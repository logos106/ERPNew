unit CustomProcessCheckThreadTask;

interface

uses
  ServerModuleThreadTask, DBBackupObj, JsonRpcTcpClient;

type

  TCustomProcessCheckThreadTask = class(TServerModuleThreadTask)
  private
  protected
    procedure DoWork; override;
  public
    constructor Create; override;
  end;

implementation

uses
  ModUserUtils, SysUtils;

{ TCustomProcessCheckThreadTask }

constructor TCustomProcessCheckThreadTask.Create;
begin
  inherited;
  self.RemoveWhenComplete := true;
end;

procedure TCustomProcessCheckThreadTask.DoWork;
var
  UserUtils: TModUserUtils;
begin
  if (not Assigned(ServerModule)) or (not (ServerModule is TModUserUtils)) then
    raise Exception.Create('Eror TCustomProcessCheckThreadTask - TModUserUtils Server Module not assigned');
  UserUtils := TModUserUtils(ServerModule);
  UserUtils.CustomProcessList.CheckCustomProcs;
end;

end.
