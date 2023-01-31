unit ReconciliationFlagsObj;

interface

uses
  MyAccess,ERPdbComponents;

type
  TRecType = (rtDeposits, rtWithdrawals);

type
  TRecTranType     = (rttNone, rttCheque, rttChequeDeposit, rttSupplierPrepayment, rttCustomerPrepayment,
    rttSupplierPayment, rttCustomerPayment, rttBankDeposit, rttDepositEntry, rttSplitDeposit,
    rttJournalEntry);
  TRecTranTypeInfo = array[Low(TRecTranType)..High(TRecTranType)] of string;

  TRecTypeInfo = array[Low(TRecType)..High(TRecType)] of string;

type
  TReconciliationInfo = record
    ReconciliationID: integer;
    ReconciliationLineID: integer;
    RecType: TRecType;
    AccountID: integer;
    DepositID: integer;
    DepositLineID: integer;
    Notes: string;
    Payee: string;
    ClientID: integer;
    Reference: string;
    Date: TDateTime;
    Amount: double;
  end;

const
  RecTranTypeNotesDesc: TRecTranTypeInfo = ('', 'Cheque', 'Cheque Deposit', 'Supplier Prepayment', 'Customer Prepayment',
    'Supplier Payment', 'Customer Payment', 'Bank Deposit', 'Deposit Entry',
    'Split Deposit', 'Journal Entry');
  RecTypeDesc: TRecTypeInfo = ('Deposit', 'Withdrawal');

type
  TReconciliationFlagsObj = class(TObject)
  private
    fAssignedConnection: TERPConnection;
    procedure SetBankDepositReconciledFlag(const DepositID: integer; const SetFlag: boolean);
    procedure SetBankDepositLinesReconciledFlag(const DepositLineID: integer; const SetFlag: boolean);
    procedure SetAllBankDepositLinesReconciledFlag(const DepositID: integer; const SetFlag: boolean);
    function VerifyID(const ReconciliationInfo: TReconciliationInfo;
                      var VerifiedDepositID, VerifiedDepositLineID: integer;
                      const CurrentReconciledState: boolean = false;
                      UseLog: boolean = true): boolean;
    procedure UpdateDepositnwithdrawal(const DeleteFlag: boolean; ReconciliationInfo: TReconciliationInfo);

  public
    class procedure Instance(aConnection: TERPConnection = nil);
    constructor Create;
    destructor Destroy; override;
    function StringToRecTranType(const TransDesc: string): TRecTranType;
    function CheckIsReconciled(const ReconciliationInfo: TReconciliationInfo): boolean;
    function FlagReconciled(const ReconciliationInfo: TReconciliationInfo): boolean;
    procedure FlagUnReconciled(const ReconciliationInfo: TReconciliationInfo);
    property AssignedConnection: TERPConnection read fAssignedConnection write fAssignedConnection;
  end;

var
  ReconciliationFlags: TReconciliationFlagsObj;

implementation
  
uses SysUtils, CommonDBLib, tcConst, CommonLib, SystemLib;
{ TReconciliationFlagsObj }

destructor TReconciliationFlagsObj.Destroy;
begin
  if Assigned(ReconciliationFlags) then
    FreeAndNil(ReconciliationFlags);
  inherited;
end;
procedure TReconciliationFlagsObj.UpdateDepositnwithdrawal(const DeleteFlag: boolean; ReconciliationInfo: TReconciliationInfo);
var
  qry: TERPCommand;
  Function IsReconciled:String;
  begin
    result := booleantostr(DeleteFlag);
  end;
begin
  qry := TERPCommand.Create(nil);

  if Assigned(fAssignedConnection) then qry.Connection:= fAssignedConnection
  else qry.Connection := GetSharedMyDacConnection;

  try
    with qry do begin
      SQL.Clear;
      if ReconciliationInfo.RecType = rtDeposits then
            SQL.Add(' UPDATE tblDeposits SET ' +
                    ' Reconciled       = '+ quotedstr(IsReconciled)+', ' +
                    ' ReconciliationID = '+ inttostr(ReconciliationInfo.ReconciliationID) +
                    ' WHERE PaymentID  = '+inttostr(ReconciliationInfo.DepositID))
      else  SQL.Add(' UPDATE tblWithdrawal SET ' +
                    ' Reconciled       = '+ quotedstr(IsReconciled)+', ' +
                    ' ReconciliationID = '+ inttostr(ReconciliationInfo.ReconciliationID) +
                    ' WHERE PaymentID  = '+ inttostr(ReconciliationInfo.DepositID));
      Execute;
    end;
  finally
    FreeAndNil(qry);
  end;


end;
procedure TReconciliationFlagsObj.SetAllBankDepositLinesReconciledFlag(const DepositID: integer; const SetFlag: boolean);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(nil);
  if Assigned(fAssignedConnection) then
    qry.Connection:= fAssignedConnection
  else
    qry.Connection := GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('UPDATE tblbankdepositlines INNER JOIN tblchartofaccounts Using(AccountID)  SET Reconciled= ' + BooleanToSQLStr(SetFlag) +
        ' WHERE AccountType <> "BANK" AND AccountType <> "CCARD" AND DepositID=' + IntToStr(DepositID) + ';');
      Execute;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TReconciliationFlagsObj.SetBankDepositLinesReconciledFlag(const DepositLineID: integer; const SetFlag: boolean);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(nil);
  if Assigned(fAssignedConnection) then
    qry.Connection:= fAssignedConnection
  else
    qry.Connection := GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('UPDATE tblbankdepositlines SET Reconciled= ' + BooleanToSQLStr(SetFlag) +
        ' WHERE DepositLineID=' + IntToStr(DepositLineID) + ';');
      Execute;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TReconciliationFlagsObj.SetBankDepositReconciledFlag(const DepositID: integer; const SetFlag: boolean);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(nil);
  if Assigned(fAssignedConnection) then
    qry.Connection:= fAssignedConnection
  else
    qry.Connection := GetSharedMyDacConnection;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('UPDATE tblbankdeposit SET Reconciled= ' + BooleanToSQLStr(SetFlag) + ' WHERE DepositID=' +
        IntToStr(DepositID) + ';');
      Execute;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

class procedure TReconciliationFlagsObj.Instance(aConnection: TERPConnection = nil);
begin
  if not Assigned(ReconciliationFlags) then begin
    ReconciliationFlags := TReconciliationFlagsObj.Create;
    if aConnection <> nil then ReconciliationFlags.AssignedConnection := aConnection;
  end;
end;

function TReconciliationFlagsObj.StringToRecTranType(const TransDesc: string): TRecTranType;
var
  i: TRecTranType;
begin
  Result := rttNone;
  for i := Low(TRecTranType) to High(TRecTranType) do begin
    if Trim(TransDesc) = RecTranTypeNotesDesc[i] then begin
      Result := i;
      Break;
    end;
  end;
end;


procedure TReconciliationFlagsObj.FlagUnReconciled(const ReconciliationInfo: TReconciliationInfo);
var
  VerifiedDepositID, VerifiedDepositLineID: integer;
begin
  VerifiedDepositID := 0;
  VerifiedDepositLineID := 0;

  // Verify Correct ID's
  VerifyID(ReconciliationInfo, VerifiedDepositID, VerifiedDepositLineID, true);

  //Set Flag
  if VerifiedDepositID <> 0 then SetBankDepositReconciledFlag(VerifiedDepositID, false);
  if VerifiedDepositLineID <> 0 then SetBankDepositLinesReconciledFlag(VerifiedDepositLineID, false);
  if VerifiedDepositLineID = -1 then SetAllBankDepositLinesReconciledFlag(VerifiedDepositID, false);
  UpdateDepositnwithdrawal(TRue, ReconciliationInfo);
end;

function TReconciliationFlagsObj.FlagReconciled(const ReconciliationInfo: TReconciliationInfo): Boolean;
var
  VerifiedDepositID, VerifiedDepositLineID: integer;
begin
  VerifiedDepositID := 0;
  VerifiedDepositLineID := 0;

  // Verify Correct ID's
  Result:= VerifyID(ReconciliationInfo, VerifiedDepositID, VerifiedDepositLineID, False);
  if not Result then
    Exit;

  //Set Flag
  if VerifiedDepositID <> 0 then SetBankDepositReconciledFlag(VerifiedDepositID, True);
  if VerifiedDepositLineID <> 0 then SetBankDepositLinesReconciledFlag(VerifiedDepositLineID, True);
  if VerifiedDepositLineID = -1 then SetAllBankDepositLinesReconciledFlag(VerifiedDepositID, True);
  UpdateDepositnwithdrawal(False, ReconciliationInfo);
end;

function TReconciliationFlagsObj.VerifyID(const ReconciliationInfo: TReconciliationInfo;
  var VerifiedDepositID, VerifiedDepositLineID: Integer;
  const CurrentReconciledState: Boolean = False;
  UseLog: Boolean = True): boolean;
var
  qry: TERPQuery;
begin
  Result:= false;
  if ReconciliationInfo.Notes = '' then Exit;
  //Get ID's
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := GetSharedMyDacConnection;

    case StringToRecTranType(ReconciliationInfo.Notes) of
      rttNone:
      begin
        Result := true;
        VerifiedDepositID := 0;
        VerifiedDepositLineID := 0;
        Exit;
      end;
      rttCheque:
       begin
          qry.SQL.Clear;
          qry.Sql.Add('Select BDL.DepositID, BDL.DepositLineID ');
          qry.Sql.Add('FROM tblbankdeposit BD ');
          qry.Sql.Add('INNER JOIN tblbankdepositlines BDL USING(DepositID) ');
          qry.Sql.Add('Where ');
          qry.Sql.Add('BD.DepositID =  :xDepositID ');
          qry.Sql.Add('AND BD.AccountID = :xAccountID ');
          qry.Sql.Add('AND BDL.CusID = :xClientID ');
          qry.Sql.Add('AND BDL.PaymentDate = :xDate ');
          qry.Sql.Add('AND Round(ABS(BD.Deposit),'+inttostr(CurrencyRoundPlaces)+') = Round(ABS(:xAmount),'+inttostr(CurrencyRoundPlaces)+') ');
          qry.Sql.Add('AND BDL.TrnsType = :xNotes ');
          //qry.Sql.Add('AND BD.Reconciled = ' + BooleanToSQLStr(CurrentReconciledState) + ' ');
          qry.Sql.Add('AND BD.Deleted = "F";');
          qry.Params.ParamByName('xDepositID').AsInteger := ReconciliationInfo.DepositID;
          qry.Params.ParamByName('xAccountID').AsInteger := ReconciliationInfo.AccountID;
          qry.Params.ParamByName('xClientID').AsInteger  := ReconciliationInfo.ClientID;
          qry.Params.ParamByName('xNotes').AsString      := ReconciliationInfo.Notes;
          qry.Params.ParamByName('xDate').AsDate         := ReconciliationInfo.Date;
          qry.Params.ParamByName('xAmount').AsFloat      := ReconciliationInfo.Amount;
          qry.Open;
          if qry.RecordCount > 0 then begin
            result:= true;
            VerifiedDepositID := qry.FieldByName('DepositID').AsInteger;
            VerifiedDepositLineID := -1;
          end;
          qry.Close;
        end;
      rttCustomerPrepayment,
      rttSupplierPrepayment,
      rttCustomerPayment,
      rttSupplierPayment:
        begin
          qry.SQL.Clear;
          qry.Sql.Add('Select BDL.DepositID, BDL.DepositLineID ');
          qry.Sql.Add('From tblbankdeposit BD ');
          qry.Sql.Add('INNER JOIN tblbankdepositlines BDL USING(DepositID) ');
          qry.Sql.Add('Where ');
          qry.Sql.Add('BD.DepositID =  :xDepositID ');
          qry.Sql.Add('AND BD.AccountID = :xAccountID ');
          qry.Sql.Add('AND BDL.CusID = :xClientID ');
          qry.Sql.Add('AND BDL.PaymentDate = :xDate ');
          qry.Sql.Add('AND Round(ABS(BD.Deposit),'+inttostr(CurrencyRoundPlaces)+') = Round(ABS(:xAmount),'+inttostr(CurrencyRoundPlaces)+') ');
          qry.Sql.Add('AND BDL.TrnsType = :xNotes ');
          //qry.Sql.Add('AND BDL.Reconciled = ' + BooleanToSQLStr(CurrentReconciledState) + ' ');
          qry.Sql.Add('AND BD.Deleted = "F";');
          qry.Params.ParamByName('xDepositID').AsInteger := ReconciliationInfo.DepositID;
          qry.Params.ParamByName('xAccountID').AsInteger := ReconciliationInfo.AccountID;
          qry.Params.ParamByName('xClientID').AsInteger := ReconciliationInfo.ClientID;
          qry.Params.ParamByName('xNotes').AsString := ReconciliationInfo.Notes;
          qry.Params.ParamByName('xDate').AsDate := ReconciliationInfo.Date;
          qry.Params.ParamByName('xAmount').AsFloat := ReconciliationInfo.Amount;
          qry.Open;
          if qry.RecordCount > 0 then begin
            result:= true;
            VerifiedDepositID := qry.FieldByName('DepositID').AsInteger;
            VerifiedDepositLineID := qry.FieldByName('DepositLineID').AsInteger;
          end;
          qry.Close;
        end;

      rttJournalEntry:
        begin
          qry.SQL.Clear;
          qry.Sql.Add('Select BDL.DepositID, BDL.DepositLineID ');
          qry.Sql.Add('From tblbankdeposit BD ');
          qry.Sql.Add('INNER JOIN tblbankdepositlines BDL USING(DepositID) ');
          qry.Sql.Add('Where ');
          qry.Sql.Add('BD.DepositID =  :xDepositID ');
          qry.Sql.Add('AND BDL.AccountID = :xAccountID ');
          qry.Sql.Add('AND BDL.PaymentDate = :xDate ');
          qry.Sql.Add('AND Round(ABS(BDL.Amount),'+inttostr(CurrencyRoundPlaces)+') = Round(ABS(:xAmount),'+inttostr(CurrencyRoundPlaces)+') ');
          qry.Sql.Add('AND BDL.TrnsType = :xNotes ');
          //qry.Sql.Add('AND BDL.Reconciled = ' + BooleanToSQLStr(CurrentReconciledState) + ' ');
          qry.Sql.Add('AND BD.Deleted = "F";');
          qry.Params.ParamByName('xDepositID').AsInteger := ReconciliationInfo.DepositID;
          qry.Params.ParamByName('xAccountID').AsInteger := ReconciliationInfo.AccountID;
          qry.Params.ParamByName('xNotes').AsString := ReconciliationInfo.Notes;
          qry.Params.ParamByName('xDate').AsDate := ReconciliationInfo.Date;
          qry.Params.ParamByName('xAmount').AsFloat := ReconciliationInfo.Amount;
          qry.Open;
          if qry.RecordCount > 0 then begin
            result:= true;
            VerifiedDepositID := qry.FieldByName('DepositID').AsInteger;
            VerifiedDepositLineID := qry.FieldByName('DepositLineID').AsInteger;
          end;
          qry.Close;
        end;

      rttBankDeposit:
        begin
          qry.SQL.Clear;
          qry.Sql.Add('Select BDL.DepositID ');
          qry.Sql.Add('From tblbankdeposit BD ');
          qry.Sql.Add('INNER JOIN tblbankdepositlines BDL USING(DepositID) ');
          qry.Sql.Add('Where ');
          qry.Sql.Add('BD.DepositID =  :xDepositID ');
          qry.Sql.Add('AND BD.AccountID = :xAccountID ');
          qry.Sql.Add('AND BD.DepositDate = :xDate ');
          qry.Sql.Add('AND Round(ABS(BD.Deposit),' + inttostr(CurrencyRoundPlaces) + ') = Round(ABS(:xAmount),'+inttostr(CurrencyRoundPlaces)+') ');
          qry.Sql.Add('AND BDL.TrnsType<>"Deposit Entry" ');
          qry.Sql.Add('AND BDL.TrnsType<>"Cheque Deposit" ');
          qry.Sql.Add('AND BDL.TrnsType<>"'+CUSTOMER_PREPAYMENT+'" ');
          qry.Sql.Add('AND BDL.TrnsType<>"Supplier Prepayment" ');
          qry.Sql.Add('AND BDL.FromDeposited="T" ');
          //qry.Sql.Add('AND BD.Reconciled = ' + BooleanToSQLStr(CurrentReconciledState) + ' ');
          qry.Sql.Add('AND BD.Deleted = "F" ');
          qry.Sql.Add('Group By  BD.DepositID;');
          qry.Params.ParamByName('xDepositID').AsInteger := ReconciliationInfo.DepositID;
          qry.Params.ParamByName('xAccountID').AsInteger := ReconciliationInfo.AccountID;
          qry.Params.ParamByName('xDate').AsDate := ReconciliationInfo.Date;
          qry.Params.ParamByName('xAmount').AsFloat := ReconciliationInfo.Amount;
          qry.Open;
          if qry.RecordCount > 0 then begin
            result:= true;
            VerifiedDepositID := qry.FieldByName('DepositID').AsInteger;
            VerifiedDepositLineID := -1;
          end;
          qry.Close;
        end;

      rttDepositEntry:
        begin
          qry.SQL.Clear;
          qry.Sql.Add('Select BD.DepositID ');
          qry.Sql.Add('From tblbankdeposit BD ');
          qry.Sql.Add('INNER JOIN tblbankdepositlines BDL USING(DepositID) ');
          qry.Sql.Add('Where ');
          qry.Sql.Add('BD.DepositID = :xDepositID ');
          qry.Sql.Add('AND BD.AccountID = :xAccountID ');
          qry.Sql.Add('AND BD.DepositDate = :xDate ');
          qry.Sql.Add('AND Round(ABS(BD.Deposit),'+inttostr(CurrencyRoundPlaces)+') = Round(ABS(:xAmount),'+inttostr(CurrencyRoundPlaces)+') ');
          qry.Sql.Add('AND BDL.TrnsType = :xNotes ');
          //qry.Sql.Add('AND BD.Reconciled = ' + BooleanToSQLStr(CurrentReconciledState) + ' ');
          qry.Sql.Add('AND BD.Deleted = "F" ');
          qry.Sql.Add('Group By  BD.DepositID');
          qry.Params.ParamByName('xDepositID').AsInteger := ReconciliationInfo.DepositID;
          qry.Params.ParamByName('xAccountID').AsInteger := ReconciliationInfo.AccountID;
          qry.Params.ParamByName('xNotes').AsString := ReconciliationInfo.Notes;
          qry.Params.ParamByName('xDate').AsDate := ReconciliationInfo.Date;
          qry.Params.ParamByName('xAmount').AsFloat := ReconciliationInfo.Amount;
          qry.Open;
          if qry.RecordCount > 0 then begin
            result:= true;
            VerifiedDepositID := qry.FieldByName('DepositID').AsInteger;
          end;
          qry.Close;
        end;

      rttSplitDeposit:
        begin
          qry.SQL.Clear;
          qry.Sql.Add('Select BDL.DepositID, BDL.DepositLineID ');
          qry.Sql.Add('From tblbankdeposit BD ');
          qry.Sql.Add('INNER JOIN tblbankdepositlines BDL USING(DepositID) ');
          qry.Sql.Add('Where ');
          qry.Sql.Add('BD.DepositID =  :xDepositID ');
          qry.Sql.Add('AND BDL.AccountID = :xAccountID ');
          qry.Sql.Add('AND BD.DepositDate = :xDate ');
          qry.Sql.Add('AND Round(ABS(BDL.Amount),'+inttostr(CurrencyRoundPlaces)+') = Round(ABS(:xAmount),'+inttostr(CurrencyRoundPlaces)+') ');
          qry.Sql.Add('AND BDL.TrnsType = :xNotes ');
          //qry.Sql.Add('AND BDL.Reconciled = ' + BooleanToSQLStr(CurrentReconciledState) + ' ');
          qry.Sql.Add('AND BD.Deleted = "F";');
          qry.Params.ParamByName('xDepositID').AsInteger := ReconciliationInfo.DepositID;
          qry.Params.ParamByName('xAccountID').AsInteger := ReconciliationInfo.AccountID;
          qry.Params.ParamByName('xNotes').AsString := 'Deposit Entry';
          qry.Params.ParamByName('xDate').AsDate := ReconciliationInfo.Date;
          qry.Params.ParamByName('xAmount').AsFloat := ReconciliationInfo.Amount;
          qry.Open;
          if qry.RecordCount > 0 then begin
            result:= true;
            //VerifiedDepositID := qry.FieldByName('DepositID').AsInteger;
            VerifiedDepositLineID := qry.FieldByName('DepositLineID').AsInteger;
          end;
          qry.Close;
        end;

      rttChequeDeposit:
        begin
          qry.SQL.Clear;
          qry.Sql.Add('Select BDL.DepositID, BDL.DepositLineID ');
          qry.Sql.Add('From tblbankdeposit BD ');
          qry.Sql.Add('INNER JOIN tblbankdepositlines BDL USING(DepositID) ');
          qry.Sql.Add('Where ');
          qry.Sql.Add('BD.DepositID =  :xDepositID ');
          qry.Sql.Add('AND BD.AccountID = :xAccountID ');
          qry.Sql.Add('AND BDL.CusID = :xClientID ');
          qry.Sql.Add('AND BDL.PaymentDate = :xDate ');
          qry.Sql.Add('AND Round(ABS(BDL.Amount),'+inttostr(CurrencyRoundPlaces)+') = Round(ABS(:xAmount),'+inttostr(CurrencyRoundPlaces)+') ');
          qry.Sql.Add('AND BDL.TrnsType = :xNotes ');
          //qry.Sql.Add('AND BD.Reconciled = ' + BooleanToSQLStr(CurrentReconciledState) + ' ');
          qry.Sql.Add('AND BD.Deleted = "F";');
          qry.Params.ParamByName('xDepositID').AsInteger := ReconciliationInfo.DepositID;
          qry.Params.ParamByName('xAccountID').AsInteger := ReconciliationInfo.AccountID;
          qry.Params.ParamByName('xClientID').AsInteger := ReconciliationInfo.ClientID;
          qry.Params.ParamByName('xNotes').AsString := ReconciliationInfo.Notes;
          qry.Params.ParamByName('xDate').AsDate := ReconciliationInfo.Date;
          qry.Params.ParamByName('xAmount').AsFloat := ReconciliationInfo.Amount;
          qry.Open;
          if qry.RecordCount > 0 then begin
            result:= true;
            VerifiedDepositID := qry.FieldByName('DepositID').AsInteger;
          end;
          qry.Close;
        end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TReconciliationFlagsObj.CheckIsReconciled(const ReconciliationInfo: TReconciliationInfo): boolean;
var
  VerifiedDepositID, VerifiedDepositLineID: Integer;
begin
  VerifiedDepositID := 0;
  VerifiedDepositLineID := 0;
  VerifyID(ReconciliationInfo, VerifiedDepositID, VerifiedDepositLineID, true, false);
  Result := ((VerifiedDepositID = 0) and (VerifiedDepositLineID = 0));
end;

constructor TReconciliationFlagsObj.Create;
begin
  fAssignedConnection:= nil;
end;



end.
