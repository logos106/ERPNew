{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 28/02/07 1.00.00  BJ  Procedure PartsQuantities - included group / variable group's unbuild qty
                        in the Qty calculation.
                       Build group's Qty is only counted when the status is 'B' or 'U'. this
                       is to avoid counting the pending build group     
}
unit VerifyFunctionsObj;

interface

uses
  DB, Dialogs, SysUtils, Controls, ProgressDialog,
  MyAccess, MemDS, kbmMemTable, TableFunctionsObj;

type
  TVerificationType = (vtVerifyData,
    vtVerifyAll,
    vtTransAccountVsPartAccountsVerify,
    vtProductQtysVerify,
    vtDevTestVerify,
    vtPayEntryVerify);

  TVerifyFunctions = class(TObject)
  private
    TableFunctions: TTableFunctionsObj;
    qryCorrect, qryCorrect2, qryExisting, TempqryAccount: TMyQuery;
    ProgressDialog: TProgressDialog;
    ErrorLog: TextFile;
    AllCount, Count: integer;
    function GetAccountID(const AccountName: string): integer;
    //function GetAccountName(const AccountID: Integer): string;
    function GetUndepositedFundID: integer;
    function SetTerms(const dtBaseDate: TDateTime; const Terms: string): TDateTime;
    procedure AccountBalanceVerify(const Fix: boolean);
    procedure AccountNameVsIDVerify(const Fix: boolean);
    procedure AddErrorLogMessage(const MessageText: string);
    procedure CashSaleOutOfBalancePaymentVerify(const Fix: boolean);
    procedure ClientBalanceVerify(const Fix: boolean);
    procedure CustPaymentInvoiceDateVerify(const Fix: boolean);
    procedure CustPaymentPaymentDateVerify(const Fix: boolean);
    procedure CustPrepaymentPaymentVerify(const Fix: boolean);
    procedure SupZeroPaymentFixVerify(const Fix: boolean);
    procedure DepositedCashSaleVerify(const Fix: boolean);
    procedure DepositedCustPaymentsVerify(const Fix: boolean);
    procedure DepositsOutOfBalanceVerify(const Fix: boolean);
    procedure GeneralJounralAccountNameVsIDVerify(const Fix: boolean);
    procedure LaybyBalanceVerify(const Fix: boolean);
    procedure LaybyOutOfBalancePaymentVerify(const Fix: boolean);
    procedure LaybyPaymentIDVerify(const Fix: boolean);
    procedure NewErrorLogFile;
    procedure PartsAvgCostVerify(const Fix: boolean);
    procedure PartsVolumeLevelPricesVerify(const Fix: boolean);
    procedure PartTypeVerify(const Fix: boolean);
    procedure PartsPricesExVerify(const Fix: boolean);
    procedure PartsQuantitiesVerify(const Fix: boolean);
    procedure PartsVerify(const Fix: boolean);
    procedure POAccountNameVsIDVerify(const Fix: boolean);
    procedure POBalancesVerify(const Fix: boolean);
    procedure POClassVerify(const Fix: boolean);
    procedure POClientsVerify(const Fix: boolean);
    procedure POCorrectRoundingVerify(const Fix: boolean);
    procedure POLinesAccountvsPartAccountsVerify(const Fix: boolean);
    procedure POLinesCorrectRoundingVerify(const Fix: boolean);
    procedure POMasterAccountVerify(const Fix: boolean);
    procedure POOutOfBalanceVerify(const Fix: boolean);
    procedure POTermsVerify(const Fix: boolean);
    procedure POVerify(const Fix: boolean);
    procedure ProcessPOBalances(const Fix: boolean);
    procedure ProcessSalesBalances(const Fix: boolean);
    procedure ReconciliationDepositVerify(const Fix: boolean);
    procedure ReconciliationReset;
    procedure ReconciliationWithdrawalVerify(const Fix: boolean);
    procedure SalesAccountNameVsIDVerify(const Fix: boolean);
    procedure SalesBalancesVerify(const Fix: boolean);
    procedure SalesClassVerify(const Fix: boolean);
    procedure SalesClientsVerify(const Fix: boolean);
    procedure SalesCorrectRoundingVerify(const Fix: boolean);
    procedure SalesEmployeeFixVerify(const Fix: boolean);
    procedure SalesLinesAccountvsPartAccountsVerify(const Fix: boolean);
    procedure SalesLinesCorrectRoundingVerify(const Fix: boolean);
    procedure SalesMasterAccountVerify(const Fix: boolean);
    procedure SalesOutOfBalanceVerify(const Fix: boolean);
    procedure SalesTermsVerify(const Fix: boolean);
    procedure SalesVerify(const Fix: boolean);
    procedure StockAdjAccountNameVsIDVerify(const Fix: boolean);
    procedure UnDepositedReset;
    procedure UpdateLastPOBalance(POID: integer);
    procedure UpdateLastSaleBalance(const SaleID: integer);
    procedure UpdateStatusText;
    procedure ExtraBuyPriceFix; //delete all records with PartsID = 0, as they can exist only by error
    procedure ExtraSellPriceFix; //delete all records with PartsID = 0, as they can exist only by error
  public
    NoMessage: boolean;
    constructor Create;
    destructor Destroy; override;
    procedure VerifyData(const Fix: boolean);
    procedure RunAllVerifies(const Fix: boolean);
    procedure TransactionAccountvsPartAccountsVerify(const Fix: boolean);
    procedure ProductQtysVerify(const Fix: boolean);
    procedure DevTestVerify(const Fix: boolean);
    //procedure PayEntryVerify;
    procedure VerifyChequeBankDeposits;
    function PartsQuantities(const ProductID, ClassID: integer; var OnHire, InStockQty, SalesOrderQty, SalesOrderBOQty, InvoiceBOQty, OnOrderQty: double; const NonInventoryPart: boolean = false): boolean;

  end;

const
  ERRORLOG_FILE     = 'Platinum1Verify.log';
  UNDEPOSITED_FUNDS = 'UNDEPOSITED FUNDS';

procedure VerifyData(const VerificationType: TVerificationType; const FixIssues: boolean; Const NoShowMessage:Boolean=False);

implementation

uses FastFuncs,MAIN, CommonDbLib, TransactionsTable,  DnMLib, Math,
  DateUtils,
  //PayFunctionObj,
  ReconciliationFlagsObj, BankDepositObj, loglib,
  tcDataUtils, Forms, CommonLib, AppEnvironment;

procedure VerifyData(const VerificationType: TVerificationType; const FixIssues: boolean; Const NoShowMessage:Boolean=False);
var
  VF: TVerifyFunctions;
begin
  VF := TVerifyFunctions.Create;
  try
    VF.NoMessage := NoShowMessage;
    case VerificationType of
      vtDevTestVerify: VF.DevTestVerify(FixIssues);

      //vtPayEntryVerify: VF.PayEntryVerify;

      vtProductQtysVerify: VF.ProductQtysVerify(FixIssues);

      vtTransAccountVsPartAccountsVerify: VF.TransactionAccountvsPartAccountsVerify(FixIssues);

      vtVerifyAll: VF.RunAllVerifies(FixIssues);

      vtVerifyData: VF.VerifyData(FixIssues);
    end;
  finally
    FreeandNil(VF);
  end;
end;

{ TVerifyFunctions }

procedure TVerifyFunctions.NewErrorLogFile;
var
  sFile: string;
begin
  sFile := ExtractFilePath(Application.ExeName) + ERRORLOG_FILE;
  AssignFile(ErrorLog, sFile);
  Rewrite(ErrorLog);
end;

procedure TVerifyFunctions.AddErrorLogMessage(const MessageText: string);
begin
  Writeln(ErrorLog, MessageText);
  Flush(ErrorLog);
end;

constructor TVerifyFunctions.Create;
begin
  inherited; 
  TableFunctions := TTableFunctionsObj.Create;
  NoMessage := false;
  NewErrorLogFile;
  Application.ProcessMessages;
end;

destructor TVerifyFunctions.Destroy;
begin
  FreeandNil(TableFunctions);
  CloseFile(ErrorLog);
  if not NoMessage then CommonLib.MessageDlgXP_Vista(#13 + #10 + 'Check Log File (' + ERRORLOG_FILE + ') To See Report',
      mtInformation, [mbOK], 0);
  inherited; 
end;

{function TVerifyFunctions.GetAccountName(const AccountID: Integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(Application.MainForm);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT AccountName FROM tblchartofaccounts WHERE AccountID = ' + FastFuncs.IntToStr(AccountID) + ';');
    qryTemp.Active := True;
    if not qryTemp.IsEmpty then begin
      result := qryTemp.FieldByName('AccountName').AsString;
    end else begin
      result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;}

procedure TVerifyFunctions.VerifyData(const Fix: boolean);
var
  TransactionTableObj: TTransactionTableObj;
begin
  ProgressDialog := TProgressDialog.Create(Application.MainForm);
  try
    Screen.Cursor           := crHourGlass;
    ProgressDialog.Caption  := 'Please Wait .......';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := 100;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;

    //Start Verification
    AddErrorLogMessage('Verification Started - ' + DateTimeToStr(Now));
    AddErrorLogMessage('--------------------');
    AddErrorLogMessage('');
    Count    := 0;
    AllCount := 31;
    UpdateStatusText;
    {Account vs ID Verify}
    ResetAllEmployeeNames;
    SetAccountLevelField;
    AccountNameVsIDVerify(Fix);
    UpdateStatusText;
    UpdateSecsInAllLogs;
    UpdateStatusText;
    PartsVerify(Fix);
    UpdateStatusText;
    PartsPricesExVerify(Fix);
    UpdateStatusText;
    PartsVolumeLevelPricesVerify(Fix);
    UpdateStatusText;
    SetRelatedChildID;
    SalesVerify(Fix);
    UpdateStatusText;
    POVerify(Fix);
    UpdateStatusText;

    {Out Of Balance}
    SalesOutOfBalanceVerify(Fix);
    UpdateStatusText;
    POOutOfBalanceVerify(Fix);
    UpdateStatusText;
    SalesBalancesVerify(Fix);
    UpdateStatusText;
    POBalancesVerify(Fix);
    UpdateStatusText;

    LaybyPaymentIDVerify(Fix);
    UpdateStatusText;
    LaybyBalanceVerify(Fix);
    UpdateStatusText;

    LaybyOutOfBalancePaymentVerify(Fix);
    UpdateStatusText;
    CashSaleOutOfBalancePaymentVerify(Fix);
    UpdateStatusText;

    UnDepositedReset;
    UpdateStatusText;
    DepositedCustPaymentsVerify(Fix);
    UpdateStatusText;
    DepositedCashSaleVerify(Fix);
    UpdateStatusText;
    DepositsOutOfBalanceVerify(Fix);
    UpdateStatusText;

    CustPaymentInvoiceDateVerify(Fix);
    UpdateStatusText;
    CustPaymentPaymentDateVerify(Fix);
    UpdateStatusText;
    CustPrepaymentPaymentVerify(Fix);
    UpdateStatusText;
    SupZeroPaymentFixVerify(Fix);

    {Verify}
    TransactionTableObj := TTransactionTableObj.Create;
    try
      TransactionTableObj.SetEmptyGlobalRef;
      UpdateStatusText;
      TransactionTableObj.CleanRefreshTrnsTable(true);
      UpdateStatusText;
      TransactionTableObj.CreatePermanentSummaryTable;
      UpdateStatusText;
      TransactionTableObj.CleanRefreshTrnsTable(true);
      UpdateStatusText;
    finally
      FreeandNil(TransactionTableObj);
    end;
    ProcessPOBalances(Fix);
    ProcessSalesBalances(Fix);

    AccountBalanceVerify(Fix);
    UpdateStatusText;
    ClientBalanceVerify(Fix);
    UpdateStatusText;


    {Reconciliation}
    if Fix then begin
      ReconciliationReset;
      UpdateStatusText;
      ReconciliationDepositVerify(Fix);
      UpdateStatusText;
      ReconciliationWithdrawalVerify(Fix);
      UpdateStatusText;
    end;

    {ExtraBuy & ExtraSell}
    ExtraBuyPriceFix;
    UpdateStatusText;
    ExtraSellPriceFix;
    UpdateStatusText;

    Count    := 0;
    AllCount := 0;
    UpdateStatusText;
    AddErrorLogMessage('');
    AddErrorLogMessage('----------------------');
    AddErrorLogMessage('Verification Completed - ' + DateTimeToStr(Now));
  finally
    FreeandNil(ProgressDialog);
    Screen.Cursor := crDefault;
    Application.ProcessMessages
  end;
end;

procedure TVerifyFunctions.AccountBalanceVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;

  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryCorrect do begin
      {Correct Account Balances}
      SQL.Clear;
      SQL.Add('SELECT AccountID, ');
      SQL.Add('If(AccountType="CCARD" OR AccountType = "EQUITY" OR AccountType = "INC" ');
      SQL.Add('OR AccountType = "OCLIAB",Sum(CreditsEx-DebitsEx),Sum(DebitsEx-CreditsEx)) as Balance ');
      SQL.Add('FROM tbltransactions Where  not isNull(AccountID) AND Active="T" ');
      SQL.Add('AND AccountID=:xAccountID ');
      SQL.Add('Group By AccountID; ');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      {Current Account Balances}
      SQL.Clear;
      SQL.Add('SELECT AccountID,AccountName, Balance as Balance ');
      SQL.Add('FROM tblchartofaccounts Where  not isNull(AccountID); ');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;

    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    AddErrorLogMessage('*************************************************************');
    AddErrorLogMessage('Account Balance Verification Started - ' + DateTimeToStr(Now));
    AddErrorLogMessage('');
    with qryExisting do begin
      First;
      while not Eof do begin
        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xAccountID').AsInteger := qryExisting.FieldByName('AccountID').AsInteger;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 1', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 1', LogLib.LogType_Debug);
        if not (qryExisting.FieldByName('Balance').AsCurrency = qryCorrect.FieldByName('Balance').AsCurrency) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('Balance').AsCurrency := qryCorrect.FieldByName('Balance').AsCurrency;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;


procedure TVerifyFunctions.ClientBalanceVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 3;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;

  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;

  qryCorrect2 := TMyQuery.Create(Application.MainForm);
  qryCorrect2.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect2.Options.FlatBuffers := True;
  qryCorrect2.Options.StrictUpdate := false;

  try
    //Load Queries
    with qryCorrect do begin
      {Customer Balances}
      SQL.Clear;
      SQL.Add('SELECT TRANS.ClientName as CustomerName, ');
      SQL.Add('TRANS.ClientID, ');
      SQL.Add('Sum(DebitsInc-CreditsInc) AS CustBalance ');
      SQL.Add('FROM tbltransactions TRANS ');
      SQL.Add('Where not isNull(TRANS.AccountID) ');
      SQL.Add('AND ((TRANS.AccountType = "AR" AND (TRANS.TYPE = "Invoice" OR TRANS.TYPE = "Refund" OR TRANS.TYPE = "Customer Payment"))  ');
      SQL.Add('OR ((TRANS.TYPE = "Customer Prepayment" OR TRANS.TYPE = "Customer Payment") AND TRANS.AccountID=' +
        FastFuncs.IntToStr(GetPrepaymentAccountID('C')) + ')) ');
      SQL.Add('AND (DebitsEx-CreditsEx)<>0.00 ');
      SQL.Add('AND TRANS.ClientID=:xClientID ');
      SQL.Add('Group By TRANS.ClientID; ');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryCorrect2 do begin
      {Supplier Balances}
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('TRANS.ClientName as SupplierName, ');
      SQL.Add('TRANS.ClientID as ClientID, ');
      SQL.Add('Sum(CreditsInc-DebitsInc) AS SuppBalance ');
      SQL.Add('FROM tbltransactions TRANS ');
      SQL.Add('WHERE not isNull(TRANS.AccountID) AND  ');
      SQL.Add('((TRANS.AccountType = "AP" AND (TRANS.TYPE = "PO" OR TRANS.TYPE = "Bill" OR TRANS.TYPE = "Credit" OR TRANS.TYPE = "Supplier Payment")) ');
      SQL.Add(' OR ((TRANS.TYPE = "Supplier Prepayment" OR TRANS.TYPE = "Supplier Payment") AND TRANS.AccountID=' +
        FastFuncs.IntToStr(GetPrepaymentAccountID('S')) + ')) ');
      SQL.Add('AND (DebitsEx-CreditsEx)<>0.00 ');
      SQL.Add('AND TRANS.ClientID=:xClientID ');
      SQL.Add('Group By ClientID; ');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      {Current Client Balances}
      SQL.Clear;
      SQL.Add('SELECT ClientID,Company,Balance FROM tblclients; ');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 10;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;

    AddErrorLogMessage('');
    AddErrorLogMessage('*************************************************************');
    AddErrorLogMessage('Client Balance Verification Started - ' + DateTimeToStr(Now));
    AddErrorLogMessage('');
    with qryExisting do begin
      First;
      while not Eof do begin
        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xClientID').AsInteger := qryExisting.FieldByName('ClientID').AsInteger;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 2', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 2', LogLib.LogType_Debug);

        qryCorrect2.Close;
        qryCorrect2.Params.ParamByName('xClientID').AsInteger := qryExisting.FieldByName('ClientID').AsInteger;
        loglib.Log(qryCorrect2.SQL.Text + ' - Start 3', LogLib.LogType_Debug);
        qryCorrect2.Open;
        loglib.Log('End 3', LogLib.LogType_Debug);

        if not (qryExisting.FieldByName('Balance').AsCurrency =
          (qryCorrect.FieldByName('CustBalance').AsCurrency - qryCorrect2.FieldByName('SuppBalance').AsCurrency)) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('Balance').AsCurrency :=
              (qryCorrect.FieldByName('CustBalance').AsCurrency - qryCorrect2.FieldByName('SuppBalance').AsCurrency);
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryCorrect2.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryCorrect2);
    FreeAndNil(qryExisting);
  end;
end;


procedure TVerifyFunctions.PartsVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  //Create Queries
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryCorrect do begin
      {List of Accounts & Types}
      SQL.Clear;
      SQL.Add('SELECT AccountID, AccountName, AccountType ');
      SQL.Add('FROM tblchartofaccounts Where  not isNull(AccountID) AND not isNull(AccountName) ');
      SQL.Add('AND AccountName=:xAccountName;');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      {List of Parts}
      SQL.Clear;
      SQL.Add('SELECT PARTSID, PARTNAME,PARTTYPE, INCOMEACCNT, ASSETACCNT, COGSACCNT, ');
      SQL.Add('COST1, COST2, COST3, PRICE1, PRICE2, PRICE3, TAXCODE ');
      SQL.Add('FROM tblparts Where  not isNull(PARTSID);  ');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;

    AddErrorLogMessage('');
    AddErrorLogMessage('*************************************************************');
    AddErrorLogMessage('Product Verification Started - ' + DateTimeToStr(Now));
    AddErrorLogMessage('');

    with qryExisting do begin
      First;
      while not Eof do begin
        //Cost of Goods Account
        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xAccountName').AsString := qryExisting.FieldByName('COGSACCNT').AsString;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 4', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 4', LogLib.LogType_Debug);

        if not (qryExisting.FieldByName('COGSACCNT').AsString = qryCorrect.FieldByName('AccountName').AsString) and not Empty(qryExisting.FieldByName('COGSACCNT').AsString) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('COGSACCNT').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsCOGSAccount);
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        if (qryCorrect.FieldByName('AccountType').AsString = 'COGS') then begin
          // Correct
        end else begin
          AddErrorLogMessage('');
          AddErrorLogMessage(#9 + #9 + 'Warning - ' + qryExisting.FieldByName('PARTNAME').AsString +
            ' : Cost of Goods Sold Account Type ~ Failed ( ' + qryExisting.FieldByName('COGSACCNT').AsString +
            ' Is Not A Cost of Goods Sold Account Type). ');
          AddErrorLogMessage('');
        end;

        //Asset Account
        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xAccountName').AsString := qryExisting.FieldByName('ASSETACCNT').AsString;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 5', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 5', LogLib.LogType_Debug);

        if not (qryExisting.FieldByName('ASSETACCNT').AsString = qryCorrect.FieldByName('AccountName').AsString) and not Empty(qryExisting.FieldByName('ASSETACCNT').AsString) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('ASSETACCNT').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsAssetAccount);
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        if not (qryCorrect.FieldByName('AccountType').AsString = 'OCASSET') then begin
          AddErrorLogMessage('');
          AddErrorLogMessage(#9 + #9 + 'Warning - ' + qryExisting.FieldByName('PARTNAME').AsString +
            ' : Asset Account Type ~ Failed ( ' + qryExisting.FieldByName('ASSETACCNT').AsString + ' Is Not A Asset Account Type). ');
          AddErrorLogMessage('');
        end;

        //Income Account
        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xAccountName').AsString := qryExisting.FieldByName('INCOMEACCNT').AsString;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 6', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 6', LogLib.LogType_Debug);

        if not (qryExisting.FieldByName('INCOMEACCNT').AsString = qryCorrect.FieldByName('AccountName').AsString) and not Empty(qryExisting.FieldByName('INCOMEACCNT').AsString) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('INCOMEACCNT').AsString := GetAccountName(AppEnv.CompanyPrefs.DefPartsIncomeAccount);
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        if not (qryCorrect.FieldByName('AccountType').AsString = 'INC') then begin
          AddErrorLogMessage('');
          AddErrorLogMessage(#9 + #9 + 'Warning - ' + qryExisting.FieldByName('PARTNAME').AsString +
            ' : Asset Account Type ~ Failed ( ' + qryExisting.FieldByName('INCOMEACCNT').AsString + ' Is Not A Income Account Type). ');
          AddErrorLogMessage('');
        end;

        //General
        if not (qryExisting.FieldByName('PARTTYPE').AsString = 'OTHER') then begin
          { COST }
          if not (qryExisting.FieldByName('COST1').AsCurrency > 0.00) then begin
            AddErrorLogMessage('');
            AddErrorLogMessage(#9 + #9 + 'Warning - ' + qryExisting.FieldByName('PARTNAME').AsString +
              ' : Cost Check ~ Failed ( No Cost ). ');
            AddErrorLogMessage('');
          end;
          { PRICE }
          if not (qryExisting.FieldByName('PRICE1').AsCurrency > 0.00) then begin
            AddErrorLogMessage('');
            AddErrorLogMessage(#9 + #9 + 'Warning - ' + qryExisting.FieldByName('PARTNAME').AsString +
              ' : Price Check ~ Failed ( No Price ). ');
            AddErrorLogMessage('');
          end;
          { COST >= PRICE }
          if not (qryExisting.FieldByName('PRICE1').AsCurrency > qryExisting.FieldByName('COST1').AsCurrency) then begin
            AddErrorLogMessage('');
            AddErrorLogMessage(#9 + #9 + 'Warning - ' + qryExisting.FieldByName('PARTNAME').AsString +
              ' : Profit Check ~ Failed ( No Profit Margin ). ');
            AddErrorLogMessage('');
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.POVerify(const Fix: boolean);
begin
  POClientsVerify(Fix);
  POTermsVerify(Fix);
  POLinesCorrectRoundingVerify(Fix);
  POCorrectRoundingVerify(Fix);
end;

procedure TVerifyFunctions.SalesVerify(const Fix: boolean);
begin
  SalesClientsVerify(Fix);
  SalesEmployeeFixVerify(Fix);
  SalesTermsVerify(Fix);
  SalesLinesCorrectRoundingVerify(Fix);
  SalesCorrectRoundingVerify(Fix);
end;

procedure TVerifyFunctions.POClientsVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;

  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;

  try

    //Load Queries
    with qryCorrect do begin
      {Correct ClientID}
      SQL.Clear;
      SQL.Add('SELECT  ClientID, Company FROM tblclients Where ClientID=:xClientID;');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      {Current PO ClientID}
      SQL.Clear;
      SQL.Add('SELECT PurchaseOrderID, SupplierName, ClientID  FROM tblpurchaseorders ');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xClientID').AsInteger := qryExisting.FieldByName('ClientID').AsInteger;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 7', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 7', LogLib.LogType_Debug);
        if (qryExisting.FieldByName('SupplierName').AsString = qryCorrect.FieldByName('Company').AsString) then begin
          //
        end else begin
          if Fix then begin
            qryCorrect.Close;
            qryCorrect.Params.ParamByName('xClientID').AsInteger :=
              GetClientID(qryExisting.FieldByName('SupplierName').AsString);
            loglib.Log(qryCorrect.SQL.Text + ' - Start 8', LogLib.LogType_Debug);
            qryCorrect.Open;
            loglib.Log('End 8', LogLib.LogType_Debug);

            qryExisting.Edit;
            qryExisting.FieldByName('ClientID').AsInteger := qryCorrect.FieldByName('ClientID').AsInteger;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.SalesClientsVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;

  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryCorrect2 := TMyQuery.Create(Application.MainForm);
  qryCorrect2.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect2.Options.FlatBuffers := True;
  qryCorrect2.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryCorrect do begin
      {Correct ClientID}
      SQL.Clear;
      SQL.Add('SELECT  ClientID, Company FROM tblclients WHERE ClientID=:xClientID;');
      Open;
    end;
    with qryCorrect2 do begin
      {Correct ClientID}
      SQL.Clear;
      SQL.Add('SELECT ClientID, Company FROM tblclients WHERE Company=:xCompany;');
      Open;
    end;


    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      {Current Sales ClientID}
      SQL.Clear;
      SQL.Add('SELECT SaleID, CustomerName, ClientID  FROM tblsales ');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xClientID').AsInteger := qryExisting.FieldByName('ClientID').AsInteger;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 9', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 9', LogLib.LogType_Debug);
        if (qryExisting.FieldByName('CustomerName').AsString = qryCorrect.FieldByName('Company').AsString) then begin
          //
        end else begin
          if Fix then begin
            qryCorrect2.Close;
            qryCorrect2.Params.ParamByName('xCompany').AsString := qryExisting.FieldByName('CustomerName').AsString;
            loglib.Log(qryCorrect2.SQL.Text + ' - Start 10', LogLib.LogType_Debug);
            qryCorrect2.Open;
            loglib.Log('End 10', LogLib.LogType_Debug);

            qryExisting.Edit;
            qryExisting.FieldByName('ClientID').AsInteger := qryCorrect2.FieldByName('ClientID').AsInteger;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect2.Close;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryCorrect2);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.SalesCorrectRoundingVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    with qryExisting do begin
      //Current Sales
      SQL.Clear;
      SQL.Add('Select SaleID,TotalTax,TotalAmount,TotalAmountInc From tblsales; ');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;

    qryExisting.First;
    while not qryExisting.Eof do begin
      if Fix then begin
        qryExisting.Edit;
        qryExisting.FieldByName('TotalAmountInc').asCurrency := RoundCurrency(qryExisting.FieldByName('TotalAmountInc').asCurrency);
        try
          qryExisting.Post;
        Except  
        end;
      end;
      ProgressDialog.StepIt; 
      Application.ProcessMessages;
      qryExisting.Next;
    end;
    qryExisting.Close;
  finally
    FreeAndNil(qryExisting);
  end;;
end;


procedure TVerifyFunctions.POCorrectRoundingVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    with qryExisting do begin
      //Current Sales
      SQL.Clear;
      SQL.Add('Select PurchaseOrderID,TotalTax,TotalAmount,TotalAmountInc FROM tblpurchaseorders; ');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;

    qryExisting.First;
    while not qryExisting.Eof do begin
      if Fix then begin
        qryExisting.Edit;
        qryExisting.FieldByName('TotalAmountInc').asCurrency := RoundCurrency(qryExisting.FieldByName('TotalAmountInc').asCurrency);
        try
          qryExisting.Post;
        Except  
        end;
      end;
      ProgressDialog.StepIt; 
      Application.ProcessMessages;
      qryExisting.Next;
    end;
    qryExisting.Close;
  finally
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.POLinesCorrectRoundingVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    with qryExisting do begin
      //Current PO's
      SQL.Clear;
      SQL.Add('SELECT PurchaseLineID, PurchaseOrderID, LineCostInc,LineTax,TotalLineAmount, TotalLineAmountInc, COGSTotalLineAmountInc FROM tblpurchaselines; ');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;

    qryExisting.First;
    while not qryExisting.Eof do begin
      if Fix then begin
        qryExisting.Edit;
        qryExisting.FieldByName('TotalLineAmountInc').asCurrency :=
          RoundCurrency(qryExisting.FieldByName('TotalLineAmountInc').asCurrency);
        qryExisting.FieldByName('LineTax').asCurrency := qryExisting.FieldByName('TotalLineAmountInc').asCurrency - qryExisting.FieldByName('TotalLineAmount').asCurrency;
        try
          qryExisting.Post;
        Except  
        end;
      end;
      ProgressDialog.StepIt; 
      Application.ProcessMessages;
      qryExisting.Next;
    end;
    qryExisting.Close;
  finally
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.SalesLinesCorrectRoundingVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    with qryExisting do begin
      //Current Sales's Rounding
      SQL.Clear;
      SQL.Add('SELECT SaleLineID, SaleID,LineTax,LineCost,LinePriceInc, LineCostInc,TotalLineAmount, TotalLineAmountInc  FROM tblsaleslines; ');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;

    qryExisting.First;
    while not qryExisting.Eof do begin
      if Fix then begin
        qryExisting.Edit;
        qryExisting.FieldByName('LineTax').asFloat := qryExisting.FieldByName('TotalLineAmountInc').asFloat - qryExisting.FieldByName('TotalLineAmount').asFloat;
        try
          qryExisting.Post;
        except 
        end;
      end;
      ProgressDialog.StepIt; 
      Application.ProcessMessages;
      qryExisting.Next;
    end;
    qryExisting.Close;
  finally
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.SalesLinesAccountvsPartAccountsVerify(const Fix: boolean);
label 
  Skip;
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 3;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  AddErrorLogMessage('');
  AddErrorLogMessage('*************************************************************');
  AddErrorLogMessage('Sales Parts / Account Verification Started - ' + DateTimeToStr(Now));
  AddErrorLogMessage('');

  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryCorrect2 := TMyQuery.Create(Application.MainForm);
  qryCorrect2.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect2.Options.FlatBuffers := True;
  qryCorrect2.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryCorrect do begin
      //List of Accounts & Types
      SQL.Clear;
      SQL.Add('SELECT GlobalRef, AccountID, AccountName, AccountType ');
      SQL.Add('FROM tblchartofaccounts Where  not isNull(AccountID) AND not isNull(AccountName) ');
      SQL.Add('AND AccountName=:xAccountName;');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryCorrect2 do begin
      //List of Parts
      SQL.Clear;

      SQL.Add('SELECT GlobalRef,PARTSID, PARTNAME,PARTTYPE, INCOMEACCNT, ASSETACCNT, COGSACCNT,COST1,PRICE1 ');
      SQL.Add('FROM tblparts Where  not isNull(PARTSID)  ');
      SQL.Add('AND PARTNAME=:xPartName;');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      //Current SalesLines
      SQL.Clear;

      SQL.Add('SELECT SaleLineID, tblSales.GlobalRef, tblsaleslines.SaleID, ProductID, PARTTYPE, INCOMEACCNT, ASSETACCNT, COGSACCNT, ProductGroup, ProductName ' + 'FROM tblsaleslines INNER JOIN tblSales USING(SaleID) ' +
        'Where Shipped <> 0.00 AND TotalLineAmountInc <> 0.00 AND ProductID<>0; ');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        //Parts Verifiy
        //Parts Type Check
        qryCorrect2.Close;
        qryCorrect2.Params.ParamByName('xPartName').AsString := qryExisting.FieldByName('ProductName').AsString;
        loglib.Log(qryCorrect2.SQL.Text + ' - Start 12', LogLib.LogType_Debug);
        qryCorrect2.Open;
        loglib.Log('End 12', LogLib.LogType_Debug);

        if qryCorrect2.RecordCount = 0 then begin
          AddErrorLogMessage('');
          AddErrorLogMessage(#9 + 'Transaction No. - ' + qryExisting.FieldByName('GlobalRef').AsString +
            ' > < ' + qryExisting.FieldByName('ProductName').AsString + ' : Product ~ Failed ( ' +
            qryExisting.FieldByName('ProductName').AsString + ' Product Does Not Exist .)');
          AddErrorLogMessage('');
          goto Skip;
        end;

        if not (qryExisting.FieldByName('ProductID').AsString = qryCorrect2.FieldByName('PARTSID').AsString) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('ProductID').AsString := qryCorrect2.FieldByName('PARTSID').AsString;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        if not (qryExisting.FieldByName('PARTTYPE').AsString = qryCorrect2.FieldByName('PARTTYPE').AsString) and not Empty(qryExisting.FieldByName('PARTTYPE').AsString) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('PARTTYPE').AsString := qryCorrect2.FieldByName('PARTTYPE').AsString;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        //Asset Account
        if not (qryExisting.FieldByName('ASSETACCNT').AsString = qryCorrect2.FieldByName('ASSETACCNT').AsString) and not Empty(qryExisting.FieldByName('ASSETACCNT').AsString) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('ASSETACCNT').AsString := qryCorrect2.FieldByName('ASSETACCNT').AsString;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xAccountName').AsString := qryExisting.FieldByName('ASSETACCNT').AsString;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 13', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 13', LogLib.LogType_Debug);

        if not (qryCorrect.FieldByName('AccountType').AsString = 'OCASSET') then begin
          AddErrorLogMessage('');
          AddErrorLogMessage(#9 + #9 + 'Warning - ' + qryExisting.FieldByName('ProductName').AsString +
            ' : Asset Account Type ~ Failed ( ' + qryExisting.FieldByName('ASSETACCNT').AsString + ' Is Not A Asset Account Type). ');
          AddErrorLogMessage('');
        end;

        //Income Account
        if not (qryExisting.FieldByName('INCOMEACCNT').AsString = qryCorrect2.FieldByName('INCOMEACCNT').AsString) and not Empty(qryExisting.FieldByName('INCOMEACCNT').AsString) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('INCOMEACCNT').AsString := qryCorrect2.FieldByName('INCOMEACCNT').AsString;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xAccountName').AsString := qryExisting.FieldByName('INCOMEACCNT').AsString;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 14', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 14', LogLib.LogType_Debug);

        if not (qryCorrect.FieldByName('AccountType').AsString = 'INC') then begin
          AddErrorLogMessage('');
          AddErrorLogMessage(#9 + #9 + 'Warning - ' + qryExisting.FieldByName('ProductName').AsString +
            ' : Income Account Type ~ Failed ( ' + qryExisting.FieldByName('INCOMEACCNT').AsString + ' Is Not A Income Account Type). ');
          AddErrorLogMessage('');
        end;

        //Cost of Goods Account
        if not (qryExisting.FieldByName('COGSACCNT').AsString = qryCorrect2.FieldByName('COGSACCNT').AsString) and not Empty(qryExisting.FieldByName('COGSACCNT').AsString) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('COGSACCNT').AsString := qryCorrect2.FieldByName('COGSACCNT').AsString;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xAccountName').AsString := qryExisting.FieldByName('COGSACCNT').AsString;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 15', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 15', LogLib.LogType_Debug);

        if not (qryCorrect.FieldByName('AccountType').AsString = 'COGS') then begin
          AddErrorLogMessage('');
          AddErrorLogMessage(#9 + #9 + 'Warning - ' + qryExisting.FieldByName('ProductName').AsString +
            ' : Cost of Goods Sold Account Type ~ Failed ( ' + qryExisting.FieldByName('COGSACCNT').AsString +
            ' Is Not A Cost of Goods Sold Account Type). ');
          AddErrorLogMessage('');
        end;
        Skip: ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryCorrect2.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryCorrect2);
    FreeAndNil(qryExisting);
  end;
end;


procedure TVerifyFunctions.POLinesAccountvsPartAccountsVerify(const Fix: boolean);
label 
  Skip;
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 3;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  AddErrorLogMessage('');
  AddErrorLogMessage('*************************************************************');
  AddErrorLogMessage('Purchases Parts / Account Verification Started - ' + DateTimeToStr(Now));
  AddErrorLogMessage('');

  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryCorrect2 := TMyQuery.Create(Application.MainForm);
  qryCorrect2.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect2.Options.FlatBuffers := True;
  qryCorrect2.Options.StrictUpdate := false;


  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryCorrect do begin
      //List of Accounts & Types
      SQL.Clear;

      SQL.Add('SELECT AccountID, AccountName, AccountType ');
      SQL.Add('FROM tblchartofaccounts Where  not isNull(AccountID) AND not isNull(AccountName) ');
      SQL.Add('AND AccountName=:xAccountName;');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryCorrect2 do begin
      //List of Parts
      SQL.Clear;

      SQL.Add('SELECT PARTSID, PARTNAME,PARTTYPE, INCOMEACCNT, ASSETACCNT, COGSACCNT,COST1,PRICE1 ');
      SQL.Add('FROM tblparts Where  not isNull(PARTSID)  ');
      SQL.Add('AND PARTNAME=:xPartName;');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      //Current POLines
      SQL.Clear;
      SQL.Add('SELECT PurchaseLineID, tblpurchaseorders.GlobalRef, tblpurchaselines.PurchaseOrderID, ProductID, PARTTYPE, INCOMEACCNT, ASSETACCNT, COGSACCNT, ProductGroup, ProductName ');
      SQL.Add('FROM tblpurchaselines INNER JOIN tblpurchaseorders USING(PurchaseOrderID)');
      SQL.Add('Where Shipped <> 0.00 AND TotalLineAmountInc <> 0.00 AND ProductID<>0;');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        //Parts Verifiy
        //Parts Type Check
        qryCorrect2.Close;
        qryCorrect2.Params.ParamByName('xPartName').AsString := qryExisting.FieldByName('ProductName').AsString;
        loglib.Log(qryCorrect2.SQL.Text + ' - Start 16', LogLib.LogType_Debug);
        qryCorrect2.Open;
        loglib.Log('End 16', LogLib.LogType_Debug);


        if qryCorrect2.RecordCount = 0 then begin
          AddErrorLogMessage('');
          AddErrorLogMessage(#9 + 'Transaction No. - ' + qryExisting.FieldByName('GlobalRef').AsString +
            ' > < ' + qryExisting.FieldByName('ProductName').AsString + ' : Product ~ Failed ( ' +
            qryExisting.FieldByName('ProductName').AsString + ' Product Does Not Exist .)');
          AddErrorLogMessage('');
          goto Skip;
        end;

        if not (qryExisting.FieldByName('ProductID').AsString = qryCorrect2.FieldByName('PARTSID').AsString) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('ProductID').AsString := qryCorrect2.FieldByName('PARTSID').AsString;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;


        if not (qryExisting.FieldByName('PARTTYPE').AsString = qryCorrect2.FieldByName('PARTTYPE').AsString) or
          Empty(qryExisting.FieldByName('PARTTYPE').AsString) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('PARTTYPE').AsString := qryCorrect2.FieldByName('PARTTYPE').AsString;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        // Asset Account
        if not (qryExisting.FieldByName('ASSETACCNT').AsString = qryCorrect2.FieldByName('ASSETACCNT').AsString) or Empty(qryExisting.FieldByName('ASSETACCNT').AsString) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('ASSETACCNT').AsString := qryCorrect2.FieldByName('ASSETACCNT').AsString;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xAccountName').AsString := qryExisting.FieldByName('ASSETACCNT').AsString;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 17', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 17', LogLib.LogType_Debug);

        if not (qryCorrect.FieldByName('AccountType').AsString = 'OCASSET') then begin
          AddErrorLogMessage('');
          AddErrorLogMessage(#9 + #9 + 'Warning - ' + qryExisting.FieldByName('ProductName').AsString +
            ' : Asset Account Type ~ Failed ( ' + qryExisting.FieldByName('ASSETACCNT').AsString + ' Is Not A Asset Account Type). ');
          AddErrorLogMessage('');
        end;

        //Income Account
        if not (qryExisting.FieldByName('INCOMEACCNT').AsString = qryCorrect2.FieldByName('INCOMEACCNT').AsString) or
          Empty(qryExisting.FieldByName('INCOMEACCNT').AsString) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('INCOMEACCNT').AsString := qryCorrect2.FieldByName('INCOMEACCNT').AsString;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xAccountName').AsString := qryExisting.FieldByName('INCOMEACCNT').AsString;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 18', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 18', LogLib.LogType_Debug);

        if not (qryCorrect.FieldByName('AccountType').AsString = 'INC') then begin
          AddErrorLogMessage('');
          AddErrorLogMessage(#9 + #9 + 'Warning - ' + qryExisting.FieldByName('ProductName').AsString +
            ' : Income Account Type ~ Failed ( ' + qryExisting.FieldByName('INCOMEACCNT').AsString + ' Is Not A Income Account Type). ');
          AddErrorLogMessage('');
        end;

        //Cost of Goods Account
        if not (qryExisting.FieldByName('COGSACCNT').AsString = qryCorrect2.FieldByName('COGSACCNT').AsString) or
          Empty(qryExisting.FieldByName('COGSACCNT').AsString) then begin
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('COGSACCNT').AsString := qryCorrect2.FieldByName('COGSACCNT').AsString;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xAccountName').AsString := qryExisting.FieldByName('COGSACCNT').AsString;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 19', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 19', LogLib.LogType_Debug);

        if not (qryCorrect.FieldByName('AccountType').AsString = 'COGS') then begin
          AddErrorLogMessage('');
          AddErrorLogMessage(#9 + #9 + 'Warning - ' + qryExisting.FieldByName('ProductName').AsString +
            ' : Cost of Goods Sold Account Type ~ Failed ( ' + qryExisting.FieldByName('COGSACCNT').AsString +
            ' Is Not A Cost of Goods Sold Account Type). ');
          AddErrorLogMessage('');
        end;
        Skip: ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryCorrect2.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryCorrect2);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.SalesClassVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;

  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryCorrect do begin
      {Correct ClassName}
      SQL.Clear;

      SQL.Add('SELECT ClassID,ClassName FROM tblclass WHERE ClassName=:xClassName ;');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      {Current Sales Class}
      SQL.Clear;

      SQL.Add('SELECT SaleID, ClassID, Class  FROM tblsales ');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xClassName').AsString := qryExisting.FieldByName('Class').AsString;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 20', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 20', LogLib.LogType_Debug);

        if (qryExisting.FieldByName('ClassID').AsInteger = qryCorrect.FieldByName('ClassID').AsInteger) then begin
          //
        end else begin
          if Fix then begin
            qryCorrect.Close;
            qryCorrect.Params.ParamByName('xClassName').AsString := qryExisting.FieldByName('Class').AsString;
            loglib.Log(qryCorrect.SQL.Text + ' - Start 21', LogLib.LogType_Debug);
            qryCorrect.Open;
            loglib.Log('End 21', LogLib.LogType_Debug);

            qryExisting.Edit;
            qryExisting.FieldByName('ClassID').AsInteger := qryCorrect.FieldByName('ClassID').AsInteger;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;


procedure TVerifyFunctions.POClassVerify(const Fix: boolean);
begin
  // PO LInes Class Verify ??
end;

procedure TVerifyFunctions.POMasterAccountVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;

  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryCorrect2 := TMyQuery.Create(Application.MainForm);
  qryCorrect2.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect2.Options.FlatBuffers := True;
  qryCorrect2.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryCorrect do begin
      SQL.Clear;
      SQL.Add('SELECT AccountID, AccountName, AccountType ');
      SQL.Add('FROM tblchartofaccounts Where  not isNull(AccountID) AND not isNull(AccountName) ');
      SQL.Add('AND AccountName=:xAccountName;');

      Open;
    end;
    with qryCorrect2 do begin
      SQL.Clear;
      SQL.Add('SELECT AccountID, AccountName, AccountType ');
      SQL.Add('FROM tblchartofaccounts Where  not isNull(AccountID) AND not isNull(AccountName) ');
      SQL.Add('AND AccountID=:xAccountID;');

      Open;
    end;


    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      {Current Sales Class}
      SQL.Clear;

      SQL.Add('SELECT PurchaseOrderID, Account, AccountID ,IsCheque FROM tblpurchaseorders ');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;

    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xAccountName').AsString := qryExisting.FieldByName('Account').AsString;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 22', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 22', LogLib.LogType_Debug);

        if (qryExisting.FieldByName('AccountID').AsInteger = qryCorrect.FieldByName('AccountID').AsInteger) and
          (qryExisting.FieldByName('Account').AsString > '') then begin
          //
        end else begin
          if Fix then begin
            qryCorrect.Close;
            qryCorrect.Params.ParamByName('xAccountName').AsString := qryExisting.FieldByName('Account').AsString;
            loglib.Log(qryCorrect.SQL.Text + ' - Start 23', LogLib.LogType_Debug);
            qryCorrect.Open;
            loglib.Log('End 23', LogLib.LogType_Debug);

            qryExisting.Edit;

            qryExisting.FieldByName('AccountID').AsInteger := qryCorrect.FieldByName('AccountID').AsInteger;

            if (qryExisting.FieldByName('AccountID').AsInteger = 0) or (qryCorrect.FieldByName('AccountName').AsString = '') then begin
              if qryExisting.FieldByName('IsCheque').AsString = 'T' then begin
                qryCorrect2.Close;
                qryCorrect2.Params.ParamByName('xAccountID').AsInteger := AppEnv.CompanyPrefs.DefaultChequeAccount;
                loglib.Log(qryCorrect2.SQL.Text + ' - Start 24', LogLib.LogType_Debug);
                qryCorrect2.Open;
                loglib.Log('End 24', LogLib.LogType_Debug);
                qryExisting.Edit;
                qryExisting.FieldByName('AccountID').AsInteger := qryCorrect2.FieldByName('AccountID').AsInteger;
                qryExisting.FieldByName('Account').AsString := qryCorrect2.FieldByName('AccountName').AsString;
              end else begin
                qryCorrect2.Close;
                qryCorrect2.Params.ParamByName('xAccountID').AsInteger := AppEnv.CompanyPrefs.DefaultPurchasesAccount;
                loglib.Log(qryCorrect2.SQL.Text + ' - Start 25', LogLib.LogType_Debug);
                qryCorrect2.Open;
                loglib.Log('End 25', LogLib.LogType_Debug);
                qryExisting.Edit;
                qryExisting.FieldByName('AccountID').AsInteger := qryCorrect2.FieldByName('AccountID').AsInteger;
                qryExisting.FieldByName('Account').AsString := qryCorrect2.FieldByName('AccountName').AsString;
              end;
            end;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryCorrect2.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryCorrect2);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.SalesMasterAccountVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryCorrect2 := TMyQuery.Create(Application.MainForm);
  qryCorrect2.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect2.Options.FlatBuffers := True;
  qryCorrect2.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryCorrect do begin
      {Correct ClassName}
      SQL.Clear;

      SQL.Add('SELECT AccountID, AccountName, AccountType ');
      SQL.Add('FROM tblchartofaccounts Where  not isNull(AccountID) AND not isNull(AccountName) ');
      SQL.Add('AND AccountName=:xAccountName;');

      Open;
    end;
    with qryCorrect2 do begin
      {Correct ClassName}
      SQL.Clear;

      SQL.Add('SELECT AccountID, AccountName, AccountType ');
      SQL.Add('FROM tblchartofaccounts Where  not isNull(AccountID) AND not isNull(AccountName) ');
      SQL.Add('AND AccountID=:xAccountID;');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      {Current Sales Class}
      SQL.Clear;

      SQL.Add('SELECT SaleID, Account, AccountID ,IsCashSale FROM tblsales ');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;

    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xAccountName').AsString := qryExisting.FieldByName('Account').AsString;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 26', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 26', LogLib.LogType_Debug);

        if (qryExisting.FieldByName('AccountID').AsInteger = qryCorrect.FieldByName('AccountID').AsInteger) and
          (qryExisting.FieldByName('Account').AsString > '') then begin
          //
        end else begin
          if Fix then begin
            qryCorrect.Close;
            qryCorrect.Params.ParamByName('xAccountName').AsString := qryExisting.FieldByName('Account').AsString;
            loglib.Log(qryCorrect.SQL.Text + ' - Start 27', LogLib.LogType_Debug);
            qryCorrect.Open;
            loglib.Log('End 27', LogLib.LogType_Debug);
            qryExisting.Edit;

            qryExisting.FieldByName('AccountID').AsInteger := qryCorrect.FieldByName('AccountID').AsInteger;

            if (qryExisting.FieldByName('AccountID').AsInteger = 0) or (qryCorrect.FieldByName('AccountName').AsString = '') then begin
              if qryExisting.FieldByName('IsCashSale').AsString = 'T' then begin
                qryCorrect.Close;
                qryCorrect.Params.ParamByName('xAccountName').AsString := 'Undeposited Funds';
                loglib.Log(qryCorrect.SQL.Text + ' - Start 28', LogLib.LogType_Debug);
                qryCorrect.Open;
                loglib.Log('End 28', LogLib.LogType_Debug);

                qryExisting.Edit;
                qryExisting.FieldByName('AccountID').AsInteger := qryCorrect.FieldByName('AccountID').AsInteger;
                qryExisting.FieldByName('Account').AsString := qryCorrect.FieldByName('AccountName').AsString;
              end else begin
                qryCorrect2.Close;
                qryCorrect2.Params.ParamByName('xAccountID').AsInteger := AppEnv.CompanyPrefs.DefaultSalesAccount;
                loglib.Log(qryCorrect2.SQL.Text + ' - Start 29', LogLib.LogType_Debug);
                qryCorrect2.Open;
                loglib.Log('End 29', LogLib.LogType_Debug);

                qryExisting.Edit;
                qryExisting.FieldByName('AccountID').AsInteger := qryCorrect2.FieldByName('AccountID').AsInteger;
                qryExisting.FieldByName('Account').AsString := qryCorrect2.FieldByName('AccountName').AsString;
              end;
            end;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect2.Close;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryCorrect2);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.SalesEmployeeFixVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.StrictUpdate := false;
  qryCorrect.Options.FlatBuffers := True;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.StrictUpdate := false;
  qryExisting.Options.FlatBuffers := True;
  try
    //Load Queries
    with qryCorrect do begin
      {Correct Employee}
      SQL.Clear;
      SQL.Add('SELECT EmployeeID, EmployeeName FROM tblEmployees ');
      SQL.Add('WHERE EmployeeName=:xEmployeeName;');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      {Current Sales Employee}
      SQL.Clear;

      SQL.Add('SELECT SaleID, EmployeeID, EmployeeName  FROM tblsales; ');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        qryCorrect.Close;
        qryCorrect.Params.ParamByName('xEmployeeName').AsString := qryExisting.FieldByName('EmployeeName').AsString;
        loglib.Log(qryCorrect.SQL.Text + ' - Start 30', LogLib.LogType_Debug);
        qryCorrect.Open;
        loglib.Log('End 30', LogLib.LogType_Debug);

        if (qryExisting.FieldByName('EmployeeID').AsInteger = qryCorrect.FieldByName('EmployeeID').AsInteger) then begin
          //
        end else begin
          if Fix then begin
            qryCorrect.Close;
            qryCorrect.Params.ParamByName('xEmployeeName').AsString := qryExisting.FieldByName('EmployeeName').AsString;
            loglib.Log(qryCorrect.SQL.Text + ' - Start 31', LogLib.LogType_Debug);
            qryCorrect.Open;
            loglib.Log('End 31', LogLib.LogType_Debug);

            qryExisting.Edit;
            qryExisting.FieldByName('EmployeeID').AsInteger := qryCorrect.FieldByName('EmployeeID').AsInteger;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.POOutOfBalanceVerify(const Fix: boolean);
var
  TempTotals, TotalEx, TotalTax: currency;

  function GetPOlinesTotals(const ID: string; var TotalEx: currency; var TotalTax: currency): currency;
  begin
    with qryCorrect do begin
      {Correct SaleLines}
      SQL.Clear;

      SQL.Add('SELECT  PurchaseOrderID, Sum(TotalLineAmountInc) as TotalPOInc , Sum(TotalLineAmount) as TotalPOEx ');
      SQL.Add('FROM tblpurchaselines Where PurchaseOrderID = ' + ID + ' Group By PurchaseOrderID ');

      Open;

      if not qryCorrect.IsEmpty then begin
        Result := qryCorrect.FieldByName('TotalPOInc').asCurrency;
        TotalEx := qryCorrect.FieldByName('TotalPOEx').asCurrency;
        TotalTax := RoundCurrency(Result - TotalEx);
      end else begin
        Result := 0.00;
      end;
    end;
  end;
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.StrictUpdate := false;
  qryCorrect.Options.FlatBuffers := True;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryExisting do begin
      {Correct SaleLines}
      SQL.Clear;

      SQL.Add('SELECT PurchaseOrderID, GlobalRef, PurchaseOrderNumber,TotalTax,TotalAmount, TotalAmountInc, ');
      SQL.Add('If(tblPurchaseOrders.IsBill="T","[Bill]",If(tblPurchaseOrders.IsPO="T","[Purchase Order]", ');
      SQL.Add('If(tblPurchaseOrders.IsCredit="T","[Credit]",If(tblPurchaseOrders.IsCheque="T","[Cheque]","[RA]")))) AS Type ');
      SQL.Add('FROM tblPurchaseOrders ');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;

    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        TempTotals := RoundCurrency(GetPOlinesTotals(qryExisting.FieldByName('PurchaseOrderID').AsString, TotalEx, TotalTax));
        if (RoundCurrency(qryExisting.FieldByName('TotalAmountInc').asCurrency) <> TempTotals) then begin
          AddErrorLogMessage('');
          AddErrorLogMessage('Warning - ' + qryExisting.FieldByName('Type').AsString +
            ' Transaction Number - ' + qryExisting.FieldByName('PurchaseOrderNumber').AsString + ' (' +
            qryExisting.FieldByName('GlobalRef').AsString + ') Line Totals Don''t Match Grand Total');
          AddErrorLogMessage(FloatToStr(RoundCurrency(qryExisting.FieldByName('TotalAmountInc').asCurrency)) +
            ' Not equal To Line Totals ' + FloatToStr(TempTotals));
          AddErrorLogMessage('');

          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('TotalTax').asCurrency := TotalTax;
            qryExisting.FieldByName('TotalAmount').asCurrency := TotalEx;
            qryExisting.FieldByName('TotalAmountInc').asCurrency := TempTotals;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.SalesOutOfBalanceVerify(const Fix: boolean);
var
  TotalTax, TotalEx, TempTotals: currency;

  function GetSalelinesTotals(const ID: string; var TotalEx: currency; var TotalTax: currency): currency;
  begin
    with qryCorrect do begin
      {Correct SaleLines}
      SQL.Clear;

      SQL.Add('SELECT  SaleID, Sum(TotalLineAmountInc) as TotalSaleInc, Sum(TotalLineAmount) as TotalSaleEx ');
      SQL.Add('FROM tblsaleslines Where SaleID = ' + ID + ' Group By SaleID ');

      Open;

      if not qryCorrect.IsEmpty then begin
        Result := qryCorrect.FieldByName('TotalSaleInc').asCurrency;
        TotalEx := qryCorrect.FieldByName('TotalSaleEx').asCurrency;
        TotalTax := RoundCurrency(Result - TotalEx);
      end else begin
        Result := 0.00;
      end;
    end;
  end;
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.StrictUpdate := false;
  qryCorrect.Options.FlatBuffers := True;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.StrictUpdate := false;
  qryExisting.Options.FlatBuffers := True;
  try

    //Load Queries
    with qryExisting do begin
      {Correct SaleLines}
      SQL.Clear;

      SQL.Add('SELECT SaleID, GlobalRef,InvoiceDocNumber,TotalTax, TotalAmount, TotalAmountInc, ');
      SQL.Add('If(tblSales.IsCashSale="T" And tblSales.IsPOS="F" ,"Cash Sale",If(tblSales.IsRefund="T","Refund", ');
      SQL.Add('If(tblSales.IsCashSale="T" And tblSales.IsPOS="T","POS", ');
      SQL.Add('If(tblSales.IsInvoice="T","Invoice","Unknown")))) as Type ');
      SQL.Add('FROM tblSales ');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;

    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        TempTotals := RoundCurrency(GetSalelinesTotals(qryExisting.FieldByName('SaleID').AsString, TotalEx, TotalTax));
        if (RoundCurrency(qryExisting.FieldByName('TotalAmountInc').asCurrency) <> TempTotals) then begin
          AddErrorLogMessage('');
          AddErrorLogMessage('Warning - [' + qryExisting.FieldByName('Type').AsString +
            '] Transaction Number - ' + qryExisting.FieldByName('InvoiceDocNumber').AsString + ' (' +
            qryExisting.FieldByName('GlobalRef').AsString + ') Line Totals Don''t Match Grand Total');
          AddErrorLogMessage(FloatToStr(RoundCurrency(qryExisting.FieldByName('TotalAmountInc').asCurrency)) +
            ' Not equal To Line Totals ' + FloatToStr(TempTotals));
          AddErrorLogMessage('');
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('TotalTax').asCurrency := TotalTax;
            qryExisting.FieldByName('TotalAmount').asCurrency := TotalEx;
            qryExisting.FieldByName('TotalAmountInc').asCurrency := TempTotals;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.DepositsOutOfBalanceVerify(const Fix: boolean);
var
  TempTotals: currency;

  function GetSalelinesTotals(const ID: string): currency;
  begin
    with qryCorrect do begin
      {Correct SaleLines}
      SQL.Clear;

      SQL.Add('SELECT tblbankdepositlines.DepositID,  Sum(tblbankdepositlines.Amount) as TotalAmount ');
      SQL.Add('FROM tblbankdeposit INNER JOIN tblbankdepositlines USING(DepositID) WHERE  tblbankdeposit.Deleted="F" AND tblbankdepositlines.DepositID = ' + ID + ' Group By tblbankdepositlines.DepositID ');

      Open;

      if not qryCorrect.IsEmpty then begin
        Result := qryCorrect.FieldByName('TotalAmount').asCurrency;
      end else begin
        Result := 0.00;
      end;
    end;
  end;
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryExisting do begin
      {Correct SaleLines}
      SQL.Clear;

      SQL.Add('SELECT GlobalRef, DepositID,Deposit FROM tblbankdeposit WHERE  tblbankdeposit.Deleted="F"');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;

    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        TempTotals := RoundCurrency(GetSalelinesTotals(qryExisting.FieldByName('DepositID').AsString));
        if (RoundCurrency(qryExisting.FieldByName('Deposit').asCurrency) <> TempTotals) then begin
          AddErrorLogMessage('');
          AddErrorLogMessage('Warning - [Bank Deposit] Transaction Number - ' +
            qryExisting.FieldByName('DepositID').AsString + ' (' + qryExisting.FieldByName('GlobalRef').AsString +
            ') Line Totals Don''t Match Grand Total');
          AddErrorLogMessage(FloatToStr(RoundCurrency(qryExisting.FieldByName('Deposit').asCurrency)) +
            ' Not equal To Line Totals ' + FloatToStr(TempTotals));
          AddErrorLogMessage('');
          if Fix then begin
            qryExisting.Edit;
            qryExisting.FieldByName('Deposit').asCurrency := TempTotals;
            try
              qryExisting.Post;
            Except  
            end;
          end;
        end;

        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.PartTypeVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;

  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    with qryExisting do begin
      SQL.Clear;
      SQL.Add('SELECT PARTSID, PARTNAME, PARTTYPE ');
      SQL.Add('FROM tblparts Where not isNull(PARTSID);');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        with qryCorrect do begin
          SQL.Clear;
          SQL.Add('UPDATE tblpurchaselines SET PARTTYPE= ' + QuotedStr(qryExisting.FieldByName('PARTTYPE').AsString) + ' ');
          SQL.Add('WHERE `ProductID` = ' + FastFuncs.IntToStr(qryExisting.FieldByName('PARTSID').AsInteger) + ';');
          Execute;
        end;
        with qryCorrect do begin
          SQL.Clear;
          SQL.Add('UPDATE tblsaleslines SET PARTTYPE= ' + QuotedStr(qryExisting.FieldByName('PARTTYPE').AsString) + ' ');
          SQL.Add('WHERE `ProductID` = ' + FastFuncs.IntToStr(qryExisting.FieldByName('PARTSID').AsInteger) + ';');
          Execute;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
      {Qtys Fix}
      with qryCorrect do begin
        SQL.Clear;
        SQL.Add('UPDATE tblpurchaselines INNER JOIN  tblpurchaseorders USING(PurchaseOrderID) ');
        SQL.Add('SET ReceivedDate=IF(IsNull(tblpurchaseorders.InvoiceDate),tblpurchaseorders.OrderDate,tblpurchaseorders.InvoiceDate) ');
        SQL.Add('WHERE tblpurchaseorders.IsPO="T" AND IsNull(tblpurchaselines.ReceivedDate) ');
        SQL.Add('AND tblpurchaselines.Shipped <>0.00; ');
        Execute;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.PartsVolumeLevelPricesVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    with qryExisting do begin
      {List of Parts}
      SQL.Clear;
      SQL.Add('SELECT PARTSID, BuyQTY1, BuyQTY2, BuyQTY3, SellQTY1, SellQTY2, SellQTY3, COST1, COST2, COST3, PRICE1, PRICE2, PRICE3 ');
      SQL.Add('FROM tblparts Where  not isNull(PARTSID)  ');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;


    with qryExisting do begin
      First;
      while not Eof do begin
        Edit;
        // 1st Volumes Qty = 1;
        if (FieldByName('BuyQTY1').AsFloat <> 0) then begin
          FieldByName('BuyQTY1').AsFloat := 1;
        end;
        if (FieldByName('SellQTY1').AsFloat <> 0) then begin
          FieldByName('SellQTY1').AsFloat := 1;
        end;

        // Sell Qty Volumes Prices
        if (FieldByName('SellQTY2').AsFloat < FieldByName('SellQTY1').AsFloat) then begin
          FieldByName('SellQTY2').AsFloat := FieldByName('SellQTY1').AsFloat;
        end else if (FieldByName('SellQTY3').AsFloat < FieldByName('SellQTY2').AsFloat) then begin
          FieldByName('SellQTY3').AsFloat := FieldByName('SellQTY2').AsFloat;
        end;

        //Prices Same Qty Level
        if (FieldByName('PRICE2').AsFloat <> FieldByName('PRICE1').AsFloat) and
          (FieldByName('SellQTY2').AsFloat = FieldByName('SellQTY1').AsFloat) then begin
          FieldByName('PRICE2').AsFloat := FieldByName('PRICE1').AsFloat;
        end else if (FieldByName('PRICE3').AsFloat <> FieldByName('PRICE2').AsFloat) and
          (FieldByName('SellQTY3').AsFloat = FieldByName('SellQTY2').AsFloat) then begin
          FieldByName('PRICE3').AsFloat := FieldByName('PRICE2').AsFloat;
        end;

        // Buy Qty Volumes Prices
        if (FieldByName('BuyQTY2').AsFloat < FieldByName('BuyQTY1').AsFloat) then begin
          FieldByName('BuyQTY2').AsFloat := FieldByName('BuyQTY1').AsFloat;
        end else if (FieldByName('BuyQTY3').AsFloat < FieldByName('BuyQTY2').AsFloat) then begin
          FieldByName('BuyQTY3').AsFloat := FieldByName('BuyQTY2').AsFloat;
        end;
        //Costs Same Qty Level
        if (FieldByName('COST2').AsFloat <> FieldByName('COST1').AsFloat) and
          (FieldByName('BuyQTY2').AsFloat = FieldByName('BuyQTY1').AsFloat) then begin
          FieldByName('COST2').AsFloat := FieldByName('COST1').AsFloat;
        end else if (FieldByName('COST3').AsFloat <> FieldByName('COST2').AsFloat) and
          (FieldByName('BuyQTY3').AsFloat = FieldByName('BuyQTY2').AsFloat) then begin
          FieldByName('COST3').AsFloat := FieldByName('COST2').AsFloat;
        end;

        Post;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryExisting.Close;
  finally
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.PartsPricesExVerify(const Fix: boolean);
var
  TempEx, TempInc: double;
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    with qryExisting do begin
      {List of Parts}
      SQL.Clear;

      SQL.Add('SELECT PARTSID, COST1, COST2, COST3,COSTINC1,COSTINC2,COSTINC3, PRICE1, PRICE2, PRICE3,PRICEINC1,PRICEINC2,PRICEINC3, TaxCode ');
      SQL.Add('FROM tblparts Where  not isNull(PARTSID)  ');

      Open;
    end;
    ProgressDialog.StepIt;
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := (qryExisting.RecordCount * 5) + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;


    with qryExisting do begin
      First;
      while not Eof do begin
        //COST1
        TempEx := FieldByName('COST1').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        TempEx := GetAmountEx(TempInc, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        Edit;
        FieldByName('COST1').AsFloat := TempEx;
        ProgressDialog.StepIt;
        Application.ProcessMessages;
        //COSTINC1
        TempEx := FieldByName('COST1').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        Edit;
        FieldByName('COSTINC1').AsFloat := TempInc;
        ProgressDialog.StepIt;
        Application.ProcessMessages;
        //COST2
        TempEx := FieldByName('COST2').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        TempEx := GetAmountEx(TempInc, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        Edit;
        FieldByName('COST2').AsFloat := TempEx;
        ProgressDialog.StepIt;
        Application.ProcessMessages;
        //COSTINC2
        TempEx := FieldByName('COST2').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        Edit;
        FieldByName('COSTINC2').AsFloat := TempInc;
        ProgressDialog.StepIt;
        Application.ProcessMessages;
        //COST3
        TempEx := FieldByName('COST3').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        TempEx := GetAmountEx(TempInc, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        Edit;
        FieldByName('COST3').AsFloat := TempEx;
        ProgressDialog.StepIt;
        Application.ProcessMessages;
        //COSTINC3
        TempEx := FieldByName('COST3').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        Edit;
        FieldByName('COSTINC3').AsFloat := TempInc;
        ProgressDialog.StepIt;
        Application.ProcessMessages;
        //PRICE1
        TempEx := FieldByName('PRICE1').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        TempEx := GetAmountEx(TempInc, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        Edit;
        FieldByName('PRICE1').AsFloat := TempEx;
        ProgressDialog.StepIt;
        Application.ProcessMessages;
        //PRICEINC1
        TempEx := FieldByName('PRICE1').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        Edit;
        FieldByName('PRICEINC1').AsFloat := TempInc;
        ProgressDialog.StepIt;
        Application.ProcessMessages;
        //PRICE2
        TempEx := FieldByName('PRICE2').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        TempEx := GetAmountEx(TempInc, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        Edit;
        FieldByName('PRICE2').AsFloat := TempEx;
        ProgressDialog.StepIt;
        Application.ProcessMessages;
        //PRICEINC2
        TempEx := FieldByName('PRICE2').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        Edit;
        FieldByName('PRICEINC2').AsFloat := TempInc;
        ProgressDialog.StepIt;
        Application.ProcessMessages;
        //PRICE3
        TempEx := FieldByName('PRICE3').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        TempEx := GetAmountEx(TempInc, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        Edit;
        FieldByName('PRICE3').AsFloat := TempEx;
        //PRICEINC3
        TempEx := FieldByName('PRICE3').AsFloat;
        TempInc := GetAmountInc(TempEx, GetTaxRate(qryExisting.FieldByName('TaxCode').AsString));
        TempInc := RoundCurrency(TempInc);
        Edit;
        FieldByName('PRICEINC3').AsFloat := TempInc;
        if Fix then begin
          try
            Post;
          Except 
          end;
        end;
        ProgressDialog.StepIt;
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryExisting.Close;
  finally
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.POBalancesVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryExisting do begin
      SQL.Clear;

      SQL.Add('SELECT PurchaseOrderID, GlobalRef, PurchaseOrderNumber,Balance,Paid,Payment,TotalAmountInc,IsCredit ');
      SQL.Add('FROM tblPurchaseOrders Where (IsBill="T" OR IsCredit="T" OR IsPO="T")');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;

    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        if Fix then begin
          Edit;
          if not (FieldByName('IsCredit').AsString = 'T') then begin
            FieldByName('Balance').asCurrency := RoundCurrency(RoundCurrency(FieldByName('TotalAmountInc').asCurrency) - RoundCurrency(FieldByName('Payment').asCurrency));
          end else begin
            FieldByName('Balance').asCurrency := RoundCurrency(RoundCurrency(FieldByName('TotalAmountInc').asCurrency) - RoundCurrency(-FieldByName('Payment').asCurrency));
          end;
          if FieldByName('Balance').asCurrency <> 0.00 then begin
            FieldByName('Paid').AsString := 'F';
          end else begin
            FieldByName('Paid').AsString := 'T';
          end;
          try
            Post;
          Except  
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryExisting.Close;
  finally
    FreeAndNil(qryExisting);
  end;
end;


procedure TVerifyFunctions.SalesBalancesVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryExisting do begin
      SQL.Clear;

      SQL.Add('SELECT SaleID, GlobalRef,InvoiceDocNumber,Balance,Paid,Payment,TotalAmountInc  ');
      SQL.Add('FROM tblSales Where (IsInvoice="T" OR IsRefund="T")');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;

    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        if Fix then begin
          Edit;
          FieldByName('Balance').asCurrency := RoundCurrency(RoundCurrency(FieldByName('TotalAmountInc').asCurrency) - RoundCurrency(FieldByName('Payment').asCurrency));
          if RoundCurrency(FieldByName('Balance').asCurrency) <> 0.00 then begin
            FieldByName('Paid').AsString := 'F';
          end else begin
            FieldByName('Paid').AsString := 'T';
          end;
          if RoundCurrency(FieldByName('TotalAmountInc').asCurrency) = 0.00 then FieldByName('Paid').AsString := 'F';
          try
            Post;
          Except  
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryExisting.Close;
  finally
    FreeAndNil(qryExisting);
  end;
end;


function TVerifyFunctions.PartsQuantities(const ProductID, ClassID: integer; var OnHire, InStockQty, SalesOrderQty, SalesOrderBOQty, InvoiceBOQty, OnOrderQty: double; const NonInventoryPart: boolean = false): boolean;
var
  qryTemp: TMyQuery;
  ShippedSales: double;
  ReceivedPO: double;
  StockAdjust: double;
  StockTransferFrom: double;
  StockTransferTO: double;
  GroupBuilds: double;
  Groups: double;
  VGroupBuilds: double;
  VGroups: double;
  //strSQL :String;
begin
  qryTemp := TMyQuery.Create(Application.MainForm);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Options.StrictUpdate := false;
  try
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // On Hire
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Count(tblhirelines.ProductID) as QTY FROM tblhire ');
    qryTemp.SQL.Add('INNER JOIN tblhirelines USING(HireID) INNER JOIN tblparts on tblparts.PARTSID=tblhirelines.ProductID ');
    qryTemp.SQL.Add('WHERE (tblhire.Active="T") AND (IsNull(ReturnedDate) OR (CURDATE()<ReturnedDate)) ');
    if not NonInventoryPart then begin
      qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    end;
    qryTemp.SQL.Add('AND tblhirelines.ProductID=' + FastFuncs.IntToStr(ProductID) + ' AND tblhire.ClassID=' + FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;

    if not qryTemp.IsEmpty then begin
      OnHire := qryTemp.FieldByName('QTY').AsFloat;
    end else begin
      OnHire := 0.00;
    end;

    // Groups
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum(BuildQty-UnBuildQty+0.00) as QTY FROM tblgroupbuild  ');
    qryTemp.SQL.Add('INNER JOIN tblparts on tblparts.PARTSID=GroupPartID ');
    qryTemp.SQL.Add('Where (tblgroupbuild.Buildstatus = "B" or tblgroupbuild.Buildstatus = "U")');
    qryTemp.SQL.Add('and  (tblgroupbuild.Deleted<>"T" ) ');
    if not NonInventoryPart then begin
      qryTemp.SQL.Add('AND PARTTYPE="GRP" ');
    end;
    qryTemp.SQL.Add('AND tblgroupbuild.GroupPartID=' + FastFuncs.IntToStr(ProductID) + ' AND tblgroupbuild.ClassID=' +
      FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Groups := qryTemp.FieldByName('QTY').AsFloat;
    end else begin
      Groups := 0.00;
    end;

    // Group Builds
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum((BuildQty-UnBuildQty+0.00)*Qty) as QTY FROM tblgroupbuildlines ');
    qryTemp.SQL.Add('INNER JOIN tblgroupbuild on BuildID=GroupBuildID INNER JOIN tblparts on tblparts.PARTSID=tblgroupbuildlines.PartsID ');
    qryTemp.SQL.Add('Where (tblgroupbuild.Buildstatus = "B" or tblgroupbuild.Buildstatus = "U")');
    qryTemp.SQL.Add('and (tblgroupbuild.Deleted<>"T") ');
    if not NonInventoryPart then begin
      qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    end;
    qryTemp.SQL.Add('AND tblgroupbuildlines.PartsID=' + FastFuncs.IntToStr(ProductID) + ' AND tblgroupbuild.ClassID=' +
      FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      GroupBuilds := qryTemp.FieldByName('QTY').AsFloat;
    end else begin
      GroupBuilds := 0.00;
    end;

    // V Groups
    VGroups := 0.00;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum(BuildQty+0.00) as QTY FROM tblvargroupbuild  ');
    qryTemp.SQL.Add('INNER JOIN tblparts on tblparts.PARTSID=GroupPartID ');
    qryTemp.SQL.Add('WHERE (tblvargroupbuild.BuildStatus="B") ');
    if not NonInventoryPart then begin
      qryTemp.SQL.Add('AND PARTTYPE="GRP" ');
    end;
    qryTemp.SQL.Add('AND tblvargroupbuild.GroupPartID=' + FastFuncs.IntToStr(ProductID) +
      ' AND tblvargroupbuild.ClassID=' + FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      VGroups := qryTemp.FieldByName('QTY').AsFloat;
    end;
(*// V Groups unbuild
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum(0.00-BuildQty) as QTY FROM tblvargroupbuild  ');
    qryTemp.SQL.Add('INNER JOIN tblparts on tblparts.PARTSID=GroupPartID ');
    qryTemp.SQL.Add('WHERE (tblvargroupbuild.BuildStatus="U") ');
    if not NonInventoryPart then begin
      qryTemp.SQL.Add('AND PARTTYPE="GRP" ');
    end;
    qryTemp.SQL.Add('AND tblvargroupbuild.GroupPartID=' + FastFuncs.IntToStr(ProductID) +
      ' AND tblvargroupbuild.ClassID=' + FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      VGroups := VGroups + qryTemp.FieldByName('QTY').AsFloat;
    end;*)

    // V Group Builds
    VGroupBuilds := 0.00;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum((BuildQty+0.00)*Qty) as QTY FROM tblvargroupbuildlines ');
    qryTemp.SQL.Add('INNER JOIN tblvargroupbuild on BuildID=GroupBuildID INNER JOIN tblparts on tblparts.PARTSID=tblvargroupbuildlines.PartsID ');
    qryTemp.SQL.Add('WHERE (tblvargroupbuild.BuildStatus="B") ');
    if not NonInventoryPart then begin
      qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    end;
    qryTemp.SQL.Add('AND tblvargroupbuildlines.PartsID=' + FastFuncs.IntToStr(ProductID) +
      ' AND tblvargroupbuild.ClassID=' + FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      VGroupBuilds := qryTemp.FieldByName('QTY').AsFloat;
    end;
(*// V Group un Builds
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum((0.00-BuildQty)*Qty) as QTY FROM tblvargroupbuildlines ');
    qryTemp.SQL.Add('INNER JOIN tblvargroupbuild on BuildID=GroupBuildID INNER JOIN tblparts on tblparts.PARTSID=tblvargroupbuildlines.PartsID ');
    qryTemp.SQL.Add('WHERE (tblvargroupbuild.BuildStatus="U") ');
    if not NonInventoryPart then begin
      qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    end;
    qryTemp.SQL.Add('AND tblvargroupbuildlines.PartsID=' + FastFuncs.IntToStr(ProductID) +
      ' AND tblvargroupbuild.ClassID=' + FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      VGroupBuilds := VGroupBuilds + qryTemp.FieldByName('QTY').AsFloat;
    end;*)

    //Shipped Sales
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum(Shipped) as QTY FROM tblsaleslines INNER JOIN tblsales Using(SaleID) WHERE ((IsInvoice="T" OR IsRefund="T" OR IsCashSale="T" Or ISPOS = "T") ');
    qryTemp.SQL.Add('AND ( tblsales.IsQuote<>"T" AND IsSalesOrder<>"T" AND IsVoucher<>"T" AND IsLayby<>"T" AND IsLaybyTOS<>"T" AND IsLaybyPayment<>"T")) ');
    if not NonInventoryPart then begin
      qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    end;
    qryTemp.SQL.Add('AND ProductID=' + FastFuncs.IntToStr(ProductID) + ' AND ClassID=' + FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      ShippedSales := qryTemp.FieldByName('QTY').AsFloat;
    end else begin
      ShippedSales := 0.00;
    end;

    //Received PO
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum(Shipped) as QTY FROM tblpurchaselines INNER JOIN tblpurchaseorders Using(PurchaseOrderID) WHERE (IsPO="T")  ');
    if not NonInventoryPart then begin
      qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    end;
    qryTemp.SQL.Add('AND ProductID=' + FastFuncs.IntToStr(ProductID) + ' AND ClassID=' + FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      ReceivedPO := qryTemp.FieldByName('QTY').AsFloat;
    end else begin
      ReceivedPO := 0.00;
    end;

    //Stock Adjustments
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum(Qty) as QTY FROM tblstockadjustment INNER JOIN tblstockadjust Using(StockAdjustmentNo) ');
    qryTemp.SQL.Add('WHERE tblstockadjust.Deleted="F" AND ProductID=' + FastFuncs.IntToStr(ProductID) + ' AND ClassID=' + FastFuncs.IntToStr(ClassID) + ' ');
    qryTemp.SQL.Add('AND (Length(BinLocation)=0 OR IsNull(BinLocation)) AND (Length(BinNumber)=0 OR IsNull(BinNumber)) AND (Length(BatchNo)=0 OR IsNull(BatchNo)) ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      StockAdjust := qryTemp.FieldByName('QTY').AsFloat;
    end else begin
      StockAdjust := 0.00;
    end;

    //Stock Transfer From
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum(TransferQty) AS QTY FROM tblstocktransferlines INNER JOIN tblstocktransfer Using(TransferID) ');
    qryTemp.SQL.Add('WHERE tblstocktransfer.Deleted="F" AND PartsID=' + FastFuncs.IntToStr(ProductID) + ' AND TransferFromID=' + FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      StockTransferFrom := qryTemp.FieldByName('QTY').AsFloat;
    end else begin
      StockTransferFrom := 0.00;
    end;

    //Stock Transfer TO
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum(TransferQty) AS QTY FROM tblstocktransferlines INNER JOIN tblstocktransfer Using(TransferID) ');
    qryTemp.SQL.Add('WHERE tblstocktransfer.Deleted="F" AND PartsID=' + FastFuncs.IntToStr(ProductID) + ' AND ClassIDTo=' + FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      StockTransferTO := qryTemp.FieldByName('QTY').AsFloat;
    end else begin
      StockTransferTO := 0.00;
    end;

    {In Stock Qty}
    InStockQty := ((((ReceivedPO - ShippedSales) + StockAdjust) + (StockTransferTO - StockTransferFrom) - (GroupBuilds + VGroupBuilds)) + (Groups + VGroups));
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    {On Sales Order Qty}
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum(Shipped) as QTY FROM tblsaleslines INNER JOIN tblsales Using(SaleID) WHERE Converted<>"T" AND IsSalesOrder="T" ');
    if not NonInventoryPart then begin
      qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    end;
    qryTemp.SQL.Add('AND ProductID=' + FastFuncs.IntToStr(ProductID) + ' AND ClassID=' + FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      SalesOrderQty := qryTemp.FieldByName('QTY').AsFloat;
    end else begin
      SalesOrderQty := 0.00;
    end;
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    {On Sales Order BO Qty}
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum(BackOrder) as QTY FROM tblsaleslines INNER JOIN tblsales Using(SaleID) WHERE Converted<>"T" AND IsSalesOrder="T" ');
    if not NonInventoryPart then begin
      qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    end;
    qryTemp.SQL.Add('AND Invoiced="F" AND ProductID=' + FastFuncs.IntToStr(ProductID) + ' AND ClassID=' + FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      SalesOrderBOQty := qryTemp.FieldByName('QTY').AsFloat;
    end else begin
      SalesOrderBOQty := 0.00;
    end;
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    {On Invoice BO Qty}
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum(BackOrder) as QTY FROM tblsaleslines INNER JOIN tblsales Using(SaleID) WHERE IsInvoice="T" ');
    if not NonInventoryPart then begin
      qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    end;
    qryTemp.SQL.Add('AND Invoiced="F" AND ProductID=' + FastFuncs.IntToStr(ProductID) + ' AND ClassID=' + FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      InvoiceBOQty := qryTemp.FieldByName('QTY').AsFloat;
    end else begin
      InvoiceBOQty := 0.00;
    end;
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    {On PO BO Qty}
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT Sum(BackOrder) as QTY FROM tblpurchaselines INNER JOIN tblpurchaseorders Using(PurchaseOrderID) WHERE (IsPO="T")  ');
    if not NonInventoryPart then begin
      qryTemp.SQL.Add('AND (PARTTYPE="INV" OR PARTTYPE="GRP") ');
    end;
    qryTemp.SQL.Add('AND Invoiced="F" AND ProductID=' + FastFuncs.IntToStr(ProductID) + ' AND ClassID=' + FastFuncs.IntToStr(ClassID) + ' ;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      OnOrderQty := qryTemp.FieldByName('QTY').AsFloat;
    end else begin
      OnOrderQty := 0.00;
    end;
    ////////////////////////////////////////////////////////////////////////////////////////////////////

    Result := true;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TVerifyFunctions.PartsQuantitiesVerify(const Fix: boolean);
var
  qryTemp: TMyQuery;
  qryParts: TMyCommand;
  OnHire, InStockQty, SalesOrdersQty, SalesOrderBOQty, InvoiceBOQty, OnOrderQty: double;
  OLDOnHire, OLDInStockQty, OLDSalesOrdersQty, OLDSalesOrderBOQty, OLDInvoiceBOQty, OLDOnOrderQty: double;
  PostOK: boolean;
begin
  qryTemp := TMyQuery.Create(Application.MainForm);
  qryParts := TMyCommand.Create(Application.MainForm);
  try
    qryParts.Connection          := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.Connection           := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Options.StrictUpdate := false;
    with qryTemp do begin
      SQL.Clear;
      SQL.Add('SELECT ID,ProductID,ProductName,ClassID,ClassName,InStockQty,OnHireQTY,SalesOrdersQty,SalesOrderBOQty,InvoiceBOQty, OnOrderQty, EditedFlag,msTimeStamp  FROM tblpartqtylines;');
      Active := true;

      First;
      ProgressDialog.CloseDialog;
      ProgressDialog.MaxValue := RecordCount + 1;
      ProgressDialog.Value := ProgressDialog.MinValue;
      ProgressDialog.Execute;

      AddErrorLogMessage('*************************************************************');
      AddErrorLogMessage('Product Quantities Verification Started - ' + DateTimeToStr(Now));
      AddErrorLogMessage('');

      while not Eof do begin
        PostOK := PartsQuantities(FieldByName('ProductID').AsInteger, FieldByName('ClassID').AsInteger, OnHire, InStockQty, SalesOrdersQty, SalesOrderBOQty, InvoiceBOQty, OnOrderQty);

        qryParts.SQL.Clear;
        qryParts.SQL.Add('UPDATE tblparts SET Active="T" WHERE PARTSID=' + FastFuncs.IntToStr(FieldByName('ProductID').AsInteger) + ';');

        if PostOK then begin
          //Get Old Values
          OLDInStockQty := FieldByName('InStockQty').AsFloat;
          OLDSalesOrdersQty := FieldByName('SalesOrdersQty').AsFloat;
          OLDInvoiceBOQty := FieldByName('InvoiceBOQty').AsFloat;
          OLDOnOrderQty := FieldByName('OnOrderQty').AsFloat;
          OLDOnHire := FieldByName('OnHireQTY').AsFloat;
          OLDSalesOrderBOQty := FieldByName('SalesOrderBOQty').AsFloat;

          if ((InStockQty <> 0) or (SalesOrdersQty <> 0) or (InvoiceBOQty <> 0) or (OnOrderQty <> 0) or
            (OnHire <> 0) or (SalesOrderBOQty <> 0)) then qryParts.Execute;

          //Add Right Values
          Edit;
          FieldByName('InStockQty').AsFloat := InStockQty;
          FieldByName('SalesOrdersQty').AsFloat := SalesOrdersQty;
          FieldByName('InvoiceBOQty').AsFloat := InvoiceBOQty;
          FieldByName('OnOrderQty').AsFloat := OnOrderQty;
          FieldByName('OnHireQTY').AsFloat := OnHire;
          FieldByName('SalesOrderBOQty').AsFloat := SalesOrderBOQty;
          FieldByName('msTimeStamp').AsVariant := FieldByName('msTimeStamp').AsVariant;



          if not ((OLDInStockQty = InStockQty) and (OLDSalesOrdersQty = SalesOrdersQty) and
            (OLDInvoiceBOQty = InvoiceBOQty) and (OLDOnOrderQty = OnOrderQty) and
            (OLDOnHire = OnHire) and (OLDSalesOrderBOQty = SalesOrderBOQty)) then begin
            FieldByName('EditedFlag').AsString := 'T';
            AddErrorLogMessage('Department - ' + FieldByName('ClassName').AsString +
              ' ~ Product Name - ' + FieldByName('ProductName').AsString);
            AddErrorLogMessage(#9 + 'InStock       From ' + FloatToStr(OLDInStockQty) + ' To ' + FloatToStr(InStockQty));
            AddErrorLogMessage(#9 + 'Sales Orders  From ' + FloatToStr(OLDSalesOrdersQty) +
              ' To ' + FloatToStr(SalesOrdersQty));
            AddErrorLogMessage(#9 + 'Sales Orders BO From ' + FloatToStr(OLDSalesOrderBOQty) +
              ' To ' + FloatToStr(SalesOrderBOQty));
            AddErrorLogMessage(#9 + 'Invoice BO''s  From ' + FloatToStr(OLDInvoiceBOQty) + ' To ' + FloatToStr(InvoiceBOQty));
            AddErrorLogMessage(#9 + 'On Order      From ' + FloatToStr(OLDOnOrderQty) + ' To ' + FloatToStr(OnOrderQty));
            AddErrorLogMessage(#9 + 'On Hire      From ' + FloatToStr(OLDOnHire) + ' To ' + FloatToStr(OnHire));
          end;
          try
            loglib.Log('ProductID=' + qryTemp.FieldByName('ProductID').AsString + ' /-/ ClassID=' +
              qryTemp.FieldByName('ClassID').AsString + ' - Start PartsQuantitiesVerify 1', LogLib.LogType_Debug);
            Post;
            loglib.Log('ProductID=' + qryTemp.FieldByName('ProductID').AsString + ' /-/ ClassID=' +
              qryTemp.FieldByName('ClassID').AsString + ' - End PartsQuantitiesVerify 1', LogLib.LogType_Debug);
          Except  
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
  finally
    FreeAndNil(qryTemp);
    FreeandNil(qryParts);
  end;
end;

procedure TVerifyFunctions.ProductQtysVerify(const Fix: boolean);
begin
  try
    ProgressDialog := TProgressDialog.Create(Application.MainForm);
    Screen.Cursor := crHourGlass;
    ProgressDialog.Caption := 'Please Wait .......';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := 100;
    ProgressDialog.Step := 1;
    ProgressDialog.Value := ProgressDialog.MinValue;
    Count    := 0;
    AllCount := 3;
    UpdateStatusText;

    //Start Verification
    AddErrorLogMessage('Verification Started - ' + DateTimeToStr(Now));
    AddErrorLogMessage('--------------------');
    AddErrorLogMessage('');

    PartTypeVerify(Fix);
    UpdateStatusText;
    PartsQuantitiesVerify(Fix);
    UpdateStatusText;
    PartsAvgCostVerify(Fix);
    UpdateStatusText;

    AddErrorLogMessage('');
    AddErrorLogMessage('----------------------');
    AddErrorLogMessage('Verification Completed - ' + DateTimeToStr(Now));

  finally
    Count    := 0;
    AllCount := 0;
    UpdateStatusText;
    FreeandNil(ProgressDialog);
    Screen.Cursor := crDefault;
    Application.ProcessMessages
  end;
end;

function TVerifyFunctions.SetTerms(const dtBaseDate: TDateTime; const Terms: string): TDateTime;
var
  EOM: boolean;
  EOMPlus: boolean;
begin
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    with qryExisting do begin
      SQL.Clear;

      SQL.Add('SELECT TermsID, Terms, TermsAmount, EOM, EOMPlus, Active, Description, EditedFlag  FROM tblterms ');
      SQL.Add(' Where Terms = "' + Terms + '";');

      Open;
    end;
    Result := 0;
    if qryExisting.RecordCount > 0 then begin
      EOM := qryExisting.FieldByName('EOM').AsBoolean;
      EOMPlus := qryExisting.FieldByName('EOMPlus').AsBoolean;

      if not EOM then begin // + Days
        Result := IncDay(dtBaseDate, qryExisting.FieldByName('TermsAmount').AsInteger);
      end;

      if EOM then begin
        if not EOMPlus then begin //EOM + Days
          Result := IncDay(IncHour(EndOfTheMonth(dtBaseDate), - 1), qryExisting.FieldByName('TermsAmount').AsInteger);
        end;
      end;

      if EOM then begin // EOM + EOM + Day
        if EOMPlus then begin
          Result := IncDay(IncHour(EndOfTheMonth(IncMonth(dtBaseDate, 1)), - 1), qryExisting.FieldByName('TermsAmount').AsInteger);
        end;
      end;
    end;
    qryExisting.Close;
  finally
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.POTermsVerify(const Fix: boolean);
var
  TempDate: TDateTime;
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryCorrect do begin
      SQL.Clear;

      SQL.Add('SELECT tblPurchaseOrders.PurchaseOrderID,InvoiceDate,OrderDate,Terms,DueDate,IsPO FROM tblPurchaseOrders ');
      SQL.Add('INNER JOIN tblpurchaselines Using(PurchaseOrderID);');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;

    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryCorrect.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryCorrect do begin
      First;
      while not Eof do begin
        if Fix then begin
          if (qryCorrect.FieldByName('IsPO').AsString = 'T') and not Empty(qryCorrect.FieldByName('InvoiceDate').AsString) then begin
            Edit;
            TempDate := SetTerms(FieldByName('InvoiceDate').AsDateTime, FieldByName('Terms').AsString);
            if TempDate = 0 then begin
            end else begin
              FieldByName('DueDate').AsDateTime := TempDate;
            end;
            try
              Post;
            Except  
            end;
          end else begin
            Edit;
            TempDate := SetTerms(FieldByName('OrderDate').AsDateTime, FieldByName('Terms').AsString);
            if TempDate = 0 then begin
            end else begin
              FieldByName('DueDate').AsDateTime := TempDate;
            end;
            try
              Post;
            Except  
            end;
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
  finally
    FreeAndNil(qryCorrect);
  end;
end;


procedure TVerifyFunctions.ReconciliationDepositVerify(const Fix: boolean);
var
  ReconciliationRecord: TReconciliationInfo;
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  TReconciliationFlagsObj.Instance;
  try
    qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryCorrect.Options.FlatBuffers := True;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    // Get All Reconciliation Deposit Lines
    qryCorrect.SQL.Clear;
    qryCorrect.SQL.Add('SELECT tblreconciliationdepositlines.ClientID,tblreconciliationdepositlines.DepositLineID,ReconciliationLineID, tblreconciliationdepositlines.ReconciliationID,' +
      'PaymentID,Reference, Payee, tblreconciliationdepositlines.AccountID, Amount, tblreconciliationdepositlines.Notes, Deposited, Reconciled, ');
    qryCorrect.SQL.Add('tblreconciliationdepositlines.DepositDate FROM tblreconciliationdepositlines  INNER JOIN tblreconciliation  Using(ReconciliationID) WHERE Finished = "T" AND tblreconciliation.Deleted<>"T";');
    loglib.Log(qryCorrect.SQL.Text + ' - Start 32', LogLib.LogType_Debug);
    qryCorrect.Open;
    loglib.Log('End 32', LogLib.LogType_Debug);

    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryCorrect.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;


    qryCorrect.First;
    while not qryCorrect.Eof do begin
      //Setup Record
      ReconciliationRecord.ReconciliationID := qryCorrect.FieldByName('ReconciliationID').AsInteger;
      ReconciliationRecord.ReconciliationLineID := qryCorrect.FieldByName('ReconciliationLineID').AsInteger;
      ReconciliationRecord.RecType := rtDeposits;
      ReconciliationRecord.AccountID := qryCorrect.FieldByName('AccountID').AsInteger;
      ReconciliationRecord.DepositID := qryCorrect.FieldByName('PaymentID').AsInteger;
      ReconciliationRecord.DepositLineID := qryCorrect.FieldByName('DepositLineID').AsInteger;
      ReconciliationRecord.Notes := qryCorrect.FieldByName('Notes').AsString;
      ReconciliationRecord.ClientID := qryCorrect.FieldByName('ClientID').AsInteger;
      ReconciliationRecord.Reference := qryCorrect.FieldByName('Reference').AsString;
      ReconciliationRecord.Date := qryCorrect.FieldByName('DepositDate').AsDateTime;
      ReconciliationRecord.Amount := qryCorrect.FieldByName('Amount').AsFloat;
      //Set Flag
      ReconciliationFlags.FlagReconciled(ReconciliationRecord);

      ProgressDialog.StepIt; 
      Application.ProcessMessages;
      qryCorrect.Next;
    end;

    qryCorrect.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(ReconciliationFlags);
  end;
end;

procedure TVerifyFunctions.ReconciliationWithdrawalVerify(const Fix: boolean);
var
  ReconciliationRecord: TReconciliationInfo;
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  TReconciliationFlagsObj.Instance;
  try
    qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryCorrect.Options.FlatBuffers := True;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    // Get All Reconciliation Withdrawal Lines
    qryCorrect.SQL.Clear;
    qryCorrect.SQL.Add('SELECT tblreconciliationwithdrawallines.ClientID, tblreconciliationwithdrawallines.DepositLineID,ReconciliationLineID, tblreconciliationwithdrawallines.ReconciliationID, PaymentID,Reference, Payee, ' +
      'tblreconciliationwithdrawallines.AccountID, Amount, tblreconciliationwithdrawallines.Notes, Deposited, Reconciled, ');
    qryCorrect.SQL.Add('tblreconciliationwithdrawallines.DepositDate FROM tblreconciliationwithdrawallines INNER JOIN tblreconciliation Using(ReconciliationID)  WHERE Finished = "T"  AND tblreconciliation.Deleted<>"T" ');
    qryCorrect.SQL.Add('Order By DepositDate; ');
    loglib.Log(qryCorrect.SQL.Text + ' - Start 33', LogLib.LogType_Debug);
    qryCorrect.Open;
    loglib.Log('End 33', LogLib.LogType_Debug);

    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryCorrect.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;

    qryCorrect.First;
    while not qryCorrect.Eof do begin
      //Setup Record
      ReconciliationRecord.ReconciliationID := qryCorrect.FieldByName('ReconciliationID').AsInteger;
      ReconciliationRecord.ReconciliationLineID := qryCorrect.FieldByName('ReconciliationLineID').AsInteger;
      ReconciliationRecord.RecType := rtWithdrawals;
      ReconciliationRecord.AccountID := qryCorrect.FieldByName('AccountID').AsInteger;
      ReconciliationRecord.DepositID := qryCorrect.FieldByName('PaymentID').AsInteger;
      ReconciliationRecord.DepositLineID := qryCorrect.FieldByName('DepositLineID').AsInteger;
      ReconciliationRecord.Notes := qryCorrect.FieldByName('Notes').AsString;
      ReconciliationRecord.ClientID := qryCorrect.FieldByName('ClientID').AsInteger;
      ReconciliationRecord.Reference := qryCorrect.FieldByName('Reference').AsString;
      ReconciliationRecord.Date := qryCorrect.FieldByName('DepositDate').AsDateTime;
      ReconciliationRecord.Amount := qryCorrect.FieldByName('Amount').AsFloat;
      //Set Flag
      ReconciliationFlags.FlagReconciled(ReconciliationRecord);

      ProgressDialog.StepIt; 
      Application.ProcessMessages;
      qryCorrect.Next;
    end;

    qryCorrect.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(ReconciliationFlags);
  end;
end;

procedure TVerifyFunctions.ReconciliationReset;
var
  qryTemp: TMyCommand;
begin
  qryTemp := TMyCommand.Create(Application.MainForm);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.SQL.Text := 'UPDATE tblbankdeposit SET Reconciled= "F";';
    qryTemp.Execute;

    qryTemp.SQL.Text := 'UPDATE tblbankdepositlines SET Reconciled= "F";';
    qryTemp.Execute;

  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TVerifyFunctions.TransactionAccountvsPartAccountsVerify(const Fix: boolean);
begin
  try
    ProgressDialog := TProgressDialog.Create(Application.MainForm);
    Screen.Cursor := crHourGlass;
    ProgressDialog.Caption := 'Please Wait .......';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := 100;
    ProgressDialog.Step := 1;
    ProgressDialog.Value := ProgressDialog.MinValue;
    Count    := 0;
    AllCount := 7;
    UpdateStatusText;

    //Start Verification
    AddErrorLogMessage('Transaction Account vs Product Accounts Verification Started - ' + DateTimeToStr(Now));
    AddErrorLogMessage('--------------------');
    AddErrorLogMessage('');

    SalesClassVerify(Fix);
    UpdateStatusText;
    SalesMasterAccountVerify(Fix);
    UpdateStatusText;
    SalesLinesAccountvsPartAccountsVerify(Fix);
    UpdateStatusText;

    POClassVerify(Fix);
    UpdateStatusText;
    POMasterAccountVerify(Fix);
    UpdateStatusText;
    POLinesAccountvsPartAccountsVerify(Fix);
    UpdateStatusText;

    AddErrorLogMessage('');
    AddErrorLogMessage('----------------------');
    AddErrorLogMessage('Transaction Account vs Product Accounts Verification Completed - ' + DateTimeToStr(Now));
  finally
    Count    := 0;
    AllCount := 0;
    UpdateStatusText;
    FreeandNil(ProgressDialog);
    Screen.Cursor := crDefault;
    Application.ProcessMessages
  end;
end;

procedure TVerifyFunctions.DevTestVerify(const Fix: boolean);
begin
  ProgressDialog := TProgressDialog.Create(Application.MainForm);
  try
    Screen.Cursor           := crHourGlass;
    ProgressDialog.Caption  := 'Please Wait .......';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := 100;
    ProgressDialog.Step     := 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;

    //Start Verification
    AddErrorLogMessage('Test Verification Started - ' + DateTimeToStr(Now));
    AddErrorLogMessage('--------------------');
    AddErrorLogMessage('');

    {DevTestVerify}
    if Fix then begin
      ProcessSalesBalances(Fix);
    end;

    AddErrorLogMessage('');
    AddErrorLogMessage('----------------------');
    AddErrorLogMessage('Test Verification Completed - ' + DateTimeToStr(Now));

  finally
    FreeandNil(ProgressDialog);
    Screen.Cursor := crDefault;
    Application.ProcessMessages
  end;
end;


procedure TVerifyFunctions.LaybyOutOfBalancePaymentVerify(const Fix: boolean);
var
  TempTotals: currency;

  function GetSalesPaymentsTotals(const ID: string): currency;
  begin
    with qryCorrect do begin
      {Correct SaleLines}
      SQL.Clear;

      SQL.Add('SELECT Sum(Amount) as TotalAmount FROM tblsalespayments Where SaleID = ' + ID + ' Group By SaleID;');

      Open;

      if not qryCorrect.IsEmpty then begin
        Result := qryCorrect.FieldByName('TotalAmount').asCurrency;
      end else begin
        Result := 0.00;
      end;
    end;
  end;

  procedure DeleteSalesPayments(const ID: string);
  begin
    with qryCorrect do begin
      {Correct SaleLines}
      SQL.Clear;

      SQL.Add('DELETE FROM tblsalespayments Where SaleID = ' + ID + ';');

      Execute;
    end;
  end;

  procedure ADDSalesPayments(const ID, Amount: string);
  begin
    with qryCorrect do begin
      {Correct SaleLines}
      SQL.Clear;

      SQL.Add('INSERT HIGH_PRIORITY INTO `tblsalespayments` (SaleID,PayMethod,Amount,Deleted,Deposited,EditedFlag) ');
      SQL.Add('VALUES("' + ID + '", "Layby", "' + Amount + '", "F", "F", "F");');

      Execute;
    end;
  end;
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryExisting do begin
      {Correct SaleLines}
      SQL.Clear;

      SQL.Add('SELECT GlobalRef,InvoiceDocNumber,SaleID,TotalAmountInc FROM tblsales  WHERE `IsCashSale` = "T" AND `IsLaybyTOS` = "F" AND `PayMethod` = "Layby"; ');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;

    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        TempTotals := RoundCurrency(GetSalesPaymentsTotals(qryExisting.FieldByName('SaleID').AsString));
        if (RoundCurrency(qryExisting.FieldByName('TotalAmountInc').asCurrency) <> TempTotals) then begin
          AddErrorLogMessage('');
          AddErrorLogMessage('Warning - [Cash Sale] Transaction Number - ' +
            qryExisting.FieldByName('InvoiceDocNumber').AsString + ' (' + qryExisting.FieldByName('GlobalRef').AsString +
            ') Payment Totals Don''t Match Grand Total');
          AddErrorLogMessage(CurrToStrF(qryExisting.FieldByName('TotalAmountInc').asCurrency,
            ffCurrency, 2) + ' Not equal To Payment Totals ' + CurrToStrF(FloatToCurr(TempTotals), ffCurrency, 2));
          AddErrorLogMessage('');
          if Fix then begin
            DeleteSalesPayments(qryExisting.FieldByName('SaleID').AsString);
            ADDSalesPayments(qryExisting.FieldByName('SaleID').AsString,
              FloatToStr(RoundCurrency(qryExisting.FieldByName('TotalAmountInc').asCurrency)));
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
  finally
    FreeAndNil(qryCorrect);
  end;
end;

procedure TVerifyFunctions.CashSaleOutOfBalancePaymentVerify(const Fix: boolean);
var
  TempTotals: currency;

  function GetSalesPaymentsTotals(const ID: string): currency;
  begin
    with qryCorrect do begin
      {Correct SaleLines}
      SQL.Clear;

      SQL.Add('SELECT Sum(Amount) as TotalAmount FROM tblsalespayments Where SaleID = ' + ID + ' Group By SaleID;');

      Open;

      if not qryCorrect.IsEmpty then begin
        Result := qryCorrect.FieldByName('TotalAmount').asCurrency;
      end else begin
        Result := 0.00;
      end;
    end;
  end;

  procedure ADDSalesPayments(const ID, PayMethod, Amount: string);
  begin
    with qryCorrect do begin
      {Correct SaleLines}
      SQL.Clear;

      SQL.Add('INSERT HIGH_PRIORITY INTO `tblsalespayments` (SaleID,PayMethod,Amount,Deleted,Deposited,EditedFlag) ');
      SQL.Add('VALUES("' + ID + '", "' + PayMethod + '", "' + Amount + '", "F", "F", "F");');

      Execute;
    end;
  end;
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;

  qryExisting.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryExisting do begin
      {Correct SaleLines}
      SQL.Clear;

      SQL.Add('SELECT GlobalRef,InvoiceDocNumber,PayMethod,SaleID,TotalAmountInc FROM tblsales  WHERE `IsCashSale` = "T" AND `IsLaybyTOS` <> "T" AND `IsLaybyPayment` = "F" AND `PayMethod` <> "Layby";');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;

    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        TempTotals := RoundCurrency(GetSalesPaymentsTotals(qryExisting.FieldByName('SaleID').AsString));
        if (RoundCurrency(qryExisting.FieldByName('TotalAmountInc').asCurrency) <> TempTotals) then begin
          AddErrorLogMessage('');
          AddErrorLogMessage('Warning - [Cash Sale] Transaction Number - ' +
            qryExisting.FieldByName('InvoiceDocNumber').AsString + ' (' + qryExisting.FieldByName('GlobalRef').AsString +
            ') Payment Totals Don''t Match Grand Total');
          AddErrorLogMessage(CurrToStrF(qryExisting.FieldByName('TotalAmountInc').asCurrency,
            ffCurrency, 2) + ' Not equal To Payment Totals ' + CurrToStrF(FloatToCurr(TempTotals), ffCurrency, 2));
          AddErrorLogMessage('');
          if Fix and (TempTotals = 0.00) then begin
            ADDSalesPayments(qryExisting.FieldByName('SaleID').AsString, qryExisting.FieldByName('PayMethod').AsString,
              FloatToStr(RoundCurrency(qryExisting.FieldByName('TotalAmountInc').asCurrency)));
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
  finally
    FreeAndNil(qryCorrect);
  end;
end;

procedure TVerifyFunctions.SalesTermsVerify(const Fix: boolean);
var
  TempDate: TDateTime;
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;
  try
    //Load Queries
    with qryCorrect do begin
      SQL.Clear;

      SQL.Add('SELECT SaleID, SaleDate, ShipDate, DueDate,Terms  FROM tblsales Where IsInvoice="T";');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;

    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryCorrect.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryCorrect do begin
      First;
      while not Eof do begin
        if Fix then begin
          Edit;
          if AppEnv.CompanyPrefs.UseShippedDateForTerms then begin
            TempDate := SetTerms(FieldByName('ShipDate').AsDateTime, FieldByName('Terms').AsString);
          end else begin
            TempDate := SetTerms(FieldByName('SaleDate').AsDateTime, FieldByName('Terms').AsString);
          end;
          if TempDate = 0 then begin
          end else begin
            FieldByName('DueDate').AsDateTime := TempDate;
          end;
          try
            Post;
          Except  
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
  finally
    FreeAndNil(qryCorrect);
  end;
end;

function TVerifyFunctions.GetUndepositedFundID: integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(Application.MainForm);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Options.StrictUpdate := false;
  try
    qryTemp.SQL.Add('SELECT AccountID FROM tblchartofaccounts WHERE Upper(AccountName) =' + QuotedStr(UNDEPOSITED_FUNDS) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('AccountID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;


procedure TVerifyFunctions.UnDepositedReset;
var
  qryTemp: TMyCommand;
begin
  qryTemp := TMyCommand.Create(Application.MainForm);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.SQL.Text := 'UPDATE tblbankdepositlines SET PaymentID=DepositID WHERE CompanyName = "Grouped Clients" And TrnsType = "Cash Sale";';
    qryTemp.Execute;

    qryTemp.SQL.Text := 'UPDATE tblSales SET Deposited= "F";';
    qryTemp.Execute;

    qryTemp.SQL.Text := 'UPDATE tblsalespayments SET Deposited= "F";';
    qryTemp.Execute;

    qryTemp.SQL.Text := 'UPDATE tbldeposits SET Deposited= "F";';
    qryTemp.Execute;

  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TVerifyFunctions.DepositedCustPaymentsVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;

  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryCorrect do begin
      SQL.Clear;

      SQL.Add('SELECT tblbankdepositlines.GlobalRef,tblbankdepositlines.DepositLineID,tblbankdepositlines.DepositID,tblbankdepositlines.PaymentID,tblbankdepositlines.Amount,tblbankdepositlines.TransID ');
      SQL.Add('FROM tblbankdeposit INNER JOIN tblbankdepositlines Using(DepositID) Where tblbankdeposit.Deleted="F" ');
      SQL.Add('AND tblbankdepositlines.TrnsType="Customer Payment" AND tblbankdepositlines.FromDeposited="T" AND tblbankdepositlines.AccountID=' +
        FastFuncs.IntToStr(GetUndepositedFundID) + ';');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryCorrect.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryCorrect do begin
      First;
      while not Eof do begin
        with qryExisting do begin
          SQL.Clear;
          SQL.Add('SELECT GlobalRef,PaymentID,Deposited,DepositID,Amount FROM tbldeposits WHERE Deposited<>"T" AND `PaymentID` =' +
            qryCorrect.FieldByName('PaymentID').AsString + ';');
          Open;
        end;

        if qryExisting.RecordCount > 0 then begin
          qryExisting.Edit;
          qryExisting.FieldByName('DepositID').AsInteger := qryCorrect.FieldByName('DepositID').AsInteger;
          qryExisting.FieldByName('Deposited').AsString := 'T';
          try
            qryExisting.Post;
          Except  
          end;
        end else begin
          AddErrorLogMessage('');
          AddErrorLogMessage('Warning - [Bank Deposit] Transaction Number - ' +
            qryCorrect.FieldByName('GlobalRef').AsString + ' ~ Customer Payment  - ' +
            qryCorrect.FieldByName('PaymentID').AsString + ' Already Deposited !');
          AddErrorLogMessage('');
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.DepositedCashSaleVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;

  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.StrictUpdate := false;
  qryCorrect.Options.FlatBuffers := True;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryCorrect do begin
      SQL.Clear;

      SQL.Add('SELECT tblbankdepositlines.TrnsType,tblbankdepositlines.DepositLineID,tblbankdepositlines.DepositID,tblbankdepositlines.PaymentID,tblbankdepositlines.Amount,tblbankdepositlines.TransID ');
      SQL.Add('FROM tblbankdeposit INNER JOIN tblbankdepositlines Using(DepositID) Where tblbankdeposit.Deleted="F" AND CompanyName<>"Grouped Clients"  ');
      SQL.Add('AND  (tblbankdepositlines.TrnsType="Cash Sale" OR tblbankdepositlines.TrnsType="Refund") AND tblbankdepositlines.FromDeposited="T" AND tblbankdepositlines.AccountID=' + FastFuncs.IntToStr(GetUndepositedFundID) + ';');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryCorrect.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryCorrect do begin
      First;
      while not Eof do begin
        with qryExisting do begin
          SQL.Clear;
          SQL.Add('SELECT PaymentID, Deposited,Amount,DepositID FROM `tblsalespayments` WHERE Deposited<>"T" AND `SaleID` =' +
            FastFuncs.IntToStr(qryCorrect.FieldByName('PaymentID').AsInteger) + ';');
          Open;
        end;

        if qryExisting.RecordCount > 0 then begin
          qryExisting.Edit;
          qryExisting.FieldByName('DepositID').AsInteger := qryCorrect.FieldByName('DepositID').AsInteger;
          qryExisting.FieldByName('Deposited').AsString := 'T';
          try
            qryExisting.Post;
          Except  
          end;
        end else begin
          AddErrorLogMessage('');
          AddErrorLogMessage('Warning - [Bank Deposit] Transaction Number - ' +
            FastFuncs.IntToStr(qryCorrect.FieldByName('DepositID').AsInteger) + ' ~ ' + qryCorrect.FieldByName('TrnsType').AsString +
            '  - ' + FastFuncs.IntToStr(qryCorrect.FieldByName('PaymentID').AsInteger) + ' Already Deposited !');
          AddErrorLogMessage('');
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
    //######### Group Transactions #######################################
    with qryCorrect do begin
      SQL.Clear;
      SQL.Add('SELECT tblbankdepositlines.TrnsType,tblbankdepositlines.DepositLineID,tblbankdepositlines.TransID,tblbankdepositlines.DepositID,tblbankdepositlines.PaymentID,tblbankdepositlines.Amount ');
      SQL.Add('FROM tblbankdeposit INNER JOIN tblbankdepositlines Using(DepositID) Where tblbankdeposit.Deleted="F" AND CompanyName="Grouped Clients"  ');
      SQL.Add('AND  (tblbankdepositlines.TrnsType="Cash Sale" OR tblbankdepositlines.TrnsType="Refund") AND tblbankdepositlines.FromDeposited="T" AND tblbankdepositlines.AccountID=' + FastFuncs.IntToStr(GetUndepositedFundID) + ';');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryCorrect.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryCorrect do begin
      First;
      while not Eof do begin
        with qryExisting do begin
          SQL.Clear;
          SQL.Add('SELECT PaymentID, Deposited,Amount,DepositID FROM `tblsalespayments`  WHERE Deposited<>"T" AND `DepositID` =' +
            FastFuncs.IntToStr(qryCorrect.FieldByName('DepositID').AsInteger) + ';');
          Open;
        end;

        if qryExisting.RecordCount > 0 then begin
          while not qryExisting.Eof do begin
            qryExisting.Edit;
            qryExisting.FieldByName('DepositID').AsInteger := qryCorrect.FieldByName('DepositID').AsInteger;
            qryExisting.FieldByName('Deposited').AsString := 'T';
            try
              qryExisting.Post;
            Except  
            end;
            qryExisting.Next;
          end;
        end else begin
          AddErrorLogMessage('');
          AddErrorLogMessage('Warning - [Bank Deposit] Transaction Number - ' +
            FastFuncs.IntToStr(qryCorrect.FieldByName('DepositID').AsInteger) + ' ~ Grouped ' + qryCorrect.FieldByName('TrnsType').AsString +
            '  - ' + FastFuncs.IntToStr(qryCorrect.FieldByName('PaymentID').AsInteger) + ' Already Deposited !');
          AddErrorLogMessage('');
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    //################################################
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.CustPaymentInvoiceDateVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.StrictUpdate := false;
  qryCorrect.Options.FlatBuffers := True;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryCorrect do begin
      SQL.Clear;

      SQL.Add('SELECT PaymentLineID,PaymentID,tbldepositline.InvoiceDate,SaleDate  ');
      SQL.Add('FROM tbldepositline INNER JOIN tblSales Using(Saleid) WHERE tbldepositline.InvoiceDate<>SaleDate ');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryCorrect.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryCorrect do begin
      First;
      while not Eof do begin
        with qryExisting do begin
          SQL.Clear;

          SQL.Add('SELECT PaymentLineID,PaymentID,InvoiceDate FROM tbldepositline WHERE PaymentLineID =' +
            qryCorrect.FieldByName('PaymentLineID').AsString + ';');

          Open;
        end;

        if qryExisting.RecordCount > 0 then begin
          qryExisting.Edit;
          qryExisting.FieldByName('InvoiceDate').AsDateTime := qryCorrect.FieldByName('SaleDate').AsDateTime;
          try
            qryExisting.Post;
          Except  
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.CustPaymentPaymentDateVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.StrictUpdate := false;
  qryCorrect.Options.FlatBuffers := True;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryCorrect do begin
      SQL.Clear;

      SQL.Add('SELECT PaymentLineID,D.PaymentID,DL.InvoiceDate,PaymentDate FROM tbldeposits D  ');
      SQL.Add('INNER JOIN tbldepositline DL USING(PaymentID) WHERE DL.InvoiceDate>PaymentDate ');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryCorrect.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryCorrect do begin
      First;
      while not Eof do begin
        with qryExisting do begin
          SQL.Clear;

          SQL.Add('SELECT PaymentID,PaymentDate FROM tbldeposits WHERE PaymentID =' +
            qryCorrect.FieldByName('PaymentID').AsString + ';');

          Open;
        end;

        if qryExisting.RecordCount > 0 then begin
          qryExisting.Edit;
          qryExisting.FieldByName('PaymentDate').AsDateTime := qryCorrect.FieldByName('InvoiceDate').AsDateTime;
          try
            qryExisting.Post;
          Except  
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.LaybyPaymentIDVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryCorrect do begin
      SQL.Clear;

      SQL.Add('SELECT SaleLineID,SL.laybyID, ');
      SQL.Add('CONCAT(SUBSTRING(S.GlobalRef,1,3), SUBSTRING_INDEX(SUBSTRING_INDEX(MEMO,"Layby No: ",-1), " ", 1)) as CorrectLaybyID ');
      SQL.Add('From tblsaleslines  as SL INNER JOIN tblsales as S using (SALEID) ');
      SQL.Add('Where islaybypayment = "T" AND (ProductName="Layby Payment") ');
      SQL.Add('AND (CONCAT(SUBSTRING(S.GlobalRef,1,3), SUBSTRING_INDEX(SUBSTRING_INDEX(MEMO,"Layby No: ",-1), " ", 1))<>SL.laybyID);');

      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryCorrect.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryCorrect do begin
      First;
      while not Eof do begin
        with qryExisting do begin
          SQL.Clear;

          SQL.Add('SELECT SaleLineID,laybyID From tblsaleslines WHERE SaleLineID =' +
            qryCorrect.FieldByName('SaleLineID').AsString + ';');


          Open;
        end;

        if qryExisting.RecordCount > 0 then begin
          qryExisting.Edit;
          qryExisting.FieldByName('laybyID').AsString := qryCorrect.FieldByName('CorrectLaybyID').AsString;
          try
            qryExisting.Post;
          Except  
          end;
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.LaybyBalanceVerify(const Fix: boolean);
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Options.StrictUpdate := false;

  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryCorrect do begin
      SQL.Clear;

      SQL.Add('SELECT SaleID,TotalAmountInc,Balance From tblsales WHERE IsLaybyTOS="T";');
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryCorrect.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryCorrect do begin
      First;
      while not Eof do begin
        with qryExisting do begin
          SQL.Clear;

          SQL.Add('UPDATE tblsales SET Balance= ' + FloatToStr(GetLaybyBal(qryCorrect.FieldByName('SaleID').AsInteger,
            qryCorrect.FieldByName('TotalAmountInc').AsCurrency)) + ' WHERE SaleID=' + qryCorrect.FieldByName('SaleID').AsString + ';');

          Execute;
        end;

        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

function TVerifyFunctions.GetAccountID(const AccountName: string): integer;
var
  qryTemp: TMyQuery;
begin
  Result := 0;
  qryTemp := TMyQuery.Create(Application.MainForm);
  try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Connection           := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.Options.StrictUpdate := false;
    with qryTemp do begin
      SQL.Clear;
      SQL.Add('SELECT AccountID  FROM tblchartofaccounts Where AccountName  = ' + QuotedStr(AccountName) + ';');
      Open;
      if not RecordCount <> 0 then begin
        Result := qryTemp.FieldByName('AccountID').AsInteger;
      end;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TVerifyFunctions.AccountNameVsIDVerify(const Fix: boolean);
begin
  SalesAccountNameVsIDVerify(Fix);
  POAccountNameVsIDVerify(Fix);
  GeneralJounralAccountNameVsIDVerify(Fix);
  StockAdjAccountNameVsIDVerify(Fix);
end;

procedure TVerifyFunctions.SalesAccountNameVsIDVerify(const Fix: boolean);
begin
  TempqryAccount := TMyQuery.Create(Application.MainForm);
  TempqryAccount.Connection := CommonDbLib.GetSharedMyDacConnection;
  TempqryAccount.Options.FlatBuffers := True;
  TempqryAccount.Options.StrictUpdate := false;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.StrictUpdate := false;
  qryExisting.Options.FlatBuffers := True;
  try
    ProgressDialog.CloseDialog;
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := 2;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      SQL.Clear;

      SQL.Add('SELECT SaleID,Account,AccountID FROM tblsales;');
      Open;
    end;

    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        qryExisting.Edit;
        qryExisting.FieldByName('AccountID').AsInteger := GetAccountID(qryExisting.FieldByName('Account').AsString);
        try
          qryExisting.Post;
        Except  
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    TempqryAccount.Close;
    qryExisting.Close;
  finally
    FreeAndNil(TempqryAccount);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.POAccountNameVsIDVerify(const Fix: boolean);
begin
  TempqryAccount := TMyQuery.Create(Application.MainForm);
  TempqryAccount.Connection := CommonDbLib.GetSharedMyDacConnection;
  TempqryAccount.Options.FlatBuffers := True;
  TempqryAccount.Options.StrictUpdate := false;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    ProgressDialog.CloseDialog;
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := 2;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      SQL.Clear;

      SQL.Add('SELECT PurchaseOrderID,Account,AccountID FROM tblpurchaseorders;');
      Open;
    end;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        qryExisting.Edit;
        qryExisting.FieldByName('AccountID').AsInteger := GetAccountID(qryExisting.FieldByName('Account').AsString);
        try
          qryExisting.Post;
        Except  
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    TempqryAccount.Close;
    qryExisting.Close;
  finally
    FreeAndNil(TempqryAccount);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.GeneralJounralAccountNameVsIDVerify(const Fix: boolean);
begin
  TempqryAccount := TMyQuery.Create(Application.MainForm);
  TempqryAccount.Connection := CommonDbLib.GetSharedMyDacConnection;
  TempqryAccount.Options.FlatBuffers := True;
  TempqryAccount.Options.StrictUpdate := false;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Options.StrictUpdate := false;
  try
    ProgressDialog.CloseDialog;
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := 2;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      SQL.Clear;

      SQL.Add('SELECT GJDID,AccountName,AccountID FROM tblgeneraljournaldetails;');
      Open;
    end;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        qryExisting.Edit;
        qryExisting.FieldByName('AccountID').AsInteger := GetAccountID(qryExisting.FieldByName('AccountName').AsString);
        try
          qryExisting.Post;
        Except  
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    TempqryAccount.Close;
    qryExisting.Close;
  finally
    FreeAndNil(TempqryAccount);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.StockAdjAccountNameVsIDVerify(const Fix: boolean);
begin
  TempqryAccount := TMyQuery.Create(Application.MainForm);
  TempqryAccount.Options.FlatBuffers := True;
  TempqryAccount.Connection := CommonDbLib.GetSharedMyDacConnection;

  TempqryAccount.Options.StrictUpdate := false;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;

  qryExisting.Options.StrictUpdate := false;
  try
    ProgressDialog.CloseDialog;
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := 2;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryExisting do begin
      SQL.Clear;

      SQL.Add('SELECT StockAdjustmentID,AccountName,AccountID FROM tblstockadjustment;');
      Open;
    end;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryExisting.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryExisting do begin
      First;
      while not Eof do begin
        qryExisting.Edit;
        qryExisting.FieldByName('AccountID').AsInteger := GetAccountID(qryExisting.FieldByName('AccountName').AsString);
        try
          qryExisting.Post;
        Except  
        end;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    TempqryAccount.Close;
    qryExisting.Close;
  finally
    FreeAndNil(TempqryAccount);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.RunAllVerifies(const Fix: boolean);
begin
  try
    Screen.Cursor := crHourGlass;
    AddErrorLogMessage('Verification Started - ' + DateTimeToStr(Now));
    AddErrorLogMessage('--------------------');
    AddErrorLogMessage('');
    //###-------
    TransactionAccountvsPartAccountsVerify(Fix);
    //PayEntryVerify;
    VerifyData(Fix);
    ProductQtysVerify(Fix);
    //###-------
    AddErrorLogMessage('');
    AddErrorLogMessage('----------------------');
    AddErrorLogMessage('Verification Completed - ' + DateTimeToStr(Now));
  finally
    Screen.Cursor := crDefault;
    Application.ProcessMessages
  end;
end;


//procedure TVerifyFunctions.PayEntryVerify;
//var
//  qryPays: TMyQuery;
//  savedCursor: TCursor;
//  MsDateTime: TDateTime;
//  tmpPayFunction: TPayFunctionObj;
//begin
//  savedCursor := Screen.Cursor;
//  ProgressDialog := TProgressDialog.Create(Application.MainForm);
//  ProgressDialog.Caption := 'Please Wait .......';
//  ProgressDialog.MinValue := 0;
//  ProgressDialog.MaxValue := 100;
//  ProgressDialog.Step := 1;
//  ProgressDialog.Value := ProgressDialog.MinValue;
//  qryPays := TMyQuery.Create(Application.MainForm);
//  qryPays.Options.FlatBuffers := True;
//  tmpPayFunction := TPayFunctionObj.Create;
//  try
//    Screen.Cursor      := crHourGlass;
//    qryPays.Connection := CommonDbLib.GetSharedMyDacConnection;
//    qryPays.SQL.Clear;
//    qryPays.SQL.Add('SELECT PayID FROM tblpays WHERE Paid = "T" AND Deleted = "F";');
//    qryPays.Open;
//    qryPays.IndexFieldNames := 'PayID ASC CIS';
//
//    if qryPays.RecordCount > 0 then begin
//      ProgressDialog.MaxValue := qryPays.RecordCount + 1;
//      ProgressDialog.Execute;
//      qryPays.First;
//      while not qryPays.Eof do begin
//        tmpPayFunction.VerifyPay(qryPays.FieldByName('PayID').AsInteger);
//        qryPays.Next;
//        ProgressDialog.StepIt; 
//        Application.ProcessMessages;
//      end;
//    end;
//    qryPays.IndexFieldNames := '';
//    qryPays.SQL.Clear;
//    qryPays.SQL.Add('SELECT SentStamp FROM `tblmsbackendid` WHERE BEDefault="T";');
//    qryPays.Open;
//    MsDateTime := qryPays.FieldByName('SentStamp').AsDateTime;
//    qryPays.SQL.Clear;
//    qryPays.SQL.Add('UPDATE tblpaystransactions SET msTimeStamp=:xDate;');
//    qryPays.Params.ParamByName('xDate').AsDateTime := MsDateTime;
//    qryPays.Options.StrictUpdate := false;
//    qryPays.Execute;
//  finally
//    FreeAndNil(tmpPayFunction);
//    FreeAndNil(ProgressDialog);
//    FreeAndNil(qryPays);
//    Screen.Cursor := savedCursor;
//  end;
//end;

procedure TVerifyFunctions.UpdateStatusText;
begin
  if (Count = 0) and (AllCount = 0) then begin
    Mainform.StatusBar.Panels[Mainform.StatusBar.Panels.Count - 1].Text := '';
  end else begin;
    Count := Count + 1;
    Mainform.StatusBar.Panels[Mainform.StatusBar.Panels.Count - 1].Text :=
      'Verification Pass (' + FastFuncs.IntToStr(Count) + ' of ' + FastFuncs.IntToStr(AllCount) + ')';
  end;
  Application.ProcessMessages;
end;

procedure TVerifyFunctions.PartsAvgCostVerify(const Fix: boolean);
var
  qryParts: TMyQuery;
  TransactionTableObj: TTransactionTableObj;
begin //---->Procces All Avg Costs
  qryParts := TMyQuery.Create(Application.MainForm);
  qryParts.Options.FlatBuffers := True;
  qryParts.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qryParts do begin
      SQL.Clear;
      SQL.Add('SELECT PARTSID FROM tblparts WHERE Active="T" AND PARTTYPE = "INV" OR PARTTYPE = "GRP";');
      Open;
      if RecordCount > 0 then begin
        ProgressDialog.CloseDialog;
        ProgressDialog.MinValue := 0;
        ProgressDialog.MaxValue := qryParts.RecordCount + 1;
        ProgressDialog.Value := ProgressDialog.MinValue;
        ProgressDialog.Execute;
        First;
        while not qryParts.Eof do begin
          TransactionTableObj := TTransactionTableObj.Create;
          try
            loglib.Log('PARTSID=' + qryParts.FieldByName('PARTSID').AsString + ' - Start PartsAvgCostVerify 1',
              LogLib.LogType_Debug);
            TransactionTableObj.UpdateAvgCosts(qryParts.FieldByName('PARTSID').AsInteger);
          finally
            FreeandNil(TransactionTableObj);
          end;
          ProgressDialog.StepIt; 
          Application.ProcessMessages;
          Next;
        end;
      end;
    end;
    qryParts.Close;
    qryParts.SQL.Clear;
    qryParts.SQL.Add('UPDATE tblpurchaselines SET COGSTotalLineAmount= 0, COGSTotalLineAmountInc=0 ');
    qryParts.SQL.Add('WHERE Round(TotalLineAmountInc,0)=Round(COGSTotalLineAmountInc,0) AND TotalLineAmountInc<>0.00 AND `PARTTYPE`="INV";');
    qryParts.Execute;
  finally
    FreeandNil(qryParts);
  end;
end;

procedure TVerifyFunctions.UpdateLastPOBalance(POID: integer);
var
  tblPODetails: TMyQuery;
  qryPaymentOnPO: TMyQuery;
  AmountOutstanding: currency;
  NoPayments: boolean;
begin
  tblPODetails := TMyQuery.Create(Application.MainForm);
  tblPODetails.Options.FlatBuffers := True;
  tblPODetails.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryPaymentOnPO := TMyQuery.Create(Application.MainForm);
  qryPaymentOnPO.Options.FlatBuffers := True;
  qryPaymentOnPO.Connection := CommonDbLib.GetSharedMyDacConnection;
  NoPayments := false;
  try
    {Details}
    with qryPaymentOnPO do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT PaymentLineID,tblwithdrawallines.PaymentID, POID, Payment, OriginalAmount, AmountOutstanding, AmountDue, PaidInFull ');
      SQL.Add('FROM tblwithdrawallines Inner Join tblwithdrawal Using(PaymentID) ');
      SQL.Add('Where POID = ' + FastFuncs.IntToStr(POID) + ' AND tblwithdrawal.Deleted = "F" ORDER BY tblwithdrawallines.PaymentID;;');
      Open;
    end;

    if qryPaymentOnPO.RecordCount = 0 then NoPayments := true;
    qryPaymentOnPO.Last;
    AmountOutstanding := qryPaymentOnPO.FieldByName('AmountOutstanding').asCurrency;

    with tblPODetails do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM tblpurchaseorders Where PurchaseOrderID = ' + FastFuncs.IntToStr(POID) + ';');
      Open;
    end;

    with tblPODetails do begin
      tblPODetails.Last;
      tblPODetails.Edit;

      if NoPayments then begin
        tblPODetails.FieldByName('Payment').asCurrency := 0.00;
      end else begin
        tblPODetails.FieldByName('Payment').asCurrency := tblPODetails.FieldByName('TotalAmountInc').asCurrency - AmountOutstanding;
      end;
      tblPODetails.FieldByName('Balance').asCurrency := tblPODetails.FieldByName('TotalAmountInc').asCurrency - tblPODetails.FieldByName('Payment').asCurrency;
      if (tblPODetails.FieldByName('Balance').asCurrency = 0.00) and
        (tblPODetails.FieldByName('TotalAmountInc').asCurrency <> 0.00) then begin
        tblPODetails.FieldByName('Paid').AsString := 'T';
      end else begin
        tblPODetails.FieldByName('Paid').AsString := 'F';
      end;
      if (tblPODetails.FieldByName('Balance').asCurrency = 0.00) and
        (tblPODetails.FieldByName('TotalAmountInc').asCurrency = 0.00) then begin
        tblPODetails.FieldByName('Paid').AsString := 'T';
      end;
      tblPODetails.Post;
    end;
  finally
    FreeandNil(tblPODetails);
    FreeandNil(qryPaymentOnPO);
  end;
end;

procedure TVerifyFunctions.ProcessPOBalances(const Fix: boolean);
var
  qryTemp: TMyQuery;
begin
  if not Fix then Exit;
  qryTemp := TMyQuery.Create(Application.MainForm);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.Options.FlatBuffers := True;
  with qryTemp do try
      Close;
      SQL.Clear;
      SQL.Add('SELECT tblpurchaseorders.PurchaseOrderID');
      SQL.Add('FROM tblpurchaseorders ');
      SQL.Add('INNER JOIN tblpurchaselines USING(PurchaseOrderID)');
      SQL.Add('Group By tblpurchaseorders.PurchaseOrderID;');
      Open;
      if RecordCount > 0 then begin
        ProgressDialog.CloseDialog;
        ProgressDialog.MinValue := 0;
        ProgressDialog.MaxValue := qryTemp.RecordCount + 2;
        ProgressDialog.Value := ProgressDialog.MinValue;
        ProgressDialog.Execute;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        qryTemp.First;
        while not qryTemp.Eof do begin
          UpdateLastPOBalance(qryTemp.FieldByName('PurchaseOrderID').AsInteger);
          ProgressDialog.StepIt; 
          Application.ProcessMessages;
          qryTemp.Next;
        end;
      end;
    finally
      FreeAndNil(qryTemp);
    end;
end;




procedure TVerifyFunctions.ProcessSalesBalances(const Fix: boolean);
var
  qryTemp: TMyQuery;
begin
  if not Fix then Exit;
  qryTemp := TMyQuery.Create(Application.MainForm);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryTemp.Options.FlatBuffers := True;
  with qryTemp do try
      Close;
      SQL.Clear;
      SQL.Add('SELECT tblsales.SaleID ');
      SQL.Add('FROM tblsales ');
      SQL.Add('INNER JOIN tblsaleslines USING(SaleID) ');
      SQL.Add('WHERE tblsales.IsLaybyTOS <> "T" ');
      SQL.Add('Group By tblsales.SaleID;');
      Open;
      if RecordCount > 0 then begin
        ProgressDialog.CloseDialog;
        ProgressDialog.MinValue := 0;
        ProgressDialog.MaxValue := qryTemp.RecordCount + 1;
        ProgressDialog.Value := ProgressDialog.MinValue;
        ProgressDialog.Execute;
        qryTemp.First;
        while not qryTemp.Eof do begin
          UpdateLastSaleBalance(qryTemp.FieldByName('SaleID').AsInteger);
          ProgressDialog.StepIt; 
          Application.ProcessMessages;
          qryTemp.Next;
        end;
      end;
    finally
      FreeAndNil(qryTemp);
    end;
end;

procedure TVerifyFunctions.UpdateLastSaleBalance(const SaleID: integer);
var
  tblSalesDetails: TMyQuery;
  qryPaymentOnSale: TMyQuery;
  AmountOutstanding: currency;
  NoPayments: boolean;
begin
  tblSalesDetails := TMyQuery.Create(Application.MainForm);
  tblSalesDetails.Options.StrictUpdate := false;
  tblSalesDetails.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryPaymentOnSale := TMyQuery.Create(Application.MainForm);
  qryPaymentOnSale.Options.StrictUpdate := false;
  qryPaymentOnSale.Connection := CommonDbLib.GetSharedMyDacConnection;
  NoPayments := false;
  try
    {Details}
    with qryPaymentOnSale do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT PaymentLineID,tbldepositline.PaymentID, SaleID, Payment,OriginalAmount, AmountOutstanding, AmountDue, PaidInFull ');
      SQL.Add('FROM tbldepositline Inner Join tbldeposits Using(PaymentID) ');
      SQL.Add('Where SaleID = ' + FastFuncs.IntToStr(SaleID) + ' AND tbldeposits.Deleted = "F" ORDER BY tbldepositline.PaymentID;');
      Open;
    end;

    if qryPaymentOnSale.RecordCount = 0 then NoPayments := true;
    qryPaymentOnSale.Last;
    AmountOutstanding := qryPaymentOnSale.FieldByName('AmountOutstanding').asCurrency;

    with tblSalesDetails do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM tblsales Where SaleID = ' + FastFuncs.IntToStr(SaleID) + ';');
      Open;
    end;

    with tblSalesDetails do begin
      tblSalesDetails.Last;
      tblSalesDetails.Edit;

      if NoPayments then begin
        tblSalesDetails.FieldByName('Payment').asCurrency := 0.00;
      end else begin
        tblSalesDetails.FieldByName('Payment').asCurrency := tblSalesDetails.FieldByName('TotalAmountInc').asCurrency - AmountOutstanding;
      end;
      tblSalesDetails.FieldByName('Balance').asCurrency := tblSalesDetails.FieldByName('TotalAmountInc').asCurrency - tblSalesDetails.FieldByName('Payment').asCurrency;
      if (tblSalesDetails.FieldByName('Balance').asCurrency = 0.00) and
        (tblSalesDetails.FieldByName('TotalAmountInc').asCurrency <> 0.00) then begin
        tblSalesDetails.FieldByName('Paid').AsString := 'T';
      end else begin
        tblSalesDetails.FieldByName('Paid').AsString := 'F';
      end;
      if (tblSalesDetails.FieldByName('Balance').asCurrency = 0.00) and
        (tblSalesDetails.FieldByName('TotalAmountInc').asCurrency = 0.00) then begin
        tblSalesDetails.FieldByName('Paid').AsString := 'T';
      end;
      tblSalesDetails.Post;
    end;
  finally
    FreeandNil(tblSalesDetails);
    FreeandNil(qryPaymentOnSale);
  end;
end;

procedure TVerifyFunctions.CustPrepaymentPaymentVerify(const Fix: boolean);
var
  TmpPaid: string;
begin
  ProgressDialog.CloseDialog;
  ProgressDialog.MinValue := 0;
  ProgressDialog.MaxValue := 2;
  ProgressDialog.Value := ProgressDialog.MinValue;
  ProgressDialog.Execute;
  qryCorrect := TMyQuery.Create(Application.MainForm);
  qryCorrect.Options.FlatBuffers := True;
  qryCorrect.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryCorrect.Options.StrictUpdate := false;
  qryExisting := TMyQuery.Create(Application.MainForm);
  qryExisting.Options.FlatBuffers := True;
  qryExisting.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryExisting.Options.StrictUpdate := true;
  try
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    with qryCorrect do begin
      SQL.Clear;
      SQL.Add('Select tblprepayments.PrePaymentID, tblprepayments.PayAmount as TotalPrepayAmount, Sum(If(tbldeposits.Deleted="T" OR IsNull(tbldeposits.Deleted),0.00,-tbldepositline.Payment)) as Payment, ');
      SQL.Add('tblprepayments.PayAmount - Sum(If(tbldeposits.Deleted="T" OR IsNull(tbldeposits.Deleted),0.00,-tbldepositline.Payment)) as Balance ');
      SQL.Add('FROM tblprepayments LEFT JOIN tbldepositline on tbldepositline.PrePaymentID=tblprepayments.PrePaymentID AND tbldepositline.PrePaymentID<>0 ');
      SQL.Add('LEFT JOIN tbldeposits on tbldeposits.PaymentID=tbldepositline.PaymentID WHERE tblprepayments.Customer="T" ');
      SQL.Add('Group By tblprepayments.PrePaymentID;');
      Open;
      Open;
    end;
    ProgressDialog.StepIt; 
    Application.ProcessMessages;
    //Compare Queries
    ProgressDialog.CloseDialog;
    ProgressDialog.MaxValue := qryCorrect.RecordCount + 1;
    ProgressDialog.Value    := ProgressDialog.MinValue;
    ProgressDialog.Execute;
    with qryCorrect do begin
      First;
      while not Eof do begin
        TmpPaid := 'F';
        if (qryCorrect.FieldByName('Balance').AsFloat = 0.00) then TmpPaid := 'T';
        qryExisting.SQL.Clear;
        qryExisting.SQL.Add('UPDATE tblprepayments SET Paid=:xPaid, Balance=:xBalance, ' +
          'Payment=:xPayment WHERE PrePaymentID=:xPrePaymentID ;');
        qryExisting.Params.ParamByName('xBalance').AsFloat := qryCorrect.FieldByName('Balance').AsFloat;
        qryExisting.Params.ParamByName('xPayment').AsFloat := qryCorrect.FieldByName('Payment').AsFloat;
        qryExisting.Params.ParamByName('xPaid').AsString := TmpPaid;
        qryExisting.Params.ParamByName('xPrePaymentID').AsInteger := qryCorrect.FieldByName('PrePaymentID').AsInteger;
        qryExisting.Execute;
        ProgressDialog.StepIt; 
        Application.ProcessMessages;
        Next;
      end;
    end;
    qryCorrect.Close;
    qryExisting.Close;
  finally
    FreeAndNil(qryCorrect);
    FreeAndNil(qryExisting);
  end;
end;

procedure TVerifyFunctions.VerifyChequeBankDeposits;
var
  BankDeposit: TBankDepositObj;
  tblMaster: TMyQuery;
  tblDetails: TMyQuery;
begin
  tblMaster := TMyQuery.Create(Application.MainForm);
  tblDetails := TMyQuery.Create(Application.MainForm);
  try
    tblMaster.Connection  := CommonDbLib.GetSharedMyDacConnection;
    tblDetails.Connection := CommonDbLib.GetSharedMyDacConnection;
    tblMaster.Options.FlatBuffers := True;
    tblDetails.Options.FlatBuffers := True;
    tblMaster.SQL.Text    := 'SELECT * FROM tblPurchaseOrders ' + 'INNER JOIN tblPurchaseLines ON (tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID) ' + 'WHERE tblPurchaseOrders.OrderDate And tblPurchaseOrders.IsCheque = "T" ' + 'GROUP BY tblPurchaseOrders.PurchaseOrderID ' + 'ORDER BY tblPurchaseOrders.PurchaseOrderID;';
    tblDetails.SQL.Text   := 'SELECT * FROM tblpurchaselines WHERE PurchaseOrderID=:xID';
    tblMaster.Open;
    if tblMaster.RecordCount > 0 then begin
      CommonDbLib.GetSharedMyDacConnection.ExecSQL('DELETE tblbankdepositlines FROM tblbankdepositlines ' +
        'WHERE `TrnsType` = "Cheque" OR `TrnsType` = "Cheque Deposit";', []);
      CommonDbLib.GetSharedMyDacConnection.ExecSQL('DELETE tblbankdeposit FROM tblbankdeposit LEFT JOIN tblbankdepositlines ON ' +
        'tblbankdeposit.DepositID=tblbankdepositlines.DepositID WHERE IsNull(tblbankdepositlines.DepositID);', []);
      tblMaster.First;
      while not tblMaster.Eof do begin
        tblDetails.Close;
        tblDetails.Params.ParamByName('xID').AsInteger := tblMaster.FieldByName('PurchaseOrderID').AsInteger;
        tblDetails.Open;

        BankDeposit := TBankDepositObj.Create;
        try
          BankDeposit.Connection := CommonDbLib.GetSharedMyDacConnection;
          BankDeposit.CreateBankDeposit(tblMaster.FieldByName('OrderDate').AsDateTime,
            tblMaster.FieldByName('EmployeeID').AsInteger, 0,
            tblMaster.FieldByName('AccountID').AsInteger, tblMaster.FieldByName('Comments').AsString, - (tblMaster.FieldByName('TotalAmountInc').AsCurrency), false, true);
          tblDetails.First;
          while not tblDetails.Eof do begin
            BankDeposit.CreateBankDepositLine(BankDeposit.InsertedID, tblMaster.FieldByName('PurchaseOrderID').AsInteger,
              'Cheque',
              tblMaster.FieldByName('ClientID').AsInteger, 0, 'Cheque', tblMaster.FieldByName('OrderDate').AsDateTime,
              tblMaster.FieldByName('SupplierName').AsString, tblMaster.FieldByName('InvoiceNumber').AsString, 0,
              GetAccountID(tblDetails.FieldByName('AccountName').AsString), - (tblDetails.FieldByName('TotalLineAmountInc').AsCurrency),
              '', tblDetails.FieldByName('Product_Description').AsString, false, true, false, false, true, 0);
            tblDetails.Next;
          end;
        finally
          FreeandNil(BankDeposit);
        end;
        tblMaster.Next;
      end;
    end;
  finally
    FreeAndNil(tblMaster);
    FreeAndNil(tblDetails);
  end;
end;

procedure TVerifyFunctions.SupZeroPaymentFixVerify;
var
  qryTempExec: TMyCommand;
  qryTemp: TMyQuery;
begin
  qryTempExec := TMyCommand.Create(Application.MainForm);
  qryTemp := TMyQuery.Create(Application.MainForm);
  try
    qryTemp.Options.FlatBuffers := True;
    qryTemp.Connection     := CommonDbLib.GetSharedMyDacConnection;
    qryTempExec.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('Select tblwithdrawal.PaymentID, Amount as HeaderAmount ,Sum(Payment) as LineTotal, ');
    qryTemp.SQL.Add('Round(Amount-Sum(Payment),2) as Diff ');
    qryTemp.SQL.Add('FROM tblwithdrawal ');
    qryTemp.SQL.Add('INNER JOIN tblwithdrawallines USING(PaymentID) ');
    qryTemp.SQL.Add('WHERE tblwithdrawal.Deleted="F" ');
    qryTemp.SQL.Add('Group By tblwithdrawal.PaymentID ');
    qryTemp.SQL.Add('Having Diff<>0.00; ');
    qryTemp.Open;
    if qryTemp.RecordCount > 0 then begin
      qryTemp.First;
      while not qryTemp.Eof do begin
        qryTempExec.SQL.Clear;
        qryTempExec.SQL.Add('UPDATE tblwithdrawal SET Deleted= "T",Amount=(UnApplied+Applied) WHERE PaymentID=' +
          FastFuncs.IntToStr(qryTemp.FieldByName('PaymentID').AsInteger) + ';');
        qryTempExec.Execute;
        qryTemp.Next;
      end;
    end;
  finally
    FreeAndNil(qryTemp);
    FreeAndNil(qryTempExec);
  end;
end;

procedure TVerifyFunctions.ExtraBuyPriceFix;
Var cmd : TMyCommand;
begin
  cmd := TMyCommand.Create(nil);
  try
    cmd.Connection := CommonDbLib.GetSharedMyDacConnection;
    cmd.SQL.Text := 'DELETE FROM tblextraprice WHERE PartsID = 0';
    cmd.Execute;
  finally
    FreeandNil(cmd);
  end;  
end;

procedure TVerifyFunctions.ExtraSellPriceFix;
Var cmd : TMyCommand;
begin
  cmd := TMyCommand.Create(nil);
  try
    cmd.Connection := CommonDbLib.GetSharedMyDacConnection;
    cmd.SQL.Text := 'DELETE FROM tblExtraPriceSell WHERE PartsID = 0';
    cmd.Execute;
  finally
    FreeandNil(cmd);
  end;
end;

end.



