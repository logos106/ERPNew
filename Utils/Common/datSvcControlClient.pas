unit datSvcControlClient;

interface

uses
  SysUtils, Classes, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, ServiceGuiCommon, ActiveX, ExtCtrls, AppVarsObj,
  IdAntiFreezeBase, IdAntiFreeze;

type
  TSvcControlClient = class(TDataModule)
    TCPClient: TIdTCPClient;
    Timer: TTimer;
    IdAntiFreeze1: TIdAntiFreeze;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure TCPClientConnected(Sender: TObject);
    procedure TCPClientDisconnected(Sender: TObject);
  private
    Queue: TRemoteMessageQueue;
    fOnReceiveMessage: TOnAddMessageEvent;
    fAppVarsCreated: boolean;
    fOnConnect,
    fOnDisconnect: TNotifyEvent;
    fAutoReconnect: boolean;
    fUserDisconnect: boolean;
    fLastReconnectTime: TDateTime;
    procedure DoOnAddMessage(msg: TRemoteMessageItem);
    procedure SetServerPort(const Value: integer);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    function ReadFromServer(var inStr: string): boolean;
    function GetRemotePropertyStr(PropName: string): string;
    procedure SetRemotePropertyStr(PropName: string; const Value: string);
    procedure SendMessage(msg: TRemoteMessageItem);
    function GetServerIP: string;
    function GetServerPort: integer;
    procedure SetServerIP(const Value: string);
    procedure CheckForMessages;
  public
    property ServerPort: integer read GetServerPort write SetServerPort;
    property ServerIP: string read GetServerIP write SetServerIP;
    property Active: boolean read GetActive write SetActive;
    property AutoReconnect: boolean read fAutoReconnect write fAutoReconnect;
    procedure Connect;
    procedure Disconnect;
    property RemotePropertyStr[PropName: string]: string read GetRemotePropertyStr write SetRemotePropertyStr;
    property OnConnect: TNotifyEvent read fOnConnect write fOnConnect;
    property OnDisconnect: TNotifyEvent read fOnDisconnect write fOnDisconnect;
    property OnReceiveMessage: TOnAddMessageEvent read fOnReceiveMessage write fOnReceiveMessage;
  end;


var
  SvcControlClient: TSvcControlClient;

implementation

uses
  Forms, IdStack;

{$R *.dfm}

const
  TimeoutSeconds = 5;
  SecondsPerDay = 24*60*60;
  ReconnectRetrySeconds = 5;

function ElapsedSeconds(aStartTime: TDateTime): double;
begin
  result:= (now - aStartTime) * SecondsPerDay;
end;

function TimedOut(aStartTime: TDateTime): boolean;
begin
  result:= ElapsedSeconds(aStartTime) >= TimeoutSeconds;
end;

{ TSvcControlClient }

procedure TSvcControlClient.DataModuleCreate(Sender: TObject);
begin
  fAutoReconnect:= true;
  fUserDisconnect:= true;
  Queue:= TRemoteMessageQueue.Create;
  Queue.OnAddMessage:= self.DoOnAddMessage;
  fAppVarsCreated:= false;
  if not Assigned(AppVars) then begin
    AppVars:= TAppVars.Create;
    AppVars.SaveOnChange:= true;
    AppVars.EncryptFile:= true;
    AppVars.LoadFromFile();
    fAppVarsCreated:= true;
  end;
  { set defaults }
//  if GStack.LocalAddresses.Count > 0 then
//    AppVars.SetDefault('ServerIP',GStack.LocalAddresses[0])
//  else
//    AppVars.SetDefault('ServerIP','127.0.0.1');
  { each client needs to set its port }
//  AppVars.SetDefault('ServerPort','9010');
  Timer.Enabled:= true;
end;

procedure TSvcControlClient.DataModuleDestroy(Sender: TObject);
begin
  Active:= false;
  Queue.Free;
  if fAppVarsCreated then begin
    AppVars.Free;
    AppVars:= nil;
  end;
end;

procedure TSvcControlClient.DoOnAddMessage(msg: TRemoteMessageItem);
begin
  if (msg.Direction = mdOut) then begin
    SendMessage(msg);
  end
  else begin
    { incoming message }
    if msg.RequesterId = '' then begin
      { this is not a responce message }
      if Assigned(fOnReceiveMessage) then begin
        { pass message to handler }
        fOnReceiveMessage(msg);
      end
      else begin
        { not handled so flag for deletion }
        msg.Status:= msDelete;
      end;
    end;
  end;
  { delete any old messages from queue }
  Queue.RemoveDeleted;
end;

function TSvcControlClient.GetActive: boolean;
begin
  result:= TCPClient.Connected;
end;

function TSvcControlClient.GetRemotePropertyStr(PropName: string): string;
var
  msg: TRemoteMessageItem;
  startTime: TDateTime;
begin
  result:= '';
  msg:= TRemoteMessageItem.Create;
  try
    msg.Direction:= mdOut;
    msg.Values['command']:= 'getProperty';
    msg.Values['propName']:= PropName;
    Queue.AddMessage(msg);
    startTime:= now;
    while (not Assigned(msg.Responce)) and (not TimedOut(startTime)) do  begin
      CheckForMessages;
      Application.ProcessMessages;
    end;

    if Assigned(msg.Responce) then begin
      result:= msg.Responce.Values['propValue'];
      msg.Responce.Status:= msDelete;
    end
    else begin
      raise Exception.Create('Failed getting remote property');
    end;
  finally
    msg.Status:= msDelete;
  end;
end;

function TSvcControlClient.ReadFromServer(var inStr: string): boolean;
var
  StartTagFound, EndTagFound: boolean;
  s: string;
begin
  result:= true;
  inStr:= '';
  StartTagFound:= false;
  EndTagFound:= false;

  try
    s:= TCPClient.ReadLn(#10,100);
    if TCPClient.ReadLnTimedOut then begin
      inStr:= s;
      exit;
    end;
    if (not StartTagFound) and (Pos('<'+XMLMsgNodeRoot,s) > 0) then
      StartTagFound:= true;
//    while (s <> '') or ((s = '') and (StartTagFound and (not EndTagFound))) do begin
    while not (StartTagFound and EndTagFound) do begin
      inStr:= inStr + s;
      if TCPClient.ReadLnTimedOut then
        break;
      s:= TCPClient.ReadLn(#10,100);
      if (not StartTagFound) and (Pos('<'+XMLMsgNodeRoot,s) > 0) then
        StartTagFound:= true;
      if (not EndTagFound) and (Pos('</'+XMLMsgNodeRoot,s) > 0) then
        EndTagFound:= true;
    end;
  except
    result:= false;
  end;  
end;

procedure TSvcControlClient.SendMessage(msg: TRemoteMessageItem);
begin
  if Active then begin
    try
      TCPClient.WriteLn(msg.XML);
      msg.Status:= msDone;
    except
      msg.Status:= msFail;
    end;
  end;
end;

procedure TSvcControlClient.SetActive(const Value: boolean);
begin
  if Value then begin
    { connect }
    if not TCPClient.Connected then begin
      TCPClient.Port:= ServerPort;
      TCPClient.Host:= ServerIP;
      fUserDisconnect:= false;
      try
        TCPClient.Connect();
      except
      end;
    end;
  end
  else begin
    { disconnect }
    if TCPClient.Connected then begin
      fUserDisconnect:= true;
      TCPClient.Disconnect;
    end;
  end;
end;

procedure TSvcControlClient.SetRemotePropertyStr(PropName: string;
  const Value: string);
var
  msg: TRemoteMessageItem;
  startTime: TDateTime;
begin
  msg:= TRemoteMessageItem.Create;
  try
    msg.Direction:= mdOut;
    msg.Values['command']:= 'setProperty';
    msg.Values['propName']:= PropName;
    msg.Values['propValue']:= Value;
    Queue.AddMessage(msg);
    startTime:= now;
    while (msg.Status = msWaiting) and (not TimedOut(startTime)) do begin
      Application.ProcessMessages;
      CheckForMessages;
    end;
    if msg.Status <> msDone then begin
      raise Exception.Create('Failed setting remote property');
    end;

  finally
    msg.Status:= msDelete;
  end;
end;

procedure TSvcControlClient.TimerTimer(Sender: TObject);
begin
  CheckForMessages;
end;

function TSvcControlClient.GetServerIP: string;
begin
  result:= AppVars['ServerIP'];
end;

function TSvcControlClient.GetServerPort: integer;
begin
  result:= AppVars.IntVar['ServerPort'];
end;

procedure TSvcControlClient.SetServerIP(const Value: string);
var
  SvrActive: boolean;
begin
  if AppVars['ServerIP'] <> Value then begin
    SvrActive:= Active;
    Active:= false;
    AppVars['ServerIP']:= value;
    Active:= SvrActive;
  end;
end;
procedure TSvcControlClient.SetServerPort(const Value: integer);
var
  SvrActive: boolean;
begin
  if AppVars.IntVar['ServerPort'] <> Value then begin
    SvrActive:= Active;
    Active:= false;
    AppVars.IntVar['ServerPort']:= value;
    Active:= SvrActive;
  end;
end;


procedure TSvcControlClient.Connect;
begin
  Active:= true;
end;

procedure TSvcControlClient.Disconnect;
begin
  Active:= false;
end;

procedure TSvcControlClient.TCPClientConnected(Sender: TObject);
begin
  if Assigned(fOnConnect) then
    fOnConnect(self);
end;

procedure TSvcControlClient.TCPClientDisconnected(Sender: TObject);
begin
  if Assigned(fOnDisconnect) then
    fOnDisconnect(self);
end;

procedure TSvcControlClient.CheckForMessages;
var
  s: string;
  msg: TRemoteMessageItem;
  x: integer;
begin
  Timer.Enabled:= false;
  try
    if Active then begin
      { get any messages from server }
      if ReadFromServer(s) then begin
        if s <> '' then begin
          msg:= TRemoteMessageItem.Create;
          msg.Direction:= mdIn;
          try
            msg.XML:= s;
          except
            msg.Free;
            msg:= nil;
          end;
          if Assigned(msg) then
            Queue.AddMessage(msg);
        end;
      end
      else begin
        { error reading from server ... try disconnecting and reconnecting }
        Active:= false;
        sleep(1000);
        Active:= true;
      end;

      { now check for unsent messages }
      for x:= 0 to Queue.Count -1 do begin
        msg:= queue.Items[x];
        if (msg.Status = msWaiting) and (msg.Direction = mdOut) then
          SendMessage(msg);
      end;
    end
    else begin
      { not connected }
      if AutoReconnect and (not fUserDisconnect) then begin
        if ((now - fLastReconnectTime) * SecondsPerDay) >= ReconnectRetrySeconds then begin
          TCPClient.Port:= ServerPort;
          TCPClient.Host:= ServerIP;
          try
            TCPClient.Connect();
          except
          end;
        end;
      end;
    end;
  finally
    Timer.Enabled:= true;
  end;
end;

end.
