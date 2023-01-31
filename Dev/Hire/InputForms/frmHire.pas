unit frmHire;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel,
  ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusobjHire, wwdblook, ERPDbLookupCombo,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, Mask, ComCtrls, ad4DBControls, wwcheckbox,
  wwdbedit, Wwdotdot, Wwdbcomb, wwdbdatetimepicker, DNMAction, ActnList,
  IntegerListObj, DMComps;

type

  TfmHire = class(TBaseInputGUI)
    QryHire: TERPQuery;
    dsHire: TDataSource;
    QryHireLines: TERPQuery;
    dsHireLines: TDataSource;
    QryHirePartsSales: TERPQuery;
    dsHirePartsSales: TDataSource;
    QryTax: TERPQuery;
    cboClassQry: TERPQuery;
    cboEmployeeLookup: TERPQuery;
    cboAssetLookup: TERPQuery;
    cboLinesEmployeeLookup: TERPQuery;
    cboTermsQry: TERPQuery;
    dshireLinescount: TDataSource;
    dshirepartssalecount: TDataSource;
    dsSales: TDataSource;
    qryClientInvoicetoLookup: TERPQuery;
    qryClientLookup: TERPQuery;
    QryDurationRates: TERPQuery;
    QryhireLinesCount: TERPQuery;
    Qryhirepartssalecount: TERPQuery;
    QryProducts: TERPQuery;
    qryProductsParts: TERPQuery;
    QryProductsTax: TERPQuery;
    qryProductsUOM: TERPQuery;
    QrySales: TERPQuery;
    cboTax: TwwDBLookupCombo;
    cboTermsQryActive: TWideStringField;
    cboTermsQryEOM: TWideStringField;
    cboTermsQryEOMPlus: TWideStringField;
    cboTermsQryTerms: TWideStringField;
    cboTermsQryTermsAmount: TIntegerField;
    cboTermsQryTermsID: TIntegerField;
    qryClientInvoicetoLookupAltPhone: TWideStringField;
    qryClientInvoicetoLookupBillCountry: TWideStringField;
    qryClientInvoicetoLookupBillPostcode: TWideStringField;
    qryClientInvoicetoLookupBillState: TWideStringField;
    qryClientInvoicetoLookupBillStreet: TWideStringField;
    qryClientInvoicetoLookupBillStreet2: TWideStringField;
    qryClientInvoicetoLookupBillStreet3: TWideStringField;
    qryClientInvoicetoLookupBillSuburb: TWideStringField;
    qryClientInvoicetoLookupClientID: TIntegerField;
    qryClientInvoicetoLookupCompany: TWideStringField;
    qryClientInvoicetoLookupFaxNumber: TWideStringField;
    qryClientInvoicetoLookupfirstname: TWideStringField;
    qryClientInvoicetoLookupForcePOOnCustomer: TWideStringField;
    qryClientInvoicetoLookupIsJob: TWideStringField;
    qryClientInvoicetoLookupJobname: TWideStringField;
    qryClientInvoicetoLookupjobnumber: TIntegerField;
    qryClientInvoicetoLookuplastname: TWideStringField;
    qryClientInvoicetoLookupmobile: TWideStringField;
    qryClientInvoicetoLookupParentClientID: TIntegerField;
    qryClientInvoicetoLookupPhone: TWideStringField;
    qryClientInvoicetoLookupPostcode: TWideStringField;
    qryClientInvoicetoLookupState: TWideStringField;
    qryClientInvoicetoLookupStopCredit: TWideStringField;
    qryClientInvoicetoLookupStopCreditImage: TIntegerField;
    qryClientInvoicetoLookupStreet: TWideStringField;
    qryClientInvoicetoLookupStreet2: TWideStringField;
    qryClientInvoicetoLookupStreet3: TWideStringField;
    qryClientInvoicetoLookupSuburb: TWideStringField;
    qryClientInvoicetoLookupTaxID: TIntegerField;
    qryClientInvoicetoLookuptitle: TWideStringField;
    qryClientInvoicetoLookupWarrantyFinishDate: TDateTimeField;
    qryClientLookupAltPhone: TWideStringField;
    qryClientLookupBillCountry: TWideStringField;
    qryClientLookupBillPostcode: TWideStringField;
    qryClientLookupBillState: TWideStringField;
    qryClientLookupBillStreet: TWideStringField;
    qryClientLookupBillStreet2: TWideStringField;
    qryClientLookupBillStreet3: TWideStringField;
    qryClientLookupBillSuburb: TWideStringField;
    qryClientLookupClientId: TIntegerField;
    qryClientLookupCompany: TWideStringField;
    qryClientLookupCountry: TWideStringField;
    qryClientLookupDefaultPostAccount: TWideStringField;
    qryClientLookupDefaultPostAccountID: TIntegerField;
    qryClientLookupFax: TWideStringField;
    qryClientLookupForcePOOnInvoice: TWideStringField;
    qryClientLookupInvBaseNumber: TIntegerField;
    qryClientLookupIsJob: TWideStringField;
    qryClientLookupPhone: TWideStringField;
    qryClientLookupPostcode: TWideStringField;
    qryClientLookupRepID: TIntegerField;
    qryClientLookupShippingID: TIntegerField;
    qryClientLookupShippingMethod: TWideStringField;
    qryClientLookupState: TWideStringField;
    qryClientLookupStopCredits: TWideStringField;
    qryClientLookupStreet: TWideStringField;
    qryClientLookupStreet2: TWideStringField;
    qryClientLookupStreet3: TWideStringField;
    qryClientLookupSuburb: TWideStringField;
    qryClientLookupTaxID: TIntegerField;
    qryClientLookupTERMS: TWideStringField;
    qryClientLookupTermsID: TIntegerField;
    qryClientLookupUseInvBase: TWideStringField;
    qryClientLookupWarrantyFinishDate: TDateTimeField;
    QryDurationRatesDuration: TStringField;
    QryDurationRatesDurationId: TIntegerField;
    QryDurationRatesDurationName: TWideStringField;
    QryDurationRatesdurationtype: TWideStringField;
    QryDurationRatesQty: TFloatField;
    QryDurationRatesRate: TFloatField;
    QryHireBillCustomerID: TIntegerField;
    QryHireBillCustomerName: TWideStringField;
    QryHireBillToAddress: TWideStringField;
    QryHireClassID: TIntegerField;
    QryHireClassname: TWideStringField;
    QryHireContactID: TIntegerField;
    QryHireConverted: TWideStringField;
    QryHireCreatedDate: TDateField;
    QryHireCustomerID: TIntegerField;
    QryHireCustomerName: TWideStringField;
    QryHireEmployeeId: TIntegerField;
    QryHireemployeeName: TWideStringField;
    QryHireGlobalRef: TWideStringField;
    QryHireHireDate: TDateField;
    QryHireHireID: TIntegerField;
    QryHireHiretotal: TFloatField;
    QryHireLinesActualHireFrom: TDateTimeField;
    QryHireLinesActualHireFromtime: TWideStringField;
    QryHireLinesActualHireTo: TDateTimeField;
    QryHireLinesActualHiretoTime: TWideStringField;
    QryHireLinesConverted: TWideStringField;
    QryhireLinescountDescription: TWideStringField;
    QryHireLinesDeleted: TWideStringField;
    QryHireLinesDurationId: TIntegerField;
    QryHireLinesDurationName: TWideStringField;
    QryHireLinesDurationQty: TFloatField;
    QryHireLinesDurationRate: TFloatField;
    QryHireLinesEmployeeId: TIntegerField;
    QryHireLinesEmployeeName: TWideStringField;
    QryHireLinesGlobalRef: TWideStringField;
    QryHireLinesHireFrom: TDateTimeField;
    QryHireLinesHireFromtime: TWideStringField;
    QryHireLinesHireID: TIntegerField;
    QryHireLinesHireLineID: TIntegerField;
    QryHireLinesHireQty: TFloatField;
    QryHireLinesHireTo: TDateTimeField;
    QryHireLinesHiretoTime: TWideStringField;
    QryHireLinesHireUOMQty: TFloatField;
    QryHireLinesLineAmount: TFloatField;
    QryHireLinesLineAmountInc: TFloatField;
    QryHireLinesLineTaxCode: TWideStringField;
    QryHireLinesLineTaxRate: TFloatField;
    QryHireLinesmsTimeStamp: TDateTimeField;
    QryHireLinesmsUpdateSiteCode: TWideStringField;
    QryHireLinesPriceEx: TFloatField;
    QryHireLinesPriceInc: TFloatField;
    QryHireLinesStatus: TWideStringField;
    QryHireLinesUOM: TWideStringField;
    QryHireLinesUOMID: TIntegerField;
    QryHireLinesUOMMult: TFloatField;
    QryHiremsTimeStamp: TDateTimeField;
    QryHiremsUpdateSiteCode: TWideStringField;
    QryHireNotes: TWideMemoField;
    QryhirepartssalecountDescription: TWideStringField;
    QryHirePartsSalesConverted: TWideStringField;
    QryHirePartsSalesDeleted: TWideStringField;
    QryHirePartsSalesDescription: TWideStringField;
    QryHirePartsSalesDiscount: TFloatField;
    QryHirePartsSalesDiscountPercent: TFloatField;
    QryHirePartsSalesGlobalRef: TWideStringField;
    QryHirePartsSalesHireID: TIntegerField;
    QryHirePartsSalesHirePartsSaleID: TIntegerField;
    QryHirePartsSalesIsRelatedProduct: TWideStringField;
    QryHirePartsSalesLinecost: TFloatField;
    QryHirePartsSalesLineTotalEx: TFloatField;
    QryHirePartsSalesLineTotalInc: TFloatField;
    QryHirePartsSalesMarkup: TFloatField;
    QryHirePartsSalesMarkupPercent: TFloatField;
    QryHirePartsSalesMatrixDesc: TWideMemoField;
    QryHirePartsSalesMatrixPrice: TFloatField;
    QryHirePartsSalesMatrixRef: TWideMemoField;
    QryHirePartsSalesmsTimeStamp: TDateTimeField;
    QryHirePartsSalesmsUpdateSiteCode: TWideStringField;
    QryHirePartsSalesParentLineRef: TWideStringField;
    QryHirePartsSalesParentProductID: TLargeintField;
    QryHirePartsSalesPartBarcode: TWideStringField;
    QryHirePartsSalesPartIssuedOn: TDateTimeField;
    QryHirePartsSalesPriceEx: TFloatField;
    QryHirePartsSalesPriceInc: TFloatField;
    QryHirePartsSalesProductID: TIntegerField;
    QryHirePartsSalesProductName: TWideStringField;
    QryHirePartsSalesQty: TFloatField;
    QryHirePartsSalesRelatedProductQty: TFloatField;
    QryHirePartsSalesTaxCode: TWideStringField;
    QryHirePartsSalesTaxRate: TFloatField;
    QryHirePartsSalesUnitofMeasure: TWideStringField;
    QryHirePartsSalesUnitofMeasureID: TLargeintField;
    QryHirePartsSalesUnitofMeasureMultiplier: TFloatField;
    QryHirePartsSalesUOMQty: TFloatField;
    QryHireSalesTotal: TFloatField;
    QryHireShipAddressID: TIntegerField;
    QryHireShiptoAddress: TWideStringField;
    QryHireStatus: TWideStringField;
    QryHireTerms: TWideStringField;
    QryHireTermsID: TIntegerField;
    QryHireTotalamount: TFloatField;
    QryHireUseBillCust: TWideStringField;
    qryProductsPartsActive: TWideStringField;
    qryProductsPartsASSETACCNT: TWideStringField;
    qryProductsPartsAvgCost: TFloatField;
    qryProductsPartsBARCODE: TWideStringField;
    qryProductsPartsBuyQTY1: TIntegerField;
    qryProductsPartsBuyQTY2: TIntegerField;
    qryProductsPartsBuyQTY3: TIntegerField;
    qryProductsPartsCOGSACCNT: TWideStringField;
    qryProductsPartsCOST1: TFloatField;
    qryProductsPartsCOST2: TFloatField;
    qryProductsPartsCOST3: TFloatField;
    qryProductsPartsDept: TWideStringField;
    qryProductsPartsEditedFlag: TWideStringField;
    qryProductsPartsINCOMEACCNT: TWideStringField;
    qryProductsPartsManuf: TWideStringField;
    qryProductsPartsPARTNAME: TWideStringField;
    qryProductsPartsPARTSDESCRIPTION: TWideStringField;
    qryProductsPartsPARTSID: TIntegerField;
    qryProductsPartsPARTTYPE: TWideStringField;
    qryProductsPartsPRICE1: TFloatField;
    qryProductsPartsPRICE2: TFloatField;
    qryProductsPartsPRICE3: TFloatField;
    qryProductsPartsPRODUCTCODE: TWideStringField;
    qryProductsPartsPRODUCTGROUP: TWideStringField;
    qryProductsPartsSellQTY1: TIntegerField;
    qryProductsPartsSellQTY2: TIntegerField;
    qryProductsPartsSellQTY3: TIntegerField;
    qryProductsPartsSNTracking: TWideStringField;
    qryProductsPartsSpecialDiscount: TWideStringField;
    qryProductsPartsSupplierProductCode: TWideStringField;
    qryProductsPartsTAXCODE: TWideStringField;
    qryProductsPartsType: TWideStringField;
    qryProductsPartsWHOLESALEPRICE: TFloatField;
    qryProductsUOMBaseUnitName: TWideStringField;
    qryProductsUOMMultiplier: TFloatField;
    qryProductsUOMUnitDescription: TWideStringField;
    qryProductsUOMUnitID: TIntegerField;
    qryProductsUOMUnitName: TWideStringField;
    QrySalescustomerName: TWideStringField;
    QrySalesIsCashSale: TWideStringField;
    QrySalesIsInvoice: TWideStringField;
    QrySalesIsPOS: TWideStringField;
    QrySalesIsSalesOrder: TWideStringField;
    QrySalesSaleDate: TDateField;
    QrySalessaleID: TIntegerField;
    QrySalesSalestype: TWideStringField;
    QrySalesTotalAmountInc: TFloatField;



    cboDurationName: TwwDBLookupCombo;
    DNMPanel4: TDNMPanel;
    DNMPanel6: TDNMPanel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel2: TBevel;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit5: TDBEdit;
    txtNotes: TAddictSpellDBMemo;
    pnlHireEquipments: TDNMPanel;
    Label6: TLabel;
    grdHireEquipments: TwwDBGrid;
    btnDelete: TwwIButton;
    cboAsset: TERPDbLookupCombo;
    cboLinesEmployee: TwwDBLookupCombo;
    cboStatus: TwwDBComboBox;
    pnlProducts: TDNMPanel;
    Label5: TLabel;
    grdProducts: TwwDBGrid;
    wwIButton1: TwwIButton;
    cboProductsUOM: TwwDBLookupCombo;



    cboProductsProduct: TERPDbLookupCombo;
    cboProductsTax: TwwDBLookupCombo;
    pnlTop: TDNMPanel;
    Label160: TLabel;
    Label38: TLabel;
    Label2: TLabel;
    bvelCustomerDetails: TBevel;
    Label79: TLabel;
    ClassLabel: TLabel;
    Bevel7: TBevel;
    Label1: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    txtCustomID: TDBEdit;
    chkUseBillCust: TDBCheckBox;
    cboClientR: TERPDbLookupCombo;
    btnContacts: TDNMSpeedButton;
    cboBillClientName: TERPDbLookupCombo;
    btnShipment: TDNMSpeedButton;
    txtClientDetails: TDBMemo;
    OptStatus: TDBRadioGroup;
    cboTerms: TwwDBLookupCombo;
    cboClass: TwwDBLookupCombo;
    txtShipTo: TDBMemo;
    DNMPanel1: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnRepeat: TDNMSpeedButton;
    btnCopy: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Bevel1: TBevel;
    Bevel3: TBevel;
    btnconvertToSale: TDNMSpeedButton;
    Label48: TLabel;
    cboEmployee: TwwDBLookupCombo;
    Bevel4: TBevel;
    DNMSpeedButton5: TDNMSpeedButton;
    lsTDNMSpeedButtonActions: TActionList;
    actPreview: TAction;
    actPrint: TAction;
    actNew: TAction;
    actSave: TAction;
    actConvertToSale: TDNMAction;
    actInvoice: TDNMAction;
    actSalesOrder: TDNMAction;
    actPOS: TDNMAction;
    actCashSale: TDNMAction;
    actSmartOrder: TDNMAction;
    btnPayments: TDNMSpeedButton;
    DBCheckBox1: TDBCheckBox;
    dtHireFrom: TwwDBDateTimePicker;
    dtActualHireFrom: TwwDBDateTimePicker;
    dtActualHireTo: TwwDBDateTimePicker;
    dtHireTo: TwwDBDateTimePicker;
    SaleDate_Label: TLabel;
    cboCreationDate: TwwDBDateTimePicker;
    lblMsg: TLabel;
    cboEstimatedDateTime: TwwDBComboDlg;
    Label9: TLabel;
    Splitter1: TSplitter;
    QryHireCustomerPONumber: TWideStringField;
    edtCustomerPONumber: TDBEdit;
    Label11: TLabel;
    QryHireLinesAssetId: TIntegerField;
    QryHireLinesAssetName: TWideStringField;
    QryHireLinesIncomeAccountId: TIntegerField;
    cboAssetLookupAssetName: TWideStringField;
    cboAssetLookupAssetCode: TWideStringField;
    cboAssetLookupAssetID: TIntegerField;
    QryHireLinesHireProductId: TIntegerField;
    QryHireLinesHireProductName: TWideStringField;
    QryHireDeleted: TWideStringField;
    QryHireLinesAssetCode: TWideStringField;
    btnPlanner: TDNMSpeedButton;
    actOpenPlanner: TDNMAction;
    QryHireLinesAlloc: TStringField;
    QryHireDefaultHireFrom: TDateTimeField;
    QryHireDefaultHireTo: TDateTimeField;
    QryHireDefaultDurationId: TIntegerField;
    QryHireDefaultActualHireFrom: TDateTimeField;
    QryHireDefaultActualHireTo: TDateTimeField;
    QryHireDefaultActualDurationId: TIntegerField;
    QryHireDefaultDurationQty: TFloatField;
    QryHireDefaultAcutualDurationQty: TFloatField;
    QryHireLinesDetail: TStringField;
    btnAttachments: TDNMSpeedButton;
    DMTextTargetHire: TDMTextTarget;
    QryHireLinesProductPrintName: TWideStringField;
    QryHirePartsSalesProductPrintName: TWideStringField;
    QryHireClientBillPrintName: TWideStringField;
    QryHireClientPrintName: TWideStringField;
    cboPrintProductR: TERPDbLookupCombo;
    QryProductspartsId: TIntegerField;
    QryProductsPartname: TWideStringField;
    QryProductsPartsDescription: TWideStringField;
    QryHireLinesSalesDescription: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnContactsClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure QrySalesBeforeOpen(DataSet: TDataSet);
    procedure QryhirepartssalecountBeforeOpen(DataSet: TDataSet);
    procedure QryhireLinesCountBeforeOpen(DataSet: TDataSet);
    procedure QryHireLinesAfterPost(DataSet: TDataSet);
    procedure QryHirePartsSalesAfterPost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkUseBillCustExit(Sender: TObject);
    procedure cboAssetLookupBeforeOpen(DataSet: TDataSet);
    procedure cboAssetBeforeOpenList(Sender: TObject);
    procedure QryTaxBeforeOpen(DataSet: TDataSet);
    procedure QryProductsTaxBeforeOpen(DataSet: TDataSet);
    procedure btnShipmentClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnRepeatClick(Sender: TObject);
    procedure grdHireEquipmentsTitleButtonClick(Sender: TObject;AFieldName: string);
    procedure grdProductsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure wwIButton1Click(Sender: TObject);
    //procedure Doconvert(Sender: TObject);
    procedure OnupdateSalesActions(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure grdHireEquipmentsEnter(Sender: TObject);
    procedure grdHireEquipmentsDblClick(Sender: TObject);
    procedure actConvertToSaleUpdate(Sender: TObject);
    procedure QryHireAfterOpen(DataSet: TDataSet);
    procedure cboDurationNameCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure QryDurationRatesCalcFields(DataSet: TDataSet);
    procedure CustomiseGridClick(Sender: TObject);
    procedure actConvertToSaleExecute(Sender: TObject);
    procedure pnlSalesOptionsExit(Sender: TObject);
    procedure actPOSExecute(Sender: TObject);
    procedure btnPaymentsClick(Sender: TObject);
    procedure DNMSpeedButton5Click(Sender: TObject);
    procedure grdHireEquipmentsColEnter(Sender: TObject);
    procedure popCustomiseGridPopup(Sender: TObject);
    procedure cboAssetCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboAssetDoGridDataSelect(Sender: TObject);
//    procedure btnPrintClick(Sender: TObject);
    procedure DoPrintOptions(Sender : TObject);
    procedure grdHireEquipmentsExit(Sender: TObject);
    procedure convertHire(Sender: TObject);
    procedure actInvoiceExecute(Sender: TObject);
    procedure actSalesOrderExecute(Sender: TObject);
    procedure actCashSaleExecute(Sender: TObject);
    procedure actSmartOrderExecute(Sender: TObject);
    procedure cboEstimatedDateTimeCustomDlg(Sender: TObject);
    procedure cboAssetDblClick(Sender: TObject);
    procedure actOpenPlannerExecute(Sender: TObject);
    procedure dtHireTimeDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure QryHireLinesCalcFields(DataSet: TDataSet);
    procedure grdHireEquipmentsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAttachmentsClick(Sender: TObject);
    procedure DMTextTargetHireDrop(Sender: TObject; Acceptor: TWinControl;
      const DropText: string; X, Y: Integer);
    procedure QryHireAfterInsert(DataSet: TDataSet);
    procedure OptStatusClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
  private
    HireObj: THire;
    mnuShowtime : TMenuItem;
    fbcolspecificmsgShown:boolean;
    fiHireLineAssetId: Integer;
    fdQty:Double;
    fbCheck4Availability:Boolean;
    AssetIdList: TIntegerList;
    function SaveHire: Boolean;
    procedure initcontactList(Sender: TObject);
    procedure UpdateFromContact(Sender: TwwDbGrid);
    procedure intPOS(Sender: TObject);
    //procedure HideTabs(const TabToshow:Integer =0);
    procedure initShipingAddList(Sender: TObject);
    procedure OnSelectShippingAddress(Sender: TwwDbGrid);
    function CopyToPOS: Boolean;
    procedure RefreshDurationLookup;
    procedure intHireSalesList(Sender: TObject);
    Procedure Showtime(Sender: TObject);
    procedure OpenRelatedProducts;
    procedure AddrelatedProductsforSale(Sender: TwwDbGrid);
    procedure FilterForProduct(Sender: TObject);
    Procedure AddrelatedProductsforSaleCallback(Const Sender: TBusObj; var Abort: boolean);
    Procedure ReadExtraGuipref;
    Procedure WriteExtraGuiPref;
    function HirePrerequisitesOK: boolean;
//    procedure Check4Availability;
//    procedure UpDateHireQty(Sender: TwwDbGrid);
    procedure PlannerBeforeShow(Sender: TObject);
    //procedure DoBeforeShowAssetList(Sender: TObject);
    //procedure DoOnAssetListDataSelect(Sender: TwwDbGrid);
    procedure ShowAttachments(fbDragnDropping :Boolean);
    procedure RefreshCustomerLookup;
  Protected
    procedure CommitAndNotify;override;
    procedure KeyIdChanged(const NewKeyId: integer); override;
    function GetReportTypeID: integer; override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure InitERPLookupCombonFields; Override;
    procedure DoPrintHire(APrint : boolean);
    procedure DoPrint(Sender : TObject);
    procedure DoPreview(Sender : TObject);
    procedure DoEmail(Silent : boolean);
    procedure DoEmailSilent(Sender : TObject);
    procedure DoEmailStright(Sender : TObject);
//    procedure DoPrintOptions(Sender : TObject);

  public
    procedure TimerMsg(lbl:TLabel; const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);override;
  end;


implementation

uses CommonLib, BusObjConst, ContactList, CommonFormLib, (* *)tcConst,
  BusObjAudit, POSScreenGUI, EquipmentListForm, AppEnvironment, FormFactory,
  ShipAddressListForm, frmRepeat, CommonDbLib, DNMLib, commonGuiLib,
  tcDataUtils, frmReportingOptions, HireSalesList,
  HireSmartOrderList, {frmHiringTimes,} RelatedProducts, BusObjStock,
  frmDateTimeSelect, DbSharedObjectsObj, MySQLConst,
  LogLib, frmMessageWithList, frmMessageBase, BaseListingForm,
  FixedAssetsListFrm, frmHirePlanner, frmHireDefaultDuration,
  frmHireLineDetailEdit, frmHireLineAllocation, BusObjAssetHire,
  frmHireRateEdit, BusObjDuration, frmAttachments, EmailExtraUtils;

{$R *.dfm}

(*procedure TfmHire.Doconvert(Sender: TObject);
begin
  inherited;
  if not SaveHire then Exit;
  try
    CommitAndNotify;
    HireObj.Dirty := False;
    if (HireObj.hirelines.count =0) and  (HireObj.HirePartsSale.count =0) then exit;

             if sender = actInvoice     then begin if HireObj.CopyToInvoice     = 0 then Exit;
    end else if sender = actSaleSOrder  then begin if HireObj.CopyTosalesOrder  = 0 then Exit;
    end else if sender = actCashsale    then begin if HireObj.CopyToCashSale    = 0 then Exit;
    end else if sender = actSmartOrder  then begin if HireObj.CopyToSmartOrder  = 0 then Exit;
    end else if sender = actPOS         then begin if not CopyToPOS                 then Exit;
    end else exit;
    Self.close;
  finally
    beginTRansaction;
  end;
end;*)
Function TfmHire.CopyToPOS:Boolean ;
begin
  Result := False;
  if not SaveHire then Exit;

  try
    HireObj.connection.CommitTransaction;
    Enableform;
    Try
      if CommonLib.MessageDlgXP_Vista('Are you sure you want to convert this hire to a POS  transaction?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
        OpenERPForm('TPOSScreenForm' , 0 , nil , intPOS);
        REsult := TRue;
      end;
    Finally
      Disableform;
    End;
  finally

  end;
end;
procedure TfmHire.CustomiseGridClick(Sender: TObject);
begin
  inherited;
  grdProducts.ColumnByName('converted').ReadOnly := True;
  grdHireEquipments.ColumnByName('converted').ReadOnly := True;
end;
(*
procedure TfmHire.btnPrintClick(Sender: TObject);
var
  s:String;
begin
  inherited;
  if not SaveHire then exit;
  HireObj.Dirty := False;
  HireObj.connection.CommitTransaction;
  HireObj.connection.BeginTransaction;

  s:= '~|||~Where HireId = ' + inttostr(HireObj.ID) +
     '~|||~Where HireId = ' + inttostr(HireObj.ID) +
      '~|||~Where HireId = ' + inttostr(HireObj.ID) ;
     fbReportSQLSupplied := False;

  PrintTemplateReport(TemplateReportName[False,''], s, sender = btnPrint, 1);
//  Self.Close;
end;
*)

procedure TfmHire.DMTextTargetHireDrop(Sender: TObject; Acceptor: TWinControl;
  const DropText: string; X, Y: Integer);
var
  Form: TComponent;
begin
  if qryHireHireId.AsInteger < 1 then
    Exit; // need id

  ShowAttachments(true);
  Form := TfmAttachments(GetComponentByClassName('TfmAttachments', true));
  if Assigned(Form) then // if has acess
      TfmAttachments(Form).DMTextTargetDrop(Sender, Acceptor, DropText, X, Y);
end;

procedure TfmHire.DNMSpeedButton5Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('THireSmartOrderListGUI' , intHireSalesList);

end;

procedure TfmHire.actConvertToSaleExecute(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
begin
  if not SaveHire  then Exit;
  CommitAndNotify;
  HireObj.Dirty := False;
  try
      OptsForm := TfmReportingOptions.Create(nil);
      try
        OptsForm.ReportformCaption := 'Hire';
        OptsForm.ActionList.AddDivider('Convert To');
        OptsForm.ActionList.Add('Invoice'     ,'Make an Invoice'                        ,actInvoiceExecute    , true, true, False);
        OptsForm.ActionList.Add('Sales Order'  ,'Make a Sales Order'                     ,actSalesOrderExecute , true, true, False);
        //OptsForm.ActionList.Add('POS'         ,'Make a POS'                             ,actPOSExecute        , true, true, False);
        OptsForm.ActionList.Add('Cash Sale'   ,'Make a Cash Sale'                       ,actCashSaleExecute   , True, true, False);
        OptsForm.ActionList.Add('Smart Order' ,'Make a Smart Order for the Sales Items' ,actSmartOrderExecute , true, true, False);
        OptsForm.ShowModal;
        CloseAfterPrint(OptsForm.CloseWhenDone);
      finally
        OptsForm.Free;
      end;
  finally
    beginTRansaction;
  end;

  end;

procedure TfmHire.actConvertToSaleUpdate(Sender: TObject);
begin
  inherited;
  actConvertToSale.Enabled := (HireObj.hirelines.count >0) ;
  if HireObj.hirelines.count =0 then begin
    AddDisablescontrolforHint(pnlTop , btnconvertToSale , 'Please Choose Item to Enable Convert Options ');
    //AddDisablescontrolforHint(pnlTop , btnSmartOrder , 'Please Choose Equipment to Enable Convert Options');
  end else begin
    AddDisablescontrolforHint(pnlTop , btnconvertToSale , '');
    //AddDisablescontrolforHint(pnlTop , btnSmartOrder , '');
  end;

end;


procedure TfmHire.actPOSExecute(Sender: TObject);
begin
  inherited;
  if CopyToPOS then Self.close;
end;

procedure TfmHire.actInvoiceExecute   (Sender: TObject);
begin
  inherited;
  convertHire(actInvoice);
end;

procedure TfmHire.actOpenPlannerExecute(Sender: TObject);
begin
  inherited;
  if not SaveHire then Exit;
  CommitAndNotify;
  HireObj.Dirty := False;
  self.AddFlag('OpenHirePlanner');
  Self.Close;
end;

procedure TfmHire.actSalesOrderExecute(Sender: TObject);begin  inherited; convertHire(actSalesOrder);end;
procedure TfmHire.actSmartOrderExecute(Sender: TObject);begin  inherited; convertHire(actSmartOrder);end;
procedure TfmHire.actCashSaleExecute  (Sender: TObject);begin  inherited; convertHire(actCashSAle);end;

procedure TfmHire.btnAttachmentsClick(Sender: TObject);
begin
  inherited;
  ShowAttachments(False);
end;

procedure TfmHire.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfmHire.btnContactsClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TContactListGUI' ,UpdateFromContact , initcontactList );
end;

procedure TfmHire.btnCopyClick(Sender: TObject);
var
  oHire : THire;
  lId : integer;
  idx : integer;
begin
  inherited;
  if not SaveHire then
    Exit;
  CommitAndNotify;

  oHire := THire.CreateWithNewConn(nil);
  oHire.New;
  oHire.HireLines;
  oHire.HirePartsSale;
  try
    HireObj.Dirty := False;
    oHire.Connection.BeginTransaction;

    oHire.CreatedDate := HireObj.CreatedDate;
    oHire.HireDate := HireObj.HireDate;
    oHire.CustomerID := HireObj.CustomerID;
    oHire.ShipAddressID := HireObj.ShipAddressID;
    oHire.UseBillCust := HireObj.UseBillCust;
    oHire.Converted := HireObj.Converted;
    oHire.BillCustomerID := HireObj.BillCustomerID;
    oHire.EmployeeId := HireObj.EmployeeId;
    oHire.BilltoAddress := HireObj.BilltoAddress;
    oHire.ShipToAddress := HireObj.ShipToAddress;
    oHire.CustomerName := HireObj.CustomerName;
    oHire.ClientPrintName := HireObj.ClientPrintName;
    oHire.BillCustomerName := HireObj.BillCustomerName;
    oHire.BillClientPrintName := HireObj.BillClientPrintName;
    oHire.DepartmentName := HireObj.DepartmentName;
    oHire.EmployeeName := HireObj.EmployeeName;
    oHire.ContactID := HireObj.ContactID;
    oHire.DepartmentID := HireObj.DepartmentID;
    oHire.Hiretotal := HireObj.Hiretotal; //@@
    oHire.SalesTotal := HireObj.SalesTotal;
    oHire.TotalAmount := HireObj.TotalAmount; //@@
    oHire.Notes := HireObj.Notes;
    oHire.Status := HireObj.Status;
    oHire.TermsID := HireObj.TermsID;
    oHire.Terms := HireObj.Terms;  //@@
//    oHire.HireLines := HireObj.HireLines;
//    oHire.HirePartsSale := HireObj.HirePartsSale;
    oHire.CustomerPONumber := HireObj.CustomerPONumber;
    oHire.Deleted := HireObj.Deleted;
    oHire.DefaultHireFrom := HireObj.DefaultHireFrom;
    oHire.DefaultHireTo := HireObj.DefaultHireTo;
    oHire.DefaultDurationId := HireObj.DefaultDurationId;
    oHire.DefaultDurationQty := HireObj.DefaultDurationQty;
    oHire.DefaultActualHireFrom := HireObj.DefaultActualHireFrom;
    oHire.DefaultActualHireTo := HireObj.DefaultActualHireTo;
    oHire.DefaultActualDurationId := HireObj.DefaultActualDurationId;
    oHire.DefaultActualDurationQty := HireObj.DefaultActualDurationQty;
    HireObj.HireLines.First;
    for idx := 0 to HireObj.HireLines.Count - 1 do
    begin
//    oHire.HireLines.HireID: Integer read GetHireID write SetHireID;
      oHire.HireLines.New;
      oHire.HireLines.EmployeeId:= HireObj.HireLines.EmployeeId;
//      oHire.HireLines.EmployeeName:= HireObj.HireLines.EmployeeName;
      oHire.HireLines.AssetId:= HireObj.HireLines.AssetId;
      oHire.HireLines.AssetCode:= HireObj.HireLines.AssetCode;
      oHire.HireLines.HireQty:= HireObj.HireLines.HireQty;
      oHire.HireLines.HireFromtime:= HireObj.HireLines.HireFromtime;
      oHire.HireLines.HireTotime:= HireObj.HireLines.HireTotime;
      oHire.HireLines.ActualHireFromTime:= HireObj.HireLines.ActualHireFromTime;
      oHire.HireLines.ActualHireToTime:= HireObj.HireLines.ActualHireToTime;
      oHire.HireLines.HireFrom:= HireObj.HireLines.HireFrom;
      oHire.HireLines.HireTo:= HireObj.HireLines.HireTo;
      oHire.HireLines.ActualHireTo:= HireObj.HireLines.ActualHireTo;
      oHire.HireLines.ActualHirefrom:= HireObj.HireLines.ActualHirefrom;
      oHire.HireLines.DurationId:= HireObj.HireLines.DurationId;
//      oHire.HireLines.DurationName:= HireObj.HireLines.DurationName;
//@@      oHire.HireLines.DurationRate:= HireObj.HireLines.DurationRate;
      oHire.HireLines.DurationQty:= HireObj.HireLines.DurationQty;
      oHire.HireLines.UOMID:= HireObj.HireLines.UOMID;
      oHire.HireLines.UOM:= HireObj.HireLines.UOM;
      oHire.HireLines.UOMMult:= HireObj.HireLines.UOMMult;
      oHire.HireLines.Status:= HireObj.HireLines.Status;
      oHire.HireLines.LineAmount:= HireObj.HireLines.LineAmount;
      oHire.HireLines.LineTaxCode:= HireObj.HireLines.LineTaxCode;
      oHire.HireLines.LineTaxRate:= HireObj.HireLines.LineTaxRate;
      oHire.HireLines.LineAmountInc:= HireObj.HireLines.LineAmountInc;
      oHire.HireLines.PriceEx:= HireObj.HireLines.PriceEx;
      oHire.HireLines.PriceInc:= HireObj.HireLines.PriceInc;
      oHire.HireLines.Deleted:= HireObj.HireLines.Deleted;
      oHire.HireLines.Converted:= HireObj.HireLines.Converted;
      oHire.HireLines.DurationRate:= HireObj.HireLines.DurationRate; //@@@
//      oHire.HireLines.HireReturnPQA:= HireObj.HireLines.HireReturnPQA;
      oHire.HireLines.IncomeAccountId:= HireObj.HireLines.IncomeAccountId;
      oHire.HireLines.HireProductName:= HireObj.HireLines.HireProductName;
      oHire.HireLines.HireProductPrintName:= HireObj.HireLines.HireProductPrintName;
      oHire.HireLines.HireProductId:= HireObj.HireLines.HireProductId;
//      oHire.HireLines.AssetName:= HireObj.HireLines.AssetName;
//    oHire.HireLines.AssetLines: THireLineAsset read GetAssetLines;

      oHire.HireLines.Planner := HireObj.HireLines.Planner;
      oHire.HireLines.PostDb;
      HireObj.HireLines.Next;
    end;

    HireObj.HirePartsSale.First;
    for idx := 0 to HireObj.HirePartsSale.Count - 1 do
    begin
      oHire.HirePartsSale.New;
//      oHire.HirePartsSale.HirePartsSaleID:= HireObj.HirePartsSale.HirePartsSaleID;
      oHire.HirePartsSale.HireID := oHire.Id; // HireObj.HirePartsSale.HireID;
      oHire.HirePartsSale.ProductID := HireObj.HirePartsSale.ProductID;
      oHire.HirePartsSale.Qty := HireObj.HirePartsSale.Qty;
      oHire.HirePartsSale.UOMQty := HireObj.HirePartsSale.UOMQty;
      oHire.HirePartsSale.Description:= HireObj.HirePartsSale.Description;
      oHire.HirePartsSale.PartType:= HireObj.HirePartsSale.PartType;
      oHire.HirePartsSale.UnitofMeasureMultiplier:= HireObj.HirePartsSale.UnitofMeasureMultiplier;
      oHire.HirePartsSale.Linecost:= HireObj.HirePartsSale.Linecost;
      oHire.HirePartsSale.PriceEx:= HireObj.HirePartsSale.PriceEx;
      oHire.HirePartsSale.PriceInc:= HireObj.HirePartsSale.PriceInc;
      oHire.HirePartsSale.TaxCode:= HireObj.HirePartsSale.TaxCode;
      oHire.HirePartsSale.TaxRate:= HireObj.HirePartsSale.TaxRate;
      oHire.HirePartsSale.LineTotalEx:= HireObj.HirePartsSale.LineTotalEx;
      oHire.HirePartsSale.LineTotalInc:= HireObj.HirePartsSale.LineTotalInc;
      oHire.HirePartsSale.Discount:= HireObj.HirePartsSale.Discount;
      oHire.HirePartsSale.Markup:= HireObj.HirePartsSale.Markup;
      oHire.HirePartsSale.DiscountPercent:= HireObj.HirePartsSale.DiscountPercent;
      oHire.HirePartsSale.MarkupPercent:= HireObj.HirePartsSale.MarkupPercent;
      oHire.HirePartsSale.Deleted:= HireObj.HirePartsSale.Deleted;
      oHire.HirePartsSale.Converted:= HireObj.HirePartsSale.Converted;
      oHire.HirePartsSale.ParentProductID:= HireObj.HirePartsSale.ParentProductID;
      oHire.HirePartsSale.ParentLineRef:= HireObj.HirePartsSale.ParentLineRef;
      oHire.HirePartsSale.RelatedProductQty:= HireObj.HirePartsSale.RelatedProductQty;
      oHire.HirePartsSale.IsRelatedProduct:= HireObj.HirePartsSale.IsRelatedProduct;
      oHire.HirePartsSale.PartBarcode:= HireObj.HirePartsSale.PartBarcode;
      oHire.HirePartsSale.PartIssuedOn:= HireObj.HirePartsSale.PartIssuedOn;
      oHire.HirePartsSale.PostDb;
      HireObj.HirePartsSale.Next;
    end;

    lId := oHire.Id;
    oHire.Save;
    oHire.PostDb;
    oHire.Connection.CommitTransaction;

  finally
    oHire.Free;
  end;
    HireObj.Load(lId);
    HireObj.connection.BeginTransaction;
    if HireObj.count=0 then HireObj.new;
    HireObj.HireLines;
    HireObj.HirePartsSale;
    openQueries;
    BeginTransaction;
    Setcontrolfocus(cboClientR);
end;

procedure TfmHire.initcontactList(Sender: TObject);
begin
  if not(Sender is   TContactListGUI) then exit;
  TContactListGUI(Sender).clientId := HireObj.CustomerId;
end;

procedure TfmHire.QryDurationRatesCalcFields(DataSet: TDataSet);
begin
  inherited;
  QryDurationRatesDuration.asString := floattoStrF(QryDurationRatesQty.asfloat , ffGeneral, 15, 2) +' ' +QryDurationRatesdurationtype.asString;
end;

procedure TfmHire.QryHireAfterInsert(DataSet: TDataSet);
begin
  RefreshCustomerLookup;
end;
procedure TfmHire.RefreshCustomerLookup;
begin
  inherited;
  closedb(qryClientLookup);
  InitERPLookupCombonFields;
  opendb(qryClientLookup);
end;

procedure TfmHire.QryHireAfterOpen(DataSet: TDataSet);
begin
  inherited;
    RefreshCustomerLookup;
    QryHireLinesHireFrom.DisplayFormat        := FormatSettings.ShortDateFormat;
    QryHireLinesHireTo.DisplayFormat          := FormatSettings.ShortDateFormat;
    QryHireLinesActualHireFrom.DisplayFormat  := FormatSettings.ShortDateFormat;
    QryHireLinesActualHireTo.DisplayFormat    := FormatSettings.ShortDateFormat;
end;

procedure TfmHire.QryHireLinesAfterPost(DataSet: TDataSet);
begin
  inherited;
  closedb(QryhireLinescount);
  Opendb(QryhireLinescount);
end;

procedure TfmHire.QryHireLinesCalcFields(DataSet: TDataSet);
begin
  inherited;
  QryHireLinesAlloc.AsString := '+';
  QryHireLinesDetail.AsString := '+';
end;

procedure TfmHire.QryhireLinesCountBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;
  QryhireLinesCount.ParamByName('hireId').AsInteger := hireObj.ID;
end;

procedure TfmHire.QryhirepartssalecountBeforeOpen(
  DataSet: TDataSet);
begin
  inherited;
  Qryhirepartssalecount.ParamByName('hireId').AsInteger := hireObj.ID;
end;

procedure TfmHire.QryHirePartsSalesAfterPost(
  DataSet: TDataSet);
begin
  inherited;
  closedb(Qryhirepartssalecount);
  Opendb(Qryhirepartssalecount);
end;

procedure TfmHire.QryProductsTaxBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryProductsTax.Parambyname('xRegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfmHire.QrySalesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
   QrySales.ParamByName('QuoteglobalREf').AsString := HireObj.GlobalRef;
end;

procedure TfmHire.QryTaxBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryTax.Parambyname('xRegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfmHire.UpdateFromContact(Sender: TwwDbGrid);
begin
  inherited;
  if AccessLevel > 3 then    exit;
  HireObj.contactId := Sender.Datasource.dataset.FieldByName('ContactID').AsInteger;
  HireObj.PostDB;
end;

procedure TfmHire.WriteExtraGuiPref;
begin
  GuiPrefs.Node['General.pnlProducts.Height'].AsInteger := pnlProducts.Height;
end;

procedure TfmHire.cboEstimatedDateTimeCustomDlg(Sender: TObject);
//var
//  dt: TDateTime;
begin
  inherited;
  frmHireDefaultDuration.DoSetHireDurations(HireObj);
//  if HireObj.EstimatedHireDate = 0 then
//    dt := Now()
//  else
//    dt := HireObj.EstimatedHireDate;
//  if frmDateTimeSelect.SelectDateTime(dt) then
//    HireObj.EstimatedHireDate := dt;
end;

procedure TfmHire.wwIButton1Click(Sender: TObject);
begin
  inherited;
  if not hireObj.HirePartsSale.Converted then begin
    if MessageDlgXP_Vista('Do you want to Remove this Product from Hire Sale?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
    hireObj.HirePartsSale.Deleted := true;
    hireObj.HirePartsSale.PostDB;
  end else begin
    MessageDlgXP_Vista('This Product is already invoiced. You cannot delete it ', mtWarning, [mbOK], 0);
  end;
end;

procedure TfmHire.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if not hireObj.HireLines.Converted then begin
    if MessageDlgXP_Vista('Do you want to Remove this Item from Hire?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
    hireObj.HireLines.Deleted := true;
    hireObj.HireLines.PostDB;
  end else begin
    MessageDlgXP_Vista('This Product is already invoiced. You cannot delete it ', mtWarning, [mbOK], 0);
  end;
end;

procedure TfmHire.btnNewClick(Sender: TObject);
begin
  inherited;
  if not SaveHire then Exit;
  CommitAndNotify;
  HireObj.Dirty := False;

  BeginTransaction;
  HireObj.new;
  HireObj.HireLines;
  HireObj.HirePartsSale;
  openQueries;
  Setcontrolfocus(cboClientR);
end;

procedure TfmHire.btnPaymentsClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('THireSalesListGUI' , intHireSalesList);
end;
procedure TfmHire.intHireSalesList(Sender: TObject);
begin
  if Sender is THireSalesListGUI then begin
    THireSalesListGUI(SendeR).HireRef := HireObj.GlobalRef;
  end else if sender is THireSmartOrderListGUI then begin
     THireSmartOrderListGUI(SendeR).HireRef := HireObj.GlobalRef;
  end;
end;
procedure TfmHire.btnRepeatClick(Sender: TObject);
Var
  ProgressDialog: TProgressDialog;
Begin
  If Not SaveHire (*HiresOBJ.Save*) Then Exit;
  HireOBJ.Connection.CommitTransaction;
  With TRepeatFrm.Create(Self, CommonDbLib.GetSharedMyDacConnection.Database) Do Begin
    Try
      Caption := 'Repeat Hire';
      ShowModal;
      If ModalResult = MrOk Then Begin
        HireObj.Connection.BeginTransaction;
        ProgressDialog := TProgressDialog.Create(Nil);
        HireObj.HireLines.Dataset.Disablecontrols;
        HireObj.HirePartsSale.Dataset.Disablecontrols;
        TRy
          DoShowProgressbar(Length(Dates), 'Creating Hire Records' , '');
          try
            If Not HireObj.RepeatHire(Dates) Then Begin
              HireObj.Connection.RollbackTransaction;
              HireObj.Connection.BeginTransaction;
            End Else Begin
              HireObj.Connection.CommitTransaction;
              Self.CloseWait;
            End;
          finally
            DoHideProgressbar;
          end;
        Finally
          If Assigned(ProgressDialog) Then FreeAndNil(ProgressDialog);
          HireObj.HireLines.Dataset.Enablecontrols;
          HireObj.HirePartsSale.Dataset.Enablecontrols;
        End;
      End;
    Finally Free;
    End;
  End;
end;

procedure TfmHire.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not SaveHire then Exit;
  CommitAndNotify;
  HireObj.Dirty := False;
  Self.Close;
end;

procedure TfmHire.btnShipmentClick(Sender: TObject);
begin
  inherited;
  if HireObj.CustomerId =0 then exit;
  OpenERPListFormSingleselectModal('TShipAddressListGUI' ,OnSelectShippingAddress, initShipingAddList );
end;
procedure TfmHire.OnSelectShippingAddress(Sender: TwwDbGrid);
begin
  with TwwDbGrid(Sender).Datasource.DataSet do begin
    HireObj.ShipAddressID := FieldByName('ShipAddressID').AsInteger;
    HireObj.PostDB;
  end;
end;
procedure TfmHire.OnupdateSalesActions(Sender: TObject);
begin
  inherited;
  if not (Sender is TDnmAction) then exit;
  TDnmAction(Sender).enabled := (HireObj.hirelines.count >0) or (HireObj.HirePartsSale.count >0);
end;

procedure TfmHire.pnlSalesOptionsExit(Sender: TObject);
begin
  inherited;
  //pnlSalesOptions.Visible := False;
end;

procedure TfmHire.popCustomiseGridPopup(Sender: TObject);
begin
  inherited;
  if assigned(mnushowTime) then
  mnushowTime.Visible := Screen.ActiveControl =  grdHireEquipments;
end;

procedure TfmHire.initShipingAddList(Sender: TObject);
begin
  if not (Sender is TShipAddressListGUI) then exit;
  TShipAddressListGUI(Sender).CustomerID := HireObj.CustomerId;
end;
procedure TfmHire.intPOS(Sender:TObject);
begin
  if not (Sender is  TPOSScreenForm) then exit;
  TPOSScreenForm(Sender).HireID := hireObj.ID;
end;
procedure TfmHire.KeyIdChanged(const NewKeyId: integer);
begin
  inherited;
end;

procedure TfmHire.cboDurationNameCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  HireObj.HireLines.DurationId  := QryDurationRatesDurationId.asInteger;
  HireObj.HireLines.DurationRate := QryDurationRatesRate.asFloat;
end;

procedure TfmHire.cboAssetBeforeOpenList(Sender: TObject);
begin
  inherited;
  if Sender is  TFixedAssetsListGUI then
    TFixedAssetsListGUI(Sender).grpHireFilter.ItemIndex := 1;
end;

procedure TfmHire.cboAssetCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if cboAssetLookup.FieldByName('AssetId').AsInteger > 0 then
    HireObj.Hirelines.AssetId := cboAssetLookup.FieldByName('AssetId').AsInteger;
  if HireObj.Hirelines.AssetId <> 0 then
    if HireObj.Hirelines.duration.DurationType ='H' then
        Showtime(SelF);
end;

procedure TfmHire.cboAssetDblClick(Sender: TObject);
begin
  CommonFormLib.OpenERPForm('TfmFixedAsset',self.QryHireLinesAssetId.AsInteger );
//  if cboAsset.LookupTable.active and (QryHireLinesAssetName.AsString <> '') then begin
//    TMyQuery(cboAsset.LookupTable).ParamByName('SearchValue').AsString := QryHireLinesAssetName.AsString;
//    cboAsset.SearchMode := smStartsWith;
//    cboAsset.LookupTable.Refresh;
//    cboAsset.LookupTable.Locate('AssetId',HireObj.HireLines.AssetId,[]);
//  end;
  inherited;
end;

procedure TfmHire.cboAssetDoGridDataSelect(Sender: TObject);
var
  fCount: integer;
begin
  inherited;
  fCount := 1;
  if Sender is TwwDBGrid then begin
    if (TwwDBGrid(Sender).Datasource.DataSet.FieldByName('AssetId').AsInteger <> 0) and
      (HireObj.Hirelines.AssetId <> TwwDBGrid(Sender).Datasource.DataSet.FieldByName('AssetId').AsInteger) then begin
      HireObj.Hirelines.AssetId := TwwDBGrid(Sender).Datasource.DataSet.FieldByName('AssetId').AsInteger;
//      HireObj.Hirelines.PostDb;
    end;
    fCount := TwwDBGrid(Sender).SelectedList.Count;
  end;
  if (HireObj.Hirelines.AssetId <> 0) and (fCount = 1) then
    if HireObj.Hirelines.duration.DurationType ='H' then
        Showtime(SelF);

end;

procedure TfmHire.cboAssetLookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
//  cboEquipmentLookup.parambyname('ProductId').AsInteger := HireObj.HireLines.ProductID;
end;

procedure TfmHire.chkUseBillCustExit(Sender: TObject);
begin
  inherited;
  cboBillClientName.enabled := HireObj.UseBillCust;
end;

procedure TfmHire.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

Function TfmHire.SaveHire :Boolean;
begin
  result:= False;
  HireObj.PostDB;
  if not(HireObj.Save) then exit;
  Result:= True;

end;

procedure TfmHire.ShowAttachments(fbDragnDropping :Boolean);
var
  tmpComponent: TComponent;
begin
  if qryHireHireId.AsInteger < 1 then
    Exit; // need id
  tmpComponent := TfmAttachments(GetComponentByClassName('TfmAttachments', False, self));
  if not Assigned(tmpComponent) then Exit;
  with TfmAttachments(tmpComponent) do begin
    DBConnection := Self.MyConnection;
    AttachObserver(Self);
    TableName := 'tblHire';
    TableId := qryHireHireId.AsInteger;
    DragnDropping :=fbDragnDropping;
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TfmHire.Showtime(Sender: TObject);
begin
  Application.ProcessMessages;
  DoEditHireLine(HireObj.HireLines);
//  With TfmHiringTimes.Create(Self) do try
//    HireObj := Self.HireObj;
//    Showmodal;
//  finally
//    Free;
//  end;
end;

procedure TfmHire.TimerMsg(lbl: TLabel; const Value: String;
  Secondstoshow: Integer; msgColor: TColor);
begin
  inherited;
  fbcolspecificmsgShown:=    False;
end;

procedure TfmHire.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveHire then exit;
  HireObj.Connection.CommitTransaction;
  Self.Close;

end;

procedure TfmHire.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;
end;
procedure TfmHire.convertHire(Sender: TObject);
var
  i:Integer;
begin
  inherited;
       if Sender = actInvoice    then i:= HireObj.CopyToInvoice
  else if sender = actSalesorder then i :=HireObj.CopyTosaleSOrder
  else if sender = actCashSale   then i :=HireObj.CopyToCashsale
  else if sender = actSmartOrder then i :=HireObj.CopyToSmartOrder
  else exit;
  if i=0 then exit;

  TAudit.AddEntry('Main', HireObj.Globalref, TDnmaction(Sender).caption +' # ' + inttostr(i) +' is created ', NIL, HireObj.XMLNodeName, TERPConnection(HireObj.Connection.Connection), False);

       if Sender = actInvoice    then OpenERPForm('TInvoiceGUI' , i)
  else if sender = actSalesorder then OpenERPForm('TSalesOrderGUI' , i)
  else if sender = actCashSale   then OpenERPForm('TCashSaleGUI' , i)
  else if sender = actSmartOrder then OpenERPForm('TSmartOrderGUI' , i);
  Self.Close;



end;

procedure TfmHire.OpenRelatedProducts;
begin
  OpenERPListFormultiselectModal('TRelatedProductsGUI' , FilterForProduct , AddrelatedProductsforSale);
end;

procedure TfmHire.OptStatusClick(Sender: TObject);
var
  bm : TBookmark;
begin
  if OptStatus.ItemIndex <> 2 then
    exit;
  bm := qryHireLines.GetBookmark;
  try
    qryHireLines.First;
    while not qryHireLines.Eof do
    begin
      qryHireLines.Edit;
      qryHireLines.FieldByName('Status').AsString := 'N';
      qryHireLines.Next;
    end;
  finally
    qryHireLines.GotoBookmark(bm);
    qryHireLines.FreeBookmark(bm);
  end;

end;

procedure TfmHire.PlannerBeforeShow(Sender: TObject);
begin
  TfmHirePlanner(Sender).HireID := self.HireObj.ID;
end;

procedure TfmHire.FilterForProduct(Sender:TObject);
begin
  if not (Sender is TRelatedProductsGUI) then exit;
  TRelatedProductsGUI(Sender).FilterString := 'PartsId = ' + inttostr(hireObj.HireLines.ProductId);
end;
procedure TfmHire.AddrelatedProductsforSale(sender:TwwDbGrid);
var
  fsSelectedProducts:String;
begin
  if sender = nil then begin
    fsSelectedProducts := '';
  end else if Sender.Owner is TRelatedProductsGUI then begin
    fsSelectedProducts := TRelatedProductsGUI(Sender.Owner).SelectedIDs('ProductId' , True );
    if fsSelectedProducts = '' then fsSelectedProducts := '0';
  end else begin
    Exit;
  end;
  With TRelatedProduct.create(self) do try
    Connection := HireObj.Connection;
    if fsSelectedProducts <> '' then
      LoadSelect('ProductId in (' +fsSelectedProducts+')')
    else LoadSelect('ParentID =' + inttostr(HireObj.HireLines.ProductID) );
    if count >0 then Iteraterecords(AddrelatedProductsforSaleCallback);
  finally
    Free;
  end;
end;
Procedure TfmHire.AddrelatedProductsforSaleCallback(Const Sender: TBusObj; var Abort: boolean);
begin
  if not HireObj.HirePartsSale.Locate('ProductID' , TRelatedProduct(Sender).ProductID , []) then begin
    HireObj.HirePartsSale.New;
    HireObj.HirePartsSale.ProductId :=TRelatedProduct(Sender).ProductID;
    HireObj.HirePartsSale.Qty :=TRelatedProduct(Sender).Quantity;
    HireObj.HirePartsSale.PostDB;
  end;
end;

procedure TfmHire.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  MsgOption: Word;
  msg: string;
  DurId: integer;
begin
     inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is THire then THire(Sender).Dataset  := QryHire
        else if Sender is THireLines then THireLines(Sender).Dataset  := QryHireLines
        else if Sender is THirePartsSale then THirePartsSale(Sender).Dataset  := QryHirePartsSales;
     end else if (Eventtype = BusObjEvent_Change ) and (Value = BusObjEventVal_Hiredate) then begin
      if ((HireObj.Hirelines.HireFRom       >0) and (HireObj.Hirelines.HireFRom       <now)) or
         ((HireObj.Hirelines.HireTo         >0) and (HireObj.Hirelines.HireTo         <Now)) or
         ((HireObj.Hirelines.ActualHireFRom >0) and (HireObj.Hirelines.ActualHireFRom <now)) or
         ((HireObj.Hirelines.ActualHireTo   >0) and (HireObj.Hirelines.ActualHireTo   <Now)) then
          TimerMsg(lblMsg , 'A Date/time Prior to Now is selected');
     end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_ProductID) then begin
        if HireObj.hirelines.Product.RelatedProducts.Count>0 then begin
          MsgOption := MessageDlgXP_Vista('Selected Item ' +QuotedStr(HireObj.hirelines.AssetName)+' has '+ inttostr(HireObj.hirelines.Product.RelatedProducts.Count) +' related Products.'+NL+
                                'Do you wish to Add them to the Sales Product?', mtconfirmation, [], 0 , nil , '' , '' , False, nil , 'Add to Sales List,Open List To Choose,Cancel');
          if MsgOption = 102 then exit
          else if MsgOption = 101 then OpenRelatedProducts
          else if MsgOption = 100 then AddrelatedProductsforSale(nil);
        end;
    end  else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_ProgressbarProgress) then begin
      DoStepProgressbar;
    end  else if (Eventtype = BusObjEvent_Change ) and (Value =  BusObjEventVal_status ) then begin
      if (HireObj.hirelines.Status ='P') or (HireObj.hirelines.Status ='R') then begin
        if (HireObj.hirelines.Hirefrom <> 0) and (HireObj.hirelines.ActualHirefrom = 0) and
           (HireObj.hirelines.Hireto   <> 0) and (HireObj.hirelines.ActualHireTo   = 0) then
           HireObj.hirelines.ActualHirefrom := HireObj.hirelines.Hirefrom;
           HireObj.hirelines.ActualHireto   := HireObj.hirelines.hireto;
           HireObj.hirelines.PostDB;
      end;
    end  else if (Eventtype = BusObjEvent_Dataset  ) and (Sender.IsdataIdchangeEvent(Value)) then begin
      RefreshdurationLookup;
    end  else if (Eventtype = BusObjEvent_Change  ) and (Value =  BusObjEventVal_EstimateDuration ) then begin
        TimerMsg(lblMsg , 'Estimated Duration is Assigned');
    end  else if (Eventtype = BusObjEvent_Change  ) and (Value =  BusObjEventVal_InitDurationfromMinimum ) then begin
        TimerMsg(lblMsg , 'Minimum Duration of Item ' + quotedstr(HireObj.hirelines.AssetName) +' is Assigned');
    end  else if (Eventtype = BusObjEvent_Change  ) and (Value =  BusObjEventVal_Duration ) then begin
        if (Sender is THireLines) //then
           and not(assigned(FormInstance('TfmHireLineDetailEdit'))) then
          if HireObj.Hirelines.duration.DurationType ='H' then begin
            Showtime(SelF);
          end;
    end else if (Eventtype = BusObjEvent_Change) and (Value =  BusobjEventVal_HireLineQtyUnavailable) then begin
      MessageDlgXP_Vista('There is not enough quantity of ' + HireObj.HireLines.AssetName + ' available for hire.',mtInformation,[mbOk],0);
    end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_HireAssetID) then begin
      if (HireObj.DefaultActualHireFrom > 0) and ((HireObj.DefaultActualHireTo > 0)) then
        DurId := HireObj.DefaultActualDurationId
      else
        DurId := HireObj.DefaultDurationId;

      if (DurId > 0) and (not TAssetHire.HasDurationPrice(THireLines(Sender).AssetId,DurId)) then begin
          if CommonLib.MessageDlgXP_Vista(THireLines(Sender).AssetName + ' ' + THireLines(Sender).AssetCode +
            ' does not have a price for ' + TDuration.IDToggle(DurID) + ', do you want to add one?', mtWarning,[mbYes,mbNo],0) = mrYes then begin
            if frmHireRateEdit.AddNewHireRate(THireLines(Sender).AssetName, DurId) then begin
              THireLines(Sender).DurationId := DurID;
              THireLines(Sender).PostDb;
            end;
          end;
      end;
    end else if (Value =  BusObjEventVal_DurationReplaced ) then begin
      if (HireObj.hirelines.Durationname <> '') and (Eventtype<> '') and not(Sametext(Eventtype , HireObj.hirelines.Durationname)) then
        TimerMsg(lblMsg , 'Hire Asset '+ Quotedstr(HireObj.hirelines.AssetName) +' Doesn''t Have Duration ' + quotedstr(HireObj.hirelines.Durationname)+'.  Duration is Changed to '+Quotedstr(Eventtype), 10);
    end  else if (Eventtype = BusobjEvent_ToDo  ) and (Value =  BusobjEvent_checkHireQtyAvailability) then begin
//      Check4Availability;
      if not HireObj.HireLines.IsAvailable(msg) then
        MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
    end;
end;

procedure TfmHire.DoEmail(Silent : boolean);
var
  s : string;
  lClientId : integer;
  lAddr : string;
  lName : string;
  lSilent, lSecret : boolean;
begin

  if not SaveHire then exit;
  HireObj.Dirty := False;
  HireObj.connection.CommitTransaction;
  HireObj.connection.BeginTransaction;

  lClientId := qryHireCustomerId.AsInteger;
  if lClientId = 0 then
    exit;

  s:= '~|||~Where HireId = ' + inttostr(HireObj.ID) +
     '~|||~Where HireId = ' + inttostr(HireObj.ID) +
      '~|||~Where HireId = ' + inttostr(HireObj.ID) ;
  fbReportSQLSupplied := False;

  GetCustomerNameAndEmail(lClientId, lAddr, lName);
  if lAddr = '' then
  begin
    if MessageDlgXP_Vista('Client ' + qryHireCustomerName.AsString + ' Does Not Have Email Address'#13#10+
      'Do You Still Want To Open Email Client?', mtWarning, [mbYes, mbNo], 0) = mrNo then
        exit;
    EmailReport(0, lName, lAddr, 'Hire Statement', 'Hire', s, false, true, true);
    exit;
  end;

  lSilent := true;
  if Silent then
    lSecret := true
  else
    if not EmailShortSendMode(lSilent, lSecret) then
      exit;
  // TemplateReportName[False,'']
  EmailReport(0, lName, lAddr, 'Hire Statement', 'Hire', s, false, false, false, lSilent, lSecret);
end;

procedure TfmHire.DoEmailSilent(Sender: TObject);
begin
  DoEmail(true);
end;

procedure TfmHire.DoEmailStright(Sender: TObject);
begin
  DoEmail(false);
end;

procedure TfmHire.DoPreview(Sender: TObject);
begin
  DoPrintHire(false);
end;

procedure TfmHire.DoPrint(Sender: TObject);
begin
  DoPrintHire(true);
end;

procedure TfmHire.DoPrintHire(APrint: boolean);
var
  s:String;
begin
  inherited;
  if not SaveHire then exit;
  HireObj.Dirty := False;
  HireObj.connection.CommitTransaction;
  HireObj.connection.BeginTransaction;

  s:= '~|||~Where HireId = ' + inttostr(HireObj.ID) +
     '~|||~Where HireId = ' + inttostr(HireObj.ID) +
      '~|||~Where HireId = ' + inttostr(HireObj.ID) ;
     fbReportSQLSupplied := False;

  PrintTemplateReport(TemplateReportName[False,''], s, APrint, 1);
end;

procedure TfmHire.DoPrintOptions(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
begin
(*
  if not SaveHire then exit;
  HireObj.Dirty := False;
  HireObj.connection.CommitTransaction;
  HireObj.connection.BeginTransaction;
*)
  OptsForm := TfmReportingOptions.Create(Self);
  try
    OptsForm.ActionList.AddDivider('Print');
    OptsForm.ActionList.Add('Print' ,'Print The Hire', DoPrint, true, true);
    OptsForm.ActionList.Add('Preview', 'Preview The Hire', DoPreview, true, true);
    OptsForm.ActionList.AddDivider('Email');
    OptsForm.ActionList.Add('Email' ,'Email The Hire', DoEmailStright, true, true);
    OPtsform.ActionList.Add('Email Silently', 'Email the Hire Silently', DoEmailSilent, true, true);

    OptsForm.ShowModal;
    CloseAfterPrint(OptsForm.CloseWhenDone);
  finally
    OptsForm.Free;
  end;
end;

(*procedure TfmHire.DoBeforeShowAssetList(Sender: TObject);
begin
  if Sender is  TFixedAssetsListGUI then begin
    TFixedAssetsListGUI(Sender).grpHireFilter.ItemIndex := 1;
    TFixedAssetsListGUI(Sender).FilterString := 'AssetName = ' + QuotedStr(QryHireLinesAssetName.AsString);
  end;
end;*)

(*procedure TfmHire.DoOnAssetListDataSelect(Sender: TwwDbGrid);
var
  x: integer;
begin
  for x := 0 to Sender.SelectedList.Count -1 do begin
    sender.DataSource.DataSet.GotoBookmark(Sender.SelectedList[x]);
    AssetIdList.Add(sender.DataSource.DataSet.FieldByName('AssetId').AsInteger);
  end;
end;*)

procedure TfmHire.dtHireTimeDblClick(Sender: TObject);
begin
  inherited;
  if TwwDBDateTimePicker(Sender).Date > 0 then
    ShowTime(nil);
  grdHireEquipmentsDblClick(nil);
end;

procedure TfmHire.ReadExtraGuipref;
begin
  if GuiPrefs.Node.Exists('General.pnlProducts')  then begin
    pnlProducts.Height := GuiPrefs.Node['General.pnlProducts.Height'].AsInteger;
  end;
end;

Procedure TfmHire.RefreshDurationLookup;
begin
      if (QryDurationRates.parambyname('AssetId').AsInteger <> HireObj.HireLines.AssetID) then begin
           closedb(QryDurationRates);
           QryDurationRates.parambyname('AssetId').AsInteger := HireObj.HireLines.AssetID ;
           OpenDB(QryDurationRates);
         end;
end;
procedure TfmHire.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteExtraGuiPref;
  inherited;
  action := caFree;
end;

procedure TfmHire.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if HireObj.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveHire then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          HireObj.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          self.RemoveFlag('OpenHirePlanner');
          btnCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;
  if self.IsFlag('OpenHirePlanner') then begin
    if self.HireObj.Converted then begin
      CommonLib.MessageDlgXP_Vista('This Hire Has Already Been Converted.'#13#10'The Items Will Not Be Shown on the Hire Planner',mtInformation,[mbOk],0);
      OpenERPForm('TfmHirePlanner',0,nil,nil);
    end
    else begin
      OpenERPForm('TfmHirePlanner',0,nil,PlannerBeforeShow);
    end;
  end;

end;

procedure TfmHire.FormCreate(Sender: TObject);
//var
//  qry: TERPQuery;

//  procedure LoadTimeCombo;
//  begin
//    qry.Open;
//    while not qry.EOF do begin
//      cboEstimatedTimeSpan.Items.AddObject(qry.FieldByName('Description').AsString, TObject(qry.FieldByName('DurationId').AsInteger));
//      qry.Next;
//    end;
//    qry.Close;
//  end;

begin


  fbCheck4Availability := False;
  fiHireLineAssetId := 0;
  fdQty := 0;

  fbcolspecificmsgShown:= False;
  dtHireFrom.DisplayFormat        := FormatSettings.ShortDateFormat;
    dtHireTo.DisplayFormat          := FormatSettings.ShortDateFormat;
    dtActualHireTo.DisplayFormat    := FormatSettings.ShortDateFormat;
    dtActualHireFrom.DisplayFormat  := FormatSettings.ShortDateFormat;


  AllowCustomiseGrid := True;
  cboAsset.LookupFormClassName := 'TFixedAssetsListGUI';
  inherited;
  AssetIdList := TIntegerList.Create;

  HireObj := THire.CreateWithNewConn(Self);
  HireObj.Connection.connection := Self.MyConnection;
  HireObj.BusObjEvent := DoBusinessObjectEvent;

end;

procedure TfmHire.FormDestroy(Sender: TObject);
begin
  inherited;
  AssetIdList.Free;
end;

procedure TfmHire.FormShow(Sender: TObject);
begin
  inherited;
  ReadExtraGuiPref;
  HireObj.Load(KeyID);
  HireObj.connection.BeginTransaction;
  if HireObj.count=0 then HireObj.new;
  HireObj.HireLines;
  HireObj.HirePartsSale;
  openQueries;
//  FormatProductCombo(cboProduct);
  //FormatProductCombo(cboProductsProduct);
//  cboEstimatedTimeSpan.ItemIndex := cboEstimatedTimeSpan.Items.IndexOfObject(TObject(HireObj.EstimateDurationId));
  Setcontrolfocus(cboClientR);
  cboBillClientName.enabled := HireObj.UseBillCust;
  grdProducts.ColumnByName('converted').ReadOnly := True;
  grdHireEquipments.ColumnByName('converted').ReadOnly := True;


  if (Assigned(grdHireEquipments.Popupmenu)) then begin
    mnuShowtime := TMenuItem.Create(self);
    mnuShowtime.Caption := 'Show Hire Timings';
    mnuShowtime.OnClick := Showtime;
    grdHireEquipments.Popupmenu.Items.Add(mnuShowtime);
  end;
  guiprefs.DbGridElement[grdHireEquipments].RemoveFields( QryHireLinesActualHireFromtime.fieldname  +','+
                                                          QryHireLinesActualHiretoTime.fieldname    +','+
                                                          QryHireLinesAssetId.FieldName             +','+
                                                          QryHireLinesHireUOMQty.FieldName          +','+
                                                          QryHireLinesDeleted.fieldname             +','+
                                                          QryHireLinesDurationId.fieldname          +','+
                                                          QryHireLinesEmployeeId.fieldname          +','+
                                                          //QryHireLinesEquipmentId.fieldname         +','+
                                                          QryHireLinesHireID.fieldname              +','+
                                                          QryHireLinesHireLineID.fieldname          +','+
                                                          QryHireLinesUOMID.fieldname               +','+
                                                          QryHireLinesUOMMult.fieldname             +','+
                                                          QryHireLinesGlobalRef.fieldname           +','+
                                                          QryHireLinesHireFromtime.fieldname        +','+
                                                          QryHireLinesHiretoTime.fieldname          +','+
                                                          //QryHireLinesHireQty.fieldname             +','+
                                                          QryHireLinesmsTimeStamp.fieldname         +','+
                                                          QryHireLinesmsUpdateSiteCode.fieldname    +','+
                                                          QryHireLinesLineTaxRate.fieldname );

  guiprefs.DbGridElement[grdProducts].RemoveFields(       QryHirePartsSalesDeleted.fieldname +','+
                                                          QryHirePartsSalesDiscount.fieldname +','+
                                                          QryHirePartsSalesDiscountPercent.fieldname +','+
                                                          QryHirePartsSalesGlobalRef.fieldname +','+
                                                          QryHirePartsSalesHireID.fieldname +','+
                                                          QryHirePartsSalesHirePartsSaleID.fieldname +','+
                                                          QryHirePartsSalesParentProductID.fieldname +','+
                                                          QryHirePartsSalesProductID.fieldname +','+
                                                          QryHirePartsSalesUnitofMeasureID.fieldname +','+
                                                          QryHirePartsSalesmsTimeStamp.fieldname +','+
                                                          QryHirePartsSalesmsUpdateSiteCode.fieldname +','+
                                                          QryHirePartsSalesIsRelatedProduct.fieldname +','+
                                                          QryHirePartsSalesLinecost.fieldname +','+
                                                          QryHirePartsSalesUnitofMeasureMultiplier.fieldname +','+
                                                          QryHirePartsSalesMarkup.fieldname +','+
                                                          QryHirePartsSalesMarkupPercent.fieldname +','+
                                                          QryHirePartsSalesMatrixDesc.fieldname +','+
                                                          QryHirePartsSalesMatrixPrice.fieldname +','+
                                                          QryHirePartsSalesMatrixRef.fieldname +','+
                                                          QryHirePartsSalesParentLineRef.fieldname +','+
                                                          QryHirePartsSalesRelatedProductQty.fieldname +','+
                                                          QryHirePartsSalesTaxRate.fieldname);
  if not HirePrerequisitesOK then begin
    HireObj.Dirty := false;
    Close;
  end;
  btnAttachments.Enabled := KeyId > 0;
  DMTextTargetHire.AcceptorControl := nil;
  DMTextTargetHire.AcceptorControl := txtNotes;

end;

function TfmHire.GetReportTypeID: integer;
begin
  REsult := 60;
end;

procedure TfmHire.grdHireEquipmentsColEnter(Sender: TObject);
begin
  inherited;
  if Sametext(TField(grdHireEquipments.GetActiveField).FieldName , QryHireLinesDurationName.FieldName) then begin
    TimerMsg(lblMsg, 'This Dropdown Will Only Display the Rates Setup For This Asset');
    fbcolspecificmsgShown:=    true;
  end else if (Sametext(TField(grdHireEquipments.GetActiveField).FieldName , QryHireLinesActualHireFrom.FieldName) and (QryHireLinesActualHireFrom.asDatetime =0)) or
            (Sametext(TField(grdHireEquipments.GetActiveField).FieldName , QryHireLinesActualHireTo.FieldName) and (QryHireLinesActualHireTo.asDatetime =0)) then begin
    TimerMsg(lblMsg, 'Double Click on The "Actual Period From " or "Actual Period To" to Copy from the Quoted Period to Actual');
    fbcolspecificmsgShown:=    true;
  end
  else if Sametext(TField(grdHireEquipments.GetActiveField).FieldName , QryHireLinesAssetName.FieldName) then begin
    if cboAsset.LookupTable.active and (QryHireLinesAssetName.AsString <> '') then begin
      TMyQuery(cboAsset.LookupTable).ParamByName('SearchValue').AsString := QryHireLinesAssetName.AsString;
      cboAsset.SearchMode := smStartsWith;
      cboAsset.LookupTable.Refresh;
      cboAsset.LookupTable.Locate('AssetId',HireObj.HireLines.AssetId,[]);
    end;
  end
  else begin
    if fbcolspecificmsgShown then begin
      hideTimerMsg;
      fbcolspecificmsgShown := False;
    end;
  end;
end;

procedure TfmHire.grdHireEquipmentsDblClick(Sender: TObject);
var
  FB:Boolean;
begin
  inherited;
  if Sametext(grdHireEquipments.GetActiveField.fieldname ,QryHireLinesActualHireFrom.FieldName) or
    Sametext(grdHireEquipments.GetActiveField.fieldname ,QryHireLinesActualHireTo.FieldName) then
    if (HireObj.HireLines.actualHirefrom =0) and (HireObj.HireLines.actualHireto =0) then begin
      fb :=HireObj.HireLines.DoFieldChange ;
      HireObj.HireLines.DoFieldChange := False;
      try
        HireObj.HireLines.actualHireFrom := HireObj.HireLines.HireFrom;
        HireObj.HireLines.ActualHireto := HireObj.HireLines.HireTo;
        HireObj.HireLines.actualHireFromtime := HireObj.HireLines.HireFromtime;
        HireObj.HireLines.ActualHiretotime := HireObj.HireLines.HireTotime;
        HireObj.HireLines.PostDB;
      finally
        HireObj.HireLines.DoFieldChange  := fb;
      end;
      TimerMsg(lblMsg, '"Actual Period From" and "Actual Period To" is copied from the Quoted Period');
  end;
end;

procedure TfmHire.grdHireEquipmentsEnter(Sender: TObject);
begin
  inherited;
  if Hireobj.HireLines.count =0 then Hireobj.HireLines.New;
  lblMsg.caption := 'To See Hire time, Please Double Click on the From or To Dates';
end;

procedure TfmHire.grdHireEquipmentsExit(Sender: TObject);
begin
  inherited;
  lblMsg.caption := '';
end;

procedure TfmHire.grdHireEquipmentsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (grdHireEquipments.SelectedField = QryHireLinesAlloc) and (QryHireLinesAssetName.AsString <> '') then begin
     DoHireLineAllocation(HireObj.HireLines);
  //    AssetIdList.Clear;
//    if CommonFormLib.OpenERPListFormultiselectModal('TFixedAssetsListGUI',DoFeforeShowAssetList,DoOnAssetListDataSelect) then begin
//      if AssetIdList.Count > 0 then begin
//        if AssetIdList.InList(QryHireLinesAssetId.AsInteger) then
//          AssetIdList.Remove(QryHireLinesAssetId.AsInteger)
//        else
//          HireObj.HireLines.Delete;
//        for x := 0 to AssetIdList.Count -1 do begin
//          HireObj.HireLines.New;
//          HireObj.HireLines.AssetId := AssetIdList[x];
//          HireObj.HireLines.PostDb;
//        end;
//      end;
//    end;
  end
  else if (grdHireEquipments.SelectedField = QryHireLinesDetail) then begin
    DoEditHireLine(self.HireObj.HireLines);

  end;
end;

procedure TfmHire.grdHireEquipmentsTitleButtonClick(Sender: TObject;
  AFieldName: string);
begin
  inherited;
  if Sametext(Afieldname ,QryHireLinesPriceEx.FieldName) then begin
    Swapfields(Self ,twwDBGrid(Sender), QryHireLinesPriceEx.FieldName,QryHireLinesPriceInc.FieldName, QryHireLinesPriceInc.DisplayLabel, nil);
  end else if Sametext(Afieldname ,QryHireLinesPriceinc.FieldName) then begin
    Swapfields(Self ,twwDBGrid(Sender),QryHireLinesPriceinc.FieldName,QryHireLinesPriceex.FieldName, QryHireLinesPriceex.DisplayLabel, nil);
  end else if Sametext(Afieldname ,QryHireLinesLineAmount.FieldName) then begin
    Swapfields(Self ,twwDBGrid(Sender),QryHireLinesLineAmount.FieldName,QryHireLinesLineAmountInc.FieldName, QryHireLinesLineAmountInc.DisplayLabel, nil);
  end else if Sametext(Afieldname ,QryHireLinesLineAmountinc.FieldName) then begin
    Swapfields(Self ,twwDBGrid(Sender),QryHireLinesLineAmountinc.FieldName,QryHireLinesLineAmount.FieldName, QryHireLinesLineAmount.DisplayLabel, nil);

  end;
  QryHireLinesPriceInc.readonly     := Accesslevel>=5;
  QryHireLinesPriceEx.readonly      := Accesslevel>=5;
  QryHireLinesLineAmountInc.readonly:= Accesslevel>=5;
  QryHireLinesLineAmount.readonly   := Accesslevel>=5;

end;
procedure TfmHire.grdProductsTitleButtonClick(Sender: TObject;
  AFieldName: string);
begin
  inherited;
  if Sametext(Afieldname ,QryHirePartsSalesPriceEx.FieldName) then begin
    Swapfields(Self ,twwDBGrid(Sender),QryHirePartsSalesPriceEx.FieldName,QryHirePartsSalesPriceInc.FieldName, QryHirePartsSalesPriceInc.DisplayLabel, nil);
  end else if Sametext(Afieldname ,QryHirePartsSalesPriceInc.FieldName) then begin
    Swapfields(Self ,twwDBGrid(Sender),QryHirePartsSalesPriceInc.FieldName,QryHirePartsSalesPriceEx.FieldName, QryHirePartsSalesPriceEx.DisplayLabel, nil);
  end else if Sametext(Afieldname ,QryHirePartsSalesLineTotalEx.FieldName) then begin
    Swapfields(Self ,twwDBGrid(Sender),QryHirePartsSalesLineTotalEx.FieldName,QryHirePartsSalesLineTotalInc.FieldName, QryHirePartsSalesLineTotalInc.DisplayLabel, nil);
  end else if Sametext(Afieldname ,QryHirePartsSalesLineTotalInc.FieldName) then begin
    Swapfields(Self ,twwDBGrid(Sender),QryHirePartsSalesLineTotalInc.FieldName,QryHirePartsSalesLineTotalEx.FieldName, QryHirePartsSalesLineTotalEx.DisplayLabel, nil);

  end;
  QryHirePartsSalesPriceInc.readonly      := Accesslevel>=5;
  QryHirePartsSalesPriceEx.readonly       := Accesslevel>=5;
  QryHirePartsSalesLineTotalInc.readonly  := Accesslevel>=5;
  QryHirePartsSalesLineTotalEx.readonly   := Accesslevel>=5;
end;

function TfmHire.HirePrerequisitesOK: boolean;
var
  qry: TERPQuery;
begin
  result := true;
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'select Count(*) as RecCount from tblduration where Active = "T"';
    qry.Open;
    if qry.FieldByName('RecCount').AsInteger = 0 then begin
      result := false;
      CommonLib.MessageDlgXP_Vista('As no Durations/Times are setup we will now go to the Hire Setup screen',mtInformation,[mbOk],0);
      OpenERPForm('TfmSetupHire',0);
      exit;
    end;
    qry.Close;
    qry.SQL.Text := 'select Count(*) as RecCount from tblassethire where Active = "T" and AssetId > 0';
    qry.Open;
    if qry.FieldByName('RecCount').AsInteger = 0 then begin
      result := false;
      CommonLib.MessageDlgXP_Vista('As no Products are setup we will now go to the Hire Setup screen',mtInformation,[mbOk],0);
      OpenERPForm('TfmSetupHire',0);
      exit;
    end;
    qry.Close;
    qry.SQL.Text := 'select Count(*) as RecCount from tblhirepricinglines';
    qry.Open;
    if qry.FieldByName('RecCount').AsInteger = 0 then begin
      result := false;
      CommonLib.MessageDlgXP_Vista('As no Hire Prices are setup we will now go to the Hire Setup screen',mtInformation,[mbOk],0);
      OpenERPForm('TfmSetupHire',0);
      exit;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;


procedure TfmHire.InitERPLookupCombonFields;
begin
  if not assigned(HireObj) then
    exit;
  inherited;
  SetupProductNamenPrintNameinGrid(cboProductsProduct ,cboPrintProductR ,'ProductName' , 'ProductPrintName' , 'PARTSDESCRIPTION' , grdProducts );

  NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(HireObj.customerId,  cboClientR,False, True, False, true, true , 'ClientPrintName' , nil, true);
  NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(HireObj.BillCustomerID,  cboBillClientName,False,True , False, true, true, 'ClientBillPrintName', nil, true);

end;

initialization
  RegisterClassOnce(TfmHire);
  with FormFact do  begin
    RegisterMe(TfmHire, 'THireListGUI_*=HireID');
    RegisterMe(TfmHire, 'THireHistoryForAssetGUI_*=HireID');
    RegisterMe(TfmHire, 'THireListDetailsGUI_*=HireID');
    RegisterMe(TfmHire, 'TOnHireListGUI_*=HireID');
    RegisterMe(TfmHire, 'THireItemAvailabilityGUI_*=HireID');
    RegisterMe(TfmHire, 'THireItemDetailListGUI_*=HireID');

  end;
end.

