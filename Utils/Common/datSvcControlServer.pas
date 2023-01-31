unit datSvcControlServer;

interface

uses
  SysUtils, Classes, IdBaseComponent, IdComponent, IdTCPServer, 
  ServiceGuiCommon, IdAntiFreezeBase, IdAntiFreeze;

type

  TOnSetPropertyStrEvent = procedure(const propName, propValue: string) of object;
  TOnGetPropertyStrEvent = procedure(const propName: string; var propValue: string) of object;

  TSvcControlServer = class(TDataModule)
    TCPServer: TIdTCPServer;
    IdAntiFreeze1: TIdAntiFreeze;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TCPServerExecute(AThread: TIdPeerThread);
  private
//    fAppVarsCreated: boolean;
    fOnReceiveMessage: TOnAddMessageEvent;
    fObjectToControl: TComponent;
    procedure SetPort(const Value: integer);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    function GetPort: integer;
    procedure SetProperty(const propName, propValue: string);
    function GetProperty(const propName: string): string;
  public
    property Port: integer read GetPort write SetPort;
    property Active: boolean read GetActive write SetActive;
    property ObjectToControl: TComponent read fObjectToControl write fObjectToControl;
    property OnReceiveMessage: TOnAddMessageEvent read fOnReceiveMessage write fOnReceiveMessage;
    procedure SendMessage(msg: TRemoteMessageItem);
  end;

var
  SvcControlServer: TSvcControlServer;

implementation

{$R *.dfm}

uses
  IdSocketHandle, IdStack, IdTCPConnection, IdGlobal, TypInfo,
  LogThreadLib, LogMessageTypes, AppVarsObj;


procedure TSvcControlServer.DataModuleCreate(Sender: TObject);
begin
  TCPServer.CommandHandlersEnabled:= false;
//  fAppVarsCreated:= false;
//  if not Assigned(AppVars) then begin
//    AppVars:= TAppVars.Create;
//    AppVars.SaveOnChange:= true;
//    AppVars.EncryptFile:= true;
//    AppVars.LoadFromFile();
//    fAppVarsCreated:= true;
//  end;
  { set defaults }
  AppVars.SetDefault('ServerControlPort','9010');
end;

procedure TSvcControlServer.DataModuleDestroy(Sender: TObject);
begin
  Active:= false;
//  if fAppVarsCreated then begin
//    AppVars.Free;
//    AppVars:= nil;
//  end;
end;

function TSvcControlServer.GetActive: boolean;
begin
  result:= TCPServer.Active;
end;

function TSvcControlServer.GetPort: integer;
begin
  result:= AppVars.IntVar['ServerControlPort'];
end;

function TSvcControlServer.GetProperty(const propName: string): string;
var
  s: string;
begin
  s:= '';
  TLogger.Inst.Log('TSvcControlServer.GetProperty - Name: "' + propName,ltDetail);
//  if Assigned(fOnGetProperty) then
//    fOnGetProperty(propName, s);

  if Assigned(fObjectToControl) then begin
    s:= typInfo.GetPropValue(fObjectToControl,propName);
  end;
  TLogger.Inst.Log('TSvcControlServer.GetProperty - Name: "' + propName + '" Value: "' + s + '"',ltDetail);
  result:= s;
end;

procedure TSvcControlServer.SendMessage(msg: TRemoteMessageItem);
var
  x: integer;
  List: TList;
begin
  List:= TCPServer.Threads.LockList;
  try
    { send message to all connected clients }
    for x:= 0 to List.Count -1 do begin
      try
        TIdPeerThread(List[x]).Connection.WriteLn(msg.XML);
      except
      end;  
    end;

  finally
    TCPServer.Threads.UnlockList;
    msg.Free;
  end;  
end;

procedure TSvcControlServer.SetActive(const Value: boolean);
var
  Binding: TIdSocketHandle;
  x: integer;
begin
  if not TCPServer.Active then begin
    TCPServer.Bindings.Clear;
      Binding:= TCPServer.Bindings.Add;
      Binding.IP:= '127.0.0.1';
      Binding.Port:= self.Port;
      for x:= 0 to GStack.LocalAddresses.Count -1 do begin
        Binding:= TCPServer.Bindings.Add;
        Binding.IP:= GStack.LocalAddresses[x];
        Binding.Port:= self.Port;
      end;
      for x:= 0 to TCPServer.Bindings.Count -1 do begin
        TLogger.Inst.Log('TdmXMLServer.SetActive - Adding binding for Address: ' + TCPServer.Bindings[x].IP  +
          '  Port: ' + IntToStr(TCPServer.Bindings[x].Port),ltInfo);

      end;
    TCPServer.Active:= true;
    TLogger.Inst.Log('TSvcControlServer.SetActive - Started Control Server',ltInfo);
  end
  else begin
    TCPServer.Active:= false;
    TLogger.Inst.Log('TSvcControlServer.SetActive - Stopped Control Server',ltInfo);
  end;
end;

procedure TSvcControlServer.SetPort(const Value: integer);
begin
  AppVars.IntVar['ServerControlPort']:= Value;
end;

procedure TSvcControlServer.SetProperty(const propName, propValue: string);
begin
//  if Assigned(fOnSetProperty) then
//    fOnSetProperty(propName, propValue);

  TLogger.Inst.Log('TSvcControlServer.SetProperty - Name: "' + propName + '" Value: "' + propValue + '"',ltDetail);
  if Assigned(fObjectToControl) then begin
    typInfo.SetPropValue(fObjectToControl,propName,propValue);
  end;
end;

procedure TSvcControlServer.TCPServerExecute(AThread: TIdPeerThread);
var
  StartTagFound, EndTagFound: boolean;
  s, inStr, propVal: string;
  msg, msgResp: TRemoteMessageItem;
begin
  inStr:= '';
  StartTagFound:= false;
  EndTagFound:= false;

//  s:= AThread.Connection.ReadLn();
//  if (not StartTagFound) and (Pos('<'+XMLMsgNodeRoot,s) > 0) then
//    StartTagFound:= true;
//  while (s <> '') or ((s = '') and (StartTagFound and (not EndTagFound))) do begin
//    inStr:= inStr + s;
//
//    s:= AThread.Connection.ReadLn();
//    if (not StartTagFound) and (Pos('<'+XMLMsgNodeRoot,s) > 0) then
//      StartTagFound:= true;
//    if (not EndTagFound) and (Pos('</'+XMLMsgNodeRoot,s) > 0) then
//      EndTagFound:= true;
//  end;
  s:= AThread.Connection.ReadLn(#10,100);
  if (not StartTagFound) and (Pos('<'+XMLMsgNodeRoot,s) > 0) then
    StartTagFound:= true;
  while not (StartTagFound and EndTagFound) do begin
    inStr:= inStr + s;

    s:= AThread.Connection.ReadLn(#10,100);
    if AThread.Connection.ReadLnTimedOut then
      break;
    if (not StartTagFound) and (Pos('<'+XMLMsgNodeRoot,s) > 0) then
      StartTagFound:= true;
    if (not EndTagFound) and (Pos('</'+XMLMsgNodeRoot,s) > 0) then
      EndTagFound:= true;
  end;


  if inStr <> '' then begin
    TLogger.Inst.Log('TSvcControlServer.TCPServerExecute - Message: ' + inStr,ltDetail);
    msg:= TRemoteMessageItem.Create;
    try
      msg.Direction:= mdIn;
      try
        msg.XML:= inStr;
      except
        exit;
      end;

      if msg.Values['command'] = 'setProperty' then begin
        TLogger.Inst.Log('TSvcControlServer.TCPServerExecute - Setting property',ltDetail);
        self.SetProperty(msg.Values['propName'],msg.Values['propValue']);
      end
      else if msg.Values['command'] = 'getProperty' then begin
        TLogger.Inst.Log('TSvcControlServer.TCPServerExecute - Getting property',ltDetail);
        { get the property }
        propVal:= self.GetProperty(msg.Values['propName']);
        { create responce message }
        msgResp:= TRemoteMessageItem.Create;
        try
          msgResp.Direction:= mdOut;
          msgResp.RequesterId:= msg.Id;
          msgResp.Values['command']:= 'responce';
          msgResp.Values['propName']:= msg.Values['propName'];
          msgResp.Values['propValue']:= propVal;
          AThread.Connection.WriteLn(msgResp.XML);
        finally
          msgResp.Free;
        end;
      end
      else begin
        { pass on for processing }
        if Assigned(fOnReceiveMessage) then
          fOnReceiveMessage(msg);
      end;
    finally
      msg.Free;
    end;
  end;
end;

end.
