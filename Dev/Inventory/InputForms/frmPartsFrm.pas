unit frmPartsFrm;
{
                                                   o
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/04/05  1.00.01 IJB  Added Foreign Sell Price grid to Extra Sell Price tab.
 28/04/05  1.00.02 IJB  Added Attachments to Miscellaneous tab.
 10/05/05  1.00.04 DJH  Preference support for Hire Prices to be Ex or Inc.
                        Also added Variable Group Option in the Group/Kits Tab.
 10/05/05  1.00.05 DJH  In Quantities Tab, hide delete button when disabled.
 16/05/05  1.00.06 IJB  Changed general price/cost formatting edit and display
                        masks to $0.00###
 16/05/05  1.00.07 DJH  Changed all Grid Delete Button Glyphs, when now disabled
                        a ghosted/shaded image will show.
 *                      Fixed bug in regards to when creating a new product that
                        the default departments are not going into the quantities area.
 17/05/05  1.00.08 DJH  Added a From and To date on Related Parts.  This is used within
                        the Hire Object when creating invoices.
 23/05/05  1.00.09 BJ   IsVariable Check box is moved from the group tab to the
                        main tab
                        Variable Groups can exists without having any product
                        within it.
 25/05/05  1.00.10 IJB  Relabled 'PDA Landed Cost' to 'Landed Cost'.
 26/05/05  1.00.11 BJ   isVariableGroup checkbox should be visible only if the
                        current product is a group.
 08/06/05  1.01.00 ISB  Added Specifications tab under Miscellaneous tab
 10/06/05  1.00.11 BJ   Bug fixed : Quantity tab :Available Quantities shows
                        the sold Quantity too
 27/06/05  1.00.12 BJ   --> Extra Buy Price: When a supplier with blank 'ForeignExchangeSellCode' is
                        selected in 'Extra Buy Price', the supplier form is opened to select the
                        foreign currency for the supplier. The Supplier form is opened with
                        'FocusOnForeignCurrency' set to true to have the foreign currency field as
                        the default control.
                        --> Extra Buy Price : The suppliers already selected for the Product is
                        'filtered out' on 'Dropdown' of the combo to avoid duplicating the supplier
                        for the smae product. It is not possible to have multiple currencies for one
                        supplier at the moment.
                        --> Extra sell price :The currency already being selected for the product is
                        'filtered out' on the 'dropdown' of the combo to avoid duplicating the currency
                        for the same Product.
 04/07/05  1.00.13 IJB  Enabled UserLock object in form create to stop more than
                        one user editing the same product at one time.
 05/07/05  1.00.14 DSP  Added 'IncludeInAnalysis' checkbox.
 06/07/05  1.00.15 BJ   Bug fixed : when a new product is created, records were
                        not getting created in the tblpartqtylines table.
 12/07/05  1.00.17 DSP  Added a check for a change of the 'dblcProductType'
                        combo box name as it is referenced from datAssemblyPart
                        file via a component search
 13/07/05  1.00.18 DSP  Re-enabled form on close if cancelled.
 14/07/05  1.00.19 IJB  Fixed to clear cost/price amounts when "New" button
                        clicked.
 15/07/05  1.00.20 BJ   Serial number is editable. Double click on the serial no
                        if the item is not sold, then shown a popup form to accept the
                        new serial number.
                        NOTE: This tab uses the Serialnumberlist created
                        at run time and the Qrymain(datasource of the grid) is non-editable
                        So the serial number is updated using an updateQry.
                        When the data is 'Saved' or 'Cancelled' in the parts form
                        need to commit/rollback the serial number too.
 29/07/05  1.00.21 BJ   Bug fixed : when a new product is created, records were
                        not getting created in the tblpartqtylines table.
 29/07/05  1.00.22 DSP  1. Bug fixed: Ticking the 'Show All' checkbox caused an
                           SQL error.
                        2. Removed matrix functionality for assembled items.
 01/08/05  1.00.23 DMS  1. Changed edtPart OnChange event to avoid access violation error.
 03/08/05  1.00.24 IJB  Modified User Locking to be table specific.
 04/08/05  1.00.25 IJB  Replaced calls to HandleUnknownException with raise so
                        ExceptionalMagic catches/reports exceptions correctly.
 08/08/05  1.00.26 DSP  The user was asked if they wanted to Save data even when
                        no entries had been made. This has been fixed.
 30/08/05  1.00.27 BJ   Serial no related issues handled.
                        Fixed Prices and qtys validation.
 01/09/05  1.00.28 BJ   If the stock available for a group part,it is not possible to add/delete
                        Parts to the group. Warning message added before insert and ondelete.
 06/09/05  1.00.29 DSP  1. Moved 'HideOnPrint' checkbox to the main tab.
                        2. Changed a comparison 'Cost1 <> Cost1' to 'Cost2 <> Cost1' in
                           BuyQty_Prices.
 01/09/05  1.00.30 BJ   bug fixed : was crashing when trying to add a product to the grp/kit
                        for a vraible grp product which did not have a product init.
 26/09/05  1.00.31 BJ   The serial list's Fixed asset option calls a dynamic procedure
                        defined in here in this form.
 28/09/05  1.00.32 AL   1. Removed columns from grdRelatedParts on Group/Kit Tab
                        2. Hire Prices tab: Added Incurence controls and ADOquery
 11/10/05  1.00.33 MV   Added cboCurrencyCode and qryBuyCurrencyLookup to support
                        the revised foreign currency implementation.
 24/10/05  1.00.34 BJ   Added flag and product specification for Segregated product.
                        Segregated otem is a Group product but the Group/Kit parts
                        are disabled for this product.
 01/11/05  1.00.35 BJ   Added SO unallocated qty and SO-Bo unallocated Qty.
 15/11/05  1.00.36 DSP  Added qryProduct.Post to the UpdateSell_Cost_Percentage
                        procedure.
 24/11/05  1.00.37 DSP  Added a new field called 'Volume'.
 13/12/05  1.00.38 DSP  Added 'Copy' button to allow duplication of a product.
 19/12/05  1.00.39  AL  Removed "Instance", added RegisterClass  *Task306*
 05/01/06  1.00.40  BJ  bug fixed: A group product was not enabling the Group/Kit Grid
                        Group product combo in the build group class is registered for this form
 09/01/06  1.00.41  IJB Modified to update xtraBuy price when user changes
                        Supplier Code on Main tab.
 30/01/06  1.00.42   AL Changed qryQtys SQL to hide inactive departments
 31/01/06  1.00.43  IJB Modified so when user enters Cost or Price Inc values
                        ex price is stored without rounding to ensure correct
                        conversion of stored ex price back to inc.
 28/02/06  1.00.44  DSP Added copy functionality for group/kits and related
                        parts.
 16/03/06  1.00.45  BJ  bug fixed: orgprice1/2/3 were getting values from the .text of the edit compoentn
                        which had a $ sign, changed to get strValue before moving into the field
 21/03/06  1.00.46  AL  Changed SQL of qryTemp in CreateQtyLines to create line for clonned product.
                        Added  call of CreateQtyLines to btnCopyClick;
 21/03/06  1.00.47  AL  Changed TabOrder in Main page' pnlMainHeader
                        ProdType -> 1stColumn -> 2ndColumn -> 3rdColumn -> Product Name -> Desc...
 20/03/06  1.00.48  DSP Added messages to btnGroupCopyClick procedure to inform
                        the user if the product being copied to or from is not a
                        'Group' type.
 03/04/06  1.00.49  BJ  Disabled the serial no tab if the product is not serialised.
                        The tab is displayed with an empty list.
 18/05/06  1.00.50  BJ  UOM introduced in the group items which has the DEFAULT_UOM as the
                        default value.
                        Note :Form doesn;'t allow to change the UOM at the moment, but as the build
                        group business objects uses the UOM so the fields are introduced in the table
 05/07/06  1.00.51  AL  Comented ProcessMessage in Price1Change and Cost1Change
 14/07/06  1.00.52  DSP Fixed bug related to 'Auto Price Update'.
 08/08/06  1.00.53  BJ  1)Volume field's label gets the name of the product as the caption
                        2)For a bin product, if any of the bin is assigned to the product,
                        double click on the bin location grid to drill down into the bin allocation
                        2)For a Batch product, if any of the Batch is creted for the product,
                        double click on the Batch grid to drill down into the Batch allocation
 06/09/06  1.00.54  DSP Changed Application.ProcessMessages in ProductTreeOrder
                        and OpenUnitsOfMeasureQtys to Update.
 07/09/06  1.00.55  DSP Added auto-correction for price fields of qryForeignPrice.
 08/09/06  1.00.56  DSP cboPartLevel1, cboPartLevel2, cboPartLevel3 values were
                        not being cleared when a qryProduct record was deleted
                        (after answering 'No' to a 'Not in list' query for the
                        cboINCOMEACC combo box). This has been fixed.
 02/10/06  1.00.57  BJ  fbCanclose private vareiable is set to false when a subform
                        is opened in modal form and the formclosequery checks for this
                        variable before closing the form.
 23/01/07 1.00.58   BJ  quantity tab shows the onbuild and building qtys
 24/01/07 1.00.59   DSP Removed 'On Hire' from grdPartQtyLines.
}

{ TODO : Form is using the busobj but not completely
Temp solution for processpartsextender :
Product object is not bound to the form query but using the same connection
using the form's dataset in busobj force the dynamic events to the dataset/fields
and that kills the confirmation to change the price2/price3 when price1 is changed}


interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, DBCGrids,
  ComCtrls,AdvOfficeStatusBar, BaseInputForm, Buttons, DNMSpeedButton, wwdblook, wwcheckbox, DNMPanel,
  Grids, Wwdbigrd, Wwdbgrid,  ActnList, BaseListingForm, wwdbdatetimepicker,
  wwclearbuttongroup, wwradiogroup, Menus, AdvMenus, wwdbedit, BaseGrid, AdvGrid,
  kbmMemTable, Math, MemDS, DBAccess, MyAccess,ERPdbComponents, wwSpeedButton, Variants,
  wwDBNavigator, wwclearpanel, SelectionDialog, AppEvnts,
  ProgressDialog, DataState, OleCtrls, Jpeg, PrintDAT, frmAttachments,
  MyQueryLineNo, Shader, frmCustomFieldsFrm,
  dmGUIStylers, busobjbase, frmProductAllocationTree,
  IntegerListObj, ImgList, Wwdotdot, Wwdbcomb, BusObjProductBarcode,
  BusObjCurrency,ProductCommissionList, DNMAction, wwriched,
  AdvObj, frmPartsPriceMatrix, ERPDbLookupCombo, rtflabel, pngimage, CheckLst, ERPSets,
  BusObjProductPicture ,BusObjEquipment , frmHirePricing, HTMLUn2, HtmlView , ProductQtyAdjLib , frmERPHelpDocViewer , Busobjcustomfields,
  Wwdbspin;

const
  SX_SetFocus               = WM_USER + 100;
  SX_UpdateProductSellInfo  = WM_USER + 101;
  SX_BinQtyChangeMsg        = WM_USER + 102;
  SX_BatchQtyChangeMsg      = WM_USER + 103;
  SX_UpdateProductBuyInfo   = WM_USER + 104;

type

  TDutiesRecord = record
    CountryId : integer;
    SupplierId : integer;
    Duty : double;
    Handling : double;
  end;

  TfrmParts = class(TBaseInputGUI)
    pageControl: TPageControl;
    Main: TTabSheet;
    Extra_Buy_Price: TTabSheet;
    Extra_Sell_Price: TTabSheet;
    Customer_History: TTabSheet;
    Supplier_History: TTabSheet;
    RelatedParts: TTabSheet;
    TabSerial: TTabSheet;
    Quantities: TTabSheet;
    qryProduct: TERPQuery;
    qryProductTypeLookup: TERPQuery;
    qryProductTypeLookupDS: TDataSource;
    qryProductDS: TDataSource;
    qryPartName: TERPQuery;
    DSqryPartName: TDataSource;
    cboCOGSAccountQry: TERPQuery;
    cbTaxCodeQry: TERPQuery;
    cbTaxCodeSrc: TDataSource;
    DScboCOGSAccountQry: TDataSource;
    DSClientLookup: TDataSource;
    DScboINCOMEAccountQry: TDataSource;
    cboINCOMEAccountQry: TERPQuery;
    DScboASSETAccountQry: TDataSource;
    cboASSETAccountQry: TERPQuery;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DNMPanel4: TDNMPanel;
    DNMPanel5: TDNMPanel;
    pnlCustHistory: TDNMPanel;
    pnlSuppHistory: TDNMPanel;
    pnlSerials: TDNMPanel;
    cbo_Class_Qry: TERPQuery;
    cboClassSrc: TDataSource;
    cboProductSrc: TDataSource;
    qryProductPARTSID: TAutoIncField;
    qryProductPARTTYPE: TWideStringField;
    qryProductPRODUCTGROUP: TWideStringField;
    qryProductPARTNAME: TWideStringField;
    qryProductPARTSDESCRIPTION: TWideStringField;
    qryProductPURCHASEDESC: TWideStringField;
    qryProductINCOMEACCNT: TWideStringField;
    qryProductASSETACCNT: TWideStringField;
    qryProductCOGSACCNT: TWideStringField;
    qryProductBARCODE: TWideStringField;
    qryProductPRODUCTCODE: TWideStringField;
    qryProductTAXCODE: TWideStringField;
    qryProductPURCHTAXCODE: TWideStringField;
    qryProductPREFEREDSUPP: TWideStringField;
    qryProductSpecialDiscount: TWideStringField;
    qryProductSNTracking: TWideStringField;
    qryProductMultipleBins: TWideStringField;
    qryProductBuyQTY1: TIntegerField;
    qryProductBuyQTY2: TIntegerField;
    qryProductBuyQTY3: TIntegerField;
    qryProductSellQTY1: TIntegerField;
    qryProductSellQTY2: TIntegerField;
    qryProductSellQTY3: TIntegerField;
    qryProductAvgCost: TFloatField;
    qryProductActive: TWideStringField;
    qryProductLockExtraSell: TWideStringField;
    qryProductEditedFlag: TWideStringField;
    cbTaxCodeQryTaxCodeID: TAutoIncField;
    cbTaxCodeQryDescription: TWideStringField;
    cbTaxCodeQryRate: TFloatField;
    cbTaxCodeQryTaxRatePercent: TFloatField;
    cbo_Class_QryClassID: TAutoIncField;
    cbo_Class_QryClassName: TWideStringField;
    grdSellPrices: TwwDBGrid;
    dsSellPrices: TDataSource;
    qrySellPrices: TERPQuery;
    qrySellPricesPriceID: TAutoIncField;
    qrySellPricesClientTypeID: TIntegerField;
    qrySellPricesPartsID: TIntegerField;
    qrySellPricesQtyPercent1: TFloatField;
    qryClientTypes: TERPQuery;
    dsClientTypes: TDataSource;
    qrySellPricesClientTypeName: TWideStringField;
    cboClientType: TwwDBLookupCombo;
    qrySellPricesCalcSellQty1: TIntegerField;
    btnDeleteSellPrice: TwwIButton;
    pnlFooter: TDNMPanel;
    pnlHeader: TDNMPanel;
    edtPartName: TEdit;
    grdBuyPrice: TwwDBGrid;
    btnDeleteXBuyPrice: TwwIButton;
    dsExtraBuyPrice: TDataSource;
    qryExtraBuyPrice: TERPQuery;
    qryExtraBuyPriceExtraPartPriceID: TAutoIncField;
    qryExtraBuyPricePartsID: TIntegerField;
    qryExtraBuyPriceSupplierID: TIntegerField;
    qryExtraBuyPricePrice: TFloatField;
    qryExtraBuyPricePartName: TWideStringField;
    qryExtraBuyPriceBuy1: TIntegerField;
    qryExtraBuyPriceSupplierProductCode: TWideStringField;
    qryExtraBuyPriceSupplierProductName: TWideStringField;
    qryExtraBuyPriceUsePrice: TWideStringField;
    qryExtraBuyPriceSupplierName: TWideStringField;
    cboSupplier: TwwDBLookupCombo;
    qryProductAutoReorder: TWideStringField;
    qryProductBatch: TWideStringField;
    TabPicture: TTabSheet;
    mnuPicture: TAdvPopupMenu;
    mitAddImage: TMenuItem;
    mitDeletePic: TMenuItem;
    DNMPanel6: TDNMPanel;
    qryProductAutoBatch: TWideStringField;
    cbTaxCodeQryName: TWideStringField;
    cbTaxCodeQryTaxCode: TWideStringField;
    dsUnitsOfMeasure: TDataSource;
    qryProductOrderTime: TFloatField;
    qryProductManufactureTime: TFloatField;
    qryProductOverrunTime: TFloatField;
    memqryProduct: TkbmMemTable;
    Miscellaneous: TTabSheet;
    qryProductDuration: TIntegerField;
    memqryQtys: TkbmMemTable;
    qryProductPRODUCTCOMMENT: TWideStringField;
    qryProductAttrib1Purchase: TFloatField;
    qryProductAttrib2Purchase: TFloatField;
    qryProductAttrib1PurchaseRate: TFloatField;
    qryProductAttrib1Sale: TFloatField;
    qryProductAttrib2Sale: TFloatField;
    qryProductAttrib1SaleRate: TFloatField;
    qrySellPricesAllClients: TWideStringField;
    qrySellPricesDateTo: TDateField;
    qrySellPricesDateFrom: TDateField;
    wwDBDateTo: TwwDBDateTimePicker;
    wwDBDatefrom: TwwDBDateTimePicker;
    qryProductSupplierProductCode: TWideStringField;
    chkActive: TwwCheckBox;
    qryUnitsOfTime: TERPQuery;
    qryUnitsOfMeasureQtys: TERPQuery;
    DSqryUnitsOfMeasureQtys: TDataSource;
    qryProductRequired: TWideStringField;
    qrySellPricesExtraSellDesc: TWideStringField;
    qryUnitOfMeasure: TERPQuery;
    qryUnitOfMeasureUnitID: TIntegerField;
    qryUnitOfMeasureUnitName: TWideStringField;
    qryUnitOfMeasureUnitDescription: TWideStringField;
    qryUnitOfMeasureMultiplier: TFloatField;
    qryProductShowProductPopUp: TWideStringField;
    qryProductProductPopUpNotes: TWideMemoField;
    grdRelatedParts: TwwDBGrid;
    RealtedPartsIButton: TwwIButton;
    Label41: TLabel;
    dsRelatedParts: TDataSource;
    qryRelatedParts: TERPQuery;
    qryRelatedPartsRelatedID: TAutoIncField;
    qryRelatedPartsParentID: TIntegerField;
    qryRelatedPartsProductID: TIntegerField;
    qryRelatedPartsPartName: TWideStringField;
    qryRelatedPartsQty: TFloatField;
    qryRelatedPartsEditedFlag: TWideStringField;
    cboProductsRelated: TERPDbLookupCombo;
    grdForeign: TwwDBGrid;
    grdForeignIButton: TwwIButton;
    DNMPanel20: TDNMPanel;
    Label43: TLabel;
    DNMPanel21: TDNMPanel;
    Label42: TLabel;
    qryForeignPrice: TERPQuery;
    qryForeignPriceForeignPriceID: TAutoIncField;
    qryForeignPricePartsID: TIntegerField;
    qryForeignPricePartName: TWideStringField;
    qryForeignPriceBuy1: TIntegerField;
    qryForeignPricePrice1: TFloatField;
    qryForeignPriceSupplierProductCode: TWideStringField;
    qryForeignPriceSupplierProductName: TWideStringField;
    dsForeignPrice: TDataSource;
    qryForeignPriceSupplierName: TWideStringField;
    cboSupplierForeign: TwwDBLookupCombo;
    edtVariantPrice: TwwDBEdit;
    qryProductCOST1: TFloatField;
    qryProductCOST2: TFloatField;
    qryProductCOST3: TFloatField;
    qryProductPRICE1: TFloatField;
    qryProductPRICE2: TFloatField;
    qryProductPRICE3: TFloatField;
    qryProductorgPrice1: TFloatField;
    qryProductorgPrice2: TFloatField;
    qryProductorgPrice3: TFloatField;
    qryProductWHOLESALEPRICE: TFloatField;
    qryProductArea: TWideStringField;
    qryExtraBuyPricePrintedValue: TFloatField;
    qryProductOnSpecial: TWideStringField;
    qryProductDiscontinued: TWideStringField;
    qryRelatedPartsHideRelated: TWideStringField;
    qrySellPricesPrice1: TFloatField;
    NewManufacture: TTabSheet;
    cboManfProductQry: TERPQuery;
    cboClientLookup: TERPQuery;
    cboClientLookupClientID: TIntegerField;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupForeignExchangeSellCode: TWideStringField;
    qryRelatedPartsUseIncur: TWideStringField;
    qryRelatedPartsIncurAmount: TFloatField;
    qryRelatedPartsExtraQty: TFloatField;
    edtIncurMargin: TwwDBEdit;
    qryRelatedPartsIncurAfterTax: TWideStringField;
    qryProductUseAdvancedMatrix: TWideStringField;
    qryProductUseHedgingFormula: TWideStringField;
    qryProductLevel3: TERPQuery;
    qryProductLevel2: TERPQuery;
    qryProductLevel1: TERPQuery;
    qryProductOnCostIncrease: TWideStringField;
    qryProductOnCostDecrease: TWideStringField;
    qryProductLevels: TERPQuery;
    qryProcessStep: TERPQuery;
    qryProductLastUpdated: TDateTimeField;
    dlgPrint: TPdtPrintDAT;
    qryProductPDAMinSellQty: TFloatField;
    qryProductLandedCost: TFloatField;
    DNMPanel25: TDNMPanel;
    Label56: TLabel;
    grdForeignSell: TwwDBGrid;
    grdForeignSellIButton: TwwIButton;
    DNMPanel26: TDNMPanel;
    Label57: TLabel;
    dsForeignPriceSell: TDataSource;
    qryForeignPriceSell: TERPQuery;
    qryForeignPriceSellForeignPriceId: TAutoIncField;
    qryForeignPriceSellPartsId: TIntegerField;
    qryForeignPriceSellClientID: TIntegerField;
    qryForeignPriceSellPartName: TWideStringField;
    qryForeignPriceSellBuy1: TIntegerField;
    qryForeignPriceSellPrice1: TFloatField;
    qryForeignPriceSellSupplierProductCode: TWideStringField;
    qryForeignPriceSellSupplierProductName: TWideStringField;
    qryForeignPriceSellSupplierName: TWideStringField;
    qryForeignPriceSellIsSellPrice: TWideStringField;
    qryForeignPriceIsSellPrice: TWideStringField;
    qryForeignPriceClientID: TIntegerField;
    qryCurrency: TERPQuery;
    cboCurrency: TwwDBLookupCombo;
    qryForeignPriceSellCode: TWideStringField;
    qryForeignPriceSellCurrencyId: TIntegerField;
    qryProductIsVariable: TWideStringField;
    qryRelatedPartsHireFromDate: TDateField;
    qryRelatedPartsHireToDate: TDateField;
    MiscPageControl: TPageControl;
    tabGeneral: TTabSheet;
    tabSpecifications: TTabSheet;
    DNMPanel15: TDNMPanel;
    pnlSalesMisc: TDNMPanel;
    Label85: TLabel;
    Label84: TLabel;
    txtProductNumber: TwwDBEdit;
    txtBarcode: TDBEdit;
    DNMPanel28: TDNMPanel;
    qrySpecifications: TERPQuery;
    DSSpecifications: TDataSource;
    qrySpecificationsPartSpecID: TAutoIncField;
    qrySpecificationsPartsID: TIntegerField;
    qrySpecificationsSpecDescription: TWideStringField;
    qrySpecificationsSpecValue: TWideStringField;
    qrySpecificationsIsMultiplier: TWideStringField;
    qrySpecificationsGlobalRef: TWideStringField;
    Label59: TLabel;
    qrySpecificationsOnPrintOut: TWideStringField;
    qryProductIncludeInAnalysis: TWideStringField;
    qryProductHideOnPrint: TWideStringField;
    cboCurrencyCode: TwwDBLookupCombo;
    qryForeignPriceCurrencyId: TIntegerField;
    qryBuyCurrencyLookup: TERPQuery;
    qryForeignPriceCurrencyCode: TWideStringField;
    qryProductSell_Cost_Percentage: TFloatField;
    qryProductNormalDeliveryTime: TFloatField;
    qryProductVolume: TFloatField;
    qryProductAutoBin: TWideStringField;
    btnCompleted: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    btnCopy: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    qryUnitsOfMeasureQtysTotalAvailableQtyInUOM: TFloatField;
    qryUnitsOfMeasureQtysUOMVolume: TFloatField;
    qryUnitsOfMeasureQtysUOMWeight: TFloatField;
    qryUnitsOfMeasureQtysAvailableQtyUOMWeight: TFloatField;
    Bevel20: TBevel;
    lblCopyParts: TLabel;
    cboProduct: TwwDBLookupCombo;
    btnGroupCopy: TDNMSpeedButton;
    qryProductLookupToCopyRelatedFrom: TERPQuery;
    qryProductLookupToCopyRelatedFromPartsID: TIntegerField;
    qryProductLookupToCopyRelatedFromPartName: TWideStringField;
    lblcopyfrom: TLabel;
    qryProductCOSTINC1: TFloatField;
    qryProductCOSTINC2: TFloatField;
    qryProductCOSTINC3: TFloatField;
    qryProductPRICEINC1: TFloatField;
    qryProductPRICEINC2: TFloatField;
    qryProductPRICEINC3: TFloatField;
    rdoCopyOptions: TwwRadioGroup;
    qryPartPics: TERPQuery;
    qryPartPicspartID: TIntegerField;
    qryPartPicspartPic: TBlobField;
    DSPartPic: TDataSource;
    dlgPARTSLongMemo: TwwMemoDialog;
    dlgPARTSpurchaseLongMemo: TwwMemoDialog;
    qryProductPARTSDESCRIPTION_Memo: TWideMemoField;
    qryProductPURCHASEDESC_Memo: TWideMemoField;
    qryProductAutoSmartOrder: TWideStringField;
    DNMPanel19: TDNMPanel;
    btnNewUOM: TDNMSpeedButton;
    grdUnitOfMeasureQtys: TwwDBGrid;
    qryProductDateUpdated: TDateField;
    qryProductDateCreated: TDateField;
    pnlMain: TDNMPanel;
    pnlMainHeader: TDNMPanel;
    Label34: TLabel;
    lblFirstCol: TLabel;
    lblSecondCol: TLabel;
    lblThirdCol: TLabel;
    lblPartname: TLabel;
    edtPart: TwwDBEdit;
    cboPartLevel3: TwwDBLookupCombo;
    cboPartLevel2: TwwDBLookupCombo;
    cboPartLevel1: TwwDBLookupCombo;
    dblcProductType: TwwDBLookupCombo;
    DNMPanel1: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    TabIntrastat: TTabSheet;
    DNMPanel33: TDNMPanel;
    Label86: TLabel;
    edCommodityCode: TDBEdit;
    qryProductNetWeightKg: TFloatField;
    grdProductClasses: TwwDBGrid;
    btnProductClasses: TwwIButton;
    qryProductClass: TERPQuery;
    dsProductClass: TDataSource;
    qryProductClassGlobalRef: TWideStringField;
    qryProductClassID: TIntegerField;
    qryProductClassProductID: TIntegerField;
    qryProductClassProductName: TWideStringField;
    qryProductClassProductGroup: TWideStringField;
    qryProductClassClassID: TIntegerField;
    qryProductClassClassName: TWideStringField;
    qryProductClassReOrderPoint: TFloatField;
    qryProductClassPreferredLevel: TFloatField;
    qryProductClassReOrderAmount: TFloatField;
    qryProductClassLastAdj: TFloatField;
    qryProductClassLastAdjAccount: TIntegerField;
    qryProductClassClassPriceVariance: TFloatField;
    qryProductClassVariantPrice: TFloatField;
    qryProductClassNextStocktakeDate: TDateField;
    qryProductClassActive: TWideStringField;
    qryProductClassmsTimeStamp: TDateTimeField;
    cboClassName: TwwDBLookupCombo;
    qryUnitsOfMeasureQtysUOM: TWideStringField;
    qryUnitsOfMeasureQtysUOMMultiplier: TFloatField;
    qryUnitsOfMeasureQtysVolume: TFloatField;
    qryUnitsOfMeasureQtysWeight: TFloatField;
    QryProductQtys: TERPQuery;
    QryProductQtysProductID: TIntegerField;
    QryProductQtysDepartmentID: TIntegerField;
    QryProductQtysAvailableQty: TFloatField;
    QryProductQtysAllocatedBOQty: TFloatField;
    QryProductQtysSOQty: TFloatField;
    QryProductQtysSOBOQty: TFloatField;
    QryProductQtysInstockQty: TFloatField;
    QryProductQtysPOBOQty: TFloatField;
    qryProductClassAvailableQty: TFloatField;
    qryProductClassAllocatedBOQty: TFloatField;
    qryProductClassSOQty: TFloatField;
    qryProductClassSOBOQty: TFloatField;
    qryProductClassInstockQty: TFloatField;
    qryProductClassPOBOQty: TFloatField;
    tabBatch: TTabSheet;
    DNMPanel7: TDNMPanel;
    Label15: TLabel;
    lblProductvolume: TLabel;
    cboBinBatchClass: TwwDBLookupCombo;
    edtDBVolume: TDBEdit;
    BinBatchAllocation: TDNMPanel;
    grdSerials: TwwDBGrid;
    QrySerialno: TERPQuery;
    dsSerialno: TDataSource;
    DNMPanel23: TDNMPanel;
    Bevel9: TBevel;
    Bevel8: TBevel;
    lblNotAllocatedToBatches: TLabel;
    lblNotAllocatedToBins: TLabel;
    chkBatches: TDBCheckBox;
    OptAutoallocbatches: TwwRadioGroup;
    Panel2: TPanel;
    chkMultipleBins: TwwCheckBox;
    OptAutoallocbins: TwwRadioGroup;
    edNotAllocatedToBatches: TEdit;
    edNotAllocatedToBins: TEdit;
    QrySerialnoPartsId: TIntegerField;
    QrySerialnoDepartmentID: TIntegerField;
    QrySerialnoUOM: TWideStringField;
    QrySerialnoUOMMultiplier: TFloatField;
    QrySerialnogLevel: TLargeintField;
    QrySerialnoProductName: TWideStringField;
    QrySerialnoProductColumn1: TWideStringField;
    QrySerialnoProductColumn2: TWideStringField;
    QrySerialnoProductColumn3: TWideStringField;
    QrySerialnoPartsDescription: TWideStringField;
    QrySerialnoClassname: TWideStringField;
    QrySerialnoBatchnumber: TWideStringField;
    QrySerialnocBatchExpiryDate: TWideStringField;
    QrySerialnoBatchExpiryDate: TDateTimeField;
    QrySerialnobinLocation: TWideStringField;
    QrySerialnoBinnumber: TWideStringField;
    QrySerialnoSerialnumber: TWideStringField;
    QrySerialnoAlloctype: TWideStringField;
    QrySerialnoDescription: TWideStringField;
    Label2: TLabel;
    QryUOMSales: TERPQuery;
    dsUOMSAles: TDataSource;
    qryUOMPurchase: TERPQuery;
    dsUOMPurcahse: TDataSource;
    QryUOMSalesUnitName: TWideStringField;
    QryUOMSalesUnitID: TIntegerField;
    QryUOMSalesMultiplier: TFloatField;
    qryUOMPurchaseUnitName: TWideStringField;
    qryUOMPurchaseUnitID: TIntegerField;
    qryUOMPurchaseMultiplier: TFloatField;
    QryBins: TERPQuery;
    lblDefaultBin4class: TLabel;
    cboDefaultBin4class: TwwDBLookupCombo;
    QryBinsGlobalRef: TWideStringField;
    QryBinsBinID: TIntegerField;
    QryBinsClassId: TIntegerField;
    QryBinsBinLocation: TWideStringField;
    QryBinsBinNumber: TWideStringField;
    QryBinsActive: TWideStringField;
    QryBinsvolume: TFloatField;
    QryBinsVolume_Used: TFloatField;
    QryBinsmsTimeStamp: TDateTimeField;
    qryProductClassDefaultbinId: TIntegerField;
    qryProductClassDefaultbinlocation: TWideStringField;
    cboDefaultBin: TwwDBLookupCombo;
    qrybinslookup: TERPQuery;
    StringField1: TWideStringField;
    IntegerField1: TIntegerField;
    qryUnitsOfMeasureQtysAvailableQtyinUOM: TFloatField;
    qryUnitsOfMeasureQtysTotalAvailableQtyInUnits: TFloatField;
    qryUnitsOfMeasureQtysUOMDesc: TWideStringField;
    qryUnitsOfMeasureQtysBaseUnitName: TWideStringField;
    DNMPanel14: TDNMPanel;
    lbldefaultbin: TLabel;
    Label9: TLabel;
    qryUnitsOfMeasureQtysUOMMultiplierDesc: TWideStringField;
    grdUOMQty: TwwDBGrid;
    qryUnitsOfMeasureQtysTotalAvailableQtyUOMDesc: TWideStringField;
    lblUOMAvailableQty: TLabel;
    qryUnitsOfMeasureQtysAvailableQtyinUnits: TFloatField;
    lblQty: TLabel;
    Label37: TLabel;
    lblTotalQty: TLabel;
    dsPartBarCodes: TDataSource;
    qryPartBarCodes: TERPQuery;
    qryPartBarCodesProductBarCodeID: TIntegerField;
    qryPartBarCodesPartsID: TIntegerField;
    qryPartBarCodesBarCode: TWideStringField;
    qryPartBarCodesIsprimaryBarcode: TWideStringField;
    qryPartBarCodesActive: TWideStringField;
    qryProductisEquipment: TWideStringField;
    DNMPanel29: TDNMPanel;
    Label5: TLabel;
    cboClass4Serialno: TwwDBLookupCombo;
    cmdNewSrno: TDNMSpeedButton;
    grpFilters: TwwRadioGroup;
    qryProductGrossMarginMode: TWideStringField;
    qryCustomFields: TERPQuery;
    qryProductCUSTFLD1: TWideStringField;
    qryProductCUSTFLD2: TWideStringField;
    qryProductCUSTFLD3: TWideStringField;
    qryProductCUSTFLD4: TWideStringField;
    qryProductCUSTFLD5: TWideStringField;
    qryProductCUSTFLD6: TWideStringField;
    qryProductCUSTFLD7: TWideStringField;
    qryProductCUSTFLD8: TWideStringField;
    qryProductCUSTFLD9: TWideStringField;
    qryProductCUSTFLD10: TWideStringField;
    qryProductCUSTFLD11: TWideStringField;
    qryProductCUSTFLD12: TWideStringField;
    qryProductCUSTFLD13: TWideStringField;
    qryProductCUSTFLD14: TWideStringField;
    qryProductCUSTFLD15: TWideStringField;
    qryProductCUSTDATE1: TDateTimeField;
    qryProductCUSTDATE2: TDateTimeField;
    qryProductCUSTDATE3: TDateTimeField;
    TabProductMovement: TTabSheet;
    PageMovements: TPageControl;
    TabSalesMovements: TTabSheet;
    TabPurchaseMovement: TTabSheet;
    DNMPanel8: TDNMPanel;
    Bevel1: TBevel;
    Bevel4: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    Bevel3: TBevel;
    lblTotAmnt: TLabel;
    lblTotQty: TLabel;
    Label46: TLabel;
    grdSales: TAdvStringGrid;
    dtpFrom: TDateTimePicker;
    dtpTo: TDateTimePicker;
    btnView: TDNMSpeedButton;
    chkBaseOnShipped: TCheckBox;
    DNMPanel9: TDNMPanel;
    Bevel2: TBevel;
    Bevel5: TBevel;
    Label12: TLabel;
    Label13: TLabel;
    Bevel6: TBevel;
    lblPurchTotAmnt: TLabel;
    lblPurchTotQty: TLabel;
    Label47: TLabel;
    grdPurch: TAdvStringGrid;
    dtpPurchFrom: TDateTimePicker;
    dtpPurchTo: TDateTimePicker;
    btnPurchView: TDNMSpeedButton;
    chkBasePurchOn: TCheckBox;
    Custom_Fields: TTabSheet;
    dsPartsProcess: TDataSource;
    QryPartsProcess: TERPQuery;
    QryPartsProcessGlobalRef: TWideStringField;
    QryPartsProcessID: TIntegerField;
    QryPartsProcessPartId: TIntegerField;
    QryPartsProcessProcessStepID: TIntegerField;
    QryPartsProcessProcessStepSeq: TIntegerField;
    QryPartsProcessDuration: TFloatField;
    QryPartsProcessSetupDuration: TFloatField;
    QryPartsProcessBreakdownDuration: TFloatField;
    QryPartsProcessFixedAmount: TFloatField;
    QryPartsProcessProcessStep: TWideStringField;
    pnlProductspec: TDNMPanel;
    Bevel17: TBevel;
    Label65: TLabel;
    Label51: TLabel;
    grdGeneralSpec: TwwDBGrid;
    wwIButton3: TwwIButton;
    grdPartsProcess: TwwDBGrid;
    deleteProcessStep: TwwIButton;
    cboProcessStep: TwwDBLookupCombo;
    qryProcessStepGlobalRef: TWideStringField;
    qryProcessStepID: TIntegerField;
    qryProcessStepDescription: TWideStringField;
    qryProcessStepProcessTime: TDateTimeField;
    qryProcessStepActive: TWideStringField;
    qryProcessStepmsTimeStamp: TDateTimeField;
    qryProductGlobalRef: TWideStringField;
    qryPartPicsIsDefault: TWideStringField;
    qryPartBarCodesGlobalref: TWideStringField;
    qryPartPicsGlobalRef: TWideStringField;
    qryPartPicspartpicID: TIntegerField;
    qryPartPicsmsTimeStamp: TDateTimeField;
    lblRecNo: TLabel;
    QryBinsLocNum: TWideStringField;
    tabcommission: TTabSheet;
    TabExtraSellPrice: TTabSheet;
    pnlcommission: TDNMPanel;
    tabInTrans: TTabSheet;
    DNMPanel30: TDNMPanel;
    grdIntrans: TwwDBGrid;
    QryInTransation: TERPQuery;
    dsInTransation: TDataSource;
    QryInTransationType: TWideStringField;
    QryInTransationLineCost: TFloatField;
    QryInTransationShipped: TFloatField;
    QryInTransationLandedCostsPerItem: TFloatField;
    Bevel12: TBevel;
    Label63: TLabel;
    DBEdit6: TDBEdit;
    btnRecalculateAvgcost: TDNMSpeedButton;
    QryInTransationOrderedDates: TDateTimeField;
    QryInTransationInStockItem: TWideStringField;
    QryInTransationID: TIntegerField;
    QryInTransationInStockQty: TFloatField;
    QryInTransationInStockValue: TFloatField;
    QryInTransationTranstype: TWideStringField;
    Label69: TLabel;
    stockCostSystem: TRadioGroup;
    Label70: TLabel;
    chkincludelandedcost: TCheckBox;
    Label72: TLabel;
    lsTDNMSpeedButtonActions: TActionList;
    actEquipment: TDNMAction;
    qrySellPricesUOM: TWideStringField;
    qrySellPricesUOMID: TIntegerField;
    qrySellPricesUOMMultiplier: TFloatField;
    qryForeignPriceSellUOMID: TIntegerField;
    qryForeignPriceSellUOM: TWideStringField;
    qryForeignPriceSellUOMMultiplier: TFloatField;
    qryExtraBuyPriceUOM: TWideStringField;
    qryExtraBuyPriceUOMID: TIntegerField;
    qryExtraBuyPriceUOMMultiplier: TFloatField;
    qryForeignPriceUOM: TWideStringField;
    qryForeignPriceUOMID: TIntegerField;
    qryForeignPriceUOMMultiplier: TFloatField;
    QryUOM: TERPQuery;
    QryUOMUnitname: TWideStringField;
    QryUOMmultiplier: TFloatField;
    QryUOMUnitId: TIntegerField;
    QryUOMPartID: TIntegerField;
    cboUOMESP: TwwDBLookupCombo;
    cboUOMESFP: TwwDBLookupCombo;
    cboUOMEBP: TwwDBLookupCombo;
    cboUOMEBFP: TwwDBLookupCombo;
    qrySellPricesuomPrice1: TFloatField;
    qryForeignPriceSellUOMPrice1: TFloatField;
    qryExtraBuyPriceUOMPrice: TFloatField;
    qryForeignPriceUOMPrice1: TFloatField;
    tabnotes: TTabSheet;
    DNMPanel31: TDNMPanel;
    qryProductProductionNotes: TWideMemoField;
    qryProductGeneralNotes: TWideMemoField;
    qryPartNotes: TERPQuery;
    dsPartNotes: TDataSource;
    qryPartNotesGlobalref: TWideStringField;
    qryPartNotesPartsId: TIntegerField;
    qryPartNotesActive: TWideStringField;
    qryPartNotesmsTimeStamp: TDateTimeField;
    cboProductQry: TERPQuery;
    qryPartNotesNotes: TWideStringField;
    qryProductProductUOMID: TIntegerField;
    qryProductProductUOM: TWideStringField;
    qryProductDescription: TWideStringField;
    Label89: TLabel;
    DBEdit7: TDBEdit;
    ERPQuery1: TERPQuery;
    IntegerField2: TIntegerField;
    StringField2: TWideStringField;
    StringField3: TWideStringField;
    FloatField1: TFloatField;
    qryUnitOfMeasureBaseUnitName: TWideStringField;
    qryProductUOMtobeUsedinManufacture: TWideStringField;
    qryProductEx_Works: TFloatField;
    qryProductCountryofOriginID: TLargeintField;
    qryCountry: TERPQuery;
    qryCountryCountryId: TIntegerField;
    qryCountryCountry: TWideStringField;
    btnAutoFill: TDNMSpeedButton;
    Label54: TLabel;
    edtMinQty: TwwDBEdit;
    FontDialog: TFontDialog;
    lblExtraSellPrice: TLabel;
    chkExtraSellPrice: TwwCheckBox;
    Label93: TLabel;
    chkLockExtraSellPrice: TwwCheckBox;
    tabPriceMatrix: TTabSheet;
    PageControlsellprice: TPageControl;
    qryProductPublishOnWeb: TWideStringField;
    qryExtraBuyPriceMinimumOrderQty: TFloatField;
    dsAlternateProducts: TDataSource;
    QryAlternateProducts: TERPQuery;
    QryAlternateProductsID: TIntegerField;
    QryAlternateProductsGlobalref: TWideStringField;
    QryAlternateProductsProductID: TIntegerField;
    QryAlternateProductsProductName: TWideStringField;
    QryAlternateProductsAlternateProductID: TIntegerField;
    QryAlternateProductsAlternateProductName: TWideStringField;
    QryAlternateProductsmstimestamp: TDateTimeField;
    cboalternateProductQty: TERPQuery;
    QryAlternateProductsIsDefault: TWideStringField;
    qryProductformulaID: TIntegerField;
    qryProductformula: TERPQuery;
    qryProductformulaFormulaID: TIntegerField;
    qryProductformulaFormulaName: TWideStringField;
    Label97: TLabel;
    lblWeight: TLabel;
    qryProductHideonPickSlip: TWideStringField;
    qryProductHideonDelDocket: TWideStringField;
    mnuMainpopup: TPopupMenu;
    mnuauditTrial: TMenuItem;
    qrySpecificationsmsUpdateSiteCode: TWideStringField;
    qryProductClassmsUpdateSiteCode: TWideStringField;
    QryBinsmsUpdateSiteCode: TWideStringField;
    QryPartsProcessmsUpdateSiteCode: TWideStringField;
    qryProcessStepmsUpdateSiteCode: TWideStringField;
    qryProductmsUpdateSiteCode: TWideStringField;
    qryPartPicsmsUpdateSiteCode: TWideStringField;
    qryProductLatestCost: TFloatField;
    btnDetails: TDNMSpeedButton;
    qryProductPartCalcformula: TWideStringField;
    mnuPartCalcformulafields: TPopupMenu;
    qryProductPartCalcformulaField: TWideStringField;
    qryProductPartCalcformulaUOM: TWideStringField;
    qryProductPartCalcformulaUOMID: TIntegerField;
    qryProductLineNo: TIntegerField;
    qryProductPartCalcformulaUOMMult: TFloatField;
    pnlformula: TDNMPanel;
    cboPartCalcformulaUOM: TwwDBLookupCombo;
    memPartCalcformula: TDBMemo;
    Label100: TLabel;
    qryProductPartCalcFormulaMult: TFloatField;
    lblFormula: TLabel;
    edtPartCalcformulaMult: TwwDBEdit;
    QryPartCalcformulaUOM: TERPQuery;
    QryPartCalcformulaUOMUnitID: TIntegerField;
    QryPartCalcformulaUOMUnitName: TWideStringField;
    QryPartCalcformulaUOMMultiplier: TFloatField;
    lblPartCalcformula: TLabel;
    qryProductFormulaQtyValue1: TFloatField;
    qryProductFormulaQtyValue2: TFloatField;
    qryProductFormulaQtyValue3: TFloatField;
    qryProductFormulaQtyValue4: TFloatField;
    qryProductFormulaQtyValue5: TFloatField;
    Label101: TLabel;
    Label102: TLabel;
    edtCalcField: TwwDBEdit;
    edtCalcField11: TwwDBEdit;
    edtCalcField22: TwwDBEdit;
    edtCalcField33: TwwDBEdit;
    edtCalcField44: TwwDBEdit;
    edtCalcField55: TwwDBEdit;
    lblCalcField11: TLabel;
    lblCalcField22: TLabel;
    lblCalcField33: TLabel;
    lblCalcField44: TLabel;
    lblCalcField55: TLabel;
    pnlcalclformula: TDNMPanel;
    lblCalcField1: TLabel;
    lblCalcField2: TLabel;
    lblCalcField3: TLabel;
    lblCalcField4: TLabel;
    lblCalcField5: TLabel;
    Label68: TLabel;
    edtCalcField1: TwwDBEdit;
    edtCalcField2: TwwDBEdit;
    edtCalcField3: TwwDBEdit;
    edtCalcField4: TwwDBEdit;
    edtCalcField5: TwwDBEdit;
    lblFormulaDetails: TLabel;
    lblFormulaExplain: TLabel;
    Bevel19: TBevel;
    Bevel21: TBevel;
    Label108: TLabel;
    qryProductFormulaQty: TFloatField;
    qryProductFormulaQty1: TFloatField;
    qryProductFormulaQty2: TFloatField;
    qryProductFormulaQty3: TFloatField;
    qryProductFormulaQty4: TFloatField;
    qryProductFormulaQty5: TFloatField;
    qryRelatedPartsCanDelete: TWideStringField;
    qryRelatedPartsIsHidden: TWideStringField;
    qryProductCanDeleteInPOS: TWideStringField;
    qryProductIsBOMTemplate: TWideStringField;
    qryProductIsSystemProduct: TWideStringField;
    qryProductMancostWithLabour: TFloatField;
    TmrRoundingPriceHint: TTimer;
    grdQty: TwwDBGrid;
    tabMan: TTabSheet;
    grdMan: TAdvStringGrid;
    lblonbuild: TLabel;
    lblbuilding: TLabel;
    Bevel23: TBevel;
    Bevel24: TBevel;
    Label109: TLabel;
    dtpFromMan: TDateTimePicker;
    Label110: TLabel;
    dtpToMan: TDateTimePicker;
    btnManView: TDNMSpeedButton;
    Bevel22: TBevel;
    lblBuilt: TLabel;
    Bevel25: TBevel;
    lblsubbuilt: TLabel;
    Bevel26: TBevel;
    Bevel27: TBevel;
    lbltotalAmount: TLabel;
    lblbuiltIntoStock: TLabel;
    Bevel28: TBevel;
    Horizontal1: TSplitter;
    lblusedtoBuit: TLabel;
    Bevel29: TBevel;
    qryRelatedPartsISContainer: TWideStringField;
    qryRelatedPartsISPallet: TWideStringField;
    qryRelatedPartsIsToRoundtoNextNumberinSales: TWideStringField;
    qryRelatedPartsIsToRoundtoPreviousNumberinSales: TWideStringField;
    qryRelatedPartsZeroWhenLessthan1: TWideStringField;
    qryProductPRODUCTAttrib1: TFloatField;
    QryProductUOM: TERPQuery;
    QryProductUOMGlobalRef: TWideStringField;
    QryProductUOMUnitID: TIntegerField;
    QryProductUOMUnitName: TWideStringField;
    QryProductUOMUnitDescription: TWideStringField;
    QryProductUOMMultiplier: TFloatField;
    QryProductUOMEditedFlag: TWideStringField;
    QryProductUOMBaseUnitName: TWideStringField;
    QryProductUOMBaseUnitID: TIntegerField;
    QryProductUOMmsTimeStamp: TDateTimeField;
    QryProductUOMActive: TWideStringField;
    QryProductUOMPartID: TIntegerField;
    QryProductUOMSalesDefault: TWideStringField;
    QryProductUOMPurchasesDefault: TWideStringField;
    QryProductUOMHeight: TFloatField;
    QryProductUOMWidth: TFloatField;
    QryProductUOMLength: TFloatField;
    QryProductUOMWeight: TFloatField;
    QryProductUOMVolume: TFloatField;
    QryProductUOMNoOfBoxes: TIntegerField;
    QryProductUOMUnitProductKeyName: TWideStringField;
    QryProductUOMmsUpdateSiteCode: TWideStringField;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    lblArea: TLabel;
    cboAreaCode: TwwDBLookupCombo;
    qryProductmsTimeStamp: TDateTimeField;
    tabAusEParcel: TTabSheet;
    qryProductCreateJobwhenconvert: TWideStringField;
    DNMPanel34: TDNMPanel;
    Label4: TLabel;
    wwCheckBox5: TwwCheckBox;
    Label19: TLabel;
    wwCheckBox6: TwwCheckBox;
    Label111: TLabel;
    Label115: TLabel;
    wwRadioGroup1: TwwRadioGroup;
    qryProductDangerousProduct: TWideStringField;
    qryProductReqdinsurance: TWideStringField;
    qryProductInsuranceAmount: TFloatField;
    qryProductTariffcode: TWideStringField;
    qryProductUndeliveredAction: TWideStringField;
    qryProductconsignmentProducttype: TWideStringField;
    qryProductProductclassification: TWideStringField;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    Shape1: TShape;
    qryForeignPriceForeignPriceDescription: TWideStringField;
    qryForeignPriceSellForeignPriceDescription: TWideStringField;
    qryProductEnableAutoSplitQtyintoUOMinSales: TWideStringField;
    qryProductAreaCoverageofsingleQty: TFloatField;
    qryProductBOMPriceCalculatedfromTree: TWideStringField;
    qryProductBOMCostCalculatedFromTree: TWideStringField;
    qryPartPicsPictype: TWideStringField;
    pnlImage: TDNMPanel;
    imagePart: TImage;
    pnlPicHeader: TDNMPanel;
    Label103: TLabel;
    btnAddPic: TDNMSpeedButton;
    btnClearPic: TDNMSpeedButton;
    btnStretch: TDNMSpeedButton;
    chkDefaultPic: TwwCheckBox;
    qryProductRequiresAssembly: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    qryPartBarCodesUnitOfMeasureId: TIntegerField;
    qryPartBarCodesmsTimeStamp: TDateTimeField;
    qryPartBarCodesmsUpdateSiteCode: TWideStringField;
    qryPartBarCodesUOMName: TStringField;
    qryForeignPriceSellSellPrice1: TFloatField;
    qryProductDocumentPath: TWideStringField;
    qryProductcDocumentPath: TStringField;
    qryProductShowPurchaseProductPopUp: TWideStringField;
    qryProductProductPurchasePopUpNotes: TWideMemoField;
    navPartPic: TwwDBNavigator;
    navPartPicFirst: TwwNavButton;
    navPartPicPriorPage: TwwNavButton;
    navPartPicPrior: TwwNavButton;
    navPartPicNext: TwwNavButton;
    navPartPicLast: TwwNavButton;
    navPartPicDelete: TwwNavButton;
    pnlPicturetype: TDNMPanel;
    DBText1: TDBText;
    Label118: TLabel;
    btnConvertImage: TDNMSpeedButton;
    lstImageTypes: TCheckListBox;
    qryPartPicsSortOrder: TIntegerField;
    edtPartPicSortOrder: TwwDBEdit;
    lblPartPicSortOrder: TLabel;
    edtPartPicName: TwwDBEdit;
    lblPartPicName: TLabel;
    qryPartPicsImageName: TWideStringField;
    qryPartPicsImageTypes: TWideStringField;
    qryProductLatestCostDate: TDateField;
    qryProductManLatestCost: TFloatField;
    qryProductManLatestCostDate: TDateField;
    qryProductManAvgCost: TFloatField;
    qryProductClassWastagePercentage: TFloatField;
    QryInTransationTransID: TIntegerField;
    DNMPanel35: TDNMPanel;
    btnRefresh: TDNMSpeedButton;
    DBEdit3: TDBEdit;
    Label21: TLabel;
    pnlAdjustAllocation: TDNMPanel;
    MnuAdjustAllocationThis: TDNMSpeedButton;
    MnuAdjustAllocationAll: TDNMSpeedButton;
    pnlEmptyBins: TDNMPanel;
    Label7: TLabel;
    Label23: TLabel;
    MnuEmptyAllocationAll: TDNMSpeedButton;
    MnuEmptyAllocationThis: TDNMSpeedButton;
    actAdjustThisProductbinbatch: TDNMAction;
    actAdjustAllProductsBinBatch: TDNMAction;
    actEmptythisProductbins: TDNMAction;
    actEmptyAllproductbins: TDNMAction;
    DNMPanel37: TDNMPanel;
    btnMoveStockToDefaultbin: TDNMSpeedButton;
    DNMPanel38: TDNMPanel;
    QryPartHirePricing: TERPQuery;
    QryPartHirePricingLines: TERPQuery;
    QryPartHirePricingHirePriceId: TIntegerField;
    QryPartHirePricingGlobalref: TWideStringField;
    QryPartHirePricingMinHirePeriod: TIntegerField;
    QryPartHirePricingMinHirePeriodType: TWideStringField;
    QryPartHirePricingProductID: TIntegerField;
    QryPartHirePricingEquipmentId: TIntegerField;
    QryPartHirePricingActive: TWideStringField;
    QryPartHirePricingmstimestamp: TDateTimeField;
    QryPartHirePricingmsUpdatesiteCode: TWideStringField;
    QryPartHirePricingLinesHirePriceLineId: TIntegerField;
    QryPartHirePricingLinesGlobalref: TWideStringField;
    QryPartHirePricingLinesHirePriceID: TIntegerField;
    QryPartHirePricingLinesDurationID: TIntegerField;
    QryPartHirePricingLinesDurationName: TWideStringField;
    QryPartHirePricingLinesRate: TFloatField;
    QryPartHirePricingLinesActive: TWideStringField;
    QryPartHirePricingLinesmstimestamp: TDateTimeField;
    QryPartHirePricingLinesmsUpdatesiteCode: TWideStringField;
    mnugrdSerials: TAdvPopupMenu;
    mnuEquipment: TMenuItem;
    qryProductTotalLandedCost: TFloatField;
    tabLatestCost: TTabSheet;
    QryLatestCost: TERPQuery;
    dsLatestCost: TDataSource;
    QryLatestCostNo: TLargeintField;
    QryLatestCostPurchaseOrderID: TIntegerField;
    QryLatestCostSupplierName: TWideStringField;
    QryLatestCostOrderDate: TDateTimeField;
    QryLatestCostProductName: TWideStringField;
    QryLatestCostUOM: TWideStringField;
    QryLatestCostUnitofMeasureShipped: TFloatField;
    QryLatestCostInvoiceDate: TDateField;
    DNMPanel39: TDNMPanel;
    Label50: TLabel;
    grdLatestCost: TwwDBGrid;
    QryLatestCostLineCost: TFloatField;
    QryLatestCostLineCostInc: TFloatField;
    QryLatestCostIgnoreSupplierforProductLatestCost: TWideStringField;
    Label44: TLabel;
    qrySellPricesGlobalRef: TWideStringField;
    qrySellPricesTerms: TWideStringField;
    qrySellPricesmsTimeStamp: TDateTimeField;
    qrySellPricesActive: TWideStringField;
    qrySellPricesmsUpdateSiteCode: TWideStringField;
    QryTerms: TERPQuery;
    cboTerms: TwwDBLookupCombo;
    btnMakeEquipment: TDNMSpeedButton;
    mnuEquip: TAdvPopupMenu;
    mnuProdEquip: TMenuItem;
    qryProductRequireSignature: TWideStringField;
    qryProductIsSegregatedProduct: TWideStringField;
    qryProductExcludeFromSmartOrder: TWideStringField;
    qryProductHideWastage: TWideStringField;
    btnQtyAdjust: TDNMSpeedButton;
    qryRelatedPartsGlobalRef: TWideStringField;
    qryRelatedPartsParentQty: TFloatField;
    qryRelatedPartsmsTimeStamp: TDateTimeField;
    qryRelatedPartsmsUpdateSiteCode: TWideStringField;
    pnlRelatedPArtsHelp: TDNMPanel;
    DNMPanel41: TDNMPanel;
    DNMSpeedButton3: TDNMSpeedButton;
    DNMSpeedButton4: TDNMSpeedButton;
    btnREorderpoints: TDNMSpeedButton;
    btnMakeBOM: TDNMSpeedButton;
    lblTotal: TLabel;
    splshowTransactionhistory: TSplitter;
    pnlProductQtycheck: TDNMPanel;
    qryExtraBuyPriceSupplierBarCode: TWideStringField;
    chkshowTransactionhistory: TCheckBox;
    qryProductClassUseproductforecastformula: TWideStringField;
    btnUseFormala: TDNMSpeedButton;
    btndonotUseFormala: TDNMSpeedButton;
    cbDutiesSupplier: TwwDBLookupCombo;
    cbDutiesCountry: TwwDBLookupCombo;
    grdDuties: TwwDBGrid;
    CopySerialNumber1: TMenuItem;
    dsImportProducts: TDataSource;
    qryImportProducts: TERPQuery;
    qryImportProductsID: TIntegerField;
    qryImportProductspartname: TWideStringField;
    qryImportProductsSupplier: TWideStringField;
    qryImportProductsCountry: TWideStringField;
    qryImportProductsduty: TFloatField;
    qryImportProductshandling: TFloatField;
    qryImportProductssupplierId: TIntegerField;
    qryImportProductsCountryofOriginId: TIntegerField;
    DNMPanel42: TDNMPanel;
    Memo1: TMemo;
    Label1: TLabel;
    btnMultiAdjust: TDNMSpeedButton;
    wwDBGrid2: TwwDBGrid;
    Label55: TLabel;
    DBText2: TDBText;
    grdDutiesIButton: TwwIButton;
    qryimportProduct: TERPQuery;
    dsimportProduct: TDataSource;
    qryimportProductCountry: TStringField;
    qryimportProductSupplier: TStringField;
    qryimportProductGlobalRef: TWideStringField;
    qryimportProductID: TIntegerField;
    qryimportProductSupplierId: TIntegerField;
    qryimportProductProductId: TIntegerField;
    qryimportProductCountryOfOriginId: TIntegerField;
    qryimportProductDuty: TFloatField;
    qryimportProductHandling: TFloatField;
    qryimportProductmsTimeStamp: TDateTimeField;
    qryimportProductmsupdateSitecode: TWideStringField;
    qryimportProductDetails: TWideStringField;
    wwDBEdit5: TwwDBEdit;
    Label60: TLabel;
    qryProductMultibuy: TWideStringField;
    DNMPanel44: TDNMPanel;
    Label61: TLabel;
    edtURL: TDBEdit;
    qryProductHyperlink: TWideStringField;
    qryProductSalesTaxBasedon: TWideStringField;
    DNMSpeedButton6: TDNMSpeedButton;
    DNMPanel45: TDNMPanel;
    DNMPanel46: TDNMPanel;
    DNMPanel47: TDNMPanel;
    edtProductionnotes: TDBMemo;
    Label74: TLabel;
    Label76: TLabel;
    edtGeneralNotes: TDBMemo;
    wwDBGrid1: TwwDBGrid;
    Label88: TLabel;
    lblProductPrintName: TLabel;
    edtProductPrintName: TwwDBEdit;
    qryProductProductPrintName: TWideStringField;
    qryProductDefaultWarrantyDuration: TFloatField;
    cboPrintProductsrelated: TERPDbLookupCombo;
    qrySellPricesQtyLimitforDiscount: TFloatField;
    pnlCustFieldsTab: TDNMPanel;
    Label40: TLabel;
    Label48: TLabel;
    pgCustomFields: TPageControl;
    tabCustomFields: TTabSheet;
    pnlcustomfieldList: TDNMPanel;
    DNMPanel32: TDNMPanel;
    Memo2: TMemo;
    TabSheet2: TTabSheet;
    pnlCustFldsFixed: TDNMPanel;
    Bevel14: TBevel;
    Box181: TBevel;
    Label87: TLabel;
    CUSTLBL1: TLabel;
    CUSTLBL2: TLabel;
    CUSTLBL3: TLabel;
    CUSTLBL4: TLabel;
    CUSTLBL5: TLabel;
    CUSTLBL6: TLabel;
    CUSTLBL7: TLabel;
    CUSTLBL8: TLabel;
    CUSTLBL9: TLabel;
    CUSTLBL10: TLabel;
    CUSTLBL11: TLabel;
    CUSTLBL12: TLabel;
    CUSTLBL13: TLabel;
    CUSTLBL14: TLabel;
    CUSTLBL15: TLabel;
    CUSTLBL16: TLabel;
    Label90: TLabel;
    Label94: TLabel;
    CUSTLBL17: TLabel;
    CUSTLBL18: TLabel;
    cmdCustomLabelsOld: TDNMSpeedButton;
    CUSTFLD1: TwwDBComboBox;
    CUSTFLD2: TwwDBComboBox;
    CUSTFLD3: TwwDBComboBox;
    CUSTFLD4: TwwDBComboBox;
    CUSTFLD5: TwwDBComboBox;
    CUSTFLD10: TwwDBComboBox;
    CUSTFLD9: TwwDBComboBox;
    CUSTFLD8: TwwDBComboBox;
    CUSTFLD7: TwwDBComboBox;
    CUSTFLD6: TwwDBComboBox;
    CUSTFLD11: TwwDBComboBox;
    CUSTFLD12: TwwDBComboBox;
    CUSTFLD13: TwwDBComboBox;
    CUSTFLD14: TwwDBComboBox;
    CUSTFLD15: TwwDBComboBox;
    CUSTFLD16: TwwDBDateTimePicker;
    CUSTFLD17: TwwDBDateTimePicker;
    CUSTFLD18: TwwDBDateTimePicker;
    qryProductEnablePackWeight: TWideStringField;
    qryProductIsOTFProduct: TWideStringField;
    DBCheckBox2: TDBCheckBox;
    DNMPanel11: TDNMPanel;
    Label58: TLabel;
    Label66: TLabel;
    lblDocumentPath: TDBText;
    pnlAttachments: TPanel;
    btnOpenDocumentPath: TDNMSpeedButton;
    btnSetDocumentPath: TDNMSpeedButton;
    Label24: TLabel;
    PopupPOMemo: TDBMemo;
    chkShowPurchaseProductPopUp: TDBCheckBox;
    Label39: TLabel;
    PopupMemo: TDBMemo;
    chkShowProductPopUp: TDBCheckBox;
    DNMPanel49: TDNMPanel;
    edtNormalDeliveryTime: TDBEdit;
    Label67: TLabel;
    Label96: TLabel;
    cboProductformula: TwwDBLookupCombo;
    Label116: TLabel;
    chkEnableAutoSplitQtyintoUOMinSales: TwwCheckBox;
    btnSelectUOM: TDNMSpeedButton;
    Label83: TLabel;
    grdAlternateProducts: TwwDBGrid;
    wwDBGrid3IButton: TwwIButton;
    cboProductR: TERPDbLookupCombo;
    cboPrintProductR: TERPDbLookupCombo;
    DBCheckBox3: TDBCheckBox;
    DNMPanel55: TDNMPanel;
    Label17: TLabel;
    Label62: TLabel;
    grdAltBarcodes: TwwDBGrid;
    delAltBarcodes: TwwIButton;
    chkShowInactiveBarcodes: TCheckBox;
    cboBarcodeUOM: TwwDBLookupCombo;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    edtAttrib1Purchase: TDBEdit;
    edtAttrib2Purchase: TDBEdit;
    edtAttrib3Purchase: TDBEdit;
    Label25: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    edtAttrib1Sale: TDBEdit;
    edtAttrib2Sale: TDBEdit;
    edtAttrib3Sale: TDBEdit;
    Label106: TLabel;
    lblProductAttrib1: TLabel;
    edtProductAttrib1: TDBEdit;
    qryProductCostUpdateFromPurchase: TWideStringField;
    pnl1: TDnmPanel;
    pnl2: TDnmPanel;
    pnl3: TDnmPanel;
    pnl5: TDnmPanel;
    pnl6: TDnmPanel;
    pnl7: TDnmPanel;
    pnl9: TDnmPanel;
    pnl10: TDnmPanel;
    pnl11: TDnmPanel;
    pnl12: TDnmPanel;
    pnl13: TDnmPanel;
    pnl14: TDnmPanel;
    pnl4: TDNMPanel;
    Label95: TLabel;
    DBCheckBox35: TwwCheckBox;
    DBCheckBox80: TwwCheckBox;
    pnl8: TDNMPanel;
    Label117: TLabel;
    DBEdit11: TDBEdit;
    btnOpen_sup: TDNMSpeedButton;
    btnOpen_cust: TDNMSpeedButton;
    QryAlternateProductsAlternateProductPrintName: TWideStringField;
    cboPrintProductQry: TERPQuery;
    btnMakeRelatedFromBOM: TDNMSpeedButton;
    qryProductClassIsDefaultStockClass: TWideStringField;
    Label32: TLabel;
    DNMPanel17: TDNMPanel;
    Label52: TLabel;
    wwDBSpinEdit1: TwwDBSpinEdit;
    DNMPanel18: TDNMPanel;
    DNMPanel13: TDNMPanel;
    DBCheckBox4: TDBCheckBox;
    btnOpen_man: TDNMSpeedButton;
    DNMSpeedButton5: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    tabwalmart: TTabSheet;
    dswalmartitems: TDataSource;
    qrywalmartitems: TERPQuery;
    qrywalmartitemsID: TIntegerField;
    qrywalmartitemsGlobalref: TWideStringField;
    qrywalmartitemsMart: TWideStringField;
    qrywalmartitemsSku: TWideStringField;
    qrywalmartitemsWpid: TWideStringField;
    qrywalmartitemsUpc: TWideStringField;
    qrywalmartitemsGtin: TWideStringField;
    qrywalmartitemsProductName: TWideStringField;
    qrywalmartitemsShelf: TWideStringField;
    qrywalmartitemsProductType: TWideStringField;
    qrywalmartitemsPrice_Currency: TWideStringField;
    qrywalmartitemsPrice_Amount: TWideStringField;
    qrywalmartitemsPublishedStatus: TWideStringField;
    qrywalmartitemsNameValueAttributes_Name: TWideStringField;
    qrywalmartitemsNameValueAttributes_Type: TWideStringField;
    qrywalmartitemsAvailabilityCode: TWideStringField;
    qrywalmartitemsERPProductId: TIntegerField;
    qrywalmartitemsSynched: TWideStringField;
    qrywalmartitemsmstimeStamp: TDateTimeField;
    qrywalmartitemsmsUpdatesitecode: TWideStringField;
    DNMPanel24: TDNMPanel;
    qryWalmartUOM: TERPQuery;
    qrywalmartitemsUOMID: TIntegerField;
    qrywalmartitemsUOM: TWideStringField;
    qryWalmartUOMUnitID: TIntegerField;
    qryWalmartUOMUnitName: TWideStringField;
    qryWalmartUOMMultiplier: TFloatField;
    qryWalmartUOMUnitDescription: TWideStringField;
    qryWalmartUOMBaseUnitName: TWideStringField;
    qrywalmartitemsUOMMult: TFloatField;
    qrywalmartitemsUOMQty: TFloatField;
    qryWalmartPriceCurrency: TERPQuery;
    DNMPanel27: TDNMPanel;
    DNMPanel48: TDNMPanel;
    DNMPanel50: TDNMPanel;
    DNMPanel51: TDNMPanel;
    DNMPanel52: TDNMPanel;
    DNMPanel53: TDNMPanel;
    DNMPanel54: TDNMPanel;
    DNMPanel56: TDNMPanel;
    DNMPanel57: TDNMPanel;
    Label91: TLabel;
    edtSku: TwwDBEdit;
    wwDBEdit14: TwwDBEdit;
    wwDBEdit6: TwwDBEdit;
    wwDBEdit8: TwwDBEdit;
    wwDBEdit9: TwwDBEdit;
    wwDBEdit10: TwwDBEdit;
    wwDBEdit11: TwwDBEdit;
    DNMPanel58: TDNMPanel;
    DNMPanel59: TDNMPanel;
    DNMPanel60: TDNMPanel;
    DNMPanel61: TDNMPanel;
    wwDBEdit15: TwwDBEdit;
    wwDBEdit13: TwwDBEdit;
    wwDBEdit12: TwwDBEdit;
    wwDBEdit16: TwwDBEdit;
    cboWalmartUOM: TwwDBLookupCombo;
    DNMPanel63: TDNMPanel;
    wwDBEdit17: TwwDBEdit;
    wwDBEdit18: TwwDBEdit;
    wwDBLookupCombo1: TwwDBLookupCombo;
    Label120: TLabel;
    Label121: TLabel;
    Label53: TLabel;
    Label92: TLabel;
    Label122: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Label127: TLabel;
    DNMPanel64: TDNMPanel;
    Label98: TLabel;
    lblERPSKU: TLabel;
    lblERPProductname: TLabel;
    lblERPWPID: TLabel;
    Label38: TLabel;
    Label99: TLabel;
    lblERPPrice: TLabel;
    DNMPanel62: TDNMPanel;
    wwRadioGroup2: TwwRadioGroup;
    Label104: TLabel;
    DNMPanel65: TDNMPanel;
    Label107: TLabel;
    qrywalmartitemsfulfillmentLagTime: TIntegerField;
    qrywalmartitemsMinfulfillmentLagTime: TIntegerField;
    wwDBSpinEdit2: TwwDBSpinEdit;
    Label119: TLabel;
    DNMPanel66: TDNMPanel;
    Label123: TLabel;
    Label124: TLabel;
    wwDBSpinEdit3: TwwDBSpinEdit;
    wwDBSpinEdit4: TwwDBSpinEdit;
    Label125: TLabel;
    lblwalmartQtyhint: TLabel;
    btnTree: TDNMSpeedButton;
    btnMoveAllStockToDefaultbin: TDNMSpeedButton;
    lblmsg: TLabel;
    tabExcelPrice: TTabSheet;
    pnlPartsExcelPrice: TDNMPanel;
    qryPartNotesmsUpdateSiteCode: TWideStringField;
    DNMPanel69: TDNMPanel;
    pnlSales: TDNMPanel;
    lblSalesdesc: TLabel;
    txtProductDescriptionSale: TDBMemo;
    btnPriceCalc: TDNMSpeedButton;
    pnlPrice: TDNMPanel;
    Label82: TLabel;
    txtSell1: TDBEdit;
    txtSell2: TDBEdit;
    txtSell3: TDBEdit;
    txtRetailPriceInc: TwwDBEdit;
    tglGST: TDNMSpeedButton;
    txtPrice2: TwwDBEdit;
    txtPrice3: TwwDBEdit;
    txtRetailPrice: TwwDBEdit;
    btnLongSaleDesc: TDNMSpeedButton;
    DNMPanel22: TDNMPanel;
    Label14: TLabel;
    Label20: TLabel;
    Label35: TLabel;
    Label81: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    cboINCOMEACC: TwwDBLookupCombo;
    txtWholesalePrice: TDBEdit;
    txtMarkup2: TEdit;
    cboTaxCode: TwwDBLookupCombo;
    edtsalesUOM: TDBEdit;
    btnSalesUOM: TDNMSpeedButton;
    optSalesTaxBasedon: TwwRadioGroup;
    DNMPanel67: TDNMPanel;
    lblUOMtobeUsedinManufactureSales: TLabel;
    chkUOMtobeUsedinManufactureSales: TwwCheckBox;
    DNMPanel12: TDNMPanel;
    Label16: TLabel;
    PartTreeView: TTreeView;
    DNMPanel10: TDNMPanel;
    Label22: TLabel;
    txtProductComment: TDBMemo;
    DNMPanel70: TDNMPanel;
    pnlPurchase: TDNMPanel;
    ProductDescription_Label: TLabel;
    txtProductDescriptionPurchase: TDBMemo;
    btnLongPurchDesc: TDNMSpeedButton;
    pnlCost: TDNMPanel;
    Label80: TLabel;
    txtBuy1: TDBEdit;
    txtBuy2: TDBEdit;
    txtBuy3: TDBEdit;
    txtCostPriceInc: TwwDBEdit;
    txtCost2: TwwDBEdit;
    txtCost3: TwwDBEdit;
    txtCost: TwwDBEdit;
    tglCost: TDNMSpeedButton;
    DNMPanel16: TDNMPanel;
    Label73: TLabel;
    Label75: TLabel;
    Label77: TLabel;
    Label79: TLabel;
    Label3: TLabel;
    lblUOMtobeUsedinManufacturePurchases: TLabel;
    cboPURTaxCode: TwwDBLookupCombo;
    cboSupp: TwwDBLookupCombo;
    cboCOGSACC: TwwDBLookupCombo;
    SupplierCode: TDBEdit;
    DBEdit1: TDBEdit;
    btnPurhcaseUOM: TDNMSpeedButton;
    chkUOMtobeUsedinManufacturePurchases: TwwCheckBox;
    pnlPurchMisc: TDNMPanel;
    Label64: TLabel;
    cboASSETACC: TwwDBLookupCombo;
    DNMPanel36: TDNMPanel;
    Label18: TLabel;
    Label71: TLabel;
    Label36: TLabel;
    Label105: TLabel;
    Label45: TLabel;
    Label49: TLabel;
    btnLandedCost: TDNMSpeedButton;
    edtAvgcost: TDBEdit;
    edtLandedCost: TDBEdit;
    edtLatestCost: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DNMPanel71: TDNMPanel;
    DNMPanel68: TDNMPanel;
    Label78: TLabel;
    txtmarkup: TwwDBEdit;
    rgMarkupType: TwwRadioGroup;
    pnlOptions: TDNMPanel;
    pnlAutoReorder: TDNMPanel;
    lblAutoReorder: TLabel;
    chkAutoReorder: TDBCheckBox;
    pnlDiscontinued: TDNMPanel;
    lblDiscontinued: TLabel;
    chkDiscontinued: TDBCheckBox;
    pnlIncludeInAnalysis: TDNMPanel;
    lblIncludeInAnalysis: TLabel;
    chkIncludeInAnalysis: TDBCheckBox;
    pnlHideonDelDocket: TDNMPanel;
    lblHideonDelDocket: TLabel;
    chkHideonDelDocket: TDBCheckBox;
    pnlAutoSmartOrder: TDNMPanel;
    lblAutoSmartOrder: TLabel;
    chkAutoSmartOrder: TDBCheckBox;
    pnlisEquipment: TDNMPanel;
    lblisEquipment: TLabel;
    chkisEquipment: TDBCheckBox;
    pnlPublishOnWeb: TDNMPanel;
    lblPublishOnWeb: TLabel;
    chkPublishOnWeb: TDBCheckBox;
    pnlHideonPickSlip: TDNMPanel;
    lblHideonPickSlip: TLabel;
    chkHideonPickSlip: TDBCheckBox;
    pnlHideOnPrint: TDNMPanel;
    lblHideOnPrint: TLabel;
    chkHideOnPrint: TDBCheckBox;
    pnlSNTracking: TDNMPanel;
    lblSNTracking: TLabel;
    chkSNTracking: TDBCheckBox;
    pnlCanDeleteInPOS: TDNMPanel;
    lblCanDeleteInPOS: TLabel;
    chkCanDeleteInPOS: TDBCheckBox;
    pnlIsBOMTemplate: TDNMPanel;
    lblIsBOMTemplate: TLabel;
    chkIsBOMTemplate: TDBCheckBox;
    pnlRequiresAssembly: TDNMPanel;
    lblRequiresAssembly: TLabel;
    chkRequiresAssembly: TDBCheckBox;
    pnlSpecialDiscount: TDNMPanel;
    lblSpecialDiscount: TLabel;
    chkSpecialDiscount: TDBCheckBox;
    pnlRequireSignature: TDNMPanel;
    lblRequireSignature: TLabel;
    chkRequireSignature: TDBCheckBox;
    pnlExcludeFromSmartOrder: TDNMPanel;
    lblExcludeFromSmartOrder: TLabel;
    chkExcludeFromSmartOrder: TDBCheckBox;
    DNMPanel40: TDNMPanel;
    lblHideWastage: TLabel;
    chkHideWastage: TDBCheckBox;
    Shape2: TShape;
    qryPartNotesPartsNotesID: TIntegerField;
    qryProductSKU: TWideStringField;
    DNMPanel72: TDNMPanel;
    Label126: TLabel;
    wwDBEdit7: TwwDBEdit;
    cmdCopy: TDNMSpeedButton;
    DNMPanel73: TDNMPanel;
    lblFilter: TLabel;
    edtSearchSN: TEdit;
    btnSearch: TDNMSpeedButton;
    qryProductHasProductOptions: TWideStringField;
    DNMPanel43: TDNMPanel;
    lblMultobuy: TLabel;
    DBCheckBox1: TDBCheckBox;
    DNMPanel74: TDNMPanel;
    Label128: TLabel;
    DBCheckBox5: TDBCheckBox;


    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure tglGSTClick(Sender: TObject);
    procedure txtRetailPriceIncExit(Sender: TObject);
    procedure cmdCopyClick(Sender: TObject);
    procedure txtMarkup2Exit(Sender: TObject);
    procedure cbTaxCodeQryCalcFields(DataSet: TDataSet);
    procedure cmdNewClick(Sender: TObject);
    procedure btnProductClassesClick(Sender: TObject);
    procedure cboClassNameCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure calcUnallocatedBins(var Message: TMessage); message SX_BinQtyChangeMsg;
    procedure calcUnallocatedBatches(var Message: TMessage); message SX_BatchQtyChangeMsg;
    procedure UpdateProductSellInfo(var Message: TMessage); message SX_UpdateProductSellInfo;
    procedure UpdateProductBuyInfo(var Message: TMessage); message SX_UpdateProductBuyInfo;
    procedure FormCreate(Sender: TObject);
    procedure txtRetailPriceExit(Sender: TObject);
    procedure pageControlChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cboClientTypeNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure qrySellPricesBeforePost(DataSet: TDataSet);
    procedure btnDeleteSellPriceClick(Sender: TObject);
    procedure grdSellPricesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure btnDeleteXBuyPriceClick(Sender: TObject);
    procedure qryExtraBuyPriceUsePriceChange(Sender: TField);
    procedure qryExtraBuyPriceSupplierIDChange(Sender: TField);
    procedure btnStretchClick(Sender: TObject);
    procedure mitAddImageClick(Sender: TObject);
    procedure dblcProductTypeChange(Sender: TObject);
    procedure cboClassNameNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboPartLevel3NotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboPartLevel2NotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboPartLevel1NotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure dtpFromCloseUp(Sender: TObject);
    procedure dtpToCloseUp(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
    procedure btnPurchViewClick(Sender: TObject);
    procedure dtpPurchFromCloseUp(Sender: TObject);
    procedure dtpPurchToCloseUp(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure qryProductAfterOpen(DataSet: TDataSet);
    procedure PartTreeViewClick(Sender: TObject);
    procedure edtAttrib1PurchaseExit(Sender: TObject);
    procedure txtCostExit(Sender: TObject);
    procedure edtAttrib1SaleExit(Sender: TObject);
    procedure edtAttrib2PurchaseExit(Sender: TObject);
    procedure edtAttrib2SaleExit(Sender: TObject);
    procedure qrySellPricesAllClientsChange(Sender: TField);
    procedure grdSellPricesRowChanged(Sender: TObject);
    procedure grdSellPricesEnter(Sender: TObject);
    procedure chkShowProductPopUpClick(Sender: TObject);
    procedure qryRelatedPartsBeforePost(DataSet: TDataSet);
    procedure RealtedPartsIButtonClick(Sender: TObject);
    procedure grdRelatedPartsExit(Sender: TObject);
    procedure grdForeignIButtonClick(Sender: TObject);
    procedure qryForeignPriceBeforePost(DataSet: TDataSet);
    procedure qryForeignPriceClientIDChange(Sender: TField);
    procedure tglCostClick(Sender: TObject);
    procedure cboAreaNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure txtBarcodeExit(Sender: TObject);
    procedure qrySellPricesQtyPercent1Change(Sender: TField);
    procedure grdForeignSellIButtonClick(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure txtCostPriceIncExit(Sender: TObject);
    procedure cboPartLevel1Enter(Sender: TObject);
    procedure cboPartLevel2Enter(Sender: TObject);
    procedure cboPartLevel3Enter(Sender: TObject);
    procedure qryProductActiveChange(Sender: TField);
    procedure cboManfProductQryAfterOpen(DataSet: TDataSet);
    procedure cboClientLookupAfterOpen(DataSet: TDataSet);
    procedure cboProductQryAfterOpen(DataSet: TDataSet);
    procedure qryProductLevel1AfterOpen(DataSet: TDataSet);
    procedure qryProductLevel2AfterOpen(DataSet: TDataSet);
    procedure qryProductLevel3AfterOpen(DataSet: TDataSet);
    procedure cboPartLevel1CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboPartLevel2CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboPartLevel3CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure SetComboFocus(var Message: TMessage); message SX_SetFocus;

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pageControlChanging(Sender: TObject;var AllowChange: Boolean);
    procedure qryUnitsOfMeasureQtysAfterOpen(DataSet: TDataSet);
    procedure chkBaseOnShippedClick(Sender: TObject);
    procedure chkBasePurchOnClick(Sender: TObject);
    procedure chkShowAllClick(Sender: TObject);
    procedure edtMinQtyExit(Sender: TObject);
    procedure qryForeignPriceSellClientIDChange(Sender: TField);
    procedure cboUnitOfTimeNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure wwIButton1Click(Sender: TObject);
    procedure MiscPageControlChange(Sender: TObject);
    procedure qrySpecificationsBeforePost(DataSet: TDataSet);
    procedure CheckClick(Sender: TObject);
    procedure qrySpecificationsIsMultiplierChange(Sender: TField);
    procedure cboSupplierForeignCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboSupplierForeignDropDown(Sender: TObject);
    procedure cboCurrencyCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboCurrencyDropDown(Sender: TObject);
    procedure qryProductBeforePost(DataSet: TDataSet);
    procedure qryProductAfterPost(DataSet: TDataSet);
    procedure edtPartExit(Sender: TObject);
    procedure cboManufProdCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure chkSNTrackingEnter(Sender: TObject);
    procedure dblcProductTypeExit(Sender: TObject);
    procedure cboPartLevel2Exit(Sender: TObject);
    procedure cboCurrencyCodeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure txtmarkupExit(Sender: TObject);
    procedure qrySpecificationsAfterScroll(DataSet: TDataSet);
    procedure btnCopyClick(Sender: TObject);
    procedure qryProductAfterInsert(DataSet: TDataSet);
    procedure qryProductSupplierProductCodeChange(Sender: TField);
    procedure qryUnitsOfMeasureQtysCalcFields(DataSet: TDataSet);
    procedure btnGroupCopyClick(Sender: TObject);
    procedure dblcProductTypeNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure cbTaxCodeQryBeforeOpen(DataSet: TDataSet);
    procedure FormResize(Sender: TObject);
    procedure cboTaxCodeExit(Sender: TObject);
    procedure cboPURTaxCodeChange(Sender: TObject);
    procedure cboPURTaxCodeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure txtWholesalePriceExit(Sender: TObject);
    procedure qryProductWHOLESALEPRICEChange(Sender: TField);
    procedure qryProductAfterDelete(DataSet: TDataSet);
    procedure btnLongSaleDescClick(Sender: TObject);
    procedure btnNewUOMClick(Sender: TObject);
    procedure qryProductClassAfterInsert(DataSet: TDataSet);
    procedure cboClassNameDropDown(Sender: TObject);
    procedure qryProductClassBeforePost(DataSet: TDataSet);
    procedure grdProductClassesCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure qryProductClassClassPriceVarianceChange(Sender: TField);
    procedure grdProductClassesRowChanged(Sender: TObject);
    procedure qryProductClassVariantPriceChange(Sender: TField);
    procedure grdProductClassesExit(Sender: TObject);
    procedure cboBinBatchClassChange(Sender: TObject);
    procedure cboBinBatchClassDropDown(Sender: TObject);
    procedure chkBatchesClick(Sender: TObject);
    procedure chkMultipleBinsClick(Sender: TObject);
    procedure chkMultipleBinsEnter(Sender: TObject);
    procedure chkBatchesEnter(Sender: TObject);
    procedure cboClass4SerialnoChange(Sender: TObject);
    procedure grdSerialsDblClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);
    procedure cboDefaultBinCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdProductClassesDblClick(Sender: TObject);
    procedure cboDefaultBinDropDown(Sender: TObject);
    procedure qryProductClassDefaultbinIdSetText(Sender: TField;const Text: String);
    procedure BinBatchAllocationDblClick(Sender: TObject);
    procedure grdUnitOfMeasureQtysCalcCellColors(Sender: TObject;
      Field: TField; State: TGridDrawState; Highlight: Boolean;
      AFont: TFont; ABrush: TBrush);
    procedure cmdNewSrnoClick(Sender: TObject);
    procedure qryProductBARCODESetText(Sender: TField; const Text: String);
    procedure qryPartBarCodesBarCodeSetText(Sender: TField;
      const Text: String);
    procedure qryPartBarCodesPostError(DataSet: TDataSet;E: EDatabaseError; var Action: TDataAction);
    procedure cboPURTaxCodeExit(Sender: TObject);
    procedure delAltBarcodesClick(Sender: TObject);
    procedure cmdCustomLabelsOldClick(Sender: TObject);
    procedure PageMovementsChange(Sender: TObject);
    procedure QryPartsProcessAfterInsert(DataSet: TDataSet);
    procedure deleteProcessStepClick(Sender: TObject);
    procedure cboProcessStepCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdPartsProcessExit(Sender: TObject);
    procedure QryPartsProcessBeforeInsert(DataSet: TDataSet);
    procedure QryPartsProcessBeforePost(DataSet: TDataSet);
    procedure qryPartPicsBeforePost(DataSet: TDataSet);
    procedure qryPartPicsAfterInsert(DataSet: TDataSet);
    procedure qryPartBarCodesIsprimaryBarcodeChange(Sender: TField);
    procedure chkShowInactiveBarcodesClick(Sender: TObject);
    procedure cboDefaultBin4classNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure cboDefaultBinNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure cboDefaultBinExit(Sender: TObject);
    procedure qryPartPicsAfterScroll(DataSet: TDataSet);
    procedure qryPartPicsAfterOpen(DataSet: TDataSet);
    procedure qryPartPicsAfterPost(DataSet: TDataSet);
    procedure rgMarkupTypeClick(Sender: TObject);
    procedure qryProductGrossMarginModeSetText(Sender: TField;
      const Text: String);
    procedure qryForeignPricePriceGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure qryForeignPriceSellPriceGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure QryInTransationAfterOpen(DataSet: TDataSet);
    procedure btnRecalculateAvgcostClick(Sender: TObject);
    procedure grdIntransDrawFooterCell(Sender: TObject; Canvas: TCanvas;
      FooterCellRect: TRect; Field: TField; FooterText: String;
      var DefaultDrawing: Boolean);
    procedure grdIntransCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure QryInTransationCalcFields(DataSet: TDataSet);
    procedure stockCostSystemEnter(Sender: TObject);
    procedure edtAvgcostDblClick(Sender: TObject);
    procedure chkisEquipmentClick(Sender: TObject);
    procedure actEquipmentUpdate(Sender: TObject);
    procedure ExtraPriceUOMCloseup(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qrySellPricesCalcFields(DataSet: TDataSet);
    procedure grdForeignSellEnter(Sender: TObject);
    procedure grdBuyPriceEnter(Sender: TObject);
    procedure grdForeignEnter(Sender: TObject);
    procedure qryExtraBuyPricePriceChange(Sender: TField);
    procedure qryForeignPriceSellAfterInsert(DataSet: TDataSet);
    procedure qryForeignPriceSellCalcFields(DataSet: TDataSet);
    procedure qryExtraBuyPriceCalcFields(DataSet: TDataSet);
    procedure qryForeignPriceCalcFields(DataSet: TDataSet);
    procedure qryExtraBuyPriceAfterInsert(DataSet: TDataSet);
    procedure qrySellPricesAfterPost(DataSet: TDataSet);
    procedure qryForeignPriceSellPrice1Change(Sender: TField);
    procedure qryForeignPriceAfterInsert(DataSet: TDataSet);
    procedure qrySellPricesAfterInsert(DataSet: TDataSet);
    procedure qryForeignPriceSellAfterPost(DataSet: TDataSet);
    procedure qryExtraBuyPriceAfterPost(DataSet: TDataSet);
    procedure qryForeignPriceAfterPost(DataSet: TDataSet);
    procedure qrySellPricesUOMChange(Sender: TField);
    procedure wwDBGrid1Enter(Sender: TObject);
    procedure qryProductClassReOrderAmountSetText(Sender: TField;
      const Text: String);
    procedure cboPartLevel1Exit(Sender: TObject);
    procedure cboPartLevel3Exit(Sender: TObject);
    procedure ChangePODefaultUOM(Sender: TObject);
    procedure ChangeSalesDefaultUOM(Sender: TObject);
    procedure OnChangeUOMtobeUsedinManufacture(Sender: TObject);
    procedure btnAutoFillClick(Sender: TObject);
    procedure cboProcessStepBeforeDropDown(Sender: TObject);
    procedure qryPartBarCodesAfterInsert(DataSet: TDataSet);

    procedure FormKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure cboSuppEnter(Sender: TObject);
    procedure cboPartLevelDblClick(Sender: TObject);
    procedure grdAlternateProductsEnter(Sender: TObject);
    procedure QryAlternateProductsBeforeInsert(DataSet: TDataSet);
    procedure QryAlternateProductsAfterInsert(DataSet: TDataSet);
    procedure wwDBGrid3IButtonClick(Sender: TObject);
    procedure QryAlternateProductsBeforePost(DataSet: TDataSet);
    procedure QryAlternateProductsIsDefaultChange(Sender: TField);
    procedure QryAlternateProductsAlternateProductNameChange(Sender: TField);
    procedure qryProductDiscontinuedChange(Sender: TField);
    procedure chkDiscontinuedClick(Sender: TObject);
    procedure cboProductsRelatedAfterchange(Sender: TObject);
    procedure qrySellPricesPrice1Change(Sender: TField);

    procedure qryProductPRICE1Change(Sender: TField);
    procedure qryProductPRICEINC1Change(Sender: TField);
    procedure qryProductPRICEINC2Change(Sender: TField);
    procedure qryProductPRICEINC3Change(Sender: TField);


    procedure qryProductCOSTINC1Change(Sender: TField);
    procedure qryProductCOSTINC2Change(Sender: TField);
    procedure qryProductCOSTINC3Change(Sender: TField);
		procedure qryProductCOST1Change(Sender: TField);
    procedure qryProductClassAfterOpen(DataSet: TDataSet);
    procedure mnuauditTrialClick(Sender: TObject);
    procedure qryPartPicsBeforeDelete(DataSet: TDataSet);
    procedure chkActiveClick(Sender: TObject);
    procedure btnDetailsClick(Sender: TObject);
    procedure memPartCalcformulaEnter(Sender: TObject);
    procedure memPartCalcformulaExit(Sender: TObject);
    procedure memPartCalcformulaChange(Sender: TObject);
    procedure cboPartCalcformulaUOMCloseUp(Sender: TObject; LookupTable,FillTable: TDataSet; modified: Boolean);
    procedure pnlformulaEnter(Sender: TObject);
    procedure explainformula(Sender: TObject);
    procedure makeformula(Sender: TObject);
    procedure dblcProductTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure chkDefaultPicClick(Sender: TObject);
    procedure qryProductSell_Cost_PercentageChange(Sender: TField);
    procedure qryRelatedPartsAfterInsert(DataSet: TDataSet);
    procedure DBEdit1DblClick(Sender: TObject);
    procedure edtsalesUOMDblClick(Sender: TObject);
    procedure TmrRoundingPriceHintTimer(Sender: TObject);
    procedure OnExitPriceEdit(Sender: TObject);
    procedure txtPrice2Exit(Sender: TObject);
    procedure txtPrice3Exit(Sender: TObject);
    procedure btnMoveStockToDefaultbinClick(Sender: TObject);
    procedure btnManViewClick(Sender: TObject);
    procedure dtpFromManCloseUp(Sender: TObject);
    procedure dtpToManCloseUp(Sender: TObject);
    procedure qryProductPARTTYPEChange(Sender: TField);
    procedure qryRelatedPartsISContainerChange(Sender: TField);
    procedure qryRelatedPartsISPalletChange(Sender: TField);
    procedure qryRelatedPartsIsToRoundtoNextNumberinSalesChange(Sender: TField);
    procedure qryRelatedPartsIsToRoundtoPreviousNumberinSalesChange(Sender: TField);
    procedure btnRefreshClick(Sender: TObject);
    procedure qryProductPARTNAMEChange(Sender: TField);
    procedure qryProductGrossMarginModeChange(Sender: TField);
    procedure memqryProductBeforeInsert(DataSet: TDataSet);
    procedure btnSelectUOMClick(Sender: TObject);
    procedure chkEnableAutoSplitQtyintoUOMinSalesClick(Sender: TObject);
    procedure qrySellPricesAfterOpen(DataSet: TDataSet);
    procedure cboCOGSACCEnter(Sender: TObject);
    procedure cboCOGSACCExit(Sender: TObject);
    procedure cboPURTaxCodeEnter(Sender: TObject);
    procedure cboINCOMEACCEnter(Sender: TObject);
    procedure cboTaxCodeEnter(Sender: TObject);
    procedure cboINCOMEACCExit(Sender: TObject);
    procedure btnConvertImageClick(Sender: TObject);
    procedure cboASSETACCEnter(Sender: TObject);
    procedure cboASSETACCExit(Sender: TObject);
    procedure chkHideOnPrintEnter(Sender: TObject);
    procedure chkHideOnPrintExit(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnLongPurchDescClick(Sender: TObject);
    procedure lsTDNMSpeedButtonActionsUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure btnSetDocumentPathClick(Sender: TObject);
    procedure btnOpenDocumentPathClick(Sender: TObject);
    procedure qryProductCalcFields(DataSet: TDataSet);
    procedure qryExtraBuyPriceBeforePost(DataSet: TDataSet);
    procedure chkShowPurchaseProductPopUpClick(Sender: TObject);
    procedure QrySerialnoAfterOpen(DataSet: TDataSet);
    procedure lstImageTypesClickCheck(Sender: TObject);
    procedure btnPriceCalcClick(Sender: TObject);
    procedure qryProductClassWastagePercentageChange(Sender: TField);
    procedure grdIntransDblClick(Sender: TObject);
    procedure actAdjustThisProductbinbatchUpdate(Sender: TObject);
    procedure actEmptythisProductbinsUpdate(Sender: TObject);
    procedure actAdjustThisProductbinbatchExecute(Sender: TObject);
    procedure actAdjustAllProductsBinBatchExecute(Sender: TObject);
    procedure actEmptythisProductbinsExecute(Sender: TObject);
    procedure actEmptyAllproductbinsExecute(Sender: TObject);
    procedure qryProductAfterScroll(DataSet: TDataSet);
    procedure QryPartHirePricingAfterInsert(DataSet: TDataSet);
    procedure QryPartHirePricingLinesAfterInsert(DataSet: TDataSet);
    procedure QryPartHirePricingAfterOpen(DataSet: TDataSet);
    procedure QryPartHirePricingAfterPost(DataSet: TDataSet);
    procedure QryPartHirePricingAfterScroll(DataSet: TDataSet);
    procedure QryPartHirePricingLinesBeforeInsert(DataSet: TDataSet);
    procedure mnuEquipmentClick(Sender: TObject);
    procedure pnlOptionsEnter(Sender: TObject);
    procedure qryProductPARTNAMESetText(Sender: TField; const Text: string);
    procedure edtLandedCostDblClick(Sender: TObject);
    procedure btnLandedCostClick(Sender: TObject);
    procedure QryLatestCostBeforeOpen(DataSet: TDataSet);
    procedure grdLatestCostCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure edtLatestCostDblClick(Sender: TObject);
    procedure btnMakeEquipmentClick(Sender: TObject);
    procedure mnuProdEquipClick(Sender: TObject);
    procedure mnuEquipPopup(Sender: TObject);
    procedure cboReorderPointsExit(Sender: TObject);
    procedure btnQtyAdjustClick(Sender: TObject);
    procedure qryRelatedPartsQtyChange(Sender: TField);
    procedure qryRelatedPartsParentQtyChange(Sender: TField);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure DNMSpeedButton4Click(Sender: TObject);
    procedure btnReorderPointsClick(Sender: TObject);
    procedure btnMakeBOMClick(Sender: TObject);
    procedure chkshowTransactionhistoryClick(Sender: TObject);
    procedure UpdateUseFormala(Sender: TObject);
    procedure CopySerialNumber1Click(Sender: TObject);
    procedure grdSerialsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure qryImportProductsBeforeOpen(DataSet: TDataSet);
    procedure btnMultiAdjustClick(Sender: TObject);
    procedure cbDutiesCountryCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cbDutiesSupplierCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdDutiesIButtonClick(Sender: TObject);
    procedure qryimportProductCalcFields(DataSet: TDataSet);
    procedure qryimportProductAfterInsert(DataSet: TDataSet);
    procedure qryimportProductBeforePost(DataSet: TDataSet);
    procedure qryimportProductAfterScroll(DataSet: TDataSet);
    procedure DNMSpeedButton6Click(Sender: TObject);
    procedure edtProductPrintNameExit(Sender: TObject);
    procedure qryProductProductPrintNameChange(Sender: TField);
    procedure qryRelatedPartsProductIDChange(Sender: TField);
    procedure pageControlResize(Sender: TObject);
    procedure edtProductPrintNameChange(Sender: TObject);
    Procedure OpenCostStructureDoc(Sender :TObject);
    procedure OpenSupplierHistory(Sender: TObject);
    procedure OpenCustomerHistory(Sender: TObject);
    procedure QryAlternateProductsAfterOpen(DataSet: TDataSet);
    procedure grdAlternateProductsTitleButtonClick(Sender: TObject;
      AFieldName: string);
    procedure btnMakeRelatedFromBOMClick(Sender: TObject);
    procedure qryProductClassIsDefaultStockClassChange(Sender: TField);
    procedure edtProductPrintNameEnter(Sender: TObject);
    procedure txtProductDescriptionPurchaseEnter(Sender: TObject);
    procedure txtProductDescriptionSaleEnter(Sender: TObject);
    procedure txtProductDescriptionPurchaseExit(Sender: TObject);
    procedure txtProductDescriptionSaleExit(Sender: TObject);
    procedure DNMSpeedButton5Click(Sender: TObject);
    procedure qryProductNormalDeliveryTimeSetText(Sender: TField;
      const Text: string);
    procedure qryRelatedPartsBeforeOpen(DataSet: TDataSet);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure qrywalmartitemsAfterInsert(DataSet: TDataSet);
    procedure cboWalmartUOMCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qrywalmartitemsAfterOpen(DataSet: TDataSet);
    procedure ControlfocusProductId(Sender: TObject);
    procedure ControlfocusProductPrintname(Sender: TObject);
    procedure ControlfocusSalesUOM(Sender: TObject);
    procedure lblERPPriceClick(Sender: TObject);
    procedure qryWalmartUOMBeforeOpen(DataSet: TDataSet);
    procedure lblwalmartQtyhintClick(Sender: TObject);
    procedure btnTreeClick(Sender: TObject);
    procedure MyConnectionAfterCommit(Sender: TObject);
    procedure qryPartNotesAfterInsert(DataSet: TDataSet);
    procedure qryPartNotesAfterPost(DataSet: TDataSet);
    procedure qryProductSalesTaxBasedonChange(Sender: TField);
    procedure optSalesTaxBasedonChange(Sender: TObject);
    procedure edtSearchSNKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);


  private
    { Private declarations }
    fiseq:Integer;
    ispricechanging:Boolean;
    fLastcombo  : TwwDbLookupcombo;
    fNewManufactureExitExecuted : boolean;
    bInitialisedNewPart     : Boolean;
    bUpdatingSellInfo       : Boolean;
    bUpdatingBuyInfo        : Boolean;
    bUpdatingSellPrice      : Boolean;
    bNewPart                : Boolean;
    fbIsHireProduct         : Boolean;

    fState                  : TDataSetState;
    bIsChangingPercent      : Boolean;
    bIsChangingPrices       : Boolean; // prevents recursion in on change event
    bAccessEnabled          : Boolean; // set according to access level
    dOldCost                : double;
    bCheckLinkNumInProgress : boolean;
    bRunOnceVariant         : boolean;
    bFinishedOnShow         : boolean;
    AttachmentForm          : TfmAttachments;
    IsSerialformshown       : Boolean;
    fbCurPage               : TTabSheet;
    bCopyPart               : Boolean;
    iCopyPartID             : Integer;
    fbCanClose              : Boolean;
    inQtyPriceValidation    : Boolean;
    updatedDefaultbin       : Boolean;
    InTransTotQty, InTransTotCost:double;
    InTransInstockQty, IntransInstockValue :Double;
    inTransLandedCostsPerItem:double;
    bUOMPriceChangeInProgress           : boolean;
    bPriceMatrixPcent1ChangeInProgress  : boolean;
    ffrmListSupplierProductReport       : TBaseListingGUI;
    ffrmListSalesReport     : TBaseListingGUI;
    fFrmProductQtycheck     : TBaseListingGUI;
    ProductAllocationForm :TfmProductAllocationTree;
    Flags: TIntegerList;
    ProductClassID:Integer;
    ProductBarcodeList: TProductBarcodeList;
    DoingOnTabchange: boolean;
    LastKeyId: integer;
    ForeignCurrency: TCurrency;
    ProductCommissionList:TBaselistingGUI;
    CleanIsEquipment:Boolean;
    ProductInTransTablename :String;
    AlternateProductsIsDefaultChanging:Boolean;
    CalcQtyformulaREadonly:boolean;
    ChangingUOMtobeUsedinManufacture:Boolean;
    ProductclassPartsID:Integer;
    PartsPriceMatrixForm :TfmPartsPriceMatrix;
    DefaultBinsAssignedtoClasses:String;
    AdjustBatchno:String;
    SAOriginalno :String;
    fbPartHasTree: Boolean;
    fsPrice:String;
    RoundingPriceHint:THintWindow;
    fbValidatingProductcostPrice:boolean;
    formshown:boolean;
    fbPricechanged :Boolean;
    fOnAfterSaveProduct: TNotifyEvent;
    fbValidatingdisPercent :Boolean;
    slPictureCodes: TStringList;
    ProductPicture: TProductPicture;
    fdProductMarkupPrice: Double;
    HirePricingform :TfmHirePricing;
    fbPriceExMode :Boolean;
    fbCostExMode:boolean;
    Cost1OldValue: double;
    CostInc1OldValue: double;
    fbShowtotalLandedcost: Boolean;
    fProductQtyAdjobj :TProductQtyAdjObj;
    ERPHelpDocViewer : TfmERPHelpDocViewer;
    fsFilenamePrefix :STring;
    fSelectedProducts: TIntegerSet;
    fSelectedDuties: TDutiesRecord;
    fbUpdatingcompanyonName :Boolean;
    fbPartnameMadeFromName:Boolean;
    fbcleanBatch, fbCleanMultipleBins, fbCleanSNTracking:Boolean;
    SavedAccessLevel: integer;
    fbAftershowAutoFocusingToPage :Boolean;
    //fbPartsExcelPriceCreated :Boolean;
    aPartsExcelPrice :TComponent;

    Procedure EditDB(Dataset:TDataset);
    Procedure PostDB(Dataset:TDataset);
    function GetPurchGrandTotal(const dtStart, dtEnd: TDateTime): Double;
    function GetSalesGrandTotal(const dtStart, dtEnd: TDateTime): Double;
    function PreSaveProduct: Boolean;
    function ProductGroupJoin: string;
    Function  BuyQty_Prices :Boolean; overload;
    Function  SellQty_Prices:Boolean;
    Function QtyPriceValidation(Qty1,Qty2,Qty3, Price1, Price2, Price3:TField; IsSale :Boolean= False) :Boolean;
    procedure GetPurchDB;
    procedure GetSalesDB;
    procedure LoadPurchGrid;
    procedure LoadSalesGrid;
    procedure OpenUnitsOfMeasureQtys(const ClassID: Integer);
    procedure PrepareQueries;
    procedure ProductTreeOrder;
    procedure ResetExtraSellPrice;
    procedure ResetVariantPrice;
    Function  SaveProduct:Boolean ;
    procedure SetNewDefaults;
    Procedure CreateQtyLines;
    Function  ProductNameUnique :boolean;
    Function Validate:Boolean;
    procedure SetFocusToAccCombo(var Msg: TMessage); overload;message WM_SetFocus;
    procedure SetFocusToAccCombo(const AccComboNO:Integer);  overload;
    Procedure Ontabcommission(Sender:TObject);
    Procedure OnTabSupplierHistory(sender:TObject);
    Procedure OnTabCustomerHistory(Sender:TObject);
    Procedure OnTabMain(Sender:TObject);
    Procedure OnTabQuantities(sender:TObject);

    Procedure OnTabExtraBuyPrice(sender:TObject);
    Procedure OnTabExtraSellPrice(sender:TObject);
    Procedure OnTabSalesMovement(Sender:TObject);
    Procedure onTabtabInTrans(Sender:TObject);

    Procedure OnTabPurchaseMovement(Sender:TObject);
    Procedure OnTabMan(Sender:TObject);
    Procedure OntabLatestCost(Sender:TObject);
    Procedure OnTabMisc(Sender :TObject);
    Procedure OnTabRelatedParts(Sender:TObject);
    Procedure OnTabmanufacture(Sender:TObject);
    Procedure ontabTabProductMovement(Sender:TObject);
    Function  OnTabchange(Sender :TObject; var PriorityName1, PriorityName2: string; var PriorityID1,PriorityID2: Integer): boolean;
    Procedure OpenQryQty;
    Function ProductInStockQty :double;
    Procedure LoadQryQty(PartsID:Integer);
    procedure WMSysCommand(var Message:TWMSysCommand); message WM_SYSCOMMAND;
    Procedure UOMQueries;
    Procedure updateDefaultbin;
    function ProductSaved :boolean;
    procedure RefreshBarcodeGrid;
    Procedure CalcmarkupforPrice;
    Procedure CostPriceMarkupCalc(Sender: TField);
    Procedure CalcPriceformarkup;
    Procedure CalcCostformarkup;
    function GetNewDatasetinTransaction(Const strSql :String):TCustomMyDataset;
    Procedure CalPriceCostPercent(calcfield:Integer);
    Procedure LoadqryUnitsOfMeasureQtys;
    Procedure LoadIntrans;
    procedure dobeforeExecute(Sender: TObject; var SQL: String;
      var Omit: Boolean);
    Function IsNewProductRec:Boolean;
    Procedure OpenEquipform(Serialnumber:String='');
    Procedure AddnewIfEmpty(Ds:TDataset);
    function ChkCustReqdFields: boolean;
    Procedure AssignPODefaultUOM(Sender:TwwDbGrid);
    Procedure AssignSalesDefaultUOM(Sender:TwwDbGrid);
    Procedure ReadUOMGrid(Sender:TObject; var UnitId:Integer; Var PartID:Integer;var xUnitName:String; var UOMMultiplier:Double);
    Procedure CreateDefaultUOM(UnitId:Integer; PartID:Integer;xUnitName:String;Category:String;UOMMultiplier:Double);
    Function UOMLockMsg:String;
    Procedure ShowUOMfields(ShowRegardless: boolean = false);
    function ClassIDs: String;
    Procedure AssignProductId(Sender:TObject);
    Function SupplierProductReportListForm       : TBaseListingGUI;
    Function SalesReportListForm     : TBaseListingGUI;
    Function ProductQtycheckForm     : TBaseListingGUI;
    function SavePriceMatrix:boolean;
    procedure InitAttachment;
    Function AllocationOptionsconfirmed:Boolean;
    procedure TransAuditTrialbeforeShow(Sender: TObject);
    procedure beforeshowProductPurchaseMovementList(Sender: TObject);
    procedure iniTPartCalcFormulaOptions;
    procedure mnuPartCalcformulafieldsClick(Sender: TObject);
    function IsSearchPartcalcformulaValid: Boolean;
    procedure doSearchPartcalcformulaValidate;

    procedure PartCalcformulahint(hintvalue: String);
    procedure Partcalcformulatofields;
    procedure PartcalcfieldsToformula;
    procedure ValidateAllocation(Alloctype: String);
    procedure FormulaDetails;
    Procedure ClearPartCalcformulahint;
    procedure DoCalcQtyformulaREadonly;
    procedure PartcalcformulaExampleVar(Sender: TObject; const VarName: string;var Value: extended; var FieldFound: Boolean);
    procedure DoSearchPartcalcformulaVar(Sender: TObject; const VarName: string;var Value: extended; var FieldFound: Boolean);
    procedure beforeshowStockAdjustEntryList(Sender: TObject);
    function isOktoAdjust(Batchno, BinLocation,Serialnumber: String): Boolean;
    procedure setPartHasTree(const Value: Boolean);
    procedure beforeShowDrillform(Sender: TObject);
    procedure beforeShowProductInvInfo(Sender: TObject);
    procedure beforeshowReorderPoints(Sender : TObject);
    Function InitUOM(const UOMName: String; UOMQry :TDataset):Integer;
    procedure ValidatedisPercent(const ShowMessge:Boolean = true);
    procedure UpdateExtraSellprice;
    function RoundProductPriceTo5C(const ProductPrice: currency): currency;
    procedure ShowPriceroundhint(edt:TwwDBEdit);
    procedure GetManDB;
    procedure LoadManGrid;
    procedure REadProductMovementGuiprefs(const Tabindex:Integer);
    procedure WriteProductMovementGuiPres;
    Procedure InitProductMovementTab;
    function HasContainer(const RelatedID: Integer): Boolean;
    function HasPallet(const RelatedID: Integer): Boolean;
    procedure refreshProductAllocationForm;
    procedure RecalculateMargins;
    procedure ValidateProductCostPrice(Sender: TField);
    procedure beforeshowUOMforAutoSplitQtyinSales(Sender: TObject);
    procedure RefreshProductPic(DataSet: TDataSet);
    procedure initProductPictureList(Sender: TObject);
    procedure AlignOptionCheckBoxes;
    procedure initproductId(Sender: TObject);
    function IsNewProduct:Boolean;
    procedure AdjustThisProductbins(Emptybin :Boolean =False);
    procedure AdjustAllProductBins(Emptybin :Boolean =False);
    procedure setIsHireProduct(const Value: Boolean);
    procedure REfreshhirePriceLines;
    procedure initEquipForm(Sender: TObject);
    procedure OnSaveEquip(Sender: TObject);
    procedure SetCostExMode(const Value: Boolean);
    procedure setPriceExMode(const Value: Boolean);
    procedure SetShowtotalLandedcost(const Value: Boolean);
    procedure CheckForSNEquipmentnAllocateForHire;
    procedure initSerialsAllocatedInPO(Sender: Tobject);
    procedure OnSelectSerialsAllocatedInPO(Sender: TwwDbGrid);
    procedure OnSerialsAllocatedInPOMultiselect(Grid: TwwDBGrid;
      Selecting: Boolean; var Accept: Boolean);
    function ProductEquipcount: Integer;
    procedure beforeshowEquipmentList(Sender: TObject);
    function ProductQtyAdjobj : TProductQtyAdjObj;
    procedure ShowrelatedProductHelp(Openform:boolean);
    procedure MakeTreeFromRelatedParts;
    Procedure MakeRelatedPArtsFromTree;
    procedure QrySerialnoreccount;
    procedure ShowProductQtycheck;
    procedure AddImportProducts(Sender: TwwDBGrid);
    procedure initProductListExpress(Sender: TObject);
    procedure initSerialNumberHistory(Sender: TObject);
    procedure ReadGuiPrefsGen;
    procedure WriteGuiPrefsGen;
    procedure OpenQueryforKeyId(Qry: TERPQuery; Param: String);
    procedure InitQueryParamforKeyId(Qry: TERPQuery; Param: String);
    procedure MakePartname;
    procedure initgrdAlternateProducts;
    function ProductHasAllocationRecords(PQAType:String = ''):Boolean;
    procedure AllocationQtyCheck;
    procedure initExcelPriceform;
    procedure initglobalEvets;
    procedure GlobalEventHandler(const Sender: TObject; const Event: string;const Data: Pointer);
    procedure CloseExcelPriceForm;
    Procedure FocusPriceMatrix;
    function SalesTaxBasedonProductPrice:boolean;
    procedure ShowtglGSTHint;
    procedure CreateUOMS;
    (*procedure CreateUOMScallback(const Sender: TBusObj; var Abort: Boolean);*)
  Protected
    procedure CustomFieldsRefresh;Override;
    procedure KeyIdChanged(const NewKeyId: integer); override;
    procedure InitPopupform(frmPopup:TBaseInputGUI);Override;
    Procedure UpdateProductCostWithExtraBuyPrice;
    Procedure focusUOMPrice1;
    function GetKeyString: string; override;
    procedure SetKeyString(const Value: string); override;
    function SaveOrCancelChanges: boolean;override;
    procedure EnableDisable;Override;

    property SelectedDutiesRecord : TDutiesRecord read fSelectedDuties write fSelectedDuties;
    property SelectedProducts : TIntegerSet read fSelectedProducts write fSelectedProducts;
    Procedure InitERPLookupCombonFields; Override;
    procedure ChangeMemoButtonColours;
  public
    { Public declarations }
    fsPartName: string;
    fsBarcode:STring;
    fsPartType: string;
    fbDiscountError: Boolean;
    fbIsShowingList: Boolean;
    fbDefaultRunOnceFlag: Boolean;
    bOnSave                 : Boolean;
    SaveAccessLevel: integer;
    constructor Create(AOwner: TComponent); override;
    class procedure CloseMe; override;
    Function CustomFieldExtenderListtype:TListType; Override;
    function GetAutoBarcode: string;
    procedure OpenToQuantities;
    procedure UpdateMe; override;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
    Procedure OnTabTabBatch(Sender:TObject);
    Property NewPart  : Boolean Write bNewPart ;
    procedure RoundPrice1;
    procedure RoundPrice2;
    procedure RoundPrice3;
    procedure ShowPricecostCalcHint;
    property OnAfterSaveProduct: TNotifyEvent read fOnAfterSaveProduct write fOnAfterSaveProduct;
    Property ProductMarkupPrice       : Double  read fdProductMarkupPrice        write fdProductMarkupPrice;
    Property IsHireProduct :Boolean read fbIsHireProduct write setIsHireProduct;
    Property CostExMode:Boolean read fbCostExMode write SetCostExMode;
    Property PriceExMode:Boolean read fbPriceExMode write setPriceExMode;
    Property ShowtotalLandedcost :Boolean Read fbShowtotalLandedcost write SetShowtotalLandedcost;
    Procedure OnTabSerial(Sender :TObject);
    Procedure UpdateProductDescriptionFromTreeInfo(var fscleanSelectedInfos  :String; const  fsSelectedInfos   :String; Var fscleanAllInfos  :String; const  fsAllInfos:String);
    Procedure FocusWalmartPage;
    Procedure initPriceifBlank(const Value:Double);
    Procedure initCostifBlank(const Value:Double);
    Procedure DoFocusControl(Const FocusControltype:String);Override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  published
    Property PartHasTree :Boolean read fbPartHasTree write setPartHasTree;
  end;

implementation

uses
  CommonDbLib, FormFactory, DNMLib, AuditObj,
  DNMExceptions, ClientTypeForm, SupplierProductReportForm, SalesReportForm,
  DateUtils,  frmBatchPartsCreator,
  DecimalRounding, CommonLib, tcTypes, tcDataUtils,
  BusObjClient, GlobalEventsObj, tcConst,
  UnitsOfMeasureForm, AppEnvironment, FastFuncs, Productqtylib,
  SerialnumberHistory, frmBinLocation, busobjPQA,
   frmStockAdjustEntry,
  BusObjStock,ProductMovementList, BusObjConst, LogThreadLib,
  EquipmentListForm, StockAdjustEntryList, BusobjStockAdjustEntry,
  frmStockAdjustEntryFlat, DAScript,
  CommonFormLib, BusobjProductProperties, UnitsOfMeasureList,
  frmStockTransferEntry, AppContextObj, GuiPrefsObj, DataTreeObj,
  UnitsOfMeasuregroup, InventoryLib, BusObjProductGroup , BusobjUOM,
  TransAuditTrail, BusObjPrintDoc, BusObjDeletedItem,
  ProductPurchaseMovementList, ParserLib, ImagesLib, frmMessageWithList,
  ProductBatchnoList, MySQLConst, InventoryTypes, frmProductSOInfo,
  frmProductInvInfo, frmPartsCostPriceOptions, frmUOMforAutoSplitQtyinSales, GIFimg, ProductPictureList, BusObjPicture,
  PQALib, ForeignBuyPriceAuditTrial, ShellAPI, {$WARNINGS OFF}FileCtrl{$WARNINGS ON},
  docPathLib, BusObjProductClass, LogLib, DbSharedObjectsObj, frmPartsPriceCalc,
  frmEquip, ProductSerialNumbersForHire, SystemLib,
  BusobjProctree, BOMLib, DocReaderObj, ProductQtycheck, Barcodeconst, Clipbrd,
  FrmProductQtyAdjOptions , frmProductReorderPoints, ProductListExpressForm,
  UserCustomisedNames, BusObjProcPrefs, ProductnAllocationQtyCheckList,
  TimedHint, AlternateProductSearch, Walmart_Item_Lib, CK_DLL_Const,
  frmPartsExcelPrice, ProductBatches;

const
  COL_DATE = 0;
  COL_QTY = 1;
  COL_VALUE = 2;
  COL_AVERAGE = 3;
  COL_PERCENT_MOVE = 4;
  COL_PERCENT_TOT = 5;
  GRID_COL_INACTIVE = $00DEDEDE;
  AutoPriceFlag = 1;



var
  isOpenToQuantities: Boolean;
  bFirstSales_Movement: Boolean;
  bfirstMan_Movement:boolean;
  bFirstPurch_Movement: Boolean;
  qryGrouplinesModified: Boolean;
  qrySales: TERPQuery;
  qryMan: TERPQuery;
  qryPurch: TERPQuery;
  SaveButtonClicked: Integer;

{$R *.DFM}

procedure TfrmParts.WMSysCommand(var Message:TWMSysCommand);
begin
  if (Message.CmdType and $FFF0 = SC_CLOSE) then begin
    if fsModal in Self.FormState  then
      ModalResult:= mrCancel;
  end;
  inherited;
End;

Function TfrmParts.ProductInStockQty :double;
begin
  result := tcdatautils.ProductInStockQty(qryProductPARTSID.asInteger ,Self.MyConnection);
(*var
  strSQL:String;
begin
  REsult := 0;
  strSQL:= ProductQtyLib.SQL4ProductAvailableQty(0 , '', tsummary, qryProductPARTSID.asInteger);
  With GetNewDatasetinTransaction(strSQL) do try
        if recordcount > 0 then
        REsult := fieldByname('Qty').asFloat ;
  finally
        if Active then close;
        Free;
  end;*)
end;

Procedure TfrmParts.ShowrelatedProductHelp(Openform:boolean);
var
  s:String;
begin

  if GuiPrefs.Node.Exists('Options.RelatedProductHelpIndes') and (GuiPrefs.Node['Options.RelatedProductHelpIndes'].asInteger =2) then
      s:= 'Pallets and Containers'   else     s:= 'Related Packaging';
  TDocReaderObj.ShowERPHelp(nil, Self, openform, s);
end;
Procedure TfrmParts.ReadGuiPrefsGen;
begin
        if GuiPrefs.Node.Exists('Options.ProductQtycheckHeight') then
        pnlProductQtycheck.Height :=  GuiPrefs.Node['Options.ProductQtycheckHeight'].asInteger;
        if pnlProductQtycheck.Height > TabSerial.height -100 then pnlProductQtycheck.Height :=  TabSerial.height -100;

             if chkshowTransactionhistory.visible = false then chkshowTransactionhistory.Checked :=  False
        else if GuiPrefs.Node.Exists('Options.showTransactionhistory') then chkshowTransactionhistory.Checked :=  GuiPrefs.Node['Options.showTransactionhistory'].asBoolean
        else chkshowTransactionhistory.Checked :=  False;

        if GuiPrefs.Node.Exists('Options.ShowtotalLandedcost')  then ShowtotalLandedcost:= GuiPrefs.Node['Options.ShowtotalLandedcost '].asBoolean  else ShowtotalLandedcost := True;
        if GuiPrefs.Node.Exists('Options.CostExMode')           then CostExMode         := GuiPrefs.Node['Options.CostExMode'].asBoolean            else CostExMode := True;
        if GuiPrefs.Node.Exists('Options.PriceExMode')          then PriceExMode        := GuiPrefs.Node['Options.PriceExMode'].asBoolean           else PriceExMode := True;
        if GuiPrefs.Node.Exists('Options.ImageStretch')         then StretchImage(imagePart , GuiPrefs.Node['Options.ImageStretch'].AsBoolean);

end;
procedure TfrmParts.OpenQueryforKeyId(Qry :TERPQuery; Param:String);
begin
  InitQueryParamforKeyId(Qry , param);
  opendb(qry);
end;
procedure TfrmParts.FormShow(Sender: TObject);
var
  qry: TERPQuery;
begin
  DisableForm;

  lbldefaultbin.caption := 'Double click on the grid to restore a Deleted record.' +chr(13) +
                    'Double click on the ''Default Bin''  to unassign the ''Default Bin'' for the selected class.';
  try
    bFinishedOnShow := False;
    fbCanClose := True;
    UOMQueries;

    try
      inherited;
      BeginTransaction;
      GuiPrefs.Active := True;
      qry := DbSharedObj.GetQuery(MyConnection);
      try
        qry.SQL.Add('select * from tblImageType where Active = "T"');
        qry.Open;
        slPictureCodes.Clear;
        while not qry.Eof do begin
          lstImageTypes.Items.AddObject(qry.FieldByName('Description').AsString, TObject(qry.FieldByName('ID').AsInteger));
          slPictureCodes.AddObject(qry.FieldByName('Code').AsString, TObject(qry.FieldByName('ID').AsInteger));
          qry.Next;
        end;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;

      if bCopyPart then
      begin
        KeyID := DuplicatePart(iCopyPartID, MyConnection);
        edtPartName.Text := '';
        edtPart.ReadOnly := False;
      end;
      ShowUOMfields;
      IsSerialformshown := False;
      dblcProductType.Enabled := (KeyID = 0);

      pageControl.ActivePage := TTabSheet(Main);
      pgCustomFields.ActivePage := TTabSheet(tabCustomFields);
      MiscPageControl.ActivePage := TTabSheet(tabGeneral);


      SaveButtonClicked := 0; // This is a flag which is used to make sure that "Do you wanna Save changes" does not appear if the Save button was clicked.
      if qryProduct.Active then    begin
        PostDB(QryProduct);
        notify;
      end;
      label30.Caption := AppEnv.CompanyPrefs.ProductAttrib1Name;
      label31.Caption := AppEnv.CompanyPrefs.ProductAttrib2Name;
      label33.Caption := ('Price / ' + AppEnv.CompanyPrefs.ProductAttrib1Name);
      label27.Caption := AppEnv.CompanyPrefs.ProductAttrib1Name;
      label28.Caption := AppEnv.CompanyPrefs.ProductAttrib2Name;
      label29.Caption := ('Price / ' + AppEnv.CompanyPrefs.ProductAttrib1Name);
      lblProductAttrib1.caption :=AppEnv.CompanyPrefs.ProductAttrib3Name;

      pnl12.Visible := AppEnv.CompanyPrefs.ShowMeasurementAttributes ;
      pnl13.Visible := AppEnv.CompanyPrefs.ShowMeasurementAttributes ;
      pnl14.Visible := AppEnv.CompanyPrefs.ShowProductExtraAttributes;

      bAccessEnabled := (AccessLevel < 5);
      bIsChangingPrices := false;
      bFirstSales_Movement := true;
      bfirstMan_Movement:= True;
      bFirstPurch_Movement := true;
      PrepareQueries;


      RefreshBarcodeGrid;

      dblcProductType.Enabled := (KeyID=0);
      btnNewUOM.Enabled := not(KeyID=0);
      if KeyID = 0 then
      begin
        edtPartName.TExt := '';
        qryProduct.Insert;
        bNewPart := True;
        fState := qryProduct.State;
        self.edtPart.ReadOnly := False; // Allow part name to be entered in new record.

        if not Empty(fsPartName) then begin
          qryProductPARTNAME.AsString := fsPartName;
        end;
        if not Empty(fsBarcode) then begin
          qryProductBARCODE.asString := fsBarcode;
        end;

        txtMarkup2.Text := FloatToStrF(AppEnv.CompanyPrefs.WholesalePercentag * 100, ffFixed, 7, 2) + ' %';

        if not Empty(fsPartType) then begin
          dblcProductType.Text := fsPartType;
        end;

        cboPartLevel1.LookupValue := '';
        SetNewDefaults;

        PostDB(QryProduct); EditDB(QryProduct);

        if AppEnv.CompanyPrefs.AutoAddBarcodes then begin
          ProductBarcodeList.AddBarcode(GetAutoBarcode);
        end;
        ActiveControl := edtPart;
      end
      else
      begin
        edtPartName.Text  := qryProductProductPrintName.asString;
        if edtPartName.Text = '' then edtPartName.Text := qryProductPARTNAME.asString;
        if bCopyPart then begin
          EditDB(QryProduct);
          qryProductPARTNAME.asString := '';
        end;


        dOldCost := qryProductCOST1.asFloat;
        EditNoAbort(qryProduct);
        cboPartLevel1.LookupValue := qryProductLevels.FieldbyName('PartLevel1').AsString;
        cboPartLevel2.LookupValue := qryProductLevels.FieldbyName('PartLevel2').AsString;
        cboPartLevel3.LookupValue := qryProductLevels.FieldbyName('PartLevel3').AsString;

        if not bCopyPart then
          edtPart.ReadOnly := True; // Lock Part Name so it cannot be edited

      end;

      OpenQueryforKeyId(qryUnitOfMeasure      , 'KeyID');
      OpenQueryforKeyId(QryPartCalcformulaUOM , 'xPartID');
      OpenQueryforKeyId(qryimportProduct      , 'ProductId');
      OpenQueryforKeyId(QryUOM                , 'KeyID');
      OpenQueryforKeyId(qryWalmartUOM         , 'xPartID');

      txtmarkup.Enabled               := (AccessLevel <= 2);
      chkActive.Enabled               := (AccessLevel <> 2) and (AccessLevel <> 3);

      if rgMarkUpType.ItemIndex = 0 then
        txtmarkup.Text                  := FloatToStrF(DivZer((qryProductPRICE1.AsFloat - qryProductCOST1.AsFloat), qryProductCOST1.AsFloat) * 100, ffFixed, 7, 2) + ' %';

      if qryProductWHOLESALEPRICE.AsFloat > 0 then
        txtMarkup2.Text               := FloatToStrF(DivZer((qryProductWHOLESALEPRICE.AsFloat - qryProductCOST1.AsFloat), qryProductCOST1.AsFloat) * 100, ffFixed, 7, 2) + ' %';


      if isOpenToQuantities then    begin
        pageControl.ActivePage := TTabSheet(Quantities);
        pageControlChange(nil);
      end else begin
        pageControl.ActivePage := TTabSheet(Main);
        if AccessLevel <= 2 then      begin
          if dblcProductType.CanFocus then
            SetControlFocus(dblcProductType);
        end else begin
          SetControlFocus(btnClose);
        end;
      end;

      InitProductmovementTab;
      qryGroupLinesModified := False;

        Label39.Enabled := qryProductShowProductPopUp.asString = 'T';
        PopupMemo.Enabled := qryProductShowProductPopUp.asString = 'T';

        Label24.Enabled := qryProductShowProductPopUp.asString = 'T';
        PopupPOMemo.Enabled := qryProductShowProductPopUp.asString = 'T';

      if qryProductRequired.AsBoolean then begin
        chkActive.readonly := True;
        Showcontrolhint( chkActive , 'This is a "Required" Product. It is not Possible to Inactivate it.'+NL+
                                      '"Required" Flag can be Changed in Export / Import Product List');
      end;
      ProductTreeOrder;
      ReadGuiPrefsGen;
      bFinishedOnShow := True;

      cboPartLevel1.OnEnter := cboPartLevel1Enter;


      CustomFieldsRefresh;

      rgMarkupType.Value := QryProductGrossMarginMode.asString;
      if QryProductGrossMarginMode.asString = 'T' then
        rgMarkupType.itemindex := 0 else rgMarkupType.itemindex:= 1;


      chkSNTracking.Enabled := qryProductPARTTYPE.asstring = 'INV';
      lblSNTracking.Enabled := chkSNTracking.Enabled;


      chkBatches.Enabled:= true;
      chkMultipleBins.Enabled:= true;

      if self.qryProductActive.AsBoolean then
        qryProductLevel1.ParamByName('Active').AsString:= 'T'
      else
        qryProductLevel1.ParamByName('Active').AsString:= 'F';
      if qryProductLevel1.Active then
        qryProductLevel1.Refresh;
      qryProductLevel2.ParamByName('Active').AsString:= qryProductLevel1.ParamByName('Active').AsString;
      if qryProductLevel2.Active then
        qryProductLevel2.Refresh;
      qryProductLevel3.ParamByName('Active').AsString:= qryProductLevel1.ParamByName('Active').AsString;
      if qryProductLevel3.Active then
        qryProductLevel3.Refresh;

      ChangeMemoButtonColours;
      (*if qryProductPARTSID.AsInteger > 0 then begin

        qry := DbSharedObj.GetQuery(MyConnection);

        try
          qry.Connection:= MyConnection;
          qry.SQL.Add('Select count(PQAD.PQAID) PQACount from tblPQa PQA inner join tblPQADetails PQAD on PQA.PQAID = PQAD.PQAID where PQA.productId=  ' +
                        IntToStr(qryProductPARTSID.AsInteger));
          qry.Open;
          if qry.FieldByName('PQACount').AsInteger > 0 then begin
            chkBatches.Enabled:= false;
            chkMultipleBins.Enabled:= false;
          end;
        finally
          DbSharedObj.ReleaseObj(qry);
        end;
      end;*)
      initExcelPriceForm;
      ShowcontrolHint(optSalesTaxBasedon, 'Product Price: Any Discounts Applied will be ignored for tax Purposes' +NL+
                                          'Sales Price : Tax will be calculated on Discoutned Price');
    except
      on EAbort do
        HandleEAbortException;
      on e: ENoAccess do
      begin
        HandleNoAccessException(e);
        exit;
      end;
      on e: Exception do
        raise;
    end;
  finally
    DataState.Activate;
    formshown:= True;
    EnableForm;
    Setcontrolfocus(edtProductPrintName);
  end;
end;

Procedure TfrmParts.initExcelPriceform;
begin
  //if fbPartsExcelPriceCreated then exit;
  if aPartsExcelPrice <> nil then exit;
  aPartsExcelPrice := TfmPartsExcelPrice.Makeinstance(self,pnlPartsExcelPrice );
  //fbPartsExcelPriceCreated := True;
end;
procedure TfrmParts.FormulaDetails;
var
   Value :double;
  fdPartCalcFormulaMult:Double;
  ErrMsg:String;
  function Explainformula :String;
  var
    s:String;
  begin
    REsult := '';
    if QryProductPartCalcFormula.asString = '' then exit;
    if Value > 1 then result := floatToStr(Value) +' = ' +floatToStr( fdPartCalcFormulaMult) +'  ' +  QryProductPartCalcFormula.asString
    else begin
        s:= '';
        if Appenv.companyprefs.PartCalcfield1 and (Trim(edtCalcField1.Text) <> '') then s:= s+ ' ' + edtCalcField1.Text + ' ' + Appenv.companyprefs.PartCalcField1Name;
        if Appenv.companyprefs.PartCalcfield2 and (Trim(edtCalcField2.Text) <> '') then s:= s+ ', ' + edtCalcField2.Text + ' ' + Appenv.companyprefs.PartCalcField2Name;
        if Appenv.companyprefs.PartCalcfield3 and (Trim(edtCalcField3.Text) <> '') then s:= s+ ', ' + edtCalcField3.Text + ' ' + Appenv.companyprefs.PartCalcField3Name;
        if Appenv.companyprefs.PartCalcfield4 and (Trim(edtCalcField4.Text) <> '') then s:= s+ ', ' + edtCalcField4.Text + ' ' + Appenv.companyprefs.PartCalcField4Name;
        if Appenv.companyprefs.PartCalcfield5 and (Trim(edtCalcField5.Text) <> '') then s:= s+ ', ' + edtCalcField5.Text + ' ' + Appenv.companyprefs.PartCalcField5Name;
        Result := 'ie.  ' + FloatToStr(round(1/value,GeneralRoundPlaces)) + ' of ' + s +' = ' +' 1 ' +  QryProductPartCalcFormulauom.asString;
    end;
  end;
begin
  Value := ParserValue(Self,PartcalcformulaExampleVar ,  QryProductPartCalcformula.AsString , ErrMsg);
  if Value = 0 then begin
    lblFormulaDetails.caption :=''
  end else begin
    fdPartCalcFormulaMult:= QryProductPartCalcFormulaMult.AsFloat;
    if fdPartCalcFormulaMult = 0 then fdPartCalcFormulaMult := 1;
    Value := Value * fdPartCalcFormulaMult;
    if QryProductPartCalcFormula.asString = '' then
         lblFormulaDetails.Caption :=''
    else lblFormulaDetails.Caption := ' = ' +
                              ReplaceStr(ReplaceStr(ReplaceStr(ReplaceStr(ReplaceStr(QryProductPartCalcformula.AsString , 'Field1' , edtCalcField1.Text)  , 'Field2' , edtCalcField2.Text)  , 'Field3' , edtCalcField3.Text)  , 'Field4' , edtCalcField4.Text)  , 'Field5' , edtCalcField5.Text) + ' * ' + floattoStr(fdPartCalcFormulaMult) +
                              NL +  ' =  ' + FloatToStrF(round(Value,5), ffgeneral, 15, 5) +'  ' + QryProductPartCalcformulaUOM.AsString;

    lblFormulaExplain.caption := explainformula;
  end;
  lblFormulaDetails.refresh;

  DoCalcQtyformulaREadonly;
end;

function TfrmParts.SalesReportListForm: TBaseListingGUI;
begin
  CreateHistorylistform('TSalesReportGUI' ,Self, ffrmListSalesReport,'ProductID', IntToStr(KeyID));
  REsult := ffrmListSalesReport;
end;
function TfrmParts.ProductQtycheckForm: TBaseListingGUI;
begin
  CreateHistorylistform('TProductQtycheckGUI' ,Self, fFrmProductQtycheck,'ProductID', IntToStr(KeyID));
  fFrmProductQtycheck.chkIgnoreDates.checked := TRue;
  REsult := fFrmProductQtycheck;
end;
function TfrmParts.SavePriceMatrix: boolean;
begin
  REsult := True;
  if (pageControl.ActivePage = TTabSheet(Extra_Sell_Price))   then
    if PageControlsellprice.ActivePage = tabPriceMatrix then
      if assigned(PartsPriceMatrixForm) then
        if not(PartsPriceMatrixForm.Save) then
          Result := False;
end;

function TfrmParts.SupplierProductReportListForm: TBaseListingGUI;
begin
  CreateHistorylistform('TSupplierProductReportGUI' ,Self, ffrmListSupplierProductReport,'ProductID', IntToStr(KeyID));
  REsult :=ffrmListSupplierProductReport;
end;

Procedure TfrmParts.LoadQryQty(PartsID:Integer);
begin
  if ProductclassPartsID<> partsID then begin
      with qryProductClass do begin
          if Active then close;
          SQL.clear;
          SQL.add(' Select * ');
          SQL.add(' FROM tblproductclasses ');
          SQL.add(' Where ProductID = ' + IntToStr(PartsID));
          ProductclassPartsID := PartsId;
      end;
  end;

  With QryProductQtys do begin
    if Active then close;
    SQL.clear;
    SQL.add('Select distinct PQA.ProductID, PQA.DepartmentID, ');
    //SQL.add('Round(' + ProductQtyLib.SQL4Qty(tAvailable) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as AvailableQty, ');
          if AppEnv.CompanyPrefs.CountSOBOInAvailable  then begin
                   SQL.Add( 'Round(' +ProductQtylib.SQL4Qty(tAvailable ) +' - ' + ProductQtylib.SQL4Qty(tsobo ) +', ' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "AvailableQty",');
          end else SQL.Add( 'Round(' +ProductQtylib.SQL4Qty(tAvailable ) +',' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "AvailableQty",');

    SQL.add('Round(' +ProductQtyLib.SQL4Qty(tInvBO)+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as AllocatedBOQty, ');
    SQL.add('Round(' +ProductQtyLib.SQL4Qty(tSO)+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as SOQty, ');
    SQL.add('Round(' +ProductQtyLib.SQL4Qty(tSOBO)+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as SOBOQty, ');
    SQL.add('Round(' +ProductQtyLib.SQL4Qty(tInStock)+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as InstockQty, ');
    // Should not include FuturePO in On Order
    SQL.add('Round(Round(Sum(if(PQA.Active ="F" , 0,');
    SQL.add('  if(PQA.TransType="TPurchaseOrderLine" and ifnull(PQA.IsBO , "F") ="T",');
    SQL.add('ifnull((select QtySold from tblPurchaseLines PL inner join tblPurchaseOrders PO on PO.PurchaseOrderId=PL.PurchaseOrderId where PL.PurchaseLineId=PQA.TransLineId and PO.FuturePo="F"), 0),');
    SQL.add('0))),5), 5) as POBOQty');
    // end of FuturePO
    SQL.add('from tblPQA as PQA where PQA.ProductID = ' + IntToStr(PartsID));
    SQL.add('group by PQA.ProductID, PQA.DepartmentID');
    open;
  end;

End;
procedure TfrmParts.InitQueryParamforKeyId(Qry: TERPQuery; Param: String);
begin
  Closedb(Qry);
  Qry.parambyname(Param).asInteger := KeyId;
end;

procedure TfrmParts.PrepareQueries;
var
  QueryNamesNotToOpen: array of string;
begin
  if (LastKeyId <> KeyID) or (not qryProduct.Active) then begin
    LastKeyId:= KeyID;
    CloseQueries;
    InitQueryParamforKeyId(qryUOMPurchase                       ,'PartsID'  );
    InitQueryParamforKeyId(QryUOMSales                          ,'PartsID'  );
    InitQueryParamforKeyId(qryProduct                           ,'KeyID'    );
    InitQueryParamforKeyId(qryProductLevels                     ,'KeyID'    );
    InitQueryParamforKeyId(qryPartNotes                         ,'KeyID'    );
    InitQueryParamforKeyId(qrySpecifications                    ,'xPartsID' );
    InitQueryParamforKeyId(qryRelatedParts                      ,'xParentID');
    InitQueryParamforKeyId(qrySellPrices                        ,'xPartsID' );
    InitQueryParamforKeyId(qryExtraBuyPrice                     ,'xPartsID' );
    InitQueryParamforKeyId(qryForeignPrice                      ,'xPartsID' );
    InitQueryParamforKeyId(qryForeignPriceSell                  ,'xPartsID' );
    InitQueryParamforKeyId(qryUnitsOfMeasureQtys                ,'xPartsID' );
    InitQueryParamforKeyId(qryUnitOfMeasure                     ,'KeyID'    );
    InitQueryParamforKeyId(qryWalmartUOM                        ,'xPartID'  );
    InitQueryParamforKeyId(QryPartCalcformulaUOM                ,'xPartID'  );
    InitQueryParamforKeyId(QryUOM                               ,'KeyID'    );
    InitQueryParamforKeyId(QryPartsProcess                      ,'ID'       );
    InitQueryParamforKeyId(qryProductLookupToCopyRelatedFrom    ,'PartsID'  );
    InitQueryParamforKeyId(QryAlternateProducts                 ,'KeyId'    );
    InitQueryParamforKeyId(QryProductUOM                        ,'xPartID'  );
    InitQueryParamforKeyId(qrywalmartitems                      ,'xPartsID' );

    ProductPicture.LoadSelect('PartID = ' + IntToStr(KeyID));
    LoadQryQty(KeyID);

    // open queries
    Setlength(QueryNamesNotToOpen, 30);
    QueryNamesNotToOpen[0] := 'qrySales'; //This Is To Aid the Speed Openning Of Parts Form
    QueryNamesNotToOpen[1] := 'qryPurch'; //########### CHECK pageControlChange ##########
    QueryNamesNotToOpen[2] := 'cboProductQry';
    QueryNamesNotToOpen[3] := 'cboManfProductQry';
    QueryNamesNotToOpen[4] := 'qryGrouplines';
    QueryNamesNotToOpen[5] := 'qryPartsBarcodes';
    QueryNamesNotToOpen[6] := 'qryManuf';
    QueryNamesNotToOpen[7] := 'cboClientLookup';
    QueryNamesNotToOpen[8] := 'qryProductClass';
    QueryNamesNotToOpen[9] := 'cbo_Class_Qry';
    QueryNamesNotToOpen[10] := 'qryPartName';
    QueryNamesNotToOpen[11] := 'qryUnitsOfTime';
    QueryNamesNotToOpen[12] := 'qryUnitsOfMeasureQtys';
    QueryNamesNotToOpen[13] := 'qryPriceMatrix';
    QueryNamesNotToOpen[14] := 'qryUnitOfMeasure';
    QueryNamesNotToOpen[15] := 'qryRelatedParts';
    QueryNamesNotToOpen[16] := 'qryProductLevel1';
    QueryNamesNotToOpen[17] := 'qryProductLevel2';
    QueryNamesNotToOpen[18] := 'qryProductLevels3';
    QueryNamesNotToOpen[19] := 'qryAdvMatrix';
    QueryNamesNotToOpen[20] := 'qryAdvMatrixQtys';
    QueryNamesNotToOpen[21] := 'qrySpecifications';
    QueryNamesNotToOpen[22] := 'qryUnitsOfMeasure';
    QueryNamesNotToOpen[23] := 'QryInTransation';
    QueryNamesNotToOpen[24] := 'QrySerialno';
    QueryNamesNotToOpen[25] := 'QryPartCalcformulaUOM';
    QueryNamesNotToOpen[26] := 'qryMan';
    QueryNamesNotToOpen[27] := 'QryPartHirePricing';
    QueryNamesNotToOpen[28] := 'QryPartHirePricingLines';
    QueryNamesNotToOpen[29] := 'cboPrintProductQry';
(*    QueryNamesNotToOpen[30] := 'qrywalmartitems';
    QueryNamesNotToOpen[31] := 'qryWalmartUOM';*)

    // don't use transactional connection for lookup
    qryProcessStep.Connection := CommonDbLib.GetSharedMyDacConnection;
    OpenQueries(QueryNamesNotToOpen);

    {ProductBarcodeList doesn't need to be loaded as the qry is opned already
    it should not be loaded as the busobj will change the SQL and kill the parameter of the query
    Reading the lines property will open the query}
    ProductBarcodeList.Dataset;{to call the Dobusinessobjevent to assign the qry to busobj}
    ProductBarcodeList.Lines;


    qryPartBarCodes.Filtered:= false;
    qryPartBarCodes.Filter:= 'Active = "T"';
    qryPartBarCodes.Filtered:= true;

  end;
end;
procedure TfrmParts.WriteGuiPrefsGen;
begin
  GuiPrefs.Node['Options.ProductQtycheckHeight'].asInteger := pnlProductQtycheck.Height;
  GuiPrefs.Node['Options.showTransactionhistory'].asBoolean := chkshowTransactionhistory.Checked and chkshowTransactionhistory.visible;
end;
procedure TfrmParts.FocusWalmartPage;
begin
  if fbAftershowAutoFocusingToPage then exit;
  fbAftershowAutoFocusingToPage := true;
  try
    Pagecontrol.ActivePage := Miscellaneous;
    pageControlChange(pageControl);
    MiscPageControl.ActivePage := tabwalmart;
    Setcontrolfocus(edtSku);
  finally
    fbAftershowAutoFocusingToPage := False;
  end;

end;

procedure TfrmParts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiPrefsGen;
  WriteProductMovementGuiPres;
  SetControlFocus(btnClose);
  Self.Enabled := False;

  inherited;
  FreeandNil(ProductAllocationForm);

  if not ErrorOccurred then begin
    CloseQueries;
  end;

  Action := caFree;
end;

procedure TfrmParts.SetNewDefaults;
begin
    inQtyPriceValidation := True;
    try
      if not bInitialisedNewPart then  begin
        if not Empty(GetAccountName(AppEnv.CompanyPrefs.DefPartsCOGSAccount)) then begin
          qryProductCOGSACCNT.AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsCOGSAccount);
        end else begin
          qryProductCOGSACCNT.AsString := 'Cost of Goods Sold';
        end;

        if not Empty(GetAccountName(AppEnv.CompanyPrefs.DefPartsIncomeAccount)) then begin
          qryProductINCOMEACCNT.AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsIncomeAccount);
        end else begin
          qryProductINCOMEACCNT.AsString := 'Sales';
        end;

        if not Empty(GetAccountName(AppEnv.CompanyPrefs.DefPartsAssetAccount)) then begin
          qryProductASSETACCNT.AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsAssetAccount);
        end else begin
          qryProductASSETACCNT.AsString := 'Inventory Asset';
        end;

        qryProductDateCreated.AsDateTime := Now;

        qryProductActive.AsBoolean := true;
        qryProductAutoReorder.AsBoolean := true;
        qryProductPURCHTAXCODE.AsString := appenv.CompanyPrefs.DefaultPurchaseTaxCode;
        qryProductTAXCODE.AsString := appenv.CompanyPrefs.DefaultSalesTaxCode;
        qryProductBuyQTY1.AsFloat := 1;
        qryProductBuyQTY2.AsFloat := 1;
        qryProductBuyQTY3.AsFloat := 1;
        qryProductCOST1.AsFloat := 0.00;
        qryProductCOST2.AsFloat := 0.00;
        qryProductCOST3.AsFloat := 0.00;
        qryProductCOSTINC1.AsFloat := 0.00;
        qryProductCOSTINC2.AsFloat := 0.00;
        qryProductCOSTINC3.AsFloat := 0.00;
        qryProductSellQTY3.AsFloat := 1;
        qryProductSellQTY2.AsFloat := 1;
        qryProductSellQTY1.AsFloat := 1;
        qryProductPRICE1.AsFloat := 0.00;
        qryProductPRICE2.AsFloat := 0.00;
        qryProductPRICE3.AsFloat := 0.00;
        qryProductAvgCost.AsFloat:= 0;
        txtRetailPriceInc.Clear;
        txtCostPriceInc.Clear;
        qryProductUOMtobeUsedinManufacture.AsString := AppEnv.CompanyPrefs.UOMToBeUsedInManufactureDefault;
      end;
    finally
        inQtyPriceValidation := False;
    end;
end ;
procedure TfrmParts.setPartHasTree(const Value: Boolean);
begin
  fbPartHasTree := Value;
  lblIsBOMTemplate.enabled := Value;
  chkIsBOMTemplate.enabled := Value;
end;


Procedure TfrmParts.ShowtglGSTHint;
var
  s:String;
begin
  if PriceExMode then s:= 'Enter Prices Excluding Tax.'
  else s:=  'Enter Prices Including Tax.' ;
  if SalesTaxBasedonProductPrice then s:= s+ NL+'Price Discount Based on Qty is not Applicable when Sales Tax based on Product Price';
  ShowControlhint(pnlSales , s);

  if PriceExMode then s:= s+ NL +NL+'Click to Enter Prices Including Tax'
  else s:=  s+ NL +'Click to Enter Prices Excluding Tax';
  ShowControlhint(tglGST,s);

end;
procedure TfrmParts.setPriceExMode(const Value: Boolean);
begin
  fbPriceExMode := Value;
  if Value then begin
    tglGST.Caption:= doTRanslate('Price (Ex)');
    txtPrice2.DataField := 'PRICE2';
    txtPrice3.DataField := 'PRICE3';
  end  else begin
    tglGST.Caption:= DoTRanslate('Price (Inc)');
    txtPrice2.DataField := 'PRICEINC2';
    txtPrice3.DataField := 'PRICEINC3';
  end;
  ShowtglGSTHint;
  txtRetailPrice.Visible := Value;
  txtRetailPriceInc.Visible := not(Value);
  GuiPrefs.Node['Options.PriceExMode'].asBoolean:= Value;
end;

Procedure  TfrmParts.OpenQryQty;
begin
    if qryProductClass.Active = False then begin
        LoadQryQty(qryProduct.FieldByName('PARTSID').AsInteger);
        qryProductClass.Open;
    end;
end;

procedure TfrmParts.OpenSupplierHistory(Sender: TObject);
var
  form: TSupplierProductReportGUI;
begin
  Form := TSupplierProductReportGUI.Create(Application);
  Form.FilterString := 'ProductID = ' + IntToStr(KeyID);
  Form.FormStyle := fsMDIChild;
  form.BringToFront;
end;
Procedure TfrmParts.CreateUOMS;
var
  ExcludeList :TStringlist;
  qrySource: TERPQuery;
  qryDestination: TERPQuery;
begin
  if iCopyPartID =0 then exit;
  qrySource := DbSharedObj.GetQuery(MyConnection);
  qryDestination := DbSharedObj.GetQuery(MyConnection);
  try
      ExcludeList := TStringList.create;
      try
                ExcludeList.clear;
                ExcludeList.add('GlobalRef');
                ExcludeList.add('PartID');
                ExcludeList.add('BaseUnitID');
                ExcludeList.add('UnitID');
                try CopyProductTableRecords(iCopyPartID, qryProductPartsId.asInteger, 'SELECT * FROM tblunitsofmeasure WHERE PartID = ', qrySource, qryDestination, ExcludeList, 'order by BaseUnitName'); Except end;
      finally
        freeandnil(ExcludeList);
      end;
  finally
    DbSharedObj.ReleaseObj(qrySource);
    DbSharedObj.ReleaseObj(qryDestination);
  end;
(*var
  UOM : TUnitOfMeasure;
begin
  if iCopyPartID =0 then exit;
  UOM := TUnitOfMeasure.create(Self);
  try
    uom.connection := TMyDacDataConnection.create(uom);
    uom.connection.connection := qryProduct.connection;
    uom.LoadSelect('PartID = '+ inttostr(iCopyPartID));
    uom.iteraterecords(CreateUOMScallback);
  finally
    Freeandnil(UOM);
  end;*)
end;
(*Procedure  TfrmParts.CreateUOMScallback(const Sender: TBusObj;var Abort: Boolean);
begin
  TUnitOfMeasure.CreateNewUOM(self, qryProductPartsID.asInteger, TUnitOfMeasure(Sender).UOMName , TUnitOfMeasure(Sender).connection);
end;*)
Procedure  TfrmParts.CreateQtyLines;
  Procedure LinkProduct(fProductID, fClassID:Integer);
  begin
     TProductClass.LinkProduct(fProductID, fClassId, MyConnection);
  end;
begin
  if qryProductPARTNAME.asString = '' then exit;

  if not IsFlag('Cloning') then begin
    LinkProduct(qryProduct.FieldByName('PARTSID').AsInteger , Appenv.DefaultClass.ClassId);
  end else begin
    With CommonDbLib.TempMyQuery do try
      connection := MyConnection;
      SQL.add('Select ClassId '+
              ' from tblProductclasses '+
              ' where  ifnull(ClassID,0) <> 0 ' +
              ' and  ProductID = ' + IntToStr(iCopyPartID));
      open;
      if recordcount = 0 then Exit;
      first;
      while Eof = False do begin
        LinkProduct(qryProduct.FieldByName('PARTSID').AsInteger , FieldByname('ClassId').asInteger);
        Next;
      end;
    finally
        if active then Close;
        Free;
    end;
  end;
  if qryProductClass.active then qryProductClass.Close;
  OpenQryQty;
end;

procedure TfrmParts.btnCloseClick(Sender: TObject);
var
  ExitResult:Word;
  Msg:String;
begin
  DisableForm;
  try
    inherited;
    Notify(True);


  if not fbCanClose then begin
      Exit;
  end  else begin
    if not ErrorOccurred then begin
        if DataHasChanged then begin
          if datastate.dirty =false then begin
          end else begin
            Msg:= '';
            if DefaultBinsAssignedtoClasses <> '' then
              msg := 'Default Bin(s) are Automatically Assigned to the Following ' + Appenv.DefaultClass.Classheading+'.' +chr(13) +
                      DefaultBinsAssignedtoClasses +chr(13)+chr(13);
            Msg := msg +'Do You Wish To Keep These Changes You Have Made?';
            ExitResult := CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbYes, mbNo, mbCancel], 0);
            case ExitResult of
              mrYes: begin
                    btnCompleted.Click;
                    Exit;
              end;
              mrNo: begin
                      RollbackTransaction;
                      SaveButtonClicked:= 1;
                      datastate.dirty:= False;
                      Self.close;
                      Exit;
              end;
              mrCancel: begin
                      Exit;
              end;
            end;
          end;
        end;
    end;
  end;

  Self.Close;
  if FormStillOpen('TfrmBatchParts') then begin
    if TfrmBatchParts(FindExistingComponent('TfrmBatchParts')).Visible then begin
        TfrmBatchParts(FindExistingComponent('TfrmBatchParts')).cboPartName.Text :='';
    end;
  end;

  finally
    EnableForm;
  end;
end;


Function  TfrmParts.ProductNameUnique :boolean;
var
    Qry :TERPQuery;
begin
    Qry := TERPQuery.Create(nil);
    With Qry do Try
        Connection := MyConnection;
        Sql.add('Select PartsID from tblParts where PartName = ' + quotedStr(qryProductPartName.asSTring) );
        if qryProductPARTSID.asString <> '' then
            SQL.add(' and PartsId <> ' + qryProductPARTSID.asString);
        Open;
        Result := Recordcount =0;
    Finally
        if active then Close;
        Free;
    end;
end;
function TfrmParts.ProductQtyAdjobj: TProductQtyAdjObj;
begin
  if fProductQtyAdjobj = nil then fProductQtyAdjobj := TProductQtyAdjObj.Create(Self);
  Result := fProductQtyAdjobj;
end;

function TfrmParts.ProductGroupJoin: string;
begin
  if not empty(cboPartLevel1.Text) then
  begin
    if not empty(cboPartLevel2.Text) then
    begin
      if not empty(cboPartLevel3.Text) then
      begin
        result := cboPartLevel1.Text + '^' + cboPartLevel2.Text + '^' + cboPartLevel3.Text;
      end
      else
      begin
        result := cboPartLevel1.Text + '^' + cboPartLevel2.Text;
      end;
    end
    else
    begin
      result := cboPartLevel1.Text;
    end;
  end
  else
  begin
    result := '';
  end;
end;

function TfrmParts.ProductHasAllocationRecords(PQAType:String = ''): Boolean;
var
  QRY:TERPQuery;
begin
  REsult := False;

  if qryProductPARTSID.AsInteger =0 then exit;

  qry := DbSharedObj.GetQuery(MyConnection);
  try
    qry.Connection:= MyConnection;
    closedb(qry);
    qry.SQL.text := 'Select count(PQAD.PQAID) PQACount from tblPQa PQA inner join tblPQADetails PQAD on PQA.PQAID = PQAD.PQAID '+ iif(PQAType<> '' , ' and PQAD.alloctype =' +quotedstr(PQAType) , '') +
                   ' where PQA.productId=  ' +                  IntToStr(qryProductPARTSID.AsInteger);
    opendb(qry);
    REsult := qry.FieldByName('PQACount').AsInteger > 0;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;

end;

Function TfrmParts.SaveProduct:Boolean ;
var
  qryTemp: TERPQuery;
  bm :TBookMark;
  s:String;
begin
    Result := False;

    try
       if AccessLevel = 5 then begin
         result := true;
         self.CommitTransaction;
         exit;
       end;

      if not BuyQty_Prices then Exit;
      if not SellQty_Prices then Exit;

      if not Validate then Exit;
      if ProductBarcodeList.Dirty and (not ProductBarcodeList.Save) then Exit;
      if not(SavePriceMatrix) then exit;
      ProductPicture.PostDb;
      if (ProductPicture.Count > 0) and (not ProductPicture.Save) then begin
          CommonLib.MessageDlgXP_Vista('Coud not save Product Picture: ' + ProductPicture.ResultStatus.Messages, mtInformation, [mbOK], 0);
        exit;
      end;

      qryTemp := TERPQuery.Create(nil);
      qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
      try
        try
          Processingcursor(True);
          if qrySpecifications.Active and (qrySpecifications.Modified) then
            PostDB(qrySpecifications);

            PostDB(QryProductClass);
            bm :=QryProductClass.GetBookmark;
            QryProductClass.Disablecontrols;
            TRy
                QryProductClass.first;
                while QryProductClass.Eof = false do begin
                      if QryProductClassProductID.asInteger = 0 then begin
                         EditDB(qryProductClass);
                         qryProductClassProductID.AsInteger := qryProductPARTSID.AsInteger;
                         qryProductClassProductName.AsString := qryProductPARTNAME.AsString;
                         qryProductClassProductGroup.AsString := qryProductPRODUCTGROUP.AsString;
                         PostDB(qryProductClass);
                      end;
                      qryProductClass.Next;
                end;
            Finally
                qryProductClass.GotoBookmark(bm);
                qryProductClass.Enablecontrols;
                qryProductClass.FreeBookmark(bm);
            end;

          If EditNoAbort(qryProduct) then Begin
            qryProduct.FieldByName('Duration').AsInteger := (qryProduct.FieldByName('OrderTime').AsInteger +
              qryProduct.FieldByName('ManufactureTime').AsInteger + qryProduct.FieldByName('OverrunTime').AsInteger);
            PostDB(QryProduct);
          end;

          if (qryProductClass.Modified)     then PostDB(qryProductClass);
          if (qrySellPrices.Modified)       then PostDB(qrySellPrices);
          if (qryExtraBuyPrice.Modified)    then PostDB(qryExtraBuyPrice);
          if (qryForeignPrice.Modified)     then PostDB(qryForeignPrice);
          if (qryForeignPriceSell.Modified) then PostDB(qryForeignPriceSell);
          if (qryPartNotes.modified)        then Postdb(qryPartNotes);

          EditDB(qryProduct);
          qryProductmsUpdateSiteCode.AsString:= AppEnv.Branch.SiteCode;
          qryProduct.FieldByName('PRODUCTGROUP').AsString := ProductGroupJoin;
          EditDB(qryProduct);PostDB(QryProduct);EditDB(qryProduct);
          if bCopyPart then begin
            AddFlag('Cloning');
            try
              CreateQtyLines;
              CreateUOMs;
            finally
              RemoveFlag('Cloning');
            end;

          end;
          bCopyPart := False;
          iCopyPartID := 0;

          EditDB(qryProduct);
          if (qryProductEditedFlag.AsString = 'T') then begin
            EditDB(qryProduct);
            qryProductDateUpdated.AsDateTime:= Now;
          end;
          PostDB(QryProduct);

          if not AllocationOptionsconfirmed then exit;

          ProcessEditedFlag('Main', Self, memqryProduct, qryProduct, nil);

          { update tblProductGroup }
          qryTemp.Connection:= MyConnection;

          s:= ' Insert Ignore into tblProductGroup (GroupName) '+
                       ' select distinct '+ Firstcolumn  + ' from tblParts P  where IfNull(ProductGroup,"") <> ""  and '+ firstcolumn  + ' <> ""  and PartsId = '+ inttostr(QryProductPArtsId.asInteger)+ ' and '+ firstcolumn  +' not in (select GroupName from tblProductGroup  ) ' +
            ' union all  select distinct '+ secondcolumn + ' from tblParts P  where IfNull(ProductGroup,"") <> ""  and '+ secondcolumn + ' <> ""  and PartsId = '+ inttostr(QryProductPArtsId.asInteger)+ ' and '+ secondcolumn +' not in (select GroupName from tblProductGroup  ) ' +
            ' union all  select distinct '+ Thirdcolumn  + ' from tblParts P  where IfNull(ProductGroup,"") <> ""  and '+ Thirdcolumn  + ' <> ""  and PartsId = '+ inttostr(QryProductPArtsId.asInteger)+ ' and '+ Thirdcolumn  +' not in (select GroupName from tblProductGroup  ) ' ;
        qryTemp.SQL.clear;
        qryTemp.SQL.add(s);
        qryTemp.execute;

        GlobalEvents.Notify(self, GEVENT_EXTENDER_PARENT_AFTERSAVE);
        CommitTransaction;
        Result := True;
        if Assigned(fOnAfterSaveProduct) then
          fOnAfterSaveProduct(self);

        finally
          if Assigned(qryTemp) then
            FreeAndNil(qryTemp);
          Processingcursor(False);
        end;
      except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin HandleNoAccessException(e); exit; end;
      on e: Exception do begin
          Audit.AddEntry(e, Self);
          raise Exception.Create(e.Message + chr(13) + 'Errors occured in ' + Self.ClassName);
        end;
      end;
    finally
    end;
end;

procedure TfrmParts.tglGSTClick(Sender: TObject);
begin
  inherited;
  if bFinishedOnShow and (screen.activecontrol = tglGST) then begin
    CommonLib.MessageDlgXP_Vista('If a price (as Ex) is entered manually then it must include four(4) decimal places or be entered as ''Inc'' for auto-calculation', mtInformation, [mbOK], 0);
  end;
  PriceExMode := not(PriceExMode);
end;

procedure TfrmParts.txtRetailPriceIncExit(Sender: TObject);
var
  Ex, Inc: Double;
begin
  try
    inherited;
    if not (qryProduct.State in [dsEdit, dsInsert]) then
      exit;
    Inc := StrValue(txtRetailPriceInc.Text);
    Ex := CommonLib.Round(GetAmountEx(Inc, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
    qryProduct.FieldByName('Price1').AsFloat := Ex;
    CostPriceMarkupCalc(qryProductPRICEINC1);
    txtMarkup2.Text := FloatToStrF(AppEnv.CompanyPrefs.WholesalePercentag * 100, ffFixed, 7, 2) + ' %';
    txtRetailPriceInc.Text := CurrToStrF(FloatToCurr(RoundCurrency(Inc)), ffCurrency, CurrencyRoundPlaces);
  finally
    OnExitPriceEdit(sender);
  end;
end;

procedure TfrmParts.cmdCopyClick(Sender: TObject);
begin
  inherited;
  Editdb(qryProduct);
  qryProduct.FieldByName('PARTSDESCRIPTION').AsString := qryProduct.FieldByName('PURCHASEDESC').AsString;
end;

procedure TfrmParts.txtMarkup2Exit(Sender: TObject);
var
  TempPercent: Double;
begin
  inherited;
  if IsFlag('ChangingWholeSale%') or (fsShowing in self.FormState) then Exit;

  TempPercent := StrValue(txtMarkup2.Text) / 100;
  if qryProductWHOLESALEPRICE.AsFloat <> qryProductCOST1.AsFloat * (1 + TempPercent) then
  begin
    CheckEditMode(qryProduct);
    // txtMarket2Exit is called during formShow so only modify qryProductWHOLESALEPRICE
    // if values do not equal as setting this sets qryProduct.Modified to true so user
    // will be asked to Save when form closes even if they have not changed any fields
    qryProductWHOLESALEPRICE.AsFloat := qryProductCOST1.AsFloat * (1 + TempPercent);
  end;

  txtmarkup2.Text := FloatToStrF(DivZer((qryProductWHOLESALEPRICE.AsFloat - qryProductCOST1.AsFloat), qryProductCOST1.AsFloat) * 100, ffFixed, 7, 2) + ' %';
end;

procedure TfrmParts.cbTaxCodeQryCalcFields(DataSet: TDataSet);
begin
  inherited;
  cbTaxCodeQryTaxRatePercent.AsFloat := cbTaxCodeQryRate.AsFloat * 100;
end;

procedure TfrmParts.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    Processingcursor(True);
    try
      if DataHasChanged then
      begin
        if CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          if not PreSaveProduct then  Exit;

          if not SaveProduct then Exit;
        end else begin
          RollbackTransaction;
        end;
      end;
      formshown := False;
      Try
        CloseQueries;
        KeyID := 0;
        fsPartName := '';
        fsBarcode := '';
        bInitialisedNewPart := False;
        edtPart.ReadOnly := False;
        Application.ProcessMessages;
        CalcQtyformulaREadonly := False;
        FormShow(self);
      Finally
        formshown:= True;
      End;
    finally
      Processingcursor(False);
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmParts.btnProductClassesClick(Sender: TObject);
begin
  if qryProductClassActive.AsBoolean = False then Exit;

  if  (qryProductClassAvailableQty.asfloat <>0) or
      (qryProductClassAllocatedBOQty.asfloat <>0) or
      (qryProductClassSOQty.asfloat <>0) or
      (qryProductClassSOBOQty.asfloat <>0) or
      (qryProductClassInstockQty.asfloat <>0) or
      (qryProductClassPOBOQty.asfloat <>0) then begin
      MessageDlgXP_Vista('The product has some outstanding quantity for this ' + Appenv.DefaultClass.Classheading +'. It is not possible to make it Inactive.', mtWarning, [mbOK], 0);
      Exit;
  end;
  inherited;
  qryProductClass.DisableControls;
  try
    if qryProductClass.recordcount <= 1 then exit;
    EditDB(qryProductClass);
    qryProductClassActive.AsBoolean := false;
    PostDB(qryProductClass);
    grdProductClasses.refresh;
    MessageDlgXP_Vista(Appenv.DefaultClass.Classheading +' ' + quotedstr(qryProductclassclassname.asString)+' is made inactive.', mtInformation, [mbOK], 0);
  finally
    qryProductClass.EnableControls;
  end;
end;
procedure TfrmParts.calcUnallocatedBatches(var Message: TMessage);
var
  notAllocated :double;
  strSQL:String;
begin
  notAllocated := qryProductClassInstockQty.asFloat;
  strSQL := 'Select ' + SQL4Qty(tinstock , 'PQA' , 'PQABatch.Qty') + ' as Qty '+
            ' FROM ' + ProductTables(tDetails) +
            ' Where PQA.ProductID = ' + IntToStr(qryProductPARTSID.asInteger) +
            ' and PQA.DepartmentId = ' + IntToStr(qryProductClassClassID.asInteger);
  With TERPQuery.create(Self) do try
      Connection := qryProductClass.Connection;
      SQL.add(strSQL);
      Open;
      if recordcount > 0 then  notAllocated := notAllocated - FieldByname('Qty').asFloat;
  finally
      if active then close;
      Free;
  end;

  edNotAllocatedToBatches.Text := FloatToStrF(round(notAllocated,tcconst.GeneralRoundPlaces), ffFixed, 10, 5);
       if notAllocated = 0 then edNotAllocatedToBatches.Color := clMoneyGreen
  else if notAllocated > 0 then edNotAllocatedToBatches.Color := clLime
  else                          edNotAllocatedToBatches.Color := clRed;
end;
procedure TfrmParts.calcUnallocatedBins(var Message: TMessage);
var
  notAllocated:Double;
  strSQL:String;
begin
  notAllocated := qryProductClassInstockQty.asFloat;
  strSQL := 'Select ' + SQL4Qty(tinstock , 'PQA' , 'PQAbins.Qty') + ' as Qty '+
            ' FROM ' + ProductTables(tExtraDetails) +
            ' Where PQA.ProductID = ' + IntToStr(qryProductPARTSID.asInteger) +
            ' and PQA.DepartmentId = ' + IntToStr(qryProductClassClassID.asInteger);
  With TERPQuery.create(Self) do try
      Connection := qryProductClass.Connection;
      SQL.add(strSQL);
      Open;
      if recordcount > 0 then  notAllocated := notAllocated - FieldByname('Qty').asFloat;
  finally
      if active then close;
      Free;
  end;
  edNotAllocatedToBins.Text := FloatToStrF(round(notAllocated,tcConst.GeneralRoundPlaces), ffFixed, 10, 4);
       if notAllocated = 0 then edNotAllocatedToBins.Color := clMoneyGreen
  else if notAllocated > 0 then edNotAllocatedToBins.Color := clLime
  else                          edNotAllocatedToBins.Color := clRed;

       if notAllocated = 0 then edNotAllocatedToBins.hint := 'Allocation is complete'
  else if notAllocated > 0 then edNotAllocatedToBins.hint := floattoStrf(notAllocated , ffGeneral, 15,2)+  ' quantity to be allocated'
  else                          edNotAllocatedToBins.hint := floattoStrf(abs(notAllocated) , ffGeneral, 15,2)+  ' quantity is over allocated';
  edNotAllocatedToBins.Showhint := True;

end;

procedure TfrmParts.cboClassNameCloseUp(Sender: TObject; LookupTable,  FillTable: TDataSet; modified: Boolean);
var
  strSQL:String;
begin
  if not Modified then Exit;
  inherited;
  strSQL:= 'Select * from tblProductClasses '+
          ' where productID = ' +IntToStr(qryProductPARTSID.AsInteger)+
          ' and classId  = ' +IntToStr(cbo_Class_QryClassID.asInteger)+
          ' and id <> ' +IntToStr(qryProductClassID.asInteger);
  with GetNewDatasetinTransaction(strSQL) do try
      if recordcount > 0 then begin
          CommonLib.MessageDlgXP_Vista('Duplicate record' , mtWarning, [mbOk], 0);
          if qryProductClass.State in [dsEdit,dsinsert] then qryProductClass.Cancel;
          Exit;
      end;
  finally
      if active then close;
      Free;
  end;
  if qryProductClass.State in [dsEdit, dsInsert] then else
    qryProductClass.Edit;
  qryProductClassClassID.AsInteger := cbo_Class_QryClassID.asInteger;
  qryProductClassClassname.Asstring := cbo_Class_QryClassname.asstring;
  if qryProductClass.State in [dsEdit, dsInsert] then
    qryProductClass.Post;
end;
Procedure TfrmParts.AlignOptionCheckBoxes;
  Procedure SizeCheckbox(lbl:TLabel; chk :TDBcheckbox);
  begin
    chk.Width           := 15;
    chk.Align           := alright;
    chk.AlignWithMargins:= True;
    chk.Margins.Left    := 0;
    chk.Margins.Bottom  := 0;
    chk.Margins.top     := 0;
    chk.Margins.Right   := 4;
    lbl.Align           := alclient;
    lbl.Layout          := tlCenter;
  end;
begin
    SizeCheckbox(lblAutoReorder           ,chkAutoReorder           );
    SizeCheckbox(lblDiscontinued          ,chkDiscontinued          );
    SizeCheckbox(lblIncludeInAnalysis     ,chkIncludeInAnalysis     );
    SizeCheckbox(lblHideonDelDocket       ,chkHideonDelDocket       );
    SizeCheckbox(lblAutoSmartOrder        ,chkAutoSmartOrder        );
    SizeCheckbox(lblisEquipment           ,chkisEquipment           );
    SizeCheckbox(lblPublishOnWeb          ,chkPublishOnWeb          );
    SizeCheckbox(lblHideonPickSlip        ,chkHideonPickSlip        );
    SizeCheckbox(lblHideOnPrint           ,chkHideOnPrint           );
    SizeCheckbox(lblSNTracking            ,chkSNTracking            );
    SizeCheckbox(lblCanDeleteInPOS        ,chkCanDeleteInPOS        );
    SizeCheckbox(lblIsBOMTemplate         ,chkIsBOMTemplate         );
    SizeCheckbox(lblRequiresAssembly      ,chkRequiresAssembly      );
    SizeCheckbox(lblSpecialDiscount       ,chkSpecialDiscount       );
    SizeCheckbox(lblRequireSignature      ,chkRequireSignature      );
    SizeCheckbox(lblExcludeFromSmartOrder ,chkExcludeFromSmartOrder );
    SizeCheckbox(lblHideWastage           ,chkHideWastage           );
end;

procedure TfrmParts.FormCreate(Sender: TObject);
begin
  aPartsExcelPrice :=nil;
  //fbPartsExcelPriceCreated := False;
  fbAftershowAutoFocusingToPage := False;
  fbUpdatingcompanyonName := False;
  ApplyLabelCaptions(lblPartname          , cpProductName);
  ApplyLabelCaptions(lblProductPrintName  , cpProductPrintName);
  ApplyLabelCaptions(lblFirstCol          , cpPrductfirstcolumn);
  ApplyLabelCaptions(lblSecondCol         , cpProdutSecondcolumn);
  ApplyLabelCaptions(lblThirdCol          , cpProductthirdcolumn);

  fsFilenamePrefix :='ERPHelpDoc_' +  GetTemporaryTableNameSuffix+'_';
  ERPHelpDocViewer := nil;
  fProductQtyAdjobj := nil;
  {$IFDEF WEB_SHOP}
  lblPartPicName.Visible := true;
  edtPartPicName.Visible := true;
  lblPartPicSortOrder.Visible := true;
  edtPartPicSortOrder.Visible := true;
  lstImageTypes.Visible := true;
  {$ELSE}
  lblPartPicName.Visible := false;
  edtPartPicName.Visible := false;
  lblPartPicSortOrder.Visible := false;
  edtPartPicSortOrder.Visible := false;
  lstImageTypes.Visible := false;
  {$ENDIF}
  pageControl.ActivePage := TTabSheet(Main);
  inherited;
  AlignOptionCheckBoxes;
  fbValidatingdisPercent  := False;
  fbPricechanged:= False;
  try
    tabwalmart.Visible := appenv.CompanyPrefs.EnableWalmart;
    MiscPageControl.ActivePage := TTabSheet(tabwalmart);
    MiscPageControl.ActivePage := TTabSheet(tabGeneral);
    tabAusEParcel.TabVisible:= (Appenv.RegionalOptions.RegionType = RAust) and
                             (Appenv.CompanyPrefs.EnableAusEparcel);
  Except
    on E:Exception do begin
      tabAusEParcel.TabVisible:= False;
    end;
  end;
  fbValidatingProductcostPrice := False;
  btnRefresh.Visible := Devmode;
  RoundingPriceHint:= Nil;
  CalcQtyformulaREadonly:= False;
  AlternateProductsIsDefaultChanging:= False;
  {Adds SearchValue and Searchfield Params for ERPLookupcombo to work - also the fields to the drop down }
  cboProductQry.SQL.add('and p.PartsId <> :KeyID');
  self.cboProductsRelated.SpcialLookupItemList.Text:= ComboSpecialItem_OpenList;
  self.cboPrintProductsrelated.SpcialLookupItemList.Text:= ComboSpecialItem_OpenList;
  fbIsHireProduct := false;

  PartsPriceMatrixform := Nil;
  chkExtraSellPrice.showhint := true;
  lblExtraSellPrice.showhint := true;
  chkExtraSellPrice.hint := DiscountOverrideHint;
  lblExtraSellPrice.hint := DiscountOverrideHint;
  ProductclassPartsID:= -1;
  fsPartName := '';
  fsBarcode:= '';
  ChangingUOMtobeUsedinManufacture:= False;
  ffrmListSupplierProductReport       :=nil;
  ffrmListSalesReport     :=nil;
  fFrmProductQtycheck     :=nil;

  ispricechanging:= False;
  ForeignCurrency:= TCurrency.Create(nil);
  DoingOnTabchange:= false;
  LastKeyId:= -1;
  bNewPart := False;
  Flags:= TIntegerList.Create;
  inQtyPriceValidation := False;
  ProductBarcodeList:= TProductBarcodeList.Create(self);
  ProductBarcodeList.connection := TMydacdataconnection.Create(ProductBarcodeList);
  ProductBarcodeList.connection.connection := Self.MyConnection;
  ProductBarcodeList.Name:= 'ProductBarcodeList';
  ProductBarcodeList.BusObjEvent := DoBusinessObjectEvent;
  ProductBarcodeList.SilentMode:= false;
  ProductBarcodeList.LogChangesOnSave := False;

  ProductPicture := TProductPicture.Create(Self);
  ProductPicture.Connection := TMyDacDataConnection.Create(ProductPicture);
  ProductPicture.Connection.Connection := MyConnection;
  ProductPicture.BusObjEvent := DoBusinessObjectEvent;

  updatedDefaultbin:= false;
  fNewManufactureExitExecuted := false;
  if Self.ErrorOccurred then exit;
  bFinishedOnShow := False;
  UserLock.Enabled := true;
  bInitialisedNewPart := False;
  bUpdatingSellInfo := False;
  bUpdatingBuyInfo := False;
  bUpdatingSellPrice := False;
  fbDiscountError := False;
  fbTabSettingEnabled := False;
  bCopyPart := False;
  iCopyPartID := 0;
  qrySales := TERPQuery.Create(Self);
  qrySales.Name := 'qrySales';
  qrySales.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryMan := TERPQuery.Create(Self);
  qryMan.Name := 'qryMan';
  qryMan.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryPurch := TERPQuery.Create(Self);
  qryPurch.Name := 'qryPurch';
  qryPurch.Connection := CommonDbLib.GetSharedMyDacConnection;
  isOpenToQuantities := False;
  fbAllowNotInList := true; // turn on auto not-in-list processing
  bUOMPriceChangeInProgress := false;
  bPriceMatrixPcent1ChangeInProgress := false;
  bCheckLinkNumInProgress := false;
  fbIsShowingList := False;
  slPictureCodes := TStringList.Create;


  if FindChildComponent(Self, 'dblcProductType') = nil then begin
    raise Exception.Create('The reference to the combo box labeled ''Product Type''' +
                           sLineBreak + 'in datAssemblyPart should be changed to match' +
                           sLineBreak + 'the combo box name');
  end;

  LoadqryUnitsOfMeasureQtys;
  LoadIntrans;
  iniTPartCalcFormulaOptions;

  SelectedProducts := TIntegerSet.Create;

  PageControlsellprice.ActivePageIndex := 0;

  initglobalEvets;
  GlobalEvents.Notify(Self, GEVENT_FormCreate_After);
end;
Procedure TFrmParts.initglobalEvets;
begin
  GlobalEvents.RegisterNameHandler(Self, '', '', GEVENT_FormCloseQuery, GlobalEventHandler);
end;
procedure TFrmParts.GlobalEventHandler(const Sender: TObject; const Event: string; const Data: Pointer);
begin
  (*if sameText(Event , GEVENT_FormCloseQuery)  then begin
    if Assigned(aPartsExcelPrice) then begin
      logtext('Freeandnil(TfmPartsExcelPrice)');
      Freeandnil(aPartsExcelPrice);
    end;
  end;*)
end;
Procedure TFrmParts.iniTPartCalcFormulaOptions;
var
  item: TMenuItem;
begin
  mnuPartCalcformulafields.Items.Clear;

  lblCalcField1.Caption := TRim(Appenv.CompanyPrefs.PartCalcField1Name);
  lblCalcField1.Visible :=Appenv.CompanyPrefs.PartCalcfield1Visible;
  edtCalcField1.Visible := Appenv.CompanyPrefs.PartCalcfield1Visible;

  lblCalcField2.Caption := TRim(Appenv.CompanyPrefs.PartCalcField2Name);
  lblCalcField2.Visible :=Appenv.CompanyPrefs.PartCalcfield2Visible;
  edtCalcField2.Visible := Appenv.CompanyPrefs.PartCalcfield2Visible;

  lblCalcField3.Caption := TRim(Appenv.CompanyPrefs.PartCalcField3Name);
  lblCalcField3.Visible :=Appenv.CompanyPrefs.PartCalcfield3Visible;
  edtCalcField3.Visible := Appenv.CompanyPrefs.PartCalcfield3Visible;

  lblCalcField4.Caption := TRim(Appenv.CompanyPrefs.PartCalcField4Name);
  lblCalcField4.Visible :=Appenv.CompanyPrefs.PartCalcfield4Visible;
  edtCalcField4.Visible := Appenv.CompanyPrefs.PartCalcfield4Visible;

  lblCalcField5.Caption := TRim(Appenv.CompanyPrefs.PartCalcField5Name);
  lblCalcField5.Visible :=Appenv.CompanyPrefs.PartCalcfield5Visible;
  edtCalcField5.Visible := Appenv.CompanyPrefs.PartCalcfield5Visible;

  lblCalcField11.Caption := lblCalcField1.Caption;lblCalcField11.visible := lblCalcField1.visible;   edtCalcField11.Visible := edtCalcField1.Visible;
  lblCalcField22.Caption := lblCalcField2.Caption;lblCalcField22.visible := lblCalcField2.visible;   edtCalcField22.Visible := edtCalcField2.Visible;
  lblCalcField33.Caption := lblCalcField3.Caption;lblCalcField33.visible := lblCalcField3.visible;   edtCalcField33.Visible := edtCalcField3.Visible;
  lblCalcField44.Caption := lblCalcField4.Caption;lblCalcField44.visible := lblCalcField4.visible;   edtCalcField44.Visible := edtCalcField4.Visible;
  lblCalcField55.Caption := lblCalcField5.Caption;lblCalcField55.visible := lblCalcField5.visible;   edtCalcField55.Visible := edtCalcField5.Visible;


  if (Appenv.CompanyPrefs.PartCalcfield1Visible) then begin
        item := TMenuItem.Create(self);
        item.Caption := Appenv.CompanyPrefs.PartCalcField1Name;
        item.Tag := 1;
        item.OnClick := mnuPartCalcformulafieldsClick;
        mnuPartCalcformulafields.Items.Add(item);
  end;

  if (Appenv.CompanyPrefs.PartCalcfield2Visible) then begin
        item := TMenuItem.Create(self);
        item.Caption := Appenv.CompanyPrefs.PartCalcField2Name;
        item.Tag := 2;
        item.OnClick := mnuPartCalcformulafieldsClick;
        mnuPartCalcformulafields.Items.Add(item);
  end;

  if (Appenv.CompanyPrefs.PartCalcfield3Visible) then begin
        item := TMenuItem.Create(self);
        item.Caption := Appenv.CompanyPrefs.PartCalcField3Name;
        item.Tag := 3;
        item.OnClick := mnuPartCalcformulafieldsClick;
        mnuPartCalcformulafields.Items.Add(item);
  end;

  if (Appenv.CompanyPrefs.PartCalcfield4Visible) then begin
        item := TMenuItem.Create(self);
        item.Caption := Appenv.CompanyPrefs.PartCalcField4Name;
        item.Tag := 4;
        item.OnClick := mnuPartCalcformulafieldsClick;
        mnuPartCalcformulafields.Items.Add(item);
  end;

  if (Appenv.CompanyPrefs.PartCalcfield5Visible) then begin
        item := TMenuItem.Create(self);
        item.Caption := Appenv.CompanyPrefs.PartCalcField5Name;
        item.Tag := 5;
        item.OnClick := mnuPartCalcformulafieldsClick;
        mnuPartCalcformulafields.Items.Add(item);
  end;
end;

procedure TfrmParts.mnuPartCalcformulafieldsClick(Sender:TObject);
var
  s:STring;
  x:Integer;
  InsertStr:String;
begin
    if not(sender is TMenuItem) then exit;
         if TMenuItem(Sender).tag = 1 then InsertStr :=   Appenv.CompanyPrefs.PartCalcField1Name
    else if TMenuItem(Sender).tag = 2 then InsertStr :=   Appenv.CompanyPrefs.PartCalcField2Name
    else if TMenuItem(Sender).tag = 3 then InsertStr :=   Appenv.CompanyPrefs.PartCalcField3Name
    else if TMenuItem(Sender).tag = 4 then InsertStr :=   Appenv.CompanyPrefs.PartCalcField4Name
    else if TMenuItem(Sender).tag = 5 then InsertStr :=   Appenv.CompanyPrefs.PartCalcField5Name
    else exit;

    if InsertStr = '' then exit;

    InsertStr:= ' [' + InsertStr +'] ';

    s := memPartCalcformula.Text;
    x := memPartCalcformula.SelStart;
    Insert(InsertStr, s, x + 1);
    editdb(QryProduct);
    QryProductpartCalcformula.AsString := s;
    postdb(QryProduct);
    editdb(QryProduct);
    if QryProductpartCalcformula.AsString <> memPartCalcformula.Text then memPartCalcformula.Text     := QryProductpartCalcformula.AsString;
    memPartCalcformula.SelStart :=Length(memPartCalcformula.Text);
    memPartCalcformula.SelLength := 0;
end;
procedure TfrmParts.mnuProdEquipClick(Sender: TObject);
begin
  inherited;
  OpenEquipform('');
end;

procedure TfrmParts.MyConnectionAfterCommit(Sender: TObject);
begin
  inherited;
  Appenv.CompanyPrefs.CheckForHasExcelPrices;
end;

procedure TfrmParts.OpenToQuantities;
begin
  inherited;
  isOpenToQuantities := True;
end;

procedure TfrmParts.txtRetailPriceExit(Sender: TObject);
begin
  inherited;
  fbPricechanged:= True;
  try
  if AccessLevel <= 2 then begin
    CostPriceMarkupCalc(qryProductPRICE1);
    txtMarkup2.Text := FloatToStrF(AppEnv.CompanyPrefs.WholesalePercentag * 100, ffFixed, 7, 2) + ' %';
    if (qryProduct.FieldByName('Price1').AsFloat <> 0) and (qryProduct.FieldByName('Attrib1Sale').AsFloat <> 0) then begin;
      EditDB(QryProduct);
      qryProduct.FieldByName('Attrib1SaleRate').AsFloat :=
        DivZer(qryProduct.FieldByName('Price1').AsFloat, qryProduct.FieldByName('Attrib1Sale').AsFloat);
    end;
  end;
  finally
    fbPricechanged:= False;
  end;
end;

Procedure TfrmParts.OnTabSerial(Sender :TObject);
begin
  if not formshown then exit;
  QrySerialnoBatchnumber.visible      :=   QryproductBatch.asBoolean;
  QrySerialnoBatchExpiryDate.visible  :=   QryproductBatch.asBoolean;
  QrySerialnobinLocation.visible      :=   Qryproductmultiplebins.asBoolean;
  QrySerialnobinnumber.visible        :=   Qryproductmultiplebins.asBoolean;
  mnuEquipment.visible                :=   QryproductisEquipment.asBoolean;
  cboClass4Serialno.Text := qryProductClassClassName.asString;
  QrySerialno.DisableControls;
  try
    if QrySerialno.active then QrySerialno.Close;
    QrySerialno.SQL.clear;
    QrySerialno.SQL.add(Serialnumberlist(QryProductPARTSID.asInteger , qryProductClassClassID.asInteger , 0 , 0, 0 , False));
    QrySerialno.SQL.add('Union');
    QrySerialno.SQL.add('SELECT distinct ');
    QrySerialno.SQL.add('P.PartsId, ');
    QrySerialno.SQL.add('S.ClassId as DepartmentID, ');
    QrySerialno.SQL.add('0 as UOMID, ');
    QrySerialno.SQL.add(Quotedstr(AppEnv.DefaultClass.DefaultUOM) +' as UOM,');
    QrySerialno.SQL.add('1 as UOMMultiplier,');
    QrySerialno.SQL.add('3 as gLevel, ');
    QrySerialno.SQL.add('P.PartName as ProductName ,');
    QrySerialno.SQL.add(FirstColumn  +' as ProductColumn1,');
    QrySerialno.SQL.add(Secondcolumn +' as ProductColumn2,');
    QrySerialno.SQL.add(Thirdcolumn  +' as ProductColumn3,');
    QrySerialno.SQL.add('PartsDescription,');
    QrySerialno.SQL.add('S.ClassName,');
    QrySerialno.SQL.add('"" as Batchnumber,');
    QrySerialno.SQL.add('"" TruckLoadNo, ');
    QrySerialno.SQL.add('NULL  as BatchExpiryDate, ');
    QrySerialno.SQL.add('NULL  as BatchExpiryDate,');
    QrySerialno.SQL.add('"" Binlocation,');
    QrySerialno.SQL.add('"" Binnumber,');
    QrySerialno.SQL.add('SerialNo,');
    QrySerialno.SQL.add('NULL as Description,');
    QrySerialno.SQL.add('NULL as Transdate,');
    QrySerialno.SQL.add('"New" as allocType');
    QrySerialno.SQL.add('FROM tblSerialnumbers S');
    QrySerialno.SQL.add('inner join tblParts P on P.PartsId = S.ProductID');
    QrySerialno.SQL.add('Where  S.Active = "T"');
    QrySerialno.SQL.add('and Serialno not in (Select Value from tblPQADetails where PQAType = ' +quotedStr(TPQASN.PQADetailType)+' and productId = ' + IntToStr(QryProductPARTSID.asInteger)+')');
    QrySerialno.SQL.add('and S.ClassId =' + IntToStr(qryProductClassClassID.asInteger));
    QrySerialno.SQL.add('and S.ProductID =' + IntToStr(QryProductPARTSID.asInteger));
    try
      QrySerialno.open;
      grpFiltersClick(grpFilters);

    Except
      on E:Exception do begin

      end;
    end;

  finally
    QrySerialno.EnableControls;
  end;
  ShowProductQtycheck;
  chkshowTransactionhistoryClick(chkshowTransactionhistory);
end;
Procedure TfrmParts.ShowProductQtycheck;
var
  ffrmList : TProductQtycheckGUI;
begin
    ffrmList := TProductQtycheckGUI(ProductQtycheckForm);
    if assigned(ffrmList) then begin
      TProductQtycheckGUI(ffrmList).productId :=qryProductPARTSID.AsInteger;
      TProductQtycheckGUI(ffrmList).ClassId :=qryProductClassClassId.asInteger;
      ffrmList.Parent := pnlProductQtycheck;
      ffrmList.borderstyle := bsNone;
      ffrmList.Show;
    end;
end;
Function  TfrmParts.OnTabchange(  Sender :TObject ; var PriorityName1, PriorityName2: string; var PriorityID1,PriorityID2: Integer): boolean;
var
    SelectedTab: TTabSheet;
begin
    Result := True;
    if DoingOnTabchange then exit;
    DoingOnTabchange:= true;
    try
      SelectedTab := pageControl.ActivePage;
      if bNewPart and (pageControl.ActivePage <> TTabSheet(Main)) then begin
        if PreSaveProduct then begin
          pageControl.ActivePage := TTabSheet(SelectedTab);
        end else begin
          pageControl.ActivePage := TTabSheet(Main);
          Result := False;
          Exit;
        end;
      end;
    finally
      DoingOnTabchange:= false;
    end;
end;

Procedure TfrmParts.OnTabSupplierHistory(Sender:TObject);
var
      ffrmList          : TBaseListingGUI;
begin
    // State that we are viewing a base listing form.
        // While this is happening.  Page Changes cannot happen.
  //btnOpen.Enabled := true;
  //btnOpen.OnClick := OpenSupplierHistory;
        fbIsShowingList := True;

        ffrmList := SupplierProductReportListForm;
        if Assigned(ffrmList) then
        begin
          ffrmList.FilterString := 'ProductID = ' + IntToStr(KeyID);
          ffrmList.Parent := pnlSuppHistory;
          ffrmList.borderstyle := bsNone;
          ffrmList.Show;
        end;
end;
Procedure TfrmParts.OnTabCustomerHistory(Sender:TObject);
var
      ffrmList          : TBaseListingGUI;
begin
        // State that we are viewing a base listing form.
        // While this is happening.  Page Changes cannot happen.
  //btnOpen.Enabled := true;
  //btnOpen.OnClick := OpenCustomerHistory;
        fbIsShowingList := True;

        ffrmList := SalesReportListForm;

        if assigned(ffrmList) then
        begin
          TSalesReportGUI(ffrmList).productId :=KeyID;
          ffrmList.Parent := pnlCustHistory;
          ffrmList.borderstyle := bsNone;
          ffrmList.Show;
          TSalesReportGUI(ffrmList).SelectedClasSID:= 0;
        end;
end;
Procedure TfrmParts.OnTabMain(Sender:TObject);
begin
    EditDB(QryProduct);
end;

Procedure TfrmParts.OnTabQuantities(sender:TObject);
begin
    if cbo_Class_Qry.Active = False then cbo_Class_Qry.Open;
    if qryProductClass.Recordcount = 0 then begin
      qryProductClass.Insert;
      qryProductClassClassID.asInteger := AppEnv.DefaultClass.ClassID;
      qryProductClassClassName.asString := AppEnv.DefaultClass.DefaultClassName;
      qryProductClass.Post;
    end;
    if qryUnitsOfMeasureQtys.Active = False then qryUnitsOfMeasureQtys.Open;
    grdProductClasses.ColumnByName('ClassName').DisplayLabel := AppEnv.DefaultClass.ClassHeading;
    OpenUnitsOfMeasureQtys(qryProductClassClassID.AsInteger);
    grdProductClasses.ColumnByName('DEfaultBinLocation').ReadOnly := qryProductMultipleBins.asBoolean = False;
    cboDefaultBin.Enabled := (qryProductMultipleBins.asBoolean = True) and (Accesslevel<5);
    updateDefaultbin;
    grdProductClassesRowChanged(grdProductClasses);
end;

Procedure TfrmParts.OnTabtabBatch(Sender:TObject);
begin
    lblProductvolume.Caption := 'Volume per ' + Trim(edtPartName.Text);
    chkMultipleBins.checked :=  qryProductMultipleBins.Asboolean;
    chkBatches.checked      :=  qryProductBatch.Asboolean;
    cbo_Class_Qry.Open;
    if qryProductBatch.asboolean        then  PostMessage(self.Handle, SX_BatchQtyChangeMsg, 0, 0);
    if qryProductMultipleBins.asBoolean then  PostMessage(self.Handle, SX_BinQtyChangeMsg, 0, 0);
    Application.ProcessMessages;
    cbobinbatchClass.Text := qryProductClassClassName.asString;
    if not Assigned(ProductAllocationForm) then cbobinbatchClassChange(cbobinbatchClass);
    lblDefaultBin4class.Enabled :=chkMultipleBins.checked and (Accesslevel<5);
    cboDefaultBin4class.Enabled :=chkMultipleBins.checked and (Accesslevel<5);
    pnlAdjustAllocation.Enabled :=(Accesslevel<5);
    pnlEmptyBins.Enabled :=(Accesslevel<5);

    btnMoveStockToDefaultbin.Enabled :=(chkMultipleBins.checked) and (Accesslevel<5);
    btnMoveAllStockToDefaultbin.Enabled :=(Accesslevel<5);
    updateDefaultbin;
end;

Procedure TfrmParts.OnTabExtraBuyPrice(sender:TObject);
begin
    cboClientLookup.Open;
end;


procedure TfrmParts.OnTabExtraSellPrice(sender: TObject);
begin
  CloseDb(qryUOM);
  OpenDb(qryUOM);
  if PartsPriceMatrixform = nil then begin
    PartsPriceMatrixform := TfmPartsPriceMatrix.create(Self, myconnection);
    PartsPriceMatrixform.ProductID := qryproductPartsId.asInteger;
    PartsPriceMatrixform.ParentControl := tabPriceMatrix;
    PartsPriceMatrixform.PriceMatrixTabIndex := 0;
    PartsPriceMatrixform.Align := alClient;
    PartsPriceMatrixform.pnlMatrix.Align := alClient;
  end;
end;

procedure TfrmParts.OntabLatestCost(Sender: TObject);
begin
  openDb(QryLatestCost);
  QryLatestCost.first;
  grdLatestCost.setActivefield('LineCost');
end;

Procedure TfrmParts.OnTabSalesMovement(Sender:TObject);
begin
    if bFirstSales_Movement then begin
        btnViewClick(Sender);
        bFirstSales_Movement := false;
    end;
end;
Procedure TfrmParts.OnTabMan(Sender:TObject);
begin
    if bfirstMan_Movement then begin
        btnManViewClick(Sender);
        bfirstMan_Movement := false;
    end;
end;
Procedure TfrmParts.OnTabPurchaseMovement(Sender:TObject);
begin

    if  bFirstPurch_Movement then begin
        btnPurchViewClick(Sender);
        bFirstPurch_Movement := false;
    end;
end;

Procedure TfrmParts.OnTabRelatedParts(Sender:TObject);
begin
    {related parts common for both}
    With cboProductQry do begin
        if Params.ParamByName('KeyId').asInteger <>  qryProductPARTSID.asInteger then begin
            if Active then close;
            Params.ParamByName('KeyId').asInteger :=  qryProductPARTSID.asInteger;
        end;
        if not Active then Open;
    end;
    cboProductQry.Open;
    qryRelatedParts.Open;
    grdRelatedParts.Update;
end;

Procedure TfrmParts.OnTabMisc(Sender :TObject);
begin
    MiscPageControl.ActivePage := TTabSheet(tabGeneral);
    InitAttachment;
    grdAltBarcodes.height := TDnmPanel(grdAltBarcodes.parent).height - 27;
end;

procedure TfrmParts.pageControlChange(Sender: TObject);
var
  PriorityName1     : string;
  PriorityName2     : string;
  PriorityID1       : Integer;
  PriorityID2       : Integer;
begin
  PriorityID1       := 0;
  PriorityID2       := 0;
  Processingcursor(True);

  if not OnTabchange(Sender,PriorityName1,PriorityName2, PriorityID1, PriorityId2) then Exit;

  Processingcursor(True);
  Try
           if (pageControl.ActivePage = TTabSheet(TabSerial))         then OnTabSerial(sender)
      else if (pageControl.ActivePage = TTabSheet(Supplier_History))  then OnTabSupplierHistory(sender)
      else if (pageControl.ActivePage = TTabSheet(Customer_History))  then OnTabCustomerHistory(sender)
      else if (pageControl.ActivePage = TTabSheet(Main))              then OnTabMain(sender)
      else if (pageControl.ActivePage = TTabSheet(Quantities))        then OnTabQuantities(sender)
      else if (pageControl.ActivePage = TTabSheet(Extra_Buy_Price))   then OnTabExtraBuyPrice(sender)
      else if (pageControl.ActivePage = TTabSheet(Extra_Sell_Price))   then OnTabExtraSellPrice(sender)
      else if (pageControl.ActivePage = TTabSheet(Miscellaneous))     then OnTabMisc(Sender)
      else if (pageControl.ActivePage = TTabSheet(RelatedParts))      then OnTabRelatedParts(sender)
      else if (pageControl.ActivePage = TTabSheet(newManufacture))    then onTabManufacture(Sender)
      else if (PageControl.ActivePage = TTabSheet(TabProductMovement)) then ontabTabProductMovement(Sender)
      else if (PageControl.ActivePage = TTabSheet(Custom_Fields))     then CustomFieldsRefresh
      else if (pageControl.ActivePage = TTabSheet(tabBatch))          then begin
        OnTabTabBatch(sender);
        if not chkMultipleBins.Checked  and  not chkBatches.Checked then begin
          CommonLib.MessageDlgXP_Vista('Please select either "Batch Tracking" or "Use Bins" to activate.', mtInformation,[mbOk], 0);
        end;
      end;

      GlobalEvents.Notify(pageControl, GEVENT_OnChange);
      fbIsShowingList := False;
  finally
    Processingcursor(False);
  end;
end;

procedure TfrmParts.FormDestroy(Sender: TObject);
begin
  Logtext('TfmPartsExcelPrice.FormDestroy' );
  Flags.Free;
  FreeAndNil(PartsPriceMatrixform);
  FreeAndNil(qrySales);
  FreeAndNil(qryMan);
  FreeAndNil(qryPurch);
  FreeAndNil(AttachmentForm);
  Freeandnil(RoundingPriceHint);
  //Freeandnil(fProductQtyAdjobj);  { owned by form}
  FreeAndNil(fSelectedProducts);
  Notify;
  ForeignCurrency.Free;
  DestroyUserTemporaryTable(ProductInTransTablename);
  slPictureCodes.Free;
  Freeandnil(HirePricingform);
  inherited;
  Logtext('TfmPartsExcelPrice.FormDestroy - done' );
end;

procedure TfrmParts.cboClientTypeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
var
  frm: TBaseInputGUI;
begin
    fbCanClose := False;
    Try
  inherited;
  frm := nil;
  Accept := false;
  if CommonLib.MessageDlgXP_Vista('Client Type not found in list. Would you like to create this Client Type?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    fbCanClose := False;
    try
      frm := TClientTypeGUI(GetComponentByClassName('TClientTypeGUI'));
      if Assigned(frm) then begin //if has acess
        TClientTypeGUI(frm).ClientTypeName := NewValue;
        frm.Position := poScreenCenter;
        frm.ShowModal;
      end;
    finally
      qryClientTypes.Close;
      qryClientTypes.Connection := CommonDbLib.GetSharedMyDacConnection;
      qryClientTypes.Open;
      if not Empty(TClientTypeGUI(frm).ClientTypeName) then begin
        if qryClientTypes.Locate('TypeName', TClientTypeGUI(frm).ClientTypeName, [loCaseInsensitive]) then begin
          qrySellPrices.Edit;
          qrySellPricesClientTypeID.AsInteger := qryClientTypes.fieldbyname('ClientTypeID').AsInteger;
          cboClientType.LookupValue := qryClientTypes.fieldbyname('ClientTypeID').AsString;
          Accept := true;
        end;
      end;
      if Assigned(frm) then
        FreeandNil(frm);
    end;
  end;
  Finally
    fbCanClose := True;
  end;
end;

procedure TfrmParts.cboCOGSACCEnter(Sender: TObject);
begin
  inherited;
  SaveAccessLevel := AccessLevel;
  AccessLevel := 1;
end;

procedure TfrmParts.cboCOGSACCExit(Sender: TObject);
begin
  inherited;
  PostDB(qryProduct);
  AccessLevel := SaveAccessLevel;
end;

procedure TfrmParts.qrySellPricesBeforePost(DataSet: TDataSet);
var
  strSQL:String;
begin
  inherited;
  qrySellPricesAllClients.asBoolean := qrySellPricesClientTypeID.asInteger=0;
  if ispricechanging then exit;
  strSQL:='Select * from tblExtraPriceSell ' +
          ' where   ((ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') <=' + QuotedStr(FormatDateTime(MysqlDateFormat , qrySellPricesDateFrom.asDatetime)) +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')>=' + QuotedStr(FormatDateTime(MysqlDateFormat , qrySellPricesDateFrom.asDatetime)) +' ) '+
          '       Or (ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') <=' + QuotedStr(FormatDateTime(MysqlDateFormat , qrySellPricesDateTo.asDatetime  )) +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')>=' + QuotedStr(FormatDateTime(MysqlDateFormat , qrySellPricesDateTo.asDatetime  )) +' )'+
          '       Or (ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') >=' + QuotedStr(FormatDateTime(MysqlDateFormat , qrySellPricesDateFrom.asDatetime)) +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')<=' + QuotedStr(FormatDateTime(MysqlDateFormat , qrySellPricesDateTo.asDatetime  )) +' ))'+
          ' and ifnull(UOMID,0)       ='+IntToStr(qrySellPricesUOMID.asInteger) +
          ' and ifnull(ClienttypeID,0)='+IntToStr(qrySellPricesClientTypeID.asInteger) +
          ' and ifnull(PartsID,0)     ='+IntToStr(qrySellPricesPartsID.asInteger) +
          ' and ifnull(Terms,"")      ='+Quotedstr(qrySellPricesTerms.asString) +
          ' and ifnull(priceID,0)    <>'+IntToStr(qrySellPricesPriceID.asInteger);

  with CommonDbLib.TempMyQuery do try
      connection := qrySellPrices.connection;
      SQL.add(strSQL);
      Open;
      if recordcount > 0 then begin
        Commonlib.MessageDlgXP_Vista('An Extra Sell Price Already Exists For Client Type ' +qrySellPricesClientTypeName.asString +' For An Overlaping Period and Same Unit Of Measure.' ,mtWarning, [mbok],0);
        abort;
      end;
  finally
      if active then close;
      Free;
  end;

end;

procedure TfrmParts.btnDeleteSellPriceClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista(Format('Are you sure you want to delete %s?', [qrySellPricesClientTypeName.AsString]),
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      qrySellPrices.Delete;
    except
      {Raise a silent exception}
    end;
  end;
end;

procedure TfrmParts.grdSellPricesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Field.FieldKind = fkCalculated then
  begin
    ABrush.Color := clSilver;
  end;
end;

procedure TfrmParts.btnDeleteXBuyPriceClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista(Format('Are you sure you want to delete %s?', [qryExtraBuyPriceSupplierName.AsString]),
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      qryExtraBuyPrice.Delete;
    except
      {Raise a silent exception}
    end;
  end;
end;



procedure TfrmParts.beforeshowProductPurchaseMovementList(Sender: TObject);
begin
   if not(sender is TProductPurchaseMovementListGUI) then exit;
   TProductPurchaseMovementListGUI(Sender).ProductID := qryProductPARTSID.AsInteger;
end;
procedure TfrmParts.qryExtraBuyPriceUsePriceChange(Sender: TField);
var
  bm: TBookmark;
begin
  inherited;
  if not Sender.AsBoolean then  exit;
  bUpdatingBuyInfo := True;
  try
    bm := qryExtraBuyPrice.GetBookmark;
    qryExtraBuyPrice.DisableControls;
    Try
      qryExtraBuyPrice.first;
      {Uncheck any other line with the Use flag set}
      while not qryExtraBuyPrice.EOF do
      begin
        if (qryExtraBuyPrice.CompareBookmarks(bm, qryExtraBuyPrice.GetBookmark) <> 0) and
          (qryExtraBuyPriceUsePrice.AsBoolean = true) then   begin
          EditDB(qryExtraBuyPrice);
          qryExtraBuyPriceUsePrice.AsBoolean := false;
          PostDB(qryExtraBuyPrice)
        end;
        qryExtraBuyPrice.Next;
      end;
    finally
      qryExtraBuyPrice.GotoBookmark(bm);
      qryExtraBuyPrice.FreeBookmark(bm);
      qryExtraBuyPrice.EnableControls;
    end;

    if CommonLib.MessageDlgXP_Vista('Are you sure you want to use ' +
              qryExtraBuyPriceSupplierName.AsString +' as the Preferred Supplier '
                + chr(13) + 'for product ' + qryProductPARTNAME.AsString + '?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
          EditDb(qryProduct);
          qryProductPREFEREDSUPP.AsString := qryExtraBuyPriceSupplierName.AsString;
          qryProductSupplierProductCode.AsString := qryExtraBuyPriceSupplierProductCode.AsString;
        UpdateProductCostWithExtraBuyPrice;
    end Else qryExtraBuyPrice.Cancel;
        {Set the new preferred Supplier details}
  finally
        bUpdatingBuyInfo := false;
  end;
end;

procedure TfrmParts.qryExtraBuyPriceSupplierIDChange(Sender: TField);
begin
  qryExtraBuyPrice.Post;
  qryExtraBuyPrice.Edit;
end;

procedure TfrmParts.btnSelectUOMClick(Sender: TObject);
begin
  inherited;
  with tEmpMyQuery do try
    SQL.add('Select count(*) ctr from tblparts where partsID = ' + inttostr(qryProductPartsID.asInteger));
    open;
    if fieldbyname('ctr').asInteger =0 then begin
    if MessageDlgXP_Vista('UOMS can be created only for saved Products. Do you want to Save this product and continue?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
      if not PreSaveProduct then  Exit;
      if not SaveProduct then Exit;
      BeginTransaction;
    end;
  finally
    if active then close;
    Free;
  end;
  OpenERPFormModal('TfmUOMforAutoSplitQtyinSales' , 0 , beforeshowUOMforAutoSplitQtyinSales);
end;

procedure TfrmParts.beforeshowUOMforAutoSplitQtyinSales(Sender: TObject);
begin
  if not(Sender is TfmUOMforAutoSplitQtyinSales) then exit;
  PostDB(qryProduct);
  TfmUOMforAutoSplitQtyinSales(Sender).ProductID := qryProductPartsId.AsInteger;
  TfmUOMforAutoSplitQtyinSales(Sender).TransConnection :=TERPConnection(qryProduct.Connection);
end;
procedure TfrmParts.btnStretchClick(Sender: TObject);
begin
  DisableForm;
  try
    StretchImage(imagePart , not(imagePart.Stretch));
    GuiPrefs.Node['Options.ImageStretch'].AsBoolean := imagePart.Stretch;
  finally
    EnableForm;
  end;
end;


procedure TfrmParts.btnTreeClick(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Sub Components To Load from Stock');
end;

procedure TfrmParts.mitAddImageClick(Sender: TObject);
begin
  DisableForm;
  try
    SelectPicture(TpotProductPicture, self, qryPartPics , qryPartPicspartpicID.FieldName,  qryPartPicsPartPic.FieldName, true , qryPartPicsPictype.fieldname , true);
    ProductPicture.RefreshDB;
    if ProductPicture.Count = 1 then begin
      ProductPicture.IsDefault := true;
      ProductPicture.PostDb;
    end;
  finally
    EnableForm;
    navPartPic.visible := False;
    navPartPic.visible := TRue;
    application.ProcessMessages;
  end;
end;

procedure TfrmParts.mnuauditTrialClick(Sender: TObject);
begin
  inherited;
  if KeyId  =0 then exit;
  OpenErpListform('TTransAuditTrailGUI' ,TransAuditTrialbeforeShow);
end;
procedure TfrmParts.mnuEquipmentClick(Sender: TObject);
begin
  inherited;
  OpenEquipform(QrySerialnoSerialnumber.asString);
end;

procedure TfrmParts.mnuEquipPopup(Sender: TObject);
begin
  inherited;
  mnuProdEquip.visible := QryProductIsEquipment.asBoolean;
end;

procedure TfrmParts.TmrRoundingPriceHintTimer(Sender: TObject);
begin
  inherited;
  if assigned(RoundingPriceHint) then Freeandnil(RoundingPriceHint);
  TmrRoundingPriceHint.Enabled:= False;
end;

procedure TfrmParts.TransAuditTrialbeforeShow(Sender: TObject);
begin
  if not(Sender is TTransAuditTrailGUI) then exit;
  TTransAuditTrailGUI(Sender).DocName       := 'Product';
  TTransAuditTrailGUI(Sender).DocId         := QryproductPartsId.asInteger;
  TTransAuditTrailGUI(Sender).TransGlobalref:= QryproductGlobalref.asString;
  TTransAuditTrailGUI(Sender).DocDescription:='Product';
  TTransAuditTrailGUI(Sender).Formname      := Self.Classname;
end;


procedure TfrmParts.dblcProductTypeChange(Sender: TObject);
var
  I: Integer;
Const GrayColor = $00E8E8E8;
begin
  If (csDestroying in Self.ComponentState) then Exit;
  inherited;
  GlobalEvents.Notify(Sender, GEVENT_ComboCloseUp);

  if dblcProductType.Value = 'Assembly' then
  begin
    txtBuy1.Enabled := false;
    txtBuy2.Enabled := false;
    txtBuy3.Enabled := false;
    txtBuy1.Color := GrayColor;
    txtBuy2.Color := GrayColor;
    txtBuy3.Color := GrayColor;

    txtCost.Enabled := false;
    txtCost2.Enabled := false;
    txtCost3.Enabled := false;
    txtCost.Color := GrayColor;
    txtCost2.Color := GrayColor;
    txtCost3.Color := GrayColor;

    txtSell1.Enabled := false;
    txtSell2.Enabled := false;
    txtSell3.Enabled := false;
    txtSell1.Color := GrayColor;
    txtSell2.Color := GrayColor;
    txtSell3.Color := GrayColor;

    txtRetailPrice.Enabled := false;
    txtPrice2.Enabled := false;
    txtPrice3.Enabled := false;
    txtRetailPrice.Color := GrayColor;
    txtPrice2.Color := GrayColor;
    txtPrice3.Color := GrayColor;
  end
  else begin
    txtBuy1.Enabled := true;
    txtBuy2.Enabled := true;
    txtBuy3.Enabled := true;
    txtBuy1.Color := clWindow;
    txtBuy2.Color := clWindow;
    txtBuy3.Color := clWindow;

    txtCost.Enabled := true;
    txtCost2.Enabled := true;
    txtCost3.Enabled := true;
    txtCost.Color := clWindow;
    txtCost2.Color := clWindow;
    txtCost3.Color := clWindow;

    txtSell1.Enabled := true;
    txtSell2.Enabled := true;
    txtSell3.Enabled := true;
    txtSell1.Color := clWindow;
    txtSell2.Color := clWindow;
    txtSell3.Color := clWindow;

    txtRetailPrice.Enabled := true;
    txtPrice2.Enabled := true;
    txtPrice3.Enabled := true;
    txtRetailPrice.Color := clWindow;
    txtPrice2.Color := clWindow;
    txtPrice3.Color := clWindow;
  end;
  optSalesTaxBasedonChange(nil);
  if (dblcProductType.Value <> 'Inventory Part') and (dblcProductType.Value <> 'Group') then begin
    if qryProduct.Active then begin
      EditDB(QryProduct);
      chkMultipleBins.Checked := False;
    end;
  end;


  if (dblcProductType.Value = 'Non-Inventory Part') then begin
    for I := 0 to pnlPurchMisc.ControlCount - 1 do begin
      if pnlPurchMisc.Controls[I] is TDBEdit then begin
      end else if pnlPurchMisc.Controls[I] is TwwDBLookupCombo then begin
        TwwDBLookupCombo(pnlPurchMisc.Controls[I]).Color := clSilver;
        TDBEdit(pnlPurchMisc.Controls[I]).Enabled := False;
      end;
    end;

    for I := 0 to pnlPurchase.ControlCount - 1 do
    begin
      if pnlPurchase.Controls[I] is TDBEdit then
      begin
        TDBEdit(pnlPurchase.Controls[I]).Color := clWhite;
        TDBEdit(pnlPurchase.Controls[I]).Enabled := bAccessEnabled;
      end
      else if pnlPurchase.Controls[I] is TwwDBLookupCombo then
      begin
        TwwDBLookupCombo(pnlPurchase.Controls[I]).Color := clWhite;
        TDBEdit(pnlPurchase.Controls[I]).Enabled := bAccessEnabled;
      end;
    end;
  end
  else if (dblcProductType.Value = 'Other Type') then begin
    for I := 0 to pnlPurchase.ControlCount - 1 do begin
      if pnlPurchase.Controls[I] is TDBEdit then
      begin
        TDBEdit(pnlPurchase.Controls[I]).Color := clSilver;
        TDBEdit(pnlPurchase.Controls[I]).Enabled := False;
      end
      else if pnlPurchase.Controls[I] is TwwDBLookupCombo then
      begin
        TwwDBLookupCombo(pnlPurchase.Controls[I]).Color := clSilver;
        TDBEdit(pnlPurchase.Controls[I]).Enabled := False;
      end;
    end;

    for I := 0 to pnlPurchMisc.ControlCount - 1 do
    begin
      if pnlPurchMisc.Controls[I] is TDBEdit then begin
      end else if pnlPurchMisc.Controls[I] is TwwDBLookupCombo then begin
        TwwDBLookupCombo(pnlPurchMisc.Controls[I]).Color := clSilver;
        TDBEdit(pnlPurchMisc.Controls[I]).Enabled := False;
      end;
    end;
    if dblcProductType.Value = 'Other Type' then
    begin
      cboSupp.Color := clWhite; // enable prefferred supplier
      cboSupp.Enabled := true;
    end;
  end
  else
  begin
    for I := 0 to pnlPurchase.ControlCount - 1 do
    begin
      if pnlPurchase.Controls[I] is TDBEdit then
      begin
        if not (dblcProductType.Value = 'Assembly') then begin
          TDBEdit(pnlPurchase.Controls[I]).Color := clWhite;
          TDBEdit(pnlPurchase.Controls[I]).Enabled := bAccessEnabled;
        end;
      end
      else if pnlPurchase.Controls[I] is TwwDBLookupCombo then
      begin
        TwwDBLookupCombo(pnlPurchase.Controls[I]).Color := clWhite;
        TDBEdit(pnlPurchase.Controls[I]).Enabled := bAccessEnabled;
      end;
    end;

    for I := 0 to pnlPurchMisc.ControlCount - 1 do
    begin
      if pnlPurchMisc.Controls[I] is TDBEdit then
      begin
      end
      else if pnlPurchMisc.Controls[I] is TwwDBLookupCombo then
      begin
        TwwDBLookupCombo(pnlPurchMisc.Controls[I]).Color := clWhite;
        TDBEdit(pnlPurchMisc.Controls[I]).Enabled := bAccessEnabled;
      end;
    end;
  end;
end;

procedure TfrmParts.dblcProductTypeCloseUp(Sender: TObject; LookupTable,  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  chkSNTracking.Enabled := qryProductPARTTYPE.asstring = 'INV';
  lblSNTracking.Enabled := chkSNTracking.Enabled;
end;

procedure TfrmParts.cboClassNameNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  NotInListWarning(Sender);
  Accept := False;
end;

procedure TfrmParts.cboPartLevel3NotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPartColumnNames') <= 3) then
  begin
    Accept := True;
    cboPartLevel3.Text :=NewValue;
    SetFocusToAccCombo(4);
  end
  else
  begin
    Accept := False;
    cboPartLevel3.Text := '';
  end;
end;

procedure TfrmParts.cboPartLevel2NotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPartColumnNames') <= 3) then
  begin
    Accept := True;
    cboPartLevel2.Text :=NewValue;
    SetFocusToAccCombo(3);
  end
  else
  begin
    Accept := False;
    cboPartLevel2.Text := '';
  end;
end;

procedure TfrmParts.cboPartLevel1NotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPartColumnNames') <= 3) then
  begin
    Accept := True;
    cboPartLevel1.Text :=NewValue;
    SetFocusToAccCombo(2);
  end
  else
  begin
    Accept := False;
    cboPartLevel1.Text := '';
  end;
end;

Function TfrmParts.SellQty_Prices:Boolean;
var
  fd:Double;
begin
  if dblcProductType.Value = 'Assembly' then begin
    Result := true;
    Exit; //Prices Calculated from Assembly Tree
  end;
  AddFlag('SellQty_Prices');
  try
    if Sysutils.SameText(tglGST.Caption,'Price (Inc)') then begin
      Result := QtyPriceValidation(qryProductSellQTY1, qryProductSellQTY2 , qryProductSellQTY3,
                          txtRetailPriceInc.Field,  txtPrice2.Field   , txtPrice3.Field, True);
      AddFlag('PriceChange');
      try
        fd:= CommonLib.Round(GetAmountEx(qryProductPRICEINC1.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
        if fd<>qryProductPRICE1.AsFloat  then qryProductPRICE1.AsFloat := fd;

        fd:= CommonLib.Round(GetAmountEx(qryProductPRICEINC2.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
        if fd <> qryProductPRICE2.AsFloat then qryProductPRICE2.AsFloat:= fd;

        fd:= CommonLib.Round(GetAmountEx(qryProductPRICEINC3.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
        if fd<> qryProductPRICE3.AsFloat  then qryProductPRICE3.AsFloat := fd;
        RoundPrice1;
        RoundPrice2;
        RoundPrice3;
      finally
        RemoveFlag('PriceChange');
      end;
    end else begin
      Result := QtyPriceValidation(qryProductSellQTY1, qryProductSellQTY2 , qryProductSellQTY3,
                          txtRetailPrice.Field,  txtPrice2.Field   , txtPrice3.Field, True);
      AddFlag('PriceIncChange');
      try
        fd:= CommonLib.Round(GetAmountInc(qryProductPRICE1.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
        if fd <> qryProductPRICEINC1.AsFloat then qryProductPRICEINC1.AsFloat := fd;

        fd:= CommonLib.Round(GetAmountInc(qryProductPRICE2.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
        if fd<>qryProductPRICEINC2.AsFloat  then qryProductPRICEINC2.AsFloat := fd;

        fd:= CommonLib.Round(GetAmountInc(qryProductPRICE3.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
        if fd <> qryProductPRICEINC3.AsFloat  then qryProductPRICEINC3.AsFloat := fd;
        RoundPrice1;
        RoundPrice2;
        RoundPrice3;
      finally
        RemoveFlag('PriceIncChange');
      end;
    end;
  finally
    RemoveFlag('SellQty_Prices');
  end;
end;









function TfrmParts.GetSalesGrandTotal(const dtStart, dtEnd: TDateTime): Double;
var
  qryTot: TERPQuery;
begin
  result := 0.0;

  qryTot := TERPQuery.Create(nil);
  try
    qryTot.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTot.ParamCheck := True;
    with qryTot do
    begin
      qryTot.Close;
      SQL.Clear;
      if not chkBaseOnShipped.Checked then
      begin
        SQL.Add('SELECT Sum(TotalLineAmountInc) as "Total" ' +
          'FROM tblSales INNER JOIN tblSalesLines Using(SaleID) ' +
          'WHERE (IsInvoice="T" OR IsCashSale="T" OR IsRefund="T" OR IsPOS="T") '+
          'And tblSales.SaleDate BETWEEN :xDateFrom AND :xDateTo ;');
      end
      else
      begin
        SQL.Add('SELECT Sum(TotalLineAmountInc) as "Total" ' +
          'FROM tblSales INNER JOIN tblSalesLines Using(SaleID) ' +
          'WHERE (IsInvoice="T" OR IsCashSale="T" OR IsRefund="T" OR IsPOS="T") '+
          'And tblSales.ShipDate BETWEEN :xDateFrom AND :xDateTo ;');
      end;
      params.ParamByName('xDateFrom').asDateTime := dtStart;
      params.ParamByName('xDateTo').asDateTime := dtEnd;
      Open;
      if not IsEmpty then
      begin
        result := FieldByName('Total').AsFloat;
      end;
    end;
  finally
    // Release our used objects.
    if Assigned(qryTot) then
      FreeandNil(qryTot);
  end;
end;


function TfrmParts.GetPurchGrandTotal(const dtStart, dtEnd: TDateTime): Double;
var
  qryTot: TERPQuery;
begin
  result := 0.0;

  qryTot := TERPQuery.Create(nil);
  try
    qryTot.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTot.ParamCheck := True;
    with qryTot do
    begin
      qryTot.Close;
      SQL.Clear;
      if not chkBasePurchOn.Checked then
      begin
        SQL.Add('SELECT Sum(TotalLineAmountInc) as "Total" ' +
          'FROM tblPurchaseOrders INNER JOIN tblPurchaseLines Using(PurchaseOrderID) ' +
          'WHERE IsPO="T" And tblPurchaseOrders.OrderDate BETWEEN :xDateFrom AND :xDateTo ;');
      end
      else
      begin
        SQL.Add('SELECT Sum(TotalLineAmountInc) as "Total" ' +
          'FROM tblPurchaseOrders INNER JOIN tblPurchaseLines Using(PurchaseOrderID) ' +
          'WHERE IsPO="T" And tblPurchaseOrders.InvoiceDate BETWEEN :xDateFrom AND :xDateTo ;');
      end;

      params.ParamByName('xDateFrom').asDateTime := dtStart;
      params.ParamByName('xDateTo').asDateTime := dtEnd;
      Open;

      if not IsEmpty then
      begin
        result := FieldByName('Total').AsFloat;
      end;
    end;
  finally
    // Release our used objects.
    if Assigned(qryTot) then
      FreeandNil(qryTot);
  end;
end;





procedure TfrmParts.cmdPrintClick(Sender: TObject);
var
  sSQL: string;
  fPrintDoc: TBusObjPrintDoc;
begin
  DisableForm;
  try
    inherited;
    if not SaveProduct then exit
    else self.BeginTransaction;
    sSQL := ' WHERE tblparts.PARTSID = ' + IntToStr(KeyID) + ' and TC.RegionId = ' + IntToStr(appenv.RegionalOptions.ID) +
            '~|||~  where PT.MasterId = ' + IntToStr(KeyID) +  ' and Mastertype = "mtProduct" ' +' order by PT.SequenceDown' +
            '~|||~  where partID = ' + IntToStr(KeyID)+ ' Order by Isdefault desc Limit 1';
    PrintTemplateReport('Product', sSQL, not AppEnv.Employee.ShowPreview, 1);
    fPrintDoc := TBusObjPrintDoc.Create(self);
    Try
      fPrintdoc.PrintDoc('Product',KeyID, dtMain , Self.Classname , PreviewToDocumentOutputType(AppEnv.Employee.ShowPreview) , 'Product');
    finally
      Freeandnil(fPrintDoc);
    end;
  finally
    EnableForm;
  end;
end;


procedure TfrmParts.qryProductAfterOpen(DataSet: TDataSet);
begin
  inherited;
  IsHireProduct := tcdatautils.IsHireProduct(qryProductPartsID.asInteger);
  ShowPricecostCalcHint;
  ProductclassPartsID:= 0;
  try
    LoadEditedFlagMemTable(qryProduct, memqryProduct);
  Except
    on E:Exception do begin
      {$IFDEF DevMode}
        MessageDlgXP_Vista(E.Message, mtWarning, [mbok],0);
      {$ENDIF}
    end;
  end;
  doSearchPartcalcformulaValidate;
  OpenQryQty;
  if qryProductClass.Active = False then qryProductClass.Open;

  InitAttachment;
  Partcalcformulatofields;
  { 12/6/2014 Dene requested ability to alter prices of "Labour" product
    so exclusion added here + product is "required" so can not be made inactive }
  if accesslevel <5 then
    if QryProductIsSystemProduct.asBoolean and (not SameText(qryProductPARTNAME.AsString, PART_LABOUR)) then begin
      AccessLevel:= 5; // read only
      MessageDlgXP_Vista(QryProductPartName.asString + ' is a system Product'+NL+NL+'Access has been changed to read-only.', mtWarning, [mbOK], 0);
    end;

  btnMakeEquipment.Enabled :=  AppEnv.CompanyPrefs.UseHire and  QryProductSNTracking.AsBoolean and  QryProductISEquipment.AsBoolean;
  fbcleanBatch        := qryProductBatch.asBoolean;
  fbCleanMultipleBins := qryProductMultipleBins.asBoolean;
  fbCleanSNTracking   := qryProductSNTracking.asBoolean;
  optSalesTaxBasedonChange(nil);
end;
Procedure TfrmParts.Partcalcformulatofields;
var
  s:STring;
begin
  s:= qryProductPartCalcformula.asString;
  s:= ReplaceStr(s , 'field1' , appenv.CompanyPrefs.PartCalcField1Name );
  s:= ReplaceStr(s , 'field2', appenv.CompanyPrefs.PartCalcField2Name);
  s:= ReplaceStr(s , 'field3', appenv.CompanyPrefs.PartCalcField3Name);
  s:= ReplaceStr(s , 'field4', appenv.CompanyPrefs.PartCalcField4Name);
  s:= ReplaceStr(s , 'field5', appenv.CompanyPrefs.PartCalcField5Name);
  if not (SameText(qryProductPartCalcformulafield.asString , s)) then begin
    EditDB(qryProduct);
    qryProductPartCalcformulafield.AsString := s;
    postDB(qryProduct);
  end;
  FormulaDetails;
end;

Procedure TfrmParts.PartcalcfieldsToformula;
var
  s:STring;
begin
  if memPartCalcformula.text <> qryProductPartCalcformulafield.asString then begin
    EditDB(QryProduct);
    qryProductPartCalcformulafield.asString:=memPartCalcformula.text;
    PostDB(QryProduct);
  end;
  s:= qryProductPartCalcformulafield.asString;
  s:= ReplaceStr(s , appenv.CompanyPrefs.PartCalcField1Name, 'Field1');
  s:= ReplaceStr(s , appenv.CompanyPrefs.PartCalcField2Name, 'Field2');
  s:= ReplaceStr(s , appenv.CompanyPrefs.PartCalcField3Name, 'Field3');
  s:= ReplaceStr(s , appenv.CompanyPrefs.PartCalcField4Name, 'Field4');
  s:= ReplaceStr(s , appenv.CompanyPrefs.PartCalcField5Name, 'Field5');
  if not (SameText(qryProductPartCalcformula.asString , s)) then begin
    EditDB(qryProduct);
    qryProductPartCalcformula.AsString := s;
    postDB(qryProduct);
  end;
  FormulaDetails;
end;

procedure TfrmParts.ProductTreeOrder;
var
  Level1: TTreeNode;
  Level2: TTreeNode;
  Level3: TTreeNode;
begin
    if not Empty(cboPartLevel1.Text) then begin
      cboPartLevel2.Enabled := bAccessEnabled;
      cboPartLevel3.Enabled := False;
    end else begin
      cboPartLevel2.text := '';
      cboPartLevel2.Enabled := False;
    end;

    if not Empty(cboPartLevel2.Text) and not Empty(cboPartLevel1.Text) then begin
      cboPartLevel3.Enabled := bAccessEnabled;
    end else begin
      cboPartLevel3.text := '';
      cboPartLevel3.Enabled := False;
    end;

  PartTreeView.Items.Clear;
  if Empty(cboPartLevel1.Text) then begin
    PartTreeView.Items.Add(nil, edtPart.Text);
  end else if Empty(cboPartLevel2.Text) then begin
    Level1 := PartTreeView.Items.Add(nil, cboPartLevel1.Text);
    PartTreeView.Items.AddChild(Level1, edtPart.Text);
  end else if Empty(cboPartLevel3.Text) then  begin
    Level1 := PartTreeView.Items.Add(nil, cboPartLevel1.Text);
    Level2 := PartTreeView.Items.AddChild(Level1, cboPartLevel2.Text);
    PartTreeView.Items.AddChild(Level2, edtPart.Text);
  end  else  begin
    Level1 := PartTreeView.Items.Add(nil, cboPartLevel1.Text);
    Level2 := PartTreeView.Items.AddChild(Level1, cboPartLevel2.Text);
    Level3 := PartTreeView.Items.AddChild(Level2, cboPartLevel3.Text);
    PartTreeView.Items.AddChild(Level3, edtPart.Text);
  end;

  PartTreeView.FullExpand;
  Update;
end;

procedure TfrmParts.QryAlternateProductsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  initgrdAlternateProducts;

end;

procedure TfrmParts.QryAlternateProductsAlternateProductNameChange(
  Sender: TField);
begin
  inherited;
  if QryAlternateProductsAlternateProductName.asString =   QryAlternateProductsProductName.asString  then begin
    QryAlternateProducts.cancel;
    Exit;
  end;
  QryAlternateProductsAlternateProductId.asInteger := getProduct(QryAlternateProductsAlternateProductName.asString);
  if QryAlternateProductsAlternateProductId.asInteger =0 then exit;
end;

procedure TfrmParts.QryAlternateProductsBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if QryProductPartsId.asInteger =0 then begin
    MessageDlgXP_Vista('Please Provide the Product Details Before Creating Alternate Products', mtInformation, [mbOK], 0);
    Abort;
    Exit;
  end;
end;

procedure TfrmParts.QryAlternateProductsBeforePost(DataSet: TDataSet);
begin
  inherited;
  AlternateProductsIsDefaultChanging:= TRue;
  Try
    if QryAlternateProducts.recordcount =0 then QryAlternateProductsISDefault.asBoolean := true;
  Finally
    AlternateProductsIsDefaultChanging:= False;
  End;
  if (QryAlternateProductsAlternateProductId.asInteger =0) then begin
    QryAlternateProducts.Cancel;
    abort;
  end;
end;

procedure TfrmParts.QryAlternateProductsIsDefaultChange(Sender: TField);
var
  fID:Integer;
begin
  inherited;
  if AlternateProductsIsDefaultChanging then exit;
  AlternateProductsIsDefaultChanging:= TRue;
  Try
    if QryAlternateProductsisDefault.asBoolean then begin
      postDB(QryAlternateProducts);
      fID:= QryAlternateProductsID.asInteger;
      QryAlternateProducts.first;
      While QryAlternateProducts.eof = False do begin
        if (QryAlternateProductsID.asInteger <> fid) and (QryAlternateProductsIsDefault.asBoolean ) then begin
          EditDB(QryAlternateProducts);
          QryAlternateProductsIsDefault.asBoolean := False;
          PostDB(QryAlternateProducts);
        end;
        QryAlternateProducts.Next;
      end;
    end;
  Finally
    AlternateProductsIsDefaultChanging:= False;
  End;
end;

procedure TfrmParts.PartTreeViewClick(Sender: TObject);
begin
  inherited;
  PartTreeView.FullExpand;
end;

procedure TfrmParts.edtAttrib1PurchaseExit(Sender: TObject);
begin
  inherited;
  if (qryProduct.FieldByName('Cost1').AsVariant <> 0) and (qryProduct.FieldByName('Attrib1Purchase').AsVariant <> 0) then
  begin;
    EditDB(QryProduct);
    qryProduct.FieldByName('Attrib1PurchaseRate').AsVariant :=
      DivZer(qryProduct.FieldByName('Cost1').AsVariant, qryProduct.FieldByName('Attrib1Purchase').AsVariant);
  end;
end;

procedure TfrmParts.txtCostExit(Sender: TObject);
begin
  inherited;
  if (qryProduct.FieldByName('Cost1').AsVariant <> 0) and (qryProduct.FieldByName('Attrib1Purchase').AsVariant <> 0) then
  begin;
    EditDB(QryProduct);
    qryProduct.FieldByName('Attrib1PurchaseRate').asFloat :=
      DivZer(qryProduct.FieldByName('Cost1').asFloat, qryProduct.FieldByName('Attrib1Purchase').asFloat);
  end;
  CostPriceMarkupCalc(qryProductcostinc1);
end;

procedure TfrmParts.edtAttrib1SaleExit(Sender: TObject);
begin
  inherited;
  if (qryProduct.FieldByName('Price1').AsVariant <> 0) and (qryProduct.FieldByName('Attrib1Sale').AsVariant <> 0) then
  begin;
    EditDB(QryProduct);
    qryProduct.FieldByName('Attrib1SaleRate').asFloat :=
      DivZer(qryProduct.FieldByName('Price1').asFloat, qryProduct.FieldByName('Attrib1Sale').asFloat);
  end;
end;

procedure TfrmParts.edtAttrib2PurchaseExit(Sender: TObject);
begin
  inherited;
    EditDB(QryProduct);
  qryProduct.FieldByName('Attrib2Sale').asFloat := qryProduct.FieldByName('Attrib2Purchase').asFloat;
end;

procedure TfrmParts.edtAttrib2SaleExit(Sender: TObject);
begin
  inherited;
    EditDB(QryProduct);
  qryProduct.FieldByName('Attrib2Purchase').asFloat := qryProduct.FieldByName('Attrib2Sale').asFloat;
end;

procedure TfrmParts.edtLandedCostDblClick(Sender: TObject);
begin
  inherited;
  //ShowtotalLandedcost := not (ShowtotalLandedcost);
  pageControl.ActivePage := TabProductMovement;
  if pageControl.ActivePage = TabProductMovement then
  begin
    PageMovements.ActivePage := tabLatestCost;
    PageMovementsChange(tabLatestCost);
  end;
end;

procedure TfrmParts.edtLatestCostDblClick(Sender: TObject);
begin
  inherited;
  pageControl.ActivePage := TabProductMovement;
  if pageControl.ActivePage = TabProductMovement then begin
    PageMovements.ActivePage := tabLatestCost;
    PageMovementsChange(PageMovements);
  end;

end;

procedure TfrmParts.qrySellPricesAllClientsChange(Sender: TField);
begin
  inherited;
  if qrySellPricesAllClients.AsString = 'T' then
  begin
    cboClientType.Enabled := False;
  end
  else
  begin
    cboClientType.Enabled := True;
  end;
end;

procedure TfrmParts.grdSellPricesRowChanged(Sender: TObject);
begin
  inherited;
  if qrySellPricesAllClients.AsString = 'T' then
  begin
    cboClientType.Enabled := False;
  end
  else
  begin
    cboClientType.Enabled := True;
  end;
end;

procedure TfrmParts.grdSellPricesEnter(Sender: TObject);
begin
  inherited;
  if qrySellPricesAllClients.AsString = 'T' then
  begin
    cboClientType.Enabled := False;
  end
  else
  begin
    cboClientType.Enabled := True;
  end;
  if sender is TwwDBGrid then AddnewIfEmpty( TwwDBGrid(Sender).Datasource.Dataset);
end;

procedure TfrmParts.OpenUnitsOfMeasureQtys(const ClassID: Integer);
begin
  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
  if (csDestroying in Self.ComponentState) then Exit;
  if bOnSave then Exit; //Slow Save Bug
  with qryUnitsOfMeasureQtys do
  begin
    if Active then Close;
    ParamByName('xPartsID').asInteger := KeyID;
    ParamByName('xClassID').asInteger := ClassID;
    Open;
  end;
end;

function TfrmParts.GetAutoBarcode: string;
begin
    result := tcdatautils.GetAutoBarcode(myconnection);
(*var
  qry: TERPQuery;
  //s:String;
  fimaxlen :Integer;
begin
  result := '';
  try
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try

      Closedb(qry); qry.SQL.Clear;
      qry.SQL.adD('Select max(length(barcode)) maxlen from  tblparts where  length(barcode)<=15');
      opendb(qry);
      if qry.fieldbyname('maxlen').asInteger =0 then Exit;
      fimaxlen := qry.FieldByName('maxlen').asinteger;
      Closedb(qry); qry.SQL.Clear;
      qry.SQL.Add('SELECT');
      qry.SQL.Add('MAX(Truncate(P.Barcode, 0))  AS aBarcode, ');
      qry.SQL.Add('MAX(Truncate(P.Barcode, 0)) + 1 AS Barcode');
      qry.SQL.Add('FROM tblparts P');
      qry.SQL.Add('where isinteger(barcode)    and  length(barcode) = ' + inttostr(fimaxlen));
      Opendb(qry);
      result := qry.FieldByName('Barcode').AsString;

     // Binny (TODO) check if the number already exists - as this can make a 16 digit barcode  - dene doesn't want to spend more time on it  at the moemnt

    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  finally
    if result = '' then result := '1';
  end;*)
end;


function TfrmParts.GetKeyString: string;
begin
  if self.qryProduct.Active then
    result:= self.qryProductProductprintname.AsString
  else
    result:= '';
end;

procedure TfrmParts.chkShowProductPopUpClick(Sender: TObject);
begin
  inherited;
    Label39.Enabled := chkShowProductPopUp.Checked;
    PopupMemo.Enabled := chkShowProductPopUp.Checked;
end;

procedure TfrmParts.chkShowPurchaseProductPopUpClick(Sender: TObject);
begin
  inherited;
  Label24.Enabled := chkShowPurchaseProductPopUp.Checked;
  PopupPOMemo.Enabled := chkShowPurchaseProductPopUp.Checked;
end;

procedure TfrmParts.chkshowTransactionhistoryClick(Sender: TObject);
begin
  inherited;
  if isformshown then begin
    pnlProductQtycheck.Visible := chkshowTransactionhistory.Checked;
    splshowTransactionhistory.Visible := chkshowTransactionhistory.Checked;
    splshowTransactionhistory.top := 0;
  end;
end;

function TfrmParts.PreSaveProduct: Boolean;
begin
  result := False;
  try
    try
      Processingcursor(True);
      SaveButtonClicked := 1;
      fsPartName := edtPart.Text;
      if not BuyQty_Prices  then Exit;
      if not SellQty_Prices then Exit;

      if  Empty(edtPart.Text) then begin
         MessageDlgXP_Vista('Product Name cannot be blank.', mtWarning, [mbOK], 0);
         pageControl.ActivePage := TTabSheet(Main);
         Setcontrolfocus(edtProductPrintName);
         result := False;
         Exit;
      end;
      if not ProductNameUnique() then begin
          MessageDlgXP_Vista('Product with this name already exists. Product name cannot be duplicate.', mtWarning, [mbOK], 0);
          pageControl.ActivePage := TTabSheet(Main);
          Setcontrolfocus(edtProductPrintName);
          result := False;
          Exit;
      end;
      if  Empty(dblcProductType.Value) then begin
        MessageDlgXP_Vista('Product Type cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        SetControlFocus(dblcProductType);
        result := False;
        Exit;
      end;
      if  Empty(cboCOGSACC.LookupValue) then begin
        MessageDlgXP_Vista('Product COGS Account cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        SetControlFocus(cboCOGSACC);
        result := False;
        Exit;
      end;
      if  Empty(cboINCOMEACC.LookupValue) then begin
        MessageDlgXP_Vista('Product Income Account cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        SetControlFocus(cboINCOMEACC);
        result := False;
        Exit;
      end;
      if Empty(cboASSETACC.LookupValue) then begin
        MessageDlgXP_Vista('Product Asset Account cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        SetControlFocus(cboASSETACC);
        result := False;
        Exit;
      end;
      if Empty(cboTaxCode.LookupValue) then begin
        MessageDlgXP_Vista('Product Sales Tax Code cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        SetControlFocus(cboTaxCode);
        result := False;
        Exit;
      end;
      if Empty(cboPURTaxCode.LookupValue) then begin
        MessageDlgXP_Vista('Product Purchase Tax Code cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        SetControlFocus(cboPURTaxCode);
        result := False;
        Exit;
      end;
      if Empty(txtRetailPrice.Text) then begin
        MessageDlgXP_Vista('Product Retail Price cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        SetControlFocus(txtRetailPrice);
        result := False;
        Exit;
      end;
      PostDB(qrywalmartitems);
      EditDB(QryProduct);
      qryProduct.FieldByName('PRODUCTGROUP').AsString := ProductGroupJoin;
      if (qryProductEditedFlag.AsString = 'T') then qryProductDateUpdated.AsDateTime := Now;
      PostDB(QryProduct);
      bNewPart := False;
      KeyID := qryProductPARTSID.AsInteger;
      PrepareQueries;
      FormShow(self);
      pageControl.ActivePage := TTabSheet(Main);
      EditDB(QryProduct);
      Result := True;
    finally
      Processingcursor(False);
    end;
  except
    on EAbort do
      HandleEAbortException;
    on e: Exception do
      raise;
  end;
end;

procedure TfrmParts.cboProductsRelatedAfterchange(Sender: TObject);
begin
  inherited;
  if not CheckRelatedProduct(cboProductQry.FieldByName('PartsID').AsInteger, qryProductPARTSID.AsInteger) then
  begin
    cboProductsRelated.Text := '';
    qryRelatedParts.Cancel;
    MessageDlgXP_Vista('You Cannot Assign this Product as a Related Part, ' + #10#13 +
      'it would Create a Circular Reference', mtWarning, [mbOK], 0);
    exit;
  end;

  if qryRelatedParts.State <> dsBrowse then
    qryRelatedParts.Post;

  qryRelatedParts.Edit;
  qryRelatedPartsProductID.AsInteger := cboProductQry.FieldByName('PartsID').AsInteger;
  qryRelatedPartsQty.AsInteger := 1;
  qryRelatedParts.Post;
  qryRelatedParts.Edit;
end;


procedure TfrmParts.qryRelatedPartsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if Appenv.companyprefs.SortRelatedProductsinSale then
    qryRelatedParts.indexfieldnames := 'ISContainer DESC CIS';
end;

procedure TfrmParts.qryRelatedPartsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (qryRelatedPartsPartName.AsString <> '') and (qryRelatedPartsProductID.AsInteger =0) then begin
    qryRelatedPartsProductID.AsInteger := GetProduct(qryRelatedPartsPartName.AsString );
    if qryRelatedPartsQty.AsInteger =0 then
      qryRelatedPartsQty.AsInteger := 1;
  end;
  if qryRelatedPartsISContainer.asBoolean then
    if HasContainer(qryRelatedPartsRelatedID.asInteger) then
      qryRelatedPartsISContainer.AsBoolean := False;

  if qryRelatedPartsISPallet.asBoolean then
    if HasPallet(qryRelatedPartsRelatedID.asInteger) then
      qryRelatedPartsISPallet.AsBoolean := False;

end;

procedure TfrmParts.RealtedPartsIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryRelatedParts);
  if qryRelatedParts.RecordCount > 0 then
  begin
    qryRelatedParts.Edit;
  end else begin
    qryRelatedParts.Insert;
  end;
  FlagAsUpdated(self.qryProduct);
end;

procedure TfrmParts.grdRelatedPartsExit(Sender: TObject);
begin
  inherited;
  if qryRelatedParts.Active and (qryRelatedParts.State <> dsBrowse) and (qryRelatedParts.RecordCount > 0) then
  begin
    qryRelatedParts.Post;
  end;
end;

procedure TfrmParts.grdForeignIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryForeignPrice);
end;

procedure TfrmParts.qryForeignPriceBeforePost(DataSet: TDataSet);
begin
  inherited;

  if Dataset.FieldByname('Price1').AsCurrency = 0 then
    Dataset.FieldByname('Price1').AsCurrency := 0;
end;

procedure TfrmParts.qryForeignPriceClientIDChange(Sender: TField);
begin
  inherited;
  PostDB(qryForeignPrice);
  EditDB(qryForeignPrice);
end;

procedure TfrmParts.tglCostClick(Sender: TObject);
begin
  if bFinishedOnShow then Begin
    MessageDlgXP_Vista('If a price (as Ex) is entered manually then it must include four(4) decimal places or be entered as ''Inc'' for auto-calculation', mtInformation, [mbOK], 0);
  end;
  inherited;
  CostExMode := not(CostExMode);
end;

procedure TfrmParts.cboAreaNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
// prevents generic not-in-list processing
begin
  inherited;
  Accept := true;
end;

procedure TfrmParts.cboASSETACCEnter(Sender: TObject);
begin
  inherited;
  SaveAccessLevel := AccessLevel;
  AccessLevel := 1;
end;

procedure TfrmParts.cboASSETACCExit(Sender: TObject);
begin
  inherited;
  AccessLevel := SaveAccessLevel;
end;

procedure TfrmParts.txtBarcodeExit(Sender: TObject);
var
  sProductName :String;
begin
  inherited;
  if txtBarcode.Text = '' then
    exit;
  try
    sProductName := TProduct.ProductNameForBarcode(txtBarcode.Text);
    if sProductName = '' then begin
    end;
    if (sProductName = qryProductPARTname.asString) or (sProductName = '') then begin
      if not ProductBarcodeList.Lines.Locate('BarCode',txtBarcode.Text,[]) then begin
        { add new barcode }
        ProductBarcodeList.Lines.Dataset.Append;
        ProductBarcodeList.Lines.ProductID:= qryProductPartsID.AsInteger;
        ProductBarcodeList.Lines.BarCode:= txtBarcode.Text;
        ProductBarcodeList.Lines.PostDb;
      end;
      { make primary }
      ProductBarcodeList.PrimaryBarcode:= txtBarcode.Text;
    end
    else begin
      { exists for a different product }
      MessageDlgXP_Vista('This barcode has already been used with PART Name => ' + sProductNAme + #13 + #10 + #13 + #10 +
          'Please select a different barcode to use.', mtInformation, [mbOK], 0);
      txtBarcode.Text := '';
      qryProductbarcode.asString := '';
      txtBarcode.SetFocus;
    end;
  finally
    PostDB(qryProduct);
    EditDB(qryProduct);
  end;
end;
Procedure TfrmParts.ValidatedisPercent(const ShowMessge:Boolean = true);
var
  Msg   :String;
  Discount:double;
  ESPrice :Double;
begin
  if fbValidatingdisPercent then exit;
  fbValidatingdisPercent:= True;
  try
    qrySellPrices.DisableControls;
    try
      Msg := '';
      Discount :=qrySellPricesQtyPercent1.AsFloat ;
      ESPrice := CommonLib.Round((1 - DivZer(Discount, 100)) * qryProductPRICE1.AsFloat , tcConst.GeneralRoundPlaces);
      TProductExtraSellPrice.ValidatediscountnCalcPrice(Discount,Msg);
      EditDb(qrySellPrices);
      if not(SameValue(qrySellPricesQtyPercent1.AsFloat,Discount)) then qrySellPricesQtyPercent1.AsFloat  := Discount;
      if not(SameValue(qrySellPricesPrice1.AsFloat,ESPrice))       then qrySellPricesPrice1.AsFloat := ESPrice;

      PostDB(qrySellPrices);
      if Msg <> '' then
        if ShowMessge or devmode  then
          MessageDlgXP_Vista(Msg, mtInformation, [mbOK], 0)
    finally
      qrySellPrices.EnableControls;
    end;
  finally
    fbValidatingdisPercent  := False;
  end;

end;
Procedure TfrmParts.UpdateExtraSellprice;
begin
  if bUpdatingSellPrice then
      exit;
    if not bIsChangingPercent then
    begin // Prevents Recursion
      Application.Processmessages;
      bIsChangingPercent := true;
      ValidatedisPercent;
      focusUOMPrice1;
      bIsChangingPercent := False;
    end;
end;
procedure TfrmParts.qrySellPricesQtyPercent1Change(Sender: TField);
begin


  if ispricechanging then exit;
  ispricechanging := true;
  try
    qrySellPricesQtyPercent1.AsFloat := Round(qrySellPricesQtyPercent1.AsFloat, GeneralRoundPlaces);
    PostDB(qrySellPrices);
    inherited;

    updateExtraSellPrice;
  finally
      ispricechanging:= False;
  end;
end;


procedure TfrmParts.qrySellPricesPrice1Change(Sender: TField);
begin
  if ispricechanging then exit;
  ispricechanging := true;
  try
    inherited;
    if Empty(Sender.AsString) then
    begin
      if uppercase(Sender.FieldName) = 'PRICE1' then
      begin
        Sender.AsFloat := qryProductPRICE1.AsFloat;
      end;
    end;

    if not bIsChangingPrices then
    begin // prevents recursion
      bIsChangingPrices := true;
      EditDB(qrySellPrices);
      qrySellPricesQtyPercent1.AsFloat := Round((DivZer(qrySellPricesPrice1.AsFloat, qryProductPRICE1.AsFloat) - 1) * -100, GeneralRoundPlaces);
      ValidatedisPercent;
      EditDB(qrySellPrices);
      qrySellPricesuomPrice1.asFloat := Round(qrySellPricesUOMMultiplier.asFloat * qrySellPricesPrice1.asFloat, GeneralRoundPlaces);
      PostDB(qrySellPrices);
      EditDB(qrySellPrices);
      focusUOMPrice1;
      bIsChangingPrices := False;
    end;
  finally
      ispricechanging:= False;
  end;
end;

procedure TfrmParts.ResetVariantPrice;
var
  bm: TBookmark;
begin
  if QryProductclass.Active = false then begin
    LoadQryQty(KeyID);
    QryProductclass.Active := True;
  end;
  bm := QryProductclass.GetBookmark;
  QryProductclass.DisableControls;
  QryProductclass.first;
  while not QryProductclass.EOF do begin
      QryProductclassClassPriceVarianceChange(nil);
      QryProductclass.Next;
  End;
  QryProductclass.EnableControls;
  QryProductclass.GotoBookmark(bm);
  QryProductclass.FreeBookmark(bm);

end;

procedure TfrmParts.ResetExtraSellPrice;
var
  bm: TBookmark;
  oldispricechanging :Boolean;
begin
  if qrySellPrices.recordcount =0 then exit;
  oldispricechanging := ispricechanging;
  ispricechanging:= true;
  try

    if not FormStillOpen('TfrmParts') then exit;

    qrySellPrices.Active := True;
    with qrySellPrices do    begin
      bm := GetBookmark;
      try
        DisableControls;
      first;
      showProgressbar('Recalculating Extra sell price discount' , recordcount);
      try
        while not EOF do    begin
          UpdateExtraSellprice;
          Next;
          StepProgressbar;
        end;
      finally
        HideProgressbar;
        Application.Processmessages;
      end;
      GotoBookmark(bm);
      finally
        EnableControls;
        FreeBookmark(bm);
      end;
    end;
  finally
    ispricechanging := oldispricechanging;
  end;
end;

procedure TfrmParts.grdForeignSellIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryForeignPriceSell);
end;

procedure TfrmParts.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  pageControlChange(nil);
end;

procedure TfrmParts.txtCostPriceIncExit(Sender: TObject);
begin
  inherited;
  //
end;
Function TfrmParts.QtyPriceValidation(Qty1,Qty2,Qty3, Price1, Price2, Price3:TField; IsSale :Boolean= False):Boolean;
var
    strMsg :String;
    isPrice :Boolean;
    function GetMsg(Const Bigfield, Smallfield:String; Const BigValue, SmallValue :Double):String;
    var
        volumestr:String;
    begin
        if isPrice then begin
            if IsSale then volumestr := 'Volume Sell Price#' else volumestr := 'Volume Buy Cost#'
        end else if IsSale then
             volumestr := 'Volume Sell Qty #' else volumestr := 'Volume Buy Qty #';

        Result :=   volumestr +Bigfield   + ' (' + FloattoStr(Bigvalue)  +')';
        if BigValue > SmallValue then Result:= result +' can''t be greater than  ' + chr(13)
                                 else Result:= result +' can''t be less than  ' + chr(13);
        Result:= result +volumestr +Smallfield + ' (' + FloattoStr(Smallvalue)+').' + chr(13)+ chr(13);

        if isPrice and (Bigfield ='1') then
              if (pageControl.ActivePage = TTabSheet(NewManufacture)) then begin
                Result := Result +'Changing the ''BOM'' will recalculate the ''Markup''/''Gross Margin'' based on the New ';
                if IsSale then result:= result +'Price' else result:= result +'Cost';
                result:= result +' from the tree' +chr(13)+chr(13);
              end else if IsSale then
                  Result := Result +'This will recalculate the ''Markup''/''Gross Margin'' based on the New Price.' +chr(13)+chr(13)
              else if (BigValue > SmallValue) and (qryproductOnCostIncrease.AsBoolean) then
                  Result := Result +'This will recalculate the Price based on the New Cost and ''Markup''/''Gross Margin''.' +chr(13)+chr(13)
              else if (BigValue > SmallValue) and (qryproductOnCostIncrease.AsBoolean=False) then
                  Result := Result +'This will recalculate the ''Markup''/''Gross Margin'' based on the New Cost.' +chr(13)+chr(13)
              else if (BigValue < SmallValue) and (qryproductOnCostDecrease.AsBoolean) then
                  Result := Result +'This will recalculate the Price based on the New Cost and ''Markup''/''Gross Margin''.' +chr(13)+chr(13)
              else if (BigValue > SmallValue) and (qryproductOnCostDecrease.AsBoolean=False) then
                  Result := Result +'This will recalculate the ''Markup''/''Gross Margin'' based on the New Cost.' +chr(13)+chr(13)
              else
                Result := Result +'This will recalculate the ''Markup''/''Gross Margin'' based on the New Cost.' +chr(13)+chr(13);

        Result:= result +'Do you wish to auto correct?'
    end;
begin
    Result := False;
    if inQtyPriceValidation then begin
        Result := True;
        exit;
    end;

    inQtyPriceValidation := true;
    try
        EditDB(QryProduct);
        if Qty1.asFloat <> Round(QTY1.asFloat,5) then
            Qty1.asFloat := Round(QTY1.asFloat,5);
        if Qty2.asFloat <> Round(QTY2.asFloat,5) then
            Qty2.asFloat := Round(QTY2.asFloat,5);
        if Qty3.asFloat <> Round(QTY3.asFloat,5) then
            Qty3.asFloat := Round(QTY3.asFloat,5);
        if Price1.asFloat <> Round(Price1.asFloat,5) then
            Price1.asFloat := Round(Price1.asFloat,5);
        if Price2.asFloat <> Round(Price2.asFloat,5) then
            Price2.asFloat := Round(Price2.asFloat,5);
        if Price3.asFloat <> Round(Price3.asFloat,5) then
            Price3.asFloat := Round(Price3.asFloat,5);

        isPrice := False;
        if Qty2.AsFloat < qty1.AsFloat      then begin
            strMsg := GetMsg('1' , '2' , qty1.AsFloat, qty2.AsFloat);
            if Flags.InList(AutoPriceFlag) or (MessageDlgXP_Vista(strMsg , mtWarning, [mbYes, mbNo], 0) = mrYes) then
                 Qty2.AsFloat := Qty1.AsFloat
            else Exit;
        end;
        if Qty3.AsFloat < Qty2.AsFloat      then begin
            strMsg := GetMsg('2' , '3', qty2.AsFloat , qty3.AsFloat);
            if Flags.InList(AutoPriceFlag) or (MessageDlgXP_Vista(strMsg , mtWarning, [mbYes, mbNo], 0) = mrYes) then
                 Qty3.AsFloat := Qty2.AsFloat
            else Exit;
        end;

        isPrice := True;
        if Price1.AsFloat < Price2.AsFloat  then begin
            strMsg := GetMsg('1' , '2', Price1.AsFloat , Price2.AsFloat);
            if Flags.InList(AutoPriceFlag) or (MessageDlgXP_Vista(strMsg , mtWarning, [mbYes, mbNo], 0) = mrYes) then
                 Price2.AsFloat := Price1.AsFloat
            else Exit;
        end;
        if Price2.AsFloat < Price3.AsFloat  then begin
            strMsg := GetMsg('2' , '3', Price2.AsFloat , Price3.AsFloat);
            if Flags.InList(AutoPriceFlag) or (MessageDlgXP_Vista(strMsg , mtWarning, [mbYes, mbNo], 0) = mrYes) then
                 Price3.AsFloat := Price2.AsFloat
            else Exit;
        end;

        if (Qty2.AsFloat = qty1.AsFloat)    and (price1.AsFloat <> price2.AsFloat)  then begin
            strMsg := GetMsg('1' , '2', price1.AsFloat , price2.AsFloat);
            if Flags.InList(AutoPriceFlag) or (MessageDlgXP_Vista(strMsg , mtWarning, [mbYes, mbNo], 0) = mrYes) then
                 Price2.AsFloat := price1.AsFloat
            else Exit;
        end;
        if (Qty3.AsFloat = qty2.AsFloat)    and  (price2.AsFloat <> price3.AsFloat) then begin
            strMsg := GetMsg('2' , '3' , price2.AsFloat, price3.AsFloat);
            if Flags.InList(AutoPriceFlag) or (MessageDlgXP_Vista(strMsg , mtWarning, [mbYes, mbNo], 0) = mrYes) then
                 Price3.AsFloat := price2.AsFloat
            else Exit;
        end;

        REsult := True;
    Finally
        inQtyPriceValidation := False;
    end;
end;

function TfrmParts.BuyQty_Prices:Boolean;
var
  fd:double;
begin
  if dblcProductType.Value = 'Assembly' then begin
    Result := true;
    Exit; //Prices Calculated from Assembly Tree
  end;
  if Sysutils.SameText(tglCost.Caption , 'Cost (Inc)') then begin
    Result := QtyPriceValidation(qryProductBuyQTY1, qryProductBuyQTY2 , qryProductBuyQTY3 ,
                        txtCostPriceInc.Field,  txtCost2.Field   , txtCost3.Field);
      AddFlag('costIncChange');
      fd:= CommonLib.Round(GetAmountex(qryProductcostinc1.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
      if fd<> qryProductcost1.AsFloat then qryProductcost1.AsFloat:= fd;

      fd:= CommonLib.Round(GetAmountex(qryProductcostinc2.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
      if fd <> qryProductcost2.AsFloat then qryProductcost2.AsFloat := fd;

      fd:= CommonLib.Round(GetAmountex(qryProductcostinc3.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
      if fd<> qryProductcost3.AsFloat then qryProductcost3.AsFloat:= fd;

      RemoveFlag('costIncChange');
  end else begin
    Result := QtyPriceValidation(qryProductBuyQTY1, qryProductBuyQTY2 , qryProductBuyQTY3 ,
                        txtCost.Field,  txtCost2.Field   , txtCost3.Field);
      AddFlag('costIncChange');
      fd:= CommonLib.Round(GetAmountInc(qryProductcost1.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
      if fd<>qryProductcostINC1.AsFloat then qryProductcostINC1.AsFloat := fd;

      fd := CommonLib.Round(GetAmountInc(qryProductcost2.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
      if fd <>qryProductcostINC2.AsFloat then qryProductcostINC2.AsFloat:= fd;

      fd:= CommonLib.Round(GetAmountInc(qryProductcost3.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
      if fd<> qryProductcostINC3.AsFloat then qryProductcostINC3.AsFloat := fd;
      RemoveFlag('costIncChange');
  end;
end;


procedure TfrmParts.cboPartLevel1Enter(Sender: TObject);
var
  Temp: string;
begin
  inherited;
  Temp := cboPartLevel1.Text;
  qryProductLevel1.Open;
  cboPartLevel1.Text := Temp;
  cboPartLevel1.PerformSearch;
end;

procedure TfrmParts.cboPartLevel2Enter(Sender: TObject);
var
  Temp: string;
begin
  inherited;
  Temp := cboPartLevel2.Text;
  qryProductLevel2.Open;
  cboPartLevel2.Text := Temp;
  cboPartLevel2.PerformSearch;
end;

procedure TfrmParts.cboPartLevel3Enter(Sender: TObject);
var
  Temp: string;
begin
  inherited;
  Temp := cboPartLevel3.Text;
  qryProductLevel3.Open;
  cboPartLevel3.Text := Temp;
  cboPartLevel3.PerformSearch;
end;

procedure TfrmParts.qryProductActiveChange(Sender: TField);
begin
  inherited;
  // checks table to ensure there are nno outstanding quanities on this product
  // .. prior to making inactive. ( we cannot simply use SUM(...) in SQL cuz
  // .. -ve and +ve anounts may cancel each other ).
  if qryProductActive.AsBoolean then Exit;
  if qryProductPARTTYPE.asString <> 'INV' then exit;
  QryProductQtys.DisableControls;
  try
      QryProductQtys.filter := ' (InstockQty <> 0) OR  (SOQty <> 0)  OR (AllocatedBOQty <> 0)  OR (POBOQty <> 0) OR (SOBOQty <> 0)';
      QryProductQtys.Filtered := True;
      if QryProductQtys.recordcount > 0 then begin
        EditDB(QryProduct);
        qryProductActive.AsBoolean := True;
        MessageDlgXP_Vista('This Product Can''t Be Made Inactive' + #13#10#13#10 +
                  'There Is Stock or Transactions Outstanding !', mtWarning, [mbOK], 0);
      End;
  finally
    QryProductQtys.Filtered :=False;
    QryProductQtys.filter := '';
    QryProductQtys.Enablecontrols;
  end;
end;

procedure TfrmParts.cboManfProductQryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cboManfProductQry.IndexFieldNames := QuotedStr('PARTNAME') + ' ASC CIS';
end;

procedure TfrmParts.cboClientLookupAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cboClientLookup.IndexFieldNames := QuotedStr('Company') + ' ASC CIS';
end;

procedure TfrmParts.cboProductQryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cboProductQry.IndexFieldNames := QuotedStr('PARTNAME') + ' ASC CIS';
end;

procedure TfrmParts.qryProductLevel1AfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryProductLevel1.IndexFieldNames := QuotedStr('PartLevel1') + ' ASC CIS';
end;

procedure TfrmParts.qryProductLevel2AfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryProductLevel2.IndexFieldNames := QuotedStr('PartLevel2') + ' ASC CIS';
end;

procedure TfrmParts.qryProductLevel3AfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryProductLevel3.IndexFieldNames := QuotedStr('PartLevel3') + ' ASC CIS';
end;

procedure TfrmParts.qryProductNormalDeliveryTimeSetText(Sender: TField;
  const Text: string);
begin
  inherited;
  try
    if trim(text)='' then begin
      EditDB(QryProduct);
      TFloatField(Sender).asfloat := 0;
    end else begin
      EditDB(QryProduct);
      try
        TFloatField(Sender).asfloat := strTofloat(trim(text));
      Except
        //
      end;
    end;
  except
  end;
end;

procedure TfrmParts.cboPartCalcformulaUOMCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  EditDB(qryProduct);
  QryProductPartCalcformulaUOM.AsString     := QryPartCalcformulaUOMUnitName.AsString;
  QryProductPartCalcformulaUOMID.AsInteger  := QryPartCalcformulaUOMUnitID.AsInteger;
  QryProductPartCalcformulaUOMMult.AsFloat  := QryPartCalcformulaUOMMultiplier.AsFloat;
end;

procedure TfrmParts.cboPartLevel1CloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  ProductTreeOrder;
  SetFocusToAccCombo(2);
end;

procedure TfrmParts.cboPartLevelDblClick(Sender: TObject);
var
  form: TBaseInputGUI;
  formID: integer;
begin
  if Trim(TwwDbLookupCombo(Sender).Text) <> '' then begin
    formId:= TProductGroup.IDToggle(Trim(TwwDbLookupCombo(Sender).Text),MyConnection);
    if formId < 1 then exit;

    form := TBaseInputGUI(GetComponentByClassName('TfmProductGroupEdit'));
    if Assigned(Form) then begin
      form.KeyID:= formId;
      form.FormStyle := fsMDIChild;
      form.BringToFront;
    end;
  end;
end;

procedure TfrmParts.cboPartLevel2CloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  ProductTreeOrder;

  SetFocusToAccCombo(3);
end;

procedure TfrmParts.cboPartLevel3CloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  ProductTreeOrder;

  SetFocusToAccCombo(4);
end;

procedure TfrmParts.SetComboFocus(var Message: TMessage);
begin
  case Message.wParam of
    1: if (cboPartLevel2.Visible) and (cboPartLevel2.Enabled) then
        SetControlFocus(cboPartLevel2);
    2: if (cboPartLevel3.Visible) and (cboPartLevel3.Enabled) then
        SetControlFocus(cboPartLevel3);
    3: if (edtPart.Visible) and (edtPart.Enabled) then
        Setcontrolfocus(edtProductPrintName);
  end;
end;

procedure TfrmParts.SetCostExMode(const Value: Boolean);
begin
  fbCostExMode := value;
  if Value then begin
    tglCost.Caption:= doTRanslate('Cost (Ex)');
    txtCost2.DataField := 'COST2';
    txtCost3.DataField := 'COST3';
    tglCost.hint := 'Enter Cost Excluding Tax.' + NL +'Click to Enter Cost Including Tax'+NL;
  end  else begin
    tglCost.Caption:= DoTRanslate('Cost (Inc)');
    txtCost2.DataField := 'COSTINC2';
    txtCost3.DataField := 'COSTINC3';
    tglCost.hint := 'Enter Cost Including Tax.' + NL +'Click to Enter Cost Excluding Tax'+NL;
  end;
  txtCost.Visible           := Value;
  txtCostPriceInc.Visible   := not(Value);
  GuiPrefs.Node['Options.CostExMode'].asBoolean:= Value;
end;

procedure TfrmParts.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  SetControlFocus(btnClose);
  if not fbCanClose then begin
    CanClose := False;
  end else if (ModalResult = mrCancel) or (bOnSave) then begin
    Canclose:= True;
  end  else begin
    if not ErrorOccurred then begin
      if SaveButtonClicked <> 1 then begin
        if DataHasChanged then begin
          SaveButtonClicked := 0; // Reset SavedButtonClicked
          bringToFront;
          Canclose:= SaveOrCancelChanges;
        end else begin
          RollbackTransaction;
        end;
      end;
    end;
  end;
  if CanClose then begin
    CloseExcelPriceForm;
    GlobalEvents.Notify(Sender, GEVENT_FormCloseQuery);
  end;
end;
procedure TfrmParts.CloseExcelPriceForm;
begin
    if Assigned(aPartsExcelPrice) then begin
      logtext('Freeandnil(TfmPartsExcelPrice)');
      Freeandnil(aPartsExcelPrice);
    end;
end;
procedure TfrmParts.btnCompletedClick(Sender: TObject);
begin
  DisableForm;
  try
    bOnSave := True;
    GlobalEvents.Notify(Sender, GEVENT_OnClick_Before);
    try
      SaveButtonClicked := 1;
      fsPartName := edtPart.Text;

      if SaveProduct then begin
        KeyId := qryProductPARTSID.AsInteger;
        Notify(False);
        Self.Close;
      end;
    except
      on EAbort do
        HandleEAbortException;
      on e: Exception do
        raise;
    end;

    bOnSave := False;

    if FormStillOpen('TfrmBatchParts') then begin
      if TfrmBatchParts(FindExistingComponent('TfrmBatchParts')).visible  then begin
        with TfrmBatchParts(FindExistingComponent('TfrmBatchParts')) do begin
          qryParts.Close;
          qryParts.open;
        end;
      end;
    end;

    if fsModal in FormState then ModalResult := mrOK ;
  finally
    EnableForm;
  end;
end;

procedure TfrmParts.btnConvertImageClick(Sender: TObject);
begin
  inherited;
  if MessageDlgXP_vista('This will Save the productCard and close the form. Do you want to continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  if not SaveProduct then exit;
  OpenERPListForm('TProductPictureListGUI' , initProductPictureList);
  SaveButtonClicked := 1;
  KeyId := qryProductPARTSID.AsInteger;
  Notify(False);
  Self.Close;
end;

Procedure TfrmParts.initProductPictureList(Sender:TObject);
begin
  if not(Sender is TProductPictureListGUI) then exit;
  TProductPictureListGUI(Sender).ProductId := QryproductPartsID.AsInteger;
  TProductPictureListGUI(Sender).PictureID := qryPartPicspartpicID.AsInteger;
end;

function TfrmParts.SaveOrCancelChanges: boolean;
var
  ExitResult: Word;
begin
  if datastate.dirty =false then begin
    Result := True;
    Exit;
  end;
  Result := True;
   ExitResult := MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0);
          case ExitResult of
            mrYes: begin
                  result := SaveProduct;
                  if result then Notify(False);
                  end;
            mrNo: begin
                    RollbackTransaction;
                    REsult := True;
                    Notify(TRue);
                  end;
            mrCancel: begin
                    result:= false;
                  end;
          end;
end;
procedure TfrmParts.pageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  //btnOpen.CAption := 'Open';
  //btnOpen.Enabled := false;
  PostDB(qryProduct);
  if qryProductPartsId.asInteger = 0 then begin
    Allowchange:= False;
    Exit;
  end;
  if (iCopyPartID <> 0)(* and (pageControl.ActivePage = TTabSheet(NewManufacture)) *) then begin
    MessageDlgXP_Vista('This is a Copied Product. Please Close and Reopen to Edit', mtInformation, [mbOK], 0);
    Allowchange:= False;
    Exit;
  end;
  if (pageControl.ActivePage = TTabSheet(Extra_Sell_Price))   then
    if assigned(PartsPriceMatrixForm) then
      if accesslevel <5 then
        if not(PartsPriceMatrixForm.Save) then begin
          Allowchange:= False;
          Exit;
        end;
  if fbIsShowingList then
    AllowChange := False;
  fbCurPage := Pagecontrol.ActivePage;
end;

procedure TfrmParts.pageControlResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgCustomFields, 1);
end;

procedure TfrmParts.qryUnitsOfMeasureQtysAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryUnitsOfMeasureQtys.IndexFieldNames := '[UOM]';
end;

procedure TfrmParts.chkActiveClick(Sender: TObject);
begin
  inherited;
  if self.qryProductActive.AsBoolean then
    qryProductLevel1.ParamByName('Active').AsString:= 'T'
  else
    qryProductLevel1.ParamByName('Active').AsString:= 'F';
  if qryProductLevel1.Active then
    qryProductLevel1.Refresh;
  qryProductLevel2.ParamByName('Active').AsString:= qryProductLevel1.ParamByName('Active').AsString;
  if qryProductLevel2.Active then
    qryProductLevel2.Refresh;
  qryProductLevel3.ParamByName('Active').AsString:= qryProductLevel1.ParamByName('Active').AsString;
  if qryProductLevel3.Active then
    qryProductLevel3.Refresh;
end;

procedure TfrmParts.chkBaseOnShippedClick(Sender: TObject);
begin
  inherited;
  btnViewClick(Sender);
end;

procedure TfrmParts.chkBasePurchOnClick(Sender: TObject);
begin
  inherited;
  btnPurchViewClick(Sender);
end;

procedure TfrmParts.UpdateProductSellInfo(var Message: TMessage);
begin
  if bUpdatingSellInfo or (KeyID = 0) then exit;

  bUpdatingSellInfo := True;

  // Lets start with the Extra Sell prices.
  qrySellPrices.First;
  while not qrySellPrices.EOF do
  begin
    // Update Sell Quantities.
    qrySellPrices.Edit;
    qrySellPrices.FieldByName('CalcSellQty1').AsFloat := qryProduct.FieldByName('SellQty1').AsFloat;
    // Recalculate Discounted Prices.
    qrySellPricesPrice1.AsFloat := CommonLib.Round((1 - DivZer(qrySellPricesQtyPercent1.AsFloat, 100)) * qryProductPRICE1.AsFloat, tcConst.GeneralRoundPlaces);

    // Update Record
    qrySellPrices.Post;

    // Fetch next record.
    qrySellPrices.Next;
  end;
  // Return to first record.
  qrySellPrices.First;

  // State that we are now finished updating.
  bUpdatingSellInfo := False;
end;

procedure TfrmParts.UpdateProductBuyInfo(var Message: TMessage);
begin
  If Not qryExtraBuyPrice.Active then Exit;
  // If we are already updating this info, then exit.
  if bUpdatingBuyInfo then
    exit;
  if (not bFinishedOnShow) or bUpdatingBuyInfo then
    exit;
  bUpdatingBuyInfo := True;
  try
    // Locate Preferred Supplier and Update Extra Buy Information.
    if qryExtraBuyPrice.Locate('SupplierID', GetSupplierID(qryProduct.FieldByName('PREFEREDSUPP').AsString), [loCaseInsensitive]) then
    begin
      qryExtraBuyPrice.Edit;
      qryExtraBuyPrice.FieldByName('Buy1').AsFloat := qryProduct.FieldByName('BuyQty1').AsFloat;
      qryExtraBuyPrice.FieldByName('Price').AsFloat := qryProduct.FieldByName('Cost1').AsFloat;
      qryExtraBuyPrice.FieldByName('PrintedValue1').AsFloat := qryProduct.FieldByName('Cost1').AsFloat;
      qryExtraBuyPrice.FieldByName('SupplierProductCode').AsString :=
        qryProduct.FieldByName('SupplierProductCode').AsString;
      qryExtraBuyPrice.Post;
    end;
  finally
    // State that we are now finished updating.
    bUpdatingBuyInfo := False;
  end;
end;

procedure TfrmParts.chkShowAllClick(Sender: TObject);
begin
  inherited;
  pageControlChange(Sender);
end;

procedure TfrmParts.edtMinQtyExit(Sender: TObject);
begin
  inherited;
  if qryProduct.State in [dsEdit, dsInsert] then
  begin
    PostDB(QryProduct);
    EditDB(QryProduct);
  end;
end;

procedure TfrmParts.qryForeignPriceSellClientIDChange(Sender: TField);
begin
  inherited;
  PostDB(qryForeignPriceSell);
  EditDB(qryForeignPriceSell);
end;

// ---------- File Attachment stuff --------------------------------------------

procedure TfrmParts.UpdateMe;
begin
  // update a field in tblClients to indicate that data has changed
  //  ie attachments have been added/removed
  Editdb(qryProduct);
  qryProductLastUpdated.AsDateTime := now;
end;

//------------------------------------------------------------------------------

procedure TfrmParts.cboUnitOfTimeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  Accept := False;
end;

procedure TfrmParts.cboWalmartUOMCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not modified then Exit;
  inherited;
  editDB(qrywalmartitems);
  qrywalmartitemsUOMID.asInteger := //qryWalmartUOMUnitID.asInteger;
                                    TUnitOfMeasure.CreateNewUOM(self,
                                                                qryProductPARTSID.asInteger,
                                                                qryWalmartUOMUnitName.asString,
                                                                qryWalmartUOMMultiplier.asFloat,
                                                                qryWalmartUOMUnitdescription.asString,
                                                                qryWalmartUOMBaseunitname.asString);
  PostDB(qrywalmartitems);
end;

procedure TfrmParts.wwIButton1Click(Sender: TObject);
begin
  inherited;
  DeleteRecord(qrySpecifications);
end;
procedure TfrmParts.optSalesTaxBasedonChange(Sender: TObject);
begin
  inherited;
  try
    if Assigned(Screen.ActiveControl) and
      ((screen.activecontrol = optSalesTaxBasedon) or (screen.activecontrol.parent = optSalesTaxBasedon)) then begin
      EditDB(qryProduct);
      qryProductSalesTaxBasedon.asString :=  optSalesTaxBasedon.value;
      PostDB(qryProduct);
    end;
  Except
    // kill the exception if active control is not set yet - event fired from in form show
  end;
  txtSell2.Enabled := not( SalesTaxBasedonProductPrice);
  txtSell3.Enabled := not( SalesTaxBasedonProductPrice);
  txtPrice2.Enabled := not( SalesTaxBasedonProductPrice);
  txtPrice3.Enabled := not( SalesTaxBasedonProductPrice);
  ShowtglGSThint;
end;

procedure TfrmParts.MiscPageControlChange(Sender: TObject);
begin
  if IsFlag('MiscPage') then exit;
  AddFlag('MiscPage');
  try
    inherited;
    if (MiscPageControl.ActivePage = TTabSheet(tabSpecifications)) then begin
      qrySpecifications.Open;
    end
    else if (MiscPageControl.ActivePage = TTabSheet(tabcommission)) then begin
      Ontabcommission(sender);
    end;
  finally
    RemoveFlag('MiscPage');
  end;
end;

procedure TfrmParts.qrySpecificationsBeforePost(DataSet: TDataSet);
begin
  inherited;
  DataSet.fieldbyname('PartsID').AsInteger := qryProductPARTSID.AsInteger;
end;

procedure TfrmParts.CheckClick(Sender: TObject);
begin
  if not TwwCheckBox(Sender).DataSource.DataSet.Active then
    Exit;
  TwwCheckBox(Sender).DataSource.DataSet.Edit;
  if TwwCheckBox(Sender).Checked then
    TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'T'
  else
    TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'F';
end;

procedure TfrmParts.qrySpecificationsIsMultiplierChange(Sender: TField);
begin
  inherited;
  if (Sender.AsString = 'T') and not IsNumeric(qrySpecifications.FieldByName('SpecValue').AsString) then
  begin
    MessageDlgXP_Vista('Calculation Specification Must Have Numerical Value', mtInformation, [mbOK], 0);
    Sender.AsString := 'F';
  end;
end;

procedure TfrmParts.cboSuppEnter(Sender: TObject);
begin
  inherited;
  fLastcombo:= TwwDbLookupCombo(Sender);
end;

procedure TfrmParts.cboSupplierForeignCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  {remove the filter of the lookup table as the lookup fields of the
  Filltable is bound to it. Removing the filter relocates the record
  pointer to the first record, so need to locate it. This should be done
  even the modified = False as the filter was applied in 'dropdown'}
  cboSupplierForeign.LookupTable.Filtered := False;
  cboSupplierForeign.LookupTable.Locate('ClientId', filltable.FieldByname('clientId').ASInteger, []);

  // set currency (to suppliers currency)
  if not(LookupTable.FieldByname('ForeignExchangeSellCode').aSString = '') then
  begin
    if cboCurrencyCode.LookupTable.Locate('Code', LookupTable.FieldByname('ForeignExchangeSellCode').aSString, [loCaseInsensitive]) then
    begin
      FillTable.FieldByName('CurrencyId').AsInteger := cboCurrencyCode.LookupTable.FieldByName('CurrencyId').asInteger;
      cboCurrencyCode.Text := FillTable.FieldByName('CurrencyCode').AsString;
    end;
  end;

  // Set default values
  if FillTable.FieldByname('Buy1').AsInteger = 0 then
    FillTable.FieldByname('Buy1').AsCurrency := 1;
  if FillTable.FieldByname('Price1').AsCurrency = 0 then
    FillTable.FieldByname('Price1').AsCurrency := 0;
end;

procedure TfrmParts.cboSupplierForeignDropDown(Sender: TObject);
var
  strFilter: string;
  Qry: TERPQuery;
begin
  {Sets the filter to remove the already selected supplier as the
  supplier can be selected once for the product}
  inherited;
  strFilter := '';
  Qry := TERPQuery.Create(nil);
  try
    CloneDataSet(qryForeignPrice, Qry);
    with Qry do
    begin
      First;
      while Eof = False do
      begin
        if Qry.fieldByname('ClientId').AsInteger <> qryForeignPrice.FieldByname('clientId').AsInteger then
        begin
          if strFilter <> '' then
            strFilter := strFilter + ' AND ';
          strFilter := strFilter + 'ClientId <> ' + FieldByname('clientId').AsString;
        end;
        Next;
      end;
      if strFilter <> '' then
      begin
        cboSupplierForeign.LookupTable.Filter := strFilter;
        cboSupplierForeign.LookupTable.Filtered := True;
      end;
    end;
  finally
    if Qry.ACtive then
      Qry.Close;
    FreeAndNil(qry);
  end;
end;

procedure TfrmParts.cboCurrencyCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  {remove the filter of the lookup table as the lookup fields of the
  Filltable is bound to it. Removing the filter relocates the record
  pointer to the first record, so need to locate it. This should be done
  even the modified = False as the filter was applied in 'dropdown'}
  cboCurrency.LookupTable.Filtered := False;
  //cboCurrency.LookupTable.Locate('CurrencyId', getCurrencyID(filltable.FieldByname('Price_Currency').asString), []);
  cboCurrency.LookupTable.Locate('CurrencyId', filltable.FieldByname('CurrencyId').asInteger, []);
end;

procedure TfrmParts.cboCurrencyDropDown(Sender: TObject);
var
  strFilter: string;
  Qry: TERPQuery;
begin
  {Sets the filter to remove the already selected currencies as the
  currency can be selected once for the product}
  inherited;
  strFilter := '';
  Qry := TERPQuery.Create(nil);
  try
    CloneDataSet(qryForeignPriceSell, Qry);
    with Qry do
    begin
      First;
      while Eof = False do
      begin
        if Qry.fieldByname('CurrencyId').AsInteger <> qryForeignPriceSell.FieldByname('CurrencyId').AsInteger then
        begin
          if strFilter <> '' then
            strFilter := strFilter + ' AND ';
          strFilter := strFilter + 'CurrencyId <> ' + FieldByname('CurrencyId').AsString;
        end;
        Next;
      end;
      if strFilter <> '' then
      begin
        cboCurrency.LookupTable.Filter := strFilter;
        cboCurrency.LookupTable.Filtered := True;
      end;
    end;
  finally
    if Qry.ACtive then
      Qry.Close;
    FreeAndNil(qry);
  end;
end;

procedure TfrmParts.qryProductBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryProductmsUpdateSiteCode.AsString:= AppEnv.Branch.SiteCode;
  if (qryProductGlobalRef.AsString = '') and (qryProductPARTSID.AsInteger > 0) then
    qryProductGlobalRef.AsString:= AppEnv.Branch.SiteCode + IntToStr(qryProductPARTSID.AsInteger);
end;
procedure TfrmParts.edtProductPrintNameChange(Sender: TObject);
begin
  inherited;
  if Screen.ActiveControl = Sender then
    fbPartnameMadeFromName := False;
end;
procedure TfrmParts.MakePartname;
begin
  if not fbPartnameMadeFromName then
    NamenPrintNameGridObj.MakePartname(fbUpdatingcompanyonName,Qryproduct);
  fbPartnameMadeFromName := True;
end;
procedure TfrmParts.qryProductAfterPost(DataSet: TDataSet);
begin
  inherited;
  MakePartname;

    if bNewPart then begin
      ShowUOMfields(true);
      with qryProductClass do begin
            LoadQryQty( qryProduct.FieldByname('PartsId').asInteger);
            Open;
            if (fbPartnameMadeFromName) and ((RecordCount = 0) or
                ((RecordCount = 1) and (fieldByName('ClassName').asString = ''))) then
                CreateQtyLines;
      end;
    end;
    if fsBarcode <> '' then
      if not qryPartBarCodes.Locate('barcode' , fsBarcode , []) then begin
          qryPartBarCodes.append;
          qryPartBarCodesBarCode.asString:=fsBarcode;
          qryPartBarCodes.Post;
      end;
    initAttachment;
end;
procedure TfrmParts.qryProductAfterScroll(DataSet: TDataSet);
begin
  inherited;
  IsHireProduct := tcdatautils.IsHireProduct(qryProductPartsID.asInteger);
end;

Procedure TfrmParts.InitAttachment;
begin
  if qryProductPartsID.AsInteger =0 then exit;
  If not Assigned(AttachmentForm) then Begin
    AttachmentForm := TfmAttachments(GetComponentByClassName('TfmAttachments',False,Self,True,True,qryProductPartsID.AsInteger));
    AttachmentForm.DBConnection := MyConnection;
    AttachmentForm.AttachObserver(Self);
    AttachmentForm.TableName := 'tblParts';
  end;
  if AttachmentForm.TableId <> qryProductPartsID.AsInteger then begin
    AttachmentForm.TableId := qryProductPartsID.AsInteger;
    AttachmentForm.Tag := qryProductPartsID.AsInteger;
    AttachmentForm.lvAttachments.Parent := pnlAttachments;
    AttachmentForm.lvAttachments.Align := alClient;
    AttachmentForm.PopulateListView;
  end;
end;
Function TfrmParts.Validate :Boolean ;
var
  BusObj: TBusObj;
begin
    Result := False;
    if Empty(edtPart.Text) then begin
        MessageDlgXP_Vista('Product Name cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        Setcontrolfocus(edtProductPrintName);
        Exit;
    end;
    if not ProductNameUnique() then begin
        MessageDlgXP_Vista('Product already exists with this name, name cannot be duplicate.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        Setcontrolfocus(edtProductPrintName);
        Exit;
    end;
    if Empty(dblcProductType.Value) then begin
        MessageDlgXP_Vista('Product Type cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        SetControlFocus(dblcProductType);
        Exit;
    end;
    if Empty(cboCOGSACC.LookupValue) then begin
        MessageDlgXP_Vista('Product COGS Account cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        SetControlFocus(cboCOGSACC);
        Exit;
    end;
    if Empty(cboINCOMEACC.LookupValue) then begin
        MessageDlgXP_Vista('Product Income Account cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        SetControlFocus(cboINCOMEACC);
        Exit;
    end;
    if Empty(cboASSETACC.LookupValue) then begin
        MessageDlgXP_Vista('Product Asset Account cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        SetControlFocus(cboASSETACC);
        Exit;
    end;
    if  Empty(cboTaxCode.LookupValue) then begin
        MessageDlgXP_Vista('Product Sales Tax Code cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        SetControlFocus(cboTaxCode);
        Exit;
    end;
    if Empty(cboPURTaxCode.LookupValue) then begin
        MessageDlgXP_Vista('Product Purchase Tax Code cannot be blank.', mtWarning, [mbOK], 0);
        pageControl.ActivePage := TTabSheet(Main);
        SetControlFocus(cboPURTaxCode);
        Exit;
    end;

    if not ChkCustReqdFields then begin
        Result := false;
        Exit;
    end;
    if qryProduct.state in [dsEdit,dsInsert] then begin
        PostDB(QryProduct);
        KeyId := qryProductPARTSID.asInteger;
    end;
   if qryProductMultipleBins.asBoolean then begin
       if qryProductVolume.asFloat = 0 then
            if AppEnv.CompanyPrefs.EnforceBinVolume then  begin
                MessageDlgXP_Vista('This product uses Bins and should have a volume.', mtWarning, [mbOK], 0);
                Pagecontrol.ActivePage := TTabSheet(tabBatch);
                SetControlFocus(edtDBVolume);
                EditDB(QryProduct);
                exit;
            end;
   end;
   BusObj:= TProductForeignSellPrice.Create(nil);
   try
     BusObj.Dataset:= qryForeignPriceSell;
     if not BusObj.ValidateDataList then begin
        pageControl.ActivePage := Extra_Sell_Price;
        SetControlFocus(grdForeignSell);
       exit;
     end;
   finally
     BusObj.Free;
   end;
   BusObj:= TProductExtraSellPrice.Create(nil);
   try
     BusObj.Dataset:= qrySellPrices;
     if not BusObj.ValidateDataList then begin
        pageControl.ActivePage := Extra_Sell_Price;
        SetControlFocus(grdSellPrices);
       exit;
     end;
   finally
     BusObj.Free;
   end;
   BusObj:= TProductForeignBuyPrice.Create(nil);
   try
     BusObj.Dataset:= qryForeignPrice;
     if not BusObj.ValidateDataList then begin
        pageControl.ActivePage := Extra_Buy_Price;
        SetControlFocus(grdForeign);
       exit;
     end;
   finally
     BusObj.Free;
   end;

   BusObj:= TProductclass.Create(nil);
   try
     BusObj.Dataset:= qryProductClass;
     if not BusObj.ValidateDataList then begin
        pageControl.ActivePage := Quantities;
        SetControlFocus(grdProductClasses);
       exit;
     end;
   finally
     BusObj.Free;
   end;

   BusObj:= TProductExtraBuyPrice.Create(nil);
   try
     BusObj.Dataset:= qryExtraBuyPrice;
     if TProductExtraBuyPrice(BusObj).count >0 then begin
       if TProductExtraBuyPrice(BusObj).ProductName <> qryProductPARTNAME.AsString then begin
         TProductExtraBuyPrice(BusObj).ProductName := qryProductPARTNAME.AsString;
         BusObj.PostDb;
       end;

       if not BusObj.ValidateDataList then begin
          pageControl.ActivePage := Extra_Buy_Price;
          SetControlFocus(grdBuyPrice);
         exit;
       end;
     end;
   finally
     BusObj.Free;
   end;

   if qryProductPartCalcformula.AsString <> '' then begin
      if not IsSearchPartcalcformulaValid then begin
        pageControl.ActivePage := Miscellaneous;
        MiscPageControl.ActivePage := tabSpecifications;
        SetControlFocus(memPartCalcformula);
        MessageDlgXP_Vista('Product Qty Calculating formula has error - ' + lblPartCalcformula.Caption, mtWarning, [mbOK], 0);
        Exit;
      end;
      if qryProductPartCalcformulaUOM.AsString = '' then begin
        pageControl.ActivePage := Miscellaneous;
        MiscPageControl.ActivePage := tabSpecifications;
        SetControlFocus(memPartCalcformula);
        MessageDlgXP_Vista('Please Select a Unit of Meassure for the formula calculation' , mtWarning, [mbOK], 0);
        Exit;
      end;
   end;
   PartcalcfieldsToformula;
   Result := True;
end;

procedure TfrmParts.KeyIdChanged(const NewKeyId: integer);
begin
  logInuseform;

  if UserLock.Enabled and (AccessLevel < 5) then begin
    // remove all existing locks
    UserLock.UnlockAllCurrentInstance;

    if (KeyId > 0) then begin
      if not UserLock.Lock('tblParts',KeyId,Self.Caption) then begin
        AccessLevel:= 5; // read only

        MessageDlgXP_Vista(UserLock.LockMessage+#13+#10+#13+#10+'Access has been changed to read-only.', mtWarning, [mbOK], 0);
      end
      else begin

      end;
    end;
  end;
  ProductPicture.LoadSelect('PartID = ' + IntToStr(KeyID));
  PartHasTree := GetTreeRootID(KeyID)<>0;
  showPricecostCalcHint;
  CleanIsEquipment := qryProductisEquipment.asBoolean;
  btnMakeBOM.Enabled := not(PartHasTree);

end;
procedure TfrmParts.lblwalmartQtyhintClick(Sender: TObject);
begin
  inherited;
  pageControl.ActivePage := Quantities;
  pageControlChange(nil);
  if qryUnitsOfMeasureQtys.Locate(qryUnitsOfMeasureQtysUOM.fieldname , qrywalmartitemsUOM.asString , []) then begin
    SetControlFocus(grdUOMQty);
    grdUOMQty.SetActivefield(qryUnitsOfMeasureQtysUOMDesc.fieldname);
  end else begin
    SetControlFocus(grdProductClasses);
    grdProductClasses.SetActivefield(qryProductClassAvailableQty.fieldname);
    TimerMsg(lbldefaultbin, quotedstr(qryProductPARTNAME.asString) +  ' Has no Stock Available for Walmart UOM - '+ quotedstr(qryUnitsOfMeasureQtysTotalAvailableQtyInUOM.fieldname));
  end;
end;

procedure TfrmParts.lblERPPriceClick(Sender: TObject);
begin
  inherited;
  pageControl.ActivePage := Main;
  if not txtRetailPriceInc.visible then tglGST.click;
  SetControlFocus(txtRetailPriceInc);
end;

procedure TfrmParts.ControlfocusProductPrintname(Sender: TObject);
begin
  inherited;
  pageControl.ActivePage := Main;
  if txtRetailPriceInc.visible then SetControlFocus(txtRetailPrice);
end;

procedure TfrmParts.ControlfocusSalesUOM(Sender: TObject);
begin
  inherited;
  pageControl.ActivePage := Main;
  SetControlFocus(edtsalesUOM);
end;

procedure TfrmParts.ControlfocusProductId(Sender: TObject);
begin
  inherited;
  pageControl.ActivePage := Main;
  SetControlFocus(edtPart);
end;

procedure TfrmParts.btnLandedCostClick(Sender: TObject);
begin
  inherited;
  ShowtotalLandedcost := not (ShowtotalLandedcost);
end;

procedure TfrmParts.SetShowtotalLandedcost(const Value: Boolean);
begin
  fbShowtotalLandedcost := Value;
  if Value then begin
    btnLandedCost.caption := 'Total Landed Cost';
    edtLandedCost.datafield :=QryProducttotalLandedcost.fieldname;
    btnLandedCost.hint := 'Total Landed Cost (=Landed Cost + Last Cost) is Displayed'+NL+'Please Double Click for the Product''s Landed Cost'+NL;
    edtLandedCost.hint := btnLandedCost.hint;
  end else begin
    btnLandedCost.caption := 'Landed Cost';
    edtLandedCost.datafield :=QryProductLandedcost.fieldname;
    btnLandedCost.hint := 'Landed Cost is Displayed'+NL+'Please Double Click for the Product''s Total Landed Cost (=Landed Cost + Last Cost) '+NL;
    edtLandedCost.hint := btnLandedCost.hint;
  end;
  GuiPrefs.Node['Options.ShowtotalLandedcost'].asBoolean:= Value;
end;

Procedure TfrmParts.ShowPricecostCalcHint;
begin
  if ParthasTree =False then pnlSales.Hint := ''
  else if qryProductBOMPriceCalculatedfromTree.AsBoolean then pnlSales.Hint := 'The Price of the product has been calculated from the BOM tree'
  else pnlSales.Hint := 'The Price of the product has NOT been calculated from the BOM tree, overwritten manually ';
  pnlSales.showhint := true;
  pnlSales.Parentshowhint := False;

  if ParthasTree =False then pnlPurchase.Hint := ''
  else if qryProductBOMcostCalculatedfromTree.AsBoolean then pnlPurchase.Hint := 'The Cost of the product has been calculated from the BOM tree'
  else pnlPurchase.Hint := 'The Cost of the product has NOT been calculated from the BOM tree, overwritten manually ';
  pnlPurchase.showhint := true;
  pnlPurchase.Parentshowhint := False;

end;
procedure TfrmParts.edtPartExit(Sender: TObject);
begin
  inherited;

  if edtProductPrintName.text = '' then Exit;
  if qryProductProductPrintName.asString ='' then exit;

  edtPartName.Text  := edtProductPrintName.text;
  ProductTreeOrder;
  EditDB(qryProduct);
  if  (edtProductPrintName.text <> '')  then begin
    if  (txtProductDescriptionPurchase.text = '') then begin
     qryProductPURCHASEDESC.asString := edtProductPrintName.text;
     txtProductDescriptionPurchase.SelStart := char_length(txtProductDescriptionPurchase.text);
    end;
    if  (txtProductDescriptionSale.text = '') then begin
     qryProductPARTSDESCRIPTION.asString := edtProductPrintName.text;
     txtProductDescriptionSale.SelStart := char_length(txtProductDescriptionSale.text);
    end;
    if self.qryProductPARTTYPE.AsString = '' then begin
      self.qryProductPARTTYPE.AsString := 'INV';
    end;
  end;
  Postdb(qryProduct);
  EditDB(qryProduct);
end;

procedure TfrmParts.edtProductPrintNameEnter(Sender: TObject);
begin
  inherited;
  if QryProductIsSystemProduct.AsBoolean then begin
    SavedAccessLevel := AccessLevel;
    AccessLevel := 1;
  end;
end;

procedure TfrmParts.edtProductPrintNameExit(Sender: TObject);
begin
  inherited;
  if Trim(qryProduct.FieldByname('ProductPrintName').AsString) <> '' then PostDB(qryProduct);
  edtPartExit(sender);
  if QryProductIsSystemProduct.AsBoolean then begin
    AccessLevel := SavedAccessLevel;
  end;
end;

procedure TfrmParts.cboManufProdCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
    if not(FillTable.State in [dsEdit,dsInsert]) then FillTable.Edit;
    FillTable.FieldByname('ProductId').asInteger       := lookupTable.Fieldbyname('PartsId').asInteger ;
    FillTable.FieldByname('MasterProductID').AsInteger := qryProduct.Fieldbyname('PartsId').asInteger ;
    FillTable.FieldByname('Description').AsSTring      := LookupTable.fieldByname('PARTSDESCRIPTION').AsString;
end;

procedure TfrmParts.chkSNTrackingEnter(Sender: TObject);
begin
   ValidateAllocation('SN');
end;

procedure TfrmParts.SetFocusToAccCombo(var Msg: TMessage);
begin
  case Msg.wParam of
    1: Begin
         SetControlFocus(cboPartLevel1);
       end;
    2: Begin
         SetControlFocus(cboPartLevel2);
       end;
    3: Begin
         SetControlFocus(cboPartLevel3);
       end;
    4: Begin
         Setcontrolfocus(edtProductPrintName);
       end;
  end;
end;

procedure TfrmParts.dblcProductTypeExit(Sender: TObject);
begin
  inherited;
  PostMessage(Self.Handle, WM_SetFocus, 1, 0);
end;

procedure TfrmParts.cboPartLevel2Exit(Sender: TObject);
begin
  inherited;
  ProductTreeOrder;
  PostMessage(Self.Handle, WM_SetFocus, 3, 0);
end;

procedure TfrmParts.cboCurrencyCodeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
var
  Supplier: TSupplier;
  SupplierConnection: TMyDacDataConnection;
begin
  if not Modified then Exit;
  if qryForeignPriceClientID.AsString = '' then Exit;
  inherited;
  // create instance of a supplier connection to permit rollback
  Supplier:= TSupplier.Create(nil);
  SupplierConnection:= TMyDacDataConnection.Create(Supplier);
  SupplierConnection.MyDacConnection:= MyConnection;
  Supplier.Connection:= SupplierConnection;
  try
    // Can create and use an instance of TSupplier to do this.
    Supplier.LoadSelect('ClientId = ' + qryForeignPriceClientID.AsString);
    if cboCurrencyCode.Text <> Supplier.ForeignExchangeCode then
    begin
      // Query user for update
      if (MessageDlgXP_Vista('The suppliers foreign exchange code preference differs from the selection'+
                     #13+#10+ 'Do you wish to change this suppliers foreign exchange code preference ?',
                     mtWarning, [mbYes, mbNo], 0) = mrYes) then
      begin
        Supplier.ForeignExchangeCode := cboCurrencyCode.Text;
        Supplier.PostDB;
      end;
    end;
  finally
    FreeandNil(Supplier);
  end;
end;

procedure TfrmParts.txtmarkupExit(Sender: TObject);
begin
  inherited;
  Exit;
  { only change values if user has modified markup }
  if txtmarkup.Modified then begin
    if VarIsNull(qryProductSell_Cost_Percentage.OldValue) or (Round(qryProductSell_Cost_Percentage.AsFloat,2) <> Round(qryProductSell_Cost_Percentage.OldValue,2)) then begin
      CostPriceMarkupCalc(qryProductSell_Cost_Percentage);
      EditDB(QryProduct);
      if QryProductGrossMarginMode.asString = 'F' then
        if qryProductSell_Cost_Percentage.asFloat >=100 then begin
          MessageDlgXP_Vista('Goss margin should be less than 100' , mtWarning, [mbok], 0);
          qryProductSell_Cost_Percentage.asFloat := 99;
        end;
      txtRetailPriceInc.Text := CurrToStrF(FloatToCurr(RoundCurrency(GetAmountInc(qryProductPRICE1.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)))), ffCurrency, 2);
    end;
    txtmarkup.Modified := false;
  end;
end;

procedure TfrmParts.txtPrice2Exit(Sender: TObject);
begin
  inherited;
  OnExitPriceEdit(sender);
end;

procedure TfrmParts.txtPrice3Exit(Sender: TObject);
begin
  inherited;
  OnExitPriceEdit(sender);
end;

procedure TfrmParts.txtProductDescriptionPurchaseEnter(Sender: TObject);
begin
  inherited;
  if QryProductIsSystemProduct.AsBoolean then begin
    SavedAccessLevel := AccessLevel;
    AccessLevel := 1;
  end;
end;

procedure TfrmParts.txtProductDescriptionPurchaseExit(Sender: TObject);
begin
  inherited;
  if QryProductIsSystemProduct.AsBoolean then begin
    AccessLevel := SavedAccessLevel;
  end;
end;

procedure TfrmParts.txtProductDescriptionSaleEnter(Sender: TObject);
begin
  inherited;
  if QryProductIsSystemProduct.AsBoolean then begin
    SavedAccessLevel := AccessLevel;
    AccessLevel := 1;
  end;
end;

procedure TfrmParts.txtProductDescriptionSaleExit(Sender: TObject);
begin
  inherited;
  if QryProductIsSystemProduct.AsBoolean then begin
    AccessLevel := SavedAccessLevel;
  end;
end;

procedure TfrmParts.qrySpecificationsAfterScroll(DataSet: TDataSet);
begin
  inherited;
    if Dataset.state = dsInsert then Exit;
    qrySpecificationsSpecDescription.readonly := False;
    qrySpecificationsSpecValue.Readonly := False;
end;

procedure TfrmParts.btnCopyClick(Sender: TObject);
var
  //fiCopyPartID :Integer;
  tglCostCaption :String;
  tglGSTCaption :String;
begin
  DisableForm;
  try
    tglCostCaption := tglCost.caption;
    tglGSTCaption := tglGST.caption ;
    try
      Processingcursor(True);
      bCopyPart := false;

      if DataHasChanged then
      begin
        if MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          if not PreSaveProduct then
            Exit;

          if not SaveProduct then
            Exit;
        end
        else
        begin
          RollbackTransaction;
        end;
      end;

      CloseQueries;
      (*fiCopyPartID := KeyID;
      iCopyPartID := fiCopyPartID;*)
      iCopyPartID := KeyID;
      bCopyPart := True;
      KeyID := 0;
      fsPartName := '';
      fsBarcode:= '';
      bInitialisedNewPart := False;
      FormShow(self);
      EditDB(qryProduct);
      qryProductAvgCost.AsFloat:= 0;
      qryProductLandedCost.AsFloat:= 0;
      PostDB(qryProduct);
      bFinishedOnShow := False;

      try
          if not(SameText(tglCost.Caption , tglCostCaption)) then tglCost.Click;
          if not(SameText(tglGST.Caption  , tglGSTcaption )) then tglGST.Click;
      Finally
          bFinishedOnShow := true;
      end;

      SetFocusedControl(edtPart);
    finally
      Processingcursor(False);
    end;
  finally
    //bCopyPart := False;
    EnableForm;
  end;
end;



procedure TfrmParts.qryProductSell_Cost_PercentageChange(Sender: TField);
begin
  inherited;
  Sender.AsFloat := Round(Sender.AsFloat,2);
  ValidateProductcostPrice(Sender);
end;

procedure TfrmParts.qryProductSupplierProductCodeChange(Sender: TField);
begin
  inherited;
  if bFinishedOnShow then
    PostMessage(Self.Handle, SX_UpdateProductBuyInfo, 0, 0);
end;

procedure TfrmParts.qryUnitsOfMeasureQtysCalcFields(DataSet: TDataSet);
begin
  qryUnitsOfMeasureQtysTotalAvailableQtyInUnits.asFloat := qryProductClassAvailableQty.asFloat;
  qryUnitsOfMeasureQtysTotalAvailableQtyInUOM.asFloat   := CommonLib.Round(DivZer(qryUnitsOfMeasureQtysTotalAvailableQtyInUnits.asFloat,qryUnitsOfMeasureQtysUOMMultiplier.ASFloat), 5);
  qryUnitsOfMeasureQtysUOMVolume.asFloat                := qryUnitsOfMeasureQtysVolume.AsFloat *qryUnitsOfMeasureQtysUOMMultiplier.AsFloat;
  qryUnitsOfMeasureQtysUOMDesc.asString                 := Trim(qryUnitsOfMeasureQtysUOM.asString )+
                                                          '  (' +  Trim(floatToStr(qryUnitsOfMeasureQtysUOMMultiplier.asFloat)) + ' ' +
                                                           Trim(qryUnitsOfMeasureQtysBaseUnitName.asString) +')';
  qryUnitsOfMeasureQtysUOMMultiplierDesc.asString       := ' X ' +  Trim(floatToStr(qryUnitsOfMeasureQtysUOMMultiplier.asFloat));
  qryUnitsOfMeasureQtysTotalAvailableQtyUOMDesc.asString:= ' / ' +Trim(floatToStr(qryUnitsOfMeasureQtysUOMMultiplier.asFloat));
  qryUnitsOfMeasureQtysAvailableQtyinUnits.asFloat      := qryUnitsOfMeasureQtysAvailableQtyinUOM.asFloat*qryUnitsOfMeasureQtysUOMMultiplier.ASFloat;

  qryUnitsOfMeasureQtysUOMWeight.asFloat                := qryUnitsOfMeasureQtysWeight.AsFloat *qryUnitsOfMeasureQtysAvailableQtyinUOM.asFloat;
  qryUnitsOfMeasureQtysAvailableQtyUOMWeight.asFloat    := qryUnitsOfMeasureQtysWeight.AsFloat * qryUnitsOfMeasureQtysTotalAvailableQtyInUOM.asFloat ;

end;


procedure TfrmParts.qrywalmartitemsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if Sametext(Appenv.comPanyprefs.WALMART_ProductNameField ,'S')  then begin
    lblERPSKU.caption         := lblPartname.caption;
    lblERPSKU.onclick         := ControlfocusProductId;
    lblERPProductname.caption := lblProductPrintName.caption;
    lblERPProductname.onclick := ControlfocusProductPrintname;
  end else  begin
    lblERPSKU.caption         := lblProductPrintName.caption;
    lblERPProductname.caption := lblPartname.caption;
    lblERPSKU.onclick         := ControlfocusProductPrintname;
    lblERPProductname.onclick := ControlfocusProductId;
  end;

  //lblERPWPID.caption   := 'Product ID(Internal)';
  lblERPPrice.caption  := 'Price(Inc)'+NL+
                          'ERP Default Currency ('+ Appenv.RegionalOptions.ForeignExDefault+')';
  if qrywalmartitems.recordcount > 0 then begin
    EditDB(qrywalmartitems);
    if qrywalmartitemsUOMMUlt.asFloat =0 then qrywalmartitemsUOMMUlt.asFloat := 1;
    if qrywalmartitemsUOM.asString = '' then qrywalmartitemsUOM.asString := DefaultWalmartUOM;
    qrywalmartitemsUOMQty.asFloat := divZer(ProductAvailableQty(qrywalmartitemsERPProductId.asinteger , ''(*qrywalmartitemsUOM.asString*)) ,
                                                                qrywalmartitemsUOMMUlt.asFloat);
    lblwalmartQtyhint.Caption := 'Product''s Total Available Qty' +(*' in '+ Quotedstr(qrywalmartitemsUOM.asString) +*)
                                 ' in All Departments (Read-Only)';
    lblwalmartQtyhint.Refresh;
    PostDB(qrywalmartitems);
  end;
end;

procedure TfrmParts.qryWalmartUOMBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  {filter for walmart units}
  qryWalmartUOM.SQL.text := 'select uom.* from (select @IntParam:=:xPartID) a1, '+
                            '('+ProductUOMSQL+')  uom '+
                            ' where unitname in (' + WalmartProductUnits +')'+
                            ' order by PartID desc, UnitID ,UnitName';
  InitQueryParamforKeyId(qryWalmartUOM,'xPartID'  );
end;

function TfrmParts.HasPallet(Const RelatedID:Integer):Boolean;
var
  Qry :TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(qryRelatedParts.connection);
  try
    with qry do begin
      SQL.add('Select  RelatedID from tblrelatedparts '+
                      ' where ISPallet ="T" '+
                      ' and  RelatedID    <> ' + inttostr(RelatedID)+
                      ' and  ParentId      = ' + inttostr(qryProductpartsID.asInteger));
      open;
      result := recordcount >0;

    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TfrmParts.HasContainer(Const RelatedID:Integer):Boolean;
var
  Qry :TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(qryRelatedParts.connection);
  try
    with qry do begin
      SQL.add('Select  RelatedID from tblrelatedparts '+
                    ' where ISContainer = "T" '+
                    ' and  RelatedID    <> ' + inttostr(RelatedID)+
                    ' and  ParentId      = ' + inttostr(qryProductpartsID.asInteger));
      open;
      result := recordcount >0;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
procedure TfrmParts.qryRelatedPartsISContainerChange(Sender: TField);
begin
  inherited;
  if qryRelatedPartsISContainer.asBoolean then
    if qryRelatedPartsISPallet.asBoolean then
      qryRelatedPartsISContainer.asBoolean := False;

  if qryRelatedPartsISContainer.asBoolean then begin
    qryRelatedPartsIsToRoundtoNextNumberinSales.AsBoolean := TRue;
    qryRelatedPartsIsToRoundtoPreviousNumberinSales.AsBoolean := False;
  end;
end;

procedure TfrmParts.qryRelatedPartsISPalletChange(Sender: TField);
begin
  inherited;
  if qryRelatedPartsISPallet.asBoolean then
      if qryRelatedPartsISContainer.asBoolean then
        qryRelatedPartsISPallet.asBoolean := False;

  if qryRelatedPartsISPallet.asBoolean then begin
      qryRelatedPartsIsToRoundtoNextNumberinSales.AsBoolean := TRue;
      qryRelatedPartsIsToRoundtoPreviousNumberinSales.AsBoolean := False;
  end;
end;

procedure TfrmParts.qryRelatedPartsIsToRoundtoNextNumberinSalesChange(Sender: TField);
begin
  inherited;
  if qryRelatedPartsIsToRoundtoNextNumberinSales.AsBoolean then
    if not(qryRelatedPartsISPallet.asBoolean) then
      if not(qryRelatedPartsISContainer.asBoolean) then
        qryRelatedPartsIsToRoundtoNextNumberinSales.AsBoolean := false;
  if qryRelatedPartsIsToRoundtoNextNumberinSales.AsBoolean  then
    qryRelatedPartsIsToRoundtoPreviousNumberinSales.AsBoolean  := false;
end;
procedure TfrmParts.qryRelatedPartsIsToRoundtoPreviousNumberinSalesChange(Sender: TField);
begin
  inherited;
  if qryRelatedPartsIsToRoundtoPreviousNumberinSales.AsBoolean then
    if not(qryRelatedPartsISPallet.asBoolean) then
      if not(qryRelatedPartsISContainer.asBoolean) then
        qryRelatedPartsIsToRoundtoPreviousNumberinSales.AsBoolean := false;
  if qryRelatedPartsIsToRoundtoPreviousNumberinSales.AsBoolean  then
    qryRelatedPartsIsToRoundtoNextNumberinSales.AsBoolean  := false;
end;
procedure TfrmParts.qryRelatedPartsParentQtyChange(Sender: TField);
begin
  inherited;
  if (qryRelatedPartsParentQty.asfloat <> 1) and (qryRelatedPartsParentQty.asfloat <> 0)  and (qryRelatedPartsQty.asfloat =0) then begin
    EditDB(qryRelatedParts);
    qryRelatedPartsQty.asfloat :=  1;
  end;

end;

procedure TfrmParts.qryRelatedPartsProductIDChange(Sender: TField);
begin
  inherited;
  qryRelatedParts.fieldbyname('ProductPrintName').asString :=GetProductprintname(qryRelatedPartsProductID.asInteger);
  qryRelatedParts.fieldbyname('Partname').asString :=GetProduct(qryRelatedPartsProductID.asInteger);
end;

procedure TfrmParts.qryRelatedPartsQtyChange(Sender: TField);
begin
  inherited;
  if (qryRelatedPartsQty.asfloat <> 1) and (qryRelatedPartsQty.asfloat <> 0) and (qryRelatedPartsParentQty.asfloat =0) then begin
    EditDB(qryRelatedParts);
    qryRelatedPartsParentQty.asfloat :=  1;
  end;
end;

procedure TfrmParts.btnGroupCopyClick(Sender: TObject);
var
  MsgText: string;
  qrySource: TERPQuery;

  procedure SetMsgText;
  begin
    MsgText := '';
    if ProductInStockQty <> 0 then
        MsgText := MsgText + 'The currently selected product is having an available stock and the ' +
                    'Group products can''t be changed when the stock is available. So only the related parts will be copied. ';
    end;
begin
  DisableForm;
  try
    inherited;

    if not Empty(cboProduct.Text) then  begin
      Processingcursor(True);
      qrySource := TERPQuery.Create(nil);
      try
          qrySource.Connection := qryProduct.Connection;

          SetMsgText;

          qrySource.SQL.Text := 'SELECT * FROM tblrelatedparts WHERE ParentID =' + IntToStr(qryProductLookupToCopyRelatedFromPartsID.asInteger);
          qrySource.Open;
          qrySource.First;

          if (rdoCopyOptions.ItemIndex = 0  ) and (qryRelatedParts.recordcount > 0) then begin
              qryRelatedParts.first;
              While qryRelatedParts.Recordcount > 0 do begin
                  qryRelatedParts.delete;
                  qryRelatedParts.First;
              end;
          end;

          while not qrySource.Eof do
          begin
              if (rdoCopyOptions.ItemIndex = 2) and
                  (qryRelatedParts.Locate('ProductID' , qrySource.FieldByName('ProductID').AsInteger , [])) then qryRelatedParts.Edit
              else
                  qryRelatedParts.Append;

            EditDB(qryRelatedParts);qryRelatedPartsParentID.AsInteger      := qryProductpartsID.asInteger;
            EditDB(qryRelatedParts);qryRelatedPartsProductID.AsInteger     := qrySource.FieldByName('ProductID').AsInteger    ;
            EditDB(qryRelatedParts);qryRelatedPartsPartName.AsString       := qrySource.FieldByName('PartName').AsString      ;
            EditDB(qryRelatedParts);qryRelatedPartsQty.asFloat             := qrySource.FieldByName('Qty').asFloat            ;
            EditDB(qryRelatedParts);qryRelatedPartsParentQty.asFloat       := qrySource.FieldByName('ParentQty').asFloat      ;
            EditDB(qryRelatedParts);qryRelatedPartsEditedFlag.AsBoolean    := qrySource.FieldByName('EditedFlag').AsBoolean   ;
            EditDB(qryRelatedParts);qryRelatedPartsHideRelated.AsBoolean   := qrySource.FieldByName('HideRelated').AsBoolean  ;
            EditDB(qryRelatedParts);qryRelatedPartsIncurAmount.AsFloat     := qrySource.FieldByName('IncurAmount').AsFloat    ;
            EditDB(qryRelatedParts);qryRelatedPartsUseIncur.AsBoolean      := qrySource.FieldByName('UseIncur').AsBoolean     ;
            EditDB(qryRelatedParts);qryRelatedPartsIncurAfterTax.AsBoolean := qrySource.FieldByName('IncurAfterTax').AsBoolean;
            EditDB(qryRelatedParts);qryRelatedPartsHireFromDate.AsDateTime := qrySource.FieldByName('HireFromDate').AsDateTime;
            EditDB(qryRelatedParts);qryRelatedPartsHireToDate.AsDateTime   := qrySource.FieldByName('HireToDate').AsDateTime  ;
            EditDB(qryRelatedParts);qryRelatedPartsISContainer.AsBoolean   := qrySource.FieldByName('ISContainer').AsBoolean  ;
            EditDB(qryRelatedParts);qryRelatedPartsIsPallet.AsBoolean      := qrySource.FieldByName('IsPallet').AsBoolean     ;
            EditDB(qryRelatedParts);qryRelatedPartsIsToRoundtoNextNumberinSales.AsBoolean     := qrySource.FieldByName('IsToRoundtoNextNumberinSales').AsBoolean;
            EditDB(qryRelatedParts);qryRelatedPartsIsToRoundtoPreviousNumberinSales.AsBoolean := qrySource.FieldByName('IsToRoundtoPreviousNumberinSales').AsBoolean;
            qryRelatedParts.Post;
            qrySource.Next;
          end;
          qrySource.Close;
          MessageDlgXP_Vista('Copy completed.', mtInformation, [mbOK], 0);
        finally
          FreeandNil(qrySource);
          Processingcursor(False);
        end;
    end  else  begin
      MessageDlgXP_Vista('Please enter a destination product.', mtInformation, [mbOK], 0);
    end;
  finally
    EnableForm;
  end;
end;


procedure TfrmParts.qryProductDiscontinuedChange(Sender: TField);
var
  fsAlternateProductFor:String;
begin
  inherited;
  if qryProductDiscontinued.asBoolean then
    fsAlternateProductFor := AlternateProductFor(qryProductPartsId.asInteger);
    if fsAlternateProductFor<> '' then begin
      MessageDlgXP_Vista(qryProductProductPrintName.asString + ' Cannot be Discontinued as it is Already an Alternate Product for the Following' + chr(13) +  char(vk_tab) +fsAlternateProductFor+'. ', mtWarning, [mbOK], 0);
      qryProductDiscontinued.asBoolean := false;
      chkDiscontinued.checked:= False;
    end;
end;




procedure TfrmParts.dblcProductTypeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
// CAN't Add Types
  Accept:=False;
end;

procedure TfrmParts.cbTaxCodeQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  cbTaxCodeQry.ParamByName('xRegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfrmParts.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pageControl, 2);
  RealignTabControl(MiscPageControl, 1);
  RealignTabControl(PageMovements, 1);
  RealignTabControl(pgCustomFields, 1);
  grdSellPrices.Height := Trunc((DNMPanel5.Height /2) - 15);
  grdBuyPrice.Height := Trunc((DNMPanel4.Height /2) - 15);
  RealignTabControl(PageControlsellprice, 1);
end;

procedure TfrmParts.cboTaxCodeEnter(Sender: TObject);
begin
  inherited;
  SaveAccessLevel := AccessLevel;
  AccessLevel := 1;
end;

procedure TfrmParts.cboTaxCodeExit(Sender: TObject);
begin
  inherited;
  PostDB(qryProduct);
  AccessLevel := SaveAccessLevel;
  if cboTaxCode.Text = '' then begin
    cboTaxCode.DropDown;
    SetControlFocus(cboTaxCode);
    exit;
  end;

  PostDB(QryProduct);
  EditDB(QryProduct);
  AddFlag('PriceIncChange');
  qryProductPRICEINC1.AsFloat := CommonLib.Round(GetAmountInc(qryProductPRICE1.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
  qryProductPRICEINC2.AsFloat := CommonLib.Round(GetAmountInc(qryProductPRICE2.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
  qryProductPRICEINC3.AsFloat := CommonLib.Round(GetAmountInc(qryProductPRICE3.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
  RemoveFlag('PriceIncChange');
end;

procedure TfrmParts.cboPURTaxCodeChange(Sender: TObject);
begin
  inherited;
  inherited;


end;

procedure TfrmParts.cboPURTaxCodeCloseUp(Sender: TObject; LookupTable,  FillTable: TDataSet; modified: Boolean);
var
  Flag:Boolean;
begin
  if Modified = false then Exit;
  inherited;
  PostDB(QryProduct);
  EditDB(QryProduct);
  AddFlag('CostIncChange');
  flag:= fbValidatingProductcostPrice;
  fbValidatingProductcostPrice:= TRue;
  try
    qryProductCOSTINC1.AsFloat := CommonLib.Round(GetAmountInc(qryProductCOST1.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
    qryProductCOSTINC2.AsFloat := CommonLib.Round(GetAmountInc(qryProductCOST2.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
    qryProductCOSTINC3.AsFloat := CommonLib.Round(GetAmountInc(qryProductCOST3.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
  finally
    fbValidatingProductcostPrice := Flag;
  end;
  RemoveFlag('CostIncChange');
end;




procedure TfrmParts.txtWholesalePriceExit(Sender: TObject);
begin
  inherited;
  AddFlag('ChangingWholeSale%');
  txtMarkup2.Text := FloatToStrF(DivZer((qryProductWHOLESALEPRICE.AsFloat - qryProductCOST1.AsFloat), qryProductCOST1.AsFloat) * 100, ffFixed, 7, 2) + ' %';
  RemoveFlag('ChangingWholeSale%');
end;

procedure TfrmParts.qryProductWHOLESALEPRICEChange(Sender: TField);
begin
  inherited;
  if inQtyPriceValidation then Exit;
  txtWholesalePriceExit(nil);
end;

procedure TfrmParts.qryProductAfterDelete(DataSet: TDataSet);
begin
  inherited;
  cboPartLevel1.Text := '';
  txtMarkup2.Text := '';
  ProductTreeOrder;
end;

procedure TfrmParts.btnLongSaleDescClick(Sender: TObject);
begin
  inherited;
  dlgPARTSLongMemo.Execute;
  ChangeMemoButtonColours;
end;

procedure TfrmParts.btnNewUOMClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if not ProductSaved then begin
      if MessageDlgXP_Vista('Product record should be saved before creating a new Unit of Measure. Do you wish to Save it now?' , mtconfirmation , [mbYes, mbNo] , 0) = mrNo then exit;
      if not BuyQty_Prices  then Exit;
      if not SellQty_Prices then Exit;
      if not SaveProduct    then exit;
    end;
    try
      with TUnitsOfMeasureGUI(GetComponentByClassName('TUnitsOfMeasureGUI') ) do try
            ProductID := qryProductPARTSID.asInteger;
            ShowModal;
            ClosenOpenDB(qryUnitsOfMeasureQtys);
            ClosenOpenDB(qryUOMPurchase);
            ClosenOpenDB(QryUOMSales);
      Finally
            Free;
      End;
    finally
      BeginTransaction;
    end;
  finally
    EnableForm;
  end;
end;


class procedure TfrmParts.CloseMe;
begin
  inherited;
  if FormStillOpen('TfrmParts') then begin
      TfrmParts(FindExistingComponent('TfrmParts')).Close;
      Application.ProcessMessages;
  end;
end;

procedure TfrmParts.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  EquipId:INteger;
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TProductBarcodeList then TProductBarcodeList(Sender).Dataset:= qryProduct
        else if Sender is TProductBarcode then TProductBarcode(Sender).Dataset:= qryPartBarCodes
        else if Sender is TProductPicture then TProductPicture(Sender).Dataset := qryPartPics;
    end else if (Eventtype = BusobjEvent_ToDo) and (Value = BusobjEvent_ChooseEquip) then begin
          Equipid:= TEquipmentListGUI.ShowallEquipment(qryProductPARTNAME.asString);
          if EquipId<> 0 then
            if Sender is TEquipment then begin
              TEquipment(Sender).Load(Equipid);
              TEquipment(Sender).ProductId := qryProductPARTSID.asInteger;
              TEquipment(Sender).PostDB;
            end;
    end
    else if (Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value)) then begin
      if Sender is TProductPicture then
        self.RefreshProductPic(TProductPicture(Sender).Dataset);
    end;
end;



procedure TfrmParts.qryProductClassAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if GuiPrefs.Node['cboBinBatchClass.Text'].AsString <> '' then begin
    if cboBinBatchClass.LookupTable.Locate(cboBinBatchClass.LookupField,GuiPrefs.Node['cboBinBatchClass.Text'].AsString,[loCaseInsensitive]) then begin
    end;
  end;
end;

procedure TfrmParts.cboClassNameDropDown(Sender: TObject);
begin
  inherited;
  if qryProductClass.State in [dsEdit,dsInsert] then
    if qryProductClassClassID.asInteger <> 0 then qryProductClass.post;
end;

procedure TfrmParts.qryProductClassBeforePost(DataSet: TDataSet);
begin
  inherited;
  if qryProductClassClassID.asInteger = 0 then begin
    MessageDlgXP_Vista(AppEnv.DefaultClass.ClassHeading +' should not be blank.', mtInformation, [mbOK], 0);
    dataset.cancel;
    abort;
  end;

end;

procedure TfrmParts.grdProductClassesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not qryProductClassActive.AsBoolean   then begin
      Afont.Color := clInactiveCaption;
  end else begin
      Afont.Color := clblack;
  end;
  if Sysutils.SameText(Field.fieldname , 'AvailableQty') then
    if  qryProductClassID.asInteger = ProductClassID then begin
        AFont.color := clMaroon;
        AFont.Style := AFont.Style + [fsBold];
    end else begin
      if not qryProductClassActive.AsBoolean   then begin
          Afont.Color := clInactiveCaption;
      end else begin
          Afont.Color := clblack;
      end;
      AFont.Style := AFont.Style - [fsBold];
    end;
end;

procedure TfrmParts.qryProductClassClassPriceVarianceChange(Sender: TField);
var
  curTemp: Double;
begin
  inherited;
  try
    if not bRunOnceVariant then
    begin
      bRunOnceVariant := True;

      // Calculate Variant Price
      curTemp := CommonLib.Round(qryProductPRICE1.AsFloat * (1 + Divzer(qryProductClassClassPriceVariance.AsFloat, 100)), tcConst.GeneralRoundPlaces);
      if qryProductClass.state in [dsEdit, dsInsert] then else qryProductClass.Edit;
      qryProductClass.FieldByName('VariantPrice').AsFloat := curTemp;
      if qryProductClass.state in [dsEdit, dsInsert] then qryProductClass.Post;

      bRunOnceVariant := False;
    end;
  except
  end;

end;

procedure TfrmParts.EditDB(Dataset: TDataset);
begin
  if Dataset.state in [dsEdit, dsInsert, dsCalcFields	] then else
    if Dataset.recordcount =0 then Dataset.Append else Dataset.Edit;
end;

procedure TfrmParts.PostDB(Dataset: TDataset);
begin
  if Dataset.state in [dsEdit, dsInsert] then Dataset.Post;
end;

procedure TfrmParts.grdProductClassesRowChanged(Sender: TObject);
var
  TotalAvailableQty:double;
  TotalWeight:double;
begin
    if qryUnitsOfMeasureQtys.Active then qryUnitsOfMeasureQtys.Refresh;
    OpenUnitsOfMeasureQtys(qryProductClassClassID.AsInteger);
    lblQty.Caption :=FloatToStrF(qryProductClassAvailableQty.asFloat,ffNumber, 15, 4);
    qryUnitsOfMeasureQtysTotalAvailableQtyInUOM.DisplayLabel := 'Total Available Qty :' + FloatToStr(qryProductClassAvailableQty.asFloat) +' if read as UOM';
    TotalAvailableQty := 0;
    TotalWeight:= 0;
    if qryUnitsOfMeasureQtys.RecordCount > 0 then begin
        qryUnitsOfMeasureQtys.first;
        while qryUnitsOfMeasureQtys.Eof = False do begin
          TotalAvailableQty := TotalAvailableQty +qryUnitsOfMeasureQtysAvailableQtyinUnits.asFloat;
          TotalWeight := TotalWeight +qryUnitsOfMeasureQtysUOMWeight.asFloat;
            qryUnitsOfMeasureQtys.next;
        end;
    end;
    lblTotalQty.Caption :=FloatToStrF(TotalAvailableQty,ffNumber, 15, 4);
    lblWeight.Caption :=FloatToStrF(TotalWeight,ffNumber, 15, 4);
    ProductClassID := QryProductClassID.asInteger;
    grdProductClasses.RedrawGrid;
end;

procedure TfrmParts.qryProductClassVariantPriceChange(Sender: TField);
var
  curTemp: Double;
begin
  inherited;
  try
    if not bRunOnceVariant then begin
      bRunOnceVariant := True;
      curTemp := DivZer(QryProductClassVariantPrice.AsFloat, qryProductPRICE1.AsFloat) - 1;
      EditDB(QryProductClass);
      QryProductClassClassPriceVariance.AsFloat := Round(curTemp * 100, CommonLib.CurrencyRoundPlaces);
      PostDB(QryProductClass);
      bRunOnceVariant := False;
    end;
  except
  end;
end;

procedure TfrmParts.qryProductClassWastagePercentageChange(Sender: TField);
begin
  inherited;
  if qryProductClassWastagePercentage.AsFloat <0 then qryProductClassWastagePercentage.AsFloat:= 0
  else if qryProductClassWastagePercentage.AsFloat >100 then qryProductClassWastagePercentage.AsFloat := 100;
end;

procedure TfrmParts.grdProductClassesExit(Sender: TObject);
begin
  inherited;
  PostDB(QryProductClass);
end;


procedure TfrmParts.cboBinBatchClassChange(Sender: TObject);
begin
  inherited;
   refreshProductAllocationForm;
end;
Procedure TfrmParts.refreshProductAllocationForm;
begin
  qryProductClass.Locate('ClassName', cbobinbatchClass.Text, [loCaseInsensitive]);
  if (qryProductBatch.asboolean = False) and (qryProductMultipleBins.asBoolean =FalsE) then exit;

  if not Assigned(ProductAllocationForm) then begin
    ProductAllocationForm := TfmProductAllocationTree(GetComponentByClassName('TfmProductAllocationTree' , True, self));
    ProductAllocationForm.Parent   := BinBatchAllocation;
    ProductAllocationForm.Tree.OnDblClick :=     BinBatchAllocationDblClick;
  end;
  if assigned(ProductAllocationForm) then begin
    ProductAllocationForm.ProductId:=    cbobinbatchClass.LookupTable.fieldByname('ProductID').asInteger;
    ProductAllocationForm.ClassId  :=    cbobinbatchClass.LookupTable.fieldByname('ClassID').asInteger;
    if ProductAllocationForm.visible then ProductAllocationForm.RefreshTree
    else ProductAllocationForm.Show;
  end;
  if qryProductBatch.asboolean        then  PostMessage(self.Handle, SX_BatchQtyChangeMsg, 0, 0);
  if qryProductMultipleBins.asBoolean then  PostMessage(self.Handle, SX_BinQtyChangeMsg, 0, 0);

  GuiPrefs.Node['cboBinBatchClass.Text'].AsString := cboBinBatchClass.Text;
end;

procedure TfrmParts.cboBinBatchClassDropDown(Sender: TObject);
begin
  inherited;
  if qryProductClass.state in [dsEdit,dsInsert] then qryProductClass.Post;
end;

procedure TfrmParts.chkBatchesClick(Sender: TObject);
begin
  inherited;
  if Screen.ActiveControl = chkBatches then begin
    if chkBatches.checked then begin
      if qryProductIsEquipment.AsBoolean then begin
        MessageDlgXP_Vista('This is an Equipment Product. Equipment Products cannot be Batch Enabled', mtWarning, [mbOK], 0);
        EditDB(qryProduct);
        chkBatches.checked  := False;
      end;
    end else begin
        if fbcleanBatch   then begin
          EditDB(qryProduct);
          qryProductMultipleBins.asBoolean := False;
          qryProductSNTracking.asBoolean := False;
        end;
      if ProductHasAllocationrecords then
        MessageDlgXP_Vista(qryProductProductPrintName.asString  + ' Already has Transactions Created. This Change Cannot be Reverted', mtWarning, [mbOK], 0);
    end;
  end;
  OptAutoallocbatches.Enabled     :=chkBatches.checked;
  edNotAllocatedToBatches.Enabled :=chkBatches.checked;
  lblNotAllocatedToBatches.Enabled:=chkBatches.checked;
  if chkBatches.checked then
            if OptAutoallocbatches.ItemIndex = -1 then
                if AppEnv.CompanyPrefs.AutoPickBatches then
                    OptAutoallocbatches.ItemIndex := 0 else OptAutoallocbatches.ItemIndex := 1;
  if chkBatches.Checked  = False then Exit;
  if Screen.activecontrol <> chkBatches then Exit;
  EditDB(QryProduct);
  qryProductBatch.asBoolean :=chkBatches.Checked;
end;

procedure TfrmParts.chkMultipleBinsClick(Sender: TObject);
begin
  inherited;
  if Screen.ActiveControl = chkMultipleBins then begin
    if chkMultipleBins.checked then begin
      if qryProductIsEquipment.AsBoolean then begin
        MessageDlgXP_Vista('This is an Equipment Product. Equipment Products cannot be Bin Enabled', mtWarning, [mbOK], 0);
        EditDB(qryProduct);
        chkMultipleBins.checked  := False;
      end;
    end else begin
      if fbCleanMultipleBins then begin
        EditDB(qryProduct);
        qryProductSNTracking.asBoolean := False;
      end;
      if ProductHasAllocationrecords then
        MessageDlgXP_Vista(qryProductProductPrintName.asString  + ' Already has Transactions Created. This Change Cannot be Reverted', mtWarning, [mbOK], 0);
    end;
  end;
  OptAutoallocbins.Enabled      :=chkMultipleBins.checked and (Accesslevel<5);
  edNotAllocatedToBins.Enabled  :=chkMultipleBins.checked and (Accesslevel<5);
  lblNotAllocatedToBins.Enabled :=chkMultipleBins.checked and (Accesslevel<5);
  lblDefaultBin4class.Enabled :=chkMultipleBins.checked and (Accesslevel<5);
  cboDefaultBin4class.Enabled :=chkMultipleBins.checked and (Accesslevel<5);
  if chkMultipleBins.Checked then
    if OptAutoallocbins.ItemIndex = -1 then
      if AppEnv.CompanyPrefs.AutoPickBins then
        OptAutoallocbins.ItemIndex := 0 else OptAutoallocbins.ItemIndex := 1;
  if chkMultipleBins.Checked  = False then Exit;
  if Screen.activecontrol <> chkMultipleBins then Exit;
  EditDB(QryProduct);
  qryProductMultipleBins.asBoolean :=chkMultipleBins.Checked;
  if qryProductVolume.asFloat = 0 then begin
      SetControlFocus(edtDBVolume);
      Exit;
  end;
end;

procedure TfrmParts.chkMultipleBinsEnter(Sender: TObject);
begin
  ValidateAllocation('Bin');
end;

procedure TfrmParts.chkBatchesEnter(Sender: TObject);
begin
  ValidateAllocation('Batch');
end;

procedure TfrmParts.cboClass4SerialnoChange(Sender: TObject);
begin
  inherited;
  qryProductClass.Locate('ClassName', cboClass4Serialno.text, [loCaseInsensitive]);
  OnTabSerial(TabSerial);
end;

procedure TfrmParts.grdSerialsDblClick(Sender: TObject);
begin
  inherited;
  if QrySerialnoAlloctype.asString = 'New' then begin
      MessageDlgXP_Vista('This is a new Serial/Job Number' , mtWarning , [mbok], 0);
      Exit;
  end;
  OpenERpListForm('TSerialNumberHistoryGUI', initSerialNumberHistory);
end;
procedure TfrmParts.initSerialNumberHistory(Sender: TObject);
begin
  if sender is TSerialNumberHistoryGUI then begin
  TSerialNumberHistoryGUI(sender).Serialnumber := QrySerialnoSerialnumber.asString;
  TSerialNumberHistoryGUI(sender).PartsId      := qryProductPARTSID.asInteger;
  end;
end;
procedure TfrmParts.grdSerialsTitleButtonClick(Sender: TObject;
  AFieldName: string);
begin
  inherited;
  if QrySerialno.FindField(AFieldName) <> nil then begin
      if (QrySerialno.FieldByName(AFieldName).fieldKind <> fkLookup) and (QrySerialno.FieldByName(AFieldName).fieldKind <> fkCalculated) and (QrySerialno.FieldByName(AFieldName).DataType <> ftWideMemo) and
        (QrySerialno.FieldByName(AFieldName).DataType <> ftMemo) then begin
        QrySerialno.DisableControls;
        try
          QrySerialno.IndexFieldNames := QuotedStr(AFieldName) + ' ASC CIS; ';
        finally
          QrySerialno.Enablecontrols;
        end;
      end;
  end;
end;

procedure TfrmParts.grpFiltersClick(Sender: TObject);
begin
  inherited;
       if grpFilters.ItemIndex =0 then QrySerialno.filter := '(alloctype = '+ quotedStr('In-Stock') + ' or alloctype = ' + quotedStr('New')+ ')'
  else if grpFilters.ItemIndex =1 then QrySerialno.filter := 'alloctype = '+ quotedStr('Sold') +' or alloctype = '+ quotedStr('transferred') +' or alloctype = '+ quotedStr('Used in BOM')
  else if grpFilters.ItemIndex =2 then QrySerialno.filter := 'alloctype = '+ quotedStr('SO')
  else if grpFilters.ItemIndex =3 then QrySerialno.filter := 'alloctype = '+ quotedStr('Fixed Asset')
  else QrySerialno.filter := '';
  QrySerialno.filtered := grpFilters.ItemIndex <> 4;
  QrySerialnoreccount;
end;

procedure TfrmParts.UOMQueries;
begin
  if QryUOMSales.Active then QryUOMSales.Close;
  QryUOMSales.SQL.clear;
  QryUOMSales.SQL.add('SELECT UnitName,UnitID,Multiplier FROM tblunitsofmeasure Where ifnull(PartID,0)=:PartsID and SalesDefault = "T" and Active = "T"');
  QryUOMSales.SQL.add('union');
  QryUOMSales.SQL.add('Select  UnitName,UnitID,Multiplier FROM tblunitsofmeasure Where ifnull(PartID,0)=0 and  Multiplier =1  and UnitName = '+ QuotedStr(AppEnv.DefaultClass.DefaultUOM)  +' and (ifnull(BaseunitID,UnitID) = 0 or ifnull(BaseunitID,UnitID) = UnitID)');

  if qryUOMPurchase.Active then qryUOMPurchase.Close;
  qryUOMPurchase.SQL.clear;
  qryUOMPurchase.SQL.add('SELECT UnitName,UnitID,Multiplier FROM tblunitsofmeasure Where ifnull(PartID,0)=:PartsID and PurchasesDefault = "T" and Active = "T"');
  qryUOMPurchase.SQL.add('union');
  qryUOMPurchase.SQL.add('Select  UnitName,UnitID,Multiplier FROM tblunitsofmeasure Where ifnull(PartID,0)=0 and  Multiplier =1  and UnitName = '+ QuotedStr(AppEnv.DefaultClass.DefaultUOM)  +' and (ifnull(BaseunitID,UnitID) = 0 or ifnull(BaseunitID,UnitID) = UnitID)');
end;

procedure TfrmParts.cboDefaultBinCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if Modified = false then Exit;
  inherited;
  EditDB(qryProductClass);
  qryProductClassDefaultbinId.asInteger := QryBinsBinID.asInteger;
end;

procedure TfrmParts.grdProductClassesDblClick(Sender: TObject);
var
  popupformname:String;
  lFieldName : string;
begin
 inherited;
 lFieldName := TField(grdProductClasses.GetActiveField).FieldName;
 if Sysutils.SameText(lFieldName ,qryProductClassinstockQty.fieldname) then begin
  AllocationQtyCheck;
 end else if Sysutils.SameText(lFieldName ,'POBOQty') then begin
    popupformname := FormFact.formClassName['TProductListGUI_OnOrder_OnOrderRequest'];
    if popupformname <> '' then begin
      AppContext['PartDrillInfo'].IntVar['Department'] := qryProductClassClassId.asInteger;
      openErpForm(popupformname ,qryProductPARTSID.asInteger);
    end;
 end else if Sametext(lFieldName , 'AvailableQty') then begin
      TProductMovementForm.showList(Self, qryProductClassProductID.ASiNTEGER, qryProductClassClassID.asInteger);
 End else if (Sysutils.SameText(lFieldName, 'Defaultbinlocation')) and
      (qryProductClassDefaultbinId.asInteger <> 0) then begin
    if MessageDlgXP_Vista('Do you wish to unassign the Default Bin for this class?' , mtconfirmation, [mbYes,MbNO], 0) = mrYes then begin
        EditDB(qryProductClass);
        qryProductClassDefaultbinId.asInteger := 0;
        PostDB(qryProductClass);
        Exit;
    end;
 end else if Sametext(lFieldName ,qryProductClassSOBOQty.Fieldname) or
  Sametext(lFieldName ,qryProductClassSOQty.Fieldname)  then begin
    openErpListForm('TfrmProductSOInfoGUI' , beforeShowDrillform );
 end else if Sametext(lFieldName ,qryProductClassAllocatedBOQty.Fieldname)  then begin
    openErpListForm('TfrmProductBOInfoGUI' , beforeshowProductInvinfo );
// temporarily - part of reorderpoints in a separate table
  end else if Sametext(lFieldName, 'ReorderPoint') or SameText(lFieldName, 'PreferredLevel') or SameText(lFieldName, 'ReorderAmount')  then begin
    OpenERPFormModal('TfmProductReorderPoints' , KeyId , beforeshowReorderPoints);
 end else if qryProductClassActive.asBoolean = False then
    if MessageDlgXP_Vista('This is a deleted Record. Do you wish to restore this record?' , mtconfirmation, [mbYes,MbNO], 0) = mrYes then begin
        PostDB(qryProductClass);
        EditDB(qryProductClass);
        qryProductClassActive.asBoolean := True;
        PostDB(qryProductClass);
        Exit;
    end;
end;
Procedure TfrmParts.beforeShowProductInvInfo(Sender:TObject);
begin
  if not(Sender is TfrmProductBOInfoGUI) then exit;
  TfrmProductBOInfoGUI(Sender).KeyId := qryProductPARTSID.asInteger;
  AppContext['PartDrillInfo'].IntVar['Department'] := qryProductClassClassId.asInteger;
end;
Procedure TfrmParts.beforeShowDrillform(Sender:TObject);
begin
  if (Sender is TfrmProductSOInfoGUI) then begin
    TfrmProductSOInfoGUI(Sender).KeyId := qryProductPARTSID.asInteger;
    AppContext['PartDrillInfo'].IntVar['Department'] := qryProductClassClassId.asInteger;
    TfrmProductSOInfoGUI(Sender).IsBo:=Sametext(TField(grdProductClasses.GetActiveField).FieldName ,qryProductClassSOBOQty.Fieldname);
  end else if sender is TProductnAllocationQtyCheckGUI then begin
    TProductnAllocationQtyCheckGUI(Sender).ProductId := qryProductClassProductId.asInteger;
    TProductnAllocationQtyCheckGUI(Sender).ClasSId := qryProductClassclassID.asInteger;
  end;
end;
procedure TfrmParts.cboDefaultBinDropDown(Sender: TObject);
begin
  inherited;
  fLastcombo := TwwDBLookupCombo(Sender);
end;

procedure TfrmParts.UpdateMe(const Cancelled: boolean; const aObject: TObject);
var
  ComboText: string;
begin
try
  inherited;
  if Cancelled then begin
    if Assigned(fLastcombo) then begin
      fLastcombo.Text := '';
      fLastcombo.LookupTable.Close;
      fLastcombo.LookupTable.Open;
    end;
  end
  else begin
    if Assigned(fLastcombo) and Assigned(aObject) and (aObject is TBaseInputGUI) then begin
      if (Sysutils.SameText(fLastcombo.Name, 'cboDefaultBin')) OR
          (Sysutils.SameText(fLastcombo.Name, 'cboDefaultBin4class'))  then begin
            if qrybinslookup.Active then qrybinslookup.Close; qrybinslookup.open;
            if QryBins.Active       then QryBins.Close;       QryBins.open;
            if QryBins.Locate('BinID' ,TBaseInputGUI(aObject).KeyID , []) then begin
              editdb(qryProductClass);
              qryProductClassDefaultbinId.asInteger:= QryBinsBinID.AsInteger;
              fLastcombo.Text := QryBinsBinID.asString;
            end;
      end
      else if fLastCombo = cboSupp then begin
        ComboText:= cboSupp.Text;
        cboSupp.LookupTable.Refresh;
        if cboSupp.LookupTable.Locate('Company',ComboText,[loCaseInsensitive]) then begin
          cboSupp.DataSource.DataSet.FieldByName(cboSupp.DataField).AsString := ComboText;
          cboSupp.RefreshDisplay;
          if Assigned(cboSupp.OnCloseUp) then begin
            cboSupp.OnCloseUp(cboSupp, cboSupp.LookupTable, cboSupp.DataSource.DataSet, true);
          end;
        end
        else begin
          cboSupp.Text := '';
        end;
      end;
    end;
  end;
except
    //kill the exception
end;
end;

procedure TfrmParts.qryProductClassDefaultbinIdSetText(Sender: TField;const Text: String);
begin
  if not(IsInteger(Text)) then begin
    abort;
  end;
  inherited;
end;

procedure TfrmParts.qryProductClassIsDefaultStockClassChange(Sender: TField);
var
  fiID:Integer;
begin
  inherited;
  qryProductClass.DisableControls;
  try
    if  qryProductClassIsDefaultStockClass.asBoolean then begin
      postdb(qryProductClass);
      if qryProductClass.recordcount >1 then begin
        fiId:= qryProductClassID.asInteger;
        try
            qryProductClass.First;
            While qryProductClass.EOF = False do begin
              if qryProductClassID.asInteger <> fiId then begin
                EditDB(qryProductClass);
                qryProductClassIsDefaultStockClass.asBoolean  := False;
                PostDB(qryProductClass);
              end;
              qryProductClass.Next;
            end;
        finally
          qryProductClass.Locate('ID' , fiID , []);
        end;
      end;
    end;
  finally
    qryProductClass.Enablecontrols;
  end;
end;

procedure TfrmParts.InitPopupform(frmPopup: TBaseInputGUI);
begin
  inherited;
  if frmPopup is TfmbinLocation then begin
      TfmbinLocation(frmPopup).ClassId:= qryProductClassClassID.asInteger;
  end;

end;

procedure TfrmParts.InitProductMovementTab;
begin
  ReadProductMovementGuiprefs(-1);
  ReadProductMovementGuiprefs(0);
  ReadProductMovementGuiprefs(1);
  ReadProductMovementGuiprefs(2);
  ReadProductMovementGuiprefs(3);
end;

procedure TfrmParts.updateDefaultbin;
var
  fsfilter :String;
  strSQL:string;
  Qry :TERPQuery;
  ClassId:Integer;
  function getabinofproduct:Integer;   begin
    result := 0;
    strSQL:= 'SELECT  PQADetails.Value, PQA.TransDate '   +
             ' FROM tblpqa AS PQA  '   +
             ' Inner Join tblpqadetails AS PQADetails ON PQA.PQAID = PQADetails.PQAID  '   +
             ' WHERE PQADetails.PQAType =  '+ QuotedStr(TPQABins.PQADetailtype) +
             ' and PQA.DepartmentID = ' +IntToStr(qryProductClassClassID.asInteger) +
             ' and PQA.ProductID = ' +IntToStr(qryProductClassProductID.asInteger) +
             ' ORDER BY PQA.TransDate ASC   '   +
             ' Limit 1';
    if Qry.Active then Qry.Close;
    Qry.SQL.clear;
    Qry.SQL.add(strSQL);
    Qry.open;
    if Qry.recordcount = 0 then exit;
    if IsInteger(Qry.Fieldbyname('Value').asString) then
      Result := StrtoInt(Qry.Fieldbyname('Value').asString);
    if Qry.Active then Qry.Close;
  end;
begin
  if updatedDefaultbin then exit;
  updatedDefaultbin := TRue;
  fsfilter := qryProductClass.Filter;
  Qry := CommonDbLib.TempMyQuery;
  qryProductClass.DisableControls;
  ClassId :=qryProductClassClassID.asInteger;
  try
    if qryProductClass.Filter <> '' then qryProductClass.Filter := '(' + qryProductClass.Filter +') and ';
    qryProductClass.Filter := '(DefaultbinId = 0 or  DefaultbinId =null)';
    qryProductClass.filtered := true;
    if qryProductClass.recordcount = 0 then exit;
    qryProductClass.First;
    DefaultBinsAssignedtoClasses:='';
    While qryProductClass.eof = False do begin
      editdb(qryProductClass);
      qryProductClassDefaultbinId.asInteger := getabinofproduct;
      if qryProductClassDefaultbinId.asInteger <> 0 then begin
        if DefaultBinsAssignedtoClasses <> '' then DefaultBinsAssignedtoClasses := DefaultBinsAssignedtoClasses +',';
        DefaultBinsAssignedtoClasses := DefaultBinsAssignedtoClasses +'     ' +qryProductClassClassname.asString + '  :  ' + qryProductClassDefaultbinLocation.asString;
      end;
      PostDB(qryProductClass);
      qryProductClass.Next;
    end;
  finally
    qryProductClass.Filter := fsfilter;
    qryProductClass.filtered := qryProductClass.filter <> '';
    if ClassId <> qryProductClassClassID.AsInteger then qryProductClass.Locate('ClassID' , ClassId , []);
      qryProductClass.EnableControls;
      if qryProductBatch.asboolean        then  PostMessage(self.Handle, SX_BatchQtyChangeMsg, 0, 0);
      if qryProductMultipleBins.asBoolean then  PostMessage(self.Handle, SX_BinQtyChangeMsg, 0, 0);
      if Qry.Active then Qry.close;
      FreeandNil(Qry);
  end;
  if DefaultBinsAssignedtoClasses<> '' then
      MessageDlgXP_Vista('Default Bin(s) are Automatically Assigned to the Following ' + Appenv.DefaultClass.Classheading+'.' +chr(13) +
                  'Please Save the Product Card to Keep These Defaults.'+chr(13) + DefaultBinsAssignedtoClasses, mtInformation, [mbOK], 0);
end;
procedure TfrmParts.AdjustThisProductbins(Emptybin :Boolean =False);
var
  s:String;
  ExitResult: Word;
begin
  DisableForm;
  try
    if (qryProductMultipleBins.asBoolean) and (qryProductBatch.asBoolean = False) then
        if qryProductClassDefaultbinId.asInteger = 0 then
          if strValue(edNotAllocatedToBins.text) <> 0 then begin
            MessageDlgXP_Vista('Please allocate the Default Bin for this Product/'+appenv.DefaultClass.Classheading, mtWarning, [mbOk], 0);
            SetControlFocus(cboDefaultBin4class);
            Exit;
          end;

    if DataHasChanged then begin
      SaveButtonClicked := 1; // Reset SavedButtonClicked
      s :=  'This will close the Product Form.' +chr(13) +
            'Do you wish to keep these changes you Have Made?';
      ExitResult := MessageDlgXP_Vista(s, mtWarning, [mbYes, mbNo, mbCancel], 0);
      case ExitResult of
        mrYes: if not SaveProduct then Exit
               else BeginTransaction;
        mrNo: begin
                ShowWindow(Handle, SW_HIDE);
                Application.ProcessMessages;
                RollbackTransaction;
              end;
        mrCancel: Exit;
      end;
    end else begin
      RollbackTransaction;
    end;
    if self.qryProductPARTSID.asInteger > 0 then begin
      if ProductQtyAdjobj.AutoAdjustBin(inttostr(qryProductPARTSID.asInteger), inttostr(qryProductClassClassID.asInteger),'',EmptyBin ) then
        Self.Close;
    end;
 finally
    EnableForm;
 end;
end;

Procedure TfrmParts.beforeshowStockAdjustEntryList(Sender:TObject);
begin
  if not(Sender is TStockAdjustEntryListGUI) then exit;
  TStockAdjustEntryListGUI(Sender).FormStyle := fsMDIChild;
  TStockAdjustEntryListGUI(Sender).qryMain.Filter := 'Originalno = ' +QuotedStr(SAOriginalno);
  TStockAdjustEntryListGUI(Sender).qryMain.Filtered := True;
  TStockAdjustEntryListGUI(Sender).BringToFront;
end;

procedure TfrmParts.BinBatchAllocationDblClick(Sender: TObject);
var
  form :TProductBatchesGUI;
  Qty :Double;
  SelectedCellData :String;
  SAID :Integer;
  ExitResult: Word;
begin
  inherited;

  if sameText(ProductAllocationForm.SelectedcolumnName ,'Instock Quantity') or sameText(ProductAllocationForm.SelectedcolumnName ,'Sales Order Quantity') then begin
    SelectedCellData := ProductAllocationForm.SelectedCellData;
    if (SelectedCellData <> '') and (IsNumber(SelectedCellData)) then begin
      Qty := strtoFloat(SelectedCellData);
      if Qty > 0 then  begin
        if isOktoAdjust(ProductAllocationForm.Batchno,ProductAllocationForm.BinLocation, ProductAllocationForm.Serialnumber) then begin
          if DataHasChanged then begin
            ExitResult := MessageDlgXP_Vista('This will close the Product Form.' +chr(13) +
                  'Do you wish to keep these changes you have made and create a stock adjustment for this allocation?', mtWarning, [mbYes, mbNo, mbCancel], 0);
            case ExitResult of
              mrYes: if not SaveProduct then Exit
                     else BeginTransaction;
              mrNo: begin
                      ShowWindow(Handle, SW_HIDE);
                      Application.ProcessMessages;
                      RollbackTransaction;
                    end;
              mrCancel: Exit;
            end;
          end else begin
            RollbackTransaction;
          end;
          DataState.dirty:= false;
          SAID := TStockAdjustEntry.CreateStockAdjust(qryProductPARTSID.asInteger ,
                                                      qryProductClassClassID.asInteger,
                                                      Qty ,
                                                      ProductAllocationForm.UOM,
                                                      Sametext(ProductAllocationForm.SelectedcolumnName ,'Instock Quantity'),
                                                      ProductAllocationForm.Batchno,
                                                      ProductAllocationForm.ExpiryDate,
                                                      ProductAllocationForm.BinLocation,
                                                      ProductAllocationForm.binnumber,
                                                      ProductAllocationForm.Serialnumber);
          if SAID<>0 then begin
            MessageDlgXP_Vista( ' A Stock Adjustment is created for ' + qryProductProductPrintName.asString+  '.  Please adjust the Qty and make sure the stock adjustment is processed.', mtInformation, [mbok], 0);
            OpenERPForm('TfmStockAdjustEntryflat' , SAID);
            Application.ProcessMessages;
            closeWithDelay(1);
          end;
          Exit;
        end;
      end;
    end;
  end;

  if qryProductBatch.asboolean = False then Exit;
  form := TProductBatchesGUI(GetComponentByClassName('TProductBatchesGUI'));
  if not(assigned(Form)) then exit;
  form.ProductID := qryProductPARTSID.asInteger;
  Form.classid := qryProductClassClassID.asInteger;
  form.FormStyle := fsMDIChild;
  Form.bringToFront;
end;
function TfrmParts.isOktoAdjust(Batchno:String ;BinLocation,Serialnumber:String) :Boolean;
begin
  if qryProductBatch.AsBoolean then
    if Trim(Batchno)='' then begin
      Result:= False;
      TimerMsg(ProductAllocationForm.lblMsg , 'Please Select an entry with Batch Number if you want to create stock adjustment for the Qty.');
      Exit;
    end;
  if qryProductmultiplebins.AsBoolean then
    if Trim(BinLocation)='' then begin
      Result:= False;
      TimerMsg(ProductAllocationForm.lblMsg , 'Please Select an entry with Bin Details if you want to create stock adjustment for the Qty.');
      Exit;
    end;
  if qryProductSNTracking.AsBoolean  then
    if Trim(Serialnumber)='' then begin
      Result:= False;
      TimerMsg(ProductAllocationForm.lblMsg , 'Please Select an entry with Serial number if you want to create stock adjustment for the Qty.');
      Exit;
    end;
  Result := True;
end;
function TfrmParts.ProductSaved: boolean;
var
  strSQL:String;
begin
  strSQL := 'Select PartsId from tblParts where Partname = ' +quotedStr(qryProductPARTNAME.asString);
  with Commondblib.TempMyQuery do try
    SQl.add(strSQL);
    open;
    Result := Recordcount> 0;
  finally
    if Active then close;
    Free;
  end;
end;

procedure TfrmParts.grdUnitOfMeasureQtysCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Sysutils.SameText(Field.fieldName, 'TotalAvailableQtyinUnits') then begin
      AFont.Color := clMaroon;
      AFont.Style := Afont.Style +[fsBold];
  end;
end;

procedure TfrmParts.cmdNewSrnoClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if MessageDlgXP_Vista('You need to do a ''Stock Adjustment'' to create new ''Serial Numbers''.  ' +
                        'The Stock adjustment needs to be ''PROCESSED'' to make the newly added serial numbers available.  '+ chr(13) +chr(13) +
                        'Do you wish to open the Stock Adjustment form?' , mtconfirmation , [mbyes, mbNo] , 0) = mrno then exit;
  Form := GetComponentByClassName('TfmStockAdjustEntryflat');
  if Assigned(Form) then begin
    with TfmStockAdjustEntryflat(Form) do begin
      AttachObserver(Self);
      FormStyle   := fsMDIChild;
      BringToFront;
      TfmStockAdjustEntryflat(Form).stockAdjust.New;
      if TfmStockAdjustEntryflat(Form).StockAdjust.accountID> 0 then begin
        TfmStockAdjustEntryflat(Form).StockAdjust.PostDB;
        TfmStockAdjustEntryflat(Form).StockAdjust.Lines.New;
        TfmStockAdjustEntryflat(Form).StockAdjust.Lines.ProductID := qryProductPARTSID.asInteger;
        TfmStockAdjustEntryflat(Form).StockAdjust.Lines.DeptID    := qryProductClassClassID.asInteger;
        TfmStockAdjustEntryflat(Form).StockAdjust.Lines.PostDB;
        SetControlFocus(TfmStockAdjustEntryflat(Form).grdTransactions);
        TfmStockAdjustEntryflat(Form).grdTransactions.SetActiveField('Serialnumber');
      end;
    end;
  end;
end;

procedure TfrmParts.qryProductBARCODESetText(Sender: TField;
  const Text: String);
begin
  inherited;
  if Text = '' then exit;
  If aPPENV.CompanyPrefs.UseAlphaNumericBarcodes = False then
      if not IsNumeric(Text) then begin
        MessageDlgXP_Vista('Barcode should be a number. Please change the Preference if you need to have alphanumeric barcodes', mtInformation , [mbOk] , 0);
        exit;
      end;
  qryProductBARCODE.asString := Text;
end;

procedure TfrmParts.qryPartBarCodesBarCodeSetText(Sender: TField;
  const Text: String);
begin

  inherited;
  if Text = '' then exit;
  If appenv.CompanyPrefs.UseAlphaNumericBarcodes = False then
      if not IsNumeric(Text) then begin
        MessageDlgXP_Vista('Barcode should be a number. Please change the Preference if you need to have alphanumeric barcodes', mtInformation , [mbOk] , 0);
        exit;
      end;
  qryPartBarCodesBarCode.asString := Text;
end;

procedure TfrmParts.qryPartBarCodesPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: DB.TDataAction);
var
  fsProductName :String;
begin
  fsProductName := TProduct.ProductNameForBarcode(qryPartBarCodesBarCode.asSTring) ;
  if not(Sysutils.SameText(fsProductName,qryProductPARTNAME.asString)) then begin
    MessageDlgXP_Vista('Barcode ' +qryPartBarCodesBarCode.asSTring + ' has already been used with PART Name => ' + fsProductName + chr(13)+chr(13)+
        'Please select a different barcode to use.', mtInformation, [mbOK], 0);
  end else begin
    MessageDlgXP_Vista('Unknown error occured while posting the barcode ' +
                qryPartBarCodesBarCode.asSTring +':' + chr(13)+
                E.Message+chr(13) +chr(13)+
        'Please select a different barcode to use.', mtInformation, [mbOK], 0);
  end;
  action := daAbort;
end;


procedure TfrmParts.QryPartHirePricingAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshhirePriceLines;
end;
procedure TfrmParts.QryPartHirePricingAfterPost(DataSet: TDataSet);
begin
  inherited;
  RefreshhirePriceLines;
end;

procedure TfrmParts.QryPartHirePricingAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshhirePriceLines;
end;

procedure TfrmParts.REfreshhirePriceLines;
begin
//
end;

procedure TfrmParts.QryPartHirePricingLinesBeforeInsert(DataSet: TDataSet);
begin
  inherited;
    PostDB(QryPartHirePricing);
    if QryPartHirePricing.RecordCount=0 then begin
      QryPartHirePricing.Append;
      PostDb(QryPartHirePricing);
    end;
end;

procedure TfrmParts.cboPURTaxCodeEnter(Sender: TObject);
begin
  inherited;
  SaveAccessLevel := AccessLevel;
  AccessLevel := 1;
end;

procedure TfrmParts.cboPURTaxCodeExit(Sender: TObject);
begin
  inherited;
  PostDB(qryProduct);
  AccessLevel := SaveAccessLevel;
  if cboPURTaxCode.Text = '' then begin
    cboPURTaxCode.DropDown;
    SetControlFocus(cboPURTaxCode);
  end;
end;

procedure TfrmParts.cboReorderPointsExit(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmParts.delAltBarcodesClick(Sender: TObject);
begin
  inherited;
  if qryPartBarCodesIsprimaryBarcode.asBoolean then begin
      MessageDlgXP_Vista('This is the main Barcode of the product and cannot be made inactive' , mtInformation , [mbok] , 0);
      exit;
  end else begin
    ProductBarcodeList.Lines.Active:= false;
    ProductBarcodeList.Lines.PostDb;
  end;
end;



function TfrmParts.CustomFieldExtenderListtype: TListType;
begin
  REsult := ltProducts;
end;

procedure TfrmParts.CustomFieldsRefresh;
begin
    CustomFieldRefresh('CFProduct' ,pnlCustFldsFixed);
end;
function TfrmParts.ChkCustReqdFields: boolean;
begin
  Result := ChkReqdFields('Product');
  if not Result then pageControl.ActivePage := Custom_Fields;
end;
procedure TfrmParts.cmdCustomLabelsOldClick(Sender: TObject);
begin
  OpenCustomFields;
end;

procedure TfrmParts.PageMovementsChange(Sender: TObject);
var
  PriorityName1     : string;
  PriorityName2     : string;
  PriorityID1       : Integer;
  PriorityID2       : Integer;
begin
  inherited;
  PriorityID1       := 0;
  PriorityID2       := 0;


  if not OnTabchange(Sender,PriorityName1,PriorityName2, PriorityID1, PriorityId2) then Exit;

  Processingcursor(True);
  Try
         if (pageMovements.ActivePage = TTabSheet(TabSalesMovements))   then onTabSalesMovement(sender)
    else if (pageMovements.ActivePage = TTabSheet(tabInTrans))          then onTabtabInTrans(sender)
    else if (pageMovements.ActivePage = TTabSheet(TabPurchaseMovement)) then OnTabPurchaseMovement(Sender)
    else if (pageMovements.ActivePage = TTabSheet(tabMan))              then OnTabMan(Sender)
    else if (pageMovements.ActivePage = TTabSheet(tabLatestCost))       then OntabLatestCost(Sender);

    GlobalEvents.Notify(pageControl, GEVENT_OnChange);
    fbIsShowingList := False;
  finally
    Processingcursor(False);
  end;

end;

procedure TfrmParts.deleteProcessStepClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(QryPartsProcess);
end;



procedure TfrmParts.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TForeignBuyPriceAuditTrialGUI' , initproductId)
end;
procedure TfrmParts.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  OpenERPListform('TAlternateProductSearchGUI' , initproductId);
end;

procedure TfrmParts.btnLongPurchDescClick(Sender: TObject);
begin
  inherited;
  dlgPARTSpurchaseLongMemo.Execute;
  ChangeMemoButtonColours;
end;

procedure TfrmParts.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
  GuiPrefs.Node['Options.RelatedProductHelpIndes'].asInteger:= 1;
  ShowrelatedProductHelp(true);
end;

procedure TfrmParts.DNMSpeedButton4Click(Sender: TObject);
begin
  inherited;
  GuiPrefs.Node['Options.RelatedProductHelpIndes'].asInteger:= 2;
  ShowrelatedProductHelp(true);
end;

procedure TfrmParts.DNMSpeedButton5Click(Sender: TObject);
begin
  inherited;
  AllocationQtyCheck;
end;
Procedure TfrmParts.AllocationQtyCheck;
begin
  openErpListForm('TProductnAllocationQtyCheckGUI' , beforeShowDrillform );
end;
procedure TfrmParts.DNMSpeedButton6Click(Sender: TObject);
begin
  inherited;
  if edtUrl.Text = '' then
    ShellExecute(0, 'open', 'http://www.trueerp.com', '','',SW_SHOWNORMAL)
  else
    ShellExecute(0, 'open', PChar(edtUrl.Text), '','',SW_SHOWNORMAL);

end;

procedure TfrmParts.UpdateUseFormala(Sender: TObject);
begin
  inherited;
  if accesslevel > 3 then exit;
  postdb(qryProductClass);
  if qryProductClass.RecordCount=0 then exit;
  qryProductClass.First;
  While qryProductClass.Eof = False do begin
    EditDB(qryProductClass);
    if Sender =  btnUseFormala      then qryProductClassUseproductforecastformula.asBoolean := True;
    if Sender =  btndonotUseFormala then qryProductClassUseproductforecastformula.asBoolean := False;
    PostDB(qryProductClass);
    qryProductClass.Next;
  end;
end;

procedure TfrmParts.btnQtyAdjustClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TFmProductQtyAdjOptions' , 0);
end;

procedure TfrmParts.initproductId(Sender: TObject);
begin
       if sender is TForeignBuyPriceAuditTrialGUI then TForeignBuyPriceAuditTrialGUI(Sender).ProductId := qryProductPARTSID.AsInteger
  else if sender is TAlternateProductSearchGUI    then TAlternateProductSearchGUI(Sender).ProductID    := qryProductPARTSID.AsInteger;
end;
procedure TfrmParts.btnMoveStockToDefaultbinClick(Sender: TObject);
var
  s:String;
  ExitResult: Word;
  Qry :TERPQuery;
  StockAdjust:TStockAdjustEntry;
begin
  DisableForm;
  try
    if (sender = btnMoveStockToDefaultbin) and  (qryProductMultipleBins.asBoolean) and (qryProductBatch.asBoolean = False) then
        if qryProductClassDefaultbinId.asInteger = 0 then
          if strValue(edNotAllocatedToBins.text) <> 0 then begin
            MessageDlgXP_Vista('Please allocate the Default Bin for this Product/'+appenv.DefaultClass.Classheading, mtWarning, [mbOk], 0);
            SetControlFocus(cboDefaultBin4class);
            Exit;
          end;

    if DataHasChanged then begin
      SaveButtonClicked := 1; // Reset SavedButtonClicked
      s :=  'This will create a ''Stock Adjustment'' to move the ''AVAILABLE QUANTITY'' from all the Bins'+NL+'to the Default Bin :  ' + quotedstr(qryProductClassDefaultbinlocation.asString)  +'.' +NL+NL +
            'If you continue, will ''Close'' the Product Form.' +chr(13) +
            'Do you wish to keep these changes you Have Made?';
      ExitResult := MessageDlgXP_Vista(s, mtWarning, [mbYes, mbNo, mbCancel], 0 );
      case ExitResult of
        mrYes: if not SaveProduct then Exit
               else BeginTransaction;
        mrNo: begin
                ShowWindow(Handle, SW_HIDE);
                Application.ProcessMessages;
                RollbackTransaction;
              end;
        mrCancel: Exit;
      end;
    end else begin
      RollbackTransaction;
    end;
    ExitResult := MessageDlgXP_Vista('Would you like to Allocate the unallocated Quantity as well into the Default Bin (if any)?', mtConfirmation, [mbYes, mbNo, mbCancel], 0 );
    if ExitResult = mrCancel then  Exit;

    if self.qryProductPARTSID.asInteger > 0 then begin
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
        qry.SQL.text := 'select ' +
                        ' P.partsID, p.partname, PC.DefaultbinId, P.batch , PC.classid' +
                        ' from tblproductclasses Pc inner join tblparts p on p.partsId = pc.productId ' +
                        ' where ifnull(DefaultbinId,0)<> 0 and p.MultipleBins ="T"';
        if sender <> btnMoveAllStockToDefaultbin then
          if MessageDlgXP_Vista('Would you like to Move Stock of All products into It''s Default Bin?' +NL+NL+
                                'Choosing ''Yes'' will Move all Products Stock'+NL+
                                'Choosing ''No'' will Move '+ qryProductProductPrintName.AsString +'''s Stock' , mtWarning, [mbYes, mbNo, mbCancel], 0 ) = mrno then
            qry.SQL.add(' and P.partsId = ' + inttostr(qryProductPARTSID.asInteger));
        opendb(qry);
        if qry.recordcount >0 then begin
            if  (qry.locate('batch' , 'T' , [])) and   (ExitResult in [mryes])  then begin
               AdjustBatchno := ProductQtyAdjobj.getAdjustBatchno;
            end;

          StockAdjust:= TStockAdjustEntry.create(Nil);
          try
            StockAdjust.connection := TMyDacDataConnection.create(StockAdjust);
            StockAdjust.Connection.Connection := CommonDbLib.GetNewMyDacConnection(StockAdjust);
            StockAdjust.Load(0);
            StockAdjust.Connection.BeginTransaction;
             qry.first;
             lblMsg.caption :='';
             lblMsg.visible := True;
             lblMsg.Refresh;
             try
               While qry.eof =False do begin
                lblMsg.caption := Qry.fieldbyname('partname').asString+' ->  ' + inttostr(qry.recno)+' of ' + inttostr(qry.recordcount)+' Product(s)';
                lblMsg.refresh;
                SAOriginalno := StockAdjust.AutoAdjusttoDefaultBin(Qry.fieldbyname('DefaultbinId').AsInteger,Qry.fieldbyname('PARTSID').asInteger, Qry.fieldbyname('Classid').asInteger,(ExitResult in [mryes]) , AdjustBatchno );
                qry.Next;
               end;
             finally
              lblMsg.Visible := False;
             end;
            //StockAdjust.DeleteLineswith0Qty;
            StockAdjust.Connection.CommitTransaction;

            if SAOriginalno <> '' then begin
              if pos(' and P.partsId = ' , qry.SQL.text) >0 then
                s:= 'Quantity Allocted to Any bin other than the Default Bin of the Product  is allocated to the Default Bin of the Product.' +
                                        NL+NL+'The Original no of the Stock Adjustment: ' +SAOriginalno +
                                        NL +NL +'Please make sure the stock adjustment is processed.'
              else
                s:=  qryProductProductPrintName.asString+  '''s Quantity Allocted to Any Bin other than the Default Bin ' + qryProductClassDefaultbinlocation.asString +' in Department ' +
                                    qryProductClassClassName.asString + ' is allocated to the Default Bin :' + qryProductClassDefaultbinlocation.asString +'.' +
                                        chr(13)+chr(13)+'The Original no of the Stock Adjustment: ' +SAOriginalno +

                                        chr(13) +Chr(13) +'Please make sure the stock adjustment is processed.';

              MessageDlgXP_Vista(s, mtInformation, [mbok], 0);
              OpenErpListform('TStockAdjustEntryListGUI' , beforeshowStockAdjustEntryList);
              Self.Close;
            end;
          finally
            StockAdjust.Free;
            if Qry.active then Qry.close;
            Freeandnil(Qry);
          end;
        end;
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
    end;
 finally
    EnableForm;
 end;
end;




procedure TfrmParts.pnlformulaEnter(Sender: TObject);
begin
  inherited;
  doCalcQtyformulaREadonly;
end;
procedure TfrmParts.pnlOptionsEnter(Sender: TObject);
begin
  inherited;
   if not PresaveProduct then exit;
end;

procedure TfrmParts.DoCalcQtyformulaREadonly;
begin

end;


procedure TfrmParts.cboProcessStepCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  EditDB(QryPartsProcess);
  QryPartsProcessProcessStepID.asInteger := qryProcessStepID.asInteger;
end;

procedure TfrmParts.grdPartsProcessExit(Sender: TObject);
begin
  inherited;
  PostDB(QryPartsProcess);
end;

procedure TfrmParts.QryPartsProcessBeforeInsert(DataSet: TDataSet);
begin
  With TempMyQuery do try
    connection := QryPartsProcess.connection;
    SQL.text := 'Select max(ProcessStepSeq) as ProcessStepSeq from tblProcessPart where PartId = ' + intToStr(qryProductPARTSID.asInteger);
    open;
    if recordcount =0 then else  fiseq := FieldByname('ProcessStepSeq').asInteger;
  finally
    if active then close;
    free;
  end;
end;

procedure TfrmParts.QryPartsProcessBeforePost(DataSet: TDataSet);
begin
  inherited;
  if QryPartsProcessProcessStep.asString = '' then abort;
end;

procedure TfrmParts.qryPartPicsBeforeDelete(DataSet: TDataSet);
var
  msg: string;
begin
  inherited;
  if not TDeletedItem.AddDeleted('tblPartsPics','TProductPicture',qryPartPicsGlobalRef.AsString, qryPartPicspartpicID.ASInteger,qryPartPics.Connection, msg, false, qryProductGlobalRef.AsString) then begin
    CommonLib.MessageDlgXP_Vista('Unable to delete picture.' + #13#10 + #13#10 + msg, mtInformation,[mbOk],0);
    Abort;
  end;
end;

procedure TfrmParts.qryPartPicsBeforePost(DataSet: TDataSet);
var
  strSQL:String;
  qry: TERPQuery;
begin
  qryPartPicsmsUpdateSiteCode.AsString:= AppEnv.Branch.SiteCode;
  if (qryPartPicsGlobalRef.AsString = '') and (qryPartPicsPartPicID.AsInteger > 0) then
    qryPartPicsGlobalRef.AsString:= AppEnv.Branch.SiteCode + IntToStr(qryPartPicsPartPicID.AsInteger);

  if qryPartPicsIsDefault.asBoolean then begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := myConnection;
      qry.SQL.Add('update tblpartspics set IsDefault = "F"  where partId = ' +IntToStr(qryProductPARTSID.asInteger));
      qry.SQL.Add('and IsDefault ="T" and `partpicID` <> '+IntToStr(qryPartPicspartID.asInteger));
      qry.Execute;
    finally
      qry.Free;
    end;

  end else begin
    strSQL:= ' select * from tblpartspics where partId = ' +IntToStr(qryProductPARTSID.asInteger) +
              ' and IsDefault ="T" and `partpicID` <> '+IntToStr(qryPartPicspartID.asInteger);
     with GetNewDatasetinTransaction(StrSQL) do try
      if recordcount = 0 then begin
        EditDb(qryPartPics);
        qryPartPicsIsDefault.asBoolean := True;
      end;
    finally
        if active then close;
        Free;
    end;
  end;
end;


procedure TfrmParts.qryPartBarCodesIsprimaryBarcodeChange(Sender: TField);
begin
  inherited;
  PostDB(qryPartBarCodes);
end;

procedure TfrmParts.chkShowInactiveBarcodesClick(Sender: TObject);
begin
  inherited;
  qryPartBarCodes.Filtered:= false;
  if chkShowInactiveBarcodes.Checked then begin
    qryPartBarCodes.Filter:= '';
  end
  else begin
    qryPartBarCodes.Filter:= 'Active = "T"';
    qryPartBarCodes.Filtered:= true;
  end;
  RefreshBarcodeGrid;
end;

procedure TfrmParts.RefreshBarcodeGrid;
begin
  if chkShowInactiveBarcodes.Checked then begin
    grdAltBarcodes.AddField('Active');
    grdAltBarcodes.ColumnByName('Barcode').DisplayWidth:=
      grdAltBarcodes.ColumnByName('Barcode').DisplayWidth - 6;
  end
  else begin
    grdAltBarcodes.RemoveField('Active');
    grdAltBarcodes.ColumnByName('Barcode').DisplayWidth:=
      grdAltBarcodes.ColumnByName('Barcode').DisplayWidth + 6;
  end;
  grdAltBarcodes.Refresh;
end;

procedure TfrmParts.cboDefaultBin4classNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
  Accept := True;
end;

procedure TfrmParts.cboDefaultBinNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
  Accept := true;
end;

procedure TfrmParts.cboINCOMEACCEnter(Sender: TObject);
begin
  inherited;
  SaveAccessLevel := AccessLevel;
  AccessLevel := 1;
end;

procedure TfrmParts.cboINCOMEACCExit(Sender: TObject);
begin
  inherited;
  PostDB(qryProduct);
  AccessLevel := SaveAccessLevel;
end;

procedure TfrmParts.cboDefaultBinExit(Sender: TObject);
begin
  inherited;
  EditDB(qryProductClass);
  if TwwDbLookupcombo(Sender).Text = '' then qryProductClassDefaultbinId.asInteger := 0
  else qryProductClassDefaultbinId.asInteger := QryBinsBinID.asInteger;
end;
Procedure TfrmParts.RefreshProductPic(DataSet: TDataSet);
var
  sl: TStringList;
  OnClickCheck: TNotifyEvent;
  x: integer;
begin
  ImagesLib.RefreshDsImage(DataSet, 'partPic', 'Pictype' , imagePart,  pnlImage , pnlPicturetype);
  sl := TStringList.Create;
  OnClickCheck := lstImageTypes.OnClickCheck;
  lstImageTypes.OnClickCheck := nil;
  try
    sl.CommaText := qryPartPicsImageTypes.AsString;
    for x := 0 to lstImageTypes.Count -1 do begin
      lstImageTypes.Checked[x] := slPictureCodes.IndexOfObject(lstImageTypes.Items.Objects[x]) >= 0;
    end;

  finally
    sl.Free;
    lstImageTypes.OnClickCheck := OnClickCheck;
  end;
end;

procedure TfrmParts.qryPartPicsAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshProductPic(DataSet);
end;

procedure TfrmParts.qryPartPicsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshProductPic(DataSet);
end;

procedure TfrmParts.qryPartPicsAfterPost(DataSet: TDataSet);
begin
  inherited;
  //
end;

function TfrmParts.GetNewDatasetinTransaction(const strSql: String): TCustomMyDataset;
begin
  result := CommonDbLib.TempMyQuery;
  REsult.Connection := Self.MyConnection;
  Result.SQL.add(strSQL);
  REsult.open;
end;


procedure TfrmParts.CopySerialNumber1Click(Sender: TObject);
var
  s:String;
begin
  inherited;
  if (QrySerialnoSerialnumber.asSTring <> '') then begin
    s:= Barcode_Prefix_PQASN +Barcode_SepChar + trim(inttostr(QrySerialnoPartsId.AsInteger))+Barcode_SepChar + QrySerialnoSerialnumber.asSTring ;
    Clipboard.asText := s;
    Logtext(s);

  end;
end;

Procedure TfrmParts.CostPriceMarkupCalc(Sender: TField);
var
  New_Value:Double;
begin
    if (Sysutils.SameText(Sender.fieldname, 'Sell_Cost_Percentage')) then begin
        if QryProductcost1.asfloat <> 0 then begin
          CalcPriceformarkup;
        end else if qryProductPRICE1.asFloat <> 0 then begin
          CalcCostformarkup;
        end;
    end else if (Sysutils.SameText(Sender.fieldname, 'PRICEINC1')) or
        (Sysutils.SameText(Sender.fieldname, 'PRICE1')) then begin
        if QryProductcost1.asfloat <> 0 then begin
          CalcmarkupforPrice;
        end else begin
          CalcCostformarkup;
        end;
    end else if (Sysutils.SameText(Sender.fieldname, 'COST1')) or
        (Sysutils.SameText(Sender.fieldname, 'COSTINC1')) then begin
        New_Value := Sender.Value;

        if ((Sender = qryProductCost1) and (Cost1OldValue < New_Value)) or ((Sender = qryProductCostInc1) and (CostInc1OldValue < New_Value)) then
          if  QryProductOnCostIncrease.asBoolean then
            CalcPriceformarkup
          else
            CalcmarkupforPrice;
        if ((Sender = qryProductCost1) and (Cost1OldValue > New_Value)) or ((Sender = qryProductCostInc1) and (CostInc1OldValue > New_Value)) then
          if QryProductOnCostDecrease.asBoolean  then
            CalcPriceformarkup
          else
            CalcmarkupforPrice;

    end;
end;
Procedure TfrmParts.CalcmarkupforPrice;
begin
  if QryproductPRICE1.asfloat = 0 then begin
     CalcPriceformarkup;
  end else if  QryProductcost1.asfloat = 0 then begin
     Calccostformarkup;
  end else begin
    CalPriceCostPercent(3);
  end;
end;
Procedure TfrmParts.CalcCostformarkup;
begin
  if qryProductSell_Cost_Percentage.asFloat = 0 then Exit;
  CalPriceCostPercent(1);
end;


procedure TfrmParts.CalcPriceformarkup;
begin
  if qryProductSell_Cost_Percentage.asFloat = 0 then Exit;
  CalPriceCostPercent(2);
end;

procedure TfrmParts.CalPriceCostPercent(calcfield: Integer);
begin
  QryProduct.DisableControls;
  AddFlag('PriceChange');
  AddFlag('CostChange');
  TRY
    EditDB(QryProduct);
    try
    if calcfield = 1 then begin
      if QryProductGrossMarginMode.asString = 'T' then begin  {cost from markup}
        QryProductcost1.asFloat := CommonLib.Round(TProduct.calccostfromMarkup(QryproductPRICE1.asFloat,qryProductSell_Cost_Percentage.asFloat), tcConst.GeneralRoundPlaces);
        QryProductcost2.asFloat := CommonLib.Round(TProduct.calccostfromMarkup(QryproductPRICE2.asFloat,qryProductSell_Cost_Percentage.asFloat), tcConst.GeneralRoundPlaces);
        QryProductcost3.asFloat := CommonLib.Round(TProduct.calccostfromMarkup(QryproductPRICE3.asFloat,qryProductSell_Cost_Percentage.asFloat), tcConst.GeneralRoundPlaces);
      end else begin    {cost from gross}
        QryProductcost1.asFloat := CommonLib.Round(TProduct.CalccostfromGross(QryproductPRICE1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
        QryProductcost2.asFloat := CommonLib.Round(TProduct.CalccostfromGross(QryproductPRICE2.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
        QryProductcost3.asFloat := CommonLib.Round(TProduct.CalccostfromGross(QryproductPRICE3.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
      end;
      qryProductcostinc1.AsFloat := CommonLib.Round(GetAmountinc(qryProductcost1.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
      qryProductcostinc2.AsFloat := CommonLib.Round(GetAmountinc(qryProductcost2.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
      qryProductcostinc3.AsFloat := CommonLib.Round(GetAmountinc(qryProductcost3.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
    end else if calcfield =2 then begin
      if QryProductGrossMarginMode.asString = 'T' then begin{price from markup}
        QryproductPRICE1.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
        QryproductPRICE2.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost2.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
        QryproductPRICE3.asFloat := CommonLib.Round(TProduct.calcPricefromMarkup(QryProductcost3.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
      end else begin   {price from gross}
        QryproductPRICE1.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost1.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
        QryproductPRICE2.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost2.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
        QryproductPRICE3.asFloat := CommonLib.Round(TProduct.CalcPricefromGross(QryProductcost3.asFloat,(qryProductSell_Cost_Percentage.asFloat)), tcConst.GeneralRoundPlaces);
      end;
      qryProductPRICEinc1.AsFloat := CommonLib.Round(GetAmountinc(qryProductPRICE1.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
      qryProductPRICEinc2.AsFloat := CommonLib.Round(GetAmountinc(qryProductPRICE2.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
      qryProductPRICEinc3.AsFloat := CommonLib.Round(GetAmountinc(qryProductPRICE3.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
    end else if calcfield = 3 then begin
      RecalculateMargins;
    end;
    if qrySellPrices.Active then begin
      if (not qryProductLockExtraSell.AsBoolean) then ResetExtraSellPrice;
      SellQty_Prices;
      if qrySellPrices.State in [dsEdit, dsInsert] then qrySellPrices.Post;
    end;

    if QryProductclass.Active then begin
      ResetVariantPrice;
      if QryProductclass.State in [dsEdit, dsInsert] then QryProductclass.Post;
    end;
    except
        //kill the exception
    end;
    PostDB(QryProduct);
    EditDB(QryProduct);
  FINALLY
      RemoveFlag('PriceChange');
      RemoveFlag('CostChange');
      QryProduct.EnableControls;
  END;
end;
Procedure TfrmPArts.RecalculateMargins;
begin
  if fbPricechanged then exit;  // when price is changed, percentage is already calculated

      if QryProductGrossMarginMode.asString = 'F' then begin{markup}
        qryProductSell_Cost_Percentage.asFloat :=CommonLib.Round(TProduct.CalcGrossMarginPerc( QryProductcost1.asFloat,qryProductPRICE1.AsFloat), tcConst.GeneralRoundPlaces);
      end else begin{gross}
        qryProductSell_Cost_Percentage.asFloat :=CommonLib.Round(TProduct.calcMarkupPercent( QryProductcost1.asFloat,qryProductPRICE1.AsFloat), tcConst.GeneralRoundPlaces);
      end;
end;
procedure TfrmParts.rgMarkupTypeClick(Sender: TObject);
begin
  inherited;
  if rgMarkupType.itemindex = 0 then begin
    rgMarkupType.Value := 'T' ;
    QryProductGrossMarginMode.asString:= 'T';
  end else begin
    rgMarkupType.Value := 'F' ;
    QryProductGrossMarginMode.asString:= 'F';
  end;
  PostDB(QryProduct);
  EditDB(QryProduct);
  CalPriceCostPercent(3);
  EditDB(QryProduct);
end;

procedure TfrmParts.qryProductGrossMarginModeChange(Sender: TField);
begin
  inherited;
  ValidateProductcostPrice(Sender);
end;

procedure TfrmParts.qryProductGrossMarginModeSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  if QryProductGrossMarginMode.asString = 'F' then
    if qryProductSell_Cost_Percentage.asFloat >=100 then begin
      MessageDlgXP_Vista('Goss margin should be less than 100' , mtWarning, [mbok], 0);
      qryProductSell_Cost_Percentage.asFloat := 99;
    end;
end;
procedure TfrmParts.AdjustAllProductBins(Emptybin :Boolean =False);
var
  s:String;
  ExitResult: Word;
begin
  DisableForm;
  try
    if DataHasChanged then begin
      SaveButtonClicked := 1; // Reset SavedButtonClicked
      s :=  'This will close the Product Form.' +chr(13) +
            'Do you wish to keep these changes you Have Made?';
      ExitResult := MessageDlgXP_Vista(s, mtWarning, [mbYes, mbNo, mbCancel], 0);
      case ExitResult of
        mrYes: if not SaveProduct then Exit
               else BeginTransaction;
        mrNo: begin
                ShowWindow(Handle, SW_HIDE);
                Application.ProcessMessages;
                RollbackTransaction;
              end;
        mrCancel: Exit;
      end;
    end else begin
      RollbackTransaction;
    end;
      if ProductQtyAdjobj.AdjustAllProductBins(Emptybin) then
        Self.Close;
  finally
    EnableForm;
  end;

end;


procedure TfrmParts.LoadqryUnitsOfMeasureQtys;
begin
  closedb(qryUnitsOfMeasureQtys);
  qryUnitsOfMeasureQtys.SQL.text := StringReplace(qryUnitsOfMeasureQtys.SQL.text , '0.0 as AvailableQtyinUOM' , SQL4Qty(tAvailable, 'PQA' , 'PQA.UOMQTY')+' as AvailableQtyinUOM ' , [rfIgnoreCase]);
end;

procedure TfrmParts.qryForeignPricePriceGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if sender is TFloatField then
    Text:= ForeignCurrency.CachedSymbolForId(qryForeignPriceCurrencyId.AsInteger) +
      FormatFloat(TFloatField(Sender).DisplayFormat,Sender.AsFloat);
end;

procedure TfrmParts.qryForeignPriceSellPriceGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if sender is TFloatField then
    Text:= ForeignCurrency.CachedSymbolForId(self.qryForeignPriceSellCurrencyId.AsInteger) +
      FormatFloat(TFloatField(Sender).DisplayFormat,Sender.AsFloat);
end;



procedure TfrmParts.qryimportProductAfterScroll(DataSet: TDataSet);
begin
  inherited;
  closedb(qryImportProducts);
  Opendb(qryImportProducts);
  clog(qryImportProducts.Sqltext);

end;

procedure TfrmParts.qryimportProductBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (qryimportProductCountryOfOriginId.asinteger =0) and
      (qryimportProductSupplierId.asinteger =0) and
      (qryimportProductDuty.asfloat =0) and
      (qryimportProductHandling.asfloat =0) then Canceldb(qryimportProduct);

end;

procedure TfrmParts.qryimportProductCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryimportProductDetails.asString := 'Country : ' + TRim(qryimportProductCountry.asString)+', Supplier : ' + Trim(qryimportProductSupplier.asString);
end;

procedure TfrmParts.Ontabcommission(Sender: TObject);
begin
  CreateHistorylistform('TProductCommissionListGUI' ,Self, ProductCommissionList);
  if not(Assigned(ProductCommissionList)) then exit;
    ProductCommissionList.Parent := pnlcommission;
    ProductCommissionList.borderstyle := bsNone;
    ProductCommissionList.FilterString := 'PartsID= ' + IntToStr(KeyID);
    ProductCommissionList.Show;
    with TProductCommissionListGUI(ProductCommissionList) do begin
      grdMain.PopupMenu          := ProductCommissionList.mnuFilter;
    end;
end;

procedure TfrmParts.onTabtabInTrans(Sender: TObject);
begin
  if QryInTransation.active then exit;

  QryInTransation.DisableControls;
  try
    closedb(QryInTransation);

    showProgressbar('Populating Average Cost Value' , 6);
    try
    With commondblib.TempMyScript do try
      SQL.add('Drop table if exists ' +ProductInTransTablename +';');
      SQL.add('create table ' + ProductInTransTablename +' ' + TProduct.InTRansSQL(qryProductPARTSID.asInteger));
      SQL.add('Alter table ' +ProductInTransTablename +' add column   InStockItem enum("T","F") default "F";');
      SQL.add('Alter table ' +ProductInTransTablename +' add column   InStockQty Double;');
      SQL.add('Alter table ' +ProductInTransTablename +' add column   InStockValue Double;');
      SQL.add('ALTER TABLE ' +ProductInTransTablename +' ADD COLUMN `ID` int not NULL AUTO_INCREMENT , ADD PRIMARY KEY(`ID`)');
      BeforeExecute := dobeforeExecute;
      logtext(SQL.text);
      Execute;
    finally
        Free;
    end;
    finally
        HideProgressbar;
    end;
    Opendb(QryInTransation);
  finally
      QryInTransation.enablecontrols;
  end;
end;

procedure TfrmParts.QryInTransationAfterOpen(DataSet: TDataSet);
var
  QtyOnHand:Double;
begin
try
  inherited;
  InTransTotQty:=0;
  InTransTotCost:=0;
  InTransInstockQty:=0;
  IntransInstockValue:=0;
  intransLandedCostsPerItem:= 0;
  if QryInTransation.recordcount = 0 then exit;
    TDateTimeField(QryInTransationOrderedDates).DisplayFormat := FormatSettings.ShortDateformat;
    TFloatField(QryInTransationLineCost).displayformat :=AppEnv.RegionalOptions.CurrencySymbol + '#,###,###,###,###,##0.00000';

    QryInTransation.first;
    QtyOnHand := TProduct.CalcTotalQtyInStock(QryProductPartsID.asInteger);

    while (QryInTransation.Eof = False) and (QtyOnHand>0) do begin
      if QryInTransationShipped.asFloat >0 then begin
        EditDB(QryInTransation);
        QryInTransationInStockItem.asBoolean :=QtyOnHand>0;
        if QtyOnHand <=QryInTransationShipped.asFloat then
          QryInTransationInStockQty.asFloat :=QtyOnHand
        else QryInTransationInStockQty.asFloat:= QryInTransationShipped.asFloat;
        QryInTransationInStockValue.asFloat :=QryInTransationInStockQty.asFloat*QryInTransationLineCost.asFloat;
        postDB(QryInTransation);
        QtyOnHand := QtyOnHand -QryInTransationShipped.asFloat;
      end;
      QryInTransation.Next;
    end;

    QryInTransation.first;
    while QryInTransation.Eof = False do begin
      InTransTotQty       := InTransTotQty      + QryInTransationShipped.asFloat;
      InTransTotCost      := InTransTotCost     + QryInTransationShipped.asFloat * QryInTransationLineCost.asFloat;
      InTransInstockQty   := InTransInstockQty  + QryInTransationInStockQty.asFloat;
      IntransInstockValue := IntransInstockValue+ QryInTransationInStockValue.asFloat;
      inTransLandedCostsPerItem := intransLandedCostsPerItem +QryInTransationShipped.asFloat * QryInTransationLandedCostsPerItem.asFloat;
      QryInTransation.Next;
    end;
finally
  QryInTransation.first;
end;
end;

procedure TfrmParts.btnRecalculateAvgcostClick(Sender: TObject);
begin
  inherited;
    EditDB(qryProduct);
    qryProductAvgCost.asFloat :=TProduct.CalcAvgCost(qryProductPARTSID.asInteger);
    PostDB(qryProduct);
end;

procedure TfrmParts.btnRefreshClick(Sender: TObject);
begin
  inherited;
  refreshProductAllocationForm;
end;

procedure TfrmParts.btnReorderPointsClick(Sender: TObject);
begin
  if not SaveProduct then Exit;
  self.CommitTransaction;
  try
    if qryProductClass.FieldByName('ProductId').AsInteger =0 then begin
      MessageDlgXP_Vista('Please create a Product with at least one department', mtWarning, [mbOK], 0);
      exit;
    end;
    OpenERPFormModal('TfmProductReorderPoints' , KeyId , beforeshowReorderPoints);
  finally
    closedb(qryProductClass);
    Opendb(qryProductClass);
    self.BeginTransaction;
    if not UserLock.Lock('tblParts',KeyId,Self.Caption) then begin
        AccessLevel:= 5; // read only
        MessageDlgXP_Vista(UserLock.LockMessage+#13+#10+#13+#10+'Access has been changed to read-only.', mtWarning, [mbOK], 0);
    end;
  end;
end;
procedure TfrmParts.beforeshowReorderPoints(Sender: TObject);
begin
  if Sender is TfmProductReorderPoints then
  begin
    TfmProductReorderPoints(Sender).ClassId := qryProductClass.FieldByName('ClassId').AsInteger;
    TfmProductReorderPoints(Sender).ProductId := qryProductClass.FieldByName('ProductId').AsInteger;
  end;

end;

procedure TfrmParts.ontabTabProductMovement(Sender: TObject);
begin
  PageMovements.ActivePageIndex:= 0;
  PageMovementsChange(PageMovements);
end;
procedure TfrmParts.WriteProductMovementGuiPres;
begin
      GuiPrefs.Node['Productmovement.TopPanel.Height'].asInteger                      := PageMovements.Height;
      GuiPrefs.Node['Productmovement.SalesMovement.DateFrom'].AsDateTime              := dtpFrom.Date;
      GuiPrefs.Node['Productmovement.SalesMovement.DateTo'].AsDateTime                := dtpTo.Date;
      GuiPrefs.Node['Productmovement.SalesMovement.BaseonShipped'].AsBoolean          := chkBaseOnShipped.Checked;
      GuiPrefs.Node['Productmovement.PurchaseMovement.DateFrom'].AsDateTime           := dtpPurchTo.Date;
      GuiPrefs.Node['Productmovement.PurchaseMovement.DateTo'].AsDateTime             := dtpPurchFrom.Date;
      GuiPrefs.Node['Productmovement.PurchaseMovement.BaseOnInvoiceDate'].AsBoolean   := chkBasePurchOn.Checked;
      GuiPrefs.Node['Productmovement.ManufactureMovement.DateFrom'].AsDateTime        := dtpFromMan.Date;
      GuiPrefs.Node['Productmovement.ManufactureMovement.DateTo'].AsDateTime          := dtpToMan.Date;
      GuiPrefs.Node['Productmovement.AverageCostCalc.StockCostSystemIndex'].AsInteger := stockCostSystem.ItemIndex;
      GuiPrefs.Node['Productmovement.AverageCostCalc.IncludeLandedCost'].AsBoolean    := chkincludelandedcost.Checked;
end;

Procedure TfrmParts.ReadProductMovementGuiprefs(const Tabindex:Integer);
begin
  if Tabindex =-1 then begin
    if GuiPrefs.Node.Exists('Productmovement.TopPanel.Height') then begin
      PageMovements.Height := GuiPrefs.Node['Productmovement.TopPanel.Height'].asInteger;
    end;
  end else if TabIndex = 0 then begin
    if GuiPrefs.Node.Exists('Productmovement.SalesMovement') then begin
      try
        dtpFrom.Date  := GuiPrefs.Node['Productmovement.SalesMovement.DateFrom'].AsDateTime;
        dtpTo.Date    := GuiPrefs.Node['Productmovement.SalesMovement.DateTo'].AsDateTime;
        chkBaseOnShipped.Checked:= GuiPrefs.Node['Productmovement.SalesMovement.BaseonShipped'].AsBoolean;
      except
        dtpFrom.Date  := IncYear(StartOfTheMonth(Date()), -1);
        dtpTo.Date    := EndOfTheMonth(Date());
      end;
    end else begin
      dtpFrom.Date  := IncYear(StartOfTheMonth(Date()), -1);
      dtpTo.Date    := EndOfTheMonth(Date());
    end;
  end else if TabIndex = 1 then begin
    if GuiPrefs.Node.Exists('Productmovement.PurchaseMovement') then begin
      try
        dtpPurchTo.Date  := GuiPrefs.Node['Productmovement.PurchaseMovement.DateFrom'].AsDateTime;
        dtpPurchFrom.Date    := GuiPrefs.Node['Productmovement.PurchaseMovement.DateTo'].AsDateTime;
        chkBasePurchOn.Checked:=  GuiPrefs.Node['Productmovement.PurchaseMovement.BaseOnInvoiceDate'].AsBoolean;
      except
        dtpPurchTo.Date := EndOfTheMonth(Date());
        dtpPurchFrom.Date := IncYear(StartOfTheMonth(Date()), -1);
      end;
    end else begin
      dtpPurchTo.Date := EndOfTheMonth(Date());
      dtpPurchFrom.Date := IncYear(StartOfTheMonth(Date()), -1);
    end;
  end else if TabIndex = 2 then begin
    if GuiPrefs.Node.Exists('Productmovement.ManufactureMovement') then begin
      try
        dtpFromMan.Date  := GuiPrefs.Node['Productmovement.ManufactureMovement.DateFrom'].AsDateTime;
        dtpToMan.Date    := GuiPrefs.Node['Productmovement.ManufactureMovement.DateTo'].AsDateTime;
      except
        dtpFromMan.Date := IncYear(StartOfTheMonth(Date()), -1);
        dtpToMan.Date :=EndOfTheMonth(Date());
      end;
    end else begin
      dtpFromMan.Date := IncYear(StartOfTheMonth(Date()), -1);
      dtpToMan.Date :=EndOfTheMonth(Date());
    end;
  end else if TabIndex = 3 then begin
    if GuiPrefs.Node.Exists('Productmovement.AverageCostCalc') then begin
      stockCostSystem.ItemIndex := GuiPrefs.Node['Productmovement.AverageCostCalc.StockCostSystemIndex'].AsInteger;
      chkincludelandedcost.Checked:=  GuiPrefs.Node['Productmovement.AverageCostCalc.IncludeLandedCost'].AsBoolean;
    end;
  end;
end;

procedure TfrmParts.grdIntransDblClick(Sender: TObject);
begin
  inherited;
       if QryInTransationType.asString = 'PO'     then OpenERPFormModal('TPurchaseGUI'   , QryInTransationtransID.asInteger)
end;

procedure TfrmParts.grdIntransDrawFooterCell(Sender: TObject;
  Canvas: TCanvas; FooterCellRect: TRect; Field: TField;
  FooterText: String; var DefaultDrawing: Boolean);
begin
  inherited;
  grdIntrans.ColumnByName('LineCost').FooterValue :=FloatToStrF(InTransTotCost, ffCurrency, 15, CurrencyRoundPlaces);
  grdIntrans.ColumnByName('Shipped').FooterValue :=FloatToStrF(InTransTotQty , ffNumber, 15,2);
  grdIntrans.ColumnByName('InStockQty').FooterValue :=FloatToStrF(InTransInstockQty , ffNumber, 15,2);
  grdIntrans.ColumnByName('InStockValue').FooterValue :=FloatToStrF(IntransInstockValue , ffCurrency, 15,2);
  grdIntrans.ColumnByName('LandedCostsPerItem').FooterValue :=FloatToStrF(IntransLandedCostsPerItem , ffCurrency, 15,2);
end;

procedure TfrmParts.grdLatestCostCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (QryLatestCostNo.asInteger =1) and (QryLatestCostIgnoreSupplierforProductLatestCost.asBoolean = False) then begin
    if Sametext(Field.fieldname , QryLatestCostLineCost.fieldname)  then begin
      Afont.color := clred;
      Afont.Style := Afont.Style +[fsBold];
    end;
  end else if QryLatestCostIgnoreSupplierforProductLatestCost.asBoolean then begin
    Afont.color :=Inactivefontcolor;
  end else if QryLatestCostInvoiceDate.asDateTime =0 then begin
    Afont.color :=Inactivefontcolor;
  end;
end;

procedure TfrmParts.grdIntransCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QryInTransationInStockItem.asBoolean then AFont.Color := clRed;
end;

procedure TfrmParts.LoadIntrans;
begin
  ProductInTransTablename := CommonDbLib.GetUserTemporaryTableName('Intrans');
  closedb(QryInTransation);
  QryInTransation.SQL.clear;
  QryInTransation.SQL.add('select * from ' +ProductInTransTablename+ ' order by OrderedDates desc');
  {$IFDEF DevMode}
    btnRecalculateAvgcost.visible := true;
  {$ELSE}
    btnRecalculateAvgcost.visible := False;
  {$ENDIF}

  case AppEnv.CompanyPrefs.StockCostSystem of
      scsFIFO:stockCostSystem.itemindex := 0;
      scsLast:stockCostSystem.itemindex := 1;
      scsAvg :stockCostSystem.Itemindex := 2;
      else    stockCostSystem.Itemindex := -1;
    end;
  chkincludelandedcost.checked := AppEnv.CompanyPrefs.IncludeLandedCostsinAvgCost ;
end;

procedure TfrmParts.QryInTransationCalcFields(DataSet: TDataSet);
begin
  inherited;
       if QryInTransationType.asString = 'PO'       then QryInTransationTranstype.asString := 'Purchase Order'
  else if QryInTransationType.asString = 'ST'       then QryInTransationTranstype.asString := 'Stock Adjustment'
  else if QryInTransationType.asString = 'MANUF'    then QryInTransationTranstype.asString := 'Manufacture'
  else if QryInTransationType.asString = 'PROCPROG' then QryInTransationTranstype.asString := 'Progress Build';
end;

procedure TfrmParts.QryLatestCostBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryLatestCost.parambyname('ProductId').asInteger:= qryProductPARTSID.asInteger ;
end;

procedure TfrmParts.dobeforeExecute(Sender: TObject;
  var SQL: String; var Omit: Boolean);
begin
  inherited;
  stepProgressbar;
end;

procedure TfrmParts.stockCostSystemEnter(Sender: TObject);
begin
  inherited;
  SetControlFocus(grdIntrans);
end;

procedure TfrmParts.edtAvgcostDblClick(Sender: TObject);
begin
  inherited;
  pageControl.ActivePage := TabProductMovement;
  if pageControl.ActivePage = TabProductMovement then begin
    PageMovements.ActivePage := tabInTrans;
    PageMovementsChange(PageMovements);
  end;
end;

procedure TfrmParts.DBEdit1DblClick(Sender: TObject);
begin
  inherited;
  with TUnitsOfMeasureGUI(GetComponentByClassName('TUnitsOfMeasureGUI') ) do try
    KeyID := qryUOMPurchaseUnitID.AsInteger;
    ShowModal;
    ClosenOpenDB(qryUnitsOfMeasureQtys);
    ClosenOpenDB(qryUOMPurchase);
    ClosenOpenDB(QryUOMSales);
  finally
    Free;
  end;
end;

procedure TfrmParts.edtsalesUOMDblClick(Sender: TObject);
begin
  inherited;
  with TUnitsOfMeasureGUI(GetComponentByClassName('TUnitsOfMeasureGUI') ) do try
    KeyID := qryUOMSalesUnitID.AsInteger;
    ShowModal;
    ClosenOpenDB(qryUnitsOfMeasureQtys);
    ClosenOpenDB(qryUOMPurchase);
    ClosenOpenDB(QryUOMSales);
  finally
    Free;
  end;
end;

procedure TfrmParts.edtSearchSNKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  QrySerialno.Locate(QrySerialnoSerialnumber.FieldName , trim(edtSearchSN.Text) , [loCaseInsensitive,loPartialKey]);
  if Key = vk_Return then Setcontrolfocus(grdSerials);
end;

procedure TfrmParts.chkDefaultPicClick(Sender: TObject);
begin
  inherited;
  if not chkDefaultPic.Focused then exit;
  if self.qryPartPics.RecordCount > 1 then begin


  end
  else begin
    if not chkDefaultPic.Checked then begin
      CommonLib.MessageDlgXP_Vista('There is only one picture for this product so it must be set as the Default Picture.', mtInformation, [mbOK], 0);
      chkDefaultPic.Checked := true;
    end;
  end;
end;

procedure TfrmParts.chkDiscontinuedClick(Sender: TObject);
begin
  inherited;
  if screen.activecontrol =chkDiscontinued then begin
    if Qryproductdiscontinued.asBoolean <>  chkDiscontinued.checked then begin
      EditDb(Qryproduct);
      Qryproductdiscontinued.asBoolean :=  chkDiscontinued.checked;
    end;
  end;
end;

procedure TfrmParts.chkEnableAutoSplitQtyintoUOMinSalesClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = chkEnableAutoSplitQtyintoUOMinSales then
    if chkEnableAutoSplitQtyintoUOMinSales.checked then
      if appenv.CompanyPrefs.EnableAutoSplitQtyintoUOMinSales =False then
        if MessageDlgXP_Vista('Preference ''Split the sales Quantity to different Unit of measures appropriate '' is turned off.'+NL+'Do you like to turn it on?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          appenv.CompanyPrefs.EnableAutoSplitQtyintoUOMinSales := True;
end;

procedure TfrmParts.chkHideOnPrintEnter(Sender: TObject);
begin
  SaveAccessLevel := AccessLevel;
  AccessLevel := 1;
end;

procedure TfrmParts.chkHideOnPrintExit(Sender: TObject);
begin
  PostDB(qryProduct);
  AccessLevel := SaveAccessLevel;
end;

procedure TfrmParts.chkisEquipmentClick(Sender: TObject);
begin
  inherited;

  if Screen.ActiveControl = chkisEquipment then
  begin
    if chkisEquipment.checked then
      if qryProductBatch.AsBoolean or qryProductMultipleBins.AsBoolean then begin
        MessageDlgXP_Vista('This is a Bin/Batch Product. Equipment Products cannot be Bin/Batch Enabled', mtWarning, [mbOK], 0);
        EditDB(qryProduct);
        chkMultipleBins.checked  := False;
        qryProductisEquipment.AsBoolean := False;
        PostDB(qryProduct);
        EditDB(qryProduct);
        Exit;
      end;

    try
      OpenEquipform;
    finally
      if qryProduct.active then EditDB(qryProduct);
    end;
  end;
end;



function TfrmParts.IsNewProduct: Boolean;
var
  Qry:TERPQuery;
begin
      Result := True;
      if qryProductPartsId.AsInteger =0 then Exit;

      qry := DbSharedObj.GetQuery(Commondblib.GetSharedMyDacConnection);
      try
        qry.SQL.Add('Select PartsId from tblparts where PartsId = ' + Inttostr(qryProductPartsId.AsInteger));
        qry.Open;
        Result := qry.fieldbyname('PartsId').AsInteger =0;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
end;

function TfrmParts.IsNewProductRec: Boolean;
begin
  {run query outside transaction to check for the new product}
  With commondbLib.TempMyQuery do try
    SQL.add('select PartsId from tblParts where PartsId = ' + IntToStr(qryProductPARTSID.asInteger));
    open;
    Result := recordcount =0;
  finally
      if active then close;
      Free;
  end;
end;
procedure TfrmParts.actAdjustThisProductbinbatchUpdate(Sender: TObject);
begin
  inherited;
  MnuAdjustAllocationThis.Enabled :=(chkMultipleBins.checked) and (Accesslevel<5);
end;
procedure TfrmParts.actEmptythisProductbinsUpdate(Sender: TObject);
begin
  inherited;
  MnuEmptyAllocationThis.Enabled :=(chkMultipleBins.checked) and (chkBatches.checked=False) and (chkSNTracking.checked=False) and (Accesslevel<5);
end;

procedure TfrmParts.actAdjustAllProductsBinBatchExecute(Sender: TObject);begin  inherited;  AdjustAllProductBins(False)  ;end;
procedure TfrmParts.actAdjustThisProductbinbatchExecute(Sender: TObject);begin  inherited;  AdjustThisProductbins(False) ;end;
procedure TfrmParts.actEmptyAllproductbinsExecute(Sender: TObject);begin  inherited;AdjustAllProductBins(TRue)   ;end;
procedure TfrmParts.actEmptythisProductbinsExecute(Sender: TObject);begin  inherited;AdjustThisProductbins(true)  ;end;

procedure TfrmParts.actEquipmentUpdate(Sender: TObject);
begin
  inherited;
  actEquipment.enabled := qryProductIsequipment.asBoolean and (Accesslevel<5);
end;

procedure TfrmParts.OpenCostStructureDoc(Sender: TObject);
begin
  TDocReaderObj.ShowERPHelp(nil, Self, TRue, 'BOM tree');
end;

procedure TfrmParts.OpenCustomerHistory(Sender: TObject);
var
  form: TSalesReportGUI;
begin
  Form := TSalesReportGUI.Create(Application);
  Form.productId :=KeyID;
  Form.FormStyle := fsMDIChild;
  form.BringToFront;
end;
Function TfrmParts.ProductEquipcount:Integer;
var
  Qry:TERPQuery;
begin
      Result := 0;
      if qryProductPartsId.AsInteger =0 then Exit;

      qry := DbSharedObj.GetQuery(Commondblib.GetSharedMyDacConnection);
      try
        qry.SQL.Add('Select count(EquipmentID) as ctr from tblequipment where ProductId = ' + Inttostr(qryProductPartsId.AsInteger));
        qry.Open;
        Result := qry.fieldbyname('ctr').AsInteger;
      finally
        DbSharedObj.ReleaseObj(qry);
      end;
end;
Procedure TfrmParts.beforeshowEquipmentList(Sender:TObject);
begin
  if not(Sender is   TEquipmentListGUI) then exit;
  TEquipmentListGUI(Sender).FilterString :='ProductId =' + inttostr(qryProductPARTSID.asInteger);
  TEquipmentListGUI(Sender).listTimerMsg('Product '+ Quotedstr(qryProductProductPrintName.asString)+' Has Multiple Equipment', nil, 30);
end;
procedure TfrmParts.OpenEquipform(Serialnumber:String='');
var
  EquipID:Integer;
begin
    if not chkisEquipment.checked then exit;

    EditDB(qryProduct);
    qryProductisEquipment.asBoolean := true;
    PostDB(qryProduct);
    if (Serialnumber = '') and (ProductEquipcount>1) then begin
        OpenErpListform('TEquipmentListGUI' , beforeshowEquipmentList);
        Exit;
    end;
    EquipID :=getEquipmentIdforProduct(qryProductPARTSID.asInteger , Serialnumber);
    if (EquipID =0) and (IsNewProductRec) then begin
      if MessageDlgXP_Vista('Do You Wish to Save Current Record and Open Equipment Form?' ,mtConfirmation, [mbYes, mbNo] , 0) = mrno then exit;
      if not SaveProduct then exit;
      CommitTransaction;
      BeginTransaction;
    end;
    if (EquipID =0) then EquipID:= TEquipment.CreateEquipment(qryProductPARTSID.asInteger, qryProductPARTNAME.asString,Serialnumber , nil, DoBusinessObjectEvent);
    if EquipID <> 0 then begin
      UserLock.Lock('tblParts',qryProductPARTSID.asInteger,Self.Caption) ; // just to make sure the product is locked if its a new product
      OpenERPForm('TfmEquip' ,EquipID , initEquipForm);
    end;
end;
procedure TfrmParts.OnSaveEquip(Sender:TObject);
begin
  IsHireProduct := tcdatautils.IsHireProduct(qryProductPartsID.asInteger);
end;
procedure TfrmParts.initEquipForm(Sender:TObject);
begin
  if (Sender is TfmEquip) then begin
      TfmEquip(Sender).OnSaveEquip := OnSaveEquip;
  end;
end;

procedure TfrmParts.EnableDisable;
var
  bEnabled: boolean;
begin
  inherited;
  bEnabled := AccessLevel < 5;
  cbobinbatchClass.enabled :=bEnabled;
  cboPartLevel3.enabled :=bEnabled;
  cboPartLevel2.enabled :=bEnabled;
  cboPartLevel1.enabled :=bEnabled;
  cboProduct.enabled :=bEnabled;
end;

procedure TfrmParts.ExtraPriceUOMCloseup(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  if filltable.State = dsCalcFields then exit;
  EditDB(Filltable);
  if InitUOM(Lookuptable.fieldbyname('UnitName').asString , Lookuptable)<>0 then begin
    filltable.fieldbyname('UOMID').asInteger      := Lookuptable.fieldbyname('UnitId').asInteger;
    filltable.fieldbyname('UOM').asString         := Lookuptable.fieldbyname('UnitName').asString;
    filltable.fieldbyname('UOMMultiplier').asfloat:= Lookuptable.fieldbyname('Multiplier').Asfloat;
  end else begin
    cancelDb(filltable);
  end;
  PostDB(Filltable);
  EditDB(Filltable);
end;
Procedure TfrmParts.DoFocusControl(Const FocusControltype:String);
begin
	if SameText(FocusControltype ,'PriceMatrix') then begin
		FocusPriceMatrix;
	end;
end;
procedure TfrmParts.FocusPriceMatrix;
begin
  if fbAftershowAutoFocusingToPage then exit;
  fbAftershowAutoFocusingToPage := true;
  try
    Pagecontrol.ActivePage := Extra_Sell_Price;
    pageControlChange(pageControl);
    PageControlsellprice.ActivePage := tabPriceMatrix;
    if assigned(PartsPriceMatrixform) then begin
      SetcontrolFocus(PartsPriceMatrixform.btnHowto);
      ShowTimedHint(PartsPriceMatrixform.btnHowto ,'Choose for the Help Doc', true , 5000);
    end;
  finally
    fbAftershowAutoFocusingToPage := False;
  end;
end;

function TfrmParts.InitUOM(const UOMName:String; UOMQry :Tdataset):Integer;
var
  Product:TProduct;
begin
  result:= 0;
  Product:=TProduct.Create(Self);
  try
    postdb(qryProduct);
    Product.Connection := TMyDacDataConnection.Create(product);
    Product.Connection.Connection := qryProduct.Connection;
    Product.Load(qryProductPARTSID.AsInteger);
    Product.UOMList.Closedb;
    Product.UOMList.OpenDb;
    if Product.ProductUOMLocate(UOMName)  then begin
       result:= Product.UOMList.ID;
       closedb(UOMQry);
       openDb(UOMQry);
       UOMQry.Locate('unitID' , result, []);
    end;
  finally
    Freeandnil(Product);
  end;
end;
procedure TfrmParts.qrySellPricesCalcFields(DataSet: TDataSet);
begin
  inherited;
  if (fbDiscountError) or (bUpdatingSellInfo) then exit;
  qrySellPricesCalcSellQty1.AsInteger := qryProductSellQTY1.AsInteger;
  qrySellPricesuomPrice1.asFloat := qrySellPricesUOMMultiplier.asFloat * qrySellPricesPrice1.asFloat;
end;

procedure TfrmParts.AddnewIfEmpty(Ds: TDataset);
begin
  if ds.recordcount = 0 then ds.Append;
end;

function TfrmParts.AllocationOptionsconfirmed: Boolean;
var
  s:String;
begin
  Result := True;
  {Dene wants the confirmation to be taken for new product only : Ashfords}
  if not IsNewProduct then exit;
  if not sametext(self.qryProductPARTTYPE.AsString , 'INV') then exit;

  if not(chkMultipleBins.Enabled) then exit;
  s:= 'Product ' +Quotedstr(qryProductProductPrintName.asString) +' has the following Allocation Parameters set.'+chr(13)+chr(13)+
    '    '+trim(replacestr(lblSNTracking.caption, '?', '')) +' : ' + BooleantoString(qryProductSNTracking.asBoolean)+chr(13)+
    '                 '+chkBatches.caption +' : ' + BooleantoString(QryProductBatch.asBoolean)+chr(13)+
    '                           ' +chkMultipleBins.caption +' : ' + BooleantoString(qryProductMultipleBins.asBoolean)+chr(13)+chr(13)+
    'After Creating any Transactions, these fields will not be editable.' +chr(13) +chr(13) +
    'Are you sure to save these Settings?';
  Result := MessageDlgXP_Vista(s, mtConfirmation, [mbYes, mbNo], 0) = mryes;
end;

procedure TfrmParts.grdForeignSellEnter(Sender: TObject);
begin
  inherited;
  if sender is TwwDBGrid then AddnewIfEmpty( TwwDBGrid(Sender).Datasource.Dataset);
end;


procedure TfrmParts.grdBuyPriceEnter(Sender: TObject);
begin
  inherited;
  if sender is TwwDBGrid then AddnewIfEmpty( TwwDBGrid(Sender).Datasource.Dataset);
end;

procedure TfrmParts.grdDutiesIButtonClick(Sender: TObject);
var
  fiid:Integer;
begin
  inherited;
  fiid:= qryimportProductid.asInteger;
  canceldb(qryimportProduct);
  if (qryimportProductid.asInteger = fiID) and (fiid<> 0) then
    qryimportProduct.delete;

end;

procedure TfrmParts.grdForeignEnter(Sender: TObject);
begin
  inherited;
  if sender is TwwDBGrid then AddnewIfEmpty( TwwDBGrid(Sender).Datasource.Dataset);
end;

procedure TfrmParts.qryExtraBuyPricePriceChange(Sender: TField);
begin


  if ispricechanging then exit;
  ispricechanging := true;
  try
    inherited;
    updateProductcostWithExtrabuyPrice;
    EditDB(qryExtraBuyPrice);
    qryExtraBuyPriceUOMPrice.asFloat := qryExtraBuyPriceUOMMultiplier.asfloat *
                                      qryExtraBuyPricePrice.asfloat;

    focusUOMPrice1;
  finally
      ispricechanging:= False;
  end;
end;

procedure TfrmParts.UpdateProductCostWithExtraBuyPrice;
begin
  if IsFlag('CostChange') then exit;
  if bUpdatingBuyInfo then exit;
  AddFlag('CostChange');
  try
    if (qryExtraBuyPriceSupplierId.asInteger = GetSupplierID(qryProduct.FieldByName('PREFEREDSUPP').AsString)) and
      (qryUOMPurchaseUnitID.asInteger = qryExtraBuyPriceUOMID.asinteger) then begin

        EditDb(qryProduct);
        qryProductBuyQTY1.AsInteger := qryExtraBuyPriceBuy1.AsInteger;
        qryProductCOST1.AsFloat := qryExtraBuyPricePrice.AsFloat;
        if (qryProductCOST2.AsFloat >  qryExtraBuyPricePrice.AsFloat) or
          ((QryProductbuyQty2.asfloat = 1) and (qryProductCOST2.AsFloat <>  qryExtraBuyPricePrice.AsFloat) )  then qryProductCOST2.AsFloat := qryExtraBuyPricePrice.AsFloat;
        if (qryProductCOST3.AsFloat >  qryExtraBuyPricePrice.AsFloat)  or
          ((QryProductbuyQty3.asfloat = 1) and (qryProductCOST3.AsFloat <>  qryExtraBuyPricePrice.AsFloat) )   then qryProductCOST3.AsFloat := qryExtraBuyPricePrice.AsFloat;
        qryProductcostINC1.AsFloat := CommonLib.Round(GetAmountInc(qryProductcost1.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
        qryProductcostINC2.AsFloat := CommonLib.Round(GetAmountInc(qryProductcost2.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
        qryProductcostINC3.AsFloat := CommonLib.Round(GetAmountInc(qryProductcost3.AsFloat, GetTaxRate(qryProductPURCHTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
    end;
  finally
    RemoveFlag('CostChange');
  end;
end;

procedure TfrmParts.qryForeignPriceSellCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryForeignPriceSellUOMPrice1.asFloat := qryForeignPriceSelluommultiplier.asFloat*
                                          qryForeignPriceSellPrice1.asfloat;
  if qryProduct.Active then
    qryForeignPriceSellSellPrice1.AsFloat := qryProductPRICE1.AsFloat;
end;

procedure TfrmParts.qryExtraBuyPriceCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryExtraBuyPriceUOMPrice.asFloat := qryExtraBuyPriceUOMMultiplier.asfloat *
                                      qryExtraBuyPricePrice.asfloat;
end;

procedure TfrmParts.qryForeignPriceCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryForeignPriceUOMPrice1.asfloat := qryForeignPricePrice1.asFloat *
                                      qryForeignPriceUOMMultiplier.asFloat;
end;


procedure TfrmParts.qrySellPricesAfterPost(DataSet: TDataSet);
begin
  inherited;
  if REcordEmpty(Dataset , 'ClientTypeName,Terms,Price1,UOM,QtyPercent1') then
    dataset.Delete;
end;

procedure TfrmParts.qryForeignPriceSellPrice1Change(Sender: TField);
begin
  inherited;
  if ispricechanging then exit;
  ispricechanging := true;
  try
    qryForeignPriceSellUOMPrice1.asFloat := qryForeignPriceSelluommultiplier.asFloat*
                                          qryForeignPriceSellPrice1.asfloat;
    focusUOMPrice1;
  finally
      ispricechanging:= False;
  end;
end;

procedure TfrmParts.focusUOMPrice1;
var
  grd:TwwDBGrid;
  fldname:String;
begin
  if not (screen.ActiveControl is TwwDBGrid) then exit;
  grd:= TwwDBGrid(screen.activecontrol);
  fldName :=TwwDBGrid(screen.activecontrol).getActivefield.FieldName;
  if grd.Datasource.dataset.findfield('UOMPrice1') <> nil then begin
    EditDb(qrySellPrices);
    grd.SetActiveField('UOMPrice1');
    grd.SetActiveField(fldname);
  end else if grd.Datasource.dataset.findfield('UOMPrice') <> nil then begin
    EditDb(qrySellPrices);
    grd.SetActiveField('UOMPrice');
    grd.SetActiveField(fldname);
  end;

end;


procedure TfrmParts.qrySellPricesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //
end;

procedure TfrmParts.qryForeignPriceSellAfterPost(DataSet: TDataSet);
begin
  inherited;

  if REcordEmpty(Dataset , 'Price1,Code') then
    dataset.Delete;
end;

procedure TfrmParts.qryExtraBuyPriceAfterPost(DataSet: TDataSet);
begin
  inherited;
  if REcordEmpty(Dataset , 'SupplierName,Price,UOM') then
    dataset.Delete;

end;

procedure TfrmParts.qryExtraBuyPriceBeforePost(DataSet: TDataSet);
begin
  inherited;

  if (qryExtraBuyPriceSupplierName.asString ='') and
     (qryExtraBuyPriceUOM.asString ='') and
     (qryExtraBuyPriceSupplierProductName.asString ='') and
     (qryExtraBuyPriceSupplierProductCode.asString ='') and
     (qryExtraBuyPricePrice.asFloat =0) and
     (qryExtraBuyPriceUOMPrice.asFloat =0) and
     (qryExtraBuyPriceMinimumOrderQty.asFloat =0) then begin
    Dataset.Cancel;
    Abort;
  end;
end;

procedure TfrmParts.qryForeignPriceAfterPost(DataSet: TDataSet);
begin
  inherited;
  if REcordEmpty(Dataset , 'SupplierName,CurrencyCode,Price1,UOM') then
    dataset.Delete;
end;

procedure TfrmParts.qrySellPricesUOMChange(Sender: TField);
begin
  inherited;
  if qrySellPrices.fieldbyname('UOM').asString = '' then begin
    EditDB(qrySellPrices);
    qrySellPrices.fieldbyname('UOMID').asInteger      := 0;
    qrySellPrices.fieldbyname('UOMMultiplier').asfloat:= 1;
  end;
end;

procedure TfrmParts.QrySerialnoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  clog(QrySerialno.SQL.text);
  QrySerialnoreccount;
end;
Procedure TfrmParts.QrySerialnoreccount;
begin
  lblTotal.caption := 'Total Records : ' + inttostr(QrySerialno.recordcount);
  lblTotal.REfresh;
end;

procedure TfrmParts.wwDBGrid1Enter(Sender: TObject);
begin
  inherited;
  if qryPartNotes.recordcount = 0 then qryPartNotes.append;
end;


procedure TfrmParts.qryProductClassReOrderAmountSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  if not (Sender.DataSet.State in [dsEdit, dsInsert]) then exit;
  if (Text =' ') or (Text ='0') or (Text ='') or not(isnumeric(Text)) then begin
    MessageDlgXP_Vista('Re-Order Amount Cannot be 0.', mtInformation, [mbOK], 0);
    Sender.Asfloat:= 1;
  end else
  Sender.Asfloat := strtofloat(text);
end;

procedure TfrmParts.SetFocusToAccCombo(const AccComboNO: Integer);
begin
  case AccComboNO of
    1: Begin
         SetControlFocus(cboPartLevel1);
       end;
    2: Begin
         SetControlFocus(cboPartLevel2);
       end;
    3: Begin
         SetControlFocus(cboPartLevel3);
       end;
    4: Begin
         Setcontrolfocus(edtProductPrintName);
       end;
  end;

end;

procedure TfrmParts.setIsHireProduct(const Value: Boolean);
begin
  if fbIsHireProduct <> Value then begin
    fbIsHireProduct := value;
    RealignTabControl(MiscPageControl, 1);
  end;
end;

procedure TfrmParts.SetKeyString(const Value: string);
begin
  SetKeyString(TProduct, qryProduct, Value , 'Productprintname');
end;

procedure TfrmParts.cboPartLevel1Exit(Sender: TObject);
begin
  inherited;
  ProductTreeOrder;
  PostMessage(Self.Handle, WM_SetFocus, 2, 0);

end;

procedure TfrmParts.cboPartLevel3Exit(Sender: TObject);
begin
  inherited;
  PostMessage(Self.Handle, WM_SetFocus, 4, 0);

end;

procedure TfrmParts.ChangeMemoButtonColours;
begin
  if Length(qryProductPARTSDESCRIPTION_Memo.AsString) > 0 then
    btnLongSaleDesc.Color := $0077ff77
  else
    btnLongSaleDesc.Color := clBtnFace;

  if Length(qryProductPURCHASEDESC_Memo.AsString) > 0 then
    btnLongPurchDesc.Color := $0077ff77
  else
    btnLongPurchDesc.Color := clBtnFace;
end;

procedure TfrmParts.ChangePODefaultUOM(Sender: TObject);
begin
  inherited;
    if not userlock.LockAll('tblunitsofmeasure' , Self.Caption ) then begin
      MessageDlgXP_Vista(UOMLockMsg+chr(13)+chr(13) +'Whole UOM List Should be Locked to Change The Defaults.' , mtInformation, [mbok] , 0);
      exit;
    end;
  OpenERPListFormSingleselect('TUnitsOfMeasuregroupGUI' , AssignPODefaultUOM,AssignProductId);
end;

procedure TfrmParts.ChangeSalesDefaultUOM(Sender: TObject);
begin
  inherited;
  if not userlock.LockAll('tblunitsofmeasure' , Self.Caption ) then begin
      MessageDlgXP_Vista(UOMLockMsg+chr(13)+chr(13) +'Whole UOM List Should be Locked to Change The Defaults.' , mtInformation, [mbok] , 0);
      exit;
    end;
  OpenERPListFormSingleselect('TUnitsOfMeasuregroupGUI' ,  AssignSalesDefaultUOM ,AssignProductId);
end;

procedure TfrmParts.AssignPODefaultUOM(Sender: TwwDbGrid);
var
  UnitID:Integer;
  PartID:Integer;
  aUnitName:String;
  Multiplier:Double;
begin
  try
    ReadUOMGrid(Sender, UnitId,PartID,aUnitName,Multiplier);
    CreateDefaultUOM(UnitId,PartID,aUnitName,'PO', Multiplier);
    TBaseListingGUI(Sender.owner).close;
  Except
      //kill the exceptuion
  end;
end;
procedure TfrmParts.AssignSalesDefaultUOM(Sender: TwwDbGrid);
var
  UnitID:Integer;
  PartID:Integer;
  aUnitName:String;
  Multiplier:Double;
begin
  try
    ReadUOMGrid(Sender, UnitId,PartID,aUnitName,Multiplier);
    CreateDefaultUOM(UnitId,PartID,aUnitName,'Sales',Multiplier);
    TBaseListingGUI(Sender.owner).close;
  Except
      //kill the exceptuion
  end;
end;




procedure TfrmParts.ReadUOMGrid(Sender: TObject; var UnitId,  PartID: Integer;var xUnitName:String; var UOMMultiplier:Double);
begin
  UnitID:=0;
  PartID:=0;
  try
    if sender is twwdbgrid then begin
      if twwdbgrid(Sender).Datasource.Dataset.findfield('UnitID') <> nil then
        UnitID := twwdbgrid(Sender).Datasource.Dataset.findfield('UnitID').asInteger;
      if twwdbgrid(Sender).Datasource.Dataset.findfield('PartID') <> nil then
        PartID := twwdbgrid(Sender).Datasource.Dataset.findfield('PartID').asInteger;
      if twwdbgrid(Sender).Datasource.Dataset.findfield('UnitName') <> nil then
        xUnitName := twwdbgrid(Sender).Datasource.Dataset.findfield('UnitName').asString;
      if twwdbgrid(Sender).Datasource.Dataset.findfield('Multiplier') <> nil then
        UOMMultiplier := twwdbgrid(Sender).Datasource.Dataset.findfield('Multiplier').asFloat;
    end;
  except
      // kill exception is unitid is not a field
  end;
end;

constructor TfrmParts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MiscPageControl.ActivePage := TTabSheet(tabGeneral);
  fbShowtotalLandedcost := True;
end;

procedure TfrmParts.CreateDefaultUOM(UnitId, PartID: Integer; xUnitName:String; Category: String;UOMMultiplier:Double);
var
  UOM:TUnitOfMeasure;
  XML:String;
  StrSQL:String;
begin
  uom:= TUnitOfMeasure.create(Self);
  try
    uom.connection := TMyDacDataConnection.create(uom);
    uom.connection.connection := qryProduct.connection;
    if UnitID <> 0 then UOM.Load(UnitID)
    else begin
      UOM.LoadSelect('UnitName = '+quotedStr(xUnitName) + ' and PartId = '+IntToStr(qryproductPartsId.asInteger));
      if UOM.count = 0 then
        UOM.LoadSelect('UnitName = '+quotedStr(xUnitName) + ' and Multiplier = ' +FloaTtoStr(UOMMultiplier) +' Limit 1');
    end;
    XML:= UOM.XML;
    if (PartID <> qryProductPARTSID.asInteger) then
      UOM.LoadSelect('UnitName =' +QuotedStr(xunitname)+' and PartId = ' +IntToStr(qryproductPartsId.asInteger));
    if (UOM.PartID <> qryProductPARTSID.asInteger) then begin
      UOM.New;
      UOM.XML:= XML;
      UOM.PartId := qryProductPARTSID.asInteger;
      UOM.SalesDefault := Sysutils.SameText(Category, 'Sales');
      UOM.PurchasesDefault:= Sysutils.SameText(Category, 'PO');
      UOM.Postdb;
    end else begin
      if Sysutils.SameText(Category, 'Sales') then UOM.SalesDefault := true;
      if Sysutils.SameText(Category, 'PO') then UOM.PurchasesDefault:= true;
      UOM.Postdb;
    end;
    if Sysutils.SameText(Category, 'PO') then
        StrSQL:='update tblunitsofmeasure Set PurchasesDefault ="F" ' +
                ' where PurchasesDefault ="T"  ' +
                ' and unitId <>'+IntToStr(UOM.ID) +
                ' and PartID='+IntToStr(UOM.PartID)
      else
        StrSQL:='update tblunitsofmeasure Set SalesDefault ="F" ' +
                ' where SalesDefault ="T"  ' +
                ' and unitId <>'+IntToStr(UOM.ID) +
                ' and PartID='+IntToStr(UOM.PartID);
      UOM.GetNewDataSet(strSQL,true);

    if Sysutils.SameText(Category, 'PO') then begin
      closedb(qryUOMPurchase); openDB(qryUOMPurchase);
    end else begin
      closedb(QryUOMSales); openDB(QryUOMSales);
    end;
  finally
      Freeandnil(uom);

  end;
end;

function TfrmParts.UOMLockMsg: String;
begin
    result:= 'Currently the User "' +Userlock.LockInfo.UserName + '" is accessing Unit of Measure ' +
        ' with: ' + Userlock.LockInfo.LockingForm + '!';

    if (Userlock.UserName <> '') and (Userlock.UserName = Userlock.LockInfo.Username) then
      result := 'You are currently accessing Unit of Measure ' +
        ' with: ' + Userlock.LockInfo.LockingForm + '!';
    Result := Result + #13 + #10 + 'Record has been in use since: ' + FormatDateTime('dd/mm hh:nn:ss', Userlock.LockInfo.TimeLocked);
end;

(*procedure TfrmParts.cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  editDB(qryProduct);
  qryProductProductUOMID.asInteger := qryUnitOfMeasureUnitID.asInteger;
end;*)


procedure TfrmParts.OnChangeUOMtobeUsedinManufacture(Sender: TObject);
begin
  inherited;
  if ChangingUOMtobeUsedinManufacture then exit;
  ChangingUOMtobeUsedinManufacture:= TRue;
  try
    if Screen.ActiveControl = chkUOMtobeUsedinManufactureSales then
      chkUOMtobeUsedinManufacturePurchases.checked :=not (chkUOMtobeUsedinManufactureSales.checked)
    else if Screen.ActiveControl = chkUOMtobeUsedinManufacturePurchases then
      chkUOMtobeUsedinManufactureSales.checked :=not (chkUOMtobeUsedinManufacturePurchases.checked);

    if Screen.ActiveControl = chkUOMtobeUsedinManufactureSales then
      SetControlFocus(btnSalesUOM)
    else if Screen.ActiveControl = chkUOMtobeUsedinManufacturePurchases then
      SetControlFocus(btnPurhcaseUOM)
    else exit;



    EditDB(qryProduct);
    if  chkUOMtobeUsedinManufactureSales.Checked then
          qryProductUOMtobeUsedinManufacture.asString:= 'S'
    else  qryProductUOMtobeUsedinManufacture.asString:= 'P';

    PostDB(qryProduct);
    EditDB(qryProduct);
  Finally
      ChangingUOMtobeUsedinManufacture:= False;
  end;
end;

procedure TfrmParts.OnExitPriceEdit(Sender: TObject);
begin
  inherited;
  TmrRoundingPriceHintTimer(TmrRoundingPriceHint);
end;

procedure TfrmParts.explainformula(Sender: TObject);
begin
  inherited;
  formulaDetails;
end;

procedure TfrmParts.ShowUOMfields(ShowRegardless: boolean = false);
begin
  if ShowRegardless then begin
    btnPurhcaseUOM.visible := true;
    chkUOMtobeUsedinManufacturePurchases.visible := true;
    lblUOMtobeUsedinManufacturePurchases.visible := true;
    btnSalesUOM.visible := true;
    chkUOMtobeUsedinManufactureSales.visible := true;
    lblUOMtobeUsedinManufactureSales.visible := true;
  end
  else begin
    btnPurhcaseUOM.visible := KeyID>0;
    chkUOMtobeUsedinManufacturePurchases.visible := KeyID>0;
    lblUOMtobeUsedinManufacturePurchases.visible := KeyID>0;
    btnSalesUOM.visible := KeyID>0;
    chkUOMtobeUsedinManufactureSales.visible := KeyID>0;
    lblUOMtobeUsedinManufactureSales.visible := KeyID>0;
  end;
end;

procedure TfrmParts.OnTabmanufacture(Sender: TObject);
var
  Flag:Boolean;
begin
  //btnOpen.Enabled := true;
  //btnOpen.Caption := 'Cost Struc';
  //btnOpen.OnClick := OpenCostStructureDoc;

  SetControlFocus(newManufacture);
  {Price n cost Ex should be displayed in the main screen
  as the price/cost change in the tree will recalute the price n cost Ex.}
  Flag := bFinishedOnShow;
  bFinishedOnShow := False;
  try
    if tglGST.Caption = 'Price (Inc)' then begin
      tglGST.Click;
    end;
    if tglCost.Caption = 'Cost (Inc)' then begin
      tglCost.click;
    end;
  finally
    bFinishedOnShow := Flag;
  end;
end;
Function TfrmParts.ClassIDs:String;
begin
  result := '';

  REsult := qryProductClass.GroupConcat('ClassId' , 'ClassId <> ' +IntToStr(qryProductClassClassID.asInteger) );
end;
procedure TfrmParts.ClearPartCalcformulahint;
begin
  if cboPartCalcformulaUOM.readonly then else
    PartCalcformulahint('');
end;

procedure TfrmParts.btnAutoFillClick(Sender: TObject);
var
  S:String;
  ExitResult: Word;
  IgnoreAvailable: boolean;
begin
  inherited;
  IgnoreAvailable := false;
  if qryProductClass.RecordCount <=1 then begin
    MessageDlgXP_Vista('Product ' +qryProductProductPrintName.asString +' Has No ' + Appenv.DefaultClass.ClassHeading +'.' , mtWarning, [mbok],0);
    exit;
  end;

  IgnoreAvailable := true;
//  if qryProductClassPreferredLevel.asFloat >= qryProductClassAvailableQty.asFloat then begin
//     if MessageDlgXP_Vista('The Available Quantity In '+ qryProductClassClassName.asString +'  is Less Than Preferred Quantity, Do you want to Transfer Anyway?' , mtConfirmation, [mbYes,mbNo] ,0 ) <> mrYes then
//       Exit
//     else
//       IgnoreAvailable := true;
//  end;

  if DataHasChanged then begin
      SaveButtonClicked := 1; // Reset SavedButtonClicked
      s :=  'This will close the Product Form.' +chr(13) +
            'Do you wish to keep these changes you Have Made?';
      ExitResult := MessageDlgXP_Vista(s, mtWarning, [mbYes, mbNo, mbCancel], 0);
      case ExitResult of
        mrYes: if not SaveProduct then Exit
               else BeginTransaction;
        mrNo: begin
                RollbackTransaction;
              end;
        mrCancel: Exit;
      end;
    end else begin
      RollbackTransaction;
    end;

  if TfmStockTransferEntry.AutoTransfer(qryProductPARTSID.asInteger, qryProductClassClassID.asInteger,qryProductASSETACCNT.asString,ClassIDs,IgnoreAvailable) then
    Self.Close;
end;

procedure TfrmParts.cboProcessStepBeforeDropDown(Sender: TObject);
begin
  inherited;
  if (AccessLevel = 1) and
    (not (cboProcessStep.DataSource.DataSet.State in [dsEdit, dsInsert])) then
    cboProcessStep.DataSource.DataSet.Insert;

end;

procedure TfrmParts.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
 if pageControl.ActivePage = TTabSheet(Supplier_History) then begin
      if assigned(ffrmListSupplierProductReport) then ffrmListSupplierProductReport.OnKeyUp(ffrmListSupplierProductReport,Key,Shift);
 end else if pageControl.ActivePage = TTabSheet(Customer_History) then begin
      if assigned(ffrmListSalesReport) then ffrmListSalesReport.OnKeyUp(ffrmListSalesReport,Key,Shift);
 end else if pageControl.ActivePage = TTabSheet(TabSerial) then begin
      if assigned(fFrmProductQtycheck) then fFrmProductQtycheck.OnKeyUp(fFrmProductQtycheck,Key,Shift);
 end;
end;

procedure TfrmParts.AssignProductId(Sender: TObject);
begin
  if sender is TUnitsOfMeasuregroupGUI then begin
      PostDB(qryProduct);
      editDB(qryProduct);
      TUnitsOfMeasuregroupGUI(Sender).ProductId :=qryProductpartsId.asInteger;
  end;
end;

procedure TfrmParts.grdAlternateProductsEnter(Sender: TObject);
begin
  inherited;
  if QryProductPartsId.asInteger =0 then begin
    MessageDlgXP_Vista('Please Provide the Product Details Before Creating Alternate Products', mtInformation, [mbOK], 0);
    pageControl.ActivePage := Main;
    Exit;
  end;
    With cboProductQry do begin
        if Params.ParamByName('KeyId').asInteger <>  qryProductPARTSID.asInteger then begin
            if Active then close;
            Params.ParamByName('KeyId').asInteger :=  qryProductPARTSID.asInteger;
        end;
        if not Active then Open;
    end;
    cboProductQry.Open;
end;

procedure TfrmParts.grdAlternateProductsTitleButtonClick(Sender: TObject;AFieldName: string);
begin
  if sametext(AFieldName ,  QryAlternateProductsProductName.fieldname) or sametext(AFieldName ,  QryAlternateProductsAlternateProductName.fieldname) then begin
    GuiPrefs.Node['Options.alternateProduct.showname'].AsBoolean := not(GuiPrefs.Node['Options.alternateProduct.showname'].AsBoolean);
    initgrdAlternateProducts;
  end;

end;
procedure TfrmParts.initgrdAlternateProducts;
var
  s:String;
begin
  inherited;
    if GuiPrefs.Node['Options.alternateProduct.showname'].AsBoolean then s:= SelectedText(QryAlternateProductsProductName.Fieldname ,AppEnv.DefaultClass.PartColumn ,27 , '')
    else s:= SelectedText(QryAlternateProductsAlternateProductName.Fieldname ,AppEnv.CompanyPrefs.ProductPrintNameHeading ,27 , '');
    s:= s+ NL+ SelectedText(QryAlternateProductsIsDefault.Fieldname ,'Default?',1 , '');
    grdAlternateProducts.Selected.Text := s;
    grdAlternateProducts.ApplySelected;
end;

procedure TfrmParts.wwDBGrid3IButtonClick(Sender: TObject);
begin
  inherited;
  if QryAlternateProductsAlternateProductID.asInteger =0 then exit;
  if MessageDlgXP_Vista('Do you Wish to Remove '+QryAlternateProductsAlternateProductName.asString +' from the Alternate Product List of '+qryProductProductPrintName.asString +'?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  QryAlternateProducts.Delete;
end;


procedure TfrmParts.qryProductPARTNAMEChange(Sender: TField);
begin
  inherited;
  if qryProductPARTNAME.asString ='' then exit;

  if qryProductPARTNAME.asString  <> trim(qryProductPARTNAME.asString ) then begin
    Editdb(qryProduct);
    qryProductPARTNAME.asString  := trim(qryProductPARTNAME.asString ) ;
    edtPart.text :=qryProductPARTNAME.asString ;
    Postdb(qryProduct);
    Editdb(qryProduct);
  end;

  closedb(QryProductUOM);
  QryProductUOM.Params.ParamByName('xPartID').asInteger := qryProductPartsId.asInteger;
  opendb(QryProductUOM);
  if QryProductUOM.recordcount =0 then exit;
  QryProductUOM.first;
  While QryProductUOM.Eof = False do begin
    if QryProductUOMUnitProductKeyName.AsString <> QryProductUOMUnitName.AsString +':' + qryProductPARTNAME.asString then begin
      EditDb(QryProductUOM);
      QryProductUOMUnitProductKeyName.AsString :=QryProductUOMUnitName.AsString +':' + qryProductPARTNAME.asString;
      PostDb(QryProductUOM);
    end;
    QryProductUOM.Next;
  end;
end;

procedure TfrmParts.qryProductPARTNAMESetText(Sender: TField;
  const Text: string);
begin
  inherited;
  Sender.AsString := Text;
  if not ProductNameUnique() then begin
    Sender.Value :=Sender.OldValue;
    edtPart.Text := Sender.AsString;
    Application.ProcessMessages;
    MessageDlgXP_Vista('Product already exists with this name, name cannot be duplicate.', mtWarning, [mbOK], 0);
    abort;
  end;
end;

procedure TfrmParts.qryProductPARTTYPEChange(Sender: TField);
begin
  inherited;
      if ((qryProductPARTTYPE.OldValue = null) or (qryProductPARTTYPE.OldValue = '')) and Sametext(qryProductPARTTYPE.AsString , 'INV') then begin
        editDB(QryProduct);qryProductSNTracking.AsBoolean    := Appenv.CompanyPrefs.EnableSerialsByDefault;
        editDB(QryProduct);qryProductMultipleBins.AsBoolean  := Appenv.CompanyPrefs.EnableBinByDefault;
        editDB(QryProduct);qryProductBatch.AsBoolean         := Appenv.CompanyPrefs.EnableBatchByDefault;
        editDB(QryProduct);qryProductVolume.AsFloat          := Appenv.CompanyPrefs.DefaultProductVolume;
        editDB(QryProduct);qryProductCostUpdateFromPurchase.AsBoolean :=Appenv.CompanyPrefs.CostUpdateFromPurchase;
      end else if not(Sametext(qryProductPARTTYPE.AsString , 'INV')) then  begin
        editDB(QryProduct);qryProductSNTracking.AsBoolean    := False;
        editDB(QryProduct);qryProductMultipleBins.AsBoolean  := False;
        editDB(QryProduct);qryProductBatch.AsBoolean         := False;
        editDB(QryProduct);qryProductCostUpdateFromPurchase.AsBoolean :=False;
      end;
end;

procedure TfrmParts.qryProductPRICE1Change(Sender: TField);
begin
  if IsFlag('SellQty_Prices') then exit;
  if IsFlag('PriceChange') then Exit;
    fsPrice:= '';
    Try
      inherited;
      if (not qryProductLockExtraSell.AsBoolean) then
        PostMessage(Self.Handle, SX_UpdateProductSellInfo, 0, 0);
      ValidateProductcostPrice(Sender);
      if QryProductclass.Active then begin
        ResetVariantPrice;
        if QryProductclass.State in [dsEdit, dsInsert] then QryProductclass.Post;
      end;
    Finally
      if fsPrice <> '' then
         ShowPriceroundhint(txtRetailPriceInc);
    End;
end;
Procedure TfrmParts.ShowPriceroundhint(edt:TwwDBEdit);
var
  CurPos: TPoint;
begin
  inherited;
  if (fsPrice <> '') then begin
      CurPos:= edt.ClientToScreen(Point(1,1));
      RoundingPriceHint:= THintWindow.Create(Self);
      fsPrice := Replacestr(trim(fsPrice), NL , chr(13) +chr(10));
      RoundingPriceHint.ActivateHint(Rect(CurPos.X + 20, CurPos.Y + 20, CurPos.X + 580, CurPos.Y +20+  CharCounter(chr(13)+chr(10) , fsPrice)*20 ),fsPrice);
      tmrRoundingPriceHint.Enabled := True;
      Application.ProcessMessages;
  end;
  fsPrice := '';
end;

procedure TfrmParts.qryProductPRICEINC1Change(Sender: TField);
begin
  inherited;
  if IsFlag('SellQty_Prices') then exit;
  if IsFlag('PriceIncChange') then Exit;
  fsPrice:= '';
  try
    if self.bNewPart then
      Flags.Add(AutoPriceFlag);
    try
      RoundPrice1;
    finally
      if self.bNewPart then
        Flags.Remove(AutoPriceFlag);
    end;
  finally
      if fsPrice <> '' then
         ShowPriceroundhint(txtRetailPriceInc);
  end;
end;
procedure TfrmParts.qryProductPRICEINC2Change(Sender: TField);
begin
  inherited;
  if IsFlag('SellQty_Prices') then exit;
  if IsFlag('PriceIncChange') then Exit;
  fsPrice:= '';
  try

  RoundPrice2;
  finally
    if fsPrice <> '' then
      ShowPriceroundhint(txtPrice2);
  end;
end;
procedure TfrmParts.qryProductPRICEINC3Change(Sender: TField);
begin
  inherited;
  if IsFlag('SellQty_Prices') then exit;
  if IsFlag('PriceIncChange') then Exit;
  fsPrice:= '';
  try

  RoundPrice3;
  finally
      if fsPrice <> '' then
         ShowPriceroundhint(txtPrice3);
  end;
end;
procedure TfrmParts.qryProductProductPrintNameChange(Sender: TField);
begin
  inherited;
  if qryProductProductPrintName.asString ='' then exit;

  if qryProductProductPrintName.asString  <> trim(qryProductProductPrintName.asString ) then begin
    Editdb(qryProduct);
    qryProductProductPrintName.asString  := trim(qryProductProductPrintName.asString ) ;
    edtPart.text :=qryProductProductPrintName.asString ;
    Postdb(qryProduct);
    Editdb(qryProduct);
  end;
end;

Procedure TfrmParts.ValidateProductCostPrice(Sender:TField);
var
  cf:tchangingfield;
begin
  if fbValidatingProductcostPrice then exit;
  if formshown =False then exit;
  if fbAftershowAutoFocusingToPage then exit;
  if (Sender is TFloatField) and
    (Sender.AsFloat = Sender.OldValue) then exit;

  fbValidatingProductcostPrice:= True;
  try
         if Sender = qryProductCOST1      then cf:= cfC1
    else if Sender = qryProductCOST2      then cf:= cfC2
    else if Sender = qryProductCOST3      then cf:= cfC3
    else if Sender = qryProductCOSTINC1   then cf:= cfC1
    else if Sender = qryProductCOSTINC2   then cf:= cfC2
    else if Sender = qryProductCOSTINC3   then cf:= cfC3
    else if Sender = qryProductPrice1     then cf:= cfP1
    else if Sender = qryProductPrice2     then cf:= cfP2
    else if Sender = qryProductPrice3     then cf:= cfP3
    else if Sender = qryProductPriceINC1  then cf:= cfP1
    else if Sender = qryProductPriceINC2  then cf:= cfP2
    else if Sender = qryProductPriceINC3  then cf:= cfP3
    else if Sender = qryProductBuyQTY1    then cf:= cfQ1
    else if Sender = qryProductBuyQTY2    then cf:= cfQ2
    else if Sender = qryProductBuyQTY3    then cf:= cfQ3
    else if Sender = qryProductSellQTY1   then cf:= cfPQ1
    else if Sender = qryProductSellQTY2   then cf:= cfPQ2
    else if Sender = qryProductSellQTY3   then cf:= cfPQ3
    else if Sender = qryProductSell_Cost_Percentage then cf:= cfGM
    else if Sender = qryProductGrossMarginMode      then cf:= cfGMO
    else exit;
    TfmPartsCostPriceOptions.ValidateProductcostPrice(cf, self);
  finally
    PostDB(qryproduct);
    EditDB(qryproduct);
    fbValidatingProductcostPrice:= False;
  end;
  Exit;
end;

procedure TfrmParts.qryProductCOST1Change(Sender: TField);
begin
  if IsFlag('BuyQty_Prices') then exit;
  if IsFlag('CostChange') then Exit;
  Cost1OldValue := 0;
  if not VarIsNull(Sender.OldValue) then
    Cost1OldValue := Sender.OldValue;
    inherited;
    if self.bNewPart then
        Flags.Add(AutoPriceFlag);
    try
      ValidateProductcostPrice(Sender);
      if fState = dsInsert then begin
        qryProductWHOLESALEPRICE.AsFloat := qryProductCOST1.AsFloat * (1 + (StrValue(txtMarkup2.Text) / 100));
      end;
      if bFinishedOnShow then
        PostMessage(Self.Handle, SX_UpdateProductBuyInfo, 0, 0);
    finally
      if self.bNewPart then
        Flags.Remove(AutoPriceFlag);
    end;
end;

procedure TfrmParts.qryProductCOSTINC1Change(Sender: TField);
begin
  inherited;
  if IsFlag('BuyQty_Prices') then exit;
  if IsFlag('CostIncChange') then Exit;
  CostInc1OldValue := 0;
  if not VarIsNull(Sender.OldValue) then
    CostInc1OldValue := Sender.OldValue;
    if self.bNewPart then
      Flags.Add(AutoPriceFlag);
    try
      qryProductCOST1.AsFloat := CommonLib.Round(GetAmountEx(qryProductCOSTINC1.AsFloat, GetTaxRate(qryProduct.FieldByName('TaxCode').AsString)),tcConst.GeneralRoundPlaces);
      ValidateProductcostPrice(Sender);
    finally
    if self.bNewPart then
      Flags.Remove(AutoPriceFlag);
    end;
end;

procedure TfrmParts.qryProductCOSTINC2Change(Sender: TField);
begin
  inherited;
  if IsFlag('BuyQty_Prices') then exit;
  if IsFlag('CostIncChange') then Exit;
  qryProductCOST2.AsFloat := CommonLib.Round(GetAmountEx(qryProductCOSTINC2.AsFloat, GetTaxRate(qryProduct.FieldByName('TaxCode').AsString)),tcConst.GeneralRoundPlaces);
  ValidateProductcostPrice(Sender);
end;

procedure TfrmParts.qryProductCOSTINC3Change(Sender: TField);
begin
  inherited;
  if IsFlag('BuyQty_Prices') then exit;
  if IsFlag('CostIncChange') then Exit;
  qryProductCOST3.AsFloat := CommonLib.Round(GetAmountEx(qryProductCOSTINC3.AsFloat, GetTaxRate(qryProduct.FieldByName('TaxCode').AsString)),tcConst.GeneralRoundPlaces);
  ValidateProductcostPrice(Sender);
end;

Procedure TfrmParts.doSearchPartcalcformulaValidate;
begin

end;
Procedure  TfrmParts.PartCalcformulahint(hintvalue :String );
begin
  lblPartCalcformula.Visible := True;
  lblPartCalcformula.Caption :=hintvalue;
  lblPartCalcformula.REfresh;
end;
function TfrmParts.IsSearchPartcalcformulaValid:Boolean;
var
  ErrMsg:String;
begin
  if memPartCalcformula.readonly then begin
    REsult := TRue;
    Exit;
  end;
  PartcalcfieldsToformula;

  ParserValue(Self,DoSearchPartcalcformulaVar ,  QryProductPartCalcformula.AsString , ErrMsg);
  REsult :=ErrMsg ='';
  if ErrMsg <> '' then begin
        if not CalcQtyformulaREadonly then ColorToActive(memPartCalcformula.Font);
        memPartCalcformula.Hint :=  ErrMsg;
        PartCalcformulahint(ErrMsg);
  end else begin
        if memPartCalcformula.readonly = False then memPartCalcformula.Font.Color := clblack;
        memPartCalcformula.Hint := '';
        ClearPartCalcformulahint;
  end;
end;

procedure TfrmParts.makeformula(Sender: TObject);
var
  s:STring;
  formula:String;
  Procedure Add(const Value:String);
  begin
    if Trim(Value) = '' then exit;
    if Trim(Value) = '0' then exit;
    if s<> '' then s := s +' * ' ;
    s := s + Value;
  end;

begin
  inherited;
try
  formula := '';
  try
    if (trim(edtCalcField11.Text) = '') and
      (trim(edtCalcField22.Text) = '') and
      (trim(edtCalcField33.Text) = '') and
      (trim(edtCalcField44.Text) = '') and
      (trim(edtCalcField55.Text) = '') then exit;

    s:= '';
    if (edtCalcField11.visible) and  (trim(edtCalcField11.Text)<> '') then Add('[Field1]');
    if (edtCalcField22.visible) and  (trim(edtCalcField22.Text)<> '') then Add('[Field2]');
    if (edtCalcField33.visible) and  (trim(edtCalcField33.Text)<> '') then Add('[Field3]');
    if (edtCalcField44.visible) and  (trim(edtCalcField44.Text)<> '') then Add('[Field4]');
    if (edtCalcField55.visible) and  (trim(edtCalcField55.Text)<> '') then Add('[Field5]');
    formula:= s;

    s:='';
    Add(edtCalcField.Text);
    Add(edtCalcField11.Text);
    Add(edtCalcField22.Text);
    Add(edtCalcField33.Text);
    Add(edtCalcField44.Text);
    Add(edtCalcField55.Text);

    formula := formula + ' / (' + s+')';
  finally
    if (Formula<>'') and (Formula <> QryProductPartCalcformula.AsString ) then begin
      EditDB(QryProduct);
      QryProductPartCalcformula.AsString :=Formula;
    end;
    Formula := ReplaceStr(Formula , 'Field1' , Appenv.CompanyPrefs.PartCalcField1Name);
    Formula := ReplaceStr(Formula , 'Field2' , Appenv.CompanyPrefs.PartCalcField2Name);
    Formula := ReplaceStr(Formula , 'Field3' , Appenv.CompanyPrefs.PartCalcField3Name);
    Formula := ReplaceStr(Formula , 'Field4' , Appenv.CompanyPrefs.PartCalcField4Name);
    Formula := ReplaceStr(Formula , 'Field5' , Appenv.CompanyPrefs.PartCalcField5Name);
    if (Formula<>'') and (Formula <> QryProductPartCalcformulaField.AsString ) then begin
      EditDB(QryProduct);
      QryProductPartCalcformulaField.AsString :=Formula;
    end;
    PostDB(QryProduct);
    EditDB(QryProduct);
  end;
  EditDB(QryProduct);
  try
    if (sender = edtCalcField11) and (QryProductFormulaQty1.AsFloat <>0) and (QryProductFormulaQtyValue1.AsFloat =0) then QryProductFormulaQtyValue1.AsFloat :=QryProductFormulaQty1.AsFloat;
    if (sender = edtCalcField22) and (QryProductFormulaQty2.AsFloat <>0) and (QryProductFormulaQtyValue2.AsFloat =0) then QryProductFormulaQtyValue2.AsFloat :=QryProductFormulaQty2.AsFloat;
    if (sender = edtCalcField33) and (QryProductFormulaQty3.AsFloat <>0) and (QryProductFormulaQtyValue3.AsFloat =0) then QryProductFormulaQtyValue3.AsFloat :=QryProductFormulaQty3.AsFloat;
    if (sender = edtCalcField44) and (QryProductFormulaQty4.AsFloat <>0) and (QryProductFormulaQtyValue4.AsFloat =0) then QryProductFormulaQtyValue4.AsFloat :=QryProductFormulaQty4.AsFloat;
    if (sender = edtCalcField55) and (QryProductFormulaQty5.AsFloat <>0) and (QryProductFormulaQtyValue5.AsFloat =0) then QryProductFormulaQtyValue5.AsFloat :=QryProductFormulaQty5.AsFloat;
  finally
    PostDB(QryProduct);
  end;
finally
  explainformula(Sender);
end;
end;

procedure TfrmParts.memPartCalcformulaChange(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = memPartCalcformula then begin
    IsSearchPartcalcformulaValid;
    EditDB(QryProduct);
    QryProductFormulaQty.AsFloat := 0;
    QryProductFormulaQty1.AsFloat := 0;
    QryProductFormulaQty2.AsFloat := 0;
    QryProductFormulaQty3.AsFloat := 0;
    QryProductFormulaQty4.AsFloat := 0;
    QryProductFormulaQty5.AsFloat := 0;

    PostDB(QryProduct);
  end;
end;

procedure TfrmParts.memPartCalcformulaEnter(Sender: TObject);
begin
  inherited;
  PostDB(qryProduct);
  ClearPartCalcformulahint;
end;

procedure TfrmParts.memPartCalcformulaExit(Sender: TObject);
begin
  inherited;
   if not IsSearchPartcalcformulaValid then begin
    CancelDb(qryProduct);
   end;
  if not CalcQtyformulaREadonly  then ColorToActive(memPartCalcformula.Font);
  ClearPartCalcformulahint;
end;

procedure TfrmParts.memqryProductBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if memqryProduct.FindField('mstimeStamp') <> nil then
    memqryProduct.FindField('mstimeStamp').DefaultExpression:= '';
end;

procedure TfrmParts.ValidateAllocation(Alloctype:String);
(*var
  s:String;*)
begin
  inherited;


  if not(Sametext(qryProductPARTTYPE.AsString , 'INV')) then begin
      MessageDlgXP_Vista(qryProductProductPrintName.asString  + ' is ' + dblcProductType.text +'. Only ''Inventory Parts'' can have ''Batch / Bin / Serial Number tracking'' !', mtWarning, [mbOK], 0);
      chkMultipleBins.REadonly := true;
      chkBatches.REadonly := true;
      chkSNTracking.ReadOnly:= True;
      Exit;
  end;

  (*if Alloctype = 'Batch' then
    s:= StockQtyDetails(TRue,qryProductPARTSID.asInteger)
  else if alloctype = 'Bin' then
    s:= StockQtyExtraDetails(TRue,qryProductPARTSID.asInteger)
  else if Alloctype = 'SN' then
    s:= StockQtyDetailswithSno(TRue,qryProductPARTSID.asInteger)
  else exit;


  With TERPQuery.create(self) do try
    connection := Qryproduct.Connection;
    SQl.add(s);
    Open;
         if Alloctype = 'Batch' then filter := '(Batchnumber <> ' + QuotedStr('') + ') and (Batchnumber <> null)'
    else if alloctype = 'Bin'   then filter := '(binlocation <> ' + QuotedStr('') + ') and (binlocation <> null)'
    else if Alloctype = 'SN'    then filter := '(Serialnumber <> ' + QuotedStr('') + ') and (Serialnumber <> null)'
    else exit;
    Filtered := true;
    if recordcount >0 then begin*)
    if ProductHasAllocationRecords then begin
      if not Appenv.CompanyPrefs.AllowChangingProductAllocationFlags then begin
          MessageDlgXP_Vista('Serial No''s / Batches / Bins already Exist For This Product - Cannot Turn Off SN Tracking !', mtWarning, [mbOK], 0);
          chkMultipleBins.REadonly := true;
          chkBatches.REadonly := true;
          chkSNTracking.ReadOnly:= True;
          Exit;
      end else begin
         if ((Alloctype = 'Batch') and  not(qryProductBatch.asBoolean)) Or
            ((Alloctype = 'Bin'  ) and  not(qryProductMultipleBins.asBoolean)) Or
            ((Alloctype = 'SN'   ) and  not(qryProductSNTracking.asBoolean))  then begin
           MessageDlgXP_Vista('Serial No''s / Batches / Bins already Exist For This Product - you can only Turn Off Batch / Bin / SN Tracking !', mtWarning, [mbOK], 0);
          chkMultipleBins.REadonly := true;
          chkBatches.REadonly := true;
          chkSNTracking.ReadOnly:= True;
         end;
      end;
    end;
(*  finally
      if active then close;
      Free;
  end;*)

end;

procedure TfrmParts.DoSearchPartcalcformulaVar(Sender: TObject; const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
  FieldFound :=  Sametext (trim(VarName) , 'Field1') or
                 Sametext (trim(VarName) , 'Field2') or
                 Sametext (trim(VarName) , 'Field3') or
                 Sametext (trim(VarName) , 'Field4') or
                 Sametext (trim(VarName) , 'Field5');
end;
procedure TfrmParts.PartcalcformulaExampleVar(Sender: TObject;const VarName: string; var Value: extended; var FieldFound: Boolean);
begin
  FieldFound :=  Sametext (trim(VarName) , 'Field1') or
                 Sametext (trim(VarName) , 'Field2') or
                 Sametext (trim(VarName) , 'Field3') or
                 Sametext (trim(VarName) , 'Field4') or
                 Sametext (trim(VarName) , 'Field5');
       if Sametext (trim(VarName) , 'Field1')  then Value := QryProductFormulaQtyValue1.AsFloat
  else if Sametext (trim(VarName) , 'Field2')  then Value := QryProductFormulaQtyValue2.AsFloat
  else if Sametext (trim(VarName) , 'Field3')  then Value := QryProductFormulaQtyValue3.AsFloat
  else if Sametext (trim(VarName) , 'Field4')  then Value := QryProductFormulaQtyValue4.AsFloat
  else if Sametext (trim(VarName) , 'Field5')  then Value := QryProductFormulaQtyValue5.AsFloat;
end;
Procedure TfrmParts.RoundPrice1;
var
  fdPriceex, fdPriceinc:double;
begin
  if appenv.Companyprefs.ProductPriceRoundLotsnRoundup = false then exit;
  fdPriceex:=qryProductPRICE1.AsFloat;
  fdPriceinc:=qryProductPRICEinc1.AsFloat;
  qryProductPRICEinc1.AsFloat :=RoundProductPriceTo5C(qryProductPRICEinc1.AsFloat);
  qryProductPRICE1.AsFloat := CommonLib.Round(GetAmountex(qryProductPRICEinc1.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
  if FdPriceInc <> qryProductPRICEinc1.AsFloat then fsPrice := fsPrice + NL +'Price 1 (Inc) was ' + floattostr(fdPriceInc) +' and is rounded to ' +floatTostr(qryProductPRICEinc1.asfloat) +
                                                                             ' and Ex was ' + floattostr(fdPriceex) +' and is recalculated  to ' +floatTostr(qryProductPRICE1.asfloat);
  ValidateProductcostPrice(qryProductPRICE1);
end;
Procedure TfrmParts.RoundPrice2;
var
  fdPriceex, fdPriceinc:double;
begin
  if appenv.Companyprefs.ProductPriceRoundLotsnRoundup = false then exit;
  fdPriceex:=qryProductPRICE2.AsFloat;
  fdPriceinc:=qryProductPRICEinc2.AsFloat;
  qryProductPRICEinc2.AsFloat :=RoundProductPriceTo5C(qryProductPRICEinc2.AsFloat);
  qryProductPRICE2.AsFloat := CommonLib.Round(GetAmountex(qryProductPRICEinc2.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
  if FdPriceInc <> qryProductPRICEinc2.AsFloat then fsPrice := fsPrice + NL +'Price 2 (Inc) was ' + floattostr(fdPriceInc) +' and is rounded to ' +floatTostr(qryProductPRICEinc2.asfloat) +
                                                                             ' and Ex was ' + floattostr(fdPriceex) +' and is recalculated  to ' +floatTostr(qryProductPRICE2.asfloat);
  ValidateProductcostPrice(qryProductPRICE2);
end;
Procedure TfrmParts.RoundPrice3;
var
  fdPriceex, fdPriceinc:double;
begin
  if appenv.Companyprefs.ProductPriceRoundLotsnRoundup = false then exit;
  fdPriceex:=qryProductPRICE3.AsFloat;
  fdPriceinc:=qryProductPRICEinc3.AsFloat;
  qryProductPRICEinc3.AsFloat :=RoundProductPriceTo5C(qryProductPRICEinc3.AsFloat);
  qryProductPRICE3.AsFloat := CommonLib.Round(GetAmountex(qryProductPRICEinc3.AsFloat, GetTaxRate(qryProductTAXCODE.AsString)), tcConst.GeneralRoundPlaces);
  if FdPriceInc <> qryProductPRICEinc3.AsFloat then fsPrice := fsPrice + NL +'Price 3 (Inc) was ' + floattostr(fdPriceInc) +' and is rounded to ' +floatTostr(qryProductPRICEinc3.asfloat) +
                                                                           ' and Ex was ' + floattostr(fdPriceex) +' and is recalculated  to ' +floatTostr(qryProductPRICE3.asfloat);
  ValidateProductcostPrice(qryProductPRICE3);
end;
function TfrmParts.RoundProductPriceTo5C(const ProductPrice: currency): currency;
var
  iUnitCents: integer;
  bIsNeg: boolean;
  rAmount,firem: currency;
  RoundLotsof: integer;
  RoundPlaces: integer;
  Multiplier: integer;
  iUpDownValue: double;

  x: integer;
begin
  RoundPlaces:= CurrencyRoundPlaces;
  bIsNeg := false;
  rAmount := round(ProductPrice, RoundPlaces);
  if rAmount < 0.0 then begin
    bIsNeg := true;
    rAmount := -rAmount;
  end;
  Multiplier:= 1;
  for x := 1 to RoundPlaces do
    Multiplier:= Multiplier * 10;  { ie: 100 for 2 places, 1000 for 3 places }
  iUpDownValue:= AppEnv.CompanyPrefs.ProductPriceRoundUp; if iUpDownValue =0 then iUpDownValue := 2.5;
  RoundLotsof := System.round(AppEnv.CompanyPrefs.ProductPriceRoundLotsof) ;
  if AppEnv.CompanyPrefs.ProductPriceRoundLotsnRoundup then begin
      result:=  Trunc(rAmount*Multiplier)/Multiplier ;
      firem := Trunc(round(Frac(result)*Multiplier,0));
      result:= Trunc(result);
      iUnitCents := Trunc(firem /RoundLotsof) * RoundLotsof;
      firem :=firem  - iUnitCents;
      if firem >= iUpDownValue then iUnitCents := iUnitCents +RoundLotsof;
      result:= result + (iUnitCents /  Multiplier);
  end else begin
    result := rAmount;
  end;
  if bIsNeg then Result := -Result;
end;

procedure TfrmParts.dtpFromCloseUp(Sender: TObject);
begin
  // Set date to first day of the selcted month
  dtpFrom.Date := StartOfTheMonth(dtpFrom.Date);
  btnViewClick(Sender);
end;
procedure TfrmParts.dtpToCloseUp(Sender: TObject);
begin
  // Set date to last day in selected month
  dtpTo.Date := EndOfTheMonth(dtpTo.Date);
  btnViewClick(Sender);
end;

procedure TfrmParts.dtpPurchFromCloseUp(Sender: TObject);
begin
  inherited;
  // set date to first day of the selcted month
  dtpPurchFrom.Date := StartOfTheMonth(dtpPurchFrom.Date);
  btnPurchViewClick(Sender);
end;

procedure TfrmParts.dtpPurchToCloseUp(Sender: TObject);
begin
  inherited;
  // set date to last day in selected month
  dtpPurchTo.Date := EndOfTheMonth(dtpPurchTo.Date);
  btnPurchViewClick(Sender);
end;
procedure TfrmParts.dtpFromManCloseUp(Sender: TObject);
begin
  inherited;
  // set date to first day of the selcted month
  dtpFromMan.Date := StartOfTheMonth(dtpFromMan.Date);
  btnManViewClick(Sender)
end;
procedure TfrmParts.dtpToManCloseUp(Sender: TObject);
begin
  inherited;
  dtpToMan.Date := EndOfTheMonth(dtpToMan.Date);
  btnManViewClick(Sender)
end;

procedure TfrmParts.btnViewClick(Sender: TObject);
begin
  Processingcursor(True);
  try
    GetSalesDB;
    LoadSalesGrid;
  finally
    Processingcursor(False);
  end;
end;
procedure TfrmParts.GetSalesDB;
var
  dtFrom, dtTo: TDateTime;
begin
  dtFrom := IncMonth( Trunc(dtpFrom.Date), -1); // we go back a month so we can compare figures
  dtTo := Trunc(dtpTo.Date);

  with qrySales do
  begin
    qrySales.Close;
    SQL.Clear;
      SQL.Add(' SELECT tblSales.SaleID, SaleDate, tblSales.ShipDate, LinePrice, ');
      SQL.Add(' LinePriceInc, TotalLineAmountInc, QtySold, Shipped '  );
      SQL.Add(' FROM tblSales INNER JOIN tblSalesLines Using(SaleID) ' );
      SQL.Add(' WHERE (tblSales.IsInvoice="T" OR tblSales.IsCashSale="T"  ');
      SQL.Add(' OR tblSales.IsRefund="T" OR tblSales.IsPOS="T")   ');
      SQL.Add(' AND ProductID = ' + IntToStr(KeyID) );
    if not chkBaseOnShipped.Checked then
    begin
      SQL.Add(' AND tblSales.SaleDate BETWEEN '+QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom))  );
      SQL.Add(' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo))  );
      SQL.Add(' ORDER BY tblSales.SaleDate;');
    end    else    begin
      SQL.Add(' AND tblSales.ShipDate BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom))  );
      SQL.Add(' AND  ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo))  );
      SQL.Add(' ORDER BY tblSales.ShipDate;');
    end;
    Open;
  end;
end;
procedure TfrmParts.LoadSalesGrid;
{ Loads the grid, assumes that
  1. the sales query is restricted to the range we are interested in
  2. the from date dtpFrom is set to the 1st of the starting month }
var
  rTotAmount: Currency;
  rTotSold: Double;
  rGrandTot: Double;
  rGrandQty: Double;
  dtFrom: TDateTime;
  iGridRow: Integer;
  rPrevTotAmount: Currency;

  procedure UpdateRow;
  begin
    if iGridRow <> 0 then
    begin // do not display or accumulate first month
      with grdSales do
      begin
        Cells[COL_DATE, iGridRow] := FormatDateTime('MMMM yyy',IncMonth(dtFrom, -1));
        Cells[COL_QTY, iGridRow] := FloatToStrF(rTotSold, ffGeneral, 7, 2);
        Cells[COL_VALUE, iGridRow] := CurrToStrF(rTotAmount, ffFixed, 2);
        Cells[COL_AVERAGE, iGridRow] := CurrToStrF(DivZer(rTotAmount, rTotSold), ffFixed, 2);
        Cells[COL_PERCENT_MOVE, iGridRow] := FloatToStrF(DivZer((rTotAmount - rPrevTotAmount), rTotAmount) * 100, ffFixed, 7, 2);
        Cells[COL_PERCENT_TOT, iGridRow] :=
          FloatToStrF(DivZer(rTotAmount, GetSalesGrandTotal(IncMonth(dtFrom, -1), IncDay(dtFrom, -1))) * 100, ffFixed, 5, 2);
      end;
      rGrandQty := rGrandQty + rTotSold;
      rGrandTot := rGrandTot + rTotAmount;
    end;
    rPrevTotAmount := rTotAmount;
    rTotSold := 0;
    rTotAmount := 0;
  end;

begin // LoadSalesGrid
  rPrevTotAmount:= 0;
  rTotAmount:=0;
  rGrandTot := 0.0;
  rGrandQty := 0.0;
  iGridRow := 0;
  grdSales.RowCount := 1;
  dtFrom := Trunc(dtpFrom.Date);
  with qrySales do
  begin
    if not IsEmpty then
    begin
      First;
      while not Eof do
      begin
        if not chkBaseOnShipped.Checked then begin
          // used '<' so we can start at the month prior to the range selected
          // .. this allows us to compere movement
          if (qrySales.FieldByName('SaleDate').AsDateTime < dtFrom) then begin
            rTotAmount := rTotAmount + FieldByName('TotalLineAmountInc').AsFloat;
            rTotSold := rTotSold + FieldByName('Shipped').AsFloat;
            Next;
          end else begin
            UpdateRow;
            iGridRow := iGridRow + 1;
            grdSales.RowCount := iGridRow + 1;
            dtFrom := IncMonth(dtFrom);
          end;
          // No, we are then basing it off Ship Date
        end else begin
          // used '<' so we can start at the month prior to the range selected
          // .. this allows us to compere movement
          if (FieldByName('ShipDate').AsDateTime < dtFrom) then begin
            rTotAmount := rTotAmount + FieldByName('TotalLineAmountInc').AsFloat;
            rTotSold := rTotSold + FieldByName('Shipped').AsFloat;
            Next;
          end else begin
            UpdateRow;
            iGridRow := iGridRow + 1;
            grdSales.RowCount := iGridRow + 1;
            dtFrom := IncMonth(dtFrom);
          end;
        end;
      end;
      // Update Row Data
      UpdateRow;
    end;

    // Set Total Cell Areas.
    lblTotQty.Caption := CurrToStrF(rGrandQty, ffGeneral, 2);
    lblTotAmnt.Caption := AppEnv.RegionalOptions.CurrencySymbol + CurrToStrF(rGrandTot, ffFixed, 2);
  end;
end;
procedure TfrmParts.lsTDNMSpeedButtonActionsUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  btnSetDocumentPath.Enabled :=  AccessLevel < 3;
  btnOpenDocumentPath.Enabled := btnSetDocumentPath.Enabled;
end;

procedure TfrmParts.lstImageTypesClickCheck(Sender: TObject);
var
  s: string;
  x: integer;
begin
  inherited;
  s := '';
  for x := 0 to lstImageTypes.Count -1 do begin
    if lstImageTypes.Checked[x] then begin
      if s <> '' then s := s + ',';
      s := s + slPictureCodes[slPictureCodes.IndexOfObject(lstImageTypes.Items.Objects[x])];
    end;
  end;
  ProductPicture.ImageTypes := s;
end;

procedure TfrmParts.btnPurchViewClick(Sender: TObject);
begin
  Processingcursor(True);
  try
    GetPurchDB;
    LoadPurchGrid;
  finally
    Processingcursor(False);
  end;
end;
procedure TfrmParts.GetPurchDB;
var
  dtFrom, dtTo: TDateTime;
begin
  dtFrom := IncMonth(Trunc(dtpPurchFrom.Date), -1); // we go back a month so we can compare figures
  dtTo := Trunc(dtpPurchTo.Date);

  with qryPurch do
  begin
    qryPurch.Close;
    SQL.Clear;
      SQL.Add('SELECT tblPurchaseOrders.PurchaseOrderID, OrderDate, InvoiceDate, LineCost, LineCostInc, TotalLineAmountInc, QtySold, Shipped ' +
        'FROM tblPurchaseOrders INNER JOIN tblPurchaseLines Using(PurchaseOrderID) ' +
        'WHERE IsPO="T" ' +
        'AND ProductID = :xProductID ' );
    if not chkBasePurchOn.Checked then
        SQL.add('And OrderDate BETWEEN :xDateFrom AND :xDateTo Order by OrderDate;')
    else
        SQL.add('And InvoiceDate BETWEEN :xDateFrom AND :xDateTo order by invoiceDate;');

    params.ParamByName('xDateFrom').asDate := dtFrom;
    params.ParamByName('xDateTo').asDate := dtTo;
    params.ParamByName('xProductID').asInteger := KeyID;
    Open;
  end;

end;
procedure TfrmParts.LoadPurchGrid;
{ Loads the grid, assumes that
  1. the purchase query is restricted to the range we are interested in
  2. the from date dtpPurchFrom is set to the 1st of the starting month }
var
  rTotAmount: Currency;
  rTotSold: Double;
  rGrandTot: Double;
  rGrandQty: Double;
  dtFrom: TDateTime;
  iGridRow: Integer;
  rPrevTotAmount: Currency;

  procedure UpdateRow;
  begin
    if iGridRow <> 0 then
    begin // do not display or accumulate first month
      with grdPurch do
      begin
        Cells[COL_DATE        , iGridRow] := FormatDateTime('MMMM yyy', IncMonth(dtFrom, -1));
        Cells[COL_QTY         , iGridRow] := FloatToStrF(rTotSold, ffGeneral, 7, 2);
        Cells[COL_VALUE       , iGridRow] := CurrToStrF(rTotAmount, ffFixed, 2);
        Cells[COL_AVERAGE     , iGridRow] := CurrToStrF(DivZer(rTotAmount, rTotSold), ffFixed, 2);
        Cells[COL_PERCENT_MOVE, iGridRow] := FloatToStrF(DivZer((rTotAmount - rPrevTotAmount), rTotAmount) * 100, ffFixed, 7, 2);
        Cells[COL_PERCENT_TOT , iGridRow] := FloatToStrF(DivZer(rTotAmount,GetPurchGrandTotal(IncMonth(dtFrom, -1), IncDay(dtFrom, -1))) * 100, ffFixed, 5, 2);


      end;
      rGrandQty := rGrandQty + rTotSold;
      rGrandTot := rGrandTot + rTotAmount;
    end;
    rPrevTotAmount := rTotAmount;
    rTotSold := 0;
    rTotAmount := 0;
  end;
begin // LoadPurchGrid
  rPrevTotAmount:= 0;
  rTotAmount:=0;
  rGrandTot := 0.0;
  rGrandQty := 0.0;
  iGridRow := 0;
  grdPurch.RowCount := 1;

  dtFrom := Trunc(dtpPurchFrom.Date);
  with qryPurch do
  begin
    if not IsEmpty then
    begin
      // Get first record.
      First;
      while not Eof do
      begin
        // Are we basing results from Order Date?
        if not chkBasePurchOn.Checked then
        begin
          // used '<' so we can start at the month prior to the range selected
          // .. this allows us to compare movement for the fisrt month of our range
          if (FieldByName('OrderDate').AsDateTime < dtFrom) then
          begin
            // Accumulate Totals
            rTotAmount := rTotAmount + FieldByName('TotalLineAmountInc').AsFloat;
            rTotSold := rTotSold + FieldByName('Shipped').AsFloat;
            // Fetch next record.
            Next;
          end
          else
          begin
            // Update row data.
            UpdateRow;
            // Point to next row index.
            iGridRow := iGridRow + 1;
            // Advance Row ccount.
            grdPurch.RowCount := iGridRow + 1;
            // Set next date from range by one month ahead.
            dtFrom := IncMonth(dtFrom);
          end;

          // No, we are basing it from Invoice Date.
        end
        else
        begin
          // used '<' so we can start at the month prior to the range selected
          // .. this allows us to compere movement for the fisrt month of our range
          if (FieldByName('InvoiceDate').AsDateTime < dtFrom) then
          begin
            // Accumulate Totals
            rTotAmount := rTotAmount + FieldByName('TotalLineAmountInc').AsFloat;
            rTotSold := rTotSold + FieldByName('Shipped').AsFloat;
            // Fetch next record.
            Next;
          end
          else
          begin
            // Update row data.
            UpdateRow;
            // Point to next row index.
            iGridRow := iGridRow + 1;
            // Advance Row ccount.
            grdPurch.RowCount := iGridRow + 1;
            // Set next date from range by one month ahead.
            dtFrom := IncMonth(dtFrom);
          end;
        end;
      end;
      // Update row data.
      UpdateRow;
    end;

    // Update Total Cells Area.
    lblPurchTotQty.Caption := FloatToStrF(rGrandQty, ffGeneral, 15, 2);
    lblPurchTotAmnt.Caption := FloatToStrF(rGrandTot, ffCurrency, 15, CurrencyRoundPlaces);
  end;

end;
procedure TfrmParts.btnDetailsClick(Sender: TObject);
begin
  inherited;
  OpenERplistForm('TProductPurchaseMovementListGUI' , beforeshowProductPurchaseMovementList);
end;
procedure TfrmParts.CheckForSNEquipmentnAllocateForHire;
begin
  If not AppEnv.CompanyPrefs.UseHire then Exit;
  if QryProductSNTracking.AsBoolean =False then exit;
  if QryProductISEquipment.AsBoolean =False then exit;

  OpenERPListFormultiselectModal('TProductSerialNumbersForHireGUI' , initSerialsAllocatedInPO , OnSelectSerialsAllocatedInPO)
end;
Procedure TfrmParts.initSerialsAllocatedInPO(Sender:Tobject);
begin
    if not(Sender is TProductSerialNumbersForHireGUI) then exit;
    TProductSerialNumbersForHireGUI(Sender).ProductId := QryProductPartsID.AsInteger;
    TProductSerialNumbersForHireGUI(Sender).OnGidMultiselect := OnSerialsAllocatedInPOMultiselect;
end;
Procedure TfrmParts.OnSelectSerialsAllocatedInPO(Sender: TwwDbGrid);
begin
    if not(Assigned(Sender.owner)) or not(Sender.owner is TProductSerialNumbersForHireGUI) then exit;
    TProductSerialNumbersForHireGUI(Sender.owner).CreateEquipsForSelectedSerials;
end;
Procedure TfrmParts.OnSerialsAllocatedInPOMultiselect(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  if Selecting then begin
    if grid.datasource.dataset.findfield('Details') <> nil then
      if grid.datasource.dataset.findfield('Details').asInteger <> 3 then begin
        Accept := False;
        Exit;
      end;

    if grid.datasource.dataset.findfield('EquipmentId') <> nil then
      if grid.datasource.dataset.findfield('EquipmentId').asInteger >0 then begin
        Accept := False;
        Exit;
      end;

  end;
end;

procedure TfrmParts.btnMakeBOMClick(Sender: TObject);
begin
  inherited;
  if PartHasTree then begin
    MessageDlgXP_Vista('This Product ' + Quotedstr(qryProductProductPrintName.AsString) + ' Already has a BOM Tree.'+NL+
                        'It is not Possible Create Tree For Related Parts', mtInformation, [mbOK], 0);
    Exit;
  end;
  if qryRelatedParts.RecordCount = 0 then begin
    MessageDlgXP_Vista('This Product ' +  Quotedstr(qryProductProductPrintName.AsString) +' Doesn''t Have Any Related Parts to Make The Tree With.', mtInformation, [mbOK], 0);
    Exit;
  end;
  if MessageDlgXP_Vista('Creating BOM Tree Using This Product (' +  Quotedstr(qryProductProductPrintName.AsString) +')''s Related Parts will Delete all its Related Parts.'+NL+NL+
                        'It is not Possible to Revert it.' +NL+
                        'Do You Wish to Continue? ', mtconfirmation, [mbyes,mbno], 0)= mrno then exit;

  if not SaveProduct then Exit;
  TRY
    BeginTransaction;
    try
     MakeTreeFromRelatedParts;
     CommitTransaction;
     pageControl.ActivePageindex := NewManufacture.tabindex;
     Pagecontrol.onchange(Pagecontrol);
     MessageDlgXP_Vista('Assembly for 1 Hour is Added to the BOM. Please Change it if Its Different', mtInformation, [mbOK], 0);
    Except
      on E:Exception do begin
        RollbackTransaction;
      end;
    end;
  FINALLY
    BeginTransaction;
  END;


end;
Procedure TfrmParts.MakeRelatedPArtsFromTree;
var
  Proctree:TProcTree;
  scr :TERPScript;
begin
  MakeAssemblyProcess;

  Proctree:= TProcTree.create(Self);
  try
    Proctree.connection := TMyDAcDataconnection.Create(Self);
    Proctree.connection.connection := QryProduct.connection;
    Proctree.LoadSelect('masterId= ' + inttostr(QryProductPartsID.asInteger)+' and masterType = ' +quotedstr('mtProduct'));
    if Proctree.count =0 then exit;
    Proctree.First;
    While Proctree.Eof = False do begin
      if Proctree.PArtsId <> 0 then begin
          if qryRelatedParts.locate('ProductID' ,Proctree.PArtsId  , []) = False then begin
            qryRelatedParts.Append;
            qryRelatedPartsPartName.asString := Proctree.Caption;
            qryRelatedPartsPartName.asString := Proctree.Description;
            qryRelatedPartsParentQty.asFloat := Proctree.Quantity;
            qryRelatedPartsParentQty.asfloat := Proctree.TotalQty;
            qryRelatedPartsZeroWhenLessthan1.asBoolean := Proctree.ZeroWhenLessthan1;
            qryRelatedPartsIsToRoundtoNextNumberinSales.asBoolean := Proctree.RoundtoNextNumber;
            qryRelatedPartsIsToRoundtoPreviousNumberinSales.asBoolean := Proctree.RoundtoPrevNumber;
            PostDB(qryRelatedParts);
          end;
      end;
      Proctree.Next;
    end;
  finally
    Freeandnil(Proctree);
  end;
      scr := DbSharedObj.GetScript(QryProduct.connection);
      try
        scr.SQL.Clear;
        scr.SQL.add('DELETE FROM tblprocesspartqty        WHERE ProcessPartID in (Select ProcessPartID FROM tblprocesspart WHERE proctreeid in (select ProctreeId FROM tblproctree WHERE mastertype ="mtProduct" and masterid = ' + inttostr(QryProductPartsId.asInteger)+'));');
        scr.SQL.add('DELETE FROM tblprocesstime           WHERE ProcessPartID in (Select ProcessPartID FROM tblprocesspart WHERE proctreeid in (select ProctreeId FROM tblproctree WHERE mastertype ="mtProduct" and masterid = ' + inttostr(QryProductPartsId.asInteger)+'));');
        scr.SQL.add('DELETE FROM tblprocessparttimesheet  WHERE ProcessPartID in (Select ProcessPartID FROM tblprocesspart WHERE proctreeid in (select ProctreeId FROM tblproctree WHERE mastertype ="mtProduct" and masterid = ' + inttostr(QryProductPartsId.asInteger)+'));');
        scr.SQL.add('DELETE FROM tblprocesspart           WHERE proctreeid    in (select ProctreeId FROM tblproctree WHERE mastertype ="mtProduct" and masterid = ' + inttostr(QryProductPartsId.asInteger)+');');
        scr.SQL.add('DELETE FROM tblproctree              WHERE mastertype ="mtProduct" and masterid = ' + inttostr(QryProductPartsId.asInteger)+';');
        scr.Execute;
      finally
        DbSharedObj.ReleaseObj(scr);
      end;


end;
Procedure TfrmParts.MakeTreeFromRelatedParts;
var
  Proctree: TProcTree;
  fiProctreeID: Integer;
begin
  MakeAssemblyProcess;

  Proctree := TProcTree.Create(Self);
  try
    Proctree.Connection := TMyDAcDataconnection.Create(Self);
    Proctree.Connection.Connection := QryProduct.Connection;
    Proctree.LoadSelect('masterId = ' + IntToStr(QryProductPartsID.AsInteger) + ' AND masterType = ' + QuotedStr('mtProduct'));
    if Proctree.count > 0 then begin
      MessageDlgXP_Vista('A Tree Already exists for this Product. It is not possible to create another.', mtWarning, [mbOK], 0);
      Exit;
    end;
    Proctree.New;
    Proctree.ParentID := 0;
    Proctree.MasterId := QryProductPartsID.AsInteger;
    Proctree.Mastertype := 'mtProduct';
    Proctree.Sequencedown := 0;
    Proctree.SequenceUp := qryRelatedParts.RecordCount + 1;
    Proctree.Caption := qryProductProductPrintName.AsString;
    Proctree.Description := Qryproductpartsdescription.AsString;
    Proctree.PartsId := QryProductPartsID.AsInteger;
    Proctree.IsTemplate := True;
    Proctree.Quantity := 1;
    Proctree.TotalQty := 1;
    Proctree.PArtsource := 'psManufacture';
    Proctree.Inputtype := 'itNone';
    Proctree.Level := 0;
    Proctree.QtyPer := 1;
    Proctree.TreePartUOMQuantity :=1;
    Proctree.TreePartUOMTotalQty :=1;
    Proctree.PostDB;
    Proctree.TreeRootId := Proctree.ID;
    Proctree.PostDB;
    fiProctreeID:= Proctree.ID;

    Proctree.ProcessPart.New;
    Proctree.ProcessPart.ProcessStepId := ProcessStepID('Assembly');
    Proctree.ProcessPart.ProcessStepSeq := 10;
    Proctree.ProcessPart.ProcTreeId := fiProcTreeId;
    Proctree.ProcessPart.IsTemplate := true;
    Proctree.ProcessPart.Duration := 3600;
    Proctree.ProcessPart.PostDB;

    qryRelatedParts.First;
    While qryRelatedParts.EOF = False do begin
      Proctree.New;
      Proctree.TreeRootId := fiProctreeID;
      Proctree.PArentId := fiProctreeID;
      Proctree.MasterId := QryProductPartsID.AsInteger;
      Proctree.Mastertype := 'mtProduct';
      Proctree.Sequencedown := qryRelatedParts.Recno;
      Proctree.SequenceUp := (qryRelatedParts.RecordCount - qryRelatedParts.Recno) + 1;
      Proctree.Caption := qryRelatedPartsPartName.AsString;
      Proctree.Description := qryRelatedPartsPartName.AsString;
      Proctree.PartsId := qryRelatedPartsProductID.AsInteger;
      Proctree.IsTemplate := True;
      if qryRelatedPartsParentQty.AsFloat <> 1 then begin
        Proctree.Quantity := 1 / qryRelatedPartsParentQty.AsFloat;
        Proctree.TotalQty := 1 / qryRelatedPartsParentQty.AsFloat;
        Proctree.TreePartUOMQuantity := 1 / qryRelatedPartsParentQty.AsFloat;
        Proctree.TreePartUOMTotalQty := 1 / qryRelatedPartsParentQty.AsFloat;
      end else begin
        Proctree.Quantity := qryRelatedPartsQty.AsFloat;
        Proctree.TotalQty := qryRelatedPartsQty.AsFloat;
        Proctree.TreePartUOMQuantity :=qryRelatedPartsQty.AsFloat;
        Proctree.TreePartUOMTotalQty :=qryRelatedPartsQty.Asfloat;
      end;
      Proctree.PArtsource := 'psManufacture';
      Proctree.Inputtype := 'itNone';
      Proctree.Level := 1;
      Proctree.QtyPer := 1;
      Proctree.ZeroWhenLessthan1 := qryRelatedPartsZeroWhenLessthan1.AsBoolean;
      Proctree.RoundtoNextNumber := qryRelatedPartsIsToRoundtoNextNumberinSales.AsBoolean;
      Proctree.RoundtoPrevNumber := qryRelatedPartsIsToRoundtoPreviousNumberinSales.AsBoolean;
      Proctree.PostDB;
      qryRelatedParts.Next;
    end;

    qryRelatedParts.First;
    While qryRelatedParts.EOF = False do begin
     qryRelatedParts.Delete ;
     qryRelatedParts.First;
    end;
  finally
   Freeandnil(Proctree);
  end;
end;
procedure TfrmParts.btnMakeEquipmentClick(Sender: TObject);
begin
  inherited;
   CheckForSNEquipmentnAllocateForHire;
end;

procedure TfrmParts.btnMakeRelatedFromBOMClick(Sender: TObject);
begin
  inherited;
  if not PartHasTree then begin
    MessageDlgXP_Vista('This Product ' +  Quotedstr(qryProductProductPrintName.AsString) +' Doesn''t  have any BOM Tree.'+NL+
                        'It is not Possible Make Related Parts', mtInformation, [mbOK], 0);
    Exit;
  end;
  if MessageDlgXP_Vista('Creating Related Parts Using This Product (' +  Quotedstr(qryProductProductPrintName.AsString) +')''s BOM will Delete all its Tree.'+NL+NL+
                        'It is not Possible to Revert it.' +NL+
                        'Do You Wish to Continue? ' , mtconfirmation, [mbyes,mbno], 0)= mrno then exit;

  if not SaveProduct then Exit;
  TRY
    BeginTransaction;
    try
     MakeRelatedPArtsFromTree;
     CommitTransaction;
     MessageDlgXP_Vista('Related Parts Are Created From BOM', mtInformation, [mbOK], 0);
    Except
      on E:Exception do begin
        RollbackTransaction;
      end;
    end;
  FINALLY
    BeginTransaction;
  END;


end;

procedure TfrmParts.btnManViewClick(Sender: TObject);
begin
  Processingcursor(True);
  try
    GetManDB;
    LoadManGrid;
  finally
    Processingcursor(False);
  end;
end;
procedure TfrmParts.GetManDB;
var
  dtFrom, dtTo: TDateTime;
begin
  dtFrom := IncMonth( Trunc(dtpFromMan.Date), -1); // we go back a month so we can compare figures
  dtTo := Trunc(dtpToMan.Date);

  with qryMan do
  begin
    qryMan.Close;
    SQL.Clear;
      SQL.Add(' Select Month(if(ifnull(ManDate,"1899-12-30 00:00:00" ) = "1899-12-30 00:00:00" , ifnull(TransDate,Shipdate), ManDate)) as monthno, ');
      SQL.Add(' year(if(ifnull(ManDate,"1899-12-30 00:00:00" ) = "1899-12-30 00:00:00" , ifnull(TransDate,Shipdate), ManDate)) as yearno,  ');
      SQL.Add(' Sum(Qty) as Qty,');
      SQL.Add(' Sum(onBuildQty) as onBuildQty,');
      SQL.Add(' sum(BuildingQty) as BuildingQty,');
      SQL.Add(' sum(if(IsInternalOrder="T",BuiltQty,0)) as BuiltintoStockQty,');
      SQL.Add(' sum(if(IsInternalOrder="F",BuiltQty,0)) as BuiltQty,');
      SQL.Add(' sum(SubBuiltQty) as SubBuiltQty,');
      SQL.Add(' sum(usedtoBuitQty) as usedtoBuitQty,');
      SQL.Add(' sum(totalCost) as totalCost');
      SQL.Add(' from (SELECT  S.SaleID, PQA.Transdate, S.ShipDate,S.IsInternalOrder , ');
      SQL.Add(' PTP.Qty, PT.Cost as totalCost ,');
      SQL.Add(' max(if(ifnull(PP.timeEnd,0)="1899-12-30 00:00:00" , PP.timestart, PP.Timeend)) as ManDate,');
      SQL.Add('SUM(' +SQL4QtyField(tOnBuild)+') as onBuildQty,');
      SQL.Add('SUM(' +SQL4QtyField(tBuilding)+') as BuildingQty,');
      SQL.Add('SUM(' +SQL4QtyField(tBuilt)+') as BuiltQty,');
      SQL.Add('SUM(' +SQL4QtyField(tSubBuilt)+') as SubBuiltQty,');
      SQL.Add('SUM(' +SQL4QtyField(tUSedForBuild)+') as usedtoBuitQty,');
      SQL.Add(' S.converted');
      SQL.Add(' from tblsales S');
      SQL.Add(' inner join tblsaleslines SL on S.SaleID = SL.SaleID');
      SQL.Add(' inner join tblproctree PT on PT.MasterId = SL.SaleLineID and PT.Mastertype <> "mtProduct"');
      SQL.Add(' inner join tblproctreePart PTP on PT.proctreeID = PTP.proctreeID');
      SQL.Add(' Left join tblpqa PQA on PTP.ProcTreePartId = PQA.TransLineID /*and pqa.Alloctype = "IN"*/	and PQA.Transtype in (' + ManufactureTypes +')');
      SQL.Add(' Left join tblProcessPart PP on PP.proctreeId = PT.proctreeID');
      SQL.Add(' WHERE  PTP.productID  = '+ inttostr(KeyID));
      SQL.Add(' group by PT.proctreeId) data');
      SQL.Add(' where if(ifnull(ManDate,"1899-12-30 00:00:00" ) = "1899-12-30 00:00:00" , ifnull(TransDate,Shipdate), ManDate) BETWEEN '+QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom))  +' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtTo))  );
      SQL.Add(' group by year(if(ifnull(ManDate,"1899-12-30 00:00:00" ) = "1899-12-30 00:00:00" , ifnull(TransDate,Shipdate), ManDate))  , ');
      SQL.Add(' Month(if(ifnull(ManDate,"1899-12-30 00:00:00" ) = "1899-12-30 00:00:00" , ifnull(TransDate,Shipdate), ManDate) ) ');
      SQL.Add(' order by year(if(ifnull(ManDate,"1899-12-30 00:00:00" ) = "1899-12-30 00:00:00" , ifnull(TransDate,Shipdate), ManDate)) desc , ');
      SQL.Add(' Month(if(ifnull(ManDate,"1899-12-30 00:00:00" ) = "1899-12-30 00:00:00" , ifnull(TransDate,Shipdate), ManDate) ) desc');
    Open;
  end;
end;
procedure TfrmParts.LoadManGrid;
{ Loads the grid, assumes that
  1. the sales query is restricted to the range we are interested in
  2. the from date dtpFrom is set to the 1st of the starting month }
var
  rGrandTot: Double;
  rGrandQty: Double;
  iGridRow, iGridCol: Integer;
  rPrevTotAmount: Currency;
  fdonBuildQty,fdBuildingQty,fdBuiltQty,fdSubBuiltQty,fdBuiltintoStockQty , fdusedtoBuitQty:double;
  dtFrom : TDate;
const
  MAN_COL_DATE = 0;
  MAN_COL_QTYONBUILD = 1;
  MAN_COL_QTYUSEDTOBUILD=2;
  MAN_COL_QTYBUILDING = 3;
  MAN_COL_QTYBUILT = 4;
  MAN_COL_QTYBUILTTOSTOCK=5;
  MAN_COL_QTYSUBBUILT = 6;
  MAN_COL_VALUE = 7;
  MAN_COL_AVERAGE = 8;
  MAN_COL_PERCENT_MOVE = 9;
begin
  rGrandTot := 0.0;
  rGrandQty := 0.0;
  grdMan.RowCount := 2;
  fdonBuildQty    := 0;
  fdusedtoBuitQty:= 0;
  fdBuildingQty   := 0;
  fdBuiltQty      := 0;
  fdBuiltintoStockQty:=0;
  fdSubBuiltQty   := 0;

  grdman.MergeCells(MAN_COL_DATE            ,0 , MAN_COL_DATE           ,2);
  grdman.MergeCells(MAN_COL_QTYONBUILD      ,0 , MAN_COL_QTYONBUILD     ,2);
  grdman.MergeCells(MAN_COL_QTYUSEDTOBUILD  ,0 , MAN_COL_QTYUSEDTOBUILD ,2);
  grdman.MergeCells(MAN_COL_QTYBUILDING     ,0 , MAN_COL_QTYBUILDING    ,2);
  grdman.MergeCells(MAN_COL_QTYBUILT        ,0 , MAN_COL_QTYBUILT       ,2);
  grdman.MergeCells(MAN_COL_QTYBUILTTOSTOCK ,0 , MAN_COL_QTYBUILTTOSTOCK,2);
  grdman.MergeCells(MAN_COL_QTYSUBBUILT     ,0 , MAN_COL_QTYSUBBUILT    ,2);
  grdman.MergeCells(MAN_COL_VALUE           ,0 , MAN_COL_VALUE          ,2);
  grdman.MergeCells(MAN_COL_AVERAGE         ,0 , MAN_COL_AVERAGE        ,2);
  grdman.MergeCells(MAN_COL_PERCENT_MOVE    ,0 , MAN_COL_PERCENT_MOVE   ,2);
  iGridRow:=0;
  iGridCol:= MAN_COL_DATE           ;grdman.Cells[iGridCol , iGridRow] := 'Month';
  iGridCol:= MAN_COL_QTYONBUILD     ;grdman.Cells[iGridCol , iGridRow] := 'On Build Raw' ;
  iGridCol:= MAN_COL_QTYUSEDTOBUILD ;grdman.Cells[iGridCol , iGridRow] := 'Used to Build' ;
  iGridCol:= MAN_COL_QTYBUILDING    ;grdman.Cells[iGridCol , iGridRow] := 'Building' ;
  iGridCol:= MAN_COL_QTYBUILT       ;grdman.Cells[iGridCol , iGridRow] := 'Built and' +NL+'Sold';
  iGridCol:= MAN_COL_QTYBUILTTOSTOCK;grdman.Cells[iGridCol , iGridRow] := 'Built into'+NL+'Stock' ;
  iGridCol:= MAN_COL_QTYSUBBUILT    ;grdman.Cells[iGridCol , iGridRow] := 'Sub' +NL+'Built';
  iGridCol:= MAN_COL_VALUE          ;grdman.Cells[iGridCol , iGridRow] := 'Total Cost'+' ' +AppEnv.RegionalOptions.CurrencySymbol;
  iGridCol:= MAN_COL_AVERAGE        ;grdman.Cells[iGridCol , iGridRow] := 'Average' +' ' +AppEnv.RegionalOptions.CurrencySymbol;
  iGridCol:= MAN_COL_PERCENT_MOVE   ;grdman.Cells[iGridCol , iGridRow] := '    %' +NL+'Movement';

  dtFrom:= StartOfThemonth(dtpToMan.Date);
  with qryMan do  begin
    if not IsEmpty then begin
      First;
      rPrevTotAmount:= 0;
      while  dateof(dtFrom) >= dateof(dtpFromMan.Date ) do begin
        With Grdman do begin
          grdman.RowCount := grdman.RowCount + 1;
          iGridRow :=grdman.RowCount -1;
          iGridCol:= MAN_COL_DATE ;Cells[iGridCol , iGridRow] := FormatDateTime('MMMM yyy',dtFrom);
          if Locate('monthno;yearno' , vararrayof([monthof(dtfrom), yearof(dtfrom)]), []) then begin
            iGridCol:= MAN_COL_QTYONBUILD     ;if fieldbyname('onBuildQty').AsFloat       = 0 then Cells[iGridCol , iGridRow] := '' else Cells[iGridCol , iGridRow] := FloatToStrF(fieldbyname('onBuildQty').AsFloat , ffGeneral, 7, 2);
            iGridCol:= MAN_COL_QTYUSEDTOBUILD ;if fieldbyname('usedtoBuitQty').AsFloat    = 0 then Cells[iGridCol , iGridRow] := '' else Cells[iGridCol , iGridRow] := FloatToStrF(fieldbyname('usedtoBuitQty').AsFloat , ffGeneral, 7, 2);

            iGridCol:= MAN_COL_QTYBUILDING    ;if fieldbyname('BuildingQty').AsFloat      = 0 then Cells[iGridCol , iGridRow] := '' else Cells[iGridCol , iGridRow] := FloatToStrF(fieldbyname('BuildingQty').AsFloat , ffGeneral, 7, 2);
            iGridCol:= MAN_COL_QTYBUILT       ;if fieldbyname('BuiltQty').AsFloat         = 0 then Cells[iGridCol , iGridRow] := '' else Cells[iGridCol , iGridRow] := FloatToStrF(fieldbyname('BuiltQty').AsFloat , ffGeneral, 7, 2);
            iGridCol:= MAN_COL_QTYBUILTTOSTOCK;if fieldbyname('BuiltintoStockQty').AsFloat= 0 then Cells[iGridCol , iGridRow] := '' else Cells[iGridCol , iGridRow] := FloatToStrF(fieldbyname('BuiltintoStockQty').AsFloat , ffGeneral, 7, 2);
            iGridCol:= MAN_COL_QTYSUBBUILT    ;if fieldbyname('SubBuiltQty').AsFloat      = 0 then Cells[iGridCol , iGridRow] := '' else Cells[iGridCol , iGridRow] := FloatToStrF(fieldbyname('SubBuiltQty').AsFloat , ffGeneral, 7, 2);
            iGridCol:= MAN_COL_VALUE          ;if fieldbyname('totalcost').AsFloat        = 0 then Cells[iGridCol , iGridRow] := '' else Cells[iGridCol , iGridRow] := FloatToStrF(fieldbyname('totalcost').AsFloat , ffCurrency, 7,2);
            iGridCol:= MAN_COL_AVERAGE        ;if fieldbyname('totalcost').AsFloat        = 0 then Cells[iGridCol , iGridRow] := '' else Cells[iGridCol , iGridRow] := FloatToStrF(DivZer(fieldbyname('totalcost').AsFloat , FieldByname('Qty').asFloat ), ffCurrency, 7,2);
            iGridCol:= MAN_COL_PERCENT_MOVE   ;if fieldbyname('totalcost').AsFloat        = 0 then Cells[iGridCol , iGridRow] := '' else Cells[iGridCol , iGridRow] := FloatToStrF(DivZer((fieldbyname('totalcost').AsFloat - rPrevTotAmount), fieldbyname('totalcost').AsFloat) * 100, ffFixed, 7, 2);
            rPrevTotAmount      := fieldbyname('totalcost').AsFloat;
            fdonBuildQty        := fdonBuildQty       + fieldbyname('onBuildQty').AsFloat;
            fdusedtoBuitQty     := fdusedtoBuitQty    + fieldbyname('usedtoBuitQty').AsFloat;
            fdBuildingQty       := fdBuildingQty      + fieldbyname('BuildingQty').AsFloat;
            fdBuiltQty          := fdBuiltQty         + fieldbyname('BuiltQty').AsFloat;
            fdBuiltintoStockQty := fdBuiltintoStockQty+ FieldByname('BuiltintoStockQty').asFloat;
            fdSubBuiltQty       := fdSubBuiltQty      + fieldbyname('SubBuiltQty').AsFloat;
            rGrandQty           := rGrandQty          + FieldByname('Qty').asFloat;
            rGrandTot           := rGrandTot          + fieldbyname('totalcost').AsFloat;
          end else begin
            rPrevTotAmount      := 0;
            iGridCol:= MAN_COL_QTYONBUILD     ;Cells[iGridCol , iGridRow] := '' ;
            iGridCol:= MAN_COL_QTYUSEDTOBUILD ;Cells[iGridCol , iGridRow] := '' ;
            iGridCol:= MAN_COL_QTYBUILDING    ;Cells[iGridCol , iGridRow] := '' ;
            iGridCol:= MAN_COL_QTYBUILT       ;Cells[iGridCol , iGridRow] := '' ;
            iGridCol:= MAN_COL_QTYBUILTTOSTOCK;Cells[iGridCol , iGridRow] := '' ;
            iGridCol:= MAN_COL_QTYSUBBUILT    ;Cells[iGridCol , iGridRow] := '' ;
            iGridCol:= MAN_COL_VALUE          ;Cells[iGridCol , iGridRow] := '' ;
            iGridCol:= MAN_COL_AVERAGE        ;Cells[iGridCol , iGridRow] := '' ;
            iGridCol:= MAN_COL_PERCENT_MOVE   ;Cells[iGridCol , iGridRow] := '' ;
          end;
          dtFrom:= incmonth(dtFrom,-1);
        end;
      end;
    end;

    lblonbuild.Caption        := FloatToStrF(fdonBuildQty       , ffGeneral,7,2);
    lblusedtoBuit.Caption     := FloatToStrF(fdusedtoBuitQty    , ffGeneral,7,2);
    lblbuilding.Caption       := FloatToStrF(fdBuildingQty      , ffGeneral,7,2);
    lblBuilt.Caption          := FloatToStrF(fdBuiltQty         , ffGeneral,7,2);
    lblsubbuilt.Caption       := FloatToStrF(fdSubBuiltQty      , ffGeneral,7,2);
    lblbuiltIntoStock.Caption :=FloatToStrF(fdBuiltintoStockQty , ffGeneral,7,2);
    lbltotalAmount.Caption    := FloatToStrF(rGrandTot          , ffCurrency,7,2);
  end;
end;
procedure TfrmParts.qryProductCalcFields(DataSet: TDataSet);
var
  s:String;
begin
  inherited;
  s:=cDocumentPath(qryProduct);
  if not(sametext(qryProductcDocumentPath.AsString   , s)) then qryProductcDocumentPath.AsString  := s;
  qryProductTotalLandedCost.asFloat := qryProductLandedCost.asFloat + qryProductLatestCost.asFloat;
end;
procedure TfrmParts.btnSetDocumentPathClick(Sender: TObject);
begin
  SetDocPath(qryproduct);
end;
procedure TfrmParts.btnOpenDocumentPathClick(Sender: TObject);
begin
  inherited;
   OpenDocPath(QryProduct);
end;
procedure TfrmParts.btnPriceCalcClick(Sender: TObject);
begin
  inherited;
  if TfmPartsPriceCalc.DoPartsPriceCalc(Self) then begin
    if QryProductPrice1.AsFloat <>  ProductMarkupPrice then begin
      bFinishedOnShow := False;
      try
        if tglGST.Caption <> 'Price (Ex)' then tglGST.Click;
      finally
        bFinishedOnShow := True;
      end;
      editDB(QryProduct);
      QryProductPrice1.AsFloat :=  ProductMarkupPrice;
      txtRetailPriceIncExit(txtRetailPriceInc);
      PostDB(QryProduct);
    end;
  end;
end;

procedure TfrmParts.qryImportProductsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if qryimportProduct.active =false then opendb(qryimportProduct);
  qryImportProducts.parambyname('supplierId').AsInteger        := qryimportProductSupplierId.AsInteger;
  qryImportProducts.parambyname('CountryofOriginId').AsInteger := qryimportProductCountryOfOriginId.AsInteger;
end;
procedure TfrmParts.btnMultiAdjustClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselectModal('TProductListExpressGUI' , initProductListExpress, AddImportProducts);
end;
procedure TfrmParts.initProductListExpress(Sender: TObject);
begin
   if not(Sender is TProductListExpressGUI) then exit;
   TProductListExpressGUI(Sender).FilterString := 'Parttype = ' + quotedstr('INV') +
                                                  ' and Discontinued =  ' + quotedstr('F') +
                                                  ' and Active =  ' + quotedstr('T') +
                                                  ' and PartsId <> ' + inttostr(qryProductpartsId.asInteger);
end;
procedure TfrmParts.AddImportProducts(Sender: TwwDBGrid);
var
  s:String;
var
  scr :TERPScript;
begin
  inherited;
  s:= SelectedIds(sender , 'PartsID');
  if s = '' then exit;
  scr := DbSharedObj.GetScript(qryProduct.Connection);
  try
    scr.SQL.Text := 'insert ignore into tblImportProducts(ProductId, SupplierId, CountryOfOriginId, Duty, Handling) '+
                    ' Select  PartsID , ' +
                              inttostr(qryimportProductSupplierId.AsInteger) +' as SupplierId , ' +
                              inttostr(qryimportProductCountryOfOriginId.AsInteger) +' as CountryOfOriginId , ' +
                              floattostr(qryimportProductDuty.asFloat) +' as Duty , ' +
                              floattostr(qryimportProductHandling.asFloat) +' as Handling  ' +
                    ' from tblparts where partsid in (' + s +')'+
                    ' ON DUPLICATE KEY UPDATE Duty     =' + floattostr(qryimportProductDuty.asFloat    ) +'  , ' +
                                            ' Handling =' + floattostr(qryimportProductHandling.asFloat) +';';
    clog(Scr.SQL.Text);
    scr.Execute;
    closedb(qryImportProducts);
    Opendb(qryImportProducts);
  finally
    DbSharedObj.ReleaseObj(scr);
  end;

end;
procedure TfrmParts.cbDutiesCountryCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  EditDB(qryimportProduct);
  qryimportProductCountryOfOriginId.asInteger := qryCountryCountryId.asInteger;
end;

procedure TfrmParts.cbDutiesSupplierCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  EditDB(qryimportProduct);
  qryimportProductSupplierID.asInteger := cboClientLookupclientId.asInteger;
end;

procedure TfrmParts.InitERPLookupCombonFields;
begin
  inherited;
  SetupProductNamenPrintNameinGrid(cboProductR        ,cboPrintProductR         ,'AlternateProductName' , 'AlternateProductPrintName' , 'PARTSDESCRIPTION' , grdAlternateProducts );
  SetupProductNamenPrintNameinGrid(cboProductsrelated ,cboPrintProductsrelated  ,'PartName'             , 'ProductPrintName'          , 'PARTSDESCRIPTION' , grdRelatedParts );
end;

procedure TfrmParts.UpdateProductDescriptionFromTreeInfo(var fscleanSelectedInfos  :String; const  fsSelectedInfos   :String; Var fscleanAllInfos  :String; const  fsAllInfos:String);
begin
        if ProcPrefs.UpdateProductDescriptionFromTreeInfo then begin
          EditDB(qryProduct);
          //qryProductPURCHASEDESC.asString     := trim(replacestr(qryProductPURCHASEDESC.asString  , fscleanAllInfos , '') + NL+ fsAllInfos);
          qryProductPURCHASEDESC.asString     := Trim(fsAllInfos);
          fscleanAllInfos := qryProductPURCHASEDESC.asString;
          qryProductPARTSDESCRIPTION_Memo.AsString := Trim(fsAllInfos);
//          qryProductPARTSDESCRIPTION.asString := trim(replacestr(qryProductPARTSDESCRIPTION.asString  , fscleanSelectedInfos , '') + NL+ fsSelectedInfos);
          qryProductPARTSDESCRIPTION.asString := Trim(fsSelectedInfos);
          fscleanSelectedInfos :=qryProductPARTSDESCRIPTION.asString;
          qryProductPURCHASEDESC_Memo.AsString := Trim(fsSelectedInfos);
          POSTDB(qryProduct);
          self.ChangeMemoButtonColours;
        end;
end;
procedure TfrmParts.QryAlternateProductsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  QryAlternateProductsProductName.asString := QryProductPartName.asString;
  QryAlternateProductsProductID.asInteger   := QryProductPartsID.asInteger;
end;
procedure TfrmParts.qryRelatedPartsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryRelatedPartsParentID.AsInteger := qryProductPARTSID.AsInteger;
  qryRelatedPartsHideRelated.asBoolean := False;
  qryRelatedPartsCanDelete.asBoolean := True;
  qryRelatedPartsIshidden.asBoolean := False;
  qryRelatedPartsParentQty.asFloat := 1;
  qryRelatedPartsQty.asFloat := 1;
  FlagAsUpdated(self.qryProduct);
end;
procedure TfrmParts.qryProductAfterInsert(DataSet: TDataSet);
begin
  inherited;
    fbPartnameMadeFromName := False;
    ProductclassPartsID:=0;
    qryProductBatch.asString := 'F';
    qryProductMultipleBins.AsString := 'F';
    qryProductGrossMarginMode.asString := 'F';
    QryproductSalesTaxBasedon.asString := 'SP';
    rgMarkupType.Itemindex := 1;
    qryProductDocumentPath.AsString := Appenv.DocPath.DocumentPath;
end;
procedure TfrmParts.qrywalmartitemsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qrywalmartitemsERPProductId.AsInteger := qryProductPARTSID.AsInteger;
  if sametext(appenv.companyprefs.WALMART_ProductNameField , 'P') then begin
    qrywalmartitemsProductName.asString := qryProductPARTNAME.asString;
    qrywalmartitemsSku.asString := qryProductProductPrintName.asString;
  end else begin
    qrywalmartitemsSku.asString := qryProductPARTNAME.asString;
    qrywalmartitemsProductName.asString := qryProductProductPrintName.asString;
  end;
  qrywalmartitemsWpid.asString := inttostr(qryProductPartsID.asInteger);

  if qrywalmartitemsPrice_Currency.asString = '' then qrywalmartitemsPrice_Currency.asString := Appenv.RegionalOptions.ForeignExDefault;
  if (trim(qrywalmartitemsPrice_Amount.asString)='')  then
      qrywalmartitemsPrice_Amount.asString := FloattostrF(qryProductPRICEINC1.asInteger , ffGeneral, 15,2);
end;
procedure TfrmParts.qryProductClassAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryProductClassProductID.AsInteger  := qryProductPARTSID.AsInteger;
  qryProductClassProductName.AsString := qryProductPARTNAME.AsString;
  qryProductClassProductGroup.AsString:= qryProductPRODUCTGROUP.AsString;
  qryProductClassActive.asboolean     := True;
end;
procedure TfrmParts.QryPartHirePricingAfterInsert(DataSet: TDataSet);
begin
  inherited;
  QryPartHirePricingProductID.asInteger := qryProductPARTSID.asInteger;
  QryPartHirePricingEquipmentId.asInteger := 0;
  QryPartHirePricingMinHirePeriod.asInteger := 1;
  QryPartHirePricingMinHirePeriodType.asString := 'H';
end;
procedure TfrmParts.QryPartHirePricingLinesAfterInsert(DataSet: TDataSet);
begin
  inherited;
   QryPartHirePricingLinesHirePriceID.AsInteger :=  QryPartHirePricingHirePriceId.AsInteger;
   QryPartHirePricingLinesActive.asBoolean := True;
end;

procedure TfrmParts.QryPartsProcessAfterInsert(DataSet: TDataSet);
begin
  inherited;
  QryPartsProcessPartId.asinteger := qryProductPARTSID.asInteger;
  QryPartsProcessProcessStepSeq.asInteger:= fiseq+1;;
end;

procedure TfrmParts.qryPartPicsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryPartPicspartID.asinteger := qryProductPARTSID.asInteger;
end;
procedure TfrmParts.qryimportProductAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryimportProductProductId.AsInteger := qryProductpartsId.asInteger;
end;
procedure TfrmParts.qryForeignPriceSellAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryForeignPriceSellPartsId.asInteger := qryProductPARTSID.asInteger;
  qryForeignPriceSellPartName.AsString := qryProductPARTNAME.AsString;
  qryForeignPriceSellBuy1.asfloat := 1;
  qryForeignPriceSellIsSellPrice.AsBoolean := true;
  qryForeignPriceSellUOMMultiplier.asFloat := 1;
end;

procedure TfrmParts.qryExtraBuyPriceAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryExtraBuyPricePartsID.AsInteger := qryProductPARTSID.AsInteger;
  qryExtraBuyPricePartName.AsString := qryProductPartName.AsString;
  qryExtraBuyPriceUOMMultiplier.asFloat := 1;
  qryExtraBuyPriceBuy1.asFloat  := 1;
  qryExtraBuyPricePrice.AsFloat := 0;
end;
procedure TfrmParts.qryForeignPriceAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryForeignPricePartsID.AsInteger := qryProductPARTSID.AsInteger;
  qryForeignPricePartName.AsString := qryProductPARTNAME.AsString;
  qryForeignPriceUOMMultiplier.asFloat := 1;
  qryForeignPriceIsSellPrice.asBoolean := false;
  qryForeignPriceBuy1.asFloat  := 1;
  qryForeignPricePrice1.AsFloat := 0;
end;

procedure TfrmParts.qrySellPricesAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qrySellPricesPartsID.AsInteger := qryProductPARTSID.AsInteger;
  qrySellPricesUOMMultiplier.Asfloat := 1;
end;
procedure TfrmParts.qryPartNotesAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryPartNotesPartsId.asInteger := qryProductPARTSID.asInteger;
  qryPartNotesActive.asBoolean := True;
end;

procedure TfrmParts.qryPartNotesAfterPost(DataSet: TDataSet);
begin
  inherited;
  if trim(qryPartNotesNotes.asString) = '' then
    qryPartNotes.delete;
end;

procedure TfrmParts.qryPartBarCodesAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryPartBarCodesPartsID.asInteger :=  qryProductPartsId.asInteger;
end;
procedure TfrmParts.initPriceifBlank(const Value: Double);
begin
       if qryProductPRICE1.asFloat = 0 then qryProductPRICE1.asFloat  := Value
  else if qryProductPRICE2.asFloat = 0 then qryProductPRICE2.asFloat  := Value
  else if qryProductPRICE3.asFloat = 0 then qryProductPRICE3.asFloat  := Value;
end;
procedure TfrmParts.initCostifBlank(const Value: Double);
begin
       if qryProductCost1.asFloat = 0 then qryProductCost1.asFloat  := Value
  else if qryProductCost2.asFloat = 0 then qryProductCost2.asFloat  := Value
  else if qryProductCost3.asFloat = 0 then qryProductCost3.asFloat  := Value;
end;
function TfrmParts.SalesTaxBasedonProductPrice: boolean;
begin
  result := Sametext(qryProductSalesTaxBasedon.asString , 'PP');
end;
procedure TfrmParts.qryProductSalesTaxBasedonChange(Sender: TField);
begin
  inherited;
//
end;

initialization
  RegisterClassOnce(TfrmParts);
  with FormFact do
  begin
    RegisterMe(TfrmParts, 'TProductListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TMagentoProductsGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TProductsForMagentoGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TWalmartItemsGUI_*=ERPPARTSID');
    RegisterMe(TfrmParts, 'TProductQtylistGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TStSProductQtyListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TBOMProductsListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TProductcustomFieldListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'THireProductListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TProductPriceListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TAreaPOLinesDetailsListGUI_*=ProductID');
    RegisterMe(TfrmParts, 'ProductPictureListGUI_*=PARTSID');
    //RegisterMe(TfrmParts, 'TProductBuyPriceListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TAlternateProductsEBPGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TAlternateProductsGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TProductGeneralSpecListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TProductlisttorecalcAvgCostGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TUnAllocatedQtyGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TProductBarcodesGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TUOMProductListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TProductListwithUOMGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TManufactureProductListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TProductListExpressGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TProductBatchbinSNListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TManufactureSubProductListGUI_*_Parts=PARTSID');
    RegisterMe(TfrmParts, 'TProductListReorderGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TManufactureProductListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TSalesReportGUI_Product Type_*=ProductID');
    RegisterMe(TfrmParts, 'TSalesReportProductcustomFieldListGUI_Product Type_*=ProductID');
    RegisterMe(TfrmParts, 'TSalesReportCustomercustomFieldListGUI_Product Type_*=ProductID');
    RegisterMe(TfrmParts, 'TSalesReportSaleslinescustomFieldListGUI_Product Type_*=ProductID');
    RegisterMe(TfrmParts, 'TSalesReportGUI_Department_*=ProductID');
    RegisterMe(TfrmParts, 'TSalesReportProductcustomFieldListGUI_*=ProductID');
    RegisterMe(TfrmParts, 'TSalesReportGUI_Type_*=ProductID');
    RegisterMe(TfrmParts, 'TSalesReportGUI_Manufacturer_*=ProductID');
    RegisterMe(TfrmParts, 'TSalesReportGUI_Product Name_*=ProductID');
    RegisterMe(TfrmParts, 'TSalesReportGUI_Product Description_*=ProductID');
    RegisterMe(TfrmParts, 'TSerialListGUI_PartName_*=PartsID');
    RegisterMe(TfrmParts, 'TProductSalesListFormSoldGUI_*=PartsID');
    RegisterMe(TfrmParts, 'TProductSalesListFormNotSoldGUI_*=PartsID');
    RegisterMe(TfrmParts, 'TStockQtysLocationsReportGUI_*=PartsID');
    //RegisterMe(TfrmParts, 'TProductnAllocationQtyCheckGUI_*=PartsID');
    RegisterMe(TfrmParts, 'TUnallocatedBinsreportGUI_*ProductID');
    RegisterMe(TfrmParts, 'TSalescommissionListGUI_Name=ProductId');
    RegisterControl(TfrmParts, '*_cboProduct=PARTSID');
    RegisterControl(TfrmParts, '*_cboProductR=PARTSID');
    RegisterControl(TfrmParts, '*_cboProd=PARTSID');
    RegisterControl(TfrmParts, '*_cboParts=PARTSID');
    RegisterControl(TfrmParts, '*_cboGroupName=PartsID');
    RegisterMe(TfrmParts, 'TfmProcProductionPartsList_PartName=TreeProductId');
    RegisterMe(TfrmParts, 'TfmProcProductionPartsList_PartDescription=TreeProductId');
    RegisterMe(TfrmParts, 'TfmProcProductionPartsList_LineProductName=LineProductId');
    RegisterMe(TfrmParts, 'TfmProcProductionPartsList_LineProductDescription=LineProductId');
    RegisterMe(TfrmParts, 'TProductionPartStatusGUI_PROJECTEDQTY_OnOrderRequest=PARTSID');
    RegisterMe(TfrmParts, 'TManufactureSubProductListGUI_*_Main=MainPARTSID');
    RegisterMe(TfrmParts, 'TManufactureSubProductListGUI_*_Sub=SubPARTSID');
    RegisterMe(TfrmParts, 'TProductClassListGUI_*=ProductID');
    RegisterMe(TfrmParts, 'TProductProcessListGUI_*=PartId');
    RegisterMe(TfrmParts, 'TProductSpecificationListGUI_*=PartsId');
    RegisterMe(TfrmParts, 'TProductExtraSellPriceGUI_*=PartsId');
    RegisterMe(TfrmParts, 'TProductExtrabuyPricesGUI_*=PartsId');
    RegisterMe(TfrmParts, 'TProductforeignBuyPriceGUI_*=PartsId');
    RegisterMe(TfrmParts, 'TproductForeignSellPriceGUI_*=PartsId');
    RegisterMe(TfrmParts, 'TRelatedProductsGUI_PartName=ParentID');
    RegisterMe(TfrmParts, 'TRelatedProductsGUI_relatedProduct=ProductID');
    RegisterMe(TfrmParts, 'TBOMWastageReportGUI_ProductName=ProductID');
    RegisterMe(TfrmParts, 'TBOMWastageReportGUI_UOM=ProductID');
    RegisterMe(TfrmParts, 'TBOMWastageReportGUI_ChangedProduct=ProductID');
    RegisterMe(TfrmParts, 'TBOMWastageReportGUI_Quotedproduct=ProductID');
    RegisterMe(TfrmParts, 'TProcesseswithNotimeGUI_*_Product=ProductID');
    RegisterMe(TfrmParts, 'TfrmPriceListGUI_*_Product=PARTSID');
    RegisterMe(TfrmParts, 'TGlobalsearchGUI_*_Product=PARTSID');
    RegisterMe(TfrmParts, 'TDutynHandlingProductListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TCustomFieldValuesListProductGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TProjectedManufacturingQtyGUI_*=MainPartsId');
    RegisterMe(TfrmParts, 'TProductSerialNumberQtyListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TCustomerPriceListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TPartFormulaListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TTreeProductsAvgCostListGUI_*=PARTSID');
    RegisterMe(TfrmParts, 'TPartsForExcelPriceGUI_*=ProductID');
    RegisterMe(TfrmParts, 'TProductSumQtyListGUI_*=ProductID');
  end;
finalization
  UnRegisterClass(TfrmParts);
end.




