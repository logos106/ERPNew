unit PingCheckThreadTask;

interface

uses
  ServerModuleThreadTask, DBBackupObj;

type

  TPingCheckThreadTask = class(TServerModuleThreadTask)
  private
  protected
    procedure DoWork; override;
  public
    constructor Create; override;
  end;

implementation

uses
  InternetConnectivityUtils;

{ TPingCheckThreadTask }

constructor TPingCheckThreadTask.Create;
begin
  inherited Create;
  RemoveWhenComplete := false;
end;

procedure TPingCheckThreadTask.DoWork;
begin
  inherited;
  InternetConnectivityUtils.InternetAccessOk(false);
end;

end.
