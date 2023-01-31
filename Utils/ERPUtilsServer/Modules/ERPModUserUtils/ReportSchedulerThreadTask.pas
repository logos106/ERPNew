unit ReportSchedulerThreadTask;

interface

uses
  ServerModuleThreadTask, DBBackupObj, JsonRpcTcpClient;

type

  TReportSchedulerThreadTask = class(TServerModuleThreadTask)
  private
  protected
    procedure DoWork; override;
  end;

implementation

uses
  ERPDbListObj, LogMessageTypes, SysUtils, ScheduledreportObj, ActiveX;

{ TReportSchedulerThreadTask }

procedure TReportSchedulerThreadTask.DoWork;
var
  dbList: TERPDbList;
  sched: TScheduledreportObj;
begin
  TRy
    Log('Starting Scheduled Reports check ...',ltDetail);
    dbList := TERPDbList.Create(MySQLServer);
    try
     if dbList.First then begin
         repeat
           if Terminated then begin
             Log(ClassName + ' terminated, aborting Scheduled Reports check.',ltDetail);
             exit;
           end;
            Log(' Scheduled Reports  : Checking in database ' + dbList.Connection.Database,ltDetail);
            sched := TScheduledreportObj.Create(nil);
            CoInitialize(nil);
            try
              sched.OnLog := Log;
              sched.EmailAllScheduledReports(dblist.Connection);
              Log(' Scheduled Reports : Done database ' + dbList.Connection.Database,ltDetail);
            finally
              sched.Free;
              CoUninitialize();
            end;
         until not dbList.Next;
     end;
    finally
      dbList.Free;
      Log('Finished Scheduled Reports check.',ltDetail);
    end;
  except
    on e: exception do begin
      Log('Error checking Scheduled Reports: ' + e.Message,ltError);
    end;
  end;
end;

end.
