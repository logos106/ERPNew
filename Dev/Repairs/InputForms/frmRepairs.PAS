Unit frmRepairs;

{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  29/04/05  1.00.01 BJ  bug Fixed :Unit not comming in the invoice form when invoiced. Leave the
  invoice form opened after invoicing.
  24/05/05  1.00.02 BJ  When the repair is invoiced, the invoice (saleslines) are are created from
  the repairparts table, after the creation of the records, for each record the
  partscombocloseup is executed. This reinitialises the discount to 0 and price
  to the lineprice. The bug is fixed by transferring the value for these fields
  for all detail records after the productcombocloseup.
  25/05/05  1.00.03 BJ(1)Implemented the validation for maximum discount given in the rpeferance.
  (2)-----When the discount is given as %age, the price is calculated on the
  Price+Tex and wh
  en it is the amount ($) the discount is deducted from the
  total amount. For validatingthe maximum dicount %age, the %age is calculated
  on the price excluding the tax
  (3)Open the parts form when double clicked on the parts combo.
  (4)A new field is introduced in the sales table to store the Globalref of the
  repair table when the repair is invoiced.the name of the field is RepairGlobalRef,
  this field will establish the link between the invoice and repair. 'BeforePost'
  of the tblmaster updates the Globalref in the repair table which is moved into
  this new field of the sales when invoiced.
  26/05/05  1.00.04 BJ(1)Job completion date and time : validation for the empty field isbased on the
  compnay Preference
  (2)company : Drill into the field to open the job form instead of the customer
  form. if the selected client doesn't have a job, it allows to create a new job
  (3)The equipment list is populated for the job's equipments or the complete
  Active equipments based on the preference.
  27/05/05  1.00.05 BJ(1)As the company is the mandatory field for repair, no other information can be
  entered in the form before the company is selected.
  07/06/05  1.00.06 BJ   Preference implemeted to check for the credit limit of the customer before
  saving the record. NOTE: The check is not done when the repair is invoiced
  as the invoicing module checks for it and takes the confirmation again.
  07/06/05  1.00.07 IJB  Changed 'Save' logic to allow correct Save/close of form after printing and
  reprinting or reports.
  16/06/05  1.00.08 BJ   New repair automatically creates the job record
  ================================================
  1) 'CreateCustomerJobFromRepair' in the preference defines whether or not to
  create a new job for each repair.
  2) When this is set to true, the client combo lists ONLY the clients without
  any job. Selecting a client here brings up the job form for creating a new
  job record for the selected client.
  3) When this preference is set to True, the client combo is disabled. This is
  because there is a one-to-one relationship between repair and job, if you
  change the job of the repair, the original repair remains in the DB as
  'not linked' to any Repair. It is not possible to delete the old job record
  when it is changed because the relationship between job to repair is one-to-many
  when the preference is false.
  4) When the flag is set to True, it is not possible to create Repairs for an
  existing Job.
  5) Repeat repairs create duplicate repairs records for the same Client, which
  is ok for the time being.
  17/06/05  1.00.09 IJB  Added a new property to form (CreateJobFromRepair) that is initialised to
  CreateCustomerJobFromRepair pref but can be changed before form show to
  control the behavior introduced above.
  20/06/05  1.00.10 BJ   ->Added an option to specify whether or not to invoice a product.
  ->Added the option to create an appointment  form from here.
  BUG Fixed :
  ->The defaulted part - labour should have the default class.
  ->if 'Invoiced' without saving the record, the record is not getting saved.
  ->'Invoice' event was leaving the invoice form opened, This causes only showing
  the records for the last class in the loop, ignoring all the previous ones.
  So the logic is changed to commit the invoice form without user confirmation
  -> When AppEnv.CompanyPrefs.RepairEquipListLimitToJobEquip is set to true, the
  equipment combo displays the equipments of the customer job. When a new
  entry is made here (not inlist) adds the item into the 'tblequipment' in
  normal case and when AppEnv.CompanyPrefs.RepairEquipListLimitToJobEquip  is true the
  record gets added into 'tblCustomerequip't able too. NOTE : As the invoice
  form is not shown for the user for editing any information, the default
  information gets saved. The jobDueDate - completion date here is no more a
  mandatory field. If this field is blank when 'invoiced', the system date is
  stored as the saledate in the invoice.
  26/06/05  1.00.10  BJ  pop-ups a message if the warranty finish date of the selected customer job
  is less than the system date Bug fixed: Invoice is not getting the correct
  qty

  06/07/05  1.00.11  DMS 1. Passing the customer PO number when creating invoice
  from Repair.
  2. Formatted unit's source code.
  11/07/05  1.00.12  BJ  ->RepairEquipListLimitToJobEquip : the field name is changed to
  RepairEquipListLimit. the possible values in the field are
  A : All Equipments
  J : All equipments of the customer job
  C : All equipment of the customer (all jobs of the customer)
  Note: The jobs are linked to the clients with 'ParentClientID'
  ->New table :tblRepairJobs
  (1) When     RepairEquipListLimit = 'C' then the customer is selected at the
  top and a new grid is displayed in the details to update this new table. A
  combo with all the equipments (jobs)  are displayed in this grid. the
  requirement at the moment is to select one job here but a grid is provided
  incase if multiple need to be seleted. The Equipment list is invisible in
  this case.
  (2) When RepairEquipListLimit <> 'C' then the new grid is invisible and
  the equipment Grid will be displayed.
  ->Following are the READONLY LOOKUP fields in the grid Manufacturer, Model,
  SerialNo, Jobr egistration, Warranty finish date, Waranty period.
  ->Caption of the form is changed based on the preferences.
  ->Double click on the equipmnt combo to open the job.
  ->size of the btnattachment changed to have the same size as in the invoice.
  15/07/05  1.00.15  BJ  ->The invoice form is made visible based na preference when the
  repair is invoiced. NOTE: The message for adding a product which is
  not tracked to the departments elected comes up before the invoice form
  is opened !!!!!!
  21/07/05  1.00.16  BJ  ->not-in-list of the repairjobs combo will open the job form to create
  a new job.
  26/07/05  1.00.17  IJB Added code to check grdRepairJobs and grdRepairs enabled
  before setting focus.
  01/09/05  1.00.18  IJB Added code to exit in
  cboClientJobCloseUp if user hits escape.
  11/10/05  1.00.19  DLS Added contact pick button.
  17/10/05  1.00.20  DSP 1. Added 'Customise' button for grids.
  2. Changed cboStatus to a lookup combo box so status
  options could be stored in a table (tblsimpletypes).
  19/10/05  1.00.21  BJ  Added an option to right click on the notes fields to
  add current user name and system date and time at the
  end of the data available
  bug fixed : Job Grid was showing all the ID fields which should be
  hidden
  job combo shows the customer job number too
  25/10/05  1.00.22  DSP Added time-sheet entries tab.

  27/10/05  1.00.23  DSP Added cboVia combo box to show shipping method.
  04/11/05  1.00.24  DSP Added grid and the required components to the time-sheet
  entries tab.
  09/11/05  1.00.25  DSP Added automatic click of 'Costs' button on the 'Invoice'
  form when the 'Invoice' button is pressed.
  16/11/05  1.00.26  DSP Widened cboClientJob drop-down width from 50 to 65.
  17/11/05  1.00.27  DSP 1. Set the price on the 'Parts' grid from the PO value.
  2. The 'ETA Date' now shown on the 'Parts' grid is
  retrieved from the purchase order. User can drill
  down from this field.
  18/11/05  1.00.28  DSP 1. The 'Convert To Invoice' state is evaluated from the
  associated purchase order.
  2. Back orders are included to calculate the quantity
  on the parts grid.
  03/01/06  1.00.29  DSP The grid customisation is now done via right-clicking
  the grids in place of the 'Customise' button.
  06/01/06  1.00.18 DSP  Changed the parameter passed to AdjustCustomFields from
  grdEquipment to tblDetails.
  09/01/06  1.00.31  AL  Added SearchEngine usage to ProductCombo
  20/01/06  1.00.32 DSP  Changed SQL in LoadTemplate to use RJ.RepairID in place
  of RJ.ID.
  27/01/06  1.00.33 DSP  Added TJobAllocationListGUI to RegisterMe calls. Changed
  RJ.RepairID to R.RepairID in LoadTemplate. Added
  backround bitmap to time-sheet grid.
  09/02/06  1.00.34 DSP  Modified to work with grid customisation being placed
  in BaseInputForm.
  14/02/06  1.00.35 DSP  Altered qryTimeSheets to use persistent fields.
  15/02/06  1.00.36 DSP  Added UpdateSelectedProp to FormCreate.
  09/03/06  1.00.37 DSP  Changed 'clickable' grid title buttons colour to white.
  24/04/06  1.00.38 DSP  Changed 'except' to 'finally' in btnSmartOrderClick.
  09/06/06  1.00.39  AL  Do Not Load PriceEx while initializing when checnging PartID
  in tblrepairpartsAfterOpen
  13/07/06  1.00.40 DSP  Added grdTimesheetsButtonClick event handler.
  14/09/06  1.00.41 DSP  Added 'DISTINCT' to print SQL.
  30/01/07  1.00.42 DSP  Fixed bug in conversion to an invoice where prices
  and product quantities were not being transferred
  correctly.
  05/02/07  1.00.43 DSP  The invoice form is now shown in a modal state during
  conversion.
  06/03/07  1.00.44 DSP  Added functionality to choose the template for printing.
  20/04/07  1.00.45 BJ   Busobj implemented
  ETA date is removed form the PartsGrid as its not in use

}

Interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, StdCtrls, DBCtrls, Dbcgrids, Buttons, DNMSpeedButton, Wwdbdatetimepicker, Mask, ExtCtrls, Wwdblook,
  BaseInputForm, Wwdbedit, DNMPanel, Wwcheckbox, Grids, Wwdbigrd, Wwdbgrid, ComCtrls, Menus, AdvMenus, ActnList, KbmMemTable, Wwdotdot, Wwdbcomb, SelectionDialog, AppEvnts, ImgList, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ProgressDialog, DataState, DMComps, Math, BaseListingForm, IdGlobal, {SearchEngineObj,} BusObjBase, BusObjRepairs, Shader, MessageInterface, DmGUIStylers,
  FrmEquipmentxRef, FrmTimeSheetGUI, BusobjPQA, BusObjAppointments, DNMAction, Wwclearbuttongroup, FrmAttachments, Wwradiogroup, ERPDbLookupCombo, Wwriched, CustomfieldonGrid, JSONObject,
  ad4DBControls, Busobjcustomfields;

Const
  { SX_CalcTotalsMsg = WM_USER + 100; }
  SX_DSChangedMsg = WM_USER + 101;
  cMainButtonWidth = 120;
  cMainButtonHeight = 28;
  cMainButtonGap = 5;
  cMainButtonLeft = 2;
  cMainButtonTopStart = 10;
  //RepairApprovedStatus = 'Approved For Invoicing';
  RepairWaiting4PartsStatus = 'Awaiting Parts';

Type

  TRepairsGUI = Class(TBaseInputGUI)
    DSDetails: TDataSource;
    DSMaster: TDataSource;
    DsOtherFollowUp: TDataSource;
    Dsrepairparts: TDataSource;
    PopDscntMrkup: TAdvPopupMenu;
    MnuDiscountDollar: TMenuItem;
    MnuDiscountPerc: TMenuItem;
    MnuMarkupDollar: TMenuItem;
    MnuMarkupPerc: TMenuItem;
    ActlstRepairs: TActionList;
    ActInvoice: TAction;
    TblMaster: TERPQuery;
    TblDetails: TERPQuery;
    Tblrepairparts: TERPQuery;
    TbOtherFollowUp: TERPQuery;
    TblMasterRepairID: TAutoIncField;
    TblMasterGlobalRef: TWideStringField;
    TblMasterCusID: TIntegerField;
    TblMasterCreationDate: TDateField;
    TblMasterUpdateDate: TDateField;
    TblMasterDone: TWideStringField;
    TblMasterArea: TWideStringField;
    qryTimesheetsarea: TWideStringField;
    TblMasterNotes: TWideMemoField;
    TblMasterFeedbackNotes: TWideMemoField;
    TblMasterEditedFlag: TWideStringField;
    TblMasterClassID: TIntegerField;
    TblMasterEmployeeID: TIntegerField;
    TblMasterCustomerDetails: TWideStringField;
    TblMasterPhone: TWideStringField;
    TblMasterAltPhone: TWideStringField;
    TblMasterFax: TWideStringField;
    TblMasterJobDueDate: TDateTimeField;
    TblMasterConverted: TWideStringField;
    TblMasterStatus: TWideStringField;
    TblMasterBillToCustomerDetails: TWideStringField;
    TblMasterBillCusID: TIntegerField;
    TblMasterUseBillCust: TWideStringField;
    TblMasterBillPhone: TWideStringField;
    TblMasterBillAltPhone: TWideStringField;
    TblMasterBillFax: TWideStringField;
    TblDetailsGlobalRef: TWideStringField;
    TblDetailsid: TAutoIncField;
    TblDetailsRepairID: TIntegerField;
    TblDetailsEditedFlag: TWideStringField;
    TblDetailsDescription: TWideStringField;
    TblDetailsCreationDate: TDateField;
    TblDetailsUpdateDate: TDateField;
    TblrepairpartsGlobalRef: TWideStringField;
    TblrepairpartsRepairPartsID: TAutoIncField;
    TblrepairpartsRepairID: TIntegerField;
    TblrepairpartsPartsID: TIntegerField;
    TblrepairpartsQty: TFloatField;
    TblrepairpartsDescription: TWideStringField;
    TblrepairpartsPriceEx: TFloatField;
    TblrepairpartsPriceInc: TFloatField;
    TblrepairpartsTaxCode: TWideStringField;
    TblrepairpartsTaxRate: TFloatField;
    TblrepairpartsDiscount: TFloatField;
    TblrepairpartsMarkup: TFloatField;
    TblrepairpartsDiscountPercent: TFloatField;
    TblrepairpartsMarkupPercent: TFloatField;
    TblrepairpartsLineTotalEx: TFloatField;
    TblrepairpartsEditedFlag: TWideStringField;
    TbOtherFollowUpGlobalRef: TWideStringField;
    TbOtherFollowUpFollowUpID: TAutoIncField;
    TbOtherFollowUpOtherContactID: TIntegerField;
    TbOtherFollowUpRepairID: TIntegerField;
    TbOtherFollowUpEmployeeID: TIntegerField;
    TbOtherFollowUpClientID: TIntegerField;
    TbOtherFollowUpFollowUpDate: TDateTimeField;
    TbOtherFollowUpDone: TWideStringField;
    TbOtherFollowUpEditedFlag: TWideStringField;
    TbOtherFollowUpAppearDays: TIntegerField;
    TbOtherFollowUpCreationDate: TDateTimeField;
    TbOtherFollowUpUpdateDate: TDateField;
    TbOtherFollowUpIsSupplier: TWideStringField;
    TbOtherFollowUpIsOtherContact: TWideStringField;
    TbOtherFollowUpIsCustomer: TWideStringField;
    TblrepairpartscalcTotalInc: TFloatField;
    TblrepairpartscalcTotalIncBase: TFloatField;
    TblrepairpartscalcTax: TFloatField;
    TbOtherFollowUpEmployeeName: TWideStringField;
    ImgCredit: TImageList;
    ActServiceLog: TAction;
    Pnlbody: TDNMPanel;
    TABCTL20: TPageControl;
    TabFollowupnProducts: TTabSheet;
    TabEquipment: TTabSheet;
    Custom_Fields: TTabSheet;
    TabTimesheetEntries: TTabSheet;
    TabRa: TTabSheet;
    TabNotes: TTabSheet;
    TabInvoices: TTabSheet;
    Tabappointment: TTabSheet;
    TabExtrainfo: TTabSheet;
    TabSmartOrders: TTabSheet;
    TabBills: TTabSheet;
    TabSalesOrders: TTabSheet;
    TabAssets: TTabSheet;
    TabDocuments: TTabSheet;
    TabFaultsnfollowups: TTabSheet;
    TabMain: TTabSheet;
    PnlEquipments: TDNMPanel;
    TblMasterSOGlobalRef: TWideStringField;
    TblDetailsCode: TWideStringField;
    QryEmployees: TERPQuery;
    TaxCodeDetails: TERPQuery;
    CboClassQry: TERPQuery;
    QryParts: TERPQuery;
    QryfixedAssetParts: TERPQuery;
    QryClientLookup: TERPQuery;
    QryClientLookupCompany: TWideStringField;
    QryClientLookupStopCreditImage: TIntegerField;
    QryClientLookupClientID: TAutoIncField;
    QryClientLookupStreet: TWideStringField;
    QryClientLookupStreet2: TWideStringField;
    QryClientLookupSuburb: TWideStringField;
    QryClientLookupState: TWideStringField;
    QryClientLookupPostcode: TWideStringField;
    QryClientLookupPhone: TWideStringField;
    QryClientLookupAltPhone: TWideStringField;
    QryClientLookupFaxNumber: TWideStringField;
    QryClientLookupBillStreet: TWideStringField;
    QryClientLookupBillStreet2: TWideStringField;
    QryClientLookupBillSuburb: TWideStringField;
    QryClientLookupBillState: TWideStringField;
    QryClientLookupBillCountry: TWideStringField;
    QryClientLookupBillPostcode: TWideStringField;
    QryfixedAssetPartsPARTSID: TIntegerField;
    QryfixedAssetPartsPARTNAME: TWideStringField;
    TblMasterCustomerPONumber: TWideStringField;
    QryfixedAssetPartsSerial: TWideStringField;
    TblrepairpartsClassID: TIntegerField;
    TblrepairpartsClassName: TWideStringField;
    QryClass: TERPQuery;
    TblrepairpartsPartType: TWideStringField;
    ActRepeat: TAction;
    DMTextTargetRepairs: TDMTextTarget;
    TblMastermsTimeStamp: TDateTimeField;
    QryClientLookupjobnumber: TIntegerField;
    QryClientLookupJobname: TWideStringField;
    TblrepairpartsConvertToInvoice: TWideStringField;
    QryClientLookupWarrantyFinishDate: TDateTimeField;
    QryClientLookupIsJob: TWideStringField;
    QryClientLookupParentClientID: TIntegerField;
    WwIButton1: TwwIButton;
    WwIButton2: TwwIButton;
    ActCompany: TAction;
    TblDetailsCustomField1: TWideStringCustField;
    TblDetailsCustomField2: TWideStringCustField;
    TblDetailsCustomField3: TWideStringCustField;
    TblDetailsCustomField4: TWideStringCustField;
    TblDetailsCustomField5: TWideStringCustField;
    TblDetailsCustomField6: TWideStringCustField;
    TblDetailsCustomField7: TWideStringCustField;
    TblDetailsCustomField8: TWideStringCustField;
    TblDetailsCustomField9: TWideStringCustField;
    TblDetailsCustomField10: TWideStringCustField;
    QryClientLookupForcePOOnCustomer: TWideStringField;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    QryCustomFields: TERPQuery;
    pnlCustFieldsTab: TDNMPanel;
    DsCustomerSrc: TDataSource;
    QryStatus: TERPQuery;
    QryStatusName: TWideStringField;
    PopInsert: TAdvPopupMenu;
    InsertDateandTime1: TMenuItem;
    QryClientInvoicetoLookup: TERPQuery;
    QryClientInvoicetoLookupStopCreditImage: TIntegerField;
    TblMasterShipping: TWideStringField;
    QryVia: TERPQuery;
    QryViaShippingMethodID: TIntegerField;
    QryViaShippingMethod: TWideStringField;
    QryTimeSheets: TERPQuery;
    DsTimeSheets: TDataSource;
    QryEmployee: TERPQuery;
    QryServices: TERPQuery;
    QryRateType: TERPQuery;
    QryGridClass: TERPQuery;
    QryPOLines: TERPQuery;
    TblrepairpartsETADate: TDateField;
    TblrepairpartsPurchaseOrderID: TIntegerField;
    QryPartsManuf: TWideStringField;
    QryPartsType: TWideStringField;
    QryPartsDept: TWideStringField;
    QryPartsPARTNAME: TWideStringField;
    QryPartsPARTSDESCRIPTION: TWideStringField;
    QryPartsPARTSID: TIntegerField;
    QryPartsPARTTYPE: TWideStringField;
    QryPartsPRODUCTGROUP: TWideStringField;
    QryPartsINCOMEACCNT: TWideStringField;
    QryPartsASSETACCNT: TWideStringField;
    QryPartsCOGSACCNT: TWideStringField;
    QryPartsBARCODE: TWideStringField;
    QryPartsPRODUCTCODE: TWideStringField;
    QryPartsTAXCODE: TWideStringField;
    QryPartsSpecialDiscount: TWideStringField;
    QryPartsSNTracking: TWideStringField;
    QryPartsBuyQTY1: TIntegerField;
    QryPartsBuyQTY2: TIntegerField;
    QryPartsBuyQTY3: TIntegerField;
    QryPartsCOST1: TFloatField;
    QryPartsCOST2: TFloatField;
    QryPartsCOST3: TFloatField;
    QryPartsSellQTY1: TIntegerField;
    QryPartsSellQTY2: TIntegerField;
    QryPartsSellQTY3: TIntegerField;
    QryPartsPRICE1: TFloatField;
    QryPartsPRICE2: TFloatField;
    QryPartsPRICE3: TFloatField;
    QryPartsWHOLESALEPRICE: TFloatField;
    QryPartsActive: TWideStringField;
    QryPartsEditedFlag: TWideStringField;
    QryPartsAvgCost: TFloatField;
    DSTimesheetEntry: TDataSource;
    QryTimesheetEntry: TERPQuery;
    QryPayRates: TERPQuery;
    TblrepairpartsMemoLine: TWideMemoField;
    TblRepairPartsPartName: TWideStringField;
    TblMasterQuoteGlobalRef: TWideStringField;
    QryClientLookupTaxID: TIntegerField;
    TblMasterCompletionTime: TWideStringField;
    QryClientLookupStopCredit: TWideStringField;
    TblDetailsWarantyPeriodTaken: TLargeintField;
    TblDetailsWarantyPeriodLeft: TLargeintField;
    TblDetailsSaleId: TLargeintField;
    TblDetailsCustomerEquipmentID: TIntegerField;
    DNMPanel7: TDNMPanel;
    EdtETADate: TwwDBEdit;
    CboClassRepairParts: TwwDBLookupCombo;
    CboTax: TwwDBLookupCombo;
    CboProductR: TERPDbLookupCombo;
    GrdParts: TwwDBGrid;
    BtnDeleteParts: TwwIButton;
    Label20: TLabel;
    Pnltimesheetentries: TDNMPanel;
    QryTimeSheetsID: TAutoIncField;
    QryTimeSheetstimesheetDate: TDateTimeField;
    QryTimeSheetsHours: TFloatField;
    QryTimeSheetsTotal: TFloatField;
    QryTimeSheetsJob: TWideStringField;
    QryTimeSheetsJobID: TIntegerField;
    QryTimeSheetsEmployeeName: TWideStringField;
    QryTimeSheetsEmployeeID: TIntegerField;
    QryTimeSheetsLabourCost: TFloatField;
    QryTimeSheetsClassName: TWideStringField;
    QryTimeSheetsClassID: TIntegerField;
    QryTimeSheetsGlobalRef: TWideStringField;
    QryTimeSheetsServiceID: TIntegerField;
    QryTimeSheetsServiceName: TWideStringField;
    QryTimeSheetsServiceDate: TDateField;
    QryTimeSheetsQty: TFloatField;
    QryTimeSheetsChargeRate: TFloatField;
    QryTimeSheetsPartID: TIntegerField;
    QryTimeSheetsPartName: TWideStringField;
    QryTimeSheetsPayRateTypeName: TWideStringField;
    QryTimeSheetsPayRateTypeID: TIntegerField;
    QryTimeSheetsHourlyRate: TFloatField;
    QryTimeSheetsSuperInc: TWideStringField;
    QryTimeSheetsSuperAmount: TFloatField;
    QryTimeSheetsNotes: TWideMemoField;
    qryTimesheetsInvoiceNotes: TWideMemoField;
    QryTimeSheetsActive: TWideStringField;
    QryTimeSheetsUseTimeCost: TWideStringField;
    QryTimeSheetsSalesID: TIntegerField;
    QryTimeSheetsPartsDescription: TWideStringField;
    QryTimeSheetsTax: TFloatField;
    QryTimeSheetsSaleLineID: TIntegerField;
    QryTimeSheetsAllowEdit: TWideStringField;
    QryTimesheetsCustomerEquipmentId: TIntegerField;
    QryTimesheetsEquipment: TWideStringField;
    QryClientLookupterms: TWideStringField;
    QryClientLookuptermsid: TIntegerField;
    QryClientLookupmobile: TWideStringField;
    TblMasterTermsId: TLargeintField;
    TblMasterTerms: TWideStringField;
    TblMasterMobile: TWideStringField;
    TblMasterBillMobile: TWideStringField;
    CboTermsQry: TERPQuery;
    CboTermsQryTermsID: TIntegerField;
    CboTermsQryTerms: TWideStringField;
    CboTermsQryTermsAmount: TIntegerField;
    CboTermsQryEOM: TWideStringField;
    CboTermsQryEOMPlus: TWideStringField;
    CboTermsQryActive: TWideStringField;
    TblMasterContactID: TLargeintField;
    QryClientInvoicetoLookupClientID: TIntegerField;
    QryClientInvoicetoLookupCompany: TWideStringField;
    QryClientInvoicetoLookupStreet: TWideStringField;
    QryClientInvoicetoLookupStreet2: TWideStringField;
    QryClientInvoicetoLookupSuburb: TWideStringField;
    QryClientInvoicetoLookupState: TWideStringField;
    QryClientInvoicetoLookupPostcode: TWideStringField;
    QryClientInvoicetoLookupPhone: TWideStringField;
    QryClientInvoicetoLookupAltPhone: TWideStringField;
    QryClientInvoicetoLookupFaxNumber: TWideStringField;
    QryClientInvoicetoLookupmobile: TWideStringField;
    QryClientInvoicetoLookupBillStreet: TWideStringField;
    QryClientInvoicetoLookupBillStreet2: TWideStringField;
    QryClientInvoicetoLookupBillSuburb: TWideStringField;
    QryClientInvoicetoLookupBillState: TWideStringField;
    QryClientInvoicetoLookupBillCountry: TWideStringField;
    QryClientInvoicetoLookupBillPostcode: TWideStringField;
    QryClientInvoicetoLookupStopCredit: TWideStringField;
    QryClientInvoicetoLookupjobnumber: TIntegerField;
    QryClientInvoicetoLookupForcePOOnCustomer: TWideStringField;
    QryClientInvoicetoLookupJobname: TWideStringField;
    QryClientInvoicetoLookupWarrantyFinishDate: TDateTimeField;
    QryClientInvoicetoLookupIsJob: TWideStringField;
    QryClientInvoicetoLookupParentClientID: TIntegerField;
    QryClientInvoicetoLookupTaxID: TIntegerField;
    QryClientInvoicetoLookuptitle: TWideStringField;
    QryClientLookuptitle: TWideStringField;
    QryClientInvoicetoLookupStreet3: TWideStringField;
    QryClientInvoicetoLookupBillStreet3: TWideStringField;
    QryClientInvoicetoLookupfirstname: TWideStringField;
    QryClientInvoicetoLookuplastname: TWideStringField;
    QryClientLookupStreet3: TWideStringField;
    QryClientLookupBillStreet3: TWideStringField;
    QryClientLookupfirstname: TWideStringField;
    QryClientLookuplastname: TWideStringField;
    DNMPanel4: TDNMPanel;
    BtnAttachments: TDNMSpeedButton;
    QryTimesheetsTotalServicecharge: TFloatField;
    TblDetailsOnSite: TWideStringField;
    TblrepairpartsCustomerEquipmentID: TIntegerField;
    TblrepairpartsEquipment: TWideStringField;
    CboEquipname: TwwDBLookupCombo;
    QryPartsEquip: TERPQuery;
    TblrepairpartsUnitofMeasure: TWideStringField;
    TblrepairpartsUnitofMeasureID: TLargeintField;
    TblrepairpartsUnitofMeasureMultiplier: TFloatField;
    TblrepairpartsUOMQty: TFloatField;
    TblrepairpartsDeleted: TWideStringField;
    TblrepairpartsPartIssuedOn: TDateTimeField;
    QryUnitOfMeasure: TERPQuery;
    QryUnitOfMeasureUnitID: TIntegerField;
    QryUnitOfMeasureUnitName: TWideStringField;
    QryUnitOfMeasureUnitDescription: TWideStringField;
    QryUnitOfMeasureMultiplier: TFloatField;
    QryUnitOfMeasureBaseUnitName: TWideStringField;
    CboUnitOfMeasure: TwwDBLookupCombo;
    TblrepairpartsLinecost: TFloatField;
    TblrepairpartsLinecostInc: TFloatField;
    TblMasterQuotedAmount: TFloatField;
    TblMasterQuotedAmountinc: TFloatField;
    TblDetailsUOM: TWideStringField;
    TblDetailsUOMID: TLargeintField;
    TblDetailsUOMMultiplier: TFloatField;
    TblDetailsUOMQty: TFloatField;
    TblDetailsQuantity: TFloatField;
    TblrepairpartsParentProductID: TLargeintField;
    TblrepairpartsParentLineRef: TWideStringField;
    TblrepairpartsInvoiceLineRef: TWideStringField;
    TblrepairpartsRelatedProductQty: TFloatField;
    TblrepairpartsSerialNos: TWideMemoField;
    TblrepairpartsIsRelatedProduct: TWideStringField;
    TblDetailsInvoiceID: TLargeintField;
    TblMasterAllocatedEmployeeID: TIntegerField;
    TblMasterHoldRepair: TWideStringField;
    TblMasterCUSTFLD1: TWideStringField;
    TblMasterCUSTFLD2: TWideStringField;
    TblMasterCUSTFLD3: TWideStringField;
    TblMasterCUSTFLD4: TWideStringField;
    TblMasterCUSTFLD5: TWideStringField;
    TblMasterCUSTFLD6: TWideStringField;
    TblMasterCUSTFLD7: TWideStringField;
    TblMasterCUSTFLD8: TWideStringField;
    TblMasterCUSTFLD9: TWideStringField;
    TblMasterCUSTFLD10: TWideStringField;
    TblMasterCUSTFLD11: TWideStringField;
    TblMasterCUSTFLD12: TWideStringField;
    TblMasterCUSTFLD13: TWideStringField;
    TblMasterCUSTFLD14: TWideStringField;
    TblMasterCUSTFLD15: TWideStringField;
    TblMasterCUSTDATE1: TDateTimeField;
    TblMasterCUSTDATE2: TDateTimeField;
    TblMasterCUSTDATE3: TDateTimeField;
    QryTimesheetsAppointmentID: TIntegerField;
    MnuProductStatus: TMenuItem;
    QryInvoices: TERPQuery;
    QryAppointments: TERPQuery;
    DsInvoices: TDataSource;
    DsAppointments: TDataSource;
    DNMPanel5: TDNMPanel;
    DNMPanel6: TDNMPanel;
    GrdInvoices: TwwDBGrid;
    GrdAppointments: TwwDBGrid;
    QryAppointmentsAppDate: TDateField;
    QryAppointmentsActual_AppDate: TDateField;
    QryAppointmentsServiceDesc: TWideStringField;
    QryAppointmentsTotalInc: TFloatField;
    QryAppointmentsStatus: TWideStringField;
    QryInvoicesSaleID: TIntegerField;
    QryInvoicesCustomerName: TWideStringField;
    QryInvoicesSaleDate: TDateField;
    QryInvoicesTotalAmountInc: TFloatField;
    QryInvoicesEmployeeName: TWideStringField;
    QryAppointmentsAppointID: TIntegerField;
    QryAppointmentsCustomerDetails: TWideStringField;
    QryInvoicesClass: TWideStringField;
    QryInvoicesTerms: TWideStringField;
    QryInvoicesBalance: TFloatField;
    QryInvoicesPayment: TFloatField;
    QryAppointmentsNotes: TWideMemoField;
    DNMPanel8: TDNMPanel;
    Qryrepairdetails: TERPQuery;
    Dsrepairdetails: TDataSource;
    QryrepairdetailsRepairDetailId: TLargeintField;
    QryrepairdetailsGlobalref: TWideStringField;
    QryrepairdetailsRepairID: TLargeintField;
    QryrepairdetailsGSFSReceiptNo: TWideStringField;
    QryrepairdetailsFaultConditionID: TLargeintField;
    QryrepairdetailsFaultConditionDesc: TWideStringField;
    QryrepairdetailsFaultSymptomID: TLargeintField;
    QryrepairdetailsFaultSymptomDesc: TWideStringField;
    QryrepairdetailsFaultDefectID: TLargeintField;
    QryrepairdetailsFaultDefectDesc: TWideStringField;
    QryrepairdetailsFaultRepairID: TLargeintField;
    QryrepairdetailsFaultRepairDesc: TWideStringField;
    QryrepairdetailsFaultSectionId: TLargeintField;
    QryrepairdetailsFaultSectionDesc: TWideStringField;
    QryrepairdetailsRepaircode: TWideStringField;
    QryrepairdetailsMaterialcost: TFloatField;
    QryrepairdetailsFreightcost: TFloatField;
    QryrepairdetailsOtheramount: TFloatField;
    QryrepairdetailsServicetype: TWideStringField;
    QryrepairdetailsAuthorisationnumber: TWideStringField;
    Qryrepairdetailsmstimestamp: TDateTimeField;
    QryRepairFaultsCondition: TERPQuery;
    QryRepairFaultsConditionRepairFaultID: TLargeintField;
    QryRepairFaultsConditionGlobalref: TWideStringField;
    QryRepairFaultsConditioncode: TWideStringField;
    QryRepairFaultsConditionCategory: TWideStringField;
    QryRepairFaultsConditionDescription: TWideStringField;
    QryRepairFaultsConditionActive: TWideStringField;
    QryRepairFaultsConditionmsTimestamp: TDateTimeField;
    QryRepairFaultsSymptom: TERPQuery;
    QryRepairFaultsDefect: TERPQuery;
    QryRepairFaultsRepair: TERPQuery;
    QryRepairFaultsSection: TERPQuery;
    QryRepairFaultsSymptomRepairFaultID: TLargeintField;
    QryRepairFaultsSymptomGlobalref: TWideStringField;
    QryRepairFaultsSymptomcode: TWideStringField;
    QryRepairFaultsSymptomCategory: TWideStringField;
    QryRepairFaultsSymptomDescription: TWideStringField;
    QryRepairFaultsSymptomActive: TWideStringField;
    QryRepairFaultsSymptommsTimestamp: TDateTimeField;
    QryRepairFaultsDefectRepairFaultID: TLargeintField;
    QryRepairFaultsDefectGlobalref: TWideStringField;
    QryRepairFaultsDefectcode: TWideStringField;
    QryRepairFaultsDefectCategory: TWideStringField;
    QryRepairFaultsDefectDescription: TWideStringField;
    QryRepairFaultsDefectActive: TWideStringField;
    QryRepairFaultsDefectmsTimestamp: TDateTimeField;
    QryRepairFaultsRepairRepairFaultID: TLargeintField;
    QryRepairFaultsRepairGlobalref: TWideStringField;
    QryRepairFaultsRepaircode: TWideStringField;
    QryRepairFaultsRepairCategory: TWideStringField;
    QryRepairFaultsRepairDescription: TWideStringField;
    QryRepairFaultsRepairActive: TWideStringField;
    QryRepairFaultsRepairmsTimestamp: TDateTimeField;
    QryRepairFaultsSectionRepairFaultID: TLargeintField;
    QryRepairFaultsSectionGlobalref: TWideStringField;
    QryRepairFaultsSectioncode: TWideStringField;
    QryRepairFaultsSectionCategory: TWideStringField;
    QryRepairFaultsSectionDescription: TWideStringField;
    QryRepairFaultsSectionActive: TWideStringField;
    QryRepairFaultsSectionmsTimestamp: TDateTimeField;
    QryrepairdetailsFaultConditionCode: TWideStringField;
    QryrepairdetailsFaultSymptomcode: TWideStringField;
    QryrepairdetailsFaultDefectCode: TWideStringField;
    QryrepairdetailsFaultRepairCode: TWideStringField;
    QryrepairdetailsFaultSectionCode: TWideStringField;
    QryRepairFaultsConditionDetails: TWideStringField;
    QryRepairFaultsSymptomDetails: TWideStringField;
    QryRepairFaultsDefectDetails: TWideStringField;
    QryRepairFaultsRepairDetails: TWideStringField;
    QryRepairFaultsSectionDetails: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    TblMasterDetailsExported: TWideStringField;
    LblDetailsExportedStatus: TLabel;
    Bevel16: TBevel;
    QryrepairdetailsAscClaimRemarks: TWideMemoField;
    MemAscClaimRemarks: TDBMemo;
    Label64: TLabel;
    Bevel17: TBevel;
    QryrepairdetailsManInvNo: TLargeintField;
    QryrepairdetailsManInvDate: TDateTimeField;
    QryrepairdetailsModel: TWideStringField;
    QryrepairdetailsSerialNo: TWideStringField;
    QryManufacture: TERPQuery;
    QryManufactureName: TWideStringField;
    QryManufactureID: TIntegerField;
    QryrepairdetailsManufactureID: TIntegerField;
    QryrepairdetailsManufacture: TWideStringField;
    QryrepairdetailsRetailerID: TIntegerField;
    QryrepairdetailsRetailerName: TWideStringField;
    Bevel10: TBevel;
    Label65: TLabel;
    EdtManInv: TDBEdit;
    CboWarrantydate: TwwDBDateTimePicker;
    Label67: TLabel;
    Edtmodel: TDBEdit;
    Label68: TLabel;
    Label69: TLabel;
    EdtDerial: TDBEdit;
    Label71: TLabel;
    CboRetailer: TwwDBLookupCombo;
    LblSuburb: TLabel;
    DBMemo2: TDBMemo;
    Bevel11: TBevel;
    GrdServiceType: TDBRadioGroup;
    EdtReceiptNo: TDBEdit;
    Label62: TLabel;
    Edtauthno: TDBEdit;
    Bevel12: TBevel;
    Label59: TLabel;
    Edtmaterialcost: TDBEdit;
    Label60: TLabel;
    EdtFrightCost: TDBEdit;
    Label61: TLabel;
    EdtOtheramt: TDBEdit;
    Bevel14: TBevel;
    QryRetailer: TERPQuery;
    QryRetailerClientID: TIntegerField;
    QryRetailerCompany: TWideStringField;
    QryRetailerAddress: TWideStringField;
    DsRetailer: TDataSource;
    DBText1: TDBText;
    QryrepairdetailsReceiptNumberCaption: TWideStringField;
    Bevel13: TBevel;
    Label23: TLabel;
    CboManufacture: TwwDBLookupCombo;
    Label43: TLabel;
    CboFaultConditionDesc: TwwDBLookupCombo;
    Label47: TLabel;
    CboFaultSymptomDesc: TwwDBLookupCombo;
    Label49: TLabel;
    CboFaultDefectDesc: TwwDBLookupCombo;
    Label50: TLabel;
    CboFaultRepairDesc: TwwDBLookupCombo;
    Label51: TLabel;
    CboFaultSectionDesc: TwwDBLookupCombo;
    Bevel1: TBevel;
    Label57: TLabel;
    DBEdit8: TDBEdit;
    DsSmartOrders: TDataSource;
    QrySmartOrders: TERPQuery;
    DNMPanel9: TDNMPanel;
    GrdSmartOrder: TwwDBGrid;
    QrySmartOrderHeader: TERPQuery;
    DsSmartOrderHeader: TDataSource;
    QrySmartOrderHeaderSmartOrderID: TIntegerField;
    QrySmartOrderHeaderCreationDate: TDateField;
    QrySmartOrderHeaderSmartOrderDesc: TWideStringField;
    GrdSO: TwwDBGrid;
    QrySmartOrdersPARTSNAME: TWideStringField;
    QrySmartOrdersClassName: TWideStringField;
    QrySmartOrdersQty: TFloatField;
    QrySmartOrdersUnitofMeasure: TWideStringField;
    QrySmartOrdersUnitofMeasurePOLines: TWideStringField;
    QrySmartOrdersPurchaseOrderID: TIntegerField;
    QrySmartOrdersBackOrder: TFloatField;
    QrySmartOrdersQtySold: TFloatField;
    QrySmartOrdersShipped: TFloatField;
    QryapptTrainer: TERPQuery;
    QryAppointmentsTrainerID: TIntegerField;
    QryAppointmentsRep: TWideStringField;
    DNMSpeedButton2: TDNMSpeedButton;
    QryAppointmentsActual_Endtime: TDateTimeField;
    QryrepairdetailsRetailerAddress: TWideStringField;
    TblMasterRepairDocNo: TWideStringField;
    DsBills: TDataSource;
    Qrybills: TERPQuery;
    QrybillsAccountName: TWideStringField;
    QrybillsEquipmentName: TWideStringField;
    QrybillsTotalLineAmountInc: TFloatField;
    QrybillsPurchaseOrderID: TIntegerField;
    GrdBills: TwwDBGrid;
    QrybillsLineTaxCode: TWideStringField;
    QrybillsLineTax: TFloatField;
    QrybillsTotalLineAmount: TFloatField;
    QrybillsSupplierName: TWideStringField;
    QrybillsPurchaseOrderNumber: TWideStringField;
    QrySmartOrdersTotalLineAmount: TFloatField;
    QrySmartOrdersBOCost: TFloatField;
    QrySmartOrdersBackOrdercost: TFloatField;
    QrybillsLineTaxRate: TFloatField;
    TblrepairpartsMatrixDesc: TWideMemoField;
    TblrepairpartsMatrixRef: TWideMemoField;
    TblrepairpartsMatrixPrice: TFloatField;
    TblMasterCustomerName: TWideStringField;
    TblMasterBillCustomerName: TWideStringField;
    QrySalesOrders: TERPQuery;
    IntegerField1: TIntegerField;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    DateField1: TDateField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    DsSalesOrders: TDataSource;
    GrdSalesOrders: TwwDBGrid;
    QryRAs: TERPQuery;
    DsRAs: TDataSource;
    QryRAHeaders: TERPQuery;
    DsRAHeaders: TDataSource;
    QryRAHeadersPurchaseOrderID: TIntegerField;
    QryRAHeadersOrderDate: TDateTimeField;
    QryRAHeadersSupplierName: TWideStringField;
    QryRAsPurchaseOrderID: TIntegerField;
    QryRAsProductName: TWideStringField;
    QryRAsClass: TWideStringField;
    QryRAsUnitofMeasureShipped: TFloatField;
    QryRAsUOM: TWideStringField;
    QryRAsUnitofMeasureQtySold: TFloatField;
    DNMPanel10: TDNMPanel;
    GrdRAs: TwwDBGrid;
    GrdRAHeader: TwwDBGrid;
    EdtMemoLine: TwwDBEdit;
    PopOptions: TAdvPopupMenu;
    MnuAuditTrial: TMenuItem;
    QryPartsEquipID: TIntegerField;
    QryPartsEquipEquipmentID: TIntegerField;
    QryPartsEquipEquipName: TWideStringField;
    QryPartsEquipDescription: TWideStringField;
    QryPartsEquipManufacture: TWideStringField;
    QryPartsEquipmodel: TWideStringField;
    QryPartsEquipSerialno: TWideStringField;
    QryPartsEquipRegistration: TWideStringField;
    QryPartsEquipWarantyPeriod: TFloatField;
    QryPartsEquipWarantyFinishDate: TDateTimeField;
    QryPartsEquipWarantyStartDate: TDateTimeField;
    QryPartsEquipProductId: TLargeintField;
    QryPartsEquipActive: TWideStringField;
    QryPartsEquipNotes: TWideMemoField;
    TblMasterShipToID: TIntegerField;
    CustomFields1: TMenuItem;
    TblrepairpartsCustfld1: TWideStringField;
    TblrepairpartsCustFld2: TWideStringField;
    TblrepairpartsCustFld3: TWideStringField;
    TblrepairpartsCustFld4: TWideStringField;
    TblrepairpartsCustFld5: TWideStringField;
    TblrepairpartsCustFld6: TWideStringField;
    TblrepairpartsCustFld7: TWideStringField;
    TblrepairpartsCustFld8: TWideStringField;
    TblrepairpartsCustFld9: TWideStringField;
    TblrepairpartsCustFld10: TWideStringField;
    QryInvoicesQuoteStatus: TWideStringField;
    QrySalesOrdersQuoteStatus: TWideStringField;
    QrySmartOrdersSmartOrderID: TIntegerField;
    QrybillsInvoiceNumber: TWideStringField;
    QryTimesheetsRepairID: TIntegerField;
    QryRepairLookup: TERPQuery;
    QryRepairLookupRepairDocNo: TWideStringField;
    QryRepairLookupCustomerName: TWideStringField;
    QryRepairLookupRepairID: TIntegerField;
    QryTimesheetsRepairDocNo: TStringField;
    TbOtherFollowUpNotes: TWideMemoField;
    TblrepairpartsFormulaQtyValue1: TFloatField;
    TblrepairpartsFormulaQtyValue2: TFloatField;
    TblrepairpartsFormulaQtyValue3: TFloatField;
    TblrepairpartsFormulaQtyValue4: TFloatField;
    TblrepairpartsFormulaQtyValue5: TFloatField;
    TblrepairpartsFormulaQtyValue: TFloatField;
    TblMasterCancelled: TWideStringField;
    TblMasterBilltotalPrice: TFloatField;
    Label58: TLabel;
    EdtBillPrice: TwwDBEdit;
    LblTmrMsg: TLabel;
    DsAssetXRef: TDataSource;
    QryAssetXRef: TERPQuery;
    QryAssetXRefGlobalRef: TWideStringField;
    QryAssetXRefRepairAssetXRefId: TIntegerField;
    QryAssetXRefAssetId: TIntegerField;
    QryAssetXRefRepairId: TIntegerField;
    QryAssetXRefmsUpdateSiteCode: TWideStringField;
    grdAssets: TwwDBGrid;
    QryAssetLookup: TERPQuery;
    CboAssetName: TwwDBLookupCombo;
    QryAssetXRefAssetName: TStringField;
    QryAssetXRefAssetCode: TStringField;
    CboAssetCode: TwwDBLookupCombo;
    QryAssetXRefPurchaseDate: TDateField;
    QryAssetXRefPurchaseCost: TFloatField;
    QryAssetXRefBrandName: TStringField;
    QryAssetXRefManufacture: TStringField;
    QryAssetXRefModel: TStringField;
    QryAssetXRefSerial: TStringField;
    QryAssetXRefNotes: TStringField;
    BtnDeleteAsset: TwwIButton;
    QryCustomers: TERPQuery;
    QryCustomersClientID: TIntegerField;
    QryCustomersClientTypeID: TIntegerField;
    QryCustomersCUSTFLD1: TWideStringField;
    QryCustomersCUSTFLD2: TWideStringField;
    QryCustomersCUSTFLD3: TWideStringField;
    QryCustomersCUSTFLD4: TWideStringField;
    QryCustomersCUSTFLD5: TWideStringField;
    QryCustomersCUSTFLD6: TWideStringField;
    QryCustomersCUSTFLD7: TWideStringField;
    QryCustomersCUSTFLD8: TWideStringField;
    QryCustomersCUSTFLD9: TWideStringField;
    QryCustomersCUSTFLD10: TWideStringField;
    QryCustomersCUSTFLD11: TWideStringField;
    QryCustomersCUSTFLD12: TWideStringField;
    QryCustomersCUSTFLD13: TWideStringField;
    QryCustomersCUSTFLD14: TWideStringField;
    QryCustomersCUSTFLD15: TWideStringField;
    QryCustomersCUSTDATE1: TDateField;
    QryCustomersCUSTDATE2: TDateField;
    QryCustomersCUSTDATE3: TDateField;
    QryCustomersCompany: TWideStringField;
    QryCustomersStreet: TWideStringField;
    QryCustomersStreet2: TWideStringField;
    QryCustomersStreet3: TWideStringField;
    QryCustomersSuburb: TWideStringField;
    QryCustomersState: TWideStringField;
    QryCustomersPostcode: TWideStringField;
    QryCustomersPhone: TWideStringField;
    QryCustomersFaxNumber: TWideStringField;
    QryCustomersAltPhone: TWideStringField;
    QryCustomersIsJob: TWideStringField;
    QryCustomersForcePOOnCustomer: TWideStringField;
    QryCustomersWarrantyFinishDate: TDateTimeField;
    QryCustomersForcePOOnRepair: TWideStringField;
    QryCustomersEMail: TWideStringField;
    QryCustomersBillStreet: TWideStringField;
    QryCustomersBillStreet2: TWideStringField;
    QryCustomersBillSuburb: TWideStringField;
    QryCustomersBillState: TWideStringField;
    QryCustomersBillCountry: TWideStringField;
    QryCustomersBillPostcode: TWideStringField;
    QrySmartOrdersPOInvoiceNumber: TWideStringField;
    TblDetailsRepairfault: TWideStringField;
    QryrepairFaults: TERPQuery;
    QryrepairFaultsName: TWideStringField;
    QryrepairFaultsDescription: TWideStringField;
    QryrepairFaultsTypecode: TWideStringField;
    QryDocuments: TERPQuery;
    DSDocuments: TDataSource;
    GrdDocs: TwwDBGrid;
    GrdDocsIButton: TwwIButton;
    LetterBtn: TDNMSpeedButton;
    EmailBtn: TDNMSpeedButton;
    QryTimesheetssignature: TBlobField;
    QryTimesheetsSignatureTime: TDateTimeField;
    QryTimesheetsContactName: TWideStringField;
    QryTimesheetsSignatureMemo: TStringField;
    qryTimesheetsOverheadRate: TFloatField;
    qryTimesheetsTotalAdjusted: TFloatField;
    DsrepairsFaults: TDataSource;
    TblrepairsFaults: TERPQuery;
    TblrepairsFaultsRepairFault: TWideStringField;
    TblrepairsFaultsDone: TWideStringField;
    TblrepairsFaultsEquipment: TWideStringField;
    TblrepairsFaultsGlobalRef: TWideStringField;
    TblrepairsFaultsRepairsFaultId: TIntegerField;
    TblrepairsFaultsRepairID: TIntegerField;
    TblrepairsFaultsTimeSheetID: TIntegerField;
    TblrepairsFaultsmsTimeStamp: TDateTimeField;
    TblrepairsFaultsCustomerEquipmentID: TIntegerField;
    TblrepairsFaultsDeleted: TWideStringField;
    TblrepairsFaultsmsUpdateSiteCode: TWideStringField;
    pnlRepairFaults: TDNMPanel;
    GrdRepairFaults: TwwDBGrid;
    WwIButton3: TwwIButton;
    CboRepairFault: TwwDBLookupCombo;
    DNMPanel3: TDNMPanel;
    DtpFollowUpDate: TwwDBDateTimePicker;
    CboEmployeeOthersFollowUp: TwwDBLookupCombo;
    CboEquipment: TwwDBLookupCombo;
    QryRepairFaultsEquip: TERPQuery;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    WideStringField5: TWideStringField;
    WideStringField6: TWideStringField;
    WideStringField7: TWideStringField;
    WideStringField8: TWideStringField;
    WideStringField9: TWideStringField;
    WideStringField10: TWideStringField;
    FloatField4: TFloatField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    LargeintField1: TLargeintField;
    WideStringField11: TWideStringField;
    WideMemoField1: TWideMemoField;
    QryClientLookupCustomer: TWideStringField;
    QryClientLookupSupplier: TWideStringField;
    QryClientLookupOtherContact: TWideStringField;
    PnlAttachments: TPanel;
    Label70: TLabel;
    tblrepairpartsSerialNo: TStringField;
    tblrepairpartsManucature: TStringField;
    tblrepairpartsModel: TStringField;
    tblrepairpartsRegistration: TStringField;
    tblMasterEnteredBy: TWideStringField;
    QryInvoicesDeleted: TWideStringField;
    qrybillsDeleted: TWideStringField;
    QrySalesOrdersDeleted: TWideStringField;
    QryRAHeadersDeleted: TWideStringField;
    qryPartsSupplierProductCode: TWideStringField;
    qryCustomersMobile: TWideStringField;
    pnlTitle: TDNMPanel;
    Bevel2: TBevel;
    Label15: TLabel;
    Label7: TLabel;
    lblShipTo: TLabel;
    Label22: TLabel;
    Bevel3: TBevel;
    Label46: TLabel;
    Label42: TLabel;
    cboClientJob: TERPDbLookupCombo;
    btnContacts: TDNMSpeedButton;
    txtClientDetails: TDBMemo;
    edCustomerPO: TDBEdit;
    cboTerms: TwwDBLookupCombo;
    cboVia: TwwDBLookupCombo;
    Label2: TLabel;
    Label8: TLabel;
    BillClientName: TERPDbLookupCombo;
    BillToCustomerDetails: TDBMemo;
    DNMPanel2: TDNMPanel;
    lblClassHeader: TLabel;
    Label5: TLabel;
    Label48: TLabel;
    Label21: TLabel;
    Label1: TLabel;
    Label17: TLabel;
    cboClass: TwwDBLookupCombo;
    cboEmployee: TwwDBLookupCombo;
    dtCreationDate: TwwDBDateTimePicker;
    cboStatus: TwwDBLookupCombo;
    cboJobDueDate: TwwDBDateTimePicker;
    cboTime: TwwDBComboBox;
    Label6: TLabel;
    edtCPhone: TDBEdit;
    Label9: TLabel;
    DBEdit3: TDBEdit;
    Label12: TLabel;
    edtPhone: TDBEdit;
    Label13: TLabel;
    DBEdit2: TDBEdit;
    Bevel4: TBevel;
    Label10: TLabel;
    chkChooseTemplate: TCheckBox;
    Bevel5: TBevel;
    wwCheckBox1: TwwCheckBox;
    Label19: TLabel;
    Bevel8: TBevel;
    Shader1: TShader;
    pnlActiveForm: TLabel;
    pnlPagecontrol: TDNMPanel;
    lblInvoices: TLabel;
    lblAppointment: TLabel;
    lblbills: TLabel;
    lblsmartOrders: TLabel;
    lblRAs: TLabel;
    lblSalesOrders: TLabel;
    Shape1: TBevel;
    Shape2: TBevel;
    Shape3: TBevel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Bevel7: TBevel;
    pnlconvertToOptions: TDNMPanel;
    btnAppointment: TDNMSpeedButton;
    btnInvoice: TDNMSpeedButton;
    btnRAs: TDNMSpeedButton;
    btnSmartOrder: TDNMSpeedButton;
    btnBill: TDNMSpeedButton;
    btnSalesOrder: TDNMSpeedButton;
    btnEmail: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    btnRepeat: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    btnPreview: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    cmdOk: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    sbButtons: TScrollBox;
    pnlButtons: TDNMPanel;
    pnlTitle1: TDNMPanel;
    lblRepairNo: TLabel;
    lblConverted: TLabel;
    lbMemTrans: TLabel;
    DNMPanel12: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    edtRepairNo: TwwDBEdit;
    lblEnteredbyHead: TLabel;
    lblEnteredBy: TDBText;
    SmartOrderSpliter: TSplitter;
    RASpliter: TSplitter;
    Bevel9: TBevel;
    Bevel15: TBevel;
    Label16: TLabel;
    DBEdit1: TDBEdit;
    Label79: TLabel;
    DBEdit4: TDBEdit;
    Label78: TLabel;
    chkUseBillCust: TwwCheckBox;
    grdOtherFollowUp: TwwDBGrid;
    btnDeleteOtherFollowUp: TwwIButton;
    FaultsSpliter: TSplitter;
    tblMastermsUpdateSiteCode: TWideStringField;
    QryPOs: TERPQuery;
    lblPOBos: TLabel;
    lblPOBSs: TLabel;
    tblDetailsAppointmentID: TLargeintField;
    tblDetailsNotes: TWideStringField;
    tblDetailsmsTimeStamp: TDateTimeField;
    tblDetailsmsUpdateSiteCode: TWideStringField;
    tblDetailsNextServiceDate: TDateTimeField;
    tblrepairpartsPartBarcode: TWideStringField;
    QryPOsSmartOrderID: TIntegerField;
    QryPOsSmartOrderLinesID: TIntegerField;
    QryPOsOriginalNo: TWideStringField;
    QryPOsPARTSNAME: TWideStringField;
    QryPOsQty: TFloatField;
    QryPOsShipped: TFloatField;
    QryPOsBOQty: TFloatField;
    QryPOstoOrder: TFloatField;
    lblAllgood: TLabel;
    Label80: TLabel;
    btnQtyVarify: TDNMSpeedButton;
    qryCustomersTERMS: TWideStringField;
    qryCustomersTERMSID: TIntegerField;
    qryCustomersrepairComment: TWideMemoField;
    qryCustomersRepairCommentPopUp: TWideStringField;
    menMeomoriseTransaction: TMenuItem;
    menAutoMemoriseTransaction: TMenuItem;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    lblArea: TLabel;
    cboAreaCode: TwwDBLookupCombo;

    pnlNotesTop: TDNMPanel;
    Label4: TLabel;
    Label11: TLabel;
    Splitter1: TSplitter;
    txtNotes: TAddictSpellDBMemo;
    Spelling1: TMenuItem;
    txtFeedbackNotes: TAddictSpellDBMemo;
    btnCashSale: TDNMSpeedButton;
    actCashSale: TAction;
    DNMSpeedButton3: TDNMSpeedButton;
    DNMSpeedButton4: TDNMSpeedButton;
    tblrepairpartsPurchaseLineId: TIntegerField;
    pgCustomFields: TPageControl;
    tabCustomFields: TTabSheet;
    pnlcustomfieldList: TDNMPanel;
    DNMPanel11: TDNMPanel;
    Memo1: TMemo;
    TabSheet2: TTabSheet;
    pnlCustFldsFixed: TDNMPanel;
    Bevel6: TBevel;
    Box181: TBevel;
    Label95: TLabel;
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
    Label93: TLabel;
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
    btnCreateJob: TDNMSpeedButton;
    Bevel19: TBevel;
    Label3: TLabel;
    Label14: TLabel;
    Label27: TLabel;
    edtEstimatedCost: TwwDBEdit;
    edtSalesAmount: TwwDBEdit;
    edtContractValue: TwwDBEdit;
    tblMasterContractValue: TFloatField;
    tblMasterSuggestedSalesAmount: TFloatField;
    tblMasterEstimatedCost: TFloatField;
    qryTimesheetsOverheadCost: TFloatField;
    actSignature: TAction;
    tblMasterSignature: TBlobField;
    tblMasterSignatureTime: TDateTimeField;
    DNMPanel13: TDNMPanel;
    cbDone: TwwCheckBox;
    btnSignature: TDNMSpeedButton;
    QryInvoicesTotalAmount: TFloatField;
    qryCustomersbillstreet3: TWideStringField;
    qryCustomersCustomer: TWideStringField;
    qryCustomersSupplier: TWideStringField;
    qryCustomersOtherContact: TWideStringField;
    btnTotalCost: TDNMSpeedButton;
    txtCost: TEdit;
    btnTotalAmount: TDNMSpeedButton;
    txtTotal: TEdit;
    btnShowTotalAmountInc: TDNMSpeedButton;
    edtInvoicetotal: TEdit;
    Bevel18: TBevel;
    mnuAlternateProduct: TMenuItem;
    tblMasterClientPrintName: TWideStringField;
    cboPrintProductR: TERPDbLookupCombo;
    tblDetailsVehicleRego_IDNo: TWideStringField;
    tblDetailsVehicleRego_Description: TWideStringField;
    tblDetailsVehicleRego_PurposeOfUse: TWideStringField;
    tblDetailsVehicleRego_Status: TWideStringField;
    tblDetailsVehicleRego_Expiry: TDateTimeField;
    Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Procedure FormShow(Sender: TObject);
    Procedure cmdOkClick(Sender: TObject);
    Procedure BtnDeleteClick(Sender: TObject);
    Procedure cmdNewClick(Sender: TObject);
    Procedure BtnRepeatClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure BtnCancelClick(Sender: TObject);
    Procedure CboClientJobCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure TblrepairpartsCalcFields(DataSet: TDataSet);
    Procedure FormPaint(Sender: TObject);
    Procedure GrdPartsCalcTitleAttributes(Sender: TObject; Const AFieldName: String; Const AFont: TFont; Const ABrush: TBrush; Var ATitleAlignment: TAlignment);
    Procedure GrdPartsTitleButtonClick(Sender: TObject; Const AFieldName: String);
    Procedure BtnDeletePartsClick(Sender: TObject);
    Procedure BtnDeleteOtherFollowUpClick(Sender: TObject);
    Procedure LoadTemplate(Const BPrint, BSave: Boolean; Const DoClose: Boolean = True; Const FileName: String = ''); Override;
    Procedure MnuDiscountDollarClick(Sender: TObject);
    Procedure MnuDiscountPercClick(Sender: TObject);
    Procedure MnuMarkupDollarClick(Sender: TObject);
    Procedure MnuMarkupPercClick(Sender: TObject);
    Procedure ActInvoiceExecute(Sender: TObject);
    Procedure ActInvoiceUpdate(Sender: TObject);
    Procedure CboProductRCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure GrdPartsExit(Sender: TObject);
    Procedure ChkUseBillCustClick(Sender: TObject);
    Procedure BillClientNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure GrdOtherFollowUpExit(Sender: TObject);
    Procedure QryClientLookupCalcFields(DataSet: TDataSet);
    Procedure TABCTL20Change(Sender: TObject);
    Procedure FormResize(Sender: TObject);
    Procedure FormDestroy(Sender: TObject);
    Procedure CboClassRepairPartsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure BtnSmartOrderClick(Sender: TObject);
    Procedure ActRepeatUpdate(Sender: TObject);
    Procedure DMTextTargetRepairsDrop(Sender: TObject; Acceptor: TWinControl; Const DropText: String; X, Y: Integer);
    Procedure BtnAttachmentsClick(Sender: TObject);
    Procedure MemTblMasterBeforePost(DataSet: TDataSet);
    Procedure TABCTL20Enter(Sender: TObject);
    (* procedure cboClientJobDblClick(Sender: TObject); *)
    Procedure BtnAppointmentClick(Sender: TObject);
    Procedure CboClientJobEnter(Sender: TObject);
    Procedure ActCompanyExecute(Sender: TObject);
    Procedure CmdCustomLabelsOldClick(Sender: TObject);
    Procedure DsStateChange(Sender: TObject);
    Procedure InsertDateandTime1Click(Sender: TObject);
    Procedure CboProductRChange(Sender: TObject);
    Procedure QryClientInvoicetoLookupCalcFields(DataSet: TDataSet);
    Procedure CboStatusNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
    Procedure EdtETADateDblClick(Sender: TObject);
    Procedure MnuCustomiseGridClick(Sender: TObject);
    Procedure FormKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure TaxCodeDetailsBeforeOpen(DataSet: TDataSet);
    Procedure GrdTimesheetsButtonClick(Sender: TObject);
    Procedure TbOtherFollowUpNewRecord(DataSet: TDataSet);
    Procedure CboServicesCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure CboEquipmentNameDropDown(Sender: TObject);
    Procedure TABCTL20Changing(Sender: TObject; Var AllowChange: Boolean);
    Procedure CboClientJobDropDown(Sender: TObject);
    Procedure cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure GrdPartsUpdateFooter(Sender: TObject);
    Procedure CboProductRDblClick(Sender: TObject);
    Procedure CboEquipnameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure GrdPartsRowChanged(Sender: TObject);
    Procedure CboUnitOfMeasureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure UnlockedcompOnenter(Sender: TObject);
    Procedure UnlockedcompOnexit(Sender: TObject);
    Procedure GrdPartsEnter(Sender: TObject);
    Procedure BtnPreviewClick(Sender: TObject);
    Procedure CboEquipnameNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
    Procedure CboEquipnameDblClick(Sender: TObject);
    Procedure MnuProductStatusClick(Sender: TObject);
    Procedure TblDetailsWarantyPeriodTakenChange(Sender: TField);
    Procedure TblDetailsWarantyPeriodLeftChange(Sender: TField);
    Procedure GrdInvoicesDblClick(Sender: TObject);
    Procedure GrdAppointmentsDblClick(Sender: TObject);
    Procedure QryAppointmentsAfterOpen(DataSet: TDataSet);
    Procedure QryInvoicesAfterOpen(DataSet: TDataSet);
    Procedure TABCTL20Resize(Sender: TObject);
    Procedure LblAppointmentClick(Sender: TObject);
    Procedure LblInvoicesClick(Sender: TObject);
    Procedure CboFaultConditionDescCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure CboFaultSymptomDescCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure CboFaultDefectDescCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure CboFaultRepairDescCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure CboFaultSectionDescCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure DNMSpeedButton1Click(Sender: TObject);
    Procedure CboManufactureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure CboManufactureEnter(Sender: TObject);
    Procedure LblsmartOrdersClick(Sender: TObject);
    Procedure GrdSODblClick(Sender: TObject);
    Procedure GrdSmartOrderDblClick(Sender: TObject);
    Procedure QrySmartOrdersCalcFields(DataSet: TDataSet);
    Procedure CboStatusDblClick(Sender: TObject);
    Procedure TblrepairpartsAfterOpen(DataSet: TDataSet);
    Procedure CboRetailerEnter(Sender: TObject);
    Procedure CboRetailerCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure DNMSpeedButton2Click(Sender: TObject);
    Procedure CboProductRDropDown(Sender: TObject);
    Procedure CboClientJobExit(Sender: TObject);
    Procedure QryClientLookupBeforeOpen(DataSet: TDataSet);
    Procedure FormActivate(Sender: TObject);
    Procedure GrdBillsDblClick(Sender: TObject);
    Procedure LblbillsClick(Sender: TObject);
    Procedure QrybillsAfterOpen(DataSet: TDataSet);
    Procedure BtnBillClick(Sender: TObject);
    Procedure QrySmartOrderHeaderAfterOpen(DataSet: TDataSet);
    Procedure GrdPartsDblClick(Sender: TObject);
    Procedure GrdPartsKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure QrySalesOrdersAfterOpen(DataSet: TDataSet);
    Procedure GrdSalesOrdersDblClick(Sender: TObject);
    Procedure BtnSalesOrderClick(Sender: TObject);
    Procedure BtnRAsClick(Sender: TObject);
    Procedure LblRAsClick(Sender: TObject);
    Procedure LblSalesOrdersClick(Sender: TObject);
    Procedure GrdRAsDblClick(Sender: TObject);
    Procedure GrdRAHeaderDblClick(Sender: TObject);
    Procedure QryRAHeadersAfterOpen(DataSet: TDataSet);
    Procedure EdtMemoLineDblClick(Sender: TObject);
    Procedure MnuAuditTrialClick(Sender: TObject);
    Procedure Addresslist(Sender: TObject);
    Procedure CustomFields1Click(Sender: TObject);
    Procedure TblMasterRepairDocNoSetText(Sender: TField; Const Text: String);
    Procedure QrySmartOrderHeaderAfterScroll(DataSet: TDataSet);
    Procedure GrdPartsCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    Procedure BtnDeleteAssetClick(Sender: TObject);
    Procedure GrdDocsIButtonClick(Sender: TObject);
    Procedure LetterBtnClick(Sender: TObject);
    Procedure EmailBtnClick(Sender: TObject);
    Procedure QryTimesheetsCalcFields(DataSet: TDataSet);
    Procedure CboEquipmentCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
    Procedure CboEquipmentDblClick(Sender: TObject);
    Procedure CboEquipmentNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
    Procedure WwIButton3Click(Sender: TObject);
    Procedure CboRepairFaultDblClick(Sender: TObject);
    Procedure CboRepairFaultNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
    Procedure TblMasterAfterOpen(DataSet: TDataSet);
    procedure grdPartsColEnter(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure txtNotesDblClick(Sender: TObject);
    procedure txtFeedbackNotesDblClick(Sender: TObject);
    procedure edCustomerPOExit(Sender: TObject);
    procedure qryStatusBeforeOpen(DataSet: TDataSet);
    procedure btnEmailClick(Sender: TObject);
    procedure QryPOsAfterOpen(DataSet: TDataSet);
    procedure QryPOsBeforeOpen(DataSet: TDataSet);
    procedure lblPOBosClick(Sender: TObject);
    procedure lblAllgoodClick(Sender: TObject);
    procedure tblMasterAfterPost(DataSet: TDataSet);
    procedure btnQtyVarifyClick(Sender: TObject);
    procedure cboTermsQryAfterOpen(DataSet: TDataSet);
    procedure DoMemoriseRepairs(Sender: TObject);
    procedure Spelling1Click(Sender: TObject);
    procedure pnlNotesTopResize(Sender: TObject);
    procedure actCashSaleExecute(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure DNMSpeedButton4Click(Sender: TObject);
    procedure btnTotalCostClick(Sender: TObject);
    procedure btnTotalAmountClick(Sender: TObject);
    procedure btnCreateJobClick(Sender: TObject);
    procedure actSignatureExecute(Sender: TObject);
    procedure actSignatureUpdate(Sender: TObject);
    procedure txtCostDblClick(Sender: TObject);
    procedure txtTotalDblClick(Sender: TObject);
    procedure edtInvoicetotalDblClick(Sender: TObject);
    procedure btnShowTotalAmountIncClick(Sender: TObject);
    procedure mnuAlternateProductClick(Sender: TObject);
    procedure pnlconvertToOptionsDblClick(Sender: TObject);
    procedure tblMasterAfterInsert(DataSet: TDataSet);
    procedure grdPartsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  Private
    FMsgHandler       : TMsgHandler;
    BUpdatingSplit    : Boolean;
    BCanCloseForm     : Boolean;
    BDisableCancel    : Boolean;
    ProductListForm   : TBaseListingGUI;
    EquipmentxRefForm : TfmEquipmentxRef;
    TimeSheetForm     : TfrmTimeSheet;
    FsaleIDs          : String;
    // ProductSearcher: TwwDBComboSearcher;
    // ClientSearcher: TwwDBComboSearcher;
    Appointment: TAppointment;
    (* cleannote:String; *)
    RealignTabInProgress : Boolean;
    EquipmentTabshown    : Boolean;
    EquipmentName        : String;
    EquipmentId          : Integer;
    EquipmentPartsclicked: Boolean;
    CustomfieldonGrid    : TCustomFieldonGrid;
    FiCustomerID         : Integer;
    AttachmentForm       : TfmAttachments;
    mainbuttons :Array of TDNMSpeedbutton;
    ButtonCtr:Integer;
    CurPageIndex:Integer;
    fbAddNewRepairnFocustoclientCbo:Boolean;
    fbformShown:Boolean;
    fShowTotalCostInc: boolean;
    fShowTotalAmountInc: boolean;
    fshowTotalInvAmountInc: boolean;
    fbInvoicefootersShown :Boolean;
    fsSalesFormName :String;
    fsSalesType :String;


    Procedure NewRepair;
    Procedure ShowAttachments(fbDragnDropping :Boolean);
//    Procedure CheckForAttachments;
    Procedure ProductGridDblClick(Sender: TObject);

    Procedure CalcTotal;
    Procedure CopyEquipsToappointment(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure ChangeInvStatus(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure ChangeSOStatus(Const Sender: TBusObj; Var Abort: Boolean);
    Procedure UpdateFromContact(sender: TwwDBGrid);
    Procedure ShowFootervalue;
    Procedure ShowInvoicefooters;
    Procedure Showtotalamount;
    Procedure SetGridColumns;
    Procedure RefreshUnitsQry;
    Procedure SetsaleIDs(Const Value: String);

    Procedure AssignReportTemplate;
    Procedure ShowEquipform;
    Function ChkCustReqdFields: Boolean;
    Procedure ShowEquipmentParts;
    Procedure FilterforEquipment(Sender: Tobject);
    Procedure AddProducts(Sender: Tobject);
    Procedure DoAddProducts(Sender: Tobject);
    (* Procedure SetManufactureId(sender :TObject); *)
    Procedure GotoExportfield(Const Value: String);
    Procedure SetPagecontrolFocus(Control: TWincontrol; Activefieldname: String = '');
    Procedure ChangeTab(Const Tab: TTabSheet);
    Procedure ShowPO(Const POIDs: String);
    Procedure AssignRepairID4Bill(Sender: TObject);
    Procedure SetMatrixDetails(SMatrixDesc, SMatrixRef: String; DMatrixPrice: Double);
    Procedure ShowRAs(Const RAIDs: String);
    Procedure GlobalEventHandler(Const Sender: TObject; Const Event: String; Const Data: Pointer);
    Procedure BeforeshowCustomfieldList(Sender: TObject);
    Procedure ApplyCustomFieldsSettings;
    Procedure OnProductSelect(Sender: TwwDBGrid);

    Procedure LockPartCalcformulafields;
    Function Showformuladetails: Boolean;
    Procedure BeforeShowEquipmentxRefForm(Sender: TObject);
    Procedure InitAttachments;
    function DoPrint(const Preview: boolean): boolean;
    procedure PrintRepair;
    procedure PreviewRepair;
    procedure SendEmail;
    procedure SendSilentEmail;
    procedure EmailInvoiced;
    function SendPrintSMS: boolean;
    function SendPrintSMSSilent: boolean;
    function SendPrintEmail: boolean;
    function SendPrintEmailSilent: boolean;
    procedure AddMainButtons;
    procedure AddButton(const ButtonCaption: string; Pageindex:Integer; const ButtonTop: Integer);
    procedure MainButtonClick(Sender: TObject);
    procedure HideTabs(const TabToshow:Integer =0);
    function findbutton(const btnIndex:Integer):TObject;
    procedure REadguiprefs;
    procedure Writeguiprefs;
    procedure AlignConvertOptions;
    procedure UpdateNotes(Sender: TwwDbGrid);
    procedure UpdateFeedbackNotes(Sender: TwwDbGrid);
    function HasToAndIsApproved: Boolean;
    function HastoAndIsallPOREceived(Const StatusChangeEvent :String;   ShowMessage :Boolean = True): Boolean;
    procedure CreateBarcode(NewValue: String);
    procedure CreateBarCodeForProduct(Sender: TObject);
    procedure LocateaPOBO;
    Function InventoryVarify(const ShowMsg:Boolean =False):Boolean;
    procedure initcontactList(Sender: TObject);
    function SAveRepair:Boolean;
    procedure SetShowTotalCost(const Value: boolean);
    procedure SetShowTotalAmountInc(const Value: boolean);
    procedure SetshowTotalInvAmountInc(const Value: boolean);
    procedure initProductQtyBinETA(Sender: TObject);
    //function AnyclassAutoCreateSmartOrders: Boolean;
    Procedure OpenTransRecord(Const Qry: TERPQuery; IDFieldName: STring; Recordtype: String; Const ComponentClassType: String);
    procedure BeforeShowJob(Sender : TObject);
    procedure ReplaceProductWtihAlternateProduct(Sender: TwwDbGrid);
    procedure BeforeAlternateProduct(Sender: TObject);
    procedure RefreshCustomerLookup;

  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure CustomFieldsRefresh; Override;
    Procedure CompleteComboNotInList(Const AObserver: TObject); Override;
    Procedure LoadDataFromPOLines(Const ProductID: Integer);
    Function GetReportTypeID: Integer; Override;

    Procedure DivertComboDblClick(Sender: TObject); Override;

    Procedure TransAuditTrialbeforeShow(Sender: TObject);
    Procedure GrdMainonDblClick(Sender: TObject);
    Procedure SetStateParams(Const Value: TJsonObject); Override;
    Procedure AfterSubFormShow(Sender: TObject); Override;
    Procedure Openrecord(Const ID: Integer; Const ComponentClassType: String); Override;
    function GetOrAddMobileNumber: string;
    procedure SetTotalButtonCaptions(aShowTotalCostInc, aShowTotalAmountInc , ashowTotalInvAmountInc : boolean);
    property ShowTotalCostInc : boolean read fShowTotalCostInc write SetShowTotalCost;
    property ShowTotalAmountInc : boolean read fShowTotalAmountInc write SetShowTotalAmountInc;
    property showTotalInvAmountInc : boolean read fshowTotalInvAmountInc write SetshowTotalInvAmountInc;
    Procedure InitERPLookupCombonFields; Override;
    procedure DoSendEmail(aSecret : boolean);
  Public
    EmployeeID                  : Integer;
    BInitialising               : Boolean;
    RepairsOBJ                  : TRepairs;
    Function CustomFieldExtenderListtype:TListType; Override;
    Property DisableCancelButton: Boolean Read BDisableCancel Write BDisableCancel;
    Property CanCloseForm       : Boolean Read BCanCloseForm Write BCanCloseForm;
    Procedure UpdateMe; Override;
    Procedure UpdateMe(Const Canceled: Boolean; Const AObject: TObject = Nil); Override;
    Property SaleIDs: String Read FsaleIDs Write SetsaleIDs;
    Property CustomerID: Integer Read FiCustomerID Write FiCustomerID;
    Procedure Setcolumn(ColumnVisible: Boolean; ColumnName: String; Displaylabel: String = '');
    Class Function MakeaNewRepair: Integer;
  Published
    Procedure AppointmentClosed(MsgObj: TMsgObj);
    Function GetRepairDetails(MsgObj: TMsgObj; Out MsgRet: TMsgObj): Boolean;
    Procedure RefreshAppointments(MsgObj: TMsgObj; Out MsgRet: TMsgObj);
    Function Addtimesheetrecord(MsgObj: TMsgObj; Out MsgRet: TMsgObj): Boolean;
  End;

Implementation

{$R *.dfm}

Uses
  FastFuncs, DateUtils, FrmCustomerFrm, FrmRepeat, FormFactory, DNMExceptions,
  POSScreenGUI, CommonDbLib, ProductListForm, FrmFixedAssetServiceLogGUI, (*frmSmartOrderFrm,*)
  TcDataUtils, CommonLib, ActiveX, FrmPartsFrm, BaseClassFuncs,
  ContactSelectorFrm, FrmPurchaseorders, DNMLib, FrmCustomFieldsFrm, GuiPrefsObj,
  PayCommon, BusObjConst, AppEnvironment, BusObjTimeSheet, BusObjSales,
  BusObjClient, (* *)(*frmBarcodePopUp,*) FrmAllocation, StrUtils,
  AppointmentLib, BaseFormForm, BusObjEquipment, FrmProductQtysBinsETAs,
  EquipmentListforxRef, ExportRepairsObj, CommonFormLib, FrmSimpleTypes,
  EquipmentspareParts, BusobjRepairsExportConfig, RepairExportHelp,
  AppContextObj, FrmSmartOrderFrm, FrmBill, FrmproductPrices,
  PartsPriceMatrixLib, FrmpartsPriceMatrixInput, MemoDialog, GlobalEventsObj,
  BusObjPrintDoc, TcTypes, TransAuditTrail, ShipAddressListForm,
  tcconst,BusObjSimpleTypes, FrmCustomfieldList,
  FormReopenerObj, BusObjCommon, PartCalcFormulaObj, BusObjFixedAsset,
  FrmRepairCorrespondenceCreate, RepairsLib, BusObjAudit, frmReportingOptions,
  BusObjContact, frmMobileNumberInput,
  SMSUtils, EmailUtils, frmMessageWithList, frmMessageBase, BusObjStock,
  ProductListExpressForm, frmRepairsInventoryVerify, ContactList,
  frmDelayMessageDlg, datSpelling, ad3SpellBase, BusObjCash, CorrespondenceObj,
  frmJob, frmSignatureEdit, ListLib, AlternateProductSearch, DbSharedObjectsObj,EmailExtraUtils,
  LogLib(**);

procedure TRepairsGUI.PreviewRepair;
begin
  DoPrint(true);
end;

procedure TRepairsGUI.PrintRepair;
begin
  DoPrint(false);
end;

Procedure TRepairsGUI.ProductGridDblClick(Sender: TObject);
Begin
  RepairsOBJ.RepairParts.ProductID := TwwDBGrid(Sender).DataSource.DataSet.FieldByName('PartsId').AsInteger;
  ProductListForm.Close;
End;

Procedure TRepairsGUI.FormActivate(Sender: TObject);
Begin
  Inherited;
  WindowState := Wsnormal;
End;

Procedure TRepairsGUI.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
  Writeguiprefs;
  Inherited;
  CloseQueries;
  Action := CaFree;
End;

Procedure TRepairsGUI.NewRepair;
Begin
  fbAddNewRepairnFocustoclientCbo := True;
  try
    CboClass.Text                := AppEnv.DefaultClass.DefaultClassName;
    CboClientJob.Readonly        := False;
    //PageControl1.ActivePageIndex := 0;
    Mainbuttonclick(findbutton(0));
    SetControlFocus(CboClientJob);
  finally
    fbAddNewRepairnFocustoclientCbo := False;
  end;
End;

function TRepairsGUI.CustomFieldExtenderListtype: TListType;
begin
  Result := ltRepair;
end;

Procedure TRepairsGUI.CustomFields1Click(Sender: TObject);
Begin
  Inherited;
  If OpenERPFormModal('TfmCustomfieldList', 0, BeforeshowCustomfieldList) >= 0 Then CustomfieldonGrid.ApplyCustomFieldsSettings;
End;

Procedure TRepairsGUI.BeforeshowCustomfieldList(Sender: TObject);
Begin
  If Not(Sender Is TfmCustomfieldList) Then Exit;
  TfmCustomfieldList(Sender).ListType := LtRepairparts;
End;

Procedure TRepairsGUI.CustomFieldsRefresh;
BEGIN
  CustomFieldRefresh('CFRepairs', pnlCustFldsFixed);
End;

Function TRepairsGUI.ChkCustReqdFields: Boolean;
Begin
  Result                                     := ChkReqdFields('Repairs');
  If Not Result Then TabCtl20.ActivePage := Custom_Fields;
End;

Procedure TRepairsGUI.FormShow(Sender: TObject);
Var
  QueryNamesNotToOpen         : Array Of String;
  WHour, WMin, WSec, WMilliSec: Word;
  SMaridium, STime            : String;
  ManufactureId               : Integer;
  TempStr: string;

  Procedure RefreshcompletionDateNTime;
  Begin
    If RepairsOBJ.JobdueDate <> 0 Then Begin
      DecodeTime(RepairsOBJ.JobdueDate, WHour, WMin, WSec, WMilliSec);
      If WHour >= 12 Then Begin
        SMaridium               := 'PM';
        WHour                   := WHour - 12;
        If WHour = 0 Then WHour := 12;
      End Else Begin
        If WHour = 0 Then WHour := 12;
        SMaridium               := 'AM';
      End;
      If WHour < 10 Then STime := '0' + IntToStr(WHour) + ':'
      Else STime               := IntToStr(WHour) + ':';
      If WMin < 10 Then STime  := STime + '0' + IntToStr(WMin) + ' ' + SMaridium
      Else STime               := STime + IntToStr(WMin) + ' ' + SMaridium;
    End Else Begin
      STime := '';
    End;
    CboTime.Text := STime;
  End;

Begin
  Showcontrolhint(lblPObos, 'PO BO(s) is the count of Products in the Backorder - either in the same back order  or different. '+NL+
                   'It doesn''t include the Smart Orders which are not converted in to a Purchase Order/Back Order'+NL);
  Showcontrolhint(lblPOBSs, lblPObos.hint);


  If Appenv.CompanyPrefs.DefaultDiscountMarkup = 'Discounts' Then Begin
    GuiPrefs.DbGridElement[GrdParts].AddField('Discount');
    GuiPrefs.DbGridElement[GrdParts].RemoveFields('DiscountPercent,Markup,MarkupPercent');
  End
  Else If Appenv.CompanyPrefs.DefaultDiscountMarkup = 'DiscountPercent' Then Begin
    GuiPrefs.DbGridElement[GrdParts].AddField('DiscountPercent');
    GuiPrefs.DbGridElement[GrdParts].RemoveFields('Discount,Markup,MarkupPercent');
  End
  Else If Appenv.CompanyPrefs.DefaultDiscountMarkup = 'Markup' Then Begin
    GuiPrefs.DbGridElement[GrdParts].AddField('Markup');
    GuiPrefs.DbGridElement[GrdParts].RemoveFields('Discount,DiscountPercent,MarkupPercent');
  End
  Else If Appenv.CompanyPrefs.DefaultDiscountMarkup = 'MarkupPercent' Then Begin
    GuiPrefs.DbGridElement[GrdParts].AddField('MarkupPercent');
    GuiPrefs.DbGridElement[GrdParts].RemoveFields('Discount,DiscountPercent,Markup');
  End;

  TABCTL20.TabIndex := 0;
  BInitialising         := True;
  Try
    Inherited;
    //ApplyCustomFieldsSettings;

    RepairsOBJ.Connection.BeginTransaction;
    RepairsOBJ.Load(KeyID);

    Closedb(QryClientLookup);
    If KeyId <> 0 Then Begin
      If Not RepairsOBJ.Userlock.Lock(RepairsOBJ.BusobjectTableName, RepairsOBJ.ID, RepairsOBJ.LockGroupName) Then Begin
        AccessLevel := 5;
        CommonLib.MessageDlgXP_Vista(RepairsOBJ.UserLock.LockMessage + NL+NL+ 'Access will be changed to read-only.', MtWarning, [MbOK], 0);
      end else if (RepairsObj.Done) and (AppEnv.CompanyPrefs.LockRepairwhenDone ) then begin
        AccessLevel := 5;
        CommonLib.MessageDlgXP_Vista('This is a ''Done'' repair and as per the preference the repairs record is locked when Done.'+NL+NL + 'Access will be changed to read-only.', MtWarning, [MbOK], 0);
      end;
      IF RepairsOBJ.Converted Then Begin
        Self.Caption := Self.Caption + ' {Invoice already created!}';
      End;

    End Else Begin
      RepairsOBJ.New;
      NewRepair;
      if AppEnv.CompanyPrefs.AddNotesToNewRepair then
        if AppEnv.CompanyPrefs.NewRepairNotesText <> '' then
        begin
          // Just assign, no need to write in the db
          txtNotes.Lines.Text := AppEnv.CompanyPrefs.NewRepairNotesText;
        end;
    End;
    ApplyCustomFieldsSettings;
    EnableDisable;

    Setlength(QueryNamesNotToOpen, 17);
    QueryNamesNotToOpen[0]  := 'tblMaster';
    QueryNamesNotToOpen[1]  := 'tblDetails';
    QueryNamesNotToOpen[2]  := 'tblrepairparts';
    QueryNamesNotToOpen[3]  := 'tbOtherFollowUp';
    QueryNamesNotToOpen[4]  := 'qryClients';
    QueryNamesNotToOpen[5]  := 'qryCustomers';
    QueryNamesNotToOpen[6]  := 'qryTimeSheets';
    QueryNamesNotToOpen[7]  := 'QryInvoices';
    QueryNamesNotToOpen[8]  := 'QryAppointments';
    QueryNamesNotToOpen[9]  := 'QrySmartOrders';
    QueryNamesNotToOpen[10] := 'QrySmartOrderHeader';
    QueryNamesNotToOpen[11] := 'qrybills';
    QueryNamesNotToOpen[12] := 'QrysalesOrders';
    QueryNamesNotToOpen[13] := 'QryRAHeaders';
    QueryNamesNotToOpen[14] := 'QryRAs';
    QueryNamesNotToOpen[15] := 'qryAssetXRef';
    QueryNamesNotToOpen[16] := 'tblrepairsFaults';


    Closedb(CboTermsQry);
    CboTermsQry.Params.Parambyname('xTerms').AsString := RepairsObj.Terms;

    Closedb(QryPartsEquip);
    QryPartsEquip.Params.Parambyname('ClientID').AsInteger := Repairsobj.ClientID;
    Opendb(QryPartsEquip);

    Closedb(QryRepairFaultsEquip);
    QryRepairFaultsEquip.Params.Parambyname('ClientID').AsInteger := Repairsobj.ClientID;
    Opendb(QryRepairFaultsEquip);

    ManufactureId                                                   := RepairsOBJ.RepairDetails.ManufactureID;
    QryRepairFaultsCondition.Parambyname('ManufactureID').AsInteger := ManufactureId;
    QryRepairFaultsSymptom.Parambyname('ManufactureID').AsInteger   := RepairsOBJ.RepairDetails.ManufactureID;
    QryRepairFaultsDefect.Parambyname('ManufactureID').AsInteger    := RepairsOBJ.RepairDetails.ManufactureID;
    QryRepairFaultsRepair.Parambyname('ManufactureID').AsInteger    := RepairsOBJ.RepairDetails.ManufactureID;
    QryRepairFaultsSection.Parambyname('ManufactureID').AsInteger   := RepairsOBJ.RepairDetails.ManufactureID;
    QryDocuments.Parambyname('RepairID').AsInteger                  := RepairsOBJ.Id;

    OpenQueries(QueryNamesNotToOpen);

    If (FiCustomerID <> 0) And (KeyId = 0) Then Begin
      RepairsOBJ.CustomerName := TcDataUtils.GetClientName(FiCustomerID);
      CboClientJob.OnCloseUp(CboClientJob, CboClientJob.Lookuptable, CboClientJob.Datasource.Dataset, True);
      FiCustomerID := 0;
    End;

    RepairsOBJ.PostDB;
    RepairsOBJ.RepairEquipmentFault;
    RepairsOBJ.RepairParts;
    RepairsOBJ.RepairParts.Dataset.Filter   := 'Deleted <> ' + QuotedStr('T');
    RepairsOBJ.RepairParts.Dataset.Filtered := True;
    RepairsOBJ.Invoices;
    RepairsOBJ.SalesOrders;
    RepairsOBJ.Appointments;
    RepairsOBJ.Otherfollowup;
    RepairsOBJ.Customer;
    RepairsOBJ.RepairDetails;
    RepairsOBJ.RepairAssetXRef;

    CloseDB(QrySmartOrders);
    QrySmartOrders.ParamByname('RepairID').AsInteger := RepairsOBJ.Id;
    OpenDB(QrySmartOrders);

    CloseDB(QryRas);
    QryRas.ParamByname('RepairID').AsInteger := RepairsOBJ.Id;
    OpenDB(QryRas);

    CloseDB(QrySmartOrderHeader);
    QrySmartOrderHeader.ParamByname('RepairID').AsInteger := RepairsOBJ.Id;
    OpenDB(QrySmartOrderHeader);

    CloseDB(QryRAHeaders);
    QryRAHeaders.ParamByname('RepairID').AsInteger := RepairsOBJ.Id;
    OpenDB(QryRAHeaders);

    CloseDB(Qrybills);
    Qrybills.ParamByname('RepairID').AsInteger := RepairsOBJ.Id;
    OpenDB(Qrybills);


    TempStr := ExtractStrPortion(cboProductR.Selected[0], #9, 2);
    //cboProductR.Selected[0] := ReplaceStr(cboProductR.Selected[0], TempStr, IntToStr(Appenv.CompanyPrefs.ProductNameDropdownWidth));
    //FormatProductCombo(cboProductR);


    QryClientLookup.Filtered                           := False;
    QryServices.Params.ParamByName('xEmpID').AsInteger := AppEnv.Employee.EmployeeID;
    CustomFieldsRefresh;
    If QryClientLookup.Locate('ClientID', Repairsobj.ClientID, []) Then CboClientJob.Text := QryClientLookupCompany.AsString;
    If BDisableCancel Then BtnCancel.Enabled                                              := False;
    TabCtl20.ActivePageIndex                                                          := 0;
    If KeyID <> 0 Then Begin
      RefreshcompletionDateNTime;
      LblConverted.Visible := RepairsOBJ.Converted;
    End;
    LblClassHeader.Caption := AppEnv.DefaultClass.ClassHeading;
    lblClassHeader.Left := cboClass.Left;
    ChkUseBillCustClick(Nil);
//    CheckForAttachments;
    DMTextTargetRepairs.AcceptorControl := Nil;
    DMTextTargetRepairs.AcceptorControl := PnlAttachments;
    BInitialising                       := False;
    LblRepairNo.Caption                 := 'Repair No:';
    EdtRepairNo.Left                    := LblRepairNo.Left + LblRepairNo.Width + 10;
    // grdParts.ColumnByName('Discount').DisplayLabel := 'Discount ($)';
    CalcTotal;
    Width := Width - 1;
    Width := Width + 1;
    SetGridColumns;
    REadguiprefs;
    ShowFootervalue;
    grdParts.ColumnByName('ConvertToInvoice').ReadOnly:= True;
    (* if accesslevel = 2 then accesslevel := 1; *)
    RealignTabControl(pgCustomFields, 1);
  Except
    On EAbort Do HandleEAbortException;
    On E: ENoAccess Do Begin
      HandleNoAccessException(E);
      Exit;
    End;
    Else
      Raise;
  End;
  AddMainButtons;
//  if not btnAttachments.Visible then
//    btnSignature.Left := txtFeedbackNotes.Left + txtFeedbackNotes.Width - btnSignature.Width;
  TabCtl20.ActivePageIndex := 0;
  SetControlFocus(CboclientJob);
  if sametext(RepairsOBJ.CustomerPONumber , 'AUTO-Generated' ) then begin
    Setcontrolfocus(edCustomerPO);
    RepairsObj.dirty := true;
  end else if RepairsObj.TermsId < 0 then begin
    Setcontrolfocus(cboTerms);
    RepairsObj.dirty := true;
  end;
  fbformShown:=True;
End;

procedure TRepairsGUI.AddButton(const ButtonCaption: string;Pageindex:Integer;  const ButtonTop: Integer);
var
  Button: TDNMSpeedButton;
begin
  Button := TDNMSpeedButton.Create(Self);
  Setlength(mainbuttons , high(mainbuttons)+2);
  mainbuttons[high(mainbuttons)] := button;
  with Button do begin
    Left := cMainButtonLeft;
    Top := ButtonTop;
    Width := cMainButtonWidth;
    Height := cMainButtonHeight;
    Caption := ButtonCaption;
    Parent := pnlButtons;
    Alignment := taCenter;
    Color := clWhite;
    HotTrackColor := clBtnShadow;
    SlowDecease := True;
    Style := bsModern;
    inc(ButtonCtr);
    name := 'mainbutton'+inttostr(Pageindex);
    OnClick := MainButtonClick;
    tag := Pageindex;
  end;

end;
Procedure TRepairsGUI.AddMainButtons;
var
  ButtonTop: Integer;
  ButtonIndex: Integer;
  st:TStringlist;
  xtab  :TComponent;
  function CaptionnName (const tab  :TTabSheet):String;  begin    Result := tab.Caption +'|' + tab.Name ; end;
  function GetCaption   (Const Value:String   ):String;  begin    Result := trim(replacestr(copy(Value , 1, pos('|',Value)), '|',''));  end;
  function GetName      (Const Value:String   ):String;  begin    Result := trim(replacestr(copy(Value ,  pos('|',Value) , length(Value)), '|',''));  end;
begin
  ButtonTop := cMainButtonTopStart;
  st:= tStringlist.Create;
  try
    st.Sorted:=  true;
    for ButtonIndex := 0 to TabCtl20.PageCount-1 do
      st.Add(CaptionnName(TabCtl20.pages[ButtonIndex]));

    for ButtonIndex := 0 to st.Count-1 do begin
      xtab := findcomponent(getname(st[ButtonIndex]));
      if xTab <> nil then begin
        AddButton(TTabsheet(xTab).Caption , TTabsheet(xTab).PageIndex,  ButtonTop);
        ButtonTop := ButtonTop + cMainButtonHeight + cMainButtonGap;
      end;
    end;

  finally
    Freeandnil(st);
  end;



  (*for ButtonIndex := 0 to TabCtl20.PageCount-1 do begin
      AddButton(TabCtl20.pages[ButtonIndex].Caption, ButtonTop);
      ButtonTop := ButtonTop + cMainButtonHeight + cMainButtonGap;
  end;*)

  pnlButtons.Height := ButtonTop;
  if pnlButtons.Height > self.ClientHeight then begin
    pnlButtons.Width := sbButtons.ClientWidth;
    for ButtonIndex := 0 to pnlButtons.ControlCount -1 do begin
      pnlButtons.Controls[ButtonIndex].Left := 7;
    end;
  end else begin
    pnlButtons.Width := sbButtons.ClientWidth;
  end;

  //TTabsheet(TabCtl20.pages[0]).Tabvisible := True;
  //TabCtl20.ActivePageIndex :=0;
  MainButtonClick(findbutton(0));
end;
Procedure TRepairsGUI.cmdOkClick(Sender: TObject);
Begin
  Try
    If SaveRepair (*RepairsOBJ.Save*) Then Begin
      KeyId := RepairsOBJ.ID;
(*      If Not ChkCustReqdFields Then Begin
        Exit;
      End;*)
      RepairsOBJ.Connection.CommitTransaction;
      Notify;
      Self.CloseWait;
    End Else Begin
      If (RepairsOBJ.ResultStatus.GetLastFatalStatusItem <> Nil) And (RepairsOBJ.ResultStatus.GetLastFatalStatusItem.Code = BOR_TimeSheet_Err) Then Begin
        TabCtl20.ActivePage := TabTimesheetEntries;
        TabCtl20Change(TabCtl20);
      End;
    End;
  Except
    On EAbort Do HandleEAbortException;
    Else
      Raise;
  End;
End;

Procedure TRepairsGUI.BtnDeleteAssetClick(Sender: TObject);
Begin
  Inherited;
  if accesslevel >2 then exit;
  If QryAssetXRef.RecordCount > 0 Then Self.QryAssetXRef.Delete;
End;

Procedure TRepairsGUI.BtnDeleteClick(Sender: TObject);
Begin
  Try
    If CommonLib.MessageDlgXP_Vista('Delete Line ' + #10#13 + RepairsOBJ.RepairEquipment.CustomerEquipment.EquipName + ' ?', MtConfirmation, [MbYes, MbNo], 0) = MrYes Then TblDetails.Delete;
  Except
    ;
  End;
End;

Procedure TRepairsGUI.BtnDeleteOtherFollowUpClick(Sender: TObject);
Begin
  Try
    If CommonLib.MessageDlgXP_Vista('Delete Line ' + #10#13 + DateToStr(TbOtherFollowUpFollowUpDate.AsDateTime) + ' ?', MtConfirmation, [MbYes, MbNo], 0) = MrYes Then TbOtherFollowUp.Delete;
  Except
    ;
  End;
End;

Procedure TRepairsGUI.cmdNewClick(Sender: TObject);
Begin
  If RepairsOBJ.Dirty Then Begin
    If Not SaveRepair (*RepairsOBJ.Save*) Then Exit;
    RepairsOBJ.Connection.CommitTransaction;
  End;
  RepairsOBJ.Connection.BeginTransaction;
  RepairsOBJ.New;
  if TABCTL20.ActivePageIndex <> 0 then
    TABCTL20.ActivePageIndex := 0;

  NewRepair;
  RepairsOBJ.Invoices;
  RepairsOBJ.Appointments;
  RepairsOBJ.RepairDetails;
  RepairsOBJ.RepairParts;
  CalcTotal;
End;

Procedure TRepairsGUI.BtnRepeatClick(Sender: TObject);
Var
  ProgressDialog: TProgressDialog;
Begin
  If Not SaveRepair (*RepairsOBJ.Save*) Then Exit;
  RepairsOBJ.Connection.CommitTransaction;
  With TRepeatFrm.Create(Self, CommonDbLib.GetSharedMyDacConnection.Database) Do Begin
    Try
      Caption := 'Repeat Repair';
      ShowModal;
      If ModalResult = MrOk Then Begin
        RepairsOBJ.Connection.BeginTransaction;
        ProgressDialog := TProgressDialog.Create(Nil);
        RepairsObj.RepairParts.Dataset.Disablecontrols;
        RepairsObj.RepairEquipment.Dataset.Disablecontrols;
        TRy
          RepairsObj.ProgressDialog := ProgressDialog;
          If Not RepairsOBJ.Repeatrepairs(Dates) Then Begin
            RepairsObj.Connection.RollbackTransaction;
            RepairsObj.Connection.BeginTransaction;
          End Else Begin
            RepairsObj.Connection.CommitTransaction;
            Self.CloseWait;
          End;
        Finally
          If Assigned(ProgressDialog) Then FreeAndNil(ProgressDialog);
          RepairsObj.RepairParts.Dataset.Enablecontrols;
          RepairsObj.RepairEquipment.Dataset.Enablecontrols;
        End;
      End;
    Finally Free;
    End;
  End;
End;
procedure TRepairsGUI.CreateBarCodeForProduct(Sender: TObject);
begin
  with TwwDBGrid(Sender).Datasource.dataset do begin
    if active      = False then exit;
    if RecordCount = 0 then exit;
    if findfield('PartsId') = nil then exit;
    if Fieldbyname('PartsID').asInteger = 0 then exit;
    TProduct.AssignBarCode(Fieldbyname('PartsID').asInteger, repairsObj.Repairparts.partbarcode);
  end;
end;

Procedure TRepairsGUI.CreateBarcode(NewValue: String);
var
  frm  :TfrmParts;
  ans :word;
begin
  inherited;
  ans:= CommonLib.MessageDlgXP_Vista('This Barcode not found. Would you like to create?',
      mtConfirmation, [], 0  , nil , '' , '' , False, nil , 'Create New Product,Add Barcode to a Product,Cancel');
      try
  if ans = 102 then begin
  end else if ans = 101 then begin
    with TProductListExpressGUI(GetComponentByClassName('TProductListExpressGUI', true)) do begin
          ExpresslistPopup('Choose Product' , CreateBarCodeForProduct, False);
          Showmodal;
    end;
  end else begin
        if TfrmParts.FormActive then begin
          TfrmParts.CloseMe;
        end;

        frm := TfrmParts(GetComponentByClassName('TfrmParts'));
        if assigned(frm) then begin
            TfrmParts(frm).fsBarcode := Repairsobj.Repairparts.Partbarcode;
            frm.Position := poScreenCenter;
            if not frm.Visible then
              frm.ShowModal;
        end;
    end
  finally
//    Repairsobj.Repairparts.productname := tcdatautils.GetProductForbarCode(Repairsobj.Repairparts.Partbarcode);
    Repairsobj.Repairparts.productname := tcdatautils.GetProductForbarCodeEx(Repairsobj.Repairparts.Partbarcode);
    if Repairsobj.Repairparts.productname = '' then Repairsobj.Repairparts.Partbarcode:= '';
  end;
end;
Procedure TRepairsGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; Const EventType, Value: String);
Var
  MatrixDesc : String;
  MatrixRef  : String;
  MatrixPrice: Double;
Begin
      inherited ;
{--}   If (Eventtype = BusObjEvent_Dataset) And (Value = BusObjEvent_AssignDataset) Then Begin
          If Sender Is TRepairs Then TRepairs(Sender).DAtaset                          := TblMaster
          Else If Sender Is TEquipmentxRef Then TEquipmentxRef(Sender).Dataset         := TblDetails
          Else If Sender Is TOtherFollowups Then TOtherFollowups(Sender).Dataset       := TbOtherFollowUp
          Else If Sender Is TRepairParts Then TRepairParts(Sender).Dataset             := Tblrepairparts
          Else If Sender Is TTimeSheet Then TTimeSheet(Sender).Dataset                 := QryTimeSheets
          Else If Sender Is TRepairEquipmentFault Then TOtherFollowups(Sender).Dataset := TblrepairsFaults
          Else If Sender Is TTimesheetEntry Then TTimesheetEntry(Sender).Dataset       := QryTimesheetEntry
          Else If Sender Is TInvoice Then TInvoice(Sender).Dataset                     := QryInvoices
          Else If Sender Is TSalesOrder Then TSalesOrder(Sender).Dataset               := QrySalesOrders
          Else If Sender Is TAppointment Then TAppointment(Sender).Dataset             := QryAppointments
          Else If Sender Is TRepairDetails Then TRepairDetails(Sender).Dataset         := Qryrepairdetails
          Else If Sender Is TCustomer Then TCustomer(Sender).Dataset                   := QryCustomers
          Else If Sender Is TRepairAssetXRef Then TRepairAssetXRef(Sender).Dataset     := QryAssetXRef;
{--}   end else if (EventType = BusobjEvent_ToDo) and (Value = BusObjEvent_PartBarcodeNotfound)  then begin
            Createbarcode(Repairsobj.Repairparts.Partbarcode);
{--}   End  Else If (Eventtype = BusObjEvent_Dataset) And (Sender.IsdataIdchangeEvent(Value)) Then Begin
          If Sender Is TEquipmentxRef Then Begin
            CloseDb(QryrepairFaults);
            QryrepairFaults.ParamByName('xName').AsString := TEquipmentxRef(Sender).Repairfault;
            OpenDb(QryrepairFaults);
          End;
{--}   End Else If (EventType = BusObjEvent_Change) And (Value = BusobjEvent_CustomerinRepair) Then Begin
{--}   End Else If (EventType = BusObjEvent_Change) And (Value = BusobjEvent_Repairstatus) Then Begin
          if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanApproveRepairForInvoicing')<> 1 then
            if SameText (repairsobj.Status , appenv.CompanyPrefs.RepairStatustoMakeInvoice) then begin
              MessageDlgXP_vista('You don''t have access to change status to '+quotedstr(appenv.CompanyPrefs.RepairStatustoMakeInvoice) +' the Repair for Invoicing', mtWarning, [mbOK], 0);
              repairsobj.Status := tblMasterStatus.OldValue;
              repairsobj.PostDB;
            end;
          if SameText (repairsobj.Status , appenv.CompanyPrefs.RepairStatustoMakeInvoice) then
            if not HastoAndIsallPOREceived('change Status to ' +quotedstr(appenv.CompanyPrefs.RepairStatustoMakeInvoice)) then begin
              repairsobj.Status := RepairWaiting4PartsStatus;
              repairsobj.PostDB;
            end;
{--}   End Else If (EventType = BusObjEvent_Change) And (Value = BusObjEventVal_Equipment) Then Begin
          If Sender = RepairsOBJ.RepairParts Then
            If (RepairsOBJ.AddingRelatedParts=False) and (RepairsOBJ.RepairParts.ProductID = 0) Then Begin
              EquipmentPartsclicked := True;
              ShowEquipmentParts;
              EquipmentName := RepairsOBJ.RepairParts.Equipmentname;
              EquipmentId   := RepairsOBJ.RepairParts.CustomerEquipmentID;
            End;
{--}   End Else If (EventType = BusObjEvent_Change) And (Value = BusObjEventVal_Total) Then Begin
          ShowFootervalue;
          If Assigned(TimeSheetForm) Then TimeSheetForm.DoBusinessObjectEvent(Sender, EventType, Value);
          ShowtotalAmount;
{--}   End Else If (EventType = BusObjEvent_Change) And (Value = BusObjEvent_TimesheetAdded) Then Begin
          RepairsOBJ.UpdateStatus(SimpleTypeAction_TimesheetAdded);
{--}   End Else If (EventType = BusObjEvent_Change) And ((Value = BusObjEventVal_Qty)) Then Begin
          If RepairsOBJ.RepairParts.ProductId <> 0 Then RepairsOBJ.RepairParts.PostDB;
{--}   End Else If (EventType = BusObjEvent_Change) And (Value = BusObjEventVal_ProductChanged) Then Begin
          If RepairsOBJ.RepairParts.ProductId <> 0 Then
            If Not RepairsOBJ.RepairParts.Deleted Then Begin
              ReadSalesDefaultPriceMethod(RepairsOBJ.RepairParts.ProductID, MatrixDesc, MatrixRef, MatrixPrice);
              SetMatrixDetails(MatrixDesc, MatrixRef, MatrixPrice);
            End;
          { formula stuff }
          If Sender = RepairsObj.RepairParts Then Begin
            LockPartCalcformulafields;
            If RepairsOBJ.RepairParts.Hasformula Then Begin
              RepairsOBJ.RepairParts.FormulaQtyValue := 1;
              With TPartCalcFormula.Create(Self) Do
                Try InitformulaQtyValues(RepairsOBJ.RepairParts);
                Finally Free;
                End;
            End;
          End;
{--}   End Else If (Eventtype = BusObjEvent_change) And ((Value = BusObjEventVal_Manufacture)) Then Begin
          CloseDB(QryRepairFaultsCondition);
          CloseDB(QryRepairFaultsSymptom);
          CloseDB(QryRepairFaultsDefect);
          CloseDB(QryRepairFaultsRepair);
          CloseDB(QryRepairFaultsSection);
          QryRepairFaultsCondition.Parambyname('ManufactureID').AsInteger := RepairsOBJ.RepairDetails.ManufactureID;
          QryRepairFaultsSymptom.Parambyname('ManufactureID').AsInteger   := RepairsOBJ.RepairDetails.ManufactureID;
          QryRepairFaultsDefect.Parambyname('ManufactureID').AsInteger    := RepairsOBJ.RepairDetails.ManufactureID;
          QryRepairFaultsRepair.Parambyname('ManufactureID').AsInteger    := RepairsOBJ.RepairDetails.ManufactureID;
          QryRepairFaultsSection.Parambyname('ManufactureID').AsInteger   := RepairsOBJ.RepairDetails.ManufactureID;
          OpenDB(QryRepairFaultsCondition);
          OpenDB(QryRepairFaultsSymptom);
          OpenDB(QryRepairFaultsDefect);
          OpenDB(QryRepairFaultsRepair);
          OpenDB(QryRepairFaultsSection);
          { if faults already selected and changed the manufacture and if the fault doesn;t belong to the selected manufacture - reset to blank }
          If RepairsOBJ.RepairDetails.FaultConditionID <> 0 Then
            If Not QryRepairFaultsCondition.Locate('RepairFaultID', RepairsOBJ.RepairDetails.FaultConditionID, []) Then Begin
              RepairsOBJ.RepairDetails.FaultConditionID   := 0;
              RepairsOBJ.RepairDetails.FaultConditionDesc := '';
            End;
          If RepairsOBJ.RepairDetails.FaultSymptomID <> 0 Then
            If Not QryRepairFaultsSymptom.Locate('RepairFaultID', RepairsOBJ.RepairDetails.FaultSymptomID, []) Then Begin
              RepairsOBJ.RepairDetails.FaultSymptomID   := 0;
              RepairsOBJ.RepairDetails.FaultSymptomDesc := '';
            End;
          If RepairsOBJ.RepairDetails.FaultDefectID <> 0 Then
            If Not QryRepairFaultsDefect.Locate('RepairFaultID', RepairsOBJ.RepairDetails.FaultDefectID, []) Then Begin
              RepairsOBJ.RepairDetails.FaultDefectID   := 0;
              RepairsOBJ.RepairDetails.FaultDefectDesc := '';
            End;
          If RepairsOBJ.RepairDetails.FaultRepairID <> 0 Then
            If Not QryRepairFaultsRepair.Locate('RepairFaultID', RepairsOBJ.RepairDetails.FaultRepairID, []) Then Begin
              RepairsOBJ.RepairDetails.FaultRepairID   := 0;
              RepairsOBJ.RepairDetails.FaultRepairDesc := '';
            End;
          If RepairsOBJ.RepairDetails.FaultSectionID <> 0 Then
            If Not QryRepairFaultsSection.Locate('RepairFaultID', RepairsOBJ.RepairDetails.FaultSectionID, []) Then Begin
              RepairsOBJ.RepairDetails.FaultSectionID   := 0;
              RepairsOBJ.RepairDetails.FaultSectionDesc := '';
            End;
{--}   End Else If (Eventtype = BusObjEvent_change) And ((Value = BusobjEvent_RepairDone)) Then Begin
          If RepairsOBJ.Done And Not(RepairsOBJ.CleanDone) Then Begin
            If Appenv.CompanyPrefs.DefaultStatusforSOofDoneRepair <> '' Then Begin
              If RepairsOBJ.SalesOrders.Count > 0 Then Begin
                If AppEnv.AccessLevels.GetEmployeeAccessLevel(RepairsOBJ.SalesOrders.Classname) > 2 Then Begin
                  MessageDlgXP_Vista('It is not possible to change the Status of the Sales ' + 'Order(s) associated with this repair to the ' + NL + 'Default Status for Sales order when Repair is Done : ' +
                    Quotedstr(Appenv.CompanyPrefs.DefaultStatusforSOofDoneRepair) + '.' + NL + NL + RepairsOBJ.SalesOrders.NoRigtsMsg('Update'), Mtwarning, [Mbok], 0, Nil, '', '', False, Nil, '', '', 520);
                End
                Else If MessageDlgXP_Vista('Do you wish to change the Status of the Sales ' + 'Order(s) associated with this repair to the' + ' Default Status for Sales order when Repair is Done : ' +
                  Quotedstr(Appenv.CompanyPrefs.DefaultStatusforSOofDoneRepair) + '?', MtConfirmation, [Mbyes, Mbno], 0, Nil, '', '', False, Nil, '', '', 520) = MrYes Then Begin
                  RepairsOBJ.SalesOrders.IterateRecords(ChangeSOStatus);
                End;
              End;
            End;

            If Appenv.CompanyPrefs.DefaultStatusForInvoiceofdonerepair <> '' Then Begin
              If RepairsOBJ.Invoices.Count > 0 Then Begin
                If AppEnv.AccessLevels.GetEmployeeAccessLevel(RepairsOBJ.Invoices.Classname) > 2 Then Begin
                  MessageDlgXP_Vista('It is not possible to change the Status of the Invoice(s) ' + 'associated with this repair to the ' + NL + 'Default Status for Invoice when Repair is Done : ' +
                    Quotedstr(Appenv.CompanyPrefs.DefaultStatusForInvoiceofdonerepair) + '.' + NL + NL + RepairsOBJ.Invoices.NoRigtsMsg('Update'), Mtwarning, [Mbok], 0, Nil, '', '', False, Nil, '',
                    '', 500);
                End Else If MessageDlgXP_Vista('Do you wish to change the Status of the Invoice(s) ' + 'associated with this repair to the ' + ' Default Status for Invoice when Repair is Done : ' +
                  Quotedstr(Appenv.CompanyPrefs.DefaultStatusForInvoiceofdonerepair) + '?', MtConfirmation, [Mbyes, Mbno], 0, Nil, '', '', False, Nil, '', '', 500) = MrYes Then Begin
                  RepairsOBJ.Invoices.IterateRecords(ChangeInvStatus);
                End;
              End;
            End;
          End;
{--}   End;
End;

procedure TRepairsGUI.DoMemoriseRepairs(Sender: TObject);
begin
  inherited;
  RepairsOBJ.PostDB;
  If not RepairsOBJ.ValidateData Then exit;
  DoMemoriseTrans(RepairsOBJ.ID ,   RepairsOBJ.ClientID , sender = menAutoMemoriseTransaction , TitleLabel.Caption);
  if qryMemTrans.RecordCount > 0 then RepairsOBJ.Dirty:= true;
end;

function TRepairsGUI.DoPrint(const Preview: boolean): boolean;
Var
  FPrintDoc: TBusObjPrintDoc;
Begin
  result := false;
  if Accesslevel = 5 then begin
  end else begin
    if not SaveRepair (*RepairsOBJ.Save*)  then exit;
  end;
  RepairsOBJ.Connection.CommitTransaction;
  try
      result := true;
      FbReportSQLSupplied := True;
      AssignReportTemplate;
      PrintTemplateReport(ReportToPrint, RepairsReportSQL(RepairsObj.ID), not Preview, 1);
      FPrintDoc := TBusObjPrintDoc.Create(Nil);
      Try
        If (not Preview) Then FPrintDoc.PrintDoc(RepairsOBJ.ClassName, RepairsOBJ.ID, DtMain, Self.Classname, DotPrint, ReportToPrint)
        Else FPrintDoc.PrintDoc(RepairsOBJ.ClassName, RepairsOBJ.ID, DtMain, Self.Classname, DotPreview, ReportToPrint);
      Finally FPrintDoc.Free;
      End;
      If (not Preview) And AppEnv.CompanyPrefs.HoldRepairOnPrinting Then Begin
        RepairsOBJ.Connection.BeginTransaction;
        RepairsOBJ.HoldRepair := True;
        RepairsOBJ.PostDb;
        RepairsOBJ.Connection.CommitTransaction;
      End;
  finally
      RepairsOBJ.Connection.BeginTransaction;
  end;
end;

procedure TRepairsGUI.DoSendEmail(aSecret: boolean);
var
  Recipients: string;
begin
  If SaveRepair Then
  Begin
    RepairsOBJ.Connection.CommitTransaction;
    Recipients := GetContactEmails(RepairsObj.ClientID, 'MainContactForRepair');
    try
      AssignReportTemplate;
      fbReportSQLSupplied := True;
      EmailReport(RepairsOBJ.ID, RepairsOBJ.Client.ClientName, Recipients, 'Repairs', ReportToPrint, RepairsReportSQL(RepairsObj.ID), fbReportSQLSupplied, true, True, aSecret);
    finally
      RepairsOBJ.Connection.BeginTransaction;
    end;
  End;
end;

Procedure TRepairsGUI.LockPartCalcformulafields;
Begin
  With TPartCalcFormula.Create(Self) Do
    Try LockPartCalcformulafields(GrdParts, REpairsObj.RepairParts.Hasformula);
    Finally Free;
    End;
End;

procedure TRepairsGUI.MainButtonClick(Sender: TObject);
var
  Allowchange:Boolean;
begin
  if (sender is TDNMSpeedButton) and (TDNMSpeedButton(Sender).Tag >=0) then begin
    if TabCtl20.ActivePageIndex <> TDNMSpeedButton(Sender).Tag then begin
      TabCtl20Changing(TabCtl20 , Allowchange);
      if not Allowchange then exit;
      TabCtl20.ActivePageIndex :=TDNMSpeedButton(Sender).Tag;
      TTabsheet(TabCtl20.pages[TDNMSpeedButton(Sender).Tag]).Tabvisible := False;
      TabCtl20.OnChange(TabCtl20);
//      TabCtl20Change(TabCtl20);
      pnlActiveForm.Caption :=TDNMSpeedButton(Sender).Caption;
      Setcontrolfocus(TabCtl20);
    end;
    if devmode then highlightcontrol(TDNMSpeedButton(Sender));
  end;
end;

Class Function TRepairsGUI.MakeaNewRepair: Integer;
Begin
  Result := OpenERPFormModal('TRepairsGUI', 0, Nil);
End;

Procedure TRepairsGUI.ChangeInvStatus(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TInvoice) Then Exit;
  If Not(REpairsObj.Userlock.Lock('tblsales', TInvoice(Sender).ID, 'RepairUpdatingstauts')) Then Begin
    MessageDlgXP_Vista('It is not possible to change the Status of the Invoice # ' + Inttostr(TInvoice(Sender).Id) + '.' + NL + NL + Replacestr(REpairsObj.Userlock.LockMessage,
      'Unable to update data.' + #13#10, ''), Mtwarning, [Mbok], 0);
  End Else Begin
    TInvoice(Sender).Connection.BeginNestedTransaction;
    Try
      TInvoice(Sender).SalesStatus := Appenv.CompanyPrefs.DefaultStatusForInvoiceofdonerepair;
      TInvoice(Sender).PostDB;
      TInvoice(Sender).Connection.CommitNestedTransaction;
    Except TInvoice(Sender).Connection.RollbackNestedTransaction;
    End;
  End;
End;

Procedure TRepairsGUI.ChangeSOStatus(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TSalesOrder) Then Exit;
  If Not(REpairsObj.Userlock.Lock('tblsales', TSalesOrder(Sender).ID, 'RepairUpdatingstauts')) Then Begin
    MessageDlgXP_Vista('It is not possible to change the Status of the Sales Order # ' + Inttostr(TSalesOrder(Sender).Id) + '.' + NL + NL + Replacestr(REpairsObj.Userlock.LockMessage,
      'Unable to update data.' + #13#10, ''), Mtwarning, [Mbok], 0);
  End Else Begin
    TSalesOrder(Sender).Connection.BeginNestedTransaction;
    Try
      TSalesOrder(Sender).SalesStatus := Appenv.CompanyPrefs.DefaultStatusforSOofDoneRepair;
      TSalesOrder(Sender).PostDB;
      TSalesOrder(Sender).Connection.CommitNestedTransaction;
    Except TSalesOrder(Sender).Connection.RollbackNestedTransaction;
    End;
  End;
End;
Procedure TRepairsGUI.AlignConvertOptions;
var
  bTop :Integer;
  bleft :Integer;
  Procedure Alignbutton(btn :TDNMSpeedbutton);
  begin
    btn.Width  := 90;
    btn.height :=cMainButtonHeight;
    btn.Left   := bleft;
    btn.Top := bTop;
    bTop := bTop +btn.height +cMainButtonGap;
  end;
begin
  bTop :=0;
  bleft := trunc((pnlconvertToOptions.Width -90)/2);

  bTop := btnAppointment.top;
  Alignbutton(btnAppointment);
  Alignbutton(btnBill);
  Alignbutton(btnInvoice);
  Alignbutton(btnCashSale);
  Alignbutton(btnQtyVarify);
  Alignbutton(btnRAs);
  Alignbutton(btnSalesOrder);
  Alignbutton(btnSmartOrder);
end;
procedure TRepairsGUI.mnuAlternateProductClick(Sender: TObject);
begin
  inherited;
  if RepairsOBJ.RepairParts.ProductID=0 then begin
    MessageDlgXP_vista('Select the Product ', mtInformation, [mbOK], 0);
    Exit;
  end;
  OpenERPListFormModal('TAlternateProductSearchGUI' , ReplaceProductWtihAlternateProduct, BeforeAlternateProduct);

end;
procedure TRepairsGUI.BeforeAlternateProduct(Sender: TObject);
begin
  if not(Sender is TAlternateProductSearchGUI) then Exit;
  TAlternateProductSearchGUI(Sender).ProductID := RepairsOBJ.RepairParts.ProductID;
  TAlternateProductSearchGUI(Sender).ClassId := RepairsOBJ.classId;
end;
procedure TRepairsGUI.ReplaceProductWtihAlternateProduct(Sender: TwwDbGrid);
var
  fbDoFieldChangewhenDisabled: Boolean;
  //fShipped,
  fQty : double;
begin
    RepairsOBJ.RepairParts.PostDb;
      fbDoFieldChangewhenDisabled := RepairsOBJ.RepairParts.DoFieldChangewhenDisabled;
      RepairsOBJ.RepairParts.DoFieldChangewhenDisabled := true;
      try
       fQty := RepairsOBJ.RepairParts.Quantity;
             if Sender.Datasource.DataSet.findfield('AlternateProductID') <> nil then RepairsOBJ.RepairParts.ProductID := Sender.Datasource.DataSet.FieldByName('AlternateProductID').AsInteger
        else if Sender.Datasource.DataSet.findfield('PartsId')            <> nil then RepairsOBJ.RepairParts.ProductID := Sender.Datasource.DataSet.FieldByName('PartsId').AsInteger
        else if Sender.Datasource.DataSet.findfield('ProductID')          <> nil then RepairsOBJ.RepairParts.ProductID := Sender.Datasource.DataSet.FieldByName('ProductID').AsInteger;

             if Sender.Datasource.DataSet.findfield('AlternateProductName')<> nil then RepairsOBJ.RepairParts.ProductName := Sender.Datasource.DataSet.FieldByName('AlternateProductName').AsString
        else if Sender.Datasource.DataSet.findfield('Partname')            <> nil then RepairsOBJ.RepairParts.ProductName := Sender.Datasource.DataSet.FieldByName('Partname').AsString
        else if Sender.Datasource.DataSet.findfield('ProductName')         <> nil then RepairsOBJ.RepairParts.ProductName := Sender.Datasource.DataSet.FieldByName('ProductName').AsString;

        RepairsOBJ.RepairParts.Quantity := fQty;
        RepairsOBJ.RepairParts.UOMQty := Round(DivZer(RepairsOBJ.RepairParts.Quantity, RepairsOBJ.RepairParts.UOMMultiplier), RepairsOBJ.RepairParts.RoundPlacesGeneral);

        RepairsOBJ.RepairParts.PostDB;
      finally RepairsOBJ.RepairParts.DoFieldChangewhenDisabled := fbDoFieldChangewhenDisabled;
      end;
end;
Procedure TRepairsGUI.FormCreate(Sender: TObject);
Var
  Index       : Integer;
  ElementIndex: Integer;
Begin
  fbInvoicefootersShown := False;
  fbformShown:=False;
  Height := 592;
  AlignConvertOptions;
  fbAddNewRepairnFocustoclientCbo:= False;
  ButtonCtr := -1;
  CurPageIndex:= -1;
  AttachmentForm        := Nil;
  FiCustomerID          := 0;
  EquipmentPartsclicked := False;
  ExcludeGridfromcustomize(GrdSO);
  EquipmentTabshown           := False;
  Pnltimesheetentries.Caption := '';
  PnlEquipments.Caption       := '';
  Appointment                 := Nil;
  EquipmentName               := '';
  EquipmentId                 := 0;
  GlobalEvents.RegisterNameHandler(Self, 'TEquipmentsparePartsGUI', '', GEVENT_ListClosed, GlobalEventHandler);

  FMsgHandler        := TMsgHandler.Create(Self);
  AllowCustomiseGrid := True;

  Inherited;
  AddDisablescontrolforHint(pnlconvertToOptions , btnInvoice , '');
  GuiPrefs.AddFieldPair('PriceEx', 'PriceInc', Tblrepairparts);
  GuiPrefs.AddFieldPair('LineTotalEx', 'calcTotalInc', Tblrepairparts);

  TblMaster.Connection                                        := MyConnection;
  TblDetails.Connection                                       := MyConnection;
  TbOtherFollowUp.Connection                                  := MyConnection;
  TblRepairParts.Connection                                   := MyConnection;
  QryCustomers.Connection                                     := MyConnection;
  QryTimeSheets.Connection                                    := MyConnection;
  QryTimesheetEntry.Connection                                := MyConnection;
  RepairsOBJ                                                  := TRepairs.Create(Self);
  RepairsOBJ.BusObjEvent                                      := DoBusinessObjectEvent;
  RepairsOBJ.Connection                                       := TMyDacDataconnection.Create(RepairsOBJ);
  RepairsOBJ.ConfirmFromGUI                                   := ConfirmFromGUI;
  TMyDacDataconnection(RepairsOBJ.Connection).MydacConnection := MyConnection;
  RepairsOBJ.ConfirmFromGUI                                   := ConfirmFromGUI;
  BDisableCancel                                              := False;
  BCanCloseForm                                               := False;
  BUpdatingSplit                                              := False;
  FbAllowNotInList                                            := True;
  Closedb(QryParts);
  (*QryParts.SQL.Clear;
  QryParts.SQL.Add('SELECT ');
  QryParts.SQL.Add(Firstcolumn + '   AS Manuf ,');
  QryParts.SQL.Add(Secondcolumn + ' AS Type ,');
  QryParts.SQL.Add(Thirdcolumn + ' AS Dept ,');
  QryParts.SQL.Add('PARTSID,PARTTYPE, p.PRODUCTGROUP, PARTNAME,');
  QryParts.SQL.Add('PARTSDESCRIPTION, INCOMEACCNT,');
  QryParts.SQL.Add('ASSETACCNT, COGSACCNT, BARCODE, PRODUCTCODE,');
  QryParts.SQL.Add('TAXCODE,');
  QryParts.SQL.Add('SpecialDiscount, SNTracking,  BuyQTY1, BuyQTY2,');
  QryParts.SQL.Add('BuyQTY3, COST1, COST2, COST3, SellQTY1, SellQTY2, SellQTY3,');
  QryParts.SQL.Add('PRICE1, PRICE2, PRICE3, WHOLESALEPRICE, Active, p.EditedFlag, AvgCost,');
  QryParts.SQL.Add('Sell_Cost_Percentage');
  QryParts.SQL.Add('FROM tblparts P');
  QryParts.SQL.Add('WHERE Active = "T" AND PARTNAME <> ""');
  QryParts.SQL.Add('and (((:SearchMode = 0) or IsNull(:SearchMode))');
  QryParts.SQL.Add('or ((:SearchMode = 1) and (p.PartName LIKE Concat(:SearchValue,"%")))');
  QryParts.SQL.Add('or ((:SearchMode = 2) and (p.PartName LIKE Concat("%",:SearchValue,"%"))))');
  QryParts.SQL.Add('and IfNull(:SearchValue,"") <> ""');
  QryParts.SQL.Add('ORDER By PartName, PartType');*)

  QryClientLookup.Connection := CommonDbLib.GetSharedMyDacConnection;
  With DMTextTargetRepairs, CustomFormats Do Begin
    OverrideDropEffects[DeMove] := DeCopy;
    Add('FileGroupDescriptor');
    AddObject('FileContents', TObject(TYMED_ISTREAM));
  End;
  ElementIndex                                                                                                  := -1;
  For Index                                                                                                     := 0 To GuiPrefs.Elements.Count - 1 Do Begin
    If GuiPrefs.Elements.Items[Index].Target = GrdOtherFollowUp Then GuiPrefs.Elements.Items[Index].Description := 'Follow Up Grid'
    Else If GuiPrefs.Elements.Items[Index].Target = GrdParts Then GuiPrefs.Elements.Items[Index].Description    := 'Products Grid'
  End;
  If ElementIndex >= 0 Then GuiPrefs.Elements.Remove(ElementIndex);
  
  GuiPrefs.Active := True;
  With TPartCalcFormula.Create(Self) Do
    Try SetdisplayLabel(Self);
    Finally Free;
    End;
  HideTabs(0);

  fShowTotalCostInc := true;
  fShowTotalAmountInc := true;
  fshowTotalInvAmountInc := true;
  SetTotalButtonCaptions(true, True, true);
End;


Procedure TRepairsGUI.HideTabs(const TabToshow:Integer =0);
var
  ButtonIndex:Integer;
begin
    for ButtonIndex := TabCtl20.PageCount-1 downto 0 do
      TTabsheet(TabCtl20.pages[ButtonIndex]).Tabvisible := False;
    if TabToshow >=0 then begin
      TabCtl20.ActivePageIndex :=TabToshow;
      TTabsheet(TabCtl20.pages[TabToshow]).Tabvisible := False;
    end;
end;
Procedure TRepairsGUI.BtnCancelClick(Sender: TObject);
Var
  QuestionResult: Integer;
Begin
  Inherited;
  If Not RepairsOBJ.Dirty Then Begin
    Notify(False);
    Self.CloseWait;
    Exit;
  End;

  QuestionResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', MtConfirmation, [MbYes, MbNo, MbCancel], 0);
  If QuestionResult = MrYes Then Begin
    If SaveRepair (*RepairsOBJ.Save*) Then Begin
      RepairsOBJ.Connection.CommitTransaction;
      Notify;
      Self.CloseWait;
    End;
  End
  Else If QuestionResult = MrNo Then Begin
    RepairsOBJ.Connection.RollbackTransaction;
    Notify(True);
    Self.CloseWait;
  End
  Else If QuestionResult = MrCancel Then Begin
    Exit;
  End;
End;

procedure TRepairsGUI.btnCreateJobClick(Sender: TObject);
begin

  inherited;
  if (AccessLevel >= 4) then begin
    MessageDlgXP_Vista('You don''t have enough Access to create the Job', mtWarning, [mbOK], 0);
    exit;
  end;
    (*
  end else if (SaleBase.customerid = 0) then begin
    MessageDlgXP_Vista('Please Select a customer', mtWarning, [mbOK], 0);
    exit;
  end else if (SaleBase.Customer.ISjob = true) then begin
    MessageDlgXP_Vista(Salebase.CustomerName + 'is a job.', mtWarning, [mbOK], 0);
    exit;
  end;
  *)
  DisableForm;
  try
    fLastComboAccessed := cboClientJob;
    try
//      OpenERPFormModal('TJobGUI', -(SaleBase.customerid), BeforeShowJob);
      OpenERPFormModal('TJobGUI', -(tblMaster.FieldByName('CusId').asInteger), BeforeShowJob);
    finally
      fLastComboAccessed := nil;
    end;
  finally
    EnableForm;
  end;
end;

procedure TRepairsGUI.BeforeShowJob(Sender: TObject);
begin
//  if not(Sender is TBaseInputGUI) then Exit;
  if Sender is TJobGUI then
  begin
    TBaseInputGUI(Sender).AttachObserver(Self);
    TJobGui(Sender).RepairNo := tblMaster.FieldByName('RepairDocNo').AsString;
  end;
end;

Procedure TRepairsGUI.CboClientJobCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If (Not Modified) Or Empty(CboClientJob.Text) Then Exit;
  Inherited;
  // Repairsobj.Customerdetails:= ClientDetails(qryClientLookup);
  Repairsobj.Terms    := QryClientLookupterms.AsString;
  Repairsobj.TermsId  := QryClientLookuptermsid.AsInteger;
  Repairsobj.Phone    := QryClientLookupPhone.AsString;
  Repairsobj.Altphone := QryClientLookupaltPhone.AsString;
  Repairsobj.Mobile   := QryClientLookupmobile.AsString;
  Repairsobj.Fax      := QryClientLookupFaxNumber.AsString;
  // if Repairsobj.BillClientID = 0 then begin
  Repairsobj.BillClientID := RepairsOBJ.ClientID;
  // Repairsobj.Billtocustomerdetails:= ClientDetails(qryClientLookup, true);
  Repairsobj.BillPhone    := QryClientLookupphone.AsString;
  Repairsobj.BillAltphone := QryClientLookupaltPhone.AsString;
  Repairsobj.Billmobile   := QryClientLookupmobile.AsString;
  Repairsobj.BillFax      := QryClientLookupFaxNumber.AsString;
  // end;
  If RepairsOBJ.RepairEquipment.Count > 0 Then Begin
    RepairsOBJ.DeleteAllEquipment;

  End;
  If TabCtl20.ActivePage = TabEquipment Then Begin
    TabCtl20.ActivePage := TabFollowupnProducts;
    TabCtl20Change(TabCtl20);
  End;
  TabCtl20.ActivePage := TabEquipment;
  TabCtl20Change(TabCtl20);

End;

Procedure TRepairsGUI.TblrepairpartsCalcFields(DataSet: TDataSet);
Begin
  Inherited;
  (* RepairsOBJ.RepairParts.calcTotalIncBase   := RepairsOBJ.RepairParts.PriceInc     * RepairsOBJ.RepairParts.Quantity;
    RepairsOBJ.RepairParts.calcTotalInc       := RepairsOBJ.RepairParts.PriceInc     * RepairsOBJ.RepairParts.Quantity +
    RepairsOBJ.RepairParts.Markup       - RepairsOBJ.RepairParts.Discount;
    RepairsOBJ.RepairParts.calcTotalEx        := RepairsOBJ.RepairParts.calcTotalInc / (1.0 + RepairsOBJ.RepairParts.TaxRate);
    RepairsOBJ.RepairParts.calcTax            := RepairsOBJ.RepairParts.TaxRate      * 100.0; *)
End;

Procedure TRepairsGUI.CalcTotal;
Begin
  Repairsobj.TimeSheetEntry.CalcTimesheetTotal;
  Repairsobj.CalcPartsTotal;
  Showtotalamount;
End;

Procedure TRepairsGUI.FormPaint(Sender: TObject);
Begin
  Inherited;
  GrdParts.SizeLastColumn;

End;

Procedure TRepairsGUI.GrdPartsCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
Begin
  Inherited;
  try
  With TPartCalcFormula.Create(Self) Do
    Try
      GridCalcCellColors(RepairsObj.RepairParts.Hasformula, Sender, Field, State, Highlight, AFont, ABrush (* ,QtySoldColor,QtyshippedColor *) );
    Finally Free;
    End;
  if Sametext(field.FieldName , tblrepairpartsSerialNo.FieldName) or
      Sametext(field.FieldName , tblrepairpartsManucature.FieldName) or
      Sametext(field.FieldName , tblrepairpartsModel.FieldName) or
      Sametext(field.FieldName , tblrepairpartsRegistration.FieldName) then
        AFont.Color := clInactiveCaption;
  Except

  end;
End;

Function TRepairsGUI.Showformuladetails: Boolean;
Begin
  Result := False;
  If RepairsObj.RepairParts.Hasformula = False Then Exit;
  If (GrdParts.GetActiveField = Tbldetails.Findfield('UnitOfMeasureQty')) Or (GrdParts.GetActiveField = Tbldetails.Findfield('FormulaQtyValue')) Or
    (GrdParts.GetActiveField = Tbldetails.Findfield('FormulaQtyValue1')) Or (GrdParts.GetActiveField = Tbldetails.Findfield('FormulaQtyValue2')) Or
    (GrdParts.GetActiveField = Tbldetails.Findfield('FormulaQtyValue3')) Or (GrdParts.GetActiveField = Tbldetails.Findfield('FormulaQtyValue4')) Or
    (GrdParts.GetActiveField = Tbldetails.Findfield('FormulaQtyValue5')) Then Begin

    Result := True;
    With TPartCalcFormula.Create(Self) Do
      Try FormulaDetails(RepairsObj.RepairParts, RepairsObj.RepairParts.Product, False);
      Finally Free;
      End;
  End;
End;

procedure TRepairsGUI.ShowInvoicefooters;
var
  Footerfields : TFooterCalcfieldsArray ;
Begin
  Inherited;
  if fbInvoicefootersShown then exit;
  LblInvoices.Caption    := IntToStr(QryInvoices.Recordcount)         ;
  SetLength(Footerfields,4);
  try
    Footerfields[0].FieldName :=QryInvoicesTotalAmountInc.FieldName ; Footerfields[0].Total:=0;Footerfields[0].Iscurrency:=True;Footerfields[0].Calctype:=fctSum;
    Footerfields[1].FieldName :=QryInvoicesBalance.FieldName        ; Footerfields[1].Total:=0;Footerfields[1].Iscurrency:=True;Footerfields[1].Calctype:=fctSum;
    Footerfields[2].FieldName :=QryInvoicesPayment.FieldName        ; Footerfields[2].Total:=0;Footerfields[2].Iscurrency:=True;Footerfields[2].Calctype:=fctSum;
    Footerfields[3].FieldName :=QryInvoicesTotalAmount.FieldName    ; Footerfields[3].Total:=0;Footerfields[3].Iscurrency:=True;Footerfields[3].Calctype:=fctSum;
    CalcnShowGridFooter(grdInvoices , QryInvoices ,Footerfields  );
  finally
    Finalize(Footerfields);
  end;
end;

Procedure TRepairsGUI.GrdPartsCalcTitleAttributes(Sender: TObject; Const AFieldName: String; Const AFont: TFont; Const ABrush: TBrush; Var ATitleAlignment: TAlignment);
Begin
  Inherited;
  If (AFieldName = 'PriceEx') Or (AFieldName = 'LineTotalEx') Or (AFieldName = 'PriceInc') Or (AFieldName = 'calcTotalInc') Or (AFieldName = 'Discount') Or (AfieldName = 'Markup') Or
    (AFieldName = 'DiscountPercent') Or (AfieldName = 'MarkupPercent') Then ABrush.Color := ClBtnFace;
  With TPartCalcFormula.Create(Self) Do
    Try GridCalcTitleAttributes(Sender, AFieldName, AFont, ABrush, ATitleAlignment (* , QtySoldColor,QtyshippedColor *) );
    Finally Free;
    End;
  if Sametext(AFieldName , tblrepairpartsSerialNo.FieldName) or
      Sametext(AFieldName , tblrepairpartsManucature.FieldName) or
      Sametext(AFieldName , tblrepairpartsModel.FieldName) or
      Sametext(AFieldName , tblrepairpartsRegistration.FieldName) then
        AFont.Color := clInactiveCaption;
End;

procedure TRepairsGUI.grdPartsColEnter(Sender: TObject);
begin
  inherited;
  if Sametext(grdParts.GetActiveField.FieldName , TblrepairpartsTaxCode.FieldName) then GrdParts.ColumnByName('Taxcode').Readonly       := True;
  if Sametext(grdParts.GetActiveField.FieldName , TblrepairpartsCalcTax.FieldName) then GrdParts.ColumnByName('CalcTax').Readonly       := True;
end;

Procedure TRepairsGUI.GrdPartsTitleButtonClick(Sender: TObject; Const AFieldName: String);
Var
  Ipos: Integer;
Begin
  Inherited;
  GrdParts.SetActiveField(AFieldName);
  IPos := GrdParts.GetActiveCol;
  If (AFieldName = 'PriceEx') Then Begin
    GrdParts.RemoveField('PriceEx');
    GrdParts.AddField('PriceInc', IPos, False);
    TblrepairpartsPriceInc.Index                   := IPos;
    GrdParts.ColumnByName('PriceInc').DisplayLabel := 'Price (Inc)';
    ShowFootervalue;
  End Else If (AFieldName = 'PriceInc') Then Begin
    GrdParts.RemoveField('PriceInc');
    GrdParts.AddField('PriceEx', IPos, False);
    TblrepairpartsPriceEx.Index                   := IPos;
    GrdParts.ColumnByName('PriceEx').DisplayLabel := 'Price (Ex)';
    ShowFootervalue;
  End Else If (AFieldName = 'LineTotalEx') Then Begin
    GrdParts.RemoveField('LineTotalEx');
    GrdParts.AddField('calcTotalInc', IPos, False);
    TblrepairpartscalcTotalInc.Index                   := IPos;
    GrdParts.ColumnByName('calcTotalInc').DisplayLabel := 'Amount (Inc)';
    GrdParts.ColumnByName('calcTotalInc').ReadOnly:= TRue;
    ShowFootervalue;
  End Else If (AFieldName = 'calcTotalInc') Then Begin
    GrdParts.RemoveField('calcTotalInc');
    GrdParts.AddField('LineTotalEx', IPos, False);
    TblrepairpartsLineTotalEx.Index                   := IPos;
    GrdParts.ColumnByName('LineTotalEx').DisplayLabel := 'Amount (Ex)';
    GrdParts.ColumnByName('LineTotalEx').ReadOnly:= TRue;
    ShowFootervalue;
  End Else If (AFieldName = 'Discount') Or (AFieldName = 'Markup') Or (AFieldName = 'DiscountPercent') Or (AFieldName = 'MarkupPercent') Then PopDscntMrkup.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  GrdParts.Invalidate;
End;

Procedure TRepairsGUI.MnuDiscountDollarClick(Sender: TObject);
Var
  IPos: Integer;
Begin
  Inherited;
  IPos := GrdParts.GetActiveCol;
  If GrdParts.SelectedField.FieldName <> 'Discount' Then Begin
    GrdParts.RemoveField(GrdParts.SelectedField.FieldName);
    GrdParts.AddField('Discount', IPos, False);
    TblrepairpartsDiscount.Index                   := IPos;
    GrdParts.ColumnByName('Discount').DisplayLabel := 'Discount ($)';
  End;
End;

Procedure TRepairsGUI.MnuDiscountPercClick(Sender: TObject);
Var
  IPos: Integer;
Begin
  Inherited;
  IPos := GrdParts.GetActiveCol;
  If GrdParts.SelectedField.FieldName <> 'DiscountPercent' Then Begin
    GrdParts.RemoveField(GrdParts.SelectedField.FieldName);
    GrdParts.AddField('DiscountPercent', IPos, False);
    TblrepairpartsDiscountPercent.Index                   := IPos;
    GrdParts.ColumnByName('DiscountPercent').DisplayLabel := 'Discount (%)';
  End;
End;

Procedure TRepairsGUI.MnuMarkupDollarClick(Sender: TObject);
Var
  IPos: Integer;
Begin
  Inherited;
  IPos := GrdParts.GetActiveCol;
  If GrdParts.SelectedField.FieldName <> 'Markup' Then Begin
    GrdParts.RemoveField(GrdParts.SelectedField.FieldName);
    GrdParts.AddField('Markup', IPos, False);
    TblrepairpartsMarkup.Index                   := IPos;
    GrdParts.ColumnByName('Markup').DisplayLabel := 'Markup ($)';
  End;
End;

Procedure TRepairsGUI.MnuMarkupPercClick(Sender: TObject);
Var
  IPos: Integer;
Begin
  Inherited;
  IPos := GrdParts.GetActiveCol;
  If GrdParts.SelectedField.FieldName <> 'MarkupPercent' Then Begin
    GrdParts.RemoveField(GrdParts.SelectedField.FieldName);
    GrdParts.AddField('MarkupPercent', IPos, False);
    TblrepairpartsMarkupPercent.Index                   := IPos;
    GrdParts.ColumnByName('MarkupPercent').DisplayLabel := 'Markup (%)';
  End;
End;

Procedure TRepairsGUI.BtnDeletePartsClick(Sender: TObject);
Var
  IsFiltered: Boolean;
  Fid       : Integer;
Begin
  Inherited;
  if accesslevel >2 then exit;
  If RepairsObj.RepairParts.Count > 0 Then Begin
    If CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', MtConfirmation, MbYesNoCancel, 0) = MrYes Then Begin
      IsFiltered := RepairsObj.RepairParts.Dataset.Filtered;
      RepairsObj.RepairParts.Dataset.DisableControls;
      Try
        FId                                     := RepairsObj.RepairParts.ID;
        RepairsObj.RepairParts.Dataset.Filtered := False;
        RepairsObj.RepairParts.Dataset.Locate('RepairPartsID', FId, []);
        RepairsObj.RepairParts.Deleted := True;
        If RepairsObj.RepairParts.Count > 0 Then RepairsObj.RepairParts.PostDB;
      Finally
        RepairsObj.RepairParts.Dataset.Filtered := IsFiltered;
        RepairsObj.RepairParts.Dataset.EnableControls;
      End;
    End;
  End;
End;

procedure TRepairsGUI.btnEmailClick(Sender: TObject);
begin
  if not HasToAndIsApproved then exit;
  inherited;

end;

Procedure TRepairsGUI.LoadTemplate(Const BPrint, BSave: Boolean; Const DoClose: Boolean = True; Const FileName: String = '');
Var
  SSQL: String;
Begin
  ReportToPrint := '';

  If ChkChooseTemplate.Checked Then Begin
    LoadReportTypes;

    If DlgReportSelect.Execute Then ReportToPrint := DlgReportSelect.SelectedItems.Text;
  End;
  If Empty(ReportToPrint) Then Begin
    SSQL := Format('AND R.RepairID = %d', [TblMasterRepairID.AsInteger]);
    PrintTemplateReport('RepairJob', SSQL, Not AppEnv.Employee.ShowPreview, 1)
  End Else Begin
    SSQL := Format('AND R.RepairID = %d', [TblMasterRepairID.AsInteger]);
    PrintTemplateReport(ReportToPrint, SSQL, Not AppEnv.Employee.ShowPreview, 1);
  End;
End;

Procedure TRepairsGUI.ActInvoiceUpdate(Sender: TObject);
Begin
  ActInvoice.Enabled := ((RepairsOBJ.RepairParts.Count > 0) Or ((RepairsOBJ.TimesheetEntry.Count > 0) And (RepairsOBJ.TimesheetEntry.Timesheet.Count > 0))) And (RepairsOBJ.ClientID > 0) And
    (Accesslevel = 1);
  if not (ActInvoice.Enabled ) then begin
         if AccessLevel <> 1 then Showcontrolhint(btnInvoice, 'You don''t have enough access to convert into Invoice'+NL)
    else if RepairsOBJ.ClientID =0 then Showcontrolhint(btnInvoice,'Customer is not Selected'+NL)
    else if ((RepairsOBJ.RepairParts.Count = 0) and  ((RepairsOBJ.TimesheetEntry.Count = 0) or (RepairsOBJ.TimesheetEntry.Timesheet.Count = 0))) then Showcontrolhint(btnInvoice,'This repair doesn''t have any product or timesheet entries'+NL);
  end;
End;
function TRepairsGUI.HasToAndIsApproved:Boolean;
begin
  REsult:= False;
  if Appenv.CompanyPrefs.RepairStatustoMakeInvoice<>'' then
    if not sametext(RepairsOBJ.Status , appenv.CompanyPrefs.RepairStatustoMakeInvoice) then begin
      MessageDlgXP_Vista('As per the preferences, the repair has to have status '+quotedstr(appenv.CompanyPrefs.RepairStatustoMakeInvoice) +' to Invoice / Print / Email  and it is not approved.'+NL+
                          'Please change the status to ' + quotedstr(appenv.CompanyPrefs.RepairStatustoMakeInvoice) +' to be able to invoice.', MtWarning, [MbOK], 0);
      Exit;
    end;
  REsult:= True;
end;
function TRepairsGUI.HastoAndIsallPOREceived (Const StatusChangeEvent:String; ShowMessage :Boolean = True):Boolean;
begin
  REsult:= True;
  if QryPOs.recordcount = 0 then Exit;
  QryPOs.filter := 'Qty > shipped';
  QryPOs.Filtered :=  true;
  try
      if QryPOs.recordcount = 0 then Exit;
      if QryPOs.recordcount > 0 then begin
        if ShowMessage then begin
            InitMsgParams;
            PopupMsgParams.HideinGridwhen0:=true;
            PopupMsgParams.Msgcaption     := 'Repairs : Invoicing confirmation';
            PopupMsgParams.Msgds          := QryPOs;
            PopupMsgParams.fieldnames     := 'SmartOrderId,PARTSNAME,Qty,shipped,BOQty,toOrder';
            PopupMsgParams.displayLabels  := '"Smart Order #","Product name","Smart Order Qty",Received,"Back Order","Qty to be Ordered"';
            PopupMsgParams.MsgWidth       := 700;
            PopupMsgParams.MsgHeight      := 400;
            PopupMsgParams.Displaywidths  := '100,160,100,100,100,110';
            PopupMsgParams.Custombuttons  := 'Yes,No';
            PopupMsgParams.Msg1           := 'List of products outstanding to be received';
            PopupMsgParams.Msg2           := 'Would you like to ' + StatusChangeEvent +' with these product(s) outstanding?';
            PopupMsgParams.MsgColor       := Self.Color;
            result                        := TfmMessageWithList.MsgDlg = 100;
        end else begin
          Result := False;
        end;
      end;
  finally
    QryPOs.Filtered := False;
    QryPOs.Filter:= '';
  end;

end;
Procedure TRepairsGUI.ActInvoiceExecute(Sender: TObject);
Var
  Str: String;
  newFilter : string;
  OldFilter : string;
  Restore : boolean;
  OldFiltered : boolean;
  nProducts,
  cProducts : integer;
  Res : integer;
Begin
  fsSalesFormName :='TInvoiceGUI';
  fsSalesType :='Invoice''s';
  try
    ProcessingCursor;
    Try
      OldFiltered := false;
      Restore := false;
      If Not SaveRepair (*RepairsOBJ.Save*) Then Exit;

      if not HasToAndIsApproved then exit;

      //if not HastoAndIsallPOREceived('invoice the repairs') then exit;

      if Appenv.CompanyPrefs.IsSalesCategoryMandatory then
        While TSalesCategory.DefaultTypeName = '' do
          if MessageDlgXP_Vista('''Sales Category'' is a Mandatory Field for Invoice, Sales Order and Quote and you don''t have a ''Default'' Sales Category created. Would you like to Create a Default Sales Category?', mtConfirmation, [mbYes, mbNo], 0) = mrno then Exit
          else TfmSimpleTypes.DoSimpleTypesSelect(SimpleTypes_SalesCategory);

      If RepairsOBJ.Converted Then
        If AppEnv.AccessLevels.GetEmployeeAccessLevel('FnMakeduplicateInvoiceForrepair') <> 1 Then
        Begin
          MessageDlgXP_Vista('Invoice is already created for this repair. You don''t have access to create a duplicate Invoice for the repair', MtWarning, [MbOK], 0);
          Exit;
        End;

      If RepairsOBJ.Converted Then
      begin
        OldFilter := tblRepairParts.Filter;
        OldFiltered := tblRepairParts.Filtered;
        tblRepairParts.Filtered := false;
        nProducts := tblRepairParts.RecordCount;
        if OldFilter <> '' then
          tblRepairParts.Filter := '(' + OldFilter + ') AND (ConvertToInvoice=''T'')'
        else
          tblRepairParts.Filter := 'ConvertToInvoice=''T''';
        tblRepairParts.Filtered := true;
        cProducts := tblRepairParts.RecordCount;
        tblRepairParts.Filtered := false;
        tblRepairParts.Filter := OldFilter;
        tblRepairParts.Filtered := OldFiltered;
        if cProducts=nProducts then  // all products converted
        begin
          Str := 'This Repair is Already Converted.' + Chr(13) + 'Are you sure you want to convert it again?';
          If CommonLib.MessageDlgXP_Vista(Str, MtConfirmation, [MbYes, MbNo], 0) = MrNo Then
            Exit;
        end
        else
        begin
          Str := Format('%d of %d Products Have Already Been Converted.'#13#10'Do You Want to Convert All Products Again'#13#10+
                        'or Just the Products Not Yet Converted?',[cProducts, nProducts]);
  //        Res := CommonLib.MessageDlgXP_Vista(Str, MtConfirmation, [mbYes, mbAll, mbCancel], 0);
  //        Res := CommonLib.MessageDlgXPEx(Str, mtConfirmation, [mbYes, mbNo, mbCancel],          ['Rest', 'All', 'Cancel']);
            Res := CommonLib.MessageDlgXP_Vista(Str, mtConfirmation, [],  0, nil, '' , '' , False, nil, 'Rest,All,Cancel');
          if res=102 then
            Exit;
          if res=100 then
          begin  // only non-converted
            Restore := true;
            if OldFiltered then
              NewFilter := '(' + OldFilter + ') AND (ConvertToInvoice=''F'')'
            else
              NewFilter := 'ConvertToInvoice=''F''';
            tblRepairParts.Filtered := false;
            tblRepairParts.Filter := NewFilter;
            tblRepairParts.Filtered := true;
          end;
        end;
      end
      Else
      begin
        Str := 'Are you sure you want to convert this Repair to an Invoice?';
        If CommonLib.MessageDlgXP_Vista(Str, MtConfirmation, [MbYes, MbNo], 0) = MrNo Then
          Exit;
      end;

      RepairsOBJ.Connection.CommitTransaction;

      if not(InventoryVarify) then exit;

      SaleIDs := RepairsObj.CopyRepairtoSales(TInvoice.Classname);

      if Restore then
      begin
        tblRepairParts.Filtered := false;
        tblRepairParts.Filter := OldFilter;
        tblRepairParts.Filtered := OldFiltered;
      end;

      If SaleIDs <> '' Then
      begin
        TAudit.AddEntry('Main', RepairsOBJ.Globalref, 'Invoice(s) Created - ID(s) :  ' + SaleIDs, NIL, RepairsOBJ.XMLNodeName, TERPConnection(RepairsOBJ.Connection.Connection), RepairsOBJ.CleanID =0 );
        EmailInvoiced;
      end;
      { form will only be shown for a single id }
      If (SaleIDs <> '') And (Pos(',', SaleIDs) = 0) Then
        Self.CloseWait;
    Finally
      ProcessingCursor(False);
    End;
  finally
    fsSalesFormName :='';
    fsSalesType :='';
  end;
End;

Procedure TRepairsGUI.DivertComboDblClick(Sender: TObject);
Var
  TmpComponent: TComponent;
Begin
  If Sender Is TwwDBLookupCombo Then Begin
    If TwwDBLookupCombo(Sender).Name = 'cboProductR' Then Begin
      If Not FormStillOpen('TProductListGUI') Then Begin
        TmpComponent := GetComponentByClassName('TProductListGUI');
        If Not Assigned(TmpComponent) Then Exit;
        TProductListGUI(TmpComponent).FormStyle := FsMDIChild;
      End Else Begin
        TProductListGUI(FindExistingComponent('TProductListGUI')).Show;
      End;
    End;
  End;
End;

procedure TRepairsGUI.txtNotesDblClick(Sender: TObject);
begin
  OpenERPListFormSingleselectModal('TCommentsListGUI' , UpdateNotes, nil);
end;


procedure TRepairsGUI.UpdateNotes(Sender:TwwDbGrid);
begin
  if Sender.Datasource.dataset.findfield('Comments') <> nil then begin
   RepairsOBJ.EditDB;
   txtNotes.Lines.Add(Sender.Datasource.dataset.FieldByName('Comments').AsString);
   RepairsOBJ.PostDB;
  end;
end;

Procedure TRepairsGUI.CboProductRCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Modified = False Then Exit;
  Inherited;
  RefreshUnitsQry;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
  RepairsOBJ.RepairParts.ProductID                      := Lookuptable.Fieldbyname('partsID').AsInteger;
  RepairsOBJ.RepairParts.PostDB;
  TfmAllocation.DoBinBatchform(RepairsOBJ.RepairParts.PQA, Self, AccessLevel = 5);
End;

Procedure TRepairsGUI.GrdPartsExit(Sender: TObject);
Begin
  Inherited;
  RepairsObj.RepairParts.EditDB;
  RepairsObj.RepairParts.PostDB;
  MnuProductStatus.Visible := False;
End;

Procedure TRepairsGUI.GrdPartsKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
  Inherited;
  If ((SameText(ActiveField(Sender).FieldName, 'MatrixDesc')) Or (SameText(ActiveField(Sender).FieldName, 'MatrixPrice'))) And (Key <> Vk_return) And (Key <> Vk_tab) Then Begin
    Key := 0;
  End;
End;

procedure TRepairsGUI.grdPartsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = vk_f9)  then begin
    mnuAlternateProduct.click;
    Exit;
  end;
  inherited;

end;

Procedure TRepairsGUI.ChkUseBillCustClick(Sender: TObject);
(*Var
  Ctr: Integer;*)
Begin
  (*PnlBillDetails.Enabled                                                                                := ChkUseBillCust.Checked;
  For Ctr                                                                                               := 0 To PnlBillDetails.ComponentCount - 1 Do
    If PnlBillDetails.Components[Ctr] Is Tcontrol Then Tcontrol(PnlBillDetails.Components[Ctr]).Enabled := ChkUseBillCust.Checked;*)
  BillClientName.Enabled         := ChkUseBillCust.Checked;
  BillToCustomerDetails.Enabled  := ChkUseBillCust.Checked;
  edtPhone.Enabled               := ChkUseBillCust.Checked;
  DBEdit2.Enabled                := ChkUseBillCust.Checked;
  DBEdit4.Enabled                := ChkUseBillCust.Checked;
End;

Procedure TRepairsGUI.BillClientNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Modified = False Then Exit;
  Inherited;
  Repairsobj.BillClientID          := QryClientInvoicetoLookupClientID.AsInteger;
  Repairsobj.Billtocustomerdetails := ClientDetails(QryClientInvoicetoLookup, True);
  Repairsobj.BillPhone             := QryClientInvoicetoLookupPhone.AsString;
  Repairsobj.BillAltphone          := QryClientInvoicetoLookupaltPhone.AsString;
  Repairsobj.Billmobile            := QryClientInvoicetoLookupmobile.AsString;
  Repairsobj.BillFax               := QryClientInvoicetoLookupFaxNumber.AsString;
End;


Procedure TRepairsGUI.FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Var
  CThisKey: Char;
  (* ProductName :String; *)
  // bStartsWith:Boolean;
Begin

  If Appcontext['Calenderform'].VarExists('showing') Then
    If Appcontext['Calenderform'].Varbyname['showing'] = 'T' Then Begin
      Key := 0;
      Exit;
    End;

  If (Key = VK_F8) And (TabCtl20.ActivePage = TabEquipment) Then Begin
    If Not RepairsOBJ.UserLock.Lock('tblClients', RepairsOBJ.ClientID, RepairsOBJ.LockGroupName) Then Begin
      CommonLib.MessageDlgXP_Vista(StringReplace(RepairsOBJ.USerlock.LockMessage, 'Unable to update data.', 'Equipment reference cannot be created for the selected client', [RfIgnoreCase]),
        MtInformation, [Mbok], 0);
      Exit;
    End;
    Try
      TEquipmentListforxRefGUI.EquipmentListForxRef(RepairsOBJ.ClientId, EquipmentxRefForm.RefreshEquipmentLookup, RepairsOBJ.RepairEquipment);
    Finally
      RepairsOBJ.UserLock.UnLock('tblClients', RepairsOBJ.ClientID, RepairsOBJ.LockGroupName);
    End;
  End
  Else If (Key = VK_F8) And (TabCtl20.ActivePage = TabFollowupnProducts) Then Begin
    OpenErpListform('TClientEquipmentlist');
  End Else Begin
    Inherited;

    // if (Key =vK_F9) or ((Key = 192) and (not (ssAlt in Shift)) ) then begin
    If (Key = VK_F9) Then Begin
      TabCtl20.ActivePage := TTabSheet(TabFollowupnProducts);
      (* if (Key = 192) and (not (ssAlt in Shift)) then begin // ~ key
        IF RepairsOBJ.RepairParts.ProductID<> 0 then RepairsOBJ.RepairParts.New;
        RepairsOBJ.RepairParts.ProductId := TfmBarcodePopUp.GetProductID('', ProductName);
        end; *)
      Key := 0;
      Exit;
    End;
    If Shift = [SsCtrl] Then Begin
      CThisKey := Chr(Key);
      If CThisKey = 'F' Then Begin
        //TabCtl20.ActivePageIndex := 0;
        Mainbuttonclick(findbutton(0));
        TabCtl20Change(Sender);
        Key := 0;
        Exit;
      End;
      If CThisKey = 'E' Then Begin
        //TabCtl20.ActivePageIndex := 1;
        Mainbuttonclick(findbutton(1));
        TabCtl20Change(Sender);
        Key := 0;
        Exit;
      End;
    End;
  End;
End;

Procedure TRepairsGUI.GrdOtherFollowUpExit(Sender: TObject);
Begin
  Inherited;
  Editdb(GrdOtherFollowUp.DataSource.DataSet);
  PostDB(GrdOtherFollowUp.DataSource.DataSet);
End;

Procedure TRepairsGUI.QryClientLookupCalcFields(DataSet: TDataSet);
Begin
  Inherited;
  If QryClientLookupStopCredit.AsString = 'T' Then QryClientLookupStopCreditImage.AsInteger := 0
  Else QryClientLookupStopCreditImage.AsInteger                                             := 1;
End;

Procedure TRepairsGUI.TABCTL20Change(Sender: TObject);
Begin
  Inherited;
  If (TabCtl20.ActivePage = TTabSheet(Custom_Fields)) Then Begin
    CustomFieldsRefresh;
  End
  Else If (TabCtl20.ActivePage = TTabSheet(TabExtrainfo)) Then Begin
    If EquipmentTabshown = False Then Begin
      ShowEquipform;
    End;
    If RepairsOBJ.DetailsExported Then LblDetailsExportedStatus.Caption := 'Already Exported'
    Else LblDetailsExportedStatus.Caption                               := 'Not Exported';
    If (RepairsOBJ.RepairDetails.Count = 0) And (RepairsOBJ.RepairDetails.Dataset.State = DsBrowse) Then RepairsOBJ.RepairDetails.New;
    QryRetailer.Locate('clientID', Repairsobj.RepairDetails.RetailerID, []);
  End
  Else If (TabCtl20.ActivePage = TTabSheet(TabTimesheetEntries)) Then Begin
    RepairsOBJ.PostDB;
    RepairsOBJ.ResultStatus.Clear;
    If RepairsOBJ.ID = 0 Then Exit;
    If Not Assigned(TimeSheetForm) Then Begin
      TimeSheetForm := TfrmTimeSheet.Createtimesheet(Self, RepairsObj.TimesheetEntry, 'Repair', RepairsObj.ID, AccessLevel = 5, '');
      If Assigned(TimeSheetForm) Then Begin
        TimeSheetForm.Pnlfooter.Visible := False;
        TimeSheetForm.Pnlheader.Visible := False;
        TimeSheetForm.Parent            := PnlTimesheetEntries;
        TimeSheetForm.BorderStyle       := Bsnone;
        TimeSheetForm.Align             := Alclient;
        RepairsOBJ.NewTimesheetEntry;
        TimeSheetForm.KeyId := RepairsOBJ.Timesheetentry.ID;
        TimeSheetForm.Show;
        TimeSheetForm.grdTimesheets.Align := alNone;
        TimeSheetForm.grdTimesheets.Align := alClient;
      End;
    End Else Begin
      Closedb(TimeSheetForm.Qryrepairequip);
      Opendb(TimeSheetForm.Qryrepairequip);
    End;
  End
  Else If (TabCtl20.ActivePage = TTabSheet(TabEquipment)) Then Begin
    ShowEquipform;
  End  Else If (TabCtl20.ActivePage = tabInvoices) then begin
    ShowInvoicefooters;
  End;
End;

Procedure TRepairsGUI.FormResize(Sender: TObject);
(* var
  i, iCnt: integer; *)
Begin
  Inherited;
  If Not RealignTabInProgress Then Begin
    (*RealignTabInProgress := True;
    If Not Self.IsFlag('FormInitialising') Then RealignTabControl(TabCtl20, 1);
    If TabCtl20.TabWidth > 130 Then TabCtl20.TabWidth := TabCtl20.TabWidth - 1;
    RealignTabInProgress                                      := False;*)

    (*LblInvoices.Left    := TabCtl20.Tabwidth * TabInvoices.Tabindex;
    LblAppointment.Left := TabCtl20.Tabwidth * Tabappointment.Tabindex;
    LblsmartOrders.Left := TabCtl20.Tabwidth * TabSmartOrders.Tabindex;
    Lblbills.Left       := TabCtl20.Tabwidth * TabBills.Tabindex;
    LblRAs.Left         := TabCtl20.Tabwidth * TabRa.Tabindex;
    LblSalesOrders.Left := TabCtl20.Tabwidth * TabSalesorders.Tabindex;

    LblAppointment.Top := LblInvoices.Top;
    LblsmartOrders.Top := LblInvoices.Top;
    Lblbills.Top       := LblInvoices.Top;
    LblRAs.Top         := LblInvoices.Top;
    LblSalesOrders.Top := LblInvoices.Top;

    LblsmartOrders.Width := TabCtl20.Tabwidth;
    LblInvoices.Width    := TabCtl20.Tabwidth;
    LblAppointment.Width := TabCtl20.Tabwidth;
    LblBills.Width       := TabCtl20.Tabwidth;
    LblRAs.Width         := TabCtl20.Tabwidth;
    LblSalesOrders.Width := TabCtl20.Tabwidth;*)
  End;

  (* iCnt := 0;
    for i := 0 to TabCtl20.PageCount - 1 do begin
    if TabCtl20.Pages[i].TabVisible then begin
    Inc(iCnt);
    end;
    end;
    TabCtl20.TabWidth := Abs((TabCtl20.Width - 4) div iCnt); *)
End;

Procedure TRepairsGUI.FormDestroy(Sender: TObject);
Begin
  Freeandnil(CustomfieldonGrid);
  Inherited;
  FreeAndNil(FMsgHandler);
  Freeandnil(EquipmentxRefForm);
End;

Procedure TRepairsGUI.CboClassRepairPartsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Modified = False Then Exit;
  Inherited;
  If CboClassrepairParts.Text = '' Then Exit;
  EditDB(FillTable);
  FillTable.FieldByName('ClassID').AsInteger := QryClass.FieldByName('ClassID').AsInteger;
End;

Procedure TRepairsGUI.BtnSmartOrderClick(Sender: TObject);
Var
  IKeyID: Integer;
  Frm   : TSmartOrderGUI;

Begin
  If Not SaveRepair (*RepairsOBJ.Save*) Then
    Exit;
  If Not RepairsOBJ.HasInvProducts Then begin
    MessageDlgXP_vista('The Repair doesn''t have any inventory Product(s) selected', mtInformation, [mbOK], 0);
    Exit;
  end;

  If QrySmartOrderHeader.Recordcount > 0 Then
  Begin
    LblsmartOrdersClick(LblsmartOrders);
    If CommonLib.MessageDlgXP_Vista(IntToStr(QrySmartOrderHeader.Recordcount) + ' Smart Order(s) Already Created for This Repair.  Do you Wish To Create Another Smart Order?', MtConfirmation,
      [Mbyes, Mbno], 0) = Mrno Then
      Exit;
  End
  Else If CommonLib.MessageDlgXP_Vista('Are You Sure You Want To Create a SmartOrder for this Repair?', MtConfirmation, [Mbyes, Mbno], 0) = Mrno Then
    Exit;
  If Not Repairsobj.HasInvProducts Then
  Begin
    CommonLib.MessageDlgXP_Vista('Smart Otder Cannot be Created for Repairs # ' + IntToStr(Repairsobj.ID) + ' as it Doesn''t Have Any Inventory Product', MtInformation, [MbOk], 0);
    Exit;
  End;

  If Repairsobj.HasnonInvProducts Then
    CommonLib.MessageDlgXP_Vista('Products that are of Type ' + QuotedStr('Other') + ' will not be copied to the Smart Order', MtInformation, [MbOk], 0);

  IKeyID := RepairsOBJ.CopyRepairToSmartOrder(Sametext(GrdParts.GetActiveField.FieldName, 'Equipment'));
  If IKeyID <> 0 Then
  begin
    TAudit.AddEntry('Main', RepairsOBJ.Globalref, 'Smart Order Created - ID :' + Inttostr(IKeyID), NIL, RepairsOBJ.XMLNodeName, TERPConnection(RepairsOBJ.Connection.Connection),RepairsOBJ.CleanId=0);
    tblRepairParts.Close;
    tblRepairParts.Open;
  end;
  If RepairsOBJ.POIDs <> '' Then
  Begin
    ShowPO(RepairsOBJ.POIDs);
  End
  Else If IKeyID <> 0 Then
  Begin
    If CommonLib.MessageDlgXP_Vista('Do you Wish to View the Smart Order?', Mtconfirmation, [Mbyes, Mbno], 0) = Mrno Then Exit;
    Frm           := TSmartOrderGUI(GetComponentByClassName('TSmartOrderGUI'));
    Frm.KeyId     := IKeyID;
    Frm.FormStyle := FsMDIChild;
    Frm.BringToFront;
    Frm.POIDs := RepairsOBJ.POIDs;
  End;
End;

procedure TRepairsGUI.btnTotalAmountClick(Sender: TObject);
begin
  inherited;
  ShowTotalAmountInc := not ShowTotalAmountInc;
end;

procedure TRepairsGUI.btnTotalCostClick(Sender: TObject);
begin
  inherited;
  ShowTotalCostInc := not (ShowTotalCostInc);
end;

Procedure TRepairsGUI.ActRepeatUpdate(Sender: TObject);
Begin
  Inherited;
  If (KeyID = 0) Then Begin
    BtnRepeat.Enabled := False;
    CbDone.Enabled    := False;
  End Else Begin
    BtnRepeat.Enabled := True;
    CbDone.Enabled    := True;
  End;
End;

procedure TRepairsGUI.actSignatureExecute(Sender: TObject);
begin
  if frmSignatureEdit.GetClientSignature(self.tblMasterSignature, tblMasterSignatureTime) then
    self.RepairsOBJ.Dirty := true;
end;

procedure TRepairsGUI.actSignatureUpdate(Sender: TObject);
begin
  inherited;
  if self.tblMasterSignature.BlobSize > 0 then
    btnSignature.Color := $0077ff77
  else
    btnSignature.Color := clBtnFace;
end;

procedure TRepairsGUI.SetShowTotalAmountInc(const Value: boolean);
begin
  if fShowTotalAmountInc  = Value then exit;
  fShowTotalAmountInc := Value;
  SetTotalButtonCaptions(fShowTotalCostInc, Value , fshowTotalInvAmountInc);
  CalcTotal;
end;

procedure TRepairsGUI.SetshowTotalInvAmountInc(const Value: boolean);
begin
  if fshowTotalInvAmountInc = Value then exit;
  fshowTotalInvAmountInc := Value;
  SetTotalButtonCaptions(fShowTotalCostInc, fShowTotalAmountInc, Value);
  CalcTotal;
end;

procedure TRepairsGUI.SetShowTotalCost(const Value: boolean);
begin
  if Value = fShowTotalCostInc then exit;
  fShowTotalCostInc := Value;
  SetTotalButtonCaptions(Value, fShowTotalAmountInc , fshowTotalInvAmountInc);
  CalcTotal;
end;

Procedure TRepairsGUI.SetStateParams(Const Value: TJsonObject);
Begin
  Inherited;
  If Not Assigned(Value) Then Exit;
  Try
    If Value.Count > 0 Then //TabCtl20.ActivePageIndex := Value.I['TabControlActivePageIndex'];
      Mainbuttonclick(findbutton(Value.I['TabControlActivePageIndex']));
  Except
    // if TabControlActivePageIndex is not set then ignore the exception
  End;
End;

procedure TRepairsGUI.SetTotalButtonCaptions(aShowTotalCostInc, aShowTotalAmountInc , ashowTotalInvAmountInc: boolean);
begin
  if aShowTotalCostInc      then    btnTotalCost.Caption          := 'Total Cost (Inc)'         else   btnTotalCost.Caption         := 'Total Cost (Ex)';
  if aShowTotalAmountInc    then    btnTotalAmount.Caption        := 'Total Amount (Inc)'       else   btnTotalAmount.Caption       := 'Total Amount (Ex)';
  if ashowTotalInvAmountInc then    btnShowTotalAmountInc.Caption := 'Total Invoiced Amt (Inc)' else   btnShowTotalAmountInc.Caption:= 'Total Invoiced Amt (Ex)';
end;

Procedure TRepairsGUI.ShowAttachments(fbDragnDropping :Boolean);
Var
  Frm: TComponent;
Begin
  If RepairsObj.ID < 1 Then Exit;
  Frm := GetComponentByClassName('TfmAttachments', True, Self, True, True, RepairsObj.ID);
  If Assigned(Frm) Then Begin
    With TfmAttachments(Frm) Do Begin
      DBConnection := Self.MyConnection;
      AttachObserver(Self);
      TableName := 'tblRepairs';
      TableId   := RepairsObj.ID;
      Tag       := RepairsObj.ID;
      DragnDropping :=fbDragnDropping;
      FormStyle := FsMDIChild;
      BringToFront;
    End;
  End;
End;

Procedure TRepairsGUI.DMTextTargetRepairsDrop(Sender: TObject; Acceptor: TWinControl; Const DropText: String; X, Y: Integer);
Var
  Frm: TComponent;
Begin
  Inherited;
  If RepairsObj.ID < 1 Then Exit;
  ShowAttachments(true);
  Frm := FindExistingComponent('TfmAttachments', RepairsObj.ID);
  If Assigned(Frm) Then TfmAttachments(Frm).DMTextTargetDrop(Sender, Acceptor, DropText, X, Y);
End;

Procedure TRepairsGUI.BtnAttachmentsClick(Sender: TObject);
Begin
  Inherited;
  ShowAttachments(False);
End;

Procedure TRepairsGUI.BtnBillClick(Sender: TObject);
Begin
  Inherited;
  If Not SaveRepair (*RepairsOBJ.Save*) Then Exit;
  If MessageDlgXP_Vista('This will Commit the Changes to Create Bill. Do You Wish to Continue?', Mtconfirmation, [Mbyes, Mbno], 0) = MrNo Then Exit;
  RepairsOBJ.Connection.CommitTransaction;
  OpenERPForm('TBillGUI', 0, Nil, AssignRepairID4Bill);
  Self.CloseWait;
End;

Procedure TRepairsGUI.AssignRepairID4Bill(Sender: TObject);
Begin
  If Not(Sender Is TBillGUI) Then Exit;
  TBillGUI(Sender).RepairId := RepairsOBJ.ID;
  TBillGUI(Sender).Area  := RepairsOBJ.Area;
  AfterSubFormShow(Sender);
End;

//Procedure TRepairsGUI.CheckForAttachments;
//Var
//  Qry: TERPQuery;
//Begin
//  If RepairsObj.Id < 1 Then Begin
//    BtnAttachments.Enabled := False;
//    Exit;
//  End;
//  Qry := TERPQuery.Create(Nil);
//  Try
//    Qry.Options.FlatBuffers := True;
//    Qry.Connection          := MyConnection;
//    Qry.SQL.Text            := 'SELECT AttachmentName FROM tblAttachments WHERE TableName = "tblRepairs"' + ' AND TableId = ' + IntToStr(RepairsObj.ID);
//    OpenDB(Qry);
//    BtnAttachments.Enabled := Qry.RecordCount > 0;
//    Closedb(Qry);
//  Finally FreeAndNil(Qry);
//  End;
//End;

Procedure TRepairsGUI.UpdateMe;
Begin
//  CheckForAttachments;
  EditDB(TblMaster);
  TblMastermsTimeStamp.AsDateTime := Now;
End;

Procedure TRepairsGUI.MemTblMasterBeforePost(DataSet: TDataSet);
Begin
  Inherited;
  If DataSet.FieldByName('GlobalREf').AsString = '' Then DataSet.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + DataSet.FieldByName('RepairId').AsString;
End;

{ procedure TRepairsGUI.cboClientJobDblClick(Sender: TObject);
  var
  frmCust: TFrmcustomer;
  begin
  inherited;
  if repairsObj.clientID<> 0 then begin
  FrmCust := TfrmCustomer(GetComponentByClassName('TfrmCustomer', true));
  if Assigned(FrmCust) then begin
  with frmcust do begin
  KeyId := repairsObj.clientID;//qryClientLookup.FieldByName('clientId').AsInteger;
  FormStyle := fsMDIChild;
  BringToFront;
  end;
  end;
  Exit;
  end;
  end;
}
Procedure TRepairsGUI.TABCTL20Enter(Sender: TObject);
Begin
  Inherited;
  if not fbformShown then exit;
  if not fbAddNewRepairnFocustoclientCbo then
    If CboClientJob.Text = '' Then Begin
      CommonLib.MessageDlgXP_Vista('Please select a company before entering the other details', MtWarning, [MbOK], 0);
      SetControlFocus(CboclientJob);
    End;
End;

Procedure TRepairsGUI.BtnAppointmentClick(Sender: TObject);
Begin
  RepairsOBJ.PostDB;
  If RepairsOBJ.Id = 0 Then Exit;
  Self.KeyId := RepairsOBJ.Id;
  AppointmentLib.NewAppointment(RepairsOBJ.ClientID, Self, RepairsOBJ.ID, RepairsOBJ.Notes);
  TAudit.AddEntry('Main', RepairsOBJ.Globalref, 'Appointment Created', NIL, RepairsOBJ.XMLNodeName, TERPConnection(RepairsOBJ.Connection.Connection),RepairsOBJ.CleanId=0);
End;

Procedure TRepairsGUI.CboClientJobEnter(Sender: TObject);
Begin
  Inherited;
  If TblDetails.RecordCount > 0 Then Begin
(*    TabCtl20.ActivePage := TabEquipment;
    If Not(EquipmentTabshown) Then ShowEquipform;
    SetControlFocus(EquipmentxRefForm);*)
    CboclientJob.REadonly := True;
  End;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
End;
procedure TRepairsGUI.initcontactList(Sender: TObject);
begin
  if not(Sender is   TContactListGUI) then exit;
  TContactListGUI(Sender).clientId := tblMaster.FieldByName('CUSID').AsInteger;
end;

procedure TRepairsGUI.actCashSaleExecute(Sender: TObject);
Var
  Str: String;
Begin
  fsSalesFormName :='TCashSaleGUI';
  fsSalesType :='Cash Sale''s';
  try
    ProcessingCursor;
    Try
      If Not SaveRepair (*RepairsOBJ.Save*) Then Exit;

      if not HasToAndIsApproved then exit;

      //if not HastoAndIsallPOREceived('invoice the repairs') then exit;

      if Appenv.CompanyPrefs.IsSalesCategoryMandatory then
        While TSalesCategory.DefaultTypeName = '' do
          if MessageDlgXP_Vista('''Sales Category'' is a Mandatory Field for Invoice, Sales Order and Quote and you don''t have a ''Default'' Sales Category created. Would you like to Create a Default Sales Category?', mtConfirmation, [mbYes, mbNo], 0) = mrno then Exit
          else TfmSimpleTypes.DoSimpleTypesSelect(SimpleTypes_SalesCategory);

      If RepairsOBJ.Converted Then
        If AppEnv.AccessLevels.GetEmployeeAccessLevel('FnMakeduplicateInvoiceForrepair') <> 1 Then Begin
          MessageDlgXP_Vista('Invoice/Cash Sale is already created for this repair. You don''t have access to create a duplicate Invoice/Cash Sale for the repair', MtWarning, [MbOK], 0);
          Exit;
        End;
      If RepairsOBJ.Converted Then Str := 'This Repair is already converted.' + Chr(13) + 'Are you sure you want to convert it again?'
      Else Str                         := 'Are you sure you want to convert this Repair to an Cash Sale?';
      If CommonLib.MessageDlgXP_Vista(Str, MtConfirmation, [MbYes, MbNo], 0) = MrNo Then Exit;

      RepairsOBJ.Connection.CommitTransaction;

      if not(InventoryVarify) then exit;

      SaleIDs := RepairsObj.CopyRepairtoSales(TCashSale.Classname);
      If SaleIDs         <> '' Then TAudit.AddEntry('Main', RepairsOBJ.Globalref, 'Cash Sale(s) Created - ID(s) :  ' + SaleIDs, NIL, RepairsOBJ.XMLNodeName, TERPConnection(RepairsOBJ.Connection.Connection), RepairsOBJ.CleanID =0 );
      { form will only be shown for a single id }
      If (SaleIDs <> '') And (Pos(',', SaleIDs) = 0) Then Self.CloseWait;
    Finally ProcessingCursor(False);
    End;
  finally
    fsSalesFormName :='';
    fsSalesType :='';
  end;
end;

Procedure TRepairsGUI.ActCompanyExecute(Sender: TObject);
begin
  OpenERPListFormSingleselectModal('TContactListGUI' ,UpdateFromContact , initcontactList );
End;

Procedure TRepairsGUI.CmdCustomLabelsOldClick(Sender: TObject);
Begin
  FLastComboAccessed := Nil;
  OpenCustomFields;
  (* var
    frm: TfrmCustomFields;
    begin
    Frm := TfrmCustomFields(GetComponentByClassName('TfrmCustomFields', true));
    with frm do begin
    FormStyle := fsMDIChild;
    AttachObserver(Self);
    BringToFront;
    end; *)
End;

Procedure TRepairsGUI.DsStateChange(Sender: TObject);
Begin
  Inherited;
  With Sender As TDataSource Do Begin
    If State <> DsBrowse Then Begin
      BeginTransaction;

      If Not MyConnection.Intransaction Then MyConnection.StartTransaction;
    End;
  End;
End;

procedure TRepairsGUI.edCustomerPOExit(Sender: TObject);
begin
  inherited;
  if Appenv.CompanyPrefs.EnforceCustPOInrepairbeforeOtherInfo and RepairsOBJ.Customer.ForcePOOnRepair then
    if trim(RepairsOBJ.CustomerPONumber) = '' then begin
      MessageDlgXP_Vista('Customer PO Should not Be Blank and should be entered before Other Data entry', MtWarning, [Mbok], 0);
      Setcontrolfocus(edCustomerPO);
    end;

end;

Procedure TRepairsGUI.UpdateMe(Const Canceled: Boolean; Const AObject: TObject = Nil);
Begin
  Inherited;
  If Canceled Then Begin
    If Assigned(FLastComboAccessed) Then Begin
      FLastComboAccessed.Text := '';
      If Sysutils.SameText(FLastComboAccessed.Name, 'cboProductR') Then Begin
        ClosenOpenDB(FLastComboAccessed.LookupTable);
      End;
    End;
  End
  Else If (Assigned(AObject) And (AObject Is TBaseInputGUI) And Assigned(FLastComboAccessed)) Then Begin
    If Sysutils.SameText(FLastComboAccessed.Name, 'cboProductR') Then Begin
      With FLastComboAccessed Do Begin
        ClosenOpenDB(LookupTable);
        If LookupTable.Locate('PartsId', TBaseInputGUI(AObject).KeyID, []) Then Begin
          If Not(Tblrepairparts.State In [DsEdit, DsInsert]) Then EditDB(Tblrepairparts);
          Tblrepairparts.FieldByName('PartName').AsString := LookupTable.FieldByName('PartName').AsString;
          CboProductRCloseUp(FLastComboAccessed, LookupTable, Tblrepairparts, True);
        End;
      End
    End;

    If Sysutils.SameText(FLastComboAccessed.Name, 'cboRetailer') Then Begin
      With FLastComboAccessed Do Begin
        ClosenOpenDB(LookupTable);
        If LookupTable.Locate('clientID', TBaseInputGUI(AObject).KeyID, []) Then Begin
          If RepairsOBJ.RepairDetails.RetailerID <> LookupTable.FieldByname('clientID').AsInteger Then Begin
            RepairsOBJ.RepairDetails.RetailerID := LookupTable.FieldByname('clientID').AsInteger;
            RepairsOBJ.RepairDetails.Retailer   := Lookuptable.FieldByname('company').AsString;
            FLastComboAccessed.Text             := Lookuptable.FieldByname('company').AsString;
            CboRetailerCloseUp(FLastComboAccessed, LookupTable, FLastComboAccessed.DataSource.DataSet, True);
          End;
        End;
      End
    End;

    If Sysutils.SameText(FLastComboAccessed.Name, 'cboManufacture') Then Begin
      With FLastComboAccessed Do Begin
        ClosenOpenDB(LookupTable);
        If LookupTable.Locate('ID', TBaseInputGUI(AObject).KeyID, []) Then Begin
          If RepairsOBJ.RepairDetails.ManufactureID <> LookupTable.FieldByname('ID').AsInteger Then Begin
            RepairsOBJ.RepairDetails.ManufactureID := LookupTable.FieldByname('ID').AsInteger;
            FLastComboAccessed.Text                := Lookuptable.FieldByname('name').AsString;
            CboManufactureCloseUp(FLastComboAccessed, LookupTable, FLastComboAccessed.DataSource.DataSet, True);
          End
          Else RepairsOBJ.RepairDetails.ReceiptNumberCaption := RepairsOBJ.RepairDetails.ManufactureObj.RepairsExportConfig.ReceiptNumberCaption;
        End;
      End
    End;
    If Sysutils.SameText(FLastComboAccessed.Name, 'cboClientJob') Then Begin
      With FLastComboAccessed Do Begin
        ClosenOpenDB(LookupTable);
        If LookupTable.Locate('ClientID', TBaseInputGUI(AObject).KeyID, []) Then Begin
          RepairsOBJ.ClientID := LookupTable.FieldByname('ClientID').AsInteger;
          CboClientJob.Text   := Lookuptable.FieldByname('company').AsString;
          CboClientJobCloseUp(FLastComboAccessed, LookupTable, FLastComboAccessed.DataSource.DataSet, True);
          TabCtl20.ActivePage := TabMain;
          TabCtl20Change(TabCtl20);
        End;
      End
    End;
  End;
End;

Procedure TRepairsGUI.InsertDateandTime1Click(Sender: TObject);
Begin
  Inherited;
  Repairsobj.EditDB;
  If Screen.Activecontrol = TxtFeedbackNotes Then begin
      TxtFeedbackNotes.text := AddDateTime(lcdOnTimeSheetInvoiceNotes,TxtFeedbackNotes.text, true);
  end Else If Screen.Activecontrol = TxtNotes Then begin
      TxtNotes.text := AddDateTime(lcdOnLoganyway,TxtNotes.text, true);
  end;
  Repairsobj.PostDB;
End;
(*Function TRepairsGUI.AnyclassAutoCreateSmartOrders:Boolean;
begin
  With RepairsObj.getnewDataset('select count(ClassId) as ctr from tblclass where classId in (select ClassID from tblrepairparts where RepairID = ' + inttostr(RepairsObj.ID) +') and AutoCreateSmartOrders ="T"' , true) do try
    result := fieldbyname('ctr').asInteger >0;
  finally
    if active then close;
    Free;
  end;
end;*)
Function TRepairsGUI.InventoryVarify(const ShowMsg:Boolean =False):Boolean;
var
  frm : TfmRepairsInventoryVerify;
  iResult: integer;
  NewSmartOrderID: integer;
begin
      REsult := False;
      if RepairsObj.RepairParts.Count =0 then begin
        if ShowMsg then
          MessageDlgXP_Vista('You haven''t selected any product in this repair', mtWarning, [mbOK], 0);
        result:= True;
        Exit;
      end;
(*      if (AppEnv.Employee.CanAutoCreateSmartOrders =False) and  (AppEnv.Employee.OverrideAutoSmartOrders= False ) and
       (AnyclassAutoCreateSmartOrders= False ) then Exit;*)


      frm := TfmRepairsInventoryVerify(GetComponentByClassName('TfmRepairsInventoryVerify'));
      if Assigned(frm) then begin //if has access
        with frm do begin
          try
            FormStyle := fsNormal;
            Position := poDefault;
            TransLineDataset := Repairsobj.RepairParts.Dataset;
            TransNo := Repairsobj.ID;
            ConvertingFrom := 'Repair';
            SourceClassID := Repairsobj.ClassId;
            SourceCustomerID := Repairsobj.ClientID;
            btncontinue.Enabled := not(ShowMsg);
            iResult := ShowModal;
            if iResult = 3 then Exit
            else begin
              NewSmartOrderID:= SmartOrderID;
              If NewSmartOrderID <> 0  Then begin
                TAudit.AddEntry('Main', RepairsOBJ.Globalref, 'Smart Order Created # :  ' + inttostr(NewSmartOrderID), NIL, RepairsOBJ.XMLNodeName, TERPConnection(RepairsOBJ.Connection.Connection), RepairsOBJ.CleanID =0 );
                OpenERPForm('TSmartOrderGUI' ,NewSmartOrderID);
                Self.BringToFront;
              end;
            end;

            REsult:= True;
          finally
            Free;
          end;
        end;
      end;

end;

procedure TRepairsGUI.lblAllgoodClick(Sender: TObject);
begin
  inherited;
  if sametext(lblAllgood.Caption ,   'N/A' ) then
    MessageDlgXP_Vista('This repair has no Orders to receive goods', mtInformation, [mbOK], 0);

  Mainbuttonclick(findbutton(TabSmartOrders.Pageindex));
  LocateaPOBO;
end;
Procedure TRepairsGUI.LocateaPOBO;
begin
  QrySmartOrders.First;
  while QrySmartOrders.Eof = False do begin
    if QrySmartOrdersBackOrder.AsFloat <> 0 then break;
    QrySmartOrders.Next;
  end;
  grdSmartOrder.SetActiveField('Backorder');
end;
Procedure TRepairsGUI.Addresslist(Sender: TObject);
Begin
  Inherited;
  If AccessLevel >= 5 Then Exit;
  If (Repairsobj.ClientID > 0) Then Begin
    With TShipAddressListGUI.Create(Application) Do Begin
      GrdMain.OnDblClick := GrdMainonDblClick;
//      FilterString       := 'ClientID = ' + IntToStr(Repairsobj.ClientID);
      CustomerID := Repairsobj.ClientID;
      FormStyle := FsMDIChild; // Shows the form in MDIChild mode.
      // the shipping address is returned to this form and processing is continued
      // ..via the onchange event of the invisible editField TEdit control
    End;
  End;
End;

Procedure TRepairsGUI.GrdMainonDblClick(Sender: TObject);
Var
  SText: String;
Begin
  With TwwDbGrid(Sender).Datasource.DataSet Do Begin
    If FieldByName('ContactName').AsString <> '' Then SText    := FieldByName('ContactName').AsString + #13#10
    Else SText                                                 := '';
    SText                                                      := SText + FieldByName('Company Name').AsString;
    If Not Empty(FieldByName('Address').AsString) Then SText   := SText + #13#10 + FieldByName('Address').AsString;
    If Not Empty(FieldByName('Address 2').AsString) Then SText := SText + #13#10 + FieldByName('Address 2').AsString;
    If Not Empty(FieldByName('Address 3').AsString) Then SText := SText + #13#10 + FieldByName('Address 3').AsString;
    If Not Empty(FieldByName('City').AsString) Then SText      := SText + #13#10 + FieldByName('City').AsString;
    If Not Empty(FieldByName('State').AsString) Then SText     := SText + ' ' + FieldByName('State').AsString;
    SText                                                      := SText + ' ' + FieldByName('PostCode').AsString;
    If Not Empty(FieldByName('Country').AsString) Then SText   := SText + #13#10 + FieldByName('Country').AsString;
    Repairsobj.CustomerDetails                                 := SText;
    Repairsobj.ShipToID                                        := FieldByname('ShipAddressID').AsInteger;
    Repairsobj.PostDB;
  End;
  If Assigned(TwwDbGrid(Sender).Owner) Then
    If TwwDbGrid(Sender).Owner Is TForm Then Begin
      SetFocusedControl(TxtClientDetails);
      TForm(TwwDbGrid(Sender).Owner).Close;
    End;

End;

Procedure TRepairsGUI.CboProductRChange(Sender: TObject);
Begin
  Inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
End;

Procedure TRepairsGUI.CompleteComboNotInList(Const AObserver: TObject);
Begin
  If Assigned(FLastComboAccessed) And FLastComboAccessed.Enabled And FLastComboAccessed.Visible Then SetControlFocus(FLastComboAccessed);
  InComboNotinList := False;
End;

Procedure TRepairsGUI.QrybillsAfterOpen(DataSet: TDataSet);
Var
  FdTotEx, FdTotInc, FdTotTax: Double;
Begin
  Inherited;
  Lblbills.Caption := IntToStr(QryBills.Recordcount) (*+ ' Bill(s)'*);
  FdTotEx          := 0;
  FdTotInc         := 0;
  FdTotTax         := 0;
  Try
    If Qrybills.Recordcount > 0 Then Begin
      Qrybills.First;

      While Qrybills.Eof = False Do Begin
        FdTotEx  := FdTotEx + QrybillsTotalLineAmount.AsFloat;
        FdTotInc := FdTotInc + QrybillsTotalLineAmountInc.AsFloat;
        FdTotTax := FdTotTax + QrybillsLineTax.AsFloat;
        Qrybills.Next;
      End;
    End;
  Finally
    GrdBills.Columnbyname('TotalLineAmount').FooterValue    := FloatToStrF(FdTotEx, FfCurrency, 15, CurrencyRoundPlaces);
    GrdBills.Columnbyname('TotalLineAmountInc').FooterValue := FloatToStrF(FdTotInc, FfCurrency, 15, CurrencyRoundPlaces);
    GrdBills.Columnbyname('LineTax').FooterValue            := FloatToStrF(FdTotTax, FfCurrency, 15, CurrencyRoundPlaces);
  End;

End;

Procedure TRepairsGUI.QryClientInvoicetoLookupCalcFields(DataSet: TDataSet);
Begin
  Inherited;
  If QryClientInvoicetoLookupStopCredit.AsString = 'T' Then QryClientInvoicetoLookupStopCreditImage.AsInteger := 0
  Else QryClientInvoicetoLookupStopCreditImage.AsInteger                                                      := 1;
End;

Procedure TRepairsGUI.CboStatusNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
Begin
  // inherited;
  Accept := False;
  If CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', MtConfirmation, [MbYes, MbNo], 0) = MrYes Then Begin
    If TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_StatusType, NewValue) Then Begin
      Accept := True;
      LookupTable.Refresh;
    End;
  End;

  (* var
    strSQL :String;
    begin
    inherited;
    if CommonLib.MessageDlgXP_Vista('This status is not found in the list. Create new one?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then begin
    Accept := false;
    Exit;
    end;
    RepairsObj.status := newValue;
    strSQL := 'INSERT HIGH_PRIORITY INTO tblsimpletypes (Typecode , Name , Active) ' +
    'Values (' + QuotedStr('StatusType') + ',' + QuotedStr(newValue) + ',' + QuotedStr('T') + ')';
    RepairsObj.getnewDataset(strSQL , true); *)
End;

Procedure TRepairsGUI.EdtETADateDblClick(Sender: TObject);
Var
  FrmPopup   : TBaseInputGUI;
Begin
  Inherited;
  If (GrdParts.GetActiveField <> Nil) And (Not Empty(GrdParts.GetActiveField.AsString)) Then Begin
    Processingcursor(True);
    try
      FrmPopup      := TPurchaseGUI(GetComponentByClassName('TPurchaseGUI', True));
      If Assigned(FrmPopup) Then Begin
        With FrmPopup Do Begin
          FrmPopup.KeyID            := TblRepairParts.FieldByName('PurchaseOrderID').AsInteger;
          FrmPopup.CallingClassName := ClassName;
          AttachObserver(Self);
          If Not Visible Then Begin
            FormStyle := FsMDIChild;
          End Else Begin
            OnShow(Self);
          End;
          BringToFront;
        End;
      End;
    Finally
      Processingcursor(False);
    End;
  End;
End;


Procedure TRepairsGUI.EdtMemoLineDblClick(Sender: TObject);
Begin
  Inherited;
  DoDBMemoDialog(TblrepairpartsMemoLine.AsString, TblrepairpartsMemoLine.Displaylabel, TblrepairpartsMemoLine);
End;

Procedure TRepairsGUI.EmailBtnClick(Sender: TObject);
Begin
  Inherited;
  If Accesslevel >= 5 Then Exit;
  RepairsObj.PostDb;
  RepairCreateCorrespondence(tcTypes.CtEmail, Self, repairsObj.Customer.FirstName);
  If QryDocuments.Active Then QryDocuments.Close;
  QryDocuments.Open;
End;

procedure TRepairsGUI.EmailInvoiced;
var
  toEmail: string;
begin
  if AppEnv.CompanyPrefs.EnableRepairInvoicedEmail then
  begin
    toEmail := RepairsObj.ContactEmail;
    if toEmail = '' then
      toEmail := RepairsObj.Customer.Email;
    if toEmail = '' then
      exit;

    TCorrespondenceGui.EmailCustomer(toEmail,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RepairInvoicedEmailSubject, RepairsObj.PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RepairInvoicedEmailText, RepairsObj.PopulateMessageSubstituteList),
    RepairsObj.ClientID);
  end;
end;


Procedure TRepairsGUI.LetterBtnClick(Sender: TObject);
Begin
  If Accesslevel >= 5 Then Exit;
  RepairsObj.PostDb;
  RepairCreateCorrespondence(CtLetter, Self, repairsObj.Customer.FirstName);
  If QryDocuments.Active Then QryDocuments.Close;
  QryDocuments.Open;
End;

Procedure TRepairsGUI.LoadDataFromPOLines(Const ProductID: Integer);
Begin
  EditDB(TblRepairParts);
  TblRepairPartsPriceEx.AsFloat := QryParts.FieldByName('Price1').AsFloat;
End;

Procedure TRepairsGUI.MnuAuditTrialClick(Sender: TObject);
Begin
  Inherited;
  If Self.RepairsOBJ.Id = 0 Then Exit;
  OpenErpListform('TTransAuditTrailGUI', TransAuditTrialbeforeShow);
End;

Procedure TRepairsGUI.MnuCustomiseGridClick(Sender: TObject);
Var
  SourceGrid: TComponent;
Begin
  Inherited;
  If Sender Is TMenuItem Then Begin
    With TMenuItem(Sender) Do Begin
      SourceGrid := TAdvPopupMenu(TMenuItem(Sender).GetParentMenu).PopupComponent;
      If SourceGrid.Name = 'grdOtherFollowUp' Then Begin
        GuiPrefs.ShowCustomiseForm('Follow Up');
      End
      Else If SourceGrid.Name = 'grdParts' Then Begin
        GuiPrefs.ShowCustomiseForm('Products');
      End
      Else If SourceGrid.Name = 'grdAppointments' Then Begin
        GuiPrefs.ShowCustomiseForm('Appointments');
      End
      Else If SourceGrid.Name = 'grdInvoices' Then Begin
        GuiPrefs.ShowCustomiseForm('Invoices');
      End
      Else If SourceGrid.Name = 'grdSmartOrder' Then Begin
        GuiPrefs.ShowCustomiseForm('Smart Orders');
      End
      Else If SourceGrid.Name = 'grdBills' Then Begin
        GuiPrefs.ShowCustomiseForm('Bills');
      End;
    End;
    grdParts.ColumnByName('ConvertToInvoice').ReadOnly:= True;
  End;
End;

Procedure TRepairsGUI.FormKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
  Inherited;
  { SE.HandleSwitchKeys(Key); }
End;

Procedure TRepairsGUI.TaxCodeDetailsBeforeOpen(DataSet: TDataSet);
Begin
  Inherited;
  TaxCodeDetails.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
End;

Procedure TRepairsGUI.GrdPartsDblClick(Sender: TObject);
Var
  SMatrixDesc : String;
  SMatrixRef  : String;
  DMatrixPrice: Double;
Begin
  If Showformuladetails Then Exit;
  If (ActiveField(Sender).FieldName = 'MatrixDesc') Or (ActiveField(Sender).FieldName = 'MatrixPrice') Then Begin
    SMatrixDesc  := RepairsOBJ.RepairParts.MatrixDesc;
    SMatrixRef   := RepairsOBJ.RepairParts.MatrixRef;
    DMatrixPrice := RepairsOBJ.RepairParts.MatrixPrice;
    TfmpartsPriceMatrixInput.PriceMAtrix(Self, SMatrixRef, SMatrixDesc, DMatrixPrice, RepairsOBJ.RepairParts.ProductId, Myconnection);
    SetMatrixDetails(SMatrixDesc, SMatrixRef, DMatrixPrice);
    Abort; // this is to cancel the memodialag popup for this field
  End
  Else If (SameText(ActiveField(Sender).FieldName, 'PriceEx')) Or (SameText(ActiveField(Sender).FieldName, 'PriceInc')) Then Begin
    TfmproductPrices.ShowProduct(RepairsOBJ.RepairParts.ProductId, RepairsOBJ.ClientID, '', RepairsOBJ.RepairParts.UnitOfMeasureID, RepairsOBJ.RepairParts.Quantity, RepairsOBJ.RepairParts.Taxrate,
      RepairsOBJ.RepairParts.MatrixREf, 0,0);
  End
  Else If (SameText(ActiveField(Sender).FieldName, 'Memoline')) Then Begin
    DoDBMemoDialog(TblrepairpartsMemoLine.AsString, TblrepairpartsMemoLine.Displaylabel, TblrepairpartsMemoLine);
  End;

  Inherited;
End;

function TRepairsGUI.SAveRepair: Boolean;
begin
  Result := False;
  if not RepairsOBJ.Save  then exit;
  If Not ChkCustReqdFields Then Exit;
  Result := True;
end;

procedure TRepairsGUI.SendEmail;
var
  lSilent, lSecret : boolean;
begin
{
  If SaveRepair (*RepairsOBJ.Save*) Then Begin
    RepairsOBJ.Connection.CommitTransaction;
    try
    AssignReportTemplate;
    EmailReport(RepairsOBJ.ID, RepairsOBJ.Client.ClientName, RepairsOBJ.Client.Email, 'Repairs', ReportToPrint, RepairsReportSQL(RepairsObj.ID), True, True);
    finally
      RepairsOBJ.Connection.BeginTransaction;
    end;
  End;
}
  if not EmailShortSendMode(lSilent, lSecret) then exit;
  DoSendEmail(lSecret);
end;

function TRepairsGUI.SendPrintEmail: boolean;
var
  toEmail: string;
begin
  toEmail := RepairsObj.ContactEmail;
  if toEmail = '' then
    toEmail := RepairsObj.Customer.Email;

  result := TCorrespondenceGui.EmailCustomer(toEmail,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RepairPrintEmailSubject, RepairsObj.PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RepairPrintEmailText, RepairsObj.PopulateMessageSubstituteList),
    RepairsObj.ClientID);
end;

function TRepairsGUI.SendPrintEmailSilent: boolean;
var
  toEmail: string;
begin
  toEmail := RepairsObj.ContactEmail;
  if toEmail = '' then
    toEmail := RepairsObj.Customer.Email;

  result := TCorrespondenceGui.EmailCustomer(toEmail,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RepairPrintEmailSubject, RepairsObj.PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RepairPrintEmailText, RepairsObj.PopulateMessageSubstituteList),
    RepairsOBJ.ClientID,true);
end;

function TRepairsGUI.SendPrintSMS: boolean;
var
  number: string;
begin
  result := false;
  number := GetOrAddMobileNumber;
  if number = '' then exit;

  result := TCorrespondenceGui.SMSCustomer(number,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RepairPrintSMSText, RepairsObj.PopulateMessageSubstituteList),
    RepairsObj.ClientID);
end;

function TRepairsGUI.SendPrintSMSSilent: boolean;
var
  toMobile: string;
begin
  toMobile := RepairsObj.ContactMobile;
  if toMobile = '' then
    toMobile := RepairsObj.Customer.Mobile;
  result := TCorrespondenceGui.SMSCustomer(toMobile,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.RepairPrintSMSText, RepairsObj.PopulateMessageSubstituteList),
    RepairsObj.ClientID,true);
end;

procedure TRepairsGUI.SendSilentEmail;
begin
  DoSendEmail(true);
end;

Procedure TRepairsGUI.Setcolumn(ColumnVisible: Boolean; ColumnName, Displaylabel: String);
Begin
  If ColumnVisible Then Begin
    If Displaylabel <> '' Then Begin
      If GrdParts.ColumnByName(ColumnName) = Nil Then Begin
        If Tblrepairparts.Findfield(ColumnName) <> Nil Then Tblrepairparts.Fieldbyname(ColumnName).DisplayLabel := DisplayLabel;
      End Else Begin
        GrdParts.ColumnByName(ColumnName).DisplayLabel := DisplayLabel;
      End;
    End;
  End Else Begin
    Guiprefs.DbGridElement[GrdParts].RemoveField(ColumnName);
  End;
End;

Procedure TRepairsGUI.SetMatrixDetails(SMatrixDesc: String; SMatrixRef: String; DMatrixPrice: Double);
Begin
  RepairsOBJ.RepairParts.MatrixDesc  := SMatrixDesc;
  RepairsOBJ.RepairParts.MatrixRef   := SMatrixRef;
  RepairsOBJ.RepairParts.MatrixPrice := DMatrixPrice;
  If RepairsOBJ.RepairParts.MatrixPrice <> 0 Then Begin
    RepairsOBJ.RepairParts.PriceEx := RepairsOBJ.RepairParts.MatrixPrice;
    RepairsOBJ.RepairParts.CallDoFieldOnChange(TblrepairpartsPriceEx);
  End;
  RepairsOBJ.RepairParts.PostDB;
End;

Procedure TRepairsGUI.GrdTimesheetsButtonClick(Sender: TObject);
Begin
  Try
    If QryTimesheets.FieldByName('Active').AsString = 'T' Then Begin
      If CommonLib.MessageDlgXP_Vista('Delete Line ' + #10#13 + QryTimesheets.FieldByName('EmployeeName').AsString + ' ?', MtConfirmation, [MbYes, MbNo], 0) = MrYes Then QryTimesheets.Delete;
    End Else Begin
      CommonLib.MessageDlgXP_Vista('This line cannot be deleted as payment has been made.', MtInformation, [MbOK], 0);
    End;
  Except
    ;
  End;
End;

Procedure TRepairsGUI.TbOtherFollowUpNewRecord(DataSet: TDataSet);
Begin
  Inherited;
  TbOtherFollowUpCreationDate.AsDateTime := Now;
End;

Procedure TRepairsGUI.TransAuditTrialbeforeShow(Sender: TObject);
Begin
  If Not(Sender Is TTransAuditTrailGUI) Then Exit;
  TTransAuditTrailGUI(Sender).DocName        := RepairsOBJ.Classname;
  TTransAuditTrailGUI(Sender).DocId          := RepairsOBJ.ID;
  TTransAuditTrailGUI(Sender).TransGlobalref := RepairsOBJ.Globalref;
  TTransAuditTrailGUI(Sender).DocDescription := RepairsOBJ.XMLNodename;
  TTransAuditTrailGUI(Sender).Formname       := Self.Classname;
End;

procedure TRepairsGUI.txtFeedbackNotesDblClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TCommentsListGUI' , UpdateFeedbackNotes, nil);
end;
procedure TRepairsGUI.UpdateFeedbackNotes(Sender:TwwDbGrid);
begin
  if Sender.Datasource.dataset.findfield('Comments') <> nil then begin
   RepairsOBJ.EditDB;
   txtFeedbackNotes.Lines.Add(Sender.Datasource.dataset.FieldByName('Comments').AsString);
   RepairsOBJ.PostDB;;
  end;
end;
Procedure TRepairsGUI.CboServicesCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Modified = False Then Exit;
  Inherited;
  EditDB(FillTable);
  FillTable.FieldByName('ServiceID').AsInteger := LookupTable.FieldByName('ID').AsInteger;
  FillTable.FieldByName('ChargeRate').AsFloat  := LookupTable.FieldByName('Rate').AsFloat;
  FillTable.FieldByName('PartID').AsInteger    := LookupTable.FieldByName('PartID').AsInteger;
  FillTable.FieldByName('PartName').AsString   := LookupTable.FieldByName('PartName').AsString;
End;

Function TRepairsGUI.GetReportTypeID: Integer;
Begin
  Result := 23;
End;

Procedure TRepairsGUI.GlobalEventHandler(Const Sender: TObject; Const Event: String; Const Data: Pointer);
Begin
  If (SameText(Event, GEVENT_ListClosed)) And (Sender.Classnameis('TEquipmentsparePartsGUI')) And (EquipmentPartsclicked) Then Begin
    AddProducts(Sender);
    EquipmentPartsclicked := False;
  End;

End;

Procedure TRepairsGUI.OnProductSelect(Sender: TwwDBGrid);
Begin
  TEquipmentsparePartsGUI(Sender.Owner).AddProducts(DoAddProducts);
  TEquipmentsparePartsGUI(Sender.Owner).Close;
  EquipmentName         := '';
  EquipmentId           := 0;
  EquipmentPartsclicked := False;
End;

Procedure TRepairsGUI.ApplyCustomFieldsSettings;
Begin
  CustomfieldonGrid := TCustomFieldonGrid.Create(Self, 'CustFld1,CustFld2,CustFld3,CustFld4,CustFld5,CustFld6,CustFld7,CustFld8,CustFld9,CustFld10', LtRepairParts, GrdParts, Guiprefs,
    RepairsOBJ.RepairParts);
  CustomfieldonGrid.ApplyCustomFieldsSettings;
End;

Procedure TRepairsGUI.AppointmentClosed(MsgObj: TMsgObj);
Begin
  FreeAndNil(MsgObj);
  BtnAppointmentClick(Self);
End;

Procedure TRepairsGUI.CboEquipmentCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  Inherited;
  If Not Modified Then Exit;
  Inherited;
  REpairsObj.RepairEquipmentFault.CustomerEquipmentId := QryRepairFaultsEquip.Fieldbyname('ID').AsInteger;
  REpairsObj.RepairEquipmentFault.Equipment           := QryRepairFaultsEquip.Fieldbyname('EquipName').AsString;
  REpairsObj.RepairEquipmentFault.PostDB;
End;

Procedure TRepairsGUI.CboEquipmentDblClick(Sender: TObject);
Begin
  Inherited;
  // don;t delete, to skip the ondblclick event from baseinput
End;

Procedure TRepairsGUI.CboEquipmentNameDropDown(Sender: TObject);
Begin
  Inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
End;

Procedure TRepairsGUI.CboEquipmentNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
Begin
  Inherited;
  // don't delete, to skip the not in list event from baseinput
  Accept := False;
End;

Procedure TRepairsGUI.TABCTL20Changing(Sender: TObject; Var AllowChange: Boolean);
Begin
  Inherited;
  If RepairsOBJ.ClientID = 0 Then Begin
    Allowchange := False;
    Commonlib.MessageDlgXP_Vista('Customer has not been selected', MtInformation, [MbOk], 0);
    SetControlFocus(CboClientJob);
    Exit;
  End;
  If (TabCtl20.ActivePage = TTabSheet(TabTimesheetEntries)) Then Begin
    If Not(RepairsOBJ.TimesheetEntry.ValidateData) Then Begin
      AllowChange := False;
      Exit;
    End;
  End;
  Allowchange := TRue;
End;

Procedure TRepairsGUI.UpdateFromContact(sender: TwwDBGrid);
Var
  S: String;
Begin
  Inherited;
  If AccessLevel > 3 Then Exit;
  S := Trim(ClientDetails(Sender.Datasource.dataset));
  If StartsWith(RepairsOBJ.CustomerName,s) then Else S:= RepairsOBJ.CustomerName + #13#10 + S;
  RepairsOBJ.CustomerDetails := S;
  RepairsOBJ.ContactId       := Sender.Datasource.dataset.Fieldbyname('contactID').AsInteger;
  RepairsOBJ.Phone           := Sender.Datasource.dataset.Fieldbyname('ContactPH').AsString;
  RepairsOBJ.Mobile          := Sender.Datasource.dataset.Fieldbyname('ContactMOB').AsString;
  RepairsOBJ.Fax             := Sender.Datasource.dataset.Fieldbyname('ContactFax').AsString;
  RepairsOBJ.PostDb;
End;

Procedure TRepairsGUI.CboClientJobDropDown(Sender: TObject);
Begin
  Inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
End;

Procedure TRepairsGUI.GrdBillsDblClick(Sender: TObject);
Begin
  Inherited;
  OpenTransRecord(Qrybills, 'PurchaseOrderId', 'Bill', 'TBillGUI');
End;

Procedure TRepairsGUI.GrdDocsIButtonClick(Sender: TObject);
Begin
  Inherited;
  If QryDocuments.FieldByName('Active').AsBoolean = False Then Begin
    MessageDlgXP_Vista('This document is already deleted', MtInformation, [MbOK], 0);
    Exit;
  End;
  If MessageDlgXP_Vista('Are you sure you want to delete this record?', MtConfirmation, [MbYes, MbNo], 0) = Mrno Then Exit;
  EditDB(QryDocuments);
  QryDocuments.FieldByName('Active').AsBoolean := False;
  PostDb(QryDocuments);
End;

Procedure TRepairsGUI.GrdSalesOrdersDblClick(Sender: TObject);
Begin
  Inherited;
  OpenTransRecord(QrySalesOrders, 'saleID', 'SalesOrder', 'TSalesOrderGUI');
End;

Procedure TRepairsGUI.cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Not Modified Then Exit;
  Inherited;
  RepairsOBJ.Terms   := CboTermsQryTerms.AsString;
  RepairsOBJ.TermsId := CboTermsQryTermsID.AsInteger;
End;

procedure TRepairsGUI.cboTermsQryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if  AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanChangeTermsinRepairs') <> 1 then begin
    Showcontrolhint(cboTerms,'You don''t have access to change the Terms');
    cboTerms.ReadOnly := True;
  end;

end;

Procedure TRepairsGUI.WwIButton3Click(Sender: TObject);
Begin
  Inherited;
  REpairsObj.RepairEquipmentFault.Deleted := True;
  REpairsObj.RepairEquipmentFault.PostDb;
End;

Procedure TRepairsGUI.ShowFootervalue;
Begin
  GrdParts.Columnbyname('LineTotalEx').FooterValue  := FloatToStrF(RepairsOBJ.TotalEx, FfCurrency, 15, CurrencyRoundPlaces);
  GrdParts.Columnbyname('calctotalInc').FooterValue := FloatToStrF(RepairsOBJ.TotalInc, FfCurrency, 15, CurrencyRoundPlaces);
  GrdParts.Columnbyname('PriceEx').FooterValue      := FloatToStrF(RepairsOBJ.TotalPriceEx, FfCurrency, 15, CurrencyRoundPlaces);
  GrdParts.Columnbyname('PriceInc').FooterValue     := FloatToStrF(RepairsOBJ.TotalPriceInc, FfCurrency, 15, CurrencyRoundPlaces);
  GrdParts.Columnbyname('LineCost').FooterValue     := FloatToStrF(RepairsOBJ.LineCosttotal, FfCurrency, 15, CurrencyRoundPlaces);
  GrdParts.Columnbyname('LinecostInc').FooterValue  := FloatToStrF(RepairsOBJ.LineCosttotalinc, FfCurrency, 15, CurrencyRoundPlaces);
End;

Procedure TRepairsGUI.ShowPO(Const POIDs: String);
Var
  IDList      : TStringlist;
  TmpComponent: TComponent;
  X           : Integer;
Begin
  If POIDs = '' Then Exit;
  IDList := TStringList.Create;
  Try
    FastFuncs.Split(POIDs, ',', IDList);
    If IDList.Count = 0 Then Exit;
    If MessageDlgXP_Vista('Created ' + IntToStr(IDList.Count) + ' Order(s).  ' + 'Do you wish to view them?', Mtconfirmation, [MbYes, MbNo], 0) = Mrno Then Exit;
    For X          := 0 To IDList.Count - 1 Do Begin
      TmpComponent := GetComponentByClassName('TPurchaseGUI', False);
      If Assigned(TmpComponent) Then Begin
        With TBaseInputGUI(TmpComponent) Do Begin
          TBaseInputGUI(TmpComponent).KeyID     := FastFuncs.StrToInt(IDList[X]);
          TBaseInputGUI(TmpComponent).FormStyle := FsMDIChild;
          TBaseInputGUI(TmpComponent).BringToFront;
          TBaseInputGUI(TmpComponent).Update;
          While FormStillOpen('TPurchaseGUI', TForm(TmpComponent)) Do Begin
            Application.ProcessMessages;
            Sleep(100);
          End;
        End;
      End;
    End;
  Finally FreeandNil(IDList);
  End;
End;
Procedure TRepairsGUI.Showtotalamount;
Var
  lTotal : double;
  lTotalCost : double;
  lTotalAdjusted : double;
  lServiceCharges,
  lTotalBill : Double;
//  lTotalLabour : double;
Begin
  // dTotalEx := RepairsOBJ.TotalEx ;
  if ShowTotalCostInc then  begin
    lTotalBill           := RepairsOBJ.TotalBill;
    lTotalAdjusted       := RepairsObj.TimeSheetEntry.TotalAdjusted;
    lTotalCost           := RepairsOBJ.TotalCostinc;
  end else begin
    lTotalBill           := RepairsOBJ.TotalBillEx;
    lTotalAdjusted       := RepairsObj.TimeSheetEntry.TotalAdjusted;
    lTotalCost           := RepairsOBJ.TotalCost;
  end;
  txtCost.Text := CurrToStrF(lTotalCost +lTotalAdjusted + lTotalBill, ffCurrency, 2);

  Showcontrolhint(TxtCost,'This is the Total of Product Cost (Product.Cost x Product.Quantity) : ' + CurrToStrF(lTotalCost, FfCurrency, REpairsobj.CurrencyRoundPlaces) + ' +' + NL +
                      'The Total Adjusted of Timesheet : ' +    CurrToStrF(lTotalAdjusted, FfCurrency, REpairsobj.CurrencyRoundPlaces) + ' +' + NL +
                      'Total of Bills :' + CurrToStrF(lTotalBill, FfCurrency, REpairsobj.CurrencyRoundPlaces) + ''+NL);


  if ShowTotalAmountInc then  begin
    lTotal := RepairsOBJ.TotalInc;
    lServiceCharges := RepairsOBJ.Timesheetentry.TotalServiceCharges;
    Showcontrolhint(TxtTotal,'This is the total of Product price(Inc)  :' + CurrToStrF( lTotal, FfCurrency, REpairsobj.CurrencyRoundPlaces) + ' +' + NL +
                         'The time sheet Service charges(Inc) :' +    CurrToStrF(lServiceCharges, FfCurrency, REpairsobj.CurrencyRoundPlaces) + '' +NL);
  end  else  begin
    lTotal := RepairsOBJ.TotalEx;
    lServiceCharges := RepairsOBJ.Timesheetentry.TotalServiceCharges;
    Showcontrolhint(TxtTotal,'This is the total of Product price(Ex)  :' + CurrToStrF( lTotal, FfCurrency, REpairsobj.CurrencyRoundPlaces) + ' +' + NL +
                         'The time sheet Service charges(Ex) :' +    CurrToStrF(lServiceCharges, FfCurrency, REpairsobj.CurrencyRoundPlaces) + '' +NL);
  end;

  TxtTotal.Text        := CurrToStrF( lTotal + lServiceCharges, FfCurrency, REpairsobj.CurrencyRoundPlaces);

  if showTotalInvAmountInc then  begin
    lTotal :=RepairsOBJ.InvoiceTotalinc;
  end else begin
    lTotal :=RepairsOBJ.InvoiceTotalEx;
  end;
  edtInvoicetotal.Text        := CurrToStrF( lTotal (*+ lServiceCharges*), FfCurrency, REpairsobj.CurrencyRoundPlaces);
  Showcontrolhint(edtInvoicetotal,'This is the total of All Its Invoices  :' + CurrToStrF( lTotal, FfCurrency, REpairsobj.CurrencyRoundPlaces) (*+ ' +' + NL +
                         'The time sheet Service charges(Ex) :' +    CurrToStrF(lServiceCharges, FfCurrency, REpairsobj.CurrencyRoundPlaces) + ''*) +NL);
End;

procedure TRepairsGUI.Spelling1Click(Sender: TObject);
begin
  inherited;
  if txtNotes.Focused then
    Spelling.AddictSpell.CheckWinControl(txtNotes, ctSmart)
  else if txtFeedbackNotes.Focused then
    Spelling.AddictSpell.CheckWinControl(txtFeedbackNotes, ctSmart);
end;

Procedure TRepairsGUI.SetGridColumns;
Begin
  GuiPrefs.DbGridElement[GrdParts].HideField('RepairPartsId');
  GuiPrefs.DbGridElement[GrdParts].HideField('RepairId');
  GuiPrefs.DbGridElement[GrdParts].HideField('Deleted');
  GuiPrefs.DbGridElement[GrdParts].HideField('POSID');
  GuiPrefs.DbGridElement[GrdParts].HideField('ParentProductID');
  GuiPrefs.DbGridElement[GrdParts].HideField('ParentlineREf');
  GuiPrefs.DbGridElement[GrdParts].HideField('RElatedProductQty');
  (* GuiPrefs.DbGridElement[grdParts].HideField('Serialnos'); *)
  (* GuiPrefs.DbGridElement[grdParts].HideField('IsRelatedproduct'); *)
  GuiPrefs.DbGridElement[GrdParts].HideField('InvoiceLineref');
  GuiPrefs.DbGridElement[GrdParts].HideField('PartsID');
  GuiPrefs.DbGridElement[GrdParts].HideField('UnitofMeasureID');
  GuiPrefs.DbGridElement[GrdParts].HideField('UnitOfMeasureMultiplier');
  GuiPrefs.DbGridElement[GrdParts].HideField('Globalref');
  GuiPrefs.DbGridElement[GrdParts].HideField('CustomerEquipmentId');
  GuiPrefs.DbGridElement[GrdParts].HideField('Taxrate');
  GuiPrefs.DbGridElement[GrdParts].HideField('CalcTotalincBase');
  GuiPrefs.DbGridElement[GrdParts].HideField('Editedflag');
  GuiPrefs.DbGridElement[GrdParts].HideField('ClassId');
  GuiPrefs.DbGridElement[GrdParts].HideField('Qty');
  GuiPrefs.DbGridElement[GrdParts].HideField('PartType');
  (* GuiPrefs.DbGridElement[grdParts].HideField('PartIssuedOn'); *)
  GuiPrefs.DbGridElement[GrdParts].HideField('PurchaseOrderId');
  (* GuiPrefs.DbGridElement[grdParts].HideField('ConverttoInvoice'); *)
  // GuiPrefs.DbGridElement[grdParts].RemoveFields('Discounts,Markup,MarkupPercent,DiscountPercent,MAtrixRef');
  GuiPrefs.DbGridElement[GrdOtherFollowUp].HideField('FollowupID');
  GuiPrefs.DbGridElement[GrdOtherFollowUp].HideField('OtherContactId');
  GuiPrefs.DbGridElement[GrdOtherFollowUp].HideField('RepairId');
  GuiPrefs.DbGridElement[GrdOtherFollowUp].HideField('employeeId');
  GuiPrefs.DbGridElement[GrdOtherFollowUp].HideField('clientID');
  GuiPrefs.DbGridElement[GrdOtherFollowUp].HideField('Editedflag');
  GuiPrefs.DbGridElement[GrdOtherFollowUp].HideField('globalref');


End;
Procedure TRepairsGUI.REadguiprefs;
begin
  if GuiPrefs.Node.Exists('SplitWidths.smartOrder') then grdSO.Width          := GuiPrefs.Node['SplitWidths.smartOrder'].asInteger;
  if GuiPrefs.Node.Exists('SplitWidths.RA')         then grdRAHeader.Width    := GuiPrefs.Node['SplitWidths.RA'].asInteger;
  if GuiPrefs.Node.Exists('SplitWidths.Faults')     then pnlRepairFaults.Width:= GuiPrefs.Node['SplitWidths.Faults'].asInteger;
end;

Procedure TRepairsGUI.GrdPartsUpdateFooter(Sender: TObject);
Begin
  Inherited;
  ShowFootervalue;
End;

Procedure TRepairsGUI.GrdRAHeaderDblClick(Sender: TObject);
Begin
  Inherited;
  OpenTransRecord(QryRAHeaders, 'PurchaseOrderId', 'Return Authority', 'TReturnAGUI');
End;

Procedure TRepairsGUI.GrdRAsDblClick(Sender: TObject);
Begin
  Inherited;
  OpenTransRecord(QryRas, 'PurchaseOrderId', 'Return Authority', 'TReturnAGUI');
End;

Procedure TRepairsGUI.CboProductRDblClick(Sender: TObject);
Begin
  Inherited;
  ProductListForm := BaseClassFuncs.GetBaseListingByClassName('TProductListExpressGUI');
  With ProductListForm Do Begin
    If QryMain.Active Then QryMain.First;
    FormStyle          := FsMDIChild;
    GrdMain.OnDblClick := ProductGridDblClick;
    BringToFront;
  End;

End;

Procedure TRepairsGUI.CboEquipnameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Not(Modified) and (RepairsOBJ.RepairParts.CustomerEquipmentId = QryPartsEquip.Fieldbyname('ID').AsInteger) Then Exit;
  Inherited;
  RepairsOBJ.RepairParts.CustomerEquipmentId := QryPartsEquip.Fieldbyname('ID').AsInteger;
  RepairsOBJ.RepairParts.EquipmentName       := QryPartsEquip.Fieldbyname('EquipName').AsString;
  RepairsOBJ.RepairParts.PostDB;
End;

Procedure TRepairsGUI.RefreshAppointments(MsgObj: TMsgObj; Out MsgRet: TMsgObj);
Begin
  Closedb(QryAppointments);
  Opendb(QryAppointments);
End;

Procedure TRepairsGUI.RefreshUnitsQry;
Begin
  QryUnitOfMeasure.Close;
  QryUnitOfMeasure.ParamByName('xPartID').AsInteger := RepairsOBJ.RepairParts.ProductID;
  QryUnitOfMeasure.Open;
End;

Procedure TRepairsGUI.GrdPartsRowChanged(Sender: TObject);
Begin
  Inherited;
  RefreshUnitsQry;

  GrdParts.ColumnByName('Partname').Readonly := RepairsOBJ.RepairParts.IsRelatedProduct;
  CboProductR.Readonly                       := RepairsOBJ.RepairParts.IsRelatedProduct;
End;

Procedure TRepairsGUI.CboUnitOfMeasureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Not Modified Then Exit;
  Inherited;
(*  RepairsOBJ.RepairParts.UnitofmeasureID := QryUnitOfMeasureUnitID.AsInteger;
  RepairsOBJ.RepairParts.Unitofmeasure   := QryUnitOfMeasureUnitName.AsString;
  RepairsOBJ.RepairParts.UOMMultiplier   := QryUnitOfMeasureMultiplier.AsFloat;
  RepairsOBJ.RepairParts.PostDB;*)
End;

Procedure TRepairsGUI.UnlockedcompOnenter(Sender: TObject);
Begin
  Inherited;
  SavedAccessLevel := Accesslevel;

  If RepairsOBJ.UserLock.IsLockedbyOtherUser(RepairsOBJ.GetBusObjectTablename, RepairsOBJ.ID, RepairsOBJ.LockGroupName) Then Begin
    TimerMsg(LblTmrMsg, 'This record is in use by ' + RepairsOBJ.UserLock.LockInfo.UserName);
    Exit;
  End;
  AccessLevel                          := 1;
  RepairsOBJ.AccessManager.AccessLevel := 1;
  (* if Sender is TDbMemo then
    cleannote := tDBMemo(Sender).Lines.text; *)
End;

Procedure TRepairsGUI.UnlockedcompOnexit(Sender: TObject);
Begin
  Inherited;
  (* if Sender is TDbMemo then begin
    if cleannote <> tDBMemo(Sender).Lines.text then begin
    if sender = txtNotes then
    with txtNotes do
    Lines.Strings[Lines.Count - 1] := AddDateTimeLogin(Lines.Strings[Lines.Count - 1]);
    if sender = txtFeedbackNotes then
    with txtFeedbackNotes do
    Lines.Strings[Lines.Count - 1] := AddDateTimeLogin(Lines.Strings[Lines.Count - 1]);
    end;
    end;
    cleannote := ''; *)

  If Accesslevel = SavedAccessLevel Then Exit;
  RepairsOBJ.PostDB;
  If SavedAccessLevel = 5 Then Begin
    RepairsOBJ.Dirty := False;
    RepairsOBJ.Connection.CommitTransaction;
    RepairsOBJ.Connection.BeginTransaction;
  End;
  RepairsOBJ.EditDB;
  RepairsOBJ.AccessManager.AccessLevel := SavedAccessLevel;
  AccessLevel                          := SavedAccessLevel;
End;

Procedure TRepairsGUI.SetsaleIDs(Const Value: String);
Var
  IDList: TStringlist;
  // x:Integer;
  FormName, SaleType: String;
Begin
  FsaleIDs := Value;
  If AppEnv.CompanyPrefs.ShowInvoiceFormwhenRepairInvoiced = False Then Exit;
  If Value = '' Then Exit;
  IDList := TStringList.Create;
  Try
    FastFuncs.Split(Value, ',', IDList);
    (*If Screen.Activecontrol = BtnSalesOrder Then Begin
      FormName := 'TSalesOrderGUI';
      SaleType := 'Sales Order''s';
    End
    Else If Screen.Activecontrol = BtnInvoice Then Begin
      FormName := 'TInvoiceGUI';
      SaleType := 'Invoice''s';
    End
    Else Exit;*)

    FormName:= fsSalesFormName ;
    SaleType:= fsSalesType ;
    if (FormName ='') or (SaleType= '') then exit;

    { if there }
    If IDList.Count > 1 Then Begin
      CommonLib.MessageDlgXP_Vista('The following ' + SaleType + ' were created: ' + IDList.CommaText, MtInformation, [MbOk], 0);
    End Else Begin
      { just open it }
      Openrecord(StrToInt(IDList[0]), FormName)
    End;

    // for x := 0 to IDList.count-1 do begin
    // if x < IDList.count-2 then
    // OpenERPForm(formName, StrToInt(IDList[x]))
    // else
    // Openrecord(StrToInt(IDList[x]) ,formName);
    // end;
  Finally FreeandNil(IDList);
  End;

End;

Procedure TRepairsGUI.GrdPartsEnter(Sender: TObject);
Begin
  Inherited;
  GrdParts.ColumnByName('Partname').Readonly      := RepairsOBJ.RepairParts.IsRelatedProduct;
  GrdParts.ColumnByName('UnitofMeasure').Readonly := RepairsOBJ.RepairParts.IsRelatedProduct;
  GrdParts.ColumnByName('UOMqty').Readonly        := RepairsOBJ.RepairParts.IsRelatedProduct;
  GrdParts.ColumnByName('Taxcode').Readonly       := True;
  GrdParts.ColumnByName('CalcTax').Readonly       := True;
  CboUnitOfMeasure.Readonly                       := RepairsOBJ.RepairParts.IsRelatedProduct;
  CboProductR.Readonly                            := RepairsOBJ.RepairParts.IsRelatedProduct;
  Closedb(QryPartsEquip);
  QryPartsEquip.Params.Parambyname('ClientID').AsInteger := Repairsobj.ClientID;
  Opendb(QryPartsEquip);
  Closedb(QryRepairFaultsEquip);
  QryRepairFaultsEquip.Params.Parambyname('ClientID').AsInteger := Repairsobj.ClientID;
  Opendb(QryRepairFaultsEquip);
  MnuProductStatus.Visible := True;
End;

Procedure TRepairsGUI.BtnPreviewClick(Sender: TObject);
Begin
  if not HasToAndIsApproved then exit;
  DisableForm;
  try
    if DoPrint(true) then
      CloseWait;
  finally
    EnableForm;
  end;
End;

procedure TRepairsGUI.btnPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
  IsEnabled: boolean;
begin
  if not HasToAndIsApproved then exit;

  OptsForm := TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Print');
    OptsForm.ActionList.Add('Print','Print a Repair',PrintRepair, true, true);
    OptsForm.ActionList.Add('Preview', 'Preview a Repair', PreviewRepair, true, true);

    OptsForm.ActionList.AddDivider('Email');
    OptsForm.ActionList.Add('Email Repair', 'Email a copy of the Repair', SendEmail, true, true);
    OptsForm.ActionList.Add('Email Silently', 'Email a copy of the Repair Silently', SendSilentEmail, true, true);
    if AppEnv.CompanyPrefs.EnableRepairPrintEmail and ((RepairsOBJ.ContactEmail <> '') or (RepairsOBJ.Customer.Email <> '')) then begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Repair', self.SendPrintEmailSilent, true, true);
//      OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without repair', self.SendPrintEmail, true, true);
    end
    else begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without repair', self.SendPrintEmailSilent, true, false);
//      OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Repair', self.SendPrintEmail, true, false);
    end;
    OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without repair', self.SendPrintEmail, true, true);

    OptsForm.ActionList.AddDivider('SMS');

    IsEnabled := AppEnv.CompanyPrefs.SMSEnabled and
       AppEnv.CompanyPrefs.EnableRepairPrintSMS and
       ((RepairsOBJ.ContactMobile <> '') or (RepairsOBJ.Customer.Email <> ''));
    OptsForm.ActionList.Add('SMS', 'Just send SMS', self.SendPrintSMSSilent, true, IsEnabled);
    OptsForm.ActionList.Add('SMS (Edit)', 'Edit SMS before sending', self.SendPrintSMS, true, AppEnv.CompanyPrefs.SMSEnabled);

    OptsForm.ShowModal;
    CloseAfterPrint(OptsForm.CloseWhenDone );
  finally
    OptsForm.Free;
  end;
end;

procedure TRepairsGUI.btnQtyVarifyClick(Sender: TObject);
begin
  inherited;
  InventoryVarify(true);
end;

// function TRepairsGUI.doProductSearch(SearchText:String;bStartsWith:Boolean;const bAll:Boolean = False):Boolean;
// begin
// Result := False;
// if SearchText = '' then exit;
// if qryParts.Active then qryParts.Close;
// qryParts.SQL.Clear;
// qryParts.SQL.Text := fProductLookupSQL;
// if  bAll then begin
// //  qryParts.sql.Text := AnsiReplaceText(qryParts.sql.Text,'ORDER By PartName, PartType','');
// end else begin
// qryParts.sql.Text := AnsiReplaceText(qryParts.sql.Text,'ORDER By PartName, PartType','');
// if bStartsWith then begin
// qryParts.sql.Add('AND PartName LIKE "' + SearchText + '%"');
// qryParts.sql.Add('OR SUBSTRING_INDEX(P.ProductGroup,"^",1) LIKE "' + SearchText + '%"');
// qryParts.sql.Add('OR substring(substring_index(P.ProductGroup,"^",2),char_length(substring_index(P.ProductGroup,"^",1))+2) LIKE "' + SearchText + '%"');
// qryParts.sql.Add('OR substring(substring_index(P.ProductGroup,"^",3),char_length(substring_index(P.ProductGroup,"^",2))+2) LIKE "' + SearchText + '%"');
// qryParts.sql.Add('OR PARTSDESCRIPTION LIKE "' + SearchText + '%"');
// end else begin
// qryParts.sql.Add('AND PartName LIKE "%' + SearchText + '%"');
// qryParts.sql.Add('OR SUBSTRING_INDEX(P.ProductGroup,"^",1) LIKE "%' + SearchText + '%"');
// qryParts.sql.Add('OR substring(substring_index(P.ProductGroup,"^",2),char_length(substring_index(P.ProductGroup,"^",1))+2) LIKE "%' + SearchText + '%"');
// qryParts.sql.Add('OR substring(substring_index(P.ProductGroup,"^",3),char_length(substring_index(P.ProductGroup,"^",2))+2) LIKE "%' + SearchText + '%"');
// qryParts.sql.Add('OR PARTSDESCRIPTION LIKE "%' + SearchText + '%"');
// end;
// qryParts.sql.Add('ORDER By PartName, PartType');
// end;
// cboProductR.CloseUp(False);
// qryParts.Open;
// cboProductR.LookupTable.Refresh;
// if qryParts.RecordCount > 0 then begin
// Application.ProcessMessages;
// cboProductR.DropDown;
// Result := True;
// end;
// end;

// function  TRepairsGUI.IsProductInList(sProductName:string):Boolean;
// var
// frm:TBaseInputGUI;
// begin
// Result := True;
// if sProductName <> '' then begin
// if not qryParts.Locate('PartName',sProductName,[]) then begin
// Result := False;
// Processingcursor(True);
// try
// {NOTE : Need to close the form prior to showing modally, otherwise Access Viol
// trying to modalise a visible form}
//
// frm    := nil;
// if CommonLib.MessageDlgXP_Vista('Product not found in list. Would you like to create this Product?',
// mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
// try
// tblDetails.Edit;
// if TfrmParts.FormActive then begin
// TfrmParts.CloseMe;
// end;
//
// frm := TfrmParts(GetComponentByClassName('TfrmParts'));
// if assigned(frm) then begin
// TfrmParts(frm).fsPartName := sProductName;
// frm.Position := poScreenCenter;
// frm.ShowModal;
// end;
// finally
// qryParts.Close;
// qryParts.Open;
// if not Empty(TfrmParts(frm).fsPartName) then begin
// if qryParts.Locate('PartName', TfrmParts(frm).fsPartName, [loCaseInsensitive]) then begin
// cboProductR.Text := TfrmParts(frm).fsPartName;
// cboProductR.PerformSearch;
// end;
// end;
// end;
// end;
// finally
// Processingcursor(False);
// end;
// end;
// end;
// end;

Procedure TRepairsGUI.AssignReportTemplate;
Begin
  ReportToPrint := '';
  If ReportToPrint = '' Then
    If ChkChooseTemplate.Checked Then Begin
      LoadReportTypes;
      If DlgReportSelect.Execute Then ReportToPrint := DlgReportSelect.SelectedItems.Text;
    End;
  If ReportToPrint = '' Then
    If RepairsOBJ.HoldRepair Then ReportToPrint := 'Repairs held';
  If ReportToPrint = '' Then ReportToPrint      := tcdatautils.GetDefaultReport(GetReportTypeID);
  If ReportToPrint = '' Then ReportToPrint      := 'Repairs';
End;

Procedure TRepairsGUI.CboEquipnameNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
Begin
  Inherited;
  // don't delete, to skip the not in list event from baseinput
  Accept := False;
End;

Procedure TRepairsGUI.CboEquipnameDblClick(Sender: TObject);
Begin
  Inherited;
  // don;t delete, to skip the ondblclick event from baseinput
End;

function TRepairsGUI.GetOrAddMobileNumber: string;
var
  aContact: TContact;
  aCustomer : TCustomer;
begin
  result := RepairsObj.ContactMobile;
  if result = '' then
    result := RepairsObj.Customer.Mobile;
  if result = '' then begin
    if RepairsObj.ContactID > 0 then begin
      { contact mobile }
      result := GetMobileNumberFromUser('Contact (' + RepairsObj.ContactName +
        ') does not have a mobile number.' +#13#10 + 'Please enter a number.');
      if result <> '' then begin
        aContact := TContact.Create(nil);
        try
          aContact.Connection := TMyDacDataConnection.Create(aContact);
          aContact.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
          aContact.Load(RepairsObj.ContactID);
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
      result := GetMobileNumberFromUser('Customer (' + RepairsObj.CustomerName +
        ') does not have a mobile number.' + #13#10 + 'Please enter a number.');
      if result <> '' then begin
        aCustomer := TCustomer.Create(nil);
        try
          aCustomer.Connection := TMyDacDataConnection.Create(aCustomer);
          aCustomer.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
          aCustomer.Load(RepairsObj.ClientID);
          if aCustomer.Lock then begin  { only update if we can lock }
            try
              aCustomer.Mobile := result;
              aCustomer.PostDb;
              RepairsObj.Customer.RefreshDB;
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
      if RepairsObj.ContactID > 0 then begin
        { contact mobile }
        result := GetMobileNumberFromUser('Contact (' + RepairsObj.ContactName +
          ') number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.', result, MyConnection);
        if result <> '' then begin
          aContact := TContact.Create(nil);
          try
            aContact.Connection := TMyDacDataConnection.Create(aContact);
            aContact.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
            aContact.Load(RepairsObj.ContactID);
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
        result := GetMobileNumberFromUser('Customer (' + RepairsObj.CustomerName +
          ') number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.', result, MyConnection);
        if result <> '' then begin
          aCustomer := TCustomer.Create(nil);
          try
            aCustomer.Connection := TMyDacDataConnection.Create(aCustomer);
            aCustomer.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
            aCustomer.Load(RepairsObj.ClientID);
            if aCustomer.Lock then begin  { only update if we can lock }
              try
                aCustomer.Mobile := result;
                aCustomer.PostDb;
                RepairsObj.Customer.RefreshDB;
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

Function TRepairsGUI.GetRepairDetails(MsgObj: TMsgObj; Out MsgRet: TMsgObj): Boolean;
Var
  Appointmentobj: TObject;
Begin
  Result         := True;
  Appointmentobj := MsgObj.ObjPtr;
  Try
    If Appointmentobj Is TAppointment Then Begin
      Appointment := TAppointment(Appointmentobj);
      Try
        Appointment.Notes         := RepairsOBJ.Notes;
        Appointment.Feedbacknotes := RepairsOBJ.Feedbacknotes;
        If RepairsOBJ.RepairEquipment.Count = 0 Then Exit;
        RepairsOBJ.RepairEquipment.IterateRecords(CopyEquipsToappointment);
      Finally Appointment := Nil;
      End;
    End;
  Finally Appointment := Nil;
  End;
End;

Procedure TRepairsGUI.CopyEquipsToappointment(Const Sender: TBusObj; Var Abort: Boolean);
Begin
  If Not(Sender Is TEquipmentxRef) Then Exit;
  If Appointment = Nil Then Exit;
  Appointment.Equipment.New;
  Appointment.Equipment.CustomerEquipmentid := TEquipmentxRef(Sender).CustomerEquipmentid;
  Appointment.Equipment.Code                := TEquipmentxRef(Sender).Code;
  // Appointment.Equipment.EquipmentName      := TEquipmentxRef(Sender).EquipmentName;
  Appointment.Equipment.UOM           := TEquipmentxRef(Sender).Uom;
  Appointment.Equipment.UOMID         := TEquipmentxRef(Sender).UOMID;
  Appointment.Equipment.UOMMultiplier := TEquipmentxRef(Sender).UOMMultiplier;
  Appointment.Equipment.UOMQty        := TEquipmentxRef(Sender).UOMQty;
  Appointment.Equipment.Quantity      := TEquipmentxRef(Sender).Quantity;
  // Appointment.Equipment.Model              := TEquipmentxRef(Sender).Model;
  // Appointment.Equipment.Manufacture        := TEquipmentxRef(Sender).Manufacture;
  // Appointment.Equipment.Registration       := TEquipmentxRef(Sender).Registration;
  // Appointment.Equipment.Serialno           := TEquipmentxRef(Sender).Serialno;
  Appointment.Equipment.WarantyPeriodTaken := TEquipmentxRef(Sender).WarantyPeriodTaken;
  Appointment.Equipment.WarantyPeriodLeft  := TEquipmentxRef(Sender).WarantyPeriodLeft;
  Appointment.Equipment.WarantyFinishDate  := TEquipmentxRef(Sender).WarantyFinishDate;
  Appointment.Equipment.WarantyPeriod      := TEquipmentxRef(Sender).WarantyPeriod;
  Appointment.Equipment.Notes              := TEquipmentxRef(Sender).Notes;
  Appointment.Equipment.PostDB;
End;

Function TRepairsGUI.Addtimesheetrecord(MsgObj: TMsgObj; Out MsgRet: TMsgObj): Boolean;
Begin
  MsgRet.ObjPtr := RepairsOBJ;
  Result        := True;
End;
Procedure TRepairsGUI.initProductQtyBinETA(Sender: TObject);
begin
   With TfrmProductQtyBinETA(Sender) Do Begin
      TfrmProductQtyBinETA(Sender).Connection     := Self.MyConnection;
      TfrmProductQtyBinETA(Sender).KeyID          := RepairsOBJ.RepairParts.ProductID;
      TfrmProductQtyBinETA(Sender).ClassID        := RepairsOBJ.RepairParts.Classid;
      TfrmProductQtyBinETA(Sender).SalesOrderMode := False;
      TfrmProductQtyBinETA(Sender).BlockMode      := True;
    End;
end;
Procedure TRepairsGUI.MnuProductStatusClick(Sender: TObject);
begin
  OpenERPFormModal('TfrmProductQtyBinETA' , 0 , initProductQtyBinETA);
End;

Procedure TRepairsGUI.TblDetailsWarantyPeriodTakenChange(Sender: TField);
Begin
  Inherited;
  If TblDetails.Findfield('WarantyPeriod') <> Nil Then TblDetailsWarantyPeriodLeft.AsFloat := TblDetails.Fieldbyname('WarantyPeriod').AsFloat - TblDetailsWarantyPeriodTaken.Asfloat;
End;

procedure TRepairsGUI.tblMasterAfterInsert(DataSet: TDataSet);
begin
  RefreshCustomerLookup;
end;
procedure TRepairsGUI.RefreshCustomerLookup;
begin
  inherited;
  closeDb(qryClientLookup);
  NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(RepairsOBJ.clientId,  cboClientJob,False, True, False, true , true , 'ClientPrintName' , nil, true);
  OpenDb(qryClientLookup);
end;

Procedure TRepairsGUI.TblMasterAfterOpen(DataSet: TDataSet);
Begin
  Inherited;
  InitERPLookupCombonFields;
  InitAttachments;
  RefreshCustomerLookup;
End;

procedure TRepairsGUI.tblMasterAfterPost(DataSet: TDataSet);
begin
  inherited;
  InitAttachments;
end;

Procedure TRepairsGUI.InitAttachments;
Begin
  if RepairsObj.ID =0 then exit;
  If Not Assigned(AttachmentForm) Then Begin
    AttachmentForm              := TfmAttachments(GetComponentByClassName('TfmAttachments', False, Self, True, True, QryCustomersClientID.AsInteger));
    AttachmentForm.DBConnection := Self.MyConnection;
    AttachmentForm.AttachObserver(Self);
    AttachmentForm.TableName            := 'tblRepairs';
    AttachmentForm.TableId              := RepairsObj.ID;
    AttachmentForm.Tag                  := RepairsObj.ID;
    AttachmentForm.LvAttachments.Parent := PnlAttachments;
    AttachmentForm.LvAttachments.Align  := AlClient;
    AttachmentForm.PopulateListView;
  End;

End;

Procedure TRepairsGUI.TblMasterRepairDocNoSetText(Sender: TField; Const Text: String);
Begin
  Inherited;
  If AppEnv.AccessLevels.GetEmployeeAccessLevel('FnRepairNumber') = 1 Then Begin
    Sender.AsString := Text;
  End Else Begin
    MessageDlgXP_Vista('Your do not have rights to change Repair Number.', MtInformation, [MbOk], 0);
  End;
End;

Procedure TRepairsGUI.TblDetailsWarantyPeriodLeftChange(Sender: TField);
Begin
  Inherited;
  If TblDetails.Findfield('WarantyPeriod') <> Nil Then TblDetailsWarantyPeriodTaken.Asfloat := TblDetails.Fieldbyname('WarantyPeriod').AsFloat - TblDetailsWarantyPeriodLeft.AsFloat;
End;

Procedure TRepairsGUI.GrdInvoicesDblClick(Sender: TObject);
Begin
  Inherited;
  OpenTransRecord(QryInvoices, 'saleID', 'Invoice', 'TInvoiceGUI');
End;

Procedure TRepairsGUI.GrdAppointmentsDblClick(Sender: TObject);
Begin
  Inherited;
  OpenTransRecord(QryAppointments, 'AppointID', 'Appointment', 'TAppointmentGUI');
End;

Procedure TRepairsGUI.Openrecord(Const ID: Integer; Const ComponentClassType: String);
Begin
  Inherited;
End;

Procedure TRepairsGUI.AfterSubFormShow(Sender: TObject);
Begin
  Inherited;
  StateParams.I['KeyID']                     := RepairsObj.ID;
  StateParams.I['TabControlActivePageIndex'] := TabCtl20.ActivePageIndex;
End;

Procedure TRepairsGUI.OpenTransRecord(Const Qry: TERPQuery; IDFieldName: STring; Recordtype: String; Const ComponentClassType: String);
Begin
  If Qry.Recordcount = 0 Then Exit;
  If Qry.Fieldbyname(IDFieldName).AsInteger = 0 Then Exit;
  If RepairsOBJ.Dirty Then Begin
    If Commonlib.MessageDlgXP_Vista('Do You Wish To Save Current Changes and Open ' + Recordtype + '#' + IntToStr(Qry.Fieldbyname(IDFieldName).AsInteger) + '?', MtConfirmation, [Mbyes, Mbno], 0)
      = Mrno Then Exit;
    Try
      If SaveRepair (*RepairsOBJ.Save*) Then Begin
        RepairsOBJ.Connection.CommitTransaction;
      End Else Begin
        If RepairsOBJ.ResultStatus.GetLastFatalStatusItem.Code = BOR_TimeSheet_Err Then Begin
          TabCtl20.ActivePage := TabTimesheetEntries;
          TabCtl20Change(TabCtl20);
          Exit;
        End;
      End;
    Except
      On EAbort Do HandleEAbortException;
      Else
        Raise;
      Exit;
    End;
  End
  Else If Commonlib.MessageDlgXP_Vista('Do You Wish To Close The Repair Record and Open ' + Recordtype + '#' + IntToStr(Qry.Fieldbyname(IDFieldName).AsInteger) + '?', MtConfirmation, [Mbyes, Mbno], 0)
    = Mrno Then Exit;
  OpenRecord(Qry.Fieldbyname(IDFieldName).AsInteger, ComponentClassType);
  Self.CloseWait;
End;

Procedure TRepairsGUI.QrySalesOrdersAfterOpen     (DataSet: TDataSet);Begin  Inherited;  LblSalesOrders.Caption := IntToStr(QrySalesOrders.Recordcount)      ;End;
Procedure TRepairsGUI.QryAppointmentsAfterOpen    (DataSet: TDataSet);Begin  Inherited;  LblAppointment.Caption := IntToStr(QryAppointments.Recordcount)     ;End;
Procedure TRepairsGUI.QryRAHeadersAfterOpen       (DataSet: TDataSet);Begin  Inherited;  LblRAs.Caption         := IntToStr(QryRAHeaders.Recordcount)        ;End;
Procedure TRepairsGUI.QrySmartOrderHeaderAfterOpen(DataSet: TDataSet);Begin  Inherited;  LblsmartOrders.Caption := IntToStr(QrySmartOrderHeader.Recordcount) ;End;
Procedure TRepairsGUI.QryInvoicesAfterOpen        (DataSet: TDataSet);Begin  Inherited;  LblInvoices.Caption    := IntToStr(QryInvoices.Recordcount)         ;fbInvoicefootersShown := False;End;
procedure TRepairsGUI.QryPOsBeforeOpen(DataSet: TDataSet);begin  inherited;  QryPos.ParamByname('RepairID').AsInteger := RepairsOBJ.Id;end;
procedure TRepairsGUI.QryPOsAfterOpen             (DataSet: TDataSet);
  function BOPOs: Integer;
  begin
    opendb(QryPOs);
    QryPOs.filter := 'BOQty >0 ';
    QryPOs.Filtered :=  true;
    try
        result:= QryPOs.recordcount;
    finally
      QryPOs.Filtered := False;
      QryPOs.Filter:= '';
    end;
         if QryPOs.recordcount = 0 then lblAllgood.Caption:= 'N/A'
    else if HastoAndIsallPOREceived('', False) then  lblAllgood.Caption:= 'Yes' else lblAllgood.Caption:= 'No';
  end;
Begin
  inherited;
  lblPOBSs.Caption       := inttostr(BOPOs)                           ;
end;

procedure TRepairsGUI.Writeguiprefs;
begin
  GuiPrefs.Node['SplitWidths.smartOrder'].asInteger := grdSO.Width;
  GuiPrefs.Node['SplitWidths.RA'].asInteger         := grdRAHeader.Width;
  GuiPrefs.Node['SplitWidths.Faults'].asInteger     := pnlRepairFaults.Width;
end;

Procedure TRepairsGUI.TABCTL20Resize(Sender: TObject);
Begin
  (*Inherited;
  If Not RealignTabInProgress Then Begin
    RealignTabInProgress := True;
    If Not Self.IsFlag('FormInitialising') Then RealignTabControl(TabCtl20, 1);
    If TabCtl20.TabWidth > 130 Then TabCtl20.TabWidth := TabCtl20.TabWidth - 1;
    RealignTabInProgress                                      := False;
  End;*)
End;

procedure TRepairsGUI.pnlconvertToOptionsDblClick(Sender: TObject);
var
  ds:TERPQuery;
begin
    ds:= DbSharedObjectsObj.DbSharedObj.GetQuery(RepairsOBJ.Connection.Connection);
    try
  ds.sql.clear;
  ds.sql.add('    Select 1 as Category ,'+'"TotalBill"       as Type,'+' PO.Orderdate     as Date,'+'PL.accountname   as Description,'+'   PL.TotalLineAmount amtEx ,'+' PL.TotalLineAmountInc amtinc from tblpurchaselines PL inner join  tblpurchaseorders PO on PO.PurchaseOrderID = PL.PurchaseOrderID and PO.IsBill ="T" where PL.repairID= ' + inttostr(RepairsOBJ.ID) +
          ' union Select 2 as Category ,'+'"TotalAdjusted"   as Type,'+' TS.TimesheetDate as Date,'+'TS.employeename  as Description,'+'  TS.TotalAdjusted   amtEx ,'+' TS.TotalAdjusted      amtinc from tbltimesheetentry TE inner join tbltimesheets TS on TE.TimesheetEntryID = TS.TimesheetEntryID Where TE.Type = "Repair" and TE.TypeID =' + inttostr(RepairsOBJ.ID) +
          ' union Select 5 as Category ,'+'"ServiceCharges"  as Type,'+' TS.TimesheetDate as Date,'+'TS.employeename  as Description,'+'  TS.TotalServicecharge   amtEx ,'+' TS.TotalServicecharge amtinc from tbltimesheetentry TE inner join tbltimesheets TS on TE.TimesheetEntryID = TS.TimesheetEntryID Where TE.Type = "Repair" and TE.TypeID =' + inttostr(RepairsOBJ.ID) +
          ' union Select 3 as Category ,'+'"TotalCost"       as Type,'+' RP.PartIssuedOn  as Date,'+'concat( RP.PartName ,  "-> " , RP.Qty , "  " , RP.UnitofMeasure , "(" , RP.UnitofMeasureMultiplier ,")")                           as Description,'+' RP.Linecost    ,'+' RP.LinecostInc  from tblrepairparts RP where RepairID  =' + inttostr(RepairsOBJ.ID) +
          ' union Select 4 as Category ,'+'"TotalInc"        as Type,'+' RP.PartIssuedOn  as Date,'+'concat( RP.PartName ,  "-> " , RP.Qty , "  " , RP.UnitofMeasure , "(" , RP.UnitofMeasureMultiplier ,")")                           as Description,'+' RP.Linetotalex ,'+' (RP.PriceInc * RP.Qty + RP.Markup - RP.Discount)   from tblrepairparts RP where RepairID  =' + inttostr(RepairsOBJ.ID) +
          ' union Select 6 as Category ,'+'"InvoiceTotal"    as Type,'+' S.saleDate       as Date,'+'concat( SL.productname,"-> " , SL.UnitofMeasureShipped, "  " , SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")")as Description,'+' SL.TotalLineAmount amtEx ,'+' SL.TotalLineAmountInc amtinc  from tblsales S inner join tblsaleslines SL on S.SAleId = SL.saleID  where IsInvoice = "T" and Repairglobalref = ' + Quotedstr(RepairsOBJ.Globalref) +
          ' order by Category , date ');
      clog(ds.SQL.Text);
      ds.Open;
      InitMsgParams;
      PopupMsgParams.Msgcaption := 'Repair Summary';
      PopupMsgParams.Msgds := ds;
      PopupMsgParams.Custombuttons :='"Ok"';
      PopupMsgParams.fieldnames := 'Type,Date,Description,amtEx,amtinc';
      PopupMsgParams.displayLabels:= 'Type,Date,Description,Ex,Inc';
      PopupMsgParams.DisplayWidths :='80,80,150, 80,80';
      PopupMsgParams.Msg1:=btnTotalCost.caption +' summary';
      PopupMsgParams.Msg2 := '';
      PopupMsgParams.MsgColor := Self.Color;
      TfmMessageWithList.MsgDlg ;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(ds);
    end;
end;

procedure TRepairsGUI.pnlNotesTopResize(Sender: TObject);
begin
  inherited;
  txtFeedbackNotes.Left := (txtFeedbackNotes.Parent.Width Div 2) + 12;
  Label11.Left := txtFeedbackNotes.Left;
  txtFeedbackNotes.Width := txtFeedbackNotes.Parent.Width - txtFeedbackNotes.Left - 4;
  txtNotes.Width := txtFeedbackNotes.Left - 8;
  txtNotes.Height := txtNotes.Parent.Height - txtNotes.Top -4;
  txtFeedbackNotes.Height := txtNotes.Height;
end;

procedure TRepairsGUI.lblPOBosClick(Sender: TObject);
begin
  inherited;
  Mainbuttonclick(findbutton(TabSmartOrders.Pageindex));
end;

Procedure TRepairsGUI.LblAppointmentClick(Sender: TObject);
Begin
  //TabCtl20.ActivePageIndex := Tabappointment.Tabindex;
  Mainbuttonclick(findbutton(Tabappointment.Pageindex));
End;

Procedure TRepairsGUI.LblsmartOrdersClick(Sender: TObject);
Begin
  //TabCtl20.ActivePageIndex := TabSmartOrders.Tabindex;
  Mainbuttonclick(findbutton(TabSmartOrders.Pageindex));
End;

Procedure TRepairsGUI.LblbillsClick(Sender: TObject);
Begin
  //TabCtl20.ActivePageIndex := TabBills.TabIndex;
  Mainbuttonclick(findbutton(TabBills.Pageindex));
End;

Procedure TRepairsGUI.LblInvoicesClick(Sender: TObject);
Begin
  //TabCtl20.ActivePageIndex := TabInvoices.Tabindex;
  Mainbuttonclick(findbutton(TabInvoices.Pageindex));
End;

Procedure TRepairsGUI.LblRAsClick(Sender: TObject);
Begin
  //TabCtl20.ActivePageIndex := TabRa.Tabindex;
  Mainbuttonclick(findbutton(TabRa.Pageindex));
End;

Procedure TRepairsGUI.LblSalesOrdersClick(Sender: TObject);
Begin
  //TabCtl20.ActivePageIndex := TabSalesOrders.Tabindex;
  Mainbuttonclick(findbutton(TabSalesOrders.Pageindex));
End;

Procedure TRepairsGUI.CboFaultConditionDescCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Not Modified Then Exit;
  Inherited;
  RepairsOBJ.RepairDetails.FaultConditionID   := QryRepairFaultsConditionRepairFaultID.AsInteger;
  RepairsOBJ.RepairDetails.FaultConditionCode := QryRepairFaultsConditioncode.AsString;
End;

Procedure TRepairsGUI.CboFaultSymptomDescCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Not Modified Then Exit;
  Inherited;
  RepairsOBJ.RepairDetails.FaultSymptomID   := QryRepairFaultsConditionRepairFaultID.AsInteger;
  RepairsOBJ.RepairDetails.FaultsymptomCode := QryRepairFaultssymptomcode.AsString;
End;

Procedure TRepairsGUI.CboFaultDefectDescCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Not Modified Then Exit;
  Inherited;
  RepairsOBJ.RepairDetails.FaultDefectID   := QryRepairFaultsDefectRepairFaultID.AsInteger;
  RepairsOBJ.RepairDetails.FaultDefectCode := QryRepairFaultsDefectcode.AsString;
End;

Procedure TRepairsGUI.CboFaultRepairDescCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Not Modified Then Exit;
  Inherited;
  RepairsOBJ.RepairDetails.FaultRepairID   := QryRepairFaultsRepairRepairFaultID.AsInteger;
  RepairsOBJ.RepairDetails.FaultRepairCode := QryRepairFaultsRepaircode.AsString;
End;

Procedure TRepairsGUI.CboFaultSectionDescCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Not Modified Then Exit;
  Inherited;
  RepairsOBJ.RepairDetails.FaultSectionID   := QryRepairFaultsSectionRepairFaultID.AsInteger;
  RepairsOBJ.RepairDetails.FaultSectionCode := QryRepairFaultsSectioncode.AsString;
End;

Procedure TRepairsGUI.ShowEquipform;
Begin
  EquipmentxRefForm := TfmEquipmentxRef.CreateEquipmentxREf(Self, TblDetails, AccessLevel = 5, '', RepairsOBJ.Clientid, 98, BeforeShowEquipmentxRefForm);
  If Assigned(EquipmentxRefForm) Then Begin
    EquipmentxRefForm.Name              := 'repairs' + FormatDatetime('hhnnsszz', Now) + Inttostr(RepairsOBJ.ID);
    EquipmentxRefForm.Pnlfooter.Visible := False;
    EquipmentxRefForm.Align             := Alclient;
    EquipmentxRefForm.Parent            := PnlEquipments;
    EquipmentxRefForm.BorderStyle       := BsNone;
    EquipmentxRefForm.EquipmentxRef     := RepairsOBJ.RepairEquipment;
    EquipmentxRefForm.Show;
  End;
  EquipmentTabshown := True;
End;

Procedure TRepairsGUI.BeforeShowEquipmentxRefForm(Sender: TObject);
Begin
  If Not(Sender Is TfmEquipmentxRef) Then Exit;
  TfmEquipmentxRef(Sender).Guiprefs.Active := True;

  TfmEquipmentxRef(Sender).CboRepairFault.LookupTable := QryrepairFaults;
  TfmEquipmentxRef(Sender).GrdEquip.AddField('Repairfault');
  TfmEquipmentxRef(Sender).Guiprefs.DbGridElement[TfmEquipmentxRef(Sender).GrdEquip].UnHideField('Repairfault');
  TfmEquipmentxRef(Sender).GrdEquip.ColumnByName('Repairfault').DisplayLabel := 'Repair fault';
  TfmEquipmentxRef(Sender).CboRepairFault.Datafield                          := 'Repairfault';
  TblDetailsRepairfault.Index                                                := TblDetailsCustomerEquipmentID.Index + 1;

  TfmEquipmentxRef(Sender).GrdEquip.AddField('Signature');
  TfmEquipmentxRef(Sender).Guiprefs.DbGridElement[TfmEquipmentxRef(Sender).GrdEquip].UnHideField('Signature');
  TfmEquipmentxRef(Sender).GrdEquip.ColumnByName('Signature').DisplayLabel := 'Signature';
End;


Procedure TRepairsGUI.DNMSpeedButton1Click(Sender: TObject);
Var
  ExportRepairsObj: TExportRepairsObj;
Begin
  DisableForm;
  Try
    RepairsOBJ.RepairEquipment.PostDB;
    If RepairsOBJ.RepairEquipment.Count = 0 Then Begin
      MessageDlgXP_Vista('Please Add Equipment to The Repair. Repairs Without Equipment Cannot be Exported', MtWarning, [Mbok], 0);
      Exit;
    End;
    RepairsOBJ.RepairDetails.PostDB;
    If RepairsOBJ.RepairDetails.Count = 0 Then Begin
      MessageDlgXP_Vista('Please Provide the Extra Info. Repairs Without Extra Info Cannot be Exported', MtWarning, [Mbok], 0);
      Exit;
    End;
    Inherited;
    Try
      If Not SaveRepair (*RepairsOBJ.Save*) Then Exit;
    Except
      // kill exception if any
    End;
    RepairsOBJ.Connection.CommitTransaction;
    ExportRepairsObj := TExportRepairsObj.Create(Self);
    Try
      ExportRepairsObj.RepairIDs := IntToStr(RepairsOBJ.ID);
      If ExportRepairsObj.Exportdata(RepairsOBJ.Customer.ClientName + ' Repair #' + IntToStr(RepairsOBJ.ID) + '.pdi') <> '' Then Begin
        RepairsObj.DetailsExported := True;
        RepairsObj.PostDB;
      End
      Else Exit;
    Finally Freeandnil(ExportRepairsObj);
    End;
  Finally EnableForm;
  End;
  Self.CloseWait;
End;

Procedure TRepairsGUI.CboManufactureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Not Modified Then Exit;
  Inherited;
  RepairsOBJ.RepairDetails.ManufactureID := QryManufactureID.AsInteger;
  RepairsOBJ.RepairDetails.Manufacture   := QryManufactureName.AsString;
  (* if qryManufactureReceiptNumberCaption.asString <> '' then
    RepairsOBJ.RepairDetails.ReceiptNumberCaption := qryManufactureReceiptNumberCaption.asString
    else RepairsOBJ.RepairDetails.ReceiptNumberCaption := 'GSFS Receipt Number'; *)
  RepairsOBJ.RepairDetails.ReceiptNumberCaption := RepairsOBJ.RepairDetails.ManufactureObj.RepairsExportConfig.ReceiptNumberCaption;

End;

Procedure TRepairsGUI.CboManufactureEnter(Sender: TObject);
Begin
  Inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
End;

Procedure TRepairsGUI.GrdSODblClick(Sender: TObject);
Begin
  Inherited;
  OpenTransRecord(QrySmartOrderHeader, 'SmartOrderID', 'Smart Order', 'TSmartOrderGUI');
End;

Procedure TRepairsGUI.GrdSmartOrderDblClick(Sender: TObject);
Begin
  Inherited;
  If ((Sysutils.SameText(GrdSmartOrder.Getactivefield.FieldName, 'QtySold')) Or (Sysutils.SameText(GrdSmartOrder.Getactivefield.FieldName, 'Shipped')) Or
    (Sysutils.SameText(GrdSmartOrder.Getactivefield.FieldName, 'Backorder')) Or (Sysutils.SameText(GrdSmartOrder.Getactivefield.FieldName, 'PurchaseOrderID'))) And
    (QrySmartOrdersPurchaseOrderID.AsInteger <> 0) Then Begin
    OpenTransRecord(QrySmartOrders, 'PurchaseOrderId', 'Purchase Order', 'TPurchaseGUI');
  End Else Begin
    OpenTransRecord(QrySmartOrderHeader, 'SmartOrderID', 'Smart Order', 'TSmartOrderGUI');
  End;
End;

Procedure TRepairsGUI.QrySmartOrderHeaderAfterScroll(DataSet: TDataSet);
Begin
  Inherited;
  QrySmartOrders.ParamByName('SmartOrderID').AsInteger := Self.QrySmartOrderHeaderSmartOrderID.AsInteger;
  If QrySmartOrders.Active Then Begin
    QrySmartOrders.Close;
    QrySmartOrders.Open;
  End;
End;

Procedure TRepairsGUI.QrySmartOrdersCalcFields(DataSet: TDataSet);
Begin
  Inherited;
  QrySmartOrdersBackOrder.AsFloat     := QrySmartOrdersQtySold.Asfloat - QrySmartOrdersShipped.Asfloat;
  QrySmartOrdersBackOrdercost.AsFloat := QrySmartOrdersBackOrder.AsFloat * QrySmartOrdersBOCost.AsFloat;
End;

procedure TRepairsGUI.qryStatusBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if  AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanApproveRepairForInvoicing') <> 1 then begin
    Showcontrolhint(cboStatus, 'You don''t have access to change the status to '+ quotedstr(appenv.CompanyPrefs.RepairStatustoMakeInvoice)+ '');
  end;
end;

Procedure TRepairsGUI.QryTimesheetsCalcFields(DataSet: TDataSet);
Begin
  Inherited;
  If QryTimesheetssignature.Value = Null Then
    QryTimesheetsSignatureMemo.AsString := ''
  Else
    QryTimesheetsSignatureMemo.AsString := '[• • •]';

  if qryTimesheetsOverheadRate.isNull then
    qryTimesheetsOverheadCost.AsFloat := qrytimesheetsLabourCost.AsFloat
  else
    qryTimesheetsOverheadCost.AsFloat := qrytimesheetsLabourCost.AsFloat * ((100 + qryTimesheetsOverheadRate.asFloat) / 100);
End;

Procedure TRepairsGUI.CboStatusDblClick(Sender: TObject);
Begin
  Inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_StatusType);
End;

Procedure TRepairsGUI.ShowEquipmentParts;
Begin
  EquipmentName := RepairsOBJ.RepairParts.EquipmentName;
  EquipmentId   := RepairsOBJ.RepairParts.CustomerEquipmentId;
  OpenERPListFormultiselect('TEquipmentsparePartsGUI', FilterForEquipment, true, OnProductSelect)
End;

Procedure TRepairsGUI.FilterforEquipment(Sender: Tobject);
Begin
  If Sender Is TEquipmentsparePartsGUI Then Begin
    TEquipmentsparePartsGUI(Sender).Equipmentname    := RepairsOBJ.RepairParts.EquipmentName;
    TEquipmentsparePartsGUI(Sender).OnGridDataSelect := OnProductSelect;
  End;
End;

function TRepairsGUI.findbutton(const btnIndex: Integer): TObject;
begin
  REsult := Findcomponent('mainbutton' + trim(inttostr(btnIndex)));
end;

Procedure TRepairsGUI.AddProducts(Sender: Tobject);
Begin
  (* if sender is TDNMSpeedButton then
    if Assigned(TDNMSpeedButton(SendeR).Owner) then
    if TDNMSpeedButton(SendeR).Owner is TEquipmentsparePartsGUI then begin *)
  If Sender Is TEquipmentsparePartsGUI Then Begin
    TEquipmentsparePartsGUI(Sender).AddProducts(DoAddProducts);
    TEquipmentsparePartsGUI(Sender).Close;
  End;
  EquipmentName := '';
  EquipmentId   := 0;
End;

Procedure TRepairsGUI.DoAddProducts(Sender: TObject);
Begin
  If Not(Sender Is TERPQuery) Then Exit;
  If TERPQuery(Sender).FindField('ProductName') = Nil Then Exit;
  RepairsOBJ.RepairParts.New;
  RepairsOBJ.RepairParts.ProductNAme         := TERPQuery(Sender).Findfield('ProductName').AsString;
  RepairsOBJ.RepairParts.ProductId           := GetProduct(RepairsOBJ.RepairParts.ProductNAme);
  RepairsOBJ.RepairParts.EquipmentName       := EquipmentName;
  RepairsOBJ.RepairParts.CustomerEquipmentId := EquipmentId;
  RepairsOBJ.RepairParts.Quantity            := 0;
  RepairsOBJ.RepairParts.PostDB;
End;

Procedure TRepairsGUI.TblrepairpartsAfterOpen(DataSet: TDataSet);
Begin
  Inherited;
  TblrepairpartsPartIssuedOn.DisplayFormat := FormatSettings.ShortDateformat;
End;

Procedure TRepairsGUI.CboRetailerEnter(Sender: TObject);
Begin
  Inherited;
  FLastComboAccessed := CboRetailer;
End;

Procedure TRepairsGUI.CboRepairFaultDblClick(Sender: TObject);
Begin
  Inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_RepairFault, RepairsObj.RepairEquipmentFault.RepairFault);

End;

Procedure TRepairsGUI.CboRepairFaultNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
Begin
  Inherited;
  If CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', Mtconfirmation, [Mbyes, Mbno], 0) = MrYes Then Begin
    TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_RepairFault, NewValue);
    Closenopendb(CboRepairFault.LookupTable);
    If CboRepairFault.LookupTable.Locate('Name', NewValue, []) Then Begin
      RepairsObj.RepairEquipmentFault.RepairFault := NewValue;
      RepairsObj.RepairEquipmentFault.PostDB;
      Accept := True;
    End Else Begin
      Accept := False;
    End;
  End;
End;

Procedure TRepairsGUI.CboRetailerCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: Boolean);
Begin
  If Not Modified Then Exit;
  Inherited;
  RepairsOBJ.RepairDetails.RetailerID := QryRetailerClientID.AsInteger;
End;

(* procedure TRepairsGUI.SetManufactureId(sender: TObject);
  begin
  if sender is   TRepairExportHelpGUI then begin
  TRepairExportHelpGUI(Sender).ManufactureID := qryManufactureID.asInteger;
  TRepairExportHelpGUI(Sender).GotoExportfield :=GotoExportfield;
  end;

  end; *)

Procedure TRepairsGUI.DNMSpeedButton2Click(Sender: TObject);
Begin
  Inherited;
  (* OpenERPForm('TRepairExportHelpGUI' , 0 , nil , SetManufactureId) *)
  With TRepairExportHelpGUI(GetComponentByClassName('TRepairExportHelpGUI', True, Self)) Do Begin
    If Not Visible Then Begin
      ManufactureID   := QryManufactureID.AsInteger;
      GotoExportfield := Self.GotoExportfield;
      FormStyle       := FsMDIChild;
    End;
    BringtoFront;
  End;
End;

procedure TRepairsGUI.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
   AddDateTime(lcdOnLoganyway, txtNotes, true);
end;

procedure TRepairsGUI.DNMSpeedButton4Click(Sender: TObject);
begin
  inherited;
  AddDateTime(lcdOnLoganyway, txtFeedbackNotes, true);
end;

procedure TRepairsGUI.btnShowTotalAmountIncClick(Sender: TObject);
begin
  inherited;
  showTotalInvAmountInc := not showTotalInvAmountInc;
end;

Procedure TRepairsGUI.BtnRAsClick(Sender: TObject);
Var
  SKeyIDs       : String;
  ProgressDialog: TProgressDialog;
  RAOnEquipment : Boolean;
  Field         : TField;
Begin
  If Not SaveRepair (*RepairsOBJ.Save*) Then Exit;
  If QryRAHeaders.Recordcount > 0 Then Begin
    LblRAsClick(LblRAs);
    If CommonLib.MessageDlgXP_Vista(IntToStr(QryRAHeaders.Recordcount) + ' Return Authority(s) Already Created for This Repair.  Do you Wish To Create Another Return Authority?', MtConfirmation,
      [Mbyes, Mbno], 0) = Mrno Then Exit;
  End
  Else If CommonLib.MessageDlgXP_Vista('Are You Sure You Want To Create a Return Authority  for this Repair?', MtConfirmation, [Mbyes, Mbno], 0) = Mrno Then Exit;
  ProgressDialog := TProgressDialog.Create(Nil);
  Try
    Field                     := GrdParts.GetActiveField;
    RAOnEquipment             := (Assigned(Field) And (Field.FieldName = 'Equipment'));
    RepairsObj.ProgressDialog := ProgressDialog;
    SKeyIDs                   := RepairsOBJ.CopyRepairsToRA(RAOnEquipment);
    If SKeyIDs <> '' Then TAudit.AddEntry('Main', RepairsOBJ.Globalref, 'RAs Created - ID(s) : ' + SKeyIDs, NIL, RepairsOBJ.XMLNodeName, TERPConnection(RepairsOBJ.Connection.Connection),RepairsOBJ.CleanId=0);
  Finally ProgressDialog.Free;
  End;
  If RepairsObj.ResultStatus.HasAnyMessage Then CommonLib.MessageDlgXP_Vista(Trim(RepairsObj.ResultStatus.Messages), MtInformation, [MbOk], 0);

  If SKeyIDs <> '' Then Begin
    ShowRAs(SKeyIDs);
  End;
End;

Procedure TRepairsGUI.ShowRAs(Const RAIDs: String);
Var
  IDList      : TStringlist;
  TmpComponent: TComponent;
  X           : Integer;
Begin
  If RAIDs = '' Then Exit;
  IDList := TStringList.Create;
  Try
    FastFuncs.Split(RAIDs, ',', IDList);
    If IDList.Count = 0 Then Exit;
    If MessageDlgXP_Vista('Created ' + IntToStr(IDList.Count) + ' Return Authority(s).  ' + 'Do you wish to view them?', Mtconfirmation, [MbYes, MbNo], 0) = Mrno Then Exit;
    For X := 0 To IDList.Count - 1 Do Begin
      OpenErpform('TReturnAGUI', FastFuncs.StrToInt(IDList[X]));
      TmpComponent := FindExistingComponent('TReturnAGUI', 0);
      While FormStillOpen('TReturnAGUI', TForm(TmpComponent)) Do Begin
        Application.ProcessMessages;
        Sleep(100);
      End;
    End;
  Finally FreeandNil(IDList);
  End;
End;

Procedure TRepairsGUI.BtnSalesOrderClick(Sender: TObject);
Begin
  fsSalesFormName :='TSalesOrderGUI';
  fsSalesType :='Sales Order''s';
  try
    If Not SaveRepair (*RepairsOBJ.Save*) Then Exit;

      if Appenv.CompanyPrefs.IsSalesCategoryMandatory then
        While TSalesCategory.DefaultTypeName = '' do
          if MessageDlgXP_Vista('''Sales Category'' is a Mandatory Field for Invoice, Sales Order and Quote and you don''t have a ''Default'' Sales Category created. Would you like to Create a Default Sales Category?', mtConfirmation, [mbYes, mbNo], 0) = mrno then Exit
          else TfmSimpleTypes.DoSimpleTypesSelect(SimpleTypes_SalesCategory);

    If QrySalesOrders.Recordcount > 0 Then Begin
      LblRAsClick(LblRAs);
      If CommonLib.MessageDlgXP_Vista(IntToStr(QrySalesOrders.Recordcount) + ' Sales Order Already Created for This Repair.  Do you Wish To Create Another Sales Order?', MtConfirmation, [Mbyes, Mbno],
        0) = Mrno Then Exit;
    End Else If CommonLib.MessageDlgXP_Vista('Are You Sure You Want To Create a Sales Order for this Repair?', MtConfirmation, [Mbyes, Mbno], 0) = Mrno Then Exit;

    ProcessingCursor;
    Try
      If Not SaveRepair (*RepairsOBJ.Save*) Then Exit;
      RepairsOBJ.Connection.CommitTransaction;
      SaleIDs := RepairsObj.CopyRepairtoSales(TSalesOrder.Classname);
      If SaleIDs <> '' Then Begin
        TAudit.AddEntry('Main', RepairsOBJ.Globalref, 'Sales Order(s) Created - ID(s) : ' + SaleIDs, NIL, RepairsOBJ.XMLNodeName, TERPConnection(RepairsOBJ.Connection.Connection),RepairsOBJ.CleanId=0);
        Self.CloseWait;
      End;
    Finally
      ProcessingCursor(False);
    End;
  finally
    fsSalesFormName :='';
    fsSalesType :='';
  end;
End;

Procedure TRepairsGUI.GotoExportfield(Const Value: String);
Begin
  If Sysutils.SameText(Value, 'F1') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(EdtReceiptNo)
  End
  Else If Sysutils.SameText(Value, 'F2') Then Begin
    SetPagecontrolFocus(EdtRepairNo);
  End
  Else If Sysutils.SameText(Value, 'F3') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(Edtmodel);
  End
  Else If Sysutils.SameText(Value, 'F4') Then Begin
  End
  Else If Sysutils.SameText(Value, 'F5') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(EdtDerial);
  End
  Else If Sysutils.SameText(Value, 'F6') Then Begin
  End
  Else If Sysutils.SameText(Value, 'F7') Then Begin
    SetPagecontrolFocus(CboClientJob);
  End
  Else If Sysutils.SameText(Value, 'F8') Then Begin
    SetPagecontrolFocus(TxtClientDetails);
  End
  Else If Sysutils.SameText(Value, 'F9') Then Begin
    SetPagecontrolFocus(TxtClientDetails);
  End
  Else If Sysutils.SameText(Value, 'F10') Then Begin
    SetPagecontrolFocus(TxtClientDetails);
  End
  Else If Sysutils.SameText(Value, 'F11') Then Begin
    SetPagecontrolFocus(TxtClientDetails);
  End
  Else If Sysutils.SameText(Value, 'F12') Then Begin
    SetPagecontrolFocus(EdtCPhone);
  End
  Else If Sysutils.SameText(Value, 'F13') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(CboWarrantydate);
  End
  Else If Sysutils.SameText(Value, 'F14') Then Begin
    SetPagecontrolFocus(DtCreationDate);
  End
  Else If Sysutils.SameText(Value, 'F15') Then Begin
    ChangeTab(Tabappointment);
    SetPagecontrolFocus(GrdAppointments, 'AppDate');
  End
  Else If Sysutils.SameText(Value, 'F16') Then Begin
    ChangeTab(Tabappointment);
    SetPagecontrolFocus(GrdAppointments, 'Actual_appDate');
  End
  Else If Sysutils.SameText(Value, 'F17') Then Begin
    ChangeTab(Tabappointment);
    SetPagecontrolFocus(GrdAppointments, 'Actual_Endtime');
  End
  Else If Sysutils.SameText(Value, 'F18') Then Begin
  End
  Else If Sysutils.SameText(Value, 'F19') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(CboFaultConditionDesc);
  End
  Else If Sysutils.SameText(Value, 'F20') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(CboFaultSymptomDesc);
  End
  Else If Sysutils.SameText(Value, 'F21') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(CboFaultDefectDesc);
  End
  Else If Sysutils.SameText(Value, 'F22') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(CboFaultRepairDesc);
  End
  Else If Sysutils.SameText(Value, 'F23') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(CboFaultSectionDesc);
  End
  Else If Sysutils.SameText(Value, 'F24') Then Begin
    ChangeTab(TabTimesheetEntries);
    SetPagecontrolFocus(TimeSheetForm, 'Total');
  End
  Else If Sysutils.SameText(Value, 'F25') Then Begin
    ChangeTab(Tabappointment);
    SetPagecontrolFocus(GrdAppointments, 'TotalInc');
  End
  Else If Sysutils.SameText(Value, 'F26') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(Edtmaterialcost);
  End
  Else If Sysutils.SameText(Value, 'F27') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(EdtFrightCost);
  End
  Else If Sysutils.SameText(Value, 'F28') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(EdtOtheramt);
  End
  Else If Sysutils.SameText(Value, 'F29') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(GrdServiceType);
  End
  Else If Sysutils.SameText(Value, 'F30') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(Edtauthno);
  End
  Else If Sysutils.SameText(Value, 'F31') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(MemAscClaimRemarks);
  End
  Else If Sysutils.SameText(Value, 'F32') Then Begin
    ChangeTab(TabNotes);
    SetPagecontrolFocus(TxtFeedbackNotes);
  End
  Else If Sysutils.SameText(Value, 'F33') Then Begin
  End
  Else If Sysutils.SameText(Value, 'F34') Then Begin
    ChangeTab(TabEquipment);
    SetPagecontrolFocus(EquipmentxRefForm, 'EquipmentName');
  End
  Else If Sysutils.SameText(Value, 'F35') Then Begin
    ChangeTab(TabEquipment);
    SetPagecontrolFocus(EquipmentxRefForm, 'Quantity');
  End
  Else If Sysutils.SameText(Value, 'F36') Then Begin
    ChangeTab(TabExtrainfo);
    SetPagecontrolFocus(EdtManInv);
  End
  Else If Sysutils.SameText(Value, 'F37') Then Begin
    ChangeTab(TabFollowupnProducts);
    SetPagecontrolFocus(GrdParts, 'Partname');
  End
  Else If Sysutils.SameText(Value, 'F38') Then Begin
    ChangeTab(TabFollowupnProducts);
    SetPagecontrolFocus(GrdParts, 'UOMqty');
  End
  Else If Sysutils.SameText(Value, 'F39') Then Begin
    ChangeTab(TabInvoices);
    SetPagecontrolFocus(GrdInvoices, 'SaleID');
  End;
End;

Procedure TRepairsGUI.ChangeTab(Const Tab: TTabSheet);
Begin
  If Tab <> Nil Then Begin
    TabCtl20.ActivePage := Tab;
    TabCtl20Change(TabCtl20);
  End;
End;

Procedure TRepairsGUI.SetPagecontrolFocus(Control: TWincontrol; Activefieldname: String = '');
Begin
  If Control <> Nil Then Begin
    SetControlFocus(Control);
    If Activefieldname <> '' Then
      If Control Is TwwDBGrid Then TwwDBGrid(Control).SetActiveField(Activefieldname)
      Else If Control = TimeSheetForm Then Begin
        SetControlFocus(TimeSheetForm.GrdTimesheets);
        TimeSheetForm.GrdTimesheets.SetActiveField(Activefieldname);
      End
      Else If Control = EquipmentxRefForm Then Begin
        SetControlFocus(EquipmentxRefForm.GrdEquip);
        EquipmentxRefForm.GrdEquip.SetActiveField(Activefieldname);
      End;
  End;
  BringTofront;
End;

Procedure TRepairsGUI.CboProductRDropDown(Sender: TObject);
Begin
  Inherited;
  FLastComboAccessed := CboProductR;
End;

Procedure TRepairsGUI.CboClientJobExit(Sender: TObject);
Begin
  Inherited;
  If Screen.Activecontrol <> BtnCancel Then Begin
    If Cboclientjob.Text = '' Then
      If RepairsOBJ.ClientID <> 0 Then Cboclientjob.Text := TcDataUtils.GetClientName(RepairsOBJ.ClientID);

    If Cboclientjob.Text = '' Then Begin
      Setcontrolfocus(Cboclientjob);
      MessageDlgXP_Vista('Customer Should not Be Blank', MtWarning, [Mbok], 0);
      Exit;
    End;
  End;
  if Appenv.CompanyPrefs.EnforceCustPOInrepairbeforeOtherInfo and RepairsOBJ.Customer.ForcePOOnRepair then
    if trim(RepairsOBJ.CustomerPONumber) = '' then
      Setcontrolfocus(edCustomerPO);
End;

Procedure TRepairsGUI.QryClientLookupBeforeOpen(DataSet: TDataSet);
Begin
  Inherited;
  //QryClientLookup.Parambyname('clientID').AsInteger := Repairsobj.ClientID;
End;

procedure TRepairsGUI.edtInvoicetotalDblClick (Sender: TObject);begin  if edtInvoicetotal.Hint<> '' then MessageDlgXP_vista(edtInvoicetotal.hint, mtInformation, [mbOK], 0);end;
procedure TRepairsGUI.txtTotalDblClick        (Sender: TObject);begin  if txttotal.Hint       <> '' then MessageDlgXP_vista(txttotal.hint       , mtInformation, [mbOK], 0);end;
procedure TRepairsGUI.txtCostDblClick         (Sender: TObject);begin  if txtCost.Hint        <> '' then MessageDlgXP_vista(txtCost.hint        , mtInformation, [mbOK], 0);end;

procedure TRepairsGUI.InitERPLookupCombonFields;
begin
  inherited;
  SetupProductNamenPrintNameinGrid(cboProductR ,cboPrintProductR ,'Partname' , 'ProductPrintName' , 'PARTSDESCRIPTION' , grdParts );
  if tblmaster.active then
    NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(RepairsOBJ.clientId,  cboClientJob,False, True, False, true , true , 'ClientPrintName' , nil, true);
end;

Initialization

RegisterClassOnce(TRepairsGUI);
FormFact.RegisterMe(TRepairsGUI, 'TRepairsList_*=RepairID');
FormFact.RegisterMe(TRepairsGUI, 'TRepairSummaryGUI_*=RepairID');
FormFact.RegisterMe(TRepairsGUI, 'TfmRepairsKPIList_*=RepairID');
FormFact.RegisterMe(TRepairsGUI, 'TRepairExpressListGUI_*=RepairID');
FormFact.RegisterMe(TRepairsGUI, 'TRepairListExpressGUI_*=RepairID');
FormFact.RegisterMe(TRepairsGUI, 'TRepairInvoiceListGUI_*=RepairID');
FormFact.RegisterMe(TRepairsGUI, 'TRepairListParts_*=RepairID');
FormFact.RegisterMe(TRepairsGUI, 'TRepairListEquipment_*=RepairID');
FormFact.RegisterMe(TRepairsGUI, 'TRepairListTimesheet_*=RepairID');
FormFact.RegisterMe(TRepairsGUI, 'TJobProfitabilityGUI_*_Repairs=SaleID');
FormFact.RegisterMe(TRepairsGUI, 'TJobProfitabilityforCustomerGUI_*_Repairs=SaleID');
FormFact.RegisterMe(TRepairsGUI, 'TInvoiceListGUI_ConvertFromRepair_*=Globalref');
FormFact.RegisterMe(TRepairsGUI, 'TGlobalsearchGUI_*_Repairs=TransId');
FormFact.RegisterMe(TRepairsGUI, 'TOtherfollowupsGUI_*_REpair=RepairID');
FormFact.RegisterMe(TRepairsGUI, 'TSalesRepairListGUI_*=RepairID');
FormFact.RegisterMe(TRepairsGUI, 'TNumberSequenceListGUI_*_Repairs=RepairID');
FormFact.RegisterMe(TRepairsGUI, 'TMemTransListGUI_*_Repairs=RepairID');
FormFact.RegisterMe(TRepairsGUI, 'TRepairProfitabilityGUI_*_Repairs=SaleID');
FormFact.RegisterMe(TRepairsGUI, 'TCustomFieldValuesListRepairsGUI_*=RepairID');

End.
