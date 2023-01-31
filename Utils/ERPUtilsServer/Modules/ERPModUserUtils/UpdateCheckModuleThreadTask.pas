unit UpdateCheckModuleThreadTask;

interface

uses
  ServerModuleThreadTask;

type

  TUpdateCheckModuleThreadTask = class(TServerModuleThreadTask)
  private
  protected
    procedure DoWork; override;
  end;


implementation

uses
  ErpDbMaintObj, ErpDbUpdaterObj, sysutils, LogMessageTypes;


{ TUpdateCheckModuleThreadTask }

procedure TUpdateCheckModuleThreadTask.DoWork;
var
  ErpMaint: TErpMaint;
  Updater: TErpDbUpdater;
begin
  try
    ErpMaint:= TErpMaint.Create(MySQLServer);
    try
      ErpMaint.Logger := nil;
      ErpMaint.OnLog := self.OnLog;
      ErpMaint.DatabaseList.AsString := Params.O['DbList'].AsString; //  DbListJsonText;
      ErpMaint.DoMaint;
    finally
      ErpMaint.Free;
    end;

    if Terminated then
      Exit;

//    Updater:= TErpDbUpdater.Create(SoftwareReleaseType, Logger);
    Updater := TErpDbUpdater.Create(Params.S['SoftwareReleaseType'], MySQLServer, nil);
    try
      Updater.OnLog := self.OnLog;
      Updater.DatabaseList.AsString := Params.O['DbList'].AsString; // DbListJsonText;
      Updater.CheckForUpdates;
    finally
      Updater.Free;
    end;
  except
    on e: exception do begin
      Log('Error while checking for updates: ' + e.Message, ltError);
    end;
  end;
end;

end.
