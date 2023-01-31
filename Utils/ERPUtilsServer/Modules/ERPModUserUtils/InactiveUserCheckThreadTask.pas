unit InactiveUserCheckThreadTask;

interface

uses
  ServerModuleThreadTask, DBBackupObj, JsonRpcTcpClient;

type

  TInactiveUserCheckThreadTask = class(TServerModuleThreadTask)
  private
  protected
    procedure DoWork; override;
  public
    constructor Create; override;
  end;

implementation

uses
  SharedAppUserListObj;

const
  OneMinute = 1/24/60;
  MAX_USER_INACTIVITY_TIME = OneMinute * 30;

{ TInactiveUserCheckThreadTask }

constructor TInactiveUserCheckThreadTask.Create;
begin
  inherited Create;
//  RemoveWhenComplete := false;
end;

procedure TInactiveUserCheckThreadTask.DoWork;
begin
  TSharedAppUserList.ExRemoveInactiveUsers(MAX_USER_INACTIVITY_TIME, MySQLServer);
end;

end.
