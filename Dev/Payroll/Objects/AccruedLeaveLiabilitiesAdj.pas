unit AccruedLeaveLiabilitiesAdj;

interface

uses
  MyAccess,ERPdbComponents, Classes;

type
  TAccruedLeaveLiabilitiesAdjObj = class(TObject)
  private
    procedure UpdateEmployeeAccruedLeaveAdj(Const EmployeeID :Integer; Const LeaveType:String);
    procedure UpdateEmployeeOpenningBalance(Const PayID :Integer; Const LeaveType :String; Const Amount: Double);
    procedure UpdatePaysTransactions(Const PayID :Integer; Const LeaveType :String; Const Amount: Double);
  public
    procedure UpdateAccruedLeaveAdj;
  end;

implementation

uses
  {CommonDbLib,} SysUtils, MySQLConst, AppEnvironmentVirtual;

{ TAccruedLeaveLiabilitiesAdjObj }

procedure TAccruedLeaveLiabilitiesAdjObj.UpdateAccruedLeaveAdj;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    qry.SQL.Clear;
    qry.SQL.Add('SELECT tblleaveaccruals.AccrualID,tblleaveaccruals.EmployeeID,tblleaveaccruals.LeaveType FROM tblleaveaccruals ');
    qry.SQL.Add('GROUP BY  tblleaveaccruals.EmployeeID,tblleaveaccruals.LeaveType;');
    qry.Open;
    if (qry.RecordCount > 0) then begin
      qry.First;
      While not qry.EOF do begin
        UpdateEmployeeAccruedLeaveAdj(qry.FieldByName('EmployeeID').AsInteger,qry.FieldByName('LeaveType').AsString);
        qry.Next;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TAccruedLeaveLiabilitiesAdjObj.UpdateEmployeeAccruedLeaveAdj(Const EmployeeID :Integer; Const LeaveType:String);
var
  qry: TERPQuery;
  LeaveLoading, OpenningHrs,UpdateAmount,TotalAmount,TotalHrs,CurrentHrsRate:Double;
  CurrentPayID:Integer;
  FirstPay :boolean;
begin
  OpenningHrs := 0;
  LeaveLoading := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);

    qry.SQL.Clear;
    qry.SQL.Add('SELECT tblleave.LeaveID,tblleave.LeaveLoading,tblleave.EmployeeID,tblleave.`Type`,tblleave.OpenningBalanceHrs,tblleave.OpenningBalanceDate ');
    qry.SQL.Add('FROM tblleave WHERE tblleave.OpenningBalanceHrs<>0 AND not IsNull(tblleave.OpenningBalanceDate) ');
    qry.SQL.Add('AND tblleave.EmployeeID='+IntToStr(EmployeeID)+ ' AND tblleave.`Type`='+QuotedStr(LeaveType)+';');
    qry.Open;
    if (qry.RecordCount > 0) then begin
      OpenningHrs := qry.FieldByName('OpenningBalanceHrs').AsFloat;
      LeaveLoading := (qry.FieldByName('LeaveLoading').AsFloat/100);
    end;

    qry.SQL.Clear;
    qry.SQL.Add('SELECT *,(tblleaveaccruals.AccruedHours*tblleaveaccruals.CurrentHourlyRate) as SetAmount FROM tblleaveaccruals ');
    qry.SQL.Add('WHERE IFNULL(tblleaveaccruals.AccruedHours,0)<>0 AND  tblleaveaccruals.EmployeeID = '+IntToStr(EmployeeID)+ ' and tblleaveaccruals.LeaveType = '+QuotedStr(LeaveType));
    qry.SQL.Add('ORDER BY tblleaveaccruals.Date ASC;');
    qry.Open;
    if (qry.RecordCount > 0) then begin
      TotalHrs := 0;
      TotalAmount := 0;
      qry.First;
      CurrentHrsRate := qry.FieldByName('CurrentHourlyRate').AsFloat;
      CurrentPayID := qry.FieldByName('PayID').AsInteger;
      FirstPay := True;
      While not qry.EOF do begin
        TotalHrs := TotalHrs + qry.FieldByName('AccruedHours').AsFloat;
        TotalAmount := TotalAmount + qry.FieldByName('SetAmount').AsFloat;
        if FirstPay then begin
          If (OpenningHrs>0) then begin
            UpdateEmployeeOpenningBalance(CurrentPayID,LeaveType,CurrentHrsRate* OpenningHrs* (1 + LeaveLoading));
            TotalHrs := TotalHrs + OpenningHrs;
            TotalAmount := TotalAmount + (CurrentHrsRate*OpenningHrs);
          end;
          FirstPay := false;
        end;
        If (CurrentPayID <> qry.FieldByName('PayID').AsInteger) then
          If (CurrentHrsRate <> (qry.FieldByName('CurrentHourlyRate').AsFloat)) then begin
            CurrentHrsRate := qry.FieldByName('CurrentHourlyRate').AsFloat;
            if CurrentHrsRate <> 0 then begin
              CurrentPayID := qry.FieldByName('PayID').AsInteger;
              UpdateAmount := (TotalHrs*CurrentHrsRate) - TotalAmount;
              TotalAmount := TotalAmount + UpdateAmount;
              UpdatePaysTransactions(CurrentPayID,LeaveType,UpdateAmount * (1 + LeaveLoading));
            end;
          end;
        qry.Next;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TAccruedLeaveLiabilitiesAdjObj.UpdateEmployeeOpenningBalance(Const PayID :Integer; Const LeaveType :String; Const Amount: Double);
var
  qry,qry2: TERPQuery;
  StrList: TStringList;
  InsertAmt:Double;
begin
  StrList := TStringList.Create;
  qry := TERPQuery.Create(nil);
  qry2 := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    qry2.Options.FlatBuffers := True;
    qry2.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    qry2.SQL.Clear;
    qry2.SQL.Add('INSERT INTO `tblpaystransactions` (Seqno, `Date`,`Type`,`ClassID`,`PayID`,`AccountName`,`AccountGroupLevels`,`AccountID`,`AccountType`,`Description`,`EmployeeName`,`EmployeeID`,`Amount`,`PayLineID`,`MSType`) VALUES ');

    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM tblpaystransactions ');
    qry.SQL.Add('WHERE tblpaystransactions.PayID = '+IntToStr(PayID));
    qry.SQL.Add('AND tblpaystransactions.Description = "'+LeaveType+' Accrued" ');
    qry.SQL.Add('AND tblpaystransactions.Type = "Payroll Accrued Leave Opening Balance";');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblpaystransactions ');
    qry.SQL.Add('WHERE tblpaystransactions.PayID = '+IntToStr(PayID));
    qry.SQL.Add('AND tblpaystransactions.Description = "'+ LeaveType+' Accrued" ');
    qry.SQL.Add('AND tblpaystransactions.Type = "Payroll Accrued Leave";');
    qry.Open;
    if (qry.RecordCount > 0) then begin
      StrList.Clear;
      qry.First;
      While not qry.EOF do begin
        if qry.FieldByName('Amount').asFloat<0 then
          InsertAmt := -Amount
        else
          InsertAmt := Amount;

        StrList.Add('(22,'+ QuotedStr(FormatDateTime(MysqlDateFormat, qry.FieldByName('Date').AsDateTime)) +','+
                      QuotedStr(qry.FieldByName('Type').AsString+' Opening Balance') +','+
                      QuotedStr(qry.FieldByName('ClassID').AsString) +','+
                      QuotedStr(qry.FieldByName('PayID').AsString) +','+
                      QuotedStr(qry.FieldByName('AccountName').AsString) +','+
                      QuotedStr(qry.FieldByName('AccountGroupLevels').AsString) +','+
                      QuotedStr(qry.FieldByName('AccountID').AsString) +','+
                      QuotedStr(qry.FieldByName('AccountType').AsString) +','+
                      QuotedStr(qry.FieldByName('Description').AsString) +','+
                      QuotedStr(qry.FieldByName('EmployeeName').AsString) +','+
                      QuotedStr(qry.FieldByName('EmployeeID').AsString) +','+
                      QuotedStr(FloattoStr(InsertAmt)) +','+
                      QuotedStr(qry.FieldByName('PayLineID').AsString) +','+
                      QuotedStr(qry.FieldByName('MSType').AsString) +')');
        qry.Next;
      end;
      StrList.Text := StringReplace(StrList.Text,')'+#$D#$A+'(','),(',[rfReplaceAll, rfIgnoreCase]);
      qry2.SQL.Add(StrList.Text);
      qry2.Execute;
    end;
  finally
    FreeAndNil(StrList);
    FreeAndNil(qry);
    FreeAndNil(qry2);
  end;
end;

procedure TAccruedLeaveLiabilitiesAdjObj.UpdatePaysTransactions(Const PayID :Integer; Const LeaveType :String; Const Amount :Double);
var
  qry,qry2: TERPQuery;
  StrList: TStringList;
  InsertAmt:Double;
begin
  StrList := TStringList.Create;
  qry := TERPQuery.Create(nil);
  qry2 := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    qry2.Options.FlatBuffers := True;
    qry2.Connection := TCustomMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    qry2.SQL.Clear;
    qry2.SQL.Add('INSERT INTO `tblpaystransactions` (Seqno , `Date`,`Type`,`ClassID`,`PayID`,`AccountName`,`AccountGroupLevels`,`AccountID`,`AccountType`,`Description`,`EmployeeName`,`EmployeeID`,`Amount`,`PayLineID`,`MSType`) VALUES ');

    qry.SQL.Clear;
    qry.SQL.Add('DELETE FROM tblpaystransactions ');
    qry.SQL.Add('WHERE tblpaystransactions.PayID = '+IntToStr(PayID));
    qry.SQL.Add('AND tblpaystransactions.Description = "'+LeaveType+' Accrued" ');
    qry.SQL.Add('AND tblpaystransactions.Type = "Payroll Accrued Leave Adjustment";');
    qry.Execute;

    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblpaystransactions ');
    qry.SQL.Add('WHERE tblpaystransactions.PayID = '+IntToStr(PayID));
    qry.SQL.Add('AND tblpaystransactions.Description = "'+ LeaveType+' Accrued" ');
    qry.SQL.Add('AND tblpaystransactions.Type = "Payroll Accrued Leave";');
    qry.Open;
    if (qry.RecordCount > 0) then begin
      StrList.Clear;
      qry.First;
      While not qry.EOF do begin
        if qry.FieldByName('Amount').asFloat<0 then
          InsertAmt := -Amount
        else
          InsertAmt := Amount;

        StrList.Add('(21, '+ QuotedStr(FormatDateTime(MysqlDateFormat, qry.FieldByName('Date').AsDateTime)) +','+
                      QuotedStr(qry.FieldByName('Type').AsString+' Adjustment') +','+
                      QuotedStr(qry.FieldByName('ClassID').AsString) +','+
                      QuotedStr(qry.FieldByName('PayID').AsString) +','+
                      QuotedStr(qry.FieldByName('AccountName').AsString) +','+
                      QuotedStr(qry.FieldByName('AccountGroupLevels').AsString) +','+
                      QuotedStr(qry.FieldByName('AccountID').AsString) +','+
                      QuotedStr(qry.FieldByName('AccountType').AsString) +','+
                      QuotedStr(qry.FieldByName('Description').AsString) +','+
                      QuotedStr(qry.FieldByName('EmployeeName').AsString) +','+
                      QuotedStr(qry.FieldByName('EmployeeID').AsString) +','+
                      QuotedStr(FloattoStr(InsertAmt)) +','+
                      QuotedStr(qry.FieldByName('PayLineID').AsString) +','+
                      QuotedStr(qry.FieldByName('MSType').AsString) +')');
        qry.Next;
      end;
      StrList.Text := StringReplace(StrList.Text,')'+#$D#$A+'(','),(',[rfReplaceAll, rfIgnoreCase]);
      qry2.SQL.Add(StrList.Text);
      qry2.Execute;
    end;
  finally
    FreeAndNil(StrList);
    FreeAndNil(qry);
    FreeAndNil(qry2);
  end;
end;

end.
