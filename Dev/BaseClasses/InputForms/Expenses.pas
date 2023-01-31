unit Expenses;


{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 12/08/05  1.00.01 BJ  Serialno fieldtype is changed to Mediumtext
 14/09/05  1.00.02 IJB Added Attachments.
 10/10/05  1.00.03 AL  When user picks a company, program fills the Currency code box
                       and sets the rate for the Date in DateCombo
                       When user changes currency code or date, program updates
                       the Exchange Rate...
 11/10/05  1.00.04 AL  ...and update all lines and recalculates the foreign amount
 09/01/06  1.00.05 AL  Added SearchEngineObj usage to Account Name Combo
 03/02/06  1.00.06 IJB Removed Try Except from FormShow ... this should only
                       be implemented at top level form.
 29/05/06  1.00.07 BJ   chkDisableCalcs is made invisible in the template and is no more applciable
                        the calculations are done always.
 01/09/08          RM  Changed persistant field 'OrderDate' to DateTime
}
interface

uses
  Windows, DateUtils, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseTransForm, DB, wwdbdatetimepicker, wwdblook, StdCtrls, DBCtrls,
  Mask, ExtCtrls, wwcheckbox, Buttons, DNMSpeedButton, DNMPanel, Wwdbigrd, Grids, Wwdbgrid,
  ActnList, Menus, AdvMenus, ImgList, SelectionDialog, AppEvnts, wwdbedit, MemDS,
  DBAccess, MyAccess,ERPdbComponents, DataState, DMComps, Forms,
  Commonlib,Shader, busobjExpenses, busobjbase, XMLDoc, XMLIntf,
  CustomerJobRepairSelection, ProgressDialog, ERPDbLookupCombo, DNMAction,
  frmAttachments, CustomfieldonGrid;

type
  TBaseExpenseGUI = class(TBaseTransGUI)
    txtInvNumber: TDBEdit;
    Label43: TLabel;
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
    txtSalesComments: TDBMemo;
    Label93: TLabel;
    tblMasterBOID: TWideStringField;
    cboTermsQry: TERPQuery;
    tblDetailsProductID: TIntegerField;
    tblDetailsPartType: TWideStringField;
    tblDetailsIncomeAccnt: TWideStringField;
    tblDetailsAssetAccnt: TWideStringField;
    tblDetailsCogsAccnt: TWideStringField;
    tblDetailsClassID: TIntegerField;
    tblMasterAccountID: TIntegerField;
    tblMasterClientID: TIntegerField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterIsCheque: TWideStringField;
    cboAccountlineX: TERPDbLookupCombo;
    cboAccountlNoLine: TERPDbLookupCombo;
    cboClass: TwwDBLookupCombo;
    tblDetailsCalcPriceInc: TCurrencyField;
    tblDetailsCalcTotalInc: TCurrencyField;
    tblDetailsCalcTotalEx: TCurrencyField;
    tblDetailsCalcTax: TCurrencyField;
    tblDetailsAvgCost: TFloatField;
    tblDetailsCustomerJobID: TIntegerField;
    tblDetailsCOGSTotalLineAmount: TFloatField;
    tblDetailsCOGSTotalLineAmountInc: TFloatField;
    tblMasterPrintedBy: TWideStringField;
    tblMasterEnteredBy: TWideStringField;
    tblMasterEnteredAt: TWideStringField;
    tblDetailsAttrib1Purchase: TFloatField;
    tblDetailsAttrib2Purchase: TFloatField;
    tblDetailsAttrib1PurchaseRate: TFloatField;
    tblDetailsLastLineID: TIntegerField;
    tblDetailsForeignExchangeRate: TFloatField;
    tblDetailsForeignExchangeCode: TWideStringField;
    tblDetailsForeignCurrencyLineCost: TFloatField;
    tblDetailsUnitofMeasureQtySold: TFloatField;
    tblDetailsUnitofMeasureShipped: TFloatField;
    tblDetailsUnitofMeasureBackorder: TFloatField;
    tblDetailsUnitofMeasureMultiplier: TFloatField;
    tblDetailsLandedCostsPerItem: TFloatField;
    tblDetailsRelatedPOID: TIntegerField;
    tblDetailsRelatedPOIDUsed: TWideStringField;
    tblDetailsUnitofMeasurePOLines: TWideStringField;
    tblDetailsAccountNumber: TWideStringField;
    tblMasterRefNo: TWideStringField;
    tblMasterIsPOCredit: TWideStringField;
    tblMasterInvoiceDate: TDateField;
    tblMasterConNote: TWideStringField;
    tblMasterCustPONumber: TWideStringField;
    tblDetailsSearchFilter: TWideStringField;
    tblDetailsSearchFilterCopy: TWideStringField;
    tblDetailsReceivedDate: TDateField;
    tblDetailsLandedCostsPercentage: TFloatField;
    tblDetailsLandedCostsTotal: TFloatField;
    cboAccountQry: TERPQuery;
    cboAccountLinesQry: TERPQuery;
    cboAccountLinesQryAccountName: TWideStringField;
    cboAccountLinesQryAccountTree: TWideStringField;
    cboAccountLinesQryType: TWideStringField;
    cboAccountLinesQryDescription: TWideStringField;
    cboAccountLinesQryActive: TWideStringField;
    cboAccountLinesQryAccountNumber: TWideStringField;
    cboAccountLinesQryAccountNo: TWideStringField;
    cboAccountLinesQryAccountID: TIntegerField;
    cboAccountLinesQryAccountGroup: TWideStringField;
    cboAccountLinesQryTaxcode: TWideStringField;
    cboAccountLinesQryFullAccountName: TWideStringField;
    qryCustomerJob: TERPQuery;
    tblDetailsserialno: TWideMemoField;
    DMTextTargetExpense: TDMTextTarget;
    btnAttachments: TDNMSpeedButton;
    tblMasterLastUpdated: TDateTimeField;
    tblMasterSeqNo: TIntegerField;
    tblMasterForeignExchangeCode: TWideStringField;
    tblMasterForeignExchangeRate: TFloatField;
    tblMasterForeignTotalAmount: TFloatField;
    tblMasterForeignPaidAmount: TFloatField;
    tblMasterForeignBalanceAmount: TFloatField;
    tblDetailsForeignTotalLineAmount: TFloatField;
    tblDetailsNewForeignExchangeRate: TFloatField;
    tblDetailsUnitOfMeasureID: TIntegerField;
    tblMasterBaseNo: TWideStringField;
    cboRelatedPOID: TwwDBLookupCombo;
    tblMasterExpenseClaimEmployee: TIntegerField;
    cboExpenseClaimEmployee: TwwDBLookupCombo;
    lblEmployeeExpenseClaim: TLabel;
    cboClientLookupClientID: TIntegerField;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupStreet: TWideStringField;
    cboClientLookupStreet2: TWideStringField;
    cboClientLookupStreet3: TWideStringField;
    cboClientLookupSuburb: TWideStringField;
    cboClientLookupState: TWideStringField;
    cboClientLookupCountry: TWideStringField;
    cboClientLookupPostcode: TWideStringField;
    cboClientLookupBillStreet: TWideStringField;
    cboClientLookupBillStreet2: TWideStringField;
    cboClientLookupBillStreet3: TWideStringField;
    cboClientLookupBillSuburb: TWideStringField;
    cboClientLookupBillState: TWideStringField;
    cboClientLookupBillPostcode: TWideStringField;
    cboClientLookupBillCountry: TWideStringField;
    cboClientLookupTERMS: TWideStringField;
    cboClientLookupTermsID: TIntegerField;
    cboClientLookupShippingMethod: TWideStringField;
    cboClientLookupShippingID: TIntegerField;
    cboClientLookupRepID: TIntegerField;
    cboClientLookupForeignExchangeSellCode: TWideStringField;
    tblDetailsSEQNo: TIntegerField;
    tblDetailsSortID: TIntegerField;
    tblDetailsLinesOrder: TIntegerField;
    tblMasterOrderDate: TDateTimeField;
    tblmastercontactID: TLargeintField;
    tblMasterContactName:TWideStringField;
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
    qryRepairEquipClientID: TIntegerField;
    lblEnteredAtHead: TLabel;
    lblEnteredAt: TDBText;
    cboAccountNoLineQuery: TERPQuery;
    cboAccountNoLineQueryAccountTree: TWideStringField;
    cboAccountNoLineQueryFullAccountName: TWideStringField;
    cboAccountNoLineQueryAccountName: TWideStringField;
    cboAccountNoLineQueryAccountID: TIntegerField;
    cboAccountNoLineQueryAccountNumber: TWideStringField;
    cboAccountNoLineQueryAccountNo: TWideStringField;
    cboAccountNoLineQueryAccountGroup: TWideStringField;
    cboAccountNoLineQueryType: TWideStringField;
    cboAccountNoLineQueryDescription: TWideStringField;
    cboAccountNoLineQueryTaxcode: TWideStringField;
    cboAccountNoLineQueryActive: TWideStringField;
    qryRepairEquipRepairNo: TWideStringField;
    qryRepairLookup: TERPQuery;
    qryRepairLookupRepairDocNo: TWideStringField;
    qryRepairLookupCustomerName: TWideStringField;
    qryRepairLookupRepairID: TIntegerField;
    cboRepairDocNo: TwwDBLookupCombo;
    tblDetailsRepairDocNo: TStringField;
    tblDetailsEmployeeID: TIntegerField;
    tblDetailsEmployeeName: TWideStringField;
    qryEmployeeLookup: TERPQuery;
    qryEmployeeLookupEmployeeName: TWideStringField;
    cboLineEmployee: TwwDBLookupCombo;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    tblMasterArea: TWideStringField;
    lblArea: TLabel;
    cboAreaCode: TwwDBLookupCombo;
    tblDetailsAreaCode: TWideStringField;
    tblMasterEnteredAtShort: TStringField;
    tblMasterOrderStatus: TWideStringField;
    tblDetailsExpenseProductID: TIntegerField;
    tblDetailsExpenseProductName: TWideStringField;
    tblDetailsExpenseProductSelected: TStringField;
    edtExpenseProductSelected: TwwDBEdit;
    qryImportedPOIDs: TERPQuery;
    tblMasterClientPrintName: TWideStringField;
    cboCustJob: TERPDbLookupCombo;
    cboCustPrintJob: TERPDbLookupCombo;
    btnfix: TButton;
    procedure FormShow(Sender: TObject);
    procedure cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboCustomerJobNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure grdTransactionsEnter(Sender: TObject);
    procedure cboAccountlineXNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure grdTransactionsRowChanged(Sender: TObject);
    procedure tblMasterOrderDateChange(Sender: TField);
    procedure FormActivate(Sender: TObject);
    procedure grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure btnCompletedClick(Sender: TObject);
    procedure cboCustomerJobExit(Sender: TObject);
    procedure btnAttachmentsClick(Sender: TObject);
    procedure DMTextTargetExpenseDrop(Sender: TObject; Acceptor: TWinControl; const DropText: string; X, Y: integer);
    procedure FormCreate(Sender: TObject);
    procedure cboBaseForeignCurrencyCodeOrDateChange(Sender: TObject);
    procedure EnableFXControls(Enabled: boolean);
    procedure cboBaseForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboAccountlineXExit(Sender: TObject);
    procedure grdTransactionsCalcTitleAttributes(Sender: TObject;
      AFieldName: String; AFont: TFont; ABrush: TBrush;
      var ATitleAlignment: TAlignment);
    procedure cboRelatedPOIDCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboExpenseClaimEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboExpenseClaimEmployeeExit(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure cboEquipmentNameCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cboEquipmentNameNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure cboEquipmentNameDblClick(Sender: TObject);
    procedure cboEquipmentNameBeforeDropDown(Sender: TObject);
    procedure cboAccountlNoLineBeforeOpenList(Sender: TObject);
    procedure cboAccountlineXBeforeOpenList(Sender: TObject);
    procedure tblMasterCalcFields(DataSet: TDataSet);
    procedure tblDetailsCalcFields(DataSet: TDataSet);
    procedure cboLinesAreaCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure grdTransactionsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure edtExpenseProductSelectedDblClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnfixClick(Sender: TObject);
    procedure tblMasterAfterOpen(DataSet: TDataSet);
    procedure tblDetailsAfterOpen(DataSet: TDataSet);
//    procedure FormKeyDown(Sender: TObject; var Key: Word;
//      Shift: TShiftState);

  private
    { Private declarations }
    fbCustomerJobState: boolean;
    fbIsRunningRefreshCalcs: boolean;
    fbaccountofAllowExpenseClaim:Boolean;
    fxtotex ,    fxtotinc ,   fxTax: double;
    KeysPressed:String;

//    fAccountSearched:Boolean;
//    fAccountSearchText:string;
//    fAccountLookupSQL:string;
//    fAccountSearchMode:string;
//    Attachments stuff
//    AccountSearcher: TwwDBComboSearcher;
//    ClientSearcher: TwwDBComboSearcher;
    procedure CheckForAttachments;
    function ShowAttachments(fbDragnDropping :Boolean): TfmAttachments;

    Procedure SetGridColumns;
//    Procedure InitCustJobRepairSelection;
//    function doAccountSearch(SearchText:String;bStartsWith:Boolean;const bAll:Boolean = False):Boolean;
//    function IsAccountInList(sAccountName:string):Boolean;
    procedure LoadLastTransactionsForSupplier;
    function ShowNoCustomerWarning: boolean;
    procedure AddPOLAreas(Sender: TwwDBGrid);
    function showAreaPOLinesList:boolean;
    procedure CalcAll(const Sender: TBusObj; var Abort: Boolean);
    procedure CustomFields1Click(Sender: TObject);
    procedure ApplyCustomFieldsSettings;
    procedure beforeshowCustomfieldList(Sender: TObject);

  protected
    ExpenseBase :TExpenseBase;
    CustomFieldonGrid:TCustomFieldonGrid;
//    CustomerJobRepairObj: TCustomerJobRepairObj;
    function GetTaxAccountName: string; override;
    //procedure UpdateDetailChartOfAccounts; override;
    procedure FilterAccountsForExpenseClaim(const Value: Boolean);
    Function IsNew:Boolean;
    procedure   DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;
    function InvalidChequetotalHandler(const msg :String; Buttons:TMsgDlgButtons  ; DlgType: TMsgDlgType =mtConfirmation) :Integer;virtual ;
    function getcontactType:TContactType;Override;
    (*Procedure UpdateFromContact(const value:TDataset);override;*)
    function FieldsToExecludeFromsorting: String ; override;
    procedure DoOnClientchange;Override;
    procedure NewTransBusObjinstance;override;
    function GetOrAddMobileNumber: string;
    function ClientState:String; Override;
    function Clientcountry:String; Override;
    function clientLocation:String; Override;
    function ClientPostcode:String; Override;
    procedure AssignAreacolumnName;Override;
    Procedure InitERPLookupCombonFields; Override;
    procedure AddProductPriceMenu;Virtual;
  public
    procedure UpdateMe; override;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
  end;

implementation

uses
   DNMExceptions, Math, frmChartOfAccountsFrm,
   DNMLib, BaseInputForm, frmSupplier,
  ActiveX, tcConst,
  tcDataUtils, strUtils,
  AppEnvironment, FastFuncs, BusObjConst, BusObjTrans, CommonDbLib,
  frmDelayMessageDlg, ChartOfAccountsListLookup, frmSimpleTypes,
  frmMobileNumberInput, BusObjContact, BusObjClient, SMSUtils,
  BusObjSimpleTypes, CommonFormLib, AreaPOLinesList, DbSharedObjectsObj,
  frmCustomfieldList , Busobjcustomfields; // TYMED_ISTREAM for DropMaster Target in form create

{$R *.dfm}
function TBaseExpenseGUI.InvalidChequetotalHandler(const msg :String; Buttons:TMsgDlgButtons  ; DlgType: TMsgDlgType =mtConfirmation) :Integer;
begin
    Result := mrYes;
end;
procedure TBaseExpenseGUI.FormCreate(Sender: TObject);
begin
  btnfix.visible := devmode;
  if Appenv.CompanyPrefs.PODefaultValueForAreaFrom='S' then
    DefaultValueForAreaFromHint(Appenv.CompanyPrefs.PODefaultValueForAreaFrom);
  fbaccountofAllowExpenseClaim:= False;


  inherited;

  NamenPrintNameGridObj.AccountLookupQueryWithSearchengine(0, cboAccountlNoLine);
  NamenPrintNameGridObj.AccountLookupQueryWithSearchengine(0, cboAccountlineX);

  ExpenseBase.ConfirmFromGUI  := InvalidChequetotalHandler;
  // Register to accept the custom formats that Outlook supplies.
  // We've also included dtfCustom in AcceptTextFormats at design time.
  with DMTextTargetExpense, CustomFormats do begin
    OverrideDropEffects[deMove] := deCopy;
    Add('FileGroupDescriptor');
    AddObject('FileContents', TObject(TYMED_ISTREAM));
  end;
  // hide Foreign Total
  lblBaseForeignTotal.Visible := false;
  edtBaseForeignTotal.Visible := false;

  EnableFXControls(AppEnv.CompanyPrefs.UseForeignCurrencyonPO); //Can company work with foreign currency?
end;

procedure TBaseExpenseGUI.FormShow(Sender: TObject);
begin
  //qryImportedPoIds.ParamByName('LocalFXCode').AsString:= AppEnv.RegionalOptions.ForeignExDefault;
  edtExpenseProductSelected.Hint := 'Double Click for the list to choose the ' + Appenv.CompanyPrefs.AreaColumnName +'(s)' +NL;
  stepProgressbar;
  DisableForm;
  try
    fbIsRunningRefreshCalcs := false;
    fbCustomerJobState      := true;

    GuiPrefs.DbGridElement[grdTransactions].RemoveFields(
      'RelatedShipContainerID,{LineCostInc},PurchaseLineID,GlobalRef,PurchaseOrderID,'+
      'CogsAccnt,ClassID,ProductGroup,ProductName,LineTaxRate,QtySold,Shipped,'+
      'BackOrder,Invoiced,RAQty,RAstatus,Batch,UseTimecost,SaleID_Timecost,'+
      'TimecostMarkupPer,TimecostPrice,TimecostMarkupDol,EditedFlag,Deleted,'+
      'RAInvoiceNo,AccountGroup,ProductID,PartType,IncomeAccnt,AssetAccnt,'+
      'CalcPriceInc,CalcTotalInc,CalcTotalEx,CalcTax,AvgCost,CustomerJobID,'+
      'COGSTotalLineAmount,COGSTotalLineAmountInc,Attrib1Purchase,'+
      'Attrib2Purchase,Attrib1PurchaseRate,LastLineID,ForeignExchangeRate,'+
      'ForeignExchangeCode,UnitofMeasureQtySold,'+
      'UnitofMeasureShipped,UnitofMeasureBackorder,UnitofMeasureMultiplier,'+
      'LandedCostsPerItem,RelatedPOIDUsed,UnitofMeasurePOLines,'+
      'SearchFilter,SearchFilterCopy,ReceivedDate,LandedCostsPercentage,'+
      'LandedCostsTotal,serialno,ForeignTotalLineAmount,NewForeignExchangeRate,'+
      'UnitOfMeasureID,SEQNo,ExpenseProductID,ExpenseProductName');


    inherited;
    ApplyCustomFieldsSettings;
    cboAccount.Visible := (cboAccountQry.RecordCount > 1);
    lblAccount.Visible := cboAccount.Visible;

    grdTransactions.ColumnByName('RelatedPOID').DisplayLabel := 'Related PO';
    grdTransactions.RemoveField('SeqNo');

    SetGridcolumns;
//    CustomerJobRepairObj.JobCustomerSetUp;
    CheckForAttachments;
    // Set comments memo as drop target for files dropped on the form
    DMTextTargetExpense.AcceptorControl := nil;
    DMTextTargetExpense.AcceptorControl := txtComments;

    cboBaseForeignCurrencyCodeOrDateChange(nil);

    SetControlFocus(cboClientR);
//    fAccountLookupSQL := cboAccountLinesQry.SQL.Text;
    if ClassNameIs('TBillGUI') or ClassNameIs('TCreditGUI') then
      FilterAccountsForExpenseClaim(ExpenseBase.ExpenseClaimEmployee <> 0);

//    fAccountSearchMode := 'F5';
     ApplyTransAccesslevel(AccessLevel>3 , (TransAccesslevel>3) or (AccessLevel>3));
  finally
    EnableForm;
  end;
  stepProgressbar;
  AddProductPriceMenu;
end;
function TBaseExpenseGUI.ShowNoCustomerWarning : boolean;
begin
  result := false;
  if Empty(cboClientR.Text) or cboClientR.SpecialItemSelected then
  begin
    result := true;
    CommonLib.MessageDlgXP_Vista('Supplier has not been selected !', mtWarning, [mbOk], 0);
    if cboClientR.Visible and cboClientR.Enabled then
      SetControlFocus(cboClientR);
    Exit;
  end;
end;

procedure   TBaseExpenseGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_AccountID) then begin
        cboAccountQry.Locate('AccountID', ExpenseBase.Glaccountid, [loCaseInsensitive]);
        cboAccount.LookupValue := ExpenseBase.GLAccountName;
    end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_Terms) then begin
        cboTerms.LookupValue := ExpenseBase.TermsName;
        cboTermsQry.Locate('Terms', ExpenseBase.TermsName, [loCaseInsensitive]);
    end else if (EventType = BusobjEvent_Change) and (Value = BusObjEventVal_FC) then begin
        cboBaseForeignCurrencyCodeOrDateChange(nil);
    end else if (EventType = BusobjEvent_Change) and (Value = BusObjEventVal_Class) then begin
        cboClassQry.Locate('ClassName', ExpenseBase.lines.LineClassName, [loCaseInsensitive]);
        cboClass.LookupValue := ExpenseBase.lines.LineClassName;
        cboClass.Text := ExpenseBase.lines.LineClassName;
    end else if (EventType = BusObjEvent_POCommentPopUp) then begin
      DelayMessageDlg(Value,mtInformation,[mbOK],0);
    end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_ClientID) then begin
      InitClientLookupCombonFields;
      Opendb(qryClientLookup);
      DoDelayObjectProcedure(DoOnClientchange,10 , Self.classname +'.DoOnClientchange');
    end  else if (Eventtype = BusobjEvent_ToDo ) and (Value =  BusobjEvent_CalculationsDisabled) then begin
        lblDisableCalc.visible := TransBase.Lines.count > appenv.CompanyPrefs.ExpenseLinesToDisableCalcs;
    end;
    inherited;
end;
procedure TBaseExpenseGUI.DoOnClientchange;
begin
  if (Empty(cboClientR.Text)) or (expensebase.SupplierID=0) then Exit;
  try

    if cboAccountQry.IsEmpty then begin
      CommonLib.MessageDlgXP_Vista('No Accounts Payable Account !', mtWarning, [mbOK], 0);
      Self.Close;
    end;
    expensebase.OrderTo := expensebase.Supplier.ShipToAddress;
    inherited;
    cboTermsCloseUp(cboTerms, cboTerms.lookupTable, cboTerms.DataSource.DataSet, true);

  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;

  if (AppEnv.CompanyPrefs.RememberLastTransactionBySupplier) and (KeyID = 0) and (ExpenseBase.supplierId <> 0 ) and (ExpenseBase.Lines.count =0) then begin
        LoadLastTransactionsForSupplier;
  end;

end;

procedure TBaseExpenseGUI.edtExpenseProductSelectedDblClick(Sender: TObject);
begin
  inherited;
  Setcontrolfocus(grdTransactions);
  grdTransactions.SetActiveField('ExpenseProductSelected');
  if showAreaPOLinesList then exit;
end;

procedure TBaseExpenseGUI.cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
    if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
    if not Modified then Exit;
    cboTermsQry.Locate('Terms', cboTerms.Text, [loCaseInsensitive]);
    SetTerms(LookupTable, FillTable);
end;

procedure TBaseExpenseGUI.cboCustomerJobNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  CommonLib.MessageDlgXP_Vista('Customer''s Name Not in List !', mtWarning, [mbOK], 0);
  TERPDBLookupcombo(Sender).LookupValue := '';
  SetControlFocus(TERPDBLookupcombo(Sender));
end;

function TBaseExpenseGUI.GetOrAddMobileNumber: string;
var
  aContact: TContact;
  aSupplier : TSupplier;
begin
  result := ExpenseBase.ContactMobile;
  if result = '' then
    result := ExpenseBase.Supplier.Mobile;
  if result = '' then begin
    if ExpenseBase.ContactID > 0 then begin
      { contact mobile }
      result := frmMobileNumberInput.GetMobileNumberFromUser('Contact (' + ExpenseBase.ContactName +
        ') does not have a mobile number.' +#13#10 + 'Please enter a number.');
      if result <> '' then begin
        aContact := TContact.Create(nil);
        try
          aContact.Connection := TMyDacDataConnection.Create(aContact);
          aContact.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
          aContact.Load(ExpenseBase.ContactID);
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
      result := GetMobileNumberFromUser('Supplier (' + ExpenseBase.SupplierName +
        ') does not have a mobile number.' + #13#10 + 'Please enter a number.');
      if result <> '' then begin
        aSupplier := TSupplier.Create(nil);
        try
          aSupplier.Connection := TMyDacDataConnection.Create(aSupplier);
          aSupplier.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
          aSupplier.Load(ExpenseBase.SupplierID);
          if aSupplier.Lock then begin  { only update if we can lock }
            try
              aSupplier.Mobile := result;
              aSupplier.PostDb;
              ExpenseBase.Supplier.RefreshDB;
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
      if ExpenseBase.ContactID > 0 then begin
        { contact mobile }
        result := GetMobileNumberFromUser('Contact (' + ExpenseBase.ContactName +
          ') number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.', result, MyConnection);
        if result <> '' then begin
          aContact := TContact.Create(nil);
          try
            aContact.Connection := TMyDacDataConnection.Create(aContact);
            aContact.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
            aContact.Load(ExpenseBase.ContactID);
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
        result := GetMobileNumberFromUser('Supplier (' + ExpenseBase.SupplierName +
          ') number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.', result, MyConnection);
        if result <> '' then begin
          aSupplier := TSupplier.Create(nil);
          try
            aSupplier.Connection := TMyDacDataConnection.Create(aSupplier);
            aSupplier.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
            aSupplier.Load(ExpenseBase.SupplierID);
            if aSupplier.Lock then begin  { only update if we can lock }
              try
                aSupplier.Mobile := result;
                aSupplier.PostDb;
                ExpenseBase.Supplier.RefreshDB;
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

function TBaseExpenseGUI.GetTaxAccountName: string;
begin
  Result := 'Tax Paid';
end;

procedure TBaseExpenseGUI.grdTransactionsEnter(Sender: TObject);
begin
  ShowNoCustomerWarning;
  inherited;
end;

procedure TBaseExpenseGUI.grdTransactionsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  (*if Button <> mbLeft then exit;
  if showAreaPOLinesList then exit;*)
end;

procedure TBaseExpenseGUI.cboAccountlineXNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
  var
  frm: TBaseInputGUI;
begin
  frm    := nil;
  Accept := false;
  if CommonLib.MessageDlgXP_Vista('Account not found in list. Would you like to create this Account?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    try
      tblDetails.Edit;
      if TfrmChartOfAccounts.FormActive then begin
        TfrmChartOfAccounts.CloseMe;
      end;

      frm := TfrmChartOfAccounts(GetComponentByClassName('TfrmChartOfAccounts'));
      if assigned(frm) then begin
        TfrmChartOfAccounts(frm).fsNewAccount := NewValue;
        frm.Position := poScreenCenter;
        frm.ShowModal;
      end;
    finally
      cboAccountLinesQry.Close;
      cboAccountLinesQry.Open;
      if not Empty(TfrmChartOfAccounts(frm).fsNewAccount) then begin
        if cboAccountLinesQry.Locate('AccountName', TfrmChartOfAccounts(frm).fsNewAccount, [loCaseInsensitive]) then begin
          cboAccountlineX.Text := TfrmChartOfAccounts(frm).fsNewAccount;
          cboAccountlineX.PerformSearch;
        end;
        Accept := true;
      end;
    end;
  end;
end;

procedure TBaseExpenseGUI.cboAccountlNoLineBeforeOpenList(Sender: TObject);
begin
  inherited;
  if not(Sender is TChartOfAccountsListLookupGUI) then Exit;
  if not(fbaccountofAllowExpenseClaim) then exit;

  TChartOfAccountsListLookupGUI(Sender).ExpenseClaimList := true;
end;

procedure TBaseExpenseGUI.grdTransactionsRowChanged(Sender: TObject);
begin
//  CustomerJobRepairObj.rowchanged;
  if cboAccountLinesQry.active then
    if not cboAccountLinesQry.Locate('AccountName', cboAccountlineX.Text, [loCaseInsensitive]) then begin
      Exit;
    end;

  inherited;

end;

procedure TBaseExpenseGUI.tblDetailsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lblDisableCalc.visible := TransBase.Lines.count > appenv.CompanyPrefs.ExpenseLinesToDisableCalcs;
end;

procedure TBaseExpenseGUI.tblDetailsCalcFields(DataSet: TDataSet);
begin
  inherited;
  if ExpenseBase.ID>0 then
    if (ExpenseBase.Lines.ExpenseProductName<>'') and (ExpenseBase.Lines.areacode<>'') then
      ExpenseBase.Lines.ExpenseProductSelected := ExpenseBase.Lines.areacode +' - ' +ExpenseBase.Lines.ExpenseProductName;
end;

procedure TBaseExpenseGUI.tblMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
  fxtotex := ExpenseBase.totalamount;
  fxtotinc:= ExpenseBase.totalamountinc;
  fxTax   := ExpenseBase.totalTax;
end;

procedure TBaseExpenseGUI.tblMasterCalcFields(DataSet: TDataSet);
var
  dt: TDateTime;
begin
  inherited;
  try
    if (tblMasterEnteredAt.AsString <> '') then begin
      dt := StrToTime(tblMasterEnteredAt.AsString);
      tblMasterEnteredAtShort.AsString := FormatDateTime(FormatSettings.ShortTimeFormat,dt);
    end
    else
      tblMasterEnteredAtShort.AsString := tblMasterEnteredAt.AsString;
  except
    tblMasterEnteredAtShort.AsString := tblMasterEnteredAt.AsString;
    exit;
  end;
end;

procedure TBaseExpenseGUI.tblMasterOrderDateChange(Sender: TField);
begin
  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
  inherited;
  cboTermsQry.Locate('Terms', cboTerms.Text, [loCaseInsensitive]);
  cboTermsCloseUp(nil, cboTermsQry, tblMaster, true);
end;

procedure TBaseExpenseGUI.FormActivate(Sender: TObject);
begin
  inherited;
  // This must remain!
  bIsInitialising := false;
end;

procedure TBaseExpenseGUI.grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
begin
//  if (Sysutils.SameText(AFieldName , CustomerJobRepairObj.Jobnamefield))   then begin
//    CustomerJobRepairObj.JobCustomerSetUp;
//  end else   inherited grdTransactionsTitleButtonClick(Sender, AFieldName);
  inherited;
end;


procedure TBaseExpenseGUI.btnCompletedClick(Sender: TObject);
begin
  TfmSupplier.CloseMe;//This Is To Stop Lock Timeout Errors
end;
Procedure TBaseExpenseGUI.CalcAll(Const Sender: TBusObj; Var Abort: Boolean);
begin
  if not(Sender is TExpenseLineBase) then exit;
  if (ExpenseBase.ForeignExchangeCode <> '') and (ExpenseBase.ForeignExchangeCode <> Appenv.RegionalOptions.ForeignExDefault) then begin
    TExpenseLineBase(Sender).LineCost:= TExpenseLineBase(Sender).foreignLinecost /ExpenseBase.foreignExchangerate;
    TExpenseLineBase(Sender).LineCostinc  := GetAmountinc(TExpenseLineBase(Sender).LineCost ,TExpenseLineBase(Sender).LineTaxRate);
    TExpenseLineBase(Sender).CalcLineTotals;
  end;
  TExpenseLineBase(Sender).TotalLineAmountinc := round(TExpenseLineBase(Sender).TotalLineAmountinc,CurrencyRoundPlaces);
  TExpenseLineBase(Sender).TotalLineAmount := round(TExpenseLineBase(Sender).TotalLineAmountInc / (1 + TExpenseLineBase(Sender).LineTaxRate),CurrencyRoundPlaces);
  TExpenseLineBase(Sender).LineTaxTotal    := TExpenseLineBase(Sender).TotalLineAmountInc - TExpenseLineBase(Sender).TotalLineAmount;
  TExpenseLineBase(Sender).CalcLineCostFromTotal;
  TExpenseLineBase(Sender).PostDB;
end;

procedure TBaseExpenseGUI.btnfixClick(Sender: TObject);
begin
  inherited;
    ExpenseBase.accessmanager.accesslevel := 1;
    ExpenseBase.Lines.IterateRecords(CalcAll);
    ExpenseBase.CalcOrdertotals;
      if not (ExpenseBase.Lines.Locate('AccountName;ClassID;Product_Description' , vararrayof([GLACCOUNT_ROUNDFIX,GetDeptID('Roundfix'),'Rounding Adjustment Fix']) , [])) then begin
        ExpenseBase.AllowNewRecordWhenLocked := True;
        ExpenseBase.lines.New;
        ExpenseBase.lines.Accountname := GLACCOUNT_ROUNDFIX;
        ExpenseBase.lines.ProductDescription := 'Rounding Adjustment Fix';
        ExpenseBase.Lines.LineClassName := 'Roundfix';
      end;
      ExpenseBase.Lines.DoFieldChange:= False;
      try
        ExpenseBase.Lines.LineCostinc :=  round(fxtotinc-ExpenseBase.totalamountinc,CurrencyRoundPlaces);
        ExpenseBase.Lines.TotalLineAmountinc :=  ExpenseBase.Lines.LineCostinc;
        ExpenseBase.Lines.LineTaxTotal :=  round(fxtax-ExpenseBase.TotalTax,5);
        ExpenseBase.Lines.TotalLineAmount := ExpenseBase.Lines.TotalLineAmountinc-ExpenseBase.Lines.LineTaxTotal;
        ExpenseBase.Lines.CalcLineCostFromTotal;
        ExpenseBase.Lines.TotalLineamount :=  ExpenseBase.Lines.LineCost;
        ExpenseBase.Lines.PostDB;
        ExpenseBase.CalcOrderTotals;
        //ExpenseBase.Lines.TotalLineamount :=  ExpenseBase.Lines.LineCost;
      finally
        ExpenseBase.Lines.DoFieldChange:= true;
      end;
    btnfix.visible := devmode;
end;

procedure TBaseExpenseGUI.cboCustomerJobExit(Sender: TObject);
begin
  inherited;
  if Empty(TERPDBLookupcombo(Sender).Text) then begin
    ExpenseBase.lines.CustomerJobID := 0;
  end;
end;

// ---------- File Attachment Stuff --------------------------------------------

function TBaseExpenseGUI.ShowAttachments(fbDragnDropping :Boolean): TfmAttachments;
begin
  result := nil;
  if ExpenseBase.Id < 1 then Exit; // need POID
  result := TfmAttachments(GetComponentByClassName('TfmAttachments', False, self));
  if Assigned(result) then begin
    result.DBConnection := Self.MyConnection;
    result.AttachObserver(Self);
    result.TableName := 'tblPurchaseOrders';
    result.TableId   := tblMasterPurchaseOrderID.AsInteger;
    result.DragnDropping :=fbDragnDropping;
    if fsModal in self.FormState then begin
//      result.ShowModal;
    end
    else begin
      result.FormStyle := fsMDIChild;
      result.BringToFront;
    end;
  end;
end;

procedure TBaseExpenseGUI.DMTextTargetExpenseDrop(Sender: TObject; Acceptor: TWinControl;
  const DropText: string; X, Y: integer);
Var
  Form : TfmAttachments;
begin
  inherited;
  if ExpenseBase.ID < 1 then Exit; // need sales id

  form := ShowAttachments(true);
//  Form := TfmAttachments(GetComponentByClassName('TfmAttachments', True));
  if Assigned(Form) then begin
    Form.DMTextTargetDrop(Sender, Acceptor, DropText, X, Y);
    if fsModal in self.FormState then
      form.ShowModal;
  end;
end;

procedure TBaseExpenseGUI.btnAttachmentsClick(Sender: TObject);
var
  form: TfmAttachments;
begin
  inherited;
//  ShowAttachments;
  form := ShowAttachments(False);
  if Assigned(Form) then begin
    if fsModal in self.FormState then
      form.ShowModal;
  end;
end;

procedure TBaseExpenseGUI.CheckForAttachments;
var
    qry :TERPQuery;
begin
    if ExpenseBase.ID <1 then begin
        btnAttachments.Enabled := false;
        Exit; // need sales id
    end;
    qry := DbSharedObj.GetQuery(expensebase.connection.connection);
    try
      With qry do begin
        closedb(qry);
        sql.text :='SELECT AttachmentName FROM tblAttachments WHERE TableName = "tblPurchaseOrders"' +
            ' AND TableId = ' + IntToStr(ExpenseBase.ID);
        opendb(qry);
        if RecordCount > 0 then btnAttachments.Color := $0077ff77
        else btnAttachments.Color := clBtnFace;
      end;
    finally
        DbSharedObj.ReleaseObj(qry);
    end;

end;

function TBaseExpenseGUI.ClientState    :String ;begin  result:= Expensebase.supplier.State   ;end;
function TBaseExpenseGUI.Clientcountry  :String ;begin  REsult:= Expensebase.supplier.country ;end;
function TBaseExpenseGUI.clientLocation :String ;begin  REsult:= Expensebase.supplier.suburb  ;end;
function TBaseExpenseGUI.ClientPostcode :String ;begin  REsult:= Expensebase.supplier.PostCode;end;


procedure TBaseExpenseGUI.UpdateMe;
//var
//  SavedAccessLevel: integer;
begin
  inherited;
//  SavedAccessLevel:= self.AccessLevel;
//  self.AccessLevel := 1;
  OverrideAccessLevel(nil);
  try
    // somthing has changed on attachments form so update
    CheckForAttachments;
    // Update header to flag that changes have taken place
    Expensebase.LastUpdated := Now;

    self.ExpenseBase.PostDb;
  finally
//    self.AccessLevel := SavedAccessLevel;
    RestoreOverridenAccessLevel(nil);
  end;
end;

procedure TBaseExpenseGUI.UpdateMe(const Cancelled: boolean; const aObject: TObject = nil);
begin
    inherited UpdateMe(cancelled, aObject);
end;

// -----------------------------------------------------------------------------

procedure TBaseExpenseGUI.cboBaseForeignCurrencyCodeOrDateChange(Sender: TObject);
var
  iPos: integer;
begin
  inherited;
  { this code was taking focus away from GUI control as soon as user started to type new date, so exit here }
  if (Sender = cboCreationDate) then exit;

  {the busobj does the FC calculation for cheque as well. but the GUI is hiding the FC components
  in cheque form at the momnet , if required make the component visible.}
  If Self.ClassName = 'TfmCheque' then Exit;
  EnableFXControls(AppEnv.CompanyPrefs.UseForeignCurrencyonPO);

  if (cboBaseForeignCurrencyCode.Text = AppEnv.RegionalOptions.ForeignExDefault) or (NOT cboBaseForeignCurrencyCode.visible) then begin
    edtBaseExchangeRate.Enabled := false;
    grdTransactions.RemoveField('ForeignCurrencyLineCost');
    lblBaseForeignTotal.Visible := false;
    edtBaseForeignTotal.Visible := false;
  end else begin
    edtBaseExchangeRate.Enabled := true;
    iPos := GetGridColumnIndex(grdTransactions, 'Product_Description');
    if iPos < 0 then iPos := 5;
    grdTransactions.AddField('ForeignCurrencyLineCost', iPos);
    grdTransactions.ColumnByName('ForeignCurrencyLineCost').DisplayWidth := 10;
    lblBaseForeignTotal.Visible := true;
    edtBaseForeignTotal.Visible := true;
  end;

  grdTransactions.ColumnByName('ForeignCurrencyLineCost').DisplayLabel := 'Amount ' + cboBaseForeignCurrencyCode.Text;
end;

procedure TBaseExpenseGUI.EnableFXControls(Enabled: boolean);
begin
  lblBaseForeignCurrencyCode.Enabled := Enabled;
  cboBaseForeignCurrencyCode.Enabled := Enabled;

  lblBaseExchangeRate.Enabled := Enabled;
  edtBaseExchangeRate.Enabled := Enabled;
end;


procedure TBaseExpenseGUI.cboBaseForeignCurrencyCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
  Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  cboBaseForeignCurrencyCodeOrDateChange(nil);
end;

procedure TBaseExpenseGUI.cboEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TBaseExpenseGUI.cboAccountlineXBeforeOpenList(Sender: TObject);
begin
  inherited;
  if not(Sender is TChartOfAccountsListLookupGUI) then Exit;
  if not(fbaccountofAllowExpenseClaim) then exit;
  TChartOfAccountsListLookupGUI(Sender).ExpenseClaimList := true;
end;

procedure TBaseExpenseGUI.cboAccountlineXExit(Sender: TObject);
begin
  inherited;
  if cboAccountlineX.Text = '' then begin
    SetControlFocus(cboAccountlineX);
  end;
end;

procedure TBaseExpenseGUI.grdTransactionsCalcTitleAttributes(
  Sender: TObject; AFieldName: String; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin
  if grdTransactions.DataSource.DataSet.RecordCount = 0 then
    exit;
  inherited grdTransactionsCalcTitleAttributes(Sender, AFieldName, AFont, ABrush, ATitleAlignment);
//  if (Sysutils.SameText(AFieldName ,CustomerJobRepairObj.Jobnamefield))  then begin
  if (Sysutils.SameText(AFieldName ,'CustomerJob'))  then begin
    ABrush.Color := Color_Navy;
  end;
end;


procedure TBaseExpenseGUI.grdTransactionsDblClick(Sender: TObject);
begin
  inherited;
  if showAreaPOLinesList then exit;
end;

procedure TBaseExpenseGUI.cboRelatedPOIDCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
end;

procedure TBaseExpenseGUI.FilterAccountsForExpenseClaim(const Value: Boolean);
const
  cExpenseWhere = ' and (AllowExpenseClaim = "T")';
  cPlaceholder = '# placeholder for FilterAccountsForExpenseClaim';
var
  i: Integer;
begin
  if Value then begin
    i := cboAccountLinesQry.SQL.IndexOf(cPlaceholder);
    if i >= 0 then begin
      cboAccountLinesQry.Close;
      cboAccountLinesQry.SQL[i] := cExpenseWhere;
      cboAccountLinesQry.Open;
    end;
    fbaccountofAllowExpenseClaim:= True;
  end else begin
    i := cboAccountLinesQry.SQL.IndexOf(cExpenseWhere);
    if i >= 0 then begin
      cboAccountLinesQry.Close;
      cboAccountLinesQry.SQL[i] := cPlaceholder;
      cboAccountLinesQry.Open;
    end;
    fbaccountofAllowExpenseClaim:= False;
  end;
end;

function TBaseExpenseGUI.IsNew:Boolean;
var
    CleanNode: IXMLNode;
begin
    CleanNode:= ExpenseBase.CleanXMLNode;
    result := not (assigned(CleanNode));
end;

procedure TBaseExpenseGUI.LoadLastTransactionsForSupplier;
var
  qry: TERPQuery;
  CopyObj: TExpenseBase;
  LastID: integer;
begin
//  LastID:= 0;
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select PurchaseOrderID from tblPurchaseOrders');
    if ExpenseBase.IsBill then
      qry.SQL.Add('where IsBill = "T"')
    else if ExpenseBase.IsCredit then
      qry.SQL.Add('where IsCredit = "T"')
    else if ExpenseBase.IsCheque then
      qry.SQL.Add('where IsCheque = "T"')
    else
      exit;
    qry.SQL.Add('and ClientID = ' + IntToStr(ExpenseBase.ClientId));
    qry.SQL.Add('and PurchaseOrderID < ' + IntToStr(ExpenseBase.ID));
    qry.SQL.Add('and Deleted = "F"');
    qry.SQL.Add('order by PurchaseOrderID desc');
    qry.SQL.Add('limit 1');
    qry.Open;
    LastID:= qry.FieldByName('PurchaseOrderID').AsInteger;
  finally
    qry.Free;
  end;
  if LastID = 0 then
    exit;
  if ExpenseBase.IsBill then
    CopyObj:= TBill.CreateWithNewConn(nil)
  else if ExpenseBase.IsCredit then
    CopyObj:= TCredit.CreateWithNewConn(nil)
  else if ExpenseBase.IsCheque then
    CopyObj:= TCheque.CreateWithNewConn(nil)
  else
    exit;
  try
    CopyObj.Load(LastID);
    CopyObj.Lines.First;
    while not CopyObj.Lines.EOF do begin
      ExpenseBase.Lines.New;
      ExpenseBase.Lines.AccountName:= CopyObj.Lines.AccountName;
      ExpenseBase.Lines.LineTaxCode:= CopyObj.Lines.LineTaxCode;
      ExpenseBase.Lines.LineCost:= CopyObj.Lines.LineCost;
      ExpenseBase.Lines.ProductDescription:= CopyObj.Lines.ProductDescription;
      ExpenseBase.Lines.PostDb;
      CopyObj.Lines.Next;
    end;
  finally
    CopyObj.Free;
  end;
  ExpenseBase.Lines.First;
end;

procedure TBaseExpenseGUI.NewTransBusObjinstance;
begin
  TransBase := expensebase;
  inherited;
end;


procedure TBaseExpenseGUI.cboExpenseClaimEmployeeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  FilterAccountsForExpenseClaim(ExpenseBase.ExpenseClaimEmployee <> 0);
end;

procedure TBaseExpenseGUI.cboExpenseClaimEmployeeExit(Sender: TObject);
begin
  if (cboExpenseClaimEmployee.Text = '') then begin
    ExpenseBase.ExpenseClaimEmployee := 0;
    ExpenseBase.PostDB;
    FilterAccountsForExpenseClaim(ExpenseBase.ExpenseClaimEmployee <> 0);
  end;
end;

procedure TBaseExpenseGUI.cboLinesAreaCodeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not(modified) then exit;
  ExpenseBase.Lines.ExpenseProductName := '';
  ExpenseBase.Lines.ExpenseProductID:= 0;
  ExpenseBase.Lines.PostDB;
end;

Function TBaseExpenseGUI.showAreaPOLinesList:boolean;
var
  fsFieldname:String;
begin
  result := False;
  fsFieldname := grdTransactions.GetActiveField.Fieldname;
  if not Sysutils.SameText(fsFieldname , 'ExpenseProductSelected') then exit;


  Expensebase.Lines.PostDB;
  if Expensebase.Lines.AccountName = '' then exit;
  OpenERPListFormultiselectModal('TAreaPOLinesListGUI' , nil , AddPOLAreas);
  Result := true;
end;
procedure TBaseExpenseGUI.AddPOLAreas(Sender :TwwDBGrid);
var
  ctr:Integer;
  POLAreasList :TAreaPOLinesListGUI;
  AccountName:String;
  fbflag:Boolean;
  bm:TBookmark;
begin
  if Sender.SelectedList.Count =0 then exit;
  if not(Assigned(Sender.Owner)) then exit;
  if not(Sender.Owner is TAreaPOLinesListGUI) then exit;
  POLAreasList :=  TAreaPOLinesListGUI(Sender.Owner);


(*  if (Sender.SelectedList.Count =1) and (POLAreasList.details =1) then begin
    if POLAreasList.Areacode = '' then exit;
    POLAreasList.SelectAllDetailforArea(POLAreasList.Areacode);
  end;*)

  if Sender.SelectedList.Count =0 then exit;
  Accountname := Expensebase.Lines.AccountName ;
  if Accountname = '' then exit;

  DoShowProgressbar(Sender.SelectedList.Count, WAITMSG);
  try
    fbflag:=False;
    bm := tbldetails.GetBookmark;
    try
      for ctr := 0 to Sender.SelectedList.Count -1 do begin
        POLAreasList.qryMain.GoToBookmark(Sender.SelectedList.Items[ctr]);
        DoStepProgressbar(POLAreasList.ProductName);
        if (POLAreasList.ProductName <> '') and (POLAreasList.Areacode<>'') then begin
          if fbflag then begin
            Expensebase.Lines.New;
            Expensebase.Lines.accountName :=Accountname;
          end;
          fbflag:=True;
          Expensebase.Lines.AreaCode    := POLAreasList.Areacode;
          Expensebase.Lines.ExpenseProductName := POLAreasList.ProductName;
          Expensebase.Lines.PostDB;
        end;
      end;
    finally
      tbldetails.GotoBookmark(bm);
      tbldetails.FreeBookmark(bm);
    end;
  finally
    DoHideProgressbar;
  end;
end;
procedure TBaseExpenseGUI.AddProductPriceMenu;
begin
  NewMenuForTransGrid('Line Custom Fields' , CustomFields1Click , FAlse);
end;
procedure TBaseExpenseGUI.CustomFields1Click(Sender:TObject);
begin
  if OpenERPFormModal('TfmCustomfieldList', 0, beforeshowCustomfieldList)>=0  then begin
    CustomfieldonGrid.ApplyCustomFieldsSettings;
  end;
end;
procedure TBaseExpenseGUI.beforeshowCustomfieldList(Sender: TObject);
begin
  if not(Sender is TfmCustomfieldList) then Exit;
  TfmCustomfieldList(Sender).ListType := ltExpenseLines;
end;

procedure TBaseExpenseGUI.actPreviewExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBaseExpenseGUI.actPrintExecute(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TBaseExpenseGUI.AssignAreacolumnName;
begin
  inherited;
end;

procedure TBaseExpenseGUI.cboEquipmentNameBeforeDropDown(Sender: TObject);
begin
  inherited;
  qryRepairEquip.ParamByName('RepairID').AsInteger:= tblDetailsRepairID.AsInteger;
  qryRepairEquip.Refresh;
end;

procedure TBaseExpenseGUI.cboEquipmentNameCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  EditDb(tblDetails);
  tblDetailsEquipmentName.AsString:= LookupTable.FieldByName('EquipmentName').AsString;
  tblDetailsCustomerEquipmentID.AsInteger:= LookupTable.FieldByName('CustomerEquipmentID').AsInteger;
  tblDetailsRepairID.AsInteger:= LookupTable.FieldByName('RepairID').AsInteger;
  cboEquipmentName.Text:= LookupTable.FieldByName('EquipmentName').AsString;

//  CustomerJobRepairObj.RepairCloseUp(sender, LookupTable, FillTable, Modified );
end;

//procedure TBaseExpenseGUI.InitCustJobRepairSelection;
//begin
//  CustomerJobRepairObj:= TCustomerJobRepairObj.create;
//  CustomerJobRepairObj.grid                :=  grdTransactions;
//  CustomerJobRepairObj.Jobcombo            :=  cboCustJob  ;
//  CustomerJobRepairObj.JobIDField          :=  'CustomerJobID';
//  CustomerJobRepairObj.JobnameField        :=  'CustomerJob';
//  CustomerJobRepairObj.ClassNameField      :=  'class';
//  CustomerJobRepairObj.ClassIdField        :=  'Classid';
//  CustomerJobRepairObj.curSelection        :=  tnone;
//  CustomerJobRepairObj.RepairCombo         :=  cboEquipmentname;
//  CustomerJobRepairObj.RepairIdField       :=  'RepairID';
//  CustomerJobRepairObj.CustomerEquipIDField:=  'customerEquipmentId';
//  CustomerJobRepairObj.EquipmentNameField  :=  'EquipmentName';
//  CustomerJobRepairObj.REpairID        :=0;
//  CustomerJobRepairObj.ClientID        :=0;
//end;

function TBaseExpenseGUI.getcontactType: TContactType;
begin
  Result := tSuppliercontact;
end;

(*procedure TBaseExpenseGUI.UpdateFromContact(const value: TDataset);
var
  strTemp:String;
begin
  inherited;
  if AccessLevel > 3 then
    exit;
  if not Value.FieldByName('contacttitle').IsNull then strTemp := Value.FieldByName('contacttitle').AsString;

  if not Value.FieldByName('contactfirstname').IsNull then if strTemp = '' then
      strTemp := Value.FieldByName('contactfirstname').AsString
  else strTemp := strTemp + ' ' + Value.FieldByName('contactfirstname').AsString;

  if not Value.FieldByName('contactsurname').IsNull then if strTemp = '' then
      strTemp := Value.FieldByName('contactsurname').AsString
  else strTemp := strTemp + ' ' + Value.FieldByName('contactsurname').AsString;

  expensebase.OrderTo  :=
    expensebase.ClientName + #13#10 +
    strTemp + #13 + #10 +      //Contact Name
    Value.FieldByName('ContactAddress').AsString + #13 + #10 + Value.FieldByName('ContactAddress2').AsString +
    #13 + #10 + Value.FieldByName('ContactAddress3').AsString +
    #13 + #10 + Value.FieldByName('ContactCity').AsString + ' ' + Value.FieldByName('ContactState').AsString +
    ' ' + Value.FieldByName('ContactPcode').AsString;
  expensebase.contactId :=Value.FieldByName('ContactID').AsInteger;
  expensebase.PostDB;
  EmailcontactId:= Value.FieldByName('ContactID').AsInteger;
end;*)

procedure TBaseExpenseGUI.SetGridColumns;
begin
    GuiPrefs.DbGridElement[grdTransactions].HideField('TotalLineAmount');
    GuiPrefs.DbGridElement[grdTransactions].HideField('TotalLineAmountInc');
    (*GuiPrefs.DbGridElement[grdTransactions].HideField('RepairId');*)
    GuiPrefs.DbGridElement[grdTransactions].HideField('CustomerEquipmentID');
    if not AppEnv.CompanyPrefs.ShowAccountNumbers then grdTransactions.RemoveField('AccountNumber');
end;

procedure TBaseExpenseGUI.FormDestroy(Sender: TObject);
begin
//  Freeandnil(CustomerJobRepairObj);
  Freeandnil(CustomFieldonGrid);
  inherited;

end;
procedure TBaseExpenseGUI.ApplyCustomFieldsSettings;
begin
  CustomFieldonGrid := TCustomFieldonGrid.Create(Self , 'CustomField1,CustomField2,CustomField3,CustomField4,CustomField5,CustomField6,CustomField7,CustomField8,CustomField9,CustomField10' , ltExpenseLines , grdtransactions, guiprefs, ExpenseBase);
  CustomFieldonGrid.ApplyCustomFieldsSettings;
end;

procedure TBaseExpenseGUI.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift ) and (Key in [ord('R') , ord('O') , ord('U') , ord('N') , ord('D'), ord('F'), ord('I'), ord('X')]) then
  begin
      KeysPressed :=KeysPressed +chr(key);
    if Sysutils.SameText(KeysPressed , 'ROUNDFIX') then
    begin
      ExecuteSQL('INSERT IGNORE INTO `tblclass` (`ClassName`, `SiteCode`) VALUES ("Roundfix", "RND");');
      btnfix.visible := True;
    end;
  end
  else
    KeysPressed := '';

end;

procedure TBaseExpenseGUI.cboEquipmentNameNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
//don;t delete, to skip the not inlist event from baseinput
end;

procedure TBaseExpenseGUI.cboEquipmentNameDblClick(Sender: TObject);
begin
  inherited;
//don;t delete, to skip the ondblclick event from baseinput
end;


function TBaseExpenseGUI.FieldsToExecludeFromsorting: String;
begin
  result:=
//    'grdTransactions:'+CustomerJobRepairObj.Jobnamefield+';'+
    'grdTransactions:CustomerJob;'+
    inherited FieldsToExecludeFromsorting;
end;
procedure TBaseExpenseGUI.InitERPLookupCombonFields;
begin
  inherited;
  NamenPrintNameGridObj.SetupClientNamenPrintNameinGrid(0,cboCustJob ,cboCustPrintJob ,'CustomerJob'  , 'CustomerPrintJob'   , grdTransactions,False, True  , False, true , true );
end;

end.



