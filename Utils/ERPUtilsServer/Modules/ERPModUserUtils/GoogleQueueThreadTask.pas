unit GoogleQueueThreadTask;

interface

uses
  ServerModuleThreadTask, DBBackupObj;

type

  TGoogleQueueThreadTask = class(TServerModuleThreadTask)
  private
    procedure DoGoogleProgress(var Abort: boolean);
  protected
    procedure DoWork; override;
  public
    constructor Create; override;
  end;


implementation

uses
  ERPDbListObj, GoogleUpdateObj, GoogleCalendarConfigObj, LogMessageTypes,
  SysUtils;

{ TGoogleQueueThreadTask }

constructor TGoogleQueueThreadTask.Create;
begin
  inherited;
  RemoveWhenComplete := false;
end;

procedure TGoogleQueueThreadTask.DoGoogleProgress(var Abort: boolean);
begin
  if Terminated then
    Abort := true;
end;

procedure TGoogleQueueThreadTask.DoWork;
var
  dbList: TERPDbList;
  Google: TGoogleUpdateDbQueue;
  cfg: TGoogleCalendarConfig;
begin
  Log('Starting check for queued Google updates that need sending ...',ltDetail);
  try
    Google := TGoogleUpdateDbQueue.Create;
    dbList := TERPDbList.Create(MySQLServer);
    cfg := TGoogleCalendarConfig.Create;
    try
      Google.OnLog := Log;
      Google.OnContinueCheck := DoGoogleProgress;
      if dbList.First then begin
        repeat
          if Terminated then begin
            Log(ClassName + ' terminated, aborting Google check.',ltDetail);
            exit;
          end;
          cfg.Load(dbList.Connection);
          if cfg.LastServerId = '' then begin
            cfg.LastServerId := Params.S['ServerID'];
            cfg.Save(dbList.Connection);
          end;
          if cfg.SynchWithGoogleCalendar and (cfg.LastServerId = Params.S['ServerID']) then
            Google.ProcessDbQueue(dbList.Connection)
          else
            Log('Google Synch Queue check disabled for ' + dbList.Connection.Database,ltDetail);
        until not dbList.Next;
      end;
    finally
      dbList.Free;
      Google.Free;
      cfg.Free;
    end;
    Log('Google queued update check finished ...',ltDetail);
  except
    on e: exception do begin
      Log('Error during Google queued update check: ' + e.Message,ltDetail);
    end;
  end;
end;

end.
