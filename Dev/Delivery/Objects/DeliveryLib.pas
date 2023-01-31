unit DeliveryLib;

// Library of general functions associated with Delivery (eg Runs).


  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 24/03/05  1.00.00 IJB  Initial version.

interface

type
  PRunInfo = ^TRunInfo;
  TRunInfo = record
    RunID: integer;
    RunName: string;
    OperatorID: integer;
    Operator: string;
    Date: TDatetime;
    ClassID: integer;
  end;

  // returns the OPerator (EmployeeId) for the specified run
function GetOperatorForRun(const RunId: integer): integer;

implementation

uses
  MyAccess, CommonDbLib, SysUtils, FastFuncs;

// returns the OPerator (EmployeeId) for the specified run  
function GetOperatorForRun(const RunId: integer): integer;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    Result         := 0;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text   := 'SELECT OperatorId FROM tblruns WHERE RunId = ' + FastFuncs.IntToStr(RunId);
    qry.Open;
    if not qry.IsEmpty then Result := qry.FieldByName('OperatorId').AsInteger;
    qry.Close;  
  finally
    FreeAndNil(qry);
  end;
end;

end.
