unit TrainingLib;

interface

uses   BusObjBase;

type
  TMoveModule = (mmUp=1, mmDown=2);


function HasTRainingAssigned(const employeeID:Integer = 0):Boolean;
function AllTrainingdone(const employeeID:Integer = 0):Boolean;
Procedure MoveRecEntry(direction :TMoveModule; busobj :TBusobj;Seqnofieldname:String);
(*function DayStart:TDatetime;
Function Dayend:TDatetime;*)


implementation


uses CommonDbLib, tcDataUtils, BusobjTraining, AppEnvironment, SysUtils, DateUtils, db, classes;

var
    strSQL :String;

function AllTrainingdone(const employeeID:Integer = 0):Boolean;
begin
  strSQL:= 'Select distinct EMSD.TrainingEmployeeModuleStatusDetailsID ' +
            ' from tbltrainingemployeemoduleStatus EMS ' +
            ' inner join tbltrainingmodules TM on TM.TrainingModuleID =  EMS.ModuleId and TM.active ="T" ' +
            ' inner join tblTrainingEmployeeModuleStatusDetails EMSD on ' +
            ' EMSD.trainingemployeemoduleStatusID = EMS.trainingemployeemoduleStatusID  and EMSD.done ="F"  ' +
            ' where EMS.employeeId = ' +IntToStr(EmployeeID) +
            ' limit 1';
  result := tcdatautils.FieldBynameValue(strSQL , 'TrainingEmployeeModuleStatusDetailsID' ,asinteger)=0;
end;

function HasTrainingAssigned(const employeeID:Integer = 0):Boolean;
begin
  strSQL:= 'select count(TrainingEmployeeModuleID) as ctr '+
  ' from tbltrainingemployeemodules '+
  ' where (BasicFeatures = "T" or ' +
              'MoreTraining = "T" or ' +
              'Dataimport = "T" or ' +
              'erpsetup = "T" or ' +
              'Purchase_FX = "T" or ' +
              'Employee = "T" or ' +
              'Accounts = "T" or ' +
              'Inventory_Basics = "T" or ' +
              'FileMaintenance = "T" or ' +
              'Purchase = "T" or ' +
              'CRM = "T" or ' +
              'Marketing = "T" or ' +
              'Sales = "T" or ' +
              'Pos = "T" or ' +
              'CustomerPayments = "T" or ' +
              'SupplierPayments = "T" or ' +
              'Banking = "T" or ' +
              'Reports = "T" or ' +
              'General_Templates = "T" or ' +
              'Hire = "T" or ' +
              'How_To = "T" or ' +
              'Utilities = "T" or ' +
              'Inventory_Advanced = "T" or ' +
              'Manufacturing = "T" or ' +
              'Appointments     = "T" or ' +
              'Payroll = "T" or ' +
              'FixedAssets = "T" or ' +
              'Workshop = "T" or ' +
              'budgets = "T" or ' +
              'Delivery = "T" or ' +
              'Matrix  = "T" )';
  if employeeID <> 0 then
    strSQL:= strSQL + ' and employeeId = ' +IntToStr(EmployeeID);
  result := tcdatautils.FieldBynameValue(strSQL , 'ctr' ,asinteger)>0;
end;

(*function DayStart: TDatetime;
begin
  if AppEnv.CompanyPrefs.StartOfDay = 0 then begin
    result :=EncodeTime(8, 30, 0, 0);
  end else begin
    result:= TimeOf(AppEnv.CompanyPrefs.StartOfDay);
  end;
end;

function Dayend: TDatetime;
begin
        if AppEnv.CompanyPrefs.StartOfDay = 0 then begin
          Result:= IncHour(DayStart, 9);
        end else begin
          REsult := AppEnv.CompanyPrefs.EndOfDay;
          if result <= DayStart then
            Result:= IncHour(DayStart, 9);
        end;
end;*)
Procedure MoveRecEntry(direction :TMoveModule; busobj :TBusobj;Seqnofieldname:String);
var
  bm:Tbookmark;
  s:String;
  id1, id2:Integer;
  st:TStringlist;
  ctr:Integer;
begin
  if (direction =mmUp)  and (busobj.BOF) then exit;
  if (direction =mmDown)  and (busobj.EOF) then exit;
  id1:= 0;
  busobj.Dataset.DisableControls;
  try
    bm := busobj.dataset.GetBookmark;
    try
      id1:= busobj.Id;
      if direction =mmUp then begin
        busobj.Prior;
      end else begin
        busobj.Next;
      end;
      id2:= busobj.ID;
      busobj.Connection.CommitTransaction;
      try
        try
          st:= TStringlist.create;
          try
            st.commatext := Seqnofieldname;
            s:= '';
            for ctr := 0 to st.count-1 do begin
                if direction =mmUp then begin
                  s:=s+'update ' + busobj.BusObjectTableName +' Set  ' + st[ctr] +'   =  ' + st[ctr] +'   -1 where ' +busobj.IDFieldName +' = ' +IntToStr(id1) +';'+
                    'update ' + busobj.BusObjectTableName +' Set  ' + st[ctr] +'   =  ' + st[ctr] +'   +1 where ' +busobj.IDFieldName +' = ' +IntToStr(id2) +';';

                end else begin
                  s:= s+'update ' + busobj.BusObjectTableName +' Set  ' + st[ctr] +'   =  ' + st[ctr] +'   +1 where ' +busobj.IDFieldName +' = ' +IntToStr(id1) +';'+
                      'update ' + busobj.BusObjectTableName +' Set  ' + st[ctr] +'   =  ' + st[ctr] +'   -1 where ' +busobj.IDFieldName +' = ' +IntToStr(id2) +';';
                end;
            end;
          finally
            freeandnil(st);
          end;
          busobj.GetNewDataSet(s,true);
          //busobj.Connection.CommitNestedTransaction;
          busobj.closeDb;
          busobj.OpenDB;
        except
            on E:Exception do begin
                //busobj.Connection.RollbackNestedTransaction;
            end;
        end;
      finally
          busobj.Connection.beginTransaction;
      end;
    finally
        busobj.Dataset.GotoBookmark(bm);
        busobj.Dataset.FreeBookmark(bm);
        if id1 <> 0 then busobj.Dataset.Locate(busobj.idfieldname , id1, []);
    end;
  finally
      busobj.dataset.enableControls;
  end;
end;
end.
