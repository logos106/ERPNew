unit datXMLServer;

interface

uses
  SysUtils, Classes, XMLCmdSrvObj, IdBaseComponent, IdComponent,
  IdTCPServer, IdAntiFreezeBase, IdAntiFreeze, MultiEventObj,
  IdServerIOHandler, IdSSLOpenSSL;

type

  TdmXMLServer = class(TDataModule)
    TCPServer: TIdTCPServer;
    IdAntiFreeze1: TIdAntiFreeze;
    IoHandlerSSL: TIdServerIOHandlerSSL;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure TCPServerConnect(AThread: TIdPeerThread);
    procedure TCPServerDisconnect(AThread: TIdPeerThread);
    procedure TCPServerExecute(AThread: TIdPeerThread);
  private
    CmdServer: TXMLCmdSrv;
    fEventQueue: TQueuedMultiEventClass;
    fShuttingDown: boolean;
//    fAppVarsCreated: boolean;
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    function GetPort: integer;
    procedure SetPort(const Value: integer);
    function GetSessionCount: integer;
    function GetLogMessageTypes: string;
    function GetLogToEvent: boolean;
    function GetLogToFile: boolean;
    procedure SetLogMessageTypes(const Value: string);
    procedure SetLogToEvent(const Value: boolean);
    procedure SetLogToFile(const Value: boolean);
    function GetMaxSessionCount: integer;
    procedure SetMaxSessionCount(const Value: integer);
    function GetSessionTimeoutSeconds: integer;
    procedure SetSessionTimeoutSeconds(const Value: integer);
    procedure DoOnGetPassword(var Password: string);
    function GetUseSSL: boolean;
    procedure SetUseSSL(const Value: boolean);
  public
    property EventQueue: TQueuedMultiEventClass read fEventQueue;
  published
    property Active: boolean read GetActive write SetActive;
    property Port: integer read GetPort write SetPort;
    property UseSSL: boolean read GetUseSSL write SetUseSSL;
    property SessionCount: integer read GetSessionCount;
    property MaxSessionCount: integer read GetMaxSessionCount write SetMaxSessionCount;
    property LogToFile: boolean read GetLogToFile write SetLogToFile;
    property LogToEvent: boolean read GetLogToEvent write SetLogToEvent;
    property LogMessageTypes: string read GetLogMessageTypes write SetLogMessageTypes;
    property SessionTimeoutSeconds: integer read GetSessionTimeoutSeconds write SetSessionTimeoutSeconds; 
  end;

  TXMLPeerThread = class(TIdPeerThread)
  public
    procedure ProcessXMLRequest(cmdSrv: TXMLCmdSrv);
  end;

var
  dmXMLServer: TdmXMLServer;

implementation

{$R *.dfm}

uses
  AppVarsObj, IdSocketHandle, XMLServerLog, LogMessageTypes, IdStack,
  IdTCPConnection, windows, XMLRequestConst, XMLRequestUtils,
  FastFuncs, ALXMLDoc, ActiveX, Variants, IdGlobal, LogThreadLib, ComObj;

const
  CRLF = #13#10;
  ReceiveTimeoutSeconds = 10;

function ValidateAuthCode(Const authCode: string): boolean;
begin
  result:= true;
end;


{ TdmXMLServer }

procedure TdmXMLServer.DataModuleCreate(Sender: TObject);
begin
  inherited;

  fShuttingDown:= false;
  IoHandlerSSL.OnGetPassword:= self.DoOnGetPassword;
  IoHandlerSSL.SSLOptions.Method:= sslvTLSv1;
//  IoHandlerSSL.SSLOptions.Method:= sslvSSLv2;
  IoHandlerSSL.SSLOptions.Mode:= sslmServer;
  IoHandlerSSL.SSLOptions.VerifyMode:= [];

  fEventQueue:= TQueuedMultiEventClass.Create;
  TCPServer.ThreadClass:= TXMLPeerThread;
  TCPServer.CommandHandlersEnabled:= false;
  AppVars.SetDefault('ServerPort','9009');
  AppVars.SetDefault('LogMessageTypes','Error');
  AppVars.SetDefault('UseSSL','True');
  TLogger.Inst.LogMessageTypesCommaText:= AppVars['LogMessageTypes'];

  CmdServer:= TXMLCmdSrv.Create;
  CmdServer.EventQueue:= fEventQueue;
end;

procedure TdmXMLServer.DataModuleDestroy(Sender: TObject);
begin
  CmdServer.Free;
//  if fAppVarsCreated then begin
//    AppVars.Free;
//    AppVars:= nil;
//  end;
  fEventQueue.Free;
  inherited;
end;

procedure TdmXMLServer.DoOnGetPassword(var Password: string);
begin
  Password:= 'aaaa';
end;

function TdmXMLServer.GetActive: boolean;
begin
  result:= TCPServer.Active;
end;

function TdmXMLServer.GetLogMessageTypes: string;
begin
  result:= TLogger.Inst.LogMessageTypesCommaText;
end;

function TdmXMLServer.GetLogToEvent: boolean;
begin
  result:= TLogger.Inst.LogToEvent;
end;

function TdmXMLServer.GetLogToFile: boolean;
begin
  result:= TLogger.Inst.LogToFile;
end;

function TdmXMLServer.GetMaxSessionCount: integer;
begin
  result:= CmdServer.MaxThreadCount;
end;

function TdmXMLServer.GetPort: integer;
begin
  result:= AppVars.IntVar['ServerPort'];
end;

function TdmXMLServer.GetSessionCount: integer;
begin
  result:= CmdServer.ThreadCount;
end;

function TdmXMLServer.GetSessionTimeoutSeconds: integer;
begin
  result:= CmdServer.SessionTimeoutSeconds;
end;

function TdmXMLServer.GetUseSSL: boolean;
begin
  result:= AppVars.BoolVar['UseSSL'];
end;

procedure TdmXMLServer.SetActive(const Value: boolean);
var
  Binding: TIdSocketHandle;
  x: integer;
  appDir: string;
  initialFilePath: string;
  initialBuffer: array[0..260] of char;
begin
  if Value then begin
    if not TCPServer.Active then begin
      try
        CmdServer.Active:= true;
        if UseSSL then begin
          try
            TCPServer.IOHandler:= IoHandlerSSL;
            SetString(initialFilePath, initialBuffer, GetModuleFileName(0, initialBuffer, SizeOf(initialBuffer)));
            appDir:= extractFilePath(initialFilePath);
            IoHandlerSSL.SSLOptions.KeyFile:= appDir + 'sample.key';
            IoHandlerSSL.SSLOptions.CertFile:= appDir + 'sample.crt';
            IoHandlerSSL.SSLOptions.RootCertFile:= appDir + 'sampleRoot.pem';
          except
            on E: Exception do begin
             Log('TdmXMLServer.SetActive - Error setting server SSL options with message: ' + e.Message,ltError);
             CmdServer.Active:= false;
            end;
          end;
        end
        else
          TCPServer.IOHandler:= nil;
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
          Log('TdmXMLServer.SetActive - Adding binding for Address: ' + TCPServer.Bindings[x].IP  +
            '  Port: ' + IntToStr(TCPServer.Bindings[x].Port),ltInfo);

        end;
        TCPServer.Active:= true;
        self.fEventQueue.FireEvent(self,'eventActive','true');
        Log('----- XML Server Started ------------------------------------',ltInfo);
        Log('TdmXMLServer.SetActive - Started XML TCP Server',ltDetail);
      except
        on E: Exception do begin
          Log('TdmXMLServer.SetActive - Error activating server with message: ' + e.Message,ltError);
          TCPServer.Active:= false;
          CmdServer.Active:= false;
        end;
      end;
    end;
  end
  else begin
    { Active = false }
    if TCPServer.Active then begin
      fShuttingDown:= true;
      try
        self.fEventQueue.FireEvent(self,'eventActive','false');
        CmdServer.Active:=false;
        TCPServer.Active:= false;
        Log('----- XML Server Stopped ------------------------------------',ltInfo);
        Log('TdmXMLServer.SetActive - Stopped XML TCP Server',ltDetail);
      finally
        fShuttingDown:= false;
      end;
    end;
  end;
end;

procedure TdmXMLServer.SetLogMessageTypes(const Value: string);
begin
  AppVars[LogMessageTypes]:= Value;
  TLogger.Inst.LogMessageTypesCommaText:= Value;
end;

procedure TdmXMLServer.SetLogToEvent(const Value: boolean);
begin
  TLogger.Inst.LogToEvent:= Value;
end;

procedure TdmXMLServer.SetLogToFile(const Value: boolean);
begin
  TLogger.Inst.LogToFile:= Value;
end;

procedure TdmXMLServer.SetMaxSessionCount(const Value: integer);
begin
  CmdServer.MaxThreadCount:= Value;
  Log('TdmXMLServer.SetMaxSessionCount - Value = ' + IntToStr(Value),ltDetail);
end;

procedure TdmXMLServer.SetPort(const Value: integer);
var
  svrActive: boolean;
begin
  if AppVars.IntVar['ServerPort'] <> Value then begin
    svrActive:= Active;
    Active:= false;
    AppVars.IntVar['ServerPort']:= value;
    Active:= svrActive;
  end;
end;

procedure TdmXMLServer.SetSessionTimeoutSeconds(const Value: integer);
begin
  CmdServer.SessionTimeoutSeconds:= Value;
end;

procedure TdmXMLServer.SetUseSSL(const Value: boolean);
begin
  AppVars.BoolVar['UseSSL']:= Value;
end;

procedure TdmXMLServer.TCPServerConnect(AThread: TIdPeerThread);
begin
  Log('TCPServerConnect - Connect, TCP thread Id = ' + IntToStr(aThread.ThreadID),ltDetail);
  if fShuttingDown then begin
    AThread.Connection.Disconnect;
    Log('TCPServerExecute - Server is shutting down, disconnecting thread',ltDetail);
  end;
end;

procedure TdmXMLServer.TCPServerDisconnect(AThread: TIdPeerThread);
begin
  Log('TCPServerDisconnect - Disconnect, TCP thread Id = ' + IntToStr(aThread.ThreadID),ltDetail);
end;

procedure TdmXMLServer.TCPServerExecute(AThread: TIdPeerThread);
begin
  Log('TCPServerExecute - Start, thread Id = ' + IntToStr(GetCurrentThreadID),ltDetail);
  if not fShuttingDown then
    TXMLPeerThread(AThread).ProcessXMLRequest(CmdServer)
  else
    Log('TCPServerExecute - Server is shutting down, ignoring request',ltDetail);

  Log('TCPServerExecute - Finished',ltDetail);
end;

{ TXMLPeerThread }

procedure TXMLPeerThread.ProcessXMLRequest(cmdSrv: TXMLCmdSrv);
var
  s, inStr, outStr: string;
  inDoc, outDoc: TALXMLDocument;
  node, inNode, outNode, outBlock, inBlock, requestNode, responceNode: TALXMLNode;
  ticket: string;
  cmdThread: TAppInstThread;
  authCode: string;
  StartTime: TDateTime;
  StartTagFound, EndTagFound: boolean;

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

  function FirstRequestNode(Const aParent: TALXMLNode): TALXMLNode;
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
  if not cmdSrv.Active then
    exit;
  StartTime:= now;

  inStr:= '';
  outStr:= '';
  StartTagFound:= false;
  EndTagFound:= false;

  s:= self.Connection.ReadLn(#10,5000);
  if (not StartTagFound) and (Pos(XMLNodeRoot,s) > 0) then
    StartTagFound:= true;
//  while (s <> '') or ((s = '') and (StartTagFound and (not EndTagFound))) do begin
  while not (StartTagFound and EndTagFound) do begin
    inStr:= inStr + s + CRLF;

    s:= self.Connection.ReadLn(#10,5000);
    if (not StartTagFound) and (Pos(XMLNodeRoot,s) > 0) then
      StartTagFound:= true;
    if (not EndTagFound) and (Pos('/'+XMLNodeRoot,s) > 0) then
      EndTagFound:= true;
    if self.Connection.ReadLnTimedOut then
      break;
  end;

  if inStr = '' then
    exit;

  { is input text valid xml ... }
  Log('ProcessXMLRequest - Start', ltInfo);
  Log('ProcessXMLRequest - Input string = ' + #13#10 + inStr, ltDetail);
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
                  Log('ProcessXMLRequest - New session request', ltInfo);
                  cmdThread:= AquireWorkerThread('');
                  if not Assigned(cmdThread) then
                    exit;
                  responceNode:= FindAddChild(outBlock,XMLNodeResponce);
                  responceNode.Attributes[XMLAttCommand]:= XMLCmdStartSession;
                  responceNode.Attributes[XMLAttResult]:= XMLResultOk;
                  responceNode.AddChild(XMLNodeTicket).Text:= cmdThread.Ticket;
                  Log('ProcessXMLRequest - Start session request, ticket = "' + ticket + '"', ltInfo);
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
        outStr:=
          '<'+XMLNodeRoot+'>' + CRLF +
          '<'+XMLNodeBlock+'>' + CRLF +
          '<'+XMLNodeResponce + ' ' + XMLAttResult + '="'+XMLResultFail+'"></'+XMLNodeResponce+'>' + CRLF +
          '</'+XMLNodeBlock+'>' + CRLF +
          '</'+XMLNodeRoot+'>';
      inDoc.Free;
      outDoc.Free;
      self.Connection.WriteLn(outStr);
    end;
  end
  else
    Log('ProcessXMLRequest - Root XML node not found in request', ltWarning);
  Log('ProcessXMLRequest - Output string = ' + #13#10 + outStr, ltDetail);
end;

end.
