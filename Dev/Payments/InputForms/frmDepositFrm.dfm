inherited DepositGUI: TDepositGUI
  Left = 246
  Top = 253
  HelpContext = 98000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'To Be Deposited'
  ClientWidth = 829
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  ExplicitLeft = 246
  ExplicitTop = 253
  ExplicitWidth = 845
  DesignSize = (
    829
    532)
  PixelsPerInch = 96
  TextHeight = 15
  object Box31: TBevel [0]
    Left = 553
    Top = 403
    Width = 257
    Height = 58
    HelpContext = 98002
    Anchors = [akRight, akBottom]
  end
  object Label28: TLabel [1]
    Left = 20
    Top = 403
    Width = 45
    Height = 16
    HelpContext = 98003
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
  object Label36: TLabel [2]
    Left = 566
    Top = 436
    Width = 121
    Height = 18
    HelpContext = 98004
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Total Deposited = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label44: TLabel [3]
    Left = 562
    Top = 411
    Width = 125
    Height = 18
    HelpContext = 98005
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Total Undeposited = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblDeleted: TLabel [4]
    Left = 732
    Top = 470
    Width = 54
    Height = 17
    HelpContext = 98006
    Alignment = taCenter
    Anchors = [akBottom]
    AutoSize = False
    Caption = 'Deleted'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
    WordWrap = True
  end
  object Box68: TBevel [5]
    Left = 19
    Top = 64
    Width = 790
    Height = 54
    HelpContext = 98007
    Anchors = [akLeft, akTop, akRight]
    Style = bsRaised
  end
  object Label80: TLabel [6]
    Left = 270
    Top = 73
    Width = 85
    Height = 18
    HelpContext = 98008
    Anchors = [akTop]
    AutoSize = False
    Caption = 'Deposit Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object SaleDate_Label: TLabel [7]
    Left = 409
    Top = 73
    Width = 85
    Height = 18
    HelpContext = 98009
    Anchors = [akTop]
    AutoSize = False
    Caption = 'Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object ClassLabel: TLabel [8]
    Left = 549
    Top = 73
    Width = 85
    Height = 18
    HelpContext = 98010
    Anchors = [akTop]
    AutoSize = False
    Caption = 'Class'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblAccount: TLabel [9]
    Left = 31
    Top = 73
    Width = 48
    Height = 18
    HelpContext = 98011
    AutoSize = False
    Caption = 'Account'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblGroupCashSales: TLabel [10]
    Left = 646
    Top = 44
    Width = 147
    Height = 15
    HelpContext = 98012
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Group Cash Sale Deposits'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [11]
    Left = 685
    Top = 73
    Width = 70
    Height = 15
    HelpContext = 98013
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Deposit No.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 494
    Width = 829
    HelpContext = 98044
    ExplicitTop = 494
    ExplicitWidth = 829
  end
  object lblRefreshList: TLabel [13]
    Left = 19
    Top = 161
    Width = 792
    Height = 15
    HelpContext = 98043
    Alignment = taCenter
    AutoSize = False
    Caption = 'lblRefreshList'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  inherited imgGridWatermark: TImage
    Left = 189
    Top = 5
    HelpContext = 98001
    ExplicitLeft = 189
    ExplicitTop = 5
  end
  object txtDepositAmount: TDBEdit [18]
    Left = 266
    Top = 89
    Width = 116
    Height = 23
    HelpContext = 98020
    Anchors = [akTop]
    DataField = 'Deposit'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnExit = txtDepositAmountExit
  end
  object cboCreationDate: TwwDBDateTimePicker [19]
    Left = 405
    Top = 88
    Width = 116
    Height = 23
    HelpContext = 98021
    Anchors = [akTop]
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'DepositDate'
    DataSource = DSMaster
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 2
    UnboundDataType = wwDTEdtDate
  end
  object cboClass: TwwDBLookupCombo [20]
    Left = 545
    Top = 88
    Width = 116
    Height = 23
    HelpContext = 98022
    Anchors = [akTop]
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'ClassName'#9'30'#9'Class Name'#9'T')
    DataField = 'ClassID'
    DataSource = DSMaster
    LookupTable = cboClassQry
    LookupField = 'ClassID'
    ParentFont = False
    TabOrder = 3
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboClassCloseUp
  end
  object cboAccount: TwwDBLookupCombo [21]
    Left = 29
    Top = 88
    Width = 217
    Height = 23
    HelpContext = 98023
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AccountName'#9'20'#9'Account Name'#9'T'
      'Account Type'#9'20'#9'Account Type'#9'T'
      'Description'#9'30'#9'Description'#9'T')
    DataField = 'AccountID'
    DataSource = DSMaster
    LookupTable = cboAccountQry
    LookupField = 'AccountID'
    Options = [loColLines, loTitles]
    ParentFont = False
    TabOrder = 0
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboAccountCloseUp
  end
  object txtUnDeposited: TDNMPanel [22]
    Left = 687
    Top = 407
    Width = 122
    Height = 24
    HelpContext = 98024
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    DesignSize = (
      122
      24)
    object DBEdit1: TDBEdit
      Left = 1
      Top = 1
      Width = 120
      Height = 23
      HelpContext = 98025
      Anchors = [akTop]
      DataField = 'UnDepositTot'
      DataSource = DSMaster
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnExit = txtDepositAmountExit
    end
  end
  object txtDeposited: TDNMPanel [23]
    Left = 687
    Top = 434
    Width = 122
    Height = 24
    HelpContext = 98026
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    DesignSize = (
      122
      24)
    object DBEdit2: TDBEdit
      Left = 1
      Top = 1
      Width = 120
      Height = 23
      HelpContext = 98027
      Anchors = [akTop]
      DataField = 'DepositTot'
      DataSource = DSMaster
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnExit = txtDepositAmountExit
    end
  end
  object GroupCashSales: TwwCheckBox [24]
    Left = 799
    Top = 42
    Width = 16
    Height = 16
    HelpContext = 98028
    DisableThemes = False
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Anchors = [akTop, akRight]
    Caption = 'GroupCashSales'
    TabOrder = 5
    OnClick = GroupCashSalesClick
  end
  object TransNo: TDBEdit [25]
    Left = 685
    Top = 87
    Width = 116
    Height = 23
    HelpContext = 98029
    TabStop = False
    Anchors = [akTop, akRight]
    AutoSize = False
    DataField = 'DepositID'
    DataSource = DSMaster
    Enabled = False
    ReadOnly = True
    TabOrder = 4
  end
  object Notes: TDBMemo [26]
    Left = 20
    Top = 424
    Width = 527
    Height = 67
    HelpContext = 98032
    Anchors = [akLeft, akRight, akBottom]
    Color = clWhite
    DataField = 'Notes'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnEnter = NotesEnter
    OnExit = NotesExit
  end
  object btnReconciled: TDNMSpeedButton [27]
    Left = 546
    Top = 24
    Width = 87
    Height = 27
    HelpContext = 98033
    Anchors = [akTop, akRight]
    Caption = 'Reconciled'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      55555555FFFFFFFF5555555000000005555555577777777FF555550999999900
      55555575555555775F55509999999901055557F55555557F75F5001111111101
      105577FFFFFFFF7FF75F00000000000011057777777777775F755070FFFFFF0F
      01105777F555557F75F75500FFFFFF0FF0105577F555FF7F57575550FF700008
      8F0055575FF7777555775555000888888F005555777FFFFFFF77555550000000
      0F055555577777777F7F555550FFFFFF0F05555557F5FFF57F7F555550F000FF
      0005555557F777557775555550FFFFFF0555555557F555FF7F55555550FF7000
      05555555575FF777755555555500055555555555557775555555}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 11
    TabStop = False
    Visible = False
    AutoDisableParentOnclick = True
    OnClick = btnReconciledClick
  end
  object SaveProgress: TAdvProgress [28]
    Left = 66
    Top = 386
    Width = 744
    Height = 12
    HelpContext = 98035
    Anchors = [akLeft, akRight, akBottom]
    Smooth = True
    BarColor = clHighlight
    Step = 1
    TabOrder = 12
    Visible = False
    BkColor = clWhite
    Version = '1.2.0.0'
  end
  object pnlTitle: TDNMPanel [29]
    Left = 293
    Top = 6
    Width = 251
    Height = 45
    HelpContext = 98038
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 249
      Height = 43
      HelpContext = 98039
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
        Width = 249
        Height = 43
        HelpContext = 98040
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'To Be Deposited'
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
  object Panel2: TPanel [30]
    Left = 20
    Top = 177
    Width = 790
    Height = 204
    HelpContext = 98041
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 6
    object lblNote: TLabel
      Left = 2
      Top = 187
      Width = 786
      Height = 15
      HelpContext = 98055
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 'lblNote'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Visible = False
      ExplicitLeft = 3
      ExplicitTop = 161
      ExplicitWidth = 792
    end
    object grdLines: TwwDBGrid
      Left = 2
      Top = 2
      Width = 786
      Height = 185
      HelpContext = 98042
      ControlType.Strings = (
        'DEposited;CheckBox;T;F'
        'Deposited;CheckBox;T;F')
      Selected.Strings = (
        'Trntype'#9'10'#9'Type'#9'T'
        'PaidDate'#9'9'#9'Payment~Date'#9'T'
        'TransactionID'#9'10'#9'Transaction~Number'#9'T'
        'companyName'#9'15'#9'Client~Name'#9'T'
        'Amount'#9'10'#9'Amount'#9'T'
        'AccountName'#9'17'#9'From~Account'#9'T'
        'ClassName'#9'10'#9'Class'#9'T'
        'ChequeNo'#9'8'#9'Cheque~No'#9'T'
        'PaymentMethod'#9'12'#9'Payment~Method'#9'T'
        'Deposited'#9'1'#9'Deposited'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Align = alClient
      DataSource = dsGuiBankDeposit
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
      TitleLines = 2
      TitleButtons = True
      OnCalcCellColors = grdLinesCalcCellColors
      OnColEnter = grdLinesColEnter
      OnDblClick = grdLinesDblClick
      OnEnter = grdLinesEnter
      FooterColor = clWhite
      ExplicitTop = 5
    end
  end
  object pnlDepositfromDepartment: TDNMPanel [31]
    Left = 19
    Top = 118
    Width = 494
    Height = 41
    HelpContext = 98045
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
    OnEnter = pnlDepositfromDepartmentEnter
    object lblChoosedepartment: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 113
      Height = 33
      HelpContext = 98047
      Align = alLeft
      Alignment = taRightJustify
      Caption = 'Department for the  Deposits '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitHeight = 30
    end
    object chkallclasses: TCheckBox
      AlignWithMargins = True
      Left = 307
      Top = 4
      Width = 112
      Height = 33
      HelpContext = 98048
      Align = alRight
      Caption = 'All Departments'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chkallclassesClick
    end
    object cboDepositfromDepartment: TwwDBLookupCombo
      Left = 124
      Top = 9
      Width = 158
      Height = 23
      HelpContext = 98049
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ClassName'#9'30'#9'Class '#9'T')
      LookupTable = QryDepartmentforDeposit
      LookupField = 'ClassID'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboDepositfromDepartmentCloseUp
    end
    object btnRefreshList: TDNMSpeedButton
      AlignWithMargins = True
      Left = 425
      Top = 9
      Width = 65
      Height = 23
      HelpContext = 98037
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alRight
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
      OnClick = btnRefreshListClick
    end
  end
  object DNMPanel1: TDNMPanel [32]
    Left = 512
    Top = 118
    Width = 296
    Height = 41
    HelpContext = 98050
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 15
    DesignSize = (
      296
      41)
    object lblSearchField: TLabel
      Left = 81
      Top = 22
      Width = 44
      Height = 15
      HelpContext = 98014
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Amount'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      ExplicitLeft = 85
    end
    object lblSearch: TLabel
      Left = 65
      Top = 6
      Width = 60
      Height = 15
      HelpContext = 98052
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Search On'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      ExplicitLeft = 69
    end
    object edtDepositSearch: TwwDBEdit
      Left = 128
      Top = 10
      Width = 93
      Height = 23
      HelpContext = 98036
      Anchors = [akTop, akRight]
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
    object btnDepositNext: TDNMSpeedButton
      AlignWithMargins = True
      Left = 227
      Top = 9
      Width = 65
      Height = 23
      HelpContext = 98053
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alRight
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
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnDepositNextClick
    end
  end
  object DNMSpeedButton1: TDNMSpeedButton [33]
    Left = 556
    Top = 465
    Width = 167
    Height = 27
    HelpContext = 98054
    Anchors = [akRight, akBottom]
    Caption = 'Auto Deposit Accounts'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 16
    AutoDisableParentOnclick = True
    OnClick = DNMSpeedButton1Click
  end
  object btnAddDate: TDNMSpeedButton [34]
    Left = 487
    Top = 404
    Width = 64
    Height = 15
    HelpContext = 98051
    Caption = 'Add Date'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
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
    TabOrder = 17
    AutoDisableParentOnclick = True
    OnClick = btnAddDateClick
  end
  object chkDeleted: TwwCheckBox [35]
    Left = 795
    Top = 470
    Width = 15
    Height = 17
    HelpContext = 98018
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
    Anchors = [akBottom]
    Caption = 'chkApplycredits'
    DataField = 'Deleted'
    DataSource = DSMaster
    TabOrder = 8
    Visible = False
    OnClick = chkDeletedClick
  end
  object DNMPanel2: TDNMPanel [36]
    Left = 0
    Top = 494
    Width = 829
    Height = 38
    HelpContext = 98056
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 18
    DesignSize = (
      829
      38)
    object cmdNew: TDNMSpeedButton
      Left = 20
      Top = 5
      Width = 87
      Height = 27
      HelpContext = 98019
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = cmdNewClick
    end
    object cmdSave: TDNMSpeedButton
      Left = 137
      Top = 5
      Width = 87
      Height = 27
      HelpContext = 98016
      Anchors = [akBottom]
      Caption = '&Save'
      DisableTransparent = False
      Enabled = False
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = cmdSaveClick
    end
    object cmdPrint: TDNMSpeedButton
      Left = 254
      Top = 5
      Width = 87
      Height = 27
      HelpContext = 98015
      Anchors = [akBottom]
      Caption = 'Prin&t Receipt'
      DisableTransparent = False
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = cmdPrintClick
    end
    object btnAuto: TDNMSpeedButton
      Left = 371
      Top = 5
      Width = 87
      Height = 27
      HelpContext = 98034
      Anchors = [akBottom]
      Caption = 'Auto Deposit'
      DisableTransparent = False
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 3
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnAutoClick
    end
    object btnSelectAll: TDNMSpeedButton
      Left = 488
      Top = 5
      Width = 87
      Height = 27
      HelpContext = 98030
      Anchors = [akBottom]
      Caption = 'Select All'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnSelectAllClick
    end
    object btnDeselectAll: TDNMSpeedButton
      Left = 605
      Top = 5
      Width = 87
      Height = 27
      HelpContext = 98031
      Anchors = [akBottom]
      Caption = 'Deselect All'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = btnDeselectAllClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 723
      Top = 5
      Width = 87
      Height = 27
      HelpContext = 98017
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 6
      AutoDisableParentOnclick = True
      OnClick = cmdCancelClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 381
    Top = 240
  end
  inherited tmrdelay: TTimer
    Left = 416
    Top = 240
  end
  inherited popSpelling: TPopupMenu
    Left = 74
    Top = 240
  end
  inherited tmrdelayMsg: TTimer
    Left = 40
    Top = 240
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 210
    Top = 240
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 245
    Top = 240
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 42
    Top = 271
  end
  inherited DataState: TDataState
    Left = 279
    Top = 240
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 108
    Top = 240
  end
  inherited imgsort: TImageList
    Left = 313
    Top = 240
    Bitmap = {
      494C010102005C00B00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 378
    Top = 301
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 347
    Top = 240
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 142
    Top = 240
  end
  inherited qryMemTrans: TERPQuery
    Left = 422
    Top = 301
  end
  object cboClassQry: TERPQuery
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName '
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Left = 123
    Top = 301
  end
  object cboClassSrc: TDataSource
    AutoEdit = False
    DataSet = cboClassQry
    Left = 123
    Top = 330
  end
  object cboAccountQry: TERPQuery
    SQL.Strings = (
      'SELECT AccountID,'
      'AccDesc as '#39'Account Type'#39','
      'AccountGroup  , AccountName, '
      'Balance, Description, AccountNumber  '
      'FROM tblchartofaccounts'
      'LEFT JOIN tblacctypedesc on AccountType = AccType'
      'WHERE Active='#39'T'#39' AND AccType<>'#39'NONPOSTING'#39
      'AND IsHeader = '#39'F'#39
      'GROUP BY AccDesc,AccountName;')
    Left = 167
    Top = 301
  end
  object cboAccountSrc: TDataSource
    AutoEdit = False
    DataSet = cboAccountQry
    Left = 167
    Top = 330
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 41
    Top = 330
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 85
    Top = 330
  end
  object imgPopup: TImageList
    Left = 176
    Top = 240
    Bitmap = {
      494C0101020018006C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object tblDepositsDetails: TERPQuery
    SQL.Strings = (
      'SELECT * From'
      'tbldeposits limit 0;')
    Left = 289
    Top = 301
  end
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * '
      'FROM tblbankdeposit'
      'Where DepositID=:ID;')
    Left = 41
    Top = 301
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblbankdeposit.GlobalRef'
      Size = 255
    end
    object tblMasterDepositID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'DepositID'
      Origin = 'tblbankdeposit.DepositID'
    end
    object tblMasterDepositDate: TDateField
      FieldName = 'DepositDate'
      Origin = 'tblbankdeposit.DepositDate'
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblbankdeposit.EmployeeID'
    end
    object tblMasterClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblbankdeposit.ClassID'
    end
    object tblMasterClassName: TWideStringField
      FieldName = 'ClassName'
      Origin = 'tblbankdeposit.ClassName'
      Size = 255
    end
    object tblMasterAccountID: TIntegerField
      FieldName = 'AccountID'
      Origin = 'tblbankdeposit.AccountID'
    end
    object tblMasterNotes: TWideStringField
      FieldName = 'Notes'
      Origin = 'tblbankdeposit.Notes'
      Size = 255
    end
    object tblMasterDeposit: TFloatField
      FieldName = 'Deposit'
      Origin = 'tblbankdeposit.Deposit'
      currency = True
    end
    object tblMasterDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblbankdeposit.Deleted'
      FixedChar = True
      Size = 1
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblbankdeposit.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterReconciled: TWideStringField
      FieldName = 'Reconciled'
      Origin = 'tblbankdeposit.Reconciled'
      FixedChar = True
      Size = 1
    end
    object tblMasterDepositTot: TFloatField
      FieldName = 'DepositTot'
      Origin = 'tblbankdeposit.DepositTot'
      currency = True
    end
    object tblMasterUnDepositTot: TFloatField
      FieldName = 'UnDepositTot'
      Origin = 'tblbankdeposit.UnDepositTot'
      currency = True
    end
  end
  object tblDetails: TERPQuery
    SQL.Strings = (
      'Select * '
      'FROM tblbankdepositlines'
      'Where DepositID=:ID;')
    Left = 85
    Top = 301
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
  end
  object tblPrepayments: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblPrePayments Where PrePaymentID =:ID;')
    Left = 334
    Top = 301
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
  end
  object tblGuiBankDeposit: TERPQuery
    SQL.Strings = (
      'select * from tmp_bankdeposit_admin_324707b0'
      'ORDER by CompanyName ASC')
    Left = 211
    Top = 301
    object tblGuiBankDepositTrntype: TWideStringField
      Alignment = taCenter
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'Trntype'
      Origin = 'tmp_bankdeposit_admin_324707b0.Trntype'
      Size = 16
    end
    object tblGuiBankDepositPaidDate: TDateField
      Alignment = taCenter
      DisplayLabel = 'Payment~Date'
      DisplayWidth = 9
      FieldName = 'PaidDate'
      Origin = 'tmp_bankdeposit_admin_324707b0.PaidDate'
    end
    object tblGuiBankDepositTransactionID: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Transaction~Number'
      DisplayWidth = 10
      FieldName = 'TransactionID'
      Origin = 'tmp_bankdeposit_admin_324707b0.TransactionID'
    end
    object tblGuiBankDepositcompanyName: TWideStringField
      Alignment = taCenter
      DisplayLabel = 'Client~Name'
      DisplayWidth = 15
      FieldName = 'companyName'
      Origin = 'tmp_bankdeposit_admin_324707b0.companyName'
      Size = 255
    end
    object tblGuiBankDepositAmount: TFloatField
      Alignment = taCenter
      DisplayWidth = 10
      FieldName = 'Amount'
      Origin = 'tmp_bankdeposit_admin_324707b0.Amount'
      currency = True
    end
    object tblGuiBankDepositAccountName: TWideStringField
      Alignment = taCenter
      DisplayLabel = 'From~Account'
      DisplayWidth = 17
      FieldName = 'AccountName'
      Origin = 'tmp_bankdeposit_admin_324707b0.AccountName'
      Size = 50
    end
    object tblGuiBankDepositClassName: TWideStringField
      Alignment = taCenter
      DisplayLabel = 'Class'
      DisplayWidth = 10
      FieldName = 'ClassName'
      Origin = 'tmp_bankdeposit_admin_324707b0.ClassName'
      Size = 255
    end
    object tblGuiBankDepositChequeNo: TWideStringField
      Alignment = taCenter
      DisplayLabel = 'Cheque~No'
      DisplayWidth = 8
      FieldName = 'ChequeNo'
      Origin = 'tmp_bankdeposit_admin_324707b0.ChequeNo'
      Size = 50
    end
    object tblGuiBankDepositPaymentMethod: TWideStringField
      Alignment = taCenter
      DisplayLabel = 'Payment~Method'
      DisplayWidth = 12
      FieldName = 'PaymentMethod'
      Origin = 'tmp_bankdeposit_admin_324707b0.PaymentMethod'
      Size = 255
    end
    object tblGuiBankDepositDeposited: TWideStringField
      Alignment = taCenter
      DisplayWidth = 1
      FieldName = 'Deposited'
      Origin = 'tmp_bankdeposit_admin_324707b0.Deposited'
      OnChange = tblGuiBankDepositDepositedChange
      FixedChar = True
      Size = 1
    end
    object tblGuiBankDepositTransID: TIntegerField
      Alignment = taCenter
      DisplayWidth = 10
      FieldName = 'TransID'
      Origin = 'tmp_bankdeposit_admin_324707b0.TransID'
      Visible = False
    end
    object tblGuiBankDepositClientID: TIntegerField
      Alignment = taCenter
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'tmp_bankdeposit_admin_324707b0.ClientID'
      Visible = False
    end
    object tblGuiBankDepositPayMethodID: TIntegerField
      Alignment = taCenter
      DisplayWidth = 10
      FieldName = 'PayMethodID'
      Origin = 'tmp_bankdeposit_admin_324707b0.PayMethodID'
      Visible = False
    end
    object tblGuiBankDepositAccountID: TIntegerField
      Alignment = taCenter
      DisplayWidth = 10
      FieldName = 'AccountID'
      Origin = 'tmp_bankdeposit_admin_324707b0.AccountID'
      Visible = False
    end
    object tblGuiBankDepositTableName: TWideStringField
      Alignment = taCenter
      DisplayWidth = 16
      FieldName = 'TableName'
      Origin = 'tmp_bankdeposit_admin_324707b0.TableName'
      Visible = False
      Size = 16
    end
    object tblGuiBankDepositDepositID: TIntegerField
      Alignment = taCenter
      DisplayWidth = 10
      FieldName = 'DepositID'
      Origin = 'tmp_bankdeposit_admin_324707b0.DepositID'
      Visible = False
    end
    object tblGuiBankDepositLineID: TIntegerField
      Alignment = taCenter
      DisplayWidth = 10
      FieldName = 'LineID'
      Origin = 'tmp_bankdeposit_admin_324707b0.LineID'
      Visible = False
    end
    object tblGuiBankDepositID: TIntegerField
      Alignment = taCenter
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tmp_bankdeposit_admin_324707b0.ID'
      Visible = False
    end
  end
  object dsGuiBankDeposit: TDataSource
    DataSet = tblGuiBankDeposit
    Left = 211
    Top = 330
  end
  object QryDepartmentforDeposit: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName '
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Left = 256
    Top = 301
    object QryDepartmentforDepositClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object QryDepartmentforDepositClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 60
    end
  end
end
