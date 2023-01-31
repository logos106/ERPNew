unit ScheduledreportObj;

interface

uses ERPdbComponents, classes , LogThreadBase, LogMessageTypes, ReportSQLBase;

Type
  TScheduledreportObj = class(Tcomponent)
    Private
      fsDbServerName:String;
      fOnLog: LogThreadBase.TOnLogEvent;
      procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
      function getReportSQLObj(const formname:String) :TReportSQLBase;
    Protected
    Public
      Logger: TLoggerBase;
      Procedure EmailAllScheduledReports(const Conn :TERPConnection; const OnAfterEmailEvent:TNotifyEvent=nil);
      Property DbServerName :String read fsDbServerName write fsDbServerName;
      property OnLog: LogThreadBase.TOnLogEvent read fOnLog write fOnLog;
  end;

implementation

uses AppEnvironmentVirtual, BusObjectListObj, sysutils;

{ TScheduledreportObj }

procedure TScheduledreportObj.EmailAllScheduledReports(const Conn :TERPConnection; const OnAfterEmailEvent:TNotifyEvent=nil);
var
  Qry:TERPquery;
  ReportSQLObj :TReportSQLBase;
begin
   TAppEnvVirtualGUI(AppEnvVirt).SharedDbConnection := conn;

   Qry := TERPquery(AppEnvVirt.Obj['CommonDbLib.TempMyQuery']);
   try
     Qry.SQL.add('Select F.formId, F.FormName , SR.EmployeeId, SR.Employeename ' +
                ' from tblscheduledreports SR  ' +
                ' inner join tblforms F on SR.FormID = F.FormID  ' +
                ' where SR.active ="T"  ' +
                ' and NextDueDate <= CURDATE()  ' +
                ' and (ContinueIndefinitely ="T" or NextDueDate <enddate)');
     Qry.open;
     if Qry.recordcount =0 then exit;
     Qry.first;
     while Qry.Eof = False do begin
       ReportSQLObj := getReportSQLObj(Qry.FieldByName('FormName').AsString );
       if ReportSQLObj <> nil then begin
            Log(' Scheduled Reports : ' + Qry.Connection.Database+ ' ->Sending Balance Sheet to ' +Quotedstr(qry.FieldByName('Employeename').AsString),ltDetail);
            ReportSQLObj.EmployeeId :=  Qry.FieldByName('EmployeeID').AsInteger;
            ReportSQLObj.EmailReport;
            if assigned(OnAfterEmailEvent) then OnAfterEmailEvent(Self);
       end;
       Qry.Next;
     end;
   finally
     Qry.ClosenFree;
   end;
end;

function TScheduledreportObj.getReportSQLObj(const formname: String): TReportSQLBase;
var
  Cls: TReportSQLBaseClass;
  ObjectInfo :TBusObjectInfo;
begin
  result:= nil;
  ObjectInfo := BusObjectListObj.TScheduledReportObjInfoList.Inst.ItemByBusObjClassName[formname ] ;
  if ObjectInfo <> nil then begin
    try
      Cls := TReportSQLBaseClass(FindClass(ObjectInfo.BusObjClassName ));
      if (cls<> nil)  then
        Result := Cls.Create(Self);
    except
      on E:Exception do begin
        Result := nil;
      end;
    end;
  end;
end;

procedure TScheduledreportObj.Log(const msg: string; const LogMessageType: TLogMessageType);
begin
  if Assigned(Logger) then
    Logger.Log(msg,LogMessageType);
  if Assigned(fOnLog) then
    fOnLog(msg, LogMessageType);
end;

end.

