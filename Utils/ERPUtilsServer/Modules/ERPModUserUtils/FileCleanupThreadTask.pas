unit FileCleanupThreadTask;

interface

uses
  ServerModuleThreadTask;

type

  TFileCleanupModuleThreadTask = class(TServerModuleThreadTask)
  private
  protected
    procedure DoWork; override;
  end;

implementation

uses
  DBBackupObj, LogMessageTypes;

{ TFileCleanupModuleThreadTask }

procedure TFileCleanupModuleThreadTask.DoWork;
begin
  inherited;
  Log('Checking for old tempory backup files ..',ltDetail);
  if TDBBackup.CleanupTempFiles then
    Log('Deleted old files.',ltDetail)
  else
    Log('No files found.',ltDetail);
end;

end.
