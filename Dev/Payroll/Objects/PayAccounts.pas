unit PayAccounts;

interface

function WageAccountID(const EmployeeId: integer = 0): integer;
function BankAccountID(const EmployeeId: integer = 0): integer; {same account}

function WagesPaidAccountID(const EmployeeId: integer = 0): integer;
function GrossWagesAccountID(const EmployeeId: integer = 0): integer; {same account}

function DeductionsPaidAccountID(const EmployeeId: integer = 0): integer;
function DeductionsPaidAccountIDList: string;

function LeaveProvisionAccountID(const EmployeeId: integer = 0): integer;
function LeaveProvisionAccountIdList: string;

function NetWagesAccountID(const EmployeeId: integer = 0): integer;
function NetWagesAccountIdList: string;

function AllowancePaidAccountID(const EmployeeId: integer = 0): integer;
function AllowancePaidAccountIDList: string;

function SuperPaidAccountID(const EmployeeId: integer = 0): integer;
function SuperPaidAccountIDList: string;

(*function PAYGExpenseAccountID(const EmployeeId: integer = 0): integer;
function PAYGExpenseAccountIdList: string;*)

function SundriesPaidAccountID(const EmployeeId: integer = 0): integer;
function SundriesPaidAccountIDList: string;

function CommissionPaidAccountID(const EmployeeId: integer = 0): integer;

function DeductionLiabilityAccountID(const EmployeeId: integer = 0): integer;

function SuperPayableAccountID(const EmployeeId: integer = 0): integer;

function AllowanceLiabilityAccountID(const EmployeeId: integer = 0): integer;

function LeaveLiabilityAccountID(const EmployeeId: integer = 0): integer;

function PAYGTaxPayableAccountID(const EmployeeId: integer = 0): integer;

function LumpSumDPaidAccountID(const EmployeeId: integer = 0): integer;

implementation

uses
  AppEnvironment, DbSharedObjectsObj, ERPDBComponents, CommonDbLib, SysUtils;

function GetAccount(const aName: string; aEmployeeId: integer): integer;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'select ' + aName + ' from tblpersonalpreferences where EmployeeID = ' + IntToStr(aEmployeeId);
    qry.Open;
    result := qry.FieldByName(aName).AsInteger;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function GetAccountIdList(const aName: string): string;
var
  qry: TERPQuery;
begin
  result := '';
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'select ' + aName + ' from tblpersonalpreferences where IfNull(' + aName + ',0) <> 0';
    qry.Open;
    while not qry.Eof do begin
      if qry.RecNo > 1 then
        result := result + ',';
      result := result + qry.FieldByName(aName).AsString;
      qry.Next;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function WageAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('WageAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.BankAccountID;
end;

function BankAccountID(const EmployeeId: integer = 0): integer;
begin
  result := WageAccountID(EmployeeId);
end;

function WagesPaidAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('WagesPaidAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.GrossWagesAccountID;
end;

function GrossWagesAccountID(const EmployeeId: integer = 0): integer;
begin
  result := WagesPaidAccountID(EmployeeId);
end;

function DeductionsPaidAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('DeductionsPaidAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.DeductionsPaidAccountID;
end;

function LeaveProvisionAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('LeaveProvisionAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.LeaveProvisionAccountID;
end;

function NetWagesAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('NetWagesAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.NetWagesAccountID;
end;

function AllowancePaidAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('AllowancePaidAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.AllowancePaidAccountID;
end;

function SuperPaidAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('SuperPaidAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.SuperPaidAccountID;
end;

(*function PAYGExpenseAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('PAYGExpenseAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.PAYGExpenseAccountID;
end;*)

function SundriesPaidAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('SundriesPaidAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.SundriesPaidAccountID;
end;

function CommissionPaidAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('CommissionPaidAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.CommissionPaidAccountID;
end;

function DeductionLiabilityAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('DeductionLiabilityAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.DeductionLiabilityAccountID;
end;

function SuperPayableAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('SuperPayableAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.SuperPayableAccountID;
end;

function AllowanceLiabilityAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('AllowanceLiabilityAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.AllowanceLiabilityAccountID;
end;

function LeaveLiabilityAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('LeaveLiabilityAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.LeaveLiabilityAccountID;
end;

function PAYGTaxPayableAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('PAYGTaxPayableAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.PAYGTaxPayableAccountID;
end;

function LumpSumDPaidAccountID(const EmployeeId: integer = 0): integer;
begin
  result := 0;
  if EmployeeID > 0 then
    result := GetAccount('LumpSumDPaidAccountID', EmployeeId);
  if result = 0 then
    result := AppEnv.PayPrefs.LumpSumDPaidAccountID;
end;

function NetWagesAccountIdList: string;
var
  s: string;
begin
  result := IntToStr(AppEnv.PayPrefs.NetWagesAccountID);
  s := GetAccountIdList('NetWagesAccountID');
  if s <> '' then
    result := result + ',' + s;
end;

(*function PAYGExpenseAccountIdList: string;
var
  s: string;
begin
  result := IntToStr(AppEnv.PayPrefs.PAYGExpenseAccountId);
  s := GetAccountIdList('PAYGExpenseAccountId');
  if s <> '' then
    result := result + ',' + s;
end;*)

function LeaveProvisionAccountIdList: string;
var
  s: string;
begin
  result := IntToStr(AppEnv.PayPrefs.LeaveProvisionAccountID);
  s := GetAccountIdList('LeaveProvisionAccountID');
  if s <> '' then
    result := result + ',' + s;
end;

function SuperPaidAccountIDList: string;
var
  s: string;
begin
  result := IntToStr(AppEnv.PayPrefs.SuperPaidAccountID);
  s := GetAccountIdList('SuperPaidAccountID');
  if s <> '' then
    result := result + ',' + s;
end;

function DeductionsPaidAccountIDList: string;
var
  s: string;
begin
  result := IntToStr(AppEnv.PayPrefs.DeductionsPaidAccountID);
  s := GetAccountIdList('DeductionsPaidAccountID');
  if s <> '' then
    result := result + ',' + s;
end;

function SundriesPaidAccountIDList: string;
var
  s: string;
begin
  result := IntToStr(AppEnv.PayPrefs.SundriesPaidAccountID);
  s := GetAccountIdList('SundriesPaidAccountID');
  if s <> '' then
    result := result + ',' + s;
end;

function AllowancePaidAccountIDList: string;
var
  s: string;
begin
  result := IntToStr(AppEnv.PayPrefs.AllowancePaidAccountID);
  s := GetAccountIdList('AllowancePaidAccountID');
  if s <> '' then
    result := result + ',' + s;
end;


end.
