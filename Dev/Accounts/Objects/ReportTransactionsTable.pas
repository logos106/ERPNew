unit ReportTransactionsTable;

interface

uses
  ERPdbComponents, TransactionsTable;



{TReportTransactionTableObj
        |--------TAP_Report_Obj
        |--------TAR_Report_Obj
        |--------TBalanceSheet_Report_Obj
        |--------TProfitnLoss_Report_Obj
        |--------TProfitnLossPeriod_Report_Obj
}

type
  TReportTransactionTableObj = class(TTransactionTableObj)
  Private
    fdTime:Tdatetime;
    function TempMyQuery(Connection:TERPConnection=nil): TERPQuery;
    function GetAccountID(const AccountName: String): Integer;
  Protected
    function GetTemporaryTableNameSuffix:String;
    function GetPrepaymentAccountID(const TransType: string): integer;
    function TempMyScript(Connection:TERPConnection=nil): TERPScript;
    function ChangeQuery(Query: String): String;
    Procedure ExecuteBulkSQL;
    procedure MyScriptAfterExecute(Sender: TObject; SQL: string);Virtual;
  Public
    procedure MyScriptBeforeExecute(Sender: TObject; var SQL: String; var Omit: Boolean); Override;
  end;


implementation

uses Sysutils, SyncReportTableObj,TempTableUtils, AppEnvironmentVirtual, tcConst,
  DateUtils;

function TReportTransactionTableObj.GetTemporaryTableNameSuffix: String;
begin
  TempTableUtils.GetTemporaryTableNameSuffix(AppEnvVirt.Str['Employee.LogonName']);
end;

procedure TReportTransactionTableObj.MyScriptAfterExecute(Sender: TObject; SQL: string);
begin
end;

procedure TReportTransactionTableObj.MyScriptBeforeExecute(Sender: TObject;var SQL: String; var Omit: Boolean);
begin
  inherited;
  fdTime := Now;
end;

function TReportTransactionTableObj.TempMyQuery(Connection: TERPConnection): TERPQuery;
begin
  Result := TERPQuery.Create(nil);
  if assigned(Connection) then
    Result.Connection := Connection
 else
   Result.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
end;

function TReportTransactionTableObj.TempMyScript(Connection: TERPConnection): TERPScript;
begin
  Result := TERPScript.Create(nil);
  if assigned(Connection) then Result.Connection := Connection else Result.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
end;


function TReportTransactionTableObj.ChangeQuery(Query: String): String;
var
  usingReportTables:boolean;
begin
  REsult := SyncReportObj.ChangeQuery(Query ,usingReportTables);
end;
function TReportTransactionTableObj.GetPrepaymentAccountID(const TransType: string): integer;
begin
  Result := 0;
  if (TransType = 'TfmSuppPrepayments') or (TransType = 'TfmSuppPayments') or (TransType = 'S') then begin
    Result := GetAccountID(GLACCOUNT_SUPPPREPAYMENT);
  end
  else if (TransType = 'TfmCustPrepayments') or (TransType = 'TfmCustPayments') or (TransType = 'C') then begin
    Result := GetAccountID(GLACCOUNT_CUSTPREPAYMENT);
  end;
end;

procedure TReportTransactionTableObj.ExecuteBulkSQL;
begin
  try
    if Assigned(ProgressDlg) then begin
      ProgressDlg.Caption := 'Please Wait .......';
      ProgressDlg.MinValue := 0;
      ProgressDlg.Step := 1;
    end;
    if not Assigned(qryMyScript) then qryMyScript:= TempMyScript;
    qryMyScript.BeforeExecute := MyScriptBeforeExecute;
    qryMyScript.AfterExecute  := MyScriptAfterExecute;
    qryMyScript.SQL.Clear;
    qryMyScript.SQL.Text := ChangeQuery(BulkSQL.Text);
    if Assigned(ProgressDlg) then begin
      ProgressDlg.MaxValue:= qryMyScript.Statements.Count;
      ProgressDlg.Execute;
    end;
    BulkSQL.Clear;
    qryMyScript.IgnorenContinueOnError := True;
    qryMyScript.ProcessScriptExecteError := DoProcessScriptExecteError;
    qryMyScript.Execute;
  finally
    FreeAndNil(qryMyScript);
    if Assigned(ProgressDlg) then begin
      ProgressDlg.CloseDialog;
    end;
  end;
end;

Function TReportTransactionTableObj.GetAccountID(const AccountName: String): Integer;
begin
  With tempMyquery do try
    SQL.text := 'SELECT AccountID  FROM tblChartOfAccounts WHERE AccountName =' +QuotedStr(AccountName) + ';';
    open;
    Result := FieldByname('AccountID').asInteger;
  finally
    ClosenFree;
  end;

end;

end.
