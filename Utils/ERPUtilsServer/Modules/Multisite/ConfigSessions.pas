unit ConfigSessions;

interface

uses
  SessionListObj, JsonObject, JsonRpcBase, LogThreadLib;

type

  TConfigSession = class(TSession)
  private
  public
    procedure DoRequest(RequestJson: TJsonObject; ResultJson: TJsonObject = nil); override;
  end;


  TMultisiteConfigSessionList = class(TSessionList)
  private
    procedure LogEventHandler(Sender: TObject; const Event, Value : string);
  public
    constructor Create(aLogger: TLogger = nil); override;
    destructor Destroy; override;
  end;

var
  MultisiteConfigSessionList: TMultisiteConfigSessionList;

implementation

uses
  MultisiteObj, classes, sysutils, JsonRpcConst, JsonToObject;

{ TConfigSession }

procedure TConfigSession.DoRequest(RequestJson: TJsonObject; ResultJson: TJsonObject = nil);
var
  method: string;
  idx: integer;
begin
    { process the request }
  method:= Lowercase(RequestJson.S['method']);
  idx:= Pos('.',method);
  if idx > 0 then
    method:= Copy(method,idx+1,Length(method));
  if method = 'getobject' then begin
    { now look at params to see which object ... }
    if RequestJson.ObjectExists('params') then begin
      if RequestJson.O['params'].S['classname'] = 'TMultisite' then begin
        MS.Lock;
        try
          ResultJson.O['result'].S['classname']:= 'TMultisite';
          ObjToJson(MS,ResultJson.O['result'].O['object']);
        finally
          MS.Unlock;
        end;
      end;
    end;
  end
  else if method = 'setobject' then begin
    if RequestJson.ObjectExists('params') then begin
      if RequestJson.O['params'].S['classname'] = 'TMultisite' then begin
        MS.Lock;
        try
          JsonToObj(RequestJson.O['params'].O['object'],MS);
        finally
          MS.Unlock;
        end;
        if Assigned(ResultJson) then
          ResultJson.S['result']:= 'ok';

      end;
    end;
  end;
end;

{ TMultisiteConfigSessionList }

constructor TMultisiteConfigSessionList.Create(aLogger: TLogger = nil);
begin
  inherited Create(aLogger);
  if Assigned(Logger) then
    Logger.Events.AddMultiEvent(LogEventHandler);
end;

destructor TMultisiteConfigSessionList.Destroy;
begin
  if Assigned(Logger) then
    Logger.Events.RemoveMultiEvent(LogEventHandler);
  inherited;
end;

procedure TMultisiteConfigSessionList.LogEventHandler(Sender: TObject;
  const Event, Value: string);
var
  lst: TList;
  x: integer;
  Ses: TConfigSession;
  str: string;
begin
  str:= EncodeString(Value);
  lst:= LockList;
  try
    for x:= 0 to lst.Count -1 do begin
      ses:= TConfigSession(lst[x]);
      ses.Client.SendNotification('event',JO('{"eventname":"'+Event+'","value":"' + str +'"}'));
    end;
  finally
    UnlockList;
  end;
end;

end.
