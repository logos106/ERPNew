unit GoLiveUtils;

interface

uses
  DbSharedObjectsObj, ERPDbComponents;



  procedure CreateDefaultGoLiveRecords;
  function GoLiveRecordCount: integer;

implementation

uses
  CommonDbLib, SysUtils, DB;

procedure CreateDefaultGoLiveRecords;
var
  qryModules: TERPQuery;
  qryDates: TERPQuery;
  qryGoLive: TERPQuery;
  qryGoLiveModule: TERPQuery;
  qryEmployees: TERPQuery;
  qryTraining: TERPQuery;
  qry: TERPQuery;
  fNextDate: TDateTime;
  fCount: integer;

  function NextDate: TDateTime;
  begin
    if fNextDate = 0 then begin
      if not qryDates.EOF then
        fNextDate := qryDates.FieldByName('TrainingDate').AsDateTime
      else
        fNextDate := Date;
    end
    else begin
      if fCount > 2 then begin
        fCount := 1;
        if not qryDates.EOF then begin
          qryDates.Next;
          fNextDate := qryDates.FieldByName('TrainingDate').AsDateTime;
        end
        else
          fNextDate := fNextDate + 1;
      end
      else begin
        if not qryDates.EOF then begin
          fNextDate := qryDates.FieldByName('TrainingDate').AsDateTime;
        end
      end;
    end;
    inc(fCount);
    result := fNextDate;
  end;

begin
  fNextDate := 0;
  fCount := 1;
  qryModules := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  qryDates := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  qryGoLive := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  qryGoLiveModule := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  qryEmployees := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  qryTraining := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qryModules.SQL.Text := 'select * from tbltrainingmodules where SeqNo < 20 order by SeqNo';
    qryDates.SQL.Text := 'select * from tbltrainingdays where not IsNull(TrainingDate) order by TrainingDate';
    qryGoLive.SQL.Text := 'select * from tblgolive';
    qryGoLiveModule.SQL.Text := 'select * from tblgolivemodules';
    qryTraining.SQL.Text := 'select * from tbltraining';
    qryModules.Open;
    qryDates.Open;
    qryGoLive.Open;
    qryGoLiveModule.Open;
    qryTraining.Open;
    qryEmployees.SQL.Text := 'select * from tbltrainingemployeemodules';
    qryEmployees.Open;
    if qryEmployees.IsEmpty then begin
      { use all active employees }
      qryEmployees.close;
      qry.SQL.Text := 'select * from tbltrainingmodules where SeqNo < 20 order by SeqNo';
      qry.Open;
      qryEmployees.SQL.Text := 'select EmployeeID ';//from tblemployees where Active = "T"';
      while not qry.EOF do begin
        qryEmployees.SQL.Add(',"T" as ' + qry.FieldByName('TEMFieldname').AsString);
        qry.Next;
      end;
      qryEmployees.SQL.Add('from tblemployees where Active = "T"');
      qry.Close;
      qryEmployees.Open;
    end;
    while not qryModules.EOF do begin
      { only add records if at least one employee has traing assigned of it .. }
      if qryEmployees.Locate(qryModules.FieldByName('TEMFieldname').AsString,'T',[loCaseInsensitive]) then begin
        qryGoLive.Append;
        qryGoLive.FieldByName('ModuleId').AsInteger := qryModules.FieldByName('TrainingModuleId').AsInteger;
        qryGoLive.FieldByName('Days').AsInteger := 1;
        qryGoLive.FieldByName('StepNo').AsInteger := qryModules.FieldByName('SeqNo').AsInteger;
        qryGoLive.FieldByName('OrderNo').AsInteger := qryModules.FieldByName('SeqNo').AsInteger;
        qryGoLive.FieldByName('Done').AsInteger := 0;
        qryGoLive.FieldByName('StepType').AsInteger := 0;
        qryGoLive.FieldByName('Height').AsInteger := 71;
        qryGoLive.FieldByName('EditHeight').AsInteger := 97;
        qryGoLive.FieldByName('RequiredBy').AsDateTime := NextDate;
        qryGoLive.FieldByName('RequiredTime').AsDateTime := Frac(qryTraining.FieldByName('StartOfTheDay').AsDateTime);
        qryGoLive.Post;
        qryEmployees.First;
        while not qryEmployees.Eof do begin
          if qryEmployees.FieldByName(qryModules.FieldByName('TEMFieldname').AsString).ASBoolean then begin
            qryGoLiveModule.Append;
            qryGoLiveModule.FieldByName('GoLiveId').AsInteger := qryGoLive.FieldByName('GoLiveId').AsInteger;
            qryGoLiveModule.FieldByName('EmployeeId').AsInteger := qryEmployees.FieldByName('EmployeeID').AsInteger;
            qryGoLiveModule.Post;
          end;
          qryEmployees.Next;
        end;
        end;
      qryModules.Next;
    end;
  finally
    DbSharedObj.ReleaseObj(qryModules);
    DbSharedObj.ReleaseObj(qryDates);
    DbSharedObj.ReleaseObj(qryGoLive);
    DbSharedObj.ReleaseObj(qryGoLiveModule);
    DbSharedObj.ReleaseObj(qryEmployees);
    DbSharedObj.ReleaseObj(qryTraining);
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function GoLiveRecordCount: integer;
var
  qryGoLive: TERPQuery;
begin
  qryGoLive := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qryGoLive.SQL.Text := 'select count(*) from tblgolive';
    qryGoLive.Open;
    result := qryGoLive.Fields[0].AsInteger;
  finally
    DbSharedObj.ReleaseObj(qryGoLive);
  end;
end;


end.
