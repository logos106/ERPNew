unit ClearInUseTablesThreadTask;

interface

uses
  ServerModuleThreadTask;

type

  TClearInUseTablesThreadTask = class(TServerModuleThreadTask)
  private
  protected
    procedure DoWork; override;
  public
    constructor Create; override;
  end;

implementation

uses
  SharedAppUserListObj;

{ TClearInUseTablesThreadTask }

constructor TClearInUseTablesThreadTask.Create;
begin
  inherited;
  RemoveWhenComplete := true;
end;

procedure TClearInUseTablesThreadTask.DoWork;
begin
  inherited;
  TSharedAppUserList.ExClearInUseTables(MySQLServer);
end;

end.
