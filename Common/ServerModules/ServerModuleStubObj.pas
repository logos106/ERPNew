unit ServerModuleStubObj;

interface

uses
  JsonObject, ModuleComms3, Classes, LogMessageTypes, LogThreadBase;

type

  {$M+}
  TServerModuleStub = class;
  TModStringMessageEvent = procedure (Sender: TServerModuleStub; aClientId: integer; aData: string) of object;
  TModJsonMessageEvent = procedure (Sender: TServerModuleStub; aClientId: integer; aData: TJsonObject) of object;
  TModCommandMessageEvent = procedure (aData: string) of object;

  TModStringRequestEvent = procedure (Sender: TServerModuleStub; aClientId: integer; aRequest: string; var aResponse: string) of object;
  TModJsonRequestEvent = procedure (Sender: TServerModuleStub; aClientId: integer; aRequest: TJsonObject; aResponse: TJsonObject = nil) of object;
  TModCommandRequestEvent = procedure (Sender: TServerModuleStub; aRequest: string; var aResponse: string) of object;

  TModNotificationEvent = procedure (Sender: TServerModuleStub; aClientId: integer; aNotificationName, aNotificationData: string) of object;

  TServerModuleStub = class
  private
    CommsClient: TModuleComms;
    fLogger: TLoggerBase;
    //FModuleName: string;
    FModulePathName: string;

    fOnModStringMessage: TModStringMessageEvent;
    fOnModJsonMessage: TModJsonMessageEvent;
    fOnModCommandMessage: TModCommandMessageEvent;

    fOnModStringRequest: TModStringRequestEvent;
    fOnModJsonRequest: TModJsonRequestEvent;
    fOnModCommandRequest: TModCommandRequestEvent;

    fOnModNotification: TModNotificationEvent;
    fMySQLServer: string;

    function GetModuleName: string;
    procedure DoOnCommsMessage(aClientId: integer; aData: string);
    procedure DoOnCommsRequest(aClientId: integer; aRequest: string; var aResponse: string);
    function GetActive: boolean;
    function GetLoggingLevel: TLoggingLevel;
    function GetModuleDescription: string;
    function GetModuleVersion: string;
    procedure SetActive(const Value: boolean);
    procedure SetLoggingLevel(const Value: TLoggingLevel);
    procedure TerminateEXE;
    function GetGuiInERP: boolean;
    function GetGuiInServiceMenu: boolean;
    function GetLoggerClassName: string;
    //function GetVersion: string;
  protected
    procedure Log(const msg: string; const LogMessageType: TLogMessageType);

  public
    constructor Create(aModulePathName, aMySQLServer: string; aLogger: TLoggerBase = nil);
    destructor Destroy; override;
    property Logger: TLoggerBase read fLogger write fLogger;
    //property Version: string read GetVersion;

    function SendMessage(aClientId: integer; aMessage: string): boolean; overload;
    function SendMessage(aClientId: integer; aMessage: TJsonObject): boolean; overload;

    function SendRequest(aClientId: integer; aRequest: string; var aResponse: string): boolean; overload;
    function SendRequest(aClientId: integer; aRequest: TJsonObject; aResponse: TJsonObject = nil): boolean; overload;

    function SendCommandMessage(aMessage: string): boolean;
    function SendCommandRequest(aRequest: string; var aResponse: string): boolean;

    property OnModStringMessage: TModStringMessageEvent read fOnModStringMessage write fOnModStringMessage;
    property OnModJsonMessage: TModJsonMessageEvent read fOnModJsonMessage write fOnModJsonMessage;
    property OnModCommandMessage: TModCommandMessageEvent read fOnModCommandMessage write fOnModCommandMessage;

    property OnModStringRequest: TModStringRequestEvent read fOnModStringRequest write fOnModStringRequest;
    property OnModJsonRequest: TModJsonRequestEvent read fOnModJsonRequest write fOnModJsonRequest;
    property OnModCommandRequest: TModCommandRequestEvent read fOnModCommandRequest write fOnModCommandRequest;

    property OnModNotification: TModNotificationEvent read fOnModNotification write fOnModNotification;
    procedure AsJson(J: TJsonObject);
    property MySQLServer: string read fMySQLServer write fMySQLServer;

  published
    property ModuleName: string read GetModuleName;
    property ModuleFileName: string read FModulePathName;
    property ModuleDescription: string read GetModuleDescription;
    property ModuleVersion: string read GetModuleVersion;
    property Active: boolean read GetActive write SetActive;
    property LoggingLevel: TLoggingLevel read GetLoggingLevel write SetLoggingLevel;
    property LoggerClassName: string read GetLoggerClassName;
    property GuiInServiceMenu: boolean read GetGuiInServiceMenu;
    property GuiInERP: boolean read GetGuiInERP;
  end;
  {$M-}

  TNotificationEvent = procedure (Sender: TServerModuleStub; aClientId: integer; aNotificationName, aNotificationData: string) of object;
  TCommandRequestEvent = procedure (Sender: TServerModuleStub; aRequest: string; var aResponse: string) of object;

  TServerModuleList = class
  private
    fOnNotification: TNotificationEvent;
    fOnCommandRequest: TCommandRequestEvent;
    fLogger: TLoggerBase;
    function GetModuleByName(aName: string): TServerModuleStub;
    procedure DoOnModNotification(Sender: TServerModuleStub; aClientId: integer; aNotificationName, aNotificationData: string);
    procedure DoOnCommandRequest(Sender: TServerModuleStub; aRequest: string; var aResponse: string);

  protected
    fList: TThreadList;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType);

  public
    constructor Create;
    destructor Destroy; override;
    property Logger: TLoggerBase read fLogger write fLogger;
    procedure Clear;
    function LockModuleByName(aName: string): TServerModuleStub;
    property ModuleByName[aName: string]: TServerModuleStub read GetModuleByName;
    procedure Unlock;
    function AddModule(aModuleNamePath, aMySQLServer: string): boolean;
    procedure RemoveModule(aModule: TServerModuleStub);
    property OnNotification: TNotificationEvent read fOnNotification write fOnNotification;
    property OnCommandRequest: TCommandRequestEvent read fOnCommandRequest write fOnCommandRequest;
    procedure GetAsJson(Json: TJsonObject);
    property List: TThreadList read fList;
  end;


implementation

uses
  SystemLib, SysUtils, ServerModuleConst, JsonToObject, AppRunUtils; //, ModWebAPI;

{ TServerModuleStub }

procedure TServerModuleStub.AsJson(J: TJsonObject);
begin
  J.B['Active'] := Active;
  J.B['GuiInERP'] := GuiInERP;
  J.B['GuiInServiceMenu'] := GuiInServiceMenu;
  J.S['LoggingLevel'] := LoggingLevelToStr(LoggingLevel);
  J.S['ModuleDescription'] := ModuleDescription;
  J.S['ModuleFileName'] := ModuleFileName;
  J.S['ModuleName'] := ModuleName;
  J.S['ModuleVersion'] := ModuleVersion;
  J.S['LoggerClassName'] := LoggerClassName;
end;

constructor TServerModuleStub.Create(aModulePathName, aMySQLServer: string; aLogger: TLoggerBase = nil);
var
  ChannelName: String;
begin
  fMySQLServer := aMySQLServer;
  fLogger := aLogger;
  FModulePathName := aModulePathName;

  if (not ProcessExists(ModuleName + '.exe')) and (not SameText(ModuleName, 'ERPModWebAPI')) then begin
    ExecNewProcess(fModulePathName, False);
    if not ProcessExists(ModuleName + '.exe') then
      raise Exception.Create('Failed to Create Module');
  end;

  ChannelName := GetModuleName;
  if SameText(ChannelName, 'ERPModWebAPI') then
    ChannelName := 'ERPWebService';

  FModulePathName := ChannelName;

  CommsClient := TModuleComms.Create(ChannelName, False, aMySQLServer, aLogger);
  CommsClient.OnMessage := DoOnCommsMessage;
  CommsClient.OnRequest := DoOnCommsRequest;
end;

destructor TServerModuleStub.Destroy;
begin
  TerminateEXE;

  CommsClient.Free;
  inherited;
end;

procedure TServerModuleStub.DoOnCommsMessage(aClientId: integer; aData: string);
var
  typeStr: string;
  dataJson: TJsonObject;
  aNotificationName, aNotificationData: string;
  idx: integer;
begin
  if Length(aData) < 1 then Exit;
  typeStr := Copy(aData, 1, 1);
  if SameText(typeStr, IntToStr(Ord(mtString))) and Assigned(fOnModStringMessage) then
    fOnModStringMessage(self, aClientId,Copy(aData, 2, MaxInt))
  else if SameText(typeStr,IntToStr(Ord(mtJson))) and Assigned(fOnModJsonMessage) then begin
    dataJson := JO;
    try
      dataJson.AsString := Copy(aData, 2, MaxInt);
      fOnModJsonMessage(self, aClientID, dataJson);
    finally
      dataJson.Free;
    end;
  end
  else if SameText(typeStr, IntToStr(Ord(mtCommand))) then begin
    if SameText(Copy(aData, 2, MaxInt), 'RestartMe') then begin
      Log('Received message to restart module .. terminating ..', ltWarning);
      TerminateEXE;
      Log('Restarting module ..', ltWarning);
      try
        ExecNewProcess(fModulePathName, False);
      except
        on e: exception do begin
          raise Exception.Create('Failed to Create Module with message: ' + e.Message);
          exit;
        end;
      end;
      if not ProcessExists(ModuleName+ '.exe') then
        raise Exception.Create('Failed to Create Module');
      exit;
    end;
    if Assigned(fOnModCommandMessage) then begin
      fOnModCommandMessage(Copy(aData,2,MaxInt));
    end;
  end
  else if SameText(typeStr,IntToStr(Ord(mtNotification))) and Assigned(fOnModNotification) then begin
    aNotificationName := Copy(aData,2,MaxInt);
    idx := Pos(MSG_SEP_STR,aNotificationName);
    if idx > 1 then begin
      aNotificationData := Copy(aNotificationName,idx + Length(MSG_SEP_STR),MaxInt);
      aNotificationName := Copy(aNotificationName,1,idx-1);
      fOnModNotification(Self, aClientId, aNotificationName, aNotificationData);
    end;
  end;
end;

procedure TServerModuleStub.DoOnCommsRequest(aClientId: integer;
  aRequest: string; var aResponse: string);
var
  typeStr: string;
  jsonRequest,
  jsonResponse: TJsonObject;
begin
  if Length(aRequest) < 1 then exit;
  typeStr := Copy(aRequest,1,1);
  if SameText(typeStr,IntToStr(Ord(mtString))) and Assigned(fOnModStringRequest) then
    fOnModStringRequest(self, aClientId,Copy(aRequest,2,MaxInt),aResponse)
  else if SameText(typeStr,IntToStr(Ord(mtJson))) and Assigned(fOnModJsonRequest) then begin
    jsonRequest := JO;
    jsonRequest.AsString := Copy(aRequest,2,MaxInt);
    jsonResponse := nil;
    try
    fOnModJsonRequest(self, aClientId,jsonRequest,jsonResponse);
      if Assigned(jsonResponse) then
        aResponse := jsonResponse.AsString;
    finally
      jsonRequest.Free;
      jsonResponse.Free;
    end;
  end
  else if SameText(typeStr,IntToStr(Ord(mtCommand))) and Assigned(fOnModCommandRequest) then begin
    fOnModCommandRequest(self, Copy(aRequest,2,MaxInt), aResponse);
  end;
end;

function TServerModuleStub.GetActive: Boolean;
var
  resp: string;
begin
  Result := true;
  resp := 'false';
  if self.SendCommandRequest('GetActive', resp) then
    Result := SameText(resp, 'true');
end;

function TServerModuleStub.GetGuiInERP: Boolean;
var
  resp: string;
begin
  Result := True;
  if Self.SendCommandRequest('GetGuiInERP', resp) then
    Result := SameText(resp, 'true');
end;

function TServerModuleStub.GetGuiInServiceMenu: Boolean;
var
  resp: string;
begin
  Result := True;
  if self.SendCommandRequest('GetGuiInServiceMenu', resp) then
    Result := SameText(resp, 'true');
end;

function TServerModuleStub.GetLoggerClassName: string;
var
  resp: string;
begin
  Result := '';
  if Self.SendCommandRequest('GetLoggerClassName', resp) then
    Result := resp;
end;

function TServerModuleStub.GetLoggingLevel: TLoggingLevel;
var
  resp: string;
begin
  Result := llInfo;
  if Self.SendCommandRequest('GetLoggingLevel', resp) then
    Result := StrToLoggingLevel(resp);
end;

function TServerModuleStub.GetModuleDescription: string;
var
  resp: string;
begin
  Result := '';
  if Self.SendCommandRequest('GetModuleDescription', resp) then
    Result := resp;
end;

function TServerModuleStub.GetModuleName: string;
begin
  Result := ChangeFileExt(ExtractFileName(FModulePathName), '');
end;

function TServerModuleStub.GetModuleVersion: string;
var
  resp: string;
begin
  Result := '';
  if Self.SendCommandRequest('GetModuleVersion', resp) then
    Result := resp;
end;

procedure TServerModuleStub.Log(const msg: string; const LogMessageType: TLogMessageType);
begin
  if Assigned(Logger) then
    Logger.Log(msg, LogMEssageType);
end;

function TServerModuleStub.SendMessage(aClientId: Integer; aMessage: string): Boolean;
begin
  Result := False;
  if not Assigned(CommsClient) then Exit;
  Result := CommsClient.SendMessage(aClientId, IntToStr(Ord(mtString)) + aMessage);
end;

function TServerModuleStub.SendCommandMessage(aMessage: string): Boolean;
begin
  Result := False;
  if not Assigned(CommsClient) then Exit;
  Result := CommsClient.SendMessage(0, IntToStr(Ord(mtCommand)) + aMessage);
end;

function TServerModuleStub.SendCommandRequest(aRequest: string; var aResponse: string): Boolean;
begin
  Result := False;
  if not Assigned(CommsClient) then Exit;
  Result := CommsClient.SendRequest(0, IntToStr(Ord(mtCommand)) + aRequest, aResponse);
end;

function TServerModuleStub.SendMessage(aClientId: Integer; aMessage: TJsonObject): Boolean;
begin
  Result := False;
  if not Assigned(CommsClient) then Exit;
  Result := CommsClient.SendMessage(aClientId, IntToStr(Ord(mtJson)) + aMessage.AsString);
end;

function TServerModuleStub.SendRequest(aClientId: Integer; aRequest, aResponse: TJsonObject): Boolean;
var
  outStr: string;
begin
  Result := false;
  if not Assigned(CommsClient) then Exit;
  if Assigned(aResponse) then
    outStr := aResponse.AsString;
  Result := CommsClient.SendRequest(aClientId, IntToStr(Ord(mtJson)) + aRequest.AsString, outStr);
  if not Result then begin
    Log('Error sending message.',ltError);
//    Log('Error sending message, restarting module',ltError);
//    if KillTask(fModulePathName) > 0 then begin
//      if ExecNewProcess(fModulePathName,false) then begin
//        result := CommsClient.SendRequest(aClientId, IntToStr(Ord(mtJson)) +  aRequest.AsString, outStr);
//
//      end
//      else begin
//        Log('Could not restart module',ltError);
//      end;
//
//    end
//    else begin
//      Log('Could not close module',ltError);
//
//    end;

  end;

  if Result then begin
    if outStr <> '' then begin
      if not Assigned(aResponse) then
        aResponse := TJsonObject.Create;
      aResponse.AsString := outStr;
    end
    else begin
//      if Assigned(aResponse) then begin
//        FreeAndNil(aResponse);
//      end;
    end;
  end;
end;

procedure TServerModuleStub.SetActive(const Value: boolean);
begin
  Self.SendCommandMessage('SetActive' + MSG_SEP_STR + BoolToStr(Value, True));
end;

procedure TServerModuleStub.SetLoggingLevel(const Value: TLoggingLevel);
begin
  Self.SendCommandMessage('SetLoggingLevel' + MSG_SEP_STR + LoggingLevelToStr(Value));
end;

procedure TServerModuleStub.TerminateEXE;
var
  dt: TDateTime;
const
  OneSec = 1/24/60/60;
begin
  SendCommandMessage('Terminate');

  { wait for module to terminate .. }
  dt := Now + (10 * OneSec);
  while True do begin
    if not ProcessExists(ModuleName + '.exe') then Break;
    if Now > dt then begin
      { create batch file to kill module, it did not respond to the
        Terminate message sent to it }
      try
        with TStringList.Create do begin
          try
            Add('@ECHO OFF');
            //Add('ping 1.1.1.1 -n 1 -w 10000 > nul'); { wait 10 seconds .. }
            Add('SETLOCAL');
            Add('SET modProgram=' + ModuleName + '.exe');
            Add('TASKKILL /f /im "%modProgram%"'); { force KillTask }
            Add('DEL "%~f0"');
            SaveToFile(WinTempDir + ModuleName + '_terminate.bat');
          finally
            Free;
          end;
        end;
        ExecNewProcess(WinTempDir + ModuleName + '_terminate.bat',false);
      except
      end;
      Break;
    end
    else
      Sleep(20);
  end;
end;

function TServerModuleStub.SendRequest(aClientId: Integer; aRequest: string; var aResponse: string): Boolean;
begin
  Result:= false;
  if not Assigned(CommsClient) then Exit;
  Result := CommsClient.SendRequest(aClientId, IntToStr(Ord(mtString)) + aRequest, aResponse);
end;

{ TServerModuleList }

function TServerModuleList.AddModule(aModuleNamePath, aMySQLServer: string): Boolean;
var
  modStub: TServerModuleStub;
begin
  Result := True;
  try
    modStub := TServerModuleStub.Create(aModuleNamePath, aMySQLServer, Logger);
  except
    on E: Exception do begin
      Log('Failed to load module "' + aModuleNamePath + '" with exception: ' + E.Message, ltError);
      Result := False;
      Exit;
    end;
  end;
  modStub.OnModNotification := DoOnModNotification;
  modStub.OnModCommandRequest := DoOnCommandRequest;
  fList.Add(modStub);
end;

procedure TServerModuleList.Clear;
var
  lst: TList;
begin
  lst := fList.LockList;
  try
    while lst.Count > 0 do begin
      TServerModuleStub(lst[0]).Free;
      lst.Delete(0);
    end;
  finally
    fList.UnlockList;
  end;
end;

constructor TServerModuleList.Create;
begin
  fList := TThreadList.Create;
end;

destructor TServerModuleList.Destroy;
begin
  Clear;
  fList.Free;
  inherited;
end;

procedure TServerModuleList.DoOnCommandRequest(Sender: TServerModuleStub;
  aRequest: string; var aResponse: string);
begin
  if Assigned(fOnCommandRequest) then
    fOnCommandRequest(Sender,aRequest,aResponse);
end;

procedure TServerModuleList.DoOnModNotification(Sender: TServerModuleStub;
  aClientId: integer; aNotificationName, aNotificationData: string);
begin
  if Assigned(fOnNotification) then
    fOnNotification(Sender,aClientId,aNotificationName, aNotificationData);
end;

procedure TServerModuleList.GetAsJson(Json: TJsonObject);
var
  x: integer;
  lst: TList;
  mdl: TJsonObject;
begin
  lst := fList.LockList;
  try
    for x := 0 to lst.Count - 1 do begin
      mdl := JO;
      TServerModuleStub(lst[x]).AsJson(mdl.O['Module']);
      //ObjToJson(lst[x],mdl.O['Module']);
      Json.O['ModuleList'].A['Items'].Add(mdl);
    end;
  finally
    fList.UnlockList;
  end;
end;

function TServerModuleList.GetModuleByName(aName: string): TServerModuleStub;
begin
  Result := Self.LockModuleByName(aName);
//  Unlock;
end;

function TServerModuleList.LockModuleByName(aName: string): TServerModuleStub;
var
  lst: TList;
  x: integer;
begin
  Result := nil;
  lst := fList.LockList;
  try
    for x := 0 to lst.Count - 1 do begin
      if SameText(TServerModuleStub(lst[x]).ModuleName, aName) then begin
        Result := TServerModuleStub(lst[x]);
        Break;
      end;
    end;
  finally
    fList.UnlockList;
  end;
end;

procedure TServerModuleList.Log(const msg: string; const LogMessageType: TLogMessageType);
begin
  if Assigned(Logger) then
    Logger.Log(msg, LogMessageType);
end;

procedure TServerModuleList.RemoveModule(aModule: TServerModuleStub);
var
  lst: TList;
  x: integer;
begin
  lst := fList.LockList;
  try
    x := lst.IndexOf(aModule);
    if x >= 0 then begin
      TServerModuleStub(lst[x]).Free;
      lst.Delete(x);
    end;
  finally
    fList.UnlockList;
  end;
end;

procedure TServerModuleList.Unlock;
begin
  fList.UnlockList;
end;


end.
