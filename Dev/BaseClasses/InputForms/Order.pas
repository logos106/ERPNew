Unit Order;

{

  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  22/04/05  1.00.01 IJB  Added Barcode entry of products.
  26/04/05  1.00.02 IJB  Modified to use ~ char to open barcode form.
  13/05/05  1.00.04 IJB  Moved most of form calculation logic into new Business
  Objects (TOrderBase etc).
  16/05/05  1.00.05 IJB  Fixed product name not being selected from barcode entry.
  08/06/05  1.01.00 ISB  Added Specifications Combo Ect
  05/07/05  1.01.07 BJ   -->Purchase Order: Backorder records storing the PurchaseOrderId
  of the original Purchase Order record. Also stores a sequence
  no of the Backorder
  20/07/05  1.01.08 DSP  Fixed problem in CheckMatrixItems (no qry.First).
  28/07/05  1.00.09 IJB  Changed cboCustomerJob drop-down column widths.
  10/08/05  1.00.10 DSP  Altered 'unknown' exception handling to use
  ExceptionMagic.
  12/08/05  1.00.11 BJ   Serialno fieldtype is changed to mediumtext
  30/08/05  1.00.12 IJB  Modified cboClientCloseUp to Post/Edit master table if
  not yet saved to ensure PurchaseOrderId has a value
  (this was not happening when the PO Supplier was being
  created 'on the fly' resulting in PO lines with no
  PurchaseOrderID )
  15/09/05  1.00.13 IJB  Added Attachments.
  11/10/05  1.00.14 DSP  Added 'ETA Date' and 10 custom fields, and the procedure
  'AdjustCustomFields'.
  16/11/05  1.00.15 DSP  Added check for [Alt] key not being down before
  displaying the barcode form.
  04/01/06  1.00.16 AL   Added new Search mode (like)
  05/01/06  1.00.17 DSP  The 'AdjustCustomFields' procedure is now located in
  the unit tcDataUtils.
  06/01/06  1.00.18 DSP  Changed the parameter passed to AdjustCustomFields from
  grdTransactions to tblDetails.
  01/02/06  1.00.19 DSP  1. Removed call to AdjustCustomFields, this is now
  handled by the 'Customise' dialog box.
  2. Added calls to GuiPrefs.
  02/02/06  1.00.20 DSP  Rearranged fields in tbldetails.
  06/02/06  1.00.21 DSP  Set PopupMenu property of grid components to point to
  the PopupMenu value of the grid.
  09/02/06  1.00.22 DSP  Changed HiddenFields to HideField.
  15/02/06  1.00.23 DSP  Added UpdateSelectedProp to FormCreate.
  12/04/06  1.00.24 DSP  Removed functionality for AdvMatrix.
  29/05/06  1.00.14 BJ   PO object is introduced, some code from here is moved in to the object
  As frmRA is also inherited from here which doesn;t have the object,
  the necessary code is copied into this form too.
  chkDisableCalcs is made invisible in the template and is no more applciable
  the calculations are done always.

}
Interface
Uses Windows, DateUtils, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Commonlib, Dialogs, BaseTransForm, DB, wwdbdatetimepicker, wwdblook, StdCtrls,
  DBCtrls, Mask, ExtCtrls,wwcheckbox, Buttons, DNMSpeedButton, DNMPanel, Wwdbigrd, Grids,
  Wwdbgrid, ActnList, Menus, AdvMenus, ImgList, SelectionDialog, AppEvnts, wwdbedit,
  MyAccess, ERPdbComponents, MemDS, DBAccess,DataState, DMComps, BusObjOrderbase,
  Shader, CustomerJobRepairSelection, ProgressDialog, ERPDbLookupCombo, BusObjBase, CustomfieldonGrid;

Const SX_RequestComboRedrop = WM_USER + 101;

Type
  TBaseOrderGUI = Class(TBaseTransGUI)
    txtInvNumber: TDBEdit;
    Label43: TLabel;
    cboVia: TwwDBLookupCombo;
    Label47: TLabel;
    cboTerms: TwwDBLookupCombo;
    Label79: TLabel;
    cboDueDate: TwwDBDateTimePicker;
    Label45: TLabel;
    cboAccount: TwwDBLookupCombo;
    lblAccount: TLabel;
    cboViaQry: TERPQuery;
    cboViaQryShippingMethodID: TAutoIncField;
    cboViaQryShippingMethod: TWideStringField;
    tblMasterPurchaseOrderID: TAutoIncField;
    tblMasterGlobalRef: TWideStringField;
    tblMasterPurchaseOrderNumber: TWideStringField;
    tblMasterOriginalNo: TWideStringField;
    tblMasterAccount: TWideStringField;
    tblMasterSupplierName: TWideStringField;
    tblMasterOrderTo: TWideStringField;
    tblMasterShipTo: TWideStringField;
    tblMasterTotalTax: TFloatField;
    tblMasterTotalAmount: TFloatField;
    tblMasterTotalAmountInc: TFloatField;
    tblMasterEmployeeName: TWideStringField;
    tblMasterInvoiceNumber: TWideStringField;
    tblMasterETADate: TDateField;
    tblMasterDueDate: TDateField;
    tblMasterComments: TWideStringField;
    tblMasterSalesComments: TWideStringField;
    tblMasterShipping: TWideStringField;
    tblMasterTerms: TWideStringField;
    tblMasterPrintFlag: TWideStringField;
    tblMasterPaid: TWideStringField;
    tblMasterBalance: TFloatField;
    tblMasterPayment: TFloatField;
    tblMasterApplyFlag: TWideStringField;
    tblMasterAmountDue: TFloatField;
    tblMasterPayMethod: TIntegerField;
    tblMasterIsPO: TWideStringField;
    tblMasterIsRA: TWideStringField;
    tblMasterIsBill: TWideStringField;
    tblMasterIsCredit: TWideStringField;
    tblMasterDeleted: TWideStringField;
    tblMasterCancelled: TWideStringField;
    tblMasterEditedFlag: TWideStringField;
    tblDetailsPurchaseLineID: TAutoIncField;
    tblDetailsGlobalRef: TWideStringField;
    tblDetailsPurchaseOrderID: TIntegerField;
    tblDetailsProductGroup: TWideStringField;
    tblDetailsProductName: TWideStringField;
    tblDetailsProduct_CUSTFLD1: TWideStringField;
    tblDetailsProduct_CUSTFLD2: TWideStringField;
    tblDetailsProduct_CUSTFLD3: TWideStringField;
    tblDetailsProduct_CUSTFLD4: TWideStringField;
    tblDetailsProduct_CUSTFLD5: TWideStringField;
    tblDetailsProduct_CUSTFLD6: TWideStringField;
    tblDetailsProduct_CUSTFLD7: TWideStringField;
    tblDetailsProduct_CUSTFLD8: TWideStringField;
    tblDetailsProduct_CUSTFLD9: TWideStringField;
    tblDetailsProduct_CUSTFLD10: TWideStringField;
    tblDetailsProduct_CUSTFLD11: TWideStringField;
    tblDetailsProduct_CUSTFLD12: TWideStringField;
    tblDetailsProduct_CUSTFLD13: TWideStringField;
    tblDetailsProduct_CUSTFLD14: TWideStringField;
    tblDetailsProduct_CUSTFLD15: TWideStringField;
    tblDetailsProduct_CUSTDATE1: TDateTimeField;
    tblDetailsProduct_CUSTDATE2: TDateTimeField;
    tblDetailsProduct_CUSTDATE3: TDateTimeField;
    tblDetailsProduct_Description: TWideStringField;
    tblDetailsLineTaxRate: TFloatField;
    tblDetailsLineCost: TFloatField;
    tblDetailsLineCostInc: TFloatField;
    tblDetailsLineTaxCode: TWideStringField;
    tblDetailsLineTax: TFloatField;
    tblDetailsQtySold: TFloatField;
    tblDetailsShipped: TFloatField;
    tblDetailsBackOrder: TFloatField;
    tblDetailsInvoiced: TWideStringField;
    tblDetailsClass: TWideStringField;
    tblDetailsCustomerJob: TWideStringField;
    tblDetailsRAQty: TFloatField;
    tblDetailsRAstatus: TWideStringField;
    tblDetailsBatch: TWideStringField;
    tblDetailsUseTimecost: TWideStringField;
    tblDetailsSaleID_Timecost: TIntegerField;
    tblDetailsTimecostMarkupPer: TFloatField;
    tblDetailsTimecostPrice: TFloatField;
    tblDetailsTimecostMarkupDol: TFloatField;
    tblDetailsTotalLineAmount: TFloatField;
    tblDetailsTotalLineAmountInc: TFloatField;
    tblDetailsEditedFlag: TWideStringField;
    tblDetailsDeleted: TWideStringField;
    tblDetailsRAInvoiceNo: TWideStringField;
    tblDetailsAccountName: TWideStringField;
    tblDetailsAccountGroup: TWideStringField;
    tblMasterBOID: TWideStringField;
    cboTermsQry: TERPQuery;
    tblMasterAccountID: TIntegerField;
    tblMasterClientID: TIntegerField;
    tblMasterEmployeeID: TIntegerField;
    tblDetailsProductID: TIntegerField;
    tblDetailsClassID: TIntegerField;
    tblDetailsPartType: TWideStringField;
    tblDetailsIncomeAccnt: TWideStringField;
    tblDetailsAssetAccnt: TWideStringField;
    tblDetailsCogsAccnt: TWideStringField;
    cboClass: TwwDBLookupCombo;
    tblDetailsCalcCostInc: TCurrencyField;
    tblDetailsCalcTotalInc: TCurrencyField;
    tblDetailsCalcTotalEx: TCurrencyField;
    tblDetailsCalcTax: TCurrencyField;
    tblDetailsCalcBackOrder: TFloatField;
    tblMasterRefNo: TWideStringField;
    tblMasterIsPOCredit: TWideStringField;
    tblDetailsCOGSTotalLineAmount: TFloatField;
    tblDetailsAvgCost: TFloatField;
    tblDetailsCustomerJobID: TIntegerField;
    tblDetailsCOGSTotalLineAmountInc: TFloatField;
    tblMasterEnteredBy: TWideStringField;
    tblMasterPrintedBy: TWideStringField;
    tblMasterEnteredAt: TWideStringField;
    tblDetailsAttrib2Purchase: TFloatField;
    tblDetailsAttrib1Purchase: TFloatField;
    tblDetailsAttrib1PurchaseRate: TFloatField;
    tblDetailsLastLineID: TIntegerField;
    tblDetailsForeignExchangeRate: TFloatField;
    tblDetailsForeignExchangeCode: TWideStringField;
    tblDetailsForeignCurrencyLineCost: TFloatField;
    qryForeignCurrency: TERPQuery;
    cboForeignCurrencyCode: TwwDBLookupCombo;
    tblDetailsRelatedPOID: TIntegerField;
    tblDetailsRelatedPOIDUsed: TWideStringField;
    tblDetailsLandedCostsPerItem: TFloatField;
    cboUnitOfMeasure: TwwDBLookupCombo;
    tblDetailsUnitofMeasureQtySold: TFloatField;
    tblDetailsUnitofMeasureShipped: TFloatField;
    tblDetailsUnitofMeasureBackorder: TFloatField;
    tblDetailsUnitofMeasureMultiplier: TFloatField;
    tblMasterIsCheque: TWideStringField;
    tblMasterInvoiceDate: TDateField;
    tblMasterConNote: TWideStringField;
    qryUnitOfMeasure: TERPQuery;
    qryUnitOfMeasureUnitName: TWideStringField;
    qryUnitOfMeasureUnitDescription: TWideStringField;
    qryUnitOfMeasureMultiplier: TFloatField;
    tblDetailsUnitofMeasurePOLines: TWideStringField;
    tblDetailsAccountNumber: TWideStringField;
    cmdFax: TDNMSpeedButton;
    tblMasterCustPONumber: TWideStringField;
    txtSearchFilter: TwwDBEdit;
    tblDetailsSearchFilter: TWideStringField;
    tblDetailsSearchFilterCopy: TWideStringField;
    tblDetailsLandedCostsPercentage: TFloatField;
    tblDetailsLandedCostsTotal: TFloatField;
    cboAccountQry: TERPQuery;
    cboProductQry: TERPQuery;
    qryCustomerJob: TERPQuery;
    tblDetailsPartSpecID: TIntegerField;
    tblDetailsSpecDescription: TWideStringField;
    tblDetailsSpecValue: TFloatField;
    cboPartSpecs: TwwDBLookupCombo;
    tblDetailsserialno: TWideMemoField;
    btnAttachments: TDNMSpeedButton;
    DMTextTargetOrder: TDMTextTarget;
    tblMasterLastUpdated: TDateTimeField;
    tblDetailsETADate: TDateField;
    tblDetailsCustomField1: TWideStringCustField;
    tblDetailsCustomField2: TWideStringCustField;
    tblDetailsCustomField3: TWideStringCustField;
    tblDetailsCustomField4: TWideStringCustField;
    tblDetailsCustomField5: TWideStringCustField;
    tblDetailsCustomField6: TWideStringCustField;
    tblDetailsCustomField7: TWideStringCustField;
    tblDetailsCustomField8: TWideStringCustField;
    tblDetailsCustomField9: TWideStringCustField;
    tblDetailsCustomField10: TWideStringCustField;
    tblDetailsUnitOfMeasureID: TIntegerField;
    tblMasterBaseNo: TWideStringField;
    tblDetailsSortID: TIntegerField;
    tblDetailsLinesOrder: TIntegerField;
    tblDetailsMemoLine: TWideMemoField;
    qryUnitOfMeasureUnitID: TIntegerField;
    tblDetailsPQA: TWideStringField;
    tblDetailsReceivedDate: TDateTimeField;
    tblMasterOrderDate: TDateTimeField;
    tblmastercontactID: TLargeintField;
    tblMasterContactName: TWideStringField;
    cboProductR: TERPDbLookupCombo;
    tblDetailsRepairId: TIntegerField;
    tblDetailsCustomerEquipmentID: TIntegerField;
    tblDetailsEquipmentName: TWideStringField;
    cboEquipmentName: TwwDBLookupCombo;
    qryRepairEquip: TERPQuery;
    qryRepairEquipEquipmentName: TWideStringField;
    qryRepairEquipSerialno: TWideStringField;
    qryRepairEquipManufacture: TWideStringField;
    qryRepairEquipmodel: TWideStringField;
    qryRepairEquipRegistration: TWideStringField;
    qryRepairEquipWarantyFinishDate: TDateTimeField;
    qryRepairEquipWarantyPeriod: TFloatField;
    qryRepairEquipCustomerEquipmentID: TIntegerField;
    qryRepairEquipRepairID: TIntegerField;
    qryRepairEquipQuantity: TFloatField;
    qryRepairEquipUOM: TWideStringField;
    qryRepairEquipClientID: TIntegerField;
    tblDetailsTotalLineLandedCost: TFloatField;
    tblDetailsSupplierProductCode: TWideStringField;
    tblDetailsSupplierProductName: TWideStringField;
    tblDetailsPartBarcode: TWideStringField;
    tblDetailsMatrixDesc: TWideMemoField;
    tblDetailsMatrixRef: TWideMemoField;
    tblDetailsMatrixPrice: TFloatField;
    tblDetailsUOM_Width: TFloatField;
    tblDetailsUOM_Length: TFloatField;
    tblDetailsUOM_Weight: TFloatField;
    tblDetailsTotalUOM_WeightSold: TFloatField;
    tblDetailsTotalUOM_WeightShipped: TFloatField;
    tblDetailsTotalUOM_WeightBO: TFloatField;
    tblDetailsTotalUOM_LengthSold: TFloatField;
    tblDetailsTotalUOM_LengthShipped: TFloatField;
    tblDetailsTotalUOM_LengthBO: TFloatField;
    tblDetailsUOM_Volume: TFloatField;
    tblDetailsUOM_Height: TFloatField;
    lblEnteredAtHead: TLabel;
    lblEnteredAt: TDBText;
    edtMemoLine: TwwDBEdit;
    popOptions: TAdvPopupMenu;
    N1: TMenuItem;
    CustomFields1: TMenuItem;
    N2: TMenuItem;
    qryRepairEquipRepairNo: TWideStringField;
    qryRepairLookup: TERPQuery;
    qryRepairLookupRepairDocNo: TWideStringField;
    qryRepairLookupCustomerName: TWideStringField;
    qryRepairLookupRepairID: TIntegerField;
    cboRepairDocNo: TwwDBLookupCombo;
    tblDetailsRepairDocNo: TStringField;
    tblDetailsFormulaQtySoldValue1: TFloatField;
    tblDetailsFormulaQtySoldValue2: TFloatField;
    tblDetailsFormulaQtySoldValue3: TFloatField;
    tblDetailsFormulaQtySoldValue4: TFloatField;
    tblDetailsFormulaQtySoldValue5: TFloatField;
    tblDetailsFormulaQtyShippedValue1: TFloatField;
    tblDetailsFormulaQtyShippedValue2: TFloatField;
    tblDetailsFormulaQtyShippedValue3: TFloatField;
    tblDetailsFormulaQtyShippedValue4: TFloatField;
    tblDetailsFormulaQtyShippedValue5: TFloatField;
    tblDetailsFormulaQtySoldValue: TFloatField;
    tblDetailsFormulaQtyShippedValue: TFloatField;
    tblDetailsAttrib1PurchaseEst: TFloatField;
    tblDetailsAttrib2PurchaseEst: TFloatField;
    tblDetailsEmployeeID: TIntegerField;
    tblDetailsEmployeeName: TWideStringField;
    qryEmployeeLookup: TERPQuery;
    qryEmployeeLookupEmployeeName: TWideStringField;
    cboLineEmployee: TwwDBLookupCombo;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    tblMasterArea: TWideStringField;
    cboAreaCode: TwwDBLookupCombo;
    lblArea: TLabel;
    tblDetailsAreaCode: TWideStringField;
    tblMasterEnteredAtShort: TStringField;
    cboProductQryManuf: TWideStringField;
    cboProductQryType: TWideStringField;
    cboProductQryDept: TWideStringField;
    cboProductQryPARTSID: TIntegerField;
    cboProductQryPARTTYPE: TWideStringField;
    cboProductQryPRODUCTGROUP: TWideStringField;
    cboProductQryPARTNAME: TWideStringField;
    cboProductQryPARTSDESCRIPTION: TWideStringField;
    cboProductQryINCOMEACCNT: TWideStringField;
    cboProductQryPurchaseDesc: TWideStringField;
    cboProductQryASSETACCNT: TWideStringField;
    cboProductQryCOGSACCNT: TWideStringField;
    cboProductQryBARCODE: TWideStringField;
    cboProductQryPRODUCTCODE: TWideStringField;
    cboProductQryPURCHTAXCODE: TWideStringField;
    cboProductQryPREFEREDSUPP: TWideStringField;
    cboProductQryBatch: TWideStringField;
    cboProductQrySpecialDiscount: TWideStringField;
    cboProductQrySNTracking: TWideStringField;
    cboProductQryBuyQTY1: TIntegerField;
    cboProductQryBuyQTY2: TIntegerField;
    cboProductQryBuyQTY3: TIntegerField;
    cboProductQryCOST1: TFloatField;
    cboProductQryCOST2: TFloatField;
    cboProductQryCOST3: TFloatField;
    cboProductQrySellQTY1: TIntegerField;
    cboProductQrySellQTY2: TIntegerField;
    cboProductQrySellQTY3: TIntegerField;
    cboProductQryPRICE1: TFloatField;
    cboProductQryPRICE2: TFloatField;
    cboProductQryPRICE3: TFloatField;
    cboProductQryWHOLESALEPRICE: TFloatField;
    cboProductQryActive: TWideStringField;
    cboProductQryEditedFlag: TWideStringField;
    cboProductQryMultipleBins: TWideStringField;
    cboProductQryAvgCost: TFloatField;
    cboProductQryDiscontinued: TWideStringField;
    cboProductQryAttrib1Purchase: TFloatField;
    cboProductQryAttrib2Purchase: TFloatField;
    cboProductQryAttrib1PurchaseRate: TFloatField;
    cboProductQryLatestCostPrice: TFloatField;
    cboProductQryTaxCode: TWideStringField;
    cboProductQryLatestCost: TFloatField;
    cboProductQryAutoBatch: TWideStringField;
    cboProductQryAttrib1Sale: TFloatField;
    cboProductQryAttrib2Sale: TFloatField;
    cboProductQryAttrib1SaleRate: TFloatField;
    cboProductQryLatestCostDate: TDateField;
    cboProductQrySupplierProductCode: TWideStringField;
    cboProductQryCUSTFLD1: TWideStringField;
    cboProductQryCUSTFLD2: TWideStringField;
    cboProductQryCUSTFLD3: TWideStringField;
    cboProductQryCUSTFLD4: TWideStringField;
    cboProductQryCUSTFLD5: TWideStringField;
    cboProductQryCUSTFLD6: TWideStringField;
    cboProductQryCUSTFLD7: TWideStringField;
    cboProductQryCUSTFLD8: TWideStringField;
    cboProductQryCUSTFLD9: TWideStringField;
    cboProductQryCUSTFLD10: TWideStringField;
    cboProductQryCUSTFLD11: TWideStringField;
    cboProductQryCUSTFLD12: TWideStringField;
    cboProductQryCUSTFLD13: TWideStringField;
    cboProductQryCUSTFLD14: TWideStringField;
    cboProductQryCUSTFLD15: TWideStringField;
    cboProductQryCUSTDATE1: TDateTimeField;
    cboProductQryCUSTDATE2: TDateTimeField;
    cboProductQryCUSTDATE3: TDateTimeField;
    tblMasterOrderStatus: TWideStringField;
    tblDetailsForeignUOMLineCost: TFloatField;
    qryRepairLookupcusid: TIntegerField;
    tblDetailsProductPrintName: TWideStringField;
    tblMasterClientPrintName: TWideStringField;
    cboPrintProductR: TERPDbLookupCombo;
    cboCustJob: TERPDbLookupCombo;
    cboCustPrintJob: TERPDbLookupCombo;
    tblFEPOLines: TERPQuery;
    tblFEPOLinesField1: TFloatField;
    tblFEPOLinesField2: TFloatField;
    tblFEPOLinesField3: TFloatField;
    tblFEPOLinesfield4: TFloatField;
    tblFEPOLinesField5: TFloatField;
    tblFEPOLinesShippedField1: TFloatField;
    tblFEPOLinesShippedField2: TFloatField;
    tblFEPOLinesShippedField3: TFloatField;
    tblFEPOLinesShippedField4: TFloatField;
    tblFEPOLinesShippedField5: TFloatField;
    tblFEPOLinesPOID: TIntegerField;
    tblFEPOLinesPOLineID: TIntegerField;
    tblFEPOLinesFEPOLineID: TAutoIncField;
    tblFEPOLinesGlobalRef: TWideStringField;
    tblFEPOLinesProductID: TIntegerField;
    tblFEPOLinesDeleted: TWideStringField;
    tblFEPOLinesProductName: TWideStringField;
    tblFEPOLinesmsTimeStamp: TDateTimeField;
    tblFEPOLinesmsUpdateSiteCode: TWideStringField;
    tblFEPOLinesFormulaId: TIntegerField;
    dsFEPOLines: TDataSource;
    dsFEPOlinesRelatedPrs: TDataSource;
    tblFEPOlinesRelatedPrs: TERPQuery;
    tblFEPOlinesRelatedPrsProductName: TWideStringField;
    tblFEPOlinesRelatedPrsFormula: TWideStringField;
    tblFEPOlinesRelatedPrsRelatedQty: TFloatField;
    tblFEPOlinesRelatedPrsRelatedShippedQty: TFloatField;
    tblFEPOlinesRelatedPrsFEPOlinesRelatedPrID: TAutoIncField;
    tblFEPOlinesRelatedPrsGlobalRef: TWideStringField;
    tblFEPOlinesRelatedPrsFEPOLineID: TIntegerField;
    tblFEPOlinesRelatedPrsProductID: TIntegerField;
    tblFEPOlinesRelatedPrsFormulaID: TIntegerField;
    tblFEPOlinesRelatedPrsDeleted: TWideStringField;
    tblDetailsSupplierBarCode: TWideStringField;
    Procedure FormShow(Sender: TObject);
    Procedure cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    Procedure cboCustomerJobNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: boolean);
    Procedure FormDestroy(Sender: TObject);
    Procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    Procedure cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    Procedure tblDetailsQtySoldChange(Sender: TField);
    Procedure tblDetailsShippedChange(Sender: TField);
    Procedure tblDetailsLineTaxCodeChange(Sender: TField);
    Procedure tblDetailsLineCostChange(Sender: TField);
    Procedure grdTransactionsEnter(Sender: TObject);
    Procedure grdTransactionsRowChanged(Sender: TObject);
    Procedure cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    Procedure tblMasterInvoiceDateChange(Sender: TField);
    Procedure FormActivate(Sender: TObject);
    Procedure grdTransactionsFieldChanged(Sender: TObject; Field: TField);
    Procedure FormCreate(Sender: TObject);
    Procedure grdTransactionsCalcTitleAttributes(Sender: TObject; Const AFieldName: String; Const AFont: TFont; Const ABrush: TBrush; Var ATitleAlignment: TAlignment);
    // procedure tblDetailsSearchFilterValidate(Sender: TField);
    Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Procedure btnCompletedClick(Sender: TObject);
    Procedure cboProductQryAfterOpen(DataSet: TDataSet);
    Procedure cboCustomerJobExit(Sender: TObject);
    Procedure qryCustomerJobAfterOpen(DataSet: TDataSet);
    Procedure FormKeyDown(Sender: TObject; Var Key: word; Shift: TShiftState);
    Procedure FormKeyPress(Sender: TObject; Var Key: char);
    Procedure btnAttachmentsClick(Sender: TObject);
    Procedure DMTextTargetOrderDrop(Sender: TObject; Acceptor: TWinControl; Const DropText: String; X, Y: integer);
    Procedure tblDetailsUnitofMeasurePOLinesChange(Sender: TField);
    Procedure tblDetailsProductNameChange(Sender: TField);
    Procedure grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: String);
    Procedure grdTransactionsExit(Sender: TObject);
    Procedure cboClientREnter(Sender: TObject);
    Procedure cboProductRNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: boolean);
    Procedure cboEquipmentNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    Procedure cboEquipmentNameDblClick(Sender: TObject);
    Procedure cboEquipmentNameNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: boolean);
    Procedure tblDetailsLandedCostsPerItemChange(Sender: TField);
    Procedure tblDetailsLandedCostsPercentageChange(Sender: TField);
    Procedure cboEquipmentNameDropDown(Sender: TObject);
    Procedure cboUnitOfMeasureDropDown(Sender: TObject);
    Procedure cboCustomerJobDropDown(Sender: TObject);
    Procedure cboClassDropDown(Sender: TObject);
    Procedure cboPartSpecsDropDown(Sender: TObject);
    Procedure cboTaxCodeDropDown(Sender: TObject);
    Procedure cboForeignCurrencyCodeDropDown(Sender: TObject);
    Procedure grdTransactionsDblClick(Sender: TObject);
    Procedure grdTransactionsKeyDown(Sender: TObject; Var Key: word; Shift: TShiftState);
    procedure tblDetailsCalcFields(DataSet: TDataSet);
    procedure CustomFields1Click(Sender: TObject);
    procedure cboEquipmentNameBeforeDropDown(Sender: TObject);
    procedure cboRepairDocNoCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qryUnitOfMeasureBeforeOpen(DataSet: TDataSet);
    procedure tblMasterCalcFields(DataSet: TDataSet);
    procedure cboProductRAfterchange(Sender: TObject);
    procedure tblDetailsAfterOpen(DataSet: TDataSet);
    procedure cboViaEnter(Sender: TObject);
    (* procedure cboBarcodeNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean); *)
    Private
      { Private declarations }
      fbCustomerJobState: boolean;
      // CustomerJobRepairObj: TCustomerJobRepairObj;
      // ProductSearcher: TwwDBComboSearcher;
      // ClientSearcher: TwwDBComboSearcher;
      // JobSearcher: TwwDBComboSearcher;
      Newbarcode    : String;
      barCodeCreated: boolean;
      CustomFieldonGrid:TCustomFieldonGrid;
      Procedure ShowAttachments(fbDragnDropping :Boolean);
      Procedure CheckForAttachments;
      // Procedure InitCustJobRepairSelection;
      Procedure SetMatrixDetails(sMatrixDesc, sMatrixRef: String; dMatrixPrice: double);
      procedure beforeshowCustomfieldList(Sender: TObject);
      procedure ApplyCustomFieldsSettings;
      function ProductDisabledCustomFields: string;
      procedure SetProductcustomFields;
      procedure ShowAccountCbo(const Value: Boolean);
      Procedure ProductformulaEntry(Sender:TObject);
      (* Procedure CreateBarCode(Sender:TObject); *)
      procedure DisableLineZeroQtyWarning(Sender: TObject; Checked: boolean);
    Protected
      RunOnce         : boolean;
      Order           : TOrderBase;
      PriceUpdateValue: currency;
      IsUsingBusObj   : boolean;
      Function GetTaxAccountName: String; Override;
      Function GetDocumentNoName: String; Override;
      Procedure CalcAttribsTotals;
      // procedure RequeryFilteredProducts; overload;
      // procedure RequeryFilteredProducts(const FilterString: string); overload;
      Procedure RefreshUnitsQry;
      Function getcontactType: TContactType; Override;
      //Procedure UpdateFromContact(Const value: TDataSet); Override;
      Procedure SetGridColumns; Virtual;
      Procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; Const EventType, value: String); Override;
      (* Procedure ProductRNotInList;Override; *)
      Function MatrixReporttype: String; Override;
      procedure DoOnClientchange;Override;
      procedure NewTransBusObjinstance;override;
      function GetOrAddMobileNumber: string;
      procedure PopulateMessageSubstituteList(SL: TStringList); override;
      function ClientState:String; Override;
      function Clientcountry:String; Override;
      function clientLocation:String; Override;
      function ClientPostcode:String; Override;
      Procedure InitERPLookupCombonFields; Override;
      Procedure DoOnProductchange;Override;
      procedure AddProductPriceMenu;Virtual;
      procedure ShowFormulafields;Override;
    Public
      { Public declarations }
      FilterString              : String;
      fbIsClosing               : boolean;
      fbDontCopyFilter          : boolean;
      fbDontRefreshCalcs        : boolean;
      fbRecordCancelled         : boolean;
      Procedure UpdateMe; Override;
      procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
  End;

  (* var
    BaseOrderGUI: TBaseOrderGUI; *)

Implementation
Uses DNMExceptions, Math, CommonDbLib, frmPartsFrm, frmSupplier,
  (*frmBarcodePopUp,*)
  frmAttachments, GuiPrefsObj, ActiveX, BaseInputForm, DNMLib, StrUtils, AppEnvironment, FastFuncs, (* *)ProductListExpressForm, BusObjStock, tcDataUtils, tcConst, frmpartsPriceMatrixInput,
  PartsPriceMatrixLib, BusObjConst, MemoDialog, frmDelayMessageDlg,
  CommonFormLib, frmCustomfieldList, Busobjcustomfields, BusObjSimpleTypes,
  frmSimpleTypes, BusObjContact, BusObjClient, frmMobileNumberInput,
  SMSUtils, BusObjTrans, frmPOProductSpec, BusObjFeTransLines,
  DbSharedObjectsObj; // TYMED_ISTREAM for DropMaster Target in form create

Const DoMsgLogging = true;

{$R *.dfm}
procedure TBaseOrderGUI.CustomFields1Click(Sender: TObject);
begin
  inherited;
  if OpenERPFormModal('TfmCustomfieldList', 0, beforeshowCustomfieldList)>=0 then
    CustomfieldonGrid.ApplyCustomFieldsSettings;
end;

Procedure TBaseOrderGUI.FormShow(Sender: TObject);
Var TempStr: String;
Begin
  stepProgressbar;
  fbDontCopyFilter   := false;
  fbCustomerJobState := true;

  GuiPrefs.DbGridElement[grdTransactions].RemoveFields('CogsAccnt,SortID,LinesOrder,' + 'BackOrder,PurchaseLineID,' + 'GlobalRef,PurchaseOrderID,ProductGroup,LineTaxRate,Invoiced,' +
      'Batch,UseTimecost,SaleID_Timecost,TimecostMarkupPer,' + 'TimecostPrice,TimecostMarkupDol,ForeignExchangeRate,EditedFlag,' + 'Deleted,RAInvoiceNo,AccountName,AccountGroup,ProductID,' +
      'UnitofMeasureMultiplier,ClassID,AccountNumber,PartType,' + 'IncomeAccnt,AssetAccnt,CalcCostInc,SearchFilter,SearchFilterCopy,' + 'CalcTotalInc,CalcTotalEx,CalcTax,CalcBackOrder,CostCentreId,' +
      'SEQNo,NewForeignExchangeRate,COGSTotalLineAmount,AvgCost,' + 'CustomerJobID,COGSTotalLineAmountInc,LastLineID,RelatedPOID,' + 'RelatedPOIDUsed,PartSpecID,serialno,UnitOfMeasureID,BaseLineno,' +
      'msTimeStamp,INCOMEACCNTID,ASSETACCNTID,COGSACCNTID,' + 'LandedCostsTotal,MatrixRef,MatrixPrice'+ ProductDisabledCustomFields);
  // ,LandedCostsPerItem');

  Inherited;
  closedb(qryUnitOfMeasure);
  opendb(qryUnitOfMeasure);
  ApplyCustomFieldsSettings;
  { datasets must be open for the following }
  // ProductSearcher.UpdateDisplayLabel;
  // ClientSearcher.UpdateDisplayLabel;
  // JobSearcher.UpdateDisplayLabel;

  Order.Lines.DataSet.Filter := Order.TranslineFilter;
  Order.Lines.DataSet.Filtered := true;

  ShowAccountCbo(cboAccountQry.RecordCount > 1);

  (* if AppEnv.CompanyPrefs.DisplayPurhcasesExPrice then begin
    with grdTransactions do begin
    SetActiveField('LineCostInc');
    AddField('LineCost', grdTransactions.GetActiveCol, false);
    RemoveField('LineCostInc');
    ColumnByName('LineCost').DisplayLabel := 'Cost (Ex)';
    ColumnByName('LineCost').DisplayWidth := 10;
    end;
    end; *)

  // Product Combo Product Name Width Set
  TempStr                 := ExtractStrPortion(cboProductR.Selected[0], #9, 2);
  //cboProductR.Selected[0] := ReplaceStr(cboProductR.Selected[0], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductNameDropdownWidth));
  //FormatProductCombo(cboProductR);
  SetGridColumns;

  grdTransactions.SetActiveField('ProductPrintName');
  SetControlFocus(cboClientR);

  SetControlFocus(cboClientR);

  CheckForAttachments;
  // Set comments memo as drop target for files dropped on the form
  DMTextTargetOrder.AcceptorControl := Nil;
  DMTextTargetOrder.AcceptorControl := txtComments;

  cboProductR.PopupMenu            := grdTransactions.PopupMenu;
  cboCustJob.PopupMenu             := grdTransactions.PopupMenu;
  cboUnitOfMeasure.PopupMenu       := grdTransactions.PopupMenu;
  cboPartSpecs.PopupMenu           := grdTransactions.PopupMenu;
  cboClass.PopupMenu               := grdTransactions.PopupMenu;
  cboTaxCode.PopupMenu             := grdTransactions.PopupMenu;
  cboForeignCurrencyCode.PopupMenu := grdTransactions.PopupMenu;
  if tblDetails.IndExFieldNames ='' then tblDetails.IndexFieldNames       := 'LinesOrder ASC CIS';
  cboProductQry.Open;

  bIsInitialising := false;
  stepProgressbar;
  AddProductPriceMenu;
End;

Procedure TBaseOrderGUI.FormDestroy(Sender: TObject);
Begin
  Freeandnil(CustomFieldonGrid);
  // GuiPrefs.Node['SearchMode.ProductMode'].AsInteger:= ProductSearcher.SearchMode;
  // GuiPrefs.Node['SearchMode.ClientMode'].AsInteger:= ClientSearcher.SearchMode;
  // GuiPrefs.Node['SearchMode.JobMode'].AsInteger:= JobSearcher.SearchMode;
  // GuiPrefs.SavePrefs;
  tblDetails.Close;
  tblMaster.Close;
  If Assigned(MyConnection) Then MyConnection.Close;
  // Freeandnil(CustomerJobRepairObj);
  Inherited;

End;
procedure TBaseOrderGUI.AddProductPriceMenu;
begin
  NewMenuForTransGrid('Formula Details' , ProductformulaEntry , FAlse);
end;

procedure TBaseOrderGUI.ApplyCustomFieldsSettings;
begin
  CustomFieldonGrid := TCustomFieldonGrid.Create(Self , 'CustomField1,CustomField2,CustomField3,CustomField4,CustomField5,CustomField6,CustomField7,CustomField8,CustomField9,CustomField10' , ltOrderLines , grdtransactions, guiprefs, Order);
  CustomFieldonGrid.ApplyCustomFieldsSettings;
end;

Procedure TBaseOrderGUI.DoOnClientchange;
begin
  If (Empty(cboClientR.Text)) or (Order.SupplierId =0)  Then Exit;
  try
    if cboClientR.LookupTable.FieldByName('company').asString <> cboClientR.Text then
      cboClientR.LookupTable.locate('company', cboClientR.Text , []);
  Except
    // kill the exception
  end;

  Try
    If cboAccountQry.IsEmpty Then Begin
      Commonlib.MessageDlgXP_Vista('No Accounts Payable Account !', mtWarning, [mbOK], 0);
      Self.Close;
    End;

    If cboClientLookup.FieldByName('ClientId').AsInteger <> Order.ID Then Begin
      cboClientLookup.Close;
      cboClientLookup.Open;
    End;
   
    Order.InitAPAccount;

    If cboViaQry.Locate('ShippingMethodID', cboClientLookup.FieldByName('ShippingID').AsInteger, [loCaseInsensitive]) Then Begin
      cboVia.LookupValue := cboViaQry.FieldByName('ShippingMethod').AsString;
    End Else Begin
      cboVia.LookupValue := '';
    End;

    If cboTermsQry.Locate('TermsID', cboClientLookup.FieldByName('TermsID').AsInteger, [loCaseInsensitive]) Then Begin
      cboTerms.LookupValue := cboTermsQry.FieldByName('Terms').AsString;
    End Else Begin
      cboTerms.LookupValue := 'Due on Receipt';
    End;

    Order.OrderTo := Order.Supplier.ShipToAddress;

    Inherited;

  Except
    On EAbort Do HandleEAbortException;
    On e: ENoAccess Do Begin
      HandleNoAccessException(e);
      Exit;
    End;
    On e: Exception Do Raise;
  End;
End;

procedure TBaseOrderGUI.DoOnProductchange;
begin
  inherited;
  ProductformulaEntry(nil);
end;

Procedure TBaseOrderGUI.cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
Begin
  If Not Modified Then Exit;
  cboTermsQry.Locate('Terms', cboTerms.Text, [loCaseInsensitive]);
  SetTerms(LookupTable, FillTable);
End;

Procedure TBaseOrderGUI.cboCustomerJobNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: boolean);
Begin
  // CommonLib.MessageDlgXP_Vista('Customer''s Name Not in List !', mtWarning, [mbOK], 0);
  // cboCustomerJob.LookupValue := '';
  // SetControlFocus(cboCustomerJob);
End;

Procedure TBaseOrderGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
Begin
  If Not Modified Then Exit;
  Inherited;
  FillTable.Edit;
  FillTable.FieldByName('ClassID').AsInteger := LookupTable.FieldByName('ClassID').AsInteger;
End;

Procedure TBaseOrderGUI.cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
Begin
  If Not Modified Then Exit;
  Inherited;
  FillTable.Edit;
  FillTable.FieldByName('AccountID').AsInteger := LookupTable.FieldByName('AccountID').AsInteger;
End;

Function TBaseOrderGUI.GetTaxAccountName: String;
Begin
  Result := 'Tax Paid';
End;

Function TBaseOrderGUI.GetDocumentNoName: String;
Begin
  Result := 'PurchaseOrderNumber';
End;

function TBaseOrderGUI.GetOrAddMobileNumber: string;
var
  aContact: TContact;
  aSupplier : TSupplier;
begin
  result := Order.ContactMobile;
  if result = '' then
    result := Order.Supplier.Mobile;
  if result = '' then begin
    if Order.ContactID > 0 then begin
      { contact mobile }
      result := frmMobileNumberInput.GetMobileNumberFromUser('Contact (' + Order.ContactName +
        ') does not have a mobile number.' +#13#10 + 'Please enter a number.');
      if result <> '' then begin
        aContact := TContact.Create(nil);
        try
          aContact.Connection := TMyDacDataConnection.Create(aContact);
          aContact.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
          aContact.Load(Order.ContactID);
          if aContact.Lock then begin  { only update if we can lock }
            try
              aContact.ContactMOB := result;
              aContact.PostDb;
            finally
              aContact.UnLock;
            end;
          end;
        finally
          aContact.Free;
        end;
      end;
    end
    else begin
      { customer mobile }
      result := GetMobileNumberFromUser('Supplier (' + Order.SupplierName +
        ') does not have a mobile number.' + #13#10 + 'Please enter a number.');
      if result <> '' then begin
        aSupplier := TSupplier.Create(nil);
        try
          aSupplier.Connection := TMyDacDataConnection.Create(aSupplier);
          aSupplier.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
          aSupplier.Load(Order.SupplierID);
          if aSupplier.Lock then begin  { only update if we can lock }
            try
              aSupplier.Mobile := result;
              aSupplier.PostDb;
              Order.Supplier.RefreshDB;
            finally
              aSupplier.UnLock;
            end;
          end;
        finally
          aSupplier.Free;
        end;
      end;
    end;
  end
  else begin
    if (not SMSUtils.NumberHasPlusPrefix(result)) or (not SMSUtils.NumberHasCountryCode(result,MyConnection)) then begin
      if Order.ContactID > 0 then begin
        { contact mobile }
        result := GetMobileNumberFromUser('Contact (' + Order.ContactName +
          ') number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.', result, MyConnection);
        if result <> '' then begin
          aContact := TContact.Create(nil);
          try
            aContact.Connection := TMyDacDataConnection.Create(aContact);
            aContact.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
            aContact.Load(Order.ContactID);
            if aContact.Lock then begin  { only update if we can lock }
              try
                aContact.ContactMOB := result;
                aContact.PostDb;
              finally
                aContact.UnLock;
              end;
            end;
          finally
            aContact.Free;
          end;
        end;
      end
      else begin
        { customer mobile }
        result := GetMobileNumberFromUser('Supplier (' + Order.SupplierName +
          ') number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.', result, MyConnection);
        if result <> '' then begin
          aSupplier := TSupplier.Create(nil);
          try
            aSupplier.Connection := TMyDacDataConnection.Create(aSupplier);
            aSupplier.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
            aSupplier.Load(Order.SupplierID);
            if aSupplier.Lock then begin  { only update if we can lock }
              try
                aSupplier.Mobile := result;
                aSupplier.PostDb;
                Order.Supplier.RefreshDB;
              finally
                aSupplier.UnLock;
              end;
            end;
          finally
            aSupplier.Free;
          end;
        end;
      end;
    end;
  end;
end;

Procedure TBaseOrderGUI.tblDetailsQtySoldChange(Sender: TField);
Begin
  Inherited;
  RefreshCalcs;
End;

Procedure TBaseOrderGUI.tblDetailsShippedChange(Sender: TField);
Begin
  If (Self.ClassName = 'TReturnAGUI') Then Begin
    // Recalculate Totals
    RefreshCalcs;

    // This bit updates the Attrib1/2/3 fields, ie for plaster boards, cartons of beer, bulk-buy ear diggers etc
    If tblDetails.FieldByName('Shipped').IsNull Then tblDetails.FieldByName('Shipped').AsFloat := 0;
    tblDetails.FieldByName('Attrib1Purchase').AsFloat := cboProductR.LookupTable.FieldByName('Attrib1Purchase').AsFloat * tblDetails.FieldByName('Shipped').AsFloat;
    tblDetails.FieldByName('Attrib2Purchase').AsFloat     := cboProductR.LookupTable.FieldByName('Attrib2Purchase').AsFloat * tblDetails.FieldByName('Shipped').AsFloat;
    tblDetails.FieldByName('Attrib1PurchaseEst').AsFloat := cboProductR.LookupTable.FieldByName('Attrib1Purchase').AsFloat * tblDetailsQtySold.AsFloat;
    tblDetails.FieldByName('Attrib2PurchaseEst').AsFloat     := cboProductR.LookupTable.FieldByName('Attrib2Purchase').AsFloat * tblDetailsQtySold.AsFloat;
    tblDetails.FieldByName('Attrib1PurchaseRate').AsFloat := cboProductR.LookupTable.FieldByName('Attrib1PurchaseRate').AsFloat;
  End;
End;

Procedure TBaseOrderGUI.tblDetailsLineTaxCodeChange(Sender: TField);
Begin
  Inherited;
  RefreshCalcs;
End;

Procedure TBaseOrderGUI.tblDetailsLineCostChange(Sender: TField);
Begin
  Inherited;
  If Not RunOnce Then Begin
    RunOnce := true;
    RefreshCalcs;
    RunOnce := false;
  End;
End;

Procedure TBaseOrderGUI.grdTransactionsEnter(Sender: TObject);
Begin
  If Empty(cboClientR.Text) Then Begin
    Commonlib.MessageDlgXP_Vista('What NO Supplier !', mtWarning, [mbOK], 0);
    SetControlFocus(cboClientR);
  End;

  Inherited;
End;

Procedure TBaseOrderGUI.grdTransactionsRowChanged(Sender: TObject);
Begin
  // CustomerJobRepairObj.rowchanged;
  If Not(Screen.activecontrol = grdTransactions) Then Exit;
  If Order.Lines.count = 0 Then Exit;

  Inherited;
  RefreshUnitsQry;
End;

Procedure TBaseOrderGUI.cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
Begin
  If Not Modified Then Exit;
  Inherited;
End;

procedure TBaseOrderGUI.tblMasterCalcFields(DataSet: TDataSet);
var
  dt: TDateTime;
begin
  inherited;
  try
    if tblMasterEnteredAt.AsString <> '' then begin
      dt := StrToTime(tblMasterEnteredAt.AsString);
      tblMasterEnteredAtShort.AsString := FormatDateTime(FormatSettings.ShortTimeFormat,dt);
    end
    else begin
      tblMasterEnteredAtShort.AsString := '';
    end;
  except
    tblMasterEnteredAtShort.AsString := tblMasterEnteredAt.AsString;
    exit;
  end;
end;

Procedure TBaseOrderGUI.tblMasterInvoiceDateChange(Sender: TField);
Begin
  Inherited;
  cboTermsQry.Locate('Terms', cboTerms.Text, [loCaseInsensitive]);
  cboTermsCloseUp(Nil, cboTermsQry, tblMaster, true);
End;

Procedure TBaseOrderGUI.CalcAttribsTotals;
Var
  Attrib1Purchase, Attrib2Purchase, Attrib1PurchaseRate_Price: double;
  bm: TBookmark;
  Attrib1PurchaseEst, Attrib2PurchaseEst:Double;
Begin
  Attrib1Purchase           := 0.00;
  Attrib2Purchase           := 0.00;
  Attrib1PurchaseRate_Price := 0.00;
  Attrib1PurchaseEst        := 0.00;
  Attrib2PurchaseEst        := 0.00;
  bm                        := tblDetails.GetBookmark;
  Try
    tblDetails.DisableControls;
    With tblDetails Do Begin
      First;
      While Not Eof Do Begin
        Attrib1Purchase           := Attrib1Purchase + tblDetailsAttrib1Purchase.AsFloat;
        Attrib2Purchase           := Attrib2Purchase + tblDetailsAttrib2Purchase.AsFloat;
        Attrib1PurchaseRate_Price := Attrib1PurchaseRate_Price + tblDetailsTotalLineAmount.AsFloat;
        Attrib1PurchaseEst        := Attrib1Purchase + tblDetailsAttrib1Purchase.AsFloat;
        Attrib2PurchaseEst        := Attrib2Purchase + tblDetailsAttrib2Purchase.AsFloat;
        Next;
      End;
    End;
  Finally
    tblDetails.EnableControls;
    tblDetails.GotoBookmark(bm);
    tblDetails.FreeBookmark(bm);
  End;
  grdTransactions.ColumnByName('Attrib1Purchase').FooterValue     := FloatToStrF(Attrib1Purchase, ffNumber, 15, 2);
  grdTransactions.ColumnByName('Attrib2Purchase').FooterValue     := FloatToStrF(Attrib2Purchase, ffNumber, 15, 2);
  grdTransactions.ColumnByName('Attrib1PurchaseRate').FooterValue := FloatToStrF(DivZer(Attrib1PurchaseRate_Price, Attrib1Purchase), ffCurrency, 15, CurrencyRoundPlaces);
  grdTransactions.ColumnByName('Attrib1PurchaseEst').FooterValue     := FloatToStrF(Attrib1PurchaseEst, ffNumber, 15, 2);
  grdTransactions.ColumnByName('Attrib2PurchaseEst').FooterValue     := FloatToStrF(Attrib2PurchaseEst, ffNumber, 15, 2);
End;

Procedure TBaseOrderGUI.FormActivate(Sender: TObject);
Begin
  Inherited;
  // This must remain!
  bIsInitialising := false;
End;

// procedure TBaseOrderGUI.RequeryFilteredProducts;
// var
// iX: integer;
// A: integer;
// begin
// if fbIsClosing then Exit;
// with cboProductQry do begin
// Close;
// for iX := 0 to SQL.Count - 1 do begin
// // Test to see if this SQL line is the WHERE clause.
// A := FastFuncs.PosExIgnoreCase('WHERE ',SQL.Strings[iX]);
// if A >0 then Break;
// end;
//
// // Test to see if a search filter has been provided?
// if tblDetailsSearchFilter.AsString <> '' then begin
// // Yes, then setup query to get only filtered matched products.
/// /      if SearchMode = smSearchEngineLike then
// SQL.Strings[iX] := 'WHERE (Active = ' + QuotedStr('T') + ' AND PARTNAME LIKE ' +
// QuotedStr('%' + tblDetailsSearchFilter.AsString + '%') + ')';
/// /      if SearchMode = smSearchEngine then
/// /        SQL.Strings[iX] := 'WHERE (Active = ' + QuotedStr('T') + ' AND PARTNAME LIKE ' +
/// /          QuotedStr(tblDetailsSearchFilter.AsString + '%') + ')';
// end else begin
// // Otherwise, hit us with every product.
// SQL.Strings[iX] := 'WHERE (Active = ' + QuotedStr('T') + ')';
// end;
//
// // We need to get rid of this to ensure we get an appropriate list.
// if SQL.Strings[SQL.Count - 1] = 'LIMIT 0' then SQL.Delete(SQL.Count - 1);
//
// Open;
// end;
// end;
//
// procedure TBaseOrderGUI.RequeryFilteredProducts(const FilterString: string);
// var
// iX: integer;
// A: integer;
// begin
// with cboProductQry do begin
// Close;
// for iX := 0 to SQL.Count - 1 do begin
// // Test to see if this SQL line is the WHERE clause.
// A := FastFuncs.PosExIgnoreCase('WHERE ', SQL.Strings[iX]);
// if A >0 then Break;
// end;
//
// // Yes, then setup query to get only filtered matched products.
// SQL.Strings[iX] := 'WHERE (Active = ' + QuotedStr('T') + ' AND PARTSID LIKE ' + QuotedStr(FilterString + '%') + ')';
// // We need to get rid of this to ensure we get an appropriate list.
// if SQL.Strings[SQL.Count - 1] = 'LIMIT 0' then SQL.Delete(SQL.Count - 1);
// Open;
// end;
// end;

Procedure TBaseOrderGUI.grdTransactionsFieldChanged(Sender: TObject; Field: TField);
// var
// iPos: integer;
Begin
  Inherited;
  If Not Assigned(Field) Then Exit;
  If (Field = tblDetailsUnitofMeasureQtySold) Then Begin
    RefreshCalcs;
    Exit;
  End;

End;

Procedure TBaseOrderGUI.grdTransactionsKeyDown(Sender: TObject; Var Key: word; Shift: TShiftState);
Begin
  If ((SameText(ActiveField(Sender).FieldName, 'MatrixDesc')) Or (SameText(ActiveField(Sender).FieldName, 'MatrixPrice'))) And (Key <> vk_return) And (Key <> vk_tab) Then Begin
    Key := 0;
    Exit;
  End;
  Inherited;
End;
procedure TBaseOrderGUI.SetProductcustomFields;
begin
  OpenQryCustomField('CFProduct');
  tblDetailsProduct_CUSTFLD1.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel1').AsString;
  tblDetailsProduct_CUSTFLD2.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel2').AsString;
  tblDetailsProduct_CUSTFLD3.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel3').AsString;
  tblDetailsProduct_CUSTFLD4.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel4').AsString;
  tblDetailsProduct_CUSTFLD5.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel5').AsString;
  tblDetailsProduct_CUSTFLD6.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel6').AsString;
  tblDetailsProduct_CUSTFLD7.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel7').AsString;
  tblDetailsProduct_CUSTFLD8.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel8').AsString;
  tblDetailsProduct_CUSTFLD9.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel9').AsString;
  tblDetailsProduct_CUSTFLD10.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel10').AsString;
  tblDetailsProduct_CUSTFLD11.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel11').AsString;
  tblDetailsProduct_CUSTFLD12.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel12').AsString;
  tblDetailsProduct_CUSTFLD13.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel13').AsString;
  tblDetailsProduct_CUSTFLD14.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel14').AsString;
  tblDetailsProduct_CUSTFLD15.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel15').AsString;
  tblDetailsProduct_CUSTDATE1.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel16').AsString;
  tblDetailsProduct_CUSTDATE2.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel17').AsString;
  tblDetailsProduct_CUSTDATE3.DisplayLabel := 'Product''s ' + QryCustomField.FieldByName('CFLabel18').AsString;
end;
Procedure TBaseOrderGUI.FormCreate(Sender: TObject);
Begin
  DefaultValueForAreaFromHint(Appenv.CompanyPrefs.PODefaultValueForAreaFrom);
  Newbarcode     := '';
  barCodeCreated := false;
  Inherited;

  fbCustomerJobState := true;
  fbDontRefreshCalcs := false;
  fbIsClosing        := false;
  fbRecordCancelled  := false;
  fLastComboAccessed := Nil;

  // Register to accept the custom formats that Outlook supplies.
  // We've also included dtfCustom in AcceptTextFormats at design time.
  With DMTextTargetOrder, CustomFormats Do Begin
    OverrideDropEffects[deMove] := deCopy;
    Add('FileGroupDescriptor');
    AddObject('FileContents', TObject(TYMED_ISTREAM));
  End;

  SetProductcustomFields;
End;

Procedure TBaseOrderGUI.grdTransactionsCalcTitleAttributes(Sender: TObject; Const AFieldName: String; Const AFont: TFont; Const ABrush: TBrush; Var ATitleAlignment: TAlignment);
Begin
  Inherited;
  If (SysUtils.SameText(AFieldName, 'CustomerJob')) Then Begin
    ABrush.Color := clBtnFace;
  End;
End;

// procedure TBaseOrderGUI.tblDetailsSearchFilterValidate(Sender: TField);
// var
// iPos: integer;
// begin
// inherited;
//
// if (Sender.FieldName = 'SearchFilter') and (Sender.AsString = '') then begin
// if fbIsClosing then Exit;
// // Refresh our product list.
// RequeryFilteredProducts;
// iPos := GetGridColumnIndex(grdTransactions, 'SearchFilter');
// grdTransactions.KeyOptions := [dgAllowInsert];
// grdTransactions.AddField('ProductName', iPos, false);
// grdTransactions.RemoveField('SearchFilter');
// grdTransactions.ColumnByName('ProductName').DisplayLabel := 'Product';
// grdTransactions.ColumnByName('ProductName').DisplayWidth := 17;
// grdTransactions.SetActiveField('ProductName');
// //  cboProductX.Visible := true;
// // Are we to dropdown the product combo box.
// //   if not fbDontDropProductList then begin
// // Yes, then do so.
// //     cboProductX.DropDown;
// //   end;
// end;
// end;

Procedure TBaseOrderGUI.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
  // State that the form is closing.
  fbIsClosing := true;
  Inherited;
End;

Procedure TBaseOrderGUI.btnCompletedClick(Sender: TObject);
Begin
  TfmSupplier.CloseMe; // This Is To Stop Lock Timeout Errors
  Inherited;
End;

Procedure TBaseOrderGUI.cboProductQryAfterOpen(DataSet: TDataSet);
Begin
  Inherited;
  cboProductQry.IndexFieldNames := QuotedStr('PartName') + ' ASC CIS';
End;

Procedure TBaseOrderGUI.cboCustomerJobExit(Sender: TObject);
Begin
  Inherited;
  // if Empty(cboCustomerJob.Text) then begin
  // tblDetails.Edit;
  // tblDetailsCustomerJobID.AsInteger := 0;
  // end;
End;

Procedure TBaseOrderGUI.qryCustomerJobAfterOpen(DataSet: TDataSet);
Begin
  Inherited;
  If fbCustomerJobState Then Begin
    qryCustomerJob.IndexFieldNames := 'Company ASC CIS';
  End Else Begin
    qryCustomerJob.IndexFieldNames := JOBNUMBER_FIELDNAME + ' ASC CIS';
  End;
End;

procedure TBaseOrderGUI.qryUnitOfMeasureBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryUnitOfMeasure.ParamByName('xPartID').AsInteger := tblDetails.FieldByName('ProductID').AsInteger;
end;

Procedure TBaseOrderGUI.FormKeyDown(Sender: TObject; Var Key: word; Shift: TShiftState);
Begin
  Inherited;
  // if (self.ActiveControl = cboProductR) and
  // ((Key = VK_RETURN) or (Key = VK_TAB)) and (cboProductR.SelText = '') then begin
  // Key := 0;
  // exit;
  // end;
  If tblMasterClientID.AsInteger < 1 Then Exit;
  // if ((Key = VK_ESCAPE) or (key = 0)) and (ActiveControl = cboProductR) then
  // cboProductR.Text:= '';
  // if ((Key = VK_ESCAPE) or (key = 0)) and (ActiveControl = cboProductR) then
  // cboProductR.Text:= '';
End;

{ maybe this could be centralised as is duplicated code in BaseSales }
/// ////////////////////////////////////////////////////////////////////////////
// function TBaseOrderGUI.DoSameProductSearch(SearchText:string):Boolean;
// begin
// Result := False;
// if SearchText = '' then exit;
// if cboProductqry.Active then cboProductqry.Close;
// cboProductqry.SQL.Text := fProductLookupSQL;
// cboProductqry.sql.Text := AnsiReplaceText(cboProductqry.sql.Text,'Limit 0','AND PartName = "' + SearchText + '"');
//
// cboProductqry.Open;
// cboProductR.LookupTable.Refresh;
// if cboProductqry.RecordCount > 0 then begin
// Application.ProcessMessages;
// cboProductR.DropDown;
// Result := True;
// end;
// end;

// function TBaseOrderGUI.DoProductSearch(SearchText:string):Boolean;
// begin
// Result := False;
// fProductSearched := True;
// if SearchText = '' then exit;
// if cboProductqry.Active then cboProductqry.Close;
// cboProductqry.SQL.Text := fProductLookupSQL;
// cboProductqry.sql.Text := AnsiReplaceText(cboProductqry.sql.Text,'Limit 0','AND PartName LIKE "' + SearchText + '%"');
//
// cboProductqry.Open;
// cboProductR.LookupTable.Refresh;
// if cboProductqry.RecordCount > 0 then begin
// Application.ProcessMessages;
// cboProductR.DropDown;
// Result := True;
// end;
// end;

// function  TBaseOrderGUI.IsProductInList(sProductName:string):Boolean;
// var
// frm:TComponent;
// SavedCursor:TCursor;
// begin
// Result := True;
// if sProductName <> '' then begin
// if not cboProductqry.Locate('PartsDescription',sProductName,[loCaseInsensitive]) then begin
// Result := False;
// //    fLastComboAccessed := cboProductR;
// if (CommonLib.MessageDlgXP_Vista('Product name not in list. Do you wish to create it?', mtConfirmation , [mbYes, mbNo], 0) = mrYes) then begin
// Processingcursor(True);
// try
// frm := TfrmParts(GetComponentByClassName('TfrmParts'));
// TfrmParts(frm).fsPartName := sProductName;
// TfrmParts(frm).ShowModal;
// if TfrmParts(frm).ModalResult = mrOK then begin
// Result := True;
// cboProductQry.Close;
// cboProductQry.Open;
// cboProductR.LookupTable.Refresh;
// end else if TfrmParts(frm).ModalResult = mrCancel then Result := False;
//
// finally
// Processingcursor(False);
// end;
// end;
// end;
// end else Result := False;
// end;

/// /////////////////////////////////////////////////////////////////////////////////////////////

Procedure TBaseOrderGUI.FormKeyPress(Sender: TObject; Var Key: char);
Begin
  // used to signal beginning of a barcode
  // if Key = '~' then Key := Chr(0);
  Inherited;
End;

// ---------- File Attachment Stuff --------------------------------------------

Procedure TBaseOrderGUI.ShowAttachments(fbDragnDropping :Boolean);
Var Form: TComponent;
Begin
  If tblMasterPurchaseOrderID.AsInteger < 1 Then Exit;
  Form := GetComponentByClassName('TfmAttachments', true, Self, true, true, tblMasterPurchaseOrderID.AsInteger);
  If Assigned(Form) Then Begin
    With TfmAttachments(Form) Do Begin
      DBConnection := Self.MyConnection;
      AttachObserver(Self);
      TableName := 'tblPurchaseOrders';
      TableId   := tblMasterPurchaseOrderID.AsInteger;
      Tag       := tblMasterPurchaseOrderID.AsInteger;
      DragnDropping :=fbDragnDropping;
      FormStyle := fsMDIChild;
      BringToFront;
    End;
  End;
End;

procedure TBaseOrderGUI.ShowFormulafields;
begin
  inherited;
  Setcolumn(Appenv.CompanyPrefs.Fe1Visible,tblDetailsFormulaQtySoldValue1.fieldname,Appenv.CompanyPrefs.Fe1Name);
  Setcolumn(Appenv.CompanyPrefs.Fe2Visible,tblDetailsFormulaQtySoldValue2.fieldname,Appenv.CompanyPrefs.Fe2Name);
  Setcolumn(Appenv.CompanyPrefs.Fe3Visible,tblDetailsFormulaQtySoldValue3.fieldname,Appenv.CompanyPrefs.Fe3Name);
  Setcolumn(Appenv.CompanyPrefs.Fe4Visible,tblDetailsFormulaQtySoldValue4.fieldname,Appenv.CompanyPrefs.Fe4Name);
  Setcolumn(Appenv.CompanyPrefs.Fe5Visible,tblDetailsFormulaQtySoldValue5.fieldname,Appenv.CompanyPrefs.Fe5Name);
  Setcolumn(Appenv.CompanyPrefs.Fe1Visible,tblDetailsFormulaQtyShippedValue1.fieldname,Appenv.CompanyPrefs.Fe1Name);
  Setcolumn(Appenv.CompanyPrefs.Fe2Visible,tblDetailsFormulaQtyShippedValue2.fieldname,Appenv.CompanyPrefs.Fe2Name);
  Setcolumn(Appenv.CompanyPrefs.Fe3Visible,tblDetailsFormulaQtyShippedValue3.fieldname,Appenv.CompanyPrefs.Fe3Name);
  Setcolumn(Appenv.CompanyPrefs.Fe4Visible,tblDetailsFormulaQtyShippedValue4.fieldname,Appenv.CompanyPrefs.Fe4Name);
  Setcolumn(Appenv.CompanyPrefs.Fe5Visible,tblDetailsFormulaQtyShippedValue5.fieldname,Appenv.CompanyPrefs.Fe5Name);
  Setcolumn(Appenv.CompanyPrefs.Fe1Visible or
            Appenv.CompanyPrefs.Fe2Visible or
            Appenv.CompanyPrefs.Fe3Visible or
            Appenv.CompanyPrefs.Fe4Visible or
            Appenv.CompanyPrefs.Fe5Visible ,tblDetailsFormulaQtySoldValue.fieldname , 'Formula ' + tbldetailsUnitofMeasureQtySold.displaylabel );

  Setcolumn(Appenv.CompanyPrefs.Fe1Visible or
            Appenv.CompanyPrefs.Fe2Visible or
            Appenv.CompanyPrefs.Fe3Visible or
            Appenv.CompanyPrefs.Fe4Visible or
            Appenv.CompanyPrefs.Fe5Visible ,tblDetailsFormulaQtyShippedValue.fieldname , 'Formula ' + tbldetailsUnitofMeasureShipped.displaylabel );

end;

procedure TBaseOrderGUI.DisableLineZeroQtyWarning(Sender: TObject;
  Checked: boolean);
begin
  AppEnv.CompanyPrefs.DisablePurchaseLineZeroQuantityWarning := Checked;
end;

Procedure TBaseOrderGUI.DMTextTargetOrderDrop(Sender: TObject; Acceptor: TWinControl; Const DropText: String; X, Y: integer);
Var Form: TComponent;
Begin
  Inherited;
  If tblMasterPurchaseOrderID.AsInteger < 1 Then Exit;
  ShowAttachments(true);
  Form := FindExistingComponent('TfmAttachments', tblMasterPurchaseOrderID.AsInteger);
  If Assigned(Form) Then TfmAttachments(Form).DMTextTargetDrop(Sender, Acceptor, DropText, X, Y);
End;

Procedure TBaseOrderGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; Const EventType, value: String);
Var MatrixDesc: String; MatrixRef: String; MatrixPrice: double;
Begin
  Inherited;
{-->} if Sender is TFEPOLines then begin
          TFEPOLines(Sender).Dataset                           := tblFEPOLines;
{-->} end else if Sender is TFEPOlinesRelatedPrs then begin
          TFEPOlinesRelatedPrs(Sender).Dataset  := tblFEPOlinesRelatedPrs;
{-->} end else If (EventType = BusObjEvent_Change) And (value = BusObjEventVal_ProductChanged) Then Begin
        If Not Order.Lines.deleted Then Begin
          ReadPurchaseDefaultPriceMethod(Order.Lines.ProductID, MatrixDesc, MatrixRef, MatrixPrice);
          SetMatrixDetails(MatrixDesc, MatrixRef, MatrixPrice);
        End;
{-->} End Else If (EventType = BusObjEvent_POCommentPopUp) Then Begin
        DelayMessageDlg(value, mtInformation, [mbOK], 0);
{-->} end else if (EventType = BusObjEvent_Change) And (value = BusObjEventVal_ClientID) then begin
        InitClientLookupCombonFields;
        Opendb(qryClientLookup);
        DoDelayObjectProcedure(DoOnClientchange,10, Self.classname +'.DoOnClientchange');
{-->} end else if (EventType = BusObjEvent_Change) And (value = BusObjEventVal_uomChanged) then begin
        if qryUnitOfMeasureUnitID.AsInteger <> Order.Lines.UnitOfMeasureID then begin
           closedb(qryUnitOfMeasure);
           opendb(qryUnitOfMeasure);
           qryUnitOfMeasure.locate('unitID' , Order.Lines.UnitOfMeasureID , []);
        end;
{-->} end else if (EventType = BusobjEvent_ToDo) and (Value = BusObjEvent_BlankAccount) and (Sender is TTransBase) then begin
        ShowAccountCbo((Order.GLAccountId =0) or (Order.GLAccountname = ''));
      End
      else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_CalculationsDisabled) then begin
        lblDisableCalc.visible := TransBase.Lines.count > appenv.CompanyPrefs.OrderLinesToDisableCalcs;
      end
      else if (Eventtype = BusObjEvent_Warning) and (Value = BusObjEventVal_Warn_ZeroLineQty) then begin
        CommonLib.MessageDlgXP_Vista('The Quantity for ' + Order.Lines.ProductName +
          ' is "0" and ERP Has Taken It That This Was Intentional. If Not Please Re-open This Order ' + IntToStr(Order.Id) +
          ' and Adjust the Ordered Quantity.',mtInformation,[mbOK],0,nil,'','Disable This Quantity Warning',false,DisableLineZeroQtyWarning);
      end;
End;

Procedure TBaseOrderGUI.ShowAccountCbo(Const Value:Boolean);
begin
  cboAccount.Visible := Value;
  lblAccount.Visible := Value;
end;
procedure TBaseOrderGUI.beforeshowCustomfieldList(Sender: TObject);
begin
  if not(Sender is TfmCustomfieldList) then Exit;
  TfmCustomfieldList(Sender).ListType := ltOrderlines;
end;

Procedure TBaseOrderGUI.btnAttachmentsClick(Sender: TObject);
Begin
  Inherited;
  ShowAttachments(False);
End;

Procedure TBaseOrderGUI.CheckForAttachments;
Var
  qry: TERPQuery;
Begin
  If tblMasterPurchaseOrderID.AsInteger < 1 Then Begin
    btnAttachments.Enabled := false;
    Exit; // PO id
  End;
    qry := DbSharedObj.GetQuery(Order.connection.connection);
    try
      With qry do begin
        closedb(qry);
        sql.text :='SELECT AttachmentName FROM tblAttachments WHERE TableName = "tblPurchaseOrders"' +
              ' AND TableId = ' + IntToStr(Order.ID);
        opendb(qry);
        if RecordCount > 0 then btnAttachments.Color := $0077ff77
        else btnAttachments.Color := clBtnFace;
      end;
    finally
        DbSharedObj.ReleaseObj(qry);
    end;

(*
  qry                     := TERPQuery.Create(Nil);
  qry.Options.FlatBuffers := true;
  Try
    qry.Connection := MyConnection;
    qry.SQL.Text   := 'SELECT AttachmentName FROM tblAttachments WHERE TableName = "tblPurchaseOrders"' + ' AND TableId = ' + tblMasterPurchaseOrderID.AsString;
    qry.Open;
    btnAttachments.Enabled := qry.RecordCount > 0;
    qry.Close;
  Finally FreeAndNil(qry);
  End;
*)
End;

function TBaseOrderGUI.ClientState    :String;begin  REsult:= Order.Supplier.State   ;end;
function TBaseOrderGUI.Clientcountry  :String;begin  REsult:= Order.Supplier.country ;end;
function TBaseOrderGUI.clientLocation :String;begin  REsult:= Order.Supplier.suburb  ;end;
function TBaseOrderGUI.ClientPostcode :String;begin  REsult:= Order.Supplier.PostCode;end;

Procedure TBaseOrderGUI.UpdateMe;
Begin
  if accesslevel >= 5 then exit;
  Inherited;
  // somthing has changed on attachments form so update
  CheckForAttachments;
  // Update header to flag that changes have taken place
  Order.LastUpdated := Now;
  if fLastComboAccessed = cboVia then begin
    cboVia.LookupTable.Close;
    cboVia.LookupTable.Open;
  end;
End;

// -----------------------------------------------------------------------------

Procedure TBaseOrderGUI.tblDetailsUnitofMeasurePOLinesChange(Sender: TField);
Begin
  Inherited;
  tblDetailsUnitOfMeasureID.AsInteger := qryUnitOfMeasureUnitID.AsInteger;
End;

Procedure TBaseOrderGUI.RefreshUnitsQry;
Begin
  qryUnitOfMeasure.Close;
  //qryUnitOfMeasure.ParamByName('xPartID').AsInteger := tblDetailsProductID.AsInteger;
  qryUnitOfMeasure.Open;
End;

Procedure TBaseOrderGUI.tblDetailsProductNameChange(Sender: TField);
Begin
  Inherited;
  RefreshUnitsQry;
End;


Procedure TBaseOrderGUI.grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: String);
Begin
  // if (Sysutils.SameText(AFieldName , CustomerJobRepairObj.Jobnamefield))   then begin
  // CustomerJobRepairObj.JobCustomerSetUp;
  // /end else begin
  Inherited;
  // end;
End;

Function TBaseOrderGUI.MatrixReporttype: String;
Begin
  Result := 'PO';
End;


procedure TBaseOrderGUI.NewTransBusObjinstance;
begin
  TransBase := Order;
  inherited;
end;


Procedure TBaseOrderGUI.grdTransactionsDblClick(Sender: TObject);
Var sMatrixDesc: String; sMatrixRef: String; dMatrixPrice: double;
Begin
(*  if TField(grdTransactions.GetActiveField).FieldName = 'ProductName' then
    if ProductformulaEntry then Exit;*)

  If (TField(grdTransactions.GetActiveField).FieldName = 'MatrixDesc') Or (TField(grdTransactions.GetActiveField).FieldName = 'MatrixPrice') Then Begin
    sMatrixDesc  := Order.Lines.MatrixDesc;
    sMatrixRef   := Order.Lines.MatrixRef;
    dMatrixPrice := Order.Lines.MatrixPrice;
    TfmpartsPriceMatrixInput.PriceMAtrix(Self, sMatrixRef, sMatrixDesc, dMatrixPrice, Order.Lines.ProductID, MyConnection);
    SetMatrixDetails(sMatrixDesc, sMatrixRef, dMatrixPrice);
    Abort; // this is to cancel the memodialag popup for this field
  End
  Else If (SameText(ActiveField(Sender).FieldName, 'Memoline')) Then Begin
    DoDBMemoDialog(tblDetailsMemoLine.AsString, tblDetailsMemoLine.Displaylabel, tblDetailsMemoLine);
  End;
  Inherited;

End;

Procedure TBaseOrderGUI.grdTransactionsExit(Sender: TObject);
Begin
  Inherited;
  Application.ProcessMessages;
End;

Procedure TBaseOrderGUI.cboClientREnter(Sender: TObject);
Begin
  Inherited;
  fLastComboAccessed := cboClientR;
End;

procedure TBaseOrderGUI.cboProductRAfterchange(Sender: TObject);
begin
  inherited;
  if Order.lines.cleanproductname  <> Order.lines.Productname then DoOnProductchange;
end;

Procedure TBaseOrderGUI.cboProductRNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: boolean);
Var frm: TBaseInputGUI;
Begin
  { NOTE : Need to close the form prior to showing modally, otherwise Access Viol
    trying to modalise a visible form }
  If Trim(cboProductR.Text) = '~' Then Begin
    Accept := false;
    Exit;
  End;
  // if cboProductR.LookupTable.RecordCount <> 0 then begin
  frm    := Nil;
  Accept := false;
  If Commonlib.MessageDlgXP_Vista('Product not found in list. Would you like to create this Product?', mtConfirmation, [mbYes, mbNo], 0) = mrYes Then Begin
    Try
      tblDetails.Edit;
      If TfrmParts.FormActive Then Begin
        TfrmParts.CloseMe;
      End;

      frm := TfrmParts(GetComponentByClassName('TfrmParts'));
      If Assigned(frm) Then Begin
        TfrmParts(frm).fsPartName := NewValue;
        frm.Position              := poScreenCenter;
        If Not frm.Visible Then frm.ShowModal;
      End;
    Finally
      cboProductQry.Close;
      cboProductQry.Open;
      If Not Empty(TfrmParts(frm).fsPartName) Then Begin
        If cboProductQry.Locate('PartName', TfrmParts(frm).fsPartName, [loCaseInsensitive]) Then Begin
          cboProductR.Text := TfrmParts(frm).fsPartName;
          cboProductR.PerformSearch;
        End;
        Accept := true;
      End;
    End;
  End;
  // end;
End;

procedure TBaseOrderGUI.cboRepairDocNoCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then
    exit;
  inherited;
  cboRepairDocNo.Text:= LookupTable.FieldByName('RepairDocNo').AsString;
  EditDB(tblDetails);
  tblDetailsCustomerJobId.asInteger :=LookupTable.FieldByName('CusId').AsInteger;
  tblDetailsCustomerJob.asString := LookupTable.FieldByName('CustomerName').AsString;
  // try to set equipment
  if qryRepairEquip.Locate('RepairId', LookupTable.FieldByName('RepairId').AsInteger, []) then
  begin
    tblDetailsEquipmentName.AsString := qryRepairEquip.FieldByName('EquipmentName').AsString;
    tblDetailsCustomerEquipmentID.AsInteger:= qryRepairEquip.FieldByName('CustomerEquipmentID').AsInteger;
    grdTransactions.SelectRecord;  // somehow equipment is not visible without this
  end
  else
  begin
    tblDetailsEquipmentName.Clear;
    tblDetailsCustomerEquipmentID.AsInteger:= 0;
  end;

end;

procedure TBaseOrderGUI.cboEquipmentNameBeforeDropDown(Sender: TObject);
begin
  inherited;
  qryRepairEquip.ParamByName('RepairID').AsInteger:= tblDetailsRepairID.AsInteger;
  qryRepairEquip.Refresh;
end;

Procedure TBaseOrderGUI.cboEquipmentNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
Begin
  If Not Modified Then Exit;
  Inherited;
  EditDb(tblDetails);
  tblDetailsEquipmentName.AsString:= LookupTable.FieldByName('EquipmentName').AsString;
  tblDetailsCustomerEquipmentID.AsInteger:= LookupTable.FieldByName('CustomerEquipmentID').AsInteger;
  tblDetailsRepairID.AsInteger:= LookupTable.FieldByName('RepairID').AsInteger;
  cboEquipmentName.Text:= LookupTable.FieldByName('EquipmentName').AsString;
  tblDetailsCustomerJobId.asInteger :=LookupTable.FieldByName('ClientId').AsInteger;
  grdTransactions.SelectRecord;  // somehow RepairId is not visible without this
End;

// procedure TBaseOrderGUI.InitCustJobRepairSelection;
// begin
// CustomerJobRepairObj:= TCustomerJobRepairObj.create;
// CustomerJobRepairObj.grid                := grdTransactions;
// CustomerJobRepairObj.Jobcombo            := cboCustomerJob  ;
// CustomerJobRepairObj.JobIDField          := 'CustomerJobID';
// CustomerJobRepairObj.JobnameField        := 'CustomerJob';
// CustomerJobRepairObj.ClassNameField      := 'class';
// CustomerJobRepairObj.ClassIdField        := 'Classid';
// CustomerJobRepairObj.curSelection        := tnone;
// CustomerJobRepairObj.RepairCombo         := cboEquipmentname;
// CustomerJobRepairObj.RepairIdField       := 'RepairID';
// CustomerJobRepairObj.CustomerEquipIDField:= 'customerEquipmentId';
// CustomerJobRepairObj.EquipmentNameField   := 'EquipmentName';
// CustomerJobRepairObj.REpairID        :=0;
// CustomerJobRepairObj.ClientID        :=0;
//
// end;

Function TBaseOrderGUI.getcontactType: TContactType;
Begin
  Result := tSuppliercontact;
End;

(*Procedure TBaseOrderGUI.UpdateFromContact(Const value: TDataSet);
Var strTemp: String;
Begin
  Inherited;
  if AccessLevel > 3 then
    exit;
  If Not value.FieldByName('contacttitle').IsNull Then strTemp := value.FieldByName('contacttitle').AsString;

  If Not value.FieldByName('contactfirstname').IsNull Then
    If strTemp = '' Then strTemp := value.FieldByName('contactfirstname').AsString
    Else strTemp                 := strTemp + ' ' + value.FieldByName('contactfirstname').AsString;

  If Not value.FieldByName('contactsurname').IsNull Then
    If strTemp = '' Then strTemp := value.FieldByName('contactsurname').AsString
    Else strTemp                 := strTemp + ' ' + value.FieldByName('contactsurname').AsString;

  Order.OrderTo := Order.ClientName + #13 + #10 + strTemp + #13 + #10 + // Contact Name
    value.FieldByName('ContactAddress').AsString + #13 + #10 + value.FieldByName('ContactAddress2').AsString + #13 + #10 + value.FieldByName('ContactAddress3').AsString + #13 + #10 +
    value.FieldByName('ContactCity').AsString + ' ' + value.FieldByName('ContactState').AsString + ' ' + value.FieldByName('ContactPcode').AsString;
  Order.contactId := value.FieldByName('ContactID').AsInteger;
  Order.PostDB;
  EmailcontactId := value.FieldByName('ContactID').AsInteger;

End;*)

procedure TBaseOrderGUI.UpdateMe(const Cancelled: boolean; const aObject: TObject);
begin
  inherited UpdateMe(cancelled, aObject);
end;

Procedure TBaseOrderGUI.SetGridColumns;
Begin
  If Not AppEnv.CompanyPrefs.ShowPurchUnits Then Begin
    grdTransactions.RemoveField('UnitofMeasurePOLines');
    GuiPrefs.DbGridElement[grdTransactions].HideField('UnitofMeasurePOLines');
  End
  Else GuiPrefs.DbGridElement[grdTransactions].UnHideField('UnitofMeasurePOLines');

  If Not AppEnv.CompanyPrefs.ShowPurchCustJob Then Begin
    // grdTransactions.RemoveField(CustomerJobRepairObj.Jobnamefield);
    // GuiPrefs.DbGridElement[grdTransactions].HideField(CustomerJobRepairObj.Jobnamefield);
    grdTransactions.RemoveField('CustomerJob');
    GuiPrefs.DbGridElement[grdTransactions].HideField('CustomerJob');
  End (*
    else
    grdTransactions.AddField(CustomerJobRepairObj.Jobnamefield) *);

  If Not AppEnv.CompanyPrefs.ShowPurchDescription Then Begin
    grdTransactions.RemoveField('Product_Description');
    GuiPrefs.DbGridElement[grdTransactions].HideField('Product_Description');
  End
  Else GuiPrefs.DbGridElement[grdTransactions].UnHideField('Product_Description');

  If Not AppEnv.CompanyPrefs.ShowPurchClass Then Begin
    grdTransactions.RemoveField('Class');
    GuiPrefs.DbGridElement[grdTransactions].HideField('Class');
  End
  Else GuiPrefs.DbGridElement[grdTransactions].UnHideField('Class');

  If Not AppEnv.CompanyPrefs.ShowPurchTaxCode Then Begin
    grdTransactions.RemoveField('LineTaxCode');
    GuiPrefs.DbGridElement[grdTransactions].HideField('LineTaxCode');
  End
  Else GuiPrefs.DbGridElement[grdTransactions].UnHideField('LineTaxCode');

  If Not AppEnv.CompanyPrefs.ShowPurchTaxAmount Then Begin
    grdTransactions.RemoveField('LineTax');
    GuiPrefs.DbGridElement[grdTransactions].HideField('LineTax');
  End
  Else GuiPrefs.DbGridElement[grdTransactions].UnHideField('LineTax');

  // CustomerJobRepairObj.JobCustomerSetUp;
  If Not AppEnv.CompanyPrefs.ShowMeasurementAttributes Then Begin
    grdTransactions.RemoveField('Attrib1Purchase');
    grdTransactions.RemoveField('Attrib2Purchase');
    grdTransactions.RemoveField('Attrib1Purchaseest');
    grdTransactions.RemoveField('Attrib2Purchaseest');
    grdTransactions.RemoveField('Attrib1PurchaseRate');
    GuiPrefs.DbGridElement[grdTransactions].HideField('Attrib1Purchase');
    GuiPrefs.DbGridElement[grdTransactions].HideField('Attrib2Purchase');
    GuiPrefs.DbGridElement[grdTransactions].HideField('Attrib1Purchaseest');
    GuiPrefs.DbGridElement[grdTransactions].HideField('Attrib2Purchaseest');
    GuiPrefs.DbGridElement[grdTransactions].HideField('Attrib1PurchaseRate');
  End Else Begin
    GuiPrefs.DbGridElement[grdTransactions].UnHideField('Attrib1Purchase');
    GuiPrefs.DbGridElement[grdTransactions].UnHideField('Attrib2Purchase');
    GuiPrefs.DbGridElement[grdTransactions].UnHideField('Attrib1Purchaseest');
    GuiPrefs.DbGridElement[grdTransactions].UnHideField('Attrib2Purchaseest');
    GuiPrefs.DbGridElement[grdTransactions].UnHideField('Attrib1PurchaseRate');
    grdTransactions.ColumnByName('Attrib1Purchase').Displaylabel     := AppEnv.CompanyPrefs.ProductAttrib1Name;
    grdTransactions.ColumnByName('Attrib2Purchase').Displaylabel     := AppEnv.CompanyPrefs.ProductAttrib2Name;
    grdTransactions.ColumnByName('Attrib1Purchaseest').Displaylabel     := AppEnv.CompanyPrefs.ProductAttrib1Name;
    grdTransactions.ColumnByName('Attrib2Purchaseest').Displaylabel     := AppEnv.CompanyPrefs.ProductAttrib2Name;
    grdTransactions.ColumnByName('Attrib1PurchaseRate').Displaylabel := 'Price / ' + AppEnv.CompanyPrefs.ProductAttrib1Name;
  End;
  (* GuiPrefs.DbGridElement[grdTransactions].HideField('RepairId'); *)
  GuiPrefs.DbGridElement[grdTransactions].HideField('CustomerEquipmentID');

  grdTransactions.ColumnByName('Class').Displaylabel := AppEnv.DefaultClass.ClassHeading;

End;

Procedure TBaseOrderGUI.SetMatrixDetails(sMatrixDesc, sMatrixRef: String; dMatrixPrice: double);
Begin
  Order.Lines.MatrixDesc  := sMatrixDesc;
  Order.Lines.MatrixRef   := sMatrixRef;
  Order.Lines.MatrixPrice := dMatrixPrice;
  Order.Lines.PostDB;
End;

Procedure TBaseOrderGUI.cboEquipmentNameDblClick(Sender: TObject);
Begin
  Inherited;
  // don;t delete, to skip the ondblclick event from baseinput
End;

Procedure TBaseOrderGUI.cboEquipmentNameNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: boolean);
Begin
  Inherited;
  // don;t delete, to skip the not inlist event from baseinput
End;

Procedure TBaseOrderGUI.tblDetailsLandedCostsPerItemChange(Sender: TField);
Begin
  Inherited;
  { canges in this field call calcfields,
    need to get grid to refresh to show changed calc field value }
  grdTransactions.Refresh;
End;

procedure TBaseOrderGUI.tblDetailsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblDisableCalc.visible := TransBase.Lines.count >appenv.CompanyPrefs.OrderLinesToDisableCalcs;

end;

procedure TBaseOrderGUI.tblDetailsCalcFields(DataSet: TDataSet);
begin
  inherited;
  try
    if self.tblDetailsProductID.AsInteger > 0 then begin
      try
        tblDetailsUOM_Height.AsFloat             := Order.Lines.POLinesUOMDetails.Height;
        tblDetailsUOM_Width.AsFloat              := Order.Lines.POLinesUOMDetails.Width;
        tblDetailsUOM_Length.AsFloat             := Order.Lines.POLinesUOMDetails.Length;
        tblDetailsUOM_Weight.AsFloat             := Order.Lines.POLinesUOMDetails.Weight;
        tblDetailsUOM_Volume.AsFloat             := Order.Lines.POLinesUOMDetails.Volume;
        tblDetailsTotalUOM_WeightSold.asFloat    := tblDetailsUOM_Weight.AsFloat * tblDetailsUnitofMeasureQtySold.asFloat ;
        tblDetailsTotalUOM_WeightShipped.asFloat := tblDetailsUOM_Weight.AsFloat *tblDetailsUnitofMeasureShipped.asFloat;
        tblDetailsTotalUOM_WeightBO.asFloat      := tblDetailsUOM_Weight.AsFloat * tblDetailsUnitofMeasureBackorder.asFloat;
        tblDetailsTotalUOM_LengthSold.asFloat    := tblDetailsUOM_Length.AsFloat * tblDetailsUnitofMeasureQtySold.asFloat ;
        tblDetailsTotalUOM_LengthShipped.asFloat := tblDetailsUOM_Length.AsFloat *tblDetailsUnitofMeasureShipped.asFloat;
        tblDetailsTotalUOM_LengthBO.asFloat      := tblDetailsUOM_Length.AsFloat * tblDetailsUnitofMeasureBackorder.asFloat;

        tblDetailsProduct_CUSTFLD1.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD1;
        tblDetailsProduct_CUSTFLD2.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD2;
        tblDetailsProduct_CUSTFLD3.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD3;
        tblDetailsProduct_CUSTFLD4.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD4;
        tblDetailsProduct_CUSTFLD5.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD5;
        tblDetailsProduct_CUSTFLD6.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD6;
        tblDetailsProduct_CUSTFLD7.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD7;
        tblDetailsProduct_CUSTFLD8.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD8;
        tblDetailsProduct_CUSTFLD9.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD9;
        tblDetailsProduct_CUSTFLD10.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD10;
        tblDetailsProduct_CUSTFLD11.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD11;
        tblDetailsProduct_CUSTFLD12.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD12;
        tblDetailsProduct_CUSTFLD13.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD13;
        tblDetailsProduct_CUSTFLD14.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD14;
        tblDetailsProduct_CUSTFLD15.AsString := Order.Lines.OrderlineProductCustomFields.CUSTFLD15;
        tblDetailsProduct_CUSTDATE1.AsDateTime := Order.Lines.OrderlineProductCustomFields.CUSTDATE1;
        tblDetailsProduct_CUSTDATE2.AsDateTime := Order.Lines.OrderlineProductCustomFields.CUSTDATE2;
        tblDetailsProduct_CUSTDATE3.AsDateTime := Order.Lines.OrderlineProductCustomFields.CUSTDATE3;
        tblDetailsForeignUOMLineCost.AsFloat := Order.Lines.ForeignUOMLineCost;
      Except
        // kills the exception
      end;
    end;
  Except
    // sometimes error dataset not in edit mode - ignore it
  end;
end;
procedure TBaseOrderGUI.PopulateMessageSubstituteList(SL: TStringList);
begin
  self.Order.PopulateMessageSubstituteList(SL);
end;

function TBaseOrderGUI.ProductDisabledCustomFields: string;
  procedure RemoveCustomfield(fsFieldname: string);
  begin
    if fsFieldname = '' then Exit;
    if Result <> '' then Result := Result + ',';
    Result := Result + fsFieldname;
  end;

begin
  OpenQryCustomField('CFProduct');
  Result := '';
  if QryCustomField.FieldByName('CFProduct1').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD1.FieldName);
  if QryCustomField.FieldByName('CFProduct2').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD2.FieldName);
  if QryCustomField.FieldByName('CFProduct3').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD3.FieldName);
  if QryCustomField.FieldByName('CFProduct4').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD4.FieldName);
  if QryCustomField.FieldByName('CFProduct5').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD5.FieldName);
  if QryCustomField.FieldByName('CFProduct6').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD6.FieldName);
  if QryCustomField.FieldByName('CFProduct7').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD7.FieldName);
  if QryCustomField.FieldByName('CFProduct8').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD8.FieldName);
  if QryCustomField.FieldByName('CFProduct9').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD9.FieldName);
  if QryCustomField.FieldByName('CFProduct10').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD10.FieldName);
  if QryCustomField.FieldByName('CFProduct11').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD11.FieldName);
  if QryCustomField.FieldByName('CFProduct12').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD12.FieldName);
  if QryCustomField.FieldByName('CFProduct13').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD13.FieldName);
  if QryCustomField.FieldByName('CFProduct14').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD14.FieldName);
  if QryCustomField.FieldByName('CFProduct15').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTFLD15.FieldName);
  if QryCustomField.FieldByName('CFProduct16').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTDATE1.FieldName);
  if QryCustomField.FieldByName('CFProduct17').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTDATE2.FieldName);
  if QryCustomField.FieldByName('CFProduct18').AsString = 'F' then RemoveCustomfield(tblDetailsProduct_CUSTDATE3.FieldName);
  if Result <> '' then Result := ',' + Result;
end;


Procedure TBaseOrderGUI.tblDetailsLandedCostsPercentageChange(Sender: TField);
Begin
  Inherited;
  { canges in this field call calcfields,
    need to get grid to refresh to show changed calc field value }
  grdTransactions.Refresh;
End;

Procedure TBaseOrderGUI.cboEquipmentNameDropDown(Sender: TObject);
Begin
  Inherited;
  If Order.Lines.ProductID = 0 Then Abort;
End;

Procedure TBaseOrderGUI.cboUnitOfMeasureDropDown(Sender: TObject);
Begin
  Inherited;
  If Order.Lines.ProductID = 0 Then Abort;
End;

procedure TBaseOrderGUI.cboViaEnter(Sender: TObject);
begin
  inherited;
  fLastComboAccessed := cboVia;
end;

Procedure TBaseOrderGUI.cboCustomerJobDropDown(Sender: TObject);
Begin
  Inherited;
  If Order.Lines.ProductID = 0 Then Abort;
End;

Procedure TBaseOrderGUI.cboClassDropDown(Sender: TObject);
Begin
  Inherited;
  If Order.Lines.ProductID = 0 Then Abort;
End;

Procedure TBaseOrderGUI.cboPartSpecsDropDown(Sender: TObject);
Begin
  Inherited;
  If Order.Lines.ProductID = 0 Then Abort;
End;

Procedure TBaseOrderGUI.cboTaxCodeDropDown(Sender: TObject);
Begin
  Inherited;
  If Order.Lines.ProductID = 0 Then Abort;
End;

Procedure TBaseOrderGUI.cboForeignCurrencyCodeDropDown(Sender: TObject);
Begin
  Inherited;
  If Order.Lines.ProductID = 0 Then Abort;
End;
procedure TBaseOrderGUI.InitERPLookupCombonFields;
begin
  inherited;
  SetupProductNamenPrintNameinGrid(cboProductR ,cboPrintProductR ,'ProductName' , 'ProductPrintName' , 'PurchaseDesc' ,grdTransactions);
  NamenPrintNameGridObj.SetupClientNamenPrintNameinGrid(0,cboCustJob ,cboCustPrintJob ,'CustomerJob'  , 'CustomerPrintJob'   , grdTransactions,False, True  , False, true , true );
end;
Procedure TBaseOrderGUI.ProductformulaEntry(Sender : TObject);
var
  POProductSpec: TfmPOProductSpec;
begin
  if (not Assigned(Order)) or (Order.Lines.Count = 0) or (Order.Lines.ProductID < 1) then Exit;
  if (Order.Lines.Product.HasFormulaAttached) or (Order.Lines.Product.formulaId <> 0) then begin
    { create spec records internally }
    if Order.Lines.FEPOLines.DataSet.RecordCount = 0 then begin
      Order.Lines.FEPOLines.New;
      Order.Lines.FEPOLines.ProductID := Order.Lines.ProductID;
      Order.Lines.FEPOLines.ProductName := Order.Lines.ProductName;
      Order.Lines.FEPOLines.formulaId :=   Order.Lines.Product.formulaId;
      Order.Lines.FEPOLines.PostDB;
    end;
    dsFEPOLines.DataSet := Order.Lines.FEPOLines.DataSet;
    dsFEPOlinesRelatedPrs.DataSet := Order.Lines.FEPOLines.Lines.DataSet;
    dsFEPOLines.DataSet := Order.Lines.FEPOLines.DataSet;
    dsFEPOlinesRelatedPrs.DataSet := Order.Lines.FEPOLines.Lines.DataSet;
    POProductSpec := TfmPOProductSpec(CommonLib.GetComponentByClassName('TfmPOProductSpec', true, Self, False, False));
    try
      POProductSpec.FETransLines := Order.Lines.FEPOLines;
      POProductSpec.grdRelatedPr.Enabled := Order.Lines.Product.HasFormulaAttached;
      //if sametext(TField(grdtransactions.GetActiveField).fieldname , tbldetailsUnitofMeasureQtySold.fieldname) then POProductSpec.grpfilters.itemindex := 0 else POProductSpec.grpfilters.itemindex := 1;
      if sametext(TField(grdtransactions.GetActiveField).fieldname , tbldetailsUnitofMeasureQtySold.fieldname) or (grdtransactions.GetActiveField.index < tbldetailsUnitofMeasureQtySold.index) then
          POProductSpec.grpfilters.itemindex := 0
      else POProductSpec.grpfilters.itemindex := 1;

      POProductSpec.showModal;

      if POProductSpec.ModalResult = mrOK then begin
        { binny : dene asked for a default value 1 when formula products are  added }
        //Order.InternalQuantityChange := true;
        try Order.Lines.PostFERecords;
        finally
          //Order.InternalQuantityChange := False;
        end;
      end;
    finally Freeandnil(POProductSpec);
    end;

  end;
end;


End.
