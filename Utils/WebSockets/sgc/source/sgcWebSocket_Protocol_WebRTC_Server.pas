{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Protocol_WebRTC_Server;

interface

uses
  Classes, SysUtils,
  sgcJSON, sgcWebSocket_Protocol_WebRTC_Message,
  sgcWebSocket_Classes, sgcWebSocket_Protocol_Base_Server, sgcWebSocket_HTTPResponse;

type


  TsgcWSProtocol_WebRTC_Server = class(TsgcWSProtocol_Subscription_Server_Base)
  { WSMessageWebRTC }
  private
    FWSMessageWebRTC: TsgcWSMessageWebRTC;
    function GetWSMessageWebRTC: TsgcWSMessageWebRTC;
  protected
    property WSMessageWebRTC: TsgcWSMessageWebRTC read GetWSMessageWebRTC write
        FWSMessageWebRTC;
  { WSMessageWebRTC }

  { from TsgcWSComponent }
  protected
    procedure DoEventMessage(aConnection: TsgcWSConnection; const Text: string);
        override;
  { from TsgcWSComponent }

  { webrtc subscriptions }
  private
    FWebRTCSubscriptions: TStringList;
  protected
    procedure WebRTCSubscription_Add(const aSubscription: String);
    procedure WebRTCSubscription_Del(const aSubscription: String);
    function WebRTCSubscription_Count(const aSubscription: String): Integer;
  protected
    function GetWebRTCSubscriptions: TStringList;
  public
    property WebRTCSubscriptions: TStringList read GetWebRTCSubscriptions write
        FWebRTCSubscriptions;
  { webrtc subscriptions }

  protected
    procedure DoBroadCast(aMessage: TsgcWSMessageWebRTC; const aChannel: String;
        const Exclude: String = ''); virtual;
    procedure BroadcastWebRTC(const aMessage: string; const aChannel: string = '');
        virtual;    
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;


 { from TsgcWSComponent_Server }
  public
    procedure Broadcast(const aMessage: string; const aChannel: string = ''; const
        Exclude: String = ''; const Include: String = ''); override;
    function WriteData(const aGuid, aMessage: string): Boolean; override;
 { from TsgcWSComponent_Server }
  end;


  TsgcWSProtocol_JS_WebRTC = class(TsgcWSHTTPResponse_Base)
  protected
    function GetResponse: string; override;
  public
    class function GetFileName: string; override;
  end;


  TsgcWSProtocol_HTML_WebRTC = class(TsgcWSHTTPResponse_Base)
  protected
    function GetResponse: string; override;
  public
    class function GetFileName: string; override;
  end;

implementation

uses
  sgcWebSocket_Const, sgcWebSocket_Helpers, sgcWebsocket_Resources,
  sgcWebSocket_Server;

constructor TsgcWSProtocol_WebRTC_Server.Create(aOwner: TComponent);
begin
  inherited;
  FProtocol := CS_PROTOCOL_WEBRTC;
end;

destructor TsgcWSProtocol_WebRTC_Server.Destroy;
begin
  FreeAndNil(FWebRTCSubscriptions);
  inherited;
end;

procedure TsgcWSProtocol_WebRTC_Server.Broadcast(const aMessage: string; const
    aChannel: string = ''; const Exclude: String = ''; const Include: String =
    '');
begin
  WSMessageWebRTC.DoEnterWrite;
  Try
    WSMessageWebRTC.Text := aMessage;
    WSMessageWebRTC.Method := CS_SGC_BROADCAST;
    WSMessageWebRTC.Channel := aChannel;
    WSMessageWebRTC.Guid := Guid;
    WSMessageWebRTC.WebRTC := '';
    DoBroadCast(WSMessageWebRTC, aChannel, Exclude);
  Finally
    WSMessageWebRTC.DoLeaveWrite;
  End;
end;


procedure TsgcWSProtocol_WebRTC_Server.BroadcastWebRTC(const aMessage: string;
    const aChannel: string = '');
begin
  WSMessageWebRTC.DoEnterWrite;
  Try
    WSMessageWebRTC.Text := '';
    WSMessageWebRTC.Method := CS_SGC_WEBRTC;
    WSMessageWebRTC.Channel := aChannel;
    WSMessageWebRTC.Guid := Guid;
    WSMessageWebRTC.WebRTC := aMessage;
    DoBroadCast(WSMessageWebRTC, aChannel, Guid);
  Finally
    WSMessageWebRTC.DoLeaveWrite;
  End;
end;

procedure TsgcWSProtocol_WebRTC_Server.DoBroadCast(aMessage:
    TsgcWSMessageWebRTC; const aChannel: String; const Exclude: String = '');
var
  vChannel: string;
begin
  if aChannel <> '' then
  begin
    vChannel := guid + '_' + aChannel;
    inherited Broadcast(aMessage.Write, vChannel, Exclude)
  end
  else
    inherited Broadcast(aMessage.Write, '', Exclude);
end;

procedure TsgcWSProtocol_WebRTC_Server.DoEventMessage(aConnection:
    TsgcWSConnection; const Text: string);
begin
  WSMessageWebRTC.Read(Text);
  WSMessageWebRTC.params := '';

  if (WSMessageWebRTC.Guid = Guid) or (WSMessageWebRTC.Guid = '') then
  begin
    if WSMessageWebRTC.Method = CS_SGC_BROADCAST then
    begin
      WSMessageWebRTC.result := CS_SGC_BROADCAST;
      Broadcast(WSMessageWebRTC.Text, WSMessageWebRTC.Channel)
    end
    else if WSMessageWebRTC.Method = CS_SGC_PROTOCOL then
      aConnection.WriteData(aConnection.Protocol)
    else if WSMessageWebRTC.Method = CS_SGC_SUBSCRIBE then
    begin
      aConnection.DoSubscribe(Guid + '_' + WSMessageWebRTC.Channel);
      if aConnection.Subscribed(Guid + '_' + WSMessageWebRTC.Channel) then
      begin
        WebRTCSubscription_Add(Guid + '_' + WSMessageWebRTC.Channel);
        WSMessageWebRTC.Guid := Guid;
        WSMessageWebRTC.Text := IntToStr(WebRTCSubscription_Count(Guid + '_' + WSMessageWebRTC.Channel));
        aConnection.LastSubscription := WSMessageWebRTC.Channel;
        DoNotifySubscription(aConnection);
        aConnection.WriteData(WSMessageWebRTC.Write);
      end;
    end
    else if WSMessageWebRTC.Method = CS_SGC_UNSUBSCRIBE then
    begin
      aConnection.DoUnsubscribe(Guid + '_' + WSMessageWebRTC.Channel);
      if not aConnection.Subscribed(Guid + '_' + WSMessageWebRTC.Channel) then
      begin
        WebRTCSubscription_Del(Guid + '_' + WSMessageWebRTC.Channel);
        WSMessageWebRTC.Guid := Guid;
        aConnection.LastUnSubscription := WSMessageWebRTC.Channel;
        DoNotifyUnSubscription(aConnection);
        aConnection.WriteData(WSMessageWebRTC.Write);
      end;
    end
    else if WSMessageWebRTC.Method = CS_SGC_WEBRTC then
      BroadcastWebRTC(WSMessageWebRTC.WebRTC, WSMessageWebRTC.Channel)
    else
    begin
      aConnection.MsgReceived := WSMessageWebRTC.Text;
      inherited;
      aConnection.MsgReceived := Text;
    end;
  end;
end;

function TsgcWSProtocol_WebRTC_Server.GetWebRTCSubscriptions: TStringList;
begin
  if not Assigned(FWebRTCSubscriptions) then
    FWebRTCSubscriptions := TStringList.Create;
  Result := FWebRTCSubscriptions;
end;

function TsgcWSProtocol_WebRTC_Server.GetWSMessageWebRTC: TsgcWSMessageWebRTC;
begin
  if not Assigned(FWSMessageWebRTC) then
    FWSMessageWebRTC := TsgcWSMessageWebRTC.Create(self);
  Result := FWSMessageWebRTC;
end;

procedure TsgcWSProtocol_WebRTC_Server.WebRTCSubscription_Add(const
    aSubscription: String);
var
  i: Integer;
begin
  i := WebRTCSubscriptions.IndexOfName(aSubscription);

  if i = -1 then
    WebRTCSubscriptions.Add(aSubscription + '=1')
  else
    WebRTCSubscriptions.Values[aSubscription] := IntToStr(StrToInt(WebRTCSubscriptions.Values[aSubscription]) + 1);
end;

function TsgcWSProtocol_WebRTC_Server.WebRTCSubscription_Count(const
    aSubscription: String): Integer;
var
  i: Integer;
begin
  Result := 0;

  i := WebRTCSubscriptions.IndexOfName(aSubscription);

  if i <> -1 then
    Result := StrToInt(WebRTCSubscriptions.Values[aSubscription]);
end;

procedure TsgcWSProtocol_WebRTC_Server.WebRTCSubscription_Del(const
    aSubscription: String);
var
  i: Integer;
begin
  i := WebRTCSubscriptions.IndexOfName(aSubscription);

  if i <> -1 then
  begin
    if StrToInt(WebRTCSubscriptions.Values[aSubscription]) < 2 then
      WebRTCSubscriptions.Delete(i)
    else
      WebRTCSubscriptions.Values[aSubscription] := IntToStr(StrToInt(WebRTCSubscriptions.Values[aSubscription]) - 1);
  end;
end;

function TsgcWSProtocol_WebRTC_Server.WriteData(const aGuid, aMessage: string):
    Boolean;
begin
  WSMessageWebRTC.DoEnterWrite;
  Try
    WSMessageWebRTC.Text := aMessage;
    WSMessageWebRTC.Method := '';
    WSMessageWebRTC.Channel := '';
    Result := inherited WriteData(aGuid, WSMessageWebRTC.Write);
  Finally
    WSMessageWebRTC.DoLeaveWrite;
  End;
end;

function TsgcWSProtocol_JS_WebRTC.GetResponse: string;
begin
  result := GetResourceString('SGC_JS_WEBRTC_ESEGECE_COM');
end;

class function TsgcWSProtocol_JS_WebRTC.GetFileName: string;
begin
  Result := 'webrtc.esegece.com.js';
end;

class function TsgcWSProtocol_HTML_WebRTC.GetFileName: string;
begin
  Result := 'webrtc.esegece.com.html';
end;

function TsgcWSProtocol_HTML_WebRTC.GetResponse: string;
begin
  result := GetResourceString('SGC_HTML_WEBRTC_ESEGECE_COM');
end;


initialization
  RegisterClass(TsgcWSProtocol_WebRTC_Server);
  TsgcWSHTTPResponse.RegisterfileName(TsgcWSProtocol_JS_WebRTC);
  TsgcWSHTTPResponse.RegisterfileName(TsgcWSProtocol_HTML_WebRTC);

end.
