unit SimplePipesComms;

interface

uses
  SimplePipes, SyncObjs;

type
  TPipeCommsMessageEvent = procedure(aData: string) of object;
  TPipeCommsRequestEvent = procedure(aRequest: string; var aResponse: string) of object;
  TPipeRequestType = (rtMessage, rtRequest, rtResponse);
  TPipeRequestStatus = (rsIdle, rsWaitingOnResponse, rsResponseReady);

  TPipeComms = class
  private
    fChannelName: string;
    fIsServer: boolean;
    Server: TPBPipeServer;
    fOnMessage: TPipeCommsMessageEvent;
    fOnRequest: TPipeCommsRequestEvent;
    RequestStatus: TPipeRequestStatus;
    fData: string;
    CriticalSection: TCriticalSection;
    procedure DoReceivedData(aData: string);
    function InternalSend(aType: TPipeRequestType; aData: string): boolean;
  public
    constructor Create(aChannelName: string; IsServer: boolean);
    destructor Destroy; override;
    function SendMessage(aMessage: string): boolean;
    function SendRequest(aRequest: string; var aResponse: string; aTimeoutMS: integer = 10000): boolean;
    property OnMessage: TPipeCommsMessageEvent read fOnMessage write fOnMessage;
    property OnRequest: TPipeCommsRequestEvent read fOnRequest write fOnRequest;
  end;


implementation

uses
  sysutils;

{ TPipeComms }

constructor TPipeComms.Create(aChannelName: string; IsServer: boolean);
begin
  CriticalSection := TCriticalSection.Create;
  RequestStatus := rsIdle;
  fChannelName := aChannelName;
  fIsServer := IsServer;
  if fIsServer then
    Server := TPBPipeServer.Create('\\.\pipe\' + fChannelName)
  else
    Server := TPBPipeServer.Create('\\.\pipe\' + fChannelName + 'Client');
  Server.OnReceivedData := DoReceivedData;

end;

destructor TPipeComms.Destroy;
begin
  Server.Free;
  CriticalSection.Free;
  inherited;
end;

procedure TPipeComms.DoReceivedData(aData: string);
var
  reqTypeStr : string; //TPipeRequestType
  aResponse: string;
begin
  if Length(aData) < 1 then exit;
  reqTypeStr := Copy(aData,1,1);
  if reqTypeStr = IntToStr(Ord(rtMessage)) then begin
    if Assigned(fOnMessage) then
      fOnMessage(Copy(aData,2,Length(aData)));
  end
  else if reqTypeStr = IntToStr(Ord(rtRequest)) then begin
    if Assigned(fOnRequest) then begin
      fOnRequest(Copy(aData,2,Length(aData)),aResponse);
      InternalSend(rtResponse, aResponse);
    end;
  end
  else if reqTypeStr = IntToStr(Ord(rtResponse)) then begin
    CriticalSection.Acquire;
    try
      if RequestStatus = rsWaitingOnResponse then begin
        fData:= Copy(aData,2,Length(aData));
        RequestStatus:= rsResponseReady;
      end;
    finally
      CriticalSection.Release;
    end;
  end;
end;

function TPipeComms.InternalSend(aType: TPipeRequestType;
  aData: string): boolean;
begin
  result:= true;
  try
    if fIsServer then
      TPBPipeClient.SendData('\\.\pipe\' + fChannelName + 'Client',IntToStr(Ord(aType))+ aData)
    else
      TPBPipeClient.SendData('\\.\pipe\' + fChannelName,IntToStr(Ord(aType))+ aData);
  except
    result:= false;
  end;
end;

function TPipeComms.SendMessage(aMessage: string): boolean;
begin
  result:= InternalSend(rtMessage, aMessage);
end;

function TPipeComms.SendRequest(aRequest: string;
  var aResponse: string; aTimeoutMS: integer): boolean;
var
  dt: TDateTime;
const
  OneMS = 1/24/60/60/1000;
begin
  result:= true;
  try
    CriticalSection.Acquire;
    RequestStatus := rsWaitingOnResponse;
    CriticalSection.Release;

    if not InternalSend(rtRequest,aRequest) then begin
      result:= false;
      exit;
    end;

    dt:= now + (aTimeoutMS * OneMS);

    try
    { wait for reply }
      while true do begin
        CriticalSection.Acquire;
        try
          if RequestStatus = rsResponseReady then begin
            aResponse := fData;
            RequestStatus := rsIdle;
            Break;
          end;
          if now > dt then begin
            { timed out }
            result:= false;
            RequestStatus := rsIdle;
            Break;
          end;
          Sleep(10);

        finally
          CriticalSection.Release;
        end;
      end;
    finally

    end;

  except
    result := false;

  end;
end;

end.
