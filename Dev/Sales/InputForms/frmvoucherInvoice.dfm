inherited fmvoucherInvoice: TfmvoucherInvoice
  HelpContext = 997001
  Caption = 'Voucher'
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 418
    ExplicitTop = 418
  end
  inherited pnlDetail: TDNMPanel
    Left = 4
    Width = 944
    Height = 178
    HelpContext = 997031
    ExplicitLeft = 4
    ExplicitWidth = 944
    ExplicitHeight = 178
    inherited grdTransactions: TwwDBGrid
      Width = 944
      Height = 162
      HelpContext = 997033
      Selected.Strings = (
        'VoucherNo'#9'50'#9'VoucherNo'#9'F'
        'Product_Description'#9'20'#9'Description'#9'F'
        'TotalLineAmountInc'#9'14'#9'Amount (Inc)'#9'F')
      ExplicitWidth = 944
      ExplicitHeight = 147
    end
    inherited ProgressBar: TProgressBar
      Top = 162
      Width = 944
      HelpContext = 997034
      ExplicitTop = 147
      ExplicitWidth = 944
    end
  end
  inherited pnlFooter: TDNMPanel
    Top = 418
    Height = 144
    HelpContext = 997002
    Align = alBottom
    ExplicitTop = 418
    ExplicitHeight = 144
    inherited lblComments: TLabel
      Top = 26
      ExplicitTop = 26
    end
    inherited Label142: TLabel
      Left = 772
      Top = 7
      ExplicitLeft = 772
      ExplicitTop = 7
    end
    inherited Label54: TLabel
      Left = 773
      Top = 37
      ExplicitLeft = 773
      ExplicitTop = 37
    end
    inherited Label93: TLabel
      Top = 91
      ExplicitTop = 91
    end
    inherited Label56: TLabel
      Left = 769
      Top = 67
      ExplicitLeft = 769
      ExplicitTop = 67
    end
    inherited Label122: TLabel
      Left = 115
      Top = 55
      ExplicitLeft = 115
      ExplicitTop = 55
    end
    inherited Label5: TLabel
      Left = 107
      Top = 30
      ExplicitLeft = 107
      ExplicitTop = 30
    end
    inherited lblBaseForeignTotal: TLabel
      Top = 67
      ExplicitTop = 67
    end
    inherited Label101: TLabel
      Left = 318
      Top = 112
      Width = 26
      HelpContext = 997003
      ExplicitLeft = 318
      ExplicitTop = 112
      ExplicitWidth = 26
    end
    inherited lblContributionAmount: TLabel
      Left = 90
      Top = 12
      Visible = False
      ExplicitLeft = 90
      ExplicitTop = 12
    end
    inherited Label12: TLabel
      Left = 772
      Top = 126
      ExplicitLeft = 772
      ExplicitTop = 106
    end
    inherited lblApprovedAmount: TLabel
      Left = 93
      Top = 72
      Visible = False
      ExplicitLeft = 93
      ExplicitTop = 52
    end
    inherited pnlComments: TDNMPanel
      HelpContext = 997035
      inherited txtComments: TDBMemo
        HelpContext = 997004
      end
    end
    inherited txtSubTotal: TDBEdit
      Left = 840
      Top = 3
      ExplicitLeft = 840
      ExplicitTop = 3
    end
    inherited txtTotalTax: TDBEdit
      Left = 840
      Top = 33
      ExplicitLeft = 840
      ExplicitTop = 33
    end
    inherited txtTotalDiscount: TDBEdit
      Left = 168
      Top = 27
      Visible = False
      ExplicitLeft = 168
      ExplicitTop = 27
    end
    inherited txtPickMemo: TDBMemo
      Left = 75
      Top = 87
      Width = 243
      Height = 55
      HelpContext = 997005
      ExplicitLeft = 75
      ExplicitTop = 87
      ExplicitWidth = 243
      ExplicitHeight = 55
    end
    inherited txtTotalMarkup: TDBEdit
      Left = 168
      Top = 52
      Visible = False
      ExplicitLeft = 168
      ExplicitTop = 52
    end
    inherited txtTotalAmount: TDBEdit
      Left = 826
      Top = 63
      ExplicitLeft = 826
      ExplicitTop = 63
    end
    inherited edtBaseForeignTotal: TDBEdit
      Top = 64
      ExplicitTop = 64
    end
    inherited lblDisableCalc: TDNMSpeedButton
      Left = 516
      Top = 41
      ExplicitLeft = 516
      ExplicitTop = 41
    end
    inherited lblEmail: TDNMPanel
      Left = 613
      Top = 18
      Width = 165
      HelpContext = 997036
      ExplicitLeft = 613
      ExplicitTop = 18
      ExplicitWidth = 165
      inherited lblEmailMsg: TLabel
        Left = 3
        Top = 3
        Width = 160
        Height = 16
        HelpContext = 997037
        Font.Height = -13
        ExplicitLeft = 3
        ExplicitTop = 3
        ExplicitWidth = 160
        ExplicitHeight = 16
      end
    end
    inherited pnlProcessMessage: TDNMPanel
      HelpContext = 997038
      inherited lblProcessMessage: TLabel
        HelpContext = 997032
      end
    end
    inherited dnmpanle6: TDNMPanel
      Height = 141
      HelpContext = 997006
      ExplicitHeight = 141
      inherited lblMargin: TLabel
        Top = 123
        Visible = True
        ExplicitTop = 123
      end
      inherited lblMarginLabel: TLabel
        Top = 120
        Visible = True
        ExplicitTop = 120
      end
      inherited lblCostLabel: TLabel
        Top = 100
        Visible = True
        ExplicitTop = 100
      end
      inherited lblCost: TLabel
        Top = 102
        Visible = True
        ExplicitTop = 102
      end
      inherited lblEarlyPaymentDiscount2: TLabel
        Top = 60
        ExplicitTop = 60
      end
      inherited lblEarlyPaymentDiscountAmount: TLabel
        Top = 62
        ExplicitTop = 62
      end
      inherited lblEarlyPaymentDiscount: TLabel
        Top = 40
        ExplicitTop = 40
      end
      inherited lblShipTitle: TLabel
        Top = 20
        ExplicitTop = 20
      end
      inherited lblShipped: TLabel
        Top = 21
        ExplicitTop = 21
      end
      inherited lblEstimatedFinalAmt: TLabel
        Top = 82
        ExplicitTop = 82
      end
      inherited lblEstimatedFinalAmtCaption: TLabel
        Top = 80
        ExplicitTop = 80
      end
      inherited lblWeightcaption: TLabel
        Left = 24
        Top = 91
        Visible = False
        ExplicitLeft = 24
        ExplicitTop = 91
      end
      inherited lblWeight: TLabel
        Left = 94
        Top = 91
        Visible = False
        ExplicitLeft = 94
        ExplicitTop = 91
      end
    end
    inherited txtConNote: TDBEdit
      Top = 119
      ExplicitTop = 119
    end
    inherited edtContributionAmount: TwwDBEdit
      Left = 160
      Top = 6
      Visible = False
      ExplicitLeft = 160
      ExplicitTop = 6
    end
    inherited Label11: TDNMSpeedButton
      Left = 772
      Top = 100
      ExplicitLeft = 772
      ExplicitTop = 100
    end
    inherited edtPayment: TDBEdit
      Left = 840
      Top = 93
      ExplicitLeft = 840
      ExplicitTop = 93
    end
    inherited edtBalance: TDBEdit
      Left = 840
      Top = 123
      ExplicitLeft = 840
      ExplicitTop = 123
    end
    inherited edtApprovedAmount: TDBEdit
      Left = 172
      Top = 90
      Visible = False
      ExplicitLeft = 172
      ExplicitTop = 90
    end
  end
  inherited pnlHeader: TDNMPanel
    Top = 0
    HelpContext = 997039
    Align = alTop
    Font.Height = -12
    ExplicitTop = 0
    object Bevel2: TBevel [0]
      Left = 401
      Top = 61
      Width = 208
      Height = 47
      HelpContext = 997007
    end
    inherited bvelCustomerDetails: TBevel
      Left = 10
      Top = 127
      Height = 68
      HelpContext = 997008
      ExplicitLeft = 10
      ExplicitTop = 127
      ExplicitHeight = 68
    end
    inherited Label38: TLabel
      Left = 14
      Top = 50
      ExplicitLeft = 14
      ExplicitTop = 50
    end
    inherited lblClientDetails: TLabel
      Left = 17
      Top = 127
      ExplicitLeft = 17
      ExplicitTop = 127
    end
    inherited SaleDate_Label: TLabel
      Top = 57
      ExplicitTop = 57
    end
    inherited Label160: TLabel
      Top = 57
      ExplicitTop = 57
    end
    inherited ClassLabel: TLabel
      Left = 252
      Top = 62
      ExplicitLeft = 252
      ExplicitTop = 62
    end
    inherited Label43: TLabel
      Left = 14
      Top = 195
      Alignment = taLeftJustify
      ExplicitLeft = 14
      ExplicitTop = 195
    end
    inherited Label47: TLabel
      Left = 458
      Top = 195
      Width = 83
      HelpContext = 997011
      Alignment = taLeftJustify
      ExplicitLeft = 458
      ExplicitTop = 195
      ExplicitWidth = 83
    end
    inherited Label79: TLabel
      Left = 754
      Top = 195
      Width = 83
      HelpContext = 997012
      ExplicitLeft = 754
      ExplicitTop = 195
      ExplicitWidth = 83
    end
    inherited Label45: TLabel
      Left = 695
      Top = 133
      Width = 83
      HelpContext = 997013
      Visible = False
      ExplicitLeft = 695
      ExplicitTop = 133
      ExplicitWidth = 83
    end
    inherited lblAccount: TLabel
      Left = 14
      Top = 6
      ExplicitLeft = 14
      ExplicitTop = 6
    end
    inherited Label48: TLabel
      Left = 162
      Top = 195
      Width = 83
      HelpContext = 997010
      ExplicitLeft = 162
      ExplicitTop = 195
      ExplicitWidth = 83
    end
    inherited lblBaseForeignCurrencyCode: TLabel
      Left = 415
      Top = 63
      Visible = True
      ExplicitLeft = 415
      ExplicitTop = 63
    end
    inherited lblBaseExchangeRate: TLabel
      Left = 518
      Top = 65
      ExplicitLeft = 518
      ExplicitTop = 65
    end
    inherited lblStatus: TLabel
      Left = 310
      Top = 197
      ExplicitLeft = 310
      ExplicitTop = 197
    end
    inherited Label8: TLabel
      Left = 631
      Top = 35
      Visible = False
      ExplicitLeft = 631
      ExplicitTop = 35
    end
    object Bevel1: TBevel [22]
      Left = 248
      Top = 61
      Width = 150
      Height = 47
      HelpContext = 997014
    end
    object Bevel3: TBevel [23]
      Left = 248
      Top = 150
      Width = 361
      Height = 45
      HelpContext = 997015
    end
    inherited lblArea: TLabel
      Left = 606
      Top = 197
      ExplicitLeft = 606
      ExplicitTop = 197
    end
    inherited cboCurrentTransStatus: TwwDBLookupCombo
      Left = 310
      Top = 210
      Width = 98
      HelpContext = 997040
      ExplicitLeft = 310
      ExplicitTop = 210
      ExplicitWidth = 98
    end
    inherited txtShipTo: TDBMemo
      Height = 71
      HelpContext = 997021
      ExplicitHeight = 71
    end
    inherited editField: TEdit
      Left = 528
      Top = 118
      Height = 23
      HelpContext = 997017
      ExplicitLeft = 528
      ExplicitTop = 118
      ExplicitHeight = 23
    end
    inherited txtClientDetails: TDBMemo
      Top = 143
      Height = 48
      HelpContext = 997016
      ExplicitTop = 143
      ExplicitHeight = 48
    end
    inherited cboCreationDate: TwwDBDateTimePicker
      Left = 620
      Top = 72
      Height = 23
      HelpContext = 997018
      ExplicitLeft = 620
      ExplicitTop = 72
      ExplicitHeight = 23
    end
    inherited cboClass: TwwDBLookupCombo
      Left = 252
      Top = 81
      ExplicitLeft = 252
      ExplicitTop = 81
    end
    inherited txtPONumber: TDBEdit
      Left = 14
      Top = 210
      ExplicitLeft = 14
      ExplicitTop = 210
    end
    inherited cboTerms: TwwDBLookupCombo
      Left = 754
      Top = 210
      Width = 98
      HelpContext = 997019
      ExplicitLeft = 754
      ExplicitTop = 210
      ExplicitWidth = 98
    end
    inherited cboDueDate: TwwDBDateTimePicker
      Left = 695
      Top = 151
      Width = 98
      HelpContext = 997020
      Visible = False
      ExplicitLeft = 695
      ExplicitTop = 151
      ExplicitWidth = 98
    end
    inherited cmdDeliveryDocket: TDNMSpeedButton
      Left = 690
      Top = 137
      Visible = False
      ExplicitLeft = 690
      ExplicitTop = 137
    end
    inherited cmdPrintPick: TDNMSpeedButton
      Left = 646
      Top = 137
      Visible = False
      ExplicitLeft = 646
      ExplicitTop = 137
    end
    inherited cboAccount: TwwDBLookupCombo
      Top = 22
      ExplicitTop = 22
    end
    inherited txtCustomID: TDBEdit
      Top = 72
      ExplicitTop = 72
    end
    inherited cboEmployee: TwwDBLookupCombo
      Left = 162
      Top = 210
      Width = 98
      HelpContext = 997022
      ExplicitLeft = 162
      ExplicitTop = 210
      ExplicitWidth = 98
    end
    inherited btnNext: TDNMSpeedButton
      Left = 859
      Top = 13
      TabOrder = 48
      ExplicitLeft = 859
      ExplicitTop = 13
    end
    inherited btnCompleted: TDNMSpeedButton
      Left = 859
      Top = 50
      ExplicitLeft = 859
      ExplicitTop = 50
    end
    inherited btnClose: TDNMSpeedButton
      Left = 859
      Top = 87
      ExplicitLeft = 859
      ExplicitTop = 87
    end
    inherited btnPreview: TDNMSpeedButton
      Left = 859
      Top = 124
      ExplicitLeft = 859
      ExplicitTop = 124
    end
    inherited btnPrint: TDNMSpeedButton
      Left = 859
      Top = 161
      ExplicitLeft = 859
      ExplicitTop = 161
    end
    inherited pnlChooseRpt: TDNMPanel
      Left = 252
      Top = 118
      HelpContext = 997041
      ExplicitLeft = 252
      ExplicitTop = 118
    end
    inherited cboVia: TwwDBLookupCombo
      Left = 458
      Top = 210
      Width = 98
      HelpContext = 997023
      ExplicitLeft = 458
      ExplicitTop = 210
      ExplicitWidth = 98
    end
    inherited pnlHold: TDNMPanel
      Left = 390
      Top = 118
      HelpContext = 997042
      ExplicitLeft = 390
      ExplicitTop = 118
      inherited lblHoldSale: TLabel
        Top = 3
        ExplicitTop = 3
      end
      inherited chkHoldSale: TwwCheckBox
        Top = 3
        ExplicitTop = 3
      end
    end
    inherited btnContacts: TDNMSpeedButton
      Top = 69
      ExplicitTop = 69
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo
      Left = 413
      Top = 82
      Visible = True
      ExplicitLeft = 413
      ExplicitTop = 82
    end
    inherited edtBaseExchangeRate: TwwDBEdit
      Left = 516
      Top = 82
      ExplicitLeft = 516
      ExplicitTop = 82
    end
    inherited pnlTitle: TDNMPanel
      Top = 7
      HelpContext = 997043
      ExplicitTop = 7
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          HelpContext = 997024
          Caption = 'Voucher'
        end
      end
    end
    inherited cboClientR: TERPDbLookupCombo
      Left = 14
      Top = 69
      ExplicitLeft = 14
      ExplicitTop = 69
    end
    inherited btnPrepayment: TDNMSpeedButton
      Left = 259
      Top = 159
      Width = 100
      HelpContext = 997025
      TabOrder = 47
      ExplicitLeft = 259
      ExplicitTop = 159
      ExplicitWidth = 100
    end
    inherited btnRepairEquipment: TDNMSpeedButton
      Visible = False
    end
    inherited btnCreateJob: TDNMSpeedButton
      Left = 526
      Top = 117
      Visible = False
      ExplicitLeft = 526
      ExplicitTop = 117
    end
    inherited pnlParentclient: TDNMPanel
      Left = 10
      Top = 95
      Width = 238
      HelpContext = 997026
      ExplicitLeft = 10
      ExplicitTop = 95
      ExplicitWidth = 238
      inherited edtParentclient: TwwDBEdit
        Width = 137
        HelpContext = 997027
        ExplicitWidth = 137
      end
    end
    inherited cmdFax: TDNMSpeedButton
      Left = 903
      ExplicitLeft = 903
    end
    inherited cboSalesCategory: TwwDBLookupCombo
      Left = 722
      Top = 33
      Visible = False
      ExplicitLeft = 722
      ExplicitTop = 33
    end
    inherited cmdEmail: TDNMSpeedButton
      Left = 754
      Top = 157
      Visible = False
      ExplicitLeft = 754
      ExplicitTop = 157
    end
    inherited btnPDF: TDNMSpeedButton
      Left = 859
      Width = 87
      HelpContext = 997044
      ExplicitLeft = 859
      ExplicitWidth = 87
    end
    inherited btnEdit: TDNMSpeedButton
      TabOrder = 46
    end
    inherited btnShipment: TDNMSpeedButton
      Left = 621
      TabOrder = 36
      ExplicitLeft = 621
    end
    inherited cboAreaCode: TwwDBLookupCombo
      Left = 606
      Top = 210
      TabOrder = 37
      ExplicitLeft = 606
      ExplicitTop = 210
    end
    inherited btnPrevious: TDNMSpeedButton
      Left = 726
      Top = 115
      TabOrder = 38
      Visible = False
      ExplicitLeft = 726
      ExplicitTop = 115
    end
    inherited btnNextSale: TDNMSpeedButton
      Left = 773
      Top = 118
      TabOrder = 39
      Visible = False
      ExplicitLeft = 773
      ExplicitTop = 118
    end
    inherited btnShiptocontact: TDNMSpeedButton
      TabOrder = 40
    end
    inherited pnlShipToMessage: TPanel
      TabOrder = 41
    end
    inherited btninvoices: TDNMSpeedButton
      TabOrder = 42
    end
    inherited btnConSmart: TDNMSpeedButton
      TabOrder = 43
    end
    inherited btnShowDetails: TDNMSpeedButton
      TabOrder = 44
    end
    inherited btnRefNo: TDNMSpeedButton
      TabOrder = 45
    end
    object btnPayment: TDNMSpeedButton
      Left = 377
      Top = 159
      Width = 100
      Height = 27
      HelpContext = 997029
      Caption = 'Payments'
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
      TabOrder = 34
      AutoDisableParentOnclick = True
      OnClick = btnPaymentClick
    end
    object btnGroupVoucher: TDNMSpeedButton
      Left = 496
      Top = 159
      Width = 100
      Height = 27
      HelpContext = 997030
      Anchors = [akTop, akRight]
      Caption = 'Group Voucher'
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
      TabOrder = 35
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnGroupVoucherClick
    end
  end
  inherited tblDetails: TERPQuery
    object tblDetailsVoucherNo: TWideStringField [0]
      DisplayWidth = 50
      FieldName = 'VoucherNo'
      Size = 255
    end
    inherited tblDetailsProduct_Description: TWideStringField [1]
    end
    inherited tblDetailsTotalLineAmountInc: TFloatField [2]
    end
    inherited tblDetailsPartBarcode: TWideStringField [3]
      Visible = False
    end
    inherited tblDetailsProductName: TWideStringField [4]
      Visible = False
    end
    inherited tblDetailsUnitofMeasureSaleLines: TWideStringField [5]
      Visible = False
    end
    inherited tblDetailsUnitofMeasureQtySold: TFloatField [6]
      Visible = False
    end
    inherited tblDetailsUnitofMeasureShipped: TFloatField [7]
      Visible = False
    end
    inherited tblDetailsPQA: TWideStringField [8]
      Visible = False
    end
    inherited tblDetailsUnitofMeasureBackorder: TFloatField [9]
      Visible = False
    end
    inherited tblDetailsAttrib1Sale: TFloatField [10]
      Visible = False
    end
    inherited tblDetailsAttrib2Sale: TFloatField [11]
      Visible = False
    end
    inherited tblDetailsAttrib1SaleRate: TFloatField [12]
      Visible = False
    end
    inherited tblDetailsSpecDescription: TWideStringField [13]
      Visible = False
    end
    inherited tblDetailsSpecValue: TFloatField [14]
      Visible = False
    end
    inherited tblDetailsReferenceNo: TWideStringField [15]
    end
    inherited tblDetailsProduct_Description_Memo: TWideMemoField
      Visible = False
    end
    inherited tblDetailsCostCentreName: TWideStringField
      Visible = False
    end
    inherited tblDetailsLineCostInc: TFloatField
      Visible = False
    end
    inherited tblDetailsLinePriceInc: TFloatField
      Visible = False
    end
    inherited tblDetailsDiscounts: TFloatField
      Visible = False
    end
    inherited tblDetailsForeignCurrencyLinePrice: TFloatField
      Visible = False
    end
    inherited tblDetailsCalcProfit: TCurrencyField
      Visible = False
    end
    inherited tblDetailsCalcProfitPercent: TFloatField
      Visible = False
    end
    inherited tblDetailsCalcGrossProfitPercentInc: TFloatField
      Visible = False
    end
    inherited tblDetailsLatestCostPriceInc: TFloatField
      Visible = False
    end
    inherited tblDetailsLineTaxCode: TWideStringField
      Visible = False
    end
    inherited tblDetailsSeqNo: TIntegerField [27]
    end
    inherited tblDetailsLineTax: TFloatField [28]
      Visible = False
    end
    inherited tblDetailsSupplier: TWideStringField
      Visible = False
    end
    inherited tblDetailsSupplierContact: TWideStringField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField1: TWideStringCustField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField2: TWideStringCustField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField3: TWideStringCustField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField4: TWideStringCustField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField5: TWideStringCustField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField6: TWideStringCustField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField7: TWideStringCustField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField8: TWideStringCustField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField9: TWideStringCustField
      Visible = False
    end
    inherited tblDetailsSalesLinesCustField10: TWideStringCustField
      Visible = False
    end
    inherited tblDetailsMemoLine: TWideMemoField
      Visible = False
    end
    inherited tblDetailsShipDate: TDateTimeField
      Visible = False
    end
    inherited tblDetailsBaseLineno: TIntegerField
      Visible = False
    end
    inherited tblDetailsShipContainerName: TWideStringField
      Visible = False
    end
    inherited tblDetailsShipContainerETA: TDateField
      Visible = False
    end
    inherited tblDetailsTimecostused: TWideStringField
      Visible = False
    end
    inherited tblDetailsProfitbasedLatestCost: TFloatField
      Visible = False
    end
    inherited tblDetailsProfitbasedLatestCostPercent: TFloatField
      Visible = False
    end
    inherited tblDetailsProfitbasedLatestCostInc: TFloatField
      Visible = False
    end
    inherited tblDetailsProfitbasedLatestCostPercentInc: TFloatField
      Visible = False
    end
    inherited tblDetailsGrossProfitbasedLatestCostPercentInc: TFloatField
      Visible = False
    end
    inherited tblDetailsUOM_Height: TFloatField
      Visible = False
    end
    inherited tblDetailsUOM_Width: TFloatField
      Visible = False
    end
    inherited tblDetailsUOM_Length: TFloatField
      Visible = False
    end
    inherited tblDetailsUOM_Weight: TFloatField
      Visible = False
    end
    inherited tblDetailsTotalUOM_WeightSold: TFloatField
      Visible = False
    end
    inherited tblDetailsTotalUOM_WeightShipped: TFloatField
      Visible = False
    end
    inherited tblDetailsTotalUOM_WeightBO: TFloatField
      Visible = False
    end
    inherited tblDetailsTotalUOM_LengthSold: TFloatField
      Visible = False
    end
    inherited tblDetailsTotalUOM_LengthShipped: TFloatField
      Visible = False
    end
    inherited tblDetailsTotalUOM_LengthBO: TFloatField
      Visible = False
    end
    inherited tblDetailsUOM_Volume: TFloatField
      Visible = False
    end
    inherited tblDetailsProduct_custFld1: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld2: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld3: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld4: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld5: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld6: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld7: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld8: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld9: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld10: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld11: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld12: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld13: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld14: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custFld15: TWideStringField
      Visible = False
    end
    inherited tblDetailsProduct_custDate1: TDateTimeField
      Visible = False
    end
    inherited tblDetailsProduct_custDate2: TDateTimeField
      Visible = False
    end
    inherited tblDetailsProduct_custDate3: TDateTimeField
      Visible = False
    end
    inherited tblDetailsMatrixDesc: TWideMemoField
      Visible = False
    end
    inherited tblDetailsMatrixPrice: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue1: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue2: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue3: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue4: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue5: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue1: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue2: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue3: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue4: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue5: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtySoldValue: TFloatField
      Visible = False
    end
    inherited tblDetailsFormulaQtyShippedValue: TFloatField
      Visible = False
    end
    inherited tblDetailsAttrib1SaleEst: TFloatField
      Visible = False
    end
    inherited tblDetailsAttrib2SaleEst: TFloatField
      Visible = False
    end
  end
  inherited imgPopup: TImageList
    Bitmap = {
      494C01010400A800CC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
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
      0000000000008080800080808000000000000000000080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000080000000000080808000000000000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000008000000080000080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000008000808080000000FF000000800000000000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000000080000000800000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000800000008000008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080008080800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000FF0000008000000080000080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000800000800000000000000000FF00000080000000800000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000FF0000008000808080000000FF0000008000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000800000008000008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000800000008000808080000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008000000080
      0000808080000000000000000000000000000000000000000000000000000000
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
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000E00FFDFFFFFFFFFFE00FF8FFFFFFFFFF
      E00FF8FFFFFFFFFFF00FF87FFFFFFFFFF00FF81FF98FF9FFF80FF80FE10FF0FF
      F007F00FF01FE07FF007E00FF83FE03FF007E00FFC3FE01FF00FE00FF81FE20F
      F01FF01FF00FFF07F81FF00FF00FFF87FE1FF00FFFFFFFFFFF1FF007FFFFFFFF
      FF1FF007FFFFFFFFFFBFF007FFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200C800EC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
end
