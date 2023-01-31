unit wsComboProtocol;

interface
uses
  Classes, SysUtils, sgcWebSocket_Const,
  sgcJSON, sgcWebSocket_Protocol_sgc_Message,
  sgcWebSocket_Classes, sgcWebSocket_Protocol_Base_Client, sgcWebSocket_HTTPResponse,
  sgcWebSocket_Protocols, sgcWebSocket_Protocol_sgc_Server, sgcWebSocket_Protocol_sgc_Client,
  wsConsts;

type
  TServerTunnel = function(aConnection : TsgcWSConnection; const aMessage : string) : boolean of object;

  TErpRpcComboProtocol_Server = class(TsgcWSPServer_sgc)
  private
    fServerTunnel: TServerTunnel;

  protected
      procedure DoEventMessage(aConnection: TsgcWSConnection; const Text: string);
        override;
      function DoServerTunnel(aConnection : TsgcWSConnection; const aMessage : string) : boolean;
  public

  published
    property OnConnect;
    property OnDisconnect;
    property OnMessage;
    property OnBinary;
    property OnError;
    property OnSubscription;
    property OnUnSubscription;

    property RPCAuthentication;

    property OnNotification;
    property OnRPC;
    property OnRPCAuthentication;

    property Server;

    property Guid;

    property OnServerTunnel : TServerTunnel read fServerTunnel write fServerTunnel;
  end;

  TErpRpcComboProtocol_Client = class(TsgcWSProtocol_sgc_Client)
  private
    fOnNotification: TsgcWSNotificationEvent;
    fOnRPC: TsgcWSRPCEvent;
    fOnMethodAuthorised: TMethodAuthorisation;
  protected
    procedure DoEventMessage(aConnection: TsgcWSConnection; const Text: string); override;
    function DoMethodAuthorisation(aConnection: TsgcWSConnection; const aMethodName : string) : integer;

  public
    constructor Create(aOwner: TComponent); override;

    procedure RPCResult(const aId, aResult: String);
    procedure RPCError(const aId: String; const aCode: Integer;
      const aMessage: String; const aData: String = '');
  published

    property OnConnect;
    property OnDisconnect;
    property OnMessage;
    property OnBinary;
    property OnError;
    property OnSubscription;
    property OnUnSubscription;

    property OnRPCResult;
    property OnRPCError;
    property OnEvent;

    property OnNotification : TsgcWSNotificationEvent read fOnNotification write fOnNotification;
    property OnRPC : TsgcWSRPCEvent read fOnRPC write fOnRPC;
    //
    property OnMethodAuthorised : TMethodAuthorisation read fOnMethodAuthorised write fOnMethodAuthorised;

    property Client;
    property WSMessage;
  end;

implementation

{ TErpRpcComboProtocol_Server }

procedure TErpRpcComboProtocol_Server.DoEventMessage(
  aConnection: TsgcWSConnection; const Text: string);
begin
  if DoServerTunnel(aConnection, Text) then
    exit;

  if Length(Text) > 0 then
    if Text[1] <> '{' then
    begin
      Server.OnMessage(aConnection, Text);
      exit;
    end;

  WSMessage.Read(Text);

  if ((WSMessage.Guid = '') or (WSMessage.Guid = Guid)) then
  begin
    if WSMessage.method = CS_SGC_MESSAGE then
    begin
      aConnection.MsgReceived := WSMessage.Text;
      inherited;
      aConnection.MsgReceived := Text;
    end
    else if WSMessage.Method = CS_SGC_PUBLISH then
    begin
      WSMessage.method := CS_SGC_EVENT;
      WSMessage.Result := CS_SGC_EVENT;
      DoBroadCast(WSMessage, WSMessage.Channel)
    end
    else if WSMessage.Method = CS_SGC_BROADCAST then
    begin
      WSMessage.Result := CS_SGC_BROADCAST;
      DoBroadCast(WSMessage, WSMessage.Channel)
    end
    else if WSMessage.Method = CS_SGC_PROTOCOL then
      aConnection.WriteData(aConnection.Protocol)
    else if WSMessage.Method = CS_SGC_SUBSCRIBE then
    begin
      aConnection.DoSubscribe(guid + '_' + WSMessage.Channel);
      if aConnection.Subscribed(guid + '_' + WSMessage.Channel) then
      begin
        aConnection.LastSubscription := WSMessage.Channel;
        DoNotifySubscription(aConnection);
        WSMessage.Result := CS_SGC_SUBSCRIBE;
        aConnection.WriteData(WSMessage.Write);
      end;
    end
    else if WSMessage.Method = CS_SGC_UNSUBSCRIBE then
    begin
      aConnection.DoUnsubscribe(guid + '_' + WSMessage.Channel);
      if not aConnection.Subscribed(guid + '_' + WSMessage.Channel) then
      begin
        aConnection.LastUnSubscription := WSMessage.Channel;
        DoNotifyUnSubscription(aConnection);
        WSMessage.Result := CS_SGC_UNSUBSCRIBE;
        aConnection.WriteData(WSMessage.Write);
      end;
    end
    else
    begin
      // ... notification
      if WSMessage.id = '' then
      begin
        if Assigned(OnNotification) then
          OnNotification(aConnection, WSMessage.method, WSMessage.params);
      end
      else
      // ... rpc
      begin
//????        AddMethodID(aConnection.guid, WSMessage.ID);
        if DoRPCAuthentication(aConnection, WSMessage.Method) then
        begin
          if Assigned(OnRPC) then
            OnRPC(aConnection, WSMessage.ID, WSMessage.Method, WSMessage.Params);
        end
        else
          RPCError(WSMessage.ID, CS_JSONRPC_METHOD_NOT_FOUND,
            S_JSONRPC_METHOD_NOT_FOUND);
      end;
    end;
  end;
end;

function TErpRpcComboProtocol_Server.DoServerTunnel(
  aConnection: TsgcWSConnection; const aMessage: string): boolean;
begin
  if assigned(OnServerTunnel) then
    Result := OnServerTunnel(aConnection, aMessage)
  else
    Result := false;
end;

{ TErpRpcComboProtocol_Client }

constructor TErpRpcComboProtocol_Client.Create(aOwner: TComponent);
begin
  inherited;

end;

procedure TErpRpcComboProtocol_Client.DoEventMessage(
  aConnection: TsgcWSConnection; const Text: string);
begin
  if Length(Text) > 0 then
    if Text[1] <> '{' then
    begin
      if assigned(Client.OnMessage) then
        Client.OnMessage(aConnection, Text);
      Exit;
    end;

  WSMessage.Read(Text);

  if WSMessage.Method = CS_SGC_EVENT then
  begin
    if Assigned(OnEvent) then
      OnEvent(aConnection, WSMessage.Channel, WSMessage.Text)
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
    if Assigned(OnRPCError) then
    begin
      OnRPCError(aConnection, WSMessage.id, WSMessage.errorcode,
        WSMessage.errormessage, WSMessage.errordata);
      WSMessage.errorcode := 0;
    end;
  end
  else if WSMessage.result <> '' then
  begin
    if Assigned(OnRPCResult) then
      OnRPCResult(aConnection, WSMessage.id, WSMessage.result);
  end
  else if WSMessage.id = '' then
  begin
    if Assigned(FOnNotification) then
      FOnNotification(aConnection, WSMessage.method, WSMessage.params);
  end
  else

//    if assigned(OnRPC) then
//      OnRPC(AConnection, WSMessage.ID, wsMessage.Method, wsMessage.Params);
    case DoMethodAuthorisation(aConnection, WSMessage.Method) of
      csAuthorised:
        begin
          if Assigned(FOnRPC) then
            FOnRPC(aConnection, WSMessage.ID, WSMessage.Method, WSMessage.Params);
        end;
      csNoUser: RPCError(WSMessage.id, CS_NO_USER_LOGGED, S_NO_USER_LOGGED);
      csNoMethod : RPCError(WSMessage.id, CS_METHOD_NOT_FOUND, S_METHOD_NOT_FOUND);
      csNotAuthorised: RPCError(WSMessage.id, CS_NOT_AUTHORISED, S_NOT_AUTHORISED);
      csInternalError: RPCError(WSMessage.id, csInternalError, S_INTERNAL_ERROR);
    end;
end;

function TErpRpcComboProtocol_Client.DoMethodAuthorisation(aConnection: TsgcWSConnection;
  const aMethodName: string): integer;
begin
  WSMessage.errorcode := 0;
  WSMessage.errormessage := '';
  WSMessage.errordata := '';
  if assigned(OnMethodAuthorised) then
     Result := OnMethodAuthorised(AConnection, aMethodName)
  else
    Result := csNoUser;
end;

procedure TErpRpcComboProtocol_Client.RPCError(const aId: String;
  const aCode: Integer; const aMessage: String; const aData: String = '');
begin
  WSMessage.DoEnterWrite;

  WSMessage.ID := aId;
  WSMessage.errorcode := aCode;
  WSMessage.errormessage := aMessage;
  WSMessage.errordata := aData;

//  inherited WriteData(GetMethodId(aId), WSMessage.Write);
  inherited WriteData(WSMessage.Write);

  WSMessage.errorcode := 0;
  WSMessage.errormessage := '';
  WSMessage.errordata := '';

//  RemoveMethodId(aId);
end;

procedure TErpRpcComboProtocol_Client.RPCResult(const aId, aResult: String);
var
  vID: String;
begin
  vID := aId; // fix bug
  WSMessage.DoEnterWrite;

  WSMessage.ID := aId;
  WSMessage.Result := aResult;

//  inherited WriteData(GetMethodId(aId), WSMessage.Write);
  inherited WriteData(WSMessage.Write);
//  RemoveMethodId(vID);
end;

end.

