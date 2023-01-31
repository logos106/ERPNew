unit GoogleCalendarThreadTask;

interface

uses
  ServerModuleThreadTask, DBBackupObj;

type

  TGoogleCalendarThreadTask = class(TServerModuleThreadTask)
  private
    procedure DoGoogleProgress(var Abort: boolean);
  protected
    procedure DoWork; override;
  public
    constructor Create; override;
  end;

implementation

uses
  SysUtils, ERPDbListObj, LogMessageTypes,
  GoogleSynchObj, GoogleCalendarConfigObj;

{ TGoogleCalendarThreadTask }

constructor TGoogleCalendarThreadTask.Create;
begin
  inherited;
  self.RemoveWhenComplete := false;
end;

procedure TGoogleCalendarThreadTask.DoGoogleProgress(var Abort: boolean);
begin
  if Terminated then
    Abort := true;
end;

procedure TGoogleCalendarThreadTask.DoWork;
var
  dbList: TERPDbList;
  Google: TGoogleSynch;
//  startTime: TDateTime;
  AllOk: boolean;
  cfg: TGoogleCalendarConfig;
  SynchType: TGoogleSynchType;
begin
  AllOk := true;
  try
    SynchType := TGoogleSynchType(Params.I['SynchType']);
    case SynchType of
      gsCalendar: Log('Starting Google Calendar check ...',ltDetail);
      gsERPCalandar: Log('Starting Google ERP Calendar check ...',ltDetail);
      gsTask: Log('Starting Google Task check ...',ltDetail);
      gsAll: Log('Starting Google Calendar and Task check ...',ltDetail);
    end;

//    startTime := Now;
    dbList := TERPDbList.Create(MySQLServer);
    Google := TGoogleSynch.Create;
    cfg := TGoogleCalendarConfig.Create;
    try
      Google.OnLog := self.Log;
      Google.OnProgress := DoGoogleProgress;
      Google.LastSynchTime := now - 7; //LastGoogleCheckTime;
      if dbList.First then begin
        repeat
          if Terminated then begin
            Log(ClassName + ' terminated, aborting Google check.',ltDetail);
            exit;
          end;

          cfg.Load(dbList.Connection);
          if cfg.LastServerId = '' then begin
            cfg.LastServerId := Params.S['ServerId'];
            cfg.Save(dbList.Connection);
          end;
          if cfg.SynchWithGoogleCalendar and (cfg.LastServerId = Params.S['ServerId']) then begin
            Log('Google Synch starting for ' + dbList.Connection.Database,ltDetail);
            Google.Connection := dbList.Connection;
            if not Google.DoSynch(SynchType) then
              AllOk := false;
          end
          else
            Log('Google Synch disabled for ' + dbList.Connection.Database,ltDetail);
        until not dbList.Next;
      end;
      if AllOk then begin
//        self.LastGoogleCheckTime := startTime;
//        self.SaveConfig(true);
      end;
    finally
      Google.Free;
      dbList.Free;
      cfg.Free;
      Log('Finished Google check.',ltDetail);
    end;
  except
    on e: exception do begin
      Log('Error checking Google: ' + e.Message,ltError);
    end;
  end;
end;

end.
