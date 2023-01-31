inherited RefundGUI: TRefundGUI
  Left = 491
  Top = 142
  HelpContext = 464000
  Caption = 'Refund'
  ClientHeight = 564
  ExplicitLeft = 491
  ExplicitTop = 142
  ExplicitHeight = 603
  DesignSize = (
    827
    564)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 443
    ExplicitTop = 564
  end
  inherited imgGridWatermark: TImage
    HelpContext = 464001
  end
  inherited pnlDetail: TDNMPanel
    Top = 242
    Height = 201
    HelpContext = 464076
    Align = alClient
    OnEnter = pnlDetailEnter
    ExplicitTop = 242
    ExplicitHeight = 201
    inherited grdTransactions: TwwDBGrid
      Height = 201
      HelpContext = 464078
      Selected.Strings = (
        'PartBarcode'#9'10'#9'Barcode'#9#9
        'ProductName'#9'20'#9'Name'#9#9
        'RefundQty'#9'10'#9'Refund Qty'#9#9
        'UnitofMeasureSaleLines'#9'10'#9'UOM'#9#9
        'PQA'#9'1'#9'Allocation'#9#9
        'Product_Description'#9'20'#9'Description'#9#9
        'CalcGrossProfitPercentInc'#9'10'#9'CalcGrossProfitPercentInc'#9#9
        'LatestCostPriceInc'#9'10'#9'LatestCostPriceInc'#9#9
        'LinePriceInc'#9'10'#9'Amount (Inc)'#9#9
        'LineTaxCode'#9'5'#9'Code'#9#9
        'LineTax'#9'10'#9'Tax'#9#9
        'Discounts'#9'8'#9'Discounts'#9#9
        'TotalLineAmountInc'#9'10'#9'Line Total Inc'#9#9
        'MatrixDesc'#9'10'#9'Matrix Details'#9#9
        'MatrixPrice'#9'10'#9'Matrix Price'#9#9
        'Area'#9'20'#9'Area'#9#9
        'RefundedSalesLineID'#9'10'#9'RefundedSalesLineID'#9#9)
      MemoAttributes = [mSizeable, mWordWrap, mGridShow]
      ExplicitHeight = 201
    end
    inherited cboProductR: TERPDbLookupCombo
      OnNotInList = nil
    end
  end
  inherited pnlFooter: TDNMPanel
    Top = 443
    Height = 121
    HelpContext = 464002
    Align = alBottom
    ExplicitTop = 443
    ExplicitHeight = 121
    DesignSize = (
      827
      121)
    inherited lblComments: TLabel
      Left = 6
      Top = 7
      HelpContext = 464004
      ExplicitLeft = 6
      ExplicitTop = 0
    end
    inherited Label142: TLabel
      Top = 40
      HelpContext = 464005
      ExplicitTop = 33
    end
    inherited Label54: TLabel
      Top = 67
      HelpContext = 464006
      ExplicitTop = 60
    end
    inherited Label56: TLabel
      Top = 95
      HelpContext = 464007
      ExplicitTop = 88
    end
    inherited lblBaseForeignTotal: TLabel
      Left = 410
      Top = 95
      HelpContext = 464011
      ExplicitLeft = 410
      ExplicitTop = 88
    end
    inherited Label122: TLabel
      Left = 398
      Top = 67
      HelpContext = 464018
      ExplicitLeft = 398
      ExplicitTop = 60
    end
    inherited Label3: TLabel
      Left = 398
      Top = 40
      HelpContext = 464019
      ExplicitLeft = 398
      ExplicitTop = 33
    end
    inherited pnlComments: TDNMPanel
      Width = 173
      Height = 117
      HelpContext = 464089
      TabOrder = 11
      ExplicitWidth = 173
      ExplicitHeight = 117
      inherited LblCommentsHint: TLabel
        Top = 82
        Width = 171
        Height = 34
        HelpContext = 464090
        ExplicitLeft = 1
        ExplicitTop = 83
        ExplicitWidth = 171
        ExplicitHeight = 34
      end
      inherited txtComments: TDBMemo
        Width = 171
        Height = 81
        HelpContext = 464013
        ExplicitWidth = 171
        ExplicitHeight = 81
      end
    end
    inherited txtSubTotal: TDBEdit
      Top = 37
      HelpContext = 464014
      TabOrder = 3
      ExplicitTop = 37
    end
    inherited txtTotalTax: TDBEdit
      Top = 64
      HelpContext = 464015
      TabOrder = 4
      ExplicitTop = 64
    end
    inherited txtTotalAmount: TDBEdit
      Top = 91
      HelpContext = 464016
      TabOrder = 7
      ExplicitTop = 91
    end
    inherited edtBaseForeignTotal: TDBEdit
      Left = 490
      Top = 92
      HelpContext = 464017
      TabOrder = 2
      ExplicitLeft = 490
      ExplicitTop = 92
    end
    inherited lblDisableCalc: TDNMSpeedButton
      Left = 640
      Top = 1
      TabOrder = 9
      ExplicitLeft = 640
      ExplicitTop = 1
    end
    inherited DNMPanel5: TDNMPanel
      Left = 248
      Top = 6
      HelpContext = 464091
      Anchors = [akTop, akRight]
      TabOrder = 5
      ExplicitLeft = 248
      ExplicitTop = 6
      inherited lblEnteredbyHead: TLabel
        Left = 6
        Top = 1
        ExplicitLeft = 6
        ExplicitTop = 1
      end
      inherited lblEnteredBy: TDBText
        Left = 74
        Top = 1
        ExplicitLeft = 74
        ExplicitTop = 1
      end
      inherited lblPrintHead: TLabel
        Left = 6
        Top = 22
        ExplicitLeft = 6
        ExplicitTop = 22
      end
      inherited lblPrintedBy: TLabel
        Left = 74
        Top = 22
        ExplicitLeft = 74
        ExplicitTop = 22
      end
      inherited lblPrintedOnCaption: TLabel
        Left = 6
        Top = 44
        ExplicitLeft = 6
        ExplicitTop = 44
      end
      inherited lblPrintedOn: TLabel
        Left = 74
        Top = 44
        ExplicitLeft = 74
        ExplicitTop = 44
      end
      inherited lblPrintedAtCaption: TLabel
        Left = 6
        Top = 65
        ExplicitLeft = 6
        ExplicitTop = 65
      end
      inherited lblPrintedAt: TLabel
        Left = 74
        Top = 65
        ExplicitLeft = 74
        ExplicitTop = 65
      end
      inherited lblEnteredAtHead: TLabel
        Left = 6
        Top = 87
        ExplicitLeft = 6
        ExplicitTop = 87
      end
      inherited lblEnteredAt: TDBText
        Left = 74
        Top = 87
        ExplicitLeft = 74
        ExplicitTop = 87
      end
    end
    inherited lblEmail: TDNMPanel
      Left = 513
      Top = 1
      HelpContext = 464092
      TabOrder = 6
      ExplicitLeft = 513
      ExplicitTop = 1
    end
    inherited txtTotalDiscount: TDBEdit [15]
      Left = 490
      Top = 37
      HelpContext = 464022
      TabOrder = 0
      ExplicitLeft = 490
      ExplicitTop = 37
    end
    inherited txtTotalMarkup: TDBEdit [16]
      Left = 490
      Top = 64
      HelpContext = 464023
      TabOrder = 1
      ExplicitLeft = 490
      ExplicitTop = 64
    end
    object btnSignature: TDNMSpeedButton [17]
      Left = 2
      Top = 31
      Width = 65
      Height = 22
      HelpContext = 464093
      Action = actSignature
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
      TabOrder = 10
      AutoDisableParentOnclick = True
    end
    inherited pnlProcessMessage: TDNMPanel [18]
      HelpContext = 464094
      inherited lblProcessMessage: TLabel
        HelpContext = 464077
        ExplicitLeft = 160
        ExplicitWidth = 665
      end
    end
  end
  inherited pnlHeader: TDNMPanel
    Height = 242
    HelpContext = 464027
    ParentColor = True
    ExplicitHeight = 242
    DesignSize = (
      827
      242)
    object bvelFX: TBevel [0]
      Left = 240
      Top = 141
      Width = 242
      Height = 55
      HelpContext = 464079
      Shape = bsFrame
      Visible = False
    end
    object Bevel3: TBevel [1]
      Left = 285
      Top = 59
      Width = 161
      Height = 51
      HelpContext = 464080
      Shape = bsFrame
    end
    inherited Bevel2: TBevel
      Left = 198
      Top = 59
      Width = 9
      Height = 22
      HelpContext = 464063
      Visible = False
      ExplicitLeft = 198
      ExplicitTop = 59
      ExplicitWidth = 9
      ExplicitHeight = 22
    end
    inherited Bevel1: TBevel
      Left = 488
      Top = 94
      Height = 101
      HelpContext = 464058
      ExplicitLeft = 488
      ExplicitTop = 94
      ExplicitHeight = 101
    end
    inherited lblStatus: TLabel
      Left = 206
      Top = 203
      Width = 37
      HelpContext = 464081
      AutoSize = True
      ExplicitLeft = 206
      ExplicitTop = 203
      ExplicitWidth = 37
    end
    inherited Label38: TLabel
      Left = 8
      HelpContext = 464028
      ExplicitLeft = 8
    end
    inherited lblClientDetails: TLabel
      Left = 9
      Top = 88
      HelpContext = 464029
      Caption = 'Refund To'
      ExplicitLeft = 9
      ExplicitTop = 88
    end
    inherited SaleDate_Label: TLabel
      Left = 488
      Top = 45
      HelpContext = 464030
      ExplicitLeft = 488
      ExplicitTop = 45
    end
    inherited Label160: TLabel
      Left = 643
      Top = 44
      HelpContext = 464031
      ExplicitLeft = 643
      ExplicitTop = 44
    end
    inherited ClassLabel: TLabel
      Left = 293
      Top = 62
      HelpContext = 464059
      ExplicitLeft = 293
      ExplicitTop = 62
    end
    inherited Label43: TLabel
      Left = 504
      Top = 147
      HelpContext = 464060
      ExplicitLeft = 504
      ExplicitTop = 147
    end
    inherited lblAccount: TLabel
      Left = 9
      Top = -2
      HelpContext = 464061
      ExplicitLeft = 9
      ExplicitTop = -2
    end
    inherited lblPaymentMethod: TLabel
      Left = 504
      Top = 102
      Height = 15
      HelpContext = 464062
      ExplicitLeft = 504
      ExplicitTop = 102
      ExplicitHeight = 15
    end
    inherited Label48: TLabel
      Left = 7
      Top = 203
      Width = 55
      Height = 15
      HelpContext = 464032
      AutoSize = True
      Caption = 'Employee'
      ExplicitLeft = 7
      ExplicitTop = 203
      ExplicitWidth = 55
      ExplicitHeight = 15
    end
    inherited lblInvoice: TLabel
      Left = 648
      Top = 102
      HelpContext = 464064
      Visible = True
      ExplicitLeft = 648
      ExplicitTop = 102
    end
    inherited lbMemTrans: TLabel
      HelpContext = 464033
    end
    inherited Label79: TLabel
      Left = 405
      Top = 203
      Width = 36
      Height = 15
      HelpContext = 464065
      AutoSize = True
      Visible = True
      ExplicitLeft = 405
      ExplicitTop = 203
      ExplicitWidth = 36
      ExplicitHeight = 15
    end
    inherited Label45: TLabel
      Left = 605
      Top = 203
      Width = 51
      Height = 15
      HelpContext = 464066
      AutoSize = True
      Visible = True
      ExplicitLeft = 605
      ExplicitTop = 203
      ExplicitWidth = 51
      ExplicitHeight = 15
    end
    inherited lblBaseForeignCurrencyCode: TLabel
      Left = 245
      Top = 150
      Width = 84
      Height = 15
      HelpContext = 464034
      AutoSize = True
      Visible = True
      ExplicitLeft = 245
      ExplicitTop = 150
      ExplicitWidth = 84
      ExplicitHeight = 15
    end
    inherited lblBaseExchangeRate: TLabel
      Left = 370
      Top = 150
      Width = 85
      Height = 15
      HelpContext = 464035
      AutoSize = True
      Visible = True
      ExplicitLeft = 370
      ExplicitTop = 150
      ExplicitWidth = 85
      ExplicitHeight = 15
    end
    inherited Label4: TLabel
      Left = 527
      Top = 203
      Visible = False
      ExplicitLeft = 527
      ExplicitTop = 203
    end
    inherited txtClientDetails: TDBMemo [23]
      Left = 7
      Top = 103
      HelpContext = 464038
      TabOrder = 3
      ExplicitLeft = 7
      ExplicitTop = 103
    end
    inherited cboCreationDate: TwwDBDateTimePicker [24]
      Left = 488
      Top = 60
      Height = 23
      HelpContext = 464039
      TabOrder = 6
      ExplicitLeft = 488
      ExplicitTop = 60
      ExplicitHeight = 23
    end
    inherited cboClass: TwwDBLookupCombo [25]
      Left = 293
      Top = 77
      Width = 142
      HelpContext = 464067
      TabOrder = 4
      ExplicitLeft = 293
      ExplicitTop = 77
      ExplicitWidth = 142
    end
    inherited txtPONumber: TDBEdit [26]
      Left = 504
      Top = 163
      HelpContext = 464068
      TabOrder = 14
      ExplicitLeft = 504
      ExplicitTop = 163
    end
    inherited cboAccount: TwwDBLookupCombo [27]
      Left = 7
      HelpContext = 464069
      TabOrder = 0
      ExplicitLeft = 7
    end
    inherited txtCustomID: TDBEdit [28]
      Left = 643
      Top = 60
      HelpContext = 464040
      TabOrder = 7
      ExplicitLeft = 643
      ExplicitTop = 60
    end
    inherited cboEmployee: TwwDBLookupCombo [29]
      Left = 7
      Top = 217
      HelpContext = 464041
      TabOrder = 8
      ExplicitLeft = 7
      ExplicitTop = 217
    end
    inherited btnNext: TDNMSpeedButton [30]
      Left = 731
      Top = 22
      HelpContext = 464042
      Caption = '&New'
      Font.Height = -12
      TabOrder = 17
      ExplicitLeft = 731
      ExplicitTop = 22
    end
    inherited btnCompleted: TDNMSpeedButton [31]
      Left = 731
      Top = 65
      HelpContext = 464043
      Caption = '&Save'
      Font.Height = -12
      TabOrder = 30
      ExplicitLeft = 731
      ExplicitTop = 65
    end
    inherited btnClose: TDNMSpeedButton [32]
      Left = 731
      Top = 109
      HelpContext = 464044
      Font.Height = -12
      TabOrder = 22
      ExplicitLeft = 731
      ExplicitTop = 109
    end
    inherited btnPreview: TDNMSpeedButton [33]
      Left = 731
      Top = 153
      HelpContext = 464045
      Font.Height = -12
      TabOrder = 19
      ExplicitLeft = 731
      ExplicitTop = 153
    end
    inherited btnPrint: TDNMSpeedButton [34]
      Left = 731
      Top = 197
      HelpContext = 464046
      Action = nil
      Caption = 'Prin&t'
      Font.Height = -12
      TabOrder = 20
      OnClick = btnPrintClick
      ExplicitLeft = 731
      ExplicitTop = 197
    end
    inherited pnlChooseRpt: TDNMPanel [35]
      Left = 285
      Top = 113
      HelpContext = 464047
      TabOrder = 5
      ExplicitLeft = 285
      ExplicitTop = 113
      inherited chkChooseRpt: TCheckBox
        HelpContext = 464049
      end
    end
    inherited btnContacts: TDNMSpeedButton [36]
      Left = 207
      Top = 59
      HelpContext = 464050
      TabOrder = 2
      ExplicitLeft = 207
      ExplicitTop = 59
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo [37]
      Left = 245
      Top = 166
      Width = 107
      HelpContext = 464052
      TabOrder = 12
      Visible = True
      ExplicitLeft = 245
      ExplicitTop = 166
      ExplicitWidth = 107
    end
    inherited edtBaseExchangeRate: TwwDBEdit [38]
      Left = 370
      Top = 166
      Width = 107
      HelpContext = 464053
      TabOrder = 31
      Visible = True
      ExplicitLeft = 370
      ExplicitTop = 166
      ExplicitWidth = 107
    end
    inherited pnlTitle: TDNMPanel [39]
      Left = 328
      Width = 170
      Height = 43
      HelpContext = 464055
      Caption = 'REFUND'
      TabOrder = 21
      ExplicitLeft = 328
      ExplicitWidth = 170
      ExplicitHeight = 43
      inherited TitleShader: TShader
        Width = 168
        Height = 41
        HelpContext = 464056
        ExplicitWidth = 168
        ExplicitHeight = 41
        inherited TitleLabel: TLabel
          Width = 168
          Height = 41
          HelpContext = 464057
          Caption = 'Refund'
          ExplicitWidth = 168
          ExplicitHeight = 41
        end
      end
    end
    inherited cboPaymentMethod: TwwDBLookupCombo [40]
      Left = 504
      Top = 121
      HelpContext = 464070
      Enabled = False
      TabOrder = 13
      ExplicitLeft = 504
      ExplicitTop = 121
    end
    inherited btnSplit: TDNMSpeedButton [41]
      Left = 626
      Top = 119
      HelpContext = 464071
      TabOrder = 15
      ExplicitLeft = 626
      ExplicitTop = 119
    end
    inherited chkInvoice: TCheckBox [42]
      Left = 629
      Top = 102
      Height = 15
      HelpContext = 464072
      Enabled = True
      TabOrder = 11
      Visible = True
      OnClick = chkInvoiceClick
      ExplicitLeft = 629
      ExplicitTop = 102
      ExplicitHeight = 15
    end
    inherited cboTerms: TwwDBLookupCombo [43]
      Left = 405
      Top = 217
      Width = 116
      HelpContext = 464073
      TabOrder = 9
      Visible = True
      ExplicitLeft = 405
      ExplicitTop = 217
      ExplicitWidth = 116
    end
    inherited cboDueDate: TwwDBDateTimePicker [44]
      Left = 605
      Top = 217
      Width = 116
      HelpContext = 464074
      TabOrder = 10
      Visible = True
      ExplicitLeft = 605
      ExplicitTop = 217
      ExplicitWidth = 116
    end
    inherited btnCashDrawer: TDNMSpeedButton [45]
      Left = 625
      Top = 161
      HelpContext = 464075
      TabOrder = 16
      ExplicitLeft = 625
      ExplicitTop = 161
    end
    inherited btnDeposit: TDNMSpeedButton [46]
      Left = 510
      OnClick = btnDepositClick
      ExplicitLeft = 510
    end
    inherited wwDBDateTimePicker1: TwwDBDateTimePicker [47]
      Left = 527
      Top = 217
      Width = 53
      HelpContext = 464082
      TabOrder = 25
      Visible = False
      ExplicitLeft = 527
      ExplicitTop = 217
      ExplicitWidth = 53
    end
    object cmdFax: TDNMSpeedButton [48]
      Left = 439
      Top = 250
      Width = 43
      Height = 27
      HelpContext = 464026
      Anchors = [akTop, akRight]
      Caption = '&Fax'
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
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = cmdFaxClick
    end
    inherited cboClientR: TERPDbLookupCombo [49]
      Left = 7
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F')
      TabOrder = 1
      ExplicitLeft = 7
    end
    inherited btnEdit: TDNMSpeedButton [50]
      Left = 488
      Top = 250
      TabOrder = 28
      ExplicitLeft = 488
      ExplicitTop = 250
    end
    inherited cmdEmail: TDNMSpeedButton [51]
      Left = 606
      Top = 250
      Width = 37
      HelpContext = 464083
      TabOrder = 29
      ExplicitLeft = 606
      ExplicitTop = 250
      ExplicitWidth = 37
    end
    inherited btnPDF: TDNMSpeedButton [52]
      Left = 649
      Top = 250
      Width = 37
      HelpContext = 464084
      TabOrder = 26
      Visible = False
      ExplicitLeft = 649
      ExplicitTop = 250
      ExplicitWidth = 37
    end
    inherited btnPayments: TDNMSpeedButton [53]
      Left = 616
      Width = 109
      HelpContext = 464087
      Caption = 'Open Cheque'
      TabOrder = 23
      ExplicitLeft = 616
      ExplicitWidth = 109
    end
    inherited cboCurrentTransStatus: TwwDBLookupCombo [54]
      Left = 206
      Top = 217
      TabOrder = 18
      ExplicitLeft = 206
      ExplicitTop = 217
    end
    object btnselectSale: TDNMSpeedButton
      Left = 244
      Top = 142
      Width = 116
      Height = 40
      HelpContext = 464085
      Action = actSelectSales
      Caption = 'Select Sale to Return'
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
      TabOrder = 32
      WordWrap = True
      AutoDisableParentOnclick = True
    end
    object btnCheque: TDNMSpeedButton
      Left = 365
      Top = 142
      Width = 116
      Height = 40
      HelpContext = 464088
      Caption = 'Create Cheque'
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
      TabOrder = 33
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnChequeClick
    end
  end
  inherited qryPayMethod: TERPQuery
    Left = 382
    Top = 357
  end
  inherited tmrProcessMessage: TTimer
    Left = 453
    Top = 320
  end
  inherited tmrdelay: TTimer
    Left = 493
    Top = 320
  end
  inherited popSpelling: TPopupMenu
    Left = 136
    Top = 320
  end
  inherited tmrdelayMsg: TTimer
    Left = 57
    Top = 320
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 171
    Top = 11
  end
  inherited DSDetails: TDataSource
    Left = 53
    Top = 390
  end
  inherited DSMaster: TDataSource
    Left = 14
    Top = 390
  end
  inherited lsTDNMSpeedButtonActions: TActionList
    Left = 334
    Top = 320
    object actSelectSales: TDNMAction
      Caption = 'Select Sale to Return'
      HelpContext = 464086
      OnExecute = actSelectSalesExecute
      OnUpdate = actSelectSalesUpdate
      buttoncolor = clWhite
    end
    object actSignature: TAction
      Caption = 'Signature'
      HelpContext = 464095
      OnExecute = actSignatureExecute
      OnUpdate = actSignatureUpdate
    end
  end
  inherited popDscntMrkup: TAdvPopupMenu
    Left = 532
    Top = 320
  end
  inherited popMemTrans: TAdvPopupMenu
    Left = 612
    Top = 320
    inherited MemorizeTransaction1: TMenuItem
      Visible = False
    end
    inherited MemorizeAutoTransaction1: TMenuItem
      Visible = False
    end
    inherited mnuStockTransferEntrylist: TMenuItem
      Visible = False
    end
    inherited mnuReturns: TMenuItem
      Visible = False
    end
    inherited checkDiscount1: TMenuItem
      Visible = False
    end
  end
  inherited tblMaster: TERPQuery
    Left = 18
    Top = 357
    object tblMasterSaleDateTime: TDateTimeField
      FieldName = 'SaleDateTime'
    end
    object tblMasterClientSignature: TBlobField
      FieldName = 'ClientSignature'
    end
    object tblMasterSignatureTime: TDateTimeField
      FieldName = 'SignatureTime'
    end
  end
  inherited tblDetails: TERPQuery
    Left = 58
    Top = 357
    inherited tblDetailsRefundQty: TFloatField [2]
      DisplayLabel = 'Refund Qty'
      Visible = True
    end
    inherited tblDetailsUnitofMeasureSaleLines: TWideStringField [3]
    end
    inherited tblDetailsLineTaxCode: TWideStringField [9]
      DisplayWidth = 5
    end
    inherited tblDetailsLineTax: TFloatField [10]
      DisplayLabel = 'Tax'
    end
    inherited tblDetailsDiscounts: TFloatField [11]
    end
    inherited tblDetailsTotalLineAmountInc: TFloatField [12]
      DisplayLabel = 'Line Total Inc'
    end
    inherited tblDetailsMatrixDesc: TWideMemoField [13]
      DisplayLabel = 'Matrix Details'
    end
    inherited tblDetailsMatrixPrice: TFloatField [14]
      DisplayLabel = 'Matrix Price'
    end
    inherited tblDetailsArea: TWideStringField [15]
    end
    object tblDetailsIsQuote: TWideStringField [16]
      DisplayWidth = 1
      FieldName = 'IsQuote'
      Visible = False
      FixedChar = True
      Size = 1
    end
    inherited tblDetailsFormulaQtySoldValue1: TFloatField [17]
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue2: TFloatField [18]
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue3: TFloatField [19]
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue4: TFloatField [20]
      Visible = False
    end
    inherited tblDetailsUnitofMeasureShipped: TFloatField [21]
      Visible = False
    end
    inherited tblDetailsCalcPriceInc: TCurrencyField [22]
    end
    inherited tblDetailsCalcTotalInc: TCurrencyField [23]
    end
    inherited tblDetailsLaybyID: TWideStringField [24]
    end
    inherited tblDetailsCalcTotalEx: TCurrencyField [25]
    end
    inherited tblDetailsIncomeAccnt: TWideStringField [26]
    end
    inherited tblDetailsCalcTax: TCurrencyField [27]
    end
    inherited tblDetailsCalcBackOrder: TCurrencyField [28]
    end
    inherited tblDetailsOrgLinePrice: TFloatField [29]
    end
    inherited tblDetailsCalcTotalIncB4Discount: TCurrencyField [30]
    end
    inherited tblDetailsLinePrice: TFloatField [31]
    end
    inherited tblDetailsAttrib2Sale: TFloatField [32]
    end
    inherited tblDetailsAttrib1SaleRate: TFloatField [33]
    end
    inherited tblDetailsCogsAccnt: TWideStringField [34]
    end
    inherited tblDetailsLineCost: TFloatField [35]
    end
    inherited tblDetailsEditedFlag: TWideStringField [36]
    end
    inherited tblDetailsShipped: TFloatField [37]
    end
    inherited tblDetailsLineCostInc: TFloatField [38]
    end
    inherited tblDetailsLineWholesalePrice: TFloatField [39]
    end
    inherited tblDetailsDiscountPercent: TFloatField [40]
    end
    inherited tblDetailsBackOrder: TFloatField [41]
    end
    inherited tblDetailsDeleted: TWideStringField [42]
    end
    inherited tblDetailsQtySold: TFloatField [43]
    end
    inherited tblDetailsInvoiced: TWideStringField [44]
    end
    inherited tblDetailsMarkup: TFloatField [45]
    end
    inherited tblDetailsAssetAccnt: TWideStringField [46]
    end
    inherited tblDetailsTotalLineAmount: TFloatField [47]
    end
    inherited tblDetailsCalcLinePriceEx: TCurrencyField [48]
    end
    inherited tblDetailsMarkupPercent: TFloatField [49]
    end
    inherited tblDetailsAttrib1Sale: TFloatField [50]
    end
    inherited tblDetailsProductGroup: TWideStringField [51]
    end
    inherited tblDetailsFormulaQtySoldValue5: TFloatField [52]
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue1: TFloatField [53]
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue2: TFloatField [54]
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue3: TFloatField [55]
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue4: TFloatField [56]
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue5: TFloatField [57]
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue: TFloatField [58]
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue: TFloatField [59]
      Visible = False
    end
    inherited tblDetailsISVoucher: TWideStringField [60]
      Visible = False
    end
    inherited tblDetailsVoucherNo: TWideStringField [61]
      Visible = False
    end
    inherited tblDetailsISContainer: TWideStringField [62]
      Visible = False
    end
    inherited tblDetailsIsPallet: TWideStringField [63]
      Visible = False
    end
    inherited tblDetailsSaleLineID: TAutoIncField [64]
    end
    inherited tblDetailsGlobalRef: TWideStringField [65]
    end
    inherited tblDetailsSaleID: TIntegerField [66]
    end
    inherited tblDetailsLineTaxRate: TFloatField [67]
    end
    inherited tblDetailsProductID: TIntegerField [68]
    end
    inherited tblDetailsAreaQty: TFloatField [69]
      Visible = False
    end
    inherited tbldetailsMargin: TFloatField [70]
    end
    inherited tbldetailsMarginPercent: TFloatField [71]
    end
    inherited tblDetailsDiscountedPriceInc: TFloatField [72]
      Visible = False
    end
    inherited tblDetailsDiscountedPrice: TFloatField [73]
    end
    inherited tblDetailsTotalDiscountedPriceInc: TFloatField [74]
      Visible = False
    end
    inherited tblDetailsPartType: TWideStringField [75]
    end
    inherited tblDetailsTotalDiscountedPrice: TFloatField [76]
    end
    inherited tblDetailsProductPrintName: TWideStringField
      Visible = False
    end
    inherited tblDetailsUOMQtyInStock: TFloatField
      Visible = False
    end
    inherited tblDetailsUOMQtyAvailable: TFloatField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField1: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField2: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField3: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField4: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField5: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField6: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField7: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField8: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField9: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField10: TWideStringField
      Visible = False
    end
    object tblDetailsRefundedSalesLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RefundedSalesLineID'
    end
  end
  inherited cboClientLookup: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, '
      'Street, Street2, Street3, Suburb, State, Country, Postcode,'
      
        'BillStreet, BillStreet2, BillStreet3, BillSuburb, BillState, Bil' +
        'lPostcode,BillCountry,'
      'TERMS, ShippingMethod, ShippingID,RepID, TaxID,TermsID'
      'FROM tblclients'
      'WHERE Customer = '#39'T'#39' '
      'AND tblclients.ClientID= :xClientID'
      'Order By Company')
    Left = 422
    Top = 357
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
  end
  inherited cboEmployeeLookup: TERPQuery
    Left = 139
    Top = 357
  end
  inherited cboClassQry: TERPQuery
    Left = 179
    Top = 357
  end
  inherited qryBaseForeignCurrency: TERPQuery
    Left = 544
    Top = 357
  end
  inherited qryClientLookup: TERPQuery
    Left = 260
    Top = 357
    inherited qryClientLookupCompany: TWideStringField
      DisplayWidth = 45
    end
  end
  inherited imgPopup: TImageList
    Left = 241
    Bitmap = {
      494C01010200D800500110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 572
    Top = 320
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 255
    Top = 320
  end
  inherited MyConnection: TERPConnection
    Left = 18
    Top = 320
  end
  inherited DataState: TDataState
    Left = 171
    Top = 35
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 414
    Top = 320
  end
  inherited imgsort: TImageList
    Left = 216
    Top = 320
    Bitmap = {
      494C01010200DC00540110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited qryPayments: TERPQuery
    Left = 98
    Top = 357
  end
  inherited qryUnitOfMeasure: TERPQuery
    Left = 463
    Top = 357
  end
  inherited cboTermsQry: TERPQuery
    Left = 503
    Top = 357
  end
  inherited cboProductQry: TERPQuery
    Left = 341
    Top = 357
  end
  inherited cboAccountQry: TERPQuery
    SQL.Strings = (
      
        'SELECT AccountID, AccountName,tblacctypedesc.AccDesc AS Type  ,A' +
        'ccountType'
      'FROM tblchartofaccounts'
      
        'LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType = tblchartofa' +
        'ccounts.AccountType'
      
        'WHERE (AccountType = '#39'AR'#39' or AccountType = '#39'OCASSET'#39') and Active' +
        '='#39'T'#39
      'And IsHeader = '#39'F'#39
      'ORDER BY AccountType,AccountName')
    Left = 220
    Top = 357
  end
  inherited DSPayments: TDataSource
    Left = 92
    Top = 388
  end
  inherited QryTransStatus: TERPQuery
    Left = 665
    Top = 357
  end
  inherited QryAreaCodeLk: TERPQuery
    Left = 625
    Top = 357
  end
  inherited cbTaxCodeQry: TERPQuery
    Left = 301
    Top = 357
  end
  inherited qryMemTrans: TERPQuery
    Left = 584
    Top = 357
  end
  inherited SaveDialog1: TSaveDialog
    Left = 374
    Top = 320
  end
  inherited QryCustomField: TERPQuery
    Left = 706
    Top = 357
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 295
    Top = 320
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 176
    Top = 320
  end
  inherited TmrCommentshint: TTimer
    Left = 97
    Top = 320
  end
end
