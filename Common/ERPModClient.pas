unit ERPModClient;

interface

uses
  Pipes, Classes;

type
  TERPModClient = class(TObject)
  private
    fPipeClient: TPipeClient;
    fBuffer: string;
    fMessageDone: boolean;
    fTimeout: integer;
    fPipeName: string;
    procedure DoOnPipeMessage(Sender : TObject; Pipe : HPIPE; Stream : TStream);
    function GetPipeClient: TPipeClient;
  protected
    property PipeClient: TPipeClient read GetPipeClient;
  public
    Constructor Create(PipeName, ServerFileName: string);
    destructor Destroy; override;
    function Send(msg: string): string;
    property Timeout: integer read fTimeout write fTimeout;
  end;

implementation

uses
  ModuleFileNameUtils, SysUtils, SystemLib, Dialogs;

{ TERPModClient }

constructor TERPModClient.Create(PipeName, ServerFileName: string);
var
  fileName: string;
begin
  fTimeout := 10000;
  fPipeName := PipeName;
  fileName := ServerFileName;
  UniqueString(fileName);
  ExecNewProcess(fileName,false);
end;

destructor TERPModClient.Destroy;
var
  s: string;
begin
  s := Send('{"target":"system","command":"terminate"}');
  ShowMessage(s);
  fPipeClient.Free;
  inherited;
  inherited;
end;

procedure TERPModClient.DoOnPipeMessage(Sender: TObject; Pipe: HPIPE;
  Stream: TStream);
begin
  SetLength(fBuffer, Stream.Size div SizeOf(Char));
  Stream.Position := 0;
  Stream.Read(fBuffer[1], Stream.Size);
  if fBuffer = #$FEFF then
    exit;
  fMessageDone := true;
end;

function TERPModClient.GetPipeClient: TPipeClient;
begin
  if not Assigned(fPipeClient) then begin
    fPipeClient := TPipeClient.Create(nil);
    fPipeClient.PipeName := fPipeName;
    fPipeClient.OnPipeMessage := DoOnPipeMessage;
  end;
  result := fPipeClient;
end;

function TERPModClient.Send(msg: string): string;
begin
  if not PipeClient.Connected then
    PipeClient.Connect(2000);
  fBuffer := '';
  fMessageDone := false;
  PipeClient.Write(PChar(Msg)^, Length(Msg) * SizeOf(Char));
  if PipeClient.WaitForReply(Timeout) then begin
    result := fBuffer;
  end
  else begin
    raise Exception.Create('Timeout waiting for response from Module');
  end;
end;

end.
