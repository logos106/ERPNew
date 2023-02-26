inherited ReconciliationGUI: TReconciliationGUI
  Left = 332
  Top = 196
  HelpContext = 462000
  Caption = 'Bank Reconciliations'
  ClientHeight = 712
  ClientWidth = 1394
  OldCreateOrder = True
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 1400
  ExplicitHeight = 741
  DesignSize = (
    1394
    712)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 623
    Width = 1394
    HelpContext = 462066
    ExplicitTop = 472
    ExplicitWidth = 872
  end
  inherited shapehint: TShape
    Left = 22
    ExplicitLeft = 13
  end
  inherited imgGridWatermark: TImage
    HelpContext = 462001
  end
  inherited shapehintextra1: TShape
    Left = 94
    ExplicitLeft = 68
  end
  object pnlHeader: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 1394
    Height = 123
    HelpContext = 462002
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
      1394
      123)
    object Bevel2: TBevel
      Left = 7
      Top = 53
      Width = 852
      Height = 64
      HelpContext = 462003
    end
    object Label9: TLabel
      Left = 16
      Top = 67
      Width = 120
      Height = 15
      HelpContext = 462004
      Caption = 'Account to Reconcile'
      Transparent = True
    end
    object Label11: TLabel
      Left = 267
      Top = 65
      Width = 75
      Height = 15
      HelpContext = 462005
      Alignment = taRightJustify
      Caption = 'Statement # :'
      Transparent = True
    end
    object Label12: TLabel
      Left = 248
      Top = 90
      Width = 94
      Height = 15
      HelpContext = 462006
      Alignment = taRightJustify
      Caption = 'Statement Date :'
      Transparent = True
    end
    object Label13: TLabel
      Left = 622
      Top = 65
      Width = 102
      Height = 15
      HelpContext = 462007
      Alignment = taRightJustify
      Caption = 'Opening Balance :'
      Transparent = True
    end
    object Label14: TLabel
      Left = 631
      Top = 90
      Width = 93
      Height = 15
      HelpContext = 462008
      Alignment = taRightJustify
      Caption = 'Ending Balance :'
      Transparent = True
    end
    object Label16: TLabel
      Left = 533
      Top = 89
      Width = 74
      Height = 15
      HelpContext = 462075
      Caption = 'Filter on Date'
      Transparent = True
    end
    object lblRecStatus: TLabel
      Left = 634
      Top = 18
      Width = 80
      Height = 19
      HelpContext = 480044
      Caption = 'Converted'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object cboAccount: TwwDBLookupCombo
      Left = 14
      Top = 82
      Width = 165
      Height = 23
      HelpContext = 462009
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'25'#9'AccountName'#9'F'
        'AccountType'#9'15'#9'AccountType'#9'F')
      DataField = 'AccountID'
      DataSource = dsRecons
      LookupTable = qryAccount
      LookupField = 'AccountID'
      Options = [loColLines]
      Style = csDropDownList
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = cboAccountChange
      OnCloseUp = cboAccountCloseUp
    end
    object edtOpenBal: TwwDBEdit
      Left = 730
      Top = 61
      Width = 121
      Height = 23
      HelpContext = 462010
      TabStop = False
      DataField = 'OpenBalance'
      DataSource = dsRecons
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtCloseBal: TwwDBEdit
      Left = 729
      Top = 87
      Width = 121
      Height = 23
      HelpContext = 462011
      DataField = 'CloseBalance'
      DataSource = dsRecons
      Enabled = False
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
      OnDblClick = edtCloseBalDblClick
      OnExit = edtCloseBalExit
      OnKeyPress = edtCloseBalKeyPress
    end
    object edtStatement: TwwDBEdit
      Left = 348
      Top = 61
      Width = 158
      Height = 23
      HelpContext = 462012
      DataField = 'StatementNo'
      DataSource = dsRecons
      Enabled = False
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
      OnExit = edtStatementExit
    end
    object dtDate: TwwDBDateTimePicker
      Left = 347
      Top = 87
      Width = 160
      Height = 23
      HelpContext = 462013
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ReconciliationDate'
      DataSource = dsRecons
      Date = 37571.000000000000000000
      Epoch = 1950
      Time = 0.445266203700157300
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 2
      OnEnter = dtDateEnter
      OnExit = dtDateExit
    end
    object pnlTitle: TDNMPanel
      Left = 314
      Top = 4
      Width = 238
      Height = 40
      HelpContext = 462014
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 236
        Height = 38
        HelpContext = 462015
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
          Width = 236
          Height = 38
          HelpContext = 462016
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Reconciliation'
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
    object chkFilterDate: TwwCheckBox
      Left = 515
      Top = 89
      Width = 15
      Height = 17
      HelpContext = 462076
      DisableThemes = False
      AlwaysTransparent = False
      Frame.Transparent = True
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'Filter on Date'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object pnldebug: TDNMPanel
      Left = 1006
      Top = 4
      Width = 376
      Height = 50
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object DNMSpeedButton6: TDNMSpeedButton
        AlignWithMargins = True
        Left = 325
        Top = 4
        Width = 43
        Height = 42
        Align = alLeft
        Caption = 'W-&7'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton6Click
      end
      object DNMSpeedButton7: TDNMSpeedButton
        AlignWithMargins = True
        Left = 276
        Top = 4
        Width = 43
        Height = 42
        Align = alLeft
        Caption = 'W-&6'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton7Click
      end
      object DNMSpeedButton8: TDNMSpeedButton
        AlignWithMargins = True
        Left = 227
        Top = 4
        Width = 43
        Height = 42
        Align = alLeft
        Caption = 'W-&5'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton8Click
      end
      object DNMSpeedButton9: TDNMSpeedButton
        AlignWithMargins = True
        Left = 200
        Top = 4
        Width = 21
        Height = 42
        Align = alLeft
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 3
        AutoDisableParentOnclick = True
      end
      object DNMSpeedButton10: TDNMSpeedButton
        AlignWithMargins = True
        Left = 151
        Top = 4
        Width = 43
        Height = 42
        Align = alLeft
        Caption = 'Dep-&4'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 4
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton10Click
      end
      object DNMSpeedButton11: TDNMSpeedButton
        AlignWithMargins = True
        Left = 102
        Top = 4
        Width = 43
        Height = 42
        Align = alLeft
        Caption = 'Dep-&3'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 5
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton11Click
      end
      object DNMSpeedButton12: TDNMSpeedButton
        AlignWithMargins = True
        Left = 53
        Top = 4
        Width = 43
        Height = 42
        Align = alLeft
        Caption = 'Dep-&2'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 6
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton12Click
      end
      object DNMSpeedButton13: TDNMSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 43
        Height = 42
        Align = alLeft
        Caption = 'Dep-&1'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 7
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton13Click
      end
    end
    object GridBrush: TColorBox
      Left = 896
      Top = 88
      Width = 145
      Height = 22
      TabOrder = 8
      Visible = False
    end
    object btnStrictMatch: TDNMSpeedButton
      AlignWithMargins = True
      Left = 868
      Top = 8
      Width = 109
      Height = 42
      HelpContext = 462073
      Margins.Left = 4
      Margins.Top = 0
      Margins.Right = 4
      Margins.Bottom = 0
      Caption = 'Strict Match'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 9
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnStrictMatchClick
    end
    object btnRelaxedMatch: TDNMSpeedButton
      AlignWithMargins = True
      Left = 751
      Top = 12
      Width = 109
      Height = 21
      HelpContext = 462073
      Margins.Left = 4
      Margins.Right = 4
      Caption = 'Relaxed Match'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 10
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnRelaxedMatchClick
    end
  end
  object pnlFooter: TDNMPanel [6]
    Left = 0
    Top = 623
    Width = 1394
    Height = 89
    HelpContext = 462028
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      1394
      89)
    object Bevel4: TBevel
      Left = 5
      Top = 8
      Width = 269
      Height = 71
      HelpContext = 462029
    end
    object Bevel1: TBevel
      Left = 547
      Top = 8
      Width = 262
      Height = 71
      HelpContext = 462030
    end
    object Label1: TLabel
      Left = 8
      Top = 10
      Width = 171
      Height = 15
      HelpContext = 462031
      Caption = 'Items you have marked cleared'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblTotDeposits: TLabel
      Left = 12
      Top = 33
      Width = 7
      Height = 15
      HelpContext = 462032
      Caption = '0'
      Transparent = True
    end
    object Label2: TLabel
      Left = 40
      Top = 33
      Width = 150
      Height = 15
      HelpContext = 462033
      Caption = 'Deposits and Other Credits'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblTotWithdrawals: TLabel
      Left = 12
      Top = 50
      Width = 7
      Height = 15
      HelpContext = 462034
      Caption = '0'
      Transparent = True
    end
    object Label4: TLabel
      Left = 40
      Top = 50
      Width = 133
      Height = 15
      HelpContext = 462035
      Caption = 'Cheques and Payments'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblDepositsAmount: TLabel
      Left = 244
      Top = 33
      Width = 24
      Height = 15
      HelpContext = 462036
      Alignment = taRightJustify
      Caption = '0.00'
      Transparent = True
    end
    object lblWithdrawalsAmount: TLabel
      Left = 244
      Top = 50
      Width = 24
      Height = 15
      HelpContext = 462037
      Alignment = taRightJustify
      Caption = '0.00'
      Transparent = True
    end
    object Label6: TLabel
      Left = 562
      Top = 16
      Width = 87
      Height = 15
      HelpContext = 462038
      Caption = 'Ending Balance'
      Transparent = True
    end
    object Label7: TLabel
      Left = 556
      Top = 36
      Width = 93
      Height = 15
      HelpContext = 462039
      Caption = 'Cleared Balance'
      Transparent = True
    end
    object Label8: TLabel
      Left = 590
      Top = 56
      Width = 59
      Height = 15
      HelpContext = 462040
      Caption = 'Difference'
      Transparent = True
    end
    object lblEndBal: TLabel
      Left = 750
      Top = 16
      Width = 52
      Height = 15
      HelpContext = 462041
      Alignment = taRightJustify
      Caption = 'lblEndBal'
      Transparent = True
    end
    object lblClearedBal: TLabel
      Left = 778
      Top = 36
      Width = 24
      Height = 15
      HelpContext = 462042
      Alignment = taRightJustify
      Caption = '0.00'
      Transparent = True
    end
    object lblDiff: TLabel
      Left = 770
      Top = 56
      Width = 32
      Height = 15
      HelpContext = 462043
      Alignment = taRightJustify
      Caption = 'lblDiff'
      Transparent = True
    end
    object Label3: TLabel
      Left = 1314
      Top = 53
      Width = 54
      Height = 17
      HelpContext = 462044
      Alignment = taCenter
      Anchors = [akBottom]
      AutoSize = False
      Caption = 'Deleted'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitLeft = 812
    end
    object Label5: TLabel
      Left = 282
      Top = 4
      Width = 67
      Height = 18
      HelpContext = 462045
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Notes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object chkDeleted: TwwCheckBox
      Left = 1334
      Top = 69
      Width = 15
      Height = 17
      HelpContext = 462046
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
      ShowFocusRect = False
      NullAndBlankState = cbUnchecked
      Anchors = [akBottom]
      Caption = 'chkApplycredits'
      DataField = 'Deleted'
      DataSource = dsRecons
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnClick = chkDeletedClick
    end
    object txtComments: TDBMemo
      Left = 282
      Top = 19
      Width = 256
      Height = 58
      HelpContext = 462047
      Anchors = [akLeft, akBottom]
      DataField = 'Notes'
      DataSource = dsRecons
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
  end
  object Panel3: TDNMPanel [7]
    Left = 0
    Top = 123
    Width = 1237
    Height = 500
    HelpContext = 462048
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object AdvSplitter3: TAdvSplitter
      Left = 0
      Top = 230
      Width = 1237
      Height = 7
      Cursor = crVSplit
      HelpContext = 462049
      Align = alTop
      AutoSnap = False
      Beveled = True
      MinSize = 23
      ResizeStyle = rsLine
      OnMoved = AdvSplitter3Moved
      Appearance.BorderColor = clNone
      Appearance.BorderColorHot = clNone
      Appearance.Color = clWhite
      Appearance.ColorTo = clSilver
      Appearance.ColorHot = clWhite
      Appearance.ColorHotTo = clGray
      Appearance.Direction = gdVertical
      Appearance.DirectionType = dtAutoInvers
      GripStyle = sgDots
      OnDblClick = AdvSplitter3DblClick
      ExplicitTop = 178
      ExplicitWidth = 722
    end
    object Panel1: TDNMPanel
      Left = 0
      Top = 0
      Width = 1237
      Height = 230
      HelpContext = 462050
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
      object pnlDepositSearch: TDNMPanel
        Left = 0
        Top = 0
        Width = 1237
        Height = 23
        HelpContext = 462051
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = '    Deposits'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label10: TLabel
          Left = 494
          Top = 5
          Width = 88
          Height = 15
          HelpContext = 462052
          Alignment = taRightJustify
          Caption = 'Search Amount'
          Transparent = True
        end
        object btnDepositPrev: TDNMSpeedButton
          Left = 645
          Top = 2
          Width = 36
          Height = 21
          HelpContext = 462053
          Caption = '<'
          DisableTransparent = False
          Font.Charset = SYMBOL_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Symbol'
          Font.Style = [fsBold]
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ModalResult = 2
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 1
          Visible = False
          AutoDisableParentOnclick = True
          OnClick = btnDepositNextClick
        end
        object btnDepositNext: TDNMSpeedButton
          Left = 695
          Top = 0
          Width = 38
          Height = 23
          HelpContext = 462054
          Caption = '&Go'
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
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = btnDepositNextClick
        end
        object edtDepositSearch: TwwDBEdit
          Left = 591
          Top = 0
          Width = 104
          Height = 23
          HelpContext = 462055
          AutoFillDate = False
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
          OnChange = edtDepositSearchChange
        end
      end
      object Panel2: TDNMPanel
        Left = 11
        Top = 26
        Width = 1228
        Height = 205
        HelpContext = 462056
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = True
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Color = clBtnHighlight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object report1n2: TAdvSplitter
          Left = 996
          Top = 2
          Width = 5
          Height = 201
          HelpContext = 462067
          Align = alRight
          ResizeStyle = rsLine
          OnMoved = report1n2Moved
          Appearance.BorderColor = clNone
          Appearance.BorderColorHot = clNone
          Appearance.Color = clWhite
          Appearance.ColorTo = clSilver
          Appearance.ColorHot = clWhite
          Appearance.ColorHotTo = clGray
          GripStyle = sgDots
          ExplicitLeft = 1017
        end
        object pnlgrdDeposits: TDNMPanel
          Left = 2
          Top = 2
          Width = 994
          Height = 201
          HelpContext = 462068
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
          object grdDeposits: TAdvStringGrid
            Left = 1
            Top = 1
            Width = 992
            Height = 199
            Cursor = crDefault
            HelpContext = 462057
            Align = alClient
            BorderStyle = bsNone
            ColCount = 20
            DefaultRowHeight = 21
            DrawingStyle = gdsClassic
            Enabled = False
            FixedColor = 16776176
            FixedCols = 0
            RowCount = 2
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goRowSelect, goThumbTracking]
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            OnGetCellColor = grdDepositsGetCellColor
            OnGetAlignment = grdDepositsGetAlignment
            OnCellChanging = grdCellChanging
            OnDblClickCell = grdDblClickCell
            OnButtonClick = grdDepositsButtonClick
            OnCheckBoxClick = grdDepositsCheckBoxClick
            OnColumnSize = grdDepositsColumnSize
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = [fsBold]
            CellNode.ShowTree = False
            CellNode.TreeColor = clSilver
            ColumnHeaders.Strings = (
              'ERP Select'
              'Date'
              'Ref / Chq #'
              'Payee'
              'Notes'
              'Amount'
              'Bank Select'
              'Statement Date'
              'Statement Amount'
              'Statement Description'
              'Select All'
              'Add Rule'
              'ColAmount'
              'StmtAmount'
              'payId'
              'paylineid'
              'ClientId'
              'bslid'
              'Group #'
              'DepId')
            ControlLook.FixedGradientHoverFrom = clGray
            ControlLook.FixedGradientHoverTo = clWhite
            ControlLook.FixedGradientDownFrom = clGray
            ControlLook.FixedGradientDownTo = clSilver
            ControlLook.ControlStyle = csClassic
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
            EnableHTML = False
            EnableWheel = False
            EnhRowColMove = False
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDownClear = '(All)'
            FixedColWidth = 82
            FixedRowAlways = True
            FixedFont.Charset = ANSI_CHARSET
            FixedFont.Color = clWindowText
            FixedFont.Height = -12
            FixedFont.Name = 'Arial'
            FixedFont.Style = [fsBold]
            FloatFormat = '%.2f'
            HideFocusRect = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'MS Sans Serif'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            ScrollProportional = True
            ScrollWidth = 16
            SearchFooter.FindNextCaption = 'Find next'
            SearchFooter.FindPrevCaption = 'Find previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'MS Sans Serif'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SelectionColor = clWhite
            SelectionTextColor = clNone
            ShowSelection = False
            ShowDesignHelper = False
            SizeWithForm = True
            SortSettings.Show = True
            SortSettings.UpGlyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000FFFF00000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
              0000FFFF000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFF
              FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
              FF00FFFFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
              FF0000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
              FF000000000000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
              FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF000000000000FFFF000000000000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF0000000000FFFF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
              0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            SortSettings.DownGlyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF000000000000000000FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF0000000000FFFFFF000000
              000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF000000000000FFFF000000
              000000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000000000FFFFFF0000000000FFFFFF000000
              0000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFF
              FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF0000000000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FF
              FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
              FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
              0000FFFF000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              0000000000000000000000000000FF00FF00FF00FF00FF00FF00}
            SortSettings.NormalCellsOnly = True
            Version = '5.6.0.1'
            WordWrap = False
            ColWidths = (
              82
              75
              72
              129
              207
              87
              85
              75
              85
              163
              64
              64
              64
              64
              64
              64
              50
              64
              64
              64)
            RowHeights = (
              21
              21)
          end
        end
        object pnlgrdDepositsSum: TDNMPanel
          Left = 1001
          Top = 2
          Width = 225
          Height = 201
          HelpContext = 462069
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 1
          Transparent = False
          object grdDepositsSum: TAdvStringGrid
            Left = 1
            Top = 1
            Width = 223
            Height = 199
            Cursor = crDefault
            HelpContext = 462078
            Align = alClient
            BorderStyle = bsNone
            Color = 12320767
            ColCount = 2
            DefaultRowHeight = 21
            DrawingStyle = gdsClassic
            FixedColor = 16776176
            FixedCols = 0
            RowCount = 2
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goRowSelect, goThumbTracking]
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            OnColumnSize = grdDepositsSumColumnSize
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = [fsBold]
            CellNode.ShowTree = False
            CellNode.TreeColor = clSilver
            ColumnHeaders.Strings = (
              'Notes'
              'Total')
            ControlLook.FixedGradientHoverFrom = clGray
            ControlLook.FixedGradientHoverTo = clWhite
            ControlLook.FixedGradientDownFrom = clGray
            ControlLook.FixedGradientDownTo = clSilver
            ControlLook.ControlStyle = csClassic
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
            EnableHTML = False
            EnableWheel = False
            EnhRowColMove = False
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDownClear = '(All)'
            FixedColWidth = 140
            FixedRowAlways = True
            FixedFont.Charset = ANSI_CHARSET
            FixedFont.Color = clWindowText
            FixedFont.Height = -12
            FixedFont.Name = 'Arial'
            FixedFont.Style = [fsBold]
            FloatFormat = '%.2f'
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'MS Sans Serif'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            ScrollProportional = True
            ScrollWidth = 16
            SearchFooter.FindNextCaption = 'Find next'
            SearchFooter.FindPrevCaption = 'Find previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'MS Sans Serif'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SelectionColor = clWhite
            SelectionTextColor = clMaroon
            ShowSelection = False
            ShowDesignHelper = False
            SizeWithForm = True
            SortSettings.Show = True
            SortSettings.UpGlyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000FFFF00000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
              0000FFFF000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFF
              FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
              FF00FFFFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
              FF0000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
              FF000000000000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
              FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF000000000000FFFF000000000000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF0000000000FFFF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
              0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            SortSettings.DownGlyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF000000000000000000FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF0000000000FFFFFF000000
              000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF000000000000FFFF000000
              000000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000000000FFFFFF0000000000FFFFFF000000
              0000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFF
              FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF0000000000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FF
              FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
              FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
              0000FFFF000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              0000000000000000000000000000FF00FF00FF00FF00FF00FF00}
            SortSettings.NormalCellsOnly = True
            Version = '5.6.0.1'
            WordWrap = False
            ColWidths = (
              140
              76)
            RowHeights = (
              21
              21)
          end
        end
      end
    end
    object Panel4: TDNMPanel
      Left = 0
      Top = 237
      Width = 1237
      Height = 263
      HelpContext = 462058
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
      object pnlWithdrawalsSearch: TDNMPanel
        Left = 0
        Top = 0
        Width = 1237
        Height = 23
        HelpContext = 462059
        Align = alTop
        Alignment = taLeftJustify
        AutoSize = True
        BevelOuter = bvNone
        Caption = '    Withdrawals'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label15: TLabel
          Left = 483
          Top = 3
          Width = 88
          Height = 15
          HelpContext = 462060
          Alignment = taRightJustify
          Caption = 'Search Amount'
          Transparent = True
        end
        object btnWithdrawalsPrev: TDNMSpeedButton
          Left = 642
          Top = 0
          Width = 31
          Height = 23
          HelpContext = 462061
          Caption = '<'
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
          ModalResult = 2
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 1
          Visible = False
          AutoDisableParentOnclick = True
          OnClick = btnWithdrawalsNextClick
        end
        object btnWithdrawalsNext: TDNMSpeedButton
          Left = 683
          Top = 0
          Width = 38
          Height = 23
          HelpContext = 462062
          Caption = '&Go'
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
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = btnWithdrawalsNextClick
        end
        object edtWithdrawalSearch: TwwDBEdit
          Left = 581
          Top = 0
          Width = 102
          Height = 23
          HelpContext = 462063
          Margins.Top = 10
          Margins.Bottom = 10
          AutoFillDate = False
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
          OnChange = edtWithdrawalSearchChange
        end
      end
      object Panel5: TDNMPanel
        Left = 11
        Top = 24
        Width = 1226
        Height = 240
        HelpContext = 462064
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = True
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Color = clBtnHighlight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Splitter1: TAdvSplitter
          Left = 994
          Top = 2
          Width = 5
          Height = 236
          HelpContext = 462070
          Align = alRight
          ResizeStyle = rsLine
          OnMoved = Splitter1Moved
          Appearance.BorderColor = clNone
          Appearance.BorderColorHot = clNone
          Appearance.Color = clWhite
          Appearance.ColorTo = clSilver
          Appearance.ColorHot = clWhite
          Appearance.ColorHotTo = clGray
          GripStyle = sgDots
          ExplicitLeft = 1017
        end
        object pnlgrdWithdrawals: TDNMPanel
          Left = 2
          Top = 2
          Width = 992
          Height = 236
          HelpContext = 462071
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
          object grdWithdrawals: TAdvStringGrid
            Left = 1
            Top = 1
            Width = 990
            Height = 234
            Cursor = crDefault
            HelpContext = 462065
            Align = alClient
            BorderStyle = bsNone
            ColCount = 20
            DefaultRowHeight = 21
            DrawingStyle = gdsClassic
            Enabled = False
            FixedColor = 16776176
            FixedCols = 0
            RowCount = 2
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goRowSelect, goThumbTracking]
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            OnGetCellColor = grdWithdrawalsGetCellColor
            OnGetAlignment = grdWithdrawalsGetAlignment
            OnCellChanging = grdCellChanging
            OnDblClickCell = grdDblClickCell
            OnButtonClick = grdWithdrawalsButtonClick
            OnCheckBoxClick = grdWithdrawalsCheckBoxClick
            OnColumnSize = grdWithdrawalsColumnSize
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = [fsBold]
            CellNode.ShowTree = False
            CellNode.TreeColor = clSilver
            ColumnHeaders.Strings = (
              'ERP Select'
              'Date'
              'Ref / Chq #'
              'Payee'
              'Notes'
              'Amount'
              'Bank Select'
              'Statement Date'
              'Statement Amount'
              'Statement Description'
              'Select All'
              'Add Rule'
              'Col10'
              'Col11'
              'Col12'
              'Col13'
              'Col14'
              'Col15'
              'Group #'
              'DepId')
            ControlLook.FixedGradientHoverFrom = clGray
            ControlLook.FixedGradientHoverTo = clWhite
            ControlLook.FixedGradientDownFrom = clGray
            ControlLook.FixedGradientDownTo = clSilver
            ControlLook.ControlStyle = csClassic
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
            EnableHTML = False
            EnableWheel = False
            EnhRowColMove = False
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDownClear = '(All)'
            FixedColWidth = 82
            FixedRowAlways = True
            FixedFont.Charset = ANSI_CHARSET
            FixedFont.Color = clWindowText
            FixedFont.Height = -12
            FixedFont.Name = 'Arial'
            FixedFont.Style = [fsBold]
            FloatFormat = '%.2f'
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'MS Sans Serif'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            ScrollProportional = True
            ScrollWidth = 16
            SearchFooter.FindNextCaption = 'Find next'
            SearchFooter.FindPrevCaption = 'Find previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'MS Sans Serif'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SelectionColor = clWhite
            SelectionTextColor = clNone
            ShowSelection = False
            ShowDesignHelper = False
            SizeWithForm = True
            SortSettings.Show = True
            SortSettings.UpGlyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000FFFF00000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
              0000FFFF000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFF
              FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
              FF00FFFFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
              FF0000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
              FF000000000000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
              FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF000000000000FFFF000000000000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF0000000000FFFF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
              0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            SortSettings.DownGlyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF000000000000000000FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF0000000000FFFFFF000000
              000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF000000000000FFFF000000
              000000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000000000FFFFFF0000000000FFFFFF000000
              0000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFF
              FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF0000000000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FF
              FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
              FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
              0000FFFF000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              0000000000000000000000000000FF00FF00FF00FF00FF00FF00}
            SortSettings.NormalCellsOnly = True
            Version = '5.6.0.1'
            WordWrap = False
            ColWidths = (
              82
              75
              72
              129
              208
              87
              85
              75
              85
              163
              64
              64
              64
              64
              64
              64
              50
              64
              64
              64)
            RowHeights = (
              21
              21)
          end
        end
        object pnlgrdWithdrawalsSum: TDNMPanel
          Left = 999
          Top = 2
          Width = 225
          Height = 236
          HelpContext = 462072
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 1
          Transparent = False
          object grdWithdrawalsSum: TAdvStringGrid
            Left = 1
            Top = 1
            Width = 223
            Height = 234
            Cursor = crDefault
            HelpContext = 462079
            Align = alClient
            BorderStyle = bsNone
            Color = 12320767
            ColCount = 2
            DefaultRowHeight = 21
            DrawingStyle = gdsClassic
            FixedColor = 16776176
            FixedCols = 0
            RowCount = 2
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goEditing, goRowSelect, goThumbTracking]
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            OnColumnSize = grdWithdrawalsSumColumnSize
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = [fsBold]
            CellNode.ShowTree = False
            CellNode.TreeColor = clSilver
            ColumnHeaders.Strings = (
              'Notes'
              'Total')
            ControlLook.FixedGradientHoverFrom = clGray
            ControlLook.FixedGradientHoverTo = clWhite
            ControlLook.FixedGradientDownFrom = clGray
            ControlLook.FixedGradientDownTo = clSilver
            ControlLook.ControlStyle = csClassic
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
            EnableHTML = False
            EnableWheel = False
            EnhRowColMove = False
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDownClear = '(All)'
            FixedColWidth = 140
            FixedRowAlways = True
            FixedFont.Charset = ANSI_CHARSET
            FixedFont.Color = clWindowText
            FixedFont.Height = -12
            FixedFont.Name = 'Arial'
            FixedFont.Style = [fsBold]
            FloatFormat = '%.2f'
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'MS Sans Serif'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            ScrollProportional = True
            ScrollWidth = 16
            SearchFooter.FindNextCaption = 'Find next'
            SearchFooter.FindPrevCaption = 'Find previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'MS Sans Serif'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SelectionColor = clWhite
            SelectionTextColor = clMaroon
            ShowSelection = False
            ShowDesignHelper = False
            SizeWithForm = True
            SortSettings.Show = True
            SortSettings.UpGlyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000FFFF00000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
              0000FFFF000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFF
              FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
              FF00FFFFFF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
              FF0000000000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
              FF000000000000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFFFF0000000000FFFFFF0000000000FFFF
              FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF000000000000FFFF000000000000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000000000FFFFFF0000000000FFFF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
              0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
            SortSettings.DownGlyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF0000000000FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF000000000000000000FF00
              FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF0000000000FFFFFF0000000000FFFFFF000000
              000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF00FF00FF000000000000FFFF000000000000FFFF000000
              000000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000000000FFFFFF0000000000FFFFFF000000
              0000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFF
              FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF0000000000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FF
              FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
              FF0000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
              FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
              0000FFFF000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              00000000000000FFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
              FF00FF00FF00FF00FF0000000000000000000000000000000000000000000000
              0000000000000000000000000000FF00FF00FF00FF00FF00FF00}
            SortSettings.NormalCellsOnly = True
            Version = '5.6.0.1'
            WordWrap = False
            ColWidths = (
              140
              76)
            RowHeights = (
              21
              21)
          end
        end
      end
    end
  end
  object pnlRight: TDNMPanel [8]
    Left = 1237
    Top = 123
    Width = 157
    Height = 500
    HelpContext = 462017
    Align = alRight
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Bevel3: TBevel
      Left = 6
      Top = 0
      Width = 150
      Height = 600
      HelpContext = 462019
      Margins.Left = 0
      Margins.Right = 0
      Shape = bsFrame
    end
    object lbCreateNew: TLabel
      AlignWithMargins = True
      Left = 14
      Top = 449
      Width = 140
      Height = 15
      HelpContext = 462007
      Margins.Left = 14
      Align = alBottom
      Caption = 'Create New'
      Transparent = True
      ExplicitWidth = 66
    end
    object btnMarkAll: TDNMSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 126
      Width = 135
      Height = 27
      HelpContext = 462020
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Mar&k All'
      DisableTransparent = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
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
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnMarkAllClick
    end
    object btnUnMark: TDNMSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 157
      Width = 135
      Height = 27
      HelpContext = 462021
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      Caption = '&UnMark All'
      DisableTransparent = False
      Enabled = False
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
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF3333993333339993333377FF3333377FF3399993333339
        993337777FF3333377F3393999333333993337F777FF333337FF993399933333
        399377F3777FF333377F993339993333399377F33777FF33377F993333999333
        399377F333777FF3377F993333399933399377F3333777FF377F993333339993
        399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
        99333773FF3333777733339993333339933333773FFFFFF77333333999999999
        3333333777333777333333333999993333333333377777333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = btnUnMarkClick
    end
    object btnSaveClose: TDNMSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 2
      Width = 135
      Height = 27
      HelpContext = 462022
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Save && Close'
      DisableTransparent = False
      Enabled = False
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
      OnClick = btnSaveCloseClick
      OnEnter = btnSaveCloseEnter
    end
    object btnCancel: TDNMSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 33
      Width = 135
      Height = 27
      HelpContext = 462023
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
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
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object btnPrint: TDNMSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 64
      Width = 135
      Height = 27
      HelpContext = 462024
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Action = actPrint
      Align = alTop
      Caption = 'Print'
      DisableTransparent = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0003377777777777777308888888888888807F33333333333337088888888888
        88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
        8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
        8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 2
      AutoDisableParentOnclick = True
    end
    object btnHold: TDNMSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 188
      Width = 135
      Height = 27
      HelpContext = 462026
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Hol&d'
      DisableTransparent = False
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
        0EEE333377777777777733330FF00FBFB0EE33337F37733F377733330F0BFB0B
        FB0E33337F73FF73337733330FF000BFBFB033337F377733333733330FFF0BFB
        FBF033337FFF733F333733300000BF0FBFB03FF77777F3733F37000FBFB0F0FB
        0BF077733FF7F7FF7337E0FB00000000BF0077F377777777F377E0BFBFBFBFB0
        F0F077F3333FFFF7F737E0FBFB0000000FF077F3337777777337E0BFBFBFBFB0
        FFF077F3333FFFF73FF7E0FBFB00000F000077FF337777737777E00FBFBFB0FF
        0FF07773FFFFF7337F37003000000FFF0F037737777773337F7333330FFFFFFF
        003333337FFFFFFF773333330000000003333333777777777333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 6
      AutoDisableParentOnclick = True
      OnClick = btnHoldClick
    end
    object btnPrintReport: TDNMSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 95
      Width = 135
      Height = 27
      Hint = 'Print Not Reconciled Report'
      HelpContext = 462027
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Print Report'
      DisableTransparent = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0003377777777777777308888888888888807F33333333333337088888888888
        88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
        8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
        8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btnPrintReportClick
    end
    object btnBankTransactions: TDNMSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 219
      Width = 135
      Height = 2
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Bank Trans'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 7
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnBankTransactionsClick
    end
    object DNMPanel1: TDNMPanel
      AlignWithMargins = True
      Left = 11
      Top = 468
      Width = 135
      Height = 27
      Margins.Left = 11
      Margins.Top = 1
      Margins.Right = 11
      Margins.Bottom = 5
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object btnCheque: TDNMSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 0
        Width = 61
        Height = 27
        HelpContext = 462073
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Cheque'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = btnChequeClick
      end
      object btnDeposit: TDNMSpeedButton
        AlignWithMargins = True
        Left = 70
        Top = 0
        Width = 61
        Height = 27
        HelpContext = 462074
        Margins.Left = 4
        Margins.Top = 0
        Margins.Right = 4
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Deposit'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnDepositClick
      end
    end
    object btnhelp: TDNMSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 225
      Width = 135
      Height = 27
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Help'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 9
      AutoDisableParentOnclick = True
      OnClick = btnhelpClick
    end
    object bnCreateEntries: TDNMSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 256
      Width = 135
      Height = 27
      HelpContext = 462073
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Auto Apply'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 10
      Visible = False
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = bnCreateEntriesClick
    end
    object bnRules: TDNMSpeedButton
      AlignWithMargins = True
      Left = 11
      Top = 416
      Width = 135
      Height = 27
      HelpContext = 462073
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Rules'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 11
      Visible = False
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = bnRulesClick
    end
    object SettingsGroup: TAdvPanelGroup
      AlignWithMargins = True
      Left = 11
      Top = 320
      Width = 135
      Height = 92
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Align = alTop
      TabOrder = 12
      UseDockManager = True
      Visible = False
      Version = '2.0.2.0'
      Buffered = False
      Caption.Color = clHighlight
      Caption.ColorTo = clNone
      Caption.Font.Charset = ANSI_CHARSET
      Caption.Font.Color = clHighlightText
      Caption.Font.Height = -12
      Caption.Font.Name = 'Arial'
      Caption.Font.Style = [fsBold]
      Caption.Indent = 5
      Caption.Text = 'Settings'
      Caption.Visible = True
      StatusBar.Font.Charset = DEFAULT_CHARSET
      StatusBar.Font.Color = clWindowText
      StatusBar.Font.Height = -11
      StatusBar.Font.Name = 'Tahoma'
      StatusBar.Font.Style = []
      Columns = 1
      DefaultPanel.AnchorHint = False
      DefaultPanel.BevelInner = bvNone
      DefaultPanel.BevelOuter = bvNone
      DefaultPanel.BevelWidth = 1
      DefaultPanel.BorderColor = clBlack
      DefaultPanel.BorderShadow = False
      DefaultPanel.BorderStyle = bsSingle
      DefaultPanel.BorderWidth = 0
      DefaultPanel.CanMove = False
      DefaultPanel.CanSize = False
      DefaultPanel.Caption.Color = clHighlight
      DefaultPanel.Caption.ColorTo = clNone
      DefaultPanel.Caption.Font.Charset = DEFAULT_CHARSET
      DefaultPanel.Caption.Font.Color = clHighlightText
      DefaultPanel.Caption.Font.Height = -11
      DefaultPanel.Caption.Font.Name = 'Tahoma'
      DefaultPanel.Caption.Font.Style = []
      DefaultPanel.Collaps = False
      DefaultPanel.CollapsColor = clBtnFace
      DefaultPanel.CollapsDelay = 0
      DefaultPanel.CollapsSteps = 0
      DefaultPanel.Color = clBtnFace
      DefaultPanel.ColorTo = clNone
      DefaultPanel.ColorMirror = clNone
      DefaultPanel.ColorMirrorTo = clNone
      DefaultPanel.Cursor = crDefault
      DefaultPanel.Font.Charset = DEFAULT_CHARSET
      DefaultPanel.Font.Color = clWindowText
      DefaultPanel.Font.Height = -11
      DefaultPanel.Font.Name = 'Tahoma'
      DefaultPanel.Font.Style = []
      DefaultPanel.FixedTop = False
      DefaultPanel.FixedLeft = False
      DefaultPanel.FixedHeight = False
      DefaultPanel.FixedWidth = False
      DefaultPanel.Height = 120
      DefaultPanel.Hover = False
      DefaultPanel.HoverColor = clNone
      DefaultPanel.HoverFontColor = clNone
      DefaultPanel.Indent = 0
      DefaultPanel.ShadowColor = clBlack
      DefaultPanel.ShadowOffset = 0
      DefaultPanel.ShowHint = False
      DefaultPanel.ShowMoveCursor = False
      DefaultPanel.StatusBar.Font.Charset = DEFAULT_CHARSET
      DefaultPanel.StatusBar.Font.Color = clWindowText
      DefaultPanel.StatusBar.Font.Height = -11
      DefaultPanel.StatusBar.Font.Name = 'Tahoma'
      DefaultPanel.StatusBar.Font.Style = []
      DefaultPanel.TextVAlign = tvaTop
      DefaultPanel.TopIndent = 0
      DefaultPanel.URLColor = clBlue
      DefaultPanel.Width = 0
      GroupStyle = gsVertical
      HorzPadding = 8
      VertPadding = 8
      FullHeight = 0
      object Settings: TCheckListBox
        AlignWithMargins = True
        Left = 4
        Top = 22
        Width = 127
        Height = 66
        OnClickCheck = SettingsClickCheck
        Align = alClient
        Columns = 1
        ItemHeight = 15
        Items.Strings = (
          'Amount'
          'Customer/Supplier'
          'Ref Number'
          'Date')
        TabOrder = 1
      end
    end
    object chkChooseRpt: TCheckBox
      AlignWithMargins = True
      Left = 11
      Top = 291
      Width = 135
      Height = 17
      HelpContext = 462025
      Margins.Left = 11
      Margins.Top = 6
      Margins.Right = 11
      Margins.Bottom = 10
      Align = alTop
      Caption = 'Choose Template'
      TabOrder = 13
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 174
    Top = 6
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 73
    Top = 8
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C0101020048010C0310001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Top = 16
  end
  object dsRecons: TDataSource
    DataSet = qryRecons
    Left = 105
    Top = 40
  end
  object qryAccount: TERPQuery
    SQL.Strings = (
      
        'SELECT AccountName, AccountID, AccountType FROM tblchartofaccoun' +
        'ts'
      'WHERE (AccountType = '#39'BANK'#39' or AccountType = '#39'CCARD'#39')'
      'And (Active<>'#39'F'#39' or AccountId = :AccountID) AND IsHeader = '#39'F'#39
      'ORDER BY AccountName;')
    Left = 135
    Top = 10
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'AccountID'
      end>
  end
  object qryRecons: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblReconciliation'
      'WHERE ReconciliationID = :ID;')
    BeforeDelete = qryReconsBeforeDelete
    Left = 105
    Top = 8
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object qryReconsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryReconsReconciliationID: TAutoIncField
      FieldName = 'ReconciliationID'
      ReadOnly = True
    end
    object qryReconsReconciliationDate: TDateField
      FieldName = 'ReconciliationDate'
    end
    object qryReconsEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryReconsClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryReconsAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object qryReconsStatementNo: TWideStringField
      FieldName = 'StatementNo'
      Size = 50
    end
    object qryReconsNotes: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object qryReconsOpenBalance: TFloatField
      FieldName = 'OpenBalance'
      currency = True
    end
    object qryReconsCloseBalance: TFloatField
      FieldName = 'CloseBalance'
      currency = True
    end
    object qryReconsDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object qryReconsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryReconsFinished: TWideStringField
      FieldName = 'Finished'
      FixedChar = True
      Size = 1
    end
  end
  object ActionList1: TActionList
    Left = 167
    Top = 40
    object actPrint: TAction
      Caption = 'Print'
      HelpContext = 462077
      OnExecute = actPrintExecute
      OnUpdate = actPrintUpdate
    end
  end
  object tblReconWithdrawalLines: TERPQuery
    Connection = MyConnection
    Left = 134
    Top = 282
  end
  object tblReconDepLines: TERPQuery
    Connection = MyConnection
    Left = 230
    Top = 216
  end
  object wsClient: TsgcWebSocketClient
    Host = 'localhost'
    Port = 4556
    ConnectTimeout = 0
    ReadTimeout = -1
    TLS = True
    Proxy.Enabled = False
    Proxy.Port = 8080
    Proxy.ProxyType = pxyHTTP
    HeartBeat.Enabled = False
    HeartBeat.Interval = 300
    HeartBeat.Timeout = 0
    IPVersion = Id_IPv4
    OnMessage = wsClientMessage
    Authentication.Enabled = False
    Authentication.URL.Enabled = True
    Authentication.Session.Enabled = False
    Authentication.Basic.Enabled = True
    Authentication.Token.Enabled = False
    Authentication.Token.AuthName = 'Bearer'
    Extensions.DeflateFrame.Enabled = False
    Extensions.DeflateFrame.WindowBits = 15
    Extensions.PerMessage_Deflate.Enabled = False
    Extensions.PerMessage_Deflate.ClientMaxWindowBits = 15
    Extensions.PerMessage_Deflate.ClientNoContextTakeOver = False
    Extensions.PerMessage_Deflate.MemLevel = 9
    Extensions.PerMessage_Deflate.ServerMaxWindowBits = 15
    Extensions.PerMessage_Deflate.ServerNoContextTakeOver = False
    Options.CleanDisconnect = False
    Options.FragmentedMessages = frgOnlyBuffer
    Options.Parameters = '/'
    Options.RaiseDisconnectExceptions = True
    Options.ValidateUTF8 = False
    Specifications.Drafts.Hixie76 = False
    Specifications.RFC6455 = True
    NotifyEvents = neAsynchronous
    LogFile.Enabled = False
    QueueOptions.Binary.Level = qmNone
    QueueOptions.Ping.Level = qmNone
    QueueOptions.Text.Level = qmNone
    WatchDog.Attempts = 0
    WatchDog.Enabled = False
    WatchDog.Interval = 10
    Throttle.BitsPerSec = 0
    Throttle.Enabled = False
    LoadBalancer.Enabled = False
    LoadBalancer.Port = 0
    TLSOptions.VerifyCertificate = False
    TLSOptions.Version = tlsUndefined
    TLSOptions.IOHandler = iohOpenSSL
    Left = 424
    Top = 184
  end
end
