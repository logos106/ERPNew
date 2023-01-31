unit XMLCmdSrvObj;

interface

uses
  Classes, SyncObjs, ExtCtrls, Sysutils,
  DllMgrObj, forms, MultiEventObj, ALXMLDoc;

type

  { function exported by all dlls used by command server }
  TExecute = function(inNode, outNode: TALXMLNode; MainApp: TApplication = nil): boolean;

  {threadlist exceptions}
  EXMLCmdSrvMaxThreadCountExceededException = class(Exception);
  EXMLCmdSrvThreadAllreadyAqiredException = class(Exception);

  TAppInstThread = class;
  TXMLCmdSrv = class(TObject)
  private
    fThreadList: TThreadList;
    FLock: TCriticalSection;
    fSessionTimeoutSeconds: integer;
    fSessionTimer: TTimer;
    fDllMgr: TDllMgr;
    fActive: boolean;
    fEventQueue: TQueuedMultiEventClass;
    procedure KillAll;
    procedure DoOnTerminate(Sender: TObject);
    procedure DoOnSessionTimer(Sender: TObject);
    function GetNewTicket: string;
    function ThreadByTicket(const aTicket: string; List: TList): TAppInstThread;
    function GetDllMgr: TDllMgr;
    procedure SetActive(const Value: boolean);
    procedure SetMaxThreadCount(const Value: integer);
    procedure SetSessionTimeoutSeconds(const Value: integer);
    function GetThreadCount: integer;
    function GetMaxThreadCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    property MaxThreadCount: integer read GetMaxThreadCount write SetMaxThreadCount;
    function AquireThread(const aTicket: string): TAppInstThread;
    procedure ReleaseThread(aThread: TAppInstThread);
    property SessionTimeoutSeconds: integer read fSessionTimeoutSeconds write SetSessionTimeoutSeconds;
    procedure Lock;
    procedure Unlock;
    property DllMgr: TDllMgr read GetDllMgr;
    property Active: boolean read fActive write SetActive;
    property ThreadCount: integer read GetThreadCount;
    property EventQueue: TQueuedMultiEventClass read fEventQueue write fEventQueue;
  end;

  TAppInstThread = class(TThread)
  private
    fTicket: string;
    fInNode: TALXMLNode;
    fOutNode: TALXMLNode;
    fLastUsed: TDateTime;
    FSignal: TSimpleEvent;
    FWorkDoneSignal: TSimpleEvent;
    fAquired: boolean;
    fTerminateOnDone: boolean;
    fCommandServer: TXMLCmdSrv;
    fWorkDone: boolean;
    procedure ProcessRequest;
  public
    constructor Create; //(CreateSuspended: boolean);
    destructor Destroy; override;
    property Ticket: string read fTicket write fTicket;
    procedure Execute; override;
    property InNode: TALXMLNode read fInNode write fInNode;
    property OutNode: TALXMLNode read fOutNode write fOutNode;
    property LastUsed: TDateTime read fLastUsed write fLastUsed;
    procedure Die;
    procedure DoWork;
    property WorkDoneSignal: TSimpleEvent read fWorkDoneSignal;
    property WorkDone: boolean read fWorkDone;
    property Aquired: boolean read fAquired write fAquired;
    property TerminateOnDone: boolean read fTerminateOnDone write fTerminateOnDone;
    property CommandServer: TXMLCmdSrv read fCommandServer write fCommandServer;
  end;

  function ProcessXMLRequest(const inStr: string; var outStr: string; cmdSrv: TXMLCmdSrv): boolean;

implementation

uses
  FastFuncs, windows, Variants, XMLRequestConst,
  XMLServerLog, LogMessageTypes, XMLRequestUtils,
  ActiveX, AppVarsObj, XMLServerControlConst, Dialogs;

type
  TCheckLibResult = (libOk, libNotInList, libCantLoadDll);

const
  SecondsPerDay = 24 *60 *60;

var
  splitList: TStringList;
  { functin call to all dlls }
  ExecuteFunc: TExecute;

function CheckLib(Const aLibName: string; Const cmdSrv: TXMLCmdSrv): TCheckLibResult;
var dllItem: TDllMgrItem;
begin
  result:= libOk;
  dllItem:= cmdSrv.DllMgr.ItemByName[aLibName];
  if Assigned(dllItem) then begin
    if not dllItem.Loaded then begin
      cmdSrv.Lock;
      try
        if not dllItem.Load then begin
          result:= libCantLoadDll;
          exit;
        end
      finally
        cmdSrv.Unlock;
      end;
    end;
    @ExecuteFunc:= GetProcAddress(dllItem.Handle, 'Execute');
  end
  else
    result:= libNotInList;
end;

function GetNewTicket: string;
var
  x: integer;

  function RandChar: Char;
  var i: integer;
  begin
    i:= 0;
    while not(((i >= Ord('0')) and (i <= Ord('9'))) or
              ((i >= Ord('A')) and (i <= Ord('Z'))) or
              ((i >= Ord('a')) and (i <= Ord('z')))) do
      i:= Random(Ord('z'));
    result:= Chr(i);
  end;

begin
  result:= '';
  Randomize;
  for x:= 1 to 15 do
    result:= result + RandChar;
end;

function ValidateAuthCode(Const authCode: string): boolean;
begin
  result:= true;
end;

function ProcessXMLRequest(const inStr: string; var outStr: string; cmdSrv: TXMLCmdSrv): boolean;
var
  inDoc, outDoc: TALXMLDocument;
  node, inNode, outNode, outBlock, inBlock, requestNode, responceNode: TALXMLNode;
  ticket: string;
  cmdThread: TAppInstThread;
  authCode: string;
  StartTime: TDateTime;

  procedure ProcessRequest;
  begin
    cmdThread.InNode:= inNode;
    cmdThread.OutNode:= outNode;
    cmdThread.WorkDoneSignal.ResetEvent;  { make sure this is not set }
    cmdThread.DoWork;
    while not cmdThread.WorkDone do begin
      sleep(10);
    end;
//    case cmdThread.WorkDoneSignal.WaitFor(INFINITE) of
//      wrSignaled:
//        begin
//          { thread signaled that work was done }
//          Log('ProcessRequest - Work done OK', ltInfo);
//        end;
//      wrTimeout:
//        begin
//          Log('ProcessRequest - Work done timeout', ltError);
//        end;
//      wrAbandoned:
//        begin
//          Log('ProcessRequest - Work done abandoned', ltError);
//        end;
//      wrError:
//        begin
//          Log('ProcessRequest - Work done error', ltError);
//        end;
//    end;
  end;

  function FirstRequestNode(aParent: TALXMLNode): TALXMLNode;
  var i: integer;
  begin
    result:= nil;
    for i:= 0 to aParent.ChildNodes.Count -1 do begin
      { ignore comment nodes }
      if (aParent.ChildNodes[i].NodeType <> ntComment) then begin
        { is it a request node }
        if aParent.ChildNodes[i].NodeName = XMLNodeRequest then begin
          result:= aParent.ChildNodes[i];
          break;
        end;
      end;
    end;
  end;

  function AquireWorkerThread(Const aTicket: string): TAppInstThread;
  begin
    result:= nil;
    try
      result:= cmdSrv.AquireThread(ticket);
      if not Assigned(result) then begin
        { no thread found for this tread ... seasion is dead }
        responceNode:= FindAddChild(outBlock,XMLNodeResponce);
        responceNode.Attributes[XMLAttResult]:= XMLResultFail;
        responceNode.Attributes[XMLAttFailReason]:= XMLFailReasonDeadSession;
        responceNode.AddChild(XMLNodeDesc).Text:= FmtRespStr('No Session found for Ticket');
        Log('AquireWorkerThread - No Session found for Ticket', ltWarning);
      end;
    except
      on e: Exception do begin
        responceNode:= FindAddChild(outBlock,XMLNodeResponce);
        responceNode.Attributes[XMLAttResult]:= XMLResultFail;
        if e is EXMLCmdSrvMaxThreadCountExceededException then begin
          responceNode.Attributes[XMLAttFailReason]:= XMLFailReasonMaxSessionCountExceeded;
        end
        else if e is EXMLCmdSrvThreadAllreadyAqiredException then begin
          responceNode.Attributes[XMLAttFailReason]:= XMLFailReasonSessionThreadAlreadyInUse;
        end
        else begin
          responceNode.Attributes[XMLAttFailReason]:= XMLFailReasonGeneral;
        end;
        responceNode.AddChild(XMLNodeDesc).Text:= FmtRespStr(e.Message);
        Log('AquireWorkerThread - ' + e.Message, ltError);
      end;
    end;
  end;

begin
  result:= false;
  if not cmdSrv.Active then
    exit;
  StartTime:= now;
  { is input text valid xml ... }
  Log('ProcessXMLRequest - Start', ltDetail);
  Log('ProcessXMLRequest - Input string = ' + #13#10 + inStr, ltDetail);
  outBlock:= nil;
  if PosEx(XMLNodeRoot,inStr) > 0 then begin

    inDoc:= TALXMLDocument.Create('');
    outDoc:= TALXMLDocument.Create('') ;
    try
      outDoc.Active:= true;
      outDoc.Version:= XMLDocVersion;
      outDoc.Encoding:= XMLDocEncoding;
      {ToDo: remove the following option for production }
      outDoc.Options := outDoc.Options + [doNodeAutoIndent];
      outNode:= outDoc.AddChild(XMLNodeRoot);
      outBlock:= outNode.AddChild(XMLNodeBlock);
      result:= true;
      { try loading the input document ... the inDoc object will pars the XML
        and throw an error if there is a problem with the formatting }
      try
        inDoc.LoadFromXML(inStr);
        inNode:= inDoc.ChildNodes.FindNode(XMLNodeRoot);
        if not Assigned(inNode) then
          raise Exception.Create('Misssing "' + XMLNodeRoot + '" node in XML' );
        inBlock:= inNode.ChildNodes.FindNode(XMLNodeBlock);
        if not Assigned(inBlock) then
          raise Exception.Create('Misssing "' + XMLNodeBlock + '" node in XML' );
      except
        { somthing wrong with xml format }
        on E: Exception do begin
          responceNode:= FindAddChild(outBlock,XMLNodeResponce);
          responceNode.Attributes[XMLAttResult]:= XMLResultFail;
          responceNode.Attributes[XMLAttFailReason]:= XMLFailReasonXMLInvalid;
          responceNode.AddChild(XMLNodeDesc).Text:= FmtRespStr(E.Message);
          Log('ProcessXMLRequest - ' + E.Message, ltError);
          exit;
        end;
      end;
      { loaded input doc ok ... }

      try
        { now is this an existing session ie has client passed a ticket }
        ticket:= '';
        if not VarIsNull(inBlock.Attributes[XMLAttTicket]) then
          ticket:= inBlock.Attributes[XMLAttTicket];
        { has ticket, find matching thread to service request }
        if ticket = '' then begin
          { no ticket }
          { is this a session start request ? }
          { get the first request file in the block }
          requestNode:= FirstRequestNode(inBlock);
          if Assigned(requestNode) then begin
            if NodeAttStr(requestNode, XMLAttCommand) = XMLCmdStartSession then begin
              authCode:= '';
              node:= requestNode.ChildNodes.FindNode(XMLNodeAuthCode);
              if Assigned(node) then
                authCode:= node.Text;
              if authCode <> '' then begin
                if ValidateAuthCode(authCode) then begin
                  { allocate a new session ticket and create a new session thread }
                  { continues below ... }
                  Log('ProcessXMLRequest - New session request', ltDetail);
                  cmdThread:= AquireWorkerThread('');
                  if not Assigned(cmdThread) then
                    exit;
                  responceNode:= FindAddChild(outBlock,XMLNodeResponce);
                  responceNode.Attributes[XMLAttCommand]:= XMLCmdStartSession;
                  responceNode.Attributes[XMLAttResult]:= XMLResultOk;
                  responceNode.AddChild(XMLNodeTicket).Text:= cmdThread.Ticket;
                  Log('ProcessXMLRequest - Start session request, ticket = "' + ticket + '"', ltDetail);
                end
                else begin
                  { invalid authCode }
                  responceNode:= FindAddChild(outBlock,XMLNodeResponce);
                  responceNode.Attributes[XMLAttResult]:= XMLResultFail;
                  responceNode.Attributes[XMLAttFailReason]:= XMLFailReasonInvalidAuthCode;
                  responceNode.AddChild(XMLNodeDesc).Text:= FmtRespStr('Invalid AuthCode');
                  Log('ProcessXMLRequest - Invalid AuthCode "' + authCode + '"', ltWarning);
                  exit;
                end;
              end
              else begin
                { missing or blank auth code }
                responceNode:= FindAddChild(outBlock,XMLNodeResponce);
                responceNode.Attributes[XMLAttResult]:= XMLResultFail;
                responceNode.Attributes[XMLAttFailReason]:= XMLFailReasonNoAuthCode;
                responceNode.AddChild(XMLNodeDesc).Text:= FmtRespStr('AuthCode not found');
                Log('ProcessXMLRequest - AuthCode not found "' + authCode + '"', ltWarning);
                exit;
              end;
            end
            else begin
              { session start not found }
              responceNode:= FindAddChild(outBlock,XMLNodeResponce);
              responceNode.Attributes[XMLAttResult]:= XMLResultFail;
              responceNode.Attributes[XMLAttFailReason]:= XMLFailReasonNoSessionStart;
              responceNode.AddChild(XMLNodeDesc).Text:= FmtRespStr('No session start request found');
              Log('ProcessXMLRequest - No session start request found', ltWarning);
              exit;
            end;
          end
          else begin
            { no request }
            responceNode:= FindAddChild(outBlock,XMLNodeResponce);
            responceNode.Attributes[XMLAttResult]:= XMLResultFail;
            responceNode.Attributes[XMLAttFailReason]:= XMLFailReasonRequestInvalid;
            responceNode.AddChild(XMLNodeDesc).Text:= FmtRespStr('No request node found');
            Log('ProcessXMLRequest - No request node found', ltWarning);
            exit;
          end;
        end;
        if not Assigned(cmdThread) then
          cmdThread:= AquireWorkerThread(ticket);
        if Assigned(cmdThread) then begin
          { is this a end session request ? }
          requestNode:= inBlock.ChildNodes.FindNode(XMLNodeRequest);
          if Assigned(requestNode) then begin
            ProcessRequest;
          end
          else begin
            { no request node }
            responceNode:= FindAddChild(outBlock,XMLNodeResponce);
            responceNode.Attributes[XMLAttResult]:= XMLResultFail;
            responceNode.Attributes[XMLAttFailReason]:= XMLFailReasonNoRequest;
            responceNode.AddChild(XMLNodeDesc).Text:= FmtRespStr('No request found');
            Log('ProcessXMLRequest - No request found', ltWarning);
          end;
        end;
      finally
        if Assigned(cmdThread) then
          cmdSrv.ReleaseThread(cmdThread);
      end;


      if Assigned(inBlock) and
         (NodeAttStr(inBlock,XMLAttRequestTiming) = XMLRequestTimingOn) then begin
        if Assigned(outBlock) then
          outBlock.Attributes[XMLAttRequestTiming]:= FormatDateTime('hh:nn:ss:zzz', now - StartTime);
      end;

    finally
      outDoc.SaveToXML(outStr);
      if outStr = '' then
        outStr:= 'Fail';
      inDoc.Free;
      outDoc.Free;
    end;
  end
  else
    Log('ProcessXMLRequest - Root XML node not found in request', ltWarning);
  Log('ProcessXMLRequest - Output string = ' + #13#10 + outStr, ltDetail);
end;


{ TXMLCmdSrv }

constructor TXMLCmdSrv.Create;
begin
  inherited;
  Log('TXMLCmdSrv.Create - Command server starting', ltDetail);
//  if not Assigned(AppVars) then begin
//    AppVars:= TAppVars.Create;
//    AppVars.SaveOnChange:= true;
//    AppVars.EncryptFile:= true;
//    AppVars.LoadFromFile();
//  end;
  AppVars.SetDefault('MaxThreadCount','0'); { default - no limit }
  AppVars.SetDefault('SessionTimeoutSeconds','600'); { default - 10 minutes }
  fSessionTimeoutSeconds:= AppVars.IntVar['SessionTimeoutSeconds'];
  fThreadList:= TThreadList.Create;
  fLock:= TCriticalSection.Create;

  fSessionTimer:= TTimer.Create(nil);
  fSessionTimer.OnTimer:= self.DoOnSessionTimer;
  fSessionTimer.Interval:= 5000;
  fSessionTimer.Enabled:= true;
end;

destructor TXMLCmdSrv.Destroy;
begin
  Log('TXMLCmdSrv.destroy - Command server shutting down', ltDetail);
  fSessionTimer.Enabled:= false;
  KillAll;
  fThreadList.Free;
  fDllMgr.Free;
  fLock.Free;
  inherited;
end;

procedure TXMLCmdSrv.DoOnSessionTimer(Sender: TObject);
var
  List: TList;
  x: integer;
  idleSeconds: double;
begin
  fSessionTimer.Enabled:= false;
  try
    List:= fThreadList.LockList;
    try
//      Log('TXMLCmdSrv.DoOnSessionTimer - Checking for timed-out sessions, total session count: ' + IntToStr(List.Count),ltDetail);
      for x:= 0 to List.Count-1 do begin
        if (not TAppInstThread(List[x]).Terminated) and
           TAppInstThread(List[x]).WorkDone then begin
          idleSeconds:= (now - TAppInstThread(List[x]).LastUsed) * SecondsPerDay;
//          Log('TXMLCmdSrv.DoOnSessionTimer - thread: ' + IntToStr(TAppInstThread(List[x]).ThreadID) +
//            ' has been idle for: ' + FloatToStr(idleSeconds) + ' seconds.', ltDetail);
          if (idleSeconds >= SessionTimeoutSeconds) then begin
            Log('TXMLCmdSrv.DoOnSessionTimer - Session has timed out for ticket "' +
              TAppInstThread(List[x]).Ticket + '" ' +
              ' Last accessed at ' + FormatDateTime('dd/mm/yy hh:nn:ss', TAppInstThread(List[x]).LastUsed) +
              ' timout seconds set to ' + IntToStr(SessionTimeoutSeconds),ltDetail);
            TAppInstThread(List[x]).Die;
          end;
        end;
      end;
    finally
      fThreadList.UnlockList;
    end;  
  finally
    fSessionTimer.Enabled:= true;
  end;
end;

procedure TXMLCmdSrv.DoOnTerminate(Sender: TObject);
var
  List: TList;
begin
  List:= fThreadList.LockList;
  try
    Log('TXMLCmdSrv.DoOnTerminate - Deleting thread from list with Id: ' + IntToStr(TThread(Sender).ThreadID), ltDetail);
    List.Delete(List.IndexOf(Sender));
    if Assigned(fEventQueue) then
      fEventQueue.FireEvent(self,eventThreadRemoved, IntToStr(List.Count));
  finally
    fThreadList.UnlockList;
  end;
end;

procedure TXMLCmdSrv.Lock;
begin
  fLock.Acquire;
end;

procedure TXMLCmdSrv.KillAll;
var
  List: TList;
  x: integer;

  function stopped: boolean;
  begin
    List:= fThreadList.LockList;
    try
      x:= 0;
      while x < List.Count do begin
        if TAppInstThread(List[x]).Terminated and TAppInstThread(List[x]).WorkDone then begin
          Log('TXMLCmdSrv.KillAll - Deleting thread from list with Id: ' + IntToStr(TAppInstThread(List[x]).ThreadID), ltDetail);
          List.Delete(x);
          if Assigned(fEventQueue) then
             fEventQueue.FireEvent(self,eventThreadRemoved, IntToStr(List.Count));
        end
        else
          Inc(x);
      end;

      result:= List.Count = 0;
    finally
      fThreadList.UnlockList;
    end;
  end;

begin
  List:= fThreadList.LockList;
  try
    Log('TXMLCmdSrv.KillAll - Number of threads to terminate: ' +IntToStr(List.Count), ltDetail);
    for x:= 0 to List.Count -1 do begin
      { we are going to remove from list }
      Log('TXMLCmdSrv.KillAll - Killing thread with Id: ' + IntToStr(TAppInstThread(List[x]).ThreadID), ltDetail);
      TAppInstThread(List[x]).OnTerminate:= nil;
      TAppInstThread(List[x]).Die;
    end;
  finally
    fThreadList.UnlockList;
  end;
  Sleep(100);
  while not Stopped do begin
    Sleep(100);
    Application.ProcessMessages;
  end;  
  Log('TXMLCmdSrv.KillAll - Finished', ltDetail);
end;

function TXMLCmdSrv.ThreadByTicket(const aTicket: string; List: TList): TAppInstThread;
var
  x: integer;
begin
  Log('TXMLCmdSrv.ThreadByTicket - Looking for thread with ticket: "' + aTicket + '"',ltDetail);
  result:= nil;
  for x:= 0 to List.Count -1 do begin
    if TAppInstThread(List[x]).Ticket = aTicket then begin
      result:= TAppInstThread(List[x]);
      break;
    end;
  end;
  if Assigned(result) then
    Log('TXMLCmdSrv.ThreadByTicket - found thread',ltDetail)
  else
    Log('TXMLCmdSrv.ThreadByTicket - thread not found',ltDetail)
end;

procedure TXMLCmdSrv.Unlock;
begin
  fLock.Release;
end;

function TXMLCmdSrv.AquireThread(const aTicket: string): TAppInstThread;
var
  List: TList;
begin
  Log('TXMLCmdSrv.AquireThread - Looking for thread with ticket: "' + aTicket + '"',ltDetail);
  result:= nil;
  List:= fThreadList.LockList;
  try
    if aTicket <> '' then begin
      result:= self.ThreadByTicket(aTicket,List);
      if Assigned(result) then begin
        if not result.Aquired then begin
          result.Aquired:= true;
          Log('TXMLCmdSrv.AquireThread - Found thread with ticket: "' + aTicket + '"',ltDetail);
        end
        else begin
          { this tread already aquired }
          result:= nil;
          Log('TXMLCmdSrv.AquireThread - Thread already aquired by another process',ltError);
          raise EXMLCmdSrvThreadAllreadyAqiredException.Create('Thread already aquired by another process');
        end;
      end
      else begin
        { not found for this ticket }
        { return nil }
      end;
    end
    else begin
      { no ticket, add a new thread }
      if fActive then begin
        if (MaxThreadCount > 0) and (List.Count >= MaxThreadCount) then begin
          Log('TXMLCmdSrv.AquireThread - Max thread count limit reached',ltError);
          raise EXMLCmdSrvMaxThreadCountExceededException.Create('Max thread count limit reached');
        end;
        result:= TAppInstThread.Create;
        result.OnTerminate:= self.DoOnTerminate;
        result.Ticket:= self.GetNewTicket;
        result.Aquired:= true;
        result.CommandServer:= self;
        List.Add(result);
        if Assigned(fEventQueue) then
          fEventQueue.FireEvent(self,eventThreadAdded, IntToStr(List.Count));
        Log('TXMLCmdSrv.AquireThread - Created new thread with ticket: "' + result.Ticket + '"',ltDetail);
      end;
    end;
  finally
    fThreadList.UnlockList;
  end;
end;

procedure TXMLCmdSrv.ReleaseThread(aThread: TAppInstThread);
var
  List: TList;
  x: integer;
begin
  Log('TXMLCmdSrv.ReleaseThread',ltDetail);
  List:= fThreadList.LockList;
  try
    x:= List.IndexOf(aThread);
    if x >= 0 then begin
      aThread.Aquired:= false;
      Log('TXMLCmdSrv.ReleaseThread - Released thread with ticket: "' +
        TAppInstThread(List[x]).Ticket + '"',ltDetail);

      if aThread.TerminateOnDone then begin
        Log('TXMLCmdSrv.ReleaseThread - TerminateOnDone = true, killing thread',ltDetail);
        aThread.Die;
      end;
    end
    else begin
      { trad not found in list }
      Log('TXMLCmdSrv.ReleaseThread - Thread not found in list',ltWarning);
    end;
  finally
    fThreadList.UnlockList;
  end;
end;

function TXMLCmdSrv.GetNewTicket: string;
var
  x: integer;

  function RandChar: Char;
  var i: integer;
  begin
    i:= 0;
    while not(((i >= Ord('0')) and (i <= Ord('9'))) or
              ((i >= Ord('A')) and (i <= Ord('Z'))) or
              ((i >= Ord('a')) and (i <= Ord('z')))) do
      i:= Random(Ord('z'));
    result:= Chr(i);
  end;

begin
  result:= '';
  Randomize;
  for x:= 1 to 15 do
    result:= result + RandChar;
end;

function TXMLCmdSrv.GetDllMgr: TDllMgr;
begin
  if not Assigned(fDllMgr) then begin
    fDllMgr:= TDllMgr.Create;
    fDllMgr.Add('APIDLL.dll','terp');
  end;
  result:= fDllMgr;
end;

procedure TXMLCmdSrv.SetActive(const Value: boolean);
begin
  fActive := Value;
  if not Value then
    self.KillAll;
end;

procedure TXMLCmdSrv.SetMaxThreadCount(const Value: integer);
begin
  Log('TXMLCmdSrv.SetMaxThreadCount - Value = ' + IntToStr(Value), ltDetail);
  AppVars.IntVar['MaxThreadCount']:= value;
end;

procedure TXMLCmdSrv.SetSessionTimeoutSeconds(const Value: integer);
begin
  fSessionTimeoutSeconds := Value;
  AppVars.IntVar['SessionTimeoutSeconds']:= value;
end;

function TXMLCmdSrv.GetThreadCount: integer;
var
  List: TList;
begin
  List:= fThreadList.LockList;
  try
    result:= List.Count;
  finally
    fThreadList.UnlockList;
  end;
end;

function TXMLCmdSrv.GetMaxThreadCount: integer;
begin
  result:= AppVars.IntVar['MaxThreadCount'];
end;

{ TAppInstThread }

constructor TAppInstThread.Create; //(CreateSuspended: boolean);
begin
  inherited Create(true);
  fTerminateOnDone:= false;
  fWorkDone:= false;
  fAquired:= false;
  FreeOnTerminate:= true;
  fLastUsed:= now;
  fSignal:= TSimpleEvent.Create;
  fWorkDoneSignal:= TSimpleEvent.Create;
  Resume;
  Log('TAppInstThread.Create - new thread created, thread id = ' + IntToStr(self.ThreadID), ltDetail);
end;

destructor TAppInstThread.Destroy;
begin
  Log('TAppInstThread.Destroy - thread destroyed. Thread id = ' + IntToStr(Self.ThreadID) +
      ' ticket = "'+ self.Ticket + '"', ltDetail);
  fSignal.Free;
  fWorkDoneSignal.Free;
  inherited;
end;

procedure TAppInstThread.Die;
begin
  try
    Terminate;
    FSignal.SetEvent;
  except on EAccessViolation do
    {There is a very slight chance that the thread has already self-
     destructed when we try to set the signal. That could result in
     an access violation. Ignore that here. }
  end;
end;

procedure TAppInstThread.DoWork;
begin
  Log('TAppInstThread.DoWork - Thread id = ' + IntToStr(Self.ThreadID) +
      ' ticket = "'+ self.Ticket + '"', ltDetail);
  fWorkDone:= false;
  fSignal.SetEvent;
end;

procedure TAppInstThread.Execute;
begin
  try
    repeat
      if (fSignal.WaitFor(INFINITE) <> wrSignaled) then exit;
      if terminated then exit;
      fSignal.ResetEvent;
      try
        ProcessRequest;
      finally
        Log('TAppInstThread.Execute - Finished processing request. Thread id = ' + IntToStr(Self.ThreadID) +
          ' ticket = "'+ self.Ticket + '"', ltDetail);
        fWorkDone:= true;
        self.FWorkDoneSignal.SetEvent;
      end;
    until false;
  finally
    fWorkDone:= true;
  end;    
  Log('TAppInstThread.Execute - thread terminating. Thread id = ' + IntToStr(Self.ThreadID) +
      ' ticket = "'+ self.Ticket + '"', ltDetail);
end;

procedure TAppInstThread.ProcessRequest;
var
  inBlock, outBlock: TALXMLNode;
  requestNode, responceNode: TALXMLNode;
  command: string;
  x: integer;
  requestFound: boolean;
begin
  Log('TAppInstThread.ProcessRequest - processing request. Thread id = ' + IntToStr(Self.ThreadID) +
      ' ticket = "'+ self.Ticket + '"', ltDetail);
  outBlock:= nil;
  requestNode:= nil;
  try
    fLastUsed:= now;
    requestFound:= false;
    inBlock:= self.fInNode.ChildNodes.FindNode(XMLNodeBlock);
    outBlock:= self.fOutNode.ChildNodes.FindNode(XMLNodeBlock);
    for x:= 0 to inBlock.ChildNodes.Count -1 do begin
      requestNode:= inBlock.ChildNodes[x];
      if (requestNode.NodeType <> ntComment) and (requestNode.NodeName = XMLNodeRequest) then begin
        requestFound:= true;
        command:= NodeAttStr(requestNode, XMLAttCommand);
        if command = XMLCmdStartSession then begin
          { ignore - this is handled above by ProcessXMLRequest }

        end
        else if command = XMLCmdEndSession then begin
          fTerminateOnDone:= true;
          AddResponceNode(outBlock,requestNode,XMLResultOk);
          Log('TAppInstThread.ProcessRequest - End session request', ltDetail);
        end
        else begin

          { find an external library(dll) to handle the command }
          FastFuncs.Split(command,'.',splitlist);
          if splitList.Count > 1 then begin
            case CheckLib(splitList[0],self.CommandServer) of
             libOk:
               begin
                 Log('TAppInstThread.ProcessRequest - Request for library: ' + splitlist[0], ltDetail);
                 if splitList[1] = XMLCmdExecute then begin
                   responceNode:= AddResponceNode(outBlock,requestNode);
                   { hand over processing of this command to  }
                   Log('TAppInstThread.ProcessRequest - About to call Coinitialize', ltDetail);
                   Log('TAppInstThread.ProcessRequest - Calling Excute for library: ' + splitlist[0], ltDetail);
                   ExecuteFunc(requestNode, responceNode, Application);
                 end
                 else begin
                   responceNode:= AddResponceNode(outBlock,requestNode,XMLResultFail,XMLFailReasonUnknownCommand,
                                   '','Unknown command"' + splitList[1] + '"');
                   Log('TAppInstThread.ProcessRequest - ' + responceNode.ChildNodes[0].Text, ltError);
                 end;
               end;
             libNotInList:
               begin
                 responceNode:= AddResponceNode(outBlock,requestNode,XMLResultFail,XMLFailReasonLibNotFound,
                                 '','Library "' + splitList[0] + '" not found in list of loaded librarys');
                 Log('TAppInstThread.ProcessRequest - ' + responceNode.ChildNodes[0].Text, ltError);
               end;
             libCantLoadDll:
               begin
                 responceNode:= AddResponceNode(outBlock,requestNode,XMLResultFail,XMLFailReasonDllLoadFail,
                                 '','Library load failed "' + splitList[0] + '"');
                 Log('TAppInstThread.ProcessRequest - ' + responceNode.ChildNodes[0].Text, ltError);
               end;
            end;
          end
          else begin
            AddResponceNode(outBlock,requestNode,XMLResultFail,XMLFailReasonUnknownCommand,'','Unknown command');
            Log('TAppInstThread.ProcessRequest - Unknown command', ltError);
          end
        end;
      end
    end;
    if not requestFound then begin
      AddResponceNode(outBlock,requestNode,XMLResultFail,XMLFailReasonNoRequest,'','No request found');
      Log('TAppInstThread.ProcessRequest - No request found', ltWarning);
    end;
  except
    on e: Exception do begin
      AddResponceNode(outBlock,requestNode,XMLResultFail,XMLFailReasonException,'','Request failed with message: ' + e.Message);
      Log('TAppInstThread.ProcessRequest - Request failed with message: ' + e.Message, ltError);
    end;
  end;
end;

initialization
  splitList:= TStringList.Create;

finalization
  splitList.Free;

end.
