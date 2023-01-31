unit ModuleComms3;

interface

(*
    TModuleComms allows inter-module (inter-process) communications
    In main module (Server) use TModuleComms.Create([Chanel Name eg MOdule Name],true)
    In Client module use TModuleComms.Create([Same name as above],false)
    WARNING
      OnMessage and OnRequest execute in their own threads .. ie a new Thread
      is created each time (and frees its self on terminate)
*)

uses
  {$IfDef VER220}
  Windows,
  {$Else}
  WinApi.Windows,
  {$EndIf}

  SyncObjs, classes, ThreadProperty,
  LogThreadLib, LogThreadBase, LogMessageTypes,
  IdTcpServer, IdTCPClient, IdContext;

type
  TModuleCommsMessageEvent = procedure(aClientId: integer; aData: string) of object;
  TModuleCommsRequestEvent = procedure(aClientId: integer; aRequest: string; var aResponse: string) of object;
  TModuleRequestType = (rtMessage, rtRequest, rtResponse);
  TModuleRequestStatus = (rsIdle, rsWaitingOnResponse, rsResponseReady);

  TSeqGenerator = class;
  TModuleComms = class
  private
    fMaxIntStrLength: Integer;
    fChannelName: string;
    fIsServer: Boolean;
    Server: TIdTcpServer;
    Client: TIdTcpClient;
    fOnMessage: TModuleCommsMessageEvent;
    fOnRequest: TModuleCommsRequestEvent;
    CriticalSection: TCriticalSection;
    MessageList: TThreadList;
    fMessageTimeoutMS: Integer;
    SeqGen: TSeqGenerator;
    ActiveProp: TThreadProperty;
    fLogger: TLoggerBase;
    fOwnedLogger: TLoggerBase;
    procedure Lock;
    procedure Unlock;
    procedure DoReceivedData(aData: string);
    procedure DoOnServerExecute(AContext: TIdContext);
    function InternalSend(aClientId: Integer; aType: TModuleRequestType; aMessageId: string; aData: string): Boolean;
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    function GetLogger: TLoggerBase;
//    function GetServerPort: integer;
  public
    constructor Create(aChannelName: string; IsServer: Boolean; aMySQLServer: string = '127.0.0.1'; aLogger: TLoggerBase = nil);
    destructor Destroy; override;
    function SendMessage(aClientId: integer; aMessage: string): boolean;
    function SendRequest(aClientId: integer; aRequest: string; var aResponse: string): boolean;
    property OnMessage: TModuleCommsMessageEvent read fOnMessage write fOnMessage;
    property OnRequest: TModuleCommsRequestEvent read fOnRequest write fOnRequest;
    property MessageTimeoutMS: Integer read fMessageTimeoutMS write fMessageTimeoutMS;
    property Active: Boolean read GetActive write SetActive;
    property Logger: TLoggerBase read GetLogger write fLogger;
  end;

  TRequestRec = class
  public
    ClientId: integer;
    Response: string;
    Status: TModuleRequestStatus;
    MessageId: string;
    ExpireTime: TDateTime;
  end;

  TSeqGenerator = class
  private
    Lock: TCriticalSection;
    fValue: Int64;
    fLastDay: TDateTime;
    fSequenceStringLength: integer;
    fMaxInt64StrLength: integer;
    function GetSequenceStringLength: integer;
  public
    constructor Create;
    destructor Destroy; override;
    property SequenceStringLength: integer read GetSequenceStringLength;
    function GetNextSequenceString: string;
  end;

  TInternalSendFunc = function(aClientId: integer; aType: TModuleRequestType;
    aMessageId: string; aData: string): boolean of object;

  TModuleMessageThread = class(TThread)
  private
    fOnMessage: TModuleCommsMessageEvent;
    fOnRequest: TModuleCommsRequestEvent;
    fOnInternalSend: TInternalSendFunc;
  protected
    procedure Execute; override;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
  public
    requestData: string;
    responseData: string;
    ClientId: integer;
    MessageType: TModuleRequestType;
    MessageId: string;
    InternalSendFunc: TInternalSendFunc;
    MessageList: TThreadList;
    Logger: TLoggerBase;
    constructor Create(CreatSuspended: boolean);
    property OnMessage: TModuleCommsMessageEvent read fOnMessage write fOnMessage;
    property OnRequest: TModuleCommsRequestEvent read fOnRequest write fOnRequest;
    property OnInternalSend: TInternalSendFunc read fOnInternalSend write fOnInternalSend;
  end;

implementation

uses
  sysutils, ServerModuleConst, IntegerListObj, IdHttpServer, ModulePortObj;

var
  PortList: TIntegerList;

const
  OneMs = 1/24/60/60/1000;
  OneSec = 1/24/60/60;

//function PortTCP_IsOpen(dwPort : Word; ipAddressStr:AnsiString) : boolean;
//var
//  client : sockaddr_in;
//  sock   : Integer;
//
//  ret    : Integer;
//  wsdata : WSAData;
//begin
// Result:=False;
// ret := WSAStartup($0002, wsdata); //initiates use of the Winsock DLL
//  if ret<>0 then exit;
//  try
//    client.sin_family      := AF_INET;  //Set the protocol to use , in this case (IPv4)
//    client.sin_port        := htons(dwPort); //convert to TCP/IP network byte order (big-endian)
//    client.sin_addr.s_addr := inet_addr(PAnsiChar(ipAddressStr));  //convert to IN_ADDR  structure
//    sock  :=socket(AF_INET, SOCK_STREAM, 0);    //creates a socket
//    Result:=connect(sock,client,SizeOf(client))=0;  //establishes a connection to a specified socket
//  finally
//  WSACleanup;
//  end;
//end;

{ TModuleComms }

constructor TModuleComms.Create(aChannelName: string; IsServer: Boolean; aMySQLServer: string; aLogger: TLoggerBase);
var
  aPort: integer;
  tryCount: integer;

  procedure SetupPorts(RenewPort: Boolean = False);
  begin
    if fIsServer then begin
      aPort := TModulePort.GetModulePort(aChannelName, RenewPort, aMySQLServer);
      Server.Bindings.Clear;
      Server.DefaultPort := aPort;
      Client.Port := aPort + 1;
    end
    else begin
      aPort := TModulePort.GetModulePort(aChannelName, RenewPort, aMySQLServer);
      Client.Port := aPort;
      Server.Bindings.Clear;
      Server.DefaultPort := aPort + 1;
    end;
  end;

begin
  Client := nil;
  Server := nil;
  fMaxIntStrLength := Length(IntToStr(MaxInt));
  ActiveProp := TThreadProperty.Create;
  Active := True;
  MessageList := TThreadList.Create;
  CriticalSection := TCriticalSection.Create;
  fMessageTimeoutMS := 20000; { 20 seconds }
  SeqGen := TSeqGenerator.Create;
  fChannelName := aChannelName;
  fIsServer := IsServer;

  fLogger := aLogger;

  Server := TIdTCPServer.Create(nil);
  Server.OnExecute := Self.DoOnServerExecute;

  Client := TIdTCPClient.Create(nil);
  Client.Host := '127.0.0.1';

  SetupPorts(False);

  tryCount := 0;

  repeat
    try
      Server.Active := True;
    except
      on e: exception do begin
        if Pos('Could not bind socket. Address and port are already in use', e.Message) > 0 then begin
          SetupPorts(True);
        end
        else
          raise;
      end;
    end;
  until (Server.Active) or (tryCount >= 50);
end;

destructor TModuleComms.Destroy;
begin
  Server.Free;
  Client.Free;
  MessageList.Free;
  CriticalSection.Free;
  SeqGen.Free;
  ActiveProp.Free;
  fOwnedLogger.Free;
  inherited;
end;

procedure TModuleComms.DoOnServerExecute(AContext: TIdContext);
var
  stream: TStringStream;
begin
  stream := TStringStream.Create;
  try
    AContext.Connection.IOHandler.ReadStream(stream);
    stream.Position := 0;
    DoReceivedData(stream.DataString);
  finally
    stream.Free;
  end;
end;

procedure TModuleComms.DoReceivedData(aData: string);
var
  ClientId: integer;
  MessageId: string;
  MessageTypeStr: string;
  Thread: TModuleMessageThread;
  s: string;
  x: integer;
begin
  if Length(aData) < (1 + fMaxIntStrLength + SeqGen.SequenceStringLength) then
    exit; { invalid format }
  try
    ClientID := StrToInt(Copy(aData,2,fMaxIntStrLength));
  except
    exit; { invalid format }
  end;
  MessageId := Copy(aData,1+fMaxIntStrLength+1,SeqGen.SequenceStringLength);
  { now check message type }
  MessageTypeStr := Copy(aData,1,1);
  if SameText(MessageTypeStr,IntToStr(Ord(rtMessage))) then begin
    if not Assigned(self.fOnMessage) then
      exit;
    Thread := TModuleMessageThread.Create(true);
    Thread.OnMessage := fOnMessage;
    Thread.RequestData := Copy(aData,1+fMaxIntStrLength+SeqGen.SequenceStringLength+1,MaxInt);
    Thread.ClientId := ClientId;
    Thread.MessageType := rtMessage;
    Thread.Logger:= Logger;
    Thread.Start;
  end
  else if SameText(MessageTypeStr,IntToStr(Ord(rtRequest))) then begin
    if not Assigned(self.fOnRequest) then
      exit;
    Thread := TModuleMessageThread.Create(true);
    Thread.OnRequest := fOnRequest;
    s := Copy(aData,1+fMaxIntStrLength+SeqGen.SequenceStringLength+1,MaxInt);
    x:= Pos(MSG_SEP_STR,s);
    if x > 0 then begin
      Thread.responseData := Copy(s,x+Length(MSG_SEP_STR));
      s:= Copy(s,1,x-1);
    end;
    Thread.requestData := s;
    Thread.ClientId := ClientId;
    Thread.MessageType := rtRequest;
    Thread.MessageId := MessageId;
    Thread.OnInternalSend := InternalSend;
    Thread.Logger:= Logger;
    Thread.Start;
  end
  else if SameText(MessageTypeStr,IntToStr(Ord(rtResponse))) then begin
    Thread := TModuleMessageThread.Create(true);
    Thread.responseData := Copy(aData,1+fMaxIntStrLength+SeqGen.SequenceStringLength+1,MaxInt);
    Thread.MessageId := MessageId;
    Thread.MessageType := rtResponse;
    Thread.MessageList := MessageList;
    Thread.Logger:= Logger;
    Thread.Start;
  end;
end;

function TModuleComms.GetActive: boolean;
begin
  Result := ActiveProp.AsBoolean;
end;

function TModuleComms.GetLogger: TLoggerBase;
begin
  if Assigned(fLogger) then
    Result := fLogger
  else begin
    if not Assigned(fOwnedLogger) then begin
      fOwnedLogger := TLogger.Create(nil);
      fOwnedLogger.LogAllTypes;
    end;
    Result := fOwnedLogger;
  end;
end;

//function TModuleComms.GetServerPort: integer;
//var
//  tryPort: integer;
//
//  function PortOpen: boolean;
//  var
//    svr: TIDHttpServer;
//  begin
//    result := true;
//    svr := TIDHttpServer.Create(nil);
//    try
//      svr.DefaultPort := tryPort;
//      try
//        svr.Active := true;
//      except
//        result := false;
//      end;
//
//    finally
//      svr.Free;
//    end;
//  end;
//
//
//begin
//  result := 0;
//  if SameText(fChannelName,'ERPModClientServer') then
//    result := 49502
//  else if SameText(fChannelName,'ERPModUserUtils') then
//    result := 49504
//  else if SameText(fChannelName,'ERPModWebAPI') then
//    result := 49506
//  else if SameText(fChannelName,'ERPModSiteIntegration') then
//    result := 49508
//  else if SameText(fChannelName,'ERPModGoogle') then
//    result := 49510
//  else if SameText(fChannelName,'ERPModEbay') then
//    result := 49512
//  else if SameText(fChannelName,'ERPModPrestaShop') then
//    result := 49514
//  else begin
//    tryPort := 49514 + 2;
//    while tryPort < (49514 + 100) do begin
//      if (not PortList.InList(tryPort)) and PortOpen then begin
//      //if PortTCP_IsOpen(tryPort, '127.0.0.1') then begin
//        result := tryPort;
//        break;
//      end;
//      tryPort := tryPort + 2;
//    end;
//
//  end;
//  if result > 0 then
//    PortList.Add(result)
//  else
//    raise Exception.Create(self.ClassName + ' Cant determin server port for ' + fChannelName);
//end;

function TModuleComms.InternalSend(aClientId: integer; aType: TModuleRequestType;
  aMessageId: string; aData: string): boolean;
var
  ClientIdStr: string;
  stream: TStringStream;
begin
  Result:= True;
  Lock;
  try
    try
      ClientIdStr:= IntToStr(aClientId);
      while Length(ClientIdStr) < fMaxIntStrLength do
        ClientIdStr := '0' + ClientIdStr;

      stream:= TStringStream.Create;
      try
        stream.WriteString(IntToStr(Ord(aType)) + ClientIdStr + aMessageId + aData);

        try
          if not Client.Connected then
            Client.Connect();

          client.IOHandler.Write(stream,0,true);
        except
          on e: exception do begin
            Log('Error sending data: ' + e.Message, ltError);
            result:= false;
          end;
        end;
      finally
        stream.Free;
      end;
    except
      result:= false;
    end;
  finally
    Unlock;
  end;
end;

procedure TModuleComms.Lock;
begin
  CriticalSection.Acquire;
end;

procedure TModuleComms.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(Logger) then
    Logger.Log(msg, LogMessageType);
end;

function TModuleComms.SendMessage(aClientId: Integer; aMessage: string): Boolean;
begin
  { send straight away }
  Result := InternalSend(aClientId, rtMessage, SeqGen.GetNextSequenceString, aMessage);
end;

function TModuleComms.SendRequest(aClientId: integer; aRequest: string;
  var aResponse: string): boolean;
var
  reqRec: TRequestRec;
  list: TList;
  MessageId: string;
  idx: integer;
  expireTime: TDateTime;
  listCount, listPass: integer;
begin
  result := false;
  listCount := 0;
  try
    try
      expireTime := now + (OneSec * 60);
      MessageId:= SeqGen.GetNextSequenceString;
//      Log('Sending request with message Id ' + MessageId + ' expire time ' + FormatDateTime('hh:nn:ss.zzz',expireTime),ltDetail);
      reqRec:= TRequestRec.Create;
      reqRec.ClientId := aClientId;
      reqRec.MessageId := MessageId;
      reqRec.Status := rsWaitingOnResponse;
      reqRec.ExpireTime := expireTime;
      list := MessageList.LockList;
      try
        list.Add(reqRec);
      finally
        MessageList.UnlockList;
      end;

      if not InternalSend(aClientId,rtRequest,MessageId,aRequest + MSG_SEP_STR + aResponse) then begin
        { delete from list; }
        list := MessageList.LockList;
        try
          idx := list.IndexOf(reqRec);
          if idx > -1 then begin
            reqRec.Free;
            list.Delete(idx);
          end;
        finally
          MessageList.UnlockList;
        end;
        exit;
      end;

      { message sent ok .. now wait for responce }
      listPass := 0;
      while Active do begin
        if now > expireTime then begin
          Log('Timed out waiting for responce to request (list size '+IntToStr(listCount)+' pass count '+IntToStr(listPass)+').',ltError);
//          Log('now ' + FormatDateTime('hh:nn:ss.zzz',now) + ' expire ' + FormatDateTime('hh:nn:ss.zzz',expireTime)+ ' Message Id '+ MessageId,ltError);
          exit;  { timed out waiting for response }
        end;

        { check list for result .. }
        list := MessageList.LockList;
        try
          Inc(listPass);
          listCount := list.Count;
          idx := 0;
          while idx < list.Count do begin
            reqRec := list[idx];
            { clean up expired records along the way }
            if now > reqRec.ExpireTime then begin
              reqRec.Free;
              list.Delete(idx);
            end
            else if (reqRec.MessageId = MessageId) then begin
              { we found the message .. do we have a response yet .. }
              if reqRec.Status = rsResponseReady then begin
                { we have a response .. }
                result:= true;
                { copy data }
                aResponse := Copy(reqRec.Response,1,MaxInt);
                { remove from list }
                reqRec.Free;
                list.Delete(idx);
                exit;
              end
              else
                Inc(idx);
            end
            else
              Inc(idx);
          end;
        finally
          MessageList.UnlockList;
        end;
        sysutils.Sleep(10);
      end;
    except
      on e: exception do begin
        Log('Exception while sending request: ' + e.Message);
      end;
    end;
  finally
//    Log('SendRequest - End, Result: ' + BoolToStr(result,true));
  end;
end;

procedure TModuleComms.SetActive(const Value: boolean);
begin
  ActiveProp.AsBoolean := Value;
end;

procedure TModuleComms.Unlock;
begin
  CriticalSection.Release;
end;

{ TSeqGenerator }

constructor TSeqGenerator.Create;
begin
  fValue:= 0;
  fLastDay := 0;
  Lock := TCriticalSection.Create;
  fMaxInt64StrLength := Length(IntToStr(High(Int64))); { max Int64 }
  fSequenceStringLength := Length('yyyymmdd') + fMaxInt64StrLength;
end;

destructor TSeqGenerator.Destroy;
begin
  Lock.Free;
  inherited;
end;

function TSeqGenerator.GetNextSequenceString: string;
begin
  Lock.Acquire;
  try
    if Trunc(fLastDay) <> Trunc(now) then begin
      fLastDay := Trunc(now);
      fValue:= 0;
    end;
    result:= IntToStr(fValue);
    while Length(Result) < fMaxInt64StrLength do
      Result := '0' + Result;
    Result:= FormatDateTime('yyyymmdd',fLastDay) + Result;

    fValue := fValue + 1;
  finally
    Lock.Release;
  end;
end;

function TSeqGenerator.GetSequenceStringLength: integer;
begin
  result:= fSequenceStringLength;
end;

{ TModuleMessageThread }

constructor TModuleMessageThread.Create(CreatSuspended: boolean);
begin
  inherited;
  FreeOnTerminate := true;
  Logger := nil;
end;

procedure TModuleMessageThread.Execute;
var
  list: TList;
  idx: integer;
  rec: TRequestRec;
  found: boolean;
begin
  inherited;
  try
    if MessageType = rtMessage then begin
//      Log(ClassName + ' received Message',ltDetail);
      OnMessage(ClientID,requestData);
    end
    else if MessageType = rtRequest then begin
//      Log(ClassName + ' received Request',ltDetail);
      OnRequest(ClientID,requestData,responseData);
      fOnInternalSend(ClientID,rtResponse,MessageId,responseData);
    end
    else if MessageType = rtResponse then begin
//      Log(ClassName + ' received Responce for message id '+ MessageId,ltDetail);
      found := false;
      list := MessageList.LockList;
      try
//        Log(ClassName + ' list locked (count '+ IntToStr(list.Count)+ ')',ltDetail);
        for idx := 0 to list.Count -1 do begin
          rec := list[idx];
          if rec.MessageId = MessageId then begin
            rec.Status := rsResponseReady;
            rec.Response := self.responseData;
            found := true;
//            Log(ClassName + ' Request updated in list',ltDetail);
            break;
          end;
        end;
      finally
        MessageList.UnlockList;
      end;
      if not found then
        Log(ClassName + ' Message not found for received Responce for message id '+ MessageId,ltError);
    end;
  except
    { ignore exceptions .. let thread terminate }
  end;
end;

procedure TModuleMessageThread.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(Logger) then begin
    try
      Logger.Log(msg,LogMessageType);

    except;

    end;
  end;
end;

initialization
  PortList := TIntegerList.Create;

finalization
  PortList.Free;
end.
