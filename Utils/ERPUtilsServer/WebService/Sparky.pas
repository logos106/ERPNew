unit Sparky;

interface

uses
  Classes, SysUtils, LogThreadBase, LogThreadLib, ModWebAPI;

type
  TSparky = class(TThread)
  private
    ServerModule1: TModWebAPI;

  protected
    procedure Execute; override;

  public
    Finished: Boolean;

    Logger: TLogger;
    constructor Create();

    procedure MyTerminate();

  end;

implementation

uses ConsoleLogObj, StrUtils;

{ Tsparky }

constructor TSparky.Create();
begin
  inherited Create;
  Finished := False;
end;

procedure TSparky.Execute;
begin
  ServerModule1 := TModWebAPI.Create(Logger);
  try
    ServerModule1.Execute;
  finally
    Sleep(5000);
    ServerModule1.Free;
    Finished := True;
  end;
end;

procedure TSparky.MyTerminate;
begin
  ServerModule1.Terminated := True;
end;

end.

