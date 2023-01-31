inherited CreditGUI: TCreditGUI
  Left = 255
  Top = 297
  HelpContext = 75000
  Caption = 'Credit'
  ClientHeight = 564
  ClientWidth = 944
  ExplicitLeft = 255
  ExplicitTop = 297
  ExplicitWidth = 960
  ExplicitHeight = 603
  DesignSize = (
    944
    564)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 433
    Width = 944
    HelpContext = 75077
    ExplicitTop = 440
    ExplicitWidth = 944
  end
  inherited shapehint: TShape
    Left = 11
    ExplicitLeft = 11
  end
  inherited imgGridWatermark: TImage
    HelpContext = 75001
  end
  inherited shapehintextra1: TShape
    Left = 61
    ExplicitLeft = 61
  end
  inherited pnlDetail: TDNMPanel
    Top = 200
    Width = 944
    Height = 233
    HelpContext = 75065
    Align = alClient
    ExplicitTop = 200
    ExplicitWidth = 944
    ExplicitHeight = 240
    inherited grdTransactions: TwwDBGrid
      Width = 944
      Height = 233
      HelpContext = 75067
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
        'AccountName'#9'18'#9'Account Name'#9#9
        'LineTaxCode'#9'15'#9'Code'#9'F'#9
        'LineCost'#9'10'#9'Amount (Ex)'#9'F'#9
        'LineTax'#9'10'#9'Tax (Dbl Click)'#9'T'#9
        'Product_Description'#9'35'#9'Memo'#9'F'#9
        'CustomerJob'#9'25'#9'Customer Job'#9'F'#9
        'Class'#9'10'#9'Departments'#9'F'#9
        'RelatedPOID'#9'10'#9'Related PO'#9'F'#9
        'SortID'#9'10'#9'SortID'#9'F'#9
        'LinesOrder'#9'10'#9'Order by'#9'F'#9
        'EquipmentName'#9'20'#9'Equipment Name'#9'F'#9
        'EmployeeName'#9'20'#9'Employee'#9'F'#9
        'AreaCode'#9'10'#9'Area'#9'F'#9
        'RepairDocNo'#9'15'#9'Repair #'#9'F'#9
        'ExpenseProductSelected'#9'20'#9'ExpenseProductSelected'#9'F'#9)
      ExplicitWidth = 944
      ExplicitHeight = 240
    end
    inherited cboAccountlineX: TERPDbLookupCombo
      Selected.Strings = (
        'AccountName'#9'25'#9'Account Name'#9'F'
        'Type'#9'20'#9'Type'#9'T'
        'Description'#9'30'#9'Description'#9'F')
    end
  end
  inherited pnlFooter: TDNMPanel
    Top = 433
    Width = 944
    HelpContext = 75002
    Align = alBottom
    ExplicitTop = 440
    ExplicitWidth = 944
    inherited lblComments: TLabel
      HelpContext = 75004
    end
    inherited Label142: TLabel
      Left = 760
      Top = 36
      HelpContext = 75005
      ExplicitLeft = 760
      ExplicitTop = 36
    end
    inherited Label54: TLabel
      Left = 761
      HelpContext = 75006
      ExplicitLeft = 761
    end
    inherited Label56: TLabel
      Left = 704
      HelpContext = 75007
      ExplicitLeft = 704
    end
    inherited Label93: TLabel
      HelpContext = 75018
    end
    inherited lblBaseForeignTotal: TLabel
      Left = 596
      Top = 49
      Height = 14
      HelpContext = 75011
      ExplicitLeft = 494
      ExplicitTop = 49
      ExplicitHeight = 14
    end
    inherited pnlComments: TDNMPanel
      Height = 67
      HelpContext = 75074
      TabOrder = 5
      ExplicitHeight = 67
      inherited LblCommentsHint: TLabel
        Top = 48
        ExplicitTop = 48
      end
      inherited txtComments: TDBMemo
        Height = 47
        HelpContext = 75013
        ExplicitHeight = 47
      end
    end
    inherited txtSubTotal: TDBEdit
      Left = 826
      Top = 32
      HelpContext = 75014
      TabOrder = 1
      ExplicitLeft = 826
      ExplicitTop = 32
    end
    inherited txtTotalTax: TDBEdit
      Left = 826
      HelpContext = 75015
      TabOrder = 9
      ExplicitLeft = 826
    end
    inherited txtTotalAmount: TDBEdit
      Left = 812
      HelpContext = 75016
      TabOrder = 8
      ExplicitLeft = 812
    end
    inherited edtBaseForeignTotal: TDBEdit
      Left = 596
      Top = 66
      HelpContext = 75017
      TabOrder = 3
      ExplicitLeft = 494
      ExplicitTop = 66
    end
    inherited lblDisableCalc: TDNMSpeedButton
      Left = 683
      Top = 28
      TabOrder = 7
      ExplicitLeft = 683
      ExplicitTop = 28
    end
    inherited DNMPanel5: TDNMPanel
      Width = 157
      HelpContext = 75075
      TabOrder = 6
      ExplicitWidth = 157
      inherited lblEnteredbyHead: TLabel
        Left = 1
        ExplicitLeft = 1
      end
      inherited lblPrintHead: TLabel
        Left = 4
        ExplicitLeft = 4
      end
      inherited lblPrintedOnCaption: TLabel
        Left = 2
        ExplicitLeft = 2
      end
      inherited lblPrintedAtCaption: TLabel
        Left = 6
        ExplicitLeft = 6
      end
      inherited lblEnteredAtHead: TLabel
        Left = 3
        Width = 65
        HelpContext = 75076
        Alignment = taRightJustify
        Caption = 'Entered At :'
        ExplicitLeft = 3
        ExplicitWidth = 65
      end
      inherited lblEnteredAt: TDBText
        DataField = 'EnteredAtShort'
      end
    end
    inherited lblEmail: TDNMPanel
      Left = 596
      HelpContext = 75078
      TabOrder = 4
      ExplicitLeft = 596
    end
    inherited txtSalesComments: TDBMemo [14]
      Left = 72
      HelpContext = 75021
      TabOrder = 2
      ExplicitLeft = 72
    end
    inherited btnAttachments: TDNMSpeedButton [15]
      HelpContext = 75022
      TabOrder = 0
    end
    inherited pnlProcessMessage: TDNMPanel [16]
      Width = 944
      HelpContext = 75079
      TabOrder = 10
      ExplicitWidth = 944
      inherited lblProcessMessage: TLabel
        Width = 940
        HelpContext = 75066
        ExplicitLeft = 160
        ExplicitWidth = 680
      end
    end
  end
  inherited pnlHeader: TDNMPanel
    Top = 0
    Width = 944
    Height = 200
    HelpContext = 75024
    Align = alTop
    ParentColor = True
    ExplicitTop = 0
    ExplicitWidth = 944
    ExplicitHeight = 200
    DesignSize = (
      944
      200)
    object Shape1: TShape [0]
      Left = 668
      Top = 95
      Width = 114
      Height = 59
      HelpContext = 75068
      Brush.Style = bsClear
      Pen.Color = clGray
    end
    inherited Label38: TLabel
      Left = 8
      HelpContext = 75025
      ExplicitLeft = 8
    end
    inherited lblClientDetails: TLabel
      Left = 8
      HelpContext = 75026
      ExplicitLeft = 8
    end
    inherited SaleDate_Label: TLabel
      Left = 527
      Top = 50
      Width = 57
      HelpContext = 75027
      ExplicitLeft = 527
      ExplicitTop = 50
      ExplicitWidth = 57
    end
    inherited Label160: TLabel
      Left = 668
      Top = 52
      Width = 86
      Height = 15
      HelpContext = 75028
      Caption = 'Credit Number'
      ExplicitLeft = 668
      ExplicitTop = 52
      ExplicitWidth = 86
      ExplicitHeight = 15
    end
    inherited Label43: TLabel
      Left = 245
      Top = 160
      Width = 88
      Height = 15
      HelpContext = 75055
      Alignment = taLeftJustify
      AutoSize = True
      Caption = 'Invoice Number'
      ExplicitLeft = 245
      ExplicitTop = 160
      ExplicitWidth = 88
      ExplicitHeight = 15
    end
    inherited Label79: TLabel
      Left = 668
      Top = 159
      Width = 36
      Height = 15
      HelpContext = 75056
      AutoSize = True
      ExplicitLeft = 668
      ExplicitTop = 159
      ExplicitWidth = 36
      ExplicitHeight = 15
    end
    inherited Label45: TLabel
      Left = 226
      Top = 125
      Width = 51
      Height = 15
      HelpContext = 75057
      AutoSize = True
      Visible = False
      ExplicitLeft = 226
      ExplicitTop = 125
      ExplicitWidth = 51
      ExplicitHeight = 15
    end
    inherited lblAccount: TLabel
      Left = 8
      HelpContext = 75058
      ExplicitLeft = 8
    end
    inherited Label48: TLabel
      Left = 527
      Top = 160
      Width = 55
      Height = 15
      HelpContext = 75029
      AutoSize = True
      Caption = 'Employee'
      ExplicitLeft = 527
      ExplicitTop = 160
      ExplicitWidth = 55
      ExplicitHeight = 15
    end
    inherited lbMemTrans: TLabel
      Left = 703
      HelpContext = 75030
      ExplicitLeft = 601
    end
    inherited lblBaseForeignCurrencyCode: TLabel
      Left = 245
      Top = 50
      HelpContext = 75031
      Visible = True
      ExplicitLeft = 245
      ExplicitTop = 50
    end
    inherited lblEmployeeExpenseClaim: TLabel
      Left = 573
      Top = 7
      HelpContext = 75059
      Visible = True
      ExplicitLeft = 573
      ExplicitTop = 7
    end
    inherited lblBaseExchangeRate: TLabel
      Left = 386
      Top = 50
      Width = 95
      HelpContext = 75032
      Visible = True
      ExplicitLeft = 386
      ExplicitTop = 50
      ExplicitWidth = 95
    end
    inherited lblRedeemPoints: TLabel
      Left = 245
      ExplicitLeft = 245
    end
    inherited lblArea: TLabel
      Left = 681
      Top = 100
      ExplicitLeft = 681
      ExplicitTop = 100
    end
    inherited lblStatus: TLabel
      Left = 245
      Top = 94
      ExplicitLeft = 245
      ExplicitTop = 94
    end
    object Label5: TLabel [18]
      Left = 386
      Top = 160
      Width = 69
      Height = 15
      HelpContext = 75069
      Caption = 'Invoice Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited cboCurrentTransStatus: TwwDBLookupCombo
      Left = 245
      Top = 111
      Width = 114
      HelpContext = 75080
      TabOrder = 26
      ExplicitLeft = 245
      ExplicitTop = 111
      ExplicitWidth = 114
    end
    inherited txtClientDetails: TDBMemo
      Left = 8
      HelpContext = 75035
      TabOrder = 3
      ExplicitLeft = 8
    end
    inherited cboCreationDate: TwwDBDateTimePicker
      Left = 527
      Top = 66
      Width = 114
      Height = 23
      HelpContext = 75036
      TabOrder = 6
      ExplicitLeft = 527
      ExplicitTop = 66
      ExplicitWidth = 114
      ExplicitHeight = 23
    end
    inherited txtCustomID: TDBEdit
      Left = 668
      Top = 66
      Width = 114
      HelpContext = 75037
      TabOrder = 7
      ExplicitLeft = 668
      ExplicitTop = 66
      ExplicitWidth = 114
    end
    inherited txtInvNumber: TDBEdit
      Left = 245
      Top = 175
      Width = 114
      HelpContext = 75060
      TabOrder = 10
      OnExit = txtInvNumberExit
      ExplicitLeft = 245
      ExplicitTop = 175
      ExplicitWidth = 114
    end
    inherited cboTerms: TwwDBLookupCombo
      Left = 668
      Top = 174
      Width = 114
      HelpContext = 75061
      TabOrder = 13
      ExplicitLeft = 668
      ExplicitTop = 174
      ExplicitWidth = 114
    end
    inherited cboDueDate: TwwDBDateTimePicker
      Left = 226
      Top = 140
      Width = 108
      HelpContext = 75062
      TabOrder = 14
      Visible = False
      ExplicitLeft = 226
      ExplicitTop = 140
      ExplicitWidth = 108
    end
    inherited cboAccount: TwwDBLookupCombo
      Left = 8
      HelpContext = 75063
      TabOrder = 0
      ExplicitLeft = 8
    end
    inherited cboEmployee: TwwDBLookupCombo
      Left = 527
      Top = 175
      Width = 114
      HelpContext = 75038
      TabOrder = 12
      ExplicitLeft = 527
      ExplicitTop = 175
      ExplicitWidth = 114
    end
    inherited btnNext: TDNMSpeedButton
      Left = 849
      Top = 1
      HelpContext = 75039
      Font.Height = -12
      TabOrder = 15
      ExplicitLeft = 747
      ExplicitTop = 1
    end
    inherited btnCompleted: TDNMSpeedButton
      Left = 849
      Top = 32
      HelpContext = 75040
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      TabOrder = 16
      ExplicitLeft = 747
      ExplicitTop = 32
    end
    inherited btnClose: TDNMSpeedButton
      Left = 849
      Top = 64
      HelpContext = 75041
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      TabOrder = 23
      ExplicitLeft = 747
      ExplicitTop = 64
    end
    inherited btnPreview: TDNMSpeedButton
      Left = 849
      Top = 96
      HelpContext = 75042
      Font.Height = -12
      TabOrder = 22
      ExplicitLeft = 747
      ExplicitTop = 96
    end
    inherited btnPrint: TDNMSpeedButton
      Left = 849
      Top = 128
      HelpContext = 75043
      Action = nil
      Font.Height = -12
      TabOrder = 27
      OnClick = btnPrintClick
      ExplicitLeft = 747
      ExplicitTop = 128
    end
    inherited pnlChooseRpt: TDNMPanel
      Left = 822
      Top = 175
      Width = 114
      Height = 20
      HelpContext = 75044
      TabOrder = 8
      ExplicitLeft = 822
      ExplicitTop = 175
      ExplicitWidth = 114
      ExplicitHeight = 20
      inherited chkChooseRpt: TCheckBox
        Top = 3
        HelpContext = 75046
        ExplicitTop = 3
      end
    end
    inherited btnContacts: TDNMSpeedButton
      Left = 210
      Top = 55
      HelpContext = 75047
      TabOrder = 2
      ExplicitLeft = 210
      ExplicitTop = 55
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo
      Left = 245
      Top = 66
      Width = 114
      HelpContext = 75049
      TabOrder = 4
      Visible = True
      ExplicitLeft = 245
      ExplicitTop = 66
      ExplicitWidth = 114
    end
    inherited edtBaseExchangeRate: TwwDBEdit
      Left = 386
      Top = 66
      Width = 114
      HelpContext = 75050
      TabOrder = 5
      Visible = True
      ExplicitLeft = 386
      ExplicitTop = 66
      ExplicitWidth = 114
    end
    inherited pnlTitle: TDNMPanel
      Left = 380
      Width = 183
      Height = 40
      HelpContext = 75052
      Caption = 'Credit'
      TabOrder = 21
      ExplicitLeft = 380
      ExplicitWidth = 183
      ExplicitHeight = 40
      inherited TitleShader: TShader
        Width = 181
        Height = 38
        HelpContext = 75053
        ExplicitWidth = 181
        ExplicitHeight = 38
        inherited TitleLabel: TLabel
          Width = 181
          Height = 38
          HelpContext = 75054
          Caption = 'Credit'
          ExplicitWidth = 181
          ExplicitHeight = 38
        end
      end
    end
    inherited cboClientR: TERPDbLookupCombo
      Left = 8
      Top = 55
      Width = 202
      HelpContext = 75070
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F')
      DataField = 'SupplierName'
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitTop = 55
      ExplicitWidth = 202
    end
    inherited btnPayments: TDNMSpeedButton
      Left = 695
      Top = 18
      HelpContext = 75068
      TabOrder = 24
      ExplicitLeft = 593
      ExplicitTop = 18
    end
    inherited cmdEmail: TDNMSpeedButton
      Left = 781
      Top = 138
      Width = 51
      HelpContext = 75071
      TabOrder = 17
      ExplicitLeft = 679
      ExplicitTop = 138
      ExplicitWidth = 51
    end
    inherited btnPDF: TDNMSpeedButton
      Left = 849
      Top = 142
      Width = 51
      HelpContext = 75072
      TabOrder = 18
      Visible = False
      ExplicitLeft = 849
      ExplicitTop = 142
      ExplicitWidth = 51
    end
    inherited btnEdit: TDNMSpeedButton
      Left = 800
      Top = 142
      TabOrder = 19
      ExplicitLeft = 800
      ExplicitTop = 142
    end
    inherited cboExpenseClaimEmployee: TwwDBLookupCombo
      Left = 573
      Top = 22
      HelpContext = 75064
      TabOrder = 20
      Visible = True
      ExplicitLeft = 573
      ExplicitTop = 22
    end
    inherited cboAreaCode: TwwDBLookupCombo
      Left = 680
      Top = 117
      DataSource = DSMaster
      TabOrder = 9
      ExplicitLeft = 680
      ExplicitTop = 117
    end
    inherited btnfix: TButton
      TabOrder = 25
    end
    object cboInvoiceDate: TwwDBDateTimePicker
      Left = 386
      Top = 175
      Width = 114
      Height = 23
      HelpContext = 75073
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'InvoiceDate'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 11
      OnEnter = OverrideAccessLevel
    end
    object pnlApprover: TDNMPanel
      Left = 386
      Top = 95
      Width = 255
      Height = 59
      HelpContext = 75081
      BevelInner = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 28
      object lblApprover: TLabel
        Left = 9
        Top = 12
        Width = 58
        Height = 15
        HelpContext = 75082
        AutoSize = False
        Caption = 'Approver'
      end
      object cboApprover: TwwDBLookupCombo
        Left = 73
        Top = 8
        Width = 172
        Height = 23
        HelpContext = 75083
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'EmployeeName'#9'30'#9'Employee Name'#9'F')
        DataField = 'ApproverID'
        DataSource = DSMaster
        LookupTable = qryApproverLookup
        LookupField = 'EmployeeID'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object chkSendEmail: TwwCheckBox
        Left = 165
        Top = 35
        Width = 80
        Height = 17
        HelpContext = 75084
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Notify'
        TabOrder = 1
      end
      object chkApproved: TwwCheckBox
        Left = 9
        Top = 35
        Width = 80
        Height = 17
        HelpContext = 75023
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
        Caption = '&Approved'
        DataField = 'Approved'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = chkApprovedClick
      end
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 173
    Top = 11
  end
  inherited DSMaster: TDataSource
    Left = 10
    Top = 411
  end
  inherited tblMaster: TERPQuery
    Left = 10
    Top = 380
    object tblMasterApproved: TWideStringField [58]
      FieldName = 'Approved'
      FixedChar = True
      Size = 1
    end
    object tblMasterApproverID: TIntegerField
      FieldName = 'ApproverID'
    end
  end
  inherited tblDetails: TERPQuery
    Left = 44
    Top = 380
    inherited tblDetailsLineTax: TFloatField
      DisplayFormat = '$,##0.00###;($,##0.00###)'
    end
    inherited tblDetailsRelatedPOID: TIntegerField
      DisplayLabel = 'Related PO'
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
    inherited tblDetailsLineCostInc: TFloatField [16]
    end
    inherited tblDetailsPurchaseLineID: TAutoIncField [17]
    end
    inherited tblDetailsGlobalRef: TWideStringField [18]
    end
    inherited tblDetailsPurchaseOrderID: TIntegerField [19]
    end
    inherited tblDetailsCogsAccnt: TWideStringField [20]
    end
    inherited tblDetailsClassID: TIntegerField [21]
    end
    inherited tblDetailsProductGroup: TWideStringField [22]
    end
    inherited tblDetailsProductName: TWideStringField [23]
    end
    inherited tblDetailsLineTaxRate: TFloatField [24]
    end
    inherited tblDetailsQtySold: TFloatField [25]
    end
    inherited tblDetailsShipped: TFloatField [26]
    end
    inherited tblDetailsBackOrder: TFloatField [27]
    end
    inherited tblDetailsInvoiced: TWideStringField [28]
    end
    inherited tblDetailsRAQty: TFloatField [29]
    end
    inherited tblDetailsRAstatus: TWideStringField [30]
    end
    inherited tblDetailsBatch: TWideStringField [31]
    end
    inherited tblDetailsUseTimecost: TWideStringField [32]
    end
    inherited tblDetailsSaleID_Timecost: TIntegerField [33]
    end
    inherited tblDetailsTimecostMarkupPer: TFloatField [34]
    end
    inherited tblDetailsTimecostPrice: TFloatField [35]
    end
    inherited tblDetailsTimecostMarkupDol: TFloatField [36]
    end
    inherited tblDetailsTotalLineAmount: TFloatField [37]
    end
    inherited tblDetailsTotalLineAmountInc: TFloatField [38]
    end
    inherited tblDetailsEditedFlag: TWideStringField [39]
    end
    inherited tblDetailsDeleted: TWideStringField [40]
    end
    inherited tblDetailsRAInvoiceNo: TWideStringField [41]
    end
    inherited tblDetailsAccountGroup: TWideStringField [42]
    end
    inherited tblDetailsProductID: TIntegerField [43]
    end
    inherited tblDetailsPartType: TWideStringField [44]
    end
    inherited tblDetailsIncomeAccnt: TWideStringField [45]
    end
    inherited tblDetailsAssetAccnt: TWideStringField [46]
    end
    inherited tblDetailsCalcPriceInc: TCurrencyField [47]
    end
    inherited tblDetailsCalcTotalInc: TCurrencyField [48]
    end
    inherited tblDetailsCalcTotalEx: TCurrencyField [49]
    end
    inherited tblDetailsCalcTax: TCurrencyField [50]
    end
    inherited tblDetailsAvgCost: TFloatField [51]
    end
    inherited tblDetailsCustomerJobID: TIntegerField [52]
    end
    inherited tblDetailsCOGSTotalLineAmount: TFloatField [53]
    end
    inherited tblDetailsCOGSTotalLineAmountInc: TFloatField [54]
    end
    inherited tblDetailsAttrib1Purchase: TFloatField [55]
    end
    inherited tblDetailsAttrib2Purchase: TFloatField [56]
    end
    inherited tblDetailsAttrib1PurchaseRate: TFloatField [57]
    end
    inherited tblDetailsLastLineID: TIntegerField [58]
    end
    inherited tblDetailsForeignExchangeRate: TFloatField [59]
    end
    inherited tblDetailsForeignExchangeCode: TWideStringField [60]
    end
    inherited tblDetailsForeignCurrencyLineCost: TFloatField [61]
    end
    inherited tblDetailsUnitofMeasureQtySold: TFloatField [62]
    end
    inherited tblDetailsUnitofMeasureShipped: TFloatField [63]
    end
    inherited tblDetailsUnitofMeasureBackorder: TFloatField [64]
    end
    inherited tblDetailsUnitofMeasureMultiplier: TFloatField [65]
    end
    inherited tblDetailsLandedCostsPerItem: TFloatField [66]
    end
    inherited tblDetailsRelatedPOIDUsed: TWideStringField [67]
    end
    inherited tblDetailsUnitofMeasurePOLines: TWideStringField [68]
    end
    inherited tblDetailsSearchFilter: TWideStringField [69]
    end
    inherited tblDetailsSearchFilterCopy: TWideStringField [70]
    end
    inherited tblDetailsReceivedDate: TDateField [71]
    end
    inherited tblDetailsLandedCostsPercentage: TFloatField [72]
    end
    inherited tblDetailsLandedCostsTotal: TFloatField [73]
    end
    inherited tblDetailsserialno: TWideMemoField [74]
    end
    inherited tblDetailsForeignTotalLineAmount: TFloatField [75]
    end
    inherited tblDetailsNewForeignExchangeRate: TFloatField [76]
    end
    inherited tblDetailsUnitOfMeasureID: TIntegerField [77]
    end
    inherited tblDetailsSEQNo: TIntegerField [78]
    end
    inherited tblDetailsRepairId: TIntegerField [79]
    end
    inherited tblDetailsCustomerEquipmentID: TIntegerField [80]
    end
    inherited tblDetailsEmployeeID: TIntegerField [81]
      Visible = False
    end
  end
  inherited cboClientLookup: TERPQuery
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
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
  end
  inherited imgPopup: TImageList
    Left = 242
    Top = 5
    Bitmap = {
      494C010102009000F00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited DataState: TDataState
    Left = 173
    Top = 35
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102009400F40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      
        'and (tblChartofAccounts.AccountName <> "Retained Earnings") and ' +
        '(Left(IFNULL(AccountGroup,""),17) <> "Retained Earnings") '
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((AccountName LIKE Concat(:SearchValue' +
        ',"%")) or (tblacctypedesc.AccDesc LIKE Concat(:SearchValue,"%"))' +
        ' or (tblacctypedesc.AccDesc LIKE Concat(:SearchValue,"%"))) )'
      
        'or ((:SearchMode = 2) and ((AccountName LIKE Concat("%",:SearchV' +
        'alue,"%")) or (tblacctypedesc.AccDesc LIKE Concat("%",:SearchVal' +
        'ue,"%")) or (tblacctypedesc.AccDesc LIKE Concat("%",:SearchValue' +
        ',"%")))))'
      'and IfNull(:SearchValue,"") <> ""'
      '# placeholder for FilterAccountsForExpenseClaim'
      'ORDER BY AccountName')
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
  inherited qryCustomerJob: TERPQuery
    Left = 421
    Top = 374
  end
  object qryApproverLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '/*SQL dynamically chanegd */'
      'select distinct al.EmployeeID, al.EmployeeName, e.Email'
      'from tblapprovallevels al'
      'inner join tblemployees e on e.EmployeeID = al.EmployeeID'
      
        'where (:OrderTotal >= (al.ValueFrom - al.ValueLeeway)) and (:Ord' +
        'erTotal <= (al.ValueTo + al.ValueLeeway)) '
      'and al.ApprovalType = :ApprovalType')
    Left = 696
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'OrderTotal'
      end
      item
        DataType = ftUnknown
        Name = 'OrderTotal'
      end
      item
        DataType = ftUnknown
        Name = 'ApprovalType'
      end>
  end
end
