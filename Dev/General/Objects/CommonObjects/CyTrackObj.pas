unit CyTrackObj;

interface

uses
  IdTCPServer, IdContext, LogThreadBase, LogMessageTypes, Classes, JsonObject,
  XMLIntf, XMLDoc, ActiveX, MultiEventObj, SyncObjs;

type

  TCyTrackEvent = procedure (const EventName: string; data: TJsonObject) of object;

  TCyTrack = class
  private
    fLastMessageStr: string;
    Server: TIdTcpServer;
    fOnCyTrackEvent: TCyTrackEvent;
    fCyTrackPort: integer;
    fCalledID: string;
    fCallerID: string;
    fStatus: string;
    fCallDirection: string;
    fOnStatusChange: TNotifyEvent;
    fEvents: TMultiEventClass;
    fLock: TCriticalSection;
    fConnected: boolean;
    InStream: TStringStream;
    procedure DoServerExecute(AContext: TIdContext);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    procedure SetServerPort(const Value: integer);
    function GetServerPort: integer;
    procedure ProcessMessage;
    procedure XMLToJson(aNode: IXMLNode; json: TJsonObject);
    procedure SetCyTrackPort(const Value: integer);
    procedure DoOnConnect(AContext: TIdContext);
    procedure DoOnDisconnect(AContext: TIdContext);
    function GetConnected: boolean;
  public
    Logger: TLoggerBase;
    procedure Log(const aMsg: string; const LogMessageType: TLogMessageType = ltBlank);
    constructor Create;
    destructor Destroy; override;
    property ServerPort: integer read GetServerPort write SetServerPort;
    property Active: boolean read GetActive write SetActive;
    property OnCyTrackEvent: TCyTrackEvent read fOnCyTrackEvent write fOnCyTrackEvent;
    property CyTrackPort: integer read fCyTrackPort write SetCyTrackPort;
    procedure SendMessage(const msg: string);
    property CallerID: string read fCallerID;
    property CalledID: string read fCalledID;
    property CallDirection: string read fCallDirection;
    property Status: string read fStatus;
    property OnStatusChange: TNotifyEvent read fOnStatusChange write fOnStatusChange;
    procedure MakeCall(const PhoneNumber: string);
    class function Inst: TCyTrack;
    property Events: TMultiEventClass read fEvents;
    property Connected: boolean read GetConnected;
  end;

implementation

uses
  SysUtils, DateTimeUtils, Variants, JsonObjectUtils, IdSync;

var
  fCyTrack: TCyTrack;


function WTSGetActiveConsoleSessionId: THandle; external 'Kernel32.dll' name 'WTSGetActiveConsoleSessionId';

{ TCyTrack }

constructor TCyTrack.Create;
begin
  fLock := TCriticalSection.Create;
  InStream := TStringStream.Create;
  fConnected := false;
  fCalledID := '';
  fCallerID := '';
  fStatus := 'Idle';
  fCallDirection := '';

  fLastMessageStr := '';
  fEvents := TMultiEventClass.Create;
  Server := TIdTcpServer.Create(nil);
  Server.OnExecute := DoServerExecute;
  Server.OnConnect := DoOnConnect;
  Server.OnDisconnect := DoOnDisconnect;
//  Server.MaxConnections := 1;
  CyTrackPort := 9015;
end;

destructor TCyTrack.Destroy;
begin
  Server.Free;
  fEvents.Free;
  fLock.Free;
  InStream.Free;
  inherited;
end;

procedure TCyTrack.DoOnConnect(AContext: TIdContext);
begin
  fLock.Acquire;
  try
    fConnected := true;
  finally
    fLock.Release;
  end;
end;

procedure TCyTrack.DoOnDisconnect(AContext: TIdContext);
begin
  fLock.Acquire;
  try
    fConnected := false;
  finally
    fLock.Release;
  end;
end;

procedure TCyTrack.DoServerExecute(AContext: TIdContext);
var
  s: string;
begin
  if AContext.Connection.Connected then begin
    if AContext.Connection.IOHandler.InputBufferIsEmpty then begin
      sleep(15);
      exit;
    end;
    fLock.Acquire;
    try
      InStream.Clear;
      AContext.Connection.IOHandler.ReadTimeout := 2000;
      s:= AContext.Connection.IOHandler.ReadLn; // ReadStream(stream);
      while s <> '' do begin
        InStream.WriteString(s);
        s:= AContext.Connection.IOHandler.ReadLn;
      end;
      InStream.Position := 0;
      //Log(stream.DataString);
      TIdSync.SynchronizeMethod(ProcessMessage);
    finally
      fLock.Release;
    end;
  end;
end;

function TCyTrack.GetActive: boolean;
begin
  result:= Server.Active;
end;

function TCyTrack.GetConnected: boolean;
begin
  fLock.Acquire;
  try
    result := fConnected;
  finally
    fLock.Release;
  end;
end;

function TCyTrack.GetServerPort: integer;
begin
  result := Server.DefaultPort;
end;

class function TCyTrack.Inst: TCyTrack;
begin
  if not Assigned(fCyTrack) then
    fCyTrack := TCyTrack.Create;
  result := fCyTrack;
end;

procedure TCyTrack.Log(const aMsg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(Logger) then
    Logger.Log(aMsg,LogMessageType);
end;

procedure TCyTrack.MakeCall(const PhoneNumber: string);
var
  s: string;
begin
  s:= StringReplace(PhoneNumber,' ','',[rfReplaceAll]);
  SendMessage('<MakeCall PhoneNumber="' + s + '"/>');
end;

procedure TCyTrack.ProcessMessage;
var
  data: TJsonObject;
  doc: IXMLDocument;
begin
  doc := TXMLDocument.Create(nil);
  data := nil;
  Coinitialize(nil);
  try
    doc.LoadFromStream(InStream);
    doc.Active := true;
    data := JO;
    XMLToJson(doc.DocumentElement,data);
    if not SameText(fLastMessageStr,data.AsString) then begin
      fLastMessageStr := data.AsString;

      if SameText(data.Items[0].Name,'CallData') then begin

        fCallDirection := data.O['CallData'].S['Direction'];
        if SameText(fCallDirection,'IN') then
          fCallerID := data.O['CallData'].S['CallerId']
        else if SameText(fCallDirection,'OUT') then
          fCalledID := data.O['CallData'].S['CalledId'];
        fStatus := data.O['CallData'].S['Status'];
        if SameText(fStatus,'Idle') then begin
          fCalledID := '';
          fCallerID := '';
          fCallDirection := '';
        end;

        if Assigned(fOnStatusChange) then
          fOnStatusChange(self);

        Events.FireEvent(self,'OnStatusChange','');
      end;

      if Assigned (fOnCyTrackEvent) then begin
        fOnCyTrackEvent(data.Items[0].Name,data);
      end;
      Events.FireEvent(data,'OnCyTrackEvent','');
    end
    else begin
      { duplicate message }
    end;
  finally
    doc := nil;
    CoUninitialize;
    data.Free;
  end;
end;

procedure TCyTrack.SendMessage(const msg: string);
var
  List: TList;
  x: integer;
  Context: TIdContext;
begin
  List := Server.Contexts.LockList;
  try
    for x:= 0 to List.Count -1 do begin
      Context := List[x];
      Context.Connection.IOHandler.Write(msg);
    end;
  finally
    Server.Contexts.UnlockList;
  end;
end;

procedure TCyTrack.SetActive(const Value: boolean);
begin
  Server.Active := Value;
end;

procedure TCyTrack.SetCyTrackPort(const Value: integer);
var
  SessionId: integer;
begin
  if fCyTrackPort <> Value then begin
    fCyTrackPort := Value;
    SessionId := WTSGetActiveConsoleSessionId;
    ServerPort:= fCyTrackPort + SessionId;
  end;
end;

procedure TCyTrack.SetServerPort(const Value: integer);
var
  SaveActive: boolean;
begin
  if Server.DefaultPort <> Value then begin
    SaveActive := Active;
    try
      Active := false;
      Server.Bindings.Clear;
      Server.DefaultPort := Value;
    finally
      Active := SaveActive;
    end;
  end;
end;

procedure TCyTrack.XMLToJson(aNode: IXMLNode; json: TJsonObject);
var
  subJson: TJsonObject;
  x: integer;
begin
  if SameText(aNode.NodeName,'ExtraInfo') then
    exit;
  subJson := json;
  if (not aNode.IsTextElement) and (aNode.HasChildNodes) then begin
    { parent node }
    if not subJson.ObjectExists(aNode.NodeName) then
      subJson:= subJson.O[aNode.NodeName];
    for x := 0 to aNode.ChildNodes.Count -1 do begin
      XMLToJson(aNode.ChildNodes[x],subJson);
    end;
  end
  else begin
    if not VarIsNull(aNode.NodeValue) then begin
      if VarIsStr(aNode.NodeValue) then begin
        if SameText(aNode.NodeName,'Time') then
          subJson.DT[aNode.NodeName] := StrToDateTimeFmt('hh:nn:ss mmm dd, yyyy',aNode.NodeValue)
        else
         subJson.S[aNode.NodeName] := aNode.NodeValue;
      end
      else if VarIsNumeric(aNode.NodeValue) then
        subJson.F[aNode.NodeName] := aNode.NodeValue
      else
       subJson.S[aNode.NodeName] := aNode.NodeValue;
    end;
  end;
end;

initialization
  fCyTrack := nil;

finalization
  fCyTrack.Free;

end.
