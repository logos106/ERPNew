{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Protocol_sgc_Client;

interface

uses
  Classes, SysUtils,
  sgcJSON, sgcWebSocket_Protocol_sgc_Message,
  sgcWebSocket_Classes, sgcWebSocket_Protocol_Base_Client, sgcWebSocket_HTTPResponse;

type


  TsgcWSRPCResultEvent = procedure(Connection: TsgcWSConnection; Id, Result:
      string) of object;
  TsgcWSRPCErrorEvent = procedure(Connection: TsgcWSConnection; Id: string;
      ErrorCode: integer; ErrorMessage, ErrorData: string) of object;
  TsgcWSCustomEvent = procedure(Connection: TsgcWSConnection; const Channel,
      Text: string) of object;


  TsgcWSProtocol_sgc_Client = class(TsgcWSProtocol_Subscription_Client_Base)
  { wsmessage }
  protected
    FWSMessage: TsgcWSMessage;
    function GetWSMessage: TsgcWSMessage;
  protected
    property WSMessage: TsgcWSMessage read GetWSMessage write FWSMessage;
  { wsmessage }

  { from TsgcWSComponent }
  protected
    procedure DoEventMessage(aConnection: TsgcWSConnection; const Text: string);
        override;
    procedure DoEventDisconnect(aConnection: TsgcWSConnection; Code: Integer);
        override;
  { from TsgcWSComponent }

  public
    constructor Create(aOwner: TComponent); override;

  { procedures }
  public
    procedure Subscribe(const aChannel: String; const aGuid: String = ''); override;
    procedure UnSubscribe(const aChannel: String; const aGuid: String = '');
        override;
    procedure Broadcast(const aText: String; const aChannel: String = ''; const
        aGuid: String = '');
    procedure RPC(const aId, aMethod: string; const aParams: string = ''; const
        aGuid: String = '');
    procedure Notify(const aMethod: string; const aParams: string = ''; const
        aGuid: String = '');
    procedure Publish(const aText, aChannel: String; const aGuid: String = '');
  { procedures }

  { events }
  private
    FOnEvent: TsgcWSCustomEvent;
    FOnRPCError: TsgcWSRPCErrorEvent;
    FOnRPCResult: TsgcWSRPCResultEvent;
  public
    property OnEvent: TsgcWSCustomEvent read FOnEvent write FOnEvent;
    property OnRPCError: TsgcWSRPCErrorEvent read FOnRPCError write FOnRPCError;
    property OnRPCResult: TsgcWSRPCResultEvent read FOnRPCResult write FOnRPCResult;
  { events }
  end;

implementation

uses sgcWebSocket_Const, sgcWebSocket_Helpers;

constructor TsgcWSProtocol_sgc_Client.Create(aOwner: TComponent);
begin
  inherited;
  FProtocol := CS_PROTOCOL_SGC;
end;

procedure TsgcWSProtocol_sgc_Client.DoEventMessage(aConnection:
    TsgcWSConnection; const Text: string);
begin
  WSMessage.Read(Text);

  if WSMessage.Method = CS_SGC_EVENT then
  begin
    if Assigned(FOnEvent) then
      FOnEvent(aConnection, WSMessage.Channel, WSMessage.Text)
  end
  else if WSMessage.method = CS_SGC_MESSAGE then
  begin
    aConnection.MsgReceived := WSMessage.Text;
    inherited;
    aConnection.MsgReceived := Text;
  end
  else if WSMessage.Method = CS_SGC_SUBSCRIBE then
  begin
    aConnection.DoSubscribe(aConnection.Guid + '_' + WSMessage.Channel);
    aConnection.LastSubscription := WSMessage.Channel;
    DoNotifySubscription(aConnection);
  end
  else if WSMessage.Method = CS_SGC_UNSUBSCRIBE then
  begin
    aConnection.DoUnSubscribe(aConnection.Guid + '_' + WSMessage.Channel);
    aConnection.LastUnSubscription := WSMessage.Channel;
    DoNotifyUnSubscription(aConnection)
  end
  else if WSMessage.errorcode <> 0 then
  begin
    if Assigned(FOnRPCError) then
      FOnRPCError(aConnection, WSMessage.id, WSMessage.errorcode,
        WSMessage.errormessage, WSMessage.errordata);
  end
  else if WSMessage.result <> '' then
  begin
    if Assigned(FOnRPCResult) then
      FOnRPCResult(aConnection, WSMessage.id, WSMessage.result);
  end
  else
    inherited;
end;

function TsgcWSProtocol_sgc_Client.GetWSMessage: TsgcWSMessage;
begin
  if not Assigned(FWSMessage) then
    FWSMessage := TsgcWSMessage.Create(self);
  Result := FWSMessage;
end;

procedure TsgcWSProtocol_sgc_Client.RPC(const aId, aMethod: string; const
    aParams: string = ''; const aGuid: String = '');
begin
  WSMessage.DoEnterWrite;

  WSMessage.id := aId;
  WSMessage.method := aMethod;
  WSMessage.params := aParams;
  WSMessage.Guid := aGuid;
  inherited WriteData(WSMessage.Write);
end;

procedure TsgcWSProtocol_sgc_Client.Subscribe(const aChannel: String; const
    aGuid: String = '');
begin
  WSMessage.DoEnterWrite;

  WSMessage.Method := CS_SGC_SUBSCRIBE;
  WSMessage.Channel := aChannel;
  WSMessage.Guid := aGuid;
  inherited WriteData(WSMessage.Write);
end;

procedure TsgcWSProtocol_sgc_Client.UnSubscribe(const aChannel: String; const
    aGuid: String = '');
begin
  WSMessage.DoEnterWrite;

  WSMessage.Method := CS_SGC_UNSUBSCRIBE;
  WSMessage.Channel := aChannel;
  WSMessage.Guid := aGuid;
  inherited WriteData(WSMessage.Write);
end;

procedure TsgcWSProtocol_sgc_Client.Broadcast(const aText: String; const
    aChannel: String = ''; const aGuid: String = '');
begin
  WSMessage.DoEnterWrite;

  WSMessage.Method := CS_SGC_BROADCAST;
  WSMessage.Text := aText;
  WSMessage.Channel := aChannel;
  WSMessage.Guid := aGuid;
  inherited WriteData(WSMessage.Write);
end;

procedure TsgcWSProtocol_sgc_Client.DoEventDisconnect(aConnection:
    TsgcWSConnection; Code: Integer);
begin
  WSMessage.Clear(True);
  inherited;
end;

procedure TsgcWSProtocol_sgc_Client.Notify(const aMethod: string; const
    aParams: string = ''; const aGuid: String = '');
begin
  WSMessage.DoEnterWrite;

  WSMessage.id := '';
  WSMessage.method := aMethod;
  WSMessage.params := aParams;
  WSMessage.Guid := aGuid;
  inherited WriteData(WSMessage.Write);
end;

procedure TsgcWSProtocol_sgc_Client.Publish(const aText, aChannel: String;
    const aGuid: String = '');
begin
  WSMessage.DoEnterWrite;

  WSMessage.Method := CS_SGC_PUBLISH;
  WSMessage.Text := aText;
  WSMessage.Channel := aChannel;
  WSMessage.Guid := aGuid;
  inherited WriteData(WSMessage.Write);

end;

end.
