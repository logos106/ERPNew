inherited fmCustPayments: TfmCustPayments
  Left = 327
  Top = 394
  HelpContext = 410000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Receive Customer Payments'
  ClientHeight = 565
  ClientWidth = 975
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  ExplicitLeft = 327
  ExplicitTop = 394
  ExplicitWidth = 991
  ExplicitHeight = 604
  DesignSize = (
    975
    565)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel2: TBevel [0]
    Left = 339
    Top = 60
    Width = 303
    Height = 151
    HelpContext = 410002
  end
  object Box30: TBevel [1]
    Left = 19
    Top = 60
    Width = 307
    Height = 151
    HelpContext = 410003
  end
  object Box31: TBevel [2]
    Left = 745
    Top = 455
    Width = 211
    Height = 58
    HelpContext = 410004
    Anchors = [akRight, akBottom]
  end
  object Box60: TBevel [3]
    Left = 660
    Top = 60
    Width = 295
    Height = 151
    HelpContext = 410005
    Anchors = [akTop, akRight]
  end
  object Label28: TLabel [4]
    Left = 20
    Top = 441
    Width = 45
    Height = 15
    HelpContext = 410006
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
  object Label2: TLabel [5]
    Left = 350
    Top = 66
    Width = 86
    Height = 16
    HelpContext = 410007
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
  object Label3: TLabel [6]
    Left = 36
    Top = 160
    Width = 102
    Height = 16
    HelpContext = 410008
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
  object Label1: TLabel [7]
    Left = 35
    Top = 68
    Width = 147
    Height = 16
    HelpContext = 410009
    AutoSize = False
    Caption = 'Customer / Job'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label5: TLabel [8]
    Left = 671
    Top = 68
    Width = 104
    Height = 16
    HelpContext = 410010
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Opening Balance'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label23: TLabel [9]
    Left = 902
    Top = 6
    Width = 53
    Height = 15
    HelpContext = 410011
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Receipt #'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object cboPayMethod_Label: TLabel [10]
    Left = 349
    Top = 112
    Width = 106
    Height = 16
    HelpContext = 410012
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
  object Label29: TLabel [11]
    Left = 349
    Top = 160
    Width = 88
    Height = 16
    HelpContext = 410013
    AutoSize = False
    Caption = 'Reference No.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label36: TLabel [12]
    Left = 762
    Top = 488
    Width = 69
    Height = 18
    HelpContext = 410014
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Unapplied = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label44: TLabel [13]
    Left = 772
    Top = 463
    Width = 59
    Height = 18
    HelpContext = 410015
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Applied = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object ClassLabel: TLabel [14]
    Left = 670
    Top = 112
    Width = 60
    Height = 16
    HelpContext = 410016
    Anchors = [akTop, akRight]
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
  object Label81: TLabel [15]
    Left = 670
    Top = 158
    Width = 104
    Height = 16
    HelpContext = 410017
    Anchors = [akTop, akRight]
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
  object lblDeleted: TLabel [16]
    Left = 896
    Top = 526
    Width = 54
    Height = 20
    HelpContext = 410018
    Alignment = taCenter
    Anchors = [akRight, akBottom]
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
  object lblForeignCurrency: TLabel [17]
    Left = 35
    Top = 113
    Width = 102
    Height = 16
    HelpContext = 410019
    AutoSize = False
    Caption = 'Foreign Currency'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblCurrencyAmount: TLabel [18]
    Left = 160
    Top = 113
    Width = 95
    Height = 16
    HelpContext = 410020
    AutoSize = False
    Caption = 'Foreign Amount'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Bevel3: TBevel [19]
    Left = 499
    Top = 455
    Width = 241
    Height = 58
    HelpContext = 410021
    Anchors = [akRight, akBottom]
  end
  object Label10: TLabel [20]
    Left = 507
    Top = 463
    Width = 113
    Height = 18
    HelpContext = 410022
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Foreign Applied = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label12: TLabel [21]
    Left = 507
    Top = 488
    Width = 113
    Height = 18
    HelpContext = 410023
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Foreign Unapplied = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblExchangeRate: TLabel [22]
    Left = 524
    Top = 73
    Width = 105
    Height = 16
    HelpContext = 410024
    AutoSize = False
    Caption = 'Exchange Rate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblVariationAmount: TLabel [23]
    Left = 524
    Top = 113
    Width = 105
    Height = 16
    HelpContext = 410025
    AutoSize = False
    Caption = 'Variation Amount'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblVariationAccount: TLabel [24]
    Left = 524
    Top = 161
    Width = 105
    Height = 16
    HelpContext = 410026
    AutoSize = False
    Caption = 'Variation Account'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 565
    Width = 975
    HelpContext = 410063
    ExplicitTop = 565
    ExplicitWidth = 975
  end
  object lblEmail: TLabel [26]
    Left = 39
    Top = 28
    Width = 181
    Height = 19
    HelpContext = 410027
    Caption = 'Emailing, Please Wait.... '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object Bevel1: TBevel [27]
    Left = 339
    Top = 455
    Width = 155
    Height = 58
    HelpContext = 410064
    Anchors = [akRight, akBottom]
  end
  object lblEnteredHead: TLabel [28]
    Left = 343
    Top = 464
    Width = 61
    Height = 15
    HelpContext = 410065
    Anchors = [akRight, akBottom]
    Caption = 'Entered By'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblEnteredBy: TDBText [29]
    Left = 411
    Top = 464
    Width = 77
    Height = 15
    HelpContext = 410066
    Anchors = [akRight, akBottom]
    DataField = 'EnteredBy'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object lblEnteredAt: TDBText [30]
    Left = 411
    Top = 492
    Width = 78
    Height = 15
    HelpContext = 410067
    Anchors = [akRight, akBottom]
    DataField = 'EnteredAt'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object lblEnteredAtHead: TLabel [31]
    Left = 343
    Top = 492
    Width = 59
    Height = 15
    HelpContext = 410068
    Anchors = [akRight, akBottom]
    Caption = 'Entered At'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblVariation: TLabel [32]
    Left = 156
    Top = 159
    Width = 50
    Height = 15
    HelpContext = 410069
    Caption = 'Variation'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblMinus: TLabel [33]
    Left = 145
    Top = 177
    Width = 5
    Height = 19
    HelpContext = 410070
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblEqual: TLabel [34]
    Left = 235
    Top = 177
    Width = 9
    Height = 19
    HelpContext = 410071
    Caption = '='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblApplied: TLabel [35]
    Left = 248
    Top = 159
    Width = 42
    Height = 15
    HelpContext = 410072
    Caption = 'Applied'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited imgGridWatermark: TImage
    Left = 178
    HelpContext = 410001
    ExplicitLeft = 178
  end
  object txtUnapplied: TDBEdit [40]
    Left = 833
    Top = 485
    Width = 117
    Height = 23
    HelpContext = 410031
    TabStop = False
    Anchors = [akRight, akBottom]
    Color = clWhite
    DataField = 'UnApplied'
    DataSource = DSMaster
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 12
  end
  object txtApplied: TDBEdit [41]
    Left = 833
    Top = 459
    Width = 117
    Height = 23
    HelpContext = 410032
    TabStop = False
    Anchors = [akRight, akBottom]
    Color = clWhite
    DataField = 'Applied'
    DataSource = DSMaster
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 11
  end
  object cmdPrint: TDNMSpeedButton [42]
    Left = 579
    Top = 530
    Width = 88
    Height = 27
    HelpContext = 410033
    Action = actPrintReceipt
    Anchors = [akBottom]
    Caption = '&Print Receipt'
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
    TabOrder = 30
    TabStop = False
    AutoDisableParentOnclick = True
  end
  object cmdCancel: TDNMSpeedButton [43]
    Left = 793
    Top = 530
    Width = 88
    Height = 27
    HelpContext = 410035
    Action = actCancel
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
    TabOrder = 32
    AutoDisableParentOnclick = True
  end
  object cboCreationDate: TwwDBDateTimePicker [44]
    Left = 348
    Top = 84
    Width = 116
    Height = 23
    HelpContext = 410037
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    DataField = 'PaymentDate'
    DataSource = DSMaster
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 4
    UnboundDataType = wwDTEdtDate
    OnChange = cboCreationDateChange
    OnExit = cboCreationDateExit
  end
  object cboClass: TwwDBLookupCombo [45]
    Left = 670
    Top = 129
    Width = 147
    Height = 23
    HelpContext = 410038
    Anchors = [akTop, akRight]
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
  object cboAccount: TwwDBLookupCombo [46]
    Left = 670
    Top = 176
    Width = 272
    Height = 23
    HelpContext = 410039
    TabStop = False
    Anchors = [akTop, akRight]
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
    DataField = 'AccountID'
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
  end
  object cboPaymentMethod: TwwDBLookupCombo [47]
    Left = 348
    Top = 129
    Width = 160
    Height = 23
    HelpContext = 410040
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
    TabOrder = 5
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboPaymentMethodCloseUp
  end
  object chkDeleted: TwwCheckBox [48]
    Left = 916
    Top = 542
    Width = 15
    Height = 17
    HelpContext = 410041
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
    TabOrder = 33
    Visible = False
    OnClick = chkDeletedClick
  end
  object cmdNew: TDNMSpeedButton [49]
    Left = 153
    Top = 530
    Width = 88
    Height = 27
    HelpContext = 410042
    Action = actNew
    Anchors = [akBottom]
    Caption = '&New'
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
    TabOrder = 25
    AutoDisableParentOnclick = True
  end
  object txtRecordID: TDBEdit [50]
    Left = 883
    Top = 24
    Width = 72
    Height = 23
    HelpContext = 410043
    TabStop = False
    Anchors = [akTop, akRight]
    Color = clWhite
    DataField = 'PaymentNo'
    DataSource = DSMaster
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 13
  end
  object btnPopup: TDNMSpeedButton [51]
    Left = 484
    Top = 178
    Width = 24
    Height = 22
    HelpContext = 410044
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    TabOrder = 14
    AutoDisableParentOnclick = True
    OnClick = btnPopupClick
  end
  object UseAccNo: TDNMSpeedButton [52]
    Left = 277
    Top = 85
    Width = 24
    Height = 22
    HelpContext = 410045
    DisableTransparent = False
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
    NumGlyphs = 2
    TabOrder = 15
    Visible = False
    AutoDisableParentOnclick = True
    OnClick = UseAccNoClick
  end
  object Notes: TDBMemo [53]
    Left = 17
    Top = 455
    Width = 316
    Height = 58
    HelpContext = 410046
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
    TabOrder = 10
    OnEnter = NotesEnter
    OnExit = NotesExit
  end
  object cboForeignCurrencyCode: TwwDBLookupCombo [54]
    Left = 35
    Top = 129
    Width = 102
    Height = 24
    HelpContext = 410047
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Code'#9'3'#9'Code'#9#9)
    DataField = 'ForeignExchangeCode'
    DataSource = DSMaster
    LookupTable = qryForeignCurrency
    LookupField = 'Code'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 1
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboForeignCurrencyCodeCloseUp
  end
  object ForeignAmount: TDBEdit [55]
    Left = 160
    Top = 129
    Width = 113
    Height = 23
    HelpContext = 410048
    AutoSize = False
    BiDiMode = bdLeftToRight
    Color = clWhite
    DataField = 'ForeignCurrencyAmount'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 2
    OnChange = ForeignAmountChange
  end
  object btnApply: TDNMSpeedButton [56]
    Left = 366
    Top = 530
    Width = 88
    Height = 27
    HelpContext = 410049
    Action = actapplyDiscount
    Anchors = [akBottom]
    Caption = '&Apply Discnt'
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
    TabOrder = 28
    TabStop = False
    AutoDisableParentOnclick = True
  end
  object btnDeposit: TDNMSpeedButton [57]
    Left = 723
    Top = 24
    Width = 75
    Height = 23
    HelpContext = 410050
    Anchors = [akTop, akRight]
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
    TabOrder = 17
    TabStop = False
    Visible = False
    WordWrap = True
    AutoDisableParentOnclick = True
    OnClick = btnDepositClick
  end
  object txtForeignApplied: TDBEdit [58]
    Left = 627
    Top = 459
    Width = 105
    Height = 23
    HelpContext = 410051
    TabStop = False
    Anchors = [akRight, akBottom]
    Color = clWhite
    DataField = 'ForeignApplied'
    DataSource = DSMaster
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 18
  end
  object txtForeignUnapplied: TDBEdit [59]
    Left = 627
    Top = 485
    Width = 105
    Height = 23
    HelpContext = 410052
    TabStop = False
    Anchors = [akRight, akBottom]
    Color = clWhite
    DataField = 'ForeignUnApplied'
    DataSource = DSMaster
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 19
  end
  object edtExchangeRate: TwwDBEdit [60]
    Left = 524
    Top = 88
    Width = 105
    Height = 23
    HelpContext = 410053
    DataField = 'ForeignExchangeRate'
    DataSource = DSMaster
    TabOrder = 20
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object edtVariationAmount: TwwDBEdit [61]
    Left = 524
    Top = 128
    Width = 105
    Height = 23
    HelpContext = 410054
    DataField = 'ForeignVariationAmount'
    DataSource = DSMaster
    Enabled = False
    TabOrder = 21
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object cboVariationAccount: TwwDBLookupCombo [62]
    Left = 524
    Top = 176
    Width = 105
    Height = 23
    HelpContext = 410055
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'AccountName'#9'50'#9'AccountName'#9#9)
    DataField = 'ForeignVariationAccountID'
    DataSource = DSMaster
    LookupTable = qryVariationAccount
    LookupField = 'AccountID'
    DropDownWidth = 150
    TabOrder = 22
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object btnEmail: TDNMSpeedButton [63]
    Left = 686
    Top = 530
    Width = 88
    Height = 27
    HelpContext = 410057
    Action = actEmail
    Anchors = [akBottom]
    Caption = '&Email'
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
    TabOrder = 31
    TabStop = False
    AutoDisableParentOnclick = True
  end
  object pnlTitle: TDNMPanel [64]
    Left = 343
    Top = 6
    Width = 294
    Height = 45
    HelpContext = 410058
    Anchors = [akTop]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 23
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 290
      Height = 41
      HelpContext = 410059
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
        Width = 290
        Height = 41
        HelpContext = 410060
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Customer Payment'
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
  object Panel2: TPanel [65]
    Left = 19
    Top = 220
    Width = 936
    Height = 218
    HelpContext = 410061
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Caption = 'Panel1'
    TabOrder = 24
    object lblMsg: TLabel
      Left = 2
      Top = 201
      Width = 932
      Height = 15
      HelpContext = 410086
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      WordWrap = True
      ExplicitLeft = 28
      ExplicitTop = 203
      ExplicitWidth = 741
    end
    object grdPayments: TwwDBGrid
      Left = 2
      Top = 2
      Width = 932
      Height = 199
      HelpContext = 410062
      ControlType.Strings = (
        'Apply;CheckBox;T;F'
        'IsEarlyPaymentDiscount;CheckBox;T;F')
      Selected.Strings = (
        'Type'#9'10'#9'Type'#9'T'#9
        'SaleDate'#9'10'#9'Invoice Date'#9'T'#9
        'InvoiceDocNumber'#9'10'#9'Trans No'#9'T'#9
        'OriginalAmount'#9'10'#9'Amount'#9'T'#9
        'ForeignOriginalAmt'#9'1'#9'Original~Foreign amt'#9'T'#9
        'Balance'#9'1'#9'Amount~Due'#9'T'#9
        'ForeignBalanceAmount'#9'1'#9'Foreign~amount due'#9'T'#9
        'Payment'#9'1'#9'Payment'#9#9
        'ForeignPayment'#9'1'#9'ForeignPayment'#9#9
        'Apply'#9'1'#9'Apply'#9#9
        'AmountOutstanding'#9'1'#9'Amount~Outstanding'#9'T'#9
        'ForeignAmountOutstanding'#9'1'#9'Foreign~Outstanding'#9'T'#9
        'Discount'#9'10'#9'Discount'#9'F'#9
        'Withholding'#9'1'#9'Withholding'#9#9
        'Refunding'#9'1'#9'Refunding'#9#9
        'RefundPercent'#9'1'#9'Refund~Percent'#9'F'#9
        'ForeignExchangeRate'#9'1'#9'Foreign~Exchange Rate'#9'T'#9
        'IsEarlyPaymentDiscount'#9'1'#9'Early~Payment'#9'F'
        'RefNo'#9'10'#9'Ref No'#9'T'#9
        'EnteredBy'#9'20'#9'EnteredBy'#9'F'#9
        'ConNote'#9'50'#9'Con. Note'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = 16776176
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Align = alClient
      DataSource = dsGuiDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taCenter
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = True
      OnCalcCellColors = grdPaymentsCalcCellColors
      OnTitleButtonClick = grdPaymentsTitleButtonClick
      OnDblClick = grdPaymentsDblClick
      OnEnter = grdPaymentsEnter
      FooterColor = 16776176
      ExplicitLeft = 16
      ExplicitTop = -3
    end
  end
  object cmdsave: TDNMSpeedButton [66]
    Left = 47
    Top = 530
    Width = 88
    Height = 27
    HelpContext = 410073
    Action = actSave
    Anchors = [akBottom]
    Caption = '&Save'
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
    TabOrder = 26
    TabStop = False
    AutoDisableParentOnclick = True
  end
  object txtVariationAmount2: TwwDBEdit [67]
    Left = 156
    Top = 175
    Width = 73
    Height = 23
    HelpContext = 410074
    TabStop = False
    DataField = 'ForeignVariationAmount'
    DataSource = DSMaster
    Enabled = False
    ReadOnly = True
    TabOrder = 35
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object txtApplied2: TwwDBEdit [68]
    Left = 248
    Top = 175
    Width = 73
    Height = 23
    HelpContext = 410075
    TabStop = False
    DataField = 'Applied'
    DataSource = DSMaster
    Enabled = False
    ReadOnly = True
    TabOrder = 34
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object btnSelectall: TDNMSpeedButton [69]
    Left = 260
    Top = 530
    Width = 87
    Height = 27
    HelpContext = 410076
    Anchors = [akBottom]
    Caption = 'Select All'
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
    TabOrder = 27
    TabStop = False
    AutoDisableParentOnclick = True
    OnClick = btnSelectallClick
  end
  object txtAmount: TDBEdit [70]
    Left = 35
    Top = 176
    Width = 102
    Height = 23
    HelpContext = 410028
    AutoSize = False
    BiDiMode = bdLeftToRight
    Color = clWhite
    DataField = 'Amount'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 3
    OnChange = txtAmountChange
  end
  object btnReconciled: TDNMSpeedButton [71]
    Left = 643
    Top = 24
    Width = 75
    Height = 23
    HelpContext = 410056
    Anchors = [akTop]
    Caption = 'Reconciled'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ModalResult = 1
    ParentFont = False
    TabOrder = 16
    TabStop = False
    Visible = False
    WordWrap = True
    AutoDisableParentOnclick = True
    OnClick = btnReconciledClick
  end
  object txtBalance: TDBEdit [72]
    Left = 670
    Top = 84
    Width = 116
    Height = 23
    HelpContext = 410029
    TabStop = False
    Anchors = [akTop, akRight]
    Color = clWhite
    DataField = 'Balance'
    DataSource = DSMaster
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
  end
  object btnAddSurcharge: TDNMSpeedButton [73]
    Left = 473
    Top = 530
    Width = 88
    Height = 27
    HelpContext = 410077
    Action = actAddSurcharge
    Anchors = [akBottom]
    Caption = 'Surcharge'
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
    TabOrder = 29
    TabStop = False
    AutoDisableParentOnclick = True
  end
  object btnAddDate: TDNMSpeedButton [74]
    Left = 268
    Top = 439
    Width = 64
    Height = 15
    HelpContext = 410078
    Anchors = [akRight, akBottom]
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
    TabOrder = 36
    AutoDisableParentOnclick = True
    OnClick = btnAddDateClick
  end
  object cboclientR: TERPDbLookupCombo [75]
    Left = 35
    Top = 84
    Width = 238
    Height = 23
    HelpContext = 410087
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'Company'#9'45'#9'Company'#9'F'
      'Balance'#9'10'#9'Balance ($)'#9'F')
    DataField = 'CompanyName'
    DataSource = DSMaster
    LookupTable = cboClientlookup
    LookupField = 'Company'
    ParentFont = False
    TabOrder = 0
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    OnCloseUp = cboClientRCloseUp
    LookupFormClassName = 'TCustomerExpressListGUI'
    EditFormClassName = 'TfrmCustomer'
    LookupFormKeyStringFieldName = 'Company'
    LookupComboType = ctCustomer
    AllowFullListSearchMode = False
    DisableNotInList = False
    AllowMultipleSelectFromList = False
    OpenListinF6WhenNotinList = False
    DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
    DataIDField = 'CusID'
    LookupIDField = 'ClientID'
    LookupFieldAlt = 'PrintName'
  end
  object RefenceNo: TDBEdit [76]
    Left = 348
    Top = 176
    Width = 134
    Height = 23
    HelpContext = 410030
    Color = clWhite
    DataField = 'ReferenceNo'
    DataSource = DSMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnEnter = RefenceNoEnter
    OnExit = RefenceNoExit
  end
  object btnCardPayment: TDNMSpeedButton [77]
    Left = 804
    Top = 24
    Width = 75
    Height = 23
    HelpContext = 410088
    Anchors = [akBottom]
    Caption = 'Card Pay'
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
    TabOrder = 37
    TabStop = False
    Visible = False
    WordWrap = True
    AutoDisableParentOnclick = True
    OnClick = btnCardPaymentClick
  end
  object lblDisableCalc: TDNMSpeedButton [78]
    Left = 864
    Top = 439
    Width = 86
    Height = 15
    Hint = 'Select To Recalculate Total'
    Anchors = [akRight, akBottom]
    Caption = 'Calc Disabled'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
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
    TabOrder = 38
    TabStop = False
    AutoDisableParentOnclick = True
    OnClick = lblDisableCalcClick
  end
  inherited tmrProcessMessage: TTimer
    Left = 260
    Top = 8
  end
  inherited tmrdelay: TTimer
    Left = 304
    Top = 8
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 6
    Top = 3
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 69
    Top = 4
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 265
    Top = 271
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102009000B80110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 154
    Top = 272
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 334
    Top = 24
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 31
    Top = 371
  end
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tbldeposits Where PaymentID =:ID;')
    Left = 32
    Top = 335
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object tblMasterPaymentID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'PaymentID'
      ReadOnly = True
    end
    object tblMasterPaymentNo: TIntegerField
      FieldName = 'PaymentNo'
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object tblMasterCusID: TIntegerField
      FieldName = 'CusID'
    end
    object tblMasterPaymentDate: TDateField
      FieldName = 'PaymentDate'
    end
    object tblMasterAmount: TFloatField
      FieldName = 'Amount'
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
    object tblMasterCardholdersName: TWideStringField
      FieldName = 'CardholdersName'
      Size = 50
    end
    object tblMasterCreditCardNumber: TWideStringField
      FieldName = 'CreditCardNumber'
      Size = 50
    end
    object tblMasterCreditCardExpDate: TDateField
      FieldName = 'CreditCardExpDate'
    end
    object tblMasterPrintFlag: TWideStringField
      FieldName = 'PrintFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterPrintedBy: TIntegerField
      FieldName = 'PrintedBy'
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object tblMasterAccountID: TIntegerField
      FieldName = 'AccountID'
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
    object tblMasterEmployee: TWideStringField
      FieldName = 'Employee'
      FixedChar = True
      Size = 1
    end
    object tblMasterContact: TWideStringField
      FieldName = 'Contact'
      FixedChar = True
      Size = 1
    end
    object tblMasterDeposit: TWideStringField
      FieldName = 'Deposit'
      FixedChar = True
      Size = 1
    end
    object tblMasterCustomerPayment: TWideStringField
      FieldName = 'CustomerPayment'
      FixedChar = True
      Size = 1
    end
    object tblMasterCompanyName: TWideStringField
      FieldName = 'CompanyName'
      Size = 100
    end
    object tblMasterAppliedCredits: TWideStringField
      FieldName = 'AppliedCredits'
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
    object tblMasterDeposited: TWideStringField
      FieldName = 'Deposited'
      FixedChar = True
      Size = 1
    end
    object tblMasterBalance: TFloatField
      FieldName = 'Balance'
      currency = True
    end
    object tblMasterDepositedBalance: TFloatField
      FieldName = 'DepositedBalance'
    end
    object tblMasterCredit: TFloatField
      FieldName = 'Credit'
    end
    object tblMasterUnApplied: TFloatField
      FieldName = 'UnApplied'
      currency = True
    end
    object tblMasterApplied: TFloatField
      FieldName = 'Applied'
      currency = True
    end
    object tblMasterDepositID: TIntegerField
      FieldName = 'DepositID'
    end
    object tblMasterReconciliationID: TIntegerField
      FieldName = 'ReconciliationID'
    end
    object tblMasterFinished: TWideStringField
      FieldName = 'Finished'
      FixedChar = True
      Size = 1
    end
    object tblMasterStatement: TIntegerField
      FieldName = 'Statement'
    end
    object tblMasterMSReceived: TWideStringField
      FieldName = 'MSReceived'
      FixedChar = True
      Size = 1
    end
    object tblMasterForeignExchangeRate: TFloatField
      FieldName = 'ForeignExchangeRate'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblMasterForeignExchangeCode: TWideStringField
      FieldName = 'ForeignExchangeCode'
      FixedChar = True
      Size = 3
    end
    object tblMasterForeignCurrencyAmount: TFloatField
      FieldName = 'ForeignCurrencyAmount'
      DisplayFormat = '###,###,###,##0.00'
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
    object tblMasterForeignVariationAccountID: TIntegerField
      FieldName = 'ForeignVariationAccountID'
    end
    object tblMasterForeignVariationAmount: TFloatField
      FieldName = 'ForeignVariationAmount'
      currency = True
    end
    object tblMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object tblMasterForeignUnApplied: TFloatField
      FieldName = 'ForeignUnApplied'
    end
    object tblMasterForeignApplied: TFloatField
      FieldName = 'ForeignApplied'
    end
    object tblMasterEnteredBy: TWideStringField
      FieldKind = fkLookup
      FieldName = 'EnteredBy'
      LookupDataSet = qryEmployeeLookup
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'EmployeeName'
      KeyFields = 'EmployeeID'
      Size = 255
      Lookup = True
    end
    object tblMasterEnteredAt: TDateTimeField
      FieldName = 'EnteredAt'
    end
    object tblMasterSplitPaymentID: TIntegerField
      FieldName = 'SplitPaymentID'
    end
    object tblMasterSplitPaymentLineID: TIntegerField
      FieldName = 'SplitPaymentLineID'
    end
    object tblMasterClientPrintName: TWideStringField
      FieldName = 'ClientPrintName'
      Size = 255
    end
    object tblMastermsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object tblDetails: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tbldepositline Where PaymentID =:ID;'
      '')
    Left = 62
    Top = 334
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
  end
  object tblSalesDetails: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblsales Where SaleID =:ID;')
    Left = 93
    Top = 334
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblSalesDetailsSaleID: TAutoIncField
      FieldName = 'SaleID'
      ReadOnly = True
    end
    object tblSalesDetailsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object tblSalesDetailsInvoiceDocNumber: TWideStringField
      FieldName = 'InvoiceDocNumber'
      Size = 30
    end
    object tblSalesDetailsOriginalNo: TWideStringField
      FieldName = 'OriginalNo'
      Size = 255
    end
    object tblSalesDetailsAccount: TWideStringField
      FieldName = 'Account'
      Size = 255
    end
    object tblSalesDetailsAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object tblSalesDetailsBOID: TWideStringField
      FieldName = 'BOID'
      Size = 255
    end
    object tblSalesDetailsCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Size = 255
    end
    object tblSalesDetailsClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object tblSalesDetailsInvoiceTo: TWideStringField
      FieldName = 'InvoiceTo'
      Size = 255
    end
    object tblSalesDetailsShipTo: TWideStringField
      FieldName = 'ShipTo'
      Size = 255
    end
    object tblSalesDetailsSaleDate: TDateField
      FieldName = 'SaleDate'
    end
    object tblSalesDetailsTotalTax: TFloatField
      FieldName = 'TotalTax'
    end
    object tblSalesDetailsTotalAmount: TFloatField
      FieldName = 'TotalAmount'
    end
    object tblSalesDetailsTotalAmountInc: TFloatField
      FieldName = 'TotalAmountInc'
    end
    object tblSalesDetailsTotalMarkup: TFloatField
      FieldName = 'TotalMarkup'
    end
    object tblSalesDetailsTotalDiscount: TFloatField
      FieldName = 'TotalDiscount'
    end
    object tblSalesDetailsEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
    object tblSalesDetailsEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object tblSalesDetailsClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object tblSalesDetailsClass: TWideStringField
      FieldName = 'Class'
      Size = 255
    end
    object tblSalesDetailsOrderNumber: TWideStringField
      FieldName = 'OrderNumber'
      Size = 30
    end
    object tblSalesDetailsPONumber: TWideStringField
      FieldName = 'PONumber'
      Size = 30
    end
    object tblSalesDetailsChequeNo: TWideStringField
      FieldName = 'ChequeNo'
      Size = 45
    end
    object tblSalesDetailsShipDate: TDateField
      FieldName = 'ShipDate'
    end
    object tblSalesDetailsDueDate: TDateField
      FieldName = 'DueDate'
    end
    object tblSalesDetailsConNote: TWideStringField
      FieldName = 'ConNote'
      Size = 25
    end
    object tblSalesDetailsMemo: TWideMemoField
      FieldName = 'Memo'
      BlobType = ftWideMemo
    end
    object tblSalesDetailsComments: TWideMemoField
      FieldName = 'Comments'
      BlobType = ftWideMemo
    end
    object tblSalesDetailsInvoicePrintDesc: TWideStringField
      FieldName = 'InvoicePrintDesc'
      Size = 255
    end
    object tblSalesDetailsPickMemo: TWideMemoField
      FieldName = 'PickMemo'
      BlobType = ftWideMemo
      Size = 255
    end
    object tblSalesDetailsPrintHold: TWideStringField
      FieldName = 'PrintHold'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsShipping: TWideStringField
      FieldName = 'Shipping'
      Size = 255
    end
    object tblSalesDetailsTerms: TWideStringField
      FieldName = 'Terms'
      Size = 255
    end
    object tblSalesDetailsPayMethod: TWideStringField
      FieldName = 'PayMethod'
      Size = 50
    end
    object tblSalesDetailsPayDueDate: TWideStringField
      FieldName = 'PayDueDate'
      Size = 11
    end
    object tblSalesDetailsPaid: TWideStringField
      FieldName = 'Paid'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsBalance: TFloatField
      FieldName = 'Balance'
    end
    object tblSalesDetailsSOBalance: TFloatField
      FieldName = 'SOBalance'
    end
    object tblSalesDetailsPayment: TFloatField
      FieldName = 'Payment'
    end
    object tblSalesDetailsApplyFlag: TWideStringField
      FieldName = 'ApplyFlag'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsAmountDue: TFloatField
      FieldName = 'AmountDue'
    end
    object tblSalesDetailsTimeOfSale: TWideStringField
      FieldName = 'TimeOfSale'
      Size = 11
    end
    object tblSalesDetailsIsPOS: TWideStringField
      FieldName = 'IsPOS'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsPOS: TWideStringField
      FieldName = 'POS'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsIsRefund: TWideStringField
      FieldName = 'IsRefund'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsIsCashSale: TWideStringField
      FieldName = 'IsCashSale'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsIsInvoice: TWideStringField
      FieldName = 'IsInvoice'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsIsQuote: TWideStringField
      FieldName = 'IsQuote'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsIsSalesOrder: TWideStringField
      FieldName = 'IsSalesOrder'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsIsVoucher: TWideStringField
      FieldName = 'IsVoucher'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsIsLayby: TWideStringField
      FieldName = 'IsLayby'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsIsLaybyTOS: TWideStringField
      FieldName = 'IsLaybyTOS'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsIsLaybyPayment: TWideStringField
      FieldName = 'IsLaybyPayment'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsTotalQuoteAmount: TFloatField
      FieldName = 'TotalQuoteAmount'
    end
    object tblSalesDetailsLaybyID: TWideStringField
      FieldName = 'LaybyID'
      Size = 14
    end
    object tblSalesDetailsDeposited: TWideStringField
      FieldName = 'Deposited'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsTillID: TSmallintField
      FieldName = 'TillID'
    end
    object tblSalesDetailsHoldSale: TWideStringField
      FieldName = 'HoldSale'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsFreezeQuoteAmount: TWideStringField
      FieldName = 'FreezeQuoteAmount'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsConverted: TWideStringField
      FieldName = 'Converted'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsEnteredBy: TWideStringField
      FieldName = 'EnteredBy'
      Size = 255
    end
    object tblSalesDetailsEnteredAt: TWideStringField
      FieldName = 'EnteredAt'
      Size = 255
    end
    object tblSalesDetailsCommissionPaid: TWideStringField
      FieldName = 'CommissionPaid'
      FixedChar = True
      Size = 1
    end
    object tblSalesDetailsForeignPaidAmount: TFloatField
      FieldName = 'ForeignPaidAmount'
    end
    object tblSalesDetailsForeignBalanceAmount: TFloatField
      FieldName = 'ForeignBalanceAmount'
    end
  end
  object tblPrepayments: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblPrePayments Where PrePaymentID =:ID;')
    Left = 124
    Top = 335
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
  end
  object qryPayMethod: TERPQuery
    SQL.Strings = (
      'SELECT PayMethodID, Name as '#39'Payment Method'#39',IsCreditCard'
      'FROM tblpaymentmethods where Active ="T" '
      'Order By Name'
      '#'#39'Payment Method'#39)
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 282
    Top = 338
  end
  object cboAccountQry: TERPQuery
    SQL.Strings = (
      'SELECT tblChartofAccounts.* ,AccDesc as Type'
      'FROM tblChartofAccounts'
      'Left Join tblacctypedesc on  AccType = AccountType'
      'WHERE (Active = '#39'T'#39' OR AccountID=:CurrentID) AND IsHeader = '#39'F'#39
      'Order By AccDesc,AccountName;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 251
    Top = 337
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
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 219
    Top = 337
  end
  object cboClientlookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT  CT.DefaultPostAccount    AS DefaultPostAccount,  CT.Defa' +
        'ultPostAccountID  AS DefaultPostAccountID,  C1.ClientID         ' +
        '     as ClientID,  C1.Company               as Company,  C1.Prin' +
        'tName             as PrintName,  C1.JobNumber             as Job' +
        'Number,  C1.isjob                 as isjob,   C1.JobName        ' +
        '       as JobName,   C1.ParentClientID        as ParentClientID,' +
        '   C1.ForcePOOnCustomer     as ForcePOOnCustomer,  C1.StopCredit' +
        '            as StopCredit,  C1.Mobile                as Mobile, ' +
        ' C1.Title                 as Title,  C1.Lastname              as' +
        ' Lastname,  C1.FirstName             as FirstName,  C1.FaxNumber' +
        '             as FaxNumber,   C1.Supplier              as Supplie' +
        'r,   C1.Customer              as Customer,   C1.OtherContact    ' +
        '      as OtherContact,   C1.Street                as Street,  C1' +
        '.Street2               as Street2,  C1.Street3               as ' +
        'Street3,  C1.Suburb                as Suburb,  C1.State         ' +
        '        as State,  C1.Country               as Country,  C1.Post' +
        'code              as Postcode,  C1.BillStreet            as Bill' +
        'Street,  C1.BillStreet2           as BillStreet2,  C1.BillStreet' +
        '3           as BillStreet3,  C1.BillSuburb            as BillSub' +
        'urb,  C1.BillState             as BillState,  C1.BillPostcode   ' +
        '       as BillPostcode,  C1.BillCountry           as BillCountry' +
        ',  C1.TERMS                 as TERMS,  C1.TermsID               ' +
        'as TermsID,  C1.ShippingMethod        as ShippingMethod,  C1.Shi' +
        'ppingID            as ShippingID,  C1.RepID                 as R' +
        'epID,  C1.TaxID                 as TaxID,  C1.Phone             ' +
        '    as Phone,  C1.FaxNumber             as Fax,  C1.AltPhone    ' +
        '          as AltPhone,  IF(C1.IsJob = "T",C2.StopCredit,C1.StopC' +
        'redit) AS StopCredits,  C1.ForcePOOnInvoice      as ForcePOOnInv' +
        'oice,  C1.UseInvBase            as UseInvBase,  C1.InvBaseNumber' +
        '         as InvBaseNumber,  C1.WarrantyFinishDate    as Warranty' +
        'FinishDate,   C1.IsJob                 as IsJob,   C1.APBalance ' +
        '            as Balance,   C1.PayMethodID           as PayMethodI' +
        'D,   C1.ClientNo              as ClientNo,   C1.ForeignExchangeS' +
        'ellCode as ForeignExchangeSellCode,   IF((SELECT Count(*) FROM t' +
        'blPurchaseOrders WHERE tblPurchaseOrders.Approved = "F" AND tblP' +
        'urchaseOrders.ClientID = C1.ClientId) > 0,"F","T")  as All_Appro' +
        'ved , '
      '  C1.BankAccountName'
      '  FROM tblclients as C1'
      
        '  LEFT JOIN tblClientType AS CT on C1.ClientTypeID = CT.ClientTy' +
        'peID'
      '  LEFT JOIN tblClients as C2 on C1.ParentClientID = C2.ClientID'
      
        '  WHERE (0 <> 0 and C1.clientId =  0 ) or  (char_length(C1.Compa' +
        'ny)>0)  AND (C1.Customer ="T" OR C1.IsJob ="T")  AND C1.Active =' +
        ' "T"'
      '   AND ('
      '(    ((0 = 0) or (IsNull(0))) '
      
        ' or ((0 = 1) and ( ( C1.Company  LIKE Concat('#39'%'#39',"%"))  OR  ( C1' +
        '.Printname   LIKE Concat('#39'%'#39',"%"))   )) '
      
        ' or ((0 = 2) and ( ( C1.Company  LIKE Concat("%",'#39'%'#39',"%"))  OR  ' +
        '( C1.Printname   LIKE Concat("%",'#39'%'#39',"%"))   )) '
      ') AND ifnull('#39'%'#39' , "") <> "")   Order by Company ASC')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = cboClientlookupBeforeOpen
    AfterOpen = cboClientlookupAfterOpen
    Options.LongStrings = False
    Left = 211
    Top = 272
    object cboClientlookupCompany: TWideStringField
      DisplayWidth = 30
      FieldName = 'Company'
      Origin = '.Company'
      Size = 80
    end
    object cboClientlookupBalance: TFloatField
      DisplayLabel = 'Balance ($)'
      DisplayWidth = 10
      FieldName = 'Balance'
      Origin = '.Balance'
    end
    object cboClientlookupClientNo: TWideStringField
      DisplayWidth = 10
      FieldName = 'ClientNo'
      Origin = 'tblclients.ClientNo'
      Visible = False
      Size = 50
    end
    object cboClientlookupClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = '.ClientID'
      Visible = False
    end
    object cboClientlookupPayMethodID: TIntegerField
      FieldName = 'PayMethodID'
      Origin = 'tblclients.PayMethodID'
      Visible = False
    end
    object cboClientlookupBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Origin = 'tblclients.BankAccountName'
      Visible = False
      Size = 255
    end
    object cboClientlookupBankAccountBSB: TWideStringField
      FieldName = 'BankAccountBSB'
      Origin = 'tblclients.BankAccountBSB'
      Visible = False
      Size = 7
    end
    object cboClientlookupBankAccountNo: TWideStringField
      FieldName = 'BankAccountNo'
      Origin = 'tblclients.BankAccountNo'
      Visible = False
      Size = 10
    end
    object cboClientlookupForeignExchangeSellCode: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      Origin = 'tblclients.ForeignExchangeSellCode'
      Visible = False
      FixedChar = True
      Size = 3
    end
  end
  object qryForeignCurrency: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT CurrencyID, Country, Currency, Code, BuyRate , Active  '
      'FROM tblcurrencyconversion'
      'Where BuyRate <>0;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 155
    Top = 336
  end
  object qryVariationAccount: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblChartofAccounts.*'
      'FROM tblChartofAccounts'
      
        'WHERE (AccountType = '#39'EXP'#39' or AccountType = '#39'EXEXP'#39') AND Active ' +
        '= '#39'T'#39
      'AND IsHeader = '#39'F'#39
      'Order By AccountName;')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Options.LongStrings = False
    Left = 313
    Top = 338
  end
  object ActionList: TActionList
    Left = 216
    Top = 16
    object actSave: TDNMAction
      Category = 'FormActions'
      Caption = '&Save'
      HelpContext = 410079
      OnExecute = actSaveExecute
      OnUpdate = actSaveUpdate
      buttoncolor = clWhite
    end
    object actapplyDiscount: TDNMAction
      Category = 'FormActions'
      Caption = '&Apply Discnt'
      HelpContext = 410080
      OnExecute = actapplyDiscountExecute
      OnUpdate = actapplyDiscountUpdate
      buttoncolor = clWhite
    end
    object actNew: TDNMAction
      Category = 'FormActions'
      Caption = '&New'
      HelpContext = 410081
      OnExecute = actNewExecute
      OnUpdate = actNewUpdate
      buttoncolor = clWhite
    end
    object actPrintReceipt: TDNMAction
      Category = 'FormActions'
      Caption = '&Print Receipt'
      HelpContext = 410082
      OnExecute = cmdPrintAndEmailClick
      OnUpdate = actPrintReceiptUpdate
      buttoncolor = clWhite
    end
    object actEmail: TDNMAction
      Category = 'FormActions'
      Caption = '&Email'
      HelpContext = 410083
      OnExecute = cmdPrintAndEmailClick
      OnUpdate = actEmailUpdate
      buttoncolor = clWhite
    end
    object actCancel: TDNMAction
      Category = 'FormActions'
      Caption = '&Cancel'
      HelpContext = 410084
      OnExecute = actCancelExecute
      OnUpdate = actCancelUpdate
      buttoncolor = clWhite
    end
    object actAddSurcharge: TAction
      Category = 'FormActions'
      Caption = 'Surcharge'
      HelpContext = 410085
      OnExecute = actAddSurchargeExecute
      OnUpdate = actAddSurchargeUpdate
    end
  end
  object tblGuiDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '#Select * from tmp_custpayments__admin_324707b0'
      'Select * from tmp_custpayments__admin_21024dfd')
    AfterOpen = tblGuiDetailsAfterOpen
    Left = 424
    Top = 312
    object tblGuiDetailsType: TWideStringField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'Type'
      Origin = 'tmp_custpayments__admin_324707b0.Type'
      Size = 10
    end
    object tblGuiDetailsSaleDate: TDateField
      DisplayLabel = 'Invoice Date'
      DisplayWidth = 10
      FieldName = 'SaleDate'
      Origin = 'tmp_custpayments__admin_324707b0.SaleDate'
    end
    object tblGuiDetailsInvoiceDocNumber: TWideStringField
      DisplayLabel = 'Trans No'
      DisplayWidth = 10
      FieldName = 'InvoiceDocNumber'
      Origin = 'tmp_custpayments__admin_324707b0.InvoiceDocNumber'
      Size = 30
    end
    object tblGuiDetailsOriginalAmount: TFloatField
      DisplayLabel = 'Amount'
      DisplayWidth = 10
      FieldName = 'OriginalAmount'
      Origin = 'tmp_custpayments__admin_324707b0.OriginalAmount'
      currency = True
    end
    object tblGuiDetailsForeignOriginalAmt: TFloatField
      DisplayLabel = 'Original~Foreign amt'
      DisplayWidth = 1
      FieldName = 'ForeignOriginalAmt'
      Origin = 'tmp_custpayments__admin_324707b0.ForeignOriginalAmt'
      DisplayFormat = '#0.00'
    end
    object tblGuiDetailsBalance: TFloatField
      DisplayLabel = 'Amount~Due'
      DisplayWidth = 1
      FieldName = 'Balance'
      Origin = 'tmp_custpayments__admin_324707b0.Balance'
      currency = True
    end
    object tblGuiDetailsForeignBalanceAmount: TFloatField
      DisplayLabel = 'Foreign~amount due'
      DisplayWidth = 1
      FieldName = 'ForeignBalanceAmount'
      Origin = 'tmp_custpayments__admin_324707b0.ForeignBalanceAmount'
      DisplayFormat = '#0.00'
    end
    object tblGuiDetailsPayment: TFloatField
      DisplayWidth = 1
      FieldName = 'Payment'
      Origin = 'tmp_custpayments__admin_324707b0.Payment'
      currency = True
    end
    object tblGuiDetailsForeignPayment: TFloatField
      DisplayWidth = 1
      FieldName = 'ForeignPayment'
      Origin = 'tmp_custpayments__admin_324707b0.ForeignPayment'
      DisplayFormat = '#0.00'
    end
    object tblGuiDetailsApply: TWideStringField
      DisplayWidth = 1
      FieldName = 'Apply'
      Origin = 'tmp_custpayments__admin_324707b0.Apply'
      FixedChar = True
      Size = 1
    end
    object tblGuiDetailsAmountOutstanding: TFloatField
      DisplayLabel = 'Amount~Outstanding'
      DisplayWidth = 1
      FieldName = 'AmountOutstanding'
      Origin = 'tmp_custpayments__admin_324707b0.AmountOutstanding'
      currency = True
    end
    object tblGuiDetailsForeignAmountOutstanding: TFloatField
      DisplayLabel = 'Foreign~Outstanding'
      DisplayWidth = 1
      FieldName = 'ForeignAmountOutstanding'
      Origin = 'tmp_custpayments__admin_324707b0.ForeignAmountOutstanding'
      DisplayFormat = '#0.00'
    end
    object tblGuiDetailsDiscount: TFloatField
      DisplayWidth = 10
      FieldName = 'Discount'
      Origin = 'tmp_custpayments__admin_324707b0.Discount'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblGuiDetailsWithholding: TFloatField
      DisplayWidth = 1
      FieldName = 'Withholding'
      Origin = 'tmp_custpayments__admin_324707b0.Withholding'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblGuiDetailsRefunding: TFloatField
      DisplayWidth = 1
      FieldName = 'Refunding'
      Origin = 'tmp_custpayments__admin_324707b0.Refunding'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblGuiDetailsRefundPercent: TFloatField
      DisplayLabel = 'Refund~Percent'
      DisplayWidth = 1
      FieldName = 'RefundPercent'
      Origin = 'tmp_custpayments__admin_324707b0.RefundPercent'
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '#0.00%'
    end
    object tblGuiDetailsForeignExchangeRate: TFloatField
      DisplayLabel = 'Foreign~Exchange Rate'
      DisplayWidth = 1
      FieldName = 'ForeignExchangeRate'
      Origin = 'tmp_custpayments__admin_324707b0.ForeignExchangeRate'
    end
    object tblGuiDetailsIsEarlyPaymentDiscount: TWideStringField
      DisplayLabel = 'Early~Payment'
      DisplayWidth = 1
      FieldName = 'IsEarlyPaymentDiscount'
      Origin = 'tmp_custpayments__admin_324707b0.IsEarlyPaymentDiscount'
      FixedChar = True
      Size = 1
    end
    object tblGuiDetailsRefNo: TWideStringField
      DisplayLabel = 'Ref No'
      DisplayWidth = 10
      FieldName = 'RefNo'
      Origin = 'tmp_custpayments__admin_324707b0.RefNo'
      Size = 255
    end
    object tblGuiDetailsEnteredBy: TWideStringField
      DisplayWidth = 20
      FieldName = 'EnteredBy'
      ReadOnly = True
      Size = 255
    end
    object tblGuiDetailsConNote: TStringField
      DisplayLabel = 'Con. Note'
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'ConNote'
      LookupDataSet = qryConnote
      LookupKeyFields = 'SaleID'
      LookupResultField = 'ConNote'
      KeyFields = 'SaleID'
      OnGetText = tblGuiDetailsConNoteGetText
      Size = 50
      Lookup = True
    end
    object tblGuiDetailsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tmp_custpayments__admin_324707b0.ID'
      Visible = False
    end
    object tblGuiDetailsCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Origin = 'tmp_custpayments__admin_324707b0.CustomerName'
      Visible = False
      Size = 255
    end
    object tblGuiDetailsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tmp_custpayments__admin_324707b0.GlobalRef'
      Visible = False
      Size = 255
    end
    object tblGuiDetailsPaid: TWideStringField
      FieldName = 'Paid'
      Origin = 'tmp_custpayments__admin_324707b0.Paid'
      Visible = False
      Size = 1
    end
    object tblGuiDetailsSaleID: TIntegerField
      FieldName = 'SaleID'
      Origin = 'tmp_custpayments__admin_324707b0.SaleID'
      Visible = False
    end
    object tblGuiDetailsForeignExchangeCode: TWideStringField
      FieldName = 'ForeignExchangeCode'
      Origin = 'tmp_custpayments__admin_324707b0.ForeignExchangeCode'
      Visible = False
      FixedChar = True
      Size = 3
    end
  end
  object dsGuiDetails: TDataSource
    DataSet = tblGuiDetails
    Left = 424
    Top = 352
  end
  object qryEmployeeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeID,EmployeeName FROM tblemployees')
    Left = 72
    Top = 280
  end
  object qryConnote: TERPQuery
    SQL.Strings = (
      'SELECT SaleId, Connote FROM tblsales')
    Left = 581
    Top = 326
    object AutoIncField1: TAutoIncField
      FieldName = 'SaleID'
      ReadOnly = True
    end
    object WideStringField14: TWideStringField
      FieldName = 'ConNote'
      Size = 25
    end
  end
end
