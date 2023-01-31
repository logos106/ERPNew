unit Sales;
{

  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  16/03/05  1.00.01 IJB  Added file attachment stuff.
  31/03/05  1.00.02 IJB  Added commission and reward points prcessing calls to
  AfterCommit.
  05/04/05  1.00.03 IJB  Changed foreign currency calculations to use correct
  formula and to look up rate based on sale date.
  Added Currency Hedging calcualtion to
  tblDetailsCalcFields event.
  22/04/05  1.00.04 IJB  Added Barcode entry of products.
  26/04/05  1.00.05 IJB  Modified to use ~ char to open barcode form.
  13/05/05  1.00.07 IJB  Corrected foreign currency and hedging prcessing,
  see ForeignExchangeObj unit for notes on foreign hedging.
  17/05/05  1.00.08 IJB  Changed tblSalesLines field `TotalHedgeVariance` to
  `UseHedging`
  18/05/05  1.00.09 DJH  Changed LoadRelatedParts to Ignore calling from HireObj.
  Also fixed LoadRelatedParts as it was not loading in correctly.
  08/06/05  1.00.10 IJB  Fixed bug with LAtest Cost being reset to 0 when
  second line added.
  09/06/05  1.00.11 ISB  Added Specifications Combo Ect
  14/06/05  1.00.12 BJ   Added code to consider the customer's special price if
  any available for the selected cutomer and product.
  22/06/05  1.00.13 BJ   pop-ups a message if the warranty finish date of the
  selected customer job is less than the system date
  24/06/05  1.00.14 BJ   Creation date added in the saleslines table and if the
  field is blank in 'beforepost', intialises it to current date
  if the field is blank.
  06/07/05  1.00.15 DMS  1. Modified CheckSetCurrencyCode method to check for
  tables edit mode prior setting fields value.
  2. Formatted unit's source code.
  11/07/05  1.00.16 IJB  Changed to display Ex prices for all amount columns in
  grid if DisplaySalesExPrice is set in company prefs.
  20/07/05  1.00.17 IJB  Relabled "Show Cost Inc" to "Show Cost" on Sales tab
  of pref form, changed logic on sales form to always
  hide cost colum if this pref not selected.
  28/07/05  1.00.18 IJB  Modified code in FormShow to test grdTransaction
  columns exist before adding/removing fields etc.
  28/07/05  1.00.19 DSP  Code changed to use PickingSlipOrder in place of
  PickingSlipOrderByBins.
  10/08/05  1.00.20 DSP  'Unknown' exceptions are now handled by Exception
  Magic.
  10/08/05  1.00.21 IJB  Fixed foreign currency calculation error.
  12/08/05  1.00.22 BJ   Serialno fieldtype is changed to mediumText
  26/08/05  1.00.24 IJB  Added Post/Edit to ProductX OnCloseUp to fix problem
  of Lookup DataSet locating to old record when user
  changes selected product (resulting in wrong values for
  product description etc).
  09/09/05  1.00.25 BJ   bug fixed :E_FAIL status on recordcount.

  23/09/05  1.00.26 BJ   Invoice form : When required to give a qty for picking slip without
  giving a shipped quantity, this form is called. This updates the
  tblPickSliplines The form is called based on a preference -
  AcceptPickingSlipQty this form uses the ininvoice form's connection. : this functionality was before the PQA was introduced.

  30/09/05  1.10.00 IJB  Rewrite of form to use new Business Objects.
  01/12/05  1.10.01 BJ   Function created for Printing the picking slip
  Printing the picking slip updtes the new table - tblPrintdoc
  not the printFlag / printedby in tblSales.
  04/01/06  1.10.02 IJB  Added call to business object CalcOrderTotals in form
  show to force calulation of vairables.
  04/01/06  1.10.03 AL   Added new Search mode (like)
  10/01/06  1.10.04 AL   Changed Search engine to use SearchEngineObj
  10/01/06  1.10.05 IJB  Modified so that Ordered and Shipped totals always
  update (was previously preference based)
  17/01/06  1.10.06 DSP  1. Removed AdjustCustomFields as new functionality in
  the Customise popup takes its place.
  2. Added the constant cHiddenFields which is used by
  GuiPrefs to prevent the fields listed from being
  displayed in the customise popup list box.
  27/01/06  1.10.07 IJB  Modified delivery docket printing to use clients default
  report.
  01/02/06  1.10.28 DSP  Removed constant cHiddenFields. It is replaced by
  testing the visible state of the DataSet fields.
  09/02/06  1.10.29 DSP  Changed HiddenFields to HideField.
  15/02/06  1.10.30 DSP  Added UpdateSelectedProp to FormCreate.
  16/02/06  1.10.31 AL   Added RefreshUnitsQry procedure to update units combo for each product
  17/02/06  1.10.32 DSP  Changed the tblDetails' UnitOfMeasureID field to not be
  visible.
  27/03/06  1.10.33 AL   In ETAInfoClick comented if clause to let run ETA popup from any field
  31/03/06  1.10.34 DSP  1. Fixed access violation error when selecting products
  with related parts (only occurred when item selected
  using [Enter] key). Removed dgEnterToTab from KeyOptions
  until processing is completed.
  2. Removed dgTabs from Options until processing is
  completed.
  21/04/06  1.10.35 DSP  Removed changes above as values couldn't be entered
  into 'Ordered' and the original exception error no
  longer occurs.
  18/05/06  1.10.36 BJ   Confirmation before deleting the line record.
  29/05/06  1.00.07 BJ   chkDisableCalcs is made invisible in the template and is no more applciable
  the calculations are done always.
  As all the descendants of this form are usng objects, 'UsingSaleBase' variable
  if irrelevant, so deleted.
  14/08/06  1.00.49 BJ   Business object does the validation of SaleDate which is compared with companypref.closing date
  So cboCreationDateExit is overiden as and ignore the inherited;
  15/08/06  1.00.50 BJ   1)ProductLookup Combo's fields were removed as they were not used in the form, instead the object had properties defined for them which ar used.
  but other form fucntions like conversion etc are using those fields, so got them back
  Also added CreateJobwhenconvert.
  2)BusObjqueries initialised in the formcreate for tblmaster and tbldetails
  PO and PO.Lines useing these tables.
  29/08/06  1.00.51 BJ   Deleting the blank lines from the address field (same as Purchase order )
  30/08/06  1.00.52 BJ   Commented lines are removed
  02/05/07  1.00.53 DSP  Added code to handle the new company preference
  DefaultDiscountMarkup. 123

}

{$I ERP.inc}
interface

uses Windows, DateUtils, Messages, SysUtils, Variants, Classes, Graphics, Controls,
    Forms, Dialogs, BaseTransForm, BaseInputForm, DB, wwdbdatetimepicker, wwdblook,
    StdCtrls, DBCtrls, Mask, ExtCtrls,  wwcheckbox, Buttons, DNMSpeedButton, DNMPanel,
    Grids, Wwdbigrd, Wwdbgrid, ActnList, SelectionDialog, Menus, AdvMenus, ClientDiscountObj,
    ImgList, CommonLib, AppEvnts, StrUtils, wwdbedit, MyAccess,  ERPdbComponents, MemDS,
    DBAccess, DataState, DMComps, ForeignExchangeObj, BusObjBase, BusObjSales, frmEquipmentxRef,
    ComCtrls, AdvOfficeStatusBar, MessageInterface, Shader, dmGUIStylers,
    CustomfieldonGrid, frmSalesShippingDetail, ERPDbLookupCombo, DNMAction, EmailUtils, types,
    CorrespondenceObj , ProgressDialog , frmSaleSummary , ExcelfileObj;

const
  SX_RequestComboRedrop = WM_USER + 102;
  ACCESS_ALLOWED = 1;

type
  TBaseSaleGUI = class(TBaseTransGUI)
    cboClass: TwwDBLookupCombo;
    ClassLabel: TLabel;
    txtPONumber: TDBEdit;
    Label43: TLabel;
    Label47: TLabel;
    cboTerms: TwwDBLookupCombo;
    Label79: TLabel;
    cboDueDate: TwwDBDateTimePicker;
    Label45: TLabel;
    cmdDeliveryDocket: TDNMSpeedButton;
    cmdPrintPick: TDNMSpeedButton;
    cboAccount: TwwDBLookupCombo;
    lblAccount: TLabel;
    cboViaQry: TERPQuery;
    cboViaQryShippingMethodID: TAutoIncField;
    cboViaQryShippingMethod: TWideStringField;
    Label93: TLabel;
    txtPickMemo: TDBMemo;
    Label122: TLabel;
    txtTotalDiscount: TDBEdit;
    txtTotalMarkup: TDBEdit;
    txtShipTo: TDBMemo;
    tblDetailsSaleID: TIntegerField;
    tblDetailsSaleLineID: TAutoIncField;
    tblDetailsGlobalRef: TWideStringField;
    tblDetailsProductGroup: TWideStringField;
    tblDetailsProductName: TWideStringField;
    tblDetailsProduct_Description: TWideStringField;
    tblDetailsLinePrice: TFloatField;
    tblDetailsLinePriceInc: TFloatField;
    tblDetailsDiscountedPrice: TFloatField;
    tblDetailsDiscountedPriceInc: TFloatField;
    tblDetailsTotalDiscountedPrice: TFloatField;
    tblDetailsTotalDiscountedPriceInc: TFloatField;
    tblDetailsLineWholesalePrice: TFloatField;
    tblDetailsLineTaxRate: TFloatField;
    tblDetailsLineCost: TFloatField;
    tblDetailsLineCostInc: TFloatField;
    tblDetailsLineTaxCode: TWideStringField;
    tblDetailsLineTax: TFloatField;
    tblDetailsQtySold: TFloatField;
    tblDetailsShipped: TFloatField;
    tblDetailsBackOrder: TFloatField;
    tblDetailsInvoiced: TWideStringField;
    tblDetailsDiscounts: TFloatField;
    tblDetailsMarkup: TFloatField;
    tblDetailsMargin: TFloatField;
    tblDetailsTotalLineAmount: TFloatField;
    tblDetailsTotalLineAmountInc: TFloatField;
    tblDetailsEditedFlag: TWideStringField;
    tblDetailsDeleted: TWideStringField;
    tblMasterSaleID: TAutoIncField;
    tblMasterGlobalRef: TWideStringField;
    tblMasterInvoiceDocNumber: TWideStringField;
    tblMasterArea: TWideStringField;
    tblMasterOriginalNo: TWideStringField;
    tblMasterAccount: TWideStringField;
    tblMasterCustomerName: TWideStringField;
    tblMasterInvoiceTo: TWideStringField;
    tblMasterShipTo: TWideStringField;
    tblMasterSaleDate: TDateField;
    tblMasterTotalTax: TFloatField;
    tblMasterTotalAmount: TFloatField;
    tblMasterTotalAmountInc: TFloatField;
    tblMasterTotalMarkup: TFloatField;
    tblMasterTotalDiscount: TFloatField;
    tblMasterEmployeeName: TWideStringField;
    tblMasterClass: TWideStringField;
    tblMasterOrderNumber: TWideStringField;
    tblMasterPONumber: TWideStringField;
    tblMasterShipDate: TDateField;
    tblMasterDueDate: TDateField;
    tblMasterConNote: TWideStringField;
    tblMasterInvoicePrintDesc: TWideStringField;
    tblMasterPrintHold: TWideStringField;
    tblMasterShipping: TWideStringField;
    tblMasterTerms: TWideStringField;
    tblMasterPayMethod: TWideStringField;
    tblMasterPayDueDate: TWideStringField;
    tblMasterPaid: TWideStringField;
    tblMasterBalance: TFloatField;
    tblMasterPayment: TFloatField;
    tblMasterApplyFlag: TWideStringField;
    tblMasterAmountDue: TFloatField;
    tblMasterTimeOfSale: TWideStringField;
    tblMasterPOS: TWideStringField;
    tblMasterIsCashSale: TWideStringField;
    tblMasterIsInvoice: TWideStringField;
    tblMasterIsQuote: TWideStringField;
    tblMasterIsSalesOrder: TWideStringField;
    tblMasterDeleted: TWideStringField;
    tblMasterCancelled: TWideStringField;
    tblMasterEditedFlag: TWideStringField;
    tblMasterIsRefund: TWideStringField;
    tblMasterTotalQuoteAmount: TFloatField;
    tblDetailsProductID: TIntegerField;
    tblMasterBOID: TWideStringField;
    tblMasterClassID: TIntegerField;
    tblMasterChequeNo: TWideStringField;
    Label5: TLabel;
    tblMasterClientID: TIntegerField;
    tblMasterAccountID: TIntegerField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterIsLayby: TWideStringField;
    tblMasterLaybyID: TWideStringField;
    tblDetailsPartType: TWideStringField;
    tblDetailsRefundQty: TFloatField;
    tblDetailsLaybyID: TWideStringField;
    tblDetailsIncomeAccnt: TWideStringField;
    tblDetailsAssetAccnt: TWideStringField;
    tblDetailsCogsAccnt: TWideStringField;
    tblMasterIsPOS: TWideStringField;
    tblMasterDeposited: TWideStringField;
    tblDetailsCalcPriceInc: TCurrencyField;
    tblDetailsCalcTotalInc: TCurrencyField;
    tblDetailsCalcTotalEx: TCurrencyField;
    tblDetailsCalcTax: TCurrencyField;
    tblDetailsCalcBackOrder: TFloatField;
    actPick: TAction;
    tblMasterHoldSale: TWideStringField;
    actDelDocket: TAction;
    tblDetailsMarkupPercent: TFloatField;
    tblDetailsMarginPercent: TFloatField;
    tblDetailsDiscountPercent: TFloatField;
    tblDetailsCalcLinePriceEx: TCurrencyField;
    tblDetailsOrgLinePrice: TFloatField;
    tblMasterMemo: TWideMemoField;
    tblMasterComments: TWideMemoField;
    cboVia: TwwDBLookupCombo;
    editField: TEdit;
    tblMasterEnteredBy: TWideStringField;
    tblDetailsCalcProfit: TCurrencyField;
    tblDetailsCalcProfitPercent: TFloatField;
    tblMasterEnteredAt: TWideStringField;
    tblDetailsCalcTotalIncB4Discount: TCurrencyField;
    pnlHold: TDNMPanel;
    lblHoldSale: TLabel;
    chkHoldSale: TwwCheckBox;
    tblMasterSOBalance: TFloatField;
    tblMasterFreezeQuoteAmount: TWideStringField;
    tblMasterConverted: TWideStringField;
    tblDetailsAttrib1SaleRate: TFloatField;
    tblDetailsAttrib2Sale: TFloatField;
    tblDetailsAttrib1Sale: TFloatField;
    tblDetailsLastLineID: TIntegerField;
    tblMasterIsVoucher: TWideStringField;
    tblMasterIsLaybyTOS: TWideStringField;
    tblMasterIsLaybyPayment: TWideStringField;
    tblMasterTillID: TSmallintField;
    tblMasterCommissionPaid: TWideStringField;
    tblDetailsUnitofMeasureQtySold: TFloatField;
    tblDetailsUnitofMeasureShipped: TFloatField;
    tblDetailsUnitofMeasureBackorder: TFloatField;
    tblDetailsUnitofMeasureMultiplier: TFloatField;
    qryUnitOfMeasure: TERPQuery;
    qryUnitOfMeasureUnitName: TWideStringField;
    qryUnitOfMeasureUnitDescription: TWideStringField;
    qryUnitOfMeasureMultiplier: TFloatField;
    cboUnitOfMeasure: TwwDBLookupCombo;
    tblDetailsUnitofMeasureSaleLines: TWideStringField;
    cboClientLookupClientID: TAutoIncField;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupTERMS: TWideStringField;
    cboClientLookupTermsID: TIntegerField;
    cboClientLookupShippingMethod: TWideStringField;
    cboClientLookupShippingID: TIntegerField;
    cboClientLookupRepID: TIntegerField;
    cboClientLookupTaxID: TIntegerField;
    cboClientLookupStopCreditImage: TIntegerField;
    tblMasterIsManifest: TWideStringField;
    tblMasterUsedOnManifest: TWideStringField;
    tblMasterAddToManifest: TWideStringField;
    cboClientLookupForcePOOnInvoice: TWideStringField;
    tblMasterQuoteGlobalRef: TWideStringField;
    tblMasterSalesOrderGlobalRef: TWideStringField;
    tblDetailsSupplierContact: TWideStringField;
    tblDetailsSupplier: TWideStringField;
    tblMasterIsBarcodePicking: TWideStringField;
    tblMasterBarcodePickingDone: TWideStringField;
    tblMasterARNotes: TWideMemoField;
    cboSupplier: TERPDbLookupCombo;
    tblDetailsForeignCurrencyLinePrice: TFloatField;
    tblDetailsForeignExchangeSellRate: TFloatField;
    cboClientLookupStreet: TWideStringField;
    cboClientLookupStreet2: TWideStringField;
    cboClientLookupSuburb: TWideStringField;
    cboClientLookupState: TWideStringField;
    cboClientLookupCountry: TWideStringField;
    cboClientLookupPostcode: TWideStringField;
    cboClientLookupBillStreet: TWideStringField;
    cboClientLookupBillStreet2: TWideStringField;
    cboClientLookupBillSuburb: TWideStringField;
    cboClientLookupBillState: TWideStringField;
    cboClientLookupBillPostcode: TWideStringField;
    cboClientLookupBillCountry: TWideStringField;
    qryUnitOfMeasureBaseUnitName: TWideStringField;
    tblDetailsCalcProfitEx: TCurrencyField;
    tblDetailsCalcProfitPercentEx: TCurrencyField;
    tblMasterOriginalCreationDate: TDateField;
    tblMasterQuoteStatus: TWideStringField;
    tblDetailsArea: TWideStringField;
    tblDetailsSearchFilter: TWideStringField;
    tblDetailsSearchFilterCopy: TWideStringField;
    cboClientLookupUseInvBase: TWideStringField;
    cboClientLookupInvBaseNumber: TIntegerField;
    mnuDiscountTotal: TAdvPopupMenu;
    DiscountDollarTotal: TMenuItem;
    DiscountPercentTotal: TMenuItem;
    tblDetailsIsRelatedProduct: TWideStringField;
    btnPrepayment: TDNMSpeedButton;
    cboAccountQry: TERPQuery;
    qrySupplier: TERPQuery;
    tblDetailsRelatedParentProductID: TIntegerField;
    cboClientLookupPhone: TWideStringField;
    cboClientLookupFax: TWideStringField;
    cboClientLookupAltPhone: TWideStringField;
    cboClientLookupDefaultPostAccount: TWideStringField;
    cboClientLookupDefaultPostAccountID: TIntegerField;
    tblDetailsLatestCostPriceInc: TFloatField;
    tblDetailsCalcGrossProfitPercentInc: TFloatField;
    tblDetailsLatestCostPrice: TFloatField;
    tblDetailsCostCentreId: TIntegerField;
    cboCostCentre: TwwDBLookupCombo;
    tblDetailsCostCentreName: TWideStringField;
    btnAttachments: TDNMSpeedButton;
    DMTextTargetSales: TDMTextTarget;
    tblMasterTotalWETTax: TFloatField;
    tblMasterTotalWEGTax: TFloatField;
    tblMasterLastUpdated: TDateTimeField;
    tblDetailsUseHedging: TWideStringField;
    tblMasterRepairGlobalRef: TWideStringField;
    cboPartSpecs: TwwDBLookupCombo;
    qryPartsSpecs: TERPQuery;
    tblDetailsPartSpecID: TIntegerField;
    tblDetailsSpecDescription: TWideStringField;
    tblDetailsSpecValue: TFloatField;
    cboClientLookupWarrantyFinishDate: TDateTimeField;
    cboClientLookupIsJob: TWideStringField;
    tblDetailsCreationDate: TDateTimeField;
    tblDetailsSoldSerials: TWideMemoField;
    tblDetailsSalesLinesCustField1: TWideStringCustField;
    tblDetailsSalesLinesCustField2: TWideStringCustField;
    tblDetailsSalesLinesCustField3: TWideStringCustField;
    tblDetailsSalesLinesCustField4: TWideStringCustField;
    tblDetailsSalesLinesCustField5: TWideStringCustField;
    tblDetailsSalesLinesCustField6: TWideStringCustField;
    tblDetailsSalesLinesCustField7: TWideStringCustField;
    tblDetailsSalesLinesCustField8: TWideStringCustField;
    tblDetailsSalesLinesCustField9: TWideStringCustField;
    tblDetailsSalesLinesCustField10: TWideStringCustField;
    cboTermsQry: TERPQuery;
    cboTermsQryTermsID: TIntegerField;
    cboTermsQryTerms: TWideStringField;
    cboTermsQryTermsAmount: TIntegerField;
    cboTermsQryEOM: TWideStringField;
    cboTermsQryEOMPlus: TWideStringField;
    cboTermsQryActive: TWideStringField;
    tblDetailsForeignTotalLineAmount: TFloatField;
    tblMasterForeignExchangeCode: TWideStringField;
    tblMasterForeignExchangeRate: TFloatField;
    tblMasterForeignTotalAmount: TFloatField;
    tblMasterForeignPaidAmount: TFloatField;
    tblMasterForeignBalanceAmount: TFloatField;
    tblDetailsLineNotes: TWideMemoField;
    tblDetailsCustomData: TWideMemoField;
    tblDetailsUnitOfMeasureID: TIntegerField;
    tblMasterBaseNo: TWideStringField;
    N4: TMenuItem;
    ETAInfo: TMenuItem;
    tblDetailsSortId: TIntegerField;
    tblDetailsLinesOrder: TIntegerField;
    tblDetailsMemoLine: TWideMemoField;
    dlgMemoLine: TwwMemoDialog;
    tblDetailsSeqNo: TIntegerField;
    tblDetailsRelatedParentLineRef: TWideStringField;
    tblDetailsRelatedProductQty: TFloatField;
    tblDetailsIsFormulaRElatedProduct: TWideStringField;
    tblDetailsFormulaID: TIntegerField;
    tblmasterShipToID: TIntegerField;
    tblDetailsProduct_Description_Memo: TWideMemoField;
    tblFESalesLines: TERPQuery;
    tblFESalesLinesField1: TFloatField;
    tblFESalesLinesField2: TFloatField;
    tblFESalesLinesField3: TFloatField;
    tblFESalesLinesfield4: TFloatField;
    tblFESalesLinesField5: TFloatField;
    tblFESalesLinesShippedField1: TFloatField;
    tblFESalesLinesShippedField2: TFloatField;
    tblFESalesLinesShippedField3: TFloatField;
    tblFESalesLinesShippedField4: TFloatField;
    tblFESalesLinesShippedField5: TFloatField;
    tblFESalesLinesFESalesLineID: TAutoIncField;
    tblFESalesLinesGlobalRef: TWideStringField;
    tblFESalesLinesProductID: TIntegerField;
    tblFESalesLinesDeleted: TWideStringField;
    tblFESalesLinesSaleID: TIntegerField;
    tblFESalesLinesSaleLineID: TIntegerField;
    tblFESaleslinesRelatedPrs: TERPQuery;
    tblFESaleslinesRelatedPrsFESaleslinesRelatedPrID: TAutoIncField;
    tblFESaleslinesRelatedPrsGlobalRef: TWideStringField;
    tblFESaleslinesRelatedPrsFESalesLineID: TIntegerField;
    tblFESaleslinesRelatedPrsProductID: TIntegerField;
    tblFESaleslinesRelatedPrsFormulaID: TIntegerField;
    tblFESaleslinesRelatedPrsRelatedQty: TFloatField;
    tblFESaleslinesRelatedPrsDeleted: TWideStringField;
    tblFESaleslinesRelatedPrsFormula: TWideStringField;
    dsFESalesLines: TDataSource;
    dsFESaleslinesRelatedPrs: TDataSource;
    tblFESaleslinesRelatedPrsProductName: TWideStringField;
    tblFESalesLinesProductName: TWideStringField;
    qryUnitOfMeasureUnitID: TIntegerField;
    cboClientLookupStreet3: TWideStringField;
    cboClientLookupBillStreet3: TWideStringField;
    tblDetailsShipDate: TDateTimeField;
    cboClientLookupStopCredits: TWideStringField;
    tblMasterSaleDateTime: TDateTimeField;
    tblDetailsBaseLineno: TIntegerField;
    tblDetailsPQA: TWideStringField;
    qryShipContainerSaleLookup: TERPQuery;
    tblmastercontactID: TLargeintField;
    tblMasterContactName: TWideStringField;
    tblDetailsShipContainerName: TWideStringField;
    tblDetailsShipContainerETA: TDateField;
    cboProductR: TERPDbLookupCombo;
    qryClientLookupDefaultPostAccount: TWideStringField;
    qryClientLookupDefaultPostAccountID: TIntegerField;
    qryClientLookupStreet: TWideStringField;
    qryClientLookupStreet2: TWideStringField;
    qryClientLookupStreet3: TWideStringField;
    qryClientLookupSuburb: TWideStringField;
    qryClientLookupState: TWideStringField;
    qryClientLookupCountry: TWideStringField;
    qryClientLookupPostcode: TWideStringField;
    qryClientLookupBillStreet: TWideStringField;
    qryClientLookupBillStreet2: TWideStringField;
    qryClientLookupBillStreet3: TWideStringField;
    qryClientLookupBillSuburb: TWideStringField;
    qryClientLookupBillState: TWideStringField;
    qryClientLookupBillPostcode: TWideStringField;
    qryClientLookupBillCountry: TWideStringField;
    qryClientLookupTERMS: TWideStringField;
    qryClientLookupTermsID: TIntegerField;
    qryClientLookupShippingMethod: TWideStringField;
    qryClientLookupShippingID: TIntegerField;
    qryClientLookupRepID: TIntegerField;
    qryClientLookupTaxID: TIntegerField;
    qryClientLookupPhone: TWideStringField;
    qryClientLookupFax: TWideStringField;
    qryClientLookupAltPhone: TWideStringField;
    qryClientLookupStopCredits: TWideStringField;
    qryClientLookupForcePOOnInvoice: TWideStringField;
    qryClientLookupUseInvBase: TWideStringField;
    qryClientLookupInvBaseNumber: TIntegerField;
    qryClientLookupWarrantyFinishDate: TDateTimeField;
    qryClientLookupIsJob: TWideStringField;
    tblEquipmentxRefs: TERPQuery;
    tblEquipmentxRefsGlobalRef: TWideStringField;
    tblEquipmentxRefsid: TIntegerField;
    tblEquipmentxRefsCustomerEquipmentID: TIntegerField;
    tblEquipmentxRefsRepairID: TIntegerField;
    tblEquipmentxRefsNotes: TWideStringField;
    tblEquipmentxRefsOnSite: TWideStringField;
    tblEquipmentxRefsEditedFlag: TWideStringField;
    tblEquipmentxRefsDescription: TWideStringField;
    tblEquipmentxRefsCreationDate: TDateField;
    tblEquipmentxRefsUpdateDate: TDateField;
    tblEquipmentxRefsCode: TWideStringField;
    tblEquipmentxRefsCustomField1: TWideStringField;
    tblEquipmentxRefsCustomField2: TWideStringField;
    tblEquipmentxRefsCustomField3: TWideStringField;
    tblEquipmentxRefsCustomField4: TWideStringField;
    tblEquipmentxRefsCustomField5: TWideStringField;
    tblEquipmentxRefsCustomField6: TWideStringField;
    tblEquipmentxRefsCustomField7: TWideStringField;
    tblEquipmentxRefsCustomField8: TWideStringField;
    tblEquipmentxRefsCustomField9: TWideStringField;
    tblEquipmentxRefsCustomField10: TWideStringField;
    tblEquipmentxRefsmsTimeStamp: TDateTimeField;
    tblEquipmentxRefsWarantyPeriodTaken: TLargeintField;
    tblEquipmentxRefsWarantyPeriodLeft: TLargeintField;
    tblEquipmentxRefsSaleId: TLargeintField;
    Label10: TLabel;
    btnRepairEquipment: TDNMSpeedButton;
    Bvlshipto: TBevel;
    bvelCustomerDetails: TBevel;
    tblMasterRepairID: TLargeintField;
    cboProductQry: TERPQuery;
    cboProductQryPARTNAME: TWideStringField;
    cboProductQryPartsDescription: TWideStringField;
    cboProductQryManuf: TWideStringField;
    cboProductQryType: TWideStringField;
    cboProductQryDept: TWideStringField;
    cboProductQryPARTSID: TIntegerField;
    cboProductQryPARTTYPE: TWideStringField;
    cboProductQryLatestCostPrice: TFloatField;
    cboProductQrySNTracking: TWideStringField;
    cboProductQryActive: TWideStringField;
    cboProductQryPreferedSupp: TWideStringField;
    cboProductQryPRODUCTGROUP: TWideStringField;
    cboProductQryINCOMEACCNT: TWideStringField;
    cboProductQryASSETACCNT: TWideStringField;
    cboProductQryCOGSACCNT: TWideStringField;
    cboProductQryBARCODE: TWideStringField;
    cboProductQryPRODUCTCODE: TWideStringField;
    cboProductQryTAXCODE: TWideStringField;
    cboProductQryBatch: TWideStringField;
    cboProductQryAutoBatch: TWideStringField;
    cboProductQryMultipleBins: TWideStringField;
    cboProductQrySpecialDiscount: TWideStringField;
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
    cboProductQryEditedFlag: TWideStringField;
    cboProductQryAvgCost: TFloatField;
    cboProductQryAttrib1Sale: TFloatField;
    cboProductQryAttrib2Sale: TFloatField;
    cboProductQryAttrib1SaleRate: TFloatField;
    cboProductQryDiscontinued: TWideStringField;
    tblEquipmentxRefsUOM: TWideStringField;
    tblEquipmentxRefsUOMID: TLargeintField;
    tblEquipmentxRefsUOMMultiplier: TFloatField;
    tblEquipmentxRefsUOMQty: TFloatField;
    tblEquipmentxRefsQuantity: TFloatField;
    tblEquipmentxRefsAppointmentID: TLargeintField;
    tblEquipmentxRefsInvoiceID: TLargeintField;
    tblDetailsTimecostused: TWideStringField;
    ProgressBar: TProgressBar;
    tblDetailsProfitbasedLatestCost: TFloatField;
    tblDetailsProfitbasedLatestCostPercent: TFloatField;
    tblDetailsProfitbasedLatestCostInc: TFloatField;
    tblDetailsProfitbasedLatestCostPercentInc: TFloatField;
    tblDetailsGrossProfitbasedLatestCostPercentInc: TFloatField;
    tblDetailsPartBarcode: TWideStringField;
    Qrysalesshippingdetails: TERPQuery;
    QrysalesshippingdetailsSalesShippingDetailsID: TLargeintField;
    QrysalesshippingdetailsGlobalref: TWideStringField;
    QrysalesshippingdetailsSalesId: TLargeintField;
    QrysalesshippingdetailsFlightNo: TWideStringField;
    QrysalesshippingdetailsETD: TDateTimeField;
    QrysalesshippingdetailsETA: TDateTimeField;
    QrysalesshippingdetailsDescription: TWideStringField;
    QrysalesshippingdetailsWeightUOMID: TLargeintField;
    QrysalesshippingdetailsWeightUOM: TWideStringField;
    QrysalesshippingdetailsWeightUOMMultiplier: TFloatField;
    QrysalesshippingdetailsNetWeight: TFloatField;
    QrysalesshippingdetailsGrossWeight: TFloatField;
    QrysalesshippingdetailsSizeUOM: TWideStringField;
    QrysalesshippingdetailsSizeUOMID: TLargeintField;
    QrysalesshippingdetailsSizeUOMMultiplier: TFloatField;
    QrysalesshippingdetailsTotalCubicsize: TFloatField;
    QrysalesshippingdetailsAdditionalOrderCost: TFloatField;
    QrysalesshippingdetailsmsTimestamp: TDateTimeField;
    QrysalesshippingdetailsExFactoryDate: TDateTimeField;
    qryUOMLookup: TMyQuery;

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
    tblDetailsUOM_Height: TFloatField;
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
    tblDetailsUOM_ShippedVolume: TFloatField;
    tblDetailsUOM_Soldvolume: TFloatField;
    tblMasterNoOfBoxes: TLargeintField;
    tblDetailsMatrixDesc: TWideMemoField;
    tblDetailsMatrixRef: TWideMemoField;
    tblDetailsMatrixPrice: TFloatField;
    lblEnteredAtHead: TLabel;
    lblEnteredAt: TDBText;
    dnmpanle6: TDNMPanel;
    lblMargin: TLabel;
    lblMarginLabel: TLabel;
    lblCostLabel: TLabel;
    lblCost: TLabel;
    lblEarlyPaymentDiscount2: TLabel;
    lblEarlyPaymentDiscountAmount: TLabel;
    lblEarlyPaymentDiscount: TLabel;
    lblShipTitle: TLabel;
    lblShipped: TLabel;
    lblOrdered: TLabel;
    lblOrdTitle: TLabel;
    lblEstimatedFinalAmt: TLabel;
    lblEstimatedFinalAmtCaption: TLabel;
    txtConNote: TDBEdit;
    Label101: TLabel;
    tblMasterContributionAmount: TFloatField;
    lblContributionAmount: TLabel;
    edtContributionAmount: TwwDBEdit;
    actCreateJob: TDNMAction;
    btnCreateJob: TDNMSpeedButton;
    lblParentclient: TLabel;
    edtParentclient: TwwDBEdit;
    pnlParentclient: TDNMPanel;
    QryRelatedMaster: TERPQuery;
    QryRelatedMasterChildclientId: TIntegerField;
    QryRelatedMasterMastercompany: TWideStringField;
    tblMAsterMastercompany: TStringField;
    cmdFax: TDNMSpeedButton;
    Label11: TDNMSpeedButton;
    edtPayment: TDBEdit;
    Label12: TLabel;
    edtBalance: TDBEdit;
    lblApprovedAmount: TLabel;
    edtApprovedAmount: TDBEdit;
    tblMasterApprovedAmount: TFloatField;
    edtMemoLine: TwwDBEdit;
    CheckDiscounts1: TMenuItem;
    actcheckdiscount: TDNMAction;
    lblWeightcaption: TLabel;
    lblWeight: TLabel;
    mnuconvertedToList: TMenuItem;
    CustomFields1: TMenuItem;
    N1: TMenuItem;
    cboSalesCategory: TwwDBLookupCombo;
    Label8: TLabel;
    tblMasterSalesCategory: TWideStringField;
    QrySalesCAtegory: TERPQuery;
    tblDetailsmsTimeStamp: TDateTimeField;
    tblDetailsmsUpdateSiteCode: TWideStringField;
    SmartPurchaseOrders1: TMenuItem;
    Repairs1: TMenuItem;
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
    QrysalesshippingdetailsmsUpdateSiteCode: TWideStringField;
    tblDetailsAttrib1SaleEst: TFloatField;
    tblDetailsAttrib2SaleEst: TFloatField;
    ProductSelectionOptions1: TMenuItem;
    tblDetailsISContainer: TWideStringField;
    tblDetailsIsPallet: TWideStringField;
    cboClientLookupMobile: TWideStringField;
    cboClientLookupEmail: TWideStringField;
    tblMasterEnteredAtShort: TStringField;
    cboProductQrySupplierProductCode: TWideStringField;
    tblDetailsAreaQty: TFloatField;
    ManifestList1: TMenuItem;
    actManifestList: TDNMAction;
    mnuProductNotes: TMenuItem;
    tblDetailsCustomerEquipmentID: TIntegerField;
    tblDetailsEquipment: TWideStringField;
    tblEquipmentxRefsmsUpdateSiteCode: TWideStringField;
    tblEquipmentxRefsNextServiceDate: TDateTimeField;
    tblMasterPickupFromID: TIntegerField;
    tblMasterPickupFrom: TWideStringField;
    tblMasterPickMemo: TWideMemoField;
    btnShipment: TDNMSpeedButton;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    lblArea: TLabel;
    cboAreaCode: TwwDBLookupCombo;
    tblDetailsRequiresAssembly: TWideStringField;
    tblDetailsProductBarcode: TWideStringField;
    btnPrevious: TDNMSpeedButton;
    btnNextSale: TDNMSpeedButton;
    actNext: TAction;
    actPrev: TAction;
    tblDetailsUOMLineCost: TFloatField;
    tblDetailsUOMLineCostInc: TFloatField;
    tblDetailsUOMLinePrice: TFloatField;
    tblDetailsUOMLinePriceInc: TFloatField;
    qrySalesQuantities: TERPQuery;
    qrySalesQuantitiesProductId: TIntegerField;
    qrySalesQuantitiesSeqNo: TIntegerField;
    qrySalesQuantitiesQtySold: TFloatField;
    tblDetailsOriginalQtyOrdered: TFloatField;
    tblMasterShipTocontactID: TLargeintField;
    btnShiptocontact: TDNMSpeedButton;
    pnlShipToMessage: TPanel;
    lblShipToMessage: TLabel;
    tmrShipToMessage: TTimer;
    tblDetailsDetailsCust1Total: TFloatField;
    tblDetailsStandardCost: TFloatField;
    tblDetailsOrgProductPrice: TFloatField;
    tblDetailsPurchaseCost: TFloatField;
    btninvoices: TDNMSpeedButton;
    mnuSaleCustomFields: TMenuItem;
    tblFESalesLinesmsTimeStamp: TDateTimeField;
    tblFESalesLinesmsUpdateSiteCode: TWideStringField;
    tblFESalesLinesFormulaId: TIntegerField;
    ProductSelectionOptions2: TMenuItem;
    mnuAlternateProduct: TMenuItem;
    btnSignature: TDNMSpeedButton;
    tblMasterClientSignature: TBlobField;
    actSignature: TAction;
    tblMasterSignatureTime: TDateTimeField;
    tblDetailsISVoucher: TWideStringField;
    tblDetailsProductPrintName: TWideStringField;
    tblMasterClientPrintName: TWideStringField;
    btnAddFreight: TDNMSpeedButton;
    cboPrintProductR: TERPDbLookupCombo;
    tblMastermsTimeStamp: TDateTimeField;
    QrySalesLinePackWeightLinesSum: TERPQuery;
    dsSalesLinePackWeightLinesSum: TDataSource;
    QrySalesLinePackWeightLinesSumsaleId: TIntegerField;
    QrySalesLinePackWeightLinesSumSaleLineId: TIntegerField;
    QrySalesLinePackWeightLinesSumAttribValue1: TFloatField;
    QrySalesLinePackWeightLinesSumAttribValue2: TFloatField;
    QrySalesLinePackWeightLinesSumPackcount: TFloatField;
    tblDetailsPackWeightField1: TFloatField;
    tblDetailsPackWeightfield2: TFloatField;
    tblDetailsPackCount: TFloatField;
    edt_SaleNum_Seq: TDBText;
    tblMasterSaleNum_Seq: TStringField;
    qrySalesSeqno: TERPQuery;
    qrySalesSeqnoSeqNo: TLargeintField;
    qrySaleLookup: TERPQuery;
    tblMasterOriginalSaleId: TIntegerField;
    ProductStockQty1: TMenuItem;
    tblDetailsOrgProductPriceInc: TFloatField;
    btnConSmart: TDNMSpeedButton;
    actconsmart: TDNMAction;
    tblDetailsBOMComments: TWideStringField;
    tblDetailsRelatedProductProdLine: TIntegerField;
    tblDetailsRelatedProductPatternName: TWideStringField;
    tblDetailsRelatedProductFormulaDescription: TWideStringField;
    tblDetailsETDDate: TDateTimeField;
    btnShowDetails: TDNMSpeedButton;
    tblDetailsUOMQtyInStock: TFloatField;
    tblDetailsUOMQtyAvailable: TFloatField;
    tblDetailsProfitOnLanded: TFloatField;
    tblDetailsProfitOnLandedInc: TFloatField;
    tblDetailsProfitOnLandedPercent: TFloatField;
    tblDetailsProfitOnLandedPercentInc: TFloatField;
    qryCostCentre: TERPQuery;
    tblMasterDefaultReferenceNoinAllLines: TWideStringField;
    tblMasterIsdone: TWideStringField;
    tblMasterReferenceNo: TWideStringField;
    tblDetailsReferenceNo: TWideStringField;
    btnRefNo: TDNMSpeedButton;
    PopupMenu1: TPopupMenu;
    tblDetailsSalesTaxBasedon: TWideStringField;
    qryexternalxref: TERPQuery;
    dsexternalxref: TDataSource;
    qryexternalxrefID: TIntegerField;
    qryexternalxrefExternalType: TWideStringField;
    qryexternalxrefExternalID: TWideStringField;
    qryexternalxrefExternalAltID: TWideStringField;

    procedure actDelDocketExecute(Sender: TObject);
    procedure actDelDocketUpdate(Sender: TObject);
    procedure actPickUpdate(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure btnAttachmentsClick(Sender: TObject);
    procedure btnPrepaymentClick(Sender: TObject);
    procedure cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboClientDblClick(Sender: TObject);
    procedure cboClientLookupCalcFields(DataSet: TDataSet);
    procedure cboCostCentreCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboPartSpecsEnter(Sender: TObject);
    procedure cboProductQryAfterOpen(DataSet: TDataSet);
    procedure cboTaxCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure DiscountDollarTotalClick(Sender: TObject);
    procedure DiscountPercentTotalClick(Sender: TObject);
    procedure DMTextTargetSalesDrop(Sender: TObject; Acceptor: TWinControl; const DropText: string; X, Y: Integer);
    procedure editFieldChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdTransactionsCalcTitleAttributes(Sender: TObject; const AFieldName: string; const AFont: TFont; const ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure grdTransactionsColEnter(Sender: TObject);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure grdTransactionsFieldChanged(Sender: TObject; Field: TField);
    procedure grdTransactionsRowChanged(Sender: TObject);
    procedure grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure mnuDiscountDollarClick(Sender: TObject);
    procedure mnuDiscountPercClick(Sender: TObject);
    procedure mnuDiscountTotalPopup(Sender: TObject);
    procedure mnuMarkupDollarClick(Sender: TObject);
    procedure mnuMarkupPercClick(Sender: TObject);
    procedure tblDetailsAfterScroll(DataSet: TDataSet);
    procedure tblDetailsBeforePost(DataSet: TDataSet);
    procedure tblDetailsShippedChange(Sender: TField);
    procedure tblDetailsUnitofMeasureQtySoldChange(Sender: TField);
    procedure tblMasterAfterOpen(DataSet: TDataSet);
    procedure txtShipToDblClick(Sender: TObject);
    procedure cboTermsQryBeforeOpen(DataSet: TDataSet);
    procedure grdTransactionsDrawFooterCell(Sender: TObject; Canvas: TCanvas; FooterCellRect: TRect; Field: TField; FooterText: string; var DefaultDrawing: Boolean);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboBaseForeignCurrencyCodeChange(Sender: TObject);
    procedure txtTotalAmountChange(Sender: TObject);
    procedure chkHoldSaleClick(Sender: TObject);
    procedure grdTransactionsExit(Sender: TObject);
    procedure ETAInfoClick(Sender: TObject);
    procedure cboClientEnter(Sender: TObject);
    procedure tblMasterTotalQuoteAmountChange(Sender: TField);
    procedure txtShipToEnter(Sender: TObject);
    procedure txtShipToExit(Sender: TObject);
    procedure grdTransactionsColExit(Sender: TObject);
    procedure tblDetailsCalcFields(DataSet: TDataSet);
    procedure cboProductRNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboBaseForeignCurrencyCodeExit(Sender: TObject);
    procedure cboEmployeeExit(Sender: TObject);
    procedure btnRepairEquipmentClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdTransactionsEnter(Sender: TObject);
    procedure cboTaxCodeDropDown(Sender: TObject);
    procedure cboUnitOfMeasureDropDown(Sender: TObject);
    procedure cboCostCentreDropDown(Sender: TObject);
    procedure cboSupplierDropDown(Sender: TObject);
    procedure cboPartSpecsDropDown(Sender: TObject);
    procedure tblDetailsBeforeInsert(DataSet: TDataSet);
    procedure grdTransactionsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtCustomIDDblClick(Sender: TObject);
    procedure edtContributionAmountDblClick(Sender: TObject);
    procedure actCreateJobUpdate(Sender: TObject);
    procedure actCreateJobExecute(Sender: TObject);
    procedure lblParentclientClick(Sender: TObject);
    procedure tblMasterCalcFields(DataSet: TDataSet);
    procedure actcheckdiscountUpdate(Sender: TObject);
    procedure actcheckdiscountExecute(Sender: TObject);
    procedure edtMemoLineDblClick(Sender: TObject);
    procedure cboCurrentStatusNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboProductRAfterchange(Sender: TObject);
    procedure cboProductRCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboClientRBeforeOpenList(Sender: TObject);
    procedure CustomFields1Click(Sender: TObject);
    procedure grdTransactionsCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure cboSalesCategoryDblClick(Sender: TObject);
    procedure cboSalesCategoryNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure tblMasterInvoiceDocNumberSetText(Sender: TField;
      const Text: string);
    procedure SmartPurchaseOrders1Click(Sender: TObject);
    procedure Repairs1Click(Sender: TObject);
    procedure ProductSelectionOptions1Click(Sender: TObject);
    procedure qryUnitOfMeasureBeforeOpen(DataSet: TDataSet);
    procedure actManifestListUpdate(Sender: TObject);
    procedure actManifestListExecute(Sender: TObject);
    procedure mnuProductNotesClick(Sender: TObject);
    procedure btnShipmentClick(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actPrevExecute(Sender: TObject);
    procedure btnShiptocontactClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure tmrShipToMessageTimer(Sender: TObject);
    procedure btninvoicesClick(Sender: TObject);
    procedure mnuSaleCustomFieldsClick(Sender: TObject);
    procedure ProductSelectionOptions2Click(Sender: TObject);
    procedure mnuAlternateProductClick(Sender: TObject);
    procedure actSignatureExecute(Sender: TObject);
    procedure actSignatureUpdate(Sender: TObject);
    procedure btnAddFreightClick(Sender: TObject);
    procedure tblDetailsBeforeOpen(DataSet: TDataSet);
    procedure tblMasterBeforeClose(DataSet: TDataSet);
    procedure grdTransactionsMultiSelectRecord(Grid: TwwDBGrid;
      Selecting: Boolean; var Accept: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ProductStockQty1Click(Sender: TObject);
    procedure actconsmartExecute(Sender: TObject);
    procedure actconsmartUpdate(Sender: TObject);
    procedure tblMasterBeforeOpen(DataSet: TDataSet);
    procedure doShowPrepayments(Sender: TObject);Virtual;
    procedure btnShowDetailsClick(Sender: TObject);
    procedure grdTransactionsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRefNoClick(Sender: TObject);
    procedure tmrOnshowTimer(Sender: TObject);
    procedure cboViaChange(Sender: TObject);
    procedure cboViaCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure tblDetailsAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    fbSkipCalcs: Boolean;
    ActualMass: Double;
    CubicMetres: Double;
    PriceChange: Boolean;
    FirstFieldChanged: TField;
    OrgLinePrice: Double;
    ClientDiscountObj: TClientDiscountObj;
    bHoldOverride: Boolean;
    bDoCreditCheck: Boolean;
    bUpdateRelatedInProgress: Boolean;
    fbSilentMode: Boolean;
    bDoCalcFields: Boolean;
    fFxObj: TForeignExchangeObj;
    fbDetailId: Integer;
    fStoredEvent: TFieldNotifyEvent;
    fbBarcodeSearch: Boolean;
    LoadingfromHistory:Boolean;
    fbAdd_SpecialPrice:Boolean;
    fbdontAdd_SpecialPrice:boolean;
    fSalessummary :TfmSaleSummary;

    fSalesLocked: Boolean;
    RepairequipmentForm: TfmEquipmentxRef;
    barCodeCreated: Boolean;
    Newbarcode: string;
    CustomfieldonGrid: TCustomFieldonGrid;

    fbAutoSplitQty:Boolean;
    fbCalcQtyForAre:Boolean;
    ShowlinesSalesallocationDEtails :Boolean;
    aExcelObj :TExcelObj;
    mnuShowExcelPrice : TMenuItem;
    fISSalesLineLocked: Boolean;
    fbOnClientchange :Boolean;
    fbCalculatingAvaTax:Boolean;

    procedure CheckForAttachments;

    procedure InitTotals;
    procedure SetComboFocus(var Msg: TMessage); message TX_SetFocus;
    procedure ShowAttachments(fbDragnDropping :boolean);
    procedure AutoShipQtyCallback(const Sender: TBusObj; var Abort: Boolean);
    //procedure AutoResetPricesOncustomerchange(const Sender: TBusObj; var Abort: Boolean);
    procedure DisplayTotalAmounts(Totcost: Double = 0);
    procedure grdMainonDblClick(Sender: TObject);
    procedure showSO(const SOID: Integer);
    procedure showPO(const POIDs: string);
    procedure showdiscount;
    procedure showSaleSPricecolumns;
    procedure ShowcustomisableColumns;
    procedure ShowFC;
    procedure ShowSpec;
    procedure ShowAttrib;
    procedure ShowGrossProfit;
    procedure showsupplier;
    procedure showCC;
    procedure SetHint;
    procedure ConfirmPartSource;

    procedure SetProductcustomFields;
    function ProductDisabledCustomFields: string;
    procedure SetMatrixDetails(sMatrixDesc, sMatrixRef: string; dMatrixPrice: Double);

    procedure BeforeOpenNonRelatedCustomers(Sender: TObject);
    procedure Createjob;
    procedure BeforeshowJob(Sender: TObject);
    procedure Showcontribution;
    procedure EnableStatusCombo;
    procedure ShowPriceCalc;
    procedure beforeshowCustomfieldList(Sender: TObject);
    procedure BeforeShowSaleCustomFieldList(Sender: TObject);
    procedure ApplyCustomFieldsSettings;
    procedure SelectAlternateProduct;
    procedure SmartPOList;
    procedure BeforeOpenSalesSmartPOList(Sender: TObject);
    procedure RepairList;
    procedure BeforeOpenRepairList(Sender: TObject);
    procedure HideProductsourceOption(sender: TObject);
    procedure AutoLoadProducts;
    function CustomerHAsSaleHistory: Boolean;
    procedure LoadLastOrder;
    procedure openOrderHistory;
    procedure CustomerProductsaleshistorybeforeshow(Sender: TObject);
    procedure CustomerProductsaleshistoryonselect(Sender: twwDBGrid);
    procedure OpenProductList;
    procedure AutoLoadProductOptions(IgnorePrefs: boolean = false);
    procedure RecalculateNoOfBoxes;
    procedure ProductPricesClick(Sender: TObject);
    procedure RelatedProductclick(Sender: TObject);
    function IsSalesLineLocked: Boolean;
    procedure InitSalesAutoSplitQty(Sender: TObject);
    procedure ApplyAutoSplitQty(Sender: TObject);
    procedure DoAutoSplitQty;
    procedure initManifestList(Sender: TObject);
    procedure OpenProductNotes;
    procedure MoveTonotePage(Sender: TObject);
    procedure initSalesPickedQtyreport(sender: TObject);
    procedure initProductclassQty(Sender: TObject);
    procedure checkforStockinOtherDept;
    procedure UpdateFromShipToContact(Sender: TwwDbGrid);
    procedure BeforeShowSaleconvertedToList(Sender: TObject);
    procedure AfterShowSaleconvertedToList(Sender: TObject);
    procedure DoPackWeight;
    procedure initProductQtyBinETA(Sender: TObject);
    class function DoshowStock(SaleObj: TSales; FColor: Tcolor; ProgressBar: TProgressBar = nil; aOwnerform:Tform=nil): Boolean;
    procedure MakeAllBO(const Sender: TBusObj; var Abort: Boolean);
    procedure BeforeOpenSalesStockQtyStatus(Sender: TObject);
    Procedure ShowAccountCbo(Const Value:Boolean);
    procedure SalesAllocationDetailsClick(Sender:TObject);
    procedure intSalesAllocationDetails(Sender: TObject);
    Procedure ShowRPDetailsForm(Sender:TObject);overload;
    Procedure upodaterelatedProdQty(Sender:TObject);
    procedure DisableLineZeroQtyWarning(Sender: TObject; Checked: boolean);
    Procedure SalesPrepaymentbeforeopen(Sender:TObject);
    procedure oncloseSalessummaryList(Sender: TObject);
    procedure RefreshSalessummary;
    function ExcelObj :TExcelObj;
    function OnChooseCell(ASender: TObject): Boolean;
    procedure CheckForSalesTaxBasedon(const aISSalesLocked: Boolean);
    procedure InitTermsduedate;
    function DeliverydocketTemplateForSale: String;
    //procedure DoCalcAvaTax(Sender: TObject);
    //procedure DoCommitAvaTax(Sender: TObject);
    procedure DoLogAvaTaxdetails(Sender: TObject);
  protected
    fMsgHandler: TMsgHandler;
    fLockSalesInitialized: Boolean;
    dTotalAmount: Currency; // total amount for this sale
    dTotalCost: Currency; // total costs  for this sale
    dTotalOrdered: Currency; // total no. ordered for this sale
    dTotalShipped: Currency; // total no shipped for this sale
    bIsFreezeQuoteAmount: Boolean;
    iClientID: Integer;
    fCurrentSeqNo : integer;  //@@
    // bPickingSlip: Boolean;
    DontCloseAfterPrint: Boolean;
    CloseByPicking: Boolean;
    LastCurrencyCode: string;
    fSalesShippingDetailForm: TfmSalesShippingDetail;
    fbPOshown :Boolean;
    fbAutoshipmentafterformshow:Boolean;
    fbshipmentafterformshow:Boolean;
    function DeleteLinerecord:Boolean;Override;
    function SalesShippingDetailForm: TfmSalesShippingDetail;
    function FxObj: TForeignExchangeObj;
    function GetProductInStockValue(const ID: Integer): Integer;
    function IsCustomerOK(const iClientID: Integer; const bVerbose: Boolean = true): Boolean;
    function isDeptValid: Boolean;
    function IsOkToSaveSale: Boolean;
    function ReplaceColumnNo(const ColumnNo: Integer; const ReplacmentStr, LineString: string): string;
    procedure AfterCommit; override;
    procedure CompleteComboNotInList(const aObserver: TObject); override;
    procedure ConvertAttachments(const OldSaleId, NewSaleId: Integer);
    procedure EnableDisableTranFunctions; override;
    procedure IsOK_to_Print(var IsOk: Boolean); override;
    procedure UpdateAfterMemTrans; override;
    procedure RefreshUnitsQry;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); override;
    function LineEmpty: Boolean;
    Procedure ProductformulaEntry(Sender:TObject);
    procedure Ordered(const Sender: TBusObj; var Abort: Boolean);
    procedure RefreshProductQry;
    procedure Locksales;
    Procedure LockLinefieldsonAccessLevel(const DoLock:Boolean);
    procedure unlockSalesLine(Inserting:Boolean);
    function IssalesLocked: Boolean;
    function IstransLineLocked: Boolean; Override;
    function IstransLinePriceLocked: Boolean;
    procedure showStock; overload;
    function getcontactType: TContactType; override;
    //procedure UpdateFromContact(const Value: TDataSet); override;
    function FieldsToExecludeFromsorting: string; override;
    procedure OnSelectPoints(Sender: TObject); override;
    procedure PrintAddressLabel;
    procedure AddRelatedclient(Sender: TwwDbGrid); overload;
    procedure AddRelatedclient; overload;
    procedure recalcInvoicesamount; virtual;
    procedure AddAlterNateProduct(Sender: TwwDbGrid);
    procedure ReplaceProductWtihAlternateProduct(Sender: TwwDbGrid);
    procedure BeforeShowAlternateProductsGUI(Sender: TObject);
    Procedure OpenAlternateProductListtoReplace;Virtual;
    //
    procedure DoOnClientchange; override;
    procedure DoOnProductchange; override;
    procedure CheckshiptoAccess;
    procedure EnableDisable; override;
    {$IFDEF FORM_BASED_SELECT_SQL}
    function TransSpecificSQL :String;Override;
    {$ENDIF}
    procedure SetDatasetconn;Override;
    procedure AfterSubFormShow(Sender: TObject);Override;
    procedure beforeSubFormShow(Sender: TObject); Override;
    procedure CheckForMailAttachments(Corres: TCorrespondenceGui); overload;
    procedure TranslockComponents(var lockComponents: TStringDynArray );Override;
    procedure Lockcomponents;virtual;
    procedure PopulateMessageSubstituteList(SL: TStringList); override;
    function IsOktodeleteLine: Boolean;override;
    procedure SkipReadonlyfield;Override;
    function GetOrAddMobileNumber: string;
    procedure NewTransBusObjinstance;override;
    function TransStatustype:String ;override;
    function SaveTransToPDF: boolean; override;
    procedure AddDefaultOrdermenuITems;Override;
    Procedure openSalesPickedQty(Sender:TObject);
    procedure DoShipments;
    Procedure DoInventoryVerification(Sender:TObject);
    {$IFDEF FORM_BASED_SELECT_SQL}
    function RepairSalesSQL:String;Override;
    {$ENDIF}
    function ShowInvVerify(const Showcontinue: Boolean ; var NewSmartOrderID: integer): Boolean;virtual;
    procedure OpenSmartOrder(const SOID:Integer; iSaleID:Integer; sSaleRef:String);virtual;
    function ClientState:String; Override;
    function Clientcountry:String; Override;
    function clientLocation:String; Override;
    function ClientPostcode:String; Override;
    procedure AddProductPriceMenu;Virtual;
    Procedure PrintSalesDispatchBarcode(Sender: TObject);
    function ConfirmForPOcost:Boolean;
    function SaveTrans:Boolean ; Override;
    Procedure LoadTransRec; Override;
    procedure SetDirty(ADirty : boolean);virtual;

    function GetSalesCCAddresses(aEmployeeId : integer) : string;
    procedure ChooseRelatedParts(Sender: TDatasetBusObj);Override;
    Procedure InitERPLookupCombonFields; Override;
    Function DisfieldstoRemove:String;Override;
    Procedure OnGuiPrefsActive(Sender :TObject);Override;
    Function SelectedLineIds : String;
    Function IsOkToCopyToSMart :Boolean;
    Function  ShowRPDetailsForm:Boolean;overload;
    procedure ShowStatus(const Value: string); override;
    procedure OpenPrepaylist;Virtual;
    function CheckForfieldsinGridKeyPress(Sender: TObject;  var Key: Char):boolean;Override;
    procedure InitRefBtn;
    procedure ShowFormulafields;Override;
    Procedure DoShowExcelPrice(Sender:TObject); overload;virtual;
    procedure DoShowExcelPrice(SearchFor:String; ShowMsgifExcelPricenotExists:Boolean;OpenExcelsheet:Boolean);overload;virtual;
    Function ExcelObjEvent(sender :TExcelObj ; Eventtype :TExcelObjEventtype):Boolean;virtual;
    Procedure DoGeneralMenuItemClick(Sender:TObject);
    procedure DoGetShippingRates;
    Procedure AfterFormShow; Override;
    procedure Refreshexternalxref;
    function CalcAvaTax: Boolean;
    procedure CalcAvaTaxNoTaxCallback(const Sender: TBusObj;var Abort: Boolean);
    //Procedure AddProductOptionsProduct(const OldProductId, newProductID:Integer); Override;
  public
    { Public declarations }
    UnitofMeasureRunOnce: Boolean;
    bConvetingFromAppointment: Boolean;
    fbUsingTimesheetCosting: Boolean;
    fbUpdateNow: Boolean;
    fbDontCopyFilter: Boolean;
    fbDontRefreshCalcs: Boolean;
    fbSkipInherit: Boolean;
    fbSkipShippedChanged: Boolean;
    bCreditCheckOn: Boolean;
    SaleBase: TSales;
    // true if we are checking Credit limits (set true in descendant)
    procedure AutoShippingRun; override;
    procedure UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil); override;
    procedure UpdateMe; override;
    function ShowNoCustomerWarning: Boolean; // true if No Customer
    function convertToRepair: Boolean;
    class function showStock(SaleObj: TSales; FColor: Tcolor; ProgressBar: TProgressBar = nil; aOwnerform:Tform=nil): Boolean; overload;
    function SaveSalesRecord: Boolean; virtual;
    Procedure REadFeSaleslines;
    procedure DoShipmentafterformshow;
    procedure DoAutoShipmentafterformshow;
    Procedure AfterPopupformshow; Override;

  published
    property SilentMode: Boolean read fbSilentMode write fbSilentMode;
  end;

implementation

uses Math, DNMExceptions, ShipAddressListForm, frmPartsfrm, TNTFreightChargesObj,
    frmCustPrepayments, frmCustomerFrm, ActiveX, frmAttachments, tcDataUtils, CommonDbLib,
    DNMLib, GlobalEventsObj,  BusObjStock, GuiPrefsObj, frmProductETAInfo, frmProductQtyBinGUI,
    BusObjConst, frmSalesProductSpec, BusobjSaleBase, frmDelayMessageDlg,
    AppEnvironment, FastFuncs, Productqtylib,(**)frmProductQtysBinsETAs, ProductAttributeLib,
    BusobjAttribProduct, frmShippingContainerGUI, frmSmartOrderFrm, frmStockStatus,
    BusObjTrans, LogUtils, busobjrepairs, BaseFormForm, DNMAccessManager,BusObjEquipment,
    EquipmentListForm, frmMessage, frmInvoice, saleslib, ProductListExpressForm,
    frmpartsPriceMatrixInput, PartsPriceMatrixLib, frmproductPrices, CommonFormLib, BusObjClient,
    BaseListingForm, AppDatabase, MemoDialog, frmSimpleTypes, AlternateProductSearch,
    tcconst, CustomerExpressList, frmCustomfieldList, Busobjcustomfields, CustomFieldsObj,
  SalesSmartPOList, SalesRepairList, frmMessageBase,
  frmSalesProductAutoSelectOptions, CustomerProductsaleshistory,
  BusObjAttachment, SystemLib, frmvoucherInvoice, frmVoucherSale, BusObjContact,
  frmMobileNumberInput, SMSUtils, BusobjSalesQtySplit , frmSalesAutoSplitQty,
  frmSalesOrder, frmQuote, ManifestList, sndkey32,
  RepairsLib, frmSalesInventoryVerify, SalesPickedQty, ShipIntegrationTypes, EmployeeAccesses,
  ProductclassQty, DbSharedObjectsObj, BusObjProductClass,
  SalesDiscountValidationObj, LogLib, SaleconvertedToList, frmSalesPackWeight,
  SalesQtyShipAdjustmentsObj, IntegerListObj, ERPErrorEmailUtils, frmSignatureEdit,
  ThreadObjForOtherDB, SalesStockQtyStatus, SalesAllocationDetails,
  FrmSalesRelatedProducts, TypesLib, JSONObject, SalesPrepayments,
  DateTimeUtils, ERPVersionConst , IdGlobal, MessageDlgXP_forPreference,
  frmSalesExt, Preferences, Busobjpartsforexcelprice, frmShipmentRates,
  AvaTaxLib;

const
  Flag_ForeignCurrencyLinePriceChange = 1;
  Flag_QtySoldChange = 2;
  Flag_LinePriceIncChange = 3;
  Flag_LinePriceChange = 4;
  Flag_ProductXCloseUp = 5;
  Flag_LoadRelatedParts = 6;
  Flag_Specifications = 7;

{$R *.dfm}
function TBaseSaleGUI.IsOktodeleteLine: Boolean;
begin
  Result := not IstransLineLocked;//IsSalesLineLocked;
  if result = false then exit;

  If SaleBase.IsBOInvoiced and (SaleBase.Lines.QtyBackOrder<>0) then begin
    LineLockMsg :='This transaction has a shipped backorder';
    result := False;
    Exit;
  End;
  if Salebase.anystartedpacking then begin
    LineLockMsg :=Salebase.XMLNodeName + ' # ' + inttostr(Salebase.ID) +' is already started picking / packing';
    result := False;
    Exit;
  end;
  result:= True;

end;
function TBaseSaleGUI.IstransLinePriceLocked: Boolean;
begin
  Result := inherited IstransLineLocked;
  if result then exit;
  result:= IssalesLocked;
  if result then exit;
  if TransAccessLevel > 2 then result := true;
end;
function TBaseSaleGUI.IstransLineLocked: Boolean;
begin
  result:= IsSalesLineLocked;
  if result then exit;
  if SaleBase.IsBOInvoiced then begin
    LineLockMsg :='This transaction has a shipped backorder';
    Result := True;
  end;
  if result then exit; // the line is already readonly
end;
function TBaseSaleGUI.IsSalesLineLocked: Boolean;
begin
  Result := inherited IstransLineLocked;
  if result then exit;
  if TSalesLine(SaleBase.Lines).BOMGroupedLine then begin
    result := True;
    LineLockMsg := Quotedstr(SaleBase.Lines.LineDescription)+ ' is already grouped in the production';
  end;
  if result then exit;

  if TSalesLine(SaleBase.Lines).BOMProductionLine then begin
    result := True;
    LineLockMsg := Quotedstr(SaleBase.Lines.LineDescription)+ ' is a grouped entry in the production';
  end;
end;

function TBaseSaleGUI.IssalesLocked: Boolean;
begin
  Result := accessLevel>3;
end;

procedure TBaseSaleGUI.lblParentclientClick(Sender: TObject);
begin
  inherited;

end;

{ }
procedure TBaseSaleGUI.Locksales;
var
  intX, ctr: Integer;
  fbFlag :Boolean;
begin
  if fLockSalesInitialized and (fSalesLocked = IssalesLocked) then Exit;
  fLockSalesInitialized := true;
  fSalesLocked := IssalesLocked;
  fISSalesLineLocked:= false;
  if fSalesLocked then begin
    AccessLevel := 5;
    //Exit;
  end;

  for intX := 0 to Self.ComponentCount - 1 do begin
    if Self.Components[intX] = cboCurrentTransStatus then Continue;
             if Self.Components[intX] is TwwDBDateTimePicker  then begin TwwDBDateTimePicker(Self.Components[intX]).Readonly:= fSalesLocked     ;TwwDBDateTimePicker(Self.Components[intX]).Enabled:= not(fSalesLocked);
    end else if Self.Components[intX] is TwwDBLookupCombo     then begin TwwDBLookupCombo(Self.Components[intX]).Readonly   := fSalesLocked     ;TwwDBLookupCombo(Self.Components[intX]).Enabled   := not(fSalesLocked);
    end else if Self.Components[intX] is TDBMemo              then begin TDBMemo(Self.Components[intX]).Readonly            := fSalesLocked     ;TDBMemo(Self.Components[intX]).Enabled            := not(fSalesLocked);
    end else if Self.Components[intX] is TDBEdit              then begin TDBEdit(Self.Components[intX]).Readonly            := fSalesLocked     ;TDBEdit(Self.Components[intX]).Enabled            := not(fSalesLocked);
    end else if Self.Components[intX] is TEdit                then begin TEdit(Self.Components[intX]).Readonly              := fSalesLocked     ;TEdit(Self.Components[intX]).Enabled              := not(fSalesLocked);
    end else if Self.Components[intX] is twwIButton           then begin twwIButton(Self.Components[intX]).Enabled          := not(fSalesLocked);
    end else if Self.Components[intX] is TwwDbGrid            then begin TwwDbGrid(Self.Components[intX]).REadonly          := fSalesLocked;
      if not fSalesLocked then begin
        if not(dgEditing in grdTransactions.Options) then TwwDbGrid(Self.Components[intX]).Options := TwwDbGrid(Self.Components[intX]).Options + [dgEditing];
      end else if fSalesLocked then begin
        if dgEditing in grdTransactions.Options then TwwDbGrid(Self.Components[intX]).Options := TwwDbGrid(Self.Components[intX]).Options - [dgEditing];
      end;
    end;
  end;


  if not fSalesLocked then begin
    if KeyId <> 0 then begin
      fISSalesLineLocked := IstransLineLocked;
    end else begin
      fISSalesLineLocked := False;
    end;
      for ctr:= 0 to tbldetails.Fields.Count-1 do
        try
          Readonlyfield(tbldetails.Fields[ctr].fieldname           , fISSalesLineLocked);
        Except
          // kill exception if the column doesn't exists
        end;
      cboProductR.ReadOnly                    := fISSalesLineLocked;
      if LineLockMsg <> '' then
        TransTimerMsg(LineLockMsg);

      fbFlag := IstransLinePriceLocked;
      Readonlyfield(tblDetailsLinePrice.FieldName           , fbFlag);
      Readonlyfield(tblDetailsLinePrice.FieldName           , fbFlag);
      Readonlyfield(tblDetailsLinePriceInc.FieldName        , fbFlag);
      Readonlyfield(tblDetailsTotalLineAmount.FieldName     , fbFlag);
      Readonlyfield(tblDetailsTotalLineAmountInc.FieldName  , fbFlag);

      if SaleBase.isboinvoiced or (SaleBase.TotalPaid <>0) or (TransAccessLevel>3) then begin
        Readonlyfield(tblDetailsLinePrice.FieldName           , true);
        Readonlyfield(tblDetailsLinePriceInc.FieldName        , true);
        Readonlyfield(tblDetailsTotalLineAmount.FieldName     , true);
        Readonlyfield(tblDetailsTotalLineAmountInc.FieldName  , true);
        Readonlyfield(tblDetailsLineTaxRate.FieldName  , true);
        Readonlyfield(tblDetailsLineTaxCode.FieldName  , true);
        Readonlyfield(tblDetailsLineTax.FieldName  , true);
        Readonlyfield(tblDetailsUnitofMeasureQtySold.FieldName  , True);
        Readonlyfield(tblDetailsUnitofMeasureShipped.FieldName  , True);
        Readonlyfield(tblDetailsUnitofMeasureBackorder.FieldName, True);
        Readonlyfield(tblDetailsUnitofMeasureSaleLines.FieldName, True);
        Readonlyfield(tblDetailsProductname.FieldName, True);
        Readonlyfield(tblDetailsPartBarcode.FieldName, True);
        btnDelete.Enabled := False;
        TransTimerMsg(Salebase.XMLNodeName + ' # '+ inttostr(Salebase.ID)+iif(SaleBase.isboinvoiced , ' has invoiced backorder(s)' , ' is paid')+'. Access is changed to read only');
      end else if Salebase.anystartedpacking then begin
        Readonlyfield(tblDetailsUnitofMeasureQtySold.FieldName  , True);
        Readonlyfield(tblDetailsUnitofMeasureShipped.FieldName  , True);
        Readonlyfield(tblDetailsUnitofMeasureBackorder.FieldName, True);
        Readonlyfield(tblDetailsUnitofMeasureSaleLines.FieldName, True);
        Readonlyfield(tblDetailsProductname.FieldName, True);
        Readonlyfield(tblDetailsPartBarcode.FieldName, True);
        btnDelete.Enabled := False;
        TransTimerMsg(Salebase.XMLNodeName + ' # '+ inttostr(Salebase.ID)+' is already started packing. Access is changed to read only');
      end;

      {fieldscopied from repairs - should not be editable}
      grdtransactions.ColumnByName(tblDetailsEquipment.FieldName).ReadOnly := true;
      tblDetailsEquipment.ReadOnly := true;
      LockLinefieldsonAccessLevel(tbldetails.state <> dsInsert);
  end;


  ApplyTransAccesslevel(fSalesLocked , fISSalesLineLocked);
  grdtransactions.ColumnByName(tblDetailsLinesOrder.FieldName).ReadOnly := true;
  if not (Appenv.companyprefs.CostEditableinSales) then begin
    grdtransactions.ColumnByName(tblDetailsLinecost.FieldName).ReadOnly := true;
    grdtransactions.ColumnByName(tblDetailsLinecostInc.FieldName).ReadOnly := true;
  end;
  CheckForSalesTaxBasedon( (fISSalesLineLocked) or (fSalesLocked) );

  { total fields are always readonly as they are calculated and displayed }
  txtSubTotal.Readonly := true;
  txtTotalTax.Readonly := true;
  txtTotalAmount.Readonly := true;
  btnEdit.Enabled :=  not (fSalesLocked) and (SaleBase.IsBOInvoiced);
end;
procedure TBaseSaleGUI.CheckForSalesTaxBasedon(Const  aISSalesLocked:Boolean);
begin
  saleslib.CheckForSalesTaxBasedon(Self, aISSalesLocked,SaleBase);
  (*if (SaleBase.Lines.ProductId>0) then begin
    if not(aISSalesLocked) then begin
      if SaleBase.Lines.SalesTaxBasedonProductPrice then begin
        grdtransactions.ColumnByName(tblDetailsLinePrice.FieldName).ReadOnly := true;
        grdtransactions.ColumnByName(tblDetailsLinePriceInc.FieldName).ReadOnly := true;

        grdtransactions.ColumnByName(tblDetailsDiscountedPrice.FieldName).ReadOnly := False;
        grdtransactions.ColumnByName(tblDetailsDiscountedPriceInc.FieldName).ReadOnly := False;


        grdtransactions.ColumnByName(tblDetailsTotalLineamount.FieldName).ReadOnly := true;
        grdtransactions.ColumnByName(tblDetailsTotalLineamountInc.FieldName).ReadOnly := true;

        grdtransactions.ColumnByName(tblDetailsTotalDiscountedPrice.FieldName).ReadOnly := False;
        grdtransactions.ColumnByName(tblDetailsTotalDiscountedPriceInc.FieldName).ReadOnly := False;

        if tblDetailsLinePrice.visible then begin
            if not tblDetailsDiscountedPrice.visible then tblDetailsDiscountedPrice.index := tblDetailsLinePrice.index+1;
            grdTransactions.AddField(tblDetailsDiscountedPrice.FieldName);
            guiprefs.DbGridElement[grdTransactions].UnHideField(tblDetailsDiscountedPrice.FieldName);

            if not tblDetailsTotalDiscountedPrice.visible then tblDetailsTotalDiscountedPrice.index := tblDetailsLinePrice.index+1;
            grdTransactions.AddField(tblDetailsTotalDiscountedPrice.FieldName);
            guiprefs.DbGridElement[grdTransactions].UnHideField(tblDetailsTotalDiscountedPrice.FieldName);

        end;

        if tblDetailsLinePriceinc.visible then begin
            if not tblDetailsDiscountedPriceinc.visible then tblDetailsDiscountedPriceinc.index := tblDetailsLinePriceinc.index+1;
            grdTransactions.AddField(tblDetailsDiscountedPriceinc.FieldName);
            guiprefs.DbGridElement[grdTransactions].UnHideField(tblDetailsDiscountedPriceinc.FieldName);

            if not tblDetailsTotalDiscountedPriceinc.visible then tblDetailsTotalDiscountedPriceinc.index := tblDetailsLinePriceinc.index+1;
            grdTransactions.AddField(tblDetailsTotalDiscountedPriceinc.FieldName);
            guiprefs.DbGridElement[grdTransactions].UnHideField(tblDetailsTotalDiscountedPriceinc.FieldName);

        end;
      end else begin
        grdtransactions.ColumnByName(tblDetailsLinePrice.FieldName).ReadOnly := False;
        grdtransactions.ColumnByName(tblDetailsLinePriceInc.FieldName).ReadOnly := False;
        grdtransactions.ColumnByName(tblDetailsTotalLineamount.FieldName).ReadOnly := False;
        grdtransactions.ColumnByName(tblDetailsTotalLineamountInc.FieldName).ReadOnly := False;
      end;
    end;
  end;*)
end;
procedure TBaseSaleGUI.LockLinefieldsonAccessLevel(const DoLock:Boolean);
begin
  if AccessLevel <=3 then begin
    if not DoLock then begin
      Readonlyfield(tblDetailsLineTaxCode.FieldName  , False);
    end else begin
      if AllowChangingProdutTaxCodeinSales = False then
        if tbldetailslinetaxcode.readonly = false then
          if tbldetailslinetaxcode.asString <> '' then begin
            Readonlyfield(tblDetailsLineTaxCode.FieldName  , true);
          end;
    end;
    if not DoLock then begin
      Readonlyfield(tblDetailsUnitofMeasureSaleLines.FieldName  , False);
    end else begin
      if AllowChangingProdutUOMinSales = False then
        if tblDetailsUnitofMeasureSaleLines.readonly = false then
          if tblDetailsUnitOfMeasureID.asInteger <> 0 then begin
            Readonlyfield(tblDetailsUnitofMeasureSaleLines.FieldName  , true);
          end;
    end;

  end;
end;

procedure TBaseSaleGUI.ApplyCustomFieldsSettings;
begin
  CustomfieldonGrid := TCustomFieldonGrid.Create(Self,
    'SalesLinesCustField1,SalesLinesCustField2,SalesLinesCustField3,SalesLinesCustField4,SalesLinesCustField5,SalesLinesCustField6,SalesLinesCustField7,SalesLinesCustField8,SalesLinesCustField9,SalesLinesCustField10',
    ltSaleslines, grdTransactions, guiprefs, salebase);
  CustomfieldonGrid.ApplyCustomFieldsSettings;
end;

procedure TBaseSaleGUI.FormShow(Sender: TObject);
var
  // I: Integer;
  //TempStr: string;
  s: string;
begin

  stepProgressbar;
  SetHint;
  RepairequipmentForm := nil;

  SaleBase.showSO := showSO;
  SaleBase.showPO := showPO;
  fLockSalesInitialized := False;
  fbDetailId := -1;
  iClientID := 0;
  pnlHold.Visible := bCreditCheckOn;

  bHoldOverride := False;
  if ((Self is TSalesOrderGUI) or (Self is TInvoiceGUI)) then
  // LinesOrder,
    s :=  'Shipped,BackOrder,OrgLinePrice,SaleID,SaleLineID,QtySold,GlobalRef,ProductGroup,LineWholesalePrice,LineTaxRate,SortID,'
  else
    s :=  'Shipped,BackOrder,OrgLinePrice,SaleID,SaleLineID,QtySold,GlobalRef,ProductGroup,LineWholesalePrice,LineTaxRate,SeqNo,UnitofMeasureShipped,UnitofMeasureBackorder,';
  s := s + 'Invoiced,EditedFlag,Deleted,ProductID,PartType,RefundQty,LaybyID,IncomeAccnt,AssetAccnt,CogsAccnt,' + 'CalcPriceInc,CalcTotalInc,CalcTotalEx,CalcTax,CalcBackOrder,CalcLinePriceEx,' +
        'CalcTotalIncB4Discount,LastLineID,UnitofMeasureMultiplier,ForeignExchangeSellRate,' + 'ForeignTotalLineAmount,CalcProfitEx,CalcProfitPercentEx,SearchFilter,' +
        'SearchFilterCopy,IsRelatedProduct,RelatedParentProductID,CostCentreId,UseHedging,' + 'PartSpecID,CreationDate,SoldSerials,LineNotes,CustomData,UnitOfMeasureID,' +
        'RelatedParentLineRef,RelatedProductQty,IsFormulaRElatedProduct,FormulaID,Specifications,' + 'LastUpdated,IsQuote,BaseLineno,HireId,HireSerials,HireToBeReturned,' +
        'CostCentre,WarrantyEnds,%ProfitInc,GP%,LatestCost,TimeCostUsed' + 'Supplier,SupplierContact,DocketNumber,BaseLineNo,'+
        'ProfitbasedLatestCost,ProfitbasedLatestCostPercent,ProfitbasedLatestCostInc,MatrixRef,ProfitbasedLatestCostPercentInc' + ProductDisabledCustomFields;
  if not((Self is TSalesOrderGUI) or (Self is TInvoiceGUI)) then s:= s +',' +tblDetailsOriginalQtyOrdered.fieldname;

  guiprefs.DbGridElement[grdTransactions].RemoveFields(s);
  //if not {Appenv.CompanyPrefs.EnablePackWeight}SaleBase.Lines.Product.EnablePackWeight then GuiPrefs.DbGridElement[grdTransactions].RemoveFields('Packcount,packweightField');


  if KeyId = 0 then begin
    bDoCreditCheck := False;
  end else begin
    bDoCreditCheck := bCreditCheckOn;
  end;

  inherited;
  closedb(qryUnitOfMeasure);
  opendb(qryUnitOfMeasure);
  if SaleBase.Lines.count >0 then begin
    Setcolumn(SaleBase.Lines.Product.EnablePackWeight and (Appenv.companyPrefs.PackWeightQtyField <>2), tblDetailsPackWeightField2.fieldname , Appenv.CompanyPrefs.PackWeightField2  );
    Setcolumn(SaleBase.Lines.Product.EnablePackWeight and (Appenv.companyPrefs.PackWeightQtyField <>1), tblDetailsPackWeightField1.fieldname , Appenv.CompanyPrefs.PackWeightField1  );
    Setcolumn(SaleBase.Lines.Product.EnablePackWeight , tblDetailsPackcount.fieldname , 'Pack Count' );
  end;
  if appenv.CompanyPrefs.EnableAutoSplitQtyintoUOMinSales then  begin
    s:=tblDetailsUnitofMeasureSaleLines.DisplayLabel;
    if pos(' (F8)', s) = 0 then begin
      s:=s+' (F8)';
      tblDetailsUnitofMeasureSaleLines.DisplayLabel := s;
      UpdateSelectedProp(grdtransactions.Selected, tblDetailsUnitofMeasureSaleLines.fieldname, s, sptUpdateLabel);
    end;
  end;
  ApplyCustomFieldsSettings;
  SaleBase.Lines.DataSet.Filter := Salebase.TranslineFilter;
  SaleBase.Lines.DataSet.Filtered := true;
  SaleBase.Lines.FESalesLines.Lines.DataSet.Filter := 'Deleted <> ' + QuotedStr('T');
  SaleBase.Lines.FESalesLines.Lines.DataSet.Filtered := true;

  if KeyId <> 0 then begin
    iClientID := Self.tblMasterClientID.AsInteger;
  end;


  showSaleSPricecolumns;
  ShowcustomisableColumns;
  Self.tblDetailsLineTax.DisplayFormat := Appenv.RegionalOptions.CurrencySymbol + '0.00###';
  ShowFC; { Not Using  Foreign Currency }
  ShowSpec; { Not Product Specifications Calc }
  ShowAttrib;
  ShowGrossProfit;
  showsupplier;
  showCC;
  InitTotals;
  bIsFreezeQuoteAmount := False;
  ClassLabel.Caption := Appenv.DefaultClass.ClassHeading;
  ShowAccountCbo(cboAccountQry.RecordCount > 1);
  PriceChange := False;

  // hide columns according to company prefs and access levels
  Setcolumn(Appenv.CompanyPrefs.ShowSalesUnits, 'UnitofMeasureSaleLines');
  Setcolumn(Appenv.CompanyPrefs.ShowSalesDescription, 'Product_Description');
  Setcolumn((Appenv.CompanyPrefs.ShowSalesProfit) and (CanShowMargin), 'CalcProfit');
  Setcolumn((Appenv.CompanyPrefs.ShowSalesProfitPercent) and (CanShowMargin), 'CalcProfitPercent');



  Setcolumn(Appenv.CompanyPrefs.ShowSalesTaxCode, 'LineTaxCode');
  Setcolumn(Appenv.CompanyPrefs.ShowSalesTaxAmount, 'LineTax');
  guiprefs.DbGridElement[grdTransactions].HideField('BaseLineno');

  Setcolumn(False, tblDetailsCustomerEquipmentID.FieldName);
  Setcolumn(False, tblDetailsSalesTaxBasedon.FieldName);

  showdiscount;
  SetControlFocus(cboClientR);
  grdTransactions.SetActiveField('ProductPrintName');


  if KeyId = 0 then begin

  end
  else begin
    if AccessLevel <= 2 then begin
      SaleBase.DoCalcOrderTotals;
      if ReopeningForm and (sametext(ReopeningFormClass , 'TfmCustPrepayments') or sametext(ReopeningFormClass , 'TfmCustPayments') ) then  begin
                if SaleBase.IsCustomerCreditOk then begin
                  if SaleBase.HoldSale then SaleBase.HoldSale := False
                end else begin
                  If ((Salebase Is TInvoice) And (AppEnv.CompanyPrefs.CreditCheckInv) (*and ((SaleBase.TotalBalance - TInvoice(SaleBase).TotalPrePayments) > 0 )*))
                      Or ((Salebase Is TSalesOrder) And (AppEnv.CompanyPrefs.CreditCheckSO) (*and ((SaleBase.TotalBalance - TSalesOrder(SaleBase).TotalPrePayments - TSalesOrder(SaleBase).TotalProgressPayments) > 0 )*)) Then
                    If (Not Salebase.HoldSale)  Then begin
                          CommonLib.MessageDlgXP_Vista('This Sale will be marked as "Hold"' , mtInformation, [mbok], 0) ;
                          Salebase.HoldSale := True;
                          Salebase.PostDB;
                          Salebase.connection.CommitTransaction;
                          Salebase.connection.BeginTransaction;
                    End;
                end;
        SaleBase.PostDB;
      end;
      DisplayTotalAmounts(SaleBase.Totalcalc('LineCostInc*Shipped', SaleBase.ID, 'SaleID', SaleBase.Lines.GetBusObjectTablename));
    end;
  end;

  if (cboClientR.Visible) and (cboClientR.Enabled) then SetControlFocus(cboClientR);

  CheckForAttachments;
  // Set comments memo as drop target for files dropped on the form
  DMTextTargetSales.AcceptorControl := nil;
  DMTextTargetSales.AcceptorControl := txtComments;

  lblEarlyPaymentDiscountAmount.Caption := FloatToStrF(SaleBase.EarlyPaymentDiscountAmount, ffCurrency, 15, CurrencyRoundPlaces);

  if tblDetails.IndExFieldNames ='' then tblDetails.IndExFieldNames := 'LinesOrder ASC';

  // This must remain!
  bIsInitialising := False;
  stepProgressbar;
  Showcontribution;
  AddProductPriceMenu;
  fLockSalesInitialized:= False;
  LockSales;
  //if GuiPrefs.Node.Exists('Options.ShowSummary') and (GuiPrefs.Node['Options.ShowSummary'].asBoolean) then btnShowDetails.click;
end;
procedure TBaseSaleGUI.RelatedProductclick(Sender: TObject);
begin
  Salebase.lines.AddRelatedProducts;
  Salebase.lines.UpdateRelatedPartsQty;
  Salebase.DoCalcOrdertotals;
end;
procedure TBaseSaleGUI.SalesAllocationDetailsClick(Sender:TObject);
begin
  ShowlinesSalesallocationDEtails := sametext(TMenuItem(Sender).caption , 'Sales Lines Allocation Details');
  OpenERPListForm('TSalesAllocationDetailsGUI' , intSalesAllocationDetails);
end;
procedure TBaseSaleGUI.intSalesAllocationDetails(Sender:TObject);
begin
  if sender is TSalesAllocationDetailsGUI then begin
    TSalesAllocationDetailsGUI(sender).SaleId := Salebase.id;
    if ShowlinesSalesallocationDEtails then TSalesAllocationDetailsGUI(sender).SaleLineID := Salebase.Lines.id;
  end;
end;
procedure TBaseSaleGUI.AddProductPriceMenu;
begin
  NewMenuForTransGrid('Product Prices' , ProductPricesClick , FAlse);
  //NewMenuForTransGrid('Related Products' , RelatedProductclick , FAlse);
  NewMenuForTransGrid('Sales Allocation Details' , SalesAllocationDetailsClick , FAlse);
  NewMenuForTransGrid('Formula Details' , ProductformulaEntry , FAlse);
  NewMenuForTransGrid('Related Products (F12)' , ShowRPDetailsForm , FAlse);
  mnuShowExcelPrice := NewMenuForTransGrid('Show Excel Price ' , DoShowExcelPrice, False);

  NewMenuForTrans('Product Prices' , ProductPricesClick , True, 'This will open the Product Prices for the product of the selected line in the grid below');
  NewMenuForTrans('Sales Allocation Details' , SalesAllocationDetailsClick , False, 'This will open the Product Prices for the product of the selected line in the grid below');
  NewMenuForTrans('Pre-Payments' , doShowPrepayments , False, 'This will open the List of Prepayments Creates for '+ Salebase.XMLNodename +' # ' + inttostr(Salebase.ID));

end;
procedure TBaseSaleGUI.ProductPricesClick(Sender:TObject);
begin
  if accesslevel = 1 then Salebase.PostDb;
  if Salebase.count =0 then exit;
  if accesslevel = 1 then Salebase.Lines.PostDb;
  if Salebase.Lines.Count =0 then exit;
  setcontrolfocus(grdtransactions);
  if  not(Iscolvisible(tbldetailsLinePrice.FieldName)) and not(Iscolvisible(tbldetailsLinePriceinc.FieldName)) then begin
        grdTransactions.AddField(tbldetailsLinePrice.FieldName);
        guiprefs.DbGridElement[grdTransactions].UnHideField(tbldetailsLinePrice.FieldName);
  end;
       if  (Iscolvisible(tbldetailsLinePrice.FieldName))    then grdtransactions.SetActiveField(tbldetailsLinePrice.FieldName)
  else if  (Iscolvisible(tbldetailsLinePriceinc.FieldName)) then grdtransactions.SetActiveField(tbldetailsLinePriceinc.FieldName)
  else exit;
  grdTransactionsDblClick(grdTransactions);
end;


procedure TBaseSaleGUI.CheckshiptoAccess;
begin
  if not(Appenv.CompanyPrefs.CanEditSalesshiptoAddress) then
    if not(txtShipTo.Readonly) then txtShipTo.Readonly := true;
end;

procedure TBaseSaleGUI.RepairList;
begin
  OpenERPListForm('TSalesRepairListGUI' , BeforeOpenRepairList);
end;

procedure TBaseSaleGUI.Repairs1Click(Sender: TObject);
begin
  inherited;
  RepairList;
end;

{$IFDEF FORM_BASED_SELECT_SQL}
function TBaseSaleGUI.RepairSalesSQL: String;
begin

REsult:='{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO'+
          '~|||~{Details} SELECT    '+
          ' e.WorkPhone,CONCAT_WS(" ", c.Title, c.FirstName,c.LastName) as CompanyContact, '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.UnitofMeasureSaleLines)                     as UnitofMeasure,  '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.UnitofMeasureShipped)                       as UnitofMeasureShipped,      '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.UnitofMeasureBackorder)                     as UnitofMeasureBackorder,      '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.TotalLineAmount/SL.UnitofMeasureShipped)    as UnitofMeasureLinePrice,          '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.TotalLineAmountInc/SL.UnitofMeasureShipped) as UnitofMeasureLinePriceInc,              '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), "*" , SL.ProductName)                                as ProductName,              '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.Shipped)                                    as Shipped,              '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.BackOrder)                                  as BackOrder,              '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.Product_Description)                        as Product_Description,          '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.LinePrice)                                  as LinePrice,              '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.LineTax)                                    as LineTax,              '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.TotalLineAmountInc)                         as TotalLineAmountInc,             '+
          ' IF ((SL.IsRelatedProduct = "T" AND RP.HideRelated = "T") OR (P.HideOnPrint = "T"), NULL, SL.Shipped)                                    as QtySold, '+
          ' (Price1+(Price1*LineTaxRate))     as OrgLinePriceInc, '+
          ' (100-DisCountPercent)             as RebatePercent ,       '+
          Firstcolumn('P')  + '               AS PartHeader,          '+
          Secondcolumn('P') + '               AS PartSubLevel1,            '+
          Thirdcolumn('P')  + '               AS PartSubLevel2,   '+
          ' if(S.Paid="T","YES","NO")         as Paid2,              '+
          ' SUBSTRING_INDEX( c.Company,"^",1) as Company_NoJobName,       '+
          ' P.Price1                          as "ListPrice(Ex)",              '+
          ' P.PRODUCTCODE,'+
          ' P.ProductComment,'+
          ' P.SupplierProductCode as SuppProdCode,'+
          ' pp.partpic, '+
          ClientnameandAddress('C') + '  AS "No Company Name", '+
          ' c.Company               as Company, '+
          ' c.ABN                   as ABN, '+
          ' c.Title                 as Title, '+
          ' c.FirstName             as FirstName,      '+
          ' c.MiddleName            as MiddleName, '+
          ' c.LastName              as LastName, '+
          ' c.Position              as Position,      '+
          ' c.Street                as CustStreet,  '+
          ' c.Street2               as CustStreet2,  '+
          ' c.Street3               as CustStreet3,      '+
          ' c.Suburb                as CustSuburb,  '+
          ' c.State                 as CustState,  '+
          ' c.Country               as CustCountry,      '+
          ' c.Postcode              as CustPostcode,  '+
          ' c.BillStreet            as BillStreet, '+
          ' c.BillStreet2           as BillStreet2,      '+
          ' c.BillSuburb            as BillSuburb, '+
          ' c.BillState             as BillState, '+
          ' c.BillCountry           as BillCountry,        '+
          ' c.BillPostcode          as BillPostcode,  '+
          ' c.POBox                 as POBox,  '+
          ' c.POSuburb              as POSuburb,  '+
          ' c.POState               as POState,      '+
          ' c.POCountry             as POCountry, '+
          ' c.POPostcode            as POPostcode, '+
          ' c.Phone                 as Phone,        '+
          ' c.FaxNumber             as FaxNumber, '+
          ' c.Mobile                as Mobile,  '+
          ' c.Email                 as Email, '+
          ' c.AltContact            as AltContact,      '+
          ' c.AltPhone              as AltPhone,  '+
          ' c.PhoneSupportTill      as PhoneSupportTill, '+
          ' c.Contact1              as Contact1,      '+
          ' c.Contact2              as Contact2, '+
          ' c.Contact1Phone         as Contact1Phone, '+
          ' c.Contact2Phone         as Contact2Phone,      '+
          ' c.CreationDate          as CreationDate,  '+
          ' c.UpdateDate            as UpdateDate, '+
          ' c.DateInactive          as DateInactive,      '+
          ' c.Notes                 as Notes, '+
          ' c.ClientNo              as ClientNo,  '+
          ' c.JobName               as JobName,  '+
          ' c.CUSTFLD1              as CustomerCustfld1, '+
          ' c.CUSTFLD2              as CustomerCustfld2, '+
          ' c.CUSTFLD3              as CustomerCustfld3, '+
          ' c.CUSTFLD4              as CustomerCustfld4, '+
          ' c.CUSTFLD5              as CustomerCustfld5, '+
          ' c.CUSTFLD6              as CustomerCustfld6, '+
          ' c.CUSTFLD7              as CustomerCustfld7, '+
          ' c.CUSTFLD8              as CustomerCustfld8, '+
          ' c.CUSTFLD9              as CustomerCustfld9, '+
          ' c.CUSTFLD10             as CustomerCustfld10,'+
          ' c.CUSTFLD11             as CustomerCustfld11,'+
          ' c.CUSTFLD12             as CustomerCustfld12,'+
          ' c.CUSTFLD13             as CustomerCustfld13,'+
          ' c.CUSTFLD14             as CustomerCustfld14,'+
          ' c.CUSTFLD15             as CustomerCustfld15,'+
          ' C.CUSTDATE1             as CustomerCUSTDATE1,'+
          ' C.CUSTDATE2             as CustomerCUSTDATE2,'+
          ' C.CUSTDATE3             as CustomerCUSTDATE3,'+
          ' c.DeliveryNotes         as DeliveryNotes,  '+
          ' C.Manufacture ,'+
          ' C.JobRegistration , '+
          ' C.Colour , '+
          ' C.BodyType , '+
          ' C.SerialNumber , '+
          ' C.InsuranceCompanyName , '+
          ' C.JobNumber , '+
          ' C.ExcessAmount, '+
          ' C.CustomerJobNumber , '+
          ' C.Jobname , C.ModelNumber,'+
          ' IF(c.IsJob = "T",IF(C2.StopCredit="T","Yes","No"),IF(c.StopCredit="T","Yes","No"))  AS StopCredit ,'+
          ' S.* ,   '+
          ' SL.*,'+
          ' (Select Sum(PP.Balance) TotalBalance '+
                ' from tblSalesPrepayments  SP '+
                ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  '+
                ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref or SP.SalesRef = S.salesorderglobalref) as Prepayments,  '+
          ' (Select Sum(PP.Balance) TotalBalance '+
                ' from tblSalesPrepayments  SP '+
                ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  '+
                ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref or SP.SalesRef = S.salesorderglobalref) +S.payment as Totalpayment, '+
          ' S.totalamountinc - (Select Sum(PP.Balance) TotalBalance '+
                ' from tblSalesPrepayments  SP '+
                ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  '+
                ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref or SP.SalesRef = S.salesorderglobalref) -payment as Invoicebalance, '+
          ' SL.orglineprice+ SL.orglineprice* SL.linetaxrate as  orglinepriceinc ,'+
          ' SL.OrgLinePrice*SL.Shipped TotalOrgLinePrice , '+
          ' (SL.OrgLinePrice*SL.Shipped) + (SL.OrgLinePrice*SL.Shipped * SL.LineTaxRate) TotalOrgLinePriceINC  , '+
          ' SL.QtySold* SL.ForeignCurrencyLinePrice as EstForeingPrice, '+
          ' SL.ForeignExchangeSellRate * SL.LineCost as FXCost  , '+
          ' SL.OrgLinePrice * SL.Shipped TotalOrglinePrice,'+
          ' SL.OrgLinePrice * SL.Shipped+ SL.OrgLinePrice * SL.Shipped * SL.LineTaxRate as TotalOrglinePriceInc,'+
          ' SL.OrgLinePrice * SL.QtySold as TotalOrgEstlinePrice,'+
          ' SL.OrgLinePrice * SL.QtySold+ SL.OrgLinePrice * SL.QtySold * SL.LineTaxRate as TotalOrgEstlinePriceInc  , '+
          ' (SL.shipped*SL.ForeignCurrencyLinePrice) as TotalForeignCurrencyLinePrice, '+
          ' (Totaltax-TotalWETTax ) as TotalTaxExWET        ,'+
          ' FESL.Field1 as FormulaValue1, '+
          ' FESL.Field2 as FormulaValue2, '+
          ' FESL.Field3 as FormulaValue3, '+
          ' FESL.Field4 as FormulaValue4, '+
          ' FESL.Field5 as FormulaValue5,'+
          ' (Select FormulaEntryName from tblfenames where FormulaEntryId = 1) Formulaname1,'+
          ' (Select FormulaEntryName from tblfenames where FormulaEntryId = 2) Formulaname2,'+
          ' (Select FormulaEntryName from tblfenames where FormulaEntryId = 3) Formulaname3,'+
          ' (Select FormulaEntryName from tblfenames where FormulaEntryId = 4) Formulaname4,'+
          ' (Select FormulaEntryName from tblfenames where FormulaEntryId = 5) Formulaname5 ,'+
          ' SL.backorder*SL.LinePrice Bakorderamount,   '+
          ' (SL.TotalLineAmountInc*1.50) as LineCalc,'+
          ' (SL.TotalLineAmountInc*0.50) as TotalSavings,'+
          ' ct.contactemail     as ContEmail, '+
          ' ct.contacttitle     as ContTitle, '+
          ' ct.contactfirstname as ContFirstName, '+
          ' ct.contactsurname   as ContSurname,'+
          ' ct.contactaddress   as ContAddress, '+
          ' ct.contactaddress2  as ContAddress2, '+
          ' ct.contactaddress3  as ContAddress3, '+
          ' ct.contactcity      as ContCity,'+
          ' ct.contactstate     as ContState, '+
          ' ct.contactpcode     as ContPostcode, '+
          ' ct.contactcountry   as ContCountry, '+
          ' ct.contactph        as ContPh, '+
          ' ct.contactaltph     as ContAltPh,'+
          ' ct.contactmob       as ContMob, '+
          ' ct.contactfax       as ContactFax   '+
          ' FROM '+
          ' tblSales S'+
          ' INNER JOIN tblSalesLines SL Using(SaleID)'+
          ' Left join (tblfesaleslines FESL inner join tblfesaleslinesrelatedprs  FESLR on FESLR.FESalesLineID = FESL.FESalesLineID) on FESL.SaleLineID = SL.SaleLineID and FESLR.ProductID = SL.productId'+
          ' INNER JOIN tblparts P on SL.ProductID=P.PartsID'+
          ' INNER JOIN tblclients c on S.ClientID = c.ClientID'+
          ' LEFT JOIN tblClients as C2 on c.ParentClientID = C2.ClientID'+
          ' Left join tblpartspics pp on ifnull(pp.Isdefault, "") = "T" and pp.partID = SL.ProductID'+
          ' LEFT JOIN tblrelatedparts AS RP on (SL.ProductID=RP.ProductID AND SL.RelatedParentProductID=RP.ParentID)'+
          ' LEFT JOIN tblcontacts AS ct on (S.ContactID=ct.ContactID)'+
          ' Left join tblemployees e on e.EmployeeID = S.EmployeeID'+
          ' WHERE S.SaleID = SL.SaleID'+
          ' AND (P.HideOnPrint = "F"  and   (SL.IsRelatedProduct = "F" or ( SL.IsRelatedProduct = "T" and RP.HideRelated  = "F"))) AND S.SaleID = ' + inttostr(SaleBase.ID) +' order by SL.sortID' +
          '~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,  Sum(TTCL.`TaxAmount`) TaxAmount '+
          'from tblsalestaxcodelines TTCL '+
          'inner join tblsalestaxcodes TTC on TTCL.SalesTaxCodeID = TTC.ID'+
          ' where TTC.SaleID =  ' + inttostr(SaleBase.ID) +' group by TTCL.`SubTaxCode`'+
          '~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value '+
          'from  tblsales Trans  '+
          'inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID '+
          'inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId '+
          ' where ifnull(CCV.Value,"")<>""  and CFL.ListType = "ltCustomer"'+
          ' and Trans.SaleID =  ' + inttostr(SaleBase.ID) +' '+
          TransSpecificSQL +
          '~|||~{InvoiceFooter} Select Invoice_Footer from vinvoicefooterpref '+
          '~|||~'+RepairsReportSQL(TRepairs.IDGlobalRefToggle(TSales(salebase).repairGlobalref) , 0 , False);
end;
{$ENDIF}

function TBaseSaleGUI.ReplaceColumnNo(const ColumnNo: Integer; const ReplacmentStr, LineString: string): string;
var
  TotalField, TotalStrLength, CurrentStrLength, Count, I: Integer;
  CreationStr, TempStrValue: string;

  function FieldCounter(const TestString: string): Integer;
  var
    TempStr: string;
    s, Count, I: Integer;
  begin
    TempStr := TestString;
    Count := 1;

    for I := 1 to 200 do begin
      s := FastFuncs.PosEx(#44, TempStr);
      if s > 0 then begin
        Delete(TempStr, s, char_length(#44));
        Count := Count + 1;
      end else begin
        Break;
      end;
    end;
    Result := Count
  end;

begin
  CurrentStrLength := 0;
  TotalStrLength := char_length(LineString);
  TotalField := FieldCounter(LineString);
  for I := 1 to TotalField do begin
    Count := I;
    TempStrValue := Trim(ExtractStrPortion(LineString, #9, I));

    if not(ColumnNo = Count) then begin
      CreationStr := CreationStr + #9 + TempStrValue;
      CurrentStrLength := CurrentStrLength + char_length(#9 + TempStrValue);
    end else begin
      TotalStrLength := TotalStrLength - (char_length(TempStrValue) - char_length(ReplacmentStr));
      CreationStr := CreationStr + #9 + ReplacmentStr;
      CurrentStrLength := CurrentStrLength + char_length(ReplacmentStr);
    end;

    if CurrentStrLength = TotalStrLength then begin
      Break;
    end;
  end;

  CreationStr := FastFuncs.RightStr(CreationStr, (char_length(CreationStr) - 1));
  Result := CreationStr;
end;

procedure TBaseSaleGUI.FormDestroy(Sender: TObject);
begin
  if aExcelObj <> nil then freeandnil(aExcelObj);
  Freeandnil(CustomfieldonGrid);
  Freeandnil(fMsgHandler);
  tblDetails.Close;
  tblMaster.Close;
  MyConnection.Close;
  Freeandnil(ClientDiscountObj);

  if Assigned(fFxObj) then Freeandnil(fFxObj);

  inherited;
end;

(*procedure TBaseSaleGUI.AutoResetPricesOncustomerchange(const Sender: TBusObj; var Abort: Boolean);
begin
  TSalesLine(Sender).CalculateLine;
end;*)
Procedure TBaseSaleGUI.InitTermsduedate;
begin
    if Salebase.termsname <> '' then begin
      If Not  AppEnv.CompanyPrefs.UseShippedDateForTerms Then Salebase.Terms.Duedate(Salebase.SaleDate , Salebase)
      else Salebase.Terms.Duedate(Salebase.ShipDate, Salebase);
    end else SaleBase.DueDate := Date;

end;
procedure TBaseSaleGUI.cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  if modified then begin
    cboTermsQry.Locate('Terms', cboTerms.Text, [loCaseInsensitive]);
    InitTermsduedate;
  end;
end;

procedure TBaseSaleGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if (Accesslevel =1) and (cboClass.ReadOnly) then
      TransTimerMsg('You don''t have rights to ''Change Department''');
  if not modified then Exit;
  inherited;
  FillTable.FieldByName('ClassID').AsInteger := LookupTable.FieldByName('ClassID').AsInteger;
end;

procedure TBaseSaleGUI.cboTaxCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  CheckEditMode(FillTable);
  FillTable.FieldByName('LineTaxRate').AsFloat := LookupTable.FieldByName('Rate').AsFloat;
end;

procedure TBaseSaleGUI.cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  FillTable.FieldByName('AccountID').AsInteger := LookupTable.FieldByName('AccountID').AsInteger;
end;

procedure TBaseSaleGUI.tblDetailsShippedChange(Sender: TField);
begin
  if fbSkipShippedChanged then Exit;
  inherited;

end;

procedure TBaseSaleGUI.actPickUpdate(Sender: TObject);
begin
  inherited;
  actPick.Enabled := (tblDetails.RecordCount > 0);
end;

procedure TBaseSaleGUI.actcheckdiscountExecute(Sender: TObject);
begin
  inherited;
  ShowPriceCalc;
end;

procedure TBaseSaleGUI.actcheckdiscountUpdate(Sender: TObject);
begin
  inherited;
  actcheckdiscount.Enabled := (SaleBase.customerid <> 0) and (SaleBase.Lines.Count > 0) and (SaleBase.Lines.ProductID > 0) and (SaleBase.Lines.UnitOfMeasureID <> 0) and (SaleBase.Lines.QtySold <> 0);

end;

procedure TBaseSaleGUI.actconsmartExecute(Sender: TObject);
var
  SOID:Integer;
begin
  fbPOshown := False;
  try
      if not SaveSalesRecord then Exit;

      if not IsOkToCopyToSMart then exit;

      if not ConfirmForPOcost then exit;

      lblProcessMessage.Visible := true;
      try
        SaleBase.Connection.CommitTransaction;
        SaleBase.LineIdToconvert (SelectedLineIds);
        try
          if Salebase is TInvoice then SOID:= TInvoice(SaleBase).CopyInvoiceToSmartOrder
          else if Salebase is TSalesorder then SOID:= TSalesorder(SaleBase).CopySalesOrderToSmartOrder
          else if Salebase is TQuote then SOID:= TQuote(SaleBase).CopyQuoteToSmartOrder
          else Exit;
        finally
          SaleBase.CleanLineIdsToconvert;
        end;
      finally
          lblProcessMessage.Visible := False;
      end;
      Application.ProcessMessages;
      if SOID <> 0 then begin
        NewAuditTrialentry('Smart Order Created');
        Self.close;
      end else begin
          SaleBase.Connection.BeginTransaction;
      end;
  finally
      fbPOshown := False;
  end;
end;

procedure TBaseSaleGUI.actconsmartUpdate(Sender: TObject);
begin
  inherited;
  actConSmart.Enabled := (tblDetails.RecordCount > 0) and (AccessLevel < 3) and (KeyID <> 0);
  if salebase.POCreated then actConSmart.Caption := 'SM/O Created' else actConSmart.caption := 'Copy To Smart';
end;

procedure TBaseSaleGUI.actCreateJobExecute(Sender: TObject);
begin
  inherited;
  if (AccessLevel >= 4) then begin
    MessageDlgXP_Vista('You don''t have enough Access to create the Job', mtWarning, [mbOK], 0);
    exit;
  end else if (SaleBase.customerid = 0) then begin
    MessageDlgXP_Vista('Please Select a customer', mtWarning, [mbOK], 0);
    exit;
  end else if (SaleBase.Customer.ISjob = true) then begin
    MessageDlgXP_Vista(Salebase.CustomerName + 'is a job.', mtWarning, [mbOK], 0);
    exit;
  end;
  Createjob;
end;

procedure TBaseSaleGUI.actCreateJobUpdate(Sender: TObject);
begin
  inherited;
  actCreateJob.Enabled := TRue;
end;
function TBaseSaleGUI.DeliverydocketTemplateForSale:String;
begin
  result := tcdatautils.DeliverydocketTemplateForSale(SaleBase.Id);
  if chkChooseRpt.Checked then begin
        LoadReportTypes(TemplateTypeID('Delivery Docket'));
        if result <> '' then dlgReportSelect.DefaultValue := result;
        if dlgReportSelect.Execute then
        Result := dlgReportSelect.SelectedItems.Text;
  end;
end;
procedure TBaseSaleGUI.actDelDocketExecute(Sender: TObject);
(*var
  ReportToPrint: string;
begin
  ReportToPrint := '';
  if chkChooseRpt.checked then begin
    with TempMyQuery do
      try
        Sql.Add(Format('SELECT TemplName FROM tblTemplates WHERE ifnull(Active, "F")  = "T" and TypeID = %d', [29]));
        Open;
        dlgReportSelect.Items.Clear;
        if not IsEmpty then begin
          First;
          while not Eof do begin
            dlgReportSelect.Items.Add(FieldByName('TemplName').AsString);
            Next;
          end;
        end;
      finally ClosenFree;
      end;
    if dlgReportSelect.Execute then ReportToPrint := dlgReportSelect.SelectedItems.Text;
  end;*)
begin
  PrintDeliverydocket(SaleBase.ID, SaleBase.clientID,
                      SaleBase.BackOrderGlobalRef, Self,
                      Appenv.Employee.ShowPreview,
                      DeliverydocketTemplateForSale
                      (*TemplateToPrint('Delivery Docket', chkChooseRpt.checked)*));
end;

procedure TBaseSaleGUI.actDelDocketUpdate(Sender: TObject);
begin
  { Recordcoutn si causing E_FAIL status error , checking the active status
    and empty status before doing a recordcount. }
  inherited;
  if tblDetails.Active = False then actDelDocket.Enabled := False
  else if tblDetails.IsEmpty then actDelDocket.Enabled := False
  else actDelDocket.Enabled := (tblDetails.RecordCount > 0);
end;

procedure TBaseSaleGUI.actManifestListExecute(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TManifestListGUI' , initManifestList);
end;
procedure TBaseSaleGUI.initManifestList(Sender:TObject);
begin
  if not(Sender is TManifestListGUI) then exit;
  TManifestListGUI(Sender).SaleId := salebase.Id;
end;
procedure TBaseSaleGUI.actManifestListUpdate(Sender: TObject);
begin
  inherited;
  actManifestList.Visible :=  Salebase.ismanifest;
end;

procedure TBaseSaleGUI.actPrevExecute(Sender: TObject);
var
  qry: TERPQuery;
begin
  inherited;

  qry := DbSharedObj.GetQuery(MyConnection);
  try
    qry.SQL.Add('select SaleID from tblSales');
    qry.SQL.Add('where SaleID < ' + IntToStr(SaleBase.ID));
    qry.SQL.Add('and Deleted = "F"');
    if SaleBase is TQuote then
      qry.SQL.Add('and IsQuote = "T"')
    else if SaleBase is TSalesOrder then
      qry.SQL.Add('and IsSalesOrder = "T"')
    else if SaleBase is TInvoice then
      qry.SQL.Add('and IsInvoice = "T"')
    else
      exit;
    qry.SQL.Add('order by SaleID DESC');
    qry.SQL.Add('limit 1');
    qry.Open;
    if not qry.IsEmpty then begin
      { there is a sale with a higher ID }
      if SaleBase.Dirty then begin
        case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
          mrYes:
            begin
              if SaveSalesRecord then begin
                CommitAndNotify;
              end;
            end;
          mrNo:
            begin
              // Cancel edits and Rollback changes
              RollbackTransaction;
            end;
          mrCancel:
            begin
              Exit;
            end;
        end;
      end;
      NewTransBusObjRecord(qry.FieldByName('SaleId').AsInteger);
      hideProgressbar;
    end
    else begin
      { no more sales so create a new one }

    end;

  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TBaseSaleGUI.actNextExecute(Sender: TObject);
var
  qry: TERPQuery;
begin
  inherited;

  qry := DbSharedObj.GetQuery(MyConnection);
  try
    qry.SQL.Add('select SaleID from tblSales');
    qry.SQL.Add('where SaleID > ' + IntToStr(SaleBase.ID));
    qry.SQL.Add('and Deleted = "F"');
    if SaleBase is TQuote then
      qry.SQL.Add('and IsQuote = "T"')
    else if SaleBase is TSalesOrder then
      qry.SQL.Add('and IsSalesOrder = "T"')
    else if SaleBase is TInvoice then
      qry.SQL.Add('and IsInvoice = "T"')
    else
      exit;
    qry.SQL.Add('order by SaleID ASC');
    qry.SQL.Add('limit 1');
    qry.Open;
    if not qry.IsEmpty then begin
      { there is a sale with a higher ID }
      if SaleBase.Dirty then begin
        case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
          mrYes:
            begin
              if SaveSalesRecord then begin
                CommitAndNotify;
              end;
            end;
          mrNo:
            begin
              // Cancel edits and Rollback changes
              RollbackTransaction;
            end;
          mrCancel:
            begin
              Exit;
            end;
        end;
      end;
      NewTransBusObjRecord(qry.FieldByName('SaleId').AsInteger);
      hideProgressbar;
    end
    else begin
      { no more sales so create a new one }
      btnNext.Click;
    end;

  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TBaseSaleGUI.mnuDiscountDollarClick(Sender: TObject);
begin
  inherited;
  FirstFieldChanged := nil;
end;

procedure TBaseSaleGUI.mnuDiscountPercClick(Sender: TObject);
begin
  inherited;
  FirstFieldChanged := nil;
end;

procedure TBaseSaleGUI.mnuMarkupDollarClick(Sender: TObject);
begin
  inherited;
  FirstFieldChanged := nil;
end;

procedure TBaseSaleGUI.mnuMarkupPercClick(Sender: TObject);
begin
  inherited;
  FirstFieldChanged := nil;
end;

procedure TBaseSaleGUI.mnuProductNotesClick(Sender: TObject);
begin
  inherited;
  OpenProductNotes;
end;

procedure TBaseSaleGUI.mnuSaleCustomFieldsClick(Sender: TObject);
begin
  inherited;
  if OpenERPFormModal('TfmCustomfieldList', 0, BeforeShowSaleCustomFieldList) >= 0  then begin

  end;
end;

procedure TBaseSaleGUI.tblDetailsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //lblDisableCalc.visible := TransBase.Lines.count >appenv.CompanyPrefs.OrderLinesToDisableCalcs;
end;

procedure TBaseSaleGUI.tblDetailsAfterScroll(DataSet: TDataSet);
begin
  inherited;
  OrgLinePrice := 0.0;
end;

procedure TBaseSaleGUI.SetProductcustomFields;
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

  if AppEnv.CompanyPrefs.PQADEtailsCUSTFLD1 <> '' then
    tblDetailsDetailsCust1Total.DisplayLabel := AppEnv.CompanyPrefs.PQADEtailsCUSTFLD1;
end;

procedure TBaseSaleGUI.FormCreate(Sender: TObject);
var
  mnu: TMenuItem;
begin
  fbOnClientchange  := False;
  aExcelObj := nil;
  fbAutoshipmentafterformshow := False;
  fbshipmentafterformshow := False;
  fSalessummary:= nil;
  fbPOshown := False;
  fbAutoSplitQty:= false;
  fbCalcQtyForAre:= False;
  DefaultValueForAreaFromHint(Appenv.CompanyPrefs.SalesDefaultValueForAreaFrom);
  fbAdd_SpecialPrice:=False;
  fbdontAdd_SpecialPrice:=False;
  pnlParentclient.Visible := Appenv.CompanyPrefs.ShowRelatedMasterinSales;
  lblParentclient.Caption := Appenv.CompanyPrefs.RelatedMasterCaptionInSales;

  if not(Appenv.CompanyPrefs.ShowRelatedMasterinSales) then begin
    bvelCustomerDetails.Top := bvelCustomerDetails.Top - pnlParentclient.Height;
    bvelCustomerDetails.Height := bvelCustomerDetails.Height + pnlParentclient.Height;
    txtClientDetails.Top := txtClientDetails.Top - pnlParentclient.Height;
    txtClientDetails.Height := txtClientDetails.Height + pnlParentclient.Height;
    lblClientDetails.Top := lblClientDetails.Top - pnlParentclient.Height;
  end;

  mnuTransactionSequence.Visible := true;
  fLockSalesInitialized := False;
  barCodeCreated := False;
  Newbarcode := '';
  fMsgHandler := TMsgHandler.Create(Self);
  lblEstimatedFinalAmt.Caption := FloatToStrF(0, ffCurrency, 15, CurrencyRoundPlaces);
  fSalesShippingDetailForm := nil;
  fbBarcodeSearch := False;

  lblMargin.Caption := '';
  lblCost.Caption := '';


  // Register to accept the custom formats that Outlook supplies.
  // We've also included dtfCustom in AcceptTextFormats at design time.
  with DMTextTargetSales, CustomFormats do begin
    OverrideDropEffects[deMove] := deCopy;
    Add('FileGroupDescriptor');
    AddObject('FileContents', TObject(TYMED_ISTREAM));
  end;

  fStoredEvent := tblMasterTotalQuoteAmount.OnChange;
  tblMasterTotalQuoteAmount.OnChange := tblMasterTotalQuoteAmountChange;

  inherited;
  tblDetailsPackWeightField2.Displaylabel :=  Appenv.CompanyPrefs.PackWeightField2  ;
  tblDetailsPackWeightField1.Displaylabel :=  Appenv.CompanyPrefs.PackWeightField1  ;
  tblDetailsPackcount.Displaylabel :=  'Pack Count' ;

  Setlength(BusObjqueries, 2);
  BusObjqueries[0] := 'tblMaster';
  BusObjqueries[1] := 'tblDetails';

  ClientDiscountObj := TClientDiscountObj.Create;
  bCreditCheckOn := False;
  // should be set (if reuqired) in the descendant OnShow, prior to inherited
  fbUpdateNow := False;
  bUpdateRelatedInProgress := False;
  fbDontCopyFilter := False;
  fbDontRefreshCalcs := False;
  fbSkipInherit := False;
  ProductIDFromList := 0;
  bConvetingFromAppointment := False;
  fbSkipShippedChanged := False;
  fbSkipCalcs := False;
  fbSilentMode := False;
  bDoCalcFields := true;
  LastCurrencyCode := Appenv.RegionalOptions.ForeignExDefault;
  DiscountDollarTotal.Caption := ReplaceStr(DiscountDollarTotal.Caption, '$', Appenv.RegionalOptions.CurrencySymbol);

  if AllowCustomiseGrid then begin
    GuiPrefs.AddFieldPair('ProfitOnLanded', 'ProfitOnLandedInc', tblDetails);
    GuiPrefs.AddFieldPair('ProfitOnLandedPercent', 'ProfitOnLandedPercentInc', tblDetails);
  end;


  SetProductcustomFields;

  if (Salebase is TSalesOrder) or (Salebase is TInvoice) then begin
    mnu := TMenuItem.Create(self);
    mnu.Caption := 'Shipment Rate Quote';
    mnu.OnClick := DoGeneralMenuItemClick;
    pnlHeader.Popupmenu.Items.Add(mnu);
  end;
end;

procedure TBaseSaleGUI.grdTransactionsColEnter(Sender: TObject);
var
  Field: TField;
  AFieldName: string;
begin
  inherited;
  Field := grdTransactions.GetActiveField;
  AFieldName := Field.FieldName;

  if sameText(AFieldName,tblDetailsLinePriceInc.FieldName)       or sameText(AFieldName,tblDetailsLinePrice.FieldName) or
     sameText(AFieldName,tblDetailsTotalLineamountInc.FieldName) or sameText(AFieldName,tblDetailsTotalLineamount.FieldName) then begin
    PriceChange := true;
    CheckForSalesTaxBasedon( (fISSalesLineLocked) or (fSalesLocked) );
  end else if sameText(AFieldName,tblDetailsDiscountedPriceInc.FieldName)      or sameText(AFieldName,tblDetailsDiscountedPrice.FieldName) or
              sameText(AFieldName,tblDetailsTotalDiscountedPriceInc.FieldName) or sameText(AFieldName,tblDetailsTotalDiscountedPrice.FieldName) then begin
    PriceChange := true;
  end else begin
    PriceChange := False;
  end;

  if sameText(AFieldName,tblDetailsUnitofMeasureSaleLines.FieldName) then LastComboAccessed := cboUnitOfMeasure;

end;

function TBaseSaleGUI.IsCustomerOK(const iClientID: Integer; const bVerbose: Boolean = true): Boolean;
begin
  Result := true;
end;

procedure TBaseSaleGUI.editFieldChange(Sender: TObject);
// processing of the shipping address is continued here when the child form
// .. returns the shipping address to the TEdit control, editField.
// The shipping address edit box is populated with the new shipping address.
var
  sText: string;
  I: Integer;
begin
  inherited;
  if not Empty(editField.Text) then begin
    EditNoAbort(tblMaster);
    txtShipTo.Lines.Clear;
    sText := '';
    for I := 1 to char_length(editField.Text) do begin
      if editField.Text[I] = #13 then begin
        EditNoAbort(tblMaster);
        txtShipTo.Lines.Append(sText);
        sText := '';
      end else begin
        sText := sText + editField.Text[I];
      end;
    end;
    if not Empty(sText) then begin
      EditNoAbort(tblMaster);
      txtShipTo.Lines.Append(sText);
    end;
    txtShipTo.SelStart := 0; // scroll up
    txtShipTo.SelLength := 0;
    editField.Clear;
  end;
end;

procedure TBaseSaleGUI.edtContributionAmountDblClick(Sender: TObject);
begin
  inherited;
  if not IsclientRelated(SaleBase.clientID) then begin
    if MessageDlgXP_Vista('Do you wish to Select the Parent Customer for "' + SaleBase.Customername + '"?', mtconfirmation, [mbyes, mbno], 0) = mrYes then AddRelatedclient;
  end else begin
    if MessageDlgXP_Vista('Do you Wish to Open the Contributor''s Record of ' + SaleBase.Customername + '?', mtconfirmation, [mbyes, mbno], 0) = mrYes then
        OpenERPForm('TfrmCustomer', ClientParentID(SaleBase.clientID));
  end;
end;

procedure TBaseSaleGUI.edtMemoLineDblClick(Sender: TObject);
begin
  inherited;
  DoDBMemoDialog(tblDetailsMemoLine.AsString, tblDetailsMemoLine.DisplayLabel, tblDetailsMemoLine);
end;

procedure TBaseSaleGUI.txtCustomIDDblClick(Sender: TObject);
begin
  OpenTransactionSequence;
  inherited;
end;

procedure TBaseSaleGUI.txtShipToDblClick(Sender: TObject);
begin
  inherited;
  if AccessLevel >= 5 then Exit;
  if (iClientID > 0) then begin
    editField.Clear;
    with TShipAddressListGUI.Create(Application) do begin
      grdMain.OnDblClick := grdMainonDblClick;
      CustomerID := iClientID;

      FormStyle := fsMDIChild; // Shows the form in MDIChild mode.
      // the shipping address is returned to this form and processing is continued
      // ..via the onchange event of the invisible editField TEdit control
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('Choose A Customer Before Assigning An Address !', mtWarning, [mbOK], 0);
  end;
end;

procedure TBaseSaleGUI.InitTotals;
begin
  lblOrdered.Caption := '0.0';
  lblShipped.Caption := '0.0';
  lblWeight.Caption := '0.0';
  lblEarlyPaymentDiscountAmount.Caption := Appenv.RegionalOptions.CurrencySymbol + '0.00';
end;

function TBaseSaleGUI.IsOkToSaveSale: Boolean;
begin
  Result := true;

end;

procedure TBaseSaleGUI.EnableDisable;
begin
  inherited;
  EnableStatusCombo;
end;

procedure TBaseSaleGUI.EnableDisableTranFunctions;
begin
  inherited;
  chkHoldSale.Enabled := (Appenv.AccessLevels.GetEmployeeAccessLevel('FnChangeHoldSale') in [1, 2]);
end;

procedure TBaseSaleGUI.EnableStatusCombo;
begin
  // when access level is readobly all wwlookupcombos, grids and dnmspeed buttons are made disabled in the baseinput form.
  // but sales forms (Quote /invoice/salesorder) should be able to change its status , so leave them enabled
  cboCurrentTransStatus.Enabled := (txtComments.Enabled) and (fbRecEditable);
end;

procedure TBaseSaleGUI.grdTransactionsRowChanged(Sender: TObject);
begin
  inherited;
  RefreshUnitsQry;
  fLockSalesInitialized:= False;
  try
    If (tblDetails.Recordcount<>0) then
      if Assigned(screen.ActiveControl) and (screen.ActiveControl.Parent = pnlDetail) then
        Locksales;
      SkipReadonlyfield;
  Except

  end;
end;

procedure TBaseSaleGUI.tblDetailsUnitofMeasureQtySoldChange(Sender: TField);
begin

  try
    if not(tblDetails.ControlsDisabled) then begin
      if grdTransactions.ColumnByName('UnitofMeasureBackorder') <> nil then grdTransactions.SetActiveField('UnitofMeasureBackorder');
      if grdTransactions.ColumnByName('UnitofMeasureQtySold') <> nil then grdTransactions.SetActiveField('UnitofMeasureQtySold');
    end;
  except
    // kill the exception
  end;
  inherited;

end;

procedure TBaseSaleGUI.cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  Salebase.Lines.PostDb;
end;

procedure TBaseSaleGUI.IsOK_to_Print(var IsOk: Boolean);
begin
  inherited;
end;

procedure TBaseSaleGUI.cboClientLookupCalcFields(DataSet: TDataSet);
begin
  inherited;
  if cboClientLookupStopCredits.AsString = 'T' then cboClientLookupStopCreditImage.AsInteger := 2
  else cboClientLookupStopCreditImage.AsInteger := 3
end;

procedure TBaseSaleGUI.actPrintExecute(Sender: TObject);
begin
  inherited;
  try
    if (Self.ClassName = 'TInvoiceGUI') and Appenv.CompanyPrefs.PrintDelDocketWithInvoice then begin
      actDelDocketExecute(nil);
    end;
    if (Self.ClassName = 'TInvoiceGUI') and (Appenv.CompanyPrefs.PrintPickSlipWithInvoice) then
      if Appenv.CompanyPrefs.PrintPickSlipWithInvoice then begin
        PrintSalesPickingSlip;
      end;
  finally
    lblPrintedBy.Caption := DocPrintedBy;
    lblPrintedOn.Caption := TransBase.Printedon;
    lblPrintedAt.Caption := TransBase.PrintedAt;
    DontCloseAfterPrint := False;
  end;
end;
procedure TBaseSaleGUI.actSignatureExecute(Sender: TObject);
begin
  if frmSignatureEdit.GetClientSignature(self.tblMasterClientSignature, self.tblMasterSignatureTime) then
    SetDirty(true);
end;
procedure TBaseSaleGUI.actSignatureUpdate(Sender: TObject);
begin
  inherited;
  if self.tblMasterClientSignature.BlobSize > 0 then
    btnSignature.Color := $0077ff77
  else
    btnSignature.Color := clBtnFace;
end;

procedure TBaseSaleGUI.AutoShippingRun;
begin
  inherited;
  if FullBackOrder then begin
    Self.SaleBase.Lines.IterateRecords(AutoShipQtyCallback);
  end;
end;

procedure TBaseSaleGUI.AutoShipQtyCallback(const Sender: TBusObj; var Abort: Boolean);
var
  dAvailableQty: Double;
  fbDoFieldChangewhenDisabled: Boolean;
begin
  fbDoFieldChangewhenDisabled := TSalesLine(Sender).DoFieldChangewhenDisabled;
  TSalesLine(Sender).DoFieldChangewhenDisabled := true;
  try
    if IsInvProduct(TSalesLine(Sender).Product.ProductType) then begin
      dAvailableQty := TProductClass.AvailableQty(TSalesLine(Sender).ProductID, TSales(Sender.Owner).SaleClassId) + TSalesLine(Sender).CleanQtyShipped;
    end
    else dAvailableQty := TSalesLine(Sender).QtySold;
    if dAvailableQty >= TSalesLine(Sender).QtySold then TSalesLine(Sender).QtyShipped := TSalesLine(Sender).QtySold
    else if dAvailableQty < 0 then TSalesLine(Sender).QtyShipped := 0
    else TSalesLine(Sender).QtyShipped := dAvailableQty;
    TSalesLine(Sender).PostDB;
  finally TSalesLine(Sender).DoFieldChangewhenDisabled := fbDoFieldChangewhenDisabled
  end;
end;

procedure TBaseSaleGUI.grdMainonDblClick(Sender: TObject);
begin
  with TwwDbGrid(Sender).Datasource.DataSet do begin
    SaleBase.ShipToID := FieldByName('ShipAddressID').AsInteger;
    SaleBase.PostDB;
  end;
  if Assigned(TwwDbGrid(Sender).Owner) then
    if TwwDbGrid(Sender).Owner is TForm then begin
      SetFocusedControl(txtShipTo);
      TForm(TwwDbGrid(Sender).Owner).Close;
    end;
end;

procedure TBaseSaleGUI.SetMatrixDetails(sMatrixDesc: string; sMatrixRef: string; dMatrixPrice: Double);
begin
  SaleBase.Lines.MatrixDesc := sMatrixDesc;
  SaleBase.Lines.MatrixRef := sMatrixRef;
  SaleBase.Lines.MatrixPrice := dMatrixPrice;
  if SaleBase.Lines.MatrixPrice <> 0 then begin
    SaleBase.Lines.ignoreCheckSaveSpecialPrice := true;
    try
      SaleBase.Lines.LinePrice := SaleBase.Lines.MatrixPrice;
      SaleBase.Lines.CallDoFieldOnChange(tblDetailsLinePrice);
    finally SaleBase.Lines.ignoreCheckSaveSpecialPrice := False;
    end;
  end;
  SaleBase.Lines.PostDB;
end;

procedure TBaseSaleGUI.grdTransactionsDblClick(Sender: TObject);
var
  sMatrixDesc: string;
  sMatrixRef: string;
  dMatrixPrice: Double;
begin

  if (TField(grdTransactions.GetActiveField).FieldName = 'MatrixDesc') or (TField(grdTransactions.GetActiveField).FieldName = 'MatrixPrice') then begin
    sMatrixDesc := SaleBase.Lines.MatrixDesc;
    sMatrixRef := SaleBase.Lines.MatrixRef;
    dMatrixPrice := SaleBase.Lines.MatrixPrice;
    TfmpartsPriceMatrixInput.PriceMAtrix(Self, sMatrixRef, sMatrixDesc, dMatrixPrice, SaleBase.Lines.ProductID, MyConnection);
    SetMatrixDetails(sMatrixDesc, sMatrixRef, dMatrixPrice);
    Abort; // this is to cancel the memodialag popup for this field
  end  else if (SameText(TField(grdTransactions.GetActiveField).FieldName, 'LinePrice')) or (SameText(TField(grdTransactions.GetActiveField).FieldName, 'LinePriceinc')) then begin
    ShowPriceCalc;
  end  else if (SameText(ActiveFieldname, 'Memoline')) then begin
    DoDBMemoDialog(tblDetailsMemoLine.AsString, tblDetailsMemoLine.DisplayLabel, tblDetailsMemoLine);
  end  else if (SameText(ActiveFieldname, tbldetailsLatestCostPrice.fieldname)) or (SameText(ActiveFieldname, tbldetailsLatestCostPriceinc.fieldname)) then begin
      TransTimerMsg(Appenv.CompanyPrefs.SalesLineLatestCostBasedOnMsg, 5);
  end else if (SameText(ActiveField(Sender).fieldname, 'UnitofMeasureQtySold')) then begin
    DoPackWeight
  end;
  inherited;
end;

procedure TBaseSaleGUI.ShowPriceCalc;
function BOMPrice:Double;
begin
  result := SaleBase.Lines.BOMPrice;
end;
begin
  TfmproductPrices.showProduct(SaleBase.Lines.ProductID,
                               SaleBase.customerid,
                               SaleBase.TermsName,
                               SaleBase.Lines.UnitOfMeasureID,
                               SaleBase.Lines.QtySold,
                               SaleBase.Lines.LineTaxRate,
                               SaleBase.Lines.MatrixRef ,
                               SaleBase.Lines.MarginAmount ,
                               SaleBase.Lines.Marginpercent, '' , BOMPrice);
end;

procedure TBaseSaleGUI.UpdateAfterMemTrans;
var
  BkMark: TBookMark;
begin
  inherited;
  // Updates prices
  BkMark := tblDetails.GetBookmark;
  tblDetails.DisableControls;
  try
    tblDetails.First;
    while not tblDetails.Eof do begin
      grdTransactions.SetActiveField('UnitofMeasureQtySold');
      tblDetails.Edit;
      tblDetailsUnitofMeasureQtySoldChange(tblDetailsUnitofMeasureQtySold);
      tblDetails.Next;
    end;
  finally
    tblDetails.Enablecontrols;
    tblDetails.GotoBookmark(BkMark);
    tblDetails.FreeBookmark(BkMark);
  end;

end;

procedure TBaseSaleGUI.grdTransactionsFieldChanged(Sender: TObject; Field: TField);
begin
  inherited;
  if not Assigned(Field) then Exit;

end;

procedure TBaseSaleGUI.grdTransactionsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((SameText(ActiveFieldname, 'MatrixDesc')) or (SameText(ActiveFieldname, 'MatrixPrice'))) and (Key <> vk_return) and (Key <> vk_tab) then begin
    Key := 0;
    Exit;
  end;
  inherited;

end;

procedure TBaseSaleGUI.grdTransactionsKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = vk_f9)  then begin
    mnuAlternateProduct.click;
    Exit;
  end;
  inherited;
end;

procedure TBaseSaleGUI.grdTransactionsMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if selecting then begin

    if (tbldetailsQtySold.AsFloat =0)  then begin
      TransTimerMsg(SaleBase.lines.Productname +' has no Qty to Order' , 5);
      accept := False;
      Exit;
    end;
    if (SaleBase is TSalesOrder) and  (SaleBase.lines.isTreeItem) then begin
      TransTimerMsg( SaleBase.lines.Productname +' Is a BOM Line.' , 5);
      accept := False;
      Exit;
    end;
    if SaleBase.lines.ProductType = 'OTHER' then begin
      TransTimerMsg( SaleBase.lines.Productname +' Is of Type OTHER.' , 5);
      accept := False;
      Exit;
    end;
  end;
end;

function TBaseSaleGUI.GetOrAddMobileNumber: string;
var
  aContact: TContact;
  aCustomer : TCustomer;
begin
  result := SaleBase.ContactMobile;
  if result = '' then
    result := SaleBase.Customer.Mobile;
  if result = '' then begin
    if SaleBase.ContactID > 0 then begin
      { contact mobile }
      result := GetMobileNumberFromUser('Contact (' + SaleBase.ContactName +
        ') does not have a mobile number.' +#13#10 + 'Please enter a number.');
      if result <> '' then begin
        aContact := TContact.Create(nil);
        try
          aContact.Connection := TMyDacDataConnection.Create(aContact);
          aContact.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
          aContact.Load(SaleBase.ContactID);
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
      result := GetMobileNumberFromUser('Customer (' + SaleBase.CustomerName +
        ') does not have a mobile number.' + #13#10 + 'Please enter a number.');
      if result <> '' then begin
        aCustomer := TCustomer.Create(nil);
        try
          aCustomer.Connection := TMyDacDataConnection.Create(aCustomer);
          aCustomer.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
          aCustomer.Load(SaleBase.CustomerID);
          if aCustomer.Lock then begin  { only update if we can lock }
            try
              aCustomer.Mobile := result;
              aCustomer.PostDb;
              SaleBase.Customer.RefreshDB;
            finally
              aCustomer.UnLock;
            end;
          end;
        finally
          aCustomer.Free;
        end;
      end;
    end;
  end
  else begin
    if (not SMSUtils.NumberHasPlusPrefix(result)) or (not SMSUtils.NumberHasCountryCode(result,MyConnection)) then begin
      if SaleBase.ContactID > 0 then begin
        { contact mobile }
        result := GetMobileNumberFromUser('Contact (' + SaleBase.ContactName +
          ') number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.', result, MyConnection);
        if result <> '' then begin
          aContact := TContact.Create(nil);
          try
            aContact.Connection := TMyDacDataConnection.Create(aContact);
            aContact.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
            aContact.Load(SaleBase.ContactID);
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
        result := GetMobileNumberFromUser('Customer (' + SaleBase.CustomerName +
          ') number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.', result, MyConnection);
        if result <> '' then begin
          aCustomer := TCustomer.Create(nil);
          try
            aCustomer.Connection := TMyDacDataConnection.Create(aCustomer);
            aCustomer.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
            aCustomer.Load(SaleBase.CustomerID);
            if aCustomer.Lock then begin  { only update if we can lock }
              try
                aCustomer.Mobile := result;
                aCustomer.PostDb;
                SaleBase.Customer.RefreshDB;
              finally
                aCustomer.UnLock;
              end;
            end;
          finally
            aCustomer.Free;
          end;
        end;
      end;
    end;
  end;
end;

function TBaseSaleGUI.GetProductInStockValue(const ID: Integer): Integer;
begin
  Result := 0;

end;

function TBaseSaleGUI.GetSalesCCAddresses(aEmployeeId: integer): string;
var
  lStr : string;
begin
  if aEmployeeId > 0 then
    Result := GetEmployeeEmail(aEmployeeId)
  else
    Result := '';
    lStr := GetSalesEmails;
    if lStr <> '' then
    begin
      if Result <> '' then
      begin
        if pos(Result, lstr) > 0 then
          Result := lStr
        else
          Result := Result + ',' + lStr;
      end
      else
        Result := lStr;
    end;
end;

procedure TBaseSaleGUI.grdTransactionsCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  try
    inherited;
    if Field = nil then Exit;
  except
  end;
end;

procedure TBaseSaleGUI.grdTransactionsCalcTitleAttributes(Sender: TObject; const AFieldName: string; const AFont: TFont; const ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;
  if SameText(AFieldName, 'DiscountPercent') or SameText(AFieldName, 'Discounts') or
      SameText(AFieldName, 'MarkupPercent') or SameText(AFieldName, 'Markup') or
      SameText(AFieldName, 'MarginPercent') or SameText(AFieldName, 'Margin')  then begin
    ABrush.Color := clBtnFace;
  end;

  if Appenv.CompanyPrefs.ShowLatestCost then begin
    if (AFieldName = 'LatestCostPrice') or (AFieldName = 'LatestCostPriceInc') then begin
      ABrush.Color := GRIDBUTTONWHITE;
    end;
  end;
end;

procedure TBaseSaleGUI.btnPrepaymentClick(Sender: TObject);
var
  s:String;
begin
  inherited;
    s:= '';

    if SaleBase.Dirty then
      s:='Prepayments Can be Created only for Saved ' + SaleBase.XMLNodename + '.' + #13 + #10 + 'Do you Wish to Save this ' + SaleBase.XMLNodename +
      ' and Create a Prepayment Against it?'
    else s:= 'Do you Wish to Create a Prepayment Against this ' + SeparateWords(SaleBase.XMLNodename)+'?';

//  if SaleBase.cleanId = 0 then begin
    if MessageDlgXP_Vista(s , mtconfirmation, [mbyes, mbno], 0) = mrNo then Exit;
    { this is to make sure the sales record is saved so that the prePayment can eb libnked to it }

    SaleBase.OverrideHoldSale := True;
    if not(SaveSalesRecord) then Exit;
    Salebase.HoldSale := False;
    Salebase.PostDb;
    Salebase.Dirty:= False;
    SaleBase.connection.CommitTransaction;
    SaleBase.Dirty:= False;
    SaleBase.connection.BeginTransaction;
//  end;
  Openrecord(0 , 'TfmCustPrepayments');
  Self.closewait;

end;
procedure TBaseSaleGUI.beforeSubFormShow(Sender: TObject);
begin
  inherited;
end;
procedure TBaseSaleGUI.AfterSubFormShow(Sender:TObject);
begin
  inherited AfterSubFormShow(Sender);
  StateParams.I['KeyID']:= Salebase.ID;
  if (Sender is TfmCustPrepayments) then  begin
    TfmCustPrepayments(Sender).AttachObserver(Self);
    if (TfmCustPrepayments(Sender).KeyId = 0) and (TfmCustPrepayments(Sender).AccessLevel < 5) then begin
      if Self.tblMaster.FieldByName('ClientID').AsInteger <> 0 then begin
        TfmCustPrepayments(Sender).CustPrePayment.ClientID:= Self.tblMaster.FieldByName('ClientID').AsInteger;
        TfmCustPrepayments(Sender).cboClientCloseUp(TfmCustPrepayments(Sender).cboClient, TfmCustPrepayments(Sender).cboClient.LookupTable,
          TfmCustPrepayments(Sender).cboClient.Datasource.DataSet, true);
        TfmCustPrepayments(Sender).LinkToSaleRef := SaleBase.Globalref;
        TfmCustPrepayments(Sender).LinkToSaleOriginalRef := SaleBase.OriginalDocNumber;
        TfmCustPrepayments(Sender).CustPrePayment.ForeignExchangeCode := saleBase.ForeignExchangeCode;
        TfmCustPrepayments(Sender).CustPrePayment.ClassID := salebase.SaleClassId;

        if SaleBase.IsSalesOrder then begin
          TfmCustPrepayments(Sender).LinkToSaletype := 'S';
          TfmCustPrepayments(Sender).salesBalance :=SaleBase.totalbalance;
        end else if SaleBase.IsInvoice then begin
          TfmCustPrepayments(Sender).LinkToSaletype := 'I';
          TfmCustPrepayments(Sender).salesBalance :=SaleBase.totalbalance;
        end else if SaleBase.IsQuote then begin
          TfmCustPrepayments(Sender).LinkToSaletype := 'Q';
        end;
        TfmCustPrepayments(Sender).CustPrePayment.ClientID := Self.tblMaster.FieldByName('ClientID').AsInteger;
        TfmCustPrepayments(Sender).cboClient.lookuptable.locate('clientId',TfmCustPrepayments(Sender).CustPrePayment.ClientID , []);
      end;
    end;
  end;
end;


function TBaseSaleGUI.DeleteLinerecord: Boolean;
begin
  Result := Inherited;
  if Result then
  begin
    fCurrentSeqNo := 1;
  end;
end;

function TBaseSaleGUI.DisfieldstoRemove: String;
Procedure addresult (const value:String);
begin
  if value = '' then exit;
  if result <> '' then result := result +',';
  REsult := result + value;
end;
begin
  Result := '';
  if not Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'Discount'        ) then addResult('Discount');
  if not Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'DiscountPercent' ) then addResult('DiscountPercent');
  if not Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'MarkupPercent'   ) then addResult('MarkupPercent');
  if not Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'Markup'          ) then addResult('Markup');
end;

procedure TBaseSaleGUI.DisableLineZeroQtyWarning(Sender: TObject; Checked: boolean);
begin
  AppEnv.CompanyPrefs.DisableSaleLineZeroQuantityWarning := Checked;
end;

procedure TBaseSaleGUI.DiscountDollarTotalClick(Sender: TObject);
var
  DiscountAmount, ADiscPrice : Double;
  TempDiscountPercent: Double;
  Msg:String;
  aPrice :Double;
begin
  inherited;
  if AccessLevel <> 1 then begin
    MessageDlgXP_Vista('You Don''t have Access to Change This Record', mtWarning, [mbOK], 0);
    Exit;
  end;

  { close up blank line }
  if (tblDetails.State = dsInsert) and (Self.tblDetailsProductID.AsInteger < 1) then tblDetails.Cancel;

  if ProductExist(TOTALDISCOUNT_PRODUCT) then begin
    DiscountAmount := CustomInputFloat('Total Sale Discount', 'Enter Discount Amount (' + Appenv.RegionalOptions.CurrencySymbol + ') ?');
    if DiscountAmount = 0 then Exit;
      aPrice := SaleBase.TotalAmountInc ;
      if not TSalesDiscountValidationObj.ValidateDiscount(Self, DiscountAmount , TempDiscountPercent , SaleBase.TotalCost , aPrice, ADiscPrice ,1 , 0 , False, False, Msg) then begin
        CommonLib.MessageDlgXP_Vista(Msg, mtWarning, [mbOK], 0);
        Exit;
      end;

    Application.ProcessMessages;
    unlockSalesLine(false);
    if not tblDetails.Locate('ProductName', TOTALDISCOUNT_PRODUCT, [loCaseInsensitive]) then SaleBase.Lines.New;
    SaleBase.Lines.ProductName := TOTALDISCOUNT_PRODUCT;
    cboProductR.Text := TOTALDISCOUNT_PRODUCT;
    DoOnProductchange;
    SaleBase.Lines.QtySold := -1;
    SaleBase.Lines.QtyShipped := -1;
    SaleBase.Lines.LinePriceInc := DiscountAmount;
    Application.ProcessMessages;
  end else begin
    CommonLib.MessageDlgXP_Vista('Missing Total Sale Discount Product !', mtWarning, [mbOK], 0);
  end;
end;

procedure TBaseSaleGUI.DiscountPercentTotalClick(Sender: TObject);
var
  DiscountAmount , DiscountPercent ,ADiscPrice, aPrice: Double;
  Msg:String;
begin
  inherited;
  { close up blank line }
  if (tblDetails.FieldByName('productid').AsInteger < 1) and (tblDetails.State = dsInsert) then tblDetails.Cancel;
  if ProductExist(TOTALDISCOUNT_PRODUCT) then begin
    DiscountPercent := CustomInputFloat('Total Sale Discount', 'Enter Discount Amount (%)?');
    aPrice := SaleBase.TotalAmountInc ;
    if not TSalesDiscountValidationObj.ValidateDiscount(Self, DiscountAmount , DiscountPercent , SaleBase.TotalCost , aPrice , ADiscPrice ,1 , 0 , False, False, Msg) then begin
        CommonLib.MessageDlgXP_Vista(Msg, mtWarning, [mbOK], 0);
        Exit;
    end;

    // Recalculates the totals Before Percentage Discount
    Application.ProcessMessages;
    if not tblDetails.Locate('ProductName', TOTALDISCOUNT_PRODUCT, [loCaseInsensitive]) then begin
      SaleBase.Lines.New;
    end else begin
      tblDetails.Edit;
    end;
    SaleBase.Lines.ProductName := TOTALDISCOUNT_PRODUCT;
    SaleBase.Lines.SaleID := SaleBase.ID;
    cboProductR.Text := TOTALDISCOUNT_PRODUCT;
    SaleBase.Lines.QtySold := -1;
    SaleBase.Lines.QtyShipped := -1;
    SaleBase.SendEvent(BusObjEvent_Change, BusObjEventVal_QtyShipped, SaleBase.Lines);
    // Get Charges Cost
    SaleBase.Lines.LinePriceInc := Round(SaleBase.TotalAmountInc * (DiscountPercent / 100), SaleBase.RoundPlacesGeneral);
    // Recalculates the totals
    SaleBase.Lines.PostDB;
    Application.ProcessMessages;
    SaleBase.Lines.PostDB;
  end else begin
    CommonLib.MessageDlgXP_Vista('Missing Total Sale Discount Product !', mtWarning, [mbOK], 0);
  end;
end;

procedure TBaseSaleGUI.cboClientDblClick(Sender: TObject);
begin
  inherited;;
end;

procedure TBaseSaleGUI.tblMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cboTermsQry.Close;
  cboTermsQry.Open;
  SaleBase.SalesLinePackWeightSum;
  InitRefBtn;
end;
procedure TBaseSaleGUI.Refreshexternalxref;
begin
  Closedb(qryexternalxref);
  qryexternalxref.parambyname('ERPID').asInteger := Salebase.id;
  Opendb(qryexternalxref);
end;
//procedure TBaseSaleGUI.AddProductOptionsProduct(const OldProductId, newProductID:Integer);
//begin
//  inherited;
//  if OldProductId =0 then Exit;
//  if NewProductId =0  then Exit;
//
//  if SaleBase.Lines.ProductID = OldProductId then SaleBase.Lines.Deleted := true
//  else if SaleBase.Lines.Locate('ProductId', OldProductId, []) then SaleBase.Lines.Deleted := true;
//  SaleBase.Lines.PostDb;
//
//  if newProductID <> -1 then begin
//    SaleBase.Lines.New;
//    SaleBase.Lines.ProductID := newProductID;
//    SaleBase.Lines.Qtysold := 1;
//    SaleBase.Lines.PostDB;
//  end;
//end;

procedure TBaseSaleGUI.tblMasterCalcFields(DataSet: TDataSet);
var
  dt: TDateTime;
begin
  inherited;
  if not (Dataset.State in [dsEdit,dsCalcFields]) then exit;

  if Appenv.CompanyPrefs.EnablequoteVariation then begin
    if SaleBase is TQuote then begin
      if TQuote(SaleBase).relatedSales.Count > 0 then tblMasterApprovedAmount.AsFloat := TQuote(SaleBase).relatedSales.ApprovedAmount
      else tblMasterApprovedAmount.AsFloat := SaleBase.TotalAmountInc;
    end else begin
      if SaleBase.QuoteSale.relatedSales.Count = 0 then tblMasterApprovedAmount.AsFloat := SaleBase.QuoteSale.TotalAmountInc
      else tblMasterApprovedAmount.AsFloat := SaleBase.QuoteSale.relatedSales.ApprovedAmount;
    end;
  end;
  try
    if tblMasterEnteredAt.AsString <> '' then begin
      dt := StringToTime(tblMasterEnteredAt.AsString); //StrToTime(tblMasterEnteredAt.AsString);
      tblMasterEnteredAtShort.AsString := FormatDateTime(FormatSettings.ShortTimeFormat,dt);
    end
    else begin
      tblMasterEnteredAtShort.AsString := tblMasterEnteredAt.AsString;
    end;
  except
    tblMasterEnteredAtShort.AsString := tblMasterEnteredAt.AsString;
    exit;
  end;

  if not (Dataset.State in [dsEdit,dsCalcFields]) then EditDb(Dataset);
  if (Dataset.State in [dsEdit,dsCalcFields]) then begin
    if (KeyId > 0)  and (qrySalesSeqnoSeqNo.asInteger >0) then
        DataSet.FieldByName('SaleNum_Seq').AsString  := Trim(DataSet.FieldByName('OriginalSaleId').AsString) + '-' + inttostr(qrySalesSeqnoSeqNo.asInteger)
    else DataSet.FieldByName('SaleNum_Seq').AsString  := '';
  end;

end;

procedure TBaseSaleGUI.tblMasterInvoiceDocNumberSetText(Sender: TField;
  const Text: string);
begin
  inherited;
  if CanChangeSaleNumber then begin
    Sender.AsString:= Text;
  end
  else begin
    MessageDlgXP_Vista('Your do not have rights to change ' + SeparateWords(SaleBase.ObjectUserName) + ' Number.',mtInformation,[mbOk],0);
  end;
end;

procedure TBaseSaleGUI.mnuDiscountTotalPopup(Sender: TObject);
begin
  inherited;

  GlobalEvents.Notify(Sender, GEVENT_OnMenuPopup, SaleBase);
end;
procedure TBaseSaleGUI.MakeAllBO(const Sender: TBusObj; var Abort: Boolean);
var
  fb:Boolean;
begin
  if IsSalesLineLocked then exit;
  if tbldetailsunitofmeasureshipped.readonly then exit;

  fb := salebase.lines.DoFieldChangewhenDisabled;
  salebase.lines.DoFieldChangewhenDisabled := True;
  try
    salebase.lines.QtyBackOrder := salebase.lines.QtySold;
    salebase.lines.QtyShipped := 0;
    salebase.lines.PostDB;
  finally
    salebase.lines.DoFieldChangewhenDisabled := fb;
  end;
end;

procedure TBaseSaleGUI.grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  inherited grdTransactionsTitleButtonClick(Sender, AFieldName);
  if (Sametext(AFieldName,'Discounts')) or (Sametext(AFieldName,'Markup')) or (*(Sametext(AFieldName,'Margin')) or*)
      (Sametext(AFieldName,'DiscountPercent')) or (Sametext(AFieldName,'MarkupPercent')) (*or (Sametext(AFieldName,'MarginPercent'))*) then begin
    popDscntMrkup.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
    Invalidate;
  end else if (Sametext(AFieldName,'Margin')) then begin
    ChangeCurfield('MarginPercent');
  end else if (Sametext(AFieldName,'MarginPercent')) then begin
    ChangeCurfield('Margin');
  end else if (AFieldName = tblDetailsUnitofMeasureBackorder.FieldName ) then begin
    if SaleBase.Lines.QtyBackOrder <> 0 then checkforStockinOtherDept;
  end else if Sysutils.SameText(AFieldName, 'UnitOfMeasureShipped') then begin
    if (salebase is TInvoice) or (Salebase is TSalesOrder) then
      if (salebase.IsBOInvoiced =False) and (AccessLevel <=3) and (TInvoice(salebase).Totalpaid=0) then
        if MessageDlgXP_Vista ('Do You Wish to Make this a Back Order? ', mtConfirmation, [mbYes, mbNo], 0) = mryes then
          salebase.Lines.iteraterecords(MakeAllBO);
  end else if SameTExt(AFieldName,'OrgProductPrice') then begin
    grdTransactions.RemoveField('OrgProductPrice');
    grdTransactions.AddField('OrgProductPriceInc');
    guiprefs.DbGridElement[grdTransactions].UnHideField('OrgProductPriceInc');
    tblDetailsOrgProductPriceInc.Index := tblDetailsOrgProductPrice.Index;
    grdTransactions.SetActiveField('OrgProductPriceInc');
  end else if SameTExt(AFieldName,'OrgProductPriceInc') then begin
    grdTransactions.RemoveField('OrgProductPriceInc');
    grdTransactions.AddField('OrgProductPrice');
    guiprefs.DbGridElement[grdTransactions].UnHideField('OrgProductPrice');
    tblDetailsOrgProductPrice.Index := tblDetailsOrgProductPriceInc.Index;
    grdTransactions.SetActiveField('OrgProductPrice');
  end else if SameTExt(AFieldName,'ProfitOnLanded') then begin
    grdTransactions.RemoveField('ProfitOnLanded');
    grdTransactions.AddField('ProfitOnLandedInc');
    guiprefs.DbGridElement[grdTransactions].UnHideField('ProfitOnLandedInc');
    tblDetailsProfitOnLandedInc.Index := tblDetailsProfitOnLanded.Index;
    grdTransactions.SetActiveField('ProfitOnLandedInc');
  end else if SameTExt(AFieldName,'ProfitOnLandedInc') then begin
    grdTransactions.RemoveField('ProfitOnLandedInc');
    grdTransactions.AddField('ProfitOnLanded');
    guiprefs.DbGridElement[grdTransactions].UnHideField('ProfitOnLanded');
    tblDetailsProfitOnLanded.Index := tblDetailsProfitOnLandedInc.Index;
    grdTransactions.SetActiveField('ProfitOnLanded');
  end else if SameTExt(AFieldName,'ProfitOnLandedPercent') then begin
    grdTransactions.RemoveField('ProfitOnLandedPercent');
    grdTransactions.AddField('ProfitOnLandedPercentInc');
    guiprefs.DbGridElement[grdTransactions].UnHideField('ProfitOnLandedPercentInc');
    tblDetailsProfitOnLandedPercentInc.Index := tblDetailsProfitOnLandedPercent.Index;
    grdTransactions.SetActiveField('ProfitOnLandedPercentInc');
  end else if SameTExt(AFieldName,'ProfitOnLandedPercentInc') then begin
    grdTransactions.RemoveField('ProfitOnLandedPercentInc');
    grdTransactions.AddField('ProfitOnLandedPercent');
    guiprefs.DbGridElement[grdTransactions].UnHideField('ProfitOnLandedPercent');
    tblDetailsProfitOnLandedPercent.Index := tblDetailsProfitOnLandedPercentInc.Index;
    grdTransactions.SetActiveField('ProfitOnLandedPercent');
  end else begin
    if Appenv.CompanyPrefs.ShowLatestCost then begin
      if AFieldName = 'LatestCostPrice' then begin
        grdTransactions.RemoveField('LatestCostPrice');
        grdTransactions.AddField('LatestCostPriceInc');
        guiprefs.DbGridElement[grdTransactions].UnHideField('LatestCostPriceInc');
        tblDetailsLatestCostPriceInc.Index := tblDetailsLatestCostPrice.Index;
        grdTransactions.ColumnByName('LatestCostPriceInc').DisplayLabel := 'Latest Cost (Inc)';
        grdTransactions.SetActiveField('LatestCostPriceInc');
      end
      else if (AFieldName = 'LatestCostPriceInc') then begin
        grdTransactions.RemoveField('LatestCostPriceInc');
        grdTransactions.AddField('LatestCostPrice');
        guiprefs.DbGridElement[grdTransactions].UnHideField('LatestCostPrice');
        tblDetailsLatestCostPrice.Index := tblDetailsLatestCostPriceInc.Index;
        grdTransactions.ColumnByName('LatestCostPrice').DisplayLabel := 'Latest Cost (Ex)';
        grdTransactions.SetActiveField('LatestCostPrice');
      end;
    end;
  end;
end;

procedure TBaseSaleGUI.cboCostCentreCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;

  GlobalEvents.Notify(Sender, GEVENT_ComboCloseUp);
end;

procedure TBaseSaleGUI.cboProductQryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cboProductQry.IndExFieldNames := QuotedStr('PartName') + ' ASC CIS ; ' + QuotedStr('PartType') + ' ASC CIS';
end;

procedure TBaseSaleGUI.recalcInvoicesamount;
begin

end;

// ---------- File Attachment Stuff --------------------------------------------

function TBaseSaleGUI.ShowRPDetailsForm: Boolean;
var
  fiid:Integer;
  fcEvent:TGeneralconfirm;
begin
  Result := False;
  salebase.lines.PostDb;
  if salebase.lines.count =0 then exit;
  if not salebase.lines.HasRelatedProducts then exit;
  fcEvent := salebase.ConfirmFromGUI;
  salebase.ConfirmFromGUI:= nil;
  try
      if TFmSalesRelatedProducts.ShowSalesRelatedProducts(Salebase, self.color , upodaterelatedProdQty) then begin
        try
          fiid:=salebase.lines.Id;
          try
            salebase.lines.closedb;
            salebase.lines;
            salebase.Lines.CalcLineTotals;
            salebase.CalcOrdertotals;
          finally
            salebase.lines.locate(salebase.lines.IDfieldname, fiID, []);
          end;
        finally
        end;
      end;
  finally
    salebase.ConfirmFromGUI := fcEvent;
  end;
end;
Procedure  TBaseSaleGUI.upodaterelatedProdQty(Sender:TObject);
var
  fiid:Integer;
  fbFlag:Boolean;
begin
  salebase.lines.PostDb;
  if salebase.lines.count =0 then exit;
  fbFlag:= salebase.DisableCalcOrderTotals;
  salebase.DisableCalcOrderTotals := True;
  try
    fiid:=salebase.lines.Id;
    salebase.lines.closedb;
    salebase.lines;
    salebase.lines.locate(salebase.lines.IDfieldname, fiID, []);
    salebase.lines.UpdateRelatedPartsQty;
  finally
    salebase.DisableCalcOrderTotals := fbFlag;
  end;
  salebase.CalcOrdertotals;
end;

procedure TBaseSaleGUI.ShowRPDetailsForm(Sender: TObject);
begin
  ChooseRelatedParts(self.SaleBase.Lines.Product.RelatedProducts);
end;

procedure TBaseSaleGUI.ShowAccountCbo(const Value: Boolean);
begin
  cboAccount.Visible := Value;
  lblAccount.Visible := Value;
end;

procedure TBaseSaleGUI.ShowAttachments(fbDragnDropping :boolean);
var
  tmpComponent: TComponent;
begin
  if tblMasterSaleID.AsInteger < 1 then Exit; // need sales id
  tmpComponent := TfmAttachments(GetComponentByClassName('TfmAttachments', False, self));
  if not Assigned(tmpComponent) then Exit;
  with TfmAttachments(tmpComponent) do begin
    DBConnection := Self.MyConnection;
    AttachObserver(Self);
    TableName := 'tblSales';
    TableId := tblMasterSaleID.AsInteger;
    DragnDropping :=fbDragnDropping;
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TBaseSaleGUI.DMTextTargetSalesDrop(Sender: TObject; Acceptor: TWinControl; const DropText: string; X, Y: Integer);
var
  Form: TComponent;
begin
  inherited;
  if tblMasterSaleID.AsInteger < 1 then Exit; // need sales id

  ShowAttachments(true);
  Form := TfmAttachments(GetComponentByClassName('TfmAttachments', true));
  if Assigned(Form) then // if has acess
      TfmAttachments(Form).DMTextTargetDrop(Sender, Acceptor, DropText, X, Y);
end;

procedure TBaseSaleGUI.btnShiptocontactClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TContactListGUI' ,UpdateFromShipToContact , initcontactList );
end;
procedure TBaseSaleGUI.UpdateFromShipToContact(Sender: TwwDbGrid);
begin
  inherited;
  if AccessLevel > 3 then    exit;
  Transbase.ShiptocontactId := Sender.Datasource.dataset.FieldByName('ContactID').AsInteger;
  Transbase.PostDB;
end;

procedure TBaseSaleGUI.btnAddFreightClick(Sender: TObject);
begin
  inherited;
  self.SaleBase.AddStateFreight;
end;

procedure TBaseSaleGUI.btnAttachmentsClick(Sender: TObject);
begin
  inherited;
  ShowAttachments(False);
end;

procedure TBaseSaleGUI.CheckForAttachments;
var
  qry: TERPQuery;
begin
  if tblMasterSaleID.AsInteger < 1 then begin
    btnAttachments.Enabled := False;
    Exit; // need sales id
  end;

    qry := DbSharedObj.GetQuery(salebase.connection.connection);
    try
      With qry do begin
        closedb(qry);
        qry.Sql.Text := 'SELECT AttachmentName FROM tblAttachments WHERE TableName = "tblSales"' + ' AND TableId = ' + tblMasterSaleID.AsString;
        opendb(qry);
        if RecordCount > 0 then btnAttachments.Color := $0077ff77
        else btnAttachments.Color := clBtnFace;
      end;
    finally
        DbSharedObj.ReleaseObj(qry);
    end;
end;

function TBaseSaleGUI.CheckForfieldsinGridKeyPress(Sender: TObject;  var Key: Char): boolean;
begin
  result := inherited CheckForfieldsinGridKeyPress(Sender, Key);
  if result then exit;
  if ((grdTransactions.GetActiveField = tblDetailsLinecostInc) or (grdTransactions.GetActiveField = tblDetailsLinecost)) and
              (grdtransactions.ColumnByName(grdTransactions.GetActiveField.FieldName).ReadOnly ) and
              (not (Appenv.companyprefs.CostEditableinSales) ) and
              (Key <> TAB)then begin
              MessageDlgXP_VistaWithPrefoption('Based on Preferences, It is not Possible to Edit Sales cost.'+NL+NL+
                                          '(Preferences->Inventory->Stock Cost System->Can Alter Sales Cost)', mtWarning, [mbOK], 0 ,
                                          PrefOptionObj('Inventory','chkCostEditableinSales',AppEnv.AccessLevels.GetEmployeeAccessLevel('TPreferencesGUI') ) );
              Result := True;
  end;

end;

procedure TBaseSaleGUI.CheckForMailAttachments(Corres: TCorrespondenceGui);
var
  Att: TAttachment;
begin
  Att := TAttachment.Create(nil);
  try
    Att.Connection := TMyDacDataConnection.Create(Att);
    Att.Connection.Connection := MyConnection;
    Att.LoadSelect('TableName = "tblSales" and TableId = ' + self.tblMasterSaleID.AsString);
    if Att.Count > 0 then begin
      if CommonLib.MessageDlgXP_Vista('Would you like to send this ' + TransName + '''s attachments with this email?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        while not Att.EOF do begin
          Att.SaveToFile(WinTempDir + Att.AttachmentName);
          Corres.AttachmentList.Add(WinTempDir + Att.AttachmentName);
          Att.Next;
        end;
      end;
    end;
  finally
    Att.Free;
  end;
end;


procedure TBaseSaleGUI.UpdateMe;
begin
  if AccessLevel >= 5 then Exit;
  inherited;
  // somthing has changed on attachments form so update
  CheckForAttachments;
  // Update header to flag that changes have taken place
  EditDb(tblMaster);
  tblMasterLastUpdated.AsDateTime := Now;
  if qryShipContainerSaleLookup.Active then qryShipContainerSaleLookup.Close;
  qryShipContainerSaleLookup.Open;
  grdTransactions.Datasource.DataSet.Refresh;
  if LastComboAccessed <> nil then UpdateMe(False, LastComboAccessed);
end;

procedure TBaseSaleGUI.ConvertAttachments(const OldSaleId, NewSaleId: Integer);
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.Sql.Text := 'SELECT TableId FROM tblAttachments WHERE TableName = "tblSales"' + ' AND TableId = ' + IntToStr(OldSaleId);
    qry.Open;
    while not qry.Eof do begin
      qry.Edit;
      qry.FieldByName('TableId').AsInteger := NewSaleId;
      qry.Post;
      qry.Next;
    end;
    qry.Close;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

// ------------------------------------------------------------------------------

procedure TBaseSaleGUI.AfterCommit;
begin
  // perform any processing here that needs to be executed after data has
  // been committed.

end;

procedure TBaseSaleGUI.AfterFormShow;
begin
  if GuiPrefs.Node.Exists('Options.ShowSummary') and (GuiPrefs.Node['Options.ShowSummary'].asBoolean) then btnShowDetails.click;
end;

procedure TBaseSaleGUI.AfterPopupformshow;
begin
  inherited;
  if assigned(fSalessummary) and (fSalessummary.visible) then begin
    fSalessummary.bringtofront;
    fSalessummary.windowstate := wsnormal;
  end;
end;

function TBaseSaleGUI.FxObj: TForeignExchangeObj;
begin
  if not Assigned(fFxObj) then fFxObj := TForeignExchangeObj.Create;
  Result := fFxObj;
end;

procedure TBaseSaleGUI.cboPartSpecsEnter(Sender: TObject);
begin
  inherited;
  qryPartsSpecs.Close;
  qryPartsSpecs.Params.ParamByName('xPartsID').AsInteger := tblDetailsProductID.AsInteger;
  qryPartsSpecs.Open;
end;

procedure TBaseSaleGUI.tblDetailsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if tblDetails.FieldByName('CreationDate').AsDateTime = 0 then tblDetails.FieldByName('CreationDate').AsDateTime := Date;
end;

procedure TBaseSaleGUI.UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil);
begin
  if Cancelled then Exit;
    (*if Assigned(fLastComboAccessed) then begin
      { this is to keep showing the value when lookup form opened by double clicking on the component }
      closedb(fLastComboAccessed.LookupTable);
      OpenDB(fLastComboAccessed.LookupTable);
      if not fLastComboAccessed.LookupTable.Locate(fLastComboAccessed.LookupField, fLastComboAccessed.Text, []) then
          fLastComboAccessed.Datasource.DataSet.FieldByName(fLastComboAccessed.DataField).Clear;
      if SysUtils.SameText(fLastComboAccessed.Name, 'cboProductR') then grdTransactions.SetActiveField('ProductName')
      else if SysUtils.SameText(fLastComboAccessed.Name, 'cboClient') then SetFocusedControl(fLastComboAccessed);
    end;
    end;*)

    if aObject is TfmCustPrepayments then begin
      recalcInvoicesamount;
    end;
    if (Assigned(aObject) and (aObject.ClassNameIs('TfmShippingAllocation'))) then begin
      if fbAutoshipmentafterformshow then begin
        if Appenv.companyprefs.WALMARTOrderSilentProcessShipment then begin
          SaleBase.SilentMode := True;
          btnClose.Click;
        end;
      end
      else begin
        self.RollbackTransaction;
        SaleBase.RefreshDB;
        self.BeginTransaction;
      end;
    end;
    if Assigned(fLastComboAccessed) then begin
        if Assigned(aObject) and (aObject is TBaseInputGUI)  then begin
          if (fLastComboAccessed is TERPDBLookupCombo) and (not SameText(TERPDBLookupCombo(fLastComboAccessed).EditFormClassName, aObject.ClassName))  then
            exit;
          if SysUtils.SameText(fLastComboAccessed.Name, 'cboClientR') then begin
            SaleBase.customerid := TBaseInputGUI(aObject).KeyId;
          end else if SysUtils.SameText(fLastComboAccessed.Name, 'cbovia') then begin
            with fLastComboAccessed do begin
              closedb(LookupTable);
              OpenDB(LookupTable);
              if LookupTable.Locate('ShippingMethodID', TBaseInputGUI(aObject).KeyId, []) then begin
                if not(fLastComboAccessed.Datasource.DataSet.State in [dsEdit, dsInsert]) then fLastComboAccessed.Datasource.DataSet.Edit;
                fLastComboAccessed.Datasource.DataSet.FieldByName(fLastComboAccessed.datafield).AsString := LookupTable.FieldByName('ShippingMethod').AsString;
                cboViaCloseUp(fLastComboAccessed, LookupTable, fLastComboAccessed.Datasource.DataSet, true);
              end;
            end
          end else if SysUtils.SameText(fLastComboAccessed.Name, 'cboClass') then begin
            with fLastComboAccessed do begin
              closedb(LookupTable);
              OpenDB(LookupTable);
              if LookupTable.Locate('ClassID', TBaseInputGUI(aObject).KeyId, []) then begin
                if not(fLastComboAccessed.Datasource.DataSet.State in [dsEdit, dsInsert]) then fLastComboAccessed.Datasource.DataSet.Edit;
                fLastComboAccessed.Datasource.DataSet.FieldByName('Class').AsString := LookupTable.FieldByName('ClassName').AsString;
                cboClassCloseUp(fLastComboAccessed, LookupTable, fLastComboAccessed.Datasource.DataSet, true);
              end;
            end
          end else if SysUtils.SameText(fLastComboAccessed.Name, 'cboUnitOfMeasure') then begin
            with fLastComboAccessed do begin
              closedb(LookupTable);
              OpenDB(LookupTable);
              if LookupTable.Locate('UnitID', TBaseInputGUI(aObject).KeyId, []) then begin
                if not(fLastComboAccessed.Datasource.DataSet.State in [dsEdit, dsInsert]) then fLastComboAccessed.Datasource.DataSet.Edit;
                fLastComboAccessed.Datasource.DataSet.FieldByName(fLastComboAccessed.DataField).AsString := LookupTable.FieldByName(LookupField).AsString;
              end;
            end
          end else if LastComboAccessed = cboSalesCategory then begin
            closenopendb(LastComboAccessed.LookupTable);
            if LastComboAccessed.LookupTable.Locate('Name', NewTransStatus, []) then begin
              SaleBase.SalesCategory := NewTransStatus;
              SaleBase.PostDB;
            end;
          end;
        end;
    end;
  inherited UpdateMe(cancelled, aObject);
end;

procedure TBaseSaleGUI.cboSalesCategoryDblClick(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_SalesCategory, SaleBase.SalesCategory);
end;

procedure TBaseSaleGUI.cboSalesCategoryNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if not(CanCreateSalesCategory) then begin
    MessageDlgXP_Vista('You are not Allowed to Create New Sales Category', mtInformation, [mbOK], 0);
    Accept := False;
    Exit;
  end;
    LastComboAccessed := cboSalesCategory;
    NewTransStatus     := cboSalesCategory.Text;
    If CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtconfirmation, [mbyes, mbno], 0) = mrYes Then Begin
      TfmSimpleTypes.DoSimpleTypesEdit('SalesCategory', NewValue, Self);
    End;
    Accept := False;
end;

function TBaseSaleGUI.ClientState   :String;begin  REsult:= salebase.Customer.state   ;end;
procedure TBaseSaleGUI.ChooseRelatedParts(Sender: TDatasetBusObj);
begin
  GlobalEvents.Notify(cboProductR, GEVENT_ComboCloseUp, SaleBase);
  inherited;
end;

function TBaseSaleGUI.Clientcountry :String;begin  REsult:= salebase.Customer.country ;end;
function TBaseSaleGUI.clientLocation:String;begin  REsult:= salebase.Customer.suburb  ;end;
function TBaseSaleGUI.ClientPostcode:String;begin  REsult:= salebase.Customer.PostCode;end;

procedure TBaseSaleGUI.CompleteComboNotInList(const aObserver: TObject);
begin
  if Assigned(fLastComboAccessed) and fLastComboAccessed.Enabled and fLastComboAccessed.Visible then SetControlFocus(fLastComboAccessed);
  InComboNotinList := False;
end;

procedure TBaseSaleGUI.SetComboFocus(var Msg: TMessage);
begin
  if Assigned(fLastComboAccessed) and fLastComboAccessed.Enabled and fLastComboAccessed.Visible then SetControlFocus(fLastComboAccessed);
end;

procedure TBaseSaleGUI.SetDatasetconn;
begin
  inherited;
  tblFESalesLines.Connection    := MyConnection;
  tblFESaleslinesRelatedPrs.Connection    := MyConnection;
  tblEquipmentxRefs.Connection := MyConnection;
  QrySalesLinePackWeightLinesSum.Connection := MyConnection;
end;

procedure TBaseSaleGUI.SetDirty(ADirty: boolean);
begin

end;

function TBaseSaleGUI.isDeptValid: Boolean;
begin
  Result := true;
end;

procedure TBaseSaleGUI.cboClientRBeforeOpenList(Sender: TObject);
begin
  inherited;
  if not(Sender is TCustomerExpressListGUI) then Exit;
  with TCustomerExpressListGUI(Sender) do begin
    TCustomerExpressListGUI(Sender).Grpfilters.ItemIndex := 0;
    TCustomerExpressListGUI(Sender).Grpfilters.Visible := False;
  end;
end;

procedure TBaseSaleGUI.cboTermsQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if tblMaster.Active then { shows inActive Terms On Exsiting Sales }
      cboTermsQry.Params.ParamByName('xTerms').AsString := tblMaster.FieldByName('Terms').AsString
  else cboTermsQry.Params.ParamByName('xTerms').AsString := '';
end;

procedure TBaseSaleGUI.grdTransactionsDrawFooterCell(Sender: TObject; Canvas: TCanvas; FooterCellRect: TRect; Field: TField; FooterText: string; var DefaultDrawing: Boolean);
begin
  inherited;
  { update form total labels from business object }

  grdTransactions.ColumnByName('Attrib1Sale').FooterValue := FloatToStrF(SaleBase.TotalAttrib1Sale, ffNumber, 15, 2);
  grdTransactions.ColumnByName('Attrib2Sale').FooterValue := FloatToStrF(SaleBase.TotalAttrib2Sale, ffNumber, 15, 2);
  grdTransactions.ColumnByName('Attrib1SaleEst').FooterValue := FloatToStrF(SaleBase.TotalAttrib1SaleEst, ffNumber, 15, 2);
  grdTransactions.ColumnByName('Attrib2SaleEst').FooterValue := FloatToStrF(SaleBase.TotalAttrib2SaleEst, ffNumber, 15, 2);
  grdTransactions.ColumnByName('Attrib1SaleRate').FooterValue := FloatToStrF(DivZer(SaleBase.TotalAttrib1SaleRate, SaleBase.TotalAttrib1Sale), ffCurrency, 15, CurrencyRoundPlaces);

end;

procedure TBaseSaleGUI.btnDeleteClick(Sender: TObject);
begin
  inherited;
  lblEstimatedFinalAmt.Caption := FloatToStrF(SaleBase.TotalEstimatedAmountInc, ffCurrency, 15, CurrencyRoundPlaces);
end;


procedure TBaseSaleGUI.btninvoicesClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TSaleconvertedToListGUI',BeforeShowSaleconvertedToList,AfterShowSaleconvertedToList);
end;
Procedure TBaseSaleGUI.BeforeShowSaleconvertedToList(Sender: TObject);
begin
  if not(Sender is TSaleconvertedToListGUI) then exit;
  if Salebase is TSaleSOrder then TSaleconvertedToListGUI(Sender).SalesOrderRef := TSaleSOrder(salebase).globalref;
  if Salebase is TQuote      then TSaleconvertedToListGUI(Sender).QuoteRef      := TQuote(salebase).globalref;
end;
procedure TBaseSaleGUI.BeforeShowSaleCustomFieldList(Sender: TObject);
begin
  if not(Sender is TfmCustomfieldList) then Exit;
  TfmCustomfieldList(Sender).ListType := ltSales;
end;

procedure TBaseSaleGUI.AfterShowSaleconvertedToList(Sender: TObject);
begin

end;

procedure TBaseSaleGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Freeandnil(RepairequipmentForm);
  if fsalesSummary<> nil then begin
    fsalesSummary.close;
    Freeandnil(fsalesSummary);
  end;
  inherited;
  { incase if cancelled, dlete all ther eserved qty }
end;

procedure TBaseSaleGUI.cboBaseForeignCurrencyCodeChange(Sender: TObject);
begin
  inherited;
  if not Assigned(Self.SaleBase) then Exit;
  if Self.SaleBase.ForeignExchangeCode <> Appenv.RegionalOptions.ForeignExDefault then begin
    edtBaseForeignTotal.Visible := true;
    lblBaseForeignTotal.Visible := true;
  end else begin
    edtBaseForeignTotal.Visible := False;
    lblBaseForeignTotal.Visible := False;
  end;
end;

procedure TBaseSaleGUI.txtTotalAmountChange(Sender: TObject);
begin
  inherited;
  DisplayTotalAmounts;
end;

procedure TBaseSaleGUI.Ordered(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TSalesLineBase) then Exit;
  TSalesLineBase(Sender).SmartOrderCreated := true;
  TSalesLineBase(Sender).PostDB;
end;

procedure TBaseSaleGUI.RefreshProductQry;
begin
  if cboProductQry.Active then cboProductQry.Close;
  cboProductQry.Open;
end;

procedure TBaseSaleGUI.DoShipments;
var
  form: TBaseInputGUI;
  TNT_Freight: TTNTFreightChargesObj;
  DestPostcode: Integer;
  SavedSilentMode: Boolean;

begin
  if Salebase.isinternalorder then exit;
Disableform;
try
  if AppEnv.CompanyPrefs.UseTNTFreight and SameText(tblMaster.FieldByName('Shipping').AsString, Ship_TNT) then begin

    TNT_Freight := TTNTFreightChargesObj.Create;
    try
      // TNT Tables Vaild
      if TNT_Freight.TNTTablesVaild then begin
        // Add Product Line
        if TNT_Freight.TNTFreightProductExist then begin
          { Change business object to silent mode se we don't get messages when
            the TNT Freight line is added. }
          SavedSilentMode := SaleBase.SilentMode;
          SaleBase.SilentMode := true;
          try
            if not tblDetails.Locate('ProductName', TNT_Freight.TNTFreightProductName, [loCaseInsensitive]) then begin
              SaleBase.Lines.New;
            end;

            SaleBase.Lines.ProductName := TNT_Freight.TNTFreightProductName;
            cboProductR.Text := TNT_Freight.TNTFreightProductName;
            DoOnProductchange;

            SaleBase.Lines.QtySold := 1;
            SaleBase.Lines.QtyShipped := 1;

            ActualMass := SaleBase.TotalAttrib1Sale;
            CubicMetres := SaleBase.TotalAttrib2Sale;

            // Get Charges Cost
            DestPostcode := Trunc(StrValue(txtShipTo.Lines[txtShipTo.Lines.Count - 1]));
            SaleBase.Lines.LinePrice := TNT_Freight.GetChargesEx(DestPostcode, ActualMass, CubicMetres);
          finally SaleBase.SilentMode := SavedSilentMode;
          end;
        end else begin
          CommonLib.MessageDlgXP_Vista('Missing TNT Freight Product !', mtWarning, [mbOK], 0);
        end;
      end else begin
        CommonLib.MessageDlgXP_Vista('TNT Tables Are Invaild' + #13#10#13#10 + 'Import TNT Client Rates or Postcode To Zone Files', mtWarning, [mbOK], 0);
      end;
    finally
      Freeandnil(TNT_Freight);
    end;

  end
  else if (AppEnv.CompanyPrefs.UPSConfig.UPSEnabled or AppEnv.CompanyPrefs.FedExConfig.FedExEnabled or AppEnv.CompanyPrefs.USPSConfig.USPSEnabled) then begin
    if (Salebase is TSalesOrder) and (not Appenv.CompanyPrefs.AllowShipmentsFromSalesOrder) then begin
      if MessageDlgXP_Vista('"Allow Processing Shipments from Sales Order" is not selected in EDI integration Preferences.',mtConfirmation,[mbOk],0, nil,'','',False, nil ,'Open Preference Form' ) = 100 then
        OpenPrefform('EDI and Integration', 'chkAllowShipmentsFromSalesOrder' ,1 ,True, '' , '');
      exit;
    end;

    if (Salebase is TSalesOrder) or (Salebase is TInvoice) then begin
      if (not IssalesLocked) and (not Salebase.converted) then begin
        if not SaveSalesRecord then Exit;
        self.CommitTransaction;
        self.BeginTransaction;
      end;
      form := TBaseInputGUI(GetComponentByClassName('TfmShippingAllocation',false));
      if not Assigned(form) then exit;
      form.KeyID := tblMaster.FieldByName('SaleId').AsInteger;
      form.AttachObserver(self);
      if Self.accesslevel >= 3 then form.Accesslevel := 5;
      form.FormStyle := fsMDIChild;
      form.BringToFront;
      if Appenv.companyprefs.WALMARTOrderSilentProcessShipment and fbAutoshipmentafterformshow then
          form.EnabletmrOnshow(1,1)
      else if Appenv.companyprefs.WALMARTOrderSilentProcessShipment and fbshipmentafterformshow then
          form.EnabletmrOnshow(2,1);
    end;
  end
  else begin
    { open the shipping address list }
    txtShipToDblClick(txtShipTo);
  end;
finally
  Enableform;
end;
end;



procedure TBaseSaleGUI.DisplayTotalAmounts(Totcost: Double = 0);
begin
  if not Assigned(SaleBase) then Exit;
  lblEarlyPaymentDiscountAmount.Caption := FloatToStrF(SaleBase.EarlyPaymentDiscountAmount, ffCurrency, 15, CurrencyRoundPlaces);

  lblCost.Caption := CurrToStrF(SaleBase.TotalCost, ffCurrency, 2);

  if Totcost = 0 then Totcost := SaleBase.TotalCost;
  if (Self.ClassName = 'TQuoteGUI') then begin
    lblMargin.Caption := '%' + FloatToStrF(DivZer(SaleBase.TotalQuoteAmount - Totcost, SaleBase.TotalQuoteAmount) * 100, ffFixed, 6, 2);
  end else begin
    lblMargin.Caption := '%' + FloatToStrF(DivZer(SaleBase.TotalAmountInc - Totcost, SaleBase.TotalAmountInc) * 100, ffFixed, 6, 2);
  end;
end;

procedure TBaseSaleGUI.chkHoldSaleClick(Sender: TObject);
begin
  inherited;
  if not TwwCheckBox(Sender).Datasource.DataSet.Active then Exit;
  SaleBase.OverrideHoldSale := not TwwCheckBox(Sender).checked;
end;


Procedure TBaseSaleGUI.ProductformulaEntry(Sender:TObject);
var
  SalesProductSpec: TfmSalesProductSpec;
begin

  if (not Assigned(SaleBase)) or (SaleBase.Lines.Count = 0) or (SaleBase.Lines.ProductID < 1) then Exit;
  if (SaleBase.Lines.Product.HasFormulaAttached) or (SaleBase.Lines.Product.formulaId <> 0) then begin

    { create spec records internally }
    if SaleBase.Lines.FESalesLines.DataSet.RecordCount = 0 then begin
      SaleBase.Lines.FESalesLines.New;
      SaleBase.Lines.FESalesLines.ProductID := SaleBase.Lines.ProductID;
      SaleBase.Lines.FESalesLines.ProductName := SaleBase.Lines.ProductName;
      SaleBase.Lines.FESalesLines.formulaId :=   SaleBase.Lines.Product.formulaId;
      SaleBase.Lines.FESalesLines.PostDB;
    end;
    dsFESalesLines.DataSet := SaleBase.Lines.FESalesLines.DataSet;
    dsFESaleslinesRelatedPrs.DataSet := SaleBase.Lines.FESalesLines.Lines.DataSet;
    dsFESalesLines.DataSet := SaleBase.Lines.FESalesLines.DataSet;
    dsFESaleslinesRelatedPrs.DataSet := SaleBase.Lines.FESalesLines.Lines.DataSet;
    SalesProductSpec := TfmSalesProductSpec(CommonLib.GetComponentByClassName('TfmSalesProductSpec', true, Self, False, False));
    try
      SalesProductSpec.FETransLines := SaleBase.Lines.FESalesLines;
      SalesProductSpec.grdRelatedPr.Enabled := SaleBase.Lines.Product.HasFormulaAttached;
      if sametext(TField(grdtransactions.GetActiveField).fieldname , tbldetailsUnitofMeasureQtySold.fieldname) or (grdtransactions.GetActiveField.index < tbldetailsUnitofMeasureQtySold.index) then
          SalesProductSpec.grpfilters.itemindex := 0
      else SalesProductSpec.grpfilters.itemindex := 1;

      SalesProductSpec.showModal;

      if SalesProductSpec.ModalResult = mrOK then begin
        { binny : dene asked for a default value 1 when formula products are  added }
        SaleBase.InternalQuantityChange := true;
        try SaleBase.Lines.PostFERecords;
        finally SaleBase.InternalQuantityChange := False;
        end;
      end;
    finally Freeandnil(SalesProductSpec);
    end;

  end;
end;


procedure TBaseSaleGUI.ProductSelectionOptions1Click(Sender: TObject);
begin
  inherited;
  AutoLoadProductOptions(true);
end;

procedure TBaseSaleGUI.ProductSelectionOptions2Click(Sender: TObject);
begin
  inherited;
  AutoLoadProductOptions(true);
end;

procedure TBaseSaleGUI.ProductStockQty1Click(Sender: TObject);
begin
  inherited;
  OpenERPListFormModal('TSalesStockQtyStatusGUI', nil  , BeforeOpenSalesStockQtyStatus);
end;
procedure TBaseSaleGUI.BeforeOpenSalesStockQtyStatus(Sender: TObject);
begin
  if Sender is TSalesStockQtyStatusGUI then begin
    TSalesStockQtyStatusGUI(Sender).SalesBaseObj := Salebase;
  end;
end;
procedure TBaseSaleGUI.qryUnitOfMeasureBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryUnitOfMeasure.ParamByName('xPartID').AsInteger := tblDetails.FieldByName('ProductID').AsInteger;
end;

function TBaseSaleGUI.LineEmpty: Boolean;
begin
  Result := true;
  if Assigned(SaleBase.Lines) then begin
    SaleBase.Lines.PostDB;
    Result := SaleBase.Lines.DataSet.RecordCount = 0;
  end;
end;

procedure TBaseSaleGUI.RefreshUnitsQry;
begin
  qryUnitOfMeasure.Close;
  qryUnitOfMeasure.Open;
end;
procedure TBaseSaleGUI.RecalculateNoOfBoxes;
var
   noofboxes:Double;
begin
  Salebase.Lines.postDB;
  With Salebase.getNewdataset('Select Sum(uom.NoOfBoxes * SL.UnitofMeasureShipped) as noofboxes ' +
                              ' from tblsaleslines SL inner join tblunitsofmeasure uom on SL.UnitOfMeasureID = uom.UnitID ' +
                              '  where ifnull(uom.NoOfBoxes,0) <> 0 and SL.saleId = ' + inttostr(Salebase.ID) , true) do try
    noofboxes:= FieldByname('noofboxes').asFloat;
    if noofboxes <> trunc(noofboxes) then noofboxes := trunc(noofboxes) +1;
    Salebase.noofboxes := trunc(noofboxes);
  finally
    if active then close;
    free;
  end;
end;
procedure TBaseSaleGUI.InitSalesAutoSplitQty(Sender:TObject);
begin
  if not (Sender is TfmSalesAutoSplitQty) then exit;
  TfmSalesAutoSplitQty(Sender).SalesLineobj := Salebase.Lines;
  TfmSalesAutoSplitQty(Sender).TransConnection := Self.Myconnection;
end;
procedure TBaseSaleGUI.ApplyAutoSplitQty(Sender:TObject);
var
  SalesAutoSplitQty :TSalesAutoSplitQty;
  sXML:String;

  Procedure InitSaleLinefromSalesAutoSplitQtyLine;
  begin
          Salebase.Lines.XML := sXML;
          Salebase.Lines.UnitOfMeasureID  := SalesAutoSplitQty.SLLines.UOMID;
          Salebase.Lines.UnitOfMeasure    := SalesAutoSplitQty.SLLines.UOM;
          Salebase.Lines.UOMMultiplier    := SalesAutoSplitQty.SLLines.UOMMultiplier;
          Salebase.Lines.UOMQtySold       := SalesAutoSplitQty.SLLines.Qty;
          if Salebase.Lines.UOMQtyShipped > Salebase.Lines.UOMQtySold then
            Salebase.Lines.UOMQtyShipped := Salebase.Lines.UOMQtySold;
          Salebase.Lines.PostDB;
          SalesAutoSplitQty.SLLines.SaleLineref :=Salebase.Lines.Globalref;
          SalesAutoSplitQty.SLLines.PostDB;
  end;
begin
  if not (Sender is TfmSalesAutoSplitQty) then exit;

  try
    SalesAutoSplitQty := TSalesAutoSplitQty.Create(Self);
    try
      SalesAutoSplitQty.connection := Salebase.Connection;
      SalesAutoSplitQty.LoadSelect('SaleLineref = ' + Quotedstr(Salebase.Lines.Globalref));

      if SalesAutoSplitQty.count =0 then exit;

      {delete all where the qty is not selected}
      SalesAutoSplitQty.SLLines.filter := 'Qty =0';
      SalesAutoSplitQty.SLLines.filtered := TRue;
      SalesAutoSplitQty.SLLines.DeleteAll;

      SalesAutoSplitQty.SLLines.filter := '';
      SalesAutoSplitQty.SLLines.filtered :=False;

      if SalesAutoSplitQty.SLLines.count =0 then exit;

      if pos(' Requested Qty was ' ,  Salebase.Lines.ProductDescription)>0 then
        Salebase.Lines.ProductDescription := copy(Salebase.Lines.ProductDescription,1,pos(' Requested Qty was ' ,  Salebase.Lines.ProductDescription));

      if Salebase.Lines.AreaQty <> 0 then
        Salebase.Lines.ProductDescription := Salebase.Lines.ProductDescription +
                                          ' Requested Qty was to Cover an area of ' + floatToStr(Salebase.Lines.AreaQty )+'  = ' +
                                          floatToStr(SalesAutoSplitQty.Qty)+' ' + SalesAutoSplitQty.UOM +'(' +floattostr(SalesAutoSplitQty.UOMMultiplier)+')'
      else
        Salebase.Lines.ProductDescription := Salebase.Lines.ProductDescription +
                                          ' Requested Qty was ' + floatToStr(SalesAutoSplitQty.Qty)+' ' + SalesAutoSplitQty.UOM +'(' +floattostr(SalesAutoSplitQty.UOMMultiplier)+')';

      sXML:= Salebase.Lines.XML;

      {overwrite the currenct sales line for the first record}
      SalesAutoSplitQty.SLLines.First;
      InitSaleLinefromSalesAutoSplitQtyLine;
      SalesAutoSplitQty.SLLines.NExt;

      {add new for the following records}
      while SalesAutoSplitQty.SLLines.Eof = False do begin
        try
          Salebase.Lines.New;
          InitSaleLinefromSalesAutoSplitQtyLine;
          if Salebase.Lines.AreaQty <> 0 then begin
            Salebase.Lines.AreaQty      := 0;
            Salebase.Lines.PostDB;
          end;
        Except
          on E:Exception do begin
            if devmode then
              MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
          end;
        end;
        SalesAutoSplitQty.SLLines.NExt;
      end;
    finally
      freeandnil(SalesAutoSplitQty );
    end;
  Except
    on E:Exception do begin
      if devmode then
         MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;
procedure TBaseSaleGUI.DoAutoSplitQty;
begin
  if fbAutoSplitQty then exit;
  try
    fbAutoSplitQty := True;
    try
      Salebase.InternalQuantityChange:= True;
      try
        OpenERPFormModal('TfmSalesAutoSplitQty' ,0 , InitSalesAutoSplitQty , False,ApplyAutoSplitQty )
      finally
        Salebase.InternalQuantityChange:= False;
      end;
    finally
      fbAutoSplitQty:= False;
    end;
  Except
    on E:Exception do begin
      if devmode then
        MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;
procedure TBaseSaleGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ResultStatus: TResultStatusItem;
  Equipid: Integer;
  MatrixDesc: string;
  MatrixRef: string;
  MatrixPrice: Double;
  X: string;
  DoAdd_SpecialPrice:Boolean;
  option : word;
begin
  inherited;
{-->} if Sender is TEquipment then begin
        if (EventType = BusobjEvent_ToDo) and (Value = BusobjEvent_ChooseEquip) then begin
          Equipid := TEquipmentListGUI.ShowallEquipment(SaleBase.Lines.ProductName);
          if Equipid <> 0 then
            if Sender is TEquipment then begin
              TEquipment(Sender).Load(Equipid);
              TEquipment(Sender).ProductID := SaleBase.Lines.ProductID;
              TEquipment(Sender).PostDB;
            end;
        end;
      end
{-->} else if (EventType = BusobjEvent_ToDo) and (Value = BusobjEvent_AutosplitQty ) then begin
        if (Screen.activecontrol = grdtransactions) and (Sametext(ActiveFieldname , tblDetailsUnitofMeasureQtySold.FieldName)) then
          //DoAutoSplitQty;
{-->} end else if (EventType = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TEquipmentxRef then TEquipmentxRef(Sender).DataSet := tblEquipmentxRefs
        else if Sender is TSalesLinePackWeightLinesSum then TSalesLinePackWeightLinesSum(Sender).DataSet := QrySalesLinePackWeightLinesSum;
{-->} end else if (EventType = BusobjEvent_ToDo) and (Value = BusObjProcTreePartWrongProduct) then begin
        X := SendEmailtoErp('Wrong ProductId in ProcTreePart', '    Company     :' + Appenv.CompanyInfo.Companyname + chr(13) + '    Server      :' + GetSharedMyDacConnection.Server + chr(13) +
          '    Datase      :' + GetSharedMyDacConnection.Database + chr(13) + '    Version     :' + TABLE_VERSION + chr(13) + '    Description :' + 'Sale#' + IntToStr(SaleBase.ID) + '  ProductID:' +
          IntToStr(SaleBase.Lines.ProductID) + '  ProductName:' + SaleBase.Lines.ProductName + '    Failed From :' + Self.ClassName, 'sendemail');
        if X <> '' then begin
          CommonLib.MessageDlgXP_Vista('Report Sending to ERP Failed. This Transaction Could not Be Saved. Please Contact ERP.', mtWarning, [mbOK], 0);
        end else begin
          CommonLib.MessageDlgXP_Vista('A Report Has Been Sent to ERP  - This Transaction Could not Be Saved. Please Contact ERP.', mtWarning, [mbOK], 0);
        end;
      end  else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_CalculationsDisabled) then begin
        lblDisableCalc.visible := (TransBase.Lines.count > appenv.CompanyPrefs.SaleLinesToDisableCalcs) or (Appenv.companyPrefs.EnableAvaTax and Appenv.companyPrefs.AvaTaxCredentialsValidated );
        if Appenv.companyPrefs.EnableAvaTax and Appenv.companyPrefs.AvaTaxCredentialsValidated then begin
          Showcontrolhint(lblDisableCalc, 'Choose to Calculate AvaTax');
          lblDisableCalc.Caption := 'Update Tax';
        end;
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEvent_ReadTreePartSourceforSales) then begin
        ConfirmPartSource;
{-->} end  else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_SpecialPrice) then begin
        if (fbAutoSplitQty =False) and (fbCalcQtyForAre =False) then begin
          DoAdd_SpecialPrice:= true;
               if LoadingfromHistory  and fbdontAdd_SpecialPrice then DoAdd_SpecialPrice := False
          else if LoadingfromHistory  and fbAdd_SpecialPrice     then DoAdd_SpecialPrice := true
          else begin
            if not LoadingfromHistory then
                 Option := CommonLib.MessageDlgXP_Vista('Do You Wish To Add This Product To' + #13 + #10 + 'Customers Special Price List ?', mtconfirmation, [], 0 , nil , '','',False,nil,'Yes,No')
            else option := CommonLib.MessageDlgXP_Vista('Do You Wish To Add This Product To' + #13 + #10 + 'Customers Special Price List ?', mtconfirmation, [], 0 , nil , '','',False,nil,'Yes,No,Yes To All, No To All');
            if (option = 101) or (Option = 103) then  DoAdd_SpecialPrice := False;
            if option = 103 then  fbdontAdd_SpecialPrice:= true;
            if option = 102 then  fbAdd_SpecialPrice := true;
          end;
          if DoAdd_SpecialPrice then
            ClientDiscountObj.Client_Add_SpecialPrice(SaleBase.clientID, TSalesLineBase(Sender).ProductID, TSalesLineBase(Sender).LinePrice);
        end;
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_OnProductChange) then begin
        LockLinefieldsonAccessLevel(False);
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_OnUOMChange) then begin
        LockLinefieldsonAccessLevel(False);
{-->} end else if (EventType = BusObjEvent_todo) and (Value = BusObjEventVal_OpenLookuponProductChange) then begin
         cboProductR.InitnOpenLookup;
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_ProductChanged) then begin
        if TSalesLineBase(Sender).Product.ShowProductPopUp then DelayMessageDlg(TSalesLineBase(Sender).Product.ProductPopUpNotes, mtInformation, [mbOK], 0);
        SaleBase.Lines.IsRelatedProduct := False;
        SaleBase.Lines.ParentProductID := 0;
        SaleBase.Lines.RelatedProductQty := 0;
        SaleBase.Lines.RelatedParentLineRef :='';

        if (SaleBase.Lines.Product.NormalDeliveryTime>0) and (Appenv.CompanyPrefs.MatchSalesLineShipdateToProductDeliveryDays) then
            SaleBase.Lines.ETDDate := incday(SaleBase.ShipDate , trunc(SaleBase.Lines.Product.NormalDeliveryTime))
        else SaleBase.Lines.ETDDate := SaleBase.Lines.ShipDate;

        // DoOnProductchange;
        if not SaleBase.Lines.deleted then begin
          ReadSalesDefaultPriceMethod(SaleBase.Lines.ProductID, MatrixDesc, MatrixRef, MatrixPrice);
          SetMatrixDetails(MatrixDesc, MatrixRef, MatrixPrice);
        end;
        DoShowExcelPrice('Q', False, False);
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_QtyShipped) then begin
        lblShipped.Caption := FloatToStrF(SaleBase.TotalQtyShipped, ffFixed, 5, 1);
        lblWeight.Caption := FloatToStrF(SaleBase.TotalshippedUOMWeight, ffFixed, 5, 1);
        SaleBase.Lines.updaterelatedPartsQty;
        Salebase.DoCalcOrdertotals;
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_QtySold) then begin
        SaleBase.Lines.updaterelatedPartsQty;
        Salebase.DoCalcOrdertotals;
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_OrderTotalsCalculated) then begin
        lblEstimatedFinalAmt.Caption := FloatToStrF(SaleBase.TotalEstimatedAmountInc, ffCurrency, 15, CurrencyRoundPlaces);
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEvent_OnCalcOrderTotals) then begin
        lblOrdered.Caption := FloatToStrF(SaleBase.TotalQtyOrdered, ffFixed, 5, 1);
        lblShipped.Caption := FloatToStrF(SaleBase.TotalQtyShipped, ffFixed, 5, 1);
        lblWeight.Caption  := FloatToStrF(SaleBase.TotalshippedUOMWeight, ffFixed, 5, 1);
        if TSaleSLine(Salebase.Lines).SalesLinesUOMDetails.NoOfBoxes <> 0 then
          RecalculateNoOfBoxes;
{-->} end else if (EventType = BusObjEvent_Error) then begin
        ResultStatus := Sender.ResultStatus.GetLastStatusItem;
        if Assigned(ResultStatus) then

          case ResultStatus.Severity of
            rssInfo: DelayMessageDlg(ResultStatus.Message, mtInformation, [mbOK], 0);
            rssWarning: DelayMessageDlg(ResultStatus.Message, mtWarning, [mbOK], 0);
            rssError: DelayMessageDlg(ResultStatus.Message, mtWarning, [mbOK], 0);
          end;
{-->} end else if (EventType = BusObjEvent_InvoiceCommentPopUp) then begin
        DelayMessageDlg(Value, mtInformation, [mbOK], 0);
{-->} end else if (EventType = BusobjEvent_ToDo) and (Value = BusobjEvent_ShowCustomizableInvociedatefield) then begin
        grdTransactions.AddField('WarrantyEndsOn');
        guiprefs.DbGridElement[grdTransactions].AddField('WarrantyEndsOn');
        grdTransactions.SetActiveField('WarrantyEndsOn');
{-->} end else if (EventType = BusobjEvent_ToDo) and (Value = BusobjEvent_ShowCustomizableInvocieTextfield) then begin
        grdTransactions.AddField('WarrantyPeriod');
        guiprefs.DbGridElement[grdTransactions].AddField('WarrantyPeriod');
        grdTransactions.SetActiveField('WarrantyPeriod');
{-->} end else if (EventType = BusobjEvent_ToDo) and (Value = BusobjEventVal_ChooseAlternateProduct) then begin
        SelectAlternateProduct;
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEvent_ContributionAmountChanged) then begin
        if MessageDlgXP_Vista('Customer of ' + SaleBase.XMLNodename + ' #' + IntToStr(SaleBase.ID) + ' "' + Trim(SaleBase.Customername) +
          '" is not a Related Customer.  The Customer Has to be a Related Customer to Have a Contribution Amount.' + chr(13) + chr(13) + 'Do you wish to Select the Parent Customer for "' +
          SaleBase.Customername + '"?', mtconfirmation, [mbyes, mbno], 0) = mrYes then AddRelatedclient;
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_ClientID) then begin
        if not fbOnClientchange   then begin
          InitClientLookupCombonFields;
          Opendb(qryClientLookup);
          DoDelayObjectProcedure(DoOnClientchange,10, Self.classname +'.DoOnClientchange');
        end;
{-->} end else if (EventType = BusObjEvent_Change) And (value = BusObjEventVal_uomChanged)  then begin
        if qryUnitOfMeasureUnitID.AsInteger <> SaleBase.Lines.UnitOfMeasureID then begin
           closedb(qryUnitOfMeasure);
           opendb(qryUnitOfMeasure);
           qryUnitOfMeasure.locate('unitID' , SaleBase.Lines.UnitOfMeasureID , []);
        end;
{-->} end else  if (EventType = BusObjEvent_Change) And (value = BusObjEventVal_CustomerChanged) then begin
        //autoLoadProducts;
{-->} end else  if (EventType = BusobjEvent_ToDo) And (value = busobjeventval_checkforStockinOtherDept) then begin
          if Appenv.companyprefs.checkforStockinOtherDept =False then exit;
          if SAlebase.CopyingToInvoice then exit;
          checkforStockinOtherDept;
{-->} end else  if (EventType = BusObjEvent_Change) And (value = BusObjEventVal_SalesLineCost) then begin
          TransTimerMsg(Appenv.CompanyPrefs.SalesLineLatestCostBasedOnMsg, 5);
{-->} end else if (EventType = BusobjEvent_ToDo) and (Value = BusObjEvent_BlankAccount) and (Sender is TTransBase) then begin
          ShowAccountCbo((salebase.GLAccountId =0) or (salebase.GLAccountname = ''));
{-->} end else If (EventType = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value)) and (Sender is TTransBase) then begin
          //fiSmartOrderID := SalesSmartOrderID(SaleBase.globalref);
{-->} end  else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_AddRelatedPartsDone) then begin
{-->} end else if (Eventtype = BusObjEvent_Warning) and (Value = BusObjEventVal_Warn_ZeroLineQty) then begin
        CommonLib.MessageDlgXP_Vista('The Quantity for ' + SaleBase.Lines.ProductName +
          ' is "0" and ERP Has Taken It That This Was Intentional. If Not Please Re-open This Sale ' + IntToStr(SaleBase.Id) +
          ' and Adjust the Ordered Quantity.',mtInformation,[mbOK],0,nil,'','Disable This Quantity Warning',false,DisableLineZeroQtyWarning);
{-->}end else if (EventType = BusObjEvent_Change) and  (Value = BusObjEventVal_ReferenceNo) then begin
       InitRefBtn;
{-->}end else if ((sender is TSales) and (EventType = BusobjEvent_Event) and  (Value = BusObjEventDataset_AfterPost)) OR
                 ((sender is TSales) and (EventType = BusObjEvent_Dataset) and  Sender.IsdataIdchangeEvent(Value)) OR
                 ((sender is TSales) and (EventType = BusobjEvent_Event) and  (Value = BusObjEventDataset_AfterOpen)) then begin
        Refreshexternalxref;
{-->} end else if (EventType = BusobjEvent_ToDo) and (Value = BusobjEvent_CalcAvaTax) then begin
         Salebase.CalculatedAvaTax := CalcAvaTax;
{-->} end;
{-->} if (Sender is TTransBase)  then
        if ((EventType = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterOpen)) Or
           ((EventType = BusObjEvent_Dataset) and (Value = BusObjEventDataset_dataIdchange_dcLoad)) Or
           ((EventType = BusObjEvent_Dataset) and (Value = BusObjEventDataset_dataIdchange_dcDelete)) Or
           ((EventType = BusObjEvent_Dataset) and (Value = BusObjEventDataset_dataIdchange_dcNew)) Or
           ((EventType = BusObjEvent_Dataset) and (Value = BusObjEventDataset_dataIdchange_dcSave)) Or
           ((EventType = BusObjEvent_Dataset) and (Value = BusObjEventDataset_dataIdchange_dcClose)) OR
           ((EventType = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterPost)) then begin
             RefreshSalessummary;
           end;
end;
Procedure TBaseSaleGUI.CalcAvaTaxNoTaxCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TSalesLineBase then begin
    TSalesLineBase(Sender).Linetaxrate := 0;
    TSalesLineBase(Sender).PostDB;
    TSalesLineBase(Sender).CalcLinetotals;
  end;
end;
(*Function TBaseSaleGUI.CalcAvaTax:Boolean;
begin
  try
    REsult := SaleBase.CalcAvaTax;
  Except
    on E:Exception do begin
      Logtext(E.message);
    end;
  end;
end;*)
Function TBaseSaleGUI.CalcAvaTax:Boolean;
var
  fsBody :String;
  aAvaTaxERPObj :TAvaTaxERPObj;
  Msg:String;

  function TaxCodeNoTax :String;
  begin
    if trim(Appenv.companyprefs.AvaTaxConfig.NotaxTaxcode) <> '' then
         Result := Appenv.companyprefs.AvaTaxConfig.NotaxTaxcode
    else Result := appenv.regionaloptions.TaxCodeNoTax;
  end;
begin
  REsult := False;
  try
    if not Appenv.companyPrefs.EnableAvaTax then exit;
    if not Appenv.companyPrefs.AvaTaxCredentialsValidated then  Exit;
    if fbCalculatingAvaTax then exit;

    if Not (Salebase.ValidateforAvaTax) then exit;

    fbCalculatingAvaTax := True;
    try
            if not Salebase.save then exit;
            Salebase.Connection.CommitTransaction;
            try
                  Processingcursor(True);
                  try
                      if sametext(Salebase.Customer.TaxCodeName , TaxCodeNoTax) then begin
                        MessageDlgXP_Vista('Avalara Tax Calculation Ignored as Customer [' + Salebase.Customername +'] has the NoTax TaxCode [' +TaxCodeNoTax +'] Selected.', mtinformation, [mbok] , 0);
                        Salebase.Lines.iteraterecords(CalcAvaTaxNoTaxCallback);
                      end else begin
                        Salebase.Connection.beginNestedTransaction;
                        try
                          aAvaTaxERPObj := TAvaTaxERPObj.create(Self);
                          try
                            Msg := '';
                            if aAvaTaxERPObj.CalcAvaTax(Salebase, Msg) then begin
                              Salebase.Connection.CommitNestedTransaction;
                              Salebase.save;
                              Salebase.Dirty := False;
                              Result := True;
                              Exit;
                            end else begin
                                Application.ProcessMessages;
                                if Msg <> '' then begin
                                  MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
                                end;
                                Salebase.Connection.RollbackNestedTransaction;
                                Exit;
                            end;
                          finally
                            FreeandNil(aAvaTaxERPObj);
                          end;
                        Except
                          on E:Exception do begin
                            logtext(E.message);
                            Salebase.Connection.RollbackNestedTransaction;
                          end;
                        end;
                      end;
                  finally
                    Processingcursor(False);
                  end;
              finally
                Salebase.Connection.BeginTransaction;
              end;
    finally
       fbCalculatingAvaTax := False;
    end;
  Except
    on E:Exception do begin
      Logtext(E.message);
    end;
  end;
end;
procedure TBaseSaleGUI.DoGeneralMenuItemClick(Sender: TObject);
begin
  //
  if SameText(StringReplace(TMenuItem(Sender).Caption, '&', '',[]), 'Shipment Rate Quote') then begin
    DoGetShippingRates;
  end;
end;

procedure TBaseSaleGUI.DoGetShippingRates;
begin
  if not ((Salebase is TSalesOrder) or (Salebase is TInvoice)) then exit;
  if (Salebase is TSalesOrder) and (not Appenv.CompanyPrefs.AllowShipmentsFromSalesOrder) then begin
    if MessageDlgXP_Vista('"Allow Processing Shipments from Sales Order" is not selected in EDI integration Preferences.',mtConfirmation,[mbOk],0, nil,'','',False, nil ,'Open Preference Form' ) = 100 then
      OpenPrefform('EDI and Integration', 'chkAllowShipmentsFromSalesOrder' ,1 ,True, '' , '');
    exit;
  end;

  if (not IssalesLocked) and (not Salebase.converted) then begin
    if not SaveSalesRecord then Exit;
    self.CommitTransaction;
    self.BeginTransaction;
  end;
  DoShipmentRates(self);
end;

Procedure TBaseSaleGUI.checkforStockinOtherDept;
begin
  if Self is TQuoteGUI then exit;
  if not SaleBase.Lines.Product.isInvProduct then exit;
  OpenERPListForm('TProductclassQtyGUI' , initProductclassQty , nil , False );
end;

procedure TBaseSaleGUI.initProductclassQty(Sender:TObject);
begin
  if not (sender is TProductclassQtyGUI) then exit;
  TProductclassQtyGUI(Sender).productId := SaleBase.Lines.productId;
  TProductclassQtyGUI(Sender).ClassId:= SaleBase.SaleClassId;
end;
procedure TBaseSaleGUI.DoInventoryVerification(Sender: TObject);
var
  NewSmartOrderID:Integer;
  function SalesOrderID:Integer;
  begin
    if SaleBase is TSalesOrder then result := saleBase.ID else result := 0;
  end;
begin
  NewSmartOrderID:= 0;
  if SaleBase.Converted then begin
      MessageDlgXP_Vista('This ' +SaleBase.XMLNodename +' is already converted' , mtInformation, [mbOK], 0);
      Exit;
  end;
  if SaleBase.HasNonTreeLines = false then begin
      MessageDlgXP_Vista('All Product(s) in this ' + SaleBase.xmlnodename+' is getting manufactured', mtInformation, [mbOK], 0);
      Exit;
  end;
  ShowInvVerify(False,  NewSmartOrderID);
  if NewSmartOrderID <> 0 then
    OpenSmartOrder(NewSmartOrderID, SalesOrderID, salebase.globalref);
end;

Procedure TBaseSaleGUI.OpenSmartOrder(const SOID:Integer; iSaleID:Integer; sSaleRef:String);
var
  Form :TComponent;
begin
 if SOID > 0 then begin
    if sSaleRef<>'' then begin
          with TempMyScript do try
            { Smart Order has already been created and comitted so we don't
              need to use transaction control }
            Connection:= CommonDbLib.GetSharedMyDacConnection;
            SQL.Add('update tblSmartOrder set SaleOrderID = ' + IntToStr(iSaleID) + ',');
            SQL.Add('SalesGlobalRef = ' + QuotedStr(sSaleRef));
            SQL.Add('where SmartOrderID = ' + IntToStr(SOID) + ';');

            SQL.Add('update tblSmartOrderLines, tblSalesLines');
            SQL.Add('set tblSmartOrderLines.SaleLineID = tblSalesLines.SaleLineID');
            SQL.Add('where tblSalesLines.SaleID = ' + IntToStr(iSaleID));
            SQL.Add('and tblSmartOrderLines.PartsID = tblSalesLines.ProductID;');
            Execute;
          finally
            Free;
          end;
    end;

        Form := GetComponentByClassName('TSmartOrderGUI');
        if Assigned(Form) then begin //if has acess
            TSmartOrderGUI(Form).KeyID := SOID;
            TSmartOrderGUI(Form).FormStyle := fsMDIChild;
            TSmartOrderGUI(Form).BringToFront;
        end;
      end;
end;
Function TBaseSaleGUI.ShowInvVerify(const Showcontinue:Boolean; var NewSmartOrderID: integer):Boolean;
var
  frm: TfrmSalesInvVerifyGUI;
  iResult: integer;
begin
    result:= False;
    frm := TfrmSalesInvVerifyGUI(GetComponentByClassName('TfrmSalesInvVerifyGUI'));
      if Assigned(frm) then begin //if has access
        with frm do begin
          try
            FormStyle := fsNormal;
            Position := poDefault;

            // Pass our required parameters before opening
            // the Sales Inventory Verification Window.
            TransLineDataset := tblDetails;
            TransNo := tbldetailsSaleId.asInteger;
            ConvertingFrom := 'Quote';
              SourceClassID := tblMaster.FieldByName('ClassID').AsInteger;
            SourceCustomerID := tblMaster.FieldByName('ClientID').AsInteger;
            btncontinue.Enabled := Showcontinue;
            // Present the Sales Inventory Verification Window
            iResult := ShowModal;


            // Was the Cancel button pressed, if so then exit.
            if iResult = 3 then Exit
            else NewSmartOrderID:= SmartOrderID;
            REsult:= true;
          finally
            Free;
          end;
        end;
      end;
end;

function TBaseSaleGUI.CustomerHAsSaleHistory:Boolean;
begin
  With Salebase.GetNewDataSet('Select count(SaleID) as sales from tblsales '+
                              ' where ClientID = ' + inttostr(salebase.ClientId) +
                              ' and SaleID <> ' + inttostr(salebase.ID) +
                              ' and (IsQuote ="T" or IsSalesOrder = "T" or  IsInvoice ="T")  '+
                              ' and converted ="F"  '+
                              ' and deleted ="F"' , true) do try
    result:= fieldByname('sales').AsInteger >0;
  finally
    if active then close;
    free;
  end;
end;
Procedure TBaseSaleGUI.OpenProductList;
begin
  OpenERPListFormultiselectModal('TProductListExpressGUI' , nil , CustomerProductsaleshistoryonselect);
end;
procedure TBaseSaleGUI.OpenProductNotes;
begin
  if SaleBase.Lines.ProductID=0 then begin
    MessageDlgXP_vista('Select the Product ', mtInformation, [mbOK], 0);
    Exit;
  end;
  OpenERPForm('TfrmParts' ,SaleBase.Lines.ProductID ,MoveTonotePage);
end;
procedure TBaseSaleGUI.openSalesPickedQty(Sender: TObject);
begin
  if fsModal in FormState then
       OpenERPListFormModal('TSalesPickedQtyGUI' , nil, initSalesPickedQtyreport)
  else OpenERPListForm('TSalesPickedQtyGUI' , initSalesPickedQtyreport);
end;
Procedure TBaseSaleGUI.initSalesPickedQtyreport(sender :TObject);
begin
  if not(Sender is TSalesPickedQtyGUI) then exit;
  TSalesPickedQtyGUI(Sender).SaleId := salebase.ID;
  TSalesPickedQtyGUI(Sender).originalno := salebase.OriginalDocNumber;
end;
Procedure TBaseSaleGUI.MoveTonotePage(Sender:TObject);
begin
  if not(Sender is TfrmParts) then exit;
  TfrmParts(Sender).Pagecontrol.ActivePage:= TfrmParts(Sender).Miscellaneous;
  TfrmParts(Sender).MiscPageControl.ActivePage := TfrmParts(Sender).tabnotes;
  SetControlFocus(TfrmParts(Sender).edtGeneralNotes);

end;
procedure TBaseSaleGUI.NewTransBusObjinstance;
begin
  TransBase := SaleBase;
  inherited;
end;

Procedure TBaseSaleGUI.openOrderHistory;
begin
   OpenERPListFormultiselectModal('TCustomerProductsaleshistoryGUI' , CustomerProductsaleshistorybeforeshow , CustomerProductsaleshistoryonselect)
end;
Procedure TBaseSaleGUI.CustomerProductsaleshistorybeforeshow(Sender:TObject);
begin
  if not(Sender is TCustomerProductsaleshistoryGUI) then exit;
  TCustomerProductsaleshistoryGUI(Sender).ClientID := Salebase.ClientId;
end;
Procedure TBaseSaleGUI.CustomerProductsaleshistoryonselect(Sender :twwDBGrid);
var
    i:Integer;
begin
LoadingfromHistory:= true;
try
  fbdontAdd_SpecialPrice:= False;
  fbAdd_SpecialPrice := False;
  PostDB(Sender.datasource.dataset);
  if Sender.SelectedList.Count > 0 then begin
    for i := 0 to Sender.SelectedList.Count - 1 do begin
      Sender.datasource.dataset.GotoBookmark(Sender.SelectedList.Items[i]);
      if Sender.datasource.dataset.fieldByname('PartsId').asinteger <> 0 then begin
        Salebase.Lines.New;
        Salebase.Lines.ProductID := Sender.datasource.dataset.fieldByname('PartsId').asinteger;
        if Sender.datasource.dataset.findfield('UnitofMeasureSaleLines')  <> nil then Salebase.Lines.UnitOfMeasure  := Sender.datasource.dataset.fieldbyname('UnitofMeasureSaleLines').asString;
        if Sender.datasource.dataset.findfield('UnitofMeasureMultiplier') <> nil then Salebase.Lines.UOMMultiplier  := Sender.datasource.dataset.fieldbyname('UnitofMeasureMultiplier').AsFloat;
        if Sender.datasource.dataset.findfield('Qty')                     <> nil then Salebase.Lines.UOMQtySold     := Sender.datasource.dataset.fieldbyname('Qty').AsFloat else Salebase.Lines.UOMQtySold     :=1;
        if Sender.datasource.dataset.findfield('lineprice')               <> nil then Salebase.Lines.LinePrice      := Sender.datasource.dataset.fieldbyname('lineprice').AsFloat;
        Salebase.Lines.PostDB;
      end;
    end;
  end;
finally
  LoadingfromHistory:= False;
  fbdontAdd_SpecialPrice:= False;
  fbAdd_SpecialPrice := False;
end;
end;
Procedure TBaseSaleGUI.LoadLastOrder;
var
  Originalno:String;
begin
  With Salebase.getNewDataset('Select S.Originalno,  max(S.SAleDate) SaleDate  ' +
                              ' from tblsales S ' +
                              ' inner join tblsaleslines SL on S.SaleId = SL.saleID ' +
                              ' where S.converted ="F" and  S.SaleID <> ' + inttostr(Salebase.ID) +' and s.clientId = ' + inttostr(Salebase.ClientId) +
                              ' group by S.OriginalNo , SL.ProductID ' +
                              ' order by saleDate desc limit 1' , true) do try
    First;
    Originalno:= Fieldbyname('Originalno').AsString;
    if active then close;
    SQL.clear;
    SQL.add('Select S.Originalno,  S.SAleDate SaleDate , ' +
                              ' SL.ProductName , SL.productID, SL.QtySold as Qty, ' +
                              ' SL.LinePrice  LinePrice, ' +
                              ' SL.UnitofMeasureSaleLines, ' +
                              ' SL.UnitOfMeasureID, ' +
                              ' SL.UnitofMeasureMultiplier ' +
                              ' from tblsales S ' +
                              ' inner join tblsaleslines SL on S.SaleId = SL.saleID ' +
                              ' where S.OriginalNo = ' +quotedstr( Originalno) +' and SL.baselineno =0' );
    open;
    first;
    LoadingfromHistory:= True;
    try
      fbdontAdd_SpecialPrice:= False;
      fbAdd_SpecialPrice := False;
      while Eof = False do begin
        salebase.Lines.New;
        salebase.Lines.AutoLoadRelatedProducts := false;
        try
          salebase.Lines.ProductID := fieldbyname('productID').AsInteger;
          salebase.Lines.QtySold := Fieldbyname('Qty').AsFloat;
          salebase.Lines.Lineprice := fieldByname('LinePrice').AsFloat;
          salebase.Lines.UnitOfMeasure:= Fieldbyname('UnitofMeasureSaleLines').AsString;
          salebase.Lines.UOMMultiplier:= Fieldbyname('UnitofMeasureMultiplier').asFloat;
          salebase.Lines.PostDB;
        finally
          salebase.Lines.AutoLoadRelatedProducts := true;
        end;
        Next;
      end;
    finally
      LoadingfromHistory:= False;
      fbdontAdd_SpecialPrice:= False;
      fbAdd_SpecialPrice := False;
    end;
  finally
    if active then close;
    Free;
  end;
end;
procedure TBaseSaleGUI.LoadTransRec;
begin
  inherited;
  btnInvoices.visible := Salebase.converted and not (Salebase.IsInternalOrder);
end;

Procedure TBaseSaleGUI.AutoLoadProductOptions(IgnorePrefs: boolean = false);
var
  AutoLoadProductOptionSelected:Integer;
begin
    if CustomerHasSaleHistory then begin
      if IgnorePrefs or ((Appenv.Companyprefs.ShowSalesProductAutoSelectOptions) and (Appenv.employee.ShowSalesProductAutoSelectOptions)) then begin
          if not(self.ClassNameIs('TfmVoucherSale')) and not(self.ClassNameIs('TfmvoucherInvoice')) then begin
              AutoLoadProductOptionSelected:= TfmSalesProductAutoSelectOptions.AutoLoadProductOption(self);
                   if AutoLoadProductOptionSelected <=1 then exit// new
              else if AutoLoadProductOptionSelected = 2 then LoadLastOrder
              else if AutoLoadProductOptionSelected = 3 then openOrderHistory
              else if AutoLoadProductOptionSelected = 4 then openproductList
              else exit;
          end;
      end;
    end else begin
       if MessageDlgXP_Vista('You have ''Show Product Auto Select Options'' preference turned on, but Customer ' + quotedstr(Salebase.customername) +' didn''t have any sale so far.' + NL + NL+
                  'Do you wish to select product(s) from the ''Product list''?', mtConfirmation, [mbyes,mbNo], 0) = mryes then
        openProductList;
    end;
end;
Procedure TBaseSaleGUI.AutoLoadProducts;
begin
  if (Appenv.Companyprefs.ShowSalesProductAutoSelectOptions=False ) or (Appenv.employee.ShowSalesProductAutoSelectOptions = False)  then exit;

  if salebase.ClientId=0 then exit;
  salebase.PostDb;
  AutoLoadProductOptions;
end;
Procedure TBaseSaleGUI.SelectAlternateProduct;
var
  MSG:String ;
  msgoption:Word;
begin
      Msg := 'The Product ' + SaleBase.Lines.Product.ProductName + ' Has Been Discontinued  and ';
    if not(SaleBase.Lines is TQuoteLine) then Msg := Msg + ' Therefore Back Orders are NOT Accepted, ';
    Msg := Msg + 'Can Only Sell the Available Quantity!';
    Msg := Msg + NL + NL + 'Currently There is ' + FloatToStr(SaleBase.Lines.UOMQtyShipped);
    if SaleBase.Lines.UOMMultiplier <> 1 then
        Msg := Msg + ' ' + SaleBase.Lines.UnitOfMeasure + '(' + FloatToStr(SaleBase.Lines.UOMMultiplier) + ') = ' + FloatToStr(SaleBase.Lines.QtyShipped) + ' ' + AppEnv.DefaultClass.DefaultUOM;
    Msg := Msg + ' Available.';
    Msg := Msg + NL + NL + 'Do you wish To Select Another Product From the Alternate Product list of ' + SaleBase.Lines.ProductName + ' for the remaining Quanityt of ' +
      FloatToStr(SaleBase.Lines.QtyrequiredforAlternateProduct);
    msgoption := MessageDlgXP_Vista(Msg, mtconfirmation, [], 0, nil, '' ,'' , False, nil , 'Product List,Alternate Product List,Cancel');
    if  msgoption= 102 then Exit;
    if msgoption = 100 then
      OpenERPListFormModal('TProductListExpressGUI', AddAlterNateProduct)
    else OpenAlternateProductListtoReplace;

end;


function TBaseSaleGUI.SelectedLineIds: String;
begin
  Result := Commonlib.SelectedIds(grdtransactions , 'SaleLineId');
end;

procedure TBaseSaleGUI.AddDefaultOrdermenuITems;
var
  mnu: TMenuItem;
begin
  inherited;
  mnu := TMenuItem.Create(self);
  mnu.Caption := 'Inventory Verification';
  mnu.OnClick := DoInventoryVerification;
  pnlHeader.Popupmenu.Items.Add(mnu);

  if (Salebase is TSalesOrder) or (Salebase is TInvoice) then begin
      mnu := TMenuItem.Create(self);
      mnu.Caption := '-';
      grdTransactions.Popupmenu.Items.Add(mnu);

      mnu := TMenuItem.Create(self);
      mnu.Caption := 'Quantity Picking Status';
      mnu.OnClick := openSalesPickedQty;
      pnlHeader.Popupmenu.Items.Add(mnu);
  end;
  if Appenv.companyPrefs.AvaTaxCredentialsValidated then  begin
    //NewMenuForTransGrid('Calc AvaTax' , DoCalcAvaTax, true);
    //NewMenuForTransGrid('Commit in AvaTax' , DoCommitAvaTax, true);
    if devmode then
      NewMenuForTransGrid('Log AvaTax Details' , DoLogAvaTaxdetails, true);

  end;
end;
procedure TBaseSaleGUI.DoLogAvaTaxdetails(Sender: TObject);
begin
    clog(SaleBase.AvaTaxRelatedData);
    OpenLogfile;
end;
(*procedure TBaseSaleGUI.DoCommitAvaTax(Sender: TObject);
begin
end;
procedure TBaseSaleGUI.DoCalcAvaTax(Sender: TObject);
begin
  CalcAvaTax;
end;*)

procedure TBaseSaleGUI.BeforeShowAlternateProductsGUI(Sender: TObject);
begin
  if not(Sender is TAlternateProductSearchGUI) then Exit;
  TAlternateProductSearchGUI(Sender).ProductID := SaleBase.Lines.ProductID;
  TAlternateProductSearchGUI(Sender).classId := SaleBase.SaleclassId;
end;


procedure TBaseSaleGUI.BeforeOpenNonRelatedCustomers(Sender: TObject);
begin
  TBaseListingGUI(Sender).Qrymain.ParamByName('xclientID').AsInteger := SaleBase.clientID
end;

procedure TBaseSaleGUI.BeforeOpenRepairList(Sender: TObject);
begin
  if not(Sender is TSalesRepairListGUI) then exit;
  TSalesRepairListGUI(Sender).SaleID :=SaleBase.ID;
          if sameText(SaleBase.XMLNodeName, 'quote' )  then TSalesRepairListGUI(Sender).Salestype :='Quote'
    else  if sameText(SaleBase.XMLNodeName, 'Invoice') then TSalesRepairListGUI(Sender).Salestype :='Invoice'
    else  if sameText(SaleBase.XMLNodeName, 'SalesOrder' )  then TSalesRepairListGUI(Sender).Salestype :='Sales Order';
end;

procedure TBaseSaleGUI.BeforeshowJob(Sender: TObject);
begin
  if not(Sender is TBaseInputGUI) then Exit;
  TBaseInputGUI(Sender).AttachObserver(Self);
end;

procedure TBaseSaleGUI.AddRelatedclient;
var
  strMsg: string;
begin
  if not SaleBase.UserLock.Lock('tblclients', SaleBase.clientID, SaleBase.LockGroupName) then begin
    strMsg := ReplaceStr(SaleBase.UserLock.LockMessage, 'this record', 'Customer :"' + SaleBase.Customername + '"');
    strMsg := 'It is not possible to Add "' + SaleBase.Customername + '" as related Customers.' + chr(13) + chr(13) + strMsg;
    MessageDlgXP_Vista(strMsg, mtconfirmation, [mbyes, mbno], 0);
    Exit;
  end;
  OpenERPListFormSingleselect('TNonRelatedCustomerGUI', AddRelatedclient, BeforeOpenNonRelatedCustomers);
end;

procedure TBaseSaleGUI.AddRelatedclient(Sender: TwwDbGrid);
var
  xClientID: Integer;
  xCustomername: string;
  strMsg: string;
  Customer: TCustomer;
begin
  xClientID := 0;
  try
    xClientID := Sender.Datasource.DataSet.FieldByName('ClientId').AsInteger;
    xCustomername := Sender.Datasource.DataSet.FieldByName('CompanyName').AsString;
  except
  end;
  if xClientID = 0 then Exit;
  if not SaleBase.UserLock.Lock('tblclients', xClientID) then begin
    strMsg := ReplaceStr(SaleBase.UserLock.LockMessage, 'this record', 'Customer :' + xCustomername);
    strMsg := 'It is not possible to Add related Customers to ' + xCustomername + '.' + chr(13) + chr(13) + strMsg;
    MessageDlgXP_Vista(strMsg, mtWarning, [mbOK], 0);
    Exit;
  end;
  try
    Customer := TCustomer.CreateWithNewConn(Self);
    try
      Customer.connection.BeginTransaction;
      Customer.Load(xClientID);
      if Customer.Count = 0 then Exit;
      if not Customer.RelatedCustomers.Locate('ChildClientID', SaleBase.clientID, []) then begin
        Customer.RelatedCustomers.New;
        Customer.RelatedCustomers.MasterclientID := xClientID;
        Customer.RelatedCustomers.Mastercompany := xCustomername;
        Customer.RelatedCustomers.ChildclientId := SaleBase.clientID;
        Customer.RelatedCustomers.childcompany := SaleBase.Customername;
        Customer.RelatedCustomers.PostDB;
      end;
      Customer.ParentRelatedClientID := xClientID;
      Customer.RelatedCustomers.connection.CommitTransaction;
      QryRelatedMaster.Refresh;
      SaleBase.Customer.PostDB;
      tblMaster.Refresh;
    finally Freeandnil(Customer);
    end;
  finally
    SaleBase.UserLock.unLock('tblclients', xClientID);
    SaleBase.UserLock.unLock('tblclients', SaleBase.clientID);
  end;
  TBaseListingGUI(Sender.Owner).Close;
end;

procedure TBaseSaleGUI.grdTransactionsExit(Sender: TObject);
begin
  // skip the inherited as the form is using object
  // inherited;
  Application.ProcessMessages;
  fLastComboAccessed := nil;
end;
procedure TBaseSaleGUI.initProductQtyBinETA(Sender: TObject);
begin
  with TfrmProductQtyBinETA(Sender) do begin
        TfrmProductQtyBinETA(Sender).connection := Self.MyConnection;
        TfrmProductQtyBinETA(Sender).KeyId := tblDetails.FieldByName('ProductID').AsInteger;
        TfrmProductQtyBinETA(Sender).SaleLineID := tblDetails.FieldByName('SaleLineID').AsInteger;

        TfrmProductQtyBinETA(Sender).ClassID := tblMasterClassID.AsInteger;
        TfrmProductQtyBinETA(Sender).SalesOrderMode := False;
        TfrmProductQtyBinETA(Sender).BlockMode := true;
        TfrmProductQtyBinETA(Sender).AlternateProductselection :=mnuAlternateProductClick;
  end;
end;
procedure TBaseSaleGUI.ETAInfoClick(Sender: TObject);
begin
  OpenERPFormModal('TfrmProductQtyBinETA' , 0 , initProductQtyBinETA);
end;

function TBaseSaleGUI.ExcelObj: TExcelObj;
begin
  if aExcelObj = nil then begin
    aExcelObj :=  TExcelObj.Create(Self);
    Logtext('aExcelObj created');
  end;
  REsult := aExcelObj;
end;

procedure TBaseSaleGUI.cboClientEnter(Sender: TObject);
begin
  inherited;
  fLastComboAccessed := cboClientR;
end;


procedure TBaseSaleGUI.tblMasterTotalQuoteAmountChange(Sender: TField);
begin
  inherited;
  DisplayTotalAmounts;

  if Assigned(fStoredEvent) then fStoredEvent(Sender);
end;

procedure TBaseSaleGUI.tmrShipToMessageTimer(Sender: TObject);
begin
  inherited;
  tmrShipToMessage.Enabled := false;
  pnlShipToMessage.Visible := false;
end;

procedure TBaseSaleGUI.TranslockComponents(var lockComponents: TStringDynArray);
begin
  inherited TranslockComponents(lockComponents);
  AddTranslockComponent(lockComponents, cboClass);
end;

{$IFDEF FORM_BASED_SELECT_SQL}
function TBaseSaleGUI.TransSpecificSQL: String;
begin
  Result := inherited TransSpecificSQL;
  if fbReportSQLSupplied then begin
    Result := Result + '~|||~{ShippingAddress}select SA.* from tblsales S inner join tblshippingaddress SA on S.ShipToID = SA.ShipAddressID Where S.SaleId =  '+inttostr(SaleBase.ID);
  end else begin
    Result := Result + '~|||~ Where S.SaleId =  '+inttostr(SaleBase.ID);
  end;
  if not( Classnameis('TQuoteGUI')) then
    if fbReportSQLSupplied then begin
      Result := Result + '~|||~{ShippingDetails}Select * from  tblsalesshippingdetails where salesid =   '+inttostr(SaleBase.ID);
    end else begin
      Result := Result + '~|||~ where salesid =   '+inttostr(SaleBase.ID);
    end;
    if SameText(ReportToPrint, 'Quote With Pictures') then
      result := Result + '~|||~ where sl.SaleId =   '+inttostr(SaleBase.ID);
end;
{$ENDIF}

function TBaseSaleGUI.TransStatustype: String;
begin
  result := SimpleTypes_LeadStatusType;
end;

function TBaseSaleGUI.convertToRepair: Boolean;
var
  frm: TBaseInputGUI;
  iNewID: Integer;
begin
  inherited;
  Result := False;

  if not SaleBase.Save then Exit;
  SaleBase.connection.CommitTransaction;

  iNewID := SaleBase.CopySalesToRepairs;
  if iNewID > 0 then begin
    frm := TBaseInputGUI(GetComponentByClassName('TRepairsGUI'));
    if Assigned(frm) then begin // if has access
      frm.KeyId := iNewID;
      frm.Position := poDefault;
      frm.FormStyle := fsMDIChild;
      frm.BringToFront;
      Result := true;
    end;
  end;
  Application.ProcessMessages;
end;

function TBaseSaleGUI.IsOkToCopyToSMart: Boolean;
var
  s:String;
  fiSmartOrderID :Integer;
begin
    REsult := False;
    if  (KeyID = 0) then begin
      MessageDlgXP_Vista('Please Save the ' + salebase.Xmlnodename+' before Creating the Smart Order for it', mtWarning, [mbOK], 0);
      exit;
    end;
    if  (Accesslevel >3) then begin
      MessageDlgXP_Vista('You don''t have enough Access to Create the Smart Order for this ' + salebase.Xmlnodename+'', mtWarning, [mbOK], 0);
      exit;
    end;

    fiSmartOrderID := SalesSmartOrderID(SaleBase.AutoSmartOrderRef);
    if fiSmartOrderID>0 then begin
      if (saleBase is TSalesOrder) and AppEnv.CompanyPrefs.DisableCopyToSmartwhenSOCreate  then begin
        if MessageDlgXP_Vista('A Smart Order is already Created for this ' + salebase.Xmlnodename+', Do You Wish to View the Smart Order?', mtInformation, [mbYes,mbNo], 0) = mrYes then
          OpenERPForm('TSmartOrderGUI',fiSmartOrderID);
        Exit;
      end;
      if (saleBase is TInvoice) and AppEnv.CompanyPrefs.DisableInvCopyToSmartIfPOCreated  then begin
        if MessageDlgXP_Vista('A Smart Order is already Created for this ' + salebase.Xmlnodename+', Do You Wish to View the Smart Order?', mtInformation, [mbYes,mbNo], 0) = mrYes then
          OpenERPForm('TSmartOrderGUI',fiSmartOrderID);
        Exit;
      end;
    end;


    if not Salebase.LineHasInvProduct(Salebase.id) then begin
      CommonLib.MessageDlgXP_Vista('Smart Order Cannot be created for ' + salebase.xmlnodename+' #' +inttostr(Salebase.ID) +' as it Doesn''t Have Any Inventory Products.' , mtInformation, [mbOk] , 0);
      Exit;
    end;

  s := 'Products that are of Type ' + quotedStr('Other') +' will not be copied to the Smart Order.';
  if fiSmartOrderID <> 0 then s := s + Nl + NL +'A Smart Order is already Created for this ' + salebase.Xmlnodename+'.';
  if (SaleBase.Lines.count <> grdtransactions.SelectedList.Count) and (grdtransactions.SelectedList.Count >0) then
      s:= s + NL + NL+ inttoStr(grdtransactions.SelectedList.Count) +' of ' + inttostr(SaleBase.Lines.count ) +' Lines Are Selected to Convert into Smart Order';
  if (SaleBase.Lines.count >0) and (grdtransactions.SelectedList.Count =0) then
    s:= s + NL + NL+ QuotedStr(SaleBase.xmlnodename) +' has ' + inttoStr(SaleBase.Lines.count) +' Lines.  As No Lines are Selected, The Entire ' + QuotedStr(SaleBase.xmlnodename)+' will Convert.';

  s:= s + NL + NL+ 'Are You Sure You Want To Make a New Smart Order?';
  (*result := CommonLib.MessageDlgXP_Vista(s , mtconfirmation, [mbyes, mbno] , 0 ) = mryes;
  if result then
    if grdtransactions.SelectedList.Count =0 then
      SelectAllLines;*)
  case CommonLib.MessageDlgXP_Vista(s , mtconfirmation, [] , 0 , nil, '' , '' , False, nil , 'Make Smart Order,Cancel' +iif(fiSmartOrderID<>0 , ',View Smart Order' , '')) of
    100: begin result := True; if grdtransactions.SelectedList.Count =0 then SelectAllLines; end;
    102: begin REsult := False; OpenERPForm('TSmartOrderGUI',fiSmartOrderID);end;
    else Result := False;
  end;
end;

procedure TBaseSaleGUI.Createjob;
begin
  DisableForm;
  try
    fLastComboAccessed := nil;
    fLastComboAccessed := cboClientR;
    try OpenERPFormModal('TJobGUI', -(SaleBase.customerid), BeforeshowJob);
    finally fLastComboAccessed := nil;
    end;
  finally EnableForm;
  end;
end;

procedure TBaseSaleGUI.CustomFields1Click(Sender: TObject);
begin
  inherited;
  if OpenERPFormModal('TfmCustomfieldList', 0, beforeshowCustomfieldList)>=0  then begin
    CustomfieldonGrid.ApplyCustomFieldsSettings;
  end;
end;

procedure TBaseSaleGUI.beforeshowCustomfieldList(Sender: TObject);
begin
  if not(Sender is TfmCustomfieldList) then Exit;
  TfmCustomfieldList(Sender).ListType := ltSaleslines;
end;

function TBaseSaleGUI.ShowNoCustomerWarning: Boolean;
begin
  Result := False;
  if Empty(cboClientR.Text) or cboClientR.SpecialItemSelected then begin
    Result := true;
    CommonLib.MessageDlgXP_Vista('Customer has not been selected !', mtWarning, [mbOK], 0);
    if cboClientR.Visible and cboClientR.Enabled then SetControlFocus(cboClientR);
    Exit;
  end;
end;

procedure TBaseSaleGUI.txtShipToEnter(Sender: TObject);
begin
  inherited;
  DeleteEmptyLines(TDBMemo(Sender));
end;

procedure TBaseSaleGUI.txtShipToExit(Sender: TObject);
begin
  inherited;
  DeleteEmptyLines(TDBMemo(Sender));
end;

procedure TBaseSaleGUI.grdTransactionsColExit(Sender: TObject);
begin
  inherited;
  if SaleBase.Lines.ProductName = '' then begin
    grdTransactions.SetActiveField('ProductPrintName');
  end;
end;

procedure TBaseSaleGUI.tblDetailsCalcFields(DataSet: TDataSet);
begin
  inherited;
  if DataSet.State <> dsCalcFields then Exit;

  if TSalesLine(SaleBase.Lines).ProductID = 0 then Exit;

  tblDetailsCalcProfit.AsFloat := SaleBase.Lines.ProfitInc;
  tblDetailsCalcProfitPercent.AsFloat := SaleBase.Lines.ProfitPercentInc;
  tblDetailsCalcGrossProfitPercentInc.AsFloat := SaleBase.Lines.GrossProfitPercentInc;
  tblDetailsCalcProfitEx.AsFloat := SaleBase.Lines.Profit;
  tblDetailsCalcProfitPercentEx.AsFloat := SaleBase.Lines.ProfitPercent;

  tblDetailsOrgProductPrice.AsFloat := SaleBase.Lines.Product.GetPriceForQty(SaleBase.Lines.QtyShipped);
  tblDetailsOrgProductPriceInc.AsFloat := Round(tblDetailsOrgProductPrice.AsFloat * (1.0 + tblDetailsLineTaxRate.AsFloat), tcConst.RoundPlacesforeigncurrency);

  tblDetailsProfitbasedLatestCost.AsFloat := SaleBase.Lines.ProfitbasedLatestCost;
  tblDetailsProfitbasedLatestCostPercent.AsFloat := SaleBase.Lines.ProfitbasedLatestCostPercent;
  tblDetailsProfitbasedLatestCostInc.AsFloat := SaleBase.Lines.ProfitbasedLatestCostInc;
  tblDetailsProfitbasedLatestCostPercentInc.AsFloat := SaleBase.Lines.ProfitbasedLatestCostPercentInc;
  tblDetailsGrossProfitbasedLatestCostPercentInc.AsFloat := SaleBase.Lines.GrossProfitbasedLatestCostPercentInc;

  tblDetailsProduct_CUSTFLD1.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD1;
  tblDetailsProduct_CUSTFLD2.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD2;
  tblDetailsProduct_CUSTFLD3.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD3;
  tblDetailsProduct_CUSTFLD4.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD4;
  tblDetailsProduct_CUSTFLD5.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD5;
  tblDetailsProduct_CUSTFLD6.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD6;
  tblDetailsProduct_CUSTFLD7.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD7;
  tblDetailsProduct_CUSTFLD8.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD8;
  tblDetailsProduct_CUSTFLD9.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD9;
  tblDetailsProduct_CUSTFLD10.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD10;
  tblDetailsProduct_CUSTFLD11.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD11;
  tblDetailsProduct_CUSTFLD12.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD12;
  tblDetailsProduct_CUSTFLD13.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD13;
  tblDetailsProduct_CUSTFLD14.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD14;
  tblDetailsProduct_CUSTFLD15.AsString := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTFLD15;
  tblDetailsProduct_CUSTDATE1.AsDateTime := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTDATE1;
  tblDetailsProduct_CUSTDATE2.AsDateTime := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTDATE2;
  tblDetailsProduct_CUSTDATE3.AsDateTime := TSalesLine(SaleBase.Lines).SaleslineProductCustomFields.CUSTDATE3;
  tblDetailsUOM_Height.AsFloat := TSalesLine(SaleBase.Lines).SalesLinesUOMDetails.Height;
  tblDetailsUOM_Width.AsFloat := TSalesLine(SaleBase.Lines).SalesLinesUOMDetails.Width;
  tblDetailsUOM_Length.AsFloat := TSalesLine(SaleBase.Lines).SalesLinesUOMDetails.Length;
  tblDetailsUOM_Weight.AsFloat := TSalesLine(SaleBase.Lines).SalesLinesUOMDetails.Weight;
  tblDetailsUOM_Volume.AsFloat := TSalesLine(SaleBase.Lines).SalesLinesUOMDetails.Volume;
  tblDetailsUOM_ShippedVolume.AsFloat := TSalesLine(SaleBase.Lines).SalesLinesUOMDetails.Volume * TSalesLine(SaleBase.Lines).UOMQtyShipped;
  tblDetailsUOM_Soldvolume.AsFloat := TSalesLine(SaleBase.Lines).SalesLinesUOMDetails.Volume * TSalesLine(SaleBase.Lines).UOMQtySold;
  tblDetailsTotalUOM_WeightSold.AsFloat := tblDetailsUOM_Weight.AsFloat * tblDetailsUnitofMeasureQtySold.AsFloat;
  tblDetailsTotalUOM_WeightShipped.AsFloat := tblDetailsUOM_Weight.AsFloat * tblDetailsUnitofMeasureShipped.AsFloat;
  tblDetailsTotalUOM_WeightBO.AsFloat := tblDetailsUOM_Weight.AsFloat * tblDetailsUnitofMeasureBackorder.AsFloat;
  tblDetailsTotalUOM_LengthSold.AsFloat := tblDetailsUOM_Length.AsFloat * tblDetailsUnitofMeasureQtySold.AsFloat;
  tblDetailsTotalUOM_LengthShipped.AsFloat := tblDetailsUOM_Length.AsFloat * tblDetailsUnitofMeasureShipped.AsFloat;
  tblDetailsTotalUOM_LengthBO.AsFloat := tblDetailsUOM_Length.AsFloat * tblDetailsUnitofMeasureBackorder.AsFloat;
  tblDetailsTotalUOM_LengthSold.AsFloat := tblDetailsUOM_Weight.AsFloat * tblDetailsUnitofMeasureQtySold.AsFloat;
  tblDetailsTotalUOM_LengthShipped.AsFloat := tblDetailsUOM_Weight.AsFloat * tblDetailsUnitofMeasureShipped.AsFloat;
  tblDetailsTotalUOM_LengthBO.AsFloat := tblDetailsUOM_Weight.AsFloat * tblDetailsUnitofMeasureBackorder.AsFloat;
  tblDetailsUOMLineCost.AsFloat := SaleBase.Lines.UOMLineCost;
  tblDetailsUOMLineCostInc.AsFloat := SaleBase.Lines.UOMLineCostInc;
  tblDetailsUOMLinePrice.AsFloat := SaleBase.Lines.UOMLinePrice;
  tblDetailsUOMLinePriceInc.AsFloat := SaleBase.Lines.UOMLinePriceInc;

  tblDetailsUOMQtyInStock.AsFloat := SaleBase.Lines.InStockUOMQty;
  tblDetailsUOMQtyAvailable.AsFloat := SaleBase.Lines.AvailableUOMQty;

  tblDetailsProfitOnLanded.AsFloat := SaleBase.Lines.ProfitOnLanded;
  tblDetailsProfitOnLandedInc.AsFloat := SaleBase.Lines.ProfitOnLandedInc;
  tblDetailsProfitOnLandedPercent.AsFloat := SaleBase.Lines.ProfitOnLandedPercent;
  tblDetailsProfitOnLandedPercentInc.AsFloat := SaleBase.Lines.ProfitOnLandedPercentInc;

  if (Self is TSalesOrderGUI) or (Self is TInvoiceGUI) then begin
      If (Not tblmaster.active) OR (Not tblDetails.active) then Exit;
      { open the qry if it is not opened.
        Also makesure that the table is openend for the same PurchaseOrderID }
      If keyId <> 0 then begin
        If qrySalesQuantities.ParamByName('xSaleID').AsString <> salebase.BaseNo Then
          If qrySalesQuantities.active then qrySalesQuantities.Close;
        If qrySalesQuantities.active = False then begin
          qrySalesQuantities.ParamByName('xSaleID').AsString := salebase.OriginalDocNumber;
          qrySalesQuantities.Open;
        End;

        If qrySalesQuantities.Locate('ProductId;SeqNo', varArrayof([salebase.Lines.ProductID, salebase.Lines.SeqNo]), []) then salebase.Lines.OriginalQtyOrdered := qrySalesQuantities.FieldByName('QtySold').asFloat;
        If salebase.Lines.OriginalQtyOrdered = 0 then salebase.Lines.OriginalQtyOrdered                                                                 := salebase.Lines.QtySold;
      End
      Else salebase.Lines.OriginalQtyOrdered := salebase.Lines.QtySold;
  end;
end;

procedure TBaseSaleGUI.showPO(const POIDs: string);
var
  IDList: TStringlist;
  tmpComponent: TComponent;
  X: Integer;
begin
  if POIDs = '' then Exit;
  IDList := TStringlist.Create;
  try
    FastFuncs.Split(POIDs, ',', IDList);
    if IDList.Count = 0 then Exit;
    if MessageDlgXP_Vista('Created ' + IntToStr(IDList.Count) + ' Order(s).  ' + 'Do you wish to view them?', mtconfirmation, [mbyes, mbno], 0) = mrNo then Exit;
    for X := 0 to IDList.Count - 1 do begin
      tmpComponent := GetComponentByClassName('TPurchaseGUI', False);
      if Assigned(tmpComponent) then begin
        with TBaseInputGUI(tmpComponent) do begin
          TBaseInputGUI(tmpComponent).KeyId := FastFuncs.StrToInt(IDList[X]);
          TBaseInputGUI(tmpComponent).FormStyle := fsMDIChild;
          TBaseInputGUI(tmpComponent).BringToFront;
          TBaseInputGUI(tmpComponent).Update;
          fbPOshown := True;
          while FormStillOpen('TPurchaseGUI', TForm(tmpComponent)) do begin
            Application.ProcessMessages;
            Sleep(100);
          end;
        end;
      end;
    end;
  finally Freeandnil(IDList);
  end;
end;

procedure TBaseSaleGUI.showSO(const SOID: Integer);
var
  frm: TSmartOrderGUI;
begin
  if fbposhown then exit;
  if MessageDlgXP_Vista('Do you wish to view the Smart Order?', mtconfirmation, [mbyes, mbno], 0) = mrNo then Exit;
  frm := TSmartOrderGUI(GetComponentByClassName('TSmartOrderGUI'));
  frm.KeyId := SOID;
  frm.FormStyle := fsMDIChild;
  frm.BringToFront;
end;

procedure TBaseSaleGUI.DoOnClientchange;
var
  ClientChange: Boolean;
begin
if fbOnClientchange  then exit;
fbOnClientchange  := true;
try
  if (Empty(cboClientR.Text)) or (SaleBase.customerid = 0) or cboClientR.SpecialItemSelected then Exit;

  try
    if SaleBase.clientID <> qryClientLookupClientID.AsInteger then SaleBase.clientID := qryClientLookupClientID.AsInteger;

    if cboAccountQry.IsEmpty then begin
      CommonLib.MessageDlgXP_Vista('No Accounts Receivable Account !', mtWarning, [mbOK], 0);
      Self.Close;
      Exit;
    end;

    if cboViaQry.Locate('ShippingMethodID', qryClientLookup.FieldByName('ShippingID').AsInteger, [loCaseInsensitive]) then begin
      cboVia.LookupValue := cboViaQry.FieldByName('ShippingMethod').AsString;
    end else begin
      cboVia.LookupValue := '';
    end;

    inherited;
    if SaleBase is TQuote then
    else InitTermsduedate;

    if (iClientID <> 0) then ClientChange := true
    else ClientChange := False;

    iClientID := tblMaster.FieldByName('ClientID').AsInteger;

    if tcDataUtils.GetClientTerms(iClientID) <> '' then cboTerms.LookupValue := tcDataUtils.GetClientTerms(iClientID)
    else
      // locate lookup dataset to record (set by business object)
        cboTerms.LookupValue := Self.tblMasterTerms.AsString;

    cboTermsQry.Locate('Terms', cboTerms.LookupValue, [loCaseInsensitive, loPartialKey]);
    cboTerms.OnCloseUp(nil, cboTermsQry, tblMaster, true);
    // to force calculating the due date

    if ClientChange and Appenv.CompanyPrefs.ResetCustPrices then begin
      if (CommonLib.MessageDlgXP_Vista(iif(Salebase.RepairGlobalref <> '', 'This is a repair '+ Salebase.XMLNodename+'.' +NL +NL, '')+
                                      'Do You Wish To Reset Prices To This Customers Price Schedule ?', mtWarning, [mbyes, mbno], 0) = mrYes) then
        //Self.SaleBase.Lines.IterateRecords(AutoResetPricesOncustomerchange);
        Self.SaleBase.AutoResetPricesOncustomerchange;
    end;

    if Salebase.Lines.Count = 0 then
      AutoLoadProducts;

  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    on e: Exception do raise;
  end;
finally
  fbOnClientchange  := False;
end;
end;

procedure TBaseSaleGUI.cboProductRAfterchange(Sender: TObject);
begin
  inherited;
  DoOnProductchange;
end;

procedure TBaseSaleGUI.cboProductRCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  (* DoOnProductchange; *)
end;

procedure TBaseSaleGUI.cboProductRNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
var
  frm: TBaseInputGUI;
begin
  if Trim(cboProductR.Text) = '~' then begin
    Accept := False;
    Exit;
  end;
  // if cboProductR.LookupTable.RecordCount <> 0 then begin
  frm := nil;
  Accept := False;
  if CommonLib.MessageDlgXP_Vista('Product not found in list. Would you like to create this Product?', mtconfirmation, [mbyes, mbno], 0) = mrYes then begin
    try
      tblDetails.Edit;
      if TfrmParts.FormActive then begin
        TfrmParts.CloseMe;
      end;

      if not TfrmParts.FormActive then begin
        frm := TfrmParts(GetComponentByClassName('TfrmParts', False));
        if Assigned(frm) then begin
          TfrmParts(frm).fsPartName := NewValue;
          frm.Position := poScreenCenter;
          frm.showModal;
        end;
      end;
    finally
      cboProductQry.Close;
      cboProductQry.Open;
      if Assigned(frm) and (not Empty(TfrmParts(frm).fsPartName)) then begin
        if cboProductQry.Locate('PartName', TfrmParts(frm).fsPartName, [loCaseInsensitive]) then begin
          cboProductR.Text := TfrmParts(frm).fsPartName;
          cboProductR.PerformSearch;
        end;
        Accept := true;
      end;
    end;
  end;
  // end;
end;

procedure TBaseSaleGUI.DoOnProductchange;
var
  NewProductId: Integer;
begin
  if not Assigned(SaleBase) then Exit;
    inherited;
    RefreshUnitsQry;
    if Matrixshown then
      Exit;
    if ProductOptionsShown >0 then
      Exit;

//    cboProductR.CloseUp(True);
//
//    NewProductId := ProductOptionsShown;
//    if NewProductId <> -1 then begin
//      cboProductR.LookupTable.Refresh;
//      cboProductR.LookupTable.Locate('PartsId', NewProductId, []);
//      SaleBase.Lines.ProductId := NewProductId;
//    end;
    GlobalEvents.Notify(cboProductR, GEVENT_ComboCloseUp, SaleBase);
    ProductformulaEntry(nil);
    SaleBase.Lines.updaterelatedPartsQty;
    LockLinefieldsonAccessLevel(true);

  if SaleBase.Lines.Product.EnablePackWeight then
    if (SaleBase.Lines.ProductID <>0) and IsInvProduct(SaleBase.Lines.ProductType) and (SaleBase.Lines.QtySold=0) then begin
      if TfmSlaesPackWeight.DoPackWeight(Self, SaleBase.Lines) then begin
        grdTransactions.SetActiveField(tblDetailsUnitofMeasureQtySold.FieldName);
      end;
    end;
  //CheckForSalesTaxBasedon(False);
  CheckForSalesTaxBasedon( (fISSalesLineLocked) or (fSalesLocked) );
end;
Procedure TBaseSaleGUI.DoPackWeight;
begin
  if AccessLevel <=3 then
    if SaleBase.Lines.Product.EnablePackWeight then
      if (SaleBase.Lines.ProductID <>0) and IsInvProduct(SaleBase.Lines.ProductType)  then begin
        if TfmSlaesPackWeight.DoPackWeight(Self, SaleBase.Lines) then begin
          grdTransactions.SetActiveField(tblDetailsUnitofMeasureQtySold.FieldName);
        end;
      end;
end;
procedure TBaseSaleGUI.showStock;
begin
  if AccessLevel <> 1 then Exit;
  if SaleBase.TotalQtyBackOrdered = 0 then Exit;
  showStock(SaleBase, Self.Color, ProgressBar , self);
end;

procedure TBaseSaleGUI.cboBaseForeignCurrencyCodeExit(Sender: TObject);
begin
  inherited;
  if cboBaseForeignCurrencyCode.Text = '' then begin { can't be blank }
    cboBaseForeignCurrencyCode.DropDown;
    SetControlFocus(cboBaseForeignCurrencyCode);
  end;
end;

procedure TBaseSaleGUI.cboEmployeeExit(Sender: TObject);
begin
  inherited;
  if cboEmployee.Text = '' then begin { can't be blank }
    cboEmployee.DropDown;
    SetControlFocus(cboEmployee);
  end;
end;

procedure TBaseSaleGUI.btnRefNoClick(Sender: TObject);
begin
  inherited;
  if accesslevel >3 then begin
    MessageDlgXP_Vista('Sales Order is Read-Only, It is not Possible to Change the Reference No', mtInformation, [mbOK], 0);
    Exit;
  end;
   if TfmSalesExt.ShowIt(Self) then begin
    if (Salebase.referenceno <> '') and (Salebase.DefaultReferenceNoinAllLines) and (Salebase.Lines.count >0)   then
        if MessageDlgXP_vista('Do You Want to Change the Reference Number in the Exisitng Lines? ', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          Salebase.UpdateAllLinesRefNo;
   end;

end;

procedure TBaseSaleGUI.btnRepairEquipmentClick(Sender: TObject);
var
  SavedAccessLevel: Integer;
  function ROMsg: string;
  begin
    if SaleBase.RepairID <> 0 then Result := 'Already converted to Repair'
    else if SaleBase.IsInvoice then Result := 'Converted Repair'
    else Result := '';
  end;

begin
  inherited;
  SaleBase.PostDB;
  if SaleBase.customerid = 0 then begin
    CommonLib.MessageDlgXP_Vista('Customer has not been selected', mtInformation, [mbOK], 0);
    Exit;
  end;
  SavedAccessLevel := Self.AccessManager.AccessLevel;
  try
    if not Assigned(RepairequipmentForm) then begin
      RepairequipmentForm := TfmEquipmentxRef.CreateEquipmentxREf(Self, tblEquipmentxRefs, (SaleBase.RepairID <> 0) or (SaleBase.IsInvoice), ROMsg, SaleBase.clientID, 96);
      RepairequipmentForm.EquipmentxRef := TEquipmentxRef(SaleBase.RepairEquipment);
    end;
    if not Assigned(RepairequipmentForm) then Exit;
    if RepairequipmentForm.Visible then RepairequipmentForm.Hide;
    RepairequipmentForm.showModal;
  finally AccessManager.AccessLevel := SavedAccessLevel;
  end;
end;

procedure TBaseSaleGUI.btnShipmentClick(Sender: TObject);
begin
  self.DoShipments;
end;

procedure TBaseSaleGUI.SetHint;
begin
  txtShipTo.hint := 'Double Click for Address List';
  txtShipTo.showhint := true;
end;


function TBaseSaleGUI.getcontactType: TContactType;
begin
  Result := tcustomercontact;
end;

procedure TBaseSaleGUI.showdiscount;
var
  I: Integer;
begin
  I := -1;
  try
         if tblDetails.findfield('Discounts').Visible       then I := tblDetails.findfield('Discounts').Index
    else if tblDetails.findfield('DiscountPercent').Visible then I := tblDetails.findfield('DiscountPercent').Index
    else if tblDetails.findfield('Markup').Visible          then I := tblDetails.findfield('Markup').Index
    else if tblDetails.findfield('MarkupPercent').Visible   then I := tblDetails.findfield('MarkupPercent').Index
    else if tblDetails.findfield('Margin').Visible          then I := tblDetails.findfield('Margin').Index
    else if tblDetails.findfield('MarginPercent').Visible   then I := tblDetails.findfield('MarginPercent').Index;
  except
    // kill the exception
  end;

  if Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'Discounts'        ) then Setcolumn(Appenv.CompanyPrefs.ShowSalesDiscount, 'Discounts')        else Setcolumn(False, 'Discounts');
  if Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'DiscountPercent'  ) then Setcolumn(Appenv.CompanyPrefs.ShowSalesDiscount, 'DiscountPercent')  else Setcolumn(False, 'DiscountPercent');
  if Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'Markup'           ) then Setcolumn(Appenv.CompanyPrefs.ShowSalesDiscount, 'Markup')           else Setcolumn(False, 'Markup');
  if Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'MarkupPercent'    ) then Setcolumn(Appenv.CompanyPrefs.ShowSalesDiscount, 'MarkupPercent')    else Setcolumn(False, 'MarkupPercent');

  if I >= 0 then
    if Appenv.CompanyPrefs.DefaultDiscountMarkup <> '' then tblDetails.findfield(Appenv.CompanyPrefs.DefaultDiscountMarkup).Index := I;
end;

procedure TBaseSaleGUI.showSaleSPricecolumns;
begin
  Setcolumn(Appenv.CompanyPrefs.ShowSalesCostInc, 'LineCostInc');
  Setcolumn(Appenv.CompanyPrefs.ShowSalesCostInc, 'LineCost');
  Setcolumn(Appenv.CompanyPrefs.ShowPurchasecostinSales, 'PurchaseCost');
  Setcolumn(Appenv.CompanyPrefs.ShowLatestCost, 'LatestCostPrice');
  Setcolumn(Appenv.CompanyPrefs.ShowLatestCost, 'LatestCostPriceInc');

end;

procedure TBaseSaleGUI.Showcontribution;
var
  fbshow: Boolean;
begin
  fbshow := (Appenv.CompanyPrefs.EnablequoteVariation);
  if fbshow then fbshow := ((SaleBase is TQuote) or (SaleBase.Quoteglobalref <> '') and (SaleBase.QuoteSale.relatedSales.Count > 0));
  edtContributionAmount.Visible := fbshow;
  lblContributionAmount.Visible := fbshow;
  lblApprovedAmount.Visible := fbshow;
  edtApprovedAmount.Visible := fbshow;
end;


procedure TBaseSaleGUI.ShowcustomisableColumns;
begin
  { Showing/hiding the warranty fields based on the preference
    change the caption of the warranty fields based on the Preference }
  Setcolumn(Appenv.CompanyPrefs.ShowSalesWarrantyEndsOn, 'WarrantyEndsOn');
  Setcolumn(Appenv.CompanyPrefs.ShowSalesWarrantyPeriod, 'WarrantyPeriod');

  if Trim(Appenv.CompanyPrefs.SalesWarrantyEndsOnCaption) <> '' then grdTransactions.ColumnByName('WarrantyEndsOn').DisplayLabel := Trim(Appenv.CompanyPrefs.SalesWarrantyEndsOnCaption);

  if Trim(Appenv.CompanyPrefs.SalesWarrantyPeriodCaption) <> '' then grdTransactions.ColumnByName('WarrantyPeriod').DisplayLabel := Trim(Appenv.CompanyPrefs.SalesWarrantyPeriodCaption);
end;

procedure TBaseSaleGUI.ShowFC;
begin
  Setcolumn(Appenv.CompanyPrefs.UseForeignCurrencyOnSales, 'ForeignExchangeSellCode');
  Setcolumn(Appenv.CompanyPrefs.UseForeignCurrencyOnSales, 'ForeignCurrencyLinePrice');
end;

procedure TBaseSaleGUI.ShowFormulafields;
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
            Appenv.CompanyPrefs.Fe5Visible ,
            tblDetailsFormulaQtySoldValue.fieldname ,
            'Formula ' + tbldetailsUnitofMeasureQtySold.displaylabel );

  Setcolumn(Appenv.CompanyPrefs.Fe1Visible or
            Appenv.CompanyPrefs.Fe2Visible or
            Appenv.CompanyPrefs.Fe3Visible or
            Appenv.CompanyPrefs.Fe4Visible or
            Appenv.CompanyPrefs.Fe5Visible ,tblDetailsFormulaQtyShippedValue.fieldname , 'Formula ' + tbldetailsUnitofMeasureShipped.displaylabel );
end;

procedure TBaseSaleGUI.ShowSpec;
begin
  Setcolumn(Appenv.CompanyPrefs.UseProductSpecsCalcsSales, 'SpecDescription');
  Setcolumn(Appenv.CompanyPrefs.UseProductSpecsCalcsSales, 'SpecValue');
end;

procedure TBaseSaleGUI.ShowStatus(const Value: string);
begin
  inherited;
  if Value <> '' then begin
    { showing message so shrink comments }
    pnlComments.Height := 31;
  end
  else begin
    { message blank so restore comments }
    pnlComments.Height := 53;
  end;
  pnlComments.Top := txtPickMemo.Top - pnlComments.Height - 4;
end;

procedure TBaseSaleGUI.ShowAttrib;
begin
  Setcolumn(Appenv.CompanyPrefs.ShowMeasurementAttributes, 'Attrib1Sale');
  Setcolumn(Appenv.CompanyPrefs.ShowMeasurementAttributes, 'Attrib2Sale');
  Setcolumn(Appenv.CompanyPrefs.ShowMeasurementAttributes, 'Attrib1SaleEst');
  Setcolumn(Appenv.CompanyPrefs.ShowMeasurementAttributes, 'Attrib2SaleEst');
  Setcolumn(Appenv.CompanyPrefs.ShowMeasurementAttributes, 'Attrib1SaleRate');
end;

procedure TBaseSaleGUI.ShowGrossProfit;
begin
  Setcolumn(Appenv.CompanyPrefs.ShowGrossProfitPercent, 'CalcGrossProfitPercentInc');

  Setcolumn(Appenv.CompanyPrefs.ShowGrossProfitPercent, 'GrossProfitbasedLatestCostPercentInc');
end;

procedure TBaseSaleGUI.showsupplier;
begin
  Setcolumn(Appenv.CompanyPrefs.ShowSupplieronSO, 'Supplier');
  if Appenv.CompanyPrefs.ShowSupplieronSO then qrySupplier.Open;
  Setcolumn(Appenv.CompanyPrefs.ShowSupplierContactonSO, 'SupplSupplierContactier');
end;

procedure TBaseSaleGUI.SmartPurchaseOrders1Click(Sender: TObject);
begin
  inherited;
  SmartPOList;
end;
procedure TBaseSaleGUI.BeforeOpenSalesSmartPOList(Sender: TObject);
begin
    if not(Sender is TSalesSmartPOListGUI) then exit;
    TSalesSmartPOListGUI(Sender).salesRef:= SaleBase.Globalref;
          if sameText(SaleBase.XMLNodeName, 'quote')   then TSalesSmartPOListGUI(Sender).Salestype :='Quote'
    else  if sameText(SaleBase.XMLNodeName, 'Invoice') then TSalesSmartPOListGUI(Sender).Salestype :='Invoice'
    else  if sameText(SaleBase.XMLNodeName, 'SalesOrder')   then TSalesSmartPOListGUI(Sender).Salestype :='Sales Order';
end;
procedure TBaseSaleGUI.SkipReadonlyfield;
begin
  inherited;
  if GrdTransactions.Columnbyname(GrdTransactions.GetActiveField.FieldName).readonly or tbldetails.FindField(GrdTransactions.GetActiveField.FieldName).readonly or (accesslevel >3) then begin
    GrdTransactions.Options := GrdTransactions.Options - [Wwdbigrd.dgEditing];
  end else begin
    GrdTransactions.Options := GrdTransactions.Options + [Wwdbigrd.dgEditing];
  end;

end;

procedure TBaseSaleGUI.SmartPOList;
begin
   OpenERPListForm('TSalesSmartPOListGUI' , BeforeOpenSalesSmartPOList);
end;
procedure TBaseSaleGUI.showCC;
begin
  Setcolumn(Appenv.CompanyPrefs.UseCostCentres, 'CostCentreName');
  if Appenv.CompanyPrefs.UseCostCentres then qryCostCentre.Open;
end;


procedure TBaseSaleGUI.ReadFeSaleslines;
begin
  SaleBase.Lines.FESalesLines;
end;

function TBaseSaleGUI.FieldsToExecludeFromsorting: string;
begin
  Result := 'grdTransactions:UnitofMeasureShipped;' + 'grdTransactions:UnitOfMeasureBackOrder;' + inherited FieldsToExecludeFromsorting;
end;

class function TBaseSaleGUI.showStock(SaleObj: TSales; FColor: Tcolor; ProgressBar: TProgressBar = nil; aOwnerform:Tform=nil): Boolean;
begin
  ProcessingCursor(true);
  try
    result := DoshowStock(SaleObj,FColor,ProgressBar,aOwnerform) ;
  finally
    Processingcursor(False);
  end;
end;

class function TBaseSaleGUI.DoshowStock(SaleObj: TSales; FColor: Tcolor; ProgressBar: TProgressBar = nil; aOwnerform:Tform=nil): Boolean;
var
  Form: TfmStockStatus;
  BOLineIDs:TIntegerList;
  Msg:String;
begin
  Result := False;

  if MessageDlgXP_vista('This will save the current changes. Do you wish to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;
  if not SaleObj.Save then exit;
  SaleObj.Connection.CommitTransaction;
  try
      SaleObj.Connection.BeginTransaction;
      BOLineIDs:= TIntegerList.Create;
      try
        Form := TfmStockStatus(GetComponentByClassName('TfmStockStatus', true, nil, False));
        if Assigned(Form) then
          if Form.Visible then Exit;
        try
          Form.Color := FColor;
          Form.SaleID   := SaleObj.ID;
          Form.SaleDate := SaleObj.saledatetime;
          Form.ProgressBar := ProgressBar;
          Form.connection := TErpconnection(SaleObj.connection.connection);
          Form.showModal;
        finally
          if Form.ModalResult = mrOK then begin
            (*SaleObj.Connection.CommitTransaction;
            try*)
                  with Form.Qrymain do begin
                    Filter := 'ShipmentOption <> "D"';
                    Filtered := true;
                    if RecordCount > 0 then begin
                      First;
                      while Eof = False do begin
                        if SaleObj.Lines.DataSet.Locate('SaleLineID', FieldByName('SaleLineId').AsInteger, []) then begin
                          if FieldByName('ShipmentOption').AsString = 'C' then begin
                            SaleObj.Lines.UOMQtyShipped := SaleObj.Lines.UOMQtySold
                          end
                          else if FieldByName('ShipmentOption').AsString = 'R' then begin
                            if FieldByName('Received').AsFloat > 0 then SaleObj.Lines.UOMQtyShipped := FieldByName('Received').AsFloat;
                          end
                          else if FieldByName('ShipmentOption').AsString = 'A' then begin
                            if FieldByName('EnoughStock').asBoolean then SaleObj.Lines.UOMQtyShipped := SaleObj.Lines.UOMQtySold
                            else if FieldByName('UOMAvailableStock').AsFloat > 0 then SaleObj.Lines.UOMQtyShipped := FieldByName('UOMAvailableStock').AsFloat;
                          end;
                          SaleObj.Lines.PostDB;
                        end;
                        Next;
                      end;
                    end;

                    SaleObj.CrossStockAdjustTransForinvoice := True;
                    try
                      BOLineIDs.Clear;
                      try
                        Filter := 'DocheckDepartments = "T"';
                        Filtered := true;
                        if RecordCount > 0 then begin
                          First;
                          While EOF = False do begin
                            if SaleObj.Lines.DataSet.Locate('SaleLineID', FieldByName('SaleLineId').AsInteger, []) then begin
                              if SaleObj.Lines.UOMQtyBackOrder >0 then begin
                                {not possible to do transfer of bin/batch/sn product when EnforceAllocationValidation is selected}
                                if not(Appenv.CompanyPrefs.EnforceAllocationValidation) Or ((SaleObj.Lines.Product.batch=False) and (SaleObj.Lines.Product.MultipleBins=False) and (SaleObj.Lines.Product.SNTracking=False)  ) then
                                  BOLineIDs.Add(SaleObj.Lines.ID);
                              end;
                            end;
                            Next;
                          end;
                        end;
                      finally
                        if BOLineIDs.count>0 then begin
                          CheckandShipFromOtherDepts(SaleObj , BOLineIDs, Msg, Form.StockFromOtherClassId , Form.chkuseDefaultStockClassID.checked);
                        end;
                      end;


                      BOLineIDs.Clear;
                      try
                        Filter := 'DoCrosscheckCompanies = "T"';
                        Filtered := true;
                        if RecordCount > 0 then begin
                          First;
                          While EOF = False do begin
                            if SaleObj.Lines.DataSet.Locate('SaleLineID', FieldByName('SaleLineId').AsInteger, []) then begin
                              if SaleObj.Lines.UOMQtyBackOrder >0 then begin
                                {not possible to do transfer of bin/batch/sn product when EnforceAllocationValidation is selected}
                                if not(Appenv.CompanyPrefs.EnforceAllocationValidation) Or ((SaleObj.Lines.Product.batch=False) and (SaleObj.Lines.Product.MultipleBins=False) and (SaleObj.Lines.Product.SNTracking=False)  ) then
                                  BOLineIDs.Add(SaleObj.Lines.ID);
                              end;
                            end;
                            Next;
                          end;
                        end;
                      finally
                        if BOLineIDs.count>0 then begin

                          CheckCrossStockCompanies(SaleObj , BOLineIDs, Msg , aOwnerform );
                        end;
                      end;
                    finally
                      SaleObj.CrossStockAdjustTransForinvoice := false;
                    end;
                  end;
                  if SaleObj.Save then Result := true;
                  SaleObj.Dirty := True;
              if msg <> '' then
                MessageDlgXP_Vista('Quantity Adjusted for This Sale from Other ' + Appenv.DefaultClass.classheading +'  / Companies.'+NL+NL+Msg, mtInformation, [mbOK], 0);
          end;
          Freeandnil(Form);
        end;
      finally
        Freeandnil(BOLineIDs);
      end;
  finally
    SaleObj.Connection.BeginTransaction;
  end;
end;
procedure TBaseSaleGUI.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Screen.Activecontrol = grdTransactions then begin
    if SameText(Activefieldname, tblDetailsUnitofMeasureQtySold.FieldName) or SameText(Activefieldname, tblDetailsUnitofMeasureShipped.FieldName) then begin
      If (Key = VK_F8) and (accesslevel =1 ) then
        if Appenv.CompanyPrefs.EnableAutoSplitQtyintoUOMinSales then
          if Salebase.lines.product.EnableAutoSplitQtyintoUOMinSales then begin
            Salebase.lines.PostDB;
            if   (Salebase.lines.UOMQtySold <> 0) and
                ((trunc(divzer(Salebase.lines.UOMQtySold, Salebase.lines.UOMMultiplier)) <> divzer(Salebase.lines.UOMQtySold, Salebase.lines.UOMMultiplier)) or (Salebase.lines.UOMMultiplier=1)) then begin
              Key :=0;
              DoAutoSplitQty;
              Exit;
            end;
          end;
    end else if SameText(Activefieldname, tblDetailslineprice.FieldName) or SameText(Activefieldname, tblDetailslinepriceinc.FieldName) or SameText(Activefieldname, tblDetailstotallineamount.FieldName) or SameText(Activefieldname, tblDetailstotallineamountinc.FieldName) then begin
      if Key = VK_F7 then begin
        DoShowExcelPrice(mnuShowExcelPrice);
      end;
    end;
  end;
    if Key = VK_F12 then begin
      ShowRPDetailsForm;
      exit;
    end;
  if ((Key = VK_ESCAPE) or (Key = 0)) and (ActiveControl = cboProductR) then cboProductR.Text := '';
end;

procedure TBaseSaleGUI.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Shift = [ssCtrl]) then begin
    if Chr(Key) = 'A' then begin
      SelectAllLines;
    end;
  end;
end;
procedure TBaseSaleGUI.FormResize(Sender: TObject);
begin
  inherited;
  pnlShipToMessage.Left := txtShipTo.Left + 2;
  pnlShipToMessage.Width := txtShipTo.Width - 2;
  pnlShipToMessage.Top := txtShipTo.Top + txtShipTo.Height - pnlShipToMessage.Height;
  pnlShipToMessage.Color := self.Color;
end;

procedure TBaseSaleGUI.OnGuiPrefsActive(Sender: TObject);
begin
  inherited;
end;

procedure TBaseSaleGUI.OnSelectPoints(Sender: TObject);
begin
  inherited OnSelectPoints(Sender);
  showRedeemPoints(SaleBase.SaleDate);

end;

Procedure TBaseSaleGUI.HideProductsourceOption(sender :TObject);
begin
  Appenv.Employee.ManufacturePartSourceStockconfirm := not(TCheckBox(Sender).Checked);
end;

function TBaseSaleGUI.ConfirmForPOcost: Boolean;
begin
  result := True;
  if not Appenv.CompanyPrefs.ShowPurchasecostinSales then Exit;

  if  SaleBase.AnylineHasPurchaseCost then
        result := CommonLib.MessageDlgXP_Vista('"SMO To Cost" Given will be Copied into The Smart Order/Purchase Order'+NL+
                                  'Product Cost / Supplier''s Special discounts will be Ignored.'+NL+NL+
                                  'Do you Want to Continue?' , mtConfirmation, [mbyes,mbNo] , 0) = mryes;

end;

procedure TBaseSaleGUI.ConfirmPartSource;
var
  s: string;
  Defaultbutton :Integer;
begin
  if Self is TInvoiceGUI then begin
    SaleBase.UserConfirmedPartsourceStock := true;
  end else begin
    s := 'Available Quantity : ' + FloatToStr(SaleBase.Lines.Product.TotalQtyAvailable) + chr(13) + 'Instock Quantity   : ' + FloatToStr(SaleBase.Lines.Product.TotalQtyInStock) + chr(13) +
      'On Order Quantity  : ' + FloatToStr(SaleBase.Lines.Product.TotalQtyOnOrder) + chr(13) + chr(13) + 'Do you Wish To Take Quantity Out of Stock or Manufacture the ' +
      SaleBase.Lines.Product.ProductName + '?';
    Defaultbutton :=2;
    if AppEnv.CompanyPrefs.ManufacturePartSourceStock then Defaultbutton :=1;
      InitMsgParams;
      PopupMsgParams.Msgcaption    :='Product Name       : ' + SaleBase.Lines.Product.ProductName;
      PopupMsgParams.MsgText       := s;
      PopupMsgParams.Custombuttons :='"Take From Stock","Manufacture"';
      PopupMsgParams.Msg1          :='Product Source';
      PopupMsgParams.Msg2          :='What Do You Want to Do With This Product?';
      PopupMsgParams.MsgLeft       :=0;
      PopupMsgParams.MsgTop        :=Self.Top;
      PopupMsgParams.Defaultbutton :=Defaultbutton;
      PopupMsgParams.MsgHeight     :=300;
      PopupMsgParams.MsgColor      :=$00FFFFD7;
      PopupMsgParams.ChkCaption    :='Hide Product Source Option';
      PopupMsgParams.checked       := False;
      PopupMsgParams.chkclick      := HideProductsourceOption;
      SaleBase.UserConfirmedPartsourceStock := TfmMessage.MsgDlg = 100;
  end;
end;


procedure TBaseSaleGUI.grdTransactionsEnter(Sender: TObject);
begin
  ShowNoCustomerWarning;
  unlockSalesLine(False);
  inherited;
end;

function TBaseSaleGUI.SalesShippingDetailForm: TfmSalesShippingDetail;
begin
  if not(Assigned(fSalesShippingDetailForm)) then begin
    fSalesShippingDetailForm := TfmSalesShippingDetail.Create(Self, SaleBase);
  end;
  Result := fSalesShippingDetailForm;
end;

function TBaseSaleGUI.SaveSalesRecord: Boolean;
begin
  result := True;
end;

function TBaseSaleGUI.SaveTrans: Boolean;
begin
  Result :=SaveSalesRecord;
end;

function TBaseSaleGUI.SaveTransToPDF: boolean;
begin
  REsult:= False;
  ReportToPrint := '';
  if not SaveSalesRecord then Exit;
  CommitAndNotify;
  try
    try
      Result := inherited;
    except
      on E:Exception do begin
          commonlib.MessageDlgXP_Vista('Save to PDF failed.' + #13#10 + #13#10 + E.Message , mtWarning, [mbok] , 0);
      end;
    end;
  finally
    self.BeginTransaction;
  end;
end;

function TBaseSaleGUI.ProductDisabledCustomFields: string;
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

procedure TBaseSaleGUI.PopulateMessageSubstituteList(SL: TStringList);
begin
  self.SaleBase.PopulateMessageSubstituteList(SL);
end;

procedure TBaseSaleGUI.PrintAddressLabel;
begin
  if SaleBase.NoOfBoxes = 0 then Exit;
  (*strSQL := '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, ' + ' CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber,  ' +
    ' Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO ' + ' ~|||~{Details}' + AddressLabelSQL((NoOfBoxes);*)
  fbReportSQLSupplied := true;
  try
    PrintTemplateReport('Address Labels', SalesAddressLabelSQL(SaleBase.NoOfBoxes, SaleBase.id), not Appenv.Employee.ShowPreview, 1);
  finally fbReportSQLSupplied := False;
  end;
end;


procedure TBaseSaleGUI.PrintSalesDispatchBarcode(Sender: TObject);
var
  sSQL:String;
  Json: TJsonObject;
begin
  inherited;
  ReportToPrint := '';
  if chkChooseRpt.Checked then begin
    LoadReportTypes('Sales Dispatch Barcode');
    if not dlgReportSelect.Execute then Exit;
    ReportToPrint := dlgReportSelect.SelectedItems.Text;
  end;
  if ReportToPrint = '' then ReportToPrint := GetDefaultReport('Sales Dispatch Barcode');
  if ReportToPrint = '' then ReportToPrint := 'Sales Dispatch Barcode';
  if ReportToPrint = '' then Exit;

  if SaveSalesRecord then begin
    self.CommitAndNotify;
    try
      salebase.Dirty:= false;
      try
        sSQL:= SalesDispatchBarcodeSQL(inttostr(Salebase.ID) , '' , '' );
        fbReportSQLSupplied := True;
        Json:= JO;
        try
            Json.O['0'].S['master']:= 'Details';
            Json.O['0'].S['detail']:= 'RelatedParts';
            Json.O['0'].S['masterfields']:='PQADetailID';
            Json.O['0'].S['detailfields']:= 'slpqad.PQADetailID';
            PrintTemplateReport(ReportToPrint,sSQL , PrintReport(nil) , 1  ,Json );
        finally
          Json.Free;
        end;
      finally
        ReportToPrint := '';
      end;
    finally
        self.BeginTransaction;
    end;
  end;
end;

procedure TBaseSaleGUI.cboTaxCodeDropDown(Sender: TObject);
begin
  inherited;
  if SaleBase.Lines.ProductID = 0 then Abort;
end;

procedure TBaseSaleGUI.cboUnitOfMeasureDropDown(Sender: TObject);
begin
  inherited;
  if SaleBase.Lines.ProductID = 0 then Abort;
end;

procedure TBaseSaleGUI.cboViaChange(Sender: TObject);
begin
  inherited;
  if not cboVia.Focused then exit;

  if SameText(cboVia.Text, 'Quote') then
    DoGetShippingRates;
end;

procedure TBaseSaleGUI.cboViaCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if SameText(cboVia.Text, 'Shipment Rate Quote') then
    DoGetShippingRates;
end;

procedure TBaseSaleGUI.cboCostCentreDropDown(Sender: TObject);
begin
  inherited;
  if SaleBase.Lines.ProductID = 0 then Abort;
end;

procedure TBaseSaleGUI.cboCurrentStatusNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if not(CanCreateSalesStatus) then begin
    MessageDlgXP_Vista('You are not Allowed to Create New Status', mtInformation, [mbOK], 0);
    Accept := False;
    Exit;
  end;
  inherited cboCurrentStatusNotInList(Sender,LookupTable,NewValue,Accept);
end;

procedure TBaseSaleGUI.cboSupplierDropDown(Sender: TObject);
begin
  inherited;
  if SaleBase.Lines.ProductID = 0 then Abort;
end;

procedure TBaseSaleGUI.cboPartSpecsDropDown(Sender: TObject);
begin
  inherited;
  if SaleBase.Lines.ProductID = 0 then Abort;
end;

procedure TBaseSaleGUI.unlockSalesLine(Inserting:Boolean);
var
  fbLineEditable: Boolean;
  function LineEditable: Boolean;
  begin
    Result := true;
    if Inserting then exit;
    if AccessLevel >= 5 then Result := False
    else if (SaleBase.Lines.cleanId <> 0) and (AccessLevel > 3) then Result := False
    else if (SaleBase.Lines.cleanId <> 0) and (IstransLineLocked) then Result := False;
  end;

begin
  fbLineEditable := LineEditable;
  tblDetailsUnitofMeasureShipped.Readonly     := not fbLineEditable;
  tblDetailsUnitofMeasureQtySold.Readonly     := not fbLineEditable;
  tblDetailsUnitofMeasureSaleLines.Readonly   := not fbLineEditable;
  tblDetailsProductName.Readonly              := not fbLineEditable;
  tblDetailsProductID.Readonly                := not fbLineEditable;
  tblDetailsSpecDescription.Readonly          := not fbLineEditable;
  tblDetailsSpecValue.Readonly                := not fbLineEditable;
  grdTransactions.ColumnByName(tblDetailsUnitofMeasureShipped.fieldName).Readonly   := not fbLineEditable;
  grdTransactions.ColumnByName(tblDetailsUnitofMeasureQtySold.fieldName).Readonly   := not fbLineEditable;
  grdTransactions.ColumnByName(tblDetailsUnitofMeasureSaleLines.fieldName).Readonly := not fbLineEditable;
  grdTransactions.ColumnByName(tblDetailsProductName.fieldName).Readonly            := not fbLineEditable;
  grdTransactions.ColumnByName(tblDetailsProductID.fieldName).Readonly              := not fbLineEditable;
  grdTransactions.ColumnByName(tblDetailsSpecDescription.fieldName).Readonly        := not fbLineEditable;
  grdTransactions.ColumnByName(tblDetailsSpecValue.fieldName).Readonly              := not fbLineEditable;
end;
procedure TBaseSaleGUI.Lockcomponents;
begin
  if accesslevel <> 1 then
  else if KeyId =0 then cboClass.ReadOnly := False
  else if not(CanChangeDeptSales) then cboClass.ReadOnly := True
  else cboClass.ReadOnly := False;
end;

procedure TBaseSaleGUI.tblDetailsBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  unlockSalesLine(true);
end;
procedure TBaseSaleGUI.tblDetailsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  //MakepackweightFields(Salebase.SalesLinePackWeightSum.dataset);
end;

procedure TBaseSaleGUI.mnuAlternateProductClick(Sender: TObject);
begin
  if SaleBase.Lines.ProductID=0 then begin
    MessageDlgXP_vista('Select the Product ', mtInformation, [mbOK], 0);
    Exit;
  end;
  OpenERPListFormModal('TAlternateProductSearchGUI' , ReplaceProductWtihAlternateProduct, BeforeShowAlternateProductsGUI);
end;
procedure TBaseSaleGUI.OpenAlternateProductListtoReplace;
begin
  OpenERPListFormModal('TAlternateProductSearchGUI' , AddAlterNateProduct, BeforeShowAlternateProductsGUI);
end;
procedure TBaseSaleGUI.ReplaceProductWtihAlternateProduct(Sender: TwwDbGrid);
var
  fbDoFieldChangewhenDisabled: Boolean;
  fid: Integer;
  fShipped,  fSold : double;
begin
  fid := SaleBase.Lines.ID;
  try
    SaleBase.Lines.PostDb;
    SaleBase.Lines.AddingAlternateProduct := true;
    try
      fbDoFieldChangewhenDisabled := SaleBase.Lines.DoFieldChangewhenDisabled;
      SaleBase.Lines.DoFieldChangewhenDisabled := true;
      try
      SaleBase.Lines.ignoreCheckSaveSpecialPrice := true;
      try
       fSold := SaleBase.Lines.QtySold;
       fSHipped := SaleBase.Lines.QtyShipped;
             if Sender.Datasource.DataSet.findfield('AlternateProductID') <> nil then SaleBase.Lines.ProductID := Sender.Datasource.DataSet.FieldByName('AlternateProductID').AsInteger
        else if Sender.Datasource.DataSet.findfield('PartsId')            <> nil then SaleBase.Lines.ProductID := Sender.Datasource.DataSet.FieldByName('PartsId').AsInteger
        else if Sender.Datasource.DataSet.findfield('ProductID')          <> nil then SaleBase.Lines.ProductID := Sender.Datasource.DataSet.FieldByName('ProductID').AsInteger;

             if Sender.Datasource.DataSet.findfield('AlternateProductName')<> nil then SaleBase.Lines.ProductName := Sender.Datasource.DataSet.FieldByName('AlternateProductName').AsString
        else if Sender.Datasource.DataSet.findfield('Partname')            <> nil then SaleBase.Lines.ProductName := Sender.Datasource.DataSet.FieldByName('Partname').AsString
        else if Sender.Datasource.DataSet.findfield('ProductName')         <> nil then SaleBase.Lines.ProductName := Sender.Datasource.DataSet.FieldByName('ProductName').AsString;

        SaleBase.Lines.QtySold := fSold;
        if SaleBase.Lines.QtyShipped <> fShipped then
          SaleBase.Lines.QtyShipped := fShipped;
        SaleBase.Lines.UOMQtySold := Round(DivZer(SaleBase.Lines.QtySold, SaleBase.Lines.UOMMultiplier), SaleBase.Lines.RoundPlacesGeneral);

        SaleBase.Lines.PostDB;
      finally
        SaleBase.Lines.ignoreCheckSaveSpecialPrice := false;
      end;
      finally SaleBase.Lines.DoFieldChangewhenDisabled := fbDoFieldChangewhenDisabled;
      end;
    finally
      SaleBase.Lines.AddingAlternateProduct := False;
    end;
  finally
    if SaleBase.Lines.Locate(SaleBase.Lines.Idfieldname, fid, []) then begin
      if (Appenv.CompanyPrefs.ReplaceDiscontinuedwithAlternate) and (SaleBase.Lines.QtySold =0) then begin
          SaleBase.Lines.Deleted := True;
          SaleBase.Lines.PostDB;
      end;
    end;
  end;
end;
procedure TBaseSaleGUI.AddAlterNateProduct(Sender: TwwDbGrid);
var
  fbDoFieldChangewhenDisabled: Boolean;
  fid: Integer;
  fLinePrice :double;
begin
  fid := SaleBase.Lines.ID;
  try
    SaleBase.Lines.PostDb;
    fLinePrice :=SaleBase.Lines.lineprice;
    SaleBase.Lines.AddingAlternateProduct := true;
    try
      fbDoFieldChangewhenDisabled := SaleBase.Lines.DoFieldChangewhenDisabled;
      SaleBase.Lines.DoFieldChangewhenDisabled := true;
      try
        SaleBase.Lines.New;
             if Sender.Datasource.DataSet.findfield('AlternateProductID') <> nil then SaleBase.Lines.ProductID := Sender.Datasource.DataSet.FieldByName('AlternateProductID').AsInteger
        else if Sender.Datasource.DataSet.findfield('PartsId')            <> nil then SaleBase.Lines.ProductID := Sender.Datasource.DataSet.FieldByName('PartsId').AsInteger
        else if Sender.Datasource.DataSet.findfield('ProductID')          <> nil then SaleBase.Lines.ProductID := Sender.Datasource.DataSet.FieldByName('ProductID').AsInteger;

             if Sender.Datasource.DataSet.findfield('AlternateProductName')<> nil then SaleBase.Lines.ProductName := Sender.Datasource.DataSet.FieldByName('AlternateProductName').AsString
        else if Sender.Datasource.DataSet.findfield('Partname')            <> nil then SaleBase.Lines.ProductName := Sender.Datasource.DataSet.FieldByName('Partname').AsString
        else if Sender.Datasource.DataSet.findfield('ProductName')         <> nil then SaleBase.Lines.ProductName := Sender.Datasource.DataSet.FieldByName('ProductName').AsString;

        SaleBase.Lines.QtySold := SaleBase.Lines.QtyrequiredforAlternateProduct;
        SaleBase.Lines.UOMQtySold := Round(DivZer(SaleBase.Lines.QtySold, SaleBase.Lines.UOMMultiplier), SaleBase.Lines.RoundPlacesGeneral);
        SaleBase.Lines.QtyrequiredforAlternateProduct := 0;
        if (fLinePrice<> 0) and (Appenv.companyprefs.UseDiscontinuedProductPriceforAlternateProduct) then
            SaleBase.Lines.lineprice := fLinePrice;

        SaleBase.Lines.PostDB;
      finally SaleBase.Lines.DoFieldChangewhenDisabled := fbDoFieldChangewhenDisabled;
      end;
    finally SaleBase.Lines.AddingAlternateProduct := False;
    end;
  finally
    if SaleBase.Lines.Locate(SaleBase.Lines.Idfieldname, fid, []) then begin
      if (Appenv.CompanyPrefs.ReplaceDiscontinuedwithAlternate) and (SaleBase.Lines.QtySold =0) then begin
          SaleBase.Lines.Deleted := True;
          SaleBase.Lines.PostDB;
      end;
    end;
  end;
end;
procedure TBaseSaleGUI.InitERPLookupCombonFields;
begin
  inherited;
  SetupProductNamenPrintNameinGrid(cboProductR ,cboPrintProductR ,'ProductName' , 'ProductPrintName' , 'PARTSDESCRIPTION' , grdTransactions );
end;
procedure TBaseSaleGUI.tblMasterBeforeClose(DataSet: TDataSet);
begin
  inherited;
  SaleBase.SalesLinePackWeightSum.Closedb;
end;


procedure TBaseSaleGUI.tblMasterBeforeOpen(DataSet: TDataSet);
var
  fs:String;
begin
  inherited;
  fs:=OriginalSalesDocNumber(KeyID);
  closedb(qrySalesSeqno);
  qrySalesSeqno.parambyname('OriginalNo').asString := fs;
  qrySalesSeqno.parambyname('SaleID').asInteger := KeyID;
  Opendb(qrySalesSeqno);

  closedb(qrySaleLookup);
  qrySaleLookup.parambyname('OriginalNo').asString := fs;
  Opendb(qrySaleLookup);

end;

procedure TBaseSaleGUI.doShowPrepayments(Sender: TObject);
begin
// descendants will override
end;
procedure TBaseSaleGUI.OpenPrepaylist;
begin
    if Salebase.dirty then
      if MessageDlgXP_Vista('This Will Save The Changes and Close Sales Order.  Do You Wish To Proceed?' , mtConfirmation, [mbyes,mbno],0) = mrno then exit;

    if not SaveSalesRecord then exit;
    DEtachAll;
    CommitAndNotify;
    openERPlistform('TSalesPrepaymentsGUI' , SalesPrepaymentbeforeopen);

    Self.Close;
end;
procedure TBaseSaleGUI.SalesPrepaymentbeforeopen(Sender: TObject);
begin
     if not(sender is TSalesPrepaymentsGUI) then exit;
     TSalesPrepaymentsGUI(Sender).Originalno := Salebase.OriginalDocNumber;
end;

procedure TBaseSaleGUI.btnShowDetailsClick(Sender: TObject);
begin
  inherited;
  SaleBase.PostDB;
  SaleBase.Lines.PostDB;
  if Assigned(fSalessummary) then fSalessummary.bringtofront
  else begin
    //OpenERPListForm('TSalesDetailsGUI', initSalesDetails , AfterShowSalesDetails, False, oncloseSalesDetailsList);
    fSalessummary := TfmSaleSummary.ShowSaleSummary(self, SaleBase.Id , SaleBase.classname , TERPConnection(SaleBase.connection.connection ), oncloseSalessummaryList);
    GuiPrefs.Node['Options.ShowSummary'].asBoolean := True;
  end;
end;
procedure TBaseSaleGUI.oncloseSalessummaryList(Sender: TObject);
begin
  if fSalessummary.closebtnclicked then GuiPrefs.Node['Options.ShowSummary'].asBoolean := False;
  fSalessummary := nil;
  Makeitcentralized;
end;

Procedure TBaseSaleGUI.RefreshSalessummary;
begin
  if Assigned(fSalessummary) then
    fSalessummary.RefreshQuery;
end;
Procedure TBaseSaleGUI.InitRefBtn;
var
  fs:String;
begin
  fs:= '';
  try
    fs:= 'Choose to Change the Reference No' +NL+NL;
    if tblMasterReferenceNo.asString = '' then begin fs:= fs + 'No Reference Number is Set Yet'; exit; end;
    fs:= fs + 'Reference No is Set to '+ QuotedStr(tblMasterReferenceNo.asString );
    if tblmasterDefaultReferenceNoinAllLines.asBoolean then fs:= fs +NL+'It is Choosen to Copy the "Reference Number" to Every New Line';
  finally
    Showcontrolhint(btnRefNo , fs);
  end;
end;


procedure TBaseSaleGUI.DoShipmentafterformshow;
begin
  EnabletmrOnshow(2,1);
end;
procedure TBaseSaleGUI.DoAutoShipmentafterformshow;
begin
  EnabletmrOnshow(1,1);
end;
procedure TBaseSaleGUI.tmrOnshowTimer(Sender: TObject);
begin
  inherited; // disables the timer, do not remove
  if fitmrOnshowNo = 1 then begin
    fbAutoshipmentafterformshow := True;
    btnShipment.Click;
  end else if fitmrOnshowNo = 2 then begin
    fbshipmentafterformshow := True;
    btnShipment.Click;
  end;
end;

procedure TBaseSaleGUI.DoShowExcelPrice(Sender: TObject);
begin
  DoShowExcelPrice('P', true , (sender<> nil) and (Sender is TMenuItem));
end;

procedure TBaseSaleGUI.DoShowExcelPrice(SearchFor:String;ShowMsgifExcelPricenotExists:Boolean;OpenExcelsheet:Boolean);
var
  fbpartsforexcelpriceOverrides :Boolean;
  fdpartsforexcelprice:double;
  fbHaspartsforexcelprice:Boolean;
  fdpartsforexcelpriceDefaultQty :Double;
begin
  //if not(Appenv.Companyprefs.HasExcelPrices) then exit;
  if not (HasExcelPriceforProduct(Salebase.lines.ProductID, OpenExcelsheet)) then exit;
  if (SearchFor ='Q') and (  TSalesLine(Salebase.lines).UOMQtySold  <> 0) then exit;
  fdpartsforexcelprice := (*TExcelObj*)ExcelObj.calcpartsforexcelprice(Salebase.lines.ProductId,  fbpartsforexcelpriceOverrides,fbHaspartsforexcelprice, fdpartsforexcelpriceDefaultQty, ShowMsgifExcelPricenotExists, OpenExcelsheet , ExcelObjEvent);
  if not OpenExcelsheet then begin
    if fbHaspartsforexcelprice then begin
      if SearchFor ='P' then begin
        if fdpartsforexcelprice <> 0 then  TSalesLine(Salebase.lines).CalculateLine;
      end else if SearchFor ='Q' then begin
        if fdpartsforexcelpriceDefaultQty <> 0 then  begin
          TSalesLine(Salebase.lines).UOMQtySold := round(fdpartsforexcelpriceDefaultQty,5);
          TSalesLine(Salebase.lines).DofieldonChange(TSalesLine(Salebase.lines).dataset.findfield('UnitofMeasureQtySold'));
        end;
      end;
    end;
  end;
end;
Function TBaseSaleGUI.OnChooseCell(ASender: TObject):Boolean;
begin
  Salebase.Lines.DoBaseLinePricecalc;
(*var
  s:String;
  fbpartsforexcelpriceOverrides:Boolean;
  aPartsForExcelPrice : TPartsForExcelPrice;
  fdpartsforexcelpriceDefaultQty :Double;
begin
  aPartsForExcelPrice :=TPartsForExcelPrice.Create(Self);
  try
    aPartsForExcelPrice.Connection := Salebase.Connection;
    aPartsForExcelPrice.loadSelect('ProductId=' +inttostr(Salebase.lines.ProductId));
    if (aPartsForExcelPrice.count =1) and (aPartsForExcelPrice.PriceRow<>0) and (aPartsForExcelPrice.PriceCol<>0) then begin
          s:= aExcelObj.CellValue(aPartsForExcelPrice.PriceRow,aPartsForExcelPrice.PriceCol);
           if isnumber(s) then begin
              result := strtofloat(s);
              fbpartsforexcelpriceOverrides := aPartsForExcelPrice.ExcelPriceOverrides;
           end else begin
              MessageDlgXP_Vista('Price is not Provided in the Cells Selected',mtWarning, [mbOK], 0);
              Exit;
           end;
           s:= aExcelObj.CellValue(aPartsForExcelPrice.qtyRow,aPartsForExcelPrice.qtyCol);
           if isnumber(s) then begin
              fdpartsforexcelpriceDefaultQty := strtofloat(s);
           end;
    end;
  finally
      freeandnil(aPartsForExcelPrice);
  end;*)
end;
Function TBaseSaleGUI.ExcelObjEvent(sender :TExcelObj ; Eventtype :TExcelObjEventtype):Boolean;
begin
  Result := True;
       if Eventtype =  teoetDblclick          then Result := OnChooseCell(Sender);


end;
end.
