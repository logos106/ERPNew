unit ModuleComms;

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
  SimplePipes, SyncObjs, windows, classes, ThreadProperty,
  LogThreadLib, LogThreadBase, LogMessageTypes;

type
  TModuleCommsMessageEvent = procedure(aClientId: integer; aData: string) of object;
  TModuleCommsRequestEvent = procedure(aClientId: integer; aRequest: string; var aResponse: string) of object;
  TModuleRequestType = (rtMessage, rtRequest, rtResponse);
  TModuleRequestStatus = (rsIdle, rsWaitingOnResponse, rsResponseReady);

  TSeqGenerator = class;
  TModuleComms = class
  private
    fMaxIntStrLength: integer;
    fChannelName: string;
    fIsServer: boolean;
    Server: TPBPipeServer;
    fOnMessage: TModuleCommsMessageEvent;
    fOnRequest: TModuleCommsRequestEvent;
    CriticalSection: TCriticalSection;
    MessageList: TThreadList;
    fMessageTimeoutMS: integer;
    SeqGen: TSeqGenerator;
    ActiveProp: TThreadProperty;
    fLogger: TLoggerBase;
    fOwnedLogger: TLoggerBase;
    procedure Lock;
    procedure Unlock;
    procedure DoReceivedData(aData: string);
    function InternalSend(aClientId: integer; aType: TModuleRequestType; aMessageId: string; aData: string): boolean;
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    function GetLogger: TLoggerBase;
  public
    constructor Create(aChannelName: string; IsServer: boolean);
    destructor Destroy; override;
    function SendMessage(aClientId: integer; aMessage: string): boolean;
    function SendRequest(aClientId: integer; aRequest: string; var aResponse: string): boolean;
    property OnMessage: TModuleCommsMessageEvent read fOnMessage write fOnMessage;
    property OnRequest: TModuleCommsRequestEvent read fOnRequest write fOnRequest;
    property MessageTimeoutMS: integer read fMessageTimeoutMS write fMessageTimeoutMS;
    property Active: boolean read GetActive write SetActive;
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
  public
    requestData: string;
    responseData: string;
    ClientId: integer;
    MessageType: TModuleRequestType;
    MessageId: string;
    InternalSendFunc: TInternalSendFunc;
    MessageList: TThreadList;
    constructor Create(CreatSuspended: boolean);
    property OnMessage: TModuleCommsMessageEvent read fOnMessage write fOnMessage;
    property OnRequest: TModuleCommsRequestEvent read fOnRequest write fOnRequest;
    property OnInternalSend: TInternalSendFunc read fOnInternalSend write fOnInternalSend;
  end;

implementation

uses
  sysutils, ServerModuleConst;

const
  OneMs = 1/24/60/60/1000;

{ TModuleComms }

constructor TModuleComms.Create(aChannelName: string; IsServer: boolean);
begin
  fMaxIntStrLength := Length(IntToStr(MaxInt));
  ActiveProp := TThreadProperty.Create;
  Active := true;
  MessageList := TThreadList.Create;
  CriticalSection := TCriticalSection.Create;
  fMessageTimeoutMS := 20000; { 20 seconds }
  SeqGen := TSeqGenerator.Create;
//  RequestStatus := rsIdle;
  fChannelName := aChannelName;
  fIsServer := IsServer;
  if fIsServer then
    Server := TPBPipeServer.Create('\\.\pipe\' + fChannelName)
  else
    Server := TPBPipeServer.Create('\\.\pipe\' + fChannelName + 'Client');
  Server.OnReceivedData := DoReceivedData;
//  fLogger := TLogger.Create(nil);
//  fLogger.LogName := 'temp';
//  fLogger.LogAllTypes;
end;

destructor TModuleComms.Destroy;
begin
  Server.Free;
  MessageList.Free;
  CriticalSection.Free;
  SeqGen.Free;
  ActiveProp.Free;
  fOwnedLogger.Free;
  inherited;
end;

procedure TModuleComms.DoReceivedData(aData: string);
var
  ClientId: integer;
  MessageId: string;
  MessageTypeStr: string;
  Thread: TModuleMessageThread;
//  list: TList;
//  idx: integer;
//  rec: TRequestRec;
  s: string;
  x: integer;
//  found: boolean;
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
    Thread.Start;
  end
  else if SameText(MessageTypeStr,IntToStr(Ord(rtResponse))) then begin
    Thread := TModuleMessageThread.Create(true);
    Thread.responseData := Copy(aData,1+fMaxIntStrLength+SeqGen.SequenceStringLength+1,MaxInt);
    Thread.MessageId := MessageId;
    Thread.MessageType := rtResponse;
    Thread.MessageList := MessageList;
    Thread.Start;
//    Log('    Received a Responce message for Id: ' + MessageId);
//    list := MessageList.LockList;
//    try
//      found := false;
//      for idx := 0 to list.Count -1 do begin
//        rec := list[idx];
//        if rec.MessageId = MessageId then begin
//          rec.Status := rsResponseReady;
//          rec.Response := Copy(aData,1+fMaxIntStrLength+SeqGen.SequenceStringLength+1,MaxInt);
//          found := true;
//          break;
//        end;
//      end;
//      if found then
//        Log('    Found message in list and updated status')
//      else
//        Log('    Message not found in list, exiting!');
//
//    finally
//      MessageList.UnlockList;
//    end;
  end;
end;

function TModuleComms.GetActive: boolean;
begin
  result := ActiveProp.AsBoolean;
end;

function TModuleComms.GetLogger: TLoggerBase;
begin
  if Assigned(fLogger) then
    Result := fLogger
  else begin
    if not Assigned(fOwnedLogger) then begin
      fOwnedLogger:= TLogger.Create(nil);
      fOwnedLogger.LogAllTypes;
    end;
    result := fOwnedLogger;
  end;
end;

function TModuleComms.InternalSend(aClientId: integer; aType: TModuleRequestType;
  aMessageId: string; aData: string): boolean;
var
  ClientIdStr: string;
  x: integer;
begin
  result:= true;
  Lock;
  try
    try
      ClientIdStr:= IntToStr(aClientId);
      while Length(ClientIdStr) < fMaxIntStrLength do
        ClientIdStr := '0' + ClientIdStr;

      if fIsServer then begin
        { we are sending a message back to the stub from the module }
        try
          TPBPipeClient.SendData('\\.\pipe\' + fChannelName + 'Client',IntToStr(Ord(aType)) + ClientIdStr + aMessageId + aData);
        except
          on e: exception do begin
            Log('Error sending message to ' + fChannelName + 'Client: ' + e.Message,ltError);
          end;
        end;
      end
      else begin
        { we are sending a message to module }
        try
          TPBPipeClient.SendData('\\.\pipe\' + fChannelName,IntToStr(Ord(aType)) + ClientIdStr + aMessageId + aData);
        except
          on e: exception do begin
            Log('Error sending message to ' + fChannelName + ': ' + e.Message,ltError);
//            x:= 1;
//            while x <= 10 do begin
//              try
//                Sleep(500);
//                TPBPipeClient.SendData('\\.\pipe\' + fChannelName,IntToStr(Ord(aType)) + ClientIdStr + aMessageId + aData);
//                break;
//              except
//                on e2: exception do begin
//                  Inc(x);
//                  Log(e2.Message,ltWarning);
//                end;
//              end;
//            end;
//            if x > 10 then begin
//              result := false;
//              Log('Send failed.',ltError);
//            end;
          end;
        end;
      end;
    except
//      raise;
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

function TModuleComms.SendMessage(aClientId: integer; aMessage: string): boolean;
begin
  { send straight away }
  result:= InternalSend(aClientId, rtMessage, SeqGen.GetNextSequenceString, aMessage);
end;

function TModuleComms.SendRequest(aClientId: integer; aRequest: string;
  var aResponse: string): boolean;
var
  reqRec: TRequestRec;
  list: TList;
  MessageId: string;
  idx: integer;
  expireTime: TDateTime;
begin
  result := false;
//  Log('');
//  Log('SendRequest - Start');
  try
    try
      expireTime := now + (OneMs * fMessageTimeoutMS);
      MessageId:= SeqGen.GetNextSequenceString;
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
//            Log('    SendRequest Failed - Deleting from list');
            reqRec.Free;
            list.Delete(idx);
          end;
        finally
          MessageList.UnlockList;
        end;
        exit;
      end;
//      Log('    InternalSend Ok - Message Id: '+ reqRec.MessageId);

      { message sent ok .. now wait for responce }
      while Active do begin
        sysutils.Sleep(10);
        if now > expireTime then begin
//          Log('    Timed out waiting for response, returning false.');
          exit;  { timed out waiting for response }
        end;

        { check list for result .. }
//        Log('    Locking list ..');
        list := MessageList.LockList;
        try
//          Log('    List Count: '+ IntToStr(list.Count));
          idx := 0;
          while idx < list.Count do begin
            reqRec := list[idx];
            { clean up expired records along the way }
            if now > reqRec.ExpireTime then begin
//              Log('    Cleaning up old record, Id: '+ reqRec.MessageId);
              reqRec.Free;
              list.Delete(idx);
            end
            else if (reqRec.MessageId = MessageId) then begin
              { we found the message .. do we have a response yet .. }
              if reqRec.Status = rsResponseReady then begin
//                Log('    Response received, returning true');
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
//          Log('    .. list Unlocked');
        end;
      end;
      if not Active then begin
//        Log('    Module not active, returning false');
      end;
    except
      on e: exception do begin
//        Log('    Exception: ' + e.Message);
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
end;

procedure TModuleMessageThread.Execute;
var
  list: TList;
  idx: integer;
  rec: TRequestRec;
begin
  inherited;
  try
    if MessageType = rtMessage then begin
      OnMessage(ClientID,requestData);
    end
    else if MessageType = rtRequest then begin
      OnRequest(ClientID,requestData,responseData);
      fOnInternalSend(ClientID,rtResponse,MessageId,responseData);
    end
    else if MessageType = rtResponse then begin
      list := MessageList.LockList;
      try
        for idx := 0 to list.Count -1 do begin
          rec := list[idx];
          if rec.MessageId = MessageId then begin
            rec.Status := rsResponseReady;
            rec.Response := self.responseData;
            break;
          end;
        end;
      finally
        MessageList.UnlockList;
      end;
    end;
  except
    { ignore exceptions .. let thread terminate }
  end;
end;

end.
