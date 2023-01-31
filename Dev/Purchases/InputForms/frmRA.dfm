inherited ReturnAGUI: TReturnAGUI
  Left = 333
  Top = 147
  HelpContext = 474000
  Caption = 'Return Authority'
  ClientHeight = 564
  ClientWidth = 838
  ExplicitLeft = 333
  ExplicitTop = 147
  ExplicitWidth = 854
  ExplicitHeight = 603
  DesignSize = (
    838
    564)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 468
    Width = 838
    HelpContext = 474086
    ExplicitTop = 564
    ExplicitWidth = 838
  end
  inherited imgGridWatermark: TImage
    HelpContext = 474001
  end
  inherited pnlDetail: TDNMPanel
    Top = 210
    Width = 838
    Height = 258
    HelpContext = 474066
    Align = alClient
    ExplicitTop = 210
    ExplicitWidth = 838
    ExplicitHeight = 258
    inherited grdTransactions: TwwDBGrid
      Width = 838
      Height = 258
      HelpContext = 474068
      ControlType.Strings = (
        'ProductName;CustomEdit;cboProductR;F'
        'CustomerJob;CustomEdit;cboCustJob;F'
        'Class;CustomEdit;cboClass;F'
        'LineTaxCode;CustomEdit;cboTaxCode;F'
        'RAstatus;CustomEdit;cboStatus;F'
        'SearchFilter;CustomEdit;txtSearchFilter;T'
        'UnitofMeasurePOLines;CustomEdit;cboUnitOfMeasure;F'
        'MemoLine;CustomEdit;edtMemoLine;F'
        'RepairDocNo;CustomEdit;cboRepairDocNo;F'
        'EmployeeName;CustomEdit;cboLineEmployee;F'
        'AreaCode;CustomEdit;cboLinesAreaCode;F')
      Selected.Strings = (
        'ProductName'#9'17'#9'Name'#9'F'#9
        'UnitofMeasurePOLines'#9'20'#9'Units'#9'F'#9
        'RAQty'#9'10'#9'Qty'#9'F'#9
        'Attrib1Purchase'#9'16'#9'Metres'#9'F'#9
        'Attrib2Purchase'#9'16'#9'Weight'#9'F'#9
        'Attrib1PurchaseRate'#9'16'#9'Metres'#9'F'#9
        'LineTaxCode'#9'15'#9'Code'#9'F'#9
        'LineTax'#9'10'#9'Tax (Dbl Click)'#9'F'#9
        'CustomerJob'#9'20'#9'Customer / Job'#9'F'#9
        'RAInvoiceNo'#9'11'#9'Invoice'#9'F'#9
        'Product_Description'#9'20'#9'Fault Description'#9'F'#9
        'serialno'#9'10'#9'Serial'#9'F'#9
        'Class'#9'20'#9'Class'#9'F'#9
        'RAstatus'#9'20'#9'Status'#9'F'#9
        'LineCost'#9'10'#9'Cost (Ex)'#9'F'#9
        'TotalLineAmountInc'#9'10'#9'Amount (Inc)'#9#9
        'PQA'#9'1'#9'Allocation'#9'F'#9
        'UnitOfMeasureID'#9'10'#9'UnitOfMeasureID'#9'F'#9
        'SortID'#9'10'#9'SortID'#9'F'#9
        'MemoLine'#9'10'#9'Memo Line'#9'F'#9
        'CustomField6'#9'20'#9'CustomField6'#9'F'#9
        'CustomField7'#9'20'#9'CustomField7'#9'F'#9
        'CustomField8'#9'20'#9'CustomField8'#9'F'#9
        'CustomField9'#9'20'#9'CustomField9'#9'F'#9
        'CustomField10'#9'20'#9'CustomField10'#9'F'#9
        'CustomField1'#9'20'#9'CustomField1'#9'F'#9
        'CustomField2'#9'20'#9'CustomField2'#9'F'#9
        'CustomField3'#9'20'#9'CustomField3'#9'F'#9
        'CustomField4'#9'20'#9'CustomField4'#9'F'#9
        'CustomField5'#9'20'#9'CustomField5'#9'F'#9
        'ReceivedDate'#9'18'#9'Receive On'#9'F'#9
        'LandedCostsPerItem'#9'10'#9'Landed Cost/Item'#9'F'#9
        'LandedCostsPercentage'#9'10'#9'Landed Cost %'#9'F'#9
        'TotalLineLandedCost'#9'10'#9'Landed Cost'#9'F'#9
        'PartBarcode'#9'10'#9'Product Barcode'#9'F'#9
        'OriginalCost'#9'10'#9'OriginalCost'#9'F'#9
        'UOM_Height'#9'10'#9'Height'#9'F'#9
        'UOM_Width'#9'10'#9'Width'#9'F'#9
        'UOM_Length'#9'10'#9'Length'#9'F'#9
        'UOM_Weight'#9'10'#9'Weight'#9'F'#9
        'TotalUOM_WeightSold'#9'10'#9'Total Sold Weight'#9'F'#9
        'TotalUOM_WeightShipped'#9'10'#9'Total Shipped Weight'#9'F'#9
        'TotalUOM_WeightBO'#9'10'#9'Total BO Weight'#9'F'#9
        'UOM_Volume'#9'10'#9'Volume'#9'F'#9
        'RepairDocNo'#9'12'#9'Repair #'#9'F'#9
        'SEQNo'#9'10'#9'SEQNo'#9'F'#9
        'Product_custFld1'#9'20'#9'Product_custFld1'#9'F'#9
        'Product_custFld2'#9'20'#9'Product_custFld2'#9'F'#9
        'Product_custFld3'#9'20'#9'Product_custFld3'#9'F'#9
        'Product_custFld4'#9'20'#9'Product_custFld4'#9'F'#9
        'Product_custFld5'#9'20'#9'Product_custFld5'#9'F'#9
        'Product_custFld6'#9'20'#9'Product_custFld6'#9'F'#9
        'Product_custFld7'#9'20'#9'Product_custFld7'#9'F'#9
        'Product_custFld8'#9'20'#9'Product_custFld8'#9'F'#9
        'Product_custFld9'#9'20'#9'Product_custFld9'#9'F'#9
        'Product_custFld10'#9'20'#9'Product_custFld10'#9'F'#9
        'Product_custFld11'#9'20'#9'Product_custFld11'#9'F'#9
        'Product_custFld12'#9'20'#9'Product_custFld12'#9'F'#9
        'Product_custFld13'#9'20'#9'Product_custFld13'#9'F'#9
        'Product_custFld14'#9'20'#9'Product_custFld14'#9'F'#9
        'Product_custFld15'#9'20'#9'Product_custFld15'#9'F'#9
        'Product_custDate1'#9'18'#9'Product_custDate1'#9'F'#9
        'Product_custDate2'#9'18'#9'Product_custDate2'#9'F'#9
        'Product_custDate3'#9'18'#9'Product_custDate3'#9'F'#9
        'FormulaQtySoldValue1'#9'10'#9'FormulaQtySoldValue1'#9'F'#9
        'FormulaQtySoldValue2'#9'10'#9'FormulaQtySoldValue2'#9'F'#9
        'FormulaQtySoldValue3'#9'10'#9'FormulaQtySoldValue3'#9'F'#9
        'FormulaQtySoldValue4'#9'10'#9'FormulaQtySoldValue4'#9'F'#9
        'FormulaQtySoldValue5'#9'10'#9'FormulaQtySoldValue5'#9'F'#9
        'FormulaQtyShippedValue1'#9'10'#9'FormulaQtyShippedValue1'#9'F'#9
        'FormulaQtyShippedValue2'#9'10'#9'FormulaQtyShippedValue2'#9'F'#9
        'FormulaQtyShippedValue3'#9'10'#9'FormulaQtyShippedValue3'#9'F'#9
        'FormulaQtyShippedValue4'#9'10'#9'FormulaQtyShippedValue4'#9'F'#9
        'FormulaQtyShippedValue5'#9'10'#9'FormulaQtyShippedValue5'#9'F'#9
        'FormulaQtySoldValue'#9'10'#9'FormulaQtySoldValue'#9'F'#9
        'FormulaQtyShippedValue'#9'10'#9'FormulaQtyShippedValue'#9'F'#9
        'Attrib1PurchaseEst'#9'10'#9'Attrib1PurchaseEst'#9'F'#9
        'Attrib2PurchaseEst'#9'10'#9'Metres'#9'F'#9
        'EmployeeName'#9'20'#9'Employee'#9'F'#9
        'AreaCode'#9'10'#9'Area'#9'F'#9
        'LinesOrder'#9'10'#9'Order by'#9'F'#9
        'TotalUOM_LengthSold'#9'10'#9'Total Sold Length'#9'F'#9
        'TotalUOM_LengthShipped'#9'10'#9'Total Shipped Length'#9'F'#9
        'TotalUOM_LengthBO'#9'10'#9'Total BO Length'#9'F'#9
        'ForeignUOMLineCost'#9'10'#9'Foreign UOM Cost'#9'F'#9
        'ProductPrintName'#9'20'#9'ProductPrintName'#9'F'#9)
      ExplicitWidth = 838
      ExplicitHeight = 258
    end
    inherited cboClass: TwwDBLookupCombo
      Left = 277
      Top = 38
      ExplicitLeft = 277
      ExplicitTop = 38
    end
    inherited cboTaxCode: TERPDbLookupCombo
      Left = 58
      Top = 38
      TabOrder = 16
      ExplicitLeft = 58
      ExplicitTop = 38
    end
    inherited cboForeignCurrencyCode: TwwDBLookupCombo
      Left = 387
      Top = 38
      HelpContext = 474080
      Visible = False
      ExplicitLeft = 387
      ExplicitTop = 38
    end
    inherited cboUnitOfMeasure: TwwDBLookupCombo
      Left = 133
      Top = 126
      Visible = False
      ExplicitLeft = 133
      ExplicitTop = 126
    end
    inherited txtSearchFilter: TwwDBEdit
      Left = 441
      Top = 38
      TabOrder = 12
      ExplicitLeft = 441
      ExplicitTop = 38
    end
    inherited cboPartSpecs: TwwDBLookupCombo
      Left = 715
      Top = 38
      HelpContext = 474081
      Visible = False
      ExplicitLeft = 715
      ExplicitTop = 38
    end
    inherited cboProductR: TERPDbLookupCombo
      Top = 38
      ExplicitTop = 38
    end
    inherited cboEquipmentName: TwwDBLookupCombo
      Left = 496
      Top = 38
      ExplicitLeft = 496
      ExplicitTop = 38
    end
    inherited edtMemoLine: TwwDBEdit
      Left = 660
      Top = 38
      ExplicitLeft = 660
      ExplicitTop = 38
    end
    inherited cboRepairDocNo: TwwDBLookupCombo
      Top = 38
      ExplicitTop = 38
    end
    inherited cboLineEmployee: TwwDBLookupCombo
      Left = 113
      Top = 38
      Width = 65
      Height = 26
      HelpContext = 474094
      ExplicitLeft = 113
      ExplicitTop = 38
      ExplicitWidth = 65
      ExplicitHeight = 26
    end
    inherited cboLinesAreaCode: TwwDBLookupCombo
      Left = 605
      Top = 38
      ExplicitLeft = 605
      ExplicitTop = 38
    end
    inherited cboPrintProductR: TERPDbLookupCombo
      Left = 332
      Top = 38
      ExplicitLeft = 332
      ExplicitTop = 38
    end
    inherited cboCustJob: TERPDbLookupCombo
      Left = 222
      Top = 38
      TabOrder = 14
      ExplicitLeft = 222
      ExplicitTop = 38
    end
    inherited cboCustPrintJob: TERPDbLookupCombo
      Left = 551
      Top = 38
      TabOrder = 15
      ExplicitLeft = 551
      ExplicitTop = 38
    end
    object cboStatus: TwwDBComboBox
      Left = 168
      Top = 38
      Width = 65
      Height = 26
      HelpContext = 474085
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      AutoDropDown = True
      AutoFillDate = False
      DataField = 'RAstatus'
      DataSource = DSDetails
      DropDownCount = 8
      ItemHeight = 0
      Items.Strings = (
        'Awaiting RA No.'
        'In Transit'
        'Returned'
        'Send To Supplier'
        'Testing'
        'With Supplier')
      Sorted = False
      TabOrder = 4
      UnboundDataType = wwDefault
    end
  end
  inherited pnlFooter: TDNMPanel
    Top = 468
    Width = 838
    Height = 96
    HelpContext = 474002
    Align = alBottom
    ExplicitTop = 468
    ExplicitWidth = 838
    ExplicitHeight = 96
    DesignSize = (
      838
      96)
    inherited lblComments: TLabel
      Left = 6
      Top = 0
      HelpContext = 474004
      Visible = False
      ExplicitLeft = 6
      ExplicitTop = 0
    end
    inherited Label142: TLabel
      Left = 657
      Top = 16
      HelpContext = 474005
      ExplicitLeft = 657
      ExplicitTop = 12
    end
    inherited Label54: TLabel
      Left = 658
      Top = 40
      HelpContext = 474006
      ExplicitLeft = 658
      ExplicitTop = 36
    end
    inherited Label56: TLabel
      Left = 657
      Top = 69
      Width = 47
      HelpContext = 474007
      Caption = 'Total'
      ExplicitLeft = 657
      ExplicitTop = 69
      ExplicitWidth = 47
    end
    inherited lblBaseForeignTotal: TLabel
      Left = 467
      Top = 69
      HelpContext = 474011
      Alignment = taRightJustify
      ExplicitLeft = 467
      ExplicitTop = 69
    end
    object Label7: TLabel [5]
      Left = 494
      Top = 44
      Width = 54
      Height = 15
      HelpContext = 474090
      Alignment = taRightJustify
      Caption = 'Con. Note'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    inherited pnlComments: TDNMPanel
      Height = 94
      HelpContext = 474091
      ExplicitHeight = 94
      inherited LblCommentsHint: TLabel
        Top = 75
        ExplicitTop = 75
      end
      inherited txtComments: TDBMemo
        Height = 74
        HelpContext = 474013
        ExplicitHeight = 74
      end
    end
    inherited txtSubTotal: TDBEdit
      Left = 723
      Top = 12
      HelpContext = 474014
      TabOrder = 10
      ExplicitLeft = 723
      ExplicitTop = 12
    end
    inherited txtTotalTax: TDBEdit
      Left = 723
      Top = 37
      HelpContext = 474015
      TabOrder = 4
      ExplicitLeft = 723
      ExplicitTop = 37
    end
    inherited txtTotalAmount: TDBEdit
      Left = 709
      Top = 63
      HelpContext = 474016
      TabOrder = 3
      ExplicitLeft = 709
      ExplicitTop = 63
    end
    inherited edtBaseForeignTotal: TDBEdit
      Left = 553
      Top = 66
      HelpContext = 474017
      TabOrder = 1
      ExplicitLeft = 553
      ExplicitTop = 66
    end
    inherited lblDisableCalc: TDNMSpeedButton
      Left = 558
      Top = 6
      ExplicitLeft = 558
      ExplicitTop = 6
    end
    inherited DNMPanel5: TDNMPanel
      Left = 318
      Height = 96
      HelpContext = 474092
      ExplicitLeft = 318
      ExplicitHeight = 96
      inherited lblEnteredbyHead: TLabel
        Left = 8
        Top = 3
        ExplicitLeft = 8
        ExplicitTop = 3
      end
      inherited lblEnteredBy: TDBText
        Left = 75
        Top = 3
        ExplicitLeft = 75
        ExplicitTop = 3
      end
      inherited lblPrintHead: TLabel
        Left = 8
        Top = 39
        ExplicitLeft = 8
        ExplicitTop = 39
      end
      inherited lblPrintedBy: TLabel
        Left = 75
        Top = 39
        ExplicitLeft = 75
        ExplicitTop = 39
      end
      inherited lblPrintedOnCaption: TLabel
        Left = 8
        Top = 57
        ExplicitLeft = 8
        ExplicitTop = 57
      end
      inherited lblPrintedOn: TLabel
        Left = 75
        Top = 57
        ExplicitLeft = 75
        ExplicitTop = 57
      end
      inherited lblPrintedAtCaption: TLabel
        Left = 8
        Top = 75
        ExplicitLeft = 8
        ExplicitTop = 75
      end
      inherited lblPrintedAt: TLabel
        Left = 75
        Top = 75
        ExplicitLeft = 75
        ExplicitTop = 75
      end
      inherited lblEnteredAtHead: TLabel
        Left = 8
        Top = 21
        ExplicitLeft = 8
        ExplicitTop = 21
      end
      inherited lblEnteredAt: TDBText
        Left = 75
        Top = 21
        ExplicitLeft = 75
        ExplicitTop = 21
      end
    end
    inherited lblEmail: TDNMPanel
      Left = 481
      Top = 1
      HelpContext = 474095
      ExplicitLeft = 481
      ExplicitTop = 1
      inherited lblEmailMsg: TLabel
        Left = 10
        Top = 2
        ExplicitLeft = 10
        ExplicitTop = 2
      end
    end
    inherited btnAttachments: TDNMSpeedButton [14]
      Left = 6
      HelpContext = 474020
      TabOrder = 0
      ExplicitLeft = 6
    end
    object txtConsignmentNotes: TDBMemo [15]
      Left = 553
      Top = 40
      Width = 105
      Height = 23
      Hint = '"You can type a note for the consignment here."'
      HelpContext = 474093
      DataField = 'ConNote'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnDblClick = txtCommentsDblClick
    end
    inherited pnlProcessMessage: TDNMPanel [16]
      Width = 838
      HelpContext = 474096
      ExplicitWidth = 838
      inherited lblProcessMessage: TLabel
        Width = 834
        HelpContext = 474067
        ExplicitLeft = 184
        ExplicitWidth = 652
      end
    end
  end
  inherited pnlHeader: TDNMPanel
    Width = 838
    Height = 210
    HelpContext = 474022
    ParentColor = True
    ExplicitWidth = 838
    ExplicitHeight = 210
    DesignSize = (
      838
      210)
    object Bevel1: TBevel [0]
      Left = 240
      Top = 52
      Width = 494
      Height = 143
      HelpContext = 474065
    end
    inherited lblClientDetails: TLabel [1]
      Left = 8
      HelpContext = 474024
      Caption = 'Return To'
      ExplicitLeft = 8
    end
    inherited Label38: TLabel [2]
      Left = 8
      HelpContext = 474023
      ExplicitLeft = 8
    end
    inherited Label47: TLabel [3]
      Left = 504
      Top = 7
      Width = 20
      HelpContext = 474054
      Visible = False
      ExplicitLeft = 504
      ExplicitTop = 7
      ExplicitWidth = 20
    end
    inherited lblAccount: TLabel [4]
      Left = 8
      HelpContext = 474057
      ExplicitLeft = 8
    end
    inherited SaleDate_Label: TLabel [5]
      Left = 370
      Top = 56
      Width = 69
      HelpContext = 474025
      ExplicitLeft = 370
      ExplicitTop = 56
      ExplicitWidth = 69
    end
    inherited Label43: TLabel [6]
      Left = 370
      Top = 104
      Width = 167
      Height = 19
      HelpContext = 474053
      Alignment = taLeftJustify
      Caption = 'Supplier'#39's RA Number'
      ExplicitLeft = 370
      ExplicitTop = 104
      ExplicitWidth = 167
      ExplicitHeight = 19
    end
    inherited Label48: TLabel [7]
      Left = 571
      Top = 104
      Width = 101
      HelpContext = 474027
      Caption = 'Employee'
      ExplicitLeft = 571
      ExplicitTop = 104
      ExplicitWidth = 101
    end
    inherited Label79: TLabel [8]
      Left = 370
      Top = 148
      Height = 14
      HelpContext = 474055
      ExplicitLeft = 370
      ExplicitTop = 148
      ExplicitHeight = 14
    end
    inherited Label45: TLabel [9]
      Left = 610
      Top = 149
      HelpContext = 474056
      ExplicitLeft = 610
      ExplicitTop = 149
    end
    inherited Label160: TLabel [10]
      Left = 571
      Top = 56
      Width = 126
      HelpContext = 474026
      Caption = 'RA Number '
      ExplicitLeft = 571
      ExplicitTop = 56
      ExplicitWidth = 126
    end
    inherited lbMemTrans: TLabel
      Left = 572
      HelpContext = 474028
      ExplicitLeft = 572
    end
    inherited lblBaseForeignCurrencyCode: TLabel
      Left = 247
      Top = 56
      HelpContext = 474029
      ExplicitLeft = 247
      ExplicitTop = 56
    end
    inherited lblBaseExchangeRate: TLabel
      Left = 247
      Top = 104
      HelpContext = 474030
      ExplicitLeft = 247
      ExplicitTop = 104
    end
    inherited lblArea: TLabel
      Left = 489
      Top = 151
      ExplicitLeft = 489
      ExplicitTop = 151
    end
    object edtCreditMsg: TLabel [16]
      Left = 318
      Top = 195
      Width = 386
      Height = 15
      HelpContext = 474021
      Alignment = taCenter
      AutoSize = False
      Caption = 'Credit (Negative PO) Already Created'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      OnDblClick = edtCreditMsgDblClick
    end
    inherited lblStatus: TLabel
      Top = 151
      ExplicitTop = 151
    end
    inherited btnCompleted: TDNMSpeedButton [19]
      Left = 741
      Top = 38
      Height = 27
      HelpContext = 474038
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      TabOrder = 23
      TabStop = True
      ExplicitLeft = 741
      ExplicitTop = 38
      ExplicitHeight = 27
    end
    inherited btnClose: TDNMSpeedButton [20]
      Left = 741
      Top = 72
      HelpContext = 474039
      Font.Charset = DEFAULT_CHARSET
      Font.Height = -12
      TabStop = True
      ExplicitLeft = 741
      ExplicitTop = 72
    end
    inherited btnPreview: TDNMSpeedButton [21]
      Left = 741
      Top = 106
      HelpContext = 474040
      Font.Height = -12
      TabStop = True
      ExplicitLeft = 741
      ExplicitTop = 106
    end
    inherited btnPrint: TDNMSpeedButton [22]
      Left = 740
      Top = 140
      HelpContext = 474041
      Action = nil
      Font.Height = -12
      TabOrder = 27
      TabStop = True
      OnClick = btnPrintClick
      ExplicitLeft = 740
      ExplicitTop = 140
    end
    inherited pnlTitle: TDNMPanel [23]
      Left = 249
      Width = 258
      HelpContext = 474050
      Caption = 'Return Authority'
      TabOrder = 22
      ExplicitLeft = 249
      ExplicitWidth = 258
      inherited TitleShader: TShader
        Width = 256
        HelpContext = 474051
        ExplicitWidth = 256
        inherited TitleLabel: TLabel
          Width = 256
          HelpContext = 474052
          Caption = 'Return Authority'
          ExplicitWidth = 256
        end
      end
    end
    inherited cboEmployee: TwwDBLookupCombo [24]
      Left = 571
      Top = 119
      Width = 150
      HelpContext = 474036
      TabOrder = 10
      ExplicitLeft = 571
      ExplicitTop = 119
      ExplicitWidth = 150
    end
    inherited cmdEmail: TDNMSpeedButton [25]
      Left = 678
      Top = 179
      HelpContext = 474063
      TabOrder = 21
      Visible = False
      ExplicitLeft = 678
      ExplicitTop = 179
    end
    inherited txtCustomID: TDBEdit [26]
      Left = 571
      Top = 73
      Width = 150
      HelpContext = 474035
      TabOrder = 9
      ExplicitLeft = 571
      ExplicitTop = 73
      ExplicitWidth = 150
    end
    inherited cboVia: TwwDBLookupCombo [27]
      Left = 504
      Top = 6
      Width = 22
      HelpContext = 474059
      TabOrder = 19
      Visible = False
      ExplicitLeft = 504
      ExplicitTop = 6
      ExplicitWidth = 22
    end
    inherited cmdFax: TDNMSpeedButton [28]
      Left = 707
      Top = 142
      Width = 43
      HelpContext = 474064
      Visible = False
      OnClick = cmdFaxClick
      ExplicitLeft = 707
      ExplicitTop = 142
      ExplicitWidth = 43
    end
    inherited txtInvNumber: TDBEdit [29]
      Left = 370
      Top = 119
      Width = 150
      HelpContext = 474058
      TabOrder = 5
      ExplicitLeft = 370
      ExplicitTop = 119
      ExplicitWidth = 150
    end
    inherited edtBaseExchangeRate: TwwDBEdit [30]
      Left = 247
      Top = 119
      HelpContext = 474048
      TabOrder = 8
      ExplicitLeft = 247
      ExplicitTop = 119
    end
    inherited btnPayments: TDNMSpeedButton [31]
      HelpContext = 474082
    end
    inherited cboDueDate: TwwDBDateTimePicker [32]
      Left = 610
      Top = 166
      Width = 111
      HelpContext = 474061
      TabOrder = 11
      ExplicitLeft = 610
      ExplicitTop = 166
      ExplicitWidth = 111
    end
    inherited cboCreationDate: TwwDBDateTimePicker [33]
      Left = 370
      Top = 73
      Width = 111
      Height = 23
      HelpContext = 474034
      TabOrder = 4
      ExplicitLeft = 370
      ExplicitTop = 73
      ExplicitWidth = 111
      ExplicitHeight = 23
    end
    inherited txtClientDetails: TDBMemo [34]
      Left = 8
      Top = 111
      HelpContext = 474033
      ExplicitLeft = 8
      ExplicitTop = 111
    end
    inherited cboAccount: TwwDBLookupCombo [35]
      Left = 8
      HelpContext = 474062
      TabOrder = 0
      ExplicitLeft = 8
    end
    inherited btnNext: TDNMSpeedButton [36]
      Left = 741
      Top = 4
      HelpContext = 474037
      Font.Height = -12
      TabOrder = 12
      TabStop = True
      ExplicitLeft = 741
      ExplicitTop = 4
    end
    inherited pnlChooseRpt: TDNMPanel [37]
      Left = 603
      Top = 17
      HelpContext = 474042
      TabOrder = 24
      ExplicitLeft = 603
      ExplicitTop = 17
      inherited chkChooseRpt: TCheckBox
        HelpContext = 474044
      end
    end
    inherited cboTerms: TwwDBLookupCombo [38]
      Left = 370
      Top = 166
      Width = 111
      HelpContext = 474060
      TabOrder = 6
      ExplicitLeft = 370
      ExplicitTop = 166
      ExplicitWidth = 111
    end
    inherited cboBaseForeignCurrencyCode: TwwDBLookupCombo [39]
      Left = 247
      Top = 73
      HelpContext = 474047
      TabOrder = 7
      ExplicitLeft = 247
      ExplicitTop = 73
    end
    inherited btnPDF: TDNMSpeedButton [40]
      Left = 606
      Top = 177
      Width = 43
      HelpContext = 474088
      TabOrder = 25
      Visible = False
      ExplicitLeft = 606
      ExplicitTop = 177
      ExplicitWidth = 43
    end
    inherited cboClientR: TERPDbLookupCombo [41]
      Left = 8
      Top = 54
      Width = 202
      HelpContext = 474083
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F')
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitTop = 54
      ExplicitWidth = 202
    end
    inherited cboAreaCode: TwwDBLookupCombo [42]
      Left = 489
      Top = 166
      Width = 111
      HelpContext = 474087
      DataSource = DSMaster
      TabOrder = 20
      ExplicitLeft = 489
      ExplicitTop = 166
      ExplicitWidth = 111
    end
    inherited btnContacts: TDNMSpeedButton [43]
      Left = 214
      HelpContext = 474045
      TabOrder = 2
      ExplicitLeft = 214
    end
    inherited cboCurrentTransStatus: TwwDBLookupCombo [44]
      Left = 247
      Top = 166
      ExplicitLeft = 247
      ExplicitTop = 166
    end
    inherited btnEdit: TDNMSpeedButton
      Left = 651
      Top = 173
      ExplicitLeft = 651
      ExplicitTop = 173
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 741
      Top = 175
      Width = 87
      Height = 27
      HelpContext = 474084
      Anchors = [akTop, akRight]
      Caption = 'Make Credit'
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
      TabOrder = 17
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton1Click
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 154
    Top = 5
  end
  inherited DSDetails: TDataSource
    Left = 46
    Top = 409
  end
  inherited lsTDNMSpeedButtonActions: TActionList
    Left = 708
    Top = 39
  end
  inherited popMemTrans: TAdvPopupMenu
    Left = 527
    Top = 25
  end
  inherited tblMaster: TERPQuery
    Left = 8
    Top = 371
  end
  inherited tblDetails: TERPQuery
    Left = 42
    Top = 373
    inherited tblDetailsUnitofMeasurePOLines: TWideStringField [1]
    end
    inherited tblDetailsRAQty: TFloatField [2]
      DisplayLabel = 'Qty'
      Visible = True
    end
    inherited tblDetailsAttrib1Purchase: TFloatField [3]
    end
    inherited tblDetailsAttrib2Purchase: TFloatField [4]
    end
    inherited tblDetailsAttrib1PurchaseRate: TFloatField [5]
    end
    inherited tblDetailsLineTaxCode: TWideStringField [6]
    end
    inherited tblDetailsLineTax: TFloatField [7]
      DisplayFormat = '$,##0.00###;($,##0.00###)'
    end
    inherited tblDetailsCustomerJob: TWideStringField [8]
      Visible = True
    end
    inherited tblDetailsRAInvoiceNo: TWideStringField [9]
      DisplayLabel = 'Invoice'
      Visible = True
    end
    inherited tblDetailsProduct_Description: TWideStringField [10]
      DisplayLabel = 'Fault Description'
      Visible = True
    end
    inherited tblDetailsserialno: TWideMemoField [11]
      DisplayLabel = 'Serial'
      Visible = True
    end
    inherited tblDetailsClass: TWideStringField [12]
    end
    inherited tblDetailsRAstatus: TWideStringField [13]
      DisplayLabel = 'Status'
      DisplayWidth = 20
      Visible = True
      Size = 255
    end
    inherited tblDetailsLineCost: TFloatField [14]
    end
    inherited tblDetailsTotalLineAmountInc: TFloatField [15]
    end
    inherited tblDetailsPQA: TWideStringField [16]
    end
    inherited tblDetailsUnitOfMeasureID: TIntegerField [17]
    end
    inherited tblDetailsSortID: TIntegerField [18]
    end
    inherited tblDetailsMemoLine: TWideMemoField [19]
    end
    inherited tblDetailsCustomField6: TWideStringCustField [20]
    end
    inherited tblDetailsCustomField7: TWideStringCustField [21]
    end
    inherited tblDetailsCustomField8: TWideStringCustField [22]
    end
    inherited tblDetailsCustomField9: TWideStringCustField [23]
    end
    inherited tblDetailsCustomField10: TWideStringCustField [24]
    end
    inherited tblDetailsCustomField1: TWideStringCustField [25]
    end
    inherited tblDetailsCustomField2: TWideStringCustField [26]
    end
    inherited tblDetailsCustomField3: TWideStringCustField [27]
    end
    inherited tblDetailsCustomField4: TWideStringCustField [28]
    end
    inherited tblDetailsCustomField5: TWideStringCustField [29]
    end
    inherited tblDetailsReceivedDate: TDateTimeField [30]
      DisplayLabel = 'Sent On'
    end
    inherited tblDetailsLandedCostsPerItem: TFloatField [31]
    end
    inherited tblDetailsLandedCostsPercentage: TFloatField [32]
    end
    inherited tblDetailsTotalLineLandedCost: TFloatField [33]
    end
    inherited tblDetailsPartBarcode: TWideStringField [34]
      DisplayLabel = 'Product Barcode'
      DisplayWidth = 10
    end
    object tblDetailsOriginalCost: TFloatField [35]
      DisplayWidth = 10
      FieldName = 'OriginalCost'
    end
    inherited tblDetailsUOM_Height: TFloatField [36]
    end
    inherited tblDetailsUOM_Width: TFloatField [37]
    end
    inherited tblDetailsUOM_Length: TFloatField [38]
    end
    inherited tblDetailsUOM_Weight: TFloatField [39]
    end
    inherited tblDetailsTotalUOM_WeightSold: TFloatField [40]
    end
    inherited tblDetailsTotalUOM_WeightShipped: TFloatField [41]
    end
    inherited tblDetailsTotalUOM_WeightBO: TFloatField [42]
    end
    inherited tblDetailsUOM_Volume: TFloatField [43]
    end
    inherited tblDetailsRepairDocNo: TStringField [44]
    end
    object tblDetailsSEQNo: TIntegerField [45]
      DisplayWidth = 10
      FieldName = 'SEQNo'
    end
    inherited tblDetailsProduct_custFld1: TWideStringField [46]
    end
    inherited tblDetailsProduct_custFld2: TWideStringField [47]
    end
    inherited tblDetailsProduct_custFld3: TWideStringField [48]
    end
    inherited tblDetailsProduct_custFld4: TWideStringField [49]
    end
    inherited tblDetailsProduct_custFld5: TWideStringField [50]
    end
    inherited tblDetailsProduct_custFld6: TWideStringField [51]
    end
    inherited tblDetailsProduct_custFld7: TWideStringField [52]
    end
    inherited tblDetailsProduct_custFld8: TWideStringField [53]
    end
    inherited tblDetailsProduct_custFld9: TWideStringField [54]
    end
    inherited tblDetailsProduct_custFld10: TWideStringField [55]
    end
    inherited tblDetailsProduct_custFld11: TWideStringField [56]
    end
    inherited tblDetailsProduct_custFld12: TWideStringField [57]
    end
    inherited tblDetailsProduct_custFld13: TWideStringField [58]
    end
    inherited tblDetailsProduct_custFld14: TWideStringField [59]
    end
    inherited tblDetailsProduct_custFld15: TWideStringField [60]
    end
    inherited tblDetailsProduct_custDate1: TDateTimeField [61]
    end
    inherited tblDetailsProduct_custDate2: TDateTimeField [62]
    end
    inherited tblDetailsProduct_custDate3: TDateTimeField [63]
    end
    inherited tblDetailsFormulaQtySoldValue1: TFloatField [64]
    end
    inherited tblDetailsFormulaQtySoldValue2: TFloatField [65]
    end
    inherited tblDetailsFormulaQtySoldValue3: TFloatField [66]
    end
    inherited tblDetailsFormulaQtySoldValue4: TFloatField [67]
    end
    inherited tblDetailsFormulaQtySoldValue5: TFloatField [68]
    end
    inherited tblDetailsFormulaQtyShippedValue1: TFloatField [69]
    end
    inherited tblDetailsFormulaQtyShippedValue2: TFloatField [70]
    end
    inherited tblDetailsFormulaQtyShippedValue3: TFloatField [71]
    end
    inherited tblDetailsFormulaQtyShippedValue4: TFloatField [72]
    end
    inherited tblDetailsFormulaQtyShippedValue5: TFloatField [73]
    end
    inherited tblDetailsFormulaQtySoldValue: TFloatField [74]
    end
    inherited tblDetailsFormulaQtyShippedValue: TFloatField [75]
    end
    inherited tblDetailsAttrib1PurchaseEst: TFloatField [76]
    end
    inherited tblDetailsAttrib2PurchaseEst: TFloatField [77]
    end
    inherited tblDetailsEmployeeName: TWideStringField [78]
      DisplayLabel = 'Employee'
      DisplayWidth = 20
    end
    inherited tblDetailsAreaCode: TWideStringField [79]
    end
    inherited tblDetailsRepairId: TIntegerField [80]
    end
    inherited tblDetailsLineCostInc: TFloatField [81]
    end
    inherited tblDetailsUnitofMeasureQtySold: TFloatField [82]
      Visible = False
    end
    inherited tblDetailsUnitofMeasureBackorder: TFloatField [83]
      Visible = False
    end
    inherited tblDetailsUnitofMeasureShipped: TFloatField [84]
      Visible = False
    end
    inherited tblDetailsForeignCurrencyLineCost: TFloatField [85]
      Visible = False
    end
    inherited tblDetailsETADate: TDateField [86]
      Visible = False
    end
    inherited tblDetailsBatch: TWideStringField [87]
    end
    inherited tblDetailsUseTimecost: TWideStringField [88]
    end
    inherited tblDetailsSaleID_Timecost: TIntegerField [89]
    end
    inherited tblDetailsTimecostMarkupPer: TFloatField [90]
    end
    inherited tblDetailsTimecostPrice: TFloatField [91]
    end
    inherited tblDetailsTimecostMarkupDol: TFloatField [92]
    end
    inherited tblDetailsForeignExchangeRate: TFloatField [93]
    end
    inherited tblDetailsTotalLineAmount: TFloatField [94]
      OnSetText = FeldSetTextDontAllowNulls
    end
    inherited tblDetailsEditedFlag: TWideStringField [95]
    end
    inherited tblDetailsDeleted: TWideStringField [96]
    end
    inherited tblDetailsAssetAccnt: TWideStringField [97]
    end
    inherited tblDetailsCogsAccnt: TWideStringField [98]
    end
    inherited tblDetailsAccountNumber: TWideStringField [99]
      Visible = False
    end
    inherited tblDetailsSearchFilter: TWideStringField [100]
    end
    inherited tblDetailsSearchFilterCopy: TWideStringField [101]
    end
    inherited tblDetailsLandedCostsTotal: TFloatField [102]
    end
    inherited tblDetailsPartSpecID: TIntegerField [103]
    end
    inherited tblDetailsCalcCostInc: TCurrencyField [104]
    end
    inherited tblDetailsProductGroup: TWideStringField [105]
    end
    inherited tblDetailsCalcTotalInc: TCurrencyField [106]
    end
    inherited tblDetailsBackOrder: TFloatField [107]
    end
    inherited tblDetailsCalcTotalEx: TCurrencyField [108]
    end
    inherited tblDetailsSpecDescription: TWideStringField [109]
      Visible = False
    end
    inherited tblDetailsCalcTax: TCurrencyField [110]
    end
    inherited tblDetailsLineTaxRate: TFloatField [111]
    end
    inherited tblDetailsCalcBackOrder: TFloatField [112]
    end
    inherited tblDetailsPurchaseLineID: TAutoIncField [113]
    end
    inherited tblDetailsCOGSTotalLineAmount: TFloatField [114]
    end
    inherited tblDetailsForeignExchangeCode: TWideStringField [115]
    end
    inherited tblDetailsAvgCost: TFloatField [116]
    end
    inherited tblDetailsInvoiced: TWideStringField [117]
    end
    inherited tblDetailsCustomerJobID: TIntegerField [118]
    end
    inherited tblDetailsGlobalRef: TWideStringField [119]
    end
    inherited tblDetailsCOGSTotalLineAmountInc: TFloatField [120]
    end
    inherited tblDetailsAccountGroup: TWideStringField [121]
    end
    inherited tblDetailsQtySold: TFloatField [122]
    end
    inherited tblDetailsLastLineID: TIntegerField [123]
    end
    inherited tblDetailsProductID: TIntegerField [124]
    end
    inherited tblDetailsSpecValue: TFloatField [125]
      Visible = False
    end
    inherited tblDetailsRelatedPOID: TIntegerField [126]
    end
    inherited tblDetailsClassID: TIntegerField [127]
    end
    inherited tblDetailsEquipmentName: TWideStringField [128]
      Visible = False
    end
    inherited tblDetailsPartType: TWideStringField [129]
    end
    inherited tblDetailsSupplierProductCode: TWideStringField [130]
      Visible = False
    end
    inherited tblDetailsIncomeAccnt: TWideStringField [131]
    end
    inherited tblDetailsSupplierProductName: TWideStringField [132]
      Visible = False
    end
    inherited tblDetailsCustomerEquipmentID: TIntegerField [133]
    end
    inherited tblDetailsMatrixDesc: TWideMemoField [134]
    end
    inherited tblDetailsMatrixRef: TWideMemoField [135]
    end
    inherited tblDetailsMatrixPrice: TFloatField [136]
    end
    inherited tblDetailsPurchaseOrderID: TIntegerField [137]
    end
    inherited tblDetailsEmployeeID: TIntegerField [138]
      Visible = False
    end
    inherited tblDetailsLinesOrder: TIntegerField [139]
    end
    inherited tblDetailsTotalUOM_LengthSold: TFloatField [140]
    end
    inherited tblDetailsTotalUOM_LengthShipped: TFloatField [141]
    end
    inherited tblDetailsTotalUOM_LengthBO: TFloatField [142]
    end
    inherited tblDetailsForeignUOMLineCost: TFloatField [143]
    end
    inherited tblDetailsAccountName: TWideStringField [144]
    end
    inherited tblDetailsShipped: TFloatField [145]
    end
    inherited tblDetailsRelatedPOIDUsed: TWideStringField [146]
    end
    inherited tblDetailsUnitofMeasureMultiplier: TFloatField [147]
    end
    inherited tblDetailsProductPrintName: TWideStringField [148]
    end
  end
  inherited cboProductQry: TERPQuery
    SQL.Strings = (
      
        '#DUMMY QUERY - Order.Formcreate dynamically changes the query fo' +
        'r seach options '
      'SELECT'
      
        'if((LOCATE('#39'^'#39',tblParts.PRODUCTGROUP,InStr(tblParts.PRODUCTGROUP' +
        ','#39'^'#39')+1)) >0,MID(tblParts.PRODUCTGROUP,LOCATE('#39'^'#39',tblParts.PRODU' +
        'CTGROUP,InStr(tblParts.PRODUCTGROUP,'#39'^'#39')+1)+1,char_length(tblPar' +
        'ts.PRODUCTGROUP)-LOCATE('#39'^'#39',tblParts.PRODUCTGROUP,InStr(tblParts' +
        '.PRODUCTGROUP,'#39'^'#39')+1)),  Null)  AS '#39'Manuf'#39','
      
        'MID(tblParts.PRODUCTGROUP, InStr(tblParts.PRODUCTGROUP,'#39'^'#39')+1 , ' +
        'If(LOCATE('#39'^'#39',tblParts.PRODUCTGROUP, InStr(tblParts.PRODUCTGROUP' +
        ','#39'^'#39')+1) - InStr(tblParts.PRODUCTGROUP,'#39'^'#39') >0,LOCATE('#39'^'#39',tblPar' +
        'ts.PRODUCTGROUP, InStr(tblParts.PRODUCTGROUP,'#39'^'#39')+1)-1 - InStr(t' +
        'blParts.PRODUCTGROUP,'#39'^'#39'), IF(InStr(tblParts.PRODUCTGROUP,'#39'^'#39')<>' +
        '0,char_length(tblParts.PRODUCTGROUP) - InStr(tblParts.PRODUCTGRO' +
        'UP,'#39'^'#39'),0))) AS '#39'Type'#39' ,'
      
        'If(InStr(tblParts.PRODUCTGROUP,'#39'^'#39') -1 >0, Left(tblParts.PRODUCT' +
        'GROUP,InStr(tblParts.PRODUCTGROUP,'#39'^'#39')-1), tblParts.PRODUCTGROUP' +
        ') AS '#39'Dept'#39'  ,'
      'tblParts.PARTSID as PARTSID,'
      'tblParts.PARTTYPE as PARTTYPE,'
      'tblParts.PRODUCTGROUP as PRODUCTGROUP,'
      'tblParts.PARTNAME as PARTNAME,'
      'tblParts.PARTSDESCRIPTION as PARTSDESCRIPTION,'
      'tblParts.INCOMEACCNT as INCOMEACCNT,'
      'tblParts.PurchaseDesc as PurchaseDesc,'
      'tblParts.ASSETACCNT as ASSETACCNT,'
      'tblParts.COGSACCNT as COGSACCNT,'
      'tblParts.BARCODE as BARCODE,'
      'tblParts.PRODUCTCODE as PRODUCTCODE,'
      'tblParts.PURCHTAXCODE as PURCHTAXCODE,'
      'tblParts.PREFEREDSUPP as PREFEREDSUPP,'
      'tblParts.Batch as Batch,'
      'tblParts.SpecialDiscount as SpecialDiscount,'
      'tblParts.SNTracking as SNTracking,'
      'tblParts.BuyQTY1 as BuyQTY1,'
      'tblParts.BuyQTY2 as BuyQTY2,'
      'tblParts.BuyQTY3 as BuyQTY3,'
      'tblParts.COST1 as COST1,'
      'tblParts.COST2 as COST2,'
      'tblParts.COST3 as COST3,'
      'tblParts.SellQTY1 as SellQTY1,'
      'tblParts.SellQTY2 as SellQTY2,'
      'tblParts.SellQTY3 as SellQTY3,'
      'tblParts.PRICE1 as PRICE1,'
      'tblParts.PRICE2 as PRICE2,'
      'tblParts.PRICE3 as PRICE3,'
      'tblParts.WHOLESALEPRICE as WHOLESALEPRICE,'
      'tblParts.Active as Active,'
      'tblParts.EditedFlag as EditedFlag,'
      'tblParts.MultipleBins as MultipleBins,'
      'tblParts.AvgCost as AvgCost,'
      'tblParts.Discontinued as Discontinued,'
      'tblParts.Attrib1Purchase as Attrib1Purchase,'
      'tblParts.Attrib2Purchase as Attrib2Purchase,'
      'tblParts.Attrib1PurchaseRate as Attrib1PurchaseRate,'
      'tblParts.LatestCostDate as LatestCostDate'
      'FROM tblParts'
      'WHERE tblParts.Active = '#39'T'#39
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (PartName LIKE Concat(:SearchValue,"%"' +
        ')))'
      
        'or ((:SearchMode = 2) and (PartName LIKE Concat("%",:SearchValue' +
        ',"%"))))'
      'and IfNull(:SearchValue,"") <> ""')
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
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
  end
  inherited qryRepairEquip: TERPQuery
    SQL.Strings = (
      'SELECT'
      '`RE`.`CustomerEquipmentID`,'
      '`E`.`EquipmentName`,'
      '`RE`.`RepairID`,'
      'R.RepairDocNo as RepairNo,'
      '`CE`.`Serialno`,'
      '`CE`.`Manufacture`,'
      '`CE`.`model`,'
      '`CE`.`Registration`,'
      '`CE`.`WarantyPeriod`,'
      '`CE`.`WarantyFinishDate`,'
      '`CE`.`Quantity`,'
      '`CE`.`ClientID`,'
      'CE.UOM'
      'FROM'
      '`tblEquipmentxRef` AS `RE`'
      
        'Inner Join `tblcustomerequip` AS `CE` ON `RE`.`CustomerEquipment' +
        'ID` = `CE`.`id`'
      
        'Inner Join `tblequipment` AS `E` ON `CE`.`EquipmentID` = `E`.`Eq' +
        'uipmentID`'
      'Left Join tblRepairs as R on RE.RepairID = R.RepairID'
      
        'Where (RE.RepairID = :RepairID or :RepairID = 0) and (CE.ClientI' +
        'D = :ClientID or :ClientID = 0)')
  end
  inherited imgPopup: TImageList
    Left = 209
    Top = 10
    Bitmap = {
      494C010102009C00040110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200A000080110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 74
  end
  object memtblMaster: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'PurchaseOrderID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'GlobalRef'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'PurchaseOrderNumber'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'OriginalNo'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Account'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'AccountID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'BOID'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'SupplierName'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'ClientID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'OrderTo'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'EnteredAt'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'ShipTo'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'OrderDate'
        Attributes = [faFixed]
        DataType = ftDate
      end
      item
        Name = 'TotalTax'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'TotalAmount'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'TotalAmountInc'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'EmployeeName'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'EmployeeID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'InvoiceNumber'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'RefNo'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ETADate'
        Attributes = [faFixed]
        DataType = ftDate
      end
      item
        Name = 'DueDate'
        Attributes = [faFixed]
        DataType = ftDate
      end
      item
        Name = 'Comments'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'SalesComments'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Shipping'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Terms'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'PrintFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'PrintedBy'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Paid'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'Balance'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'Payment'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'ApplyFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'AmountDue'
        Attributes = [faFixed]
        DataType = ftBCD
        Precision = 15
        Size = 4
      end
      item
        Name = 'PayMethod'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'IsPO'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'IsRA'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'IsBill'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'IsCredit'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'IsCheque'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'IsPOCredit'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'Deleted'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'EditedFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'InvoiceDate'
        Attributes = [faFixed]
        DataType = ftDate
      end
      item
        Name = 'EnteredBy'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'ConNote'
        DataType = ftString
        Size = 25
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 256
    Top = 333
  end
  object memtblDetails: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'PurchaseLineID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'GlobalRef'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'PurchaseOrderID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'ProductID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'PARTTYPE'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'INCOMEACCNT'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ASSETACCNT'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'COGSACCNT'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ProductGroup'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'ProductName'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Product_Description'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'AccountName'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'AccountGroup'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'LineTaxRate'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'Attrib2Purchase'
        Attributes = [faFixed]
        DataType = ftBCD
        Precision = 15
        Size = 4
      end
      item
        Name = 'Attrib1PurchaseRate'
        Attributes = [faFixed]
        DataType = ftBCD
        Precision = 15
        Size = 4
      end
      item
        Name = 'LineCost'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'AvgCost'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'LineCostInc'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'LineTaxCode'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'LineTax'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'QtySold'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'Shipped'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'BackOrder'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'Invoiced'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'ClassID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'Class'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'CustomerJob'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'CustomerJobID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'RAQty'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'Attrib1Purchase'
        Attributes = [faFixed]
        DataType = ftBCD
        Precision = 15
        Size = 4
      end
      item
        Name = 'RAstatus'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Batch'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'UseTimecost'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'SaleID_Timecost'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'TimecostMarkupPer'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'TimecostPrice'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'TimecostMarkupDol'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'SerialNo'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'TotalLineAmount'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'TotalLineAmountInc'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'COGSTotalLineAmount'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'COGSTotalLineAmountInc'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'EditedFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'Deleted'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'RAInvoiceNo'
        DataType = ftString
        Size = 11
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 224
    Top = 334
  end
end
