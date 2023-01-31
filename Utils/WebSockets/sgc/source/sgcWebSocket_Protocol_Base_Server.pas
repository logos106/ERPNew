{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Protocol_Base_Server;

interface

{$I sgcVer.inc}

uses
  Classes, SysUtils,
  sgcWebSocket_Protocol_Base_Message,
  sgcWebSocket_HTTPResponse,
  sgcWebSocket_Classes;

type

  TsgcWSProtocol_JS_Base = class(TsgcWSHTTPResponse_Base)
  protected
    function GetResponse: string; override;
  public
    class function GetFileName: string; override;
  end;


  TsgcWSProtocol_HTML_Base = class(TsgcWSHTTPResponse_Base)
  protected
    function GetResponse: string; override;
  public
    class function GetFileName: string; override;
  end;

  TsgcWSProtocol_Server_Base = Class(TsgcWSProtocol_Server)

  { send messages }
  public
    procedure Broadcast(const aMessage: string; const aChannel: string = ''; const
        Exclude: String = ''; const Include: String = ''); overload; virtual;
    procedure Broadcast(aStream: TMemoryStream; const aChannel: string = ''; const
        Exclude: String = ''; const Include: String = ''); overload; virtual;
    function WriteData(const aGuid, aMessage: string): Boolean; overload; virtual;
    function WriteData(const aGuid: string; aStream: TMemoryStream): Boolean;
        overload; virtual;
  { send messages }
  End;

  TsgcWSProtocol_Subscription_Server_Base = class(TsgcWSProtocol_Server_Base)
  private
    FOnSubscription: TsgcWSSubscriptionEvent;
    FOnUnSubscription: TsgcWSSubscriptionEvent;
  private
    FNotifySubscription: TsgcObjectList;
    FNotifyUnSubscription: TsgcObjectList;
  private
    procedure DoAsyncSubscription;
    procedure DoAsyncUnSubscription;
  private
    function GetNotifySubscription: TsgcObjectList;
    function GetNotifyUnSubscription: TsgcObjectList;
  private
    property NotifySubscription: TsgcObjectList read GetNotifySubscription;
    property NotifyUnSubscription: TsgcObjectList read GetNotifyUnSubscription;
  protected
    procedure DoEventSubscription(aConnection: TsgcWSConnection; const
        Subscription: String); virtual;
    procedure DoEventUnSubscription(aConnection: TsgcWSConnection; const
        Subscription: String); virtual;
  protected
    procedure DoNotifySubscription(aConnection: TsgcWSConnection); virtual;
    procedure DoNotifyUnSubscription(aConnection: TsgcWSConnection); virtual;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  public
     property OnSubscription: TsgcWSSubscriptionEvent read FOnSubscription write
        FOnSubscription;
    property OnUnSubscription: TSgcWSSubscriptionEvent read FOnUnSubscription write
        FOnUnSubscription;
  End;




implementation

uses
  IdSync,
  sgcWebSocket_Types, sgcWebSocket_Const, sgcWebSocket_Helpers,
  sgcWebsocket_Resources;

{$R sgcResources.res}

function TsgcWSProtocol_JS_Base.GetResponse: string;
begin
  result := GetResourceString('SGC_JS_SGCWEBSOCKETS');
end;

class function TsgcWSProtocol_JS_Base.GetFileName: string;
begin
  Result := 'sgcWebSockets.js';
end;

procedure TsgcWSProtocol_Server_Base.Broadcast(const aMessage: string; const
    aChannel: string = ''; const Exclude: String = ''; const Include: String =
    '');
begin
  if Assigned(Server) then
  begin
    if FGuid <> '' then
      Server.Broadcast(aMessage, aChannel, FGuid + '.' + FProtocol, Exclude, Include)
    else
      Server.Broadcast(aMessage, aChannel, FProtocol, Exclude, Include);
  end;
end;

procedure TsgcWSProtocol_Server_Base.Broadcast(aStream: TMemoryStream; const
    aChannel: string = ''; const Exclude: String = ''; const Include: String =
    '');
begin
  if Assigned(Server) then
  begin
    if FGuid <> '' then
      Server.Broadcast(aStream, aChannel, FGuid + '.' + FProtocol, Exclude, Include)
    else
      Server.Broadcast(aStream, aChannel, FProtocol, Exclude, Include)
  end;
end;

function TsgcWSProtocol_Server_Base.WriteData(const aGuid, aMessage: string):
    Boolean;
begin
  result := False;
  if Assigned(Server) then
    result := Server.WriteData(aGuid, aMessage);
end;

function TsgcWSProtocol_Server_Base.WriteData(const aGuid: string; aStream:
    TMemoryStream): Boolean;
begin
  result := False;
  if Assigned(Server) then
    result := Server.WriteData(aGuid, aStream);
end;

class function TsgcWSProtocol_HTML_Base.GetFileName: string;
begin
  Result := 'sgcWebSockets.html';
end;

function TsgcWSProtocol_HTML_Base.GetResponse: string;
begin
  result := GetResourceString('SGC_HTML_SGCWEBSOCKETS');
end;

constructor TsgcWSProtocol_Subscription_Server_Base.Create(aOwner: TComponent);
begin
  inherited;
  NotifyEvents := neNoSync;
end;

destructor TsgcWSProtocol_Subscription_Server_Base.Destroy;
begin
  FreeAndNil(FNotifySubscription);
  FreeAndNil(FNotifyUnSubscription);
  inherited;
end;

procedure TsgcWSProtocol_Subscription_Server_Base.DoAsyncSubscription;
var
  i: Integer;
begin
  for i := NotifySubscription.Count - 1 Downto 0 do
  begin
    DoEventSubscription(TsgcNotifyObject(NotifySubscription.Items[i]).Connection,
      TsgcNotifyObject(NotifySubscription.Items[i]).Text);
    NotifySubscription.Delete(i);
  end;
end;

procedure TsgcWSProtocol_Subscription_Server_Base.DoAsyncUnSubscription;
var
  i: Integer;
begin
  for i := NotifyUnSubscription.Count - 1 Downto 0 do
  begin
    DoEventUnSubscription(TsgcNotifyObject(NotifyUnSubscription.Items[i]).Connection,
      TsgcNotifyObject(NotifyUnSubscription.Items[i]).Text);
    NotifyUnSubscription.Delete(i);
  end;
end;

procedure TsgcWSProtocol_Subscription_Server_Base.DoEventSubscription(
    aConnection: TsgcWSConnection; const Subscription: String);
begin
  if Assigned(FOnSubscription) then
    FOnSubscription(aConnection, Subscription);
end;

procedure TsgcWSProtocol_Subscription_Server_Base.DoEventUnSubscription(
    aConnection: TsgcWSConnection; const Subscription: String);
begin
  if Assigned(FOnUnSubscription) then
    FOnUnSubscription(aConnection, Subscription);
end;

procedure TsgcWSProtocol_Subscription_Server_Base.DoNotifySubscription(
    aConnection: TsgcWSConnection);
begin
  if Assigned(aConnection) then
  begin
    case NotifyEvents of
      neNoSync:
        DoEventSubscription(aConnection, aConnection.LastSubscription);
      neAsynchronous:
        begin
          NotifySubscription.AddNotifyObject(aConnection, aConnection.LastSubscription);
          TIdNotify.NotifyMethod(DoAsyncSubscription);
        end;
      neSynchronous:
        begin
          NotifySubscription.AddNotifyObject(aConnection, aConnection.LastSubscription);
          TIdSync.SynchronizeMethod(DoAsyncSubscription);
        end;
    end;
  end;
end;

procedure TsgcWSProtocol_Subscription_Server_Base.DoNotifyUnSubscription(
    aConnection: TsgcWSConnection);
begin
  if Assigned(aConnection) then
  begin
    case NotifyEvents of
      neNoSync:
        DoEventUnSubscription(aConnection, aConnection.LastUnSubscription);
      neAsynchronous:
        begin
          NotifyUnSubscription.AddNotifyObject(aConnection, aConnection.LastUnSubscription);
          TIdNotify.NotifyMethod(DoAsyncUnSubscription);
        end;
      neSynchronous:
        begin
          NotifyUnSubscription.AddNotifyObject(aConnection, aConnection.LastUnSubscription);
          TIdSync.SynchronizeMethod(DoAsyncUnSubscription);
        end;
    end;
  end;
end;

function TsgcWSProtocol_Subscription_Server_Base.GetNotifySubscription:
    TsgcObjectList;
begin
  if not Assigned(FNotifySubscription) then
    FNotifySubscription := TsgcObjectList.Create(True);
  Result := FNotifySubscription;
end;

function TsgcWSProtocol_Subscription_Server_Base.GetNotifyUnSubscription:
    TsgcObjectList;
begin
  if not Assigned(FNotifyUnSubscription) then
    FNotifyUnSubscription := TsgcObjectList.Create(True);
  Result := FNotifyUnSubscription;
end;

initialization
  TsgcWSHTTPResponse.RegisterfileName(TsgcWSProtocol_JS_Base);
  TsgcWSHTTPResponse.RegisterfileName(TsgcWSProtocol_HTML_Base);

end.
