{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/08/05  1.00.01 BJ   Spelling mistake corrected - Dispatch was spelled Despatch .
 }
unit frmRunDespatchCreatorFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ComCtrls, StdCtrls, Buttons, DNMSpeedButton, CheckLst, ExtCtrls,
  DNMPanel, DBAccess, MyAccess, SelectionDialog, AppEvnts, DB,  MemDS,
  ActnList, ActnMan, DeliveryObj, wwdblook, Math, ClientDiscountObj,
  DataState, Menus, AdvMenus, Shader, PlatformDefaultStyleActnCtrls,
  ProgressDialog, ERPdbComponents, ImgList;

type
  TfrmRunDespatchCreator = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    lstRuns: TCheckListBox;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    ProgressBar1: TProgressBar;
    lblProgress: TLabel;
    ProgressBar2: TProgressBar;
    Label3: TLabel;
    Label4: TLabel;
    btnSelectAll: TDNMSpeedButton;
    btnUnselectAll: TDNMSpeedButton;
    Label5: TLabel;
    chkWarning: TCheckBox;
    qryRuns: TMyQuery;
    qryRunLines: TMyQuery;
    ActionManager1: TActionManager;
    actSave: TAction;
    qryHolidays: TMyQuery;
    qryClass: TMyQuery;
    qryClassClassName: TStringField;
    qryClassClassID: TIntegerField;
    Label7: TLabel;
    cboClass: TwwDBLookupCombo;
    chkCreateHolidays: TCheckBox;
    Label6: TLabel;
    dtFrom: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    dtTo: TDateTimePicker;
    chkShowReports: TCheckBox;
    Label8: TLabel;
    chkShowLogs: TCheckBox;
    Label9: TLabel;
    chkShowLogFile: TCheckBox;
    Label10: TLabel;
    Label11: TLabel;
    chkShowLogList: TCheckBox;
    Label12: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnUnselectAllClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure actSaveUpdate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actSaveExecute(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkShowLogsClick(Sender: TObject);
    procedure chkShowLogFileClick(Sender: TObject);
    procedure chkShowLogListClick(Sender: TObject);

  private
    { Private declarations }
    MyDelivery: TDeliveryObj;
    ClientDiscount: TClientDiscountObj;
    LogList: TStringList;
    fsTablename:String;
    
    procedure BuildRunList;
    procedure CreateTemporaryTable;
    procedure DestroyTemporaryTable;
    procedure AddLogListEntry(const sState, sCompany, sContact, sDescription: string; const RunDate: TDateTime; const DespatchRunID: integer);
    procedure AddLogHeaderEntry(const sState, sDescription: string; const RunDate: TDateTime; const DespatchRunID: integer);

  public
    { Public declarations }
    

  end;

const
  LOG_TABLENAME = 'logs';

//var
//  frmRunDespatchCreator: TfrmRunDespatchCreator;

implementation

{$R *.dfm}

uses
  CommonDbLib, DNMExceptions, DNMLib,  FormFactory, frmRunDespatch,
   frmLogs, RunCreationLogsList, CommonLib, AppEnvironment,
  FastFuncs;

{ TfrmRunDespatchCreator }

procedure TfrmRunDespatchCreator.FormDestroy(Sender: TObject);
begin
  DestroyTemporaryTable;
  if Assigned(LogList) then FreeAndNil(LogList);
  if Assigned(MyDelivery) then FreeAndNil(MyDelivery);
  if Assigned(ClientDiscount) then FreeAndNil(ClientDiscount);
  inherited;
end;

procedure TfrmRunDespatchCreator.FormCreate(Sender: TObject);
begin
  fsTableName := GetUserTemporaryTableName(LOG_TABLENAME);
  CheckRunLinesForExistingFields;

  inherited;
  LogList := TStringList.Create;
  // Create our delivery object.
  MyDelivery := TDeliveryObj.Create;

  // Create our discount object.
  ClientDiscount := TClientDiscountObj.Create;

  qryRunLines.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryRunLines.ParamCheck := true;
  qryRuns.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryHolidays.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryHolidays.ParamCheck := true;
  qryClass.Connection := CommonDbLib.GetSharedMyDacConnection;

  CreateTemporaryTable;

  Label3.Caption := '';
  dtFrom.DateTime := Date;
  dtFrom.MaxDate := Date;
  dtTo.MinDate := Date;
  dtTo.DateTime := Date() + 7.0;
end;

procedure TfrmRunDespatchCreator.FormShow(Sender: TObject);
var
  QueriesNotToOpen: array of string;
begin
  try
    inherited;
    // Open queries except excluded.
    SetLength(QueriesNotToOpen, 2);
    QueriesNotToOpen[0] := 'qryRunLines';
    QueriesNotToOpen[1] := 'qryHolidays';
    OpenQueries;

    // Build Run List.
    BuildRunList;

    // Is there a class been set for our invoices.
    if cboClass.Text = '' then begin
      // No! Force default class.
      qryClass.Locate('ClassID', AppEnv.DefaultClass.ClassID, [loCaseInsensitive]);
      cboClass.Text := AppEnv.DefaultClass.DefaultClassName;
    end;

    // Exception Handler
  except
    // Handle these known exceptions.
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TfrmRunDespatchCreator.BuildRunList;
var
  iX: integer;
begin
  // Clear list box.
  lstRuns.Clear;

  // Create run list.
  while not qryRuns.Eof do begin
    lstRuns.Items.Add(qryRuns.FieldByName('RunName').AsString);
    qryRuns.Next;
  end;

  // Select all runs by default.
  for iX := 0 to lstRuns.Count - 1 do begin
    lstRuns.Checked[iX] := true;
  end;

  // Return to first record.
  qryRuns.First;
end;

procedure TfrmRunDespatchCreator.btnSelectAllClick(Sender: TObject);
var
  iX: integer;
begin
  inherited;
  if lstRuns.Count = 0 then Exit;
  for iX := 0 to lstRuns.Count - 1 do begin
    lstRuns.Checked[iX] := true;
  end;
end;

procedure TfrmRunDespatchCreator.btnUnselectAllClick(Sender: TObject);
var
  iX: integer;
begin
  inherited;
  if lstRuns.Count = 0 then Exit;
  for iX := 0 to lstRuns.Count - 1 do begin
    lstRuns.Checked[iX] := false;
  end;
end;

procedure TfrmRunDespatchCreator.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmRunDespatchCreator.actSaveUpdate(Sender: TObject);
  // Any runs selected within list
  function IsAnyRunsSelected: boolean;
  var
    iX: integer;
  begin
    Result := false;
    if lstRuns.Count = 0 then Exit;
    for iX := 0 to lstRuns.Count - 1 do begin
      if lstRuns.Checked[iX] then begin
        Result := true;
        Exit;
      end;
    end;
  end;
begin
  if cboClass.Text = '' then begin
    btnOk.Enabled := false;
    Exit;
  end;

  if not IsAnyRunsSelected then begin
    btnOk.Enabled := false;
    Exit;
  end;

  btnOk.Enabled := true;
end;

procedure TfrmRunDespatchCreator.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmRunDespatchCreator.actSaveExecute(Sender: TObject);
var
  qryDespatchRun, qryDespatchRunLines, qry: TMyQuery;
  iResult, iID, iSeq, iCurrentClientID: integer;
  dIncPrice, dPriceEx, dDiscount, dQty, dTax: double;
  sDescript: string;
  bFound, bIsHoliday: boolean;
  iX, iTotalDays: integer;
  dtCurrentDate, dtBaseDate: TDateTime;
  bCloseForm: boolean;
  frm: TfrmRunDespatchGUI;
  sMsg: string;
  Form : TComponent;
begin
  inherited;
  // Create our required objects.
  iID := 0;
  qry := TMyQuery.Create(nil);
  qryDespatchRun := TMyQuery.Create(nil);
  qryDespatchRunLines := TMyQuery.Create(nil);
  bCloseForm := false;
  try
    // Setup our queries.
    qry.Connection   := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck   := true;
    qryDespatchRun.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryDespatchRun.ParamCheck := true;
    qryDespatchRunLines.Connection := CommonDbLib.GetSharedMyDacConnection;
    dtCurrentDate    := dtFrom.DateTime;
    dtBaseDate       := dtCurrentDate;
    iTotalDays       := Floor(dtTo.DateTime - dtCurrentDate);
    ProgressBar1.Max := iTotalDays - 1;
    ProgressBar1.Position := 0;
    LogList.Clear;

    DeleteContentsFromUserTemporaryTable(fsTableName);

    LogList.Add('===============================================================');
    LogList.Add('================* RUN CREATION PROCESS STARTED *===============');
    LogList.Add('===============================================================');

    //////////////////////////
    // Set our date scan range.
    //////////////////////////
    while dtCurrentDate <= (dtBaseDate + iTotalDays) do begin
      ProgressBar2.Position := 0;
      Application.ProcessMessages;

      bIsHoliday := false;
      // Are we to double up a previous due to next run been a holiday?
      if not chkCreateHolidays.Checked then begin
        // Check for a public holiday.
        qryHolidays.Close;
        qryHolidays.Params.ParamByName('xDate').AsDateTime := dtCurrentDate;
        qryHolidays.Open;

        // If a record has been found then a holiday record
        // has been found and therefore we do not create
        // a despatch run for this day as people are usually
        // off.
        if qryHolidays.RecordCount > 0 then begin
          // Point to the next day.
          dtCurrentDate := dtCurrentDate + 1;
          ProgressBar1.StepIt;
          Application.ProcessMessages;
          Continue;
        end;
      end;

      for iX := 0 to lstRuns.Count - 1 do begin
        // Is this a selected run to setup for despatch?
        if not lstRuns.Checked[iX] then begin
          Label3.Caption := 'Bypassing ....';
          Application.ProcessMessages;
          Continue;
        end;

        // First thing we will need to do is load in the run template
        if qryRuns.Locate('RunName', lstRuns.Items.Strings[iX], [loCaseInsensitive]) then begin
          // Now retrieve run lines records.
          qryRunLines.Filtered := false;
          qryRunLines.Close;
          qryRunLines.Params.ParamByName('xRunID').AsInteger := qryRuns.FieldByName('RunID').AsInteger;
          qryRunLines.Open;

          // Next check to see if we have any clients for this scheduled date.
          bFound := false;
          qryRunLines.Filtered := false;
          qryRunLines.Filter := 'NextRunDate = ' + QuotedStr(DateToStr(dtCurrentDate));
          qryRunLines.Filtered := true;
          if qryRunLines.RecordCount > 0 then begin
            bFound := true;
          end;

          // If we have no entries to add to this despatch
          // run then work on next run
          if not bFound then begin
            Label3.Caption := 'Nothing Scheduled ....';
            AddLogHeaderEntry('Nothing Scheduled', lstRuns.Items.Strings[iX], dtCurrentDate, 0);
            Application.ProcessMessages;
            Continue;
          end;

          // Reset Run Progress Status.
          qryRunLines.First;
          Label3.Caption := lstRuns.Items.Strings[iX];
          ProgressBar2.Max := qryRunLines.RecordCount - 1;
          ProgressBar2.Position := 0;
          Application.ProcessMessages;

          if qryRunLines.RecordCount > 0 then begin
            // First we need to determine if this actual run they
            // are wanting to transfer to despatch area is currently
            // present or not.  If it is, they have to be asked on what
            // to do.
            qry.SQL.Clear;
            qry.SQL.Add('SELECT * FROM tbldespatchruns WHERE RunID = :xRunID AND RunDate = :xDate');
            qry.Params.ParamByName('xRunID').AsInteger := qryRuns.FieldByName('RunID').AsInteger;
            qry.Params.ParamByName('xDate').AsDateTime := dtCurrentDate;
            qry.Open;

            // Do we have an existing despatch run already for this scheduled date?
            if not chkWarning.Checked then begin
              if qry.RecordCount > 0 then begin
                // Grab this despatch ID and close despatch runs
                // query as we are finished with it.
                iID := qry.FieldByName('DespatchID').AsInteger;

                // Has this run been completed?
                if qry.FieldByName('Done').AsBoolean then begin
                  Label3.Caption := 'Bypassing completed run ....';
                  AddLogListEntry('WARNING', '', '', 'Run already has been despatched and completed!', dtCurrentDate, iID);
                  Application.ProcessMessages;
                  qry.Close;
                  Continue;
                end else begin
                  // No, then inform user of warning!
                  iResult := CommonLib.MessageDlgXP_Vista('It appears that a despatch run already exists under this scheduled date!' +
                    #13 + #10 + 'Would you like to replace it with this run outlay instead?' + #13 + #10 + #13 + #10 +
                    'Select OK to replace existing run or please press cancel to abort.', mtWarning, [mbOK, mbCancel], 0);

                  // If the user canceled, then out we go!
                  if iResult = mrCancel then begin
                    Label3.Caption := 'Bypassing existing run ....';
                    AddLogListEntry('BYPASSED', '', '', 'Bypassed existing despatch run!', dtCurrentDate, iID);
                    Application.ProcessMessages;
                    qry.Close;
                    Continue;
                  end;

                  // Close despatch runs query.
                  qry.Close;
                end;

                // Delete Despatch Run Header Entry.
                qry.SQL.Clear;
                qry.SQL.Add('DELETE FROM tbldespatchruns WHERE DespatchID = :xDespatchID');
                qry.Params.ParamByName('xDespatchID').AsInteger := iID;
                qry.Execute;

                // Delete Despatch Run Line Entries.
                qry.SQL.Clear;
                qry.SQL.Add('DELETE FROM tbldespatchrunlines WHERE DespatchID = :xID');
                qry.Params.ParamByName('xID').AsInteger := iID;
                qry.Execute;
                qry.Close;
              end else begin
                // Close down the query as we are now finished with it.
                qry.Close;
              end;
            end else begin
              if qry.RecordCount > 0 then begin
                // Grab this despatch ID and close despatch runs
                // query as we are finished with it.
                iID := qry.FieldByName('DespatchID').AsInteger;

                // Yes, Has invoices been generated for this run?
                if qry.FieldByName('Done').AsString = 'T' then begin
                  Label3.Caption := 'Bypassing completed run ....';
                  LogList.Add('WARNING: Run alredy has been despatched and completed!');
                  AddLogListEntry('WARNING', '', '', 'Run already has been despatched and completed!', dtCurrentDate, iID);
                  Application.ProcessMessages;
                  qry.Close;
                  Continue;
                end;

                // Delete Despatch Run Header Entry.
                qry.SQL.Clear;
                qry.SQL.Add('DELETE FROM tbldespatchruns WHERE DespatchID = :xDespatchID');
                qry.Params.ParamByName('xDespatchID').AsInteger := iID;
                qry.Execute;

                // Delete Despatch Run Line Entries.
                qry.SQL.Clear;
                qry.SQL.Add('DELETE FROM tbldespatchrunlines WHERE DespatchID = :xID');
                qry.Params.ParamByName('xID').AsInteger := iID;
                qry.Execute;
                qry.Close;
              end;
            end;

            // First lets create a despatch run header.
            qryDespatchRun.SQL.Clear;
            if bIsHoliday then begin
              qryDespatchRun.SQL.Add(
                'INSERT HIGH_PRIORITY INTO tbldespatchruns (RunID, RunName, Operator, OperatorID, RunDate, ClassID, ClassName, IsPublicHoliday) VALUES (');
              qryDespatchRun.SQL.Add(':xRunID, :xRunName, :xOperator, :xOperID, :xRunDate, :xClassID, :xClassName, :xHoliday)');
              qryDespatchRun.Params.ParamByName('xHoliday').AsString := 'T';
            end else begin
              qryDespatchRun.SQL.Add('INSERT HIGH_PRIORITY INTO tbldespatchruns (RunID, RunName, Operator, OperatorID, RunDate, ClassID, ClassName) VALUES (');
              qryDespatchRun.SQL.Add(':xRunID, :xRunName, :xOperator, :xOperID, :xRunDate, :xClassID, :xClassName)');
            end;

            qryDespatchRun.Params.ParamByName('xRunID').AsInteger := qryRuns.FieldByName('RunID').AsInteger;
            qryDespatchRun.Params.ParamByName('xRunName').AsString := qryRuns.FieldByName('RunName').AsString;
            qryDespatchRun.Params.ParamByName('xOperator').AsString := qryRuns.FieldByName('Operator').AsString;
            qryDespatchRun.Params.ParamByName('xOperID').AsInteger := qryRuns.FieldByName('OperatorID').AsInteger;
            qryDespatchRun.Params.ParamByName('xRunDate').AsDateTime := dtCurrentDate;
            qryDespatchRun.Params.ParamByName('xClassID').AsInteger := qryClass.FieldByName('ClassID').AsInteger;
            qryDespatchRun.Params.ParamByName('xClassName').AsString := qryClass.FieldByName('ClassName').AsString;

            qryDespatchRun.Execute;
            iID := GetLastRecordPostID('tbldespatchruns');

            // State in logs that run has been created.
            LogList.Add(' ');
            LogList.Add('Run Details: ' + lstRuns.Items.Strings[iX] + ' - ' + DateToStr(dtCurrentDate));
            LogList.Add('===============================================================');
            AddLogHeaderEntry('RUN CREATED', lstRuns.Items.Strings[iX], dtCurrentDate, iID);

            qryDespatchRunLines.SQL.Clear;
            qryDespatchRunLines.SQL.Add('SELECT * FROM tbldespatchrunlines LIMIT 0');
            qryDespatchRunLines.Open;

            // Copy records from RunLines table to database backend.
            qryRunLines.First;
            iCurrentClientID := qryRunLines.FieldByName('ClientID').AsInteger;
            iSeq := 1;

            while not qryRunLines.Eof do begin
              // Has the client officially started on run?
              if qryRunLines.FieldByName('StartDate').AsDateTime > dtCurrentDate then begin
                // No, Fetch next record.
                LogList.Add('NOT ADDED: Client/Customer [ ' + qryRunLines.FieldByName('Company').AsString +
                  ' / ' + qryRunLines.FieldByName('ClientName').AsString + ' ] not scheduled for this date.');
                AddLogListEntry('NOT ADDED', qryRunLines.FieldByName('Company').AsString,
                  qryRunLines.FieldByName('ClientName').AsString, 'Customer is not scheduled to start!', dtCurrentDate, iID);
                Label3.Caption := 'Bypassing ....';
                qryRunLines.Next;
                // Different client? if so, advance sequence order.
                if iCurrentClientID <> qryRunLines.FieldByName('ClientID').AsInteger then begin
                  Inc(iSeq);
                  iCurrentClientID := qryRunLines.FieldByName('ClientID').AsInteger;
                end;

                ProgressBar2.StepIt;
                Application.ProcessMessages;
                // Continue while loop.
                Continue;
              end;

              // Are we to exclude this client from this run?
              if qryRunLines.FieldByName('Exclude').AsString = 'T' then begin
                // Has exclude from and exclude to dates been provided?
                if (qryRunLines.FieldByName('ExcludeFrom').AsDateTime <> 0) and
                  (qryRunLines.FieldByName('ExcludeTo').AsDateTime <> 0) then begin
                  // Yes, check ranges.
                  if (dtCurrentDate >= qryRunLines.FieldByName('ExcludeFrom').AsDateTime) and
                    (dtCurrentDate <= qryRunLines.FieldByName('ExcludeTo').AsDateTime) then begin
                    // Fetch next record.
                    LogList.Add('EXCLUDED: Client/Customer [ ' + qryRunLines.FieldByName('Company').AsString +
                      ' / ' + qryRunLines.FieldByName('ClientName').AsString + ' ].');
                    AddLogListEntry('EXCLUDED', qryRunLines.FieldByName('Company').AsString,
                      qryRunLines.FieldByName('ClientName').AsString, 'Customer has been scheduled to be excluded!', dtCurrentDate, iID);
                    Label3.Caption := 'Client Excluded ....';
                    ProgressBar2.StepIt;
                    Application.ProcessMessages;

                    // Fetch next record.
                    qryRunLines.Next;
                    // Different client? if so, advance sequence order.
                    if iCurrentClientID <> qryRunLines.FieldByName('ClientID').AsInteger then begin
                      Inc(iSeq);
                      iCurrentClientID := qryRunLines.FieldByName('ClientID').AsInteger;
                    end;

                    // Continue while loop.
                    Continue;
                  end;
                end else begin
                  // Otherwise this client is excluded, period!
                  LogList.Add('EXCLUDED: Client/Customer [ ' + qryRunLines.FieldByName('Company').AsString +
                    ' / ' + qryRunLines.FieldByName('ClientName').AsString + ' ].');
                  AddLogListEntry('EXCLUDED', qryRunLines.FieldByName('Company').AsString,
                    qryRunLines.FieldByName('ClientName').AsString, 'Customer has been scheduled to be excluded!', dtCurrentDate, iID);
                  Label3.Caption := 'Client Excluded ....';
                  ProgressBar2.StepIt;
                  Application.ProcessMessages;

                  // Fetch next record.
                  qryRunLines.Next;
                  // Different client? if so, advance sequence order.
                  if iCurrentClientID <> qryRunLines.FieldByName('ClientID').AsInteger then begin
                    Inc(iSeq);
                    iCurrentClientID := qryRunLines.FieldByName('ClientID').AsInteger;
                  end;

                  // Continue while loop.
                  Continue;
                end;
              end;

              // Here we need to determine if this client is scheduled
              // to have a delivery.
              if qryRunLines.FieldByName('FreqType').AsString = 'Time Only' then begin
                bFound := Delivery.IsClientProductAlreadyOnRun(qryRunLines.FieldByName('ClientID').AsInteger,
                  qryRunLines.FieldByName('RunID').AsInteger, qryRunLines.FieldByName('ProductID').AsInteger);
              end else begin
                // Is the selected run date
                bFound := not (Floor(dtCurrentDate) = qryRunLines.FieldByName('NextRunDate').AsDateTime);
              end;

              if not bFound then begin
                // Fill in despatch run line details for this client.
                LogList.Add('ADDED   : Client/Customer [ ' + qryRunLines.FieldByName('Company').AsString +
                  ' / ' + qryRunLines.FieldByName('ClientName').AsString + ' ].');
                AddLogListEntry('ADDED', qryRunLines.FieldByName('Company').AsString,
                  qryRunLines.FieldByName('ClientName').AsString, 'Customer has been added to this scheduled run!', dtCurrentDate, iID);

                qryDespatchRunLines.Insert;
                qryDespatchRunLines.FieldByName('DespatchID').AsInteger := iID;
                qryDespatchRunLines.FieldByName('RunID').AsInteger := qryRunLines.FieldByName('RunID').AsInteger;
                qryDespatchRunLines.FieldByName('ClientID').AsInteger := qryRunLines.FieldByName('ClientID').AsInteger;
                qryDespatchRunLines.FieldByName('ContactID').AsInteger := qryRunLines.FieldByName('ContactID').AsInteger;
                qryDespatchRunLines.FieldByName('IsContact').AsString := qryRunLines.FieldByName('IsContact').AsString;
                qryDespatchRunLines.FieldByName('Company').AsString := qryRunLines.FieldByName('Company').AsString;
                qryDespatchRunLines.FieldByName('ProductID').AsInteger := qryRunLines.FieldByName('ProductID').AsInteger;
                qryDespatchRunLines.FieldByName('ProductName').AsString := qryRunLines.FieldByName('ProductName').AsString;
                qryDespatchRunLines.FieldByName('Sequence').AsInteger := iSeq;
                qryDespatchRunLines.FieldByName('PaymentMethodID').AsInteger :=
                  qryRunLines.FieldByName('PayMethodID').AsInteger;
                qryDespatchRunLines.FieldByName('PaymentMethodName').AsString :=
                  qryRunLines.FieldByName('PayMethodName').AsString;

                // We need to determine here if the next schedule run after this one
                // is a public holiday or not.  If it is then we need to double
                // the amount that is going out on this run as we skip public holidays.
                qryHolidays.Close;
                qryHolidays.Params.ParamByName('xDate').AsDateTime := qryrunLines.FieldByName('DateAfterNext').AsDateTime;
                qryHolidays.Open;

                if not chkCreateHolidays.Checked then begin
                  if qryHolidays.RecordCount > 0 then begin
                    // Yes! Public Holidays are double.
                    dQty := qryRunLines.FieldByName('Qty').AsFloat * 2;
                    qryDespatchRunLines.FieldByName('OrderQty').AsFloat := dQty;
                    if AppEnv.CompanyPrefs.AutoCorrectPriceDiscountsOnDeliveries then begin
                      ClientDiscount.ClientPrice_Discounts(qryRunLines.FieldByName('ClientID').AsInteger, 0,
                        qryRunLines.FieldByName('ProductID').AsInteger, qryClass.FieldByName('ClassID').AsInteger,
                        qryRunLines.FieldByName('Qty').AsFloat, dtCurrentDate, 1, '', '', '', '', '',
                        false, dPriceEx, dDiscount, sDescript, sMsg);

                      // Ex price is original ex part price - discount.
                      qryDespatchRunLines.FieldByName('OriginalExPrice').AsFloat := dPriceEx;
                      qryDespatchRunLines.FieldByName('Discount').AsFloat := dDiscount;
                      dPriceEx := dPriceEx - (dPriceEx * dDiscount);

                      // Get Inclusive price.
                      dIncPrice := GetAmountInc(dPriceEx, GetTaxRate(qryRunLines.FieldByName('TaxCode').AsString));
                      dTax := (dIncPrice - dPriceEx) * dQty;
                      dIncPrice := dIncPrice * dQty;
                      qryDespatchRunLines.FieldByName('OrderValue').AsFloat := RoundCurrency(dIncPrice);
                      qryDespatchRunLines.FieldByName('TaxAmount').AsFloat := dTax;
                      qryDespatchRunLines.FieldByName('TakenValue').AsFloat := RoundCurrency(dIncPrice);
                    end else begin
                      qryDespatchRunLines.FieldByName('OriginalExPrice').AsFloat :=
                        qryRunLines.FieldByName('OriginalExPrice').AsFloat;
                      qryDespatchRunLines.FieldByName('Discount').AsFloat := qryRunLines.FieldByName('Discount').AsFloat;
                      qryDespatchRunLines.FieldByName('OrderValue').AsFloat :=
                        qryRunLines.FieldByName('OrderValue').AsFloat * 2;
                      qryDespatchRunLines.FieldByName('TaxAmount').AsFloat :=
                        qryRunLines.FieldByName('TaxAmount').AsFloat * 2;
                      qryDespatchRunLines.FieldByName('TakenValue').AsFloat :=
                        qryRunLines.FieldByName('OrderValue').AsFloat * 2;
                    end;

                    qryDespatchRunLines.FieldByName('TakenQty').AsFloat := dQty;
                  end else begin
                    qryDespatchRunLines.FieldByName('OrderQty').AsFloat := qryRunLines.FieldByName('Qty').AsFloat;
                    qryDespatchRunLines.FieldByName('OrderValue').AsFloat := qryRunLines.FieldByName('OrderValue').AsFloat;
                    qryDespatchRunLines.FieldByName('TaxAmount').AsFloat := qryRunLines.FieldByName('TaxAmount').AsFloat;
                    qryDespatchRunLines.FieldByName('OriginalExPrice').AsFloat :=
                      qryRunLines.FieldByName('OriginalExPrice').AsFloat;
                    qryDespatchRunLines.FieldByName('Discount').AsFloat := qryRunLines.FieldByName('Discount').AsFloat;
                    qryDespatchRunLines.FieldByName('TakenQty').AsFloat := qryRunLines.FieldByName('Qty').AsFloat;
                    qryDespatchRunLines.FieldByName('TakenValue').AsFloat := qryRunLines.FieldByName('OrderValue').AsFloat;
                  end;
                  // Otherwise its just a standard day.
                end else begin
                  qryDespatchRunLines.FieldByName('OrderQty').AsFloat := qryRunLines.FieldByName('Qty').AsFloat;
                  qryDespatchRunLines.FieldByName('OrderValue').AsFloat := qryRunLines.FieldByName('OrderValue').AsFloat;
                  qryDespatchRunLines.FieldByName('TaxAmount').AsFloat := qryRunLines.FieldByName('TaxAmount').AsFloat;
                  qryDespatchRunLines.FieldByName('OriginalExPrice').AsFloat :=
                    qryRunLines.FieldByName('OriginalExPrice').AsFloat;
                  qryDespatchRunLines.FieldByName('Discount').AsFloat := qryRunLines.FieldByName('Discount').AsFloat;
                  qryDespatchRunLines.FieldByName('TakenQty').AsFloat := qryRunLines.FieldByName('Qty').AsFloat;
                  qryDespatchRunLines.FieldByName('TakenValue').AsFloat := qryRunLines.FieldByName('OrderValue').AsFloat;
                end;

                qryDespatchRunLines.FieldByName('UnitExPrice').AsFloat := qryRunLines.FieldByName('UnitExPrice').AsFloat;
                qryDespatchRunLines.FieldByName('ClientName').AsString := qryRunLines.FieldByName('ClientName').AsString;
                qryDespatchRunLines.FieldByName('Phone').AsString := qryRunLines.FieldByName('Phone').AsString;
                qryDespatchRunLines.FieldByName('Mobile').AsString := qryRunLines.FieldByName('Mobile').AsString;
                qryDespatchRunLines.FieldByName('Address').AsString := qryRunLines.FieldByName('Address').AsString;
                qryDespatchRunLines.FieldByName('Exclude').AsString := qryRunLines.FieldByName('Exclude').AsString;
                qryDespatchRunLines.FieldByName('TaxCode').AsString := qryRunLines.FieldByName('TaxCode').AsString;
                qryDespatchRunLines.FieldByName('Track').AsString := qryRunLines.FieldByName('Track').AsString;
                qryDespatchRunLines.FieldByName('PreferedSupp').AsString :=
                  qryRunLines.FieldByName('PreferedSupp').AsString;
                qryDespatchRunLines.FieldByName('ExcludeFrom').AsVariant :=
                  qryRunLines.FieldByName('ExcludeFrom').AsVariant;
                qryDespatchRunLines.FieldByName('ExcludeTo').AsVariant := qryRunLines.FieldByName('ExcludeTo').AsVariant;
                qryDespatchRunLines.FieldByName('StartDate').AsDateTime := qryRunLines.FieldByName('StartDate').AsVariant;
                qryDespatchRunLines.FieldByName('LastDelivery').AsVariant :=
                  qryRunLines.FieldByName('LastDelivery').AsVariant;
                qryDespatchRunLines.FieldByName('FreqInterval').AsInteger :=
                  qryRunLines.FieldByName('FreqInterval').AsInteger;
                qryDespatchRunLines.FieldByName('FreqType').AsString := qryRunLines.FieldByName('FreqType').AsString;
                qryDespatchRunLines.Post;
              end; // End of IF NOT bFound then begin

              // Fetch next record.
              qryRunLines.Next;
              // Different client? if so, advance sequence order.
              if iCurrentClientID <> qryRunLines.FieldByName('ClientID').AsInteger then begin
                Inc(iSeq);
                iCurrentClientID := qryRunLines.FieldByName('ClientID').AsInteger;
              end;

              // Advance progress status
              ProgressBar2.StepIt;
              Application.ProcessMessages;
            end;
          end; // End of if qryRunLines.RecordCount > 0

          // Are we to create the driver reports from here?
          if (not chkShowReports.Checked) and (iID <> 0) then begin
            frm := TfrmRunDespatchGUI(GetComponentByClassName('TfrmRunDespatchGUI'));
            if Assigned(frm) then begin
              frm.KeyID := iID;
              frm.AutoCreateMode := true;
              frm.FormStyle := fsMDIChild;
              frm.BringToFront;

              // Generate reports.
              Application.ProcessMessages;
              frm.btnDriverReportsClick(Sender);
              frm.cmdCancelClick(Sender);
            end;
          end;
        end; // End of Locate

        if chkShowLogs.Checked then begin
          qryRunLines.Filtered := false;
          qryRunLines.Filter := 'NextRunDate <> ' + QuotedStr(DateToStr(dtCurrentDate));
          qryRunLines.Filtered := true;
          qryRunLines.First;

          // Add all entries that were not scheduled to log list.
          iCurrentClientID := qryRunLines.FieldByName('ClientID').AsInteger;
          AddLogListEntry('NOT SCHEDULED', qryRunLines.FieldByName('Company').AsString,
            qryRunLines.FieldByName('ClientName').AsString, 'Customer is NOT scheduled to be on run.', dtCurrentDate, iID);
          while not qryRunLines.Eof do begin
            // Different client? if so, advance sequence order.
            if iCurrentClientID <> qryRunLines.FieldByName('ClientID').AsInteger then begin
              iCurrentClientID := qryRunLines.FieldByName('ClientID').AsInteger;
              // Add Log List Entry.
              AddLogListEntry('NOT SCHEDULED', qryRunLines.FieldByName('Company').AsString,
                qryRunLines.FieldByName('ClientName').AsString, 'Customer is NOT scheduled to be on run.', dtCurrentDate, iID);
            end;
            // Fetch next record.
            qryRunLines.Next;
          end;
        end;
      end; // End of For iX

      // Point to the next day.
      dtCurrentDate := dtCurrentDate + 1;
      ProgressBar1.StepIt;
      Application.ProcessMessages;
    end;

    LogList.Add('===============================================================');
    qryRunLines.First;

    // Are we to preview a log output?
    if chkShowLogs.Checked then begin
      // Yes, is it the log file?
      if chkShowLogFile.Checked then begin
        // Yes, show log file.
        Form := GetComponentByClassName('TfrmLogsGUI');
        if Assigned(Form) then begin
          TfrmLogsGUI(Form).LogLines := LogList;
          TfrmLogsGUI(Form).FormStyle := fsNormal;
          TfrmLogsGUI(Form).ShowModal;
        end;
      end else begin
        // No, show Log List.
        if not FormStillOpen('TRunCreationLogsListGUI') then begin
          Form := GetComponentByClassName('TRunCreationLogsListGui');
          if Assigned(Form) then begin
            with TRunCreationLogsListGUI(Form) do begin
              FormStyle := fsNormal;
              ShowModal;
            end;
          end;  
        end;
      end;
    end;
    
    // Notify any assigned list.
    Notify;

    bCloseForm := true;

  finally
    // Free our used queries.
    if Assigned(qry) then FreeAndNil(qry);
    if Assigned(qryDespatchRunLines) then
      FreeandNil(qryDespatchRunLines);
    if Assigned(qryDespatchRun) then
      FreeandNil(qryDespatchRun);

    // Are we to close the form down?
    if bCloseForm then begin
      // Yes, then close.
      Self.Close;
    end;
  end;
end;

procedure TfrmRunDespatchCreator.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if cboClass.Text = '' then Exit;
end;

procedure TfrmRunDespatchCreator.chkShowLogsClick(Sender: TObject);
begin
  inherited;
  if chkShowLogs.Checked then begin
    chkShowLogFile.Enabled := true;
    chkShowLogList.Enabled := true;
    Label11.Enabled        := true;
    Label12.Enabled        := true;
  end else begin
    chkShowLogFile.Enabled := false;
    chkShowLogList.Enabled := false;
    Label11.Enabled        := false;
    Label12.Enabled        := false;
  end;
end;

procedure TfrmRunDespatchCreator.chkShowLogFileClick(Sender: TObject);
begin
  inherited;
  if chkShowLogFile.Checked then begin
    chkShowLogList.Checked := false;
  end;
end;

procedure TfrmRunDespatchCreator.chkShowLogListClick(Sender: TObject);
begin
  inherited;
  if chkShowLogList.Checked then begin
    chkShowLogFile.Checked := false;
  end;
end;

procedure TfrmRunDespatchCreator.CreateTemporaryTable;
var
  slSQL: TStringList;
begin
  DestroyUserTemporaryTable(fsTableName);
  slSQL := TStringList.Create;
  try
    slSQL.Clear;
    slSQL.Add('CREATE TABLE `' + fsTableName + '` (');
    slSQL.Add('`RecID` INT(11) AUTO_INCREMENT,');
    slSQL.Add('`Detail` INT(11) DEFAULT 0,');
    slSQL.Add('`DespatchRunID` INT(11) DEFAULT 0,');
    slSQL.Add('`RunDate` DATE,');
    slSQL.Add('`State` VARCHAR(255),');
    slSQL.Add('`Company` VARCHAR(255),');
    slSQL.Add('`Contact` VARCHAR(255),');
    slSQL.Add('`Description` VARCHAR(255),');
    slSQL.Add('PRIMARY KEY (`RecID`)) TYPE=MyISAM;');

    CreateUserTemporaryTable(slSQL);

  finally
    // Free used objects.
    if Assigned(slSQL) then
      FreeandNil(slSQL);
  end;
end;

procedure TfrmRunDespatchCreator.DestroyTemporaryTable;
begin
  DestroyUserTemporaryTable(fsTableName);
end;

procedure TfrmRunDespatchCreator.AddLogListEntry(const sState, sCompany, sContact, sDescription: string;
  const RunDate: TDateTime; const DespatchRunID: integer);
var
  qry: TMyQuery;
  sDate: string;
  wYear, wMonth, wDay: word;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDBLib.GetSharedMyDacConnection;
    DecodeDate(RunDate, wYear, wMonth, wDay);
    sDate := FastFuncs.IntToStr(wYear) + '-' + FastFuncs.IntToStr(wMonth) + '-' + FastFuncs.IntToStr(wDay);
    qry.SQL.Clear;
    qry.SQL.Add('INSERT HIGH_PRIORITY INTO `' + fsTableName + '` ');
    qry.SQL.Add('(State, Company, Contact, Description, RunDate, Detail, DespatchRunID) VALUES (');
    qry.SQL.Add(QuotedStr(sState) + ', ' + QuotedStr(sCompany) + ', ' + QuotedStr(sContact) + ', ');
    qry.SQL.Add(QuotedStr(sDescription) + ', ' + QuotedStr(sDate) + ', 1, ' + FastFuncs.IntToStr(DespatchRunID) + ');');
    qry.Execute;

  finally
    // Release our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

procedure TfrmRunDespatchCreator.AddLogHeaderEntry(const sState, sDescription: string; const RunDate: TDateTime;
  const DespatchRunID: integer);
var
  qry: TMyQuery;
  sDate: string;
  wYear, wMonth, wDay: word;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDBLib.GetSharedMyDacConnection;
    DecodeDate(RunDate, wYear, wMonth, wDay);
    sDate := FastFuncs.IntToStr(wYear) + '-' + FastFuncs.IntToStr(wMonth) + '-' + FastFuncs.IntToStr(wDay);

    qry.SQL.Clear;
    qry.SQL.Add('INSERT HIGH_PRIORITY INTO `' + fsTableName + '` ');
    qry.SQL.Add('(State, Company, Contact, Description, RunDate, Detail, DespatchRunID) VALUES (');
    qry.SQL.Add(QuotedStr(sState) + ', NULL, NULL, ');
    qry.SQL.Add(QuotedStr(sDescription) + ', ' + QuotedStr(sDate) + ', 0, ' + FastFuncs.IntToStr(DespatchRunID) + ');');
    qry.Execute;

  finally
    // Release our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;


initialization
  RegisterClassOnce(TfrmRunDespatchCreator);
  with FormFact do begin
    RegisterMe(TfrmRunDespatchCreator, 'TRemindersListGUI_Type_Delivery Run to be Created.=ID');
  end;
end.
