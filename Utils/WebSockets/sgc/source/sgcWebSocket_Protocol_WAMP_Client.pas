{ ***************************************************************************
  sgcWebSocket component

  written by eSeGeCe
  copyright © 2013
  Email : info@esegece.com
  Web : http://www.esegece.com
  *************************************************************************** }

unit sgcWebSocket_Protocol_WAMP_Client;

interface

uses
  Classes, SysUtils,
  sgcJSON,
  sgcWebSocket_Classes, sgcWebSocket_Protocol_Base_Client,
  sgcWebSocket_Protocol_WAMP_Message;

type

  TsgcWSWelcomeEvent = procedure(Connection: TsgcWSConnection;
    SessionId, ProtocolVersion, ServerIdent: string) of object;

  TsgcWSCallResultEvent = procedure(Connection: TsgcWSConnection;
    CallId, Result: string) of object;

  TsgcWSCallErrorEvent = procedure(Connection: TsgcWSConnection;
    CallId, ErrorURI, ErrorDesc, ErrorDetails: string) of object;

  TsgcWSEvent = procedure(Connection: TsgcWSConnection;
    TopicURI, Event: string) of object;

  TsgcWSProtocol_WAMP_Client = class(TsgcWSProtocol_Client_Base)
    { WSMessageWAMP }
  protected
    FWSMessageWAMP: TsgcWSMessageWAMP;
    function GetWSMessageWAMP: TsgcWSMessageWAMP;
  protected
    property WSMessageWAMP
      : TsgcWSMessageWAMP read GetWSMessageWAMP write FWSMessageWAMP;
    { WSMessageWAMP }

    { from TsgcWSComponent }
  protected
    procedure DoEventMessage(aConnection: TsgcWSConnection;
      const Text: string); override;
    { from TsgcWSComponent }

    { constructor }
  public
    constructor Create(aOwner: TComponent); override;
    { constructor }

    { write }
  protected
    procedure DoWrite; virtual;
    { write }

    { procedures }
  public
    procedure Prefix(const aPrefix, aURI: String);
    procedure Subscribe(const aTopicURI: String);
    procedure UnSubscribe(const aTopicURI: String);
    procedure Call(const aCallId, aProcURI: String; aArguments: String = '');
    procedure Publish(const aTopicURI, aEvent: string;
      const aExclude: string = ''; const aEligible: String = '');
    { procedures }

    { events }
  private
    FOnCallError: TsgcWSCallErrorEvent;
    FOnCallResult: TsgcWSCallResultEvent;
    FOnEvent: TsgcWSEvent;
    FOnWelcome: TsgcWSWelcomeEvent;
  published
    property OnCallError
      : TsgcWSCallErrorEvent read FOnCallError write FOnCallError;
    property OnCallResult
      : TsgcWSCallResultEvent read FOnCallResult write FOnCallResult;
    property OnEvent: TsgcWSEvent read FOnEvent write FOnEvent;
    property OnWelcome: TsgcWSWelcomeEvent read FOnWelcome write FOnWelcome;
    { events }
  end;

implementation

uses
  sgcWebSocket_Const, sgcWebSocket_Helpers;

constructor TsgcWSProtocol_WAMP_Client.Create(aOwner: TComponent);
begin
  inherited;
  FProtocol := CS_PROTOCOL_WAMP;
end;

procedure TsgcWSProtocol_WAMP_Client.Call(const aCallId, aProcURI: String;
    aArguments: String = '');
begin
  WSMessageWAMP.DoEnterWrite;
  Try
    WSMessageWAMP.TypeId := CS_WAMP_CALL;
    WSMessageWAMP.CallId := aCallId;
    WSMessageWAMP.ProcUri := aProcURI;
    WSMessageWAMP.Arguments := aArguments;

    DoWrite;
  Finally
    WSMessageWAMP.DoLeaveWrite
  End;
end;

procedure TsgcWSProtocol_WAMP_Client.DoEventMessage
  (aConnection: TsgcWSConnection; const Text: string);
begin
  WSMessageWAMP.Read(aConnection.MsgReceived);

  case WSMessageWAMP.TypeId of
    CS_WAMP_WELCOME:
      begin
        if Assigned(FOnWelcome) then
          FOnWelcome(aConnection, WSMessageWAMP.SessionId,
            WSMessageWAMP.ProtocolVersion, WSMessageWAMP.ServerIdent);
      end;
    CS_WAMP_CALLRESULT:
      begin
        if Assigned(FOnCallResult) then
          FOnCallResult(aConnection, WSMessageWAMP.CallId,
            WSMessageWAMP.CallResult);
      end;
    CS_WAMP_CALLERROR:
      begin
        if Assigned(FOnCallError) then
          FOnCallError(aConnection, WSMessageWAMP.CallId,
            WSMessageWAMP.ErrorURI, WSMessageWAMP.ErrorDesc,
            WSMessageWAMP.ErrorDetails);
      end;
    CS_WAMP_EVENT:
      begin
        if Assigned(FOnEvent) then
          FOnEvent(aConnection, WSMessageWAMP.TopicURI, WSMessageWAMP.Event);
      end;
  else
    inherited;
  end;
end;

procedure TsgcWSProtocol_WAMP_Client.DoWrite;
begin
  WriteData(WSMessageWAMP.Write);
end;

function TsgcWSProtocol_WAMP_Client.GetWSMessageWAMP: TsgcWSMessageWAMP;
begin
  if not Assigned(FWSMessageWAMP) then
    FWSMessageWAMP := TsgcWSMessageWAMP.Create(self);
  Result := FWSMessageWAMP;
end;

procedure TsgcWSProtocol_WAMP_Client.Prefix(const aPrefix, aURI: String);
begin
  WSMessageWAMP.DoEnterWrite;
  Try
    WSMessageWAMP.TypeId := CS_WAMP_PREFIX;
    WSMessageWAMP.Prefix := aPrefix;
    WSMessageWAMP.PrefixURI := aURI;

    DoWrite;
  Finally
    WSMessageWAMP.DoLeaveWrite;
  End;
end;

procedure TsgcWSProtocol_WAMP_Client.Publish(const aTopicURI, aEvent: string;
  const aExclude: string = ''; const aEligible: String = '');
begin
  WSMessageWAMP.DoEnterWrite;
  Try
    WSMessageWAMP.TypeId := CS_WAMP_PUBLISH;
    WSMessageWAMP.TopicURI := aTopicURI;
    WSMessageWAMP.Event := aEvent;
    WSMessageWAMP.Exclude := aExclude;
    WSMessageWAMP.Eligible := aEligible;

    DoWrite;
  Finally
    WSMessageWAMP.DoLeaveWrite;
  End;
end;

procedure TsgcWSProtocol_WAMP_Client.Subscribe(const aTopicURI: String);
begin
  WSMessageWAMP.DoEnterWrite;
  Try
    WSMessageWAMP.TypeId := CS_WAMP_SUBSCRIBE;
    WSMessageWAMP.TopicURI := aTopicURI;

    DoWrite;
  Finally
    WSMessageWAMP.DoLeaveWrite;
  End;
end;

procedure TsgcWSProtocol_WAMP_Client.UnSubscribe(const aTopicURI: String);
begin
  WSMessageWAMP.DoEnterWrite;
  Try
    WSMessageWAMP.TypeId := CS_WAMP_UNSUBSCRIBE;
    WSMessageWAMP.TopicURI := aTopicURI;

    DoWrite;
  Finally
    WSMessageWAMP.DoLeaveWrite;
  End;
end;

end.
