unit frmRunDespatch;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/06/05 1.00.01  DSP  Added functionality to allow use of the new payment
                        method 'NAB CardFast'.
 19/08/05 1.00.02  BJ   Spelling mistake corrected - Dispatch was spelled Despatch .
 11/09/06 1.00.03  DSP  Implemented GuiPrefs.

}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB, ProgressDialog,
  wwdbdatetimepicker, StdCtrls, wwdblook, Buttons, DNMSpeedButton, Wwdbigrd, Grids,
  Wwdbgrid, ExtCtrls, DNMPanel, ActnList, ActnMan, wwcheckbox, MemDS,
  DBAccess, MyAccess, kbmMemTable,  Mask, wwdbedit, TranConvertObj,
  DeliveryObj, Menus, AdvMenus, Math, Wwdotdot, Wwdbcomb,
  TransactionsTable, MyClasses, DatasetSaver, DataState,
  CardFastLib, Shader, dmGUIStylers;

const
  WM_RESEQUENCE = WM_USER + 100;

type
  TfrmRunDespatchGUI = class(TBaseInputGUI)
    qryRuns: TMyQuery;
    dsRuns: TDataSource;
    qryRunLines: TMyQuery;
    dsRunLines: TDataSource;
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    cmdOK: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    grdRunlines: TwwDBGrid;
    btnDelete: TwwIButton;
    ActionManager1: TActionManager;
    actSave: TAction;
    qryRunLinesID: TAutoIncField;
    qryRunLinesRunID: TIntegerField;
    qryRunLinesClientID: TIntegerField;
    qryRunLinesSequence: TIntegerField;
    qryRunLinesClientName: TStringField;
    qryRunLinesAddress: TStringField;
    qryRunLinesPhone: TStringField;
    qryRunLinesMobile: TStringField;
    qryRunLinesOrderQty: TFloatField;
    qryRunLinesOrderValue: TFloatField;
    qryRunLinesTakenQty: TFloatField;
    qryRunLinesTakenValue: TFloatField;
    qryRunLinesReturnQty: TFloatField;
    qryRunLinesProductID: TIntegerField;
    qryRunLinesProductName: TStringField;
    qryRunLinesTaxCode: TStringField;
    qryRunLinesTaxAmount: TFloatField;
    qryRunLinesPaymentMethodID: TIntegerField;
    qryRunLinesPaymentMethodName: TStringField;
    qryRunsRunID: TAutoIncField;
    qryRunsRunName: TStringField;
    qryRunsActive: TStringField;
    qryRunsOperator: TStringField;
    qryRunsOperatorID: TIntegerField;
    qryRunsRunDate: TDateField;
    qryRunsDone: TStringField;
    qryRunsDespatchID: TAutoIncField;
    qryRunsGlobalRef: TStringField;
    qryRunsClassName: TStringField;
    qryRunsClassID: TIntegerField;
    qryRunLinesDespatchID: TIntegerField;
    qryRunLinesGlobalRef: TStringField;
    qryRunLinesPreferedSupp: TStringField;
    qryRunLinesUnitExPrice: TFloatField;
    qryRunsIsPublicHoliday: TStringField;
    btnStandingOrders: TDNMSpeedButton;
    btnInvoice: TDNMSpeedButton;
    lblReschedule: TLabel;
    btnProductionList: TDNMSpeedButton;
    qryRunsInvoicesGenerated: TStringField;
    qryRunLinesSalesID: TIntegerField;
    btnCancelRun: TDNMSpeedButton;
    qryRunLinesCompany: TStringField;
    btnEdit: TDNMSpeedButton;
    btnDeliveryDocket: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    chkPreviewInvoices: TCheckBox;
    Label10: TLabel;
    qryRunLinesPayments: TFloatField;
    qryRunLinesDeposits: TFloatField;
    memDespatchLines: TkbmMemTable;
    memDespatchLinesClientName: TStringField;
    memDespatchLinesCompany: TStringField;
    memDespatchLinesProductName: TStringField;
    memDespatchLinesOrderQty: TFloatField;
    memDespatchLinesOrderValue: TFloatField;
    memDespatchLinesTakenQty: TFloatField;
    memDespatchLinesTakenValue: TFloatField;
    memDespatchLinesReturnQty: TFloatField;
    memDespatchLinesPaymentMethodName: TStringField;
    memDespatchLinesPayments: TFloatField;
    memDespatchLinesDeposits: TFloatField;
    memDespatchLinesTaxCode: TStringField;
    memDespatchLinesTaxAmount: TFloatField;
    memDespatchLinesID: TAutoIncField;
    memDespatchLinesDespatchID: TIntegerField;
    memDespatchLinesGlobalRef: TStringField;
    memDespatchLinesPreferedSupp: TStringField;
    memDespatchLinesSequence: TIntegerField;
    memDespatchLinesAddress: TStringField;
    memDespatchLinesPhone: TStringField;
    memDespatchLinesMobile: TStringField;
    memDespatchLinesRunID: TIntegerField;
    memDespatchLinesClientID: TIntegerField;
    memDespatchLinesProductID: TIntegerField;
    memDespatchLinesPaymentMethodID: TIntegerField;
    memDespatchLinesUnitExPrice: TFloatField;
    memDespatchLinesSalesID: TIntegerField;
    dsDespatchLines: TDataSource;
    qryPayment: TMyQuery;
    cboPayMethod: TwwDBLookupCombo;
    tmrTrigger: TTimer;
    memCopy: TkbmMemTable;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    StringField4: TStringField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    StringField5: TStringField;
    FloatField8: TFloatField;
    AutoIncField1: TAutoIncField;
    IntegerField1: TIntegerField;
    StringField6: TStringField;
    StringField7: TStringField;
    IntegerField2: TIntegerField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    FloatField9: TFloatField;
    IntegerField7: TIntegerField;
    memDespatchLinesHistoryQty1: TFloatField;
    memDespatchLinesHistoryQty2: TFloatField;
    memDespatchLinesHistoryQty3: TFloatField;
    qryRunLinesHistoryQty1: TFloatField;
    qryRunLinesHistoryQty2: TFloatField;
    qryRunLinesHistoryQty3: TFloatField;
    memCopyHistoryQty1: TFloatField;
    memCopyHistoryQty2: TFloatField;
    memCopyHistoryQty3: TFloatField;
    qryHistory: TMyQuery;
    btnRunSummary: TDNMSpeedButton;
    PopupMenu1: TAdvPopupMenu;
    CustomiseFields1: TMenuItem;
    DNMPanel3: TDNMPanel;
    Label3: TLabel;
    cboRunName: TwwDBLookupCombo;
    Label5: TLabel;
    dtRunDate: TwwDBDateTimePicker;
    Label8: TLabel;
    edtClass: TwwDBEdit;
    Label6: TLabel;
    qryRunLinesFreqInterval: TIntegerField;
    qryRunLinesFreqType: TStringField;
    qryRunLinesStartDate: TDateField;
    memDespatchLinesFreqInterval: TIntegerField;
    memDespatchLinesFreqType: TStringField;
    memDespatchLinesStartDate: TDateField;
    memCopyFreqInterval: TIntegerField;
    memCopyFreqType: TStringField;
    memCopyStartDate: TDateField;
    qryRunsRescheduled: TStringField;
    qryRunsRescheduleDate: TDateField;
    btnReschedule: TDNMSpeedButton;
    N1: TMenuItem;
    Save1: TMenuItem;
    Invoice1: TMenuItem;
    EditRun1: TMenuItem;
    N2: TMenuItem;
    DeliveryDockets1: TMenuItem;
    StandingOrders1: TMenuItem;
    RunSummary1: TMenuItem;
    CancelRun1: TMenuItem;
    ProductionList1: TMenuItem;
    Label1: TLabel;
    qryRunLinesLastDelivery: TDateField;
    memDespatchLinesLastDelivery: TDateField;
    memCopyLastDelivery: TDateField;
    qryRunLinesTrack: TStringField;
    memDespatchLinesTrack: TStringField;
    qryRunLinesOriginalExPrice: TFloatField;
    qryRunLinesDiscount: TFloatField;
    memDespatchLinesOriginalExPrice: TFloatField;
    memDespatchLinesDiscount: TFloatField;
    memCopyDiscount: TFloatField;
    memCopyOriginalExPrice: TFloatField;
    Label7: TLabel;
    wwDBEdit1: TwwDBEdit;
    btnDriverReports: TDNMSpeedButton;
    DriverReports1: TMenuItem;
    qryRunLinesReference: TStringField;
    memDespatchLinesReference: TStringField;
    memCopyReference: TStringField;
    cboCustomer: TwwDBLookupCombo;
    cboParts: TwwDBLookupCombo;
    qryPersonalPreferences: TMyQuery;
    qryParts: TMyQuery;
    qryPartsPARTNAME: TStringField;
    qryPartsPartsID: TIntegerField;
    qryPartsPrice1: TFloatField;
    qryPartsTAXCODE: TStringField;
    qryPartsPREFEREDSUPP: TStringField;
    qryCustomer: TMyQuery;
    chkShowCompany: TwwCheckBox;
    Label9: TLabel;
    dsPersonalPreferences: TDataSource;
    btnReorder: TDNMSpeedButton;
    btnRenumber: TDNMSpeedButton;
    btnResequence: TDNMSpeedButton;
    memCopyTrack: TStringField;
    Label11: TLabel;
    chkSingleLines: TCheckBox;
    qryRunLinesIsContact: TStringField;
    qryRunLinesContactID: TIntegerField;
    memDespatchLinesIsContact: TStringField;
    memDespatchLinesContactID: TIntegerField;
    memCopyIsContact: TStringField;
    memCopyContactID: TIntegerField;
    qryRunLinesDeliveryDocket: TStringField;
    memDespatchLinesDeliveryDocket: TStringField;
    memCopyDeliveryDocket: TStringField;
    qryRunLinesPrepaymentID: TIntegerField;
    memDespatchLinesPrepaymentID: TIntegerField;
    memCopyPrepaymentID: TIntegerField;
    Label12: TLabel;
    chkPrintInvoices: TCheckBox;
    Label13: TLabel;
    txtSearch: TEdit;
    btnExport: TDNMSpeedButton;
    btnSetPayments: TDNMSpeedButton;
    SetPayments1: TMenuItem;
    Export1: TMenuItem;
    SaveDialog1: TSaveDialog;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure cboRunNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure actSaveUpdate(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure grdRunlinesCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure btnStandingOrdersClick(Sender: TObject);
    procedure btnProductionListClick(Sender: TObject);
    procedure btnInvoiceClick(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure btnCancelRunClick(Sender: TObject);
    procedure tmrTriggerTimer(Sender: TObject);
    procedure cboPayMethodCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure memDespatchLinesPaymentMethodIDChange(Sender: TField);
    procedure grdRunlinesEnter(Sender: TObject);
    procedure memDespatchLinesTakenQtyChange(Sender: TField);
    procedure cboPayMethodChange(Sender: TObject);
    procedure grdRunlinesRowChanged(Sender: TObject);
//    procedure CustomiseFields1Click(Sender: TObject);
    procedure btnRunSummaryClick(Sender: TObject);
    procedure memDespatchLinesAfterPost(DataSet: TDataSet);
    procedure memDespatchLinesPaymentsChange(Sender: TField);
    procedure memDespatchLinesDepositsChange(Sender: TField);
    procedure memDespatchLinesReturnQtyChange(Sender: TField);
    procedure Save1Click(Sender: TObject);
    procedure btnRescheduleClick(Sender: TObject);
    procedure btnDeliveryDocketClick(Sender: TObject);
    procedure btnDriverReportsClick(Sender: TObject);
    procedure cboCustomerCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboPartsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure grdRunlinesTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure grdRunlinesCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont;
      ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure chkShowCompanyClick(Sender: TObject);
    procedure memDespatchLinesSequenceChange(Sender: TField);
    procedure btnReorderClick(Sender: TObject);
    procedure btnRenumberClick(Sender: TObject);
    procedure btnResequenceClick(Sender: TObject);
    procedure memDespatchLinesReferenceChange(Sender: TField);
    procedure txtSearchChange(Sender: TObject);
    procedure btnSetPaymentsClick(Sender: TObject);
    procedure SetPayments1Click(Sender: TObject);
    procedure memDespatchLinesOrderQtyChange(Sender: TField);
    procedure btnExportClick(Sender: TObject);
    procedure cboCustomerNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure cboPayMethodOnEnter(Sender: TObject);

  private
    { Private declarations }
    HIGHLIGHTLOCATE: TColor;
    oMyDelivery: TDeliveryObj;
//    oGridObj: TCustomizeListObj;
    oDataSaver: TDatasetFileSaver;

    slColumnLockList: TStringList;
    bShowingContact: boolean;
    bDataChanged: boolean;
    RescheduleDate: TDateReturn;
    bUpdatingTakenValue: boolean;
    fbInitialisingRun: boolean;
    fbRequestRelocate: boolean;
    fbAutoCreateMode: boolean;
    iCurrentRecID: integer;
    iCurrentSequenceNumber: integer;
    iCurrentPayMethodID: integer;
    dTotalReturns: double;
    dTotalSalesInc: double;
    dTotalSalesEx: double;
    dTotalTax: double;
    dTotalQty: double;
    dTotalDeposits: double;
    dTotalPayments: double;
    fPreviousPayMethod: string;
    fCardFast: TCardFast;

    procedure PopulateDDTemporaryTable(const iClientID, iContactID: integer);
    procedure PerformResequence(var Msg: TMessage); message WM_RESEQUENCE;
    procedure RefreshClientList;

    procedure SetupRun(const iDespatchID: integer);
    procedure UpdatePaymethod(const iNewPayMethodID, iClientID, iContactID: integer);
    procedure UpdateReference(const sNewReference: string; const iClientID, iContactID: integer);
    procedure UpdateClientSequence(const iOldSequence, iNewSequence: integer);
    function IsRunOk: boolean;
    procedure SaveDespatchRun;
    procedure CalcTotals;
    procedure BlockFields;
//    procedure After_GetPreviousSettings;

  public
    { Public declarations }
    oTranConvert: TTranConvertObj;
    oTransactions: TTransactionTableObj;

    

    property CurrentRecordNumber: integer read iCurrentRecID write iCurrentRecID;
    property CurrentSequenceNumber: integer read iCurrentSequenceNumber write iCurrentSequenceNumber;
    property CurrentPayMethodID: integer read iCurrentPayMethodID write iCurrentPayMethodID;
    property TotalReturns: double read dTotalReturns write dTotalReturns;
    property TotalSalesInc: double read dTotalSalesInc write dTotalSalesInc;
    property TotalSalesEx: double read dTotalSalesEx write dTotalSalesEx;
    property TotalTax: double read dTotalTax write dTotalTax;
    property TotalDeposits: double read dTotalDeposits write dTotalDeposits;
    property TotalPayments: double read dTotalPayments write dTotalPayments;
    property TotalQty: double read dTotalQty write dTotalQty;
    property AutoCreateMode: boolean read fbAutoCreateMode write fbAutoCreateMode stored false;
    property CardFast: TCardFast read FCardFast;
  end;

//var
//  frmRunDespatchGUI: TfrmRunDespatchGUI;

implementation

{$R *.dfm}

uses
  DNMExceptions, DNMLib, CommonDbLib, FormFactory, DespatchList, frmRun, 
  frmRunReschedulerGUI,  
   frmCustomerFrm, CommonLib, ClientDiscountObj, AppEnvironment,
  FastFuncs;

const
  HIGHLIGHTLOCATEDEF = $00DFFFFE;  // a very light yellow rw

procedure TfrmRunDespatchGUI.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := True;
  CheckRunLinesForExistingFields;

  inherited;

  //  fbTabSettingEnabled := False;

  UserLock.Enabled := true;

  fCardFast := TCardFast.Create(nil);

  if AppEnv.Employee.ListSelectionColour = 0 then begin
    HIGHLIGHTLOCATE := HIGHLIGHTLOCATEDEF;
  end else begin
    HIGHLIGHTLOCATE := AppEnv.Employee.ListSelectionColour;
  end;

  AutoCreateMode := false;
  qryPayment.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryHistory.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryPersonalPreferences.Connection := CommonDbLib.GetSharedMyDacConnection;

  bUpdatingTakenValue := true;
  fbInitialisingRun := false;
  fbRequestRelocate := false;
  bShowingContact := false;
  bDataChanged := false;
  oTranConvert := TTranConvertObj.Create;

  // Create our delivery object.
  oMyDelivery := TDeliveryObj.Create;

  // Create our datasaver object
  oDataSaver := TDatasetFileSaver.Create;

  // Create our Grid Object
//  oGridObj := TCustomizeListObj.Create;

  // Create our grid lock list.
  slColumnLockList := TStringList.Create;
  slColumnLockList.Clear;
  slColumnLockList.Add('Company');

  // Set our lock list.
//  oGridObj.LockList := slColumnLockList;

  // Bind Column Moved Event to our grid.
//  oGridObj.BindColumnMovedEvent(grdRunLines);

  // Create our transactions object.
  oTransactions := TTransactionTableObj.Create;
  
end;

procedure TfrmRunDespatchGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  try
    inherited;
    SetLength(QueryNamesNotToOpen, 2);
    QueryNamesNotToOpen[0] := 'qryRunlines';
    QueryNamesNotToOpen[1] := 'qryHistory';
    qryPersonalPreferences.Params.ParamByName('xID').AsInteger := AppEnv.Employee.EmployeeID;

    if KeyID <> 0 then begin
      qryRuns.SQL.Clear;
      qryRuns.SQL.Add('SELECT * FROM tbldespatchruns ORDER BY RunName, RunDate;');
    end;

    OpenQueries(QueryNamesNotToOpen);
    if qryRuns.RecordCount < 1 then begin
      CommonLib.MessageDlgXP_Vista('You have NO scheduled runs available.', mtWarning, [mbOK], 0);
      Close;
      Exit;
    end;

    EditNoAbort(qryRuns);

    if KeyID <> 0 then begin
      if qryRuns.Locate('DespatchID', KeyID, [loCaseInsensitive]) then begin
        cboRunName.Text := qryRuns.FieldByName('RunName').AsString;
        cboRunName.Enabled := false;
        Label6.Caption := 'Operator : ' + qryRuns.FieldByName('Operator').AsString;
        SetupRun(qryRuns.FieldByName('DespatchID').AsInteger);
        BlockFields;

        Label13.Enabled := true;
        txtSearch.Enabled := true;
        // Has Invoices been generated for this run?
        if qryRuns.FieldByName('InvoicesGenerated').AsBoolean then begin
          // Yes
          Label1.Visible := true;
          btnInvoice.Enabled := false;
          Invoice1.Enabled := false;
          btnCancelRun.Enabled := false;
          CancelRun1.Enabled := false;
          btnEdit.Enabled := false;
          EditRun1.Enabled := false;
          btnDeliveryDocket.Enabled := false;
          DeliveryDockets1.Enabled := false;
          cmdOk.Enabled := false;
          Save1.Enabled := false;
          dtRunDate.Enabled := false;
          edtClass.Enabled := false;
          grdRunlines.ReadOnly := true;
          grdRunLines.KeyOptions := grdRunLines.KeyOptions - [dgAllowDelete];
          btnDelete.Enabled := false;
          btnSetPayments.Enabled := false;
          SetPayments1.Enabled := false;
          chkPreviewInvoices.Enabled := true;
          Label10.Enabled := true;

          chkPrintInvoices.Enabled := true;
          Label12.Enabled := true;

//          CustomiseFields1.Enabled := false;
          btnReorder.Enabled := false;
          btnRenumber.Enabled := false;
          btnResequence.Enabled := false;
          chkShowCompany.Enabled := false;
          Label9.Enabled := false;
          chkSingleLines.Enabled := false;
          Label11.Enabled := false;
        end else begin
          // No
          Label1.Visible := false;
          btnInvoice.Enabled := true;
          Invoice1.Enabled := true;

          Label10.Enabled := true;
          chkPreviewInvoices.Enabled := true;

          chkPrintInvoices.Enabled := true;
          Label12.Enabled := true;

          btnCancelRun.Enabled := true;
          CancelRun1.Enabled := true;
          btnEdit.Enabled := true;
          EditRun1.Enabled := true;
          btnDeliveryDocket.Enabled := true;
          DeliveryDockets1.Enabled := true;
          cmdOk.Enabled := true;
          Save1.Enabled := true;
          dtRunDate.Enabled := true;
          edtClass.Enabled := true;
          grdRunlines.ReadOnly := false;
          chkSingleLines.Enabled := true;
          //             Reschedule1.Enabled := True;
        end;

        btnExport.Enabled := true;
        Export1.Enabled := true;
        btnDriverReports.Enabled := true;
        DriverReports1.Enabled := true;
        btnStandingOrders.Enabled := true;
        StandingOrders1.Enabled := true;
        btnProductionList.Enabled := true;
        ProductionList1.Enabled := true;
        CalcTotals;
      end;
    end;

    // Auto correct product totals.
    if AppEnv.CompanyPrefs.AutoCorrectPriceDiscountsOnDeliveries then begin
      // Fetch current inventory prices.
      oMyDelivery.RecheckEnteredPrices(memDespatchLines, dtRunDate.DateTime, qryRuns.FieldByName('ClassID').AsInteger);
    end;

    // Refresh our Customer query.
    RefreshClientList;

    // If Auto Create Mode is enabled then
    // disable all user interaction controls
    // to ensure they cannot interrupt the
    // Auto Create Reports process.
    if AutoCreateMode then begin
      cmdCancel.Enabled := false;
      btnExport.Enabled := false;
      btnSetPayments.Enabled := false;
      btnCancelRun.Enabled := false;
      btnResequence.Enabled := false;
      btnInvoice.Enabled := false;
      btnRenumber.Enabled := false;
      btnRunSummary.Enabled := false;
      cmdOk.Enabled := false;
      btnDriverReports.Enabled := false;
      chkSingleLines.Enabled := false;
      Label11.Enabled := false;
      chkShowCompany.Enabled := false;
      Label9.Enabled := false;
      Label12.Enabled := false;
      chkPrintInvoices.Enabled := false;
      btnReorder.Enabled := false;
      Label10.Enabled := false;
      chkPreviewInvoices.Enabled := false;
//      CustomiseFields1.Enabled := false;
      CancelRun1.Enabled := false;
      EditRun1.Enabled := false;
      Export1.Enabled := false;
      Invoice1.Enabled := false;
      SetPayments1.Enabled := false;
      Save1.Enabled := false;
      DeliveryDockets1.Enabled := false;
      DriverReports1.Enabled := false;
      ProductionList1.Enabled := false;
      RunSummary1.Enabled := false;
      StandingOrders1.Enabled := false;
      grdRunLines.ReadOnly := true;
      cboRunName.Enabled := false;
      txtSearch.Enabled := false;
    end;
    
    // Put our Database Connection into transaction mode.
    BeginTransaction;

    // Must go last.  Now we will accept changes if any.
    bUpdatingTakenValue := false;
    SaveFieldPrefs(GuiPrefs);
     GuiPrefs.Active := True;
    // Exception Handler
  except
    // Handle these known exceptions.
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
end;

procedure TfrmRunDespatchGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TfrmRunDespatchGUI.FormDestroy(Sender: TObject);
begin
  if Assigned(oTranConvert) then
    FreeandNil(oTranConvert);
  if Assigned(oMyDelivery) then
    FreeandNil(oMyDelivery);
  if Assigned(oTransactions) then
    FreeandNil(oTransactions);
  if Assigned(oDataSaver) then
    FreeAndNil(oDataSaver);
  if Assigned(slColumnLockList) then
    FreeandNil(slColumnLockList);
  if Assigned(fCardFast) then
    FreeandNil(fCardFast);
  inherited;
end;

procedure TfrmRunDespatchGUI.cboRunNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if Empty(cboRunName.Text) then Exit;

  fbInitialisingRun := true;
  Label6.Caption := 'Operator : ' + qryRuns.FieldByName('Operator').AsString;
  SetupRun(qryRuns.FieldByName('DespatchID').AsInteger);
  BlockFields;
  Label13.Enabled := true;
  txtSearch.Enabled := true;

  // Has Invoices been generated for this run?
  if qryRuns.FieldByName('InvoicesGenerated').AsBoolean then begin
    // Yes
    Label1.Visible         := true;
    btnInvoice.Enabled     := false;
    Label10.Enabled        := false;
    chkPreviewInvoices.Enabled := false;
    btnCancelRun.Enabled   := false;
    chkPrintInvoices.Enabled := false;
    Label12.Enabled        := false;
    btnDelete.Enabled      := false;
    cmdOk.Enabled          := false;
    grdRunLines.ReadOnly   := true;
    btnReorder.Enabled     := false;
    btnRenumber.Enabled    := false;
    btnResequence.Enabled  := false;
    chkShowCompany.Enabled := false;
    Label9.Enabled         := false;
    chkSingleLines.Enabled := false;
    Label11.Enabled        := false;
  end else begin
    // No
    Label1.Visible         := false;
    btnInvoice.Enabled     := true;
    Label10.Enabled        := true;
    chkPreviewInvoices.Enabled := true;
    btnCancelRun.Enabled   := true;
    chkPrintInvoices.Enabled := true;
    Label12.Enabled        := true;
    cmdOk.Enabled          := true;
    grdRunLines.ReadOnly   := false;
    chkSingleLines.Enabled := true;
  end;

  btnEdit.Enabled := true;
  btnStandingOrders.Enabled := true;
  btnProductionList.Enabled := true;

  // Refresh our summary totals
  CalcTotals;
  fbInitialisingRun := false;
end;

  ////////////////////////////////////////////////////////////
  // This function is responsible for retrieving our run
  // despatch details.  From here once retrieved we then
  // initialise the memDespatchLines (Memory Table) as
  // all changes from the user are placed here until
  // saved.
  ////////////////////////////////////////////////////////////
procedure TfrmRunDespatchGUI.SetupRun(const iDespatchID: integer);
var
  iHistory: integer;
begin
  fbInitialisingRun := true;
  if Self.AccessLevel >= 5 then begin
    grdRunLines.ReadOnly   := true;
    btnReschedule.Enabled  := false;
    btnReorder.Enabled     := false;
    btnRenumber.Enabled    := false;
    btnResequence.Enabled  := false;
    btnSetPayments.Enabled := false;
    SetPayments1.Enabled   := false;
  end else begin
    grdRunLines.ReadOnly   := false;
    btnReschedule.Enabled  := true;
    btnReorder.Enabled     := true;
    btnRenumber.Enabled    := true;
    btnResequence.Enabled  := true;
    btnSetPayments.Enabled := true;
    SetPayments1.Enabled   := true;
  end;

  if Self.AccessLevel >= 2 then begin
    btnDelete.Enabled      := false;
    grdRunLines.KeyOptions := grdRunLines.KeyOptions - [dgAllowDelete];
  end;

  if qryRunLines.Active then begin
    qryRunLines.Last;
    qryRunLines.First;
  end;

  qryRunLines.Close;
  qryRunLines.ParamByName('xDespatchID').asInteger := iDespatchID;
  qryRunLines.Open;

  // Has invoices been generated for this run?
  if qryRuns.FieldByName('InvoicesGenerated').AsBoolean then begin
    // Yes, set properties on the following controls.
    Label1.Visible := true;
    cmdOk.Enabled  := false;
  end;

  // Load fetched data into our memory table.
  memDespatchLines.DisableControls;
  memDespatchLines.EnableIndexes := false;
  memDespatchLines.LoadFromDataSet(qryRunLines, []);
  memDespatchLines.EnableIndexes := true;
  memDespatchLines.EnableControls;
  memDespatchLines.UpdateIndexes;

  // Data changes have not been made.
  bDataChanged := false;
//  CustomiseFields1.Enabled := true;

  // Retrieve our quantity history from for the clients within
  // our memory table.
  memDespatchLines.First;
  qryRunLines.First;
  if AppEnv.CompanyPrefs.UseHistoryOnDespatchRuns then begin
    while not qryRunLines.Eof do begin
      oMyDelivery.CalcScheduledBackDates(qryRunLines.FieldByName('FreqInterval').AsInteger,
        qryRunLines.FieldByName('FreqType').AsString,
        qryRuns.FieldByName('RunDate').AsDateTime);

      qryHistory.Close;
      qryHistory.Params.ParamByName('xDate').AsDateTime := qryRuns.FieldByName('RunDate').AsDateTime;
      qryHistory.Params.ParamByName('xDate1').AsDateTime := oMyDelivery.BackTimes[2];
      qryHistory.Params.ParamByName('xCID').AsInteger := qryRunLines.FieldByName('ClientID').AsInteger;
      qryHistory.Params.ParamByName('xRID').AsInteger := qryRunLines.FieldByName('RunID').AsInteger;
      qryHistory.Params.ParamByName('xPID').AsInteger := qryRunLines.FieldByName('ProductID').AsInteger;
      qryHistory.Open;

      iHistory := 1;
      while not qryHistory.Eof do begin
        memDespatchLines.Edit;
        memDespatchLines.FieldByName('HistoryQty' + FastFuncs.IntToStr(iHistory)).AsFloat :=
          qryHistory.FieldByName('TakenQty').AsFloat;
        memDespatchLines.Post;
        Inc(iHistory);
        // Fetch next History Record.
        qryHistory.Next;
      end;

      // Fetch Next Record and Match in memory table.
      qryRunLines.Next;
      memDespatchLines.Next;
    end;
  end;

  Application.ProcessMessages;
//  oGridObj.GetPreviousSettings(grdRunLines, grdRunLines.Owner.Name);

  // Since the grid now can have a new order of fields within its
  // list.  We now have to re-initialise the tab stops so that the
  // tab stop settings will load and remain.
  Self.pTabStops.Initialised := false;
  Self.pTabStops.Initialise(memDespatchLines);

  // Now are we showing the company or contact field first?
  if (qryPersonalPreferences.FieldByName('ShowCompanyAsDefaultOnRun').AsString = 'T') then begin
    grdRunLines.ColumnByName('Company').DisplayLabel := 'Contact';
    cboCustomer.Selected.Clear;
    cboCustomer.Selected.Add('Customer' + #9 + '30' + #9 + 'Contact'#9'T' + #9);
    cboCustomer.Selected.Add('Company' + #9 + '30' + #9 + 'Company'#9'T' + #9);
    cboCustomer.Selected.Add('Type' + #9 + '15' + #9 + 'Type'#9'T' + #9);
    cboCustomer.Selected.Add('Address' + #9 + '35' + #9 + 'Address'#9'T' + #9);
    bShowingContact := true;
  end else begin
    grdRunLines.ColumnByName('Company').DisplayLabel := 'Company';
    cboCustomer.Selected.Clear;
    cboCustomer.Selected.Add('Company' + #9 + '30' + #9 + 'Company'#9'T' + #9);
    cboCustomer.Selected.Add('Customer' + #9 + '30' + #9 + 'Contact'#9'T' + #9);
    cboCustomer.Selected.Add('Type' + #9 + '15' + #9 + 'Type'#9'T' + #9);
    cboCustomer.Selected.Add('Address' + #9 + '35' + #9 + 'Address'#9'T' + #9);
    bShowingContact := false;
  end;

  // Has this run been rescheduled.
  //  if qryRuns.FieldByName('Rescheduled').AsBoolean then begin
  //     lblReschedule.Visible := True;
  //     lblReschedule.Caption := 'This Run has been rescheduled for the ' +
  //                              DateToStr(qryRuns.FieldByName('RescheduleDate').AsDateTime);
  //  end else begin
  //     lblReschedule.Visible := False;
  //  end;

  btnRunSummary.Enabled := true;
  btnDriverReports.Enabled := true;
  RunSummary1.Enabled := true;
  qryHistory.Close;
  qryRunLines.First;
  memDespatchLines.First;
  memDespatchLines.Edit;
  fbInitialisingRun := false;
end;

procedure TfrmRunDespatchGUI.actSaveUpdate(Sender: TObject);
begin
  inherited;
  if KeyID <> 0 then begin
    if (qryRuns.FieldByName('Done').AsBoolean) then begin
      cmdOk.Enabled := false;
      Save1.Enabled := false;
      Exit;
    end;
  end;

  if cboRunName.Text = '' then begin
    cmdOk.Enabled := false;
    Save1.Enabled := false;
  end else begin
    cmdOk.Enabled := true;
    Save1.Enabled := true;
  end;
end;

procedure TfrmRunDespatchGUI.btnDeleteClick(Sender: TObject);
begin
  fbInitialisingRun := true;

  inherited;

  // Delete record.
  tmrTrigger.Enabled := false;
  memDespatchLines.DisableControls;
  memDespatchLines.EnableIndexes := false;
  DeleteRecord(memDespatchLines);
  memDespatchLines.EnableIndexes := true;
  memDespatchLines.UpdateIndexes;
  memDespatchLines.EnableControls;
  Application.ProcessMessages;

  // Refresh our summary totals
  CalcTotals;

  fbInitialisingRun := false;
end;

procedure TfrmRunDespatchGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;

  // Failed! Rollback Transaction and Cancel
  RollbackTransaction;
  AutoCreateMode := false;

  // Close form.
  Close;
end;

procedure TfrmRunDespatchGUI.grdRunlinesCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  // This function makes the font colour to the same colour as the title colour
  // if the field contents equal to a value of 0 (Zero).
  if (Field.FieldName = 'OrderValue') or (Field.FieldName = 'TakenQty') or
    (Field.FieldName = 'TakenValue') or (Field.FieldName = 'ReturnQty') or
    (Field.FieldName = 'Payments') or (Field.FieldName = 'Deposits') or
    (Field.FieldName = 'TaxAmount') or (Field.FieldName = 'HistoryQty1') or
    (Field.FieldName = 'HistoryQty2') or (Field.FieldName = 'HistoryQty3') then begin
    if memDespatchLines.FieldByName(Field.FieldName).AsVariant = 0 then begin
      AFont.Color := TwwDBGrid(Sender).TitleColor;
    end;
  end;

  // Highlight any rows that match our search criteria
  // if one has been provided.
  if fbInitialisingRun then Exit;
  if chkShowCompany.Checked then begin
    if (not Empty(txtSearch.Text)) and (not (gdSelected in State) or not TwwDBGrid(Sender).Focused) and
      (FastFuncs.PosEx(FastFuncs.UpperCase(ReplaceStr(ReplaceStr(txtSearch.Text, '%', ''), '*', '')),
      FastFuncs.UpperCase(memDespatchLines.FieldByName('ClientName').AsString)) = 1) then begin
      ABrush.Color := HIGHLIGHTLOCATE;
    end;
  end else begin
    if (not Empty(txtSearch.Text)) and (not (gdSelected in State) or not TwwDBGrid(Sender).Focused) and
      (FastFuncs.PosEx(FastFuncs.UpperCase(ReplaceStr(ReplaceStr(txtSearch.Text, '%', ''), '*', '')),
      FastFuncs.UpperCase(memDespatchLines.FieldByName('Company').AsString)) = 1) then begin
      ABrush.Color := HIGHLIGHTLOCATE;
    end;
  end;
end;

procedure TfrmRunDespatchGUI.CalcTotals;
var
  dTotalPriceInc, dQty, dRtns, dTax: double;
  dValueTaken, dTakenQty: double;
  dDeposits, dPayments: double;
  mem: TkbmMemTable;
begin
  mem := TkbmMemTable.Create(nil);
  try
    mem.LoadFromDataSet(memDespatchLines, [mtcpoStructure, mtcpoProperties]);

    // Initialise total variables.
    dTotalPriceInc := 0;
    dQty           := 0;
    dRtns          := 0;
    dTax           := 0;
    dValueTaken    := 0;
    dTakenQty      := 0;
    dDeposits      := 0;
    dPayments      := 0;
    // Calculate Totals
    mem.First;
    while not mem.Eof do begin
      // Accumulate these totals.
      dQty := dQty + mem.FieldByName('OrderQty').AsFloat;
      dRtns := dRtns + mem.FieldByName('ReturnQty').AsFloat;
      dTotalPriceInc := dTotalPriceInc + mem.FieldByName('OrderValue').AsFloat;
      dTax := dTax + mem.FieldByName('TaxAmount').AsFloat;
      dTakenQty := dTakenQty + mem.FieldByName('TakenQty').AsFloat;
      dValueTaken := dValueTaken + mem.FieldByName('TakenValue').AsFloat;
      dDeposits := dDeposits + mem.FieldByName('Deposits').AsFloat;
      dPayments := dPayments + mem.FieldByName('Payments').AsFloat;
      // Fetch next Record.
      mem.Next;
    end;

    // Show footer values.
    grdRunLines.ColumnByName('OrderQty').FooterValue := FloatToStrF(dQty, ffGeneral, 15, 2);
    grdRunLines.ColumnByName('ReturnQty').FooterValue := FloatToStrF(dRtns, ffGeneral, 15, 2);
    TotalReturns := dRtns;

    grdRunLines.ColumnByName('OrderValue').FooterValue := FloatToStrF(dTotalPriceInc, ffCurrency, 15, 2);
    grdRunLines.ColumnByName('TaxAmount').FooterValue := FloatToStrF(dTax, ffCurrency, 15, 2);
    TotalTax := dTax;

    grdRunLines.ColumnByName('TakenQty').FooterValue := FloatToStrF(dTakenQty, ffGeneral, 15, 2);
    TotalQty      := dTakenQty;
    grdRunLines.ColumnByName('TakenValue').FooterValue := FloatToStrF(dValueTaken, ffCurrency, 15, 2);
    TotalSalesInc := dValueTaken;
    TotalSalesEx  := dValueTaken - dTax;

    grdRunLines.ColumnByName('Deposits').FooterValue := FloatToStrF(dDeposits, ffCurrency, 15, 2);
    TotalDeposits := dDeposits;

    grdRunLines.ColumnByName('Payments').FooterValue := FloatToStrF(dPayments, ffCurrency, 15, 2);
    TotalPayments := dPayments;
  finally
    // Free our used objects.
    if Assigned(mem) then
      FreeandNil(mem);
  end;
end;

procedure TfrmRunDespatchGUI.btnStandingOrdersClick(Sender: TObject);
var
  sSQL, sRunDate: string;
  qry: TMyQuery;
begin
  inherited;
  oMyDelivery.DeleteSOTemporaryTableContents;

  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM `' + oMyDelivery.GetSOTemporaryTableName + '`;');
    memDespatchLines.SaveToDataSet(qry, []);
    qry.Close;

    fbReportSQLSupplied := true;
    if qryRuns.FieldByName('Rescheduled').AsBoolean then begin
      sRunDate := DateToStr(qryRuns.FieldByName('RescheduleDate').AsDateTime);
    end else begin
      sRunDate := DateToStr(qryRuns.FieldByName('RunDate').AsDateTime);
    end;

    sSQL := 'SELECT *, DR.RunName AS "Run Name", DR.Operator, ' + QuotedStr(sRunDate) +
      ' AS "Run Date" FROM `' + oMyDelivery.GetSOTemporaryTableName + '` AS TSO ';
    sSQL := sSQL + 'INNER JOIN tbldespatchruns AS DR on DR.DespatchID = TSO.DespatchID';
    PrintTemplateReport('Standing Order Run Summary', sSQL, not chkPreviewInvoices.Checked, 1);
    fbReportSQLSupplied := false;

  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmRunDespatchGUI.btnProductionListClick(Sender: TObject);
var
  sSQL: string;
  sDate: string;
begin
  inherited;
  try
    // Save the run details to our database backend.
    if not IsRunOk then begin
      Exit;
    end;

    SaveDespatchRun;

    if (MyConnection.intransaction) then begin
      // Commit Transaction.
      CommitTransaction;
    end;

    if qryRuns.FieldByName('Rescheduled').AsBoolean then begin
      sDate := DateToStr(qryRuns.FieldByName('RescheduleDate').AsDateTime);
    end else begin
      sDate := DateToStr(qryRuns.FieldByName('RunDate').AsDateTime);
    end;

    fbReportSQLSupplied := true;
    sSQL := 'SELECT DR.RunName AS "Run Name", ';
    sSQL := sSQL + QuotedStr(sDate) + ' AS "Run Date", ';
    sSQL := sSQL + 'DR.Operator, ';
    sSQL := sSQL + 'DRL.ProductName AS "Product Name", P.PARTSDESCRIPTION AS "Description", ';
    sSQL := sSQL + 'Sum(DRL.OrderQty) AS Qty ';
    sSQL := sSQL + 'FROM tbldespatchruns AS DR ';
    sSQL := sSQL + 'INNER JOIN tbldespatchrunlines AS DRL on DR.DespatchID = DRL.DespatchID ';
    sSQL := sSQL + 'INNER JOIN tblparts AS P on DRL.ProductID = P.PartsID ';
    sSQL := sSQL + 'WHERE DR.DespatchID = ' + qryRuns.FieldByName('DespatchID').AsString + ' ';
    sSQL := sSQL + 'GROUP BY DRL.ProductName ';
    sSQL := sSQL + 'ORDER BY DRL.ProductName;';
    PrintTemplateReport('Order Production List', sSQL, not chkPreviewInvoices.Checked, 1);
    fbReportSQLSupplied := false;
  except 
  end;

  if not (MyConnection.intransaction) then begin
    // Put our Database Connection into transaction mode.
    BeginTransaction;
  end;
end;

procedure TfrmRunDespatchGUI.btnInvoiceClick(Sender: TObject);
var
  qry: TMyQuery;
  bCloseDown: boolean;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure that the delivery details of this run are complete and correct?' + #13#10#13#10 +
    'This means have you provided all customer payments, deposits and set prices?', mtConfirmation,
    [mbYes, mbCancel], 0) = mrCancel then Exit;
                
  qry := TMyQuery.Create(nil);
  bCloseDown := false;
  try
    // Disable all binded data aware controls.
    memDespatchLines.DisableControls;

    // Initialise our query.
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblrunslines WHERE ClientID = :xCID AND ProductID = :xPID AND RunID = :xRunID');

    // Here we will need to check to ensure that the payment method, returns and
    // payments received filled in before doing the mass invoicing.
    memDespatchLines.First;
    while not memDespatchLines.Eof do begin
      if ((memDespatchLines.FieldByName('Payments').AsFloat <> 0) and
        ((memDespatchLines.FieldByName('PaymentMethodName').AsString = '') or (memDespatchLines.FieldByName('PaymentMethodName').IsNull))) then
      begin
        CommonLib.MessageDlgXP_Vista('Before invoicing, customers who have received payments must have their payment method specified.  Please set and retry again.',
          mtWarning, [mbOK], 0);
        Exit;
      end;

      // Was this payment made by a cheque?
      if (memDespatchLines.FieldByName('PaymentMethodName').AsString = 'Cheque') and
        (memDespatchLines.FieldByName('Reference').AsString = '') then begin
        // Yes, but no reference was provided. Advise user and abort procedure.
        CommonLib.MessageDlgXP_Vista('Before invoicing customers, payments made by cheque must be provided with a reference number.  Please set and retry again.',
          mtWarning, [mbOK], 0);
        Exit;
      end;

      // Fetch next record.
      memDespatchLines.Next;
    end;

    // Get First Record.
    memDespatchLines.First;

    // Generate Invoices and Determine if a payment was received or not.
    // If a payment was received then we need to create a
    // customer prepayment entry.
    fbInitialisingRun := true;

    if FormStillOpen('TfrmCustomer') then begin
        TfrmCustomer(FindExistingComponent('TfrmCustomer')).CloseMe;
        Application.ProcessMessages;
    end;

    oTranConvert.ConvertDespatchRunToPayment(memDespatchLines, qryRuns.FieldByName('ClassID').AsInteger,
      Now(), chkPrintInvoices.Checked, chkPreviewInvoices.Checked, Self);

    fbInitialisingRun := false;

    // Now do we have the Returns, Payment Method and payments filled in?
    // if so, then we set the client on the run template the last delivery
    // field and advance the next delivery run date.
    memDespatchLines.First;
    while not memDespatchLines.Eof do begin
      qry.Close;
      qry.Params.ParamByName('xCID').AsInteger := memDespatchLines.FieldByName('ClientID').AsInteger;
      qry.Params.ParamByName('xPID').AsInteger := memDespatchLines.FieldByName('ProductID').AsInteger;
      qry.Params.ParamByName('xRunID').AsInteger := memDespatchLines.FieldByName('RunID').AsInteger;
      qry.Open;

      // Update clients next run date.
      if qry.RecordCount > 0 then begin
        while not qry.Eof do begin
          // Put record in edit mode.
          qry.Edit;

          // Set last delivery date received.
          qry.FieldByName('LastDelivery').AsDateTime := qry.FieldByName('NextRunDate').AsDateTime;

          // Calculate next run dates in advance.
          oMyDelivery.CalcScheduledDates(memDespatchLines.FieldByName('FreqInterval').AsInteger,
            memDespatchLines.FieldByName('FreqType').AsString,
            qry.FieldByName('NextRunDate').AsDateTime);

          // Set the next delivery run date.
          qry.FieldByName('NextRunDate').AsDateTime := oMyDelivery.ScheduledTimes[1];

          // Set the following next delivery date.
          qry.FieldByName('DateAfterNext').AsDateTime := oMyDelivery.ScheduledTimes[2];

          // Fetch Next Record.
          qry.Next;
        end;
      end;
                          
      // Fetch next record.
      memDespatchLines.Next;
    end;

    // State that this despatch run is now completed.
    bCloseDown := true;
    qryRuns.Edit;
    qryRuns.FieldByName('InvoicesGenerated').AsString := 'T';
    qryRuns.FieldByName('Done').AsString := 'T';
    qryRuns.Post;
    qryRuns.Edit;

  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);

    // Enable all binded data aware controls.
    memDespatchLines.EnableControls;
    if bCloseDown then begin
      // Save and close.
      cmdOk.Click;
    end;
  end;
end;

procedure TfrmRunDespatchGUI.actSaveExecute(Sender: TObject);
begin
  try
    inherited;
    // Check run for duplicate parts.
    if not IsRunOk then begin
      Exit;
    end;

    // Disable all bounded data aware controls.
    qryRuns.DisableControls;
    qryRunLines.DisableControls;

    // By Moving the record pointer, if in edit mode
    // it will force a post.
    qryRuns.Last;
    qryRuns.First;

    memDespatchLines.Last;
    memDespatchLines.First;

    qryPersonalPreferences.Last;
    qryPersonalPreferences.First;
    AppEnv.Employee.PopulateMe(AppEnv.Employee.EmployeeID);

    SaveDespatchRun;

//    oGridObj.SaveGridDetails(grdRunLines.Name, Self.Name, grdRunLines);

    if (MyConnection.intransaction) then begin
      // Commit Transaction.
      CommitTransaction;
    end;
  except
    // Failed! Rollback Transaction and Cancel
    RollbackTransaction;
  end;

  // Notify any attached list.
  Notify;
  
  // Close the form down.
  Close;
end;

procedure TfrmRunDespatchGUI.btnCancelRunClick(Sender: TObject);
var
  qry: TMyQuery;
begin
  inherited;
  qry := TMyQuery.Create(nil);
  try
    // Close this form down to ensure we do not get locking errors.
//    if Assigned(DespatchRunListGUI) then begin
//      DespatchRunListGUI.Close;
//    end;
    if FormStillOpen('TDespatchRunListGUI') then begin
      TDespatchRunListGUI(FindExistingComponent('TDespatchRunListGUI')).Close;
    end;

    // Delete the Despatch run lines.
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM tbldespatchrunlines WHERE DespatchID = :xDespatchID');
    qry.Params.ParamByName('xDespatchID').AsInteger := qryRuns.FieldByName('DespatchID').AsInteger;
    qry.Execute;

    // Now remove the despatch run header.
    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM tbldespatchruns WHERE DespatchID = :xID');
    qry.Params.ParamByName('xID').AsInteger := qryRuns.FieldByName('DespatchID').AsInteger;
    qry.Execute;
  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
    // Cancel form operation and close.
    cmdCancel.Click;
  end;
end;

procedure TfrmRunDespatchGUI.SaveDespatchRun;
var
  ProgressDialog: TProgressDialog;
  iRecID: integer;
begin
  // If the run template window is open, then save
  // run data and then close window down.
    if FormStillOpen('TfrmRunSequencerGUI') then begin
    TfrmRunSequencerGUI(FindExistingComponent('TfrmRunSequencerGUI')).cmdOKClick(nil);
  end;

//  if Assigned(frmRunSequencerGUI) then begin
//    frmRunSequencerGUI.cmdOKClick(nil);
//  end;

  iRecID := memDespatchLines.FieldByName('ID').AsInteger;
  memDespatchLines.DisableControls;
  ProgressDialog := TProgressDialog.Create(nil);
  try
    Screen.Cursor := crHourGlass;
    // Setup our progress dialog
    ProgressDialog.Caption  := 'Saving .....';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := memDespatchLines.RecordCount;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;

    Application.ProcessMessages;

    // Clear run contents.
    qryRunLines.First;
    while not qryRunLines.Eof do begin
      qryRunLines.Delete;
    end;

    // Save recorded data to database backend.
    memDespatchLines.First;
    while not memDespatchLines.Eof do begin
      qryRunLines.Insert;
      qryRunLines.FieldByName('ClientName').AsString := memDespatchLines.FieldByName('ClientName').AsString;
      qryRunLines.FieldByName('ClientID').AsInteger := memDespatchLines.FieldByName('ClientID').AsInteger;
      qryRunLines.FieldByName('DespatchID').AsInteger := memDespatchLines.FieldByName('DespatchID').AsInteger;
      qryRunLines.FieldByName('RunID').AsInteger := memDespatchLines.FieldByName('RunID').AsInteger;
      qryRunLines.FieldByName('SalesID').AsInteger := memDespatchLines.FieldByName('SalesID').AsInteger;
      qryRunLines.FieldByName('Sequence').AsInteger := memDespatchLines.FieldByName('Sequence').AsInteger;
      qryRunLines.FieldByName('OrderQty').AsFloat := memDespatchLines.FieldByName('OrderQty').AsFloat;
      qryRunLines.FieldByName('OrderValue').AsFloat := memDespatchLines.FieldByName('OrderValue').AsFloat;
      qryRunLines.FieldByName('Address').AsString := memDespatchLines.FieldByName('Address').AsString;
      qryRunLines.FieldByName('Phone').AsString := memDespatchLines.FieldByName('Phone').AsString;
      qryRunLines.FieldByName('Mobile').AsString := memDespatchLines.FieldByName('Mobile').AsString;
      qryRunLines.FieldByName('Track').AsString := memDespatchLines.FieldByName('Track').AsString;
      qryRunLines.FieldByName('PreferedSupp').AsString := memDespatchLines.FieldByName('PreferedSupp').AsString;
      qryRunLines.FieldByName('TakenQty').AsFloat := memDespatchLines.FieldByName('TakenQty').AsFloat;
      qryRunLines.FieldByName('TakenValue').AsFloat := memDespatchLines.FieldByName('TakenValue').AsFloat;
      qryRunLines.FieldByName('Company').AsString := memDespatchLines.FieldByName('Company').AsString;
      qryRunLines.FieldByName('ProductName').AsString := memDespatchLines.FieldByName('ProductName').AsString;
      qryRunLines.FieldByName('ProductID').AsInteger := memDespatchLines.FieldByName('ProductID').AsInteger;
      qryRunLines.FieldByName('ReturnQty').AsFloat := memDespatchLines.FieldByName('ReturnQty').AsFloat;
      qryRunLines.FieldByName('PaymentMethodName').AsString := memDespatchLines.FieldByName('PaymentMethodName').AsString;
      qryRunLines.FieldByName('PaymentMethodID').AsInteger := memDespatchLines.FieldByName('PaymentMethodID').AsInteger;
      qryRunLines.FieldByName('Payments').AsFloat := memDespatchLines.FieldByName('Payments').AsFloat;
      qryRunLines.FieldByName('Deposits').AsFloat := memDespatchLines.FieldByName('Deposits').AsFloat;
      qryRunLines.FieldByName('TaxCode').AsString := memDespatchLines.FieldByName('TaxCode').AsString;
      qryRunLines.FieldByName('TaxAmount').AsFloat := memDespatchLines.FieldByName('TaxAmount').AsFloat;
      qryRunLines.FieldByName('UnitExPrice').AsFloat := memDespatchLines.FieldByName('UnitExPrice').AsFloat;
      qryRunLines.FieldByName('FreqType').AsString := memDespatchLines.FieldByName('FreqType').AsString;
      qryRunLines.FieldByName('FreqInterval').AsInteger := memDespatchLines.FieldByName('FreqInterval').AsInteger;
      qryRunLines.FieldByName('StartDate').AsDateTime := memDespatchLines.FieldByName('StartDate').AsDateTime;
      qryRunLines.FieldByName('Reference').AsString := memDespatchLines.FieldByName('Reference').AsString;
      qryRunLines.FieldByName('IsContact').AsString := memDespatchLines.FieldByName('IsContact').AsString;
      qryRunLines.FieldByName('ContactID').AsInteger := memDespatchLines.FieldByName('ContactID').AsInteger;
      qryRunLines.FieldByName('DeliveryDocket').AsString := memDespatchLines.FieldByName('DeliveryDocket').AsString;
      qryRunLines.Post;

      // Write Global Reference ID.
      qryRunLines.Edit;
      qryRunLines.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + qryRunLines.FieldByName('ID').AsString;
      qryRunLines.Post;

      // Fetch next record.
      memDespatchLines.Next;

      // Advance the progress status on progress dialog.
      ProgressDialog.StepIt;
    end;
  finally
    // Free our used objects.
    if Assigned(ProgressDialog) then
      FreeandNil(ProgressDialog);

    // Restore mouse cursor.
    Screen.Cursor := crDefault;
  end;

  memDespatchLines.Locate('ID', iRecID, [loCaseInsensitive]);
  memDespatchLines.EnableControls;
end;

procedure TfrmRunDespatchGUI.tmrTriggerTimer(Sender: TObject);
begin
  inherited;
  if fbInitialisingRun then Exit;
  if fbRequestRelocate then begin
    if memDespatchLines.FieldByName('ID').AsInteger <> CurrentRecordNumber then begin
      if memDespatchLines.Locate('ID', CurrentRecordNumber, [loCaseInsensitive]) then begin
        CurrentSequenceNumber := memDespatchLines.FieldByName('Sequence').AsInteger;
        CurrentPayMethodID := memDespatchLines.FieldByName('PaymentMethodID').AsInteger;
      end;
    end;

    fbRequestRelocate  := false;
    tmrTrigger.Enabled := false;
    memDespatchLines.EnableControls;
    memDespatchLines.Edit;
  end;

  Application.ProcessMessages;
end;

procedure TfrmRunDespatchGUI.cboPayMethodCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  ErrorMsg: string;
begin
  if not Modified then Exit;
  if cboPayMethod.Text = '' then Exit
    //
    // If the chosen payment method is 'NAB CardFast' then verify that the fields
    // required exist and are valid
    //
  else if cboPayMethod.Text = cNABCardFast then begin
    if fCardFast.VerifyCustomerInfo(memDespatchLinesClientID.AsInteger, ErrorMsg) = false then begin
      CommonLib.MessageDlgXP_Vista(ErrorMsg, mtWarning, [mbOK], 0);
      cboPayMethod.Text := fPreviousPayMethod;
      memDespatchLinesPaymentMethodName.AsString := fPreviousPayMethod;
      Exit;
    end;
  end;

  FillTable.Edit;
  FillTable.FieldByName('PaymentMethodID').AsInteger := qryPayment.FieldByName('PayMethodID').AsInteger;
  bDataChanged := true;
end;

procedure TfrmRunDespatchGUI.memDespatchLinesPaymentMethodIDChange(Sender: TField);
begin
  if fbInitialisingRun then Exit;
  memDespatchLines.DisableControls;
  CurrentRecordNumber := memDespatchLines.FieldByName('ID').AsInteger;
  UpdatePayMethod(Sender.AsInteger, memDespatchLines.FieldByName('ClientID').AsInteger,
    memDespatchLines.FieldByName('ContactID').AsInteger);
  fbRequestRelocate := true;
  tmrTrigger.Enabled := true;
  Application.ProcessMessages;
  CalcTotals;
end;

procedure TfrmRunDespatchGUI.UpdatePaymethod(const iNewPayMethodID, iClientID, iContactID: integer);
begin
  fbInitialisingRun := true;
  memDespatchLines.DisableControls;
  // Ensure sorting has been disabled.
  memCopy.SortFields := '';
  memCopy.Sort([]);

  // Get original copy of run list.
  memCopy.LoadFromDataSet(memDespatchLines, []);

  // Update all entries with same sequence to match new sequence value.
  memCopy.First;
  while not memCopy.Eof do begin
    if (memCopy.FieldByName('ClientID').AsInteger = iClientID) and
      (memCopy.FieldByName('ContactID').AsInteger = iContactID) then begin
      memCopy.Edit;
      memCopy.FieldByName('PaymentMethodID').AsInteger := iNewPayMethodID;
      memCopy.FieldByName('PaymentMethodName').AsString := GetPayMethodName(iNewPayMethodID);
      memCopy.Post;
    end;
    memCopy.Next;
  end;

  // Disable filter.
  memDespatchLines.LoadFromDataSet(memCopy, []);
  memDespatchLines.EnableControls;
  memDespatchLines.Edit;
  fbInitialisingRun := false;
end;

procedure TfrmRunDespatchGUI.grdRunlinesEnter(Sender: TObject);
begin
  inherited;
  CurrentSequenceNumber := memDespatchLines.FieldByName('Sequence').AsInteger;
  CurrentRecordNumber := memDespatchLines.FieldByName('ID').AsInteger;
  CurrentPayMethodID := memDespatchLines.FieldByName('PaymentMethodID').AsInteger;
end;

procedure TfrmRunDespatchGUI.memDespatchLinesTakenQtyChange(Sender: TField);
var
  dPrice: double;
  dIncPrice: double;
  //  iResult: Integer;
begin
  if fbInitialisingRun then Exit;
  if bUpdatingTakenValue then Exit;
  bUpdatingTakenValue := true;

  inherited;

  memDespatchLines.Edit;
  if memDespatchLines.FieldByName('TakenQty').AsFloat <> 0 then begin
    dPrice    := memDespatchLines.FieldByName('TakenQty').AsFloat * memDespatchLines.FieldByName('UnitExPrice').AsFloat;
    dIncPrice := GetAmountInc(dPrice, GetTaxRate(memDespatchLines.FieldByName('TaxCode').AsString));
    memDespatchLines.FieldByName('TakenValue').AsFloat := RoundCurrency(dIncPrice);
    memDespatchLines.FieldByName('TaxAmount').AsFloat := RoundCurrency(dIncPrice - dPrice);
  end else begin
    dPrice    := memDespatchLines.FieldByName('OrderQty').AsFloat * memDespatchLines.FieldByName('UnitExPrice').AsFloat;
    dIncPrice := GetAmountInc(dPrice, GetTaxRate(memDespatchLines.FieldByName('TaxCode').AsString));
    memDespatchLines.FieldByName('TaxAmount').AsFloat := RoundCurrency(dIncPrice - dPrice);
    memDespatchLines.FieldByName('TakenValue').AsFloat := 0;
  end;

  ///////////////////////////////////////////////////////
  // PLEASE DO NOT REMOVE THIS CODE!!!! Daniel - 2/9/2004
  ///////////////////////////////////////////////////////
  //  if memDespatchLines.FieldByName('TakenQty').AsFloat < memDespatchLines.FieldByName('OrderQty').AsFloat then begin
  //     iResult := CommonLib.MessageDlgXP_Vista('The order for ' + memDespatchLines.FieldByName('ClientName').AsString + ' is lower than requested standard order.'+#13#10#13#10+
  //                           'Would you like to reschedule this run date?', mtWarning, [mbOk, mbCancel], 0);
  //     if iResult = mrOk then begin
  //        btnReschedule.Click;
  //     end;
  //  end;
  ///////////////////////////////////////////////////////

  memDespatchLines.Post;
  memDespatchLines.Edit;

  // We are now finished updating.
  bUpdatingTakenValue := false;
end;

procedure TfrmRunDespatchGUI.cboPayMethodChange(Sender: TObject);
begin
  inherited;
  memDespatchLines.Edit;
end;

procedure TfrmRunDespatchGUI.grdRunlinesRowChanged(Sender: TObject);
begin
  if fbInitialisingRun then Exit;

  inherited;

  CurrentRecordNumber := memDespatchLines.FieldByName('ID').AsInteger;
  CurrentSequenceNumber := memDespatchLines.FieldByName('Sequence').AsInteger;
  CurrentPayMethodID := memDespatchLines.FieldByName('PaymentMethodID').AsInteger;
end;

procedure TfrmRunDespatchGUI.btnRunSummaryClick(Sender: TObject);
var
  sSQL: string;
  wYear, wMonth, wDay: word;
  dtRunDate: TDateTime;
begin
  inherited;
  try
    // Save the run details to our database backend.
    if not IsRunOk then begin
      Exit;
    end;

    SaveDespatchRun;
    if (MyConnection.intransaction) then begin
      // Commit Transaction.
      CommitTransaction;
    end;

    if qryRuns.FieldByName('Rescheduled').AsBoolean then begin
      dtRunDate := qryRuns.FieldByName('RescheduleDate').AsDateTime;
    end else begin
      dtRunDate := qryRuns.FieldByName('RunDate').AsDateTime;
    end;

    DecodeDate(dtRunDate, wYear, wMonth, wDay);
    fbReportSQLSupplied := true;
    sSQL := sSQL + 'SELECT DR.RunName AS "Run Name", ';
    sSQL := sSQL + 'DATE_ADD(DATE_ADD(DATE_FORMAT(' + QuotedStr(FastFuncs.IntToStr(wYear) + '-' + FastFuncs.IntToStr(wMonth) +
      '-' + FastFuncs.IntToStr(wDay)) + ',"%Y-%m-%d"), INTERVAL 1 Day), INTERVAL -1 Day) AS "Run Date", ';
    sSQL := sSQL + 'DR.Operator, ' + QuotedStr(FloatToStrF(TotalSalesInc, ffCurrency, 15, 2)) + ' As "Net Sales (INC)", ';
    sSQL := sSQL + QuotedStr(FloatToStrF(TotalSalesEx, ffCurrency, 15, 2)) + ' AS "Net Sales (Ex)", ';
    sSQL := sSQL + QuotedStr(FloatToStrF(TotalReturns, ffGeneral, 15, 2)) + ' AS "Total Returns", ';
    sSQL := sSQL + QuotedStr(FloatToStrF(TotalPayments, ffCurrency, 15, 2)) + ' AS "Total Payments Received", ';
    sSQL := sSQL + QuotedStr(FloatToStrF(TotalDeposits, ffCurrency, 15, 2)) + ' AS "Total Deposits", ';
    sSQL := sSQL + QuotedStr(FloatToStrF(TotalQty, ffGeneral, 15, 2)) + ' AS "Total Qty", ';
    sSQL := sSQL + QuotedStr(FloatToStrF((TotalDeposits + TotalPayments), ffCurrency, 15, 2)) + ' AS "Total Received", ';
    sSQL := sSQL + QuotedStr(FloatToStrF((TotalTax), ffCurrency, 15, 2)) + ' AS "Total Tax", ';
    sSQL := sSQL + 'IF(ISNULL(DRL.PaymentMethodName) OR DRL.PaymentMethodName = "", "Unknown", DRL.PaymentMethodName) AS "Payment Method", ';
    sSQL := sSQL + 'Sum(DRL.Payments) AS "Total Payments", ';
    sSQL := sSQL + 'Sum(DRL.TakenQty) AS "Actual Qty", Sum(DRL.TakenValue) AS "Taken Value" ';
    sSQL := sSQL + 'FROM tbldespatchruns AS DR ';
    sSQL := sSQL + 'INNER JOIN tbldespatchrunlines AS DRL on DR.DespatchID = DRL.DespatchID ';
    sSQL := sSQL + 'WHERE DR.DespatchID = ' + qryRuns.FieldByName('DespatchID').AsString + ' ';
    sSQL := sSQL + 'GROUP BY DRL.PaymentMethodName ';
    sSQL := sSQL + 'ORDER BY DRL.Sequence;';

    PrintTemplateReport('Run Summary', sSQL, not chkPreviewInvoices.Checked, 1);
    fbReportSQLSupplied := false;
  except 
  end;

  if not (MyConnection.intransaction) then begin
    // Put our Database Connection into transaction mode.
    BeginTransaction;
  end;
end;

procedure TfrmRunDespatchGUI.memDespatchLinesAfterPost(DataSet: TDataSet);
begin
  if fbInitialisingRun then Exit;
  inherited;
  // Refresh Totals;
  CalcTotals;

  memDespatchLines.Edit;
end;

procedure TfrmRunDespatchGUI.memDespatchLinesPaymentsChange(Sender: TField);
begin
  inherited;
  if fbInitialisingRun then Exit;
  CalcTotals;
end;

procedure TfrmRunDespatchGUI.memDespatchLinesDepositsChange(Sender: TField);
begin
  inherited;
  if fbInitialisingRun then Exit;
  CalcTotals;
end;

procedure TfrmRunDespatchGUI.memDespatchLinesReturnQtyChange(Sender: TField);
begin
  inherited;
  if fbInitialisingRun then Exit;
  CalcTotals;
end;

procedure TfrmRunDespatchGUI.Save1Click(Sender: TObject);
begin
  inherited;
  cmdOk.Click;
end;

procedure TfrmRunDespatchGUI.btnRescheduleClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfrmRunRescheduler');
  if Assigned(Form) then begin
    with TfrmRunRescheduler(Form) do begin
      ReturnResult := @RescheduleDate;
      FormStyle := fsNormal;
      if ShowModal = mrOk then begin
        qryRuns.Edit;
        qryRuns.FieldByName('Rescheduled').AsString := 'T';
        qryRuns.FieldByName('RescheduleDate').AsDateTime := RescheduleDate.Date;
        qryRuns.Post;
        qryRuns.Edit;

        lblReschedule.Visible := true;
        lblReschedule.Caption := 'This Run has been rescheduled for the ' +
          DateToStr(qryRuns.FieldByName('RescheduleDate').AsDateTime);
      end;
    end;
  end;
end;

procedure TfrmRunDespatchGUI.btnDeliveryDocketClick(Sender: TObject);
var
  sSQL, sDeliveryDocket: string;
  iRecID, iClientID, iContactID: integer;
begin
  inherited;
  fbInitialisingRun := true;
  iRecID := memDespatchLines.FieldByName('ID').AsInteger;
  // Ensure sorting has been disabled.
  memCopy.SortFields := '';
  memCopy.Sort([]);

  // Get original copy of run list.
  memCopy.LoadFromDataSet(memDespatchLines, []);

  // Disable all binded data aware controls.
  memDespatchLines.DisableControls;

  // Goto our first record.
  iClientID := 0;
  iContactID := 0;
  memDespatchLines.First;

  // Perform our Batch Update on Accounts Receivable.
  oTransactions.Get_AR_ClientInfo(dtRunDate.DateTime, 0, true);
  // Process clients.
  while not memDespatchLines.Eof do begin
    if iClientID <> memDespatchLines.FieldByName('ClientID').AsInteger then begin
      iClientID := memDespatchLines.FieldByName('ClientID').AsInteger;
      iContactID := 0;
      // Delete the contents within our temporary table.
      oMyDelivery.DeleteDDTemporaryTableContents;
      // Populate our temporary table.
      PopulateDDTemporaryTable(iClientID, memDespatchLines.FieldByName('ContactID').AsInteger);

      // Inform BaseInput that we are supplying SQL for our report.
      fbReportSQLSupplied := true;

      // Since the main connection to this temporary table is non transaction
      // then we need to set this next flag in BaseInput so it can see our table.
      fbTemplateUsesNonFormConnection := true;

      // Set our SQL that we will use for this report.
      sSQL := 'SELECT * FROM `' + oMyDelivery.GetDDTemporaryTableName + '` ORDER BY Product;';

      // Show report
      PrintTemplateReport('Run Delivery Docket', sSQL, not chkPreviewInvoices.Checked, 1);
      sDeliveryDocket := FastFuncs.IntToStr(iClientID) + '-' + memDespatchLines.FieldByName('ContactID').AsString +
        '-' + memDespatchLines.FieldByName('DespatchID').AsString;

      // Disable these settings.
      fbReportSQLSupplied := false;
      fbTemplateUsesNonFormConnection := false;

      // Save Delivery Docket ID
      memDespatchLines.Edit;
      memDespatchLines.FieldByName('DeliveryDocket').AsString := sDeliveryDocket;
      memDespatchLines.Post;
    end else begin
      if iContactID <> memDespatchLines.FieldByName('ContactID').AsInteger then begin
        iContactID := memDespatchLines.FieldByName('ContactID').AsInteger;

        // Delete the contents within our temporary table.
        oMyDelivery.DeleteDDTemporaryTableContents;
        // Populate our temporary table.
        PopulateDDTemporaryTable(iClientID, memDespatchLines.FieldByName('ContactID').AsInteger);

        // Inform BaseInput that we are supplying SQL for our report.
        fbReportSQLSupplied := true;

        // Since the main connection to this temporary table is non transaction
        // then we need to set this next flag in BaseInput so it can see our table.
        fbTemplateUsesNonFormConnection := true;

        // Set our SQL that we will use for this report.
        sSQL := 'SELECT * FROM `' + oMyDelivery.GetDDTemporaryTableName + '` ORDER BY Product;';

        // Show report
        PrintTemplateReport('Run Delivery Docket', sSQL, not chkPreviewInvoices.Checked, 1);

        // Disable these settings.
        fbReportSQLSupplied := false;
        fbTemplateUsesNonFormConnection := false;
        sDeliveryDocket := FastFuncs.IntToStr(iClientID) + '-' + memDespatchLines.FieldByName('ContactID').AsString + '-' +
          memDespatchLines.FieldByName('DespatchID').AsString;
      end;

      // Save Delivery Docket ID
      memDespatchLines.Edit;
      memDespatchLines.FieldByName('DeliveryDocket').AsString := sDeliveryDocket;
      memDespatchLines.Post;
    end;

    // Fetch next record.
    memDespatchLines.Next;
  end;

  // Return to our current position.
  memDespatchLines.Locate('ID', iRecID, [loCaseInsensitive]);

  // Enable all binded data aware controls.
  memDespatchLines.EnableControls;
  fbInitialisingRun := false;
end;

procedure TfrmRunDespatchGUI.PopulateDDTemporaryTable(const iClientID, iContactID: integer);
var
  qry: TMyQuery;
  sPhysical, sBillTo, sDeliveryNotes, sFreqType, sCoyShipTo: string;
  sCompany, sClientName: string;
  iSequence, iFreqInterval: integer;
  dDepositHeld, dOutstanding, dTotalInc: double;
  dtDate: TDateTime;
  oARInfo: TAR_ClientInfo;
begin
  memCopy.Filtered := false;
  memCopy.Filter := 'ClientID = ' + FastFuncs.IntToStr(iClientID) + ' AND ContactID = ' + FastFuncs.IntToStr(iContactID);
  memCopy.Filtered := true;
  if memCopy.RecordCount = 0 then begin
    memCopy.Filtered := false;
    Exit;
  end;

  qry := TMyQuery.Create(nil);

  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM `' + oMyDelivery.GetDDTemporaryTableName + '` LIMIT 0;');
    qry.Open;

    if lblReschedule.Visible then begin
      if RescheduleDate.Date = 0 then begin
        dtDate := qryRuns.FieldByName('RescheduleDate').AsDateTime;
      end else begin
        dtDate := RescheduleDate.Date;
      end;
    end else begin
      dtDate := qryRuns.FieldByName('RunDate').AsDateTime;
    end;

    sCoyShipTo := oMyDelivery.GetInternalCompanyShipToAddress;
    memCopy.First;
    dTotalInc := 0;
    while not memCopy.Eof do begin
      dTotalInc := dTotalInc + memCopy.FieldByName('TakenValue').AsFloat;
      memCopy.Next;
    end;

    memCopy.First;
    oARInfo := oTransactions.Get_AR_ClientInfo(dtRunDate.DateTime, memCopy.FieldByName('ClientID').AsInteger, false);
    while not memCopy.Eof do begin
      // Fetch our required static info for this client.
      sPhysical := GetPhysicalAddress(iClientID);
      sBillTo := GetShippingAddress(iClientID);
      sCompany := memCopy.FieldByName('Company').AsString;
      sClientName := memCopy.FieldByName('ClientName').AsString;
      sDeliveryNotes := oMyDelivery.GetClientDeliveryNotes(iClientID);
      iSequence := memCopy.FieldByName('Sequence').AsInteger;
      iFreqInterval := memCopy.FieldByName('FreqInterval').AsInteger;
      sFreqType := memCopy.FieldByName('FreqType').AsString;
      dDepositHeld := oMyDelivery.GetClientDepositsHeld(iClientID);
      dOutstanding := oMyDelivery.GetTotalTrackedNotReturned(iClientID, dtDate, dtRunDate.DateTime);

      // Build Record
      qry.Insert;
      qry.FieldByName('Company').AsString := sCompany;
      qry.FieldByName('ClientName').AsString := sClientName;
      qry.FieldByName('BillTo').AsString := sPhysical;
      qry.FieldByName('DeliveryTo').AsString := sBillTo;
      qry.FieldByName('CompanyDetails').AsString := sCoyShipTo;
      qry.FieldByName('DeliveryNotes').AsString := sDeliveryNotes;
      qry.FieldByName('FreqType').AsString := sFreqType;
      qry.FieldByName('FreqInterval').AsInteger := iFreqInterval;
      qry.FieldByName('Sequence').AsInteger := iSequence;
      qry.FieldByName('DepositHeld').AsFloat := dDepositHeld;
      qry.FieldByName('BottlesHeld').AsInteger := Floor(dOutstanding);
      qry.FieldByName('LastDelivery').AsVariant := memCopy.FieldByName('LastDelivery').AsVariant;
      qry.FieldByName('Product').AsString := memCopy.FieldByName('ProductName').AsString;
      qry.FieldByName('Qty').AsFloat := memCopy.FieldByName('TakenQty').AsFloat;
      qry.FieldByName('LineTotal').AsFloat := memCopy.FieldByName('TakenValue').AsFloat;
      qry.FieldByName('DeliveryDate').AsDateTime := dtDate;

      // Are we using history values.
      if AppEnv.CompanyPrefs.UseHistoryOnDespatchRuns then begin
        qry.FieldByName('HistoryQty1').AsInteger := memCopy.FieldByName('HistoryQty1').AsInteger;
        qry.FieldByName('HistoryQty2').AsInteger := memCopy.FieldByName('HistoryQty2').AsInteger;
        qry.FieldByName('HistoryQty3').AsInteger := memCopy.FieldByName('HistoryQty3').AsInteger;
      end else begin
        qry.FieldByName('HistoryQty1').AsVariant := NULL;
        qry.FieldByName('HistoryQty2').AsVariant := NULL;
        qry.FieldByName('HistoryQty3').AsVariant := NULL;
      end;

      qry.FieldByName('WithinTerms').AsFloat := oARInfo._WithinTerms;
      qry.FieldByName('Upto30Days').AsFloat := oARInfo._1to30Days;
      qry.FieldByName('From30to60Days').AsFloat := oARInfo._30to60Days;
      qry.FieldByName('From60to90Days').AsFloat := oARInfo._60to90Days;
      qry.FieldByName('Over90Days').AsFloat := oARInfo._Over90Days;
      qry.FieldByName('Docket Number').AsString := FastFuncs.IntToStr(iClientID) + '-' +
        memCopy.FieldByName('ContactID').AsString + '-' + qryRuns.FieldByName('DespatchID').AsString;

      if memCopy.FieldByName('TakenQty').AsFloat > 1 then begin
        qry.FieldByName('Amount').AsFloat := memCopy.FieldByName('TakenValue').AsFloat /
          memCopy.FieldByName('TakenQty').AsFloat;
      end else begin
        qry.FieldByName('Amount').AsFloat := memCopy.FieldByName('TakenValue').AsFloat
      end;

      qry.FieldByName('Outstanding Amount').AsFloat := oARInfo._OutstandingAmount + dTotalInc;

      // Post Record to our temporary table.
      qry.Post;

      // Fetch next record.
      memCopy.Next;
    end;

  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
    memCopy.Filtered := false;
  end;
end;

procedure TfrmRunDespatchGUI.btnDriverReportsClick(Sender: TObject);
var
  sSQL, sRunDate, sDate: string;
  iRecID, iClientID: integer;
  qry: TMyQuery;
begin
  inherited;
  try
    // Check for Customer Product Duplicates.
    if not IsRunOk then begin
      Exit;
    end;

    // Save the run details to our database backend.
    SaveDespatchRun;
    if (MyConnection.intransaction) then begin
      // Commit Transaction.
      CommitTransaction;
    end;

    if qryRuns.FieldByName('Rescheduled').AsBoolean then begin
      sDate := DateToStr(qryRuns.FieldByName('RescheduleDate').AsDateTime);
    end else begin
      sDate := DateToStr(qryRuns.FieldByName('RunDate').AsDateTime);
    end;

    // Show Report.
    fbReportSQLSupplied := true;
    sSQL := 'SELECT DR.RunName AS "Run Name", ';
    sSQL := sSQL + QuotedStr(sDate) + ' AS "Run Date", ';
    sSQL := sSQL + 'DR.Operator, ';
    sSQL := sSQL + 'DRL.ProductName AS "Product Name", P.PARTSDESCRIPTION AS "Description", ';
    sSQL := sSQL + 'Sum(DRL.OrderQty) AS Qty ';
    sSQL := sSQL + 'FROM tbldespatchruns AS DR ';
    sSQL := sSQL + 'INNER JOIN tbldespatchrunlines AS DRL on DR.DespatchID = DRL.DespatchID ';
    sSQL := sSQL + 'INNER JOIN tblparts AS P on DRL.ProductID = P.PartsID ';
    sSQL := sSQL + 'WHERE DR.DespatchID = ' + qryRuns.FieldByName('DespatchID').AsString + ' ';
    sSQL := sSQL + 'GROUP BY DRL.ProductName ';
    sSQL := sSQL + 'ORDER BY DRL.ProductName;';
    PrintTemplateReport('Order Production List', sSQL, not chkPreviewInvoices.Checked, 1);
    fbReportSQLSupplied := false;

  except 
  end;

  oMyDelivery.DeleteSOTemporaryTableContents;

  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM `' + oMyDelivery.GetSOTemporaryTableName + '`;');
    memDespatchLines.SaveToDataSet(qry, []);
    qry.Close;

    fbReportSQLSupplied := true;
    if qryRuns.FieldByName('Rescheduled').AsBoolean then begin
      sRunDate := DateToStr(qryRuns.FieldByName('RescheduleDate').AsDateTime);
    end else begin
      sRunDate := DateToStr(qryRuns.FieldByName('RunDate').AsDateTime);
    end;

    sSQL := 'SELECT *, DR.RunName AS "Run Name", DR.Operator, ' + QuotedStr(sRunDate) +
      ' AS "Run Date" FROM `' + oMyDelivery.GetSOTemporaryTableName + '` AS TSO ';
    sSQL := sSQL + 'INNER JOIN tbldespatchruns AS DR on DR.DespatchID = TSO.DespatchID';
    PrintTemplateReport('Standing Order Run Summary', sSQL, not chkPreviewInvoices.Checked, 1);
    fbReportSQLSupplied := false;

    fbInitialisingRun := true;
    iRecID := memDespatchLines.FieldByName('ID').AsInteger;
    // Ensure sorting has been disabled.
    memCopy.SortFields := '';
    memCopy.Sort([]);

    // Get original copy of run list.
    memCopy.LoadFromDataSet(memDespatchLines, []);

    // Disable all binded data aware controls.
    memDespatchLines.DisableControls;

    // Goto our first record.
    iClientID := 0;
    memDespatchLines.First;

    // Perform our Batch Update on Accounts Receivable.
    oTransactions.Get_AR_ClientInfo(dtRunDate.DateTime, 0, true);

    // Process clients.
    while not memDespatchLines.Eof do begin
      if iClientID <> memDespatchLines.FieldByName('ClientID').AsInteger then begin
        iClientID := memDespatchLines.FieldByName('ClientID').AsInteger;
        // Delete the contents within our temporary table.
        oMyDelivery.DeleteDDTemporaryTableContents;

        Application.ProcessMessages;
        // Populate our temporary table.
        PopulateDDTemporaryTable(iClientID, memDespatchLines.FieldByName('ContactID').AsInteger);

        // Inform BaseInput that we are supplying SQL for our report.
        fbReportSQLSupplied := true;

        // Since the main connection to this temporary table is non transaction
        // then we need to set this next flag in BaseInput so it can see our table.
        fbTemplateUsesNonFormConnection := true;

        // Set our SQL that we will use for this report.
        sSQL := 'SELECT * FROM `' + oMyDelivery.GetDDTemporaryTableName + '` ORDER BY Product;';

        // Show report
        PrintTemplateReport('Run Delivery Docket', sSQL, not chkPreviewInvoices.Checked, 1);

        // Disable these settings.
        fbReportSQLSupplied := false;
        fbTemplateUsesNonFormConnection := false;
      end;

      // Fetch next record.
      memDespatchLines.Next;
    end;

    // Return to our current position.
    memDespatchLines.Locate('ID', iRecID, [loCaseInsensitive]);

    // Enable all binded data aware controls.
    memDespatchLines.EnableControls;
    fbInitialisingRun := false;

  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
    AutoCreateMode := false;
  end;

  // Return to transaction mode.
  if not (MyConnection.intransaction) then begin
    // Put our Database Connection into transaction mode.
    BeginTransaction;
  end;
end;

procedure TfrmRunDespatchGUI.cboCustomerCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  qry, qryParts, qryCompulsoryProducts: TMyQuery;
  iCount, iSequence, iFoundSeq, iRecNo: integer;
  sContactName: string;
  bContactBased: boolean;
begin
  if not Modified then Exit;
  inherited;
  // If the drop down contains nothing then exit.
  if cboCustomer.Text = '' then Exit;

  // Was the same customer selected as already present?
  if memDespatchLines.FieldByName('ClientID').AsInteger = qryCustomer.FieldByName('ClientID').AsInteger then begin
    // Yes, then out we go.
    Exit;
  end;

  // First we must check to see if this customer
  // is already assigned to another run.
  iRecNo := memDespatchLines.FieldByName('ID').AsInteger;

  sContactName := cboCustomer.Text;

  if AppEnv.CompanyPrefs.OneRunPerCustomer then begin
    if IsCustomerOnRun(qryCustomer.FieldByName('ClientID').AsInteger, qryRuns.FieldByName('RunID').AsInteger) then begin
      CommonLib.MessageDlgXP_Vista('It appears that the selected contact [ ' + qryCustomer.FieldByName('Customer').AsString +
        ' ] already exists within another run.', mtWarning, [mbOK], 0);
      // Cancel entry.
      memDespatchLines.Cancel;
      // Enable all data aware controls that relate to our memory Run Lines.
      memDespatchLines.EnableControls;
      Exit;
    end;
  end;
  
  if (memDespatchLines.FieldByName('Sequence').AsInteger <> 0) then begin
    if ((qryCustomer.FieldByName('ClientID').AsInteger <> 0) and
      (qryCustomer.FieldByName('ClientID').AsInteger <> memDespatchLines.FieldByName('ClientID').AsInteger)) then begin
      fbInitialisingRun := true;
      oMyDelivery.SetNewCustomerAgainstSequenceID(memDespatchLines, memDespatchLines.FieldByName('Sequence').AsInteger,
        qryCustomer);
      fbInitialisingRun := false;
      memDespatchLines.Locate('ID', iRecNo, [loCaseInsensitive]);
      memDespatchLines.Edit;
      Exit;
    end;
  end;

  ////////////////////////////////////////////////
  // Now we need to determine if this customer
  // has any special products.  If they do, we
  // must load them into the memory table.  This
  // will save the user time in data entry.
  ////////////////////////////////////////////////
  qry := TMyQuery.Create(nil);
  qryParts := TMyQuery.Create(nil);
  qryCompulsoryProducts := TMyQuery.Create(nil);
  try
    // Setup query to locate any compulsory products.
    qryCompulsoryProducts.Connection := CommonDbLib.GetSharedMyDacConnection;

    // Setup query to locate any related special products for this client.
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT CustomerLinesID, ProductID, Name FROM tblcustomerlines WHERE CustomerID = :xCustID AND IncludeInRun = "T";');
    qry.Params.ParamByName('xCustID').AsInteger := qryCustomer.FieldByName('ClientID').AsInteger;
    qry.Open;

    // Setup our parts query.
    qryParts.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryParts.ParamCheck := true;
    qryParts.SQL.Clear;
    qryParts.SQL.Add('SELECT PartsID, TaxCode FROM tblparts WHERE (PartsID = :xPartID);');

    // If the customer is already assigned to a sequence ID, then fetch its value.
    iFoundSeq := oMyDelivery.DoesCustomerHaveSequenceNumber(qryCustomer.FieldByName('ClientID').AsInteger, memDespatchLines);

    //////////////////////////////////////////////////////////////////////////
    // Here we have to relocate our position within the dataset
    // because the call to DoesCustomerHaveSeqeunceNumber() copies the memory
    // table and results the loss of position.
    //////////////////////////////////////////////////////////////////////////
    if memDespatchLines.Locate('ID', iRecNo, [loCaseInsensitive]) then begin
      memDespatchLines.Edit;
    end;

    Application.ProcessMessages;
    memDespatchLines.DisableControls;

    // Does the selected customer have an assigned sequence number?
    if iFoundSeq = 0 then begin
      // No! Get next sequence number.
      iSequence := oMyDelivery.GetNextSequenceNumber(memDespatchLines);
      bContactBased := false;
    end else begin
      // Yes! Then this customer will use this assigned sequence number.
      iSequence := iFoundSeq;
      if oMyDelivery.DoesCustomerHaveSequenceNumber(qryCustomer.FieldByName('ClientID').AsInteger,
        sContactName, memDespatchLines) then begin
        bContactBased := true;
      end else begin
        bContactBased := false;
      end;
    end;

    //////////////////////////////////////////////////////////////////////////
    // Any Compulsory products?
    //////////////////////////////////////////////////////////////////////////
    qryCompulsoryProducts.SQL.Clear;
    qryCompulsoryProducts.SQL.Add('SELECT * FROM tbldefaultrunparts ORDER BY ProductName;');
    qryCompulsoryProducts.Open;

    // State that we are initialising run.
    iCount := 0;
    fbInitialisingRun := true;

    if not chkSingleLines.Checked then begin
      //////////////////////////////////////////////////////////////////////////
      // If the client has not been entered before and we have compulsory products
      // then please auto load them in.
      //////////////////////////////////////////////////////////////////////////
      if (qryCompulsoryProducts.RecordCount > 0) and (not (bContactBased)) then begin
        while not qryCompulsoryProducts.Eof do begin
          // Is this the first entry?
          if iCount = 0 then begin
            // Yes! Put this run line into edit mode.
            FillTable.Edit;
          end else begin
            // No! Then create us a new run line.
            FillTable.Insert;
          end;

          FillTable.FieldByName('ClientID').AsInteger := qryCustomer.FieldByName('ClientID').AsInteger;
          if qryCustomer.FieldByName('Details').AsInteger = 0 then begin
            FillTable.FieldByName('IsContact').AsString := 'F';
          end else begin
            FillTable.FieldByName('IsContact').AsString := 'T';
            FillTable.FieldByName('ContactID').AsInteger := qryCustomer.FieldByName('ContactID').AsInteger;
          end;

          FillTable.FieldByName('ClientName').AsString := qryCustomer.FieldByName('Customer').AsString;
          FillTable.FieldByName('Company').AsString := qryCustomer.FieldByName('Company').AsString;
          FillTable.FieldByName('DespatchID').AsInteger := qryRuns.FieldByName('DespatchID').AsInteger;
          FillTable.FieldByName('TaxCode').AsString := qryCompulsoryProducts.FieldByName('TaxCode').AsString;
          FillTable.FieldByName('OrderQty').AsFloat := qryCompulsoryProducts.FieldByName('Qty').AsFloat;
          FillTable.FieldByName('TakenQty').AsFloat := qryCompulsoryProducts.FieldByName('Qty').AsFloat;
          FillTable.FieldByName('RunID').AsInteger := qryRuns.FieldByName('RunID').AsInteger;
          FillTable.FieldByName('StartDate').AsDateTime := dtRunDate.DateTime;
          FillTable.FieldByName('Payments').AsFloat := 0;
          FillTable.FieldByName('Deposits').AsFloat := 0;
          FillTable.FieldByName('ReturnQty').AsFloat := 0;
          FillTable.FieldByName('Sequence').AsInteger := iSequence;
          FillTable.FieldByName('Phone').AsString := qryCustomer.FieldByName('Phone').AsString;
          FillTable.FieldByName('Mobile').AsString := qryCustomer.FieldByName('Mobile').AsString;
          FillTable.FieldByName('Address').AsString := qryCustomer.FieldByName('Address').AsString;
          FillTable.FieldByName('ProductID').AsInteger := qryCompulsoryProducts.FieldByName('ProductID').AsInteger;
          FillTable.FieldByName('ProductName').AsString := qryCompulsoryProducts.FieldByName('ProductName').AsString;
          Inc(iCount);
          qryCompulsoryProducts.Next;
        end;
      end;

      //////////////////////////////////////////////////////////////////////////
      // Any special products?
      //////////////////////////////////////////////////////////////////////////
      if (qry.RecordCount > 0) and (not (bContactBased)) then begin
        // Add all special products.
        while not qry.Eof do begin
          // Is this the first entry?
          if iCount = 0 then begin
            // Yes! Put this run line into edit mode.
            FillTable.Edit;
          end else begin
            // No! Then create us a new run line.
            FillTable.Insert;
          end;

          // Fetch part tax code.
          qryParts.Close;
          qryParts.Params.ParamByName('xPartID').AsInteger := qry.FieldByName('ProductID').AsInteger;
          qryParts.Open;

          // Write line details to our memory table.
          FillTable.FieldByName('ClientID').AsInteger := qryCustomer.FieldByName('ClientID').AsInteger;
          if qryCustomer.FieldByName('Details').AsInteger = 0 then begin
            FillTable.FieldByName('IsContact').AsString := 'F';
            FillTable.FieldByName('ContactID').AsInteger := 0;
          end else begin
            FillTable.FieldByName('IsContact').AsString := 'T';
            FillTable.FieldByName('ContactID').AsInteger := qryCustomer.FieldByName('ContactID').AsInteger;
          end;

          FillTable.FieldByName('ClientName').AsString := qryCustomer.FieldByName('Customer').AsString;
          FillTable.FieldByName('Company').AsString := qryCustomer.FieldByName('Company').AsString;
          FillTable.FieldByName('TaxCode').AsString := qryParts.FieldByName('TaxCode').AsString;
          FillTable.FieldByName('OrderQty').AsFloat := 1;
          FillTable.FieldByName('TakenQty').AsFloat := 1;
          FillTable.FieldByName('DespatchID').AsInteger := qryRuns.FieldByName('DespatchID').AsInteger;
          FillTable.FieldByName('Payments').AsFloat := 0;
          FillTable.FieldByName('Deposits').AsFloat := 0;
          FillTable.FieldByName('ReturnQty').AsFloat := 0;

          FillTable.FieldByName('StartDate').AsDateTime := dtRunDate.DateTime;

          FillTable.FieldByName('RunID').AsInteger := qryRuns.FieldByName('RunID').AsInteger;
          FillTable.FieldByName('Sequence').AsInteger := iSequence;
          FillTable.FieldByName('Phone').AsString := qryCustomer.FieldByName('Phone').AsString;
          FillTable.FieldByName('Mobile').AsString := qryCustomer.FieldByName('Mobile').AsString;
          FillTable.FieldByName('Address').AsString := qryCustomer.FieldByName('Address').AsString;
          FillTable.FieldByName('ProductID').AsInteger := qry.FieldByName('ProductID').AsInteger;
          FillTable.FieldByName('ProductName').AsString := qry.FieldByName('Name').AsString;

          // Post Record
          FillTable.Post;

          Inc(iCount);

          // Fetch next special product
          qry.Next;
        end;

        // State that we have finished initialising the run.
        fbInitialisingRun := false;
      end else begin
        // NO, then perform just an initial setup.
        if FillTable.FieldByName('ClientID').AsInteger = 0 then begin
          FillTable.Edit;
        end else begin
          FillTable.Append;
          FillTable.FieldByName('Company').AsString := sContactName;
          cboCustomer.Text := sContactName;
        end;

        FillTable.FieldByName('DespatchID').AsInteger := qryRuns.FieldByName('DespatchID').AsInteger;
        FillTable.FieldByName('RunID').AsInteger := qryRuns.FieldByName('RunID').AsInteger;
        FillTable.FieldByName('ClientID').AsInteger := qryCustomer.FieldByName('ClientID').AsInteger;
        if qryCustomer.FieldByName('Details').AsInteger = 0 then begin
          FillTable.FieldByName('IsContact').AsString := 'F';
          FillTable.FieldByName('ContactID').AsInteger := 0;
        end else begin
          FillTable.FieldByName('IsContact').AsString := 'T';
          FillTable.FieldByName('ContactID').AsInteger := qryCustomer.FieldByName('ContactID').AsInteger;
        end;

        FillTable.FieldByName('Company').AsString := qryCustomer.FieldByName('Company').AsString;
        FillTable.FieldByName('ClientName').AsString := qryCustomer.FieldByName('Customer').AsString;
        FillTable.FieldByName('Phone').AsString := qryCustomer.FieldByName('Phone').AsString;
        FillTable.FieldByName('Mobile').AsString := qryCustomer.FieldByName('Mobile').AsString;
        FillTable.FieldByName('Address').AsString := qryCustomer.FieldByName('Address').AsString;
        FillTable.FieldByName('Sequence').AsInteger := iSequence;
        FillTable.FieldByName('OrderQty').AsFloat := 1;
        FillTable.FieldByName('TakenQty').AsFloat := 1;
        FillTable.FieldByName('StartDate').AsDateTime := dtRunDate.DateTime;
        FillTable.FieldByName('Payments').AsFloat := 0;
        FillTable.FieldByName('Deposits').AsFloat := 0;
        FillTable.FieldByName('ReturnQty').AsFloat := 0;
        FillTable.Post;
        FillTable.Edit;
        // Refresh the grid display.
        grdRunLines.RefreshDisplay;
      end;
    end else begin
      // NO, then perform just an initial setup.
      if FillTable.FieldByName('ClientID').AsInteger = 0 then begin
        FillTable.Edit;
      end else begin
        FillTable.Append;
        FillTable.FieldByName('Company').AsString := sContactName;
        cboCustomer.Text := sContactName;
      end;

      FillTable.FieldByName('DespatchID').AsInteger := qryRuns.FieldByName('DespatchID').AsInteger;
      FillTable.FieldByName('RunID').AsInteger := qryRuns.FieldByName('RunID').AsInteger;
      FillTable.FieldByName('ClientID').AsInteger := qryCustomer.FieldByName('ClientID').AsInteger;
      if qryCustomer.FieldByName('Details').AsInteger = 0 then begin
        FillTable.FieldByName('IsContact').AsString := 'F';
        FillTable.FieldByName('ContactID').AsInteger := 0;
      end else begin
        FillTable.FieldByName('IsContact').AsString := 'T';
        FillTable.FieldByName('ContactID').AsInteger := qryCustomer.FieldByName('ContactID').AsInteger;
      end;

      FillTable.FieldByName('Company').AsString := qryCustomer.FieldByName('Company').AsString;
      FillTable.FieldByName('ClientName').AsString := qryCustomer.FieldByName('Customer').AsString;
      FillTable.FieldByName('Phone').AsString := qryCustomer.FieldByName('Phone').AsString;
      FillTable.FieldByName('Mobile').AsString := qryCustomer.FieldByName('Mobile').AsString;
      FillTable.FieldByName('Address').AsString := qryCustomer.FieldByName('Address').AsString;
      FillTable.FieldByName('Sequence').AsInteger := iSequence;
      FillTable.FieldByName('OrderQty').AsFloat := 1;
      FillTable.FieldByName('TakenQty').AsFloat := 1;
      FillTable.FieldByName('StartDate').AsDateTime := dtRunDate.DateTime;
      FillTable.FieldByName('Payments').AsFloat := 0;
      FillTable.FieldByName('Deposits').AsFloat := 0;
      FillTable.FieldByName('ReturnQty').AsFloat := 0;
      FillTable.Post;
      FillTable.Edit;
      // Refresh the grid display.
      grdRunLines.RefreshDisplay;
    end;

    // Request a resequence on a sequence change.
    fbInitialisingRun := false;

    // State that the data has changed.
    memDespatchLines.EnableControls;
    bDataChanged := true;

  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(qryCompulsoryProducts) then
      FreeandNil(qryCompulsoryProducts);
  end;
end;

procedure TfrmRunDespatchGUI.cboPartsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  dIncPrice, dPriceEx, dDiscount, dQty, dTax: double;
  sDescript, sMsg: string;
begin
  if not Modified then Exit;
  inherited;
  // If there was no part selected then exit.
  if cboParts.Text = '' then Exit;

  FillTable.Edit;
  FillTable.FieldByName('ProductID').AsInteger := LookupTable.FieldByName('PARTSID').AsInteger;
  FillTable.FieldByName('TaxCode').AsString := LookupTable.FieldByName('TaxCode').AsString;
  FillTable.FieldByName('PreferedSupp').AsString := LookupTable.FieldByName('PreferedSupp').AsString;

  // Calculate me an ex price on the selected product.
  oMyDelivery.oClientDiscount.ClientPrice_Discounts(memDespatchLines.FieldByName('ClientID').AsInteger, 0,
    LookupTable.FieldByName('PartsID').AsInteger, AppEnv.DefaultClass.ClassID,
    memDespatchLines.FieldByName('TakenQty').AsFloat, Date(), 1, '', '', '', '', '',
    false, dPriceEx, dDiscount, sDescript, sMsg);

  // Ex price is original ex part price - discount.
  FillTable.FieldByName('Discount').AsFloat := dDiscount;
  FillTable.FieldByName('OriginalExPrice').AsFloat := dPriceEx;
  dPriceEx := dPriceEx - (dPriceEx * dDiscount);

  // Store
  FillTable.FieldByName('UnitExPrice').AsFloat := dPriceEx;

  // Get Inclusive price.
  dIncPrice := GetAmountInc(dPriceEx, GetTaxRate(LookupTable.FieldByName('TaxCode').AsString));

  // Store tax amount.
  dQty := FillTable.FieldByName('TakenQty').AsFloat;

  // Calculate now the tax amount if any.
  dTax := (dIncPrice - dPriceEx) * dQty;
  FillTable.FieldByName('TaxAmount').AsFloat := dTax;

  dIncPrice := dIncPrice * dQty;

  // Calculate and store order value as inclusive.
  FillTable.FieldByName('OrderValue').AsFloat := RoundCurrency(dIncPrice);
  FillTable.FieldByName('TakenValue').AsFloat := RoundCurrency(dIncPrice);

  // State that the data has changed.
  bDataChanged := true;
end;

procedure TfrmRunDespatchGUI.grdRunlinesTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  inherited;
  if AFieldName = 'Company' then begin
    bShowingContact        := bShowingContact xor true;
    cboCustomer.AutoSelect := false;
    if bShowingContact then begin
      grdRunLines.ColumnByName('Company').DisplayLabel := 'Contact';
      cboCustomer.Selected.Clear;
      cboCustomer.Selected.Add('Customer' + #9 + '25' + #9 + 'Contact'#9'T' + #9);
      cboCustomer.Selected.Add('Company' + #9 + '25' + #9 + 'Company'#9'T' + #9);
      cboCustomer.Selected.Add('Type' + #9 + '15' + #9 + 'Type'#9'T' + #9);
      cboCustomer.Selected.Add('Address' + #9 + '35' + #9 + 'Address'#9'T' + #9);
    end else begin
      grdRunLines.ColumnByName('Company').DisplayLabel := 'Company';
      cboCustomer.Selected.Clear;
      cboCustomer.Selected.Add('Company' + #9 + '25' + #9 + 'Company'#9'T' + #9);
      cboCustomer.Selected.Add('Customer' + #9 + '25' + #9 + 'Contact'#9'T' + #9);
      cboCustomer.Selected.Add('Type' + #9 + '15' + #9 + 'Type'#9'T' + #9);
      cboCustomer.Selected.Add('Address' + #9 + '35' + #9 + 'Address'#9'T' + #9);
    end;

    // Refresh Query.
    RefreshClientList;
    cboCustomer.AutoSelect := true;
  end;
end;

procedure TfrmRunDespatchGUI.grdRunlinesCalcTitleAttributes(Sender: TObject; AFieldName: string;
  AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;
  if AFieldName = 'Company' then begin
    ABrush.Color := clBtnFace;
  end;
end;

procedure TfrmRunDespatchGUI.RefreshClientList;
var
  iClientID: integer;
begin
  // Are we to order by contact or company.
  iClientID := 0;
  if qryCustomer.Active then begin
    iClientID := qryCustomer.FieldByName('ClientID').AsInteger;
  end;

  qryCustomer.DisableControls;
  qryCustomer.Close;
  qryCustomer.SQL.Clear;
  qryCustomer.SQL.Add('SELECT');
  qryCustomer.SQL.Add('0 AS "Details",');
  qryCustomer.SQL.Add('IF(C.IsJob="T", "Customer Job", "Customer") AS Type,');
  qryCustomer.SQL.Add('C.ClientID, C.Company, TRIM(CONCAT_WS(" ", IF(ISNULL(C.Title), "", C.Title), C.Firstname, C.LastName)) AS "Customer",');
  qryCustomer.SQL.Add('TRIM(LEFT(CONCAT_WS(" ", C.Street, IF(ISNULL(Street2), "", Street2), IF(ISNULL(Suburb), "", Suburb),');
  qryCustomer.SQL.Add('IF(ISNULL(State), "", C.State), IF(ISNULL(Postcode), "", Postcode),');
  qryCustomer.SQL.Add('IF(ISNULL(Country), "", C.Country)), 200)) AS Address, C.Phone, C.FaxNumber AS Fax, Mobile, 0 AS "ContactID"');
  qryCustomer.SQL.Add('FROM tblclients AS C');
  qryCustomer.SQL.Add('WHERE (Active = "T" AND Customer = "T" AND Company NOT LIKE "Table%")');

  qryCustomer.SQL.Add('UNION ALL');

  qryCustomer.SQL.Add('SELECT');
  qryCustomer.SQL.Add('1,');
  qryCustomer.SQL.Add('"Contact" AS Type,');
  qryCustomer.SQL.Add('C.CusID, C.Company, TRIM(CONCAT_WS(" ", IF(ISNULL(C.ContactTitle), "", C.ContactTitle), C.ContactFirstname, C.ContactSurName)),');
  qryCustomer.SQL.Add('TRIM(LEFT(CONCAT_WS(" ", C.ContactAddress, IF(ISNULL(ContactAddress2), "", ContactAddress2),');
  qryCustomer.SQL.Add('IF(ISNULL(ContactCity), "", ContactCity),');
  qryCustomer.SQL.Add('IF(ISNULL(ContactState), "", C.ContactState), IF(ISNULL(ContactPcode), "", ContactPcode)), 200)) AS Address,');
  qryCustomer.SQL.Add('C.ContactPh, C.ContactFax, ContactMob AS "Mobile", C.ContactID');
  qryCustomer.SQL.Add('FROM tblcontacts AS C');
  qryCustomer.SQL.Add
  ('WHERE (C.Active = "T" AND C.UseOnRun="T" AND C.ContactIsCustomer="F" AND C.ContactIsJob="F" AND C.ContactIsSupplier="F" AND C.ContactIsOtherContact="F")');

  if bShowingContact then begin
    // Ordering by contact / client name.
    qryCustomer.SQL.Add('ORDER BY Customer;');
  end else begin
    // Otherwise we need to order by Company
    qryCustomer.SQL.Add('ORDER BY Company;');
  end;

  // Open our customer list.
  qryCustomer.Open;
  if iClientID <> 0 then begin
    // Repoint to our selected customer.
    if not qryCustomer.Locate('ClientID', iClientID, [loCaseInsensitive]) then begin
      // If failed to relocate, goto first record.
      qryCustomer.First;
    end;
  end else begin
    // Set to first record.
    qryCustomer.First;
  end;

  // Re enable all data aware controls.
  qryCustomer.EnableControls;
end;

procedure TfrmRunDespatchGUI.chkShowCompanyClick(Sender: TObject);
begin
  inherited;
  AppEnv.Employee.ShowCompanyAsDefaultOnRun := chkShowCompany.Checked;
end;

procedure TfrmRunDespatchGUI.memDespatchLinesSequenceChange(Sender: TField);
begin
  inherited;
  if fbInitialisingRun then Exit;
  if memDespatchLines.FieldByName('ProductID').AsInteger = 0 then begin
    Exit;
  end;

  fbInitialisingRun := true;
  memDespatchLines.DisableControls;
  UpdateClientSequence(CurrentSequenceNumber, Sender.AsInteger);

  Application.ProcessMessages;
  CurrentSequenceNumber := Sender.AsInteger;

  fbRequestRelocate := true;
  tmrTrigger.Enabled := true;
  fbInitialisingRun := false;

  // State that the data has changed.
  bDataChanged := true;
end;

procedure TfrmRunDespatchGUI.UpdateClientSequence(const iOldSequence, iNewSequence: integer);
var
  iCount, iX: integer;
begin
  // Ensure sorting has been disabled.
  memCopy.SortFields := '';
  memCopy.Sort([]);

  // Get original copy of run list.
  memCopy.LoadFromDataSet(memDespatchLines, []);
  memCopy.Filtered := false;
  memCopy.Filter := 'Sequence = ' + QuotedStr(FastFuncs.IntToStr(iOldSequence));
  memCopy.Filtered := true;

  // Update all entries with same sequence to match new sequence value.
  memCopy.First;
  iCount := memCopy.RecordCount;
  for iX := 1 to iCount do begin
    memCopy.Edit;
    memCopy.FieldByName('Sequence').AsInteger := iNewSequence;
    memCopy.Post;
    memCopy.Next;
  end;

  // Return results and clean up.
  memCopy.Filtered := false;
  memDespatchLines.LoadFromDataSet(memCopy, []);
  memDespatchLines.Refresh;
  memDespatchLines.Edit;

  fbInitialisingRun := false;
end;

procedure TfrmRunDespatchGUI.btnReorderClick(Sender: TObject);
begin
  inherited;
  // State that we are initialising, prevent Field OnChange events from firing.
  fbInitialisingRun := true;
  memDespatchLines.DisableControls;

  // Grab a full copy of our data entry lines.
  memCopy.LoadFromDataSet(memDespatchLines, []);

  // Sort the copy by Sequence, then by client name.
  memCopy.SortFields := 'Sequence;ClientName';
  memCopy.Sort([]);

  // Save our reordered list back to our data entry lines.
  memDespatchLines.EnableIndexes := false;
  memDespatchLines.LoadFromDataSet(memCopy, []); //mtcpoFieldIndex
  memDespatchLines.EnableIndexes := true;
  memDespatchLines.EnableControls;
  fbInitialisingRun := false;
end;

procedure TfrmRunDespatchGUI.btnRenumberClick(Sender: TObject);
var
  iSeq: integer;
  iCurrentClientID: integer;
  bm: TBookmark;
begin
  fbInitialisingRun := true;
  bm := memDespatchLines.GetBookmark;
  memDespatchLines.DisableControls;
  memCopy.LoadFromDataSet(memDespatchLines, []);
  memCopy.SortFields := 'Sequence;ClientID';
  memCopy.Sort([]);
  memDespatchLines.LoadFromDataSet(memCopy, []); //mtcpoFieldIndex
  iSeq := 1;
  memDespatchLines.First;
  iCurrentClientID := memDespatchLines.FieldByName('ClientID').AsInteger;

  while not memDespatchLines.Eof do begin
    memDespatchLines.Edit;
    memDespatchLines.FieldByName('Sequence').AsInteger := iSeq;

    memDespatchLines.Post;
    memDespatchLines.Next;
    if iCurrentClientID <> memDespatchLines.FieldByName('ClientID').AsInteger then begin
      if iSeq = 1 then Inc(iSeq, 9)
      else Inc(iSeq, 10);

      iCurrentClientID := memDespatchLines.FieldByName('ClientID').AsInteger;
    end;
  end;

  // State that resequencing has finished.
  memDespatchLines.EnableControls;
  fbInitialisingRun := false;
  if memDespatchLines.BookmarkValid(bm) then begin
    memDespatchLines.GotoBookmark(bm);
    memDespatchLines.FreeBookmark(bm);
  end;
end;

procedure TfrmRunDespatchGUI.btnResequenceClick(Sender: TObject);
begin
  inherited;
  // Send Resequence Message.
  fbInitialisingRun := true;
  PostMessage(Self.Handle, WM_RESEQUENCE, 0, 0);
end;

procedure TfrmRunDespatchGUI.PerformResequence(var Msg: TMessage);
var
  iSeq: integer;
  iCurrentClientID: integer;
  iRecID: integer;
begin
  iRecID := memDespatchLines.FieldByName('ID').AsInteger;
  memDespatchLines.DisableControls;
  memCopy.LoadFromDataSet(memDespatchLines, []);
  memCopy.SortFields := 'Sequence;ClientID';
  memCopy.Sort([]);
  memDespatchLines.LoadFromDataSet(memCopy, []); //mtcpoFieldIndex

  memDespatchLines.First;
  iCurrentClientID := memDespatchLines.FieldByName('ClientID').AsInteger;
  iSeq := 1;
  while not memDespatchLines.Eof do begin
    memDespatchLines.Edit;
    memDespatchLines.FieldByName('Sequence').AsInteger := iSeq;
    memDespatchLines.Post;
    memDespatchLines.Next;
    if iCurrentClientID <> memDespatchLines.FieldByName('ClientID').AsInteger then begin
      Inc(iSeq, 1);
      iCurrentClientID := memDespatchLines.FieldByName('ClientID').AsInteger;
    end;
  end;

  // State that resequencing has finished.
  memDespatchLines.EnableControls;
  memDespatchLines.Locate('ID', iRecID, [loCaseInsensitive]);
  fbInitialisingRun := false;
end;

procedure TfrmRunDespatchGUI.memDespatchLinesReferenceChange(Sender: TField);
begin
  inherited;
  if fbInitialisingRun then Exit;
  memDespatchLines.DisableControls;
  CurrentRecordNumber := memDespatchLines.FieldByName('ID').AsInteger;
  UpdateReference(Sender.AsString, memDespatchLines.FieldByName('ClientID').AsInteger,
    memDespatchLines.FieldByName('ContactID').AsInteger);
  fbRequestRelocate := true;
  tmrTrigger.Enabled := true;
  Application.ProcessMessages;
  CalcTotals;
end;

procedure TfrmRunDespatchGUI.UpdateReference(const sNewReference: string; const iClientID, iContactID: integer);
begin
  // State that we are initialising our run.
  fbInitialisingRun := true;

  // Disable all binded data-aware controls.
  memDespatchLines.DisableControls;

  // Ensure sorting has been disabled.
  memCopy.SortFields := '';
  memCopy.Sort([]);

  // Get original copy of run list.
  memCopy.LoadFromDataSet(memDespatchLines, []);

  // Update all entries with same sequence to match new sequence value.
  memCopy.First;
  while not memCopy.Eof do begin
    if (memCopy.FieldByName('ClientID').AsInteger = iClientID) and
      (memCopy.FieldByName('ContactID').AsInteger = iContactID) then begin
      memCopy.Edit;
      // Copy new reference text to this record.
      memCopy.FieldByName('Reference').AsString := sNewReference;
      memCopy.Post;
    end;
    // Fetch next record.
    memCopy.Next;
  end;

  // Return changes and cleanup.
  memDespatchLines.LoadFromDataSet(memCopy, []);
  memDespatchLines.EnableControls;
  memDespatchLines.Edit;

  // End of run initialisation.
  fbInitialisingRun := false;
end;

procedure TfrmRunDespatchGUI.BlockFields;
begin
  memDespatchLines.FieldByName('IsContact').Visible := false;
  memDespatchLines.FieldByName('DeliveryDocket').Visible := false;
  memDespatchLines.FieldByName('ContactID').Visible := false;
  if not AppEnv.CompanyPrefs.UseHistoryOnDespatchRuns then begin
    memDespatchLines.FieldByName('HistoryQty1').Visible := false;
    memDespatchLines.FieldByName('HistoryQty2').Visible := false;
    memDespatchLines.FieldByName('HistoryQty3').Visible := false;
  end;
end;

procedure TfrmRunDespatchGUI.txtSearchChange(Sender: TObject);
begin
  inherited;
  if chkShowCompany.Checked then begin
    memDespatchLines.Locate('ClientName', ReplaceStr(ReplaceStr(txtSearch.Text, '%', ''), '*', ''),
      [loCaseInsensitive, loPartialKey]);
  end else begin
    memDespatchLines.Locate('Company', ReplaceStr(ReplaceStr(txtSearch.Text, '%', ''), '*', ''),
      [loCaseInsensitive, loPartialKey]);
  end;
end;

procedure TfrmRunDespatchGUI.btnSetPaymentsClick(Sender: TObject);
var
  iRecID: integer;
begin
  fbInitialisingRun := true;
  memDespatchLines.DisableControls;
  iRecID := memDespatchLines.FieldByName('ID').AsInteger;
  memDespatchLines.First;
  while not memDespatchLines.Eof do begin
    memDespatchLInes.Edit;
    memDespatchLines.FieldByName('Payments').AsFloat := memDespatchLines.FieldByName('TakenValue').AsFloat;
    memDespatchLines.Post;
    // Fetch next record.
    memDespatchLines.Next;
  end;

  memDespatchLines.Locate('ID', iRecID, [loCaseInsensitive]);
  memDespatchLines.EnableControls;
  CalcTotals;
  fbInitialisingRun := false;
end;

procedure TfrmRunDespatchGUI.SetPayments1Click(Sender: TObject);
begin
  inherited;
  btnSetPaymentsClick(Sender);
end;

procedure TfrmRunDespatchGUI.memDespatchLinesOrderQtyChange(Sender: TField);
var
  dPrice: double;
  dIncPrice: double;
  //  iResult: Integer;
begin
  if fbInitialisingRun then Exit;
  if bUpdatingTakenValue then Exit;
  bUpdatingTakenValue := true;

  inherited;

  memDespatchLines.Edit;
  if memDespatchLines.FieldByName('OrderQty').AsFloat <> 0 then begin
    dPrice    := memDespatchLines.FieldByName('OrderQty').AsFloat * memDespatchLines.FieldByName('UnitExPrice').AsFloat;
    dIncPrice := GetAmountInc(dPrice, GetTaxRate(memDespatchLines.FieldByName('TaxCode').AsString));
    memDespatchLines.FieldByName('OrderValue').AsFloat := RoundCurrency(dIncPrice);
  end else begin
    memDespatchLines.FieldByName('OrderValue').AsFloat := 0.00;
  end;

  ///////////////////////////////////////////////////////
  // PLEASE DO NOT REMOVE THIS CODE!!!! Daniel - 2/9/2004
  ///////////////////////////////////////////////////////
  //  if memDespatchLines.FieldByName('TakenQty').AsFloat < memDespatchLines.FieldByName('OrderQty').AsFloat then begin
  //     iResult := CommonLib.MessageDlgXP_Vista('The order for ' + memDespatchLines.FieldByName('ClientName').AsString + ' is lower than requested standard order.'+#13#10#13#10+
  //                           'Would you like to reschedule this run date?', mtWarning, [mbOk, mbCancel], 0);
  //     if iResult = mrOk then begin
  //        btnReschedule.Click;
  //     end;
  //  end;
  ///////////////////////////////////////////////////////

  memDespatchLines.Post;
  memDespatchLines.Edit;

  // We are now finished updating.
  bUpdatingTakenValue := false;
end;

procedure TfrmRunDespatchGUI.btnExportClick(Sender: TObject);
var
  slFilter: TStringList;
  wYear, wMonth, wDay: word;
begin
  inherited;
  slFilter := TStringList.Create;
  try
    // Build Filter List.
    oDataSaver.FilterList := slFilter;
    slFilter.Add('ID');
    slFilter.Add('RunID');
    slFilter.Add('DespatchID');
    slFilter.Add('ClientID');
    slFilter.Add('SalesID');
    if not AppEnv.CompanyPrefs.UseHistoryOnDespatchRuns then begin
      slFilter.Add('HistoryQty1');
      slFilter.Add('HistoryQty2');
      slFilter.Add('HistoryQty3');
    end;

    slFilter.Add('PrepaymentID');
    slFilter.Add('ContactID');
    slFilter.Add('ProductID');
    slFilter.Add('PreferedSupp');
    slFilter.Add('PayMethodID');
    slFilter.Add('GlobalRef');

    // Request for a save filename
    DecodeDate(Date, wYear, wMonth, wDay);
    SaveDialog1.FileName := cboRunName.Text + FastFuncs.IntToStr(wDay) + '-' + FastFuncs.IntToStr(wMonth) + '-' + FastFuncs.IntToStr(wYear) + '.csv';
    if SaveDialog1.Execute then begin
      // Save CSV Export File.
      oDataSaver.SaveDatasetToCVS(memDespatchLines, SaveDialog1.FileName);
    end;
  finally
    // Release our used objects.
    if Assigned(slFilter) then
      FreeandNil(slFilter);
  end;
end;

//procedure TfrmRunDespatchGUI.After_GetPreviousSettings;
//begin
//  grdRunlines.ColumnByName('ClientName').ReadOnly := true;
//  grdRunlines.ColumnByName('TaxCode').ReadOnly := true;
//  grdRunlines.ColumnByName('Track').ReadOnly := true;
//
//  if not AppEnv.CompanyPrefs.AutoCorrectPriceDiscountsOnDeliveries then begin
//    grdRunlines.ColumnByName('TakenValue').ReadOnly := false;
//  end;
//end;

procedure TfrmRunDespatchGUI.cboCustomerNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  inherited;
  Accept := false;
end;

procedure TfrmRunDespatchGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  if AutoCreateMode then begin
    CanClose := false;
  end;
end;

function TfrmRunDespatchGUI.IsRunOk: boolean;
var
  memLines: TKbmMemTable;
  memQry: TKbmMemTable;
begin
  Result := true;
  memLines := TKbmMemTable.Create(nil);
  memQry := TKbmMemTable.Create(nil);
  try
    memQry.Filtered := false;
    memQry.Filter   := '';
    memQry.LoadFromDataSet(memDespatchLines, [mtcpoStructure]);
    memLines.LoadFromDataSet(memDespatchLines, [mtcpoStructure]);
    while not memLines.Eof do begin
      memQry.Filtered := false;
      if memLines.FieldByName('IsContact').AsBoolean then begin
        memQry.Filter := 'ClientID = ' + memLines.FieldByName('ClientID').AsString + ' AND ' +
          'ContactID = ' + memLines.FieldByName('ContactID').AsString + ' AND ' + 'ProductID = ' +
          memLines.FieldByName('ProductID').AsString;
      end else begin
        memQry.Filter := 'ClientID = ' + memLines.FieldByName('ClientID').AsString + ' AND ' +
          'ProductID = ' + memLines.FieldByName('ProductID').AsString;
      end;

      memQry.Filtered := true;
      // Has the same product been assigned to this customer?
      if memQry.RecordCount > 1 then begin
        // Yes, Report Duplicate Part Error.
        CommonLib.MessageDlgXP_Vista('It appears that the Customer ' + memLines.FieldByName('ClientName').AsString +
          ' of ' + memLines.FieldByName('Company').AsString + ' has a same product nominated ' +
          'for ordering more than once - Please combine and correct before saving!', mtWarning, [mbOK], 0);

        memQry.Filtered := false;
        Result := false;
        Exit;
      end;

      // Fetch next record.
      memLines.Next;
    end;
  finally
    // Release our used objects.
    if Assigned(memLines) then
      FreeandNil(memLines);
    if Assigned(memQry) then FreeAndNil(memqry);
  end;
end;

procedure TfrmRunDespatchGUI.cboPayMethodOnEnter(Sender: TObject);
begin
  inherited;
  fPreviousPayMethod := cboPayMethod.Text;
end;

initialization
  RegisterClassOnce(TfrmRunDespatchGUI);
  with FormFact do begin
    RegisterMe(TfrmRunDespatchGUI, 'TDespatchRunListGUI_*=DespatchID');
  end;
end.

