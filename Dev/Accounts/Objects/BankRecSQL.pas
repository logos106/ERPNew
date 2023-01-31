unit BankRecSQL;

interface

uses
  classes, ReportBaseObj, Types, ErpDBComponents, ReportSQLBalanceSheet,
    UserLockObj;

type

  TToBeReconciled = class(TReportWithDateRangeBase)
  private
    fiAccountId           : Integer;
  Protected
  Public
    constructor Create; override;
    destructor Destroy; override;
  Published
    Property AccountId            : Integer read fiAccountId            write fiAccountId;
  end;

  TToBeReconciledDeposit = Class(TToBeReconciled)
  private
  Protected
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  Public
  End;

  TToBeReconciledWithDrawal = Class(TToBeReconciled)
  private
  Protected
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  Public
  End;


implementation

uses tcConst, RecLib, SysUtils, ClipBrd, LogLib;

{ TToBeReconciled }

constructor TToBeReconciled.Create;
begin
  inherited;
end;

destructor TToBeReconciled.Destroy;
begin
  inherited;
end;


{ TToBeReconciledWithDrawal }
function TToBeReconciledWithDrawal.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  SQL.Text := ToBeReconciledWithdrawalSQL(AccountId, DateTo, True, True, True, 0);
  LogText(SQL.Text);

//   ClipBoard.AsText := SQL.Text;

  if not(Search = '') then
    SQL.Text := 'SELECT * FROM (' + SQL.Text + ') AS ReconcWithdrawal WHERE ' + Search;

  if not(OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy);

  Result := true;
end;


{ TToBeReconciledDeposit }
function TToBeReconciledDeposit.PopulateReportSQL(SQL: TStrings; var msg: string): Boolean;
begin
  SQL.Text := ToBeReconciledDepositsSQL(AccountId, DateTo, True, True, True, 0);

  if not(Search = '') then
    SQL.Text := 'SELECT * FROM (' + SQL.Text + ') AS ReconcDeposit WHERE ' + Search;

  LogText(SQL.Text);
  if not(OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy);

  Result := True;
end;



initialization

  RegisterClass(TToBeReconciledDeposit);
  RegisterClass(TToBeReconciledWithDrawal);

end.
