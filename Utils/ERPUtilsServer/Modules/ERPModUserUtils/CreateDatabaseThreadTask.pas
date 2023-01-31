unit CreateDatabaseThreadTask;

interface
uses
  ServerModuleThreadTask;

type

  TCreateDatabaseThreadTask = class(TServerModuleThreadTask)
  private
  protected
    procedure DoWork; override;
  end;

implementation

{ TCreateDatabaseThreadTask }

procedure TCreateDatabaseThreadTask.DoWork;
begin
  inherited;

end;

end.
