unit frmSmartOrderFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB,  dbcgrids, StdCtrls, wwcheckbox, Buttons, DNMSpeedButton,
  wwdbdatetimepicker, Mask, DBCtrls, wwdblook, ExtCtrls, DNMPanel, BaseInputForm,
  Grids, DBGrids, Wwdbigrd, Wwdbgrid,  ImgList, kbmMemTable,
  SelectionDialog, AppEvnts, wwdbedit, ActnList, MemDS, DBAccess, MyAccess,ERPdbComponents,
  DataState, Menus, AdvMenus, Shader,
  Commonlib,BusObjSmartOrder, BusObjBase, IntegerListObj,
  CustomerJobRepairSelection, ProgressDialog, DNMAction,
  ERPDbLookupCombo, CustomfieldonGrid, ApprovalObj;

type
  TProductQtyCalculated = record
    ProductID: integer;
    DeptID: integer;
    Qty:Double;
  end;


  TSmartOrderGUI = class(TBaseInputGUI)
    pnlFooter: TDNMPanel;
    cboComments_Label: TLabel;
    pnlHeader: TDNMPanel;
    SaleDate_Label: TLabel;
    cboCreationDate: TwwDBDateTimePicker;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    pnlDetail: TDNMPanel;
    btnSave: TDNMSpeedButton;
    txtSmartOrderDesc: TDBEdit;
    Label54: TLabel;
    Label89: TLabel;
    Label65: TLabel;
    Label68: TLabel;
    DSMaster: TDataSource;
    DSDetails: TDataSource;
    Bevel1: TDnmPanel;
    TaxCodeDetails: TERPQuery;
    grdLines: TwwDBGrid;
    cboClass: TwwDBLookupCombo;
    cboClientR: TERPDbLookupCombo;
    btnDeleteGridLine: TwwIButton;
    imgPopup: TImageList;
    tblMaster: TERPQuery;
    tblDetails: TERPQuery;
    tblMasterSmartOrderID: TAutoIncField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterCreationDate: TDateField;
    tblMasterSmartOrderDesc: TWideStringField;
    tblMasterArea: TWideStringField;
    tblMasterDone: TWideStringField;
    tblMasterEditedFlag: TWideStringField;
    tblMasterSaleOrderID: TIntegerField;
    tblMasterGlobalRef: TWideStringField;
    tblDetailsQty: TFloatField;
    tblDetailsPODesc: TWideStringField;
    tblDetailsClassID: TIntegerField;
    tblDetailsSupplierID: TIntegerField;
    tblDetailsPARTSID: TIntegerField;
    tblDetailsLinePrice: TFloatField;
    tblDetailsSmartOrderLinesID: TAutoIncField;
    tblDetailsSmartOrderID: TIntegerField;
    tblDetailsEditedFlag: TWideStringField;
    tblDetailsGroupID: TIntegerField;
    tblDetailsGroupLineID: TIntegerField;
    tblDetailsGroupheader: TWideStringField;
    tblDetailsLineTaxRate: TFloatField;
    tblDetailsGlobalRef: TWideStringField;
    tblMergeSmartOrderLines: TERPQuery;
    tblShippingMethods: TERPQuery;
    tblterms: TERPQuery;
    tblShippingMethodsShippingMethodID: TAutoIncField;
    tblShippingMethodsShippingMethod: TWideStringField;
    tblShippingMethodsActive: TWideStringField;
    tblShippingMethodsEditedFlag: TWideStringField;
    tbltermsTermsID: TAutoIncField;
    tbltermsTerms: TWideStringField;
    tblDetailsSupplierContact: TWideStringField;
    tblDetailsUnitofMeasureQty: TFloatField;
    tblDetailsUnitofMeasure: TWideStringField;
    tblDetailsUnitofMeasureMultiplier: TFloatField;
    qryUnitOfMeasure: TERPQuery;
    qryUnitOfMeasureUnitName: TWideStringField;
    qryUnitOfMeasureUnitDescription: TWideStringField;
    qryUnitOfMeasureMultiplier: TFloatField;
    cboUnitOfMeasure: TwwDBLookupCombo;
    tblDetailsCustPONumber: TWideStringField;
    tblMasterProjectLineID: TIntegerField;
    cboProductR: TERPDbLookupCombo;
    txtSearchFilter: TwwDBEdit;
    tblDetailsSearchFilter: TWideStringField;
    tblDetailsSearchFilterCopy: TWideStringField;
    tblDetailsPARTSNAME: TWideStringField;
    tblDetailsCostEx: TFloatField;
    tblDetailsCostInc: TFloatField;
    tblDetailsSupplierName: TWideStringField;
    tblDetailsCusJobName: TWideStringField;
    tblDetailsClassName: TWideStringField;
    cboClassQry: TERPQuery;
    cboProductQry: TERPQuery;
    cboAccountQry: TERPQuery;
    qryClient: TERPQuery;
    qryClientLookup: TERPQuery;
    tblCompany: TERPQuery;
    tblCompanySetupID: TIntegerField;
    tblCompanyCompanyName: TWideStringField;
    tblCompanyAddress: TWideStringField;
    tblCompanyAddress2: TWideStringField;
    tblCompanyCity: TWideStringField;
    tblCompanyState: TWideStringField;
    tblCompanyPostcode: TWideStringField;
    tblCompanyCountry: TWideStringField;
    tblDetailsPurchaseOrderId: TIntegerField;
    tblDetailsPurchaseLineId: TIntegerField;
    edTotalPriceEx: TEdit;
    edTotalPriceInc: TEdit;
    tblDetailsDocketNumber: TWideStringField;
    tblDetailsUnitOfMeasureID: TIntegerField;
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
    qryUnitOfMeasureUnitID: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    edTotalPartNo: TEdit;
    tblDetailsDeleted: TWideStringField;
    tblDetailsCusJobID: TIntegerField;
    tblDetailsSaleLineID: TIntegerField;
    tblMasterSalesglobalRef: TWideStringField;
    tblDetailsRepairId: TIntegerField;
    tblDetailsCustomerEquipmentID: TIntegerField;
    cboEquipmentname: TwwDBLookupCombo;
    qryrepairequip: TERPQuery;
    qryrepairequipEquipmentName: TWideStringField;
    qryrepairequipSerialno: TWideStringField;
    qryrepairequipManufacture: TWideStringField;
    qryrepairequipmodel: TWideStringField;
    qryrepairequipRegistration: TWideStringField;
    qryrepairequipWarantyFinishDate: TDateTimeField;
    qryrepairequipWarantyPeriod: TFloatField;
    qryrepairequipCustomerEquipmentID: TIntegerField;
    qryrepairequipRepairID: TIntegerField;
    tblDetailsEquipmentName: TWideStringField;
    qryrepairequipQuantity: TFloatField;
    qryrepairequipClientID: TIntegerField;
    tblDetailsconverted: TWideStringField;
    btnHideConverted: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    ActionList: TActionList;
    actSelectRecord: TDNMAction;
    qryUnitOfMeasureheight: TFloatField;
    qryUnitOfMeasurewidth: TFloatField;
    qryUnitOfMeasurelength: TFloatField;
    qryUnitOfMeasurevolume: TFloatField;
    qryUnitOfMeasureweight: TFloatField;
    tblDetailsheight: TFloatField;
    tblDetailswidth: TFloatField;
    tblDetailslength: TFloatField;
    tblDetailsvolume: TFloatField;
    tblDetailsweight: TFloatField;
    QryUOMLookUp: TERPQuery;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    IntegerField1: TIntegerField;
    tblDetailsWeight4Qty: TFloatField;
    tblDetailsvolume4Qty: TFloatField;
    tblDetailsUnitVolume: TFloatField;
    tblDetailsProcTreeId: TIntegerField;
    tblDetailsSupplierProductCode: TWideStringField;
    tblDetailssupplierProductname: TWideStringField;
    tblDetailsPrintedValue: TFloatField;
    tblDetailsPartBarCode: TWideStringField;
    tblDetailsAvailableQty: TFloatField;
    QtyProductAvailableQty: TERPQuery;
    QtyProductOnOrderQty: TERPQuery;
    tblDetailsFormulaQtyValue1: TFloatField;
    tblDetailsFormulaQtyValue2: TFloatField;
    tblDetailsFormulaQtyValue3: TFloatField;
    tblDetailsFormulaQtyValue4: TFloatField;
    tblDetailsFormulaQtyValue5: TFloatField;
    tblDetailsFormulaQtyValue: TFloatField;
    tblDetailsOnOrder: TFloatField;
    DNMSpeedButton2: TDNMSpeedButton;
    actSummary: TDNMAction;
    tblMasterShipTo: TWideStringField;
    PopOptions: TAdvPopupMenu;
    mnuAuditTrial: TMenuItem;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    lblArea: TLabel;
    cboAreaCode: TwwDBLookupCombo;
    pnlAdvPrinting: TDNMPanel;
    LblShowPreview: TLabel;
    chkGroupClass: TCheckBox;
    chkPreview: TCheckBox;
    chkPrint: TCheckBox;
    chkShow: TCheckBox;
    CmdCreatePOs: TDNMSpeedButton;
    tblDetailsTotalQty: TFloatField;
    tblDetailsTotalUOMqty: TFloatField;
    tblDetailsTobuildQty: TFloatField;
    tblDetailsToBuildUOMQty: TFloatField;
    lblMsg: TLabel;
    btnRFQ: TDNMSpeedButton;
    ChkchooseReport: TCheckBox;
    SaveDialog1: TSaveDialog;
    btnMakeRFG: TDNMSpeedButton;
    tblDetailsWastagePercentage: TFloatField;
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
    Label1: TLabel;
    tblMastermsTimeStamp: TDateTimeField;
    tblMastermsUpdateSiteCode: TWideStringField;
    tblMasterApproved: TWideStringField;
    tblMasterApprovedBy: TIntegerField;
    lbMemTrans: TLabel;
    tblDetailsLineNotes: TWideMemoField;
    tblDetailsGeneralNotes: TWideMemoField;
    cboProductQryGeneralNotes: TWideMemoField;
    cboProductQryMultibuy: TWideStringField;
    cboPrintProductR: TERPDbLookupCombo;
    tblDetailsSupplierPrintName: TWideStringField;
    tblDetailsCusJobPrintName: TWideStringField;
    cboCustomerJob: TERPDbLookupCombo;
    cboPrintCustomerJob: TERPDbLookupCombo;
    tblDetailsTotalCostEx: TFloatField;
    tblDetailsTotalCostInc: TFloatField;
    tblMasterSaleID: TIntegerField;
    tblMasterSaletype: TStringField;
    lblSaleID: TDBText;
    edtSaleID: TDBEdit;
    tblDetailsMultiBuy: TWideStringField;
    Label160: TLabel;
    txtCustomID: TDBEdit;
    tblDetailsProductPrintName: TWideStringField;
    btnAttachments: TDNMSpeedButton;
    pnlApprover: TDNMPanel;
    cboApprover: TwwDBLookupCombo;
    tblMasterApproverID: TIntegerField;
    qryApproverLookup: TERPQuery;
    lblApprover: TLabel;
    chkSendEmail: TwwCheckBox;
    tblMasterDefaultSupplierID: TIntegerField;
    cboDefaultSupplier: TERPDbLookupCombo;
    tblMasterDefaultSupplierName: TWideStringField;
    qryDefaultSupplier: TERPQuery;
    qryClientLookupCompany: TWideStringField;
    qryClientLookupClientId: TIntegerField;
    Label3: TLabel;
    qryDefaultSupplierPrintName: TWideStringField;
    chkDefaultSupplierAll: TwwCheckBox;
    tblMasterUseDefaultSupplierForAllLines: TWideStringField;
    cboPrintClientR: TERPDbLookupCombo;
    mnuPOs: TMenuItem;
    DNMPanel1: TDNMPanel;
    chkDone: TDBCheckBox;
    chkApproved: TwwCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure txtQtyKeyPress(Sender: TObject; var Key: char);
    procedure btnNewClick(Sender: TObject);
    procedure RefreshFooter;
    procedure grdLinesTitleButtonClick(Sender: TObject; const AFieldName: string);
    procedure btnDeleteGridLineDblClick(Sender: TObject);
    procedure grdLinesCalcTitleAttributes(Sender: TObject; const AFieldName: string; const AFont: TFont;
      const ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure CmdCreatePOsClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure grdLinesCalcTitleImage(Sender: TObject; Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
    procedure chkPrintClick(Sender: TObject);
    procedure cboProductRCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure SetProductID(iValue: integer);
    procedure tblDetailsPARTSIDChange(Sender: TField);
    procedure grdLinesRowChanged(Sender: TObject);
    procedure TaxCodeDetailsBeforeOpen(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grdLinesEnter(Sender: TObject);
    procedure cboClientRCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboEquipmentnameCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboEquipmentnameDblClick(Sender: TObject);
    procedure cboEquipmentnameNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure btnHideConvertedClick(Sender: TObject);
    procedure actSelectRecordUpdate(Sender: TObject);
    procedure actSelectRecordExecute(Sender: TObject);
    procedure grdLinesMultiSelectRecord(Grid: TwwDBGrid;
      Selecting: Boolean; var Accept: Boolean);
    procedure grdLinesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure tblDetailsCalcFields(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tblDetailsBeforeOpen(DataSet: TDataSet);
    procedure tblDetailsAfterOpen(DataSet: TDataSet);
    procedure grdLinesDblClick(Sender: TObject);
    procedure actSummaryUpdate(Sender: TObject);
    procedure actSummaryExecute(Sender: TObject);
    procedure mnuAuditTrialClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnRFQClick(Sender: TObject);
    procedure btnMakeRFGClick(Sender: TObject);
    procedure mnuBusobjPropertiesoptionClick(Sender: TObject);
    procedure grdLinesKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure tblDetailsCostIncChange(Sender: TField);
    procedure tblDetailsCostExChange(Sender: TField);
    procedure chkApprovedClick(Sender: TObject);
    procedure tblMasterCalcFields(DataSet: TDataSet);
    procedure tblMasterAfterOpen(DataSet: TDataSet);
    procedure btnAttachmentsClick(Sender: TObject);
    procedure mnuPOsClick(Sender: TObject);
    procedure cboApproverCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
  private
    fbCustomerJobState: boolean;
    bFromQuote: boolean;
    fiProductID: integer;
    fbHideMessages: boolean;
    fbHideconvertedLines: Boolean;
    fsMultiselectFilter: String;
    SavedFilter: string;
    ProductAvailableQty :Array of TProductQtyCalculated;
    ProductOnOrderQty :Array of TProductQtyCalculated;
    fiProctreeId: Integer;
    fsPOIds:String;
    fiSOID :Integer;
    fbApproving  :Boolean;
    fInFormShow: boolean;
    CustomfieldonGrid: TCustomFieldonGrid;
    DoingCmdCreatePOsClick: boolean;
    function Linecount:Integer;
    function SetMultiSelectFilter(const enablefilter :Boolean =true): boolean;
    function SaveData: boolean;
    procedure PrintPO(PurchaseOrderID: integer);
    procedure TogglePOCreate(bState: boolean);
    procedure setHideconvertedLines(const Value: Boolean);
    procedure DeleteAllSelectedLines;
    function GetProductAvailableQty(ProductId, DeptID: Integer): Double;
    function GetProductOnOrderQty(ProductId, DeptID: Integer): Double;
    procedure LockPartCalcformulafields;
    function showformuladetails: Boolean;
    procedure beforeshowSmartOrderSummary(Sender: TObject);
    procedure TransAuditTrialbeforeShow(Sender: TObject);
    Function MakePO:Boolean;
    function MakeInternalSOs: Boolean;
    procedure setSOID(const Value: Integer);
    Procedure PrintSO(const ShowCancelAll:Boolean ; const supplierID:Integer=0;fbPrint :Boolean = False;fbEmail :Boolean=False; fbSAvetoPDF:Boolean=False;filename:String='');
    procedure EmalRFQs(Sender: TwwDbGrid);
    procedure ReadGuiprefs;
    procedure WriteGuiprefs;
    Procedure initSupplierListforSmartOrderRequest(Sender:TObject);
    procedure DoPrintSO;
    Procedure SoEmailSO;
    Procedure DoPreviewSO;
    Procedure SaveSoToPDF;
    procedure EmailRFQ;
    Procedure initSmartOrderRFQs(Sender:TObject);
    Procedure AddOptionsMenu;
    Procedure OptionsMenuclick(Sender:TObject);
    Procedure InitDisplayLabels;
    procedure ApplyCustomFieldsSettings;
    procedure beforeshowCustomfieldList(Sender: TObject);
    procedure CustomFields1Click(Sender: TObject);
    procedure showcurrentOrder(Sender: TObject);
    procedure AddDefaultOrdermenuITems;
    procedure ChangeToDefaultOrder(Sender: TObject);
    procedure Inserline(Sender: TObject);
    procedure ShowAttachments(fbDragnDropping :boolean);
    procedure CheckForAttachments;
    procedure DoOnapproval;
    procedure ProcessSavedSO;
    function SaveRecord: Boolean;
    procedure onShowSmartOrderPOList(Sender: TObject);
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure RefreshUnitsQry;
    function GetReportTypeID: Integer; override;
    Procedure SetPOIDs (Const value :STring);
    Procedure SetGridColumns;
    function AnyConverted:Boolean;
    Procedure CreateBarcode(NewValue:String);Overload;
    procedure CreateBarcode(Sender: TObject);Overload;

    property InFormShow : boolean read fInFormShow write fInFormShow;
    Procedure InitERPLookupCombonFields; Override;

  public
    fbProductQueryExecuted: boolean;
    fbDontRecalcFields: boolean;
    fbDontFireQtyEvent: boolean;
    bHasFiredFirstExit: boolean;
    bDontDropProductList: boolean;
    bDontProcessCloseUp: boolean;
    SmartOrder :TSmartOrder;

    isMerging: boolean;
    fbConverting: boolean;

    property HideMessages       : boolean read fbHideMessages write fbHideMessages;
    property ProductIDFromList  : integer read fiProductID write SetProductID;
    property IsFromQuotes       : boolean read bFromQuote write bFromQuote default false;
    Property POIDs              : String  read fsPOIds Write SetPOIDs;
    Property SOID              :Integer read fiSOID write setSOID;
    Property HideconvertedLines:Boolean read fbHideconvertedLines Write setHideconvertedLines;
    Property ProctreeId :Integer read fiProctreeId write fiProctreeId ;
    procedure Setcolumn(columnVisible: Boolean; columnName: string; displaylabel:String = '');


  end;

implementation

uses pqalib,
  FormFactory, DNMLib, DNMExceptions,
  frmSupplier, frmPartsfrm,
  ProductListForm, tcDataUtils, AppEnvironment,
  FastFuncs, BusObjConst, StrUtils, CompanyPrefObj, BusObjStock,
  ProductListExpressForm, CommonDbLib, Productqtylib,tcConst,
  ShellAPI, PartCalcFormulaObj, CommonFormLib, frmSmartOrderSummary,
  TransAuditTrail, SupplierListforSmartOrderRequest, frmReportingOptions, SmartOrderRFQs,
  Preferences,IdGlobal, frmCustomfieldList, Busobjcustomfields,
  sndkey32,UserCustomisedNames, EMailExtraUtils, frmAttachments,
  DbSharedObjectsObj, BusObjApprovals, CorrespondenceObj, BusObjEmployee,
  JsonToDatasetFuncs, JsonObject, JsonToObject, BusObjToDo, SmartOrderPOList,
  ApprovalNotificationLib, LookupcomboLib;

{$R *.dfm}

var
  incTax: boolean;
  qtyChangeDirect: boolean;
  slItemCount: TStringList;

const
  FlagEditingDetails = 1;
procedure TSmartOrderGUI.DoOnapproval;
begin
  if chkApproved.Focused or cboApprover.Focused then begin
    if AppEnv.CompanyPrefs.ConvertSOIntoPOOnApproval then
      if (smartOrder.Approved  and not(smartOrder.cleanApproved)) and (smartOrder.ApproverID<>0) then
        CmdCreatePOs.click;
  end;
end;
procedure TSmartOrderGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited ;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TSmartOrder         then TSmartOrder(Sender).DataSet     := tblMaster;
        if Sender is TSmartOrderLine     then TSmartOrderLine(Sender).DataSet := tblDetails;
    end  else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_QtyChanged) then begin
      if Sender is TSmartOrderLine     then
        TSmartOrderLine(Sender).WastagePercentage := 0; // user changing the qty should make the wastage percentage 0
    end  else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_Approved) then begin
      chkApproved.Checked := smartOrder.Approved;
    end  else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEvent_TotalsChanged) then
    begin
      if InFormShow then
      begin
            grdLines.ColumnByName('volume4Qty').FooterValue := FloatToStrF(SmartOrder.Totalvolume, ffGeneral, 15, 2);
            grdLines.ColumnByName('Weight4Qty').FooterValue := FloatToStrF(SmartOrder.TotalWeight, ffGeneral, 15, 2);
      end;
    end else if (EventType = BusobjEvent_ToDo) and (Value = BusObjEvent_PartBarcodeNotfound)  then begin
      Createbarcode(smartOrder.lines.Partbarcode);
    end else if (EventType = BusObjEvent_Warning) and (Value = BusobjEventVal_BOMqtyonNonBOMProduct)  then begin
      //TimerMsg(lblMsg , SmartOrder.lines.Productname +' is not a BOM product, it is not possible to have Quantity to build' , 5);
      MessageDlgXP_vista(SmartOrder.lines.Productname +' is not a BOM product, it is not possible to have Quantity to build', mtWarning, [mbOK], 0);
    end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_ProductChanged)  then begin
      if Sender  = SmartOrder.Lines then begin
          tblDetailsGeneralNotes.Value := cboProductQryGeneralNotes.Value;
          LockPartCalcformulafields;
          if SmartOrder.lines.Hasformula then   begin
            SmartOrder.lines.FormulaQtyValue := 1;
            With TPartCalcFormula.Create(Self) do try InitformulaQtyValues(SmartOrder.Lines);finally Free;end;
          end;
      end;
    end else if (EventType = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value))  then begin
    end else if (EventType = BusObjEvent_Warning) and (Value = BusobjEventVal_ConvertedSOLnotEditable)  then begin
      //TimerMsg(lblMsg , SmartOrder.lines.Productname +' is already converted and converting a converted smart order is disabled in the preference. It is not possible to change this line' , 5);
      MessageDlgXP_vista(SmartOrder.lines.Productname +' is already converted and converting a converted smart order is disabled in the preference.'+NL+'It is not possible to change this line', mtWarning, [mbOK], 0);
    end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterInsert) and (Sender is TSmartOrder) then begin
      chkSendEmail.checked := AppEnv.CompanyPrefs.DefaultNotifyNewSmartOrder;
      chkShow.checked := AppEnv.CompanyPrefs.DefaultShowPOfromSmartOrder;
    end;
end;

procedure TSmartOrderGUI.LockPartCalcformulafields;
begin
  With TPartCalcFormula.Create(Self) do try
    LockPartCalcformulafields(grdLines , SmartOrder.Lines.Hasformula );
  finally
    Free;
  end;
end;

procedure TSmartOrderGUI.mnuAuditTrialClick(Sender: TObject);
begin
  inherited;
  if SmartOrder.Id =0 then exit;
  OpenErpListform('TTransAuditTrailGUI' ,TransAuditTrialbeforeShow);
end;

procedure TSmartOrderGUI.mnuBusobjPropertiesoptionClick(Sender: TObject);
begin
  inherited;
  grdLines.columnByname('WastagePercentage').ReadOnly :=  True;
end;

procedure TSmartOrderGUI.mnuPOsClick(Sender: TObject);
begin
  inherited;
  if smartOrder.ID =0 then exit;
  OpenERPListForm('TSmartOrderPOListGUI' , onShowSmartOrderPOList);
end;
procedure TSmartOrderGUI.onShowSmartOrderPOList(Sender: TObject);
begin
   if sender is TSmartOrderPOListGUI then begin
      TSmartOrderPOListGUI(Sender).smartOrderID := smartOrder.ID;
   end;
end;
procedure TSmartOrderGUI.TransAuditTrialbeforeShow(Sender: TObject);
begin
  if not(Sender is TTransAuditTrailGUI) then exit;
  TTransAuditTrailGUI(Sender).DocName       := SmartOrder.classname;
  TTransAuditTrailGUI(Sender).DocId         := SmartOrder.ID;
  TTransAuditTrailGUI(Sender).TransGlobalref:= SmartOrder.Globalref;
  TTransAuditTrailGUI(Sender).DocDescription:=SmartOrder.XMLNodename;
  TTransAuditTrailGUI(Sender).Formname      := Self.Classname;
end;

Function TSmartOrderGUI.GetProductAvailableQty(ProductId, DeptID:Integer):Double;
var
  ctr:Integer;
begin

  for ctr := low(ProductAvailableQty) to high(ProductAvailableQty) do begin
    if (ProductAvailableQty[ctr].ProductID = ProductId) and (ProductAvailableQty[ctr].DeptID = DeptID) then begin
      REsult := ProductAvailableQty[ctr].Qty;
      Exit;
    end;
  end;

  closeDb(QtyProductAvailableQty);
  QtyProductAvailableQty.SQL.clear;
  QtyProductAvailableQty.SQL.add('Select '+SQL4Qty(tAvailable)+' as Qty from tblPQA PQA where PQA.ProductId = ' +inttostr(ProductID) + ' and DepartmentId = ' + Inttostr(DeptID));
  QtyProductAvailableQty.open;
  Result := QtyProductAvailableQty.Fieldbyname('Qty').asFloat;

  if Result <> 0 then begin
    SetLength(ProductAvailableQty, length(ProductAvailableQty)+1);
    ctr:= high(ProductAvailableQty);
    ProductAvailableQty[ctr].productId := ProductID;
    ProductAvailableQty[ctr].DeptID :=  DeptID;
    ProductAvailableQty[ctr].Qty := Result;
  end;
end;
Function TSmartOrderGUI.GetProductOnOrderQty(ProductId, DeptID:Integer):Double;
var
  ctr:Integer;
begin

  for ctr := low(ProductOnOrderQty) to high(ProductOnOrderQty) do begin
    if (ProductOnOrderQty[ctr].ProductID = ProductId) and (ProductOnOrderQty[ctr].DeptID = DeptID) then begin
      REsult := ProductOnOrderQty[ctr].Qty;
      Exit;
    end;
  end;

  closeDb(QtyProductOnOrderQty);
  QtyProductOnOrderQty.SQL.clear;
  QtyProductOnOrderQty.SQL.add('Select '+SQL4Qty(tPOBO)+' as Qty from tblPQA PQA where PQA.ProductId = ' +inttostr(ProductID) + ' and DepartmentId = ' + Inttostr(DeptID));
  QtyProductOnOrderQty.open;
  Result := QtyProductOnOrderQty.Fieldbyname('Qty').asFloat;

  if Result <> 0 then begin
    SetLength(ProductOnOrderQty, length(ProductOnOrderQty)+1);
    ctr:= high(ProductOnOrderQty);
    ProductOnOrderQty[ctr].productId := ProductID;
    ProductOnOrderQty[ctr].DeptID :=  DeptID;
    ProductOnOrderQty[ctr].Qty := Result;
  end;
end;

procedure TSmartOrderGUI.FormCreate(Sender: TObject);
begin
  DoingCmdCreatePOsClick := false;
  fbApproving  := False;
  fiproctreeId:= 0;
  SetLength(ProductAvailableQty , 0);
  SetLength(ProductOnOrderQty , 0);
  Processingcursor(True);
  AllowCustomiseGrid := True;
  try
    fbDontRecalcFields := false;
    fbProductQueryExecuted := false;
    bHasFiredFirstExit := false;
    bDontDropProductList := false;
    bDontProcessCloseUp := false;
    fbConverting       := false;
    fbDontFireQtyEvent := false;

    SmartOrder              := TSmartOrder.Create(Self);
    SmartOrder.RefreshFooter:= RefreshFooter;
    SmartOrder.Connection   := TMyDacDataConnection.Create(SmartOrder);
    SmartOrder.Connection.MyDacConnection := MyConnection;
    SmartOrder.BusObjEvent  := DoBusinessObjectEvent;
    inherited;

    popCustomiseGrid.Items.Find('Select All').Action:= actSelectRecord;

    GuiPrefs.AddreadonlyField('RepairID' , tblDetails);
    GuiPrefs.Active := True;

    tblDetailsProductPrintName.DisplayLabel := 'Product Print Name';
    tblDetailsSupplierPrintName.DisplayLabel := 'Supplier Print Name';
    tblDetailsCusJobPrintName.DisplayLabel := 'Job Print Name';


    SetConnectionString(false);
    fbCustomerJobState := true;
    tblMaster.Connection := MyConnection;
    tblDetails.Connection := MyConnection;
    tblShippingMethods.Connection := MyConnection;
    incTax          := false;
    qtyChangeDirect := true;
    slItemCount     := TStringList.Create;
    slItemCount.Duplicates := dupIgnore;
    slItemCount.Sorted := true;
    MyConnection.Connected := true;
    SmartOrder.connection.beginTransaction;

    Application.HintHidePause := 10000; // 10 sec so we can view long 'availability ' hint

    GuiPrefs.AddFieldPair('CostEx', 'costInc', tblDetails);

  finally
    Processingcursor(False);
  end;

  if Trim(AppEnv.DefaultClass.PartColumn) <> '' then
    UpdateSelectedProp(cboProductR.Selected, 'PartName', AppEnv.DefaultClass.PartColumn, sptUpdateLabel);
  With TPartCalcFormula.Create(Self) do
    try
      SetdisplayLabel(self);
    finally
      Free;
    end;
  ApproverCombo.ApproverLookupQrySQL(cboApprover , ApprovalTypeSmartOrder);
end;

procedure TSmartOrderGUI.FormDestroy(Sender: TObject);
begin
  Freeandnil(CustomfieldonGrid);
  inherited;
end;

procedure TSmartOrderGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiprefs;
  Action := caFree;
  FreeAndNil(slItemCount);
  Application.HintHidePause := 2500; // set back to default
  inherited;
end;

function TSmartOrderGUI.SaveData: boolean;
begin
  try
    REsult := SmartOrder.Save;
  finally
    SmartOrder.ResultStatus.Clear;
  end;
end;

procedure TSmartOrderGUI.SaveSoToPDF;
var
  filename:String;
begin
  DisableForm;
  try
    if not SaveData then exit;
    smartOrder.Connection.CommitTransaction;
    try
      SaveDialog1.FileName := 'Smart Order #' + inttostr(SmartOrder.ID) +'.PDF';
      if SaveDialog1.Execute then filename :=  SaveDialog1.FileName else exit;
      PrintSO(False, 0 , False, false , true , filename);
      CloseAfterPrint;
    finally
      smartOrder.Connection.RollbackTransaction;
    end;

  finally
    EnableForm;
  end;
end;

procedure TSmartOrderGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  DisableForm;
  try
    Processingcursor(True);
    InFormShow := true;
    try
      try
        inherited;
        ApplyCustomFieldsSettings;
        SavedFilter:= 'Deleted <> ' + QuotedStr('T');
        Setlength(QueryNamesNotToOpen, 9);
        QueryNamesNotToOpen[0] := 'tblMaster';
        QueryNamesNotToOpen[1] := 'tblDetails';
        QueryNamesNotToOpen[2] := 'cboAccountQry';
        QueryNamesNotToOpen[3] := 'qrypartqtylines';
        QueryNamesNotToOpen[4] := 'TaxCodeDetails';
        QueryNamesNotToOpen[5] := 'cboProductQry';
        QueryNamesNotToOpen[6] := 'qryClient';
        QueryNamesNotToOpen[7] := 'QtyProductAvailableQty';
        QueryNamesNotToOpen[8] := 'QtyProductOnOrderQty';
        OpenQueries(QueryNamesNotToOpen);

        SmartOrder.Load(KeyID);
        if KeyId =0 then SmartOrder.new ;
        SmartOrder.Lines;
        SmartOrder.Lines.Dataset.Filter:= SavedFilter;
        SmartOrder.Lines.Dataset.Filtered:= true;
        if (KeyId > 0) then
        begin
          if not SmartOrder.Lock then begin
            AccessLevel := 5; // read only
            CommonLib.MessageDlgXP_Vista(SmartOrder.UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.',
              mtWarning, [mbOK], 0);
          end;
        end;

        grdLines.ColumnByName('ClassName').DisplayLabel := AppEnv.DefaultClass.ClassHeading;
        initDisplaylabels;

        SetGridColumns;
        cboProductqry.Open;
        qryClient.Open;

        ReadGuiprefs;
        Addoptionsmenu;
        TransApprovalInit(chkApproved ,  ApprovalTypeSmartOrder , SmartOrder, 'TotalCostInc',true,cboApprover,lblApprover,chkSendEmail);

        With TPartCalcFormula.Create(Self) do try ShowFormulaQtyFields(Self);finally Free;end;

        pnlApprover.Visible :=  AppEnv.CompanyPrefs.UseApprovalLevels;

      except
        on EAbort do HandleEAbortException;
        on e: ENoAccess do HandleNoAccessException(e);
        else raise;
      end;
    finally
      Processingcursor(False);
    end;
    HideconvertedLines := False;
    AddDefaultOrdermenuITems;
  finally
    InFormShow := false;
    EnableForm;
    SetControlFocus(txtSmartOrderDesc);
  end;
end;

procedure TSmartOrderGUI.btnSaveClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if not SaveRecord then exit;
    CommitTransaction;
    Notify;
    ProcessSavedSO;
  finally
    EnableForm;
  end;
  Self.close;
end;
Function TSmartOrderGUI.SaveRecord:Boolean;
begin
  REsult := False;
  try
    Application.ProcessMessages;
    try
      if not SmartOrder.Save then Exit;
    finally
      SmartOrder.ResultStatus.Clear;
    end;
    if SmartOrder.Lines.count =0 then
      if CommonLib.MessageDlgXP_Vista('Smart Order has 0 lines. Do you Wish to Save it?',
              mtconfirmation, [mbyes,mbno], 0) = mrno then exit;

    REsult := True;
  finally
    SmartOrder.ResultStatus.Clear;
  end;
end;

Procedure TSmartOrderGUI.ProcessSavedSO;
begin
  if AppEnv.CompanyPrefs.UseApprovalLevels then begin
    if chkSendEmail.Checked and (SmartOrder.ApproverID > 0) then begin
      fsMessageOptionPrefix := 'OrderApprove.';
      try
        TApprovalNotification.Notify(self, true);
      finally
        fsMessageOptionPrefix:='';
      end;
    end;
  end;
end;

procedure TSmartOrderGUI.btnAttachmentsClick(Sender: TObject);
begin
  inherited;
  ShowAttachments(False);
end;

procedure TSmartOrderGUI.btnCancelClick(Sender: TObject);
begin
    Closeit(False);
end;

procedure TSmartOrderGUI.txtQtyKeyPress(Sender: TObject; var Key: char);
begin
  inherited;
  if (Key >= '0') and (Key <= '9') or (Key = #8) or (Key = '.') then Exit;
  Key := #0;  // otherwise don't accept
end;

procedure TSmartOrderGUI.WriteGuiprefs;
begin
  GuiPrefs.Node['Options.chooseReport'].asBoolean := ChkchooseReport.checked;
end;

procedure TSmartOrderGUI.btnNewClick(Sender: TObject);
begin
  DisableForm;
  try
    if not smartOrder.Save then Exit;
    smartOrder.connection.BeginTransaction;
    smartOrder.New;
  finally
    SmartOrder.ResultStatus.Clear;
    EnableForm;
  end;
end;

procedure TSmartOrderGUI.ReadGuiprefs;
begin
    ChkchooseReport.checked:= GuiPrefs.Node['Options.chooseReport'].asBoolean;
    grdLines.columnByname('WastagePercentage').ReadOnly :=  True;
end;

procedure TSmartOrderGUI.RefreshFooter;//(var Msg: TMessage);
begin
    edTotalPartNo.Text   := Format('%3d', [SmartOrder.TotalProducts]);
    edTotalPriceEx.Text  := Format('%9.2m', [SmartOrder.TotalCostEx]);
    edTotalPriceInc.Text := Format('%9.2m', [SmartOrder.totalCostInc]);
    if AppEnv.CompanyPrefs.UseApprovalLevels then begin
      //qryApproverLookup.ParamByName('ApprovalType').AsString := ApprovalTypeSmartOrder;
      qryApproverLookup.ParamByName('OrderTotal').AsFloat := SmartOrder.TotalCostInc;
      qryApproverLookup.Refresh;
      if SmartOrder.ApproverID > 0 then begin
        qryApproverLookup.Locate('EmployeeID',SmartOrder.ApproverID,[]);
        cboApprover.Text := qryApproverLookup.FieldByName('EmployeeName').AsString;
      end;
    end;
    TogglePOCreate((SmartOrder.totalCostInc < AppEnv.CompanyPrefs.MaxSmartAmount) or
                    (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnOverrideSmartOrdMax') = 1));
end;



procedure TSmartOrderGUI.grdLinesTitleButtonClick(Sender: TObject; const AFieldName: string);
var
  iPos: integer;
begin
  inherited;

  with grdLines do begin
    RemoveField(tblDetailsSupplierID.fieldname);
    if Sysutils.SameText(AFieldName,'CostInc') then begin
      iPos := GetGridColumnIndex(grdLines, 'CostInc');
      AddField('CostEx', iPos, false);
      Datasource.Dataset.fieldByname('CostEx').Index := ipos;
      RemoveField(AFieldName);
      ColumnByName('CostEx').DisplayLabel := 'Cost(Ex)';
      ColumnByName('CostEx').DisplayWidth := 9;

      Exit;
    end
    else if Sysutils.SameText(AFieldName , 'CostEx') then begin
      iPos := GetGridColumnIndex(grdLines, 'CostEx');
      AddField('CostInc', iPos, false);
      Datasource.Dataset.fieldByname('CostInc').Index := ipos;
      RemoveField(AFieldName);
      ColumnByName('CostInc').DisplayLabel := 'Cost(Inc)';
      ColumnByName('CostInc').DisplayWidth := 9;

      Exit;
    end
    else if Sysutils.SameText(AFieldName,'TotalCostInc') then begin
      iPos := GetGridColumnIndex(grdLines, 'TotalCostInc');
      AddField('TotalCostEx', iPos, false);
      Datasource.Dataset.fieldByname('TotalCostEx').Index := ipos;
      RemoveField(AFieldName);
      ColumnByName('TotalCostEx').DisplayLabel := 'Total Cost(Ex)';
      ColumnByName('TotalCostEx').DisplayWidth := 9;

      Exit;
    end
    else if Sysutils.SameText(AFieldName , 'TotalCostEx') then begin
      iPos := GetGridColumnIndex(grdLines, 'TotalCostEx');
      AddField('TotalCostInc', iPos, false);
      Datasource.Dataset.fieldByname('TotalCostInc').Index := ipos;
      RemoveField(AFieldName);
      ColumnByName('TotalCostInc').DisplayLabel := 'Total Cost(Inc)';
      ColumnByName('TotalCostInc').DisplayWidth := 9;

      Exit;
    end;

    if (tblDetails.FieldByName(AFieldName).FieldKind <> fkLookup) and
      (tblDetails.FieldByName(AFieldName).FieldKind <> fkCalculated) and
      (AFieldName <> SMART_JOBNUMBER_MAINGRIDFIELD) then begin
      if FastFuncs.PosEx('[' + AFieldName + ']' + ' ASC', tblDetails.IndexFieldNames) <> 0 then begin
        tblDetails.IndexFieldNames := '[' + AFieldName + ']' + ' DESC';
      end else begin
        tblDetails.IndexFieldNames := '[' + AFieldName + ']' + ' ASC';
      end;
    end;
  end;
  showcurrentOrder(nil);
end;

procedure TSmartOrderGUI.InitDisplayLabels;
begin
  tbldetailsWeight.displaylabel     :=  'Weight~( '+ appenv.CompanyPrefs.UOMWeightUOM +' )' ;
  tbldetailsHeight.displaylabel     :=  'Height~( '+ appenv.CompanyPrefs.UOMVolumeDimensionUOM +' )' ;
  tbldetailsLength.displaylabel     := 'Length~( '+ appenv.CompanyPrefs.UOMVolumeDimensionUOM +' )' ;
  tbldetailsWidth.displaylabel      :=  'Width~( '+ appenv.CompanyPrefs.UOMVolumeDimensionUOM +' )' ;
  tbldetailsVolume.displaylabel     :=  'Volume~( '+ appenv.CompanyPrefs.UOMVolumeDimensionUOM+'3' +' )' ;
  tbldetailsunitVolume.displaylabel := 'Volume~( '+ appenv.CompanyPrefs.UOMforTotalvolumeInsmartOrder+'3' +' )' ;

  tbldetailsVolume4Qty.displaylabel := 'Total Volume~( '+ appenv.CompanyPrefs.UOMforTotalvolumeInsmartOrder+'3' +' )' ;
  tbldetailsWeight4Qty.displaylabel := 'Total Weight~( '+ appenv.CompanyPrefs.UOMWeightUOM +' )' ;
end;

procedure TSmartOrderGUI.initSmartOrderRFQs(Sender: TObject);
begin
  if not(Sender  is TSmartOrderRFQsGUI) then exit;
  TSmartOrderRFQsGUI(Sender).SmartOrderId := SmartOrder.ID;
end;

procedure TSmartOrderGUI.initSupplierListforSmartOrderRequest(Sender: TObject);
begin
  if not(Sender is TSupplierListforSmartOrderRequestgui) then exit;
  TSupplierListforSmartOrderRequestgui(Sender).smartOrderId := SmartOrder.ID;
end;

procedure TSmartOrderGUI.btnDeleteGridLineDblClick(Sender: TObject);
var
  msgOption:Integer;
begin
  inherited;
    msgOption:= 103;
    if tbldetails.recordcount =0  then exit;
    if (grdLines.SelectedList.count = 1) or (SmartOrder.lines.count=1) then begin
        if MessageDlgXP_Vista('Delete Line ' + tblDetailsPARTSNAME.AsString + ' ?', mtConfirmation,[mbyes,mbno] , 0 ) = mryes then
          msgOption:=100;
    end else  begin
        msgOption:= MessageDlgXP_Vista('Do You Wish To Delete This Line or Delete All Selected Lines?', mtConfirmation,[] , 0 ,nil , '' , '' , False, nil , 'This Line,All Selected Lines,All Lines,Cancel' );
        if (grdLines.SelectedList.count=0) and (msgOption = 101)  then grdLines.selectRecord;
    end;
    if msgOption = 100 then begin
      SmartOrder.Lines.Deleted := True;
      SmartOrder.Lines.PostDB;
      grdLines.SelectedList.Clear;
    end else if msgOption = 101 then begin
      DeleteAllSelectedLines;
      grdLines.SelectedList.Clear;
    end else if msgOption = 102 then begin
      grdLines.SelectAll;
      DeleteAllSelectedLines;
      grdLines.SelectedList.Clear;
    end;
end;

Procedure TSmartOrderGUI.DeleteAllSelectedLines;
var
  i:Integer;
  st:TStringlist;
  s:String;
  fsFilter:String;
begin
  if not grdLines.DataSource.DataSet.Active then Exit;
  st:= tStringlist.create;
  try
      commonlib.SelectedIDs(GRDlINES , 'SmartOrderLinesID', st ,True);
      st.Delimiter:= ',';
      s:= '';
      if st.count > 0 then
        for i := 0 to st.count-1 do begin
          if s<> '' then s:= s +' OR ';
          s:= s + ' SmartOrderLinesID = ' + st[i];
        end;
  finally
    FreeandNil(st);
  end;
  grdLines.UnSelectAll;
  tbldetails.disablecontrols;
  try
    fsFilter:=tbldetails.filter;
    try
      if fsfilter<> '' then s:= '(' +fsfilter+') and  ('+s+')';
      tbldetails.Filter:= s;
      tbldetails.filtered := True;
      SmartOrder.Lines.DeleteAll;
    finally
      tbldetails.filter:= fsfilter;
      tbldetails.Filtered := tbldetails.filter<>'';
    end;
  finally
    tbldetails.enablecontrols;
  end;


end;
function TSmartOrderGUI.MakeInternalSOs:Boolean;
var
  CreateSOforAll:Boolean;
  //SOID:Integer;
begin
  inherited;
  Result := False;
  CreateSOforAll:=true;

  if not SmartOrder.HasanyTobuild('') then
  begin
    REsult:= True;
    exit;
  end;


  DisableForm;
  try
    tbldetails.DisableControls;
    try
      if SetMultiSelectFilter then begin
        try
          if SmartOrder.HasanyTobuild(fsMultiselectFilter) =False then begin
            //MessageDlgXP_Vista('None of the selected line in this Smart OrderSmart Order #' +IntToStr(SmartOrder.ID) +' has any quantity to build.', mtwarning, [mbok],0);
            Result:= True;
            exit;
          end;
          if (grdLines.SelectedList.Count > 0) and (grdLines.SelectedList.Count <> SmartOrder.Lines.count) then
             if MessageDlgXP_Vista('You Have Selected ' +IntToStr(grdLines.SelectedList.Count) +' of ' +IntToStr(SmartOrder.Lines.count) +' Line(s). '+
                                  'If you select any lines, Internal Sales Order will be created only for the Selected Lines.' +chr(13)+chr(13)+
                                  'If you Select No Lines, Internal Sales Order will be created the entire Smart Order .'+chr(13) +chr(13) +
                                  'Do you wish to Continue Creating Internal Sales Order for the Selected Line(s) ?' , mtConfirmation, [mbyes,mbNo] , 0) = mrno then Exit;
          if SmartOrder.IsAllBomCreated(fsMultiselectFilter) then begin
              if MessageDlgXP_Vista('Internal Sales Order has been created for all in this Smart OrderSmart Order #' +IntToStr(SmartOrder.ID) +'. Would you like to create another Sales Order?' , mtconfirmation , [mbyes,mbNo] , 0) = mrno then begin
                Result:= True;
                Exit;
              end;
          end else if SmartOrder.IsanyBomCreated(fsMultiselectFilter)  then begin
              case MessageDlgXP_Vista('Internal Sales order has been created for some of the Products in this  Smart OrderSmart Order #' +IntToStr(SmartOrder.ID) +'. Would you like to create another Sales Order?' ,
                                    mtConfirmation, [] , 0, nil , '' , '' , False, nil , 'Create For all BOm Lines, Create for BOM Lines without SO, Cancel') of
                  100:CreateSOforAll:=true;
                  101:CreateSOforAll:=False;
                  102:Exit;
              end;
          end;
          SOID := SmartOrder.CreateInternalsalesOrder(CreateSOforAll);
        finally
          SetMultiSelectFilter(False);
        end;
      end;
    finally
      tblDetails.EnableControls;
    end;
  finally
    EnableForm;
  end;
end;

procedure TSmartOrderGUI.grdLinesCalcTitleAttributes(Sender: TObject; const AFieldName: string;
  const AFont: TFont; const ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  if tbldetails.FindField(Afieldname) = nil then exit;

  inherited;
  try
  if (Sysutils.SameText(AFieldName ,'CustomerJob'))  then begin
    ABrush.Color := clBtnFace;
    Exit;
  end;

  if (Sysutils.SameText(AFieldName , 'CostInc')) or
      (Sysutils.SameText(AFieldName , 'CostEx')) then begin
    ABrush.Color := clBtnFace;
    Exit;
  end;

  
  if tbldetails.FindField(Afieldname).ReadOnly then
      AFont.Color := clInactiveCaption;

   With TPartCalcFormula.create(Self) do try   gridCalcTitleAttributes(Sender,AFieldName,AFont,ABrush,ATitleAlignment );  finally   Free;  end;
  Except
    on E:Exception do begin
      if devmode then
        MessageDlgXP_vista(E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;

Procedure TSmartOrderGUI.SetPOIDs (Const value :STring);
var
    IDList :TStringlist;
    x:Integer;
  Procedure MakeToDo(const POID:Integer);
  var
    ToDo:TToDo;
  begin
          ToDo := TToDo.CreateWithSharedConn(nil);
          try
            ToDo.New;
            ToDo.EmployeeID :=  SmartOrder.EmployeeId;
            ToDo.ToDoByDate := now;
            ToDo.Description := POCREATEDFORSO+' # ' + inttostr(POID) + ' for ' + Smartorder.BusObjectTypeDescription+' # ' + IntToStr(SmartOrder.ID);
            ToDo.LinkTo := 'Purchase Order';
            ToDo.LinkToID := POID;
            ToDo.Save;
          finally
            ToDo.Free;
          end;
  end;

  Procedure SendPurchaseOrderToDoEmail(Const Email:String;const POID:Integer);
  var
    subject, body, link  :String;
  begin
          if email <> '' then begin
              subject :=POCREATEDFORSO+' # ' + inttostr(POID) + ' for ' + Smartorder.BusObjectTypeDescription+' # ' + IntToStr(SmartOrder.ID);
              body := 'The following  ' + POCREATEDFORSO+' # ' + inttostr(POID) +' for Smart Order # ' + inttostr(SmartOrder.ID) + #13#10 +
                                        'Description: ' + SmartOrder.SmartOrderDesc + #13#10;

            body := body +'No: ' + IntToStr(POID) + #13#10;

            if AppEnv.CompanyPrefs.ErpApiEnabled then begin
              link := '<a href="http://'+'localhost'+':' +
                IntToStr(AppEnv.CompanyPrefs.ErpApiPort) +
                '/trueerp?OpenForm=TPurchaseGUI&KeyID=' + IntToStr(POID) + '">Purchase Order '+IntToStr(POID)+'</a>';
              body := body +
                'Link: ' + link + #13#10;
            end;

            body := body +
              'Creation Date: ' + Formatdatetime(Shortdateformat, Date) + #13#10 +
              'Employee: ' + Appenv.Employee.Employeename;
            TCorrespondenceGui.EmailEmployee(
              email,
              subject,
              body,
              SmartOrder.EmployeeID,
              true ,
              104,
              DoNotAskMsg ,
              DoOnDoNotAskMsgCheck);
          end else begin
           CommonLib.MessageDlgXP_Vista('There is no Email Address configured for Employee ' +
                                         TEmployee.IDToggle(SmartOrder.EmployeeID) ,mtInformation,[mbOk],0);
          end;
  end;


begin
    fsPOIds := Value;
    if Value = '' then Exit;
    IDList := TStringList.Create;
    try
        FastFuncs.Split(value , ',' , IDList);
        SmartOrder.UserLock.UnlockAllCurrentInstance;//UnlockAllCurrentUser //Binny -UnlockAllCurrentUser removes locking from other forms are well;
        for x := 0 to IDList.count-1 do begin
          if AppEnv.CompanyPrefs.UseApprovalLevels then begin
            if chkSendEmail.Checked and (SmartOrder.ApproverID > 0) then begin
              MakeToDo(FastFuncs.StrToInt(IDList[x]));
              SendPurchaseOrderToDoEmail(TEmployee.EmailForEmployeeID(SmartOrder.EmployeeID) ,FastFuncs.StrToInt(IDList[x]));
            end;
          end;
            if chkShow.Checked then begin
                if fsModal in FormState then
                  OpenERPFormModal('TPurchaseGUI' , FastFuncs.StrToInt(IDList[x]))
                else  begin
                  OpenERPForm('TPurchaseGUI' , FastFuncs.StrToInt(IDList[x]));
                  SleepUntilFormshown('TPurchaseGUI');
                end;
            End;
            if chkPrint.Checked then begin
                PrintPO(FastFuncs.StrToInt(IDList[x]));
            end;
        end;
    Finally
        FreeandNil(IDList);
    end;
end;

procedure TSmartOrderGUI.CmdCreatePOsClick(Sender: TObject);
//var
//  lApprove : boolean;
begin
  if DoingCmdCreatePOsClick then exit;

  DoingCmdCreatePOsClick := true;
  try
    POIDs:= '';

    InFormShow := TRUE; // Block approval validation in OnDataChage events - we check it here
    try

      try
        if not Saverecord then Exit;
      finally
        SmartOrder.ResultStatus.Clear;
      end;

      if SmartOrder.Lines.count =0 then
        if CommonLib.MessageDlgXP_Vista('Smart Order has 0 lines. Do you Wish to Save it?', mtconfirmation, [mbyes,mbno], 0) = mrno then
          exit;

      if not SmartOrder.Approved then begin
        if not TApprovalCheck.Approved(SmartOrder)  then exit;
        SmartOrder.Approved := true;
        SmartOrder.PostDB;
      end;
      CommitTransaction;
//      ProcessSavedSO;

      DisableForm;
      try
        if MakePO and MakeInternalSOs then begin
          Notify;
          Self.Close;
        end;
      finally
        BeginTransaction;
        EnableForm;
      end;
    finally
      InFormShow := false;
    end;
  finally
    DoingCmdCreatePOsClick := false;
  end;
end;

function TSmartOrderGUI.MakePO:Boolean;
var
    ProgressDialog: TProgressDialog;
    SaveHideconvertedLines: boolean;
    IDs :String;

    Function SelectedrowsMsg:String; begin
       if grdLines.SelectedList.count = 0 then
        REsult := 'This Smart Order has Converted Lines.'
       else result := 'You Have Selected Lines Already Converted.';
    end;
begin
  REsult:= False;
  if not appenv.CompanyPrefs.ConvertConvertedSmartOrder then
  begin
    if SmartOrder.isAllconverted then
    begin
      MessageDlgXP_Vista('Smart Order #' +IntToStr(SmartOrder.ID) +' is Already Converted. Please Change the Preference if You Need to Convert it Again' , mtWarning, [mbok] , 0);
      Exit;
    end;

    if AnyConverted then
    begin
      if MessageDlgXP_Vista(SelectedrowsMsg + '  Creating PO Will Exclude Those Lines.'#13#13 +
            'Please Change the Preference if You Need to Convert them Again.' +chr(13) +chr(13) +
            'Do you wish to Continue Creating PO for the Unconverted Lines?' , mtConfirmation, [mbyes,mbNo] , 0) = mrno then Exit;
        end;
    end;

    ProgressDialog:= TProgressDialog.Create(nil);
    tbldetails.DisableControls;
    SaveHideconvertedLines:= HideconvertedLines;
    try
      if HideconvertedLines then
        HideconvertedLines:= false;

      if (grdLines.SelectedList.Count > 0) and (grdLines.SelectedList.Count <> SmartOrder.Lines.count) then
      begin
        if MessageDlgXP_Vista('You Have Selected ' +IntToStr(grdLines.SelectedList.Count) +' of ' +IntToStr(SmartOrder.Lines.count) +' Line(s) to Convert.  Only the Selected Lines Will Convert.' +chr(13)+chr(13)+
                              'If you Select No Lines, The Entire Smart Order will Convert.'+chr(13) +chr(13) +
                              'Do you wish to Continue Creating Purchase Orders for the Selected Line(s) ?' , mtConfirmation, [mbyes,mbNo] , 0) = mrno then Exit;
      end;

      if SetMultiSelectFilter then
      begin
        try
          SmartOrder.ProgressDialog:= ProgressDialog;
          IDs :=SmartOrder.CopySmartOrderToPO;
          POIDs := IDs;
        finally
          SetMultiSelectFilter(False);
        end;
      REsult:= True;
      end;
    finally
      tblDetails.EnableControls;
      ProgressDialog.Free;
      SmartOrder.ProgressDialog:= nil;
      if SaveHideconvertedLines <> HideconvertedLines then
        HideconvertedLines:= SaveHideconvertedLines;
    end;
end;

procedure TSmartOrderGUI.PrintPO(PurchaseOrderID: integer);
var
  sSQL: string;
begin
  sSQL := Format('AND d2.PurchaseOrderID = %d', [PurchaseOrderID]);

  if chkGroupClass.Checked then begin
    sSQL := sSQL + ' Group by ProductID;'
  end else begin
    sSQL := sSQL + ' Group by PurchaseLineID;'
  end;

  PrintTemplateReport('TPurchaseGUI', sSQL, (not chkPreview.Checked), 1);
end;

procedure TSmartOrderGUI.btnPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
begin
  OptsForm := TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Print');
    OptsForm.ActionList.Add('Print' ,'Print the smart Order',DoPrintSO, false, true);
    OptsForm.ActionList.Add('Preview', 'Preview  the smart Order', DoPreviewSO, true, true);
    OptsForm.ActionList.Add('Save PDF','Save a PDF  the smart Order', SaveSoToPDF, true, true);

    OptsForm.ActionList.AddDivider('Email');
    OptsForm.ActionList.Add('Email', 'Email a copy of the smart Order', self.SoEmailSO, false, true);
    OptsForm.ActionList.Add('Email RFQ', 'Email Request For Quote', self.EmailRFQ, false, true);

    OptsForm.ShowModal;
    CloseAfterPrint(OptsForm.CloseWhenDone);
  finally
    OptsForm.Free;
  end;
end;
procedure TSmartOrderGUI.btnRFQClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormModal('TSmartOrderRFQsGUI' , nil , initSmartOrderRFQs);
end;

procedure TSmartOrderGUI.DoPreviewSO;
begin
  DisableForm;
  try
    if not SaveData then exit;
    smartOrder.Connection.CommitTransaction;
    try
      PrintSO(False);
      CloseAfterPrint;
    finally
      smartOrder.Connection.RollbackTransaction;
    end;

  finally
    EnableForm;
  end;

end;

Procedure TSmartOrderGUI.DoPrintSO;
begin
  DisableForm;
  try
    if not SaveData then exit;
    smartOrder.Connection.CommitTransaction;
    try
      PrintSO(False, 0 , true);
      CloseAfterPrint;
    finally
      smartOrder.Connection.RollbackTransaction;
    end;

  finally
    EnableForm;
  end;
end;


Procedure TSmartOrderGUI.PrintSO(const ShowCancelAll:Boolean ; const supplierID:Integer=0;fbPrint :Boolean = False;fbEmail :Boolean=False; fbSAvetoPDF:Boolean=False;filename:String='') ;
var
  sSQL: string;
  msgoption:Word;
  lSecret, lSilent : boolean;
begin

  if fbEmail then
    if not EmailShortSendMode(lSilent, lSecret) then
      exit;

  if ReportToPrint ='' then TemplateReportName[ChkchooseReport.checked,''];
  if Empty(ReportToPrint) then ReportToPrint := 'TSmartOrderGUI';

  sSQL := 'AND d2.SmartOrderID = ' + inttostr(tblMasterSmartOrderID.AsInteger) +' GROUP BY d3.SmartOrderLinesID';
  if supplierID <> 0 then ssql := ssql +'~|||~~|||~where clientId =' + inttostr(supplierID);

{----}if fbEmail and (supplierID<>0) then
        EmailReport(smartOrder.Id , tcdatautils.getSupplierName(SupplierID) , tcdatautils.clientemail(SupplierID) ,TemplateTypeName(GetReportTypeID) , reporttoprint, ssql, false, true , False, lSilent, lSecret)
{----}else if fbEmail  then begin
        EmailReport(smartOrder.Id , '' , '', TemplateTypeName(GetReportTypeID) , reporttoprint, ssql, false, true, False, lSIlent, lSecret);
{----}end else if fbSAvetoPDF then begin
        SaveTemplateReport(ReportToPrint, sSQL, False, 'PDF', filename);
        msgoption := MessageDlgXP_Vista('The smart Order is exported to ' + Quotedstr(FileName), mtWarning, [mbOK], 0 , nil , '' , '' , False, nil , 'Open File Location,Open File');
        if msgoption = 100 then ShellExecute(Handle, 'Open', PChar(ExtractFilePath(fileName)) , '', '', SW_SHOWNORMAL)
        else if msgoption = 101 then ShellExecute(Handle, 'Open', PChar(fileName) , '', '', SW_SHOWNORMAL);
{----}end else PrintTemplateReport(ReportToPrint, sSQL, fbPrint, 1, nil , '' , ShowCancelAll);
end;

procedure TSmartOrderGUI.EmalRFQs(Sender: TwwDbGrid);
var
  i: integer;
  bm:TBookmark;
  it :TIntegerList;
begin
  if Sender.DataSource.DataSet.FindField('clientID') = nil then exit;
  it :=TIntegerList.Create;
  try
      bm := Sender.datasource.dataset.GetBookmark;
      try
          if Sender.SelectedList.Count > 0 then begin
            for i := 0 to Sender.SelectedList.Count - 1 do begin
              Sender.datasource.dataset.GoToBookmark(Sender.SelectedList.Items[i]);
              if it.Indexof(Sender.DataSource.DataSet.FindField('clientID').AsInteger) <0 then begin
                It.Add(Sender.DataSource.DataSet.FindField('clientID').AsInteger);
                PrintSO(True,Sender.DataSource.DataSet.FindField('clientID').AsInteger, False , true);
                SmartOrder.RFQs.New;
                SmartOrder.RFQs.SupplierId := Sender.DataSource.DataSet.FindField('clientID').AsInteger;
                SmartOrder.RFQs.PostDB;
              end;
            end;
          end;
      finally
        Sender.datasource.dataset.GotoBookmark(bm);
        Sender.datasource.dataset.FreeBookmark(bm);
      end;
  finally
    Freeandnil(it);
  end;
end;

procedure TSmartOrderGUI.EmailRFQ;
begin
  inherited;

  if (ReportToPrint ='') or (not(Stringcontains(ReportToPrint , '(RFQ)'))) then
    TemplateReportName[true ,  ' and TemplName like ' + Quotedstr('%(RFQ)%')];

  if (ReportToPrint ='') then exit
  else  if (not(Stringcontains(ReportToPrint , '(RFQ)'))) then begin
    MessageDlgXP_Vista('Please Select a ''Request for Quote'' (RFQ) template. ', mtInformation, [mbOK], 0);
    Exit;
  end;

  DisableForm;
  try
    if not SaveData then exit;
    smartOrder.Connection.CommitTransaction;
    try
      OpenERPListFormultiselectModal('TSupplierListforSmartOrderRequestgui' ,initSupplierListforSmartOrderRequest , EmalRFQs);
      CloseAfterPrint;
    finally
      smartOrder.Connection.RollbackTransaction;
    end;

  finally
    EnableForm;
  end;
end;
procedure TSmartOrderGUI.TogglePOCreate(bState: boolean);
begin
  CmdCreatePOs.Enabled := bState;
end;

procedure TSmartOrderGUI.grdLinesCalcTitleImage(Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if Field.Fieldname <> SMART_JOBNUMBER_MAINGRIDFIELD then begin
    if FastFuncs.PosEx('[' + Field.FieldName + ']' + ' ASC', tblDetails.IndexFieldNames) > 0 then begin
      TitleImageAttributes.ImageIndex := 0;
    end else if FastFuncs.PosEx('[' + Field.FieldName + ']' + ' DESC', tblDetails.IndexFieldNames) > 0 then begin
      TitleImageAttributes.ImageIndex := 1;
    end else begin
      TitleImageAttributes.ImageIndex := -1;
    end;
  end else begin
    TitleImageAttributes.ImageIndex := -1;
  end;
end;

procedure TSmartOrderGUI.grdLinesDblClick(Sender: TObject);
begin
  inherited;
  if showformuladetails then exit;
end;

procedure TSmartOrderGUI.chkApprovedClick(Sender: TObject);
begin
  inherited;
  DoOnapproval;
end;

procedure TSmartOrderGUI.chkPrintClick(Sender: TObject);
begin
  inherited;
  chkPreview.enabled := chkPrint.Checked;
  chkGroupClass.enabled := chkPrint.Checked;
  LblShowPreview.enabled := chkPrint.Checked;
end;

procedure TSmartOrderGUI.cboProductRCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
    if not Modified then Exit;
    RefreshUnitsQry;
end;

procedure TSmartOrderGUI.SetProductID(iValue: integer);
begin
    fiProductID := iValue;
    if foCombo is TwwDBLookupCombo then begin
        if TwwDBLookupCombo(foCombo).LookupTable.Locate('PartsID', iValue, [loCaseInsensitive]) then begin
            smartOrder.Lines.PartsId := ivalue;
            TwwDBLookupCombo(foCombo).OnCloseUp(foCombo, TwwDBLookupCombo(foCombo).LookupTable,
                TwwDBLookupCombo(foCombo).DataSource.DataSet, true);
        end;
  end else if foCombo is TwwDBEdit then
    if TwwDBEdit(foCombo).DataSource.DataSet.Locate('PartsID', iValue, [loCaseInsensitive]) then
        smartOrder.Lines.PartsId := ivalue;
  SetControlFocus(grdLines);
end;

procedure TSmartOrderGUI.tblDetailsPARTSIDChange(Sender: TField);
begin
    TaxCodeDetails.Close;
    TaxCodeDetails.ParamByName('TAXCODE').AsString := cboProductQry.FieldByName('PURCHTAXCODE').AsString;
    TaxCodeDetails.Open;

    if smartOrder.Lines.SupplierID = 0  then begin
          CommonLib.MessageDlgXP_Vista('Please Select A Preferred Supplier From The Drop Down Box ' +
            'For This Product Or Simply Type In The New Supplier.',mtInformation, [mbOK], 0);
    end;
end;

procedure TSmartOrderGUI.tblMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
  edtSaleID.visible := tblMasterSaleID.asInteger <> 0;
  lblSaleID.visible := tblMasterSaleID.asInteger <> 0;
  chkSendEmail.checked := (AppEnv.CompanyPrefs.DefaultNotifyNewSmartOrder     and (tblMasterSaleID.asInteger = 0))  or
                          (AppEnv.CompanyPrefs.DefaultNotifyEditingSmartOrder and (tblMasterSaleID.asInteger <> 0));
  chkShow.checked := AppEnv.CompanyPrefs.DefaultShowPOfromSmartOrder;
  InitERPLookupCombonFields;
end;

procedure TSmartOrderGUI.tblMasterCalcFields(DataSet: TDataSet);
begin
  inherited;
  tblMasterSaleID.asInteger := tcdatautils.GetSaleIDForGlobalRef(tblMasterSalesglobalRef.asString);
  tblMasterSaletype.asString:= tcdatautils.SaleType(tblMasterSalesglobalRef.asString);
end;

procedure TSmartOrderGUI.grdLinesRowChanged(Sender: TObject);
begin
  inherited;
  RefreshUnitsQry;
  CheckForAttachments;
end;

procedure TSmartOrderGUI.RefreshUnitsQry;
begin
  qryUnitOfMeasure.Close;
  qryUnitOfMeasure.ParamByName('xPartID').AsInteger := tblDetailsPARTSID.AsInteger;
  qryUnitOfMeasure.Open;
end;

procedure TSmartOrderGUI.TaxCodeDetailsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  TaxCodeDetails.ParamByName('xRegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

function TSmartOrderGUI.GetReportTypeID: Integer;
begin
  Result := 45;
end;

procedure TSmartOrderGUI.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    inherited;
    CanClose := false;
    if SmartOrder.Dirty then begin
        case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
            mrYes: begin
                    if SaveData then begin
                        CanClose := true;
                    end;
                end;
            mrNo:begin
                    RollbackTransaction;
                    SmartOrder.Dirty := false;
                    CanClose := true;
                end;
            mrCancel:begin
                    CanClose := false;
                end;
        end;
    end else begin
        CanClose := true;
    end;
end;

procedure TSmartOrderGUI.grdLinesEnter(Sender: TObject);
begin
  inherited;
  if smartOrder.Lines.count = 0 then
    if SmartOrder.Lines.dataset.state <> dsInsert then
    begin
      smartOrder.PostDB;
      SmartOrder.Lines.new;
    end;
  
end;

procedure TSmartOrderGUI.grdLinesKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (grdlines.ColumnByName(grdlines.GetActiveField.fieldname).ReadOnly) And (Key <> TAB) then begin
    if SysUtils.SameText(grdlines.GetActiveField.fieldname, tbldetailsWastagePercentage.FieldName ) then begin
      CommonLib.MessageDlgXP_Vista('You cannot change Wastage Percentage.'+NL+
                                    'This field is automatically updated and applied when Smart Order is automatically created '+NL+
                                    'It is not applicable when ' + tblDetailsUnitofMeasureQty.FieldName +' is changed.', mtWarning, [mbOk], 0);
    End Else Begin
      CommonLib.MessageDlgXP_Vista('You do not have Access to change "' + grdlines.ColumnByName(grdlines.GetActiveField.fieldname).DisplayLabel + '"', mtWarning, [mbOk], 0);
    End;
  End;
end;

procedure TSmartOrderGUI.cboApproverCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  DoOnapproval;
end;

procedure TSmartOrderGUI.cboClientRCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
var
  msg: string;
  s:String;
begin
  if not modified then Exit;
  inherited;
  SmartOrder.Lines.SupplierName       := TERPDBLookupcombo(Sender).Lookuptable.fieldbyname('Company').asString;
  SmartOrder.Lines.SupplierPrintName  := TERPDBLookupcombo(Sender).Lookuptable.fieldbyname('PrintName').asString;
  SmartOrder.Lines.postdb;
  if (not AppEnv.CompanyPrefs.NoPreferredSuppQuestion) then begin
    if SmartOrder.Lines.SupplierName <> SmartOrder.Lines.Product.PreferedSupplierName then begin
      if SmartOrder.Lines.Product.Lock then begin
          Try
              if CommonLib.MessageDlgXP_Vista('Do you want to set ' + SmartOrder.Lines.SupplierName +
                ' as the Preferred Supplier for product ' + SmartOrder.Lines.Product.ProductName +
                '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
                s:='update tblparts set PREFEREDSUPP = ' +quotedstr(SmartOrder.Lines.SupplierName) +
                    ' where partsId = ' +intToStr(SmartOrder.Lines.PARTSID);
                SmartOrder.Lines.GetNewDataSet(s, true);
              end;
          Finally
              SmartOrder.Lines.Product.Unlock;
          end;
      end else begin
          msg := 'Unable to update ' + SmartOrder.Lines.Product.ProductName + ' Preferred supplier as product is being updated by "' +
            SmartOrder.Lines.Product.UserLock.LockInfo.UserName + '" with: ' + SmartOrder.Lines.Product.UserLock.LockInfo.LockingForm;
          SmartOrder.ResultStatus.AddItem(true, rssWarning, 1, msg, False);
      end;
    end;
  end;

end;

procedure TSmartOrderGUI.cboEquipmentnameCloseUp(Sender: TObject;LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
end;

function TSmartOrderGUI.Linecount: Integer;
begin
  With TempMyQuery do try
    SQL.add('Select count(*) ctr  from tblsmartorderlines where SmartOrderId = ' +inttostr(SmartOrder.ID));
    open;
    result := FieldByname('ctr').asInteger;
  finally
    if active then close;
    Free;
  end;
end;

procedure TSmartOrderGUI.Setcolumn(columnVisible: Boolean; columnName, displaylabel: String);
begin
  if columnVisible then begin
    if displaylabel <> '' then begin
      if grdlines.ColumnByName(columnName) = nil then begin
        if tbldetails.findfield(columnName) <> nil then
          tbldetails.fieldbyname(columnName).DisplayLabel :=DisplayLabel;
      end else begin
        grdlines.ColumnByName(columnName).DisplayLabel := DisplayLabel;
      end;
    end;
  end else begin
    guiprefs.DbGridElement[grdlines].RemoveField(columnName);
  end;
end;

procedure TSmartOrderGUI.SetGridColumns;

  Procedure ShowGridfields(Const GridField:String; Const FieldVisible :Boolean);
  begin
    if not FieldVisible then begin
      grdLines.RemoveField(GridField);
    end;
  end;

begin

    ShowGridfields( 'SupplierContact',AppEnv.CompanyPrefs.ShowSupplierContactonSO);
    ShowGridfields( 'DocketNumber',AppEnv.CompanyPrefs.ShowDocketNumberColumnOnPurchases);
    GuiPrefs.DbGridElement[grdLines].RemoveFields(
        'saleLineID,Deleted,ClassId,SmartOrderLinesID,SmartOrderId,'+
        'Editedflag,GroupId,grouplineID,groupheader,unitofmeasuremultiplier,' +
        'SearchFilterCopy,SearchFilter,PurchaseOrderID,PurchaseLineId,'+
        'UnitofMeasureID,CusJobID,Qty,PreferredSuppleir,CustomerEquipmentID,TotalQty,TotalUOMqty,TobuildQty,volume');
end;

procedure TSmartOrderGUI.cboEquipmentnameDblClick(Sender: TObject);
begin
  inherited;
//don;t delete, to skip the ondblclick event from baseinput
end;

procedure TSmartOrderGUI.cboEquipmentnameNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
//don;t delete, to skip the not in list event from baseinput
end;

procedure TSmartOrderGUI.setHideconvertedLines(const Value: Boolean);
begin
  fbHideconvertedLines := Value;
  SmartOrder.HideconvertedLines := Value;
  if Value then btnHideConverted.caption := 'Show All' else btnHideConverted.caption := 'Hide Converted';
end;

function TSmartOrderGUI.SetMultiSelectFilter(const enablefilter :Boolean =true): boolean;
var
  Ids, fsFilter:String;
  i:Integer;
begin
  result:= true;
  fsFilter := smartorder.lines.dataset.filter;
  if not enablefilter then begin
      fsFilter := trim(smartorder.lines.dataset.filter);
      fsFilter := trim(StringReplace(fsFilter, '(' + fsMultiselectFilter+')' , '',  []));
      if copy(fsFilter , char_length(fsFilter)-2 , 3) = 'and' then fsFilter := copy(fsFilter, 1, char_length(fsFilter)-3);
  end else begin
      for i := 0 to grdLines.SelectedList.Count - 1 do begin
        try
          tblDetails.GotoBookmark(grdLines.SelectedList.Items[i]);
        except
          result:= false;
          MessageDlgXP_Vista('Selection has changed, please reselect lines and try again.',mtInformation,[mbOk],0);
          grdLines.SelectedList.Clear;
          exit;
        end;
        if Ids<> '' then Ids := Ids+' or ';
        Ids := Ids +  'SmartOrderLinesID = ' + IntToStr(tblDetailsSmartOrderLinesID.asInteger);
      end;
      if Ids <> '' then begin
        fsMultiselectFilter := Ids;
        if fsFilter <> '' then fsFilter := fsFilter + ' and ';
        fsFilter := fsFilter + '(' + fsMultiselectFilter+')';
      end;
  end;
  if smartorder.lines.dataset.filter<> fsFilter then begin
    smartorder.lines.dataset.filter:= fsFilter;
    smartorder.lines.dataset.filtered := fsFilter<> '';
  end;
end;

procedure TSmartOrderGUI.btnHideConvertedClick(Sender: TObject);
begin
  inherited;
  HideconvertedLines := not(fbHideconvertedLines);
  grdLines.SelectedList.Clear;
end;

procedure TSmartOrderGUI.btnMakeRFGClick(Sender: TObject);
begin
  inherited;
  EmailRFQ;
end;

procedure TSmartOrderGUI.actSelectRecordUpdate(Sender: TObject);
begin
  inherited;
  if tblDetails.recordcount = grdLines.SelectedList.Count then begin
    actSelectRecord.Caption :='UnSelect All';
  end else begin
    actSelectRecord.Caption :='Select All';
  end;
end;

procedure TSmartOrderGUI.actSummaryExecute(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TfmSmartOrderSummary' , 0, beforeshowSmartOrderSummary , True)
end;
procedure TSmartOrderGUI.beforeshowSmartOrderSummary(Sender: TObject);
begin
  SmartOrder.Lines.PostDb;
  if not(Sender is TfmSmartOrderSummary) then exit;
  TfmSmartOrderSummary(Sender).SmartOrderId := SmartOrder.ID;
  TfmSmartOrderSummary(Sender).MyConnection := Self.MyConnection;
end;

procedure TSmartOrderGUI.actSummaryUpdate(Sender: TObject);
begin
  inherited;
  ActSummary.Enabled := Smartorder.lines.count >1;
end;

procedure TSmartOrderGUI.actSelectRecordExecute(Sender: TObject);
begin
  if actSelectRecord.Caption ='UnSelect All' then
    grdLines.UnSelectAll
  else
    grdLines.selectAll;
  actSelectRecordUpdate(actSelectRecord);
  Refresh;
end;

procedure TSmartOrderGUI.grdLinesMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  try
  if selecting then begin

    if (tbldetailsQty.AsFloat =0) and (tbldetailstobuildQty.AsFloat=0) then begin
      TimerMsg(lblMsg , SmartOrder.lines.Productname +' has no Qty to order to to build' , 5);
      accept := False;
      Exit;
    end;

    if not appenv.CompanyPrefs.ConvertConvertedSmartOrder then
      if tblDetailsconverted.asBoolean then begin
        TimerMsg(lblMsg , SmartOrder.lines.Productname +' is already converted and converting a converted smart order is disabled in the preference' , 5);
        accept := False;
        Exit;
      end;
    if (tblDetailsSupplierID.asInteger =0) and (tbldetailsQty.AsFloat >0) then begin
        TimerMsg(lblMsg , SmartOrder.lines.Productname +' has no Preferred Supplier' , 5);
        accept := False;
        Exit;
      end;
  end;
  finally
    actSelectRecordUpdate(actSelectRecord);
  end;

end;

procedure TSmartOrderGUI.grdLinesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if Field.Readonly then
      AFont.Color := clInactiveCaption;
  if fiproctreeId <> 0 then
    if Smartorder.Lines.proctreeId = fiproctreeId then
      AFont.Style := AFont.Style + [fsBold] ;
  if ((field = tblDetailsCostEx) or (field = tblDetailsCostInc)) and SmartOrder.Lines.UserEnteredCost then
    AFont.Color := clMaroon;

  With TPartCalcFormula.create(Self) do try   gridCalcCellColors(SmartOrder.lines.Hasformula  , Sender,Field,State,Highlight,AFont,ABrush);  finally    Free;  end;
end;

procedure TSmartOrderGUI.tblDetailsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  HideProgressbar;
end;

procedure TSmartOrderGUI.tblDetailsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  showProgressbar(WAITMSG, Linecount);

    tbldetailsWeight.Displayformat := FloatFieldDisplayFormat;
    tbldetailsHeight.Displayformat := FloatFieldDisplayFormat;
    tbldetailsLength.Displayformat := FloatFieldDisplayFormat;
    tbldetailsWidth.Displayformat := FloatFieldDisplayFormat;
    tbldetailsVolume.Displayformat := FloatFieldDisplayFormat;
    tbldetailsunitVolume.Displayformat := FloatFieldDisplayFormat;

    tbldetailsVolume4Qty.Displayformat := FloatFieldDisplayFormat;
    tbldetailsWeight4Qty.Displayformat := FloatFieldDisplayFormat;
end;

procedure TSmartOrderGUI.tblDetailsCalcFields(DataSet: TDataSet);
begin
  inherited;
  tblDetailsWeight4Qty.asFloat   := SmartOrder.lines.totalWeight;
  tblDetailsvolume4Qty.asFloat   := SmartOrder.lines.totalvolume;
  tblDetailsUnitVolume.asFloat   := SmartOrder.lines.unitVolume;
  tblDetailsAvailableQty.asFloat := GetProductAvailableQty(tblDetailsPARTSID.asInteger , tblDetailsClassID.asInteger);
  tblDetailsOnOrder.asFloat      := GetProductOnOrderQty(tblDetailsPARTSID.asInteger , tblDetailsClassID.asInteger);
  tblDetailsTotalCostEx.AsFloat  := SmartOrder.Lines.TotalCostEx;
  tblDetailsTotalCostInc.AsFloat := SmartOrder.Lines.TotalCostInc;
  stepProgressbar('Weights, Volume, Available Qty -'+tblDetailsPARTSNAME.asString );
end;

procedure TSmartOrderGUI.tblDetailsCostExChange(Sender: TField);
begin
  inherited;
  if grdLines.SelectedField = Sender then
    SmartOrder.Lines.UserEnteredCost := true;
end;

procedure TSmartOrderGUI.tblDetailsCostIncChange(Sender: TField);
begin
  inherited;
  if grdLines.SelectedField = Sender then
    SmartOrder.Lines.UserEnteredCost := true;
end;

Procedure TSmartOrderGUI.OptionsMenuclick(Sender:TObject);
begin
  OpenPrefform('Purchases' ,  'optTotalvolumeUOMInsmartOrder', 0 , True );
end;
procedure TSmartOrderGUI.AddOptionsMenu;
var
  NewItem: TMenuItem;
begin
    if Assigned(grdLines.PopupMenu) then begin
      NewItem := TMenuItem.Create(grdLines.PopupMenu);
      NewItem.Caption := 'Options';
      NewItem.OnClick := OptionsMenuclick;
      grdLines.PopupMenu.Items.Add(NewItem );

      NewItem := TMenuItem.Create(grdLines.PopupMenu);
      NewItem.Caption := 'Line Custom Fields';
      NewItem.OnClick := CustomFields1Click;
      grdLines.PopupMenu.Items.Add(NewItem );
    end;
end;
procedure TSmartOrderGUI.CustomFields1Click(Sender: TObject);
begin
  inherited;
  if OpenERPFormModal('TfmCustomfieldList', 0, beforeshowCustomfieldList)>=0  then begin
    CustomfieldonGrid.ApplyCustomFieldsSettings;
  end;
end;

procedure TSmartOrderGUI.beforeshowCustomfieldList(Sender: TObject);
begin
  if not(Sender is TfmCustomfieldList) then Exit;
  TfmCustomfieldList(Sender).ListType := ltSmartorderLines;
end;

procedure TSmartOrderGUI.ApplyCustomFieldsSettings;
begin
  CustomfieldonGrid := TCustomFieldonGrid.Create(Self,
    'CustomField1,CustomField2,CustomField3,CustomField4,CustomField5,CustomField6,CustomField7,CustomField8,CustomField9,CustomField10',
    ltSmartorderLines, grdLines, guiprefs, Smartorder);
  CustomfieldonGrid.ApplyCustomFieldsSettings;
end;

function TSmartOrderGUI.AnyConverted: Boolean;
var
  i:Integer;
begin
  result:= false;
  if grdLines.SelectedList.Count = 0 then result := Smartorder.IsAnyconverted
  else begin
    if grdLines.SelectedList.Count > 0 then begin
        for i := 0 to grdLines.SelectedList.Count - 1 do begin
          tblDetails.GotoBookmark(grdLines.SelectedList.Items[i]);
          if tblDetailsconverted.asBoolean then begin
              Result := True;
              Exit;
          end;
        end;
    end;
  end;
end;


procedure TSmartOrderGUI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  data: TJsonObject;
begin
  inherited;
  if (Key = 119) and ( (ssShift in Shift)) then begin  // f8
    if tblDetails.FindField('PartBarcode') <> nil then begin
      grdLines.AddField('PartBarcode');
      tblDetails.FindField('PartBarcode').index := 0;
      grdLines.SetActivefield('PartBarcode');
    end;
    Exit;
  end
  else if (KEY = VK_DOWN) and (ssCtrl in Shift) then begin
    { copy this line to a new one .. }
    if SmartOrder.Lines.ProductID > 0 then begin
      data := JO;
      try
        ObjToJson(SmartOrder.Lines,data);
        data.Delete('ID');
        data.Delete('GlobalRef');
        data.Delete('MsTimeStamp');
        data.Delete('MsUpdateSiteCode');
        data.Delete('KeyValue');
        data.Delete('CusJobID');
        data.Delete('CustPONumber');
        data.Delete('CusJobName');
        data.Delete('CusJobPrintName');
        data.Delete('RepairId');
        data.Delete('RepairPartsID');
        data.Delete('CustomerEquipmentID');
        data.Delete('EquipmentName');
        data.Delete('Converted');
        data.Delete('SaleLineID');
        data.Delete('HirePartsSaleID');
        data.Delete('ProcTreeId');
        SmartOrder.Lines.New;
        JsonToObj(data,SmartOrder.Lines);
      finally
        data.Free;
      end;
    end;
  end;
end;

procedure TSmartOrderGUI.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  lblMsg.Visible := False;
end;

procedure TSmartOrderGUI.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  bm :TBookmark;
begin
  inherited;
  if (Shift = [ssCtrl]) then
    if Chr(Key) = 'A' then begin
      if Smartorder.Lines.count =0 then exit;
      bm := Smartorder.Lines.dataset.getbookmark;
      try
        Smartorder.Lines.First;
        While Smartorder.Lines.eof = False do begin
          grdLines.SelectRecord;
          Smartorder.Lines.Next;
        end;
      finally
        Smartorder.Lines.dataset.GotoBookmark(bm);
        Smartorder.Lines.Dataset.FreeBookmark(bm);
      end;
    end;

end;

procedure TSmartOrderGUI.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  lblMsg.Visible := False;
end;

procedure TSmartOrderGUI.CreateBarcode(Sender: TObject);
begin
  with TwwDBGrid(Sender).Datasource.dataset do begin
    if active      = False then exit;
    if RecordCount = 0 then exit;
    if findfield('PartsId') = nil then exit;
    if fieldByname('PartsID').asInteger = 0 then exit;
    TProduct.AssignBarCode(fieldByname('PartsID').asInteger, SmartOrder.Lines.partbarcode);
  end;
end;

procedure TSmartOrderGUI.CreateBarcode(NewValue: String);
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
          ExpresslistPopup('Choose Product' , CreateBarCode, False);
          Showmodal;
    end;
  end else begin
        if TfrmParts.FormActive then begin
          TfrmParts.CloseMe;
        end;

        frm := TfrmParts(GetComponentByClassName('TfrmParts'));
        if assigned(frm) then begin
            TfrmParts(frm).fsBarcode := SmartOrder.lines.Partbarcode;
            frm.Position := poScreenCenter;
            if not frm.Visible then
              frm.ShowModal;
        end;
    end
  finally
    SmartOrder.Lines.PARTSNAME := tcdatautils.GetProductForbarCode(SmartOrder.lines.Partbarcode);
    if SmartOrder.Lines.PARTSNAME = '' then SmartOrder.lines.Partbarcode:= '';
  end;

end;

procedure TSmartOrderGUI.setSOID(const Value: Integer);
begin
  fiSOID := Value;
  if chkShow.Checked then begin
    OpenERPFormModal('TSalesOrderGUI' , Value);
  end;
end;

procedure TSmartOrderGUI.ShowAttachments(fbDragnDropping: boolean);
var
  tmpComponent: TComponent;
begin
  if tblDetailsSmartOrderLinesID.AsInteger < 1 then Exit; // need line id
  tmpComponent := TfmAttachments(GetComponentByClassName('TfmAttachments', False, self));
  if not Assigned(tmpComponent) then Exit;
  with TfmAttachments(tmpComponent) do begin
    DBConnection := Self.MyConnection;
    AttachObserver(Self);
    TableName := 'tblsmartorderlines';
    TableId := tblDetailsSmartOrderLinesID.AsInteger;
    DragnDropping :=fbDragnDropping;
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

function TSmartOrderGUI.showformuladetails: Boolean;
begin
  Result := False;
    if SmartOrder.lines.hasformula = False then exit;
    if  (grdlines.GetActiveField = tbldetails.findfield('UnitOfMeasureQty'))  or
        (grdlines.GetActiveField = tbldetails.findfield('FormulaQtyValue'))  or
        (grdlines.GetActiveField = tbldetails.findfield('FormulaQtyValue1'))  or
        (grdlines.GetActiveField = tbldetails.findfield('FormulaQtyValue2'))  or
        (grdlines.GetActiveField = tbldetails.findfield('FormulaQtyValue3'))  or
        (grdlines.GetActiveField = tbldetails.findfield('FormulaQtyValue4'))  or
        (grdlines.GetActiveField = tbldetails.findfield('FormulaQtyValue5'))  then begin
        Result := true;
        With TPartCalcFormula.Create(Self) do try          FormulaDetails(SmartOrder.Lines , SmartOrder.Lines.Product , False);        finally          Free;        end;
    end;
end;

procedure TSmartOrderGUI.SoEmailSO;
begin
  DisableForm;
  try
    if not SaveData then exit;
    smartOrder.Connection.CommitTransaction;
    try
      PrintSO(False, 0 , false , true);
      CloseAfterPrint;
    finally
      smartOrder.Connection.RollbackTransaction;
    end;

  finally
    EnableForm;
  end;

end;

procedure TSmartOrderGUI.InitERPLookupCombonFields;
begin
  inherited;
  SetupProductNamenPrintNameinGrid(cboProductR ,cboPrintProductR ,'PARTSNAME' , 'ProductPrintName' , 'PurchaseDesc' , grdLines );
  NamenPrintNameGridObj.SetupClientNamenPrintNameinGrid(0,cboCustomerJob ,cboPrintCustomerJob ,'CusJobName'  , 'CusJobPrintName'   , grdLines,False, True  , False, true , true );
  NamenPrintNameGridObj.SetupClientNamenPrintNameinGrid(0,cboClientR     ,cboPrintClientR     ,'SupplierName', 'SupplierPrintName' , grdLines,true , False , False, False, True );
  cboProductQry.SQL.Add('AND (P.ExcludeFromSmartOrder="F")');
  NamenPrintNameGridObj.ClientLookupQueryWithSearchengine(SmartOrder.DefaultSupplierID, cboDefaultSupplier, true ,false, false, false, true, '', nil, False);
end;

procedure TSmartOrderGUI.AddDefaultOrdermenuITems;
begin
  NewMenuItem('Insert Line'        , Inserline            , true  ,grdLines.PopupMenu);
  NewMenuItem('Default Order'      , ChangeToDefaultOrder , False ,grdLines.PopupMenu);
  NewMenuItem('Show Current Order' , showcurrentOrder     , False ,grdLines.PopupMenu);
end;

procedure TSmartOrderGUI.Inserline(Sender: TObject);
begin
  SetFocusedControl(grdlines);
  SendKeys('{INS}', true);
end;

procedure TSmartOrderGUI.ChangeToDefaultOrder(Sender: TObject);
begin
  inherited;
  tbldetails.IndexFieldNames:= '';
  if guiprefs <> nil then
    if guiprefs.Active then
      if guiprefs.DbGridElement[grdLines] <> nil then
        guiprefs.DbGridElement[grdLines].Node['IndexFieldNames'].asString := tbldetails.IndexFieldNames;

  showcurrentOrder(nil);
end;

procedure TSmartOrderGUI.CheckForAttachments;
var
  qry: TERPQuery;
begin
  if tblDetailsSmartOrderLinesID.AsInteger < 1 then begin
    btnAttachments.Enabled := False;
    Exit; // need line id
  end
  else begin
    btnAttachments.Enabled := true;
  end;

  qry := DbSharedObj.GetQuery(tblDetails.connection);
  try
    With qry do begin
      closedb(qry);
      qry.Sql.Text := 'SELECT AttachmentName FROM tblAttachments WHERE TableName = "tblsmartorderlines"' + ' AND TableId = ' + tblDetailsSmartOrderLinesID.AsString;
      opendb(qry);
      if RecordCount > 0 then btnAttachments.Color := $0077ff77
      else btnAttachments.Color := clBtnFace;
    end;
  finally
      DbSharedObj.ReleaseObj(qry);
  end;
end;

Procedure TSmartOrderGUI.showcurrentOrder(Sender: TObject);
var
  s:String;
begin
  s:= GridsortDescription(grdLines);
  if s<> '' then
      TimerMsg(lblMsg , s, 20);
end;


initialization
  RegisterClassOnce(TSmartOrderGUI);
  with FormFact do begin
    RegisterMe(TSmartOrderGUI, 'TSmartOrderListGUI_*=SmartOrderID');
    RegisterMe(TSmartOrderGUI, 'TSmartorderListDetailsGUI_*=SmartOrderID');
    RegisterMe(TSmartOrderGUI, 'TSalesSmartOrderListGUI_*=SmartOrderID');
    RegisterMe(TSmartOrderGUI, 'TSalesPurchaseOrderListGUI_*_Smart Order=SmartOrderId');
    RegisterMe(TSmartOrderGUI, 'TAllTransactionGUI_*_Smart Order=TransNo');
    RegisterMe(TSmartOrderGUI, 'TSalesSmartPOListGUI_*_SO=SmartOrderId');
    RegisterMe(TSmartOrderGUI, 'THireSmartOrderListGUI_*_Smart Order=ID');
    RegisterMe(TSmartOrderGUI, 'TBackOrderPurchaseOrderExpressGUI_SmartOrderId=SmartOrderId');
    RegisterMe(TSmartOrderGUI, 'TPurchaseOrderListExpressGUI_SmartOrderId=SmartOrderId');
    RegisterMe(TSmartOrderGUI, 'TBackOrderPurchaseListGUI_SmartOrderId=SmartOrderId');
    RegisterMe(TSmartOrderGUI, 'TPurchaseOrderListGUI_SmartOrderId=SmartOrderId');
  end;
end.




