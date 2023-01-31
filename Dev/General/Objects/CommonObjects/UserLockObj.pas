unit UserLockObj;

interface

uses
  classes, UserLockBaseObj;

type

  TUserLock = class(TUserLockBase)
  private
  protected
    function GetUserName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  AppEnvironmentVirtual, MyAccess;


{ TUserLock }

constructor TUserLock.Create(AOwner: TComponent);
begin
  inherited;
  Connection:= TMyConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  if Assigned(Owner) then begin
    // default to class name of owner form
    LockOwnerClassName := Owner.ClassName;
  end;
//  if Assigned(AppEnv.AppDb) AND AppEnv.AppDb.Connection.Connected then
//    LockOwnerUserName := AppEnv.Employee.LogonName;
  if Connection.Connected then
    LockOwnerUserName := AppEnvVirt.Str['Employee.LogonName'];
end;

function TUserLock.GetUserName: string;
begin
  result:= AppEnvVirt.Str['Employee.LogonName'];
end;

end.
