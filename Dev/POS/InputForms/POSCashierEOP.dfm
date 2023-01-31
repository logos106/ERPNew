inherited frmPOSCashierEOP: TfrmPOSCashierEOP
  Left = 602
  Top = 146
  HelpContext = 327000
  BorderIcons = []
  Caption = 'End Of Period'
  ClientHeight = 573
  ClientWidth = 536
  OldCreateOrder = True
  ExplicitLeft = 602
  ExplicitTop = 146
  ExplicitWidth = 552
  ExplicitHeight = 612
  DesignSize = (
    536
    573)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 573
    Width = 536
    HelpContext = 327084
    ExplicitTop = 573
    ExplicitWidth = 536
  end
  inherited imgGridWatermark: TImage
    HelpContext = 327001
  end
  object btnCancel: TDNMSpeedButton [5]
    Left = 296
    Top = 540
    Width = 97
    Height = 25
    HelpContext = 327003
    Cancel = True
    Caption = 'Cancel'
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
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnSave: TDNMSpeedButton [6]
    Left = 120
    Top = 540
    Width = 97
    Height = 25
    HelpContext = 327002
    Caption = 'OK'
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
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 0
    OnClick = btnSaveClick
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 8
    Top = 47
    Width = 521
    Height = 487
    HelpContext = 327004
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Bevel1: TBevel
      Left = 8
      Top = 5
      Width = 505
      Height = 470
      HelpContext = 327005
      Shape = bsFrame
    end
    object Bevel2: TBevel
      Left = 224
      Top = 309
      Width = 280
      Height = 41
      HelpContext = 327006
      Shape = bsFrame
    end
    object Label3: TLabel
      Left = 23
      Top = 16
      Width = 85
      Height = 15
      HelpContext = 327007
      Caption = 'Denominations'
      Transparent = True
    end
    object lblamt1: TLabel
      Left = 40
      Top = 47
      Width = 70
      Height = 15
      HelpContext = 327008
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lbl'
      Transparent = True
    end
    object lblamt2: TLabel
      Left = 40
      Top = 70
      Width = 70
      Height = 15
      HelpContext = 327009
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lbl'
      Transparent = True
    end
    object lblamt3: TLabel
      Left = 40
      Top = 94
      Width = 70
      Height = 15
      HelpContext = 327010
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lbl'
      Transparent = True
    end
    object lblamt4: TLabel
      Left = 40
      Top = 118
      Width = 70
      Height = 15
      HelpContext = 327011
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lbl'
      Transparent = True
    end
    object lblamt5: TLabel
      Left = 40
      Top = 142
      Width = 70
      Height = 15
      HelpContext = 327012
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lbl'
      Transparent = True
    end
    object lblamt6: TLabel
      Left = 40
      Top = 166
      Width = 70
      Height = 15
      HelpContext = 327013
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lbl'
      Transparent = True
    end
    object lblamt7: TLabel
      Left = 40
      Top = 190
      Width = 70
      Height = 15
      HelpContext = 327014
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lbl'
      Transparent = True
    end
    object lblamt8: TLabel
      Left = 40
      Top = 213
      Width = 70
      Height = 15
      HelpContext = 327015
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lbl'
      Transparent = True
    end
    object lblamt9: TLabel
      Left = 40
      Top = 237
      Width = 70
      Height = 15
      HelpContext = 327016
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lbl'
      Transparent = True
    end
    object lblamt10: TLabel
      Left = 40
      Top = 261
      Width = 70
      Height = 15
      HelpContext = 327017
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lbl'
      Transparent = True
    end
    object lblamt11: TLabel
      Left = 40
      Top = 285
      Width = 70
      Height = 15
      HelpContext = 327018
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lbl'
      Transparent = True
    end
    object Label15: TLabel
      Left = 23
      Top = 366
      Width = 59
      Height = 15
      HelpContext = 327019
      Caption = 'Total Cash'
      Transparent = True
    end
    object Label16: TLabel
      Left = 23
      Top = 390
      Width = 58
      Height = 15
      HelpContext = 327020
      Caption = 'Less Float'
      Transparent = True
    end
    object Label17: TLabel
      Left = 23
      Top = 414
      Width = 84
      Height = 15
      HelpContext = 327021
      Caption = 'Sub Total Cash'
      Transparent = True
    end
    object Label18: TLabel
      Left = 23
      Top = 446
      Width = 61
      Height = 15
      HelpContext = 327022
      Caption = 'Petty Cash'
      Transparent = True
    end
    object Label19: TLabel
      Left = 260
      Top = 47
      Width = 45
      Height = 15
      HelpContext = 327023
      Caption = 'EFTPOS'
      Transparent = True
    end
    object Label20: TLabel
      Left = 260
      Top = 70
      Width = 55
      Height = 15
      HelpContext = 327024
      Caption = 'Visa Card'
      Transparent = True
    end
    object Label21: TLabel
      Left = 260
      Top = 94
      Width = 70
      Height = 15
      HelpContext = 327025
      Caption = 'Master Card'
      Transparent = True
    end
    object Label22: TLabel
      Left = 260
      Top = 118
      Width = 67
      Height = 15
      HelpContext = 327026
      Caption = 'Diners Card'
      Transparent = True
    end
    object Label23: TLabel
      Left = 260
      Top = 142
      Width = 59
      Height = 15
      HelpContext = 327027
      Caption = 'Bank Card'
      Transparent = True
    end
    object Label24: TLabel
      Left = 260
      Top = 166
      Width = 33
      Height = 15
      HelpContext = 327028
      Caption = 'Amex'
      Transparent = True
    end
    object Label25: TLabel
      Left = 260
      Top = 261
      Width = 50
      Height = 15
      HelpContext = 327029
      Caption = 'Cheques'
      Transparent = True
    end
    object Label26: TLabel
      Left = 260
      Top = 285
      Width = 100
      Height = 15
      HelpContext = 327030
      Caption = 'Invoice Payments'
      Transparent = True
    end
    object Label28: TLabel
      Left = 128
      Top = 16
      Width = 45
      Height = 15
      HelpContext = 327031
      Caption = 'Number'
      Transparent = True
    end
    object Label29: TLabel
      Left = 373
      Top = 16
      Width = 44
      Height = 15
      HelpContext = 327032
      Caption = 'Amount'
      Transparent = True
    end
    object Bevel3: TBevel
      Left = 18
      Top = 14
      Width = 96
      Height = 22
      HelpContext = 327033
      Shape = bsFrame
    end
    object Bevel4: TBevel
      Left = 125
      Top = 14
      Width = 81
      Height = 22
      HelpContext = 327034
      Shape = bsFrame
    end
    object Bevel5: TBevel
      Left = 369
      Top = 14
      Width = 79
      Height = 21
      HelpContext = 327035
      Shape = bsFrame
    end
    object Label33: TLabel
      Left = 260
      Top = 213
      Width = 64
      Height = 15
      HelpContext = 327036
      Caption = 'Credit Card'
      Transparent = True
    end
    object lblamt12: TLabel
      Left = 40
      Top = 309
      Width = 70
      Height = 15
      HelpContext = 327037
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lbl'
      Transparent = True
    end
    object lblamt13: TLabel
      Left = 40
      Top = 333
      Width = 70
      Height = 15
      HelpContext = 327038
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'lbl'
      Transparent = True
    end
    object Label35: TLabel
      Left = 260
      Top = 237
      Width = 59
      Height = 15
      HelpContext = 327039
      Caption = 'Debit Card'
      Transparent = True
    end
    object Label27: TLabel
      Left = 260
      Top = 322
      Width = 83
      Height = 15
      HelpContext = 327040
      Caption = 'PERIOD TOTAL'
      Transparent = True
    end
    object Label36: TLabel
      Left = 260
      Top = 189
      Width = 47
      Height = 15
      HelpContext = 327041
      Caption = 'Maestro'
      Transparent = True
    end
    object Label37: TLabel
      Left = 260
      Top = 446
      Width = 103
      Height = 15
      HelpContext = 327085
      Caption = 'Number of people '
      Transparent = True
    end
    object edHundred: TwwDBEdit
      Left = 124
      Top = 43
      Width = 81
      Height = 23
      HelpContext = 327042
      DataField = 'Hundred'
      DataSource = DataSource1
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
      OnExit = edHundredExit
    end
    object edFifty: TwwDBEdit
      Left = 124
      Top = 66
      Width = 81
      Height = 23
      HelpContext = 327043
      DataField = 'Fifty'
      DataSource = DataSource1
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
      OnExit = edHundredExit
    end
    object edTwenty: TwwDBEdit
      Left = 124
      Top = 90
      Width = 81
      Height = 23
      HelpContext = 327044
      DataField = 'Twenty'
      DataSource = DataSource1
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
      OnExit = edHundredExit
    end
    object edTen: TwwDBEdit
      Left = 124
      Top = 114
      Width = 81
      Height = 23
      HelpContext = 327045
      DataField = 'Ten'
      DataSource = DataSource1
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
      OnExit = edHundredExit
    end
    object edFive: TwwDBEdit
      Left = 124
      Top = 138
      Width = 81
      Height = 23
      HelpContext = 327046
      DataField = 'Five'
      DataSource = DataSource1
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
      OnExit = edHundredExit
    end
    object edTwo: TwwDBEdit
      Left = 124
      Top = 162
      Width = 81
      Height = 23
      HelpContext = 327047
      DataField = 'Two'
      DataSource = DataSource1
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
      OnExit = edHundredExit
    end
    object edOne: TwwDBEdit
      Left = 124
      Top = 186
      Width = 81
      Height = 23
      HelpContext = 327048
      DataField = 'One'
      DataSource = DataSource1
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
      OnExit = edHundredExit
    end
    object edFiftyCents: TwwDBEdit
      Left = 124
      Top = 209
      Width = 81
      Height = 23
      HelpContext = 327049
      DataField = 'FiftyCents'
      DataSource = DataSource1
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
      OnExit = edHundredExit
    end
    object edTwentyCents: TwwDBEdit
      Left = 124
      Top = 233
      Width = 81
      Height = 23
      HelpContext = 327050
      DataField = 'TwentyCents'
      DataSource = DataSource1
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
      OnExit = edHundredExit
    end
    object edTenCents: TwwDBEdit
      Left = 124
      Top = 257
      Width = 81
      Height = 23
      HelpContext = 327051
      DataField = 'TenCents'
      DataSource = DataSource1
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
      OnExit = edHundredExit
    end
    object edFiveCents: TwwDBEdit
      Left = 124
      Top = 281
      Width = 81
      Height = 23
      HelpContext = 327052
      DataField = 'FiveCents'
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnExit = edHundredExit
    end
    object edTotal: TwwDBEdit
      Left = 124
      Top = 363
      Width = 81
      Height = 23
      HelpContext = 327053
      DataField = 'TotalCash'
      DataSource = DataSource1
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edFloat: TwwDBEdit
      Left = 124
      Top = 387
      Width = 81
      Height = 23
      HelpContext = 327054
      DataField = 'TillFloat'
      DataSource = DataSource1
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
      OnExit = edHundredExit
    end
    object edSubCash: TwwDBEdit
      Left = 124
      Top = 411
      Width = 81
      Height = 23
      HelpContext = 327055
      DataField = 'SubTotal'
      DataSource = DataSource1
      Enabled = False
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
    object edPettyCash: TwwDBEdit
      Left = 124
      Top = 443
      Width = 81
      Height = 23
      HelpContext = 327056
      DataField = 'PettyCash'
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edEFTPOS: TwwDBEdit
      Left = 368
      Top = 43
      Width = 81
      Height = 23
      HelpContext = 327057
      DataField = 'EFTPOS'
      DataSource = DataSource1
      Enabled = False
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
      OnExit = edEFTPOSExit
    end
    object edVisa: TwwDBEdit
      Left = 368
      Top = 66
      Width = 81
      Height = 23
      HelpContext = 327058
      DataField = 'Visa'
      DataSource = DataSource1
      Enabled = False
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
      OnExit = edEFTPOSExit
    end
    object edMaster: TwwDBEdit
      Left = 368
      Top = 90
      Width = 81
      Height = 23
      HelpContext = 327059
      DataField = 'MasterCard'
      DataSource = DataSource1
      Enabled = False
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
      OnExit = edEFTPOSExit
    end
    object edDiners: TwwDBEdit
      Left = 368
      Top = 114
      Width = 81
      Height = 23
      HelpContext = 327060
      DataField = 'Diners'
      DataSource = DataSource1
      Enabled = False
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
      OnExit = edEFTPOSExit
    end
    object edBankCard: TwwDBEdit
      Left = 368
      Top = 138
      Width = 81
      Height = 23
      HelpContext = 327061
      DataField = 'BankCard'
      DataSource = DataSource1
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 21
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnExit = edEFTPOSExit
    end
    object edAmex: TwwDBEdit
      Left = 368
      Top = 162
      Width = 81
      Height = 23
      HelpContext = 327062
      DataField = 'Amex'
      DataSource = DataSource1
      Enabled = False
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
      OnExit = edEFTPOSExit
    end
    object edCheques: TwwDBEdit
      Left = 368
      Top = 257
      Width = 81
      Height = 23
      HelpContext = 327063
      DataField = 'Cheques'
      DataSource = DataSource1
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 26
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnExit = edEFTPOSExit
    end
    object edInvoicePayments: TwwDBEdit
      Left = 368
      Top = 281
      Width = 81
      Height = 23
      HelpContext = 327064
      DataField = 'InvoicePayments'
      DataSource = DataSource1
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 27
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnExit = edEFTPOSExit
    end
    object edCreditCard: TwwDBEdit
      Left = 368
      Top = 209
      Width = 81
      Height = 23
      HelpContext = 327065
      DataField = 'CreditCard'
      DataSource = DataSource1
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 24
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnExit = edEFTPOSExit
    end
    object edTwoCents: TwwDBEdit
      Left = 124
      Top = 305
      Width = 81
      Height = 23
      HelpContext = 327066
      DataField = 'TwoCents'
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnExit = edHundredExit
    end
    object edOneCent: TwwDBEdit
      Left = 124
      Top = 329
      Width = 81
      Height = 23
      HelpContext = 327067
      DataField = 'OneCent'
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnExit = edHundredExit
    end
    object edDebitCard: TwwDBEdit
      Left = 368
      Top = 233
      Width = 81
      Height = 23
      HelpContext = 327068
      DataField = 'DebitCard'
      DataSource = DataSource1
      Enabled = False
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
      OnExit = edEFTPOSExit
    end
    object edPeriodTotal: TwwDBEdit
      Left = 368
      Top = 317
      Width = 81
      Height = 23
      HelpContext = 327069
      DataField = 'PeriodTotal'
      DataSource = DataSource1
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 28
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object pnlCashSales: TDNMPanel
      Left = 224
      Top = 348
      Width = 280
      Height = 88
      HelpContext = 327070
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 29
      Visible = False
      object Bevel6: TBevel
        Left = 0
        Top = 0
        Width = 280
        Height = 88
        HelpContext = 327071
        Align = alClient
        Shape = bsFrame
      end
      object Label30: TLabel
        Left = 46
        Top = 13
        Width = 67
        Height = 15
        HelpContext = 327072
        Caption = 'Cash Sales '
        Transparent = True
      end
      object Label31: TLabel
        Left = 13
        Top = 37
        Width = 28
        Height = 15
        HelpContext = 327073
        Caption = 'Start'
        Transparent = True
      end
      object Label32: TLabel
        Left = 143
        Top = 37
        Width = 21
        Height = 15
        HelpContext = 327074
        Caption = 'End'
        Transparent = True
      end
      object edCashSales: TwwDBEdit
        Left = 143
        Top = 8
        Width = 82
        Height = 23
        HelpContext = 327075
        DataField = 'CashSales'
        DataSource = DataSource1
        Enabled = False
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
      object edStart: TwwDBEdit
        Left = 10
        Top = 53
        Width = 121
        Height = 23
        HelpContext = 327076
        DataField = 'Start'
        DataSource = DataSource1
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
      end
      object edEnd: TwwDBEdit
        Left = 143
        Top = 53
        Width = 121
        Height = 23
        HelpContext = 327077
        DataField = 'EndDate'
        DataSource = DataSource1
        Enabled = False
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
    object edMaestro: TwwDBEdit
      Left = 368
      Top = 185
      Width = 81
      Height = 23
      HelpContext = 327078
      DataField = 'Maestro'
      DataSource = DataSource1
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 23
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnExit = edEFTPOSExit
    end
    object wwDBEdit1: TwwDBEdit
      Left = 368
      Top = 443
      Width = 81
      Height = 23
      HelpContext = 327086
      DataField = 'TrafficCount'
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 30
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
  end
  object edPeriodID: TwwDBEdit [8]
    Left = 8
    Top = 539
    Width = 57
    Height = 23
    HelpContext = 327079
    DataField = 'PeriodID'
    DataSource = DataSource1
    Enabled = False
    Font.Charset = ANSI_CHARSET
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
  object pnlHeader: TPanel [9]
    Left = 8
    Top = 5
    Width = 521
    Height = 39
    HelpContext = 327080
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 4
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 519
      Height = 37
      HelpContext = 327081
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
        Width = 297
        Height = 37
        HelpContext = 327082
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = '  End of Period   Till:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
      object Label2: TLabel
        Left = 297
        Top = 0
        Width = 222
        Height = 37
        HelpContext = 327083
        Align = alClient
        Caption = 'Label2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 92
        ExplicitHeight = 34
      end
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 32
    Top = 65528
  end
  inherited ApplicationEvents1: TApplicationEvents
    Top = 65528
  end
  inherited MyConnection: TERPConnection
    
    Server = 'localhost'
    Connected = True
  end
  inherited DataState: TDataState
    Left = 168
    Top = 0
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102006400840010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryTillEOP: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblpostilleop')
    AfterOpen = qryTillEOPAfterOpen
    AfterInsert = qryTillEOPAfterInsert
    Left = 296
    Top = 48
    object qryTillEOPPeriodID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PeriodID'
      Origin = 'tblpostilleop.PeriodID'
    end
    object qryTillEOPStart: TDateTimeField
      FieldName = 'Start'
      Origin = 'tblpostilleop.Start'
      DisplayFormat = 'dd-mm-yyyy hh:mm:ss'
    end
    object qryTillEOPTillID: TIntegerField
      FieldName = 'TillID'
      Origin = 'tblpostilleop.TillID'
    end
    object qryTillEOPEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblpostilleop.EmployeeID'
    end
    object qryTillEOPHundred: TIntegerField
      FieldName = 'Hundred'
      Origin = 'tblpostilleop.Hundred'
    end
    object qryTillEOPFifty: TIntegerField
      FieldName = 'Fifty'
      Origin = 'tblpostilleop.Fifty'
    end
    object qryTillEOPTwenty: TIntegerField
      FieldName = 'Twenty'
      Origin = 'tblpostilleop.Twenty'
    end
    object qryTillEOPTen: TIntegerField
      FieldName = 'Ten'
      Origin = 'tblpostilleop.Ten'
    end
    object qryTillEOPFive: TIntegerField
      FieldName = 'Five'
      Origin = 'tblpostilleop.Five'
    end
    object qryTillEOPTwo: TIntegerField
      FieldName = 'Two'
      Origin = 'tblpostilleop.Two'
    end
    object qryTillEOPOne: TIntegerField
      FieldName = 'One'
      Origin = 'tblpostilleop.One'
    end
    object qryTillEOPFiftyCents: TIntegerField
      FieldName = 'FiftyCents'
      Origin = 'tblpostilleop.FiftyCents'
    end
    object qryTillEOPTwentyCents: TIntegerField
      FieldName = 'TwentyCents'
      Origin = 'tblpostilleop.TwentyCents'
    end
    object qryTillEOPTenCents: TIntegerField
      FieldName = 'TenCents'
      Origin = 'tblpostilleop.TenCents'
    end
    object qryTillEOPFiveCents: TIntegerField
      FieldName = 'FiveCents'
      Origin = 'tblpostilleop.FiveCents'
    end
    object qryTillEOPTotalCash: TFloatField
      FieldName = 'TotalCash'
      Origin = 'tblpostilleop.TotalCash'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPSubTotal: TFloatField
      FieldName = 'SubTotal'
      Origin = 'tblpostilleop.SubTotal'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPPettyCash: TFloatField
      FieldName = 'PettyCash'
      Origin = 'tblpostilleop.PettyCash'
      DisplayFormat = '$####0.00'
    end
    object qryTillEOPEFTPOS: TFloatField
      FieldName = 'EFTPOS'
      Origin = 'tblpostilleop.EFTPOS'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPVisa: TFloatField
      FieldName = 'Visa'
      Origin = 'tblpostilleop.Visa'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPMasterCard: TFloatField
      FieldName = 'MasterCard'
      Origin = 'tblpostilleop.MasterCard'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPDiners: TFloatField
      FieldName = 'Diners'
      Origin = 'tblpostilleop.Diners'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPBankCard: TFloatField
      FieldName = 'BankCard'
      Origin = 'tblpostilleop.BankCard'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPCheques: TFloatField
      FieldName = 'Cheques'
      Origin = 'tblpostilleop.Cheques'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPInvoicePayments: TFloatField
      FieldName = 'InvoicePayments'
      Origin = 'tblpostilleop.InvoicePayments'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPPeriodTotal: TFloatField
      FieldName = 'PeriodTotal'
      Origin = 'tblpostilleop.PeriodTotal'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 254
    end
    object qryTillEOPAmex: TFloatField
      FieldName = 'Amex'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPEndDate: TDateTimeField
      FieldName = 'EndDate'
      DisplayFormat = 'dd-mm-yyyy hh:mm:ss'
    end
    object qryTillEOPVariation: TFloatField
      FieldName = 'Variation'
    end
    object qryTillEOPCashSales: TFloatField
      FieldName = 'CashSales'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPTillFloat: TFloatField
      FieldName = 'TillFloat'
    end
    object qryTillEOPTotalSalesAmount: TFloatField
      FieldName = 'TotalSalesAmount'
    end
    object qryTillEOPCreditCard: TFloatField
      FieldName = 'CreditCard'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPTwoCents: TIntegerField
      FieldName = 'TwoCents'
    end
    object qryTillEOPOneCent: TIntegerField
      FieldName = 'OneCent'
    end
    object qryTillEOPDebitCard: TFloatField
      FieldName = 'DebitCard'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPMaestro: TFloatField
      FieldName = 'Maestro'
      DisplayFormat = '$######0.00'
    end
    object qryTillEOPTrafficCount: TLargeintField
      FieldName = 'TrafficCount'
    end
    object qryTillEOPSalecount: TLargeintField
      FieldName = 'Salecount'
    end
    object qryTillEOPGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryTillEOPHundredMult: TFloatField
      FieldName = 'HundredMult'
    end
    object qryTillEOPFiftyMult: TFloatField
      FieldName = 'FiftyMult'
    end
    object qryTillEOPTwentyMult: TFloatField
      FieldName = 'TwentyMult'
    end
    object qryTillEOPTenMult: TFloatField
      FieldName = 'TenMult'
    end
    object qryTillEOPFiveMult: TFloatField
      FieldName = 'FiveMult'
    end
    object qryTillEOPTwoMult: TFloatField
      FieldName = 'TwoMult'
    end
    object qryTillEOPOneMult: TFloatField
      FieldName = 'OneMult'
    end
    object qryTillEOPFiftyCentsMult: TFloatField
      FieldName = 'FiftyCentsMult'
    end
    object qryTillEOPTwentyCentsMult: TFloatField
      FieldName = 'TwentyCentsMult'
    end
    object qryTillEOPTenCentsMult: TFloatField
      FieldName = 'TenCentsMult'
    end
    object qryTillEOPFiveCentsMult: TFloatField
      FieldName = 'FiveCentsMult'
    end
    object qryTillEOPTwoCentsMult: TFloatField
      FieldName = 'TwoCentsMult'
    end
    object qryTillEOPOneCentMult: TFloatField
      FieldName = 'OneCentMult'
    end
    object qryTillEOPmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryTillEOPmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object DataSource1: TDataSource
    DataSet = qryTillEOP
    Left = 336
    Top = 40
  end
  object qrySales: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT SaleDate, TimeOfSale, TotalLineAmountInc, PayMethod,'
      
        'ProductName, QtySold,Product_Description,EmployeeName,EmployeeID' +
        ',SaleDateTime   '
      'FROM tblSalesLines '
      'INNER JOIN tblSales ON tblSalesLines.SaleID = tblSales.SaleID '
      'WHERE IsLayby = "F" and POS = "T" '
      'AND TillID = :xTillID')
    Left = 400
    Top = 32
    ParamData = <
      item
        DataType = ftString
        Name = 'xTillID'
        Value = ''
      end>
  end
end
