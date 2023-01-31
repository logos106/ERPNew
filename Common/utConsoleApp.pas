unit utConsoleApp;

interface

uses
  Classes, PJConsoleApp, PJPipe;

type

  TConsoleApp = class(TPJCustomConsoleApp)
  private
    fOutPipe: TPJPipe;
    fOnConsoleWork: TNotifyEvent;
  protected
    procedure DoStart; override;
    procedure DoWork; override;
  public
    OutStream: TStringStream;
    constructor Create;
    destructor Destroy; override;
    property OnConsoleWork: TNotifyEvent read fOnConsoleWork write fOnConsoleWork;
    function ExecuteEx(const CmdLine: string; const CurrentDir: string = ''): Boolean;
  end;



implementation

{ TConsoleApp }

constructor TConsoleApp.Create;
begin
  fOutPipe := TPJPipe.Create;
  OutStream := TStringStream.Create;
  self.StdOut := fOutPipe.WriteHandle;
  self.TimeSlice := 2; // forces more than one OnWork event
  self.UseNewConsole := true;
end;

destructor TConsoleApp.Destroy;
begin
  fOutPipe.Free;
  OutStream.Free;
  inherited;
end;

procedure TConsoleApp.DoStart;
begin
  OutStream.Clear;
  inherited;
end;

procedure TConsoleApp.DoWork;
begin
  inherited;
  fOutPipe.CopyToStream(OutStream, 0);
  if Assigned(fOnConsoleWork) then
    fOnConsoleWork(self);
end;

function TConsoleApp.ExecuteEx(const CmdLine, CurrentDir: string): Boolean;
begin

end;

end.
