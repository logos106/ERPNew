{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Protocol_WAMP_Server;

interface

uses
  Classes, SysUtils,
  sgcJSON, sgcWebSocket_Protocol_WAMP_Message,
  sgcWebSocket_Classes, sgcWebSocket_Protocol_Base_Server, sgcWebSocket_HTTPResponse;

type

  TsgcWSPrefixEvent = procedure(Connection: TsgcWSConnection; const Prefix, URI:
      string) of object;
  TsgcWSCallEvent = procedure(Connection: TsgcWSConnection; const CallId, ProcUri, Arguments:
      string) of object;

  TsgcWSProtocol_WAMP_Server = class(TsgcWSProtocol_Subscription_Server_Base)
  { WSMessageWAMP }
  private
    FWSMessageWAMP: TsgcWSMessageWAMP;
    function GetWSMessageWAMP: TsgcWSMessageWAMP;
  protected
    property WSMessageWAMP: TsgcWSMessageWAMP read GetWSMessageWAMP write
        FWSMessageWAMP;
  { WSMessageWAMP }

  { from TsgcWSComponent }
  protected
    procedure DoNotifyConnect(aConnection: TsgcWSConnection); override;
    procedure DoEventMessage(aConnection: TsgcWSConnection; const Text: string);
        override;
  { from TsgcWSComponent }

  { call }
  private
    FCallId: TStringList;
  protected
    function GetCallId: TStringList;
    function AddCallId(const aGuid, aCallId: string): Boolean;
    function RemoveCallId(const aCallId: string): Boolean;
    function GetCallGuid(const aCallId: string): String;
  { call }

  { procedures }
  public
    procedure CallResult(const aCallId: String; const aResult: String = '');
    procedure CallError(const aCallId, aErrorURI, aErrorDesc: String; const
        aErrorDetails: String = '');
    procedure Event(const aTopicURI: String; const aEvent: String = '');
  { procedures }

  { constructor }
  public
    constructor Create(aOwner: TComponent); override;
  { constructor }

  { events }
  private
    FOnCall: TsgcWSCallEvent;
    FOnPrefix: TsgcWSPrefixEvent;
  public
    property OnCall: TsgcWSCallEvent read FOnCall write FOnCall;
    property OnPrefix: TsgcWSPrefixEvent read FOnPrefix write FOnPrefix;
  { events }    
  end;


  TsgcWSProtocol_JS_WAMP = class(TsgcWSHTTPResponse_Base)
  protected
    function GetResponse: string; override;
  public
    class function GetFileName: string; override;
  end;


  TsgcWSProtocol_HTML_WAMP = class(TsgcWSHTTPResponse_Base)
  protected
    function GetResponse: string; override;
  public
    class function GetFileName: string; override;
  end;

implementation

uses
  sgcWebSocket_Const, sgcWebSocket_Helpers,
  sgcWebsocket_Resources, sgcWebSocket_CS;

constructor TsgcWSProtocol_WAMP_Server.Create(aOwner: TComponent);
begin
  inherited;
  FProtocol := CS_PROTOCOL_WAMP;
end;

procedure TsgcWSProtocol_WAMP_Server.CallResult(const aCallId: String; const
    aResult: String = '');
begin
  WSMessageWAMP.DoEnterWrite;
  Try
    WSMessageWAMP.TypeId := CS_WAMP_CALLRESULT;
    WSMessageWAMP.CallId := aCallId;
    WSMessageWAMP.CallResult := aResult;

    WriteData(GetCallGuid(aCallId), WSMessageWAMP.Write);

    RemoveCallId(aCallId);
  Finally
    WSMessageWAMP.DoLeaveWrite;
  End;
end;

function TsgcWSProtocol_WAMP_Server.AddCallId(const aGuid, aCallId: string):
    Boolean;
begin
  Result := False;
  if GetCallId.IndexOfName(aCallId) = -1 then
    Result := GetCallId.Add(aCallId + '=' + aGuid) <> -1;
end;

procedure TsgcWSProtocol_WAMP_Server.CallError(const aCallId, aErrorURI,
    aErrorDesc: String; const aErrorDetails: String = '');
begin
  WSMessageWAMP.DoEnterWrite;
  Try
    WSMessageWAMP.TypeId := CS_WAMP_CALLERROR;
    WSMessageWAMP.CallId := aCallId;
    WSMessageWAMP.ErrorURI := aErrorURI;
    WSMessageWAMP.ErrorDesc := aErrorDesc;
    WSMessageWAMP.ErrorDetails := aErrorDetails;

    WriteData(GetCallGuid(aCallId), WSMessageWAMP.Write);

    RemoveCallId(aCallId);
  Finally
    WSMessageWAMP.DoLeaveWrite;
  End;
end;

procedure TsgcWSProtocol_WAMP_Server.DoNotifyConnect(aConnection:
    TsgcWSConnection);
begin
  WSMessageWAMP.DoEnterWrite;
  Try
    // ... welcome message
    WSMessageWAMP.TypeId := CS_WAMP_WELCOME;
    WSMessageWAMP.SessionId := aConnection.Guid;
    WriteData(aConnection.Guid, WSMessageWAMP.Write);
  Finally
    WSMessageWAMP.DoLeaveWrite;
  End;
  // ... notify connection
  inherited;
end;

procedure TsgcWSProtocol_WAMP_Server.DoEventMessage(aConnection:
    TsgcWSConnection; const Text: string);
begin
  WSMessageWAMP.Read(Text);

  case WSMessageWAMP.TypeId of
    CS_WAMP_PREFIX:
      begin
        if Assigned(FOnPrefix) then
          FOnPrefix(aConnection, WSMessageWAMP.Prefix, WSMessageWAMP.PrefixURI);
      end;
    CS_WAMP_CALL:
      begin
        AddCallId(aConnection.Guid, WSMessageWAMP.CallId);
        if Assigned(FOnCall) then
          FOnCall(aConnection, WSMessageWAMP.CallId, WSMessageWAMP.ProcUri, WSMessageWAMP.Arguments);
      end;
    CS_WAMP_SUBSCRIBE:
      begin
        aConnection.DoSubscribe(WSMessageWAMP.TopicURI);
        if aConnection.Subscribed(WSMessageWAMP.TopicURI) then
        begin
          aConnection.LastSubscription := WSMessageWAMP.TopicURI;
          DoEventSubscription(aConnection, WSMessageWAMP.TopicURI);
        end;
      end;
    CS_WAMP_UNSUBSCRIBE:
      begin
        aConnection.DoUnSubscribe(WSMessageWAMP.TopicURI);
        if not aConnection.Subscribed(WSMessageWAMP.TopicURI) then
        begin
          aConnection.LastUnSubscription := WSMessageWAMP.TopicURI;
          DoEventUnSubscription(aConnection, WSMessageWAMP.TopicURI);
        end;
      end;
    CS_WAMP_PUBLISH:
      begin
        WSMessageWAMP.TypeId := CS_WAMP_EVENT;
        Broadcast(WSMessageWAMP.Write, WSMessageWAMP.TopicURI)
      end;
    else
      inherited;
  end;
end;

function TsgcWSProtocol_WAMP_Server.GetCallGuid(const aCallId: string): String;
begin
  Result := GetCallId.Values[aCallId];
end;

function TsgcWSProtocol_WAMP_Server.GetCallId: TStringList;
begin
  DoEnterCS;
  Try
    if not Assigned(FCallId) then
      FCallId := TStringList.Create;
    Result := FCallId;
  Finally
    DoLeaveCS;
  End;
end;

function TsgcWSProtocol_WAMP_Server.GetWSMessageWAMP: TsgcWSMessageWAMP;
begin
  if not Assigned(FWSMessageWAMP) then
    FWSMessageWAMP := TsgcWSMessageWAMP.Create(self);
  Result := FWSMessageWAMP;
end;

function TsgcWSProtocol_WAMP_Server.RemoveCallId(const aCallId: string):
    Boolean;
var
  i: Integer;
begin
  result := False;

  i := GetCallId.IndexOfName(aCallId);
  if i <> -1 then
  begin
    GetCallId.Delete(i);
    result := True;
  end;
end;

procedure TsgcWSProtocol_WAMP_Server.Event(const aTopicURI: String; const
    aEvent: String = '');
begin
  WSMessageWAMP.DoEnterWrite;
  Try
    WSMessageWAMP.TypeId := CS_WAMP_EVENT;
    WSMessageWAMP.TopicUri := aTopicURI;
    WSMessageWAMP.Event := aEvent;

    BroadCast(WSMessageWAMP.Write, aTopicURI);
  Finally
    WSMessageWAMP.DoLeaveWrite;
  End;
end;

function TsgcWSProtocol_JS_WAMP.GetResponse: string;
begin
  result := GetResourceString('SGC_JS_WAMP_ESEGECE_COM');
end;

class function TsgcWSProtocol_JS_WAMP.GetFileName: string;
begin
  Result := 'wamp.esegece.com.js';
end;

class function TsgcWSProtocol_HTML_WAMP.GetFileName: string;
begin
  Result := 'wamp.esegece.com.html';
end;

function TsgcWSProtocol_HTML_WAMP.GetResponse: string;
begin
  result := GetResourceString('SGC_HTML_WAMP_ESEGECE_COM');
end;


initialization
  RegisterClass(TsgcWSProtocol_WAMP_Server);
  TsgcWSHTTPResponse.RegisterfileName(TsgcWSProtocol_JS_WAMP);
  TsgcWSHTTPResponse.RegisterfileName(TsgcWSProtocol_HTML_WAMP);

end.
