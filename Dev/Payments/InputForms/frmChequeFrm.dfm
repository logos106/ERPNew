inherited frmCheque: TfrmCheque
  Left = 120
  Top = 67
  HelpContext = 244000
  Caption = 'Cheque'
  ClientHeight = 564
  ClientWidth = 839
  ExplicitLeft = 120
  ExplicitTop = 67
  ExplicitWidth = 855
  ExplicitHeight = 603
  DesignSize = (
    839
    564)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 437
    Width = 839
    ExplicitTop = 437
    ExplicitWidth = 839
  end
  inherited imgGridWatermark: TImage
    HelpContext = 244001
  end
  inherited pnlDetail: TDNMPanel
    Top = 201
    Width = 839
    Height = 236
    HelpContext = 244071
    Align = alClient
    ExplicitTop = 201
    ExplicitWidth = 839
    ExplicitHeight = 236
    inherited grdTransactions: TwwDBGrid
      Width = 839
      Height = 236
      HelpContext = 244073
      ControlType.Strings = (
        'AccountName;CustomEdit;cboAccountlineX;F'
        'LineTaxCode;CustomEdit;cboTaxCode;F'
        'CustomerJob;CustomEdit;cboCustJob;F'
        'CustomerJobID;CustomEdit;cboJobNumber;F'
        'Class;CustomEdit;cboClass;F'
        'AccountNumber;CustomEdit;cboAccountlNoLine;F'
        'RelatedPOID;CustomEdit;cboRelatedPOID;F'
        'EquipmentName;CustomEdit;cboEquipmentname;F'
        'RepairDocNo;CustomEdit;cboRepairDocNo;F'
        'EmployeeName;CustomEdit;cboLineEmployee;F'
        'AreaCode;CustomEdit;cboLinesAreaCode;F'
        'ExpenseProductSelected;CustomEdit;edtExpenseProductSelected;F')
      Selected.Strings = (
        'AccountNumber'#9'10'#9'Account No'#9'F'#9
        'AccountName'#9'18'#9'Account Name'#9'F'#9
        'LineCost'#9'15'#9'Amount (Ex)'#9'F'#9
        'LineTaxCode'#9'15'#9'Code'#9'F'#9
        'LineTax'#9'10'#9'Tax (Dbl Click)'#9'T'#9
        'Product_Description'#9'35'#9'Memo'#9'F'#9
        'CustomerJob'#9'25'#9'Customer / Job'#9'F'#9
        'Class'#9'10'#9'Departments'#9'F'#9
        'RelatedPOID'#9'10'#9'RelatedPOID'#9'F'#9
        'SortID'#9'10'#9'SortID'#9'F'#9
        'LinesOrder'#9'10'#9'Order by'#9'F'#9
        'EquipmentName'#9'20'#9'Equipment Name'#9'F'#9
        'EmployeeName'#9'20'#9'Employee'#9'F'#9
        'AreaCode'#9'10'#9'Area'#9'F'#9
        'RepairDocNo'#9'15'#9'Repair #'#9'F'#9
        'ExpenseProductSelected'#9'20'#9'ExpenseProductSelected'#9'F'#9)
      ExplicitWidth = 839
      ExplicitHeight = 236
    end
    inherited cboAccountlineX: TERPDbLookupCombo
      Left = 80
      Top = 59
      Selected.Strings = (
        'AccountName'#9'25'#9'Account Name'#9'F'
        'Type'#9'20'#9'Type'#9'T'
        'Description'#9'30'#9'Description'#9'F')
      ExplicitLeft = 80
      ExplicitTop = 59
    end
    inherited cboTaxCode: TERPDbLookupCombo
      Left = 488
      Top = 53
      AllowClearKey = True
      LookupComboType = ctTaxcode
      AllowFullListSearchMode = True
      LookupIDField = 'TaxCodeID'
      ExplicitLeft = 488
      ExplicitTop = 53
    end
    inherited cboClass: TwwDBLookupCombo
      Left = 293
      Top = 24
      ExplicitLeft = 293
      ExplicitTop = 24
    end
    inherited cboRelatedPOID: TwwDBLookupCombo
      Left = 361
      Top = 53
      ExplicitLeft = 361
      ExplicitTop = 53
    end
    inherited cboEquipmentName: TwwDBLookupCombo
      Left = 57
      Top = 38
      ExplicitLeft = 57
      ExplicitTop = 38
    end
    inherited cboAccountlNoLine: TERPDbLookupCombo
      Left = 14
      ExplicitLeft = 14
    end
    inherited cboRepairDocNo: TwwDBLookupCombo
      Left = 222
      Top = 53
      ExplicitLeft = 222
      ExplicitTop = 53
    end
    inherited edtExpenseProductSelected: TwwDBEdit
      Left = 400
      Top = 21
      ExplicitLeft = 400
      ExplicitTop = 21
    end
    inherited cboCustJob: TERPDbLookupCombo
      Left = 179
      Top = 30
      ExplicitLeft = 179
      ExplicitTop = 30
    end
    inherited cboCustPrintJob: TERPDbLookupCombo
      Left = 368
      ExplicitLeft = 368
    end
  end
  inherited pnlFooter: TDNMPanel
    Top = 437
    Width = 839
    Height = 127
    HelpContext = 244002
    Align = alBottom
    ExplicitTop = 437
    ExplicitWidth = 839
    ExplicitHeight = 127
    DesignSize = (
      839
      127)
    object Bevel2: TBevel [0]
      Left = 1
      Top = 69
      Width = 319
      Height = 55
    end
    inherited Label1: TLabel
      Top = 9
      HelpContext = 244004
      ExplicitTop = 9
    end
    inherited Label142: TLabel
      Left = 655
      Top = 42
      HelpContext = 244005
      ExplicitLeft = 655
      ExplicitTop = 42
    end
    inherited Label54: TLabel
      Left = 656
      Top = 69
      HelpContext = 244006
      ExplicitLeft = 656
      ExplicitTop = 69
    end
    inherited Label56: TLabel
      Left = 599
      Top = 99
      HelpContext = 244007
      ExplicitLeft = 599
      ExplicitTop = 99
    end
    inherited Label93: TLabel
      Top = 72
      Width = 70
      Height = 28
      HelpContext = 244018
      ExplicitTop = 72
      ExplicitWidth = 70
      ExplicitHeight = 28
    end
    inherited lblBaseForeignTotal: TLabel
      Top = 74
      Height = 18
      HelpContext = 244011
      ExplicitTop = 74
      ExplicitHeight = 18
    end
    object lblEFT: TLabel [7]
      Left = 519
      Top = 45
      Width = 69
      Height = 15
      HelpContext = 244023
      Caption = 'Add to E.F.T..'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel1: TBevel [8]
      Left = 0
      Top = 7
      Width = 319
      Height = 61
    end
    inherited pnlComments: TDNMPanel
      Top = 10
      Width = 246
      Height = 55
      TabOrder = 5
      ExplicitTop = 10
      ExplicitWidth = 246
      ExplicitHeight = 55
      inherited LblCommentsHint: TLabel
        Top = 36
        Width = 244
        ExplicitTop = 36
        ExplicitWidth = 244
      end
      inherited txtComments: TDBMemo
        Width = 244
        Height = 35
        HelpContext = 244013
        OnExit = txtCommentsExit
        ExplicitWidth = 244
        ExplicitHeight = 35
      end
    end
    inherited txtSubTotal: TDBEdit
      Left = 721
      Top = 38
      HelpContext = 244014
      TabOrder = 3
      ExplicitLeft = 721
      ExplicitTop = 38
    end
    inherited txtTotalTax: TDBEdit
      Left = 721
      Top = 66
      HelpContext = 244015
      TabOrder = 4
      ExplicitLeft = 721
      ExplicitTop = 66
    end
    inherited txtTotalAmount: TDBEdit
      Left = 707
      Top = 93
      HelpContext = 244016
      TabOrder = 8
      ExplicitLeft = 707
      ExplicitTop = 93
    end
    inherited edtBaseForeignTotal: TDBEdit
      Left = 496
      HelpContext = 244017
      TabOrder = 14
      ExplicitLeft = 496
    end
    inherited lblDisableCalc: TDNMSpeedButton
      Left = 730
      ExplicitLeft = 730
    end
    inherited DNMPanel5: TDNMPanel
      Width = 163
      Height = 118
      TabOrder = 7
      ExplicitWidth = 163
      ExplicitHeight = 118
      inherited lblEnteredbyHead: TLabel
        Left = 5
        ExplicitLeft = 5
      end
      inherited lblPrintHead: TLabel
        Left = 8
        Top = 49
        ExplicitLeft = 8
        ExplicitTop = 49
      end
      inherited lblPrintedBy: TLabel
        Top = 49
        ExplicitTop = 49
      end
      inherited lblPrintedOnCaption: TLabel
        Left = 6
        Top = 71
        ExplicitLeft = 6
        ExplicitTop = 71
      end
      inherited lblPrintedOn: TLabel
        Top = 71
        ExplicitTop = 71
      end
      inherited lblPrintedAtCaption: TLabel
        Top = 93
        ExplicitTop = 93
      end
      inherited lblPrintedAt: TLabel
        Top = 93
        ExplicitTop = 93
      end
      inherited lblEnteredAtHead: TLabel
        Left = 13
        Top = 27
        ExplicitLeft = 13
        ExplicitTop = 27
      end
      inherited lblEnteredAt: TDBText
        Top = 27
        DataField = 'EnteredAtShort'
        ExplicitTop = 27
      end
    end
    inherited lblEmail: TDNMPanel
      Left = 598
      Top = 6
      TabOrder = 10
      ExplicitLeft = 598
      ExplicitTop = 6
    end
    inherited txtSalesComments: TDBMemo [17]
      Left = 72
      Top = 74
      Width = 246
      Height = 41
      HelpContext = 244021
      TabOrder = 1
      OnEnter = txtSalesCommentsEnter
      OnExit = txtSalesCommentsExit
      ExplicitLeft = 72
      ExplicitTop = 74
      ExplicitWidth = 246
      ExplicitHeight = 41
    end
    inherited btnAttachments: TDNMSpeedButton [18]
      Left = 4
      Top = 24
      HelpContext = 244022
      TabOrder = 0
      ExplicitLeft = 4
      ExplicitTop = 24
    end
    object chkEFT: TwwCheckBox [19]
      Left = 496
      Top = 44
      Width = 13
      Height = 17
      HelpContext = 244024
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
      Caption = 'chkEFT'
      TabOrder = 6
      OnClick = chkEFTClick
    end
    object btnAddfollowupnotedate: TDNMSpeedButton [20]
      Left = 13
      Top = 48
      Width = 56
      Height = 13
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
      TabOrder = 11
      OnClick = btnAddfollowupnotedateClick
    end
    object btnAdddate: TDNMSpeedButton [21]
      Left = 14
      Top = 102
      Width = 56
      Height = 13
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
      TabOrder = 12
      OnClick = btnAdddateClick
    end
    object btnSignature: TDNMSpeedButton [22]
      Left = 491
      Top = 6
      Width = 65
      Height = 22
      Caption = 'Signature'
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
      TabOrder = 13
    end
    inherited pnlProcessMessage: TDNMPanel [23]
      Width = 839
      ExplicitWidth = 839
      inherited lblProcessMessage: TLabel
        Width = 835
        HelpContext = 244072
        ExplicitLeft = 200
        ExplicitWidth = 637
      end
    end
  end
  inherited pnlHeader: TDNMPanel
    Top = 0
    Width = 839
    Height = 201
    HelpContext = 244025
    Align = alTop
    ParentColor = True
    ExplicitTop = -4
    ExplicitWidth = 839
    ExplicitHeight = 201
    DesignSize = (
      839
      201)
    object Shape1: TShape [0]
      Left = 476
      Top = 95
      Width = 109
      Height = 55
      Brush.Style = bsClear
      Pen.Color = clGray
    end
    object Shape2: TShape [1]
      Left = 592
      Top = 95
      Width = 140
      Height = 55
      Brush.Style = bsClear
      Pen.Color = clGray
    end
    inherited Label38: TLabel
      Left = 8
      HelpContext = 244026
      ExplicitLeft = 8
    end
    inherited lblClientDetails: TLabel
      Left = 8
      HelpContext = 244027
      ExplicitLeft = 8
    end
    inherited SaleDate_Label: TLabel
      Left = 248
      Top = 101
      Width = 105
      HelpContext = 244028
      ExplicitLeft = 248
      ExplicitTop = 101
      ExplicitWidth = 105
    end
    inherited Label160: TLabel
      Left = 652
      Top = 50
      Width = 84
      HelpContext = 244029
      Caption = 'Payment No'
      ExplicitLeft = 652
      ExplicitTop = 50
      ExplicitWidth = 84
    end
    inherited Label43: TLabel
      Left = 492
      Top = 156
      Width = 91
      Height = 15
      HelpContext = 244056
      Alignment = taLeftJustify
      AutoSize = True
      Caption = 'Cheque Number'
      ExplicitLeft = 492
      ExplicitTop = 156
      ExplicitWidth = 91
      ExplicitHeight = 15
    end
    inherited Label79: TLabel
      Left = 458
      Top = 3
      Width = 15
      HelpContext = 244057
      Visible = False
      ExplicitLeft = 458
      ExplicitTop = 3
      ExplicitWidth = 15
    end
    inherited Label45: TLabel
      Left = 479
      Top = 2
      HelpContext = 244058
      Visible = False
      ExplicitLeft = 479
      ExplicitTop = 2
    end
    inherited lblAccount: TLabel
      Left = 8
      HelpContext = 244059
      ExplicitLeft = 8
    end
    inherited Label48: TLabel
      Left = 370
      Top = 156
      Width = 22
      Height = 15
      HelpContext = 244030
      AutoSize = True
      ExplicitLeft = 370
      ExplicitTop = 156
      ExplicitWidth = 22
      ExplicitHeight = 15
    end
    object Label2: TLabel [11]
      Left = 602
      Top = 103
      Width = 73
      Height = 15
      HelpContext = 244067
      Caption = 'Cheque Total'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label66: TLabel [12]
      Left = 616
      Top = 156
      Width = 77
      Height = 15
      HelpContext = 244068
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
    inherited lbMemTrans: TLabel
      HelpContext = 244031
    end
    inherited lblBaseForeignCurrencyCode: TLabel
      Left = 248
      Top = 50
      Width = 105
      HelpContext = 244032
      ExplicitLeft = 248
      ExplicitTop = 50
      ExplicitWidth = 105
    end
    inherited lblEmployeeExpenseClaim: TLabel
      Left = 472
      Top = 46
      HelpContext = 244060
      ExplicitLeft = 472
      ExplicitTop = 46
    end
    inherited lblBaseExchangeRate: TLabel
      Left = 372
      Top = 50
      Width = 89
      HelpContext = 244033
      ExplicitLeft = 372
      ExplicitTop = 50
      ExplicitWidth = 89
    end
    inherited lblArea: TLabel
      Left = 488
      Top = 103
      ExplicitLeft = 488
      ExplicitTop = 103
    end
    inherited lblStatus: TLabel
      Left = 248
      Top = 156
      Width = 105
      ExplicitLeft = 248
      ExplicitTop = 156
      ExplicitWidth = 105
    end
    inherited cboCurrentStatus: TwwDBLookupCombo
      Top = 172
      Width = 116
      ExplicitTop = 172
      ExplicitWidth = 116
    end
    inherited txtClientDetails: TDBMemo
      Left = 8
      Height = 89
      HelpContext = 244036
      TabOrder = 3
      ExplicitLeft = 8
      ExplicitHeight = 89
    end
    inherited cboCreationDate: TwwDBDateTimePicker
      Left = 248
      Top = 119
      Width = 105
      Height = 23
      HelpContext = 244037
      TabOrder = 6
      OnCloseUp = cboCreationDateCloseUp
      ExplicitLeft = 248
      ExplicitTop = 119
      ExplicitWidth = 105
      ExplicitHeight = 23
    end
    inherited txtCustomID: TDBEdit
      Top = 66
      Width = 80
      HelpContext = 244038
      TabStop = False
      TabOrder = 5
      ExplicitTop = 66
      ExplicitWidth = 80
    end
    inherited txtInvNumber: TDBEdit
      Left = 493
      Top = 172
      Width = 116
      HelpContext = 244061
      TabOrder = 13
      ExplicitLeft = 493
      ExplicitTop = 172
      ExplicitWidth = 116
    end
    inherited cboTerms: TwwDBLookupCombo
      Left = 456
      Top = 18
      Width = 33
      HelpContext = 244062
      TabOrder = 19
      Visible = False
      ExplicitLeft = 456
      ExplicitTop = 18
      ExplicitWidth = 33
    end
    inherited cboDueDate: TwwDBDateTimePicker
      Left = 493
      Top = 17
      Width = 41
      HelpContext = 244063
      TabOrder = 23
      Visible = False
      ExplicitLeft = 493
      ExplicitTop = 17
      ExplicitWidth = 41
    end
    inherited cboAccount: TwwDBLookupCombo
      Left = 8
      Width = 203
      HelpContext = 244064
      TabStop = False
      Selected.Strings = (
        'AccountName'#9'30'#9'Account Name'#9'F'
        'Type'#9'20'#9'Type'#9'F')
      TabOrder = 0
      OnEnter = cboAccountEnter
      ExplicitLeft = 8
      ExplicitWidth = 203
    end
    inherited cboEmployee: TwwDBLookupCombo
      Left = 370
      Top = 172
      HelpContext = 244039
      TabOrder = 12
      ExplicitLeft = 370
      ExplicitTop = 172
    end
    inherited btnNext: TDNMSpeedButton
      Left = 743
      Top = 6
      HelpContext = 244040
      Font.Height = -12
      TabOrder = 15
      ExplicitLeft = 743
      ExplicitTop = 6
    end
    inherited btnCompleted: TDNMSpeedButton
      Left = 743
      Top = 37
      HelpContext = 244041
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      TabOrder = 22
      ExplicitLeft = 743
      ExplicitTop = 37
    end
    object txtInvoiceNumber: TDBEdit [32]
      Left = 616
      Top = 172
      Width = 116
      Height = 23
      HelpContext = 244069
      Color = clWhite
      DataField = 'RefNo'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
    end
    object edtChqTotal: TEdit [33]
      Left = 602
      Top = 119
      Width = 121
      Height = 23
      HelpContext = 244070
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      OnExit = edtChqTotalExit
    end
    inherited btnClose: TDNMSpeedButton
      Left = 743
      Top = 68
      HelpContext = 244042
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      TabOrder = 21
      ExplicitLeft = 743
      ExplicitTop = 68
    end
    inherited btnPreview: TDNMSpeedButton
      Left = 743
      Top = 99
      HelpContext = 244043
      Font.Height = -12
      TabOrder = 27
      ExplicitLeft = 743
      ExplicitTop = 99
    end
    inherited btnPrint: TDNMSpeedButton
      Left = 743
      Top = 130
      HelpContext = 244044
      Font.Height = -12
      TabOrder = 29
      ExplicitLeft = 743
      ExplicitTop = 130
    end
    inherited pnlChooseRpt: TDNMPanel
      Left = 476
      Top = 66
      HelpContext = 244045
      TabOrder = 4
      ExplicitLeft = 476
      ExplicitTop = 66
      inherited chkChooseRpt: TCheckBox
        HelpContext = 244047
      end
    end
    inherited btnContacts: TDNMSpeedButton
      Left = 211
      Top = 55
      HelpContext = 244048
      TabOrder = 2
      ExplicitLeft = 211
      ExplicitTop = 55
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo
      Left = 248
      Top = 66
      Width = 105
      HelpContext = 244050
      TabOrder = 10
      ExplicitLeft = 248
      ExplicitTop = 66
      ExplicitWidth = 105
    end
    inherited edtBaseExchangeRate: TwwDBEdit
      Left = 372
      Top = 66
      HelpContext = 244051
      TabOrder = 11
      ExplicitLeft = 372
      ExplicitTop = 66
    end
    inherited pnlTitle: TDNMPanel
      Left = 311
      Top = 4
      Width = 164
      Height = 41
      HelpContext = 244053
      Caption = 'Cheque'
      TabOrder = 20
      ExplicitLeft = 311
      ExplicitTop = 4
      ExplicitWidth = 164
      ExplicitHeight = 41
      inherited TitleShader: TShader
        Width = 162
        Height = 39
        HelpContext = 244054
        ExplicitWidth = 162
        ExplicitHeight = 39
        inherited TitleLabel: TLabel
          Width = 162
          Height = 39
          HelpContext = 244055
          Caption = 'Cheque'
          ExplicitWidth = 162
          ExplicitHeight = 39
        end
      end
    end
    inherited cboClientR: TERPDbLookupCombo
      Left = 8
      Top = 55
      Width = 203
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F')
      DataField = 'SupplierName'
      TabOrder = 1
      OnEnter = cboClientREnter
      ExplicitLeft = 8
      ExplicitTop = 55
      ExplicitWidth = 203
    end
    object btnReconciled: TDNMSpeedButton [43]
      Left = 624
      Top = 19
      Width = 87
      Height = 27
      HelpContext = 244075
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 24
      TabStop = False
      Visible = False
      OnClick = btnReconciledClick
    end
    inherited btnPayments: TDNMSpeedButton
      Left = 531
      Top = 19
      HelpContext = 244074
      TabOrder = 28
      ExplicitLeft = 531
      ExplicitTop = 19
    end
    inherited cmdEmail: TDNMSpeedButton
      Left = 783
      Top = 175
      Width = 43
      ExplicitLeft = 783
      ExplicitTop = 175
      ExplicitWidth = 43
    end
    inherited btnPDF: TDNMSpeedButton
      Left = 743
      Top = 161
      ExplicitLeft = 743
      ExplicitTop = 161
    end
    inherited cboExpenseClaimEmployee: TwwDBLookupCombo
      Left = 530
      Top = 41
      HelpContext = 244065
      TabOrder = 7
      ExplicitLeft = 530
      ExplicitTop = 41
    end
    inherited cboAreaCode: TwwDBLookupCombo
      Left = 488
      Top = 119
      DataSource = DSMaster
      TabOrder = 8
      ExplicitLeft = 488
      ExplicitTop = 119
    end
    object pnlContractorPayment: TDNMPanel
      Left = 372
      Top = 119
      Width = 99
      Height = 34
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 30
      object Label4: TLabel
        Left = 26
        Top = 2
        Width = 68
        Height = 30
        AutoSize = False
        Caption = 'Contractor Payment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object chkContractorPayment: TwwCheckBox
        Left = 6
        Top = 5
        Width = 15
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
        DataField = 'ContractorPayment'
        DataSource = DSMaster
        TabOrder = 0
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 527
    Top = 325
  end
  inherited tmrdelay: TTimer
    Left = 564
    Top = 325
  end
  inherited cboViaQry: TERPQuery
    Left = 186
    Top = 290
  end
  inherited popSpelling: TPopupMenu
    Left = 122
    Top = 325
  end
  inherited tmrdelayMsg: TTimer
    Left = 85
    Top = 325
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 196
    Top = 325
  end
  inherited DSDetails: TDataSource
    Left = 48
    Top = 325
  end
  inherited DSMaster: TDataSource
    Left = 12
    Top = 325
  end
  inherited lsTDNMSpeedButtonActions: TActionList
    Left = 380
    Top = 325
    object actSignature: TAction
      Caption = 'Signature'
      OnExecute = actSignatureExecute
      OnUpdate = actSignatureUpdate
    end
  end
  inherited popDscntMrkup: TAdvPopupMenu
    Left = 638
    Top = 325
  end
  inherited popMemTrans: TAdvPopupMenu
    Left = 675
    Top = 325
  end
  inherited tblMaster: TERPQuery
    Left = 13
    Top = 290
    object tblMasterIsRefundCheque: TWideStringField
      FieldName = 'IsRefundCheque'
      FixedChar = True
      Size = 1
    end
    object tblMasterRefundGlobalref: TWideStringField
      FieldName = 'RefundGlobalref'
      Size = 255
    end
    object tblMasterSignature: TBlobField
      FieldName = 'Signature'
    end
    object tblMasterSignatureTime: TDateTimeField
      FieldName = 'SignatureTime'
    end
    object tblMasterContractorPayment: TWideStringField
      FieldName = 'ContractorPayment'
      FixedChar = True
      Size = 1
    end
  end
  inherited tblDetails: TERPQuery
    Left = 47
    Top = 290
    inherited tblDetailsAccountNumber: TWideStringField
      Origin = 'tblpurchaselines.AccountNumber'
    end
    inherited tblDetailsAccountName: TWideStringField
      Origin = 'tblpurchaselines.AccountName'
    end
    inherited tblDetailsLineCost: TFloatField [2]
      DisplayWidth = 15
      Origin = 'tblpurchaselines.LineCost'
    end
    inherited tblDetailsLineTaxCode: TWideStringField [3]
      Origin = 'tblpurchaselines.LineTaxCode'
    end
    inherited tblDetailsLineTax: TFloatField
      Origin = 'tblpurchaselines.LineTax'
      DisplayFormat = '$,##0.00###;($,##0.00###)'
    end
    inherited tblDetailsProduct_Description: TWideStringField
      Origin = 'tblpurchaselines.Product_Description'
    end
    inherited tblDetailsCustomerJob: TWideStringField
      DisplayLabel = 'Customer / Job'
      Origin = 'tblpurchaselines.CustomerJob'
    end
    inherited tblDetailsClass: TWideStringField
      Origin = 'tblpurchaselines.Class'
    end
    inherited tblDetailsRelatedPOID: TIntegerField
      Origin = 'tblpurchaselines.RelatedPOID'
    end
    inherited tblDetailsEmployeeName: TWideStringField [12]
      DisplayLabel = 'Employee'
      DisplayWidth = 20
    end
    inherited tblDetailsAreaCode: TWideStringField [13]
    end
    inherited tblDetailsRepairDocNo: TStringField [14]
    end
    inherited tblDetailsExpenseProductSelected: TStringField [15]
    end
    inherited tblDetailsSEQNo: TIntegerField [16]
    end
    inherited tblDetailsRepairId: TIntegerField [17]
    end
    inherited tblDetailsCustomerEquipmentID: TIntegerField [18]
    end
    inherited tblDetailsLandedCostsPercentage: TFloatField [19]
      Origin = 'tblpurchaselines.LandedCostsPercentage'
    end
    inherited tblDetailsForeignExchangeCode: TWideStringField [20]
      Origin = 'tblpurchaselines.ForeignExchangeCode'
    end
    inherited tblDetailsUnitOfMeasureID: TIntegerField [21]
      Origin = 'tblpurchaselines.UnitOfMeasureID'
    end
    inherited tblDetailsSearchFilterCopy: TWideStringField [22]
      Origin = 'tblpurchaselines.SearchFilterCopy'
    end
    inherited tblDetailsLandedCostsTotal: TFloatField [23]
      Origin = 'tblpurchaselines.LandedCostsTotal'
    end
    inherited tblDetailsNewForeignExchangeRate: TFloatField [24]
      Origin = 'tblpurchaselines.NewForeignExchangeRate'
    end
    inherited tblDetailsSearchFilter: TWideStringField [25]
      Origin = 'tblpurchaselines.SearchFilter'
    end
    inherited tblDetailsCogsAccnt: TWideStringField [26]
      Origin = 'tblpurchaselines.COGSACCNT'
    end
    inherited tblDetailsLineCostInc: TFloatField [27]
      Origin = 'tblpurchaselines.LineCostInc'
    end
    inherited tblDetailsQtySold: TFloatField [28]
      Origin = 'tblpurchaselines.QtySold'
    end
    inherited tblDetailsForeignExchangeRate: TFloatField [29]
      Origin = 'tblpurchaselines.ForeignExchangeRate'
    end
    inherited tblDetailsAttrib1PurchaseRate: TFloatField [30]
      Origin = 'tblpurchaselines.Attrib1PurchaseRate'
    end
    inherited tblDetailsShipped: TFloatField [31]
      Origin = 'tblpurchaselines.Shipped'
    end
    inherited tblDetailsUnitofMeasureBackorder: TFloatField [32]
      Origin = 'tblpurchaselines.UnitofMeasureBackorder'
    end
    inherited tblDetailsProductName: TWideStringField [33]
      Origin = 'tblpurchaselines.ProductName'
    end
    inherited tblDetailsPurchaseOrderID: TIntegerField [34]
      Origin = 'tblpurchaselines.PurchaseOrderID'
    end
    inherited tblDetailsUnitofMeasureMultiplier: TFloatField [35]
      Origin = 'tblpurchaselines.UnitofMeasureMultiplier'
    end
    inherited tblDetailsCOGSTotalLineAmount: TFloatField [36]
      Origin = 'tblpurchaselines.COGSTotalLineAmount'
    end
    inherited tblDetailsDeleted: TWideStringField [37]
      Origin = 'tblpurchaselines.Deleted'
    end
    inherited tblDetailsUnitofMeasurePOLines: TWideStringField [38]
      Origin = 'tblpurchaselines.UnitofMeasurePOLines'
    end
    inherited tblDetailsLastLineID: TIntegerField [39]
      Origin = 'tblpurchaselines.LastLineID'
    end
    inherited tblDetailsBackOrder: TFloatField [40]
      Origin = 'tblpurchaselines.BackOrder'
    end
    inherited tblDetailsLineTaxRate: TFloatField [41]
      Origin = 'tblpurchaselines.LineTaxRate'
    end
    inherited tblDetailsReceivedDate: TDateField [42]
      Origin = 'tblpurchaselines.ReceivedDate'
    end
    inherited tblDetailsLandedCostsPerItem: TFloatField [43]
      Origin = 'tblpurchaselines.LandedCostsPerItem'
    end
    inherited tblDetailsTimecostMarkupDol: TFloatField [44]
      Origin = 'tblpurchaselines.TimecostMarkupDol'
    end
    inherited tblDetailsRelatedPOIDUsed: TWideStringField [45]
      Origin = 'tblpurchaselines.RelatedPOIDUsed'
    end
    inherited tblDetailsCalcTotalInc: TCurrencyField [46]
    end
    inherited tblDetailsRAInvoiceNo: TWideStringField [47]
      Origin = 'tblpurchaselines.RAInvoiceNo'
    end
    inherited tblDetailsTotalLineAmount: TFloatField [48]
      Origin = 'tblpurchaselines.TotalLineAmount'
    end
    inherited tblDetailsInvoiced: TWideStringField [49]
      Origin = 'tblpurchaselines.Invoiced'
    end
    inherited tblDetailsProductGroup: TWideStringField [50]
      Origin = 'tblpurchaselines.ProductGroup'
    end
    inherited tblDetailsEditedFlag: TWideStringField [51]
      Origin = 'tblpurchaselines.EditedFlag'
    end
    inherited tblDetailsTotalLineAmountInc: TFloatField [52]
      Origin = 'tblpurchaselines.TotalLineAmountInc'
    end
    inherited tblDetailsTimecostMarkupPer: TFloatField [53]
      Origin = 'tblpurchaselines.TimecostMarkupPer'
    end
    inherited tblDetailsCalcPriceInc: TCurrencyField [54]
    end
    inherited tblDetailsSaleID_Timecost: TIntegerField [55]
      Origin = 'tblpurchaselines.SaleID_Timecost'
    end
    inherited tblDetailsBatch: TWideStringField [56]
      Origin = 'tblpurchaselines.Batch'
    end
    inherited tblDetailsAccountGroup: TWideStringField [57]
      Origin = 'tblpurchaselines.AccountGroup'
    end
    inherited tblDetailsRAstatus: TWideStringField [58]
      Origin = 'tblpurchaselines.RAstatus'
      Size = 255
    end
    inherited tblDetailsClassID: TIntegerField [59]
      Origin = 'tblpurchaselines.ClassID'
    end
    inherited tblDetailsUseTimecost: TWideStringField [60]
      Origin = 'tblpurchaselines.UseTimecost'
    end
    inherited tblDetailsGlobalRef: TWideStringField [61]
      Origin = 'tblpurchaselines.GlobalRef'
    end
    inherited tblDetailsPurchaseLineID: TAutoIncField [62]
      AutoGenerateValue = arAutoInc
      Origin = 'tblpurchaselines.PurchaseLineID'
    end
    inherited tblDetailsTimecostPrice: TFloatField [63]
      Origin = 'tblpurchaselines.TimecostPrice'
    end
    inherited tblDetailsRAQty: TFloatField [64]
      Origin = 'tblpurchaselines.RAQty'
    end
    inherited tblDetailsEmployeeID: TIntegerField [65]
      Visible = False
    end
    inherited tblDetailsCOGSTotalLineAmountInc: TFloatField [66]
      Origin = 'tblpurchaselines.COGSTotalLineAmountInc'
    end
    inherited tblDetailsAvgCost: TFloatField [67]
      Origin = 'tblpurchaselines.AvgCost'
    end
    inherited tblDetailsIncomeAccnt: TWideStringField [68]
      Origin = 'tblpurchaselines.INCOMEACCNT'
    end
    inherited tblDetailsPartType: TWideStringField [69]
      Origin = 'tblpurchaselines.PARTTYPE'
    end
    inherited tblDetailsUnitofMeasureQtySold: TFloatField [70]
      Origin = 'tblpurchaselines.UnitofMeasureQtySold'
    end
    inherited tblDetailsAttrib2Purchase: TFloatField [71]
      Origin = 'tblpurchaselines.Attrib2Purchase'
    end
    inherited tblDetailsCalcTotalEx: TCurrencyField [72]
    end
    inherited tblDetailsCalcTax: TCurrencyField [73]
    end
    inherited tblDetailsAssetAccnt: TWideStringField [74]
      Origin = 'tblpurchaselines.ASSETACCNT'
    end
    inherited tblDetailsForeignCurrencyLineCost: TFloatField [75]
      Origin = 'tblpurchaselines.ForeignCurrencyLineCost'
    end
    inherited tblDetailsAttrib1Purchase: TFloatField [76]
      Origin = 'tblpurchaselines.Attrib1Purchase'
    end
    inherited tblDetailsForeignTotalLineAmount: TFloatField [77]
      Origin = 'tblpurchaselines.ForeignTotalLineAmount'
    end
    inherited tblDetailsUnitofMeasureShipped: TFloatField [78]
      Origin = 'tblpurchaselines.UnitofMeasureShipped'
    end
    inherited tblDetailsCustomerJobID: TIntegerField [79]
      Origin = 'tblpurchaselines.CustomerJobID'
    end
    inherited tblDetailsserialno: TWideMemoField [80]
      Origin = 'tblpurchaselines.serialno'
    end
    inherited tblDetailsProductID: TIntegerField [81]
      Origin = 'tblpurchaselines.ProductID'
    end
  end
  inherited cboClientLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClientID, Company, '
      'Street, Street2, Street3, Suburb, State, Country, Postcode,'
      
        'BillStreet, BillStreet2, BillStreet3, BillSuburb, BillState, Bil' +
        'lPostcode,BillCountry,'
      
        'TERMS, TermsID, ShippingMethod, ShippingID, RepID, ForeignExchan' +
        'geSellCode'
      'FROM tblclients'
      'WHERE Supplier = '#39'T'#39' '
      'AND tblclients.ClientID= :xClientID'
      'Order By Company')
    Left = 82
    Top = 290
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
  end
  inherited cboEmployeeLookup: TERPQuery
    Left = 116
    Top = 290
  end
  inherited cboClassQry: TERPQuery
    Left = 151
    Top = 290
  end
  inherited qryBaseForeignCurrency: TERPQuery
    Left = 635
    Top = 290
  end
  inherited qryClientLookup: TERPQuery
    Left = 736
    Top = 288
  end
  inherited imgPopup: TImageList
    Left = 343
    Top = 325
    Bitmap = {
      494C01010200A800EC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited ProgDialog: TProgressDialog
    Left = 601
    Top = 325
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 306
    Top = 325
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Top = 263
  end
  inherited DataState: TDataState
    Left = 233
    Top = 325
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 490
    Top = 325
  end
  inherited imgsort: TImageList
    Left = 269
    Top = 325
    Bitmap = {
      494C01010200AC00F00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited cboTermsQry: TERPQuery
    Left = 359
    Top = 290
  end
  inherited cboAccountQry: TERPQuery
    SQL.Strings = (
      
        'SELECT tblchartofaccounts.AccountType,tblchartofaccounts.Account' +
        'ID, tblchartofaccounts.AccountName, tblchartofaccounts.AccountGr' +
        'oup, tblacctypedesc.AccDesc AS Type, tblchartofaccounts.Descript' +
        'ion, tblchartofaccounts.Taxcode, tblchartofaccounts.Active'
      'FROM tblchartofaccounts '
      
        'LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType = tblchartofa' +
        'ccounts.AccountType'
      
        'WHERE  Active='#39'T'#39' AND AccountType <> '#39'AR'#39' AND AccountType <> '#39'AP' +
        #39' '
      'Order By tblacctypedesc.AccDesc,tblchartofaccounts.AccountName;')
    Left = 289
    Top = 290
  end
  inherited cboAccountLinesQry: TERPQuery
    SQL.Strings = (
      'SELECT'
      
        'Concat(If( char_length(Level4)>0,Space(15), If( char_length(Leve' +
        'l3)>0,Space(10),If( char_length(Level2)>0,Space(5),Space(0)))),A' +
        'ccountName) as AccountTree,'
      
        'SUBSTRING(If((char_length(tblChartofAccounts.AccountGroup)>0),Co' +
        'ncat(REPLACE(tblChartofAccounts.AccountGroup,"^"," - ")," - ",tb' +
        'lChartofAccounts.AccountName),tblChartofAccounts.AccountName),1,' +
        '255) as FullAccountName,'
      'tblChartofAccounts.AccountName,'
      'tblChartofAccounts.AccountID,'
      'tblChartofAccounts.AccountNumber,'
      'tblChartofAccounts.AccountGroup,'
      'tblacctypedesc.AccDesc AS Type,'
      'tblChartofAccounts.Description,'
      'tblChartofAccounts.Taxcode,'
      'tblChartofAccounts.Active'
      'FROM tblChartofAccounts'
      
        'LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType = tblChartofA' +
        'ccounts.AccountType'
      'WHERE tblChartofAccounts.Active = '#39'T'#39' and IsHeader = '#39'F'#39
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((AccountName LIKE Concat(:SearchValue' +
        ',"%")) or (tblacctypedesc.AccDesc LIKE Concat(:SearchValue,"%"))' +
        ' or (tblacctypedesc.AccDesc LIKE Concat(:SearchValue,"%"))) )'
      
        'or ((:SearchMode = 2) and ((AccountName LIKE Concat("%",:SearchV' +
        'alue,"%")) or (tblacctypedesc.AccDesc LIKE Concat("%",:SearchVal' +
        'ue,"%")) or (tblacctypedesc.AccDesc LIKE Concat("%",:SearchValue' +
        ',"%")))))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY AccountName')
    Left = 220
    Top = 290
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    inherited cboAccountLinesQryType: TWideStringField
      DisplayWidth = 20
    end
    inherited cboAccountLinesQryDescription: TWideStringField
      DisplayWidth = 30
    end
  end
  inherited cboAccountNoLineQuery: TERPQuery
    Left = 255
    Top = 290
  end
  inherited qryCustomerJob: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, JobNumber, DefaultClass, '
      'Street, Street2, Suburb, State, Country, Postcode,'
      'BillStreet, BillStreet2, BillSuburb, BillState, BillPostcode,'
      'TERMS, ShippingMethod, ShippingID, ShipTime'
      'FROM tblclients'
      'WHERE Active = '#39'T'#39
      'And Customer = '#39'T'#39' '
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((Company LIKE Concat(:SearchValue,"%"' +
        ')) or (JobNumber LIKE Concat(:SearchValue,"%")) ))'
      
        'or ((:SearchMode = 2) and ((Company LIKE Concat("%",:SearchValue' +
        ',"%")) or (JobNumber LIKE Concat("%",:SearchValue,"%")) )))'
      'and IfNull(:SearchValue,"") <> ""'
      'Order By Company;')
    Left = 462
    Top = 290
  end
  inherited QryTransStatus: TERPQuery
    Top = 290
  end
  inherited qryRepairEquip: TERPQuery
    Left = 428
    Top = 290
  end
  inherited qryRepairLookup: TERPQuery
    Left = 601
    Top = 290
  end
  inherited qryEmployeeLookup: TERPQuery
    Left = 324
    Top = 290
  end
  inherited QryAreaCodes: TERPQuery
    Left = 566
    Top = 290
  end
  inherited QryAreaCodeLk: TERPQuery
    Left = 670
    Top = 290
  end
  inherited cbTaxCodeQry: TERPQuery
    Left = 393
    Top = 290
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 159
    Top = 325
  end
  inherited SaveDialog1: TSaveDialog
    Left = 454
    Top = 325
  end
  inherited qryMemTrans: TERPQuery
    Left = 497
    Top = 290
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 417
    Top = 325
  end
  inherited QryCustomField: TERPQuery
    Left = 770
    Top = 288
  end
  inherited qryImportedPOIDs: TERPQuery
    Left = 532
    Top = 290
  end
end
