{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Protocol_Base_Client;

interface

{$I sgcVer.inc}

uses
  Classes, SysUtils,
  sgcWebSocket_Classes, sgcWebSocket_Protocol_Base_Server;

type


  TsgcWSProtocol_Client_Base = Class(TsgcWSProtocol_Client)
  { send message }
  public
    procedure WriteData(const aText: String); virtual;
  { send message }
  End;


  TsgcWSProtocol_Subscription_Client_Base = class(TsgcWSProtocol_Client_Base)
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
    procedure DoNotifySubscription(aConnection: TsgcWSConnection); virtual;
    procedure DoNotifyUnSubscription(aConnection: TsgcWSConnection); virtual;
  public
    destructor Destroy; override;
  public
    procedure Subscribe(const aChannel: String; const aGuid: String = ''); virtual;
        abstract;
    procedure UnSubscribe(const aChannel: String; const aGuid: String = '');
        virtual; abstract;
  public
     property OnSubscription: TsgcWSSubscriptionEvent read FOnSubscription write
        FOnSubscription;
    property OnUnSubscription: TSgcWSSubscriptionEvent read FOnUnSubscription write
        FOnUnSubscription;
  End;

implementation

uses
  IdSync;

procedure TsgcWSProtocol_Client_Base.WriteData(const aText: String);
begin
  if Assigned(Client) then
    Client.WriteData(aText);
end;

destructor TsgcWSProtocol_Subscription_Client_Base.Destroy;
begin
  FreeAndNil(FNotifySubscription);
  FreeAndNil(FNotifyUnSubscription);
  inherited;
end;

procedure TsgcWSProtocol_Subscription_Client_Base.DoAsyncSubscription;
var
  i: Integer;
begin
  for i := NotifySubscription.Count - 1 Downto 0 do
  begin
    if Assigned(OnSubscription) then
      OnSubscription(TsgcNotifyObject(NotifySubscription.Items[i]).Connection, TsgcNotifyObject(NotifySubscription.Items[i]).Text);
    NotifySubscription.Delete(i);
  end;
end;

procedure TsgcWSProtocol_Subscription_Client_Base.DoAsyncUnSubscription;
var
  i: Integer;
begin
  for i := NotifyUnSubscription.Count - 1 Downto 0 do
  begin
    if Assigned(OnUnSubscription) then
      OnUnSubscription(TsgcNotifyObject(NotifyUnSubscription.Items[i]).Connection, TsgcNotifyObject(NotifyUnSubscription.Items[i]).Text);
    NotifyUnSubscription.Delete(i);
  end;
end;

procedure TsgcWSProtocol_Subscription_Client_Base.DoNotifySubscription(
    aConnection: TsgcWSConnection);
begin
  NotifySubscription.AddNotifyObject(aConnection, aConnection.LastSubscription);
  TIdNotify.NotifyMethod(DoAsyncSubscription);
end;

procedure TsgcWSProtocol_Subscription_Client_Base.DoNotifyUnSubscription(
    aConnection: TsgcWSConnection);
begin
  NotifyUnSubscription.AddNotifyObject(aConnection, aConnection.LastUnSubscription);
  TIdNotify.NotifyMethod(DoAsyncUnSubscription);
end;

function TsgcWSProtocol_Subscription_Client_Base.GetNotifySubscription:
    TsgcObjectList;
begin
  if not Assigned(FNotifySubscription) then
    FNotifySubscription := TsgcObjectList.Create(True);
  Result := FNotifySubscription;
end;

function TsgcWSProtocol_Subscription_Client_Base.GetNotifyUnSubscription:
    TsgcObjectList;
begin
  if not Assigned(FNotifyUnSubscription) then
    FNotifyUnSubscription := TsgcObjectList.Create(True);
  Result := FNotifyUnSubscription;
end;


end.
