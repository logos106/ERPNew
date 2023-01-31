unit ERPModServer;

interface

uses
  Pipes, Classes, JsonObject;

type
  TERPModServer = class(TObject)
  private
//    fBuffer: string;
//    fMessageDone: boolean;
//    fTimeout: integer;
//    fPipeName: string;
//    function GetPipeClient: TPipeClient;
  protected
//    property PipeClient: TPipeClient read GetPipeClient;
    fPipeServer: TPipeServer;
    procedure DoOnPipeMessage(Sender : TObject; Pipe : HPIPE; Stream : TStream); virtual;
    procedure OnMessage(Sender : TObject; Pipe : HPIPE; Data : TJsonObject); virtual;
    procedure DoTerminate;
  public
    Constructor Create(PipeName: string);
    destructor Destroy; override;
    function Write(Pipe : HPIPE; Msg: string): Boolean;
//    function Send(msg: string): string;
//    property Timeout: integer read fTimeout write fTimeout;
  end;


implementation

uses
  SysUtils, Forms;

{ TERPModServer }

constructor TERPModServer.Create(PipeName: string);
begin
  fPipeServer := TPipeServer.Create(nil);
  fPipeServer.OnPipeMessage := DoOnPipeMessage;
  fPipeServer.PipeName := PipeName;
  fPipeServer.Active := true;
end;

destructor TERPModServer.Destroy;
begin
  fPipeServer.Free;
  inherited;
end;

procedure TERPModServer.DoOnPipeMessage(Sender: TObject; Pipe: HPIPE;
  Stream: TStream);
var
  Data: TJsonObject;
begin
  Data := JO;
  Data.ReadFromStream(Stream);
  WriteLn(Output, Data.AsString);
  try
    OnMessage(Sender, Pipe, Data);

  finally
    Data.Free;
  end;
end;

procedure TERPModServer.DoTerminate;
begin
  TThread.CreateAnonymousThread(
    procedure ()
    begin
      Sleep(1000);
      Application.Terminate;
    end
  ).Start;
end;

procedure TERPModServer.OnMessage(Sender: TObject; Pipe: HPIPE;
  Data: TJsonObject);
begin
  if Data.S['target'] = 'system' then begin
    if Data.S['command'] = 'terminate' then begin
      Write(Pipe, '{"result":"ok"}');
      DoTerminate;
      exit;
    end
  end;

end;

function TERPModServer.Write(Pipe: HPIPE; Msg: string): Boolean;
begin
  result := fPipeServer.Write(Pipe, PChar(Msg)^, Length(Msg) * SizeOf(Char));
end;

end.
