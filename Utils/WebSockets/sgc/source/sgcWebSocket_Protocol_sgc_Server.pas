{ ***************************************************************************
  sgcWebSocket component

  written by eSeGeCe
  copyright © 2013
  Email : info@esegece.com
  Web : http://www.esegece.com
  *************************************************************************** }

unit sgcWebSocket_Protocol_sgc_Server;

interface

{$I sgcVer.inc}

uses
  Classes, SysUtils,
  sgcJSON, sgcWebSocket_Protocol_sgc_Message,
  sgcWebSocket_Classes, sgcWebSocket_Protocol_Base_Server,
  sgcWebSocket_HTTPResponse;

type

  TsgcWSRPCEvent = procedure(Connection: TsgcWSConnection;
    const ID, Method, Params: string) of object;
  TsgcWSNotificationEvent = procedure(Connection: TsgcWSConnection; const Method,
      Params: string) of object;
  TsgcWSRPCAuthenticationEvent = procedure(Connection: TsgcWSConnection;
    const Method, User, Password: string; var Authenticated: Boolean)
    of object;

  TsgcWSAuthentication_Methods = class(TPersistent)
  private
    FMethods: TStringList;
    FEnabled: Boolean;
    procedure SetMethods(const Value: TStringList);
  public
    constructor Create; virtual;
    destructor Destroy; override;
  published
    property Methods: TStringList read FMethods write SetMethods;
    property Enabled: Boolean read FEnabled write FEnabled;
  end;

  TsgcWSProtocol_sgc_Server = class(TsgcWSProtocol_Subscription_Server_Base)
    { wsmessage }
  private
    FWSMessage: TsgcWSMessage;
    function GetWSMessage: TsgcWSMessage;
  protected
    property WSMessage: TsgcWSMessage read GetWSMessage write FWSMessage;
    { wsmessage }

    { from TsgcWSComponent }
  protected
    procedure DoEventMessage(aConnection: TsgcWSConnection; const Text: string);
        override;
    { from TsgcWSComponent }

    { broadcast }
  protected
    procedure DoBroadCast(aMessage: TsgcWSMessage; const aChannel: string = '';
        const Exclude: String = ''; const Include: String = ''); overload; virtual;
    procedure DoBroadCast(aStream: TMemoryStream; const aChannel: string = '';
      const Exclude: String = ''; const Include: String = ''); overload; virtual;
  public
    procedure Broadcast(const aMessage: string; const aChannel: string = ''; const
        Exclude: String = ''; const Include: String = ''); overload; override;
    procedure Broadcast(aStream: TMemoryStream; const aChannel: string = ''; const
        Exclude: String = ''; const Include: String = ''); overload; override;
    { broadcast }

    { constructor }
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    { constructor }

    { procedure }
  public
    procedure Publish(const aMessage, aChannel: String; const aExclude: String =
        ''; const aInclude: String = '');
    procedure RPCResult(const aId, aResult: String);
    procedure RPCError(const aId: String; const aCode: Integer;
      const aMessage: String; const aData: String = '');
    { procedure }

    { method id }
  private
    FMethodId: TStringList;
  protected
    function AddMethodID(const aGuid, aId: string): Boolean;
    function GetMethodId(const aId: string): String; overload;
    function GetMethodId: TStringList; overload;
    function RemoveMethodId(const aId: string): Boolean;
    { method id }

    { RPCAuthentication }
  private
    FRPCAuthentication: TsgcWSAuthentication_Methods;
  protected
    function DoRPCAuthentication(aConnection: TsgcWSConnection;
      const aMethod: string): Boolean;
  protected
    procedure SetRPCAuthentication(const Value: TsgcWSAuthentication_Methods);
  public
    property RPCAuthentication
      : TsgcWSAuthentication_Methods read FRPCAuthentication write
      SetRPCAuthentication;
    { RPCAuthentication }

    { events }
  private
    FOnNotification: TsgcWSNotificationEvent;
    FOnRPC: TsgcWSRPCEvent;
    FOnRPCAuthentication: TsgcWSRPCAuthenticationEvent;
  public
    property OnNotification: TsgcWSNotificationEvent read FOnNotification write
        FOnNotification;
    property OnRPC: TsgcWSRPCEvent read FOnRPC write FOnRPC;
    property OnRPCAuthentication
      : TsgcWSRPCAuthenticationEvent read FOnRPCAuthentication write
      FOnRPCAuthentication;
    { events }
  end;

  TsgcWSProtocol_JS_sgc = class(TsgcWSHTTPResponse_Base)
  protected
    function GetResponse: string; override;
  public
    class function GetFileName: string; override;
  end;

  TsgcWSProtocol_HTML_sgc = class(TsgcWSHTTPResponse_Base)
  protected
    function GetResponse: string; override;
  public
    class function GetFileName: string; override;
  end;

implementation

uses
  sgcWebSocket_Const, sgcWebSocket_Helpers, sgcWebsocket_Resources,
  sgcWebSocket_CS, sgcWebSocket_Server;

constructor TsgcWSProtocol_sgc_Server.Create(aOwner: TComponent);
begin
  inherited;
  FProtocol := CS_PROTOCOL_SGC;
  FRPCAuthentication := TsgcWSAuthentication_Methods.Create;
end;

destructor TsgcWSProtocol_sgc_Server.Destroy;
begin
  FreeAndNil(FMethodId);
  FreeAndNil(FRPCAuthentication);
  inherited;
end;

function TsgcWSProtocol_sgc_Server.AddMethodID(const aGuid, aId: string)
  : Boolean;
begin
  DoEnterCS;
  Try
    Result := False;
    if GetMethodId.IndexOfName(aId) = -1 then
      Result := GetMethodId.Add(aId + '=' + aGuid) <> -1;
  Finally
    DoLeaveCS;
  End;
end;

procedure TsgcWSProtocol_sgc_Server.Broadcast(const aMessage: string; const
    aChannel: string = ''; const Exclude: String = ''; const Include: String =
    '');
begin
  WSMessage.DoEnterWrite;
  Try
    WSMessage.method := CS_SGC_MESSAGE;
    WSMessage.result := CS_SGC_MESSAGE;
    WSMessage.Text := aMessage;
    WSMessage.Channel := aChannel;
    DoBroadCast(WSMessage, aChannel, Exclude, Include);
  Finally
    WSMessage.DoLeaveWrite;
  End;
end;

procedure TsgcWSProtocol_sgc_Server.Broadcast(aStream: TMemoryStream; const
    aChannel: string = ''; const Exclude: String = ''; const Include: String =
    '');
begin
  DoBroadCast(aStream, aChannel, Exclude, Include);
end;

procedure TsgcWSProtocol_sgc_Server.DoBroadCast(aMessage: TsgcWSMessage; const
    aChannel: string = ''; const Exclude: String = ''; const Include: String =
    '');
var
  vChannel: string;
begin
  if aChannel <> '' then
  begin
    vChannel := guid + '_' + aChannel;
    inherited Broadcast(aMessage.Write, vChannel, Exclude, Include)
  end
  else
    inherited Broadcast(aMessage.Write, Exclude, Include);
end;

procedure TsgcWSProtocol_sgc_Server.DoBroadCast(aStream: TMemoryStream;
  const aChannel: string = ''; const Exclude: String = '';
  const Include: String = '');
var
  vChannel: string;
begin
  if aChannel <> '' then
  begin
    vChannel := guid + '_' + aChannel;
    inherited Broadcast(aStream, vChannel, Exclude, Include)
  end
  else
    inherited Broadcast(aStream, Exclude, Include);
end;

procedure TsgcWSProtocol_sgc_Server.DoEventMessage(aConnection:
    TsgcWSConnection; const Text: string);
begin
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
        if Assigned(FOnNotification) then
          FOnNotification(aConnection, WSMessage.method, WSMessage.params);
      end
      else
      // ... rpc
      begin
        AddMethodID(aConnection.guid, WSMessage.ID);
        if DoRPCAuthentication(aConnection, WSMessage.Method) then
        begin
          if Assigned(FOnRPC) then
            FOnRPC(aConnection, WSMessage.ID, WSMessage.Method, WSMessage.Params);
        end
        else
          RPCError(WSMessage.ID, CS_JSONRPC_METHOD_NOT_FOUND,
            S_JSONRPC_METHOD_NOT_FOUND);
      end;
    end;
  end;
end;

function TsgcWSProtocol_sgc_Server.DoRPCAuthentication
  (aConnection: TsgcWSConnection; const aMethod: string): Boolean;
begin
  Result := False;

  if RPCAuthentication.Enabled then
  begin
    if RPCAuthentication.Methods.IndexOf(aMethod) <> -1 then
      Result := True
    else if RPCAuthentication.Methods.IndexOf
      (aMethod + '=' + TsgcWSConnectionServer(aConnection)
        .Authentication.User) <> -1 then
      Result := True;
  end
  else
    Result := True;

  if not result then
    if Assigned(FOnRPCAuthentication) then
      FOnRPCAuthentication(aConnection, aMethod,
        TsgcWSConnectionServer(aConnection).Authentication.User,
        TsgcWSConnectionServer(aConnection).Authentication.Password, Result);
end;

function TsgcWSProtocol_sgc_Server.GetMethodId(const aId: string): String;
begin
  DoEnterCS;
  Try
    {$IFDEF LAZARUS}
    if not Assigned(FMethodId) then
      FMethodId := TStringList.Create;
    Result := FMethodId.Values[aId];
    {$ELSE}
    Result := GetMethodId.Values[aId];
    {$ENDIF}
  Finally
    DoLeaveCS;
  End;
end;

function TsgcWSProtocol_sgc_Server.GetMethodId: TStringList;
begin
  if not Assigned(FMethodId) then
    FMethodId := TStringList.Create;
  Result := FMethodId;
end;

function TsgcWSProtocol_sgc_Server.GetWSMessage: TsgcWSMessage;
begin
  if not Assigned(FWSMessage) then
    FWSMessage := TsgcWSMessage.Create(self);
  Result := FWSMessage;
end;

procedure TsgcWSProtocol_sgc_Server.Publish(const aMessage, aChannel: String;
    const aExclude: String = ''; const aInclude: String = '');
begin
  WSMessage.DoEnterWrite;
  Try
    WSMessage.method := CS_SGC_EVENT;
    WSMessage.result := CS_SGC_EVENT;
    WSMessage.Text := aMessage;
    WSMessage.Channel := aChannel;
    DoBroadCast(WSMessage, aChannel, aExclude, aInclude);
  Finally
    WSMessage.DoLeaveWrite;
  End;
end;

function TsgcWSProtocol_sgc_Server.RemoveMethodId(const aId: string): Boolean;
var
  i: Integer;
begin
  Result := False;

  DoEnterCS;
  Try
    i := GetMethodId.IndexOfName(aId);
    if i <> -1 then
    begin
      GetMethodId.Delete(i);
      Result := True;
    end;
  Finally
    DoLeaveCS;
  End;
end;

procedure TsgcWSProtocol_sgc_Server.RPCError(const aId: String;
  const aCode: Integer; const aMessage: String; const aData: String = '');
begin
  WSMessage.DoEnterWrite;

  WSMessage.ID := aId;
  WSMessage.errorcode := aCode;
  WSMessage.errormessage := aMessage;
  WSMessage.errordata := aData;

  inherited WriteData(GetMethodId(aId), WSMessage.Write);

  RemoveMethodId(aId);
end;

procedure TsgcWSProtocol_sgc_Server.RPCResult(const aId, aResult: String);
var
  vID: String;
begin
  vID := aId; // fix bug
  WSMessage.DoEnterWrite;

  WSMessage.ID := aId;
  WSMessage.Result := aResult;

  inherited WriteData(GetMethodId(aId), WSMessage.Write);

  RemoveMethodId(vID);
end;

procedure TsgcWSProtocol_sgc_Server.SetRPCAuthentication
  (const Value: TsgcWSAuthentication_Methods);
begin
  FRPCAuthentication := Value;
end;

function TsgcWSProtocol_JS_sgc.GetResponse: string;
begin
  Result := GetResourceString('SGC_JS_ESEGECE_COM');
end;

class function TsgcWSProtocol_JS_sgc.GetFileName: string;
begin
  Result := 'esegece.com.js';
end;

class function TsgcWSProtocol_HTML_sgc.GetFileName: string;
begin
  Result := 'esegece.com.html';
end;

function TsgcWSProtocol_HTML_sgc.GetResponse: string;
begin
  Result := GetResourceString('SGC_HTML_ESEGECE_COM');
end;

constructor TsgcWSAuthentication_Methods.Create;
begin
  inherited;
  FMethods := TStringList.Create;
end;

destructor TsgcWSAuthentication_Methods.Destroy;
begin
  FreeAndNil(FMethods);
  inherited;
end;

procedure TsgcWSAuthentication_Methods.SetMethods(const Value: TStringList);
begin
  FMethods.Assign(Value);
end;

initialization

RegisterClass(TsgcWSProtocol_sgc_Server);
TsgcWSHTTPResponse.RegisterfileName(TsgcWSProtocol_JS_sgc);
TsgcWSHTTPResponse.RegisterfileName(TsgcWSProtocol_HTML_sgc);

end.
