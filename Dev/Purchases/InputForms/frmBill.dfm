inherited BillGUI: TBillGUI
  Left = 166
  Top = 247
  HelpContext = 45000
  Caption = 'Bill'
  ClientHeight = 564
  ClientWidth = 1097
  OnResize = FormResize
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 1103
  ExplicitHeight = 593
  DesignSize = (
    1097
    564)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 433
    Width = 1097
    HelpContext = 45071
    ExplicitTop = 440
    ExplicitWidth = 944
  end
  inherited shapehint: TShape
    Left = 15
    ExplicitLeft = 11
  end
  inherited imgGridWatermark: TImage
    HelpContext = 45001
  end
  inherited shapehintextra1: TShape
    Left = 73
    ExplicitLeft = 61
  end
  inherited pnlDetail: TDNMPanel
    Top = 201
    Width = 1097
    Height = 232
    HelpContext = 45068
    Align = alClient
    ExplicitTop = 201
    ExplicitWidth = 1097
    ExplicitHeight = 232
    inherited grdTransactions: TwwDBGrid
      Width = 1097
      Height = 232
      HelpContext = 45070
      ControlType.Strings = (
        'AccountName;CustomEdit;cboAccountlineX;F'
        'LineTaxCode;CustomEdit;cboTaxCode;F'
        'CustomerJob;CustomEdit;cboCustJob;F'
        'Class;CustomEdit;cboClass;F'
        'RelatedPOID;CustomEdit;cboRelatedPOID;F'
        'AccountNumber;CustomEdit;cboAccountlNoLine;F'
        'RelatedShipContainerID;CustomEdit;cboRelatedShipContainerID;F'
        'ShipContainerName;CustomEdit;cboRelShipContainer;F'
        'EquipmentName;CustomEdit;cboEquipmentName;F'
        'RepairDocNo;CustomEdit;cboRepairDocNo;F'
        'EmployeeName;CustomEdit;cboLineEmployee;F'
        'AreaCode;CustomEdit;cboLinesAreaCode;F'
        'ExpenseProductSelected;CustomEdit;edtExpenseProductSelected;F')
      Selected.Strings = (
        'AccountNumber'#9'10'#9'Account No'#9#9
        'AccountName'#9'18'#9'Account Name'#9#9
        'LineTaxCode'#9'15'#9'Code'#9#9
        'LineCost'#9'10'#9'Amount (Ex)'#9#9
        'LineTax'#9'10'#9'Tax (Dbl Click)'#9#9
        'Product_Description'#9'35'#9'Memo'#9#9
        'CustomerJob'#9'25'#9'Customer / Job'#9#9
        'Class'#9'10'#9'Departments'#9#9
        'RelatedPOID'#9'10'#9'Related'#9#9
        'ShipContainerName'#9'25'#9'Related Ship Container'#9#9
        'SortID'#9'10'#9'Sort ID'#9#9
        'LinesOrder'#9'10'#9'Order by'#9#9
        'EquipmentName'#9'20'#9'Equipment Name'#9#9
        'EmployeeName'#9'20'#9'Employee'#9#9
        'AreaCode'#9'10'#9'Area'#9#9
        'RepairDocNo'#9'15'#9'Repair #'#9#9
        'ExpenseProductSelected'#9'20'#9'ExpenseProductSelected'#9#9)
      KeyOptions = [dgEnterToTab, dgAllowInsert]
      ExplicitWidth = 1097
      ExplicitHeight = 232
    end
    inherited cboAccountlineX: TERPDbLookupCombo
      Left = 76
      Width = 63
      Height = 26
      HelpContext = 45072
      AutoSize = True
      Selected.Strings = (
        'AccountName'#9'25'#9'Account Name'#9'F'
        'Type'#9'20'#9'Type'#9'T'
        'Description'#9'30'#9'Description'#9'F')
      ParentFont = True
      OrderByDisplay = True
      ExplicitLeft = 76
      ExplicitWidth = 63
      ExplicitHeight = 26
    end
    inherited cboTaxCode: TERPDbLookupCombo
      Width = 63
      HelpContext = 45073
      TabOrder = 13
      ExplicitWidth = 63
    end
    inherited cboClass: TwwDBLookupCombo
      Left = 706
      Width = 63
      HelpContext = 45074
      ExplicitLeft = 706
      ExplicitWidth = 63
    end
    inherited cboRelatedPOID: TwwDBLookupCombo
      Left = 356
      Width = 63
      HelpContext = 45075
      Selected.Strings = (
        'PurchaseOrderNumber'#9'11'#9'PO #'#9'F'
        'SupplierName'#9'20'#9'Supplier Name'#9'F')
      AllowClearKey = True
      OnNotInList = cboRelatedPOIDNotInList
      ExplicitLeft = 356
      ExplicitWidth = 63
    end
    inherited cboEquipmentName: TwwDBLookupCombo
      Left = 496
      Width = 63
      HelpContext = 45076
      ExplicitLeft = 496
      ExplicitWidth = 63
    end
    inherited cboAccountlNoLine: TERPDbLookupCombo
      Width = 63
      HelpContext = 45077
      Selected.Strings = (
        'AccountNumber'#9'10'#9'AccountNumber'#9'F'
        'AccountName'#9'25'#9'Account Name'#9'T'#9
        'AccountTree'#9'35'#9'Account Tree'#9'F'#9
        'Type'#9'15'#9'Type'#9'T'#9
        'Description'#9'30'#9'Description'#9'F'#9
        'Active'#9'1'#9'Active'#9'T'#9)
      DropDownWidth = 0
      TabOrder = 6
      ExplicitWidth = 63
    end
    inherited cboRepairDocNo: TwwDBLookupCombo
      Left = 286
      Width = 63
      HelpContext = 45078
      TabOrder = 10
      AutoDropDown = True
      ExplicitLeft = 286
      ExplicitWidth = 63
    end
    object cboRelatedShipContainerID: TwwDBLookupCombo [8]
      Left = 636
      Top = 28
      Width = 63
      Height = 26
      HelpContext = 45079
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ContainerName'#9'20'#9'Container Name'#9'F'#9
        'ShippingContainerID'#9'10'#9'Container ID'#9'F'#9)
      DataField = 'ShipContainerName'
      DataSource = DSDetails
      LookupTable = qryShipContainerLookup
      LookupField = 'ShippingContainerID'
      TabOrder = 5
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    inherited cboLinesAreaCode: TwwDBLookupCombo
      Left = 566
      Width = 63
      HelpContext = 45080
      Selected.Strings = (
        'AreaCode'#9'20'#9'Code'#9'F'
        'AreaName'#9'20'#9'Name'#9'F')
      ExplicitLeft = 566
      ExplicitWidth = 63
    end
    inherited edtExpenseProductSelected: TwwDBEdit
      Left = 426
      Width = 63
      HelpContext = 45081
      ExplicitLeft = 426
      ExplicitWidth = 63
    end
    inherited cboCustJob: TERPDbLookupCombo
      Left = 146
      Width = 63
      HelpContext = 45082
      ExplicitLeft = 146
      ExplicitWidth = 63
    end
    inherited cboCustPrintJob: TERPDbLookupCombo
      Left = 216
      Width = 63
      HelpContext = 45083
      ExplicitLeft = 216
      ExplicitWidth = 63
    end
    object cboRelShipContainer: TERPDbLookupCombo
      Left = 871
      Top = 28
      Width = 121
      Height = 26
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ShippingContainerID'#9'10'#9'Container ID'#9#9
        'ContainerName'#9'20'#9'Container Name'#9#9)
      DataField = 'ShipContainerName'
      DataSource = DSDetails
      LookupTable = qryRelatedContLookup
      LookupField = 'ContainerName'
      Options = [loTitles]
      TabOrder = 14
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      ShowMatchText = True
      OnNotInList = cboRelShipContainerNotInList
      LookupFormClassName = 'TfrmShippingContainerList'
      EditFormClassName = 'TfrmShipContainer'
      LookupFormKeyStringFieldName = 'Container Name'
      LookupComboType = ctNone
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'ShipContainerID'
    end
  end
  inherited pnlFooter: TDNMPanel
    Top = 433
    Width = 1097
    HelpContext = 45002
    Align = alBottom
    ExplicitTop = 433
    ExplicitWidth = 1097
    DesignSize = (
      1097
      131)
    inherited lblComments: TLabel
      HelpContext = 45004
    end
    inherited Label142: TLabel
      Left = 913
      Top = 38
      HelpContext = 45005
      ExplicitLeft = 760
      ExplicitTop = 38
    end
    inherited Label54: TLabel
      Left = 914
      Top = 69
      HelpContext = 45006
      ExplicitLeft = 761
      ExplicitTop = 69
    end
    inherited Label56: TLabel
      Left = 857
      HelpContext = 45007
      ExplicitLeft = 704
    end
    inherited Label93: TLabel
      HelpContext = 45018
    end
    inherited lblBaseForeignTotal: TLabel
      Left = 632
      Top = 46
      Height = 15
      HelpContext = 45011
      ExplicitLeft = 479
      ExplicitTop = 46
      ExplicitHeight = 15
    end
    inherited pnlComments: TDNMPanel
      Left = 76
      Width = 237
      Height = 66
      HelpContext = 45084
      TabOrder = 5
      ExplicitLeft = 76
      ExplicitWidth = 237
      ExplicitHeight = 66
      inherited LblCommentsHint: TLabel
        Top = 47
        Width = 235
        HelpContext = 45085
        ExplicitTop = 47
        ExplicitWidth = 235
      end
      inherited txtComments: TDBMemo
        Width = 235
        Height = 46
        Hint = '"Type In A Comment"'
        HelpContext = 45013
        ExplicitWidth = 235
        ExplicitHeight = 46
      end
    end
    inherited txtSubTotal: TDBEdit
      Left = 979
      Top = 34
      HelpContext = 45014
      TabOrder = 1
      ExplicitLeft = 979
      ExplicitTop = 34
    end
    inherited txtTotalTax: TDBEdit
      Left = 979
      Top = 62
      HelpContext = 45015
      TabOrder = 9
      ExplicitLeft = 979
      ExplicitTop = 62
    end
    inherited txtTotalAmount: TDBEdit
      Left = 965
      HelpContext = 45016
      TabOrder = 8
      ExplicitLeft = 965
    end
    inherited edtBaseForeignTotal: TDBEdit
      Left = 632
      Top = 62
      HelpContext = 45017
      TabOrder = 3
      ExplicitLeft = 632
      ExplicitTop = 62
    end
    inherited lblDisableCalc: TDNMSpeedButton
      Left = 826
      Top = 35
      TabOrder = 7
      ExplicitLeft = 826
      ExplicitTop = 35
    end
    inherited DNMPanel5: TDNMPanel
      HelpContext = 45109
      TabOrder = 6
      inherited lblEnteredbyHead: TLabel
        Left = 4
        ExplicitLeft = 4
      end
      inherited lblEnteredBy: TDBText
        Width = 64
        Height = 15
        HelpContext = 45086
        ExplicitWidth = 64
        ExplicitHeight = 15
      end
      inherited lblPrintHead: TLabel
        Left = 4
        ExplicitLeft = 4
      end
      inherited lblPrintedBy: TLabel
        AutoSize = False
      end
      inherited lblPrintedOnCaption: TLabel
        Left = 4
        ExplicitLeft = 4
      end
      inherited lblPrintedOn: TLabel
        Width = 63
        Height = 15
        HelpContext = 45087
        ExplicitWidth = 63
        ExplicitHeight = 15
      end
      inherited lblPrintedAtCaption: TLabel
        Left = 4
        ExplicitLeft = 4
      end
      inherited lblPrintedAt: TLabel
        Width = 48
        Height = 15
        HelpContext = 45088
        ExplicitWidth = 48
        ExplicitHeight = 15
      end
      inherited lblEnteredAtHead: TLabel
        Left = 4
        Width = 62
        HelpContext = 45089
        Caption = 'Entered At:'
        ExplicitLeft = 4
        ExplicitWidth = 62
      end
      inherited lblEnteredAt: TDBText
        Width = 64
        Height = 15
        HelpContext = 45090
        DataField = 'EnteredAtShort'
        ExplicitWidth = 64
        ExplicitHeight = 15
      end
    end
    inherited lblEmail: TDNMPanel
      Left = 625
      Top = 6
      Width = 203
      HelpContext = 45091
      TabOrder = 4
      ExplicitLeft = 625
      ExplicitTop = 6
      ExplicitWidth = 203
      inherited lblEmailMsg: TLabel
        Left = 4
        Alignment = taCenter
        ExplicitLeft = 4
      end
    end
    inherited txtSalesComments: TDBMemo [14]
      Width = 237
      Hint = '"Type In A Comment"'
      HelpContext = 45021
      TabOrder = 2
      ExplicitWidth = 237
    end
    inherited btnAttachments: TDNMSpeedButton [15]
      HelpContext = 45022
      TabOrder = 0
    end
    inherited pnlProcessMessage: TDNMPanel [16]
      Width = 1097
      HelpContext = 45092
      TabOrder = 10
      ExplicitWidth = 1097
      inherited lblProcessMessage: TLabel
        Width = 1093
        HelpContext = 45069
        ExplicitLeft = 200
        ExplicitWidth = 640
      end
    end
  end
  inherited pnlHeader: TDNMPanel
    Top = 0
    Width = 1097
    Height = 201
    HelpContext = 45024
    Align = alTop
    ParentColor = True
    ExplicitTop = 0
    ExplicitWidth = 1097
    ExplicitHeight = 201
    DesignSize = (
      1097
      201)
    object Shape2: TShape [0]
      Left = 606
      Top = 95
      Width = 106
      Height = 55
      HelpContext = 45093
      Brush.Style = bsClear
      Pen.Color = clGray
    end
    object Shape1: TShape [1]
      Left = 731
      Top = 95
      Width = 113
      Height = 55
      HelpContext = 45094
      Brush.Style = bsClear
      Pen.Color = clGray
    end
    inherited Label38: TLabel
      Left = 8
      Top = 50
      HelpContext = 45025
      ExplicitLeft = 8
      ExplicitTop = 50
    end
    inherited lblClientDetails: TLabel
      Left = 8
      HelpContext = 45026
      ExplicitLeft = 8
    end
    inherited SaleDate_Label: TLabel
      Left = 484
      Top = 50
      Width = 119
      HelpContext = 45027
      Caption = 'Bill Date'
      ExplicitLeft = 484
      ExplicitTop = 50
      ExplicitWidth = 119
    end
    inherited Label160: TLabel
      Left = 731
      Top = 50
      Width = 78
      HelpContext = 45028
      Caption = 'Bill Number'
      ExplicitLeft = 731
      ExplicitTop = 50
      ExplicitWidth = 78
    end
    inherited Label43: TLabel
      Left = 241
      Top = 157
      Width = 88
      Height = 15
      HelpContext = 45055
      Alignment = taLeftJustify
      AutoSize = True
      Caption = 'Invoice Number'
      ExplicitLeft = 241
      ExplicitTop = 157
      ExplicitWidth = 88
      ExplicitHeight = 15
    end
    inherited Label79: TLabel
      Left = 606
      Top = 157
      Width = 36
      Height = 15
      HelpContext = 45056
      AutoSize = True
      ExplicitLeft = 606
      ExplicitTop = 157
      ExplicitWidth = 36
      ExplicitHeight = 15
    end
    inherited Label45: TLabel
      Left = 606
      Top = 51
      Width = 51
      Height = 15
      HelpContext = 45057
      AutoSize = True
      ExplicitLeft = 606
      ExplicitTop = 51
      ExplicitWidth = 51
      ExplicitHeight = 15
    end
    inherited lblAccount: TLabel
      Left = 8
      HelpContext = 45058
      ExplicitLeft = 8
    end
    inherited Label48: TLabel
      Left = 484
      Top = 157
      Width = 55
      Height = 15
      HelpContext = 45029
      AutoSize = True
      Caption = 'Employee'
      ExplicitLeft = 484
      ExplicitTop = 157
      ExplicitWidth = 55
      ExplicitHeight = 15
    end
    object Label2: TLabel [11]
      Left = 612
      Top = 103
      Width = 47
      Height = 15
      HelpContext = 45066
      Caption = 'Bill Total'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited lbMemTrans: TLabel
      Left = 872
      Top = -2
      HelpContext = 45030
      ExplicitLeft = 719
      ExplicitTop = -2
    end
    inherited lblBaseForeignCurrencyCode: TLabel
      Left = 241
      Top = 50
      Width = 78
      HelpContext = 45031
      Visible = True
      ExplicitLeft = 241
      ExplicitTop = 50
      ExplicitWidth = 78
    end
    inherited lblEmployeeExpenseClaim: TLabel
      Left = 565
      Top = 6
      HelpContext = 45059
      Visible = True
      ExplicitLeft = 565
      ExplicitTop = 6
    end
    inherited lblBaseExchangeRate: TLabel
      Left = 362
      Top = 50
      Width = 78
      HelpContext = 45032
      Visible = True
      ExplicitLeft = 362
      ExplicitTop = 50
      ExplicitWidth = 78
    end
    inherited lblRedeemPoints: TLabel
      Left = 241
      Width = 107
      HelpContext = 45095
      ExplicitLeft = 241
      ExplicitWidth = 107
    end
    inherited lblArea: TLabel
      Left = 741
      Top = 103
      ExplicitLeft = 741
      ExplicitTop = 103
    end
    inherited lblStatus: TLabel
      Left = 241
      Top = 103
      Width = 107
      HelpContext = 45096
      ExplicitLeft = 241
      ExplicitTop = 103
      ExplicitWidth = 107
    end
    object Label3: TLabel [20]
      Left = 362
      Top = 157
      Width = 77
      Height = 15
      HelpContext = 45097
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
    inherited cboCurrentTransStatus: TwwDBLookupCombo
      Left = 241
      Top = 118
      Width = 114
      HelpContext = 45098
      TabOrder = 29
      ExplicitLeft = 241
      ExplicitTop = 118
      ExplicitWidth = 114
    end
    inherited txtClientDetails: TDBMemo
      Left = 8
      HelpContext = 45035
      TabOrder = 3
      ExplicitLeft = 8
    end
    inherited cboCreationDate: TwwDBDateTimePicker
      Left = 484
      Top = 66
      Width = 114
      Height = 23
      HelpContext = 45036
      TabOrder = 7
      OnCloseUp = cboCreationDateCloseUp
      ExplicitLeft = 484
      ExplicitTop = 66
      ExplicitWidth = 114
      ExplicitHeight = 23
    end
    inherited txtCustomID: TDBEdit
      Left = 731
      Top = 66
      Width = 114
      HelpContext = 45037
      TabOrder = 8
      ExplicitLeft = 731
      ExplicitTop = 66
      ExplicitWidth = 114
    end
    inherited txtInvNumber: TDBEdit
      Left = 241
      Top = 172
      Width = 114
      HelpContext = 45060
      TabOrder = 14
      OnExit = txtInvNumberExit
      ExplicitLeft = 241
      ExplicitTop = 172
      ExplicitWidth = 114
    end
    inherited cboTerms: TwwDBLookupCombo
      Left = 606
      Top = 172
      Width = 114
      HelpContext = 45061
      TabOrder = 9
      ExplicitLeft = 606
      ExplicitTop = 172
      ExplicitWidth = 114
    end
    inherited cboDueDate: TwwDBDateTimePicker
      Left = 606
      Top = 66
      Width = 114
      HelpContext = 45062
      TabOrder = 10
      ExplicitLeft = 606
      ExplicitTop = 66
      ExplicitWidth = 114
    end
    inherited cboAccount: TwwDBLookupCombo
      Left = 8
      HelpContext = 45063
      TabOrder = 0
      ExplicitLeft = 8
    end
    inherited cboEmployee: TwwDBLookupCombo
      Left = 484
      Top = 172
      Width = 114
      HelpContext = 45038
      TabOrder = 13
      ExplicitLeft = 484
      ExplicitTop = 172
      ExplicitWidth = 114
    end
    inherited btnNext: TDNMSpeedButton
      Left = 1002
      Top = 7
      HelpContext = 45039
      Font.Height = -12
      TabOrder = 16
      ExplicitLeft = 1002
      ExplicitTop = 7
    end
    inherited btnCompleted: TDNMSpeedButton
      Left = 1002
      Top = 40
      HelpContext = 45099
      Action = nil
      Caption = 'Save'
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      TabOrder = 17
      ExplicitLeft = 1002
      ExplicitTop = 40
    end
    inherited btnClose: TDNMSpeedButton
      Left = 1002
      Top = 74
      HelpContext = 45041
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      TabOrder = 18
      ExplicitLeft = 1002
      ExplicitTop = 74
    end
    inherited btnPreview: TDNMSpeedButton
      Left = 1002
      Top = 107
      HelpContext = 45042
      Font.Height = -12
      TabOrder = 19
      ExplicitLeft = 1002
      ExplicitTop = 107
    end
    inherited btnPrint: TDNMSpeedButton
      Left = 1002
      Top = 141
      HelpContext = 45043
      Action = nil
      Font.Height = -12
      TabOrder = 20
      OnClick = btnPrintClick
      ExplicitLeft = 1002
      ExplicitTop = 141
    end
    inherited pnlChooseRpt: TDNMPanel
      Left = 812
      Top = 172
      Width = 124
      HelpContext = 45044
      TabOrder = 21
      ExplicitLeft = 812
      ExplicitTop = 172
      ExplicitWidth = 124
      inherited chkChooseRpt: TCheckBox
        Left = 5
        Top = 3
        Width = 116
        HelpContext = 45046
        ExplicitLeft = 5
        ExplicitTop = 3
        ExplicitWidth = 116
      end
    end
    inherited btnContacts: TDNMSpeedButton
      Left = 211
      Top = 66
      HelpContext = 45047
      TabOrder = 2
      ExplicitLeft = 211
      ExplicitTop = 66
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo
      Left = 241
      Top = 66
      Width = 114
      HelpContext = 45049
      TabOrder = 5
      Visible = True
      ExplicitLeft = 241
      ExplicitTop = 66
      ExplicitWidth = 114
    end
    inherited edtBaseExchangeRate: TwwDBEdit
      Left = 362
      Top = 66
      Width = 114
      HelpContext = 45050
      TabOrder = 6
      Visible = True
      ExplicitLeft = 362
      ExplicitTop = 66
      ExplicitWidth = 114
    end
    inherited pnlTitle: TDNMPanel
      Left = 395
      Top = 3
      Width = 154
      Height = 44
      HelpContext = 45052
      Caption = 'Bill'
      TabOrder = 25
      ExplicitLeft = 395
      ExplicitTop = 3
      ExplicitWidth = 154
      ExplicitHeight = 44
      inherited TitleShader: TShader
        Width = 152
        Height = 42
        HelpContext = 45053
        ExplicitWidth = 152
        ExplicitHeight = 42
        inherited TitleLabel: TLabel
          Width = 152
          Height = 42
          HelpContext = 45054
          Caption = 'Bill'
          ExplicitWidth = 152
          ExplicitHeight = 42
        end
      end
    end
    object edtBillTotal: TEdit [40]
      Left = 612
      Top = 118
      Width = 93
      Height = 23
      HelpContext = 45067
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      OnExit = edtBillTotalExit
    end
    inherited cboClientR: TERPDbLookupCombo
      Left = 8
      Top = 66
      Width = 202
      HelpContext = 45100
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F')
      DataField = 'SupplierName'
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitTop = 66
      ExplicitWidth = 202
    end
    inherited btnPayments: TDNMSpeedButton
      Left = 871
      Top = 18
      HelpContext = 45071
      TabOrder = 26
      ExplicitLeft = 871
      ExplicitTop = 18
    end
    inherited cmdEmail: TDNMSpeedButton
      Left = 948
      Top = 24
      Width = 48
      HelpContext = 45101
      TabOrder = 22
      ExplicitLeft = 948
      ExplicitTop = 24
      ExplicitWidth = 48
    end
    inherited btnPDF: TDNMSpeedButton
      Left = 933
      Top = 144
      Width = 38
      HelpContext = 45102
      TabOrder = 23
      Visible = False
      ExplicitLeft = 933
      ExplicitTop = 144
      ExplicitWidth = 38
    end
    inherited btnEdit: TDNMSpeedButton
      Left = 883
      Top = 147
      TabOrder = 24
      ExplicitLeft = 883
      ExplicitTop = 147
    end
    inherited cboExpenseClaimEmployee: TwwDBLookupCombo
      Left = 564
      Top = 21
      HelpContext = 45064
      TabOrder = 4
      Visible = True
      ExplicitLeft = 564
      ExplicitTop = 21
    end
    inherited cboAreaCode: TwwDBLookupCombo
      Left = 741
      Top = 118
      Width = 91
      HelpContext = 45103
      DataSource = DSMaster
      TabOrder = 11
      ExplicitLeft = 741
      ExplicitTop = 118
      ExplicitWidth = 91
    end
    inherited btnfix: TButton
      Left = 241
      TabOrder = 27
      Visible = False
      ExplicitLeft = 241
    end
    object txtInvoiceNumber: TDBEdit
      Left = 362
      Top = 172
      Width = 114
      Height = 23
      HelpContext = 45104
      Color = clWhite
      DataField = 'RefNo'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
    end
    object pnlApprover: TDNMPanel
      Left = 364
      Top = 95
      Width = 233
      Height = 55
      HelpContext = 45105
      BevelInner = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 28
      object lblApprover: TLabel
        Left = 4
        Top = 9
        Width = 58
        Height = 15
        HelpContext = 45106
        AutoSize = False
        Caption = 'Approver'
      end
      object cboApprover: TwwDBLookupCombo
        Left = 66
        Top = 5
        Width = 160
        Height = 23
        HelpContext = 45107
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
        Left = 160
        Top = 34
        Width = 66
        Height = 17
        HelpContext = 45108
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
        Left = 4
        Top = 34
        Width = 76
        Height = 17
        HelpContext = 45023
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
    Left = 168
    Top = 14
  end
  inherited DSMaster: TDataSource
    Left = 9
  end
  inherited tblMaster: TERPQuery
    Left = 16
    Top = 355
    inherited tblMasterPurchaseOrderID: TAutoIncField
      AutoGenerateValue = arAutoInc
      Origin = 'tblpurchaseorders.PurchaseOrderID'
    end
    inherited tblMasterGlobalRef: TWideStringField
      Origin = 'tblpurchaseorders.GlobalRef'
    end
    inherited tblMasterPurchaseOrderNumber: TWideStringField
      Origin = 'tblpurchaseorders.PurchaseOrderNumber'
    end
    inherited tblMasterOriginalNo: TWideStringField
      Origin = 'tblpurchaseorders.OriginalNo'
      Size = 255
    end
    inherited tblMasterAccount: TWideStringField
      Origin = 'tblpurchaseorders.Account'
    end
    inherited tblMasterSupplierName: TWideStringField
      Origin = 'tblpurchaseorders.SupplierName'
    end
    inherited tblMasterOrderTo: TWideStringField
      Origin = 'tblpurchaseorders.OrderTo'
    end
    inherited tblMasterShipTo: TWideStringField
      Origin = 'tblpurchaseorders.ShipTo'
    end
    inherited tblMasterTotalTax: TFloatField
      Origin = 'tblpurchaseorders.TotalTax'
    end
    inherited tblMasterTotalAmount: TFloatField
      Origin = 'tblpurchaseorders.TotalAmount'
    end
    inherited tblMasterTotalAmountInc: TFloatField
      Origin = 'tblpurchaseorders.TotalAmountInc'
    end
    inherited tblMasterEmployeeName: TWideStringField
      Origin = 'tblpurchaseorders.EmployeeName'
    end
    inherited tblMasterInvoiceNumber: TWideStringField
      Origin = 'tblpurchaseorders.InvoiceNumber'
    end
    inherited tblMasterETADate: TDateField
      Origin = 'tblpurchaseorders.ETADate'
    end
    inherited tblMasterDueDate: TDateField
      Origin = 'tblpurchaseorders.DueDate'
    end
    inherited tblMasterComments: TWideStringField
      Origin = 'tblpurchaseorders.Comments'
    end
    inherited tblMasterSalesComments: TWideStringField
      Origin = 'tblpurchaseorders.SalesComments'
    end
    inherited tblMasterShipping: TWideStringField
      Origin = 'tblpurchaseorders.Shipping'
    end
    inherited tblMasterTerms: TWideStringField
      Origin = 'tblpurchaseorders.Terms'
    end
    inherited tblMasterPrintFlag: TWideStringField
      Origin = 'tblpurchaseorders.PrintFlag'
    end
    inherited tblMasterPaid: TWideStringField
      Origin = 'tblpurchaseorders.Paid'
    end
    inherited tblMasterBalance: TFloatField
      Origin = 'tblpurchaseorders.Balance'
    end
    inherited tblMasterPayment: TFloatField
      Origin = 'tblpurchaseorders.Payment'
    end
    inherited tblMasterApplyFlag: TWideStringField
      Origin = 'tblpurchaseorders.ApplyFlag'
    end
    inherited tblMasterAmountDue: TFloatField
      Origin = 'tblpurchaseorders.AmountDue'
    end
    inherited tblMasterPayMethod: TIntegerField
      Origin = 'tblpurchaseorders.PayMethod'
    end
    inherited tblMasterIsPO: TWideStringField
      Origin = 'tblpurchaseorders.IsPO'
    end
    inherited tblMasterIsRA: TWideStringField
      Origin = 'tblpurchaseorders.IsRA'
    end
    inherited tblMasterIsBill: TWideStringField
      Origin = 'tblpurchaseorders.IsBill'
    end
    inherited tblMasterIsCredit: TWideStringField
      Origin = 'tblpurchaseorders.IsCredit'
    end
    inherited tblMasterDeleted: TWideStringField
      Origin = 'tblpurchaseorders.Deleted'
    end
    inherited tblMasterEditedFlag: TWideStringField
      Origin = 'tblpurchaseorders.EditedFlag'
    end
    inherited tblMasterBOID: TWideStringField
      Origin = 'tblpurchaseorders.BOID'
    end
    inherited tblMasterAccountID: TIntegerField
      Origin = 'tblpurchaseorders.AccountID'
    end
    inherited tblMasterClientID: TIntegerField
      Origin = 'tblpurchaseorders.ClientID'
    end
    inherited tblMasterEmployeeID: TIntegerField
      Origin = 'tblpurchaseorders.EmployeeID'
    end
    inherited tblMasterIsCheque: TWideStringField
      Origin = 'tblpurchaseorders.IsCheque'
    end
    inherited tblMasterPrintedBy: TWideStringField
      Origin = 'tblpurchaseorders.PrintedBy'
    end
    inherited tblMasterEnteredBy: TWideStringField
      Origin = 'tblpurchaseorders.EnteredBy'
    end
    inherited tblMasterEnteredAt: TWideStringField
      Origin = 'tblpurchaseorders.EnteredAt'
    end
    inherited tblMasterRefNo: TWideStringField
      Origin = 'tblpurchaseorders.RefNo'
    end
    inherited tblMasterIsPOCredit: TWideStringField
      Origin = 'tblpurchaseorders.IsPOCredit'
    end
    inherited tblMasterInvoiceDate: TDateField
      Origin = 'tblpurchaseorders.InvoiceDate'
    end
    inherited tblMasterConNote: TWideStringField
      Origin = 'tblpurchaseorders.ConNote'
    end
    inherited tblMasterCustPONumber: TWideStringField
      Origin = 'tblpurchaseorders.CustPONumber'
    end
    inherited tblMasterLastUpdated: TDateTimeField
      Origin = 'tblpurchaseorders.LastUpdated'
    end
    inherited tblMasterSeqNo: TIntegerField
      Origin = 'tblpurchaseorders.SeqNo'
    end
    inherited tblMasterForeignExchangeCode: TWideStringField
      Origin = 'tblpurchaseorders.ForeignExchangeCode'
    end
    inherited tblMasterForeignExchangeRate: TFloatField
      Origin = 'tblpurchaseorders.ForeignExchangeRate'
      DisplayFormat = ',##0.0000'
    end
    inherited tblMasterForeignTotalAmount: TFloatField
      Origin = 'tblpurchaseorders.ForeignTotalAmount'
    end
    inherited tblMasterForeignPaidAmount: TFloatField
      Origin = 'tblpurchaseorders.ForeignPaidAmount'
    end
    inherited tblMasterForeignBalanceAmount: TFloatField
      Origin = 'tblpurchaseorders.ForeignBalanceAmount'
    end
    inherited tblMasterBaseNo: TWideStringField
      Origin = 'tblpurchaseorders.BaseNo'
    end
    inherited tblMasterExpenseClaimEmployee: TIntegerField
      Origin = 'tblpurchaseorders.ExpenseClaimEmployee'
    end
    inherited tblMasterOrderDate: TDateTimeField
      Origin = 'tblpurchaseorders.OrderDate'
    end
    inherited tblMasterContactID: TLargeintField
      Origin = 'tblpurchaseorders.contactID'
    end
    object tblMasterApproved: TWideStringField [58]
      FieldName = 'Approved'
      Origin = 'tblpurchaseorders.Approved'
      FixedChar = True
      Size = 1
    end
    inherited tblMasterContactName: TWideStringField
      Origin = 'tblpurchaseorders.ContactName'
    end
    object tblMasterApproverID: TIntegerField
      FieldName = 'ApproverID'
    end
  end
  inherited tblDetails: TERPQuery
    BeforeInsert = tblDetailsBeforeInsert
    AfterInsert = tblDetailsAfterInsert
    BeforeEdit = tblDetailsBeforeEdit
    AfterEdit = tblDetailsAfterEdit
    AfterPost = tblDetailsAfterPost
    BeforeCancel = tblDetailsBeforeCancel
    AfterCancel = tblDetailsAfterCancel
    BeforeScroll = tblDetailsBeforeScroll
    AfterScroll = tblDetailsAfterScroll
    Left = 29
    Top = 263
    inherited tblDetailsAccountNumber: TWideStringField
      Origin = 'tblpurchaselines.AccountNumber'
    end
    inherited tblDetailsAccountName: TWideStringField
      Origin = 'tblpurchaselines.AccountName'
    end
    inherited tblDetailsLineTaxCode: TWideStringField
      Origin = 'tblpurchaselines.LineTaxCode'
    end
    inherited tblDetailsLineCost: TFloatField
      Origin = 'tblpurchaselines.LineCost'
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
      DisplayLabel = 'Related'
      Origin = 'tblpurchaselines.RelatedPOID'
    end
    object tblDetailsShipContainerName: TWideStringField [9]
      DisplayLabel = 'Related Ship Container'
      DisplayWidth = 25
      FieldKind = fkLookup
      FieldName = 'ShipContainerName'
      LookupDataSet = qryShipContainerLookup
      LookupKeyFields = 'ShippingContainerID'
      LookupResultField = 'ContainerName'
      KeyFields = 'RelatedShipContainerID'
      Size = 255
      Lookup = True
    end
    inherited tblDetailsSortID: TIntegerField
      DisplayLabel = 'Sort ID'
      Origin = 'tblpurchaselines.SortID'
    end
    inherited tblDetailsLinesOrder: TIntegerField
      Origin = 'tblpurchaselines.LinesOrder'
    end
    inherited tblDetailsEquipmentName: TWideStringField
      Origin = 'tblpurchaselines.EquipmentName'
      Size = 100
    end
    inherited tblDetailsEmployeeName: TWideStringField [13]
      DisplayLabel = 'Employee'
      DisplayWidth = 20
      Origin = 'tblpurchaselines.EmployeeName'
    end
    inherited tblDetailsAreaCode: TWideStringField [14]
      Origin = 'tblpurchaselines.AreaCode'
    end
    inherited tblDetailsRepairDocNo: TStringField [15]
    end
    inherited tblDetailsExpenseProductSelected: TStringField [16]
    end
    object tblDetailsRelatedShipContainerID: TIntegerField [17]
      DisplayLabel = 'Related Ship Container'
      DisplayWidth = 20
      FieldName = 'RelatedShipContainerID'
      Origin = 'tblpurchaselines.RelatedShipContainerID'
      Visible = False
    end
    inherited tblDetailsLineCostInc: TFloatField [18]
      Origin = 'tblpurchaselines.LineCostInc'
      OnSetText = FeldSetTextDontAllowNulls
    end
    inherited tblDetailsPurchaseLineID: TAutoIncField [19]
      AutoGenerateValue = arAutoInc
      Origin = 'tblpurchaselines.PurchaseLineID'
    end
    inherited tblDetailsGlobalRef: TWideStringField [20]
      Origin = 'tblpurchaselines.GlobalRef'
    end
    inherited tblDetailsPurchaseOrderID: TIntegerField [21]
      Origin = 'tblpurchaselines.PurchaseOrderID'
    end
    inherited tblDetailsCogsAccnt: TWideStringField [22]
      Origin = 'tblpurchaselines.COGSACCNT'
    end
    inherited tblDetailsClassID: TIntegerField [23]
      Origin = 'tblpurchaselines.ClassID'
    end
    inherited tblDetailsProductGroup: TWideStringField [24]
      Origin = 'tblpurchaselines.ProductGroup'
    end
    inherited tblDetailsProductName: TWideStringField [25]
      Origin = 'tblpurchaselines.ProductName'
    end
    inherited tblDetailsLineTaxRate: TFloatField [26]
      Origin = 'tblpurchaselines.LineTaxRate'
    end
    inherited tblDetailsQtySold: TFloatField [27]
      Origin = 'tblpurchaselines.QtySold'
    end
    inherited tblDetailsShipped: TFloatField [28]
      Origin = 'tblpurchaselines.Shipped'
    end
    inherited tblDetailsBackOrder: TFloatField [29]
      Origin = 'tblpurchaselines.BackOrder'
    end
    inherited tblDetailsInvoiced: TWideStringField [30]
      Origin = 'tblpurchaselines.Invoiced'
    end
    inherited tblDetailsRAQty: TFloatField [31]
      Origin = 'tblpurchaselines.RAQty'
    end
    inherited tblDetailsRAstatus: TWideStringField [32]
      Origin = 'tblpurchaselines.RAstatus'
      Size = 255
    end
    inherited tblDetailsBatch: TWideStringField [33]
      Origin = 'tblpurchaselines.Batch'
    end
    inherited tblDetailsUseTimecost: TWideStringField [34]
      Origin = 'tblpurchaselines.UseTimecost'
    end
    inherited tblDetailsSaleID_Timecost: TIntegerField [35]
      Origin = 'tblpurchaselines.SaleID_Timecost'
    end
    inherited tblDetailsTimecostMarkupPer: TFloatField [36]
      Origin = 'tblpurchaselines.TimecostMarkupPer'
    end
    inherited tblDetailsTimecostPrice: TFloatField [37]
      Origin = 'tblpurchaselines.TimecostPrice'
    end
    inherited tblDetailsTimecostMarkupDol: TFloatField [38]
      Origin = 'tblpurchaselines.TimecostMarkupDol'
    end
    inherited tblDetailsTotalLineAmount: TFloatField [39]
      Origin = 'tblpurchaselines.TotalLineAmount'
      OnSetText = FeldSetTextDontAllowNulls
    end
    inherited tblDetailsTotalLineAmountInc: TFloatField [40]
      Origin = 'tblpurchaselines.TotalLineAmountInc'
      OnSetText = FeldSetTextDontAllowNulls
    end
    inherited tblDetailsEditedFlag: TWideStringField [41]
      Origin = 'tblpurchaselines.EditedFlag'
    end
    inherited tblDetailsDeleted: TWideStringField [42]
      Origin = 'tblpurchaselines.Deleted'
    end
    inherited tblDetailsRAInvoiceNo: TWideStringField [43]
      Origin = 'tblpurchaselines.RAInvoiceNo'
    end
    inherited tblDetailsAccountGroup: TWideStringField [44]
      Origin = 'tblpurchaselines.AccountGroup'
    end
    inherited tblDetailsProductID: TIntegerField [45]
      Origin = 'tblpurchaselines.ProductID'
    end
    inherited tblDetailsPartType: TWideStringField [46]
      Origin = 'tblpurchaselines.PARTTYPE'
    end
    inherited tblDetailsIncomeAccnt: TWideStringField [47]
      Origin = 'tblpurchaselines.INCOMEACCNT'
    end
    inherited tblDetailsAssetAccnt: TWideStringField [48]
      Origin = 'tblpurchaselines.ASSETACCNT'
    end
    inherited tblDetailsCalcPriceInc: TCurrencyField [49]
    end
    inherited tblDetailsCalcTotalInc: TCurrencyField [50]
    end
    inherited tblDetailsCalcTotalEx: TCurrencyField [51]
    end
    inherited tblDetailsCalcTax: TCurrencyField [52]
    end
    inherited tblDetailsAvgCost: TFloatField [53]
      Origin = 'tblpurchaselines.AvgCost'
    end
    inherited tblDetailsCustomerJobID: TIntegerField [54]
      Origin = 'tblpurchaselines.CustomerJobID'
    end
    inherited tblDetailsCOGSTotalLineAmount: TFloatField [55]
      Origin = 'tblpurchaselines.COGSTotalLineAmount'
    end
    inherited tblDetailsCOGSTotalLineAmountInc: TFloatField [56]
      Origin = 'tblpurchaselines.COGSTotalLineAmountInc'
    end
    inherited tblDetailsAttrib1Purchase: TFloatField [57]
      Origin = 'tblpurchaselines.Attrib1Purchase'
    end
    inherited tblDetailsAttrib2Purchase: TFloatField [58]
      Origin = 'tblpurchaselines.Attrib2Purchase'
    end
    inherited tblDetailsAttrib1PurchaseRate: TFloatField [59]
      Origin = 'tblpurchaselines.Attrib1PurchaseRate'
    end
    inherited tblDetailsLastLineID: TIntegerField [60]
      Origin = 'tblpurchaselines.LastLineID'
    end
    inherited tblDetailsForeignExchangeRate: TFloatField [61]
      Origin = 'tblpurchaselines.ForeignExchangeRate'
    end
    inherited tblDetailsForeignExchangeCode: TWideStringField [62]
      Origin = 'tblpurchaselines.ForeignExchangeCode'
    end
    inherited tblDetailsForeignCurrencyLineCost: TFloatField [63]
      Origin = 'tblpurchaselines.ForeignCurrencyLineCost'
    end
    inherited tblDetailsUnitofMeasureQtySold: TFloatField [64]
      Origin = 'tblpurchaselines.UnitofMeasureQtySold'
    end
    inherited tblDetailsUnitofMeasureShipped: TFloatField [65]
      Origin = 'tblpurchaselines.UnitofMeasureShipped'
    end
    inherited tblDetailsUnitofMeasureBackorder: TFloatField [66]
      Origin = 'tblpurchaselines.UnitofMeasureBackorder'
    end
    inherited tblDetailsUnitofMeasureMultiplier: TFloatField [67]
      Origin = 'tblpurchaselines.UnitofMeasureMultiplier'
    end
    inherited tblDetailsLandedCostsPerItem: TFloatField [68]
      Origin = 'tblpurchaselines.LandedCostsPerItem'
    end
    inherited tblDetailsRelatedPOIDUsed: TWideStringField [69]
      Origin = 'tblpurchaselines.RelatedPOIDUsed'
    end
    inherited tblDetailsUnitofMeasurePOLines: TWideStringField [70]
      Origin = 'tblpurchaselines.UnitofMeasurePOLines'
    end
    inherited tblDetailsSearchFilter: TWideStringField [71]
      Origin = 'tblpurchaselines.SearchFilter'
    end
    inherited tblDetailsSearchFilterCopy: TWideStringField [72]
      Origin = 'tblpurchaselines.SearchFilterCopy'
    end
    inherited tblDetailsReceivedDate: TDateField [73]
      Origin = 'tblpurchaselines.ReceivedDate'
    end
    inherited tblDetailsLandedCostsPercentage: TFloatField [74]
      Origin = 'tblpurchaselines.LandedCostsPercentage'
      OnSetText = FeldSetTextDontAllowNulls
    end
    inherited tblDetailsLandedCostsTotal: TFloatField [75]
      Origin = 'tblpurchaselines.LandedCostsTotal'
      OnSetText = FeldSetTextDontAllowNulls
    end
    inherited tblDetailsserialno: TWideMemoField [76]
      Origin = 'tblpurchaselines.serialno'
    end
    inherited tblDetailsForeignTotalLineAmount: TFloatField [77]
      Origin = 'tblpurchaselines.ForeignTotalLineAmount'
      OnSetText = FeldSetTextDontAllowNulls
    end
    inherited tblDetailsNewForeignExchangeRate: TFloatField [78]
      Origin = 'tblpurchaselines.NewForeignExchangeRate'
    end
    inherited tblDetailsUnitOfMeasureID: TIntegerField [79]
      Origin = 'tblpurchaselines.UnitOfMeasureID'
    end
    inherited tblDetailsSEQNo: TIntegerField [80]
      Origin = 'tblpurchaselines.SEQNo'
    end
    inherited tblDetailsRepairId: TIntegerField [81]
      Origin = 'tblpurchaselines.RepairId'
    end
    inherited tblDetailsCustomerEquipmentID: TIntegerField [82]
      Origin = 'tblpurchaselines.CustomerEquipmentID'
    end
    inherited tblDetailsEmployeeID: TIntegerField [83]
      Origin = 'tblpurchaselines.EmployeeID'
      Visible = False
    end
    inherited tblDetailsExpenseProductID: TIntegerField
      Origin = 'tblpurchaselines.ExpenseProductID'
    end
    inherited tblDetailsExpenseProductName: TWideStringField
      Origin = 'tblpurchaselines.ExpenseProductName'
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
      'WHERE Supplier = '#39'T'#39
      'AND tblclients.ClientID= :xClientID'
      'Order By Company')
    Left = 81
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
  end
  inherited qryBaseForeignCurrency: TERPQuery
    Left = 474
    Top = 375
  end
  inherited imgPopup: TImageList
    Top = 5
    Bitmap = {
      494C01010200DC00AC0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Database = 'aus_sample_company'
    Connected = True
  end
  inherited DataState: TDataState
    Left = 168
    Top = 38
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200E400B40110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 246
    Top = 379
  end
  inherited cboAccountQry: TERPQuery
    Left = 213
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
        '(Left(ifnull(AccountGroup,""),17) <> "Retained Earnings") '
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (((AccountName LIKE Concat(:SearchValu' +
        'e,"%")) or (tblacctypedesc.AccDesc LIKE Concat(:SearchValue,"%")' +
        ') or (tblacctypedesc.AccDesc LIKE Concat(:SearchValue,"%")))) )'
      
        'or ((:SearchMode = 2) and (((AccountName LIKE Concat("%",:Search' +
        'Value,"%")) or (tblacctypedesc.AccDesc LIKE Concat("%",:SearchVa' +
        'lue,"%")) or (tblacctypedesc.AccDesc LIKE Concat("%",:SearchValu' +
        'e,"%"))))))'
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
    inherited cboAccountLinesQryAccountNumber: TWideStringField [5]
    end
    inherited cboAccountLinesQryAccountTree: TWideStringField [6]
    end
  end
  object qryShipContainerLookup: TERPQuery [37]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ContainerName , ShippingContainerID '
      'FROM tblshippingcontainer'
      'WHERE Active = "T"'
      '/* and'
      '(((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((ContainerName  LIKE Concat(:SearchVa' +
        'lue,"%"))     Or  (convert (shippingcontainerid, CHAR) LIKE Conc' +
        'at(:SearchValue,"%"))      ))'
      
        'or ((:SearchMode = 2) and ((ContainerName  LIKE Concat("%",:Sear' +
        'chValue,"%")) Or  (convert (shippingcontainerid, CHAR) LIKE Conc' +
        'at("%",:SearchValue,"%"))  )))'
      'and IfNull(:SearchValue,"") <> "" */'
      'ORDER BY ContainerName')
    Active = True
    Left = 632
    Top = 280
    object qryShipContainerLookupContainerName: TWideStringField
      DisplayLabel = 'Container Name'
      DisplayWidth = 20
      FieldName = 'ContainerName'
      Origin = 'tblshippingcontainer.ContainerName'
      Size = 255
    end
    object qryShipContainerLookupShippingContainerID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Container ID'
      DisplayWidth = 10
      FieldName = 'ShippingContainerID'
      Origin = 'tblshippingcontainer.ShippingContainerID'
    end
  end
  inherited qryRepairLookup: TERPQuery
    Active = True
    inherited qryRepairLookupRepairDocNo: TWideStringField
      Origin = 'tblrepairs.RepairDocNo'
    end
    inherited qryRepairLookupCustomerName: TWideStringField
      Origin = 'tblrepairs.CustomerName'
    end
    inherited qryRepairLookupRepairID: TIntegerField
      AutoGenerateValue = arAutoInc
      Origin = 'tblrepairs.RepairID'
    end
  end
  inherited QryAreaCodeLk: TERPQuery
    inherited QryAreaCodeLkAreaCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 20
    end
    inherited QryAreaCodeLkAreaName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
    end
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 256
    Top = 232
  end
  inherited SaveDialog1: TSaveDialog
    Left = 269
    Top = 290
  end
  inherited qryMemTrans: TERPQuery
    Left = 385
    Top = 378
  end
  inherited qryImportedPOIDs: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT P.PurchaseOrderID,P.PurchaseOrderNumber ,SupplierName'
      'FROM tblpurchaseorders P'
      
        'inner join tblclients C on P.ClientID = C.ClientID and C.ShowInS' +
        'hipContainers="T" #dene asked to filter list for the suppliers w' +
        'ith show in shiping container turned on'
      
        'left join tblPurchaseLines pol on pol.RelatedPOId = p.PurchaseOr' +
        'derId'
      'Where IsPO = "T"'
      'and P.Deleted = "F"'
      
        '#And P.ForeignExchangeCode <> :LocalFXCode  # Dene asked to remo' +
        've this as he wants all teh Purchase Orders to appear in the lis' +
        't'
      'and (ifnull(pol.PurchaseLineId, 0) = 0'
      'or pol.RelatedPoIdUsed = "F")'
      'Group By P.PurchaseOrderID;')
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
  object qryRelatedContLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ShippingContainerID , ContainerName'
      'FROM tblshippingcontainer'
      'WHERE Active = "T"'
      ' and'
      '(((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((ContainerName  LIKE Concat(:SearchVa' +
        'lue,"%"))     Or  (convert (shippingcontainerid, CHAR) LIKE Conc' +
        'at(:SearchValue,"%"))      ))'
      
        'or ((:SearchMode = 2) and ((ContainerName  LIKE Concat("%",:Sear' +
        'chValue,"%")) Or  (convert (shippingcontainerid, CHAR) LIKE Conc' +
        'at("%",:SearchValue,"%"))  )))'
      'and IfNull(:SearchValue,"") <> "" '
      'ORDER BY ContainerName')
    Active = True
    Left = 848
    Top = 272
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
      end>
    object qryRelatedContLookupContainerName: TWideStringField
      DisplayLabel = 'Container Name'
      DisplayWidth = 20
      FieldName = 'ContainerName'
      Origin = 'tblshippingcontainer.ContainerName'
      Size = 255
    end
    object qryRelatedContLookupShippingContainerID: TIntegerField
      Alignment = taLeftJustify
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Container ID'
      DisplayWidth = 10
      FieldName = 'ShippingContainerID'
      Origin = 'tblshippingcontainer.ShippingContainerID'
    end
  end
end
