unit ModuleWebAPIObj;

interface

uses
  ModuleBaseServerObj, forms, classes,
  JsonObject, JsonRpcBase, {RestServerObj, RestServerConfigObj,} sysutils,
  IdHttpServer, IdContext, IdCustomHTTPServer, IdSSLOpenSSL, IdSSL,
  LogThreadBase, LogThreadLib, LogThreadDbLib;

type

  TModuleWebAPI = class(TModuleBaseServer)
  private
  protected
    procedure DoChange; override;
    function GetLogger: TLoggerBase; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure DoRequest(Client: TJsonRpcBase; RequestJson: TJsonObject;
      ResponseJson: TJsonObject = nil); override;
    procedure Terminate; override;
  published
  end;

  TWebAPIConfigSession = class(TModuleSession)
  private
    fUpdatingModule: boolean;
  public
    constructor Create;
    procedure DoRequest(RequestJson: TJsonObject; ResultJson: TJsonObject = nil); override;
    property UpdatingModule: boolean read fUpdatingModule write fUpdatingModule;
  end;



  function GetModule(MainAppInst: TApplication): TModuleBaseServer;


implementation

uses
  LogMessageTypes, JsonRPCConst, ModuleConst, JsonToObject,
  HTTPRequestProcessor;

var
  fModuleWebAPI: TModuleWebAPI;


function GetModule(MainAppInst: TApplication): TModuleBaseServer;
begin
  if not Assigned(fModuleWebAPI) then
    fModuleWebAPI:= TModuleWebAPI.Create;
  fModuleWebAPI.AppInst:= MainAppInst;
  result:= fModuleWebAPI;
end;

{ TModuleWebAPI }

constructor TModuleWebAPI.Create;
begin
  inherited;
  try
    ModuleName:= 'WebAPI';
    ModuleDescription:= 'ERP Web API Service';
    LoadConfig;
  except
    on e: exception do begin
      if Assigned(Logger) then
        Logger.Log('Error creating TModuleWebAPI object with message: ' + e.Message, ltError);

    end;
  end;
end;

destructor TModuleWebAPI.Destroy;
begin
   Logger.Log('Shutting down ...',ltInfo);
   Terminate;
   Logger.Log('  Saving config data',ltInfo);
   SaveConfig;
   Logger.Log('Done',ltInfo);
   while not Logger.Buffer.Empty do
     Sleep(10);
   Logger.Active := false;
  inherited;
end;

procedure TModuleWebAPI.DoChange;
var
  x: integer;
  list: TList;
  ses: TWebAPIConfigSession;
begin
  inherited;
  if LoadingConfig then
    exit;
  list:= SessionList.LockList;
  try
    for x:= 0 to list.Count - 1 do begin
      ses:= TWebAPIConfigSession(list[x]);
      if (ses.SessionType = mstConfig) and (not ses.UpdatingModule) then begin
        ses.Client.SendNotification('event',JO('{"eventname":"onchange","senderclassname":"' + self.ClassName +'"}'));
      end;
    end;
  finally
    SessionList.UnlockList;
  end;
end;

procedure TModuleWebAPI.DoRequest(Client: TJsonRpcBase; RequestJson,
  ResponseJson: TJsonObject);
var
  Session: TModuleSession;
  ConfigSession: TWebAPIConfigSession;
  methodName: string;
  idx: integer;
begin
  inherited;
  if Status <> msRunning then begin
    if Status = msStopping then begin
      if RequestCount.Count = 0 then
        Status := msStopped;
    end;
    exit;
  end;
  RequestCount.Inc;
  try
    if Assigned(Client) then begin
      Session:= self.SessionList.Session(Client);
      if Assigned(Session) then
        Session.DoRequest(RequestJson, ResponseJson)
      else begin
        { process the request }
        methodName:= Lowercase(RequestJson.S['method']);
        idx:= Pos('.',methodName);
        if idx > 0 then
          methodName:= Copy(methodName,idx+1,Length(methodName));
        if methodName = 'startsession' then begin
          { now look at params to see what sort of session this is ... }
          if RequestJson.ObjectExists('params') then begin
            if RequestJson.O['params'].S['sessiontype'] = 'config' then begin
              ConfigSession:= TWebAPIConfigSession.Create;
              ConfigSession.SessionType:= mstConfig;
              ConfigSession.Client:= Client;
              SessionList.AddSession(ConfigSession);
              if Assigned(ResponseJson) then
                ResponseJson.S['result']:= 'ok';
            end
            else begin
              if Assigned(ResponseJson) then begin
                ResponseJson.O['error']:=
                  JO('{"code": '+ IntToStr(-1) +
                  ', "message": "Invalid session type"}');
              end;
            end;
          end
          else begin
            if Assigned(ResponseJson) then begin
                ResponseJson.O['error']:=
                  JO('{"code": '+ IntToStr(RPC_INVALID_REQUEST) +
                ', "message": "Invalid request format - params object not found"}');
            end;
          end;

        end;
      end;
    end
    else begin
      { session is nil, so could be a HTTP request }
      methodName:= Lowercase(RequestJson.S['method']);
      idx:= Pos('.',methodName);
      if idx > 0 then
        methodName:= Copy(methodName,idx+1,Length(methodName));
      if methodName = 'webrequest' then begin
         DoHTTPRequest(RequestJson, ResponseJson, Logger);

      end;
    end;
  finally
    RequestCount.Dec;
    if Status = msStopping then begin
      if RequestCount.Count = 0 then
        Status := msStopped;
    end;
  end;
end;

function TModuleWebAPI.GetLogger: TLoggerBase;
begin
  result:= TLogger.Create(nil);
  result.LogAllTypes;
end;

procedure TModuleWebAPI.Terminate;
begin
  inherited;
  if Status = msStopping then begin
    if RequestCount.Count = 0 then
      Status := msStopped;
  end;
end;

{ TWebAPIConfigSession }

constructor TWebAPIConfigSession.Create;
begin

end;

procedure TWebAPIConfigSession.DoRequest(RequestJson, ResultJson: TJsonObject);
var
  method: string;
  idx: integer;
begin
  { process the request }
  method:= Lowercase(RequestJson.S['method']);
  idx:= Pos('.',method);
  if idx > 0 then
    method:= Copy(method,idx+1,Length(method));
//  if method = 'getobject' then begin
//    { now look at params to see which object ... }
//    if RequestJson.ObjectExists('params') then begin
//      if RequestJson.O['params'].S['classname'] = self.SessionList.Module.ClassName then begin
//        self.SessionList.Module.Lock;
//        try
//          ResultJson.O['result'].S['classname']:= self.SessionList.Module.ClassName;
//          ObjToJson(self.SessionList.Module,ResultJson.O['result'].O['object']);
//        finally
//          self.SessionList.Module.Unlock;
//        end;
//      end;
//    end;
//  end
//  else if method = 'setobject' then begin
//    if RequestJson.ObjectExists('params') then begin
//      if RequestJson.O['params'].S['classname'] = self.SessionList.Module.ClassName then begin
//        self.SessionList.Module.Lock;
//        try
//          self.UpdatingModule:= true;
//          JsonToObj(RequestJson.O['params'].O['object'],self.SessionList.Module);
//          self.SessionList.Module.SaveConfig;
//        finally
//          self.UpdatingModule:= false;
//          self.SessionList.Module.Unlock;
//        end;
//        if Assigned(ResultJson) then
//          ResultJson.S['result']:= 'ok';
//      end;
//    end;
//  end;
end;

initialization


finalization
  fModuleWebAPI.Free;
  fModuleWebAPI:= nil;

end.
