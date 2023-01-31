inherited BasePrepaymentGUI: TBasePrepaymentGUI
  Left = 214
  Top = 319
  Caption = 'BasePrepaymentGUI'
  ClientHeight = 460
  ClientWidth = 799
  OldCreateOrder = True
  ExplicitLeft = 214
  ExplicitTop = 319
  ExplicitWidth = 815
  ExplicitHeight = 499
  DesignSize = (
    799
    460)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel3: TBevel [0]
    Left = 449
    Top = 357
    Width = 300
    Height = 43
    Anchors = [akRight, akBottom]
    Shape = bsFrame
    ExplicitLeft = 446
    ExplicitTop = 354
  end
  object Bevel2: TBevel [1]
    Left = 53
    Top = 356
    Width = 300
    Height = 43
    Anchors = [akLeft, akBottom]
    Shape = bsFrame
    ExplicitTop = 353
  end
  object Box30: TBevel [2]
    Left = 18
    Top = 56
    Width = 762
    Height = 166
    Anchors = [akLeft, akTop, akRight]
    ExplicitWidth = 759
  end
  object Bevel1: TBevel [3]
    Left = 20
    Top = 236
    Width = 762
    Height = 108
    Anchors = [akLeft, akTop, akRight, akBottom]
    ExplicitWidth = 759
    ExplicitHeight = 105
  end
  object lblPaymentDate: TLabel [4]
    Left = 351
    Top = 64
    Width = 86
    Height = 16
    AutoSize = False
    Caption = 'Payment Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label3: TLabel [5]
    Left = 30
    Top = 169
    Width = 105
    Height = 18
    AutoSize = False
    Caption = 'Payment Amount'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label1: TLabel [6]
    Left = 30
    Top = 64
    Width = 115
    Height = 21
    AutoSize = False
    Caption = 'Client'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label23: TLabel [7]
    Left = 676
    Top = 9
    Width = 91
    Height = 18
    Alignment = taCenter
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Receipt #'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
    ExplicitLeft = 673
  end
  object cboPayMethod_Label: TLabel [8]
    Left = 351
    Top = 111
    Width = 155
    Height = 18
    AutoSize = False
    Caption = 'Payment Method'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label29: TLabel [9]
    Left = 351
    Top = 166
    Width = 88
    Height = 18
    AutoSize = False
    Caption = 'Reference No'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object ClassLabel: TLabel [10]
    Left = 543
    Top = 111
    Width = 128
    Height = 19
    AutoSize = False
    Caption = 'Class'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label81: TLabel [11]
    Left = 543
    Top = 166
    Width = 92
    Height = 17
    AutoSize = False
    Caption = 'Bank Account'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label28: TLabel [12]
    Left = 37
    Top = 245
    Width = 45
    Height = 16
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
  object Label6: TLabel [13]
    Left = 81
    Top = 369
    Width = 79
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = 'Applied Credit'
    FocusControl = txtApplyCredit
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    ExplicitTop = 366
  end
  object lblForeignCurrencyCode: TLabel [14]
    Left = 30
    Top = 116
    Width = 88
    Height = 18
    AutoSize = False
    Caption = 'Currency Code'
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
  object lblExchangeRate: TLabel [15]
    Left = 543
    Top = 64
    Width = 96
    Height = 18
    AutoSize = False
    Caption = 'Exchange Rate'
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
  object lblForeignAmount: TLabel [16]
    Left = 131
    Top = 116
    Width = 96
    Height = 18
    AutoSize = False
    Caption = 'Foreign Amount'
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
  object Label5: TLabel [17]
    Left = 476
    Top = 371
    Width = 88
    Height = 15
    Anchors = [akRight, akBottom]
    Caption = 'Available Credit'
    FocusControl = txtAvailCredit
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    ExplicitLeft = 473
    ExplicitTop = 368
  end
  inherited lblSkingroupMsg: TLabel
    Top = 416
    Width = 799
    ExplicitTop = 457
    ExplicitWidth = 796
  end
  object cboPaymentMethod: TwwDBLookupCombo [23]
    Left = 351
    Top = 127
    Width = 160
    Height = 23
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taRightJustify
    Selected.Strings = (
      'Payment Method'#9'30'#9'Payment Method'#9'T')
    DataField = 'PayMethodID'
    DataSource = DSMaster
    LookupTable = qryPayMethod
    LookupField = 'PayMethodID'
    DropDownWidth = 150
    ParentFont = False
    TabOrder = 1
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboPaymentMethodCloseUp
    OnEnter = OnLookupcomboenter
  end
  object txtRecordID: TDBEdit [24]
    Left = 680
    Top = 24
    Width = 85
    Height = 23
    TabStop = False
    Anchors = [akTop, akRight]
    Color = clWhite
    DataField = 'PrePaymentID'
    DataSource = DSMaster
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 11
  end
  object btnPopup: TDNMSpeedButton [25]
    Left = 725
    Top = 82
    Width = 24
    Height = 22
    Anchors = [akTop, akRight]
    DisableTransparent = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555500000000
      0555555F7777777775F55500FFFFFFFFF0555577F5FFFFFFF7F550F0FEEEEEEE
      F05557F7F777777757F550F0FFFFFFFFF05557F7F5FFFFFFF7F550F0FEEEEEEE
      F05557F7F777777757F550F0FF777FFFF05557F7F5FFFFFFF7F550F0FEEEEEEE
      F05557F7F777777757F550F0FF7F777FF05557F7F5FFFFFFF7F550F0FEEEEEEE
      F05557F7F777777757F550F0FF77F7FFF05557F7F5FFFFFFF7F550F0FEEEEEEE
      F05557F7F777777757F550F0FFFFFFFFF05557F7FF5F5F5F57F550F00F0F0F0F
      005557F77F7F7F7F77555055070707070555575F7F7F7F7F7F55550507070707
      0555557575757575755555505050505055555557575757575555}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    TabOrder = 12
    AutoDisableParentOnclick = True
    OnClick = btnPopupClick
  end
  object Notes: TDBMemo [26]
    Left = 36
    Top = 259
    Width = 728
    Height = 69
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clWhite
    DataField = 'Notes'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object txtAvailCredit: TDBEdit [27]
    Left = 571
    Top = 368
    Width = 154
    Height = 24
    Anchors = [akRight, akBottom]
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    DataField = 'Balance'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 13
  end
  object txtApplyCredit: TDBEdit [28]
    Left = 163
    Top = 366
    Width = 154
    Height = 24
    Anchors = [akLeft, akBottom]
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    DataField = 'Payment'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 14
  end
  object txtAmount: TDBEdit [29]
    Left = 30
    Top = 186
    Width = 160
    Height = 23
    AutoSize = False
    BiDiMode = bdLeftToRight
    Color = clWhite
    DataField = 'PayAmount'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 3
  end
  object btnPayments: TDNMSpeedButton [30]
    Left = 193
    Top = 19
    Width = 87
    Height = 27
    Anchors = [akTop]
    Caption = 'Payments'
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 15
    TabStop = False
    Visible = False
    AutoDisableParentOnclick = True
    OnClick = btnPaymentsClick
  end
  object btnReconciled: TDNMSpeedButton [31]
    Left = 501
    Top = 18
    Width = 87
    Height = 27
    Anchors = [akTop]
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 16
    TabStop = False
    Visible = False
    AutoDisableParentOnclick = True
    OnClick = btnReconciledClick
  end
  object cboForeignCurrencyCode: TwwDBLookupCombo [32]
    Left = 30
    Top = 132
    Width = 89
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    CharCase = ecUpperCase
    DropDownAlignment = taLeftJustify
    DataField = 'ForeignExchangeCode'
    DataSource = DSMaster
    LookupTable = qryBaseForeignCurrency
    LookupField = 'Code'
    ParentFont = False
    TabOrder = 4
    Visible = False
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnChange = cboForeignCurrencyCodeChange
    OnCloseUp = cboForeignCurrencyCodeCloseUp
  end
  object edtExchangeRate: TwwDBEdit [33]
    Left = 543
    Top = 79
    Width = 89
    Height = 23
    DataField = 'ForeignExchangeRate'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    UnboundDataType = wwDefault
    Visible = False
    WantReturns = False
    WordWrap = False
  end
  object edtForeignAmount: TwwDBEdit [34]
    Left = 131
    Top = 132
    Width = 160
    Height = 23
    DataField = 'ForeignPayAmount'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    UnboundDataType = wwDefault
    Visible = False
    WantReturns = False
    WordWrap = False
  end
  object RefenceNo: TDBEdit [35]
    Left = 351
    Top = 183
    Width = 134
    Height = 23
    Color = clWhite
    DataField = 'ReferenceNo'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object pnlTitle: TDNMPanel [36]
    Left = 288
    Top = 7
    Width = 203
    Height = 41
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 17
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 199
      Height = 37
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
        Width = 199
        Height = 37
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Prepayment'
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
  object cboClient: TERPDbLookupCombo [37]
    Left = 30
    Top = 87
    Width = 263
    Height = 23
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Company'#9'30'#9'Company'#9'T'
      'Balance'#9'10'#9'Balance ($)'#9'T')
    DataField = 'CompanyName'
    DataSource = DSMaster
    LookupTable = cboClientlookup
    LookupField = 'Company'
    Options = [loTitles, loSearchOnBackspace]
    DropDownWidth = 300
    ParentFont = False
    TabOrder = 0
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboClientCloseUp
    OnEnter = OnLookupcomboenter
    LookupComboType = ctNone
    AllowFullListSearchMode = False
    DisableNotInList = False
    AllowMultipleSelectFromList = False
    OpenListinF6WhenNotinList = False
    DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
    DataIDField = 'ClientID'
    LookupIDField = 'ClientID'
  end
  object btnDeposit: TDNMSpeedButton [38]
    Left = 498
    Top = 18
    Width = 87
    Height = 27
    Caption = 'Deposit'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
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
    TabOrder = 18
    TabStop = False
    Visible = False
    AutoDisableParentOnclick = True
    OnClick = btnDepositClick
  end
  object cboCreationDate: TwwDBDateTimePicker [39]
    Left = 351
    Top = 80
    Width = 116
    Height = 23
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'PrePaymentDate'
    DataSource = DSMaster
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 5
    OnChange = cboForeignCurrencyCodeChange
  end
  object cboClass: TwwDBLookupCombo [40]
    Left = 543
    Top = 127
    Width = 131
    Height = 23
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
    TabOrder = 8
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object DNMPanel1: TDNMPanel [41]
    Left = 0
    Top = 416
    Width = 799
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 19
    ExplicitLeft = -50
    ExplicitTop = 422
    DesignSize = (
      799
      44)
    object Label11: TLabel
      AlignWithMargins = True
      Left = 742
      Top = 3
      Width = 54
      Height = 38
      Align = alRight
      Alignment = taCenter
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
      ExplicitLeft = 736
      ExplicitTop = 18
      ExplicitHeight = 16
    end
    object lblEFT: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 66
      Height = 38
      Align = alLeft
      Caption = 'Add to E.F.T.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      ExplicitHeight = 15
    end
    object cmdPrint: TDNMSpeedButton
      Left = 438
      Top = 7
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = 'Prin&t Receipt'
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
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdPrintClick
    end
    object cmdSave: TDNMSpeedButton
      Left = 112
      Top = 7
      Width = 87
      Height = 27
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
    end
    object cmdCancel: TDNMSpeedButton
      Left = 601
      Top = 7
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = cmdCancelClick
    end
    object chkDeleted: TwwCheckBox
      Left = 756
      Top = 20
      Width = 18
      Height = 17
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
      Anchors = [akRight, akBottom]
      Caption = 'chkApplycredits'
      DataField = 'Deleted'
      DataSource = DSMaster
      TabOrder = 3
      Visible = False
      OnClick = chkDeletedClick
    end
    object cmdNew: TDNMSpeedButton
      Left = 274
      Top = 7
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      Enabled = False
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = cmdNewClick
    end
    object chkEFT: TwwCheckBox
      Left = 30
      Top = 20
      Width = 18
      Height = 17
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
      Anchors = [akLeft, akBottom]
      Caption = 'chkEFT'
      TabOrder = 5
      Visible = False
    end
  end
  object cboAccount: TwwDBLookupCombo [42]
    Left = 543
    Top = 183
    Width = 217
    Height = 23
    TabStop = False
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AccountName'#9'20'#9'Account Name'#9'T'
      'Type'#9'20'#9'Type'#9'T')
    DataField = 'BankAccountID'
    DataSource = DSMaster
    LookupTable = cboAccountQry
    LookupField = 'AccountID'
    Options = [loTitles]
    ParentFont = False
    TabOrder = 9
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnEnter = OnLookupcomboenter
  end
  inherited tmrProcessMessage: TTimer
    Top = 0
  end
  inherited tmrdelay: TTimer
    Left = 448
    Top = 65528
  end
  inherited popSpelling: TPopupMenu
    Left = 88
    Top = 104
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 193
    Top = 65528
  end
  inherited DataState: TDataState
    Left = 272
    Top = 112
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 147
    Top = 144
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004000800010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 334
    Top = 0
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 166
    Top = 8
  end
  inherited qryMemTrans: TERPQuery
    Left = 101
    Top = 0
  end
  object tblMaster: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblPrePayments Where PrePaymentID =:ID;')
    Left = 139
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object tblMasterPrePaymentID: TAutoIncField
      FieldName = 'PrePaymentID'
      ReadOnly = True
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object tblMasterClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object tblMasterPrePaymentDate: TDateField
      FieldName = 'PrePaymentDate'
    end
    object tblMasterPayAmount: TFloatField
      FieldName = 'PayAmount'
      currency = True
    end
    object tblMasterPayMethodID: TIntegerField
      FieldName = 'PayMethodID'
    end
    object tblMasterNotes: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object tblMasterReferenceNo: TWideStringField
      FieldName = 'ReferenceNo'
      Size = 50
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object tblMasterMasterAccountID: TIntegerField
      FieldName = 'MasterAccountID'
    end
    object tblMasterBankAccountID: TIntegerField
      FieldName = 'BankAccountID'
    end
    object tblMasterCustomer: TWideStringField
      FieldName = 'Customer'
      FixedChar = True
      Size = 1
    end
    object tblMasterSupplier: TWideStringField
      FieldName = 'Supplier'
      FixedChar = True
      Size = 1
    end
    object tblMasterDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object tblMasterReconciled: TWideStringField
      FieldName = 'Reconciled'
      FixedChar = True
      Size = 1
    end
    object tblMasterDepositID: TIntegerField
      FieldName = 'DepositID'
    end
    object tblMasterReconciliationID: TIntegerField
      FieldName = 'ReconciliationID'
    end
    object tblMasterBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Size = 255
    end
    object tblMasterBankAccountBSB: TWideStringField
      FieldName = 'BankAccountBSB'
      Size = 7
    end
    object tblMasterBankAccountNo: TWideStringField
      FieldName = 'BankAccountNo'
      Size = 10
    end
    object tblMasterCompanyName: TWideStringField
      FieldName = 'CompanyName'
      Size = 255
    end
    object tblMasterPaid: TWideStringField
      FieldName = 'Paid'
      FixedChar = True
      Size = 1
    end
    object tblMasterBalance: TFloatField
      FieldName = 'Balance'
      currency = True
    end
    object tblMasterPayment: TFloatField
      FieldName = 'Payment'
      currency = True
    end
    object tblMasterDeposited: TWideStringField
      FieldName = 'Deposited'
      FixedChar = True
      Size = 1
    end
    object tblMasterForeignExchangeCode: TWideStringField
      FieldName = 'ForeignExchangeCode'
      FixedChar = True
      Size = 3
    end
    object tblMasterForeignExchangeRate: TFloatField
      FieldName = 'ForeignExchangeRate'
      DisplayFormat = '0.0000##'
      EditFormat = '0.0000##'
    end
    object tblMasterForeignPayAmount: TFloatField
      FieldName = 'ForeignPayAmount'
      DisplayFormat = '0.0000##'
      EditFormat = '0.0000##'
    end
    object tblMasterForeignPaid: TFloatField
      FieldName = 'ForeignPaid'
    end
    object tblMasterForeignBalance: TFloatField
      FieldName = 'ForeignBalance'
    end
    object tblMasterForeignPayment: TFloatField
      FieldName = 'ForeignPayment'
    end
    object tblMasterEnteredAt: TDateTimeField
      FieldName = 'EnteredAt'
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 68
    Top = 65535
  end
  object qryPayMethod: TERPQuery
    SQL.Strings = (
      'SELECT PayMethodID, Name as '#39'Payment Method'#39',IsCreditCard'
      'FROM tblpaymentmethods where active = "T";')
    Options.LongStrings = False
    Left = 407
    Top = 302
  end
  object cboAccountQry: TERPQuery
    SQL.Strings = (
      'SELECT tblChartofAccounts.* ,AccDesc as Type'
      'FROM tblChartofAccounts'
      'Left Join tblacctypedesc on  AccType = AccountType'
      
        'WHERE (Active = '#39'T'#39' OR AccountID=:CurrentID)  AND (IsHeader = '#39'F' +
        #39')'
      'Order By AccDesc,AccountName;')
    Options.LongStrings = False
    Left = 377
    Top = 303
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CurrentID'
      end>
  end
  object cboClassQry: TERPQuery
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName '
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Options.LongStrings = False
    Left = 314
    Top = 302
  end
  object cboClientlookup: TERPQuery
    SQL.Strings = (
      
        'SELECT ClientId,Company,Balance,PayMethodID, ForeignExchangeSell' +
        'Code'
      'FROM tblclients'
      
        'WHERE tblclients.Company Is Not Null And tblclients.Active <>'#39'F'#39 +
        ' And tblclients.Customer = '#39'T'#39
      'ORDER BY tblclients.Company;')
    Options.LongStrings = False
    Left = 239
    Top = 64
  end
  object qryBaseForeignCurrency: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT CurrencyID, Country, Currency, Code, BuyRate , Active  '
      'FROM tblcurrencyconversion'
      'Where Active = '#39'T'#39)
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 578
    Top = 303
    object qryBaseForeignCurrencyCurrencyID: TIntegerField
      FieldName = 'CurrencyID'
    end
    object qryBaseForeignCurrencyCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object qryBaseForeignCurrencyCurrency: TWideStringField
      FieldName = 'Currency'
      Size = 255
    end
    object qryBaseForeignCurrencyCode: TWideStringField
      FieldName = 'Code'
      FixedChar = True
      Size = 3
    end
    object qryBaseForeignCurrencyBuyRate: TFloatField
      FieldName = 'BuyRate'
    end
    object qryBaseForeignCurrencyActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
end
