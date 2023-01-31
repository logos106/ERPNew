unit frmRun;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, ExtCtrls, DNMPanel, SelectionDialog,
  AppEvnts, DB, Grids, Wwdbigrd, Wwdbgrid, Buttons, DNMSpeedButton, kbmMemTable,
  wwdblook, MemDS, DBAccess, MyAccess, wwdbdatetimepicker, Mask, wwdbedit,
  ActnList, ActnMan,  ProgressDialog, ClientDiscountObj, wwcheckbox,
  DateUtils, Wwdotdot, Wwdbcomb, DeliveryObj, Menus, AdvMenus, MyClasses, DatasetSaver,
  DataState, Shader, dmGUIStylers;

const
  WM_RESEQUENCE = WM_USER + 100;

type
  TfrmRunSequencerGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    cmdOK: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    grdRunlines: TwwDBGrid;
    qryRuns: TMyQuery;
    qryRunLines: TMyQuery;
    dsRuns: TDataSource;
    dsRunLines: TDataSource;
    ActionManager1: TActionManager;
    cboCustomer: TwwDBLookupCombo;
    qryRunLinesID: TAutoIncField;
    qryRunLinesRunID: TIntegerField;
    qryRunLinesClientID: TIntegerField;
    qryRunLinesSequence: TIntegerField;
    qryRunLinesClientName: TStringField;
    qryRunLinesAddress: TStringField;
    qryRunLinesPhone: TStringField;
    qryRunLinesMobile: TStringField;
    qryRunsRunID: TAutoIncField;
    qryRunsRunName: TStringField;
    qryRunsActive: TStringField;
    qryRunsOperator: TStringField;
    qryRunsOperatorID: TIntegerField;
    btnDelete: TwwIButton;
    qryCustomer: TMyQuery;
    memRunLines: TkbmMemTable;
    btnResequence: TDNMSpeedButton;
    actResequence: TAction;
    dsMemLines: TDataSource;
    btnReorder: TDNMSpeedButton;
    qryRunsRunDate: TDateField;
    dtExcludeFrom: TwwDBDateTimePicker;
    dtExcludeTo: TwwDBDateTimePicker;
    qryRunLinesExcludeFrom: TDateField;
    qryRunLinesExcludeTo: TDateField;
    qryRunLinesExclude: TStringField;
    qryRunLinesQty: TFloatField;
    btnRenumber: TDNMSpeedButton;
    qryPayment: TMyQuery;
    cboPayMethod: TwwDBLookupCombo;
    qryRunLinesPayMethodID: TIntegerField;
    qryRunLinesPayMethodName: TStringField;
    qryParts: TMyQuery;
    qryPartsPartsID: TIntegerField;
    qryPartsPARTNAME: TStringField;
    qryPartsPrice1: TFloatField;
    qryPartsTAXCODE: TStringField;
    cboParts: TwwDBLookupCombo;
    qryRunLinesProductID: TIntegerField;
    qryRunLinesProductName: TStringField;
    qryRunLinesOrderValue: TFloatField;
    qryRunsGlobalRef: TStringField;
    qryRunsClassName: TStringField;
    qryRunsClassID: TIntegerField;
    qryPartsPREFEREDSUPP: TStringField;
    qryRunLinesGlobalRef: TStringField;
    qryRunLinesTaxCode: TStringField;
    qryRunLinesPreferedSupp: TStringField;
    qryRunLinesUnitExPrice: TFloatField;
    qryRunLinesTaxAmount: TFloatField;
    qryRunsIsPublicHoliday: TStringField;
    qryHolidays: TMyQuery;
    qryRunLinesOriginalExPrice: TFloatField;
    qryRunLinesDiscount: TFloatField;
    memRunLinesClientName: TStringField;
    memRunLinesAddress: TStringField;
    memRunLinesSequence: TIntegerField;
    memRunLinesQty: TFloatField;
    memRunLinesProductName: TStringField;
    memRunLinesOrderValue: TFloatField;
    memRunLinesPayMethodName: TStringField;
    memRunLinesExclude: TStringField;
    memRunLinesExcludeFrom: TDateField;
    memRunLinesExcludeTo: TDateField;
    memRunLinesGlobalRef: TStringField;
    memRunLinesTaxCode: TStringField;
    memRunLinesPreferedSupp: TStringField;
    memRunLinesPhone: TStringField;
    memRunLinesMobile: TStringField;
    memRunLinesID: TAutoIncField;
    memRunLinesRunID: TIntegerField;
    memRunLinesClientID: TIntegerField;
    memRunLinesPayMethodID: TIntegerField;
    memRunLinesProductID: TIntegerField;
    memRunLinesUnitExPrice: TFloatField;
    memRunLinesTaxAmount: TFloatField;
    memRunLinesOriginalExPrice: TFloatField;
    memRunLinesDiscount: TFloatField;
    memCopy: TkbmMemTable;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField1: TIntegerField;
    FloatField1: TFloatField;
    StringField3: TStringField;
    FloatField2: TFloatField;
    StringField4: TStringField;
    StringField5: TStringField;
    DateField1: TDateField;
    DateField2: TDateField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    AutoIncField1: TAutoIncField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    tmrTrigger: TTimer;
    qryRunLinesCompany: TStringField;
    memRunLinesCompany: TStringField;
    memCopyCompany: TStringField;
    qryPersonalPreferences: TMyQuery;
    Label10: TLabel;
    chkShowCompany: TwwCheckBox;
    dsPersonalPreferences: TDataSource;
    qryRunLinesFreqInterval: TIntegerField;
    qryRunLinesFreqType: TStringField;
    memRunLinesFreqInterval: TIntegerField;
    memRunLinesFreqType: TStringField;
    cboFreqType: TwwDBComboBox;
    qryRunLinesStartDate: TDateField;
    memRunLinesStartDate: TDateField;
    dtStartDate: TwwDBDateTimePicker;
    memCopyStartDate: TDateField;
    memCopyFreqInterval: TIntegerField;
    memCopyFreqType: TStringField;
    qryRunLinesNextRunDate: TDateField;
    qryRunLinesDateAfterNext: TDateField;
    memRunLinesNextRunDate: TDateField;
    memRunLinesDateAfterNext: TDateField;
    memCopyNextRunDate: TDateField;
    memCopyDateAfterNext: TDateField;
    PopupMenu1: TAdvPopupMenu;
    CustomiseFields1: TMenuItem;
    DNMPanel2: TDNMPanel;
    Label3: TLabel;
    cboRunName: TwwDBLookupCombo;
    Label6: TLabel;
    qryRunLinesLastDelivery: TDateField;
    memRunLinesLastDelivery: TDateField;
    memCopyLastDelivery: TDateField;
    qryRunLinesTrack: TStringField;
    memRunLinesTrack: TStringField;
    memCopyTrack: TStringField;
    N1: TMenuItem;
    Save1: TMenuItem;
    Reorder1: TMenuItem;
    Renumber1: TMenuItem;
    Resequence1: TMenuItem;
    qryRunLinesIsContact: TStringField;
    qryRunLinesContactID: TIntegerField;
    memRunLinesIsContact: TStringField;
    memRunLinesContactID: TIntegerField;
    memCopyContactID: TIntegerField;
    memCopyIsContact: TStringField;
    dtNextRun: TwwDBDateTimePicker;
    txtSearch: TEdit;
    Label2: TLabel;
    btnExport: TDNMSpeedButton;
    SaveDialog1: TSaveDialog;
    Export1: TMenuItem;
    chkExclude: TwwCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure cboRunNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboCustomerCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnDeleteClick(Sender: TObject);
    procedure actResequenceUpdate(Sender: TObject);
    procedure btnReorderClick(Sender: TObject);
    procedure btnRenumberClick(Sender: TObject);
    procedure cboRunNameNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboPartsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure actResequenceExecute(Sender: TObject);
    procedure grdRunlinesTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure grdRunlinesCalcTitleAttributes(Sender: TObject; AFieldName: string; AFont: TFont;
      ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure memRunLinesSequenceChange(Sender: TField);
    procedure tmrTriggerTimer(Sender: TObject);
    procedure grdRunlinesRowChanged(Sender: TObject);
    procedure memRunLinesPayMethodIDChange(Sender: TField);
    procedure memRunLinesAfterPost(DataSet: TDataSet);
    procedure memRunLinesQtyChange(Sender: TField);
    procedure grdRunlinesEnter(Sender: TObject);
    procedure dtExcludeFromCloseUp(Sender: TObject);
    procedure dtExcludeToCloseUp(Sender: TObject);
    procedure cboCustomerNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboPartsNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboPayMethodChange(Sender: TObject);
    procedure memRunLinesExcludeFromChange(Sender: TField);
    procedure memRunLinesExcludeToChange(Sender: TField);
    procedure chkShowCompanyClick(Sender: TObject);
    procedure memRunLinesExcludeChange(Sender: TField);
    procedure grdRunlinesCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure memRunLinesFreqTypeChange(Sender: TField);
    procedure memRunLinesFreqIntervalChange(Sender: TField);
    procedure dtStartDateCloseUp(Sender: TObject);
    procedure cboFreqTypeCloseUp(Sender: TwwDBComboBox; Select: boolean);
    procedure memRunLinesStartDateChange(Sender: TField);
//    procedure CustomiseFields1Click(Sender: TObject);
    procedure memRunLinesPayMethodNameChange(Sender: TField);
    procedure txtSearchChange(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure Export1Click(Sender: TObject);
    procedure memRunLinesNextRunDateChange(Sender: TField);
    procedure chkExcludeClick(Sender: TObject);
    procedure memRunLinesOrderValueChange(Sender: TField);
    procedure memRunLinesAfterOpen(DataSet: TDataSet);
    procedure dtNextRunCloseUp(Sender: TObject);
    procedure memRunLinesAddressChange(Sender: TField);
    procedure memRunLinesClientNameChange(Sender: TField);

  private
    { Private declarations }
    slColumnLockList: TStringList;
    HIGHLIGHTLOCATE: TColor;
    MyDelivery: TDeliveryObj;
//    oGridObj: TCustomizeListObj;
    oDataSaver: TDatasetFileSaver;
    fbRequestRelocate: boolean;
    bSaving: boolean;
    fbInitialisingRun: boolean;
    iCurrentSequenceNumber: integer;
    iCurrentPayMethodID: integer;
    iCurrentRecID: integer;
    bResequencing: boolean;
    bShowingContact: boolean;

    bFirstRunSelected: boolean;
    bDataChanged: boolean;
    ClientDiscount: TClientDiscountObj;
    procedure SetupRun(iRunID: integer);
    procedure SaveSequentialOrder;
    procedure CheckExclusionDates;
    procedure PerformResequence(var Msg: TMessage); message WM_RESEQUENCE;
    procedure SaveRunDetails;
    function NoDuplicatesInRun: boolean;
    procedure RecheckEnteredPrices;
    procedure UpdateClientSequence(iOldSequence, iNewSequence: integer);
    procedure UpdatePaymethod(iNewPayMethodID, iClientID, iContactID: integer);
    procedure UpdateStartDate(dtNewDate: TDateTime; iClientID, iContactID: integer);
    procedure UpdateNextRunDate(dtNewDate: TDateTime; iClientID, iContactID: integer);
    procedure CalcTotals;
    procedure RefreshClientList;
    function IsRunListOk: boolean;
//    procedure After_GetPreviousSettings;

  public
    { Public declarations }
    

    property CurrentRecordNumber: integer read iCurrentRecID write iCurrentRecID;
    property CurrentSequenceNumber: integer read iCurrentSequenceNumber write iCurrentSequenceNumber;
    property CurrentPayMethodID: integer read iCurrentPayMethodID write iCurrentPayMethodID;

  end;

//var
//  frmRunSequencerGUI: TfrmRunSequencerGUI;

implementation

{$R *.dfm}

uses
  DNMExceptions, CommonDbLib, DNMLib, FormFactory, frmRunName,  
    
   CommonLib, AppEnvironment, FastFuncs;

const
  HIGHLIGHTLOCATEDEF = $00DFFFFE;  // a very light yellow rw

procedure TfrmRunSequencerGUI.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := True;
  CheckRunLinesForExistingFields;
  inherited;
  qryPersonalPreferences.Connection := CommonDbLib.GetSharedMyDacConnection;

  if AppEnv.Employee.ListSelectionColour = 0 then begin
    HIGHLIGHTLOCATE := HIGHLIGHTLOCATEDEF;
  end else begin
    HIGHLIGHTLOCATE := AppEnv.Employee.ListSelectionColour;
  end;

  // State that we are resequencing even thou
  // we are truely not.  This will stop the
  // application from recursive looping while
  // starting up the form.
  fbRequestRelocate := false;
  bShowingContact := false;
  bResequencing := true;
  bFirstRunSelected := false;
  bDataChanged := false;
  bSaving := false;
  tmrTrigger.Enabled := false;

  // Create our discount object.
  ClientDiscount := TClientDiscountObj.Create;
  oDataSaver := TDatasetFileSaver.Create;
//  oGridObj := TCustomizeListObj.Create;
  // Create our grid lock list.
  slColumnLockList := TStringList.Create;
  slColumnLockList.Clear;
  slColumnLockList.Add('Company');
  // Set our lock list.
//  oGridObj.LockList := slColumnLockList;
  // Bind Column Moved Event to our grid.
//  oGridObj.BindColumnMovedEvent(grdRunLines);

  // Create delivery object.
  MyDelivery := TDeliveryObj.Create;
  
end;

procedure TfrmRunSequencerGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  try
    inherited;
    SetLength(QueryNamesNotToOpen, 1);
    QueryNamesNotToOpen[0] := 'qryRunlines';

    qryPersonalPreferences.Params.ParamByName('xID').AsInteger := AppEnv.Employee.EmployeeID;

    // Open our queries
    OpenQueries(QueryNamesNotToOpen);

    EditNoAbort(qryRuns);

    // Has a run been selected from the Run List
    if KeyID <> 0 then begin
      // Locate our run details.
      if qryRuns.Locate('RunID', KeyID, [loCaseInsensitive]) then begin
        cboRunName.Text := qryRuns.FieldByName('RunName').AsString;
        bFirstRunSelected := true;

        // Set the run operator.
        Label6.Caption := 'Operator : ' + qryRuns.FieldByName('Operator').AsString;

        // Show us now our run details.
        SetupRun(qryRuns.FieldByName('RunID').AsInteger);

        label2.Enabled := true;
        txtSearch.Enabled := true;
      end;
    end else begin
      // Refetch our run lines.
      qryRunLines.Close;
      qryRunLines.ParamByName('xRunID').asInteger := KeyID;
      qryRunLines.Open;
      grdRunLines.ReadOnly := true;

      // Grab an initial copy of the sequence order for this run.
      // We will use this if changes are to be made.
      memRunLines.DisableControls;
      memRunLines.EnableIndexes := false;
      memRunLines.LoadFromDataSet(qryRunLines, []);
      memRunLines.EnableIndexes := true;
      memRunLines.UpdateIndexes;
      memRunLines.EnableControls;

//      oGridObj.GetPreviousSettings(grdRunLines, grdRunLines.Owner.Name);
//      After_GetPreviousSettings;

      Self.pTabStops.Initialised := false;
      Self.pTabStops.Initialise(memRunLines);
    end;

    // State that resequencing is not in progress.
    // This should always go last in the FormShow event.
    bResequencing := false;

    // Refresh Customer query lookup.
    RefreshClientList;

    // Recalculate Summary Totals
    CalcTotals;

    if (cboRunName.Enabled) then begin
      SetControlFocus(cboRunName);
    end else begin
      SetControlFocus(grdRunLines);
    end;

    if AppEnv.CompanyPrefs.AutoCorrectPriceDiscountsOnDeliveries then begin
      grdRunlines.ColumnByName('OrderValue').ReadOnly := True;
    end else begin
      grdRunlines.ColumnByName('OrderValue').ReadOnly := False;
    end;

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

procedure TfrmRunSequencerGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  // Close down our query controls.
  CloseQueries;

  // Free form from memory.
  Action := caFree;
end;

procedure TfrmRunSequencerGUI.FormDestroy(Sender: TObject);
begin
  if Assigned(ClientDiscount) then FreeAndNil(ClientDiscount);
  if Assigned(oDataSaver) then FreeAndNil(oDataSaver);
  if Assigned(MyDelivery) then FreeAndNil(MyDelivery);
  if Assigned(slColumnLockList) then FreeAndNil(slColumnLockList);
  inherited;
end;

procedure TfrmRunSequencerGUI.cmdCancelClick(Sender: TObject);
begin
  inherited;
  // Failed! Rollback Transaction and Cancel
  RollbackTransaction;
  Close;
end;

procedure TfrmRunSequencerGUI.cmdOKClick(Sender: TObject);
begin
  if bSaving then Exit;
  inherited;
  bSaving := true;

  try
    // Ensure the run list complies to our requirements.
    if (not IsRunListOk) or (not NoDuplicatesInRun) then begin
      bSaving := false;
      Exit;
    end;

    memRunLines.DisableControls;

    // Save our Run Details.
    SaveRunDetails;

    qryPersonalPreferences.Last;
    qryPersonalPreferences.First;

    AppEnv.Employee.PopulateMe(AppEnv.Employee.EmployeeID);
//    oGridObj.SaveGridDetails(grdRunLines.Name, Self.Name, grdRunLines);

    // Notify any attached list.
    Notify;

    // Close our form down.
    Close;
  except
    bSaving := false;
  end;
end;

procedure TfrmRunSequencerGUI.SetupRun(iRunID: integer);
begin
  fbInitialisingRun := true;
  // Check Access Levels
  if Self.AccessLevel >= 5 then begin
    grdRunLines.ReadOnly := true;
  end else begin
    grdRunLines.ReadOnly := false;
  end;

  if Self.AccessLevel >= 2 then begin
    btnDelete.Enabled      := false;
    grdRunLines.KeyOptions := grdRunLines.KeyOptions - [dgAllowDelete];
  end;

  // If in edit mode, then post.
  if qryRunLines.Active then begin
    qryRunLines.Last;
    qryRunLines.First;
  end;

  // Refetch our run lines.
  qryRunLines.Close;
  qryRunLines.ParamByName('xRunID').asInteger := iRunID;
  qryRunLines.Open;

  // Grab an initial copy of the sequence order for this run.
  // We will use this if changes are to be made.
  memRunLines.DisableControls;
  memRunLines.EnableIndexes := false;
  memRunLines.LoadFromDataSet(qryRunLines, []);
  memRunLines.EnableIndexes := true;
  memRunLines.UpdateIndexes;
  memRunLines.EnableControls;

  CustomiseFields1.Enabled := true;
  Export1.Enabled := true;
  btnExport.Enabled := true;

  // Recheck line prices.  By doing this, we keep the run dynamic.
  if AppEnv.CompanyPrefs.AutoCorrectPriceDiscountsOnDeliveries then begin
    RecheckEnteredPrices;
  end;

  // Restore user settings of the grid display control.
  Application.ProcessMessages;
//  oGridObj.GetPreviousSettings(grdRunLines, grdRunLines.Owner.Name);
//  After_GetPreviousSettings;

  // Now are we showing the company or contact field first?
  if (qryPersonalPreferences.FieldByName('ShowCompanyAsDefaultOnRun').AsString = 'T') then begin
    cboCustomer.Selected.Clear;
    cboCustomer.Selected.Add('Customer' + #9 + '30' + #9 + 'Contact'#9'T' + #9);
    cboCustomer.Selected.Add('Company' + #9 + '30' + #9 + 'Company'#9'T' + #9);
    cboCustomer.Selected.Add('Type' + #9 + '15' + #9 + 'Type'#9'T' + #9);
    cboCustomer.Selected.Add('Address' + #9 + '35' + #9 + 'Address'#9'T' + #9);

    grdRunLines.ColumnByName('Company').DisplayLabel := 'Contact';
    bShowingContact := true;
  end else begin
    cboCustomer.Selected.Clear;
    cboCustomer.Selected.Add('Company' + #9 + '30' + #9 + 'Company'#9'T' + #9);
    cboCustomer.Selected.Add('Customer' + #9 + '30' + #9 + 'Contact'#9'T' + #9);
    cboCustomer.Selected.Add('Type' + #9 + '15' + #9 + 'Type'#9'T' + #9);
    cboCustomer.Selected.Add('Address' + #9 + '35' + #9 + 'Address'#9'T' + #9);

    grdRunLines.ColumnByName('Company').DisplayLabel := 'Company';
    bShowingContact := false;
  end;

  // Since the grid now can have a new order of fields within its
  // list.  We now have to re-initialise the tab stops so that the
  // tab stop settings will load and remain.
  Self.pTabStops.Initialised := false;
  Self.pTabStops.Initialise(memRunLines);

  btnExport.Enabled := true;
  fbInitialisingRun := false;

  // Ensure the memory table is in edit mode.
  memRunLines.Edit;
end;

procedure TfrmRunSequencerGUI.cboRunNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  iResult: integer;
begin
  if not Modified then Exit;
  inherited;
  if cboRunName.Text = '' then Exit;
  bResequencing := true;
  if bFirstRunSelected then begin
    if (bDataChanged) then begin
      iResult := CommonLib.MessageDlgXP_Vista('You have current changes that need to be saved.  Do you wish to save these changes?' +
        #13 + #10 + #13 + #10 + 'Press OK to Save your changes now.  Otherwise, please press CANCEL to forfeit changes.',
        mtInformation, [mbOK, mbCancel], 0);
      if iResult = mrOk then begin
        // Ensure the run list complies to our requirements.
        if (not IsRunListOk) or (not NoDuplicatesInRun) then begin
          qryRuns.Locate('RunID', memRunLines.FieldByName('RunID').AsInteger, []);
          cboRunName.Text := qryRuns.FieldByName('RunName').AsString;
          bSaving := false;
          Exit;
        end;

        SaveRunDetails;
      end;
    end;
  end;

  // Put our Database Connection into transaction mode.
  bDataChanged := false;

  // State who the operator is for this run.
  Label6.Caption := 'Operator : ' + qryRuns.FieldByName('Operator').AsString;

  // Setup our data entry lines.
  SetupRun(qryRuns.FieldByName('RunID').AsInteger);

  label2.Enabled := true;
  txtSearch.Enabled := true;

  // Set required status flags.
  bFirstRunSelected := true;
  bResequencing := false;

  // Recalculate our summary totals.
  CalcTotals;
end;

procedure TfrmRunSequencerGUI.cboCustomerCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  qry, qryParts, qryCompulsoryProducts: TMyQuery;
  iCount, iSequence, iFoundSeq, iRecNo: integer;
  sContactName: string;
  bContactBased: boolean;
begin
  if not Modified then Exit;
  if fbInitialisingRun then Exit;
  iSequence := 0;
  inherited;

  // If the drop down contains nothing then exit.
  if cboCustomer.Text = '' then Exit;

  // Was the same customer selected as already present?
  if memRunLines.FieldByName('ClientID').AsInteger = qryCustomer.FieldByName('ClientID').AsInteger then begin
    // Yes, then out we go.
    Exit;
  end;

  iRecNo := memRunLines.FieldByName('ID').AsInteger;
  sContactName := cboCustomer.Text;

  // First we must check to see if this customer
  // is already assigned to another run.
  if AppEnv.CompanyPrefs.OneRunPerCustomer then begin
    if IsCustomerOnRun(qryCustomer.FieldByName('ClientID').AsInteger, qryRuns.FieldByName('RunID').AsInteger) then begin
      CommonLib.MessageDlgXP_Vista('It appears that the selected contact [ ' + qryCustomer.FieldByName('ClientName').AsString +
        ' of ' + qryCustomer.FieldByName('Company').AsString + ' ] already exists within another run.', mtWarning, [mbOK], 0);
      // Cancel entry.
      memRunLines.Cancel;
      // Enable all data aware controls that relate to our memory Run Lines.
      memRunLines.EnableControls;
      Exit;
    end;
  end;

  if (memRunLines.FieldByName('Sequence').AsInteger <> 0) then begin
    if ((qryCustomer.FieldByName('ClientID').AsInteger <> 0) and
      (qryCustomer.FieldByName('ClientID').AsInteger <> memRunLines.FieldByName('ClientID').AsInteger)) then begin
      fbInitialisingRun := true;
      MyDelivery.SetNewCustomerAgainstSequenceID(memRunLines, memRunLines.FieldByName('Sequence').AsInteger, qryCustomer);
      fbInitialisingRun := false;
      memRunLines.Locate('ID', iRecNo, [loCaseInsensitive]);
      memRunLines.Edit;
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
  qry.Options.FlatBuffers := True;
  qryParts := TMyQuery.Create(nil);
  qryParts.Options.FlatBuffers := True;
  qryCompulsoryProducts := TMyQuery.Create(nil);
  qryCompulsoryProducts.Options.FlatBuffers := True;
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

    ////////////////////////////
    // Setup our parts query. //
    ////////////////////////////
    qryParts.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryParts.ParamCheck := true;
    qryParts.SQL.Clear;
    qryParts.SQL.Add('SELECT PartsID, TaxCode FROM tblparts WHERE (PartsID = :xPartID);');

    ////////////////////////////////////////////////
    // If the customer is already assigned to a
    // sequence ID, then fetch its value.
    ////////////////////////////////////////////////
    iFoundSeq := MyDelivery.DoesCustomerHaveSequenceNumber(qryCustomer.FieldByName('ClientID').AsInteger, memRunLines);

    //////////////////////////////////////////////////////////////////////////
    // Here we have to relocate our position within the dataset
    // because the call to DoesCustomerHaveSeqeunceNumber() copies the memory
    // table and results the loss of position.
    //////////////////////////////////////////////////////////////////////////
    if memRunLines.Locate('ID', iRecNo, [loCaseInsensitive]) then begin
      memRunLines.Edit;
    end;

    Application.ProcessMessages;
    memRunLines.DisableControls;

    ////////////////////////////////////////////////
    // Does the selected customer have an assigned sequence number?
    ////////////////////////////////////////////////
    // Does the selected customer have an assigned sequence number?
    if iFoundSeq = 0 then begin
      // No! Get next sequence number.
      iSequence := MyDelivery.GetNextSequenceNumber(memRunLines);
      bContactBased := false;
    end else begin
      // Yes! Then this customer will use this assigned sequence number.
      if MyDelivery.DoesCustomerHaveSequenceNumber(qryCustomer.FieldByName('ClientID').AsInteger, sContactName, memRunLines) then
      begin
        bContactBased := true;
      end else begin
        bContactBased := false;
        iSequence := iFoundSeq;
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

        if qryCustomer.FieldByName('Details').AsInteger = 0 then begin
          FillTable.FieldByName('IsContact').AsString := 'F';
        end else begin
          FillTable.FieldByName('IsContact').AsString := 'T';
          FillTable.FieldByName('ContactID').AsInteger := qryCustomer.FieldByName('ContactID').AsInteger;
        end;

        FillTable.FieldByName('ClientID').AsInteger := qryCustomer.FieldByName('ClientID').AsInteger;
        FillTable.FieldByName('ClientName').AsString := qryCustomer.FieldByName('Customer').AsString;
        FillTable.FieldByName('Company').AsString := qryCustomer.FieldByName('Company').AsString;
        FillTable.FieldByName('TaxCode').AsString := qryCompulsoryProducts.FieldByName('TaxCode').AsString;
        FillTable.FieldByName('Qty').AsFloat := qryCompulsoryProducts.FieldByName('Qty').AsFloat;
        FillTable.FieldByName('RunID').AsInteger := qryRuns.FieldByName('RunID').AsInteger;
        FillTable.FieldByName('StartDate').AsDateTime := Date;

        FillTable.FieldByName('FreqInterval').AsFloat := qryCompulsoryProducts.FieldByName('FreqInterval').AsFloat;
        FillTable.FieldByName('FreqType').AsString := qryCompulsoryProducts.FieldByName('FreqType').AsString;

        MyDelivery.CalcScheduledDates(qryCompulsoryProducts.FieldByName('FreqInterval').AsInteger,
          qryCompulsoryProducts.FieldByName('FreqType').AsString,
          Date());

        FillTable.FieldByName('NextRunDate').AsDateTime := FillTable.FieldByName('StartDate').AsDateTime;

        if MyDelivery.ScheduledTimes[1] <> 0 then begin
          FillTable.FieldByName('DateAfterNext').AsDateTime := MyDelivery.ScheduledTimes[1];
        end else begin
          FillTable.FieldByName('DateAfterNext').AsDateTime := FillTable.FieldByName('StartDate').AsDateTime;
        end;

        FillTable.FieldByName('Sequence').AsInteger := iSequence;
        FillTable.FieldByName('Phone').AsString := qryCustomer.FieldByName('Phone').AsString;
        FillTable.FieldByName('Mobile').AsString := qryCustomer.FieldByName('Mobile').AsString;
        FillTable.FieldByName('Address').AsString := qryCustomer.FieldByName('Address').AsString;
        FillTable.FieldByName('ProductID').AsInteger := qryCompulsoryProducts.FieldByName('ProductID').AsInteger;
        FillTable.FieldByName('ProductName').AsString := qryCompulsoryProducts.FieldByName('ProductName').AsString;
        cboParts.Text := FillTable.FieldByName('ProductName').AsString;
        cboParts.LookupTable.Locate('PARTNAME', cboParts.Text, [loCaseInsensitive]);
        cboPartsCloseUp(cboParts, cboParts.LookupTable, cboParts.DataSource.DataSet, true);
        Inc(iCount);
        qryCompulsoryProducts.Next;
      end;
    end;

    //////////////////////////////////////////////////////////////////////////
    // Any special products?
    //////////////////////////////////////////////////////////////////////////
    if (qry.RecordCount > 0) and (not bContactBased) then begin
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
        end else begin
          FillTable.FieldByName('IsContact').AsString := 'T';
          FillTable.FieldByName('ContactID').AsInteger := qryCustomer.FieldByName('ContactID').AsInteger;
        end;

        FillTable.FieldByName('ClientName').AsString := qryCustomer.FieldByName('Customer').AsString;
        FillTable.FieldByName('Company').AsString := qryCustomer.FieldByName('Company').AsString;
        FillTable.FieldByName('TaxCode').AsString := qryParts.FieldByName('TaxCode').AsString;
        FillTable.FieldByName('Qty').AsFloat := 1;

        FillTable.FieldByName('StartDate').AsDateTime := Date;

        FillTable.FieldByName('RunID').AsInteger := qryRuns.FieldByName('RunID').AsInteger;
        FillTable.FieldByName('Sequence').AsInteger := iSequence;
        FillTable.FieldByName('Phone').AsString := qryCustomer.FieldByName('Phone').AsString;
        FillTable.FieldByName('Mobile').AsString := qryCustomer.FieldByName('Mobile').AsString;
        FillTable.FieldByName('Address').AsString := qryCustomer.FieldByName('Address').AsString;
        FillTable.FieldByName('ProductID').AsInteger := qry.FieldByName('ProductID').AsInteger;
        FillTable.FieldByName('ProductName').AsString := qry.FieldByName('Name').AsString;
        FillTable.FieldByName('FreqInterval').AsFloat := 1;
        FillTable.FieldByName('FreqType').AsString := 'Weeks(s)';

        MyDelivery.CalcScheduledDates(1, 'Week(s)', FillTable.FieldByName('StartDate').AsDateTime);
        FillTable.FieldByName('NextRunDate').AsDateTime := FillTable.FieldByName('StartDate').AsDateTime;
        if MyDelivery.ScheduledTimes[1] <> 0 then begin
          FillTable.FieldByName('DateAfterNext').AsDateTime := MyDelivery.ScheduledTimes[1];
        end else begin
          FillTable.FieldByName('DateAfterNext').AsDateTime := FillTable.FieldByName('StartDate').AsDateTime;
        end;

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

      FillTable.FieldByName('RunID').AsInteger := qryRuns.FieldByName('RunID').AsInteger;
      FillTable.FieldByName('ClientID').AsInteger := qryCustomer.FieldByName('ClientID').AsInteger;
      if qryCustomer.FieldByName('Details').AsInteger = 0 then begin
        FillTable.FieldByName('IsContact').AsString := 'F';
      end else begin
        FillTable.FieldByName('IsContact').AsString := 'T';
        FillTable.FieldByName('ContactID').AsInteger := qryCustomer.FieldByName('ContactID').AsInteger;
      end;

      FillTable.FieldByName('ClientName').AsString := qryCustomer.FieldByName('Customer').AsString;
      FillTable.FieldByName('Company').AsString := qryCustomer.FieldByName('Company').AsString;
      FillTable.FieldByName('Phone').AsString := qryCustomer.FieldByName('Phone').AsString;
      FillTable.FieldByName('Mobile').AsString := qryCustomer.FieldByName('Mobile').AsString;
      FillTable.FieldByName('Address').AsString := qryCustomer.FieldByName('Address').AsString;
      if iFoundSeq <> 0 then begin
        FillTable.FieldByName('Sequence').AsInteger := iFoundSeq;
      end else begin
        FillTable.FieldByName('Sequence').AsInteger := iSequence;
      end;
        
      FillTable.FieldByName('Qty').AsFloat := 1;
      FillTable.FieldByName('FreqInterval').AsFloat := 1;
      FillTable.FieldByName('FreqType').AsString := 'Week(s)';

      FillTable.FieldByName('StartDate').AsDateTime := Date;

      MyDelivery.CalcScheduledDates(1, 'Week(s)', FillTable.FieldByName('StartDate').AsDateTime);
      FillTable.FieldByName('NextRunDate').AsDateTime := FillTable.FieldByName('StartDate').AsDateTime;
      if MyDelivery.ScheduledTimes[1] <> 0 then begin
        FillTable.FieldByName('DateAfterNext').AsDateTime := MyDelivery.ScheduledTimes[1];
      end else begin
        FillTable.FieldByName('DateAfterNext').AsDateTime := FillTable.FieldByName('StartDate').AsDateTime;
      end;

      FillTable.Post;
      FillTable.Edit;

      // Refresh the grid display.
      grdRunLines.RefreshDisplay;
    end;

    // Request a resequence on a sequence change.
    fbInitialisingRun := false;

    // State that the data has changed.
    bDataChanged := true;
    memRunLines.EnableControls;

  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(qryCompulsoryProducts) then
      FreeandNil(qryCompulsoryProducts);
  end;
end;

procedure TfrmRunSequencerGUI.btnDeleteClick(Sender: TObject);
begin
  inherited;
  // Delete this entry from the memory dataset.
  fbInitialisingRun := true;

  // Delete line.
  DeleteRecord(memRunLines);

  // Recalculate summary totals.
  CalcTotals;
  fbInitialisingRun := false;
  memRunLines.Edit;
end;

procedure TfrmRunSequencerGUI.actResequenceUpdate(Sender: TObject);
begin
  inherited;
  // Has there been a run selected?
  if (cboRunName.Text = '') then begin
    // No! Disable the following controls.
    btnResequence.Enabled := false;
    Resequence1.Enabled   := false;
    btnReorder.Enabled    := false;
    Reorder1.Enabled      := false;
    cmdOk.Enabled         := false;
    Save1.Enabled         := false;
    btnRenumber.Enabled   := false;
    Renumber1.Enabled     := false;
    //     btnRepeat.Enabled := False;
  end else begin
    // Yes! Enable the following controls.
    btnResequence.Enabled := true;
    Resequence1.Enabled   := true;
    btnReorder.Enabled    := true;
    Reorder1.Enabled      := true;
    cmdOk.Enabled         := true;
    Save1.Enabled         := true;
    btnRenumber.Enabled   := true;
    Renumber1.Enabled     := true;
  end;
end;

procedure TfrmRunSequencerGUI.PerformResequence(var Msg: TMessage);
var
  iSeq, iRecID: integer;
  iCurrentClientID: integer;
begin
  if bResequencing then Exit;
  bResequencing := true;
  iRecID := memRunLines.FieldByName('ID').AsInteger;
  memRunLines.DisableControls;
  memCopy.LoadFromDataSet(memRunLines, []);
  memCopy.SortFields := 'Sequence;ClientID';
  memCopy.Sort([]);
  memRunLines.LoadFromDataSet(memCopy, []); //mtcpoFieldIndex

  memRunLines.First;
  iCurrentClientID := memRunLines.FieldByName('ClientID').AsInteger;
  iSeq := 1;
  while not memRunLines.Eof do begin
    memRunLines.Edit;
    memRunLines.FieldByName('Sequence').AsInteger := iSeq;
    memRunLines.Post;
    memRunLines.Next;
    if iCurrentClientID <> memRunLines.FieldByName('ClientID').AsInteger then begin
      Inc(iSeq, 1);
      iCurrentClientID := memRunLines.FieldByName('ClientID').AsInteger;
    end;
  end;

  // State that resequencing has finished.
  bResequencing := false;
  memRunLines.EnableControls;
  memRunLines.Locate('ID', iRecID, [loCaseInsensitive]);
  fbInitialisingRun := false;
end;

procedure TfrmRunSequencerGUI.btnReorderClick(Sender: TObject);
begin
  inherited;
  // State that we are initialising, prevent Field OnChange events from firing.
  fbInitialisingRun := true;
  memRunLines.DisableControls;

  // Grab a full copy of our data entry lines.
  memCopy.LoadFromDataSet(memRunLines, []);

  // Sort the copy by Sequence, then by client name.
  memCopy.SortFields := 'Sequence;ClientName';
  memCopy.Sort([]);

  // Save our reordered list back to our data entry lines.
  memRunLines.LoadFromDataSet(memCopy, []); //mtcpoFieldIndex
  memRunLines.EnableControls;
  fbInitialisingRun := false;
end;

procedure TfrmRunSequencerGUI.SaveSequentialOrder;
var
  ProgressDialog: TProgressDialog;
begin
  ProgressDialog := TProgressDialog.Create(nil);
  try
    qryRunLines.First;
    // Delete our runlines in our backend.
    while not qryRunLines.Eof do begin
      // Delete record.
      qryRunLines.Delete;
    end;

    Screen.Cursor := crHourGlass;
    // Setup our progress dialog
    ProgressDialog.Caption  := 'Saving .....';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := memRunLines.RecordCount;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;

    Application.ProcessMessages;

    // Point to our first run detail line.
    if memRunLines.Filtered then // Disable filter as all records must be saved.
      memRunLines.Filtered := false;
       
    // Fetch first record.
    memRunLines.First;

    // Copy records from memory table to database backend.
    while not memRunLines.Eof do begin
      qryRunLines.Insert;
      qryRunLines.FieldByName('RunID').AsInteger := memRunLines.FieldByName('RunID').AsInteger;
      qryRunLines.FieldByName('ClientID').AsInteger := memRunLines.FieldByName('ClientID').AsInteger;
      qryRunLines.FieldByName('StartDate').AsDateTime := memRunLines.FieldByName('StartDate').AsDateTime;
      qryRunLines.FieldByName('FreqInterval').AsInteger := memRunLines.FieldByName('FreqInterval').AsInteger;
      qryRunLines.FieldByName('FreqType').AsString := memRunLines.FieldByName('FreqType').AsString;
      qryRunLines.FieldByName('Company').AsString := memRunLines.FieldByName('Company').AsString;
      qryRunLines.FieldByName('ProductID').AsInteger := memRunLines.FieldByName('ProductID').AsInteger;
      qryRunLines.FieldByName('ProductName').AsString := memRunLines.FieldByName('ProductName').AsString;
      qryRunLines.FieldByName('Sequence').AsInteger := memRunLines.FieldByName('Sequence').AsInteger;
      qryRunLines.FieldByName('PayMethodID').AsInteger := memRunLines.FieldByName('PayMethodID').AsInteger;
      qryRunLines.FieldByName('PayMethodName').AsString := memRunLines.FieldByName('PayMethodName').AsString;
      qryRunLines.FieldByName('Qty').AsFloat := memRunLines.FieldByName('Qty').AsFloat;
      qryRunLines.FieldByName('OrderValue').AsFloat := memRunLines.FieldByName('OrderValue').AsFloat;
      qryRunLines.FieldByName('UnitExPrice').AsFloat := memRunLines.FieldByName('UnitExPrice').AsFloat;
      qryRunLines.FieldByName('TaxAmount').AsFloat := memRunLines.FieldByName('TaxAmount').AsFloat;
      qryRunLines.FieldByName('ClientName').AsString := memRunLines.FieldByName('ClientName').AsString;
      qryRunLines.FieldByName('TaxCode').AsString := memRunLines.FieldByName('TaxCode').AsString;
      qryRunLines.FieldByName('PreferedSupp').AsString := memRunLines.FieldByName('PreferedSupp').AsString;
      qryRunLines.FieldByName('Phone').AsString := memRunLines.FieldByName('Phone').AsString;
      qryRunLines.FieldByName('Mobile').AsString := memRunLines.FieldByName('Mobile').AsString;
      qryRunLines.FieldByName('Address').AsString := memRunLines.FieldByName('Address').AsString;
      qryRunLines.FieldByName('Track').AsString := memRunLines.FieldByName('Track').AsString;
      qryRunLines.FieldByName('Exclude').AsString := memRunLines.FieldByName('Exclude').AsString;
      qryRunLines.FieldByName('ExcludeFrom').AsVariant := memRunLines.FieldByName('ExcludeFrom').AsVariant;
      qryRunLines.FieldByName('ExcludeTo').AsVariant := memRunLines.FieldByName('ExcludeTo').AsVariant;
      qryRunLines.FieldByName('NextRunDate').AsDateTime := memRunLines.FieldByName('NextRunDate').AsDateTime;
      qryRunLines.FieldByName('DateAfterNext').AsDateTime := memRunLines.FieldByName('DateAfterNext').AsDateTime;
      qryRunLines.FieldByName('OriginalExPrice').AsFloat := memRunLines.FieldByName('OriginalExPrice').AsFloat;
      qryRunLines.FieldByName('Discount').AsFloat := memRunLines.FieldByName('Discount').AsFloat;
      qryRunLines.FieldByName('LastDelivery').AsVariant := memRunLines.FieldByName('LastDelivery').AsVariant;
      qryRunLines.FieldByName('IsContact').AsString := memRunLines.FieldByName('IsContact').AsString;
      qryRunLines.FieldByName('ContactID').AsInteger := memRunLines.FieldByName('ContactID').AsInteger;
      qryRunLines.Post;

      // Write Global Reference ID.
      qryRunLines.Edit;
      qryRunLines.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + qryRunLines.FieldByName('ID').AsString;
      qryRunLines.Post;

      // Fetch next record.
      memRunLines.Next;

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
end;

procedure TfrmRunSequencerGUI.btnRenumberClick(Sender: TObject);
var
  iSeq: integer;
  iCurrentClientID: integer;
  bm: TBookmark;
begin
  fbInitialisingRun := true;
  bm := memRunLines.GetBookmark;
  memRunLines.DisableControls;
  memCopy.LoadFromDataSet(memRunLines, []);
  memCopy.SortFields := 'Sequence;ClientID';
  memCopy.Sort([]);
  memRunLines.LoadFromDataSet(memCopy, []); //mtcpoFieldIndex
  iSeq := 1;
  memRunLines.First;
  iCurrentClientID := memRunLines.FieldByName('ClientID').AsInteger;

  while not memRunLines.Eof do begin
    memRunLines.Edit;
    memRunLines.FieldByName('Sequence').AsInteger := iSeq;
    memRunLines.Post;
    memRunLines.Next;

    if iCurrentClientID <> memRunLines.FieldByName('ClientID').AsInteger then begin
      if iSeq = 1 then Inc(iSeq, 9)
      else Inc(iSeq, 10);

      iCurrentClientID := memRunLines.FieldByName('ClientID').AsInteger;
    end;
  end;

  // State that resequencing has finished.
  bResequencing := false;
  memRunLines.EnableControls;
  fbInitialisingRun := false;
  if Assigned(bm) then memRunLines.GotoBookmark(bm);
end;

procedure TfrmRunSequencerGUI.SaveRunDetails;
begin
  try
    // Disable all bounded data aware controls.
    qryRuns.DisableControls;
    qryRunLines.DisableControls;

    // Ensure the following post if in edit mode.
    if qryRuns.State in [dsEdit, dsInsert] then qryRuns.Post;
    memRunLines.Last;
    memRunLines.First;

    // Disable all memRunLines data aware controls
    memRunLines.DisableControls;

    // Save the run details to our database backend.
    BeginTransaction;
    SaveSequentialOrder;

    // Is the connection in transaction mode?
    if (MyConnection.intransaction) then begin
      // Yes, Commit Transaction.
      CommitTransaction;
    end;
  except
    // Failed! Rollback Transaction and Cancel
    RollbackTransaction;
  end;

  // Enable all bounded data aware controls
  memRunLines.EnableControls;
  qryRuns.EnableControls;
  qryRunLines.EnableControls;
end;

procedure TfrmRunSequencerGUI.cboRunNameNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
var
  iResult: integer;
  Form : TComponent;
begin
  inherited;
  bResequencing := true;
  if bFirstRunSelected then begin
    if (bDataChanged) then begin
      // Ensure the run list complies to our requirements.
      if (not IsRunListOk) or (not NoDuplicatesInRun) then begin
        qryRuns.Locate('RunID', memRunLines.FieldByName('RunID').AsInteger, []);
        cboRunName.Text := qryRuns.FieldByName('RunName').AsString;
        Exit;
      end;

      // Save the run details to our database backend.
      SaveRunDetails;
    end;
  end;

  // Show our Run Name form.
  Form := GetComponentByClassName('TfrmRunCreator');
  if Assigned(Form) then begin
    with TfrmRunCreator(Form) do begin
      NewRunName := NewValue;
      FormStyle := fsNormal;
      iResult   := ShowModal;
    end;
    // Was the information saved?
    if iResult = mrOk then begin
      // Yes, then we need to refresh our run list.
      qryRuns.Close;
      qryRuns.Open;
      // Locate our new entered run name.
      if qryRuns.Locate('RunName', NewValue, [loCaseInsensitive]) then begin
        cboRunName.Text := NewValue;
        Accept := true;

        // Put our Database Connection into transaction mode.
        bDataChanged := false;

        bFirstRunSelected := true;
        Label6.Caption := 'Operator : ' + qryRuns.FieldByName('Operator').AsString;

        // Setup our data entry lines.
        SetupRun(qryRuns.FieldByName('RunID').AsInteger);
      end;
    end else begin
      Accept := false;
    end;
    bResequencing := false;

  end;

end;

procedure TfrmRunSequencerGUI.cboPartsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
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
  ClientDiscount.ClientPrice_Discounts(memRunLines.FieldByName('ClientID').AsInteger, 0,
    LookupTable.FieldByName('PartsID').AsInteger, AppEnv.DefaultClass.ClassID,
    memRunLines.FieldByName('Qty').AsFloat, Date(), 1, '', '', '', '', '',
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
  dQty := FillTable.FieldByName('Qty').AsFloat;

  // Calculate now the tax amount if any.
  dTax := (dIncPrice - dPriceEx) * dQty;
  FillTable.FieldByName('TaxAmount').AsFloat := dTax;

  dIncPrice := dIncPrice * dQty;

  // Calculate and store order value as inclusive.
  FillTable.FieldByName('OrderValue').AsFloat := RoundCurrency(dIncPrice);

  // State that this item should be tracked by default.
  FillTable.FieldByName('Track').AsString := 'T';
  
  // State that the data has changed.
  bDataChanged := true;
end;

procedure TfrmRunSequencerGUI.RecheckEnteredPrices;
var
  dIncPrice, dPriceEx, dDiscount, dQty, dTax: double;
  sDescript, sMsg: string;
  bm: TBookmark;
begin
  // Now we need to pass this memory table to ensure that all
  // product prices are upto date with reflection to what is
  // set within the parts table.
  bm := memRunLines.GetBookmark;
  memRunLines.DisableControls;
  memRunLines.EnableIndexes := false;
  dsMemLines.DataSet := nil;

  memRunLines.First;
  fbInitialisingRun := true;
  while not memRunLines.Eof do begin
    if memRunLines.FieldByName('ProductID').AsInteger <> 0 then begin
      // Calculate me an ex price.
      ClientDiscount.ClientPrice_Discounts(memRunLines.FieldByName('ClientID').AsInteger, 0,
        memRunLines.FieldByName('ProductID').AsInteger, qryRuns.FieldByName('ClassID').AsInteger,
        memRunLines.FieldByName('Qty').AsFloat, qryRuns.FieldByName('RunDate').AsDateTime, 1, '', '', '', '', '',
        false, dPriceEx, dDiscount, sDescript, sMsg);

      memRunLines.Edit;

      // Calculate Ex Price Less Discount.
      memRunLines.FieldByName('OriginalExPrice').AsFloat := dPriceEx;
      memRunLines.FieldByName('Discount').AsFloat := dDiscount;
      dPriceEx := dPriceEx - (dPriceEx * dDiscount);

      // Store the Unit Ex Price.
      memRunLines.FieldByName('UnitExPrice').AsFloat := dPriceEx;

      // Calculate Inclusive Price from Ex Price.
      dIncPrice := GetAmountInc(dPriceEx, GetTaxRate(memRunLines.FieldByName('TaxCode').AsString));

      dQty := memRunLines.FieldByName('Qty').AsFloat;

      // Calculate now the tax amount if any.
      dTax := (dIncPrice - dPriceEx) * dQty;

      // Store calculate Tax Amount.
      memRunLines.FieldByName('TaxAmount').AsFloat := dTax;

      // Calculate Total Inclusive Price.
      dIncPrice := dIncPrice * dQty;
      memRunLines.FieldByName('OrderValue').AsFloat := RoundCurrency(dIncPrice);

      // Post calculated results to memory table.
      memRunLines.Post;
    end;

    // Fetch next record.
    memRunLines.Next;
  end;

  // Restore memory table record cursor position to current or first record.
  if Assigned(bm) then memRunLines.GotoBookmark(bm)
  else // Otherwise fetch first record.
    memRunLines.First;

  // Re-enable all assigned data aware controls.
  memRunLines.EnableIndexes := true;
  dsMemLines.DataSet := memRunLines;
  memRunLines.UpdateIndexes;
  memRunLines.EnableControls;
  fbInitialisingRun := false;
end;

procedure TfrmRunSequencerGUI.actResequenceExecute(Sender: TObject);
begin
  inherited;
  // Send Resequence Message.
  fbInitialisingRun := true;
  PostMessage(Self.Handle, WM_RESEQUENCE, 0, 0);
end;

procedure TfrmRunSequencerGUI.UpdateClientSequence(iOldSequence, iNewSequence: integer);
var
  iCount, iX: integer;
begin
  // Ensure sorting has been disabled.
  memCopy.SortFields := '';
  memCopy.Sort([]);

  // Get original copy of run list.
  memCopy.LoadFromDataSet(memRunLines, []);
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
  memRunLines.LoadFromDataSet(memCopy, []);
  memRunLines.Refresh;
  memRunLines.Edit;

  fbInitialisingRun := false;
end;

procedure TfrmRunSequencerGUI.UpdatePaymethod(iNewPayMethodID, iClientID, iContactID: integer);
begin
  memRunLines.DisableControls;
  // Ensure sorting has been disabled.
  memCopy.SortFields := '';
  memCopy.Sort([]);

  // Get original copy of run list.
  memCopy.LoadFromDataSet(memRunLines, []);

  // Update all entries with same sequence to match new sequence value.
  memCopy.First;
  while not memCopy.Eof do begin
    if (memCopy.FieldByName('ClientID').AsInteger = iClientID) and
      (memCopy.FieldByName('ContactID').AsInteger = iContactID) then begin
      memCopy.Edit;
      memCopy.FieldByName('PayMethodID').AsInteger := iNewPayMethodID;
      memCopy.FieldByName('PayMethodName').AsString := GetPayMethodName(iNewPayMethodID);
      memCopy.Post;
    end;
    memCopy.Next;
  end;

  // Disable filter.
  fbInitialisingRun := true;
  memRunLines.LoadFromDataSet(memCopy, []);
  fbInitialisingRun := false;
  memRunLines.EnableControls;
end;

procedure TfrmRunSequencerGUI.UpdateStartDate(dtNewDate: TDateTime; iClientID, iContactID: integer);
begin
  fbInitialisingRun := true;
  memRunLines.DisableControls;
  // Ensure sorting has been disabled.
  memCopy.SortFields := '';
  memCopy.Sort([]);

  // Get original copy of run list.
  memCopy.LoadFromDataSet(memRunLines, []);

  // Update all entries with same sequence to match new sequence value.
  memCopy.First;
  while not memCopy.Eof do begin
    if (memCopy.FieldByName('ClientID').AsInteger = iClientID) and
      (memCopy.FieldByName('ContactID').AsInteger = iContactID) then begin
      if (memCopy.FieldByName('FreqInterval').AsInteger <> 0) and (memCopy.FieldByName('FreqType').AsString <> '') then
      begin
        MyDelivery.CalcScheduledDates(memCopy.FieldByName('FreqInterval').AsInteger,
          memCopy.FieldByName('FreqType').AsString, dtNewDate);
        memCopy.Edit;
        memCopy.FieldByName('StartDate').AsDateTime := dtNewDate;

        if MyDelivery.ScheduledTimes[1] <> 0 then begin
          memCopy.FieldByName('NextRunDate').AsDateTime := dtNewDate;
          memCopy.FieldByName('DateAfterNext').AsDateTime := MyDelivery.ScheduledTimes[1];
        end else begin
          memCopy.FieldByName('NextRunDate').AsDateTime := dtNewDate;
          memCopy.FieldByName('DateAfterNext').AsDateTime := dtNewDate;
        end;

        // Save record details.
        memCopy.Post;
      end;
    end;
    // Fetch next record.
    memCopy.Next;
  end;

  // Disable filter.
  memRunLines.LoadFromDataSet(memCopy, []);
  memRunLines.EnableControls;
  fbInitialisingRun := false;
end;

procedure TfrmRunSequencerGUI.UpdateNextRunDate(dtNewDate: TDateTime; iClientID, iContactID: integer);
var
  iRecID: integer;
begin
  fbInitialisingRun := true;
  iRecID := memRunLines.FieldByName('ID').AsInteger;
  memRunLines.DisableControls;
  // Ensure sorting has been disabled.
  memCopy.SortFields := '';
  memCopy.Sort([]);

  // Get original copy of run list.
  memCopy.LoadFromDataSet(memRunLines, []);

  // Update all entries with same sequence to match new sequence value.
  memCopy.First;
  while not memCopy.Eof do begin
    if (memCopy.FieldByName('ClientID').AsInteger = iClientID) and
      (memCopy.FieldByName('ContactID').AsInteger = iContactID) then begin
      if (memCopy.FieldByName('FreqInterval').AsInteger <> 0) and
        (memCopy.FieldByName('FreqType').AsString <> '') then begin
        MyDelivery.CalcScheduledDates(memCopy.FieldByName('FreqInterval').AsInteger,
          memCopy.FieldByName('FreqType').AsString, dtNewDate);
        memCopy.Edit;
        if MyDelivery.ScheduledTimes[1] <> 0 then begin
          memCopy.FieldByName('NextRunDate').AsDateTime := dtNewDate;
          memCopy.FieldByName('DateAfterNext').AsDateTime := MyDelivery.ScheduledTimes[1];
        end else begin
          memCopy.FieldByName('NextRunDate').AsDateTime := dtNewDate;
          memCopy.FieldByName('DateAfterNext').AsDateTime := dtNewDate;
        end;

        // Save record details.
        memCopy.Post;
      end;
    end;
    // Fetch next record.
    memCopy.Next;
  end;

  // Disable filter.
  memRunLines.LoadFromDataSet(memCopy, []);
  memRunLines.Locate('ID', iRecID, [loCaseInsensitive]);
  memRunLines.EnableControls;
  memRunLines.Edit;
  fbInitialisingRun := false;
end;

procedure TfrmRunSequencerGUI.grdRunlinesTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  if fbInitialisingRun then Exit;
  inherited;
  if AFieldName = 'Company' then begin
    bShowingContact        := bShowingContact xor true;
    cboCustomer.AutoSelect := false;
    if bShowingContact then begin
      cboCustomer.Selected.Clear;
      cboCustomer.Selected.Add('Customer' + #9 + '30' + #9 + 'Contact'#9'T' + #9);
      cboCustomer.Selected.Add('Company' + #9 + '30' + #9 + 'Company'#9'T' + #9);
      cboCustomer.Selected.Add('Type' + #9 + '15' + #9 + 'Type'#9'T' + #9);
      cboCustomer.Selected.Add('Address' + #9 + '35' + #9 + 'Address'#9'T' + #9);
      grdRunLines.ColumnByName('Company').DisplayLabel := 'Contact';
    end else begin
      cboCustomer.Selected.Clear;
      cboCustomer.Selected.Add('Company' + #9 + '30' + #9 + 'Company'#9'T' + #9);
      cboCustomer.Selected.Add('Customer' + #9 + '30' + #9 + 'Contact'#9'T' + #9);
      cboCustomer.Selected.Add('Type' + #9 + '15' + #9 + 'Type'#9'T' + #9);
      cboCustomer.Selected.Add('Address' + #9 + '35' + #9 + 'Address'#9'T' + #9);
      grdRunLines.ColumnByName('Company').DisplayLabel := 'Company';
    end;

    RefreshClientList;
    cboCustomer.AutoSelect := true;
  end;
end;

procedure TfrmRunSequencerGUI.grdRunlinesCalcTitleAttributes(Sender: TObject; AFieldName: string;
  AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;
  if AFieldName = 'Company' then begin
    ABrush.Color := clBtnFace;
  end;
end;

procedure TfrmRunSequencerGUI.memRunLinesSequenceChange(Sender: TField);
begin
  inherited;
  if fbInitialisingRun then Exit;
  if memRunLines.FieldByName('ProductID').AsInteger = 0 then begin
    Exit;
  end;

  fbInitialisingRun := true;
  memRunLines.DisableControls;
  UpdateClientSequence(CurrentSequenceNumber, Sender.AsInteger);

  Application.ProcessMessages;
  CurrentSequenceNumber := Sender.AsInteger;

  fbRequestRelocate := true;
  tmrTrigger.Enabled := true;
  fbInitialisingRun := false;

  // State that the data has changed.
  bDataChanged := true;
end;

procedure TfrmRunSequencerGUI.tmrTriggerTimer(Sender: TObject);
begin
  inherited;
  if fbInitialisingRun then Exit;
  if fbRequestRelocate then begin
    if memRunLines.FieldByName('ID').AsInteger <> CurrentRecordNumber then begin
      if memRunLines.Locate('ID', CurrentRecordNumber, [loCaseInsensitive]) then begin
        CurrentSequenceNumber := memRunLines.FieldByName('Sequence').AsInteger;
      end;

      fbRequestRelocate := false;
      tmrTrigger.Enabled := false;
    end;

    memRunLines.EnableControls;
  end;

  memRunLines.Edit;
  Application.ProcessMessages;
end;

procedure TfrmRunSequencerGUI.grdRunlinesRowChanged(Sender: TObject);
begin
  if fbInitialisingRun then Exit;
  inherited;
  CurrentRecordNumber := memRunLines.FieldByName('ID').AsInteger;
  CurrentSequenceNumber := memRunLines.FieldByName('Sequence').AsInteger;
  CurrentPayMethodID := memRunLines.FieldByName('PayMethodID').AsInteger;
end;

procedure TfrmRunSequencerGUI.memRunLinesPayMethodIDChange(Sender: TField);
begin
  inherited;
  if fbInitialisingRun then Exit;
  memRunLines.DisableControls;
  CurrentSequenceNumber := memRunLines.FieldByName('Sequence').AsInteger;
  CurrentRecordNumber := memRunLines.FieldByName('ID').AsInteger;
  CurrentPayMethodID := Sender.AsInteger;
  UpdatePayMethod(CurrentPayMethodID, memRunLines.FieldByName('ClientID').AsInteger,
    memRunLines.FieldByName('ContactID').AsInteger);
  fbRequestRelocate := true;
  tmrTrigger.Enabled := true;
  Application.ProcessMessages;

  // State that the data has changed.
  bDataChanged := true;
  //  memRunLines.EnableControls;
end;

procedure TfrmRunSequencerGUI.memRunLinesAfterPost(DataSet: TDataSet);
begin
  inherited;
  if fbInitialisingRun then Exit;

  // State that the data has changed.
  bDataChanged := true;

  // Refresh Totals;
  CalcTotals;

  memRunLines.Edit;
end;

procedure TfrmRunSequencerGUI.memRunLinesQtyChange(Sender: TField);
var
  dIncPrice, dPriceEx, dDiscount, dQty, dTax: double;
  sDescript, sMsg: string;
begin
  if fbInitialisingRun then Exit;
  if memRunLines.FieldByName('ProductID').AsInteger <> 0 then begin
    memRunLines.Edit;

    // Calculate me an ex price.
    ClientDiscount.ClientPrice_Discounts(memRunLines.FieldByName('ClientID').AsInteger, 0,
      memRunLines.FieldByName('ProductID').AsInteger, AppEnv.DefaultClass.ClassID,
      Sender.AsInteger, Date(), 1, '', '', '', '', '',
      false, dPriceEx, dDiscount, sDescript, sMsg);

    // Ex price is original ex part price - discount.
    memRunLines.FieldByName('Discount').AsFloat := dDiscount;
    memRunLines.FieldByName('OriginalExPrice').AsFloat := dPriceEx;
    dPriceEx := dPriceEx - (dPriceEx * dDiscount);

    // Store
    memRunLines.FieldByName('UnitExPrice').AsFloat := dPriceEx;

    // Get Inclusive price.
    dIncPrice := GetAmountInc(dPriceEx, GetTaxRate(memRunLines.FieldByName('TaxCode').AsString));

    // Store tax amount.
    dQty := Sender.AsInteger;

    // Calculate now the tax amount if any.
    dTax := (dIncPrice - dPriceEx) * dQty;
    memRunLines.FieldByName('TaxAmount').AsFloat := dTax;

    dIncPrice := dIncPrice * dQty;

    // Calculate and store order value as inclusive.
    memRunLines.FieldByName('OrderValue').AsFloat := RoundCurrency(dIncPrice);
  end;

  bDataChanged := true;
  CalcTotals;
end;

procedure TfrmRunSequencerGUI.grdRunlinesEnter(Sender: TObject);
begin
  if fbInitialisingRun then Exit;

  inherited;

  CurrentSequenceNumber := memRunLines.FieldByName('Sequence').AsInteger;
  CurrentRecordNumber := memRunLines.FieldByName('ID').AsInteger;
  CurrentPayMethodID := memRunLines.FieldByName('PayMethodID').AsInteger;
end;

procedure TfrmRunSequencerGUI.CalcTotals;
var
  dQty: double;
  dTotalInc: double;
  mem: TkbmMemTable;
begin
  mem := TkbmMemTable.Create(nil);
  try
    mem.LoadFromDataSet(memRunLines, [mtcpoStructure, mtcpoProperties]);
    dQty      := 0;
    dTotalInc := 0;

    // Calculate Totals
    mem.First;
    while not mem.Eof do begin
      // Accumulate these totals.
      dQty := dQty + mem.FieldByName('Qty').AsFloat;
      dTotalInc := dTotalInc + mem.FieldByName('OrderValue').AsFloat;

      // Fetch next Record.
      mem.Next;
    end;

    // Show footer values.
    grdRunLines.ColumnByName('Qty').FooterValue        := FloatToStrF(dQty, ffGeneral, 15, 2);
    grdRunLines.ColumnByName('OrderValue').FooterValue := FloatToStrF(dTotalInc, ffCurrency, 15, 2);

  finally
    // Free our used objects.
    if Assigned(mem) then
      FreeandNil(mem);
  end;
end;


function TfrmRunSequencerGUI.IsRunListOk: boolean;
var
  iRec: integer;
begin
  Result := true;
  iRec := memRunLines.FieldByName('ID').AsInteger;
  memRunLines.DisableControls;
  memRunLines.First;
  while not memRunLines.Eof do begin
    if memRunLines.FieldByName('ClientID').AsInteger = 0 then begin
      Result := false;
      CommonLib.MessageDlgXP_Vista('Each record must have a valid company / contact selected.   Please specify and retry again.',
        mtWarning, [mbOK], 0);
      memRunLines.EnableControls;
      Exit;
    end;

    if memRunLines.FieldByName('Address').AsString = '' then begin
      Result := false;
      CommonLib.MessageDlgXP_Vista('Each record must have a valid destination address.   Please specify and retry again.', mtWarning, [mbOK], 0);
      memRunLines.EnableControls;
      Exit;
    end;

    if (memRunLines.FieldByName('Sequence').AsInteger = 0) and (memRunLines.FieldByName('Sequence').IsNull) then begin
      Result := false;
      CommonLib.MessageDlgXP_Vista('Each company / contact must have a valid sequence order number.   Please specify and retry again.',
        mtWarning, [mbOK], 0);
      memRunLines.EnableControls;
      Exit;
    end;

    if memRunLines.FieldByName('ProductID').AsInteger = 0 then begin
      Result := false;
      CommonLib.MessageDlgXP_Vista('Each record must have a valid product selected.   Please specify and retry again.', mtWarning, [mbOK], 0);
      memRunLines.EnableControls;
      Exit;
    end;

    if (memRunLines.FieldByName('Qty').AsInteger = 0) and (memRunLines.FieldByName('Qty').IsNull) then begin
      Result := false;
      CommonLib.MessageDlgXP_Vista('Each company / contact must have a valid quantity amount against its selected product.   Please specify and retry again.',
        mtWarning, [mbOK], 0);
      memRunLines.EnableControls;
      Exit;
    end;

    if (memRunLines.FieldByName('NextRunDate').IsNull) then begin
      Result := false;
      CommonLib.MessageDlgXP_Vista('Each record entry must have a Next Run Delivery Date.   Please specify and retry again.',
        mtWarning, [mbOK], 0);
      memRunLines.EnableControls;
      Exit;
    end;

    if (memRunLines.FieldByName('StartDate').IsNull) then begin
      Result := false;
      CommonLib.MessageDlgXP_Vista('Each company / contact must have a valid starting date.   Please specify and retry again.',
        mtWarning, [mbOK], 0);
      memRunLines.EnableControls;
      Exit;
    end;

    if (memRunLines.FieldByName('FreqInterval').AsInteger = 0) and (memRunLines.FieldByName('FreqInterval').IsNull) then
    begin
      Result := false;
      CommonLib.MessageDlgXP_Vista('Each company / contact must have a valid delivery frequency set.   Please specify and retry again.',
        mtWarning, [mbOK], 0);
      memRunLines.EnableControls;
      Exit;
    end;

    if (memRunLines.FieldByName('FreqType').IsNull) then begin
      Result := false;
      CommonLib.MessageDlgXP_Vista('Each company / contact must have a valid delivery frequency set.   Please specify and retry again.',
        mtWarning, [mbOK], 0);
      memRunLines.EnableControls;
      Exit;
    end;

    // Fetch next record.
    memRunLines.Next;
  end;

  memRunLines.EnableControls;
  memRunLines.Locate('ID', iRec, [loCaseInsensitive]);
end;

procedure TfrmRunSequencerGUI.dtExcludeFromCloseUp(Sender: TObject);
begin
  // State that the data has changed.
  bDataChanged := true;
end;

procedure TfrmRunSequencerGUI.dtExcludeToCloseUp(Sender: TObject);
begin
  // State that the data has changed.
  bDataChanged := true;
end;

procedure TfrmRunSequencerGUI.cboCustomerNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  // Dont inherit and dont accept!
  Accept := false;
end;

procedure TfrmRunSequencerGUI.cboPartsNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: boolean);
begin
  // Dont Inherit and dont accept
  Accept := false;
end;

procedure TfrmRunSequencerGUI.cboPayMethodChange(Sender: TObject);
begin
  if fbInitialisingRun then Exit;
  inherited;
  memRunLines.Edit;
end;

procedure TfrmRunSequencerGUI.memRunLinesExcludeFromChange(Sender: TField);
begin
  if fbInitialisingRun then Exit;
  inherited;
  CheckExclusionDates;

  memRunLines.EnableControls;
end;

procedure TfrmRunSequencerGUI.memRunLinesExcludeToChange(Sender: TField);
begin
  if fbInitialisingRun then Exit;
  inherited;
  CheckExclusionDates;

  memRunLines.EnableControls;
end;

procedure TfrmRunSequencerGUI.RefreshClientList;
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
  qryCustomer.SQL.Add('IF(ISNULL(Country), "", C.Country)), 200)) AS Address, C.Phone, C.FaxNumber AS Fax, Mobile, 0 AS ContactID');
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
  qryCustomer.SQL.Add('LEFT JOIN tblClients Cl ON Cl.ClientID = C.CusID');
  qryCustomer.SQL.Add
  ('WHERE (C.Active = "T" AND C.UseOnRun="T" AND C.ContactIsCustomer="F" AND C.ContactIsJob="F" AND C.ContactIsSupplier="F" AND C.ContactIsOtherContact="F" AND (Cl.Customer="T" OR Cl.IsJob="T"))');

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

procedure TfrmRunSequencerGUI.chkShowCompanyClick(Sender: TObject);
begin
  inherited;
  AppEnv.Employee.ShowCompanyAsDefaultOnRun := chkShowCompany.Checked;
end;

procedure TfrmRunSequencerGUI.memRunLinesExcludeChange(Sender: TField);
begin
  if fbInitialisingRun then Exit;
  inherited;
  CheckExclusionDates;
  if memRunLines.FieldByName('Exclude').AsString = 'F' then begin
    memRunLines.Edit;
    memRunLines.FieldByName('ExcludeFrom').AsVariant := NULL;
    memRunLines.FieldByName('ExcludeTo').AsVariant   := NULL;
    memRunLines.EnableControls;
  end;
end;

procedure TfrmRunSequencerGUI.grdRunlinesCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  if fbInitialisingRun then Exit;
  inherited;
  // This function makes the font colour to the same colour as the title colour
  // if the field contents equal to a value of 0 (Zero).
  if (Field.FieldName = 'FreqInterval') or (Field.FieldName = 'Qty') or
    (Field.FieldName = 'OrderValue') then begin
    if memRunLines.FieldByName(Field.FieldName).AsVariant = 0 then begin
      AFont.Color := TwwDBGrid(Sender).TitleColor;
    end;
  end;

  // Highlight any rows that match our search criteria
  // if one has been provided.
  if chkShowCompany.Checked then begin
    if (not Empty(txtSearch.Text)) and (not (gdSelected in State) or not TwwDBGrid(Sender).Focused) and
      (FastFuncs.PosEx(FastFuncs.UpperCase(ReplaceStr(ReplaceStr(txtSearch.Text, '%', ''), '*', '')),
      FastFuncs.UpperCase(memRunLines.FieldByName('ClientName').AsString)) = 1) then begin
      ABrush.Color := HIGHLIGHTLOCATE;
    end;
  end else begin
    if (not Empty(txtSearch.Text)) and (not (gdSelected in State) or not TwwDBGrid(Sender).Focused) and
      (FastFuncs.PosEx(FastFuncs.UpperCase(ReplaceStr(ReplaceStr(txtSearch.Text, '%', ''), '*', '')),
      FastFuncs.UpperCase(memRunLines.FieldByName('Company').AsString)) = 1) then begin
      ABrush.Color := HIGHLIGHTLOCATE;
    end;
  end;
end;

procedure TfrmRunSequencerGUI.memRunLinesFreqTypeChange(Sender: TField);
begin
  if fbInitialisingRun then Exit;
  inherited;
  if Sender.AsString = 'Time Only' then begin
    memRunLines.Edit;
    memRunLines.FieldByName('FreqInterval').AsInteger := 1;
  end;
end;

procedure TfrmRunSequencerGUI.memRunLinesFreqIntervalChange(Sender: TField);
begin
  inherited;
  if fbInitialisingRun then Exit;

  if memRunLines.FieldByName('FreqType').AsString = 'Time Only' then begin
    if Sender.AsInteger <> 1 then begin
      memRunLines.Edit;
      memRunLines.FieldByName('FreqInterval').AsInteger := 1;
    end;
  end;

  if memRunLines.FieldByName('NextRunDate').AsDateTime <> 0 then begin
    MyDelivery.CalcScheduledDates(memRunLines.FieldByName('FreqInterval').AsInteger,
      memRunLines.FieldByName('FreqType').AsString,
      memRunLines.FieldByName('NextRunDate').AsDateTime);
    //memRunLines.FieldByName('StartDate').AsDateTime);
  end else begin
    MyDelivery.CalcScheduledDates(memRunLines.FieldByName('FreqInterval').AsInteger,
      memRunLines.FieldByName('FreqType').AsString,
      memRunLines.FieldByName('StartDate').AsDateTime);
  end;

  memRunLines.Edit;
  if MyDelivery.ScheduledTimes[1] = 0 then begin
    memRunLines.FieldByName('NextRunDate').AsDateTime   := memRunLines.FieldByName('StartDate').AsDateTime;
    memRunLines.FieldByName('DateAfterNext').AsDateTime := memRunLines.FieldByName('StartDate').AsDateTime;
  end else begin
    //      memRunLines.FieldByName('NextRunDate').AsDateTime := MyDelivery.ScheduledTimes[1];
    memRunLines.FieldByName('DateAfterNext').AsDateTime := MyDelivery.ScheduledTimes[1];
  end;

  fbInitialisingRun := true;
  if memRunLines.State in [dsEdit, dsInsert] then memRunLines.Post;
  fbInitialisingRun := false;
  memRunLines.Edit;
  
  bDataChanged := true;
end;

procedure TfrmRunSequencerGUI.dtStartDateCloseUp(Sender: TObject);
begin
  inherited;
  memRunLines.Edit;
  bDataChanged := true;
end;

procedure TfrmRunSequencerGUI.cboFreqTypeCloseUp(Sender: TwwDBComboBox; Select: boolean);
begin
  inherited;
  if fbInitialisingRun then Exit;
  fbInitialisingRun := true;
  if (memRunLines.State = dsEdit) or (memRunLines.State = dsInsert) then begin
    memRunLines.Post;
    memRunLines.Edit;
  end;

  if memRunLines.FieldByName('LastDelivery').AsDateTime <> 0 then begin
    MyDelivery.CalcScheduledDates(memRunLines.FieldByName('FreqInterval').AsInteger,
      memRunLines.FieldByName('FreqType').AsString,
      memRunLines.FieldByName('NextRunDate').AsDateTime);
  end else begin
    MyDelivery.CalcScheduledDates(memRunLines.FieldByName('FreqInterval').AsInteger,
      memRunLines.FieldByName('FreqType').AsString,
      memRunLines.FieldByName('StartDate').AsDateTime);
  end;
  
  memRunLines.Edit;
  if MyDelivery.ScheduledTimes[1] = 0 then begin
    memRunLines.FieldByName('NextRunDate').AsDateTime   := memRunLines.FieldByName('StartDate').AsDateTime;
    memRunLines.FieldByName('DateAfterNext').AsDateTime := memRunLines.FieldByName('StartDate').AsDateTime;
  end else begin
    //      memRunLines.FieldByName('NextRunDate').AsDateTime := MyDelivery.ScheduledTimes[1];
    memRunLines.FieldByName('DateAfterNext').AsDateTime := MyDelivery.ScheduledTimes[1];
  end;

  fbInitialisingRun := false;
  bDataChanged := true;
end;

procedure TfrmRunSequencerGUI.memRunLinesStartDateChange(Sender: TField);
begin
  if fbInitialisingRun then Exit;
  inherited;
  memRunLines.DisableControls;

  // Grab our current record details and store to related properties
  CurrentSequenceNumber := memRunLines.FieldByName('Sequence').AsInteger;
  CurrentRecordNumber := memRunLines.FieldByName('ID').AsInteger;

  // Update client with same start date.  No matter what here
  // that all entries that relate to this client must match.
  UpdateStartDate(Sender.AsDateTime, memRunLines.FieldByName('ClientID').AsInteger,
    memRunLines.FieldByName('ContactID').AsInteger);

  // Request a relocate to this record after update.
  fbRequestRelocate := true;
  tmrTrigger.Enabled := true;

  Application.ProcessMessages;

  // State that the data has changed.
  bDataChanged := true;
end;

procedure TfrmRunSequencerGUI.CheckExclusionDates;
var
  iX: integer;
  LastRunDate: TDateTime;
begin
  if fbInitialisingRun then Exit;
  inherited;

  if memRunLines.FieldByName('LastDelivery').IsNull then begin
    LastRunDate := memRunLines.FieldByName('StartDate').AsDateTime;
    memRunLines.FieldByName('NextRunDate').AsDateTime := LastRunDate;
  end else begin
    LastRunDate := memRunLines.FieldByName('LastDelivery').AsDateTime;
    MyDelivery.CalcScheduledDates(memRunLines.FieldByName('FreqInterval').AsInteger,
      memRunLines.FieldByName('FreqType').AsString,
      LastRunDate);
    memRunLines.FieldByName('NextRunDate').AsDateTime := MyDelivery.ScheduledTimes[1];
  end;

  if LastRunDate = memRunLines.FieldByName('NextRunDate').AsDateTime then Exit;


  if (not memRunLines.FieldByName('ExcludeFrom').IsNull) and (not memRunLines.FieldByName('ExcludeTo').IsNull) then begin
    MyDelivery.CalcScheduledDates(memRunLines.FieldByName('FreqInterval').AsInteger,
      memRunLines.FieldByName('FreqType').AsString,
      memRunLines.FieldByName('NextRunDate').AsDateTime);


    if memRunLines.FieldByName('Exclude').AsString = 'T' then begin
      iX := 1;
      while iX <= MAX_SCHEDULED_DATES do begin
        if (MyDelivery.ScheduledTimes[iX] > memRunLines.FieldByName('ExcludeFrom').AsDateTime) and
          (MyDelivery.ScheduledTimes[iX] > memRunLines.FieldByName('ExcludeTo').AsDateTime) then begin
          fbInitialisingRun := true;
          memRunLines.Edit;
          memRunLines.FieldByName('NextRunDate').AsDateTime := MyDelivery.ScheduledTimes[iX];
          if iX < MAX_SCHEDULED_DATES then begin
            memRunLines.FieldByName('DateAfterNext').AsDateTime := MyDelivery.ScheduledTimes[iX + 1];
          end;
          fbInitialisingRun := false;
          Break;
        end;
        Inc(iX);
      end;
    end else begin
      fbInitialisingRun := true;
      memRunLines.Edit;
      if MyDelivery.ScheduledTimes[1] = 0 then begin
        memRunLines.FieldByName('NextRunDate').AsDateTime := memRunLines.FieldByName('StartDate').AsDateTime;
        memRunLines.FieldByName('DateAfterNext').AsDateTime := memRunLines.FieldByName('StartDate').AsDateTime;
      end else begin
        //            memRunLines.FieldByName('NextRunDate').AsDateTime := MyDelivery.ScheduledTimes[1];
        memRunLines.FieldByName('DateAfterNext').AsDateTime := MyDelivery.ScheduledTimes[1];
      end;
      fbInitialisingRun := false;
    end;
  end;
end;

procedure TfrmRunSequencerGUI.memRunLinesPayMethodNameChange(Sender: TField);
begin
  if fbInitialisingRun then Exit;
  memRunLines.Edit;
  memRunLines.FieldByName('PayMethodID').AsInteger := qryPayment.FieldByName('PayMethodID').AsInteger;

  // State that the data has changed.
  bDataChanged := true;
end;

procedure TfrmRunSequencerGUI.txtSearchChange(Sender: TObject);
begin
  inherited;
  if chkShowCompany.Checked then begin
    memRunLines.Locate('ClientName', ReplaceStr(ReplaceStr(txtSearch.Text, '%', ''), '*', ''),
      [loCaseInsensitive, loPartialKey]);
  end else begin
    memRunLines.Locate('Company', ReplaceStr(ReplaceStr(txtSearch.Text, '%', ''), '*', ''),
      [loCaseInsensitive, loPartialKey]);
  end;
end;

procedure TfrmRunSequencerGUI.btnExportClick(Sender: TObject);
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
    slFilter.Add('ClientID');
    slFilter.Add('ContactID');
    slFilter.Add('ProductID');
    slFilter.Add('PreferedSupp');
    slFilter.Add('PayMethodID');
    slFilter.Add('GlobalRef');

    // Request for a save filename
    DecodeDate(Date, wYear, wMonth, wDay);
    SaveDialog1.FileName := cboRunName.Text + '_Template_' + FastFuncs.IntToStr(wDay) + '-' + FastFuncs.IntToStr(wMonth) +
      '-' + FastFuncs.IntToStr(wYear) + '.csv';
    if SaveDialog1.Execute then begin
      // Save CSV Export File.
      oDataSaver.SaveDatasetToCVS(memRunLines, SaveDialog1.FileName);
    end;
  finally
    // Release our used objects.
    if Assigned(slFilter) then
      FreeandNil(slFilter);
  end;
end;

procedure TfrmRunSequencerGUI.Export1Click(Sender: TObject);
begin
  btnExportClick(Sender);
end;

//procedure TfrmRunSequencerGUI.After_GetPreviousSettings;
//begin
//  grdRunlines.ColumnByName('FreqInterval').GroupName := 'Frequency';
//  grdRunlines.ColumnByName('FreqType').GroupName := 'Frequency';
//  grdRunlines.ColumnByName('ClientName').ReadOnly := true;
//  grdRunlines.ColumnByName('TaxCode').ReadOnly := true;
//
//  if AppEnv.CompanyPrefs.AutoCorrectPriceDiscountsOnDeliveries then begin
//    grdRunlines.ColumnByName('OrderValue').ReadOnly := true;
//  end else begin
//    grdRunlines.ColumnByName('OrderValue').ReadOnly := false;
//  end;
//
//  grdRunlines.ColumnByName('DateAfterNext').ReadOnly := true;
//end;

procedure TfrmRunSequencerGUI.memRunLinesNextRunDateChange(Sender: TField);
begin
  if fbInitialisingRun then Exit;
  UpdateNextRunDate(Sender.AsDateTime, memRunLines.FieldByName('ClientID').AsInteger,
    memRunLines.FieldByName('ContactID').AsInteger);
  bDataChanged := true;
end;

procedure TfrmRunSequencerGUI.chkExcludeClick(Sender: TObject);
begin
  if fbInitialisingRun then Exit;
  fbInitialisingRun := true;
  if not TwwCheckBox(Sender).DataSource.DataSet.Active then Exit;
  TwwCheckBox(Sender).DataSource.DataSet.Edit;
  if TwwCheckBox(Sender).Checked then TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString :=
      'T'
  else TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'F';

  bDataChanged := true;
  fbInitialisingRun := false;
end;

procedure TfrmRunSequencerGUI.memRunLinesOrderValueChange(Sender: TField);
var
  dTax: double;
begin
  if fbInitialisingRun then Exit;
  fbInitialisingRun := true;
  dTax := Sender.AsFloat - GetAmountEx(Sender.AsFloat, GetTaxRate(memRunLines.FieldByName('TaxCode').AsString));
  memRunLines.Edit;
  memRunLines.FieldByName('TaxAmount').AsFloat := dTax;
  memRunLines.Post;
  memRunLines.Edit;
  bDataChanged := true;
  fbInitialisingRun := false;
end;

procedure TfrmRunSequencerGUI.memRunLinesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //
end;

function TfrmRunSequencerGUI.NoDuplicatesInRun: boolean;
var
  memLines, memQry: TKbmMemTable;
begin
  Result := true;
  memLines := TKbmMemTable.Create(nil);
  memQry := TKbmMemTable.Create(nil);
  try
    memQry.Filtered := false;
    memQry.Filter   := '';
    memQry.LoadFromDataSet(memRunLines, [mtcpoStructure]);
    memLines.LoadFromDataSet(memRunLines, [mtcpoStructure]);
    while not memLines.Eof do begin
      memQry.Filtered := false;
      if memLines.FieldByName('IsContact').AsBoolean then begin
        memQry.Filter := 'ClientID = ' + QuotedStr(memLines.FieldByName('ClientID').AsString) +
          ' AND ' + 'ContactID = ' + QuotedStr(memLines.FieldByName('ContactID').AsString) + ' AND ' +
          'IsContact = ' + QuotedStr(memLines.FieldByName('IsContact').AsString) + ' AND ' + 'ProductID = ' +
          QuotedStr(memLines.FieldByName('ProductID').AsString);
      end else begin
        memQry.Filter := 'ClientID = ' + QuotedStr(memLines.FieldByName('ClientID').AsString) +
          ' AND ' + 'IsContact = ' + QuotedStr(memLines.FieldByName('IsContact').AsString) + ' AND ' +
          'ProductID = ' + QuotedStr(memLines.FieldByName('ProductID').AsString);
      end;

      memQry.Filtered := true;
      // Has the same product been assigned to this customer?
      if memQry.RecordCount > 1 then begin
        // Report Duplicate Part Error.
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
    if Assigned(memLines) then FreeAndNil(memLines);
    if Assigned(memQry) then FreeAndNil(memqry);
  end;
end;

procedure TfrmRunSequencerGUI.dtNextRunCloseUp(Sender: TObject);
begin
  inherited;
  bDataChanged := true;
end;

procedure TfrmRunSequencerGUI.memRunLinesAddressChange(Sender: TField);
begin
  inherited;
  if fbInitialisingRun then Exit;
  bDataChanged := true;
end;

procedure TfrmRunSequencerGUI.memRunLinesClientNameChange(Sender: TField);
begin
  inherited;
  if fbInitialisingRun then Exit;
  bDataChanged := true;
end;

initialization
  RegisterClassOnce(TfrmRunSequencerGUI);
  with FormFact do begin
    RegisterMe(TfrmRunSequencerGUI, 'TRunAssignerGUI_*=RunID');
  end;
end.



