program Module1;
  { NOTE remove this if you don't want to display command window }
// {$APPTYPE CONSOLE}

uses
  SysUtils,
  ServerModuleObj in '..\ServerModuleObj.pas',
  ModuleFileNameUtils in '..\..\ModuleFileNameUtils.pas',
  SystemLib in '..\..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  SimplePipes in '..\..\SimplePipes.pas',
  ModuleComms in '..\..\ModuleComms.pas',
  ThreadProperty in '..\..\ThreadProperty.pas';

type
  TServerModule1 = class(TServerModule)
  private
    dt: TDateTime;
  protected
    procedure DoWork; override;
    procedure DoOnMessage(aClientId: integer; aData: string); overload; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;



{ TServerModule1 }

constructor TServerModule1.Create;
begin
  inherited;
  Log('Module Created');
  dt:= 0;
end;

destructor TServerModule1.Destroy;
begin
  Log('Module Destroyed');
  while not Logger.Buffer.Empty do
    sleep(10);
  inherited;
end;

procedure TServerModule1.DoOnMessage(aClientId: integer; aData: string);
begin
  inherited;
  WriteLn(aData);
end;

procedure TServerModule1.DoWork;
begin
  inherited;

  Log('Started work ...');
  SysUtils.Sleep(10 * 1000);
  Log('Finished');

end;

var
  ServerModule1: TServerModule1;

begin
  try
    ServerModule1:= TServerModule1.Create;
    try
      ServerModule1.Execute;

    finally
      ServerModule1.Free;
    end;
    //ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
