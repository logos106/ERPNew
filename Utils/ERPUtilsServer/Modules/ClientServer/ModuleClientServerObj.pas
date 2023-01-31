unit ModuleClientServerObj;

interface

uses
  ModuleBaseServerObj, forms, classes,
  JsonObject, JsonRpcBase, JsonRpcTcpClient,
  ClientConfigObj;

type

  TModuleClientServer = class(TModuleBaseServer)
  private
    FClientServerName: string;
//    FERPServerName: string;
//    FERPDatabaseName: string;
  protected
    procedure DoChange; override;
    procedure SetActive(const Value: boolean); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure DoRequest(Client: TJsonRpcBase; RequestJson: TJsonObject;
      ResponseJson: TJsonObject = nil); override;
    procedure LoadConfig(encrypt: boolean = false); override;
    procedure SaveConfig(encrypt: boolean = false); override;
    procedure Terminate; override;
  published
//    property ERPServerName: string read FERPServerName write FERPServerName;
//    property ERPDatabaseName: string read FERPDatabaseName write FERPDatabaseName;
    property ClientServerName: string read FClientServerName write FClientServerName;
  end;

  TClientServerConfigSession = class(TModuleSession)
  private
    fUpdatingModule: boolean;
  public
    constructor Create;
    procedure DoRequest(RequestJson: TJsonObject; ResultJson: TJsonObject = nil); override;
    property UpdatingModule: boolean read fUpdatingModule write fUpdatingModule;
  end;

  TClientServerClientSession = class(TModuleSession)
  private
    procedure ProcessClientConfig(Req, Res: TJsonObject);
    function GetClientConfig(aId: integer): TClientConfig;
  public
    constructor Create;
    procedure DoRequest(RequestJson: TJsonObject; ResultJson: TJsonObject = nil); override;
  end;

  function GetModule(MainAppInst: TApplication): TModuleBaseServer;

implementation

uses
  sysutils, LogMessageTypes, JsonRPCConst, JsonToObject, ModuleUtils, MyAccess, ClientServerDbUtils,
  DbConst, IntegerListObj, ModuleConst, InstallConst;

var
  fModuleClientServer: TModuleClientServer;

const
  UPDATE_USER = 'ERP Office';

function GetModule(MainAppInst: TApplication): TModuleBaseServer;
begin
  fModuleClientServer.AppInst:= MainAppInst;
  result:= fModuleClientServer;
end;

procedure InitialiseConnection(conn: TMyConnection; aServer: string = ''; aDatabase: string = '');
begin
  conn.Port:= SERVER_PORT;
  conn.Options.Compress:= MYDAC_OPTIONS_COMPRESS;
  conn.Options.Protocol:= MYDAC_OPTIONS_PROTOCOL;
  conn.LoginPrompt:= false;
  conn.Username:= SYSDB_USER;
  conn.Password:= SYSDB_PASS;
  if aServer <> '' then
    conn.Server:= aServer;
  if aDatabase <> '' then
    conn.Database:= aDatabase;
end;



{ TModuleClientServer }

constructor TModuleClientServer.Create;
begin
  inherited;
  ModuleName:= 'ClientServer';
  ModuleDescription:= 'Module to provide various functions for client ERP installations';
  LoadConfig;
  ForceDirectories(ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Log\ClientConfig');
//  self.fLoggingLevel:= llDetail;
//  Logger.LogMessageTypes:= [ltNone, ltError, ltWarning, ltInfo, ltDetail, ltBlank, ltDebug];
  SessionList.Module.Logger.Log(ModuleName + ' Started.',ltInfo);
end;

destructor TModuleClientServer.Destroy;
begin
  SessionList.Module.Logger.Log(ModuleName + ' Stopped.',ltInfo);
  Sleep(100);
  inherited;
end;

procedure TModuleClientServer.DoChange;
var
  x: integer;
  list: TList;
  ses: TClientServerConfigSession;
begin
  inherited;
  if LoadingConfig then
    exit;
  list:= SessionList.LockList;
  try
    for x:= 0 to list.Count - 1 do begin
      ses:= TClientServerConfigSession(list[x]);
      if (ses.SessionType = mstConfig) and (not ses.UpdatingModule) then begin
        ses.Client.SendNotification('event',JO('{"eventname":"onchange","senderclassname":"' + self.ClassName +'"}'));
      end;
    end;
  finally
    SessionList.UnlockList;
  end;
end;

procedure TModuleClientServer.DoRequest(Client: TJsonRpcBase; RequestJson,
  ResponseJson: TJsonObject);
var
  Session: TModuleSession;
  ConfigSession: TClientServerConfigSession;
  ClientSession: TClientServerClientSession;
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
    Session:= self.SessionList.Session(Client);
    if Assigned(Session) then
      Session.DoRequest(RequestJson, ResponseJson)
    else begin
      { process the request }
      methodName:= Lowercase(RequestJson.S['method']);
      idx:= Pos('.',methodName);
      if idx > 0 then
        methodName:= Copy(methodName,idx+1,Length(methodName));
      Logger.Log('Received request method: "' + methodName + '"',ltDetail);
      if methodName = 'startsession' then begin
        { now look at params to see what sort of session this is ... }
        if RequestJson.ObjectExists('params') then begin
          if RequestJson.O['params'].S['sessiontype'] = 'config' then begin
            Logger.Log('    config session',ltDetail);
            ConfigSession:= TClientServerConfigSession.Create;
            ConfigSession.SessionType:= mstConfig;
            ConfigSession.Client:= Client;
            SessionList.AddSession(ConfigSession);
            Logger.Log('    Session List count: ' + IntToStr(SessionList.Count),ltDetail);
            if Assigned(ResponseJson) then
              ResponseJson.S['result']:= 'ok';
          end
          else if RequestJson.O['params'].S['sessiontype'] = 'client' then begin
            Logger.Log('    client session',ltDetail);
            if self.Active then begin
              ClientSession:= TClientServerClientSession.Create;
              ClientSession.SessionType:= mstClient;
              ClientSession.Client:= Client;
              SessionList.AddSession(ClientSession);
              Logger.Log('    Session List count: ' + IntToStr(SessionList.Count),ltDetail);
              if Assigned(ResponseJson) then
                ResponseJson.S['result']:= 'ok';
            end
            else begin
              ResponseJson.O['error']:=
                JO('{"code": '+ IntToStr(-1) +
                ', "message": "Module ' + self.ModuleName + ' is inactive' + '"}');
              Logger.Log(ResponseJson.O['error'].S['message'],ltError);
            end;
          end
          else begin
            if Assigned(ResponseJson) then begin
              ResponseJson.O['error']:=
                JO('{"code": '+ IntToStr(-1) +
                ', "message": "Invalid session type"}');
              Logger.Log(ResponseJson.O['error'].S['message'],ltError);
            end;
          end;
        end
        else begin
          if Assigned(ResponseJson) then begin
              ResponseJson.O['error']:=
                JO('{"code": '+ IntToStr(RPC_INVALID_REQUEST) +
              ', "message": "Invalid request format - params object not found"}');
              Logger.Log(ResponseJson.O['error'].S['message'],ltError);
          end;
        end;

      end
      else begin
        Logger.Log('Unrecognised request method: "' + methodName + '"',ltError);
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

procedure TModuleClientServer.LoadConfig(encrypt: boolean = false);
begin
  inherited LoadConfig(encrypt);
//  if self.ERPServerName = '' then
//    self.ERPServerName:= 'Server1';
//  if self.ERPDatabaseName = '' then
//    self.ERPDatabaseName:= 'erp_software_pty_ltd';
  if self.ClientServerName = '' then
    self.ClientServerName:= 'localhost';
end;

procedure TModuleClientServer.SaveConfig(encrypt: boolean = false);
begin
  inherited SaveConfig(encrypt);

end;

procedure TModuleClientServer.SetActive(const Value: boolean);
begin
  inherited;
  if Value then
    Logger.Log('Setting module Active',ltDetail)
  else
    Logger.Log('Setting module Inactive',ltDetail);
end;

procedure TModuleClientServer.Terminate;
begin
  inherited;
  if Status = msStopping then begin
    if RequestCount.Count = 0 then
      Status := msStopped;
  end;
end;

{ TClientServerConfigSession }

constructor TClientServerConfigSession.Create;
begin

end;

procedure TClientServerConfigSession.DoRequest(RequestJson,
  ResultJson: TJsonObject);
var
  method: string;
  idx: integer;
begin
  { process the request }
  method:= Lowercase(RequestJson.S['method']);
  idx:= Pos('.',method);
  if idx > 0 then
    method:= Copy(method,idx+1,Length(method));
  if method = 'getobject' then begin
    { now look at params to see which object ... }
    if RequestJson.ObjectExists('params') then begin
      if RequestJson.O['params'].S['classname'] = self.SessionList.Module.ClassName then begin
        self.SessionList.Module.Lock;
        try
          ResultJson.O['result'].S['classname']:= self.SessionList.Module.ClassName;
          ObjToJson(self.SessionList.Module,ResultJson.O['result'].O['object']);
        finally
          self.SessionList.Module.Unlock;
        end;
      end;
    end;
  end
  else if method = 'setobject' then begin
    if RequestJson.ObjectExists('params') then begin
      if RequestJson.O['params'].S['classname'] = self.SessionList.Module.ClassName then begin
        self.SessionList.Module.Lock;
        try
          self.UpdatingModule:= true;
          JsonToObj(RequestJson.O['params'].O['object'],self.SessionList.Module);
          self.SessionList.Module.SaveConfig;
        finally
          self.UpdatingModule:= false;
          self.SessionList.Module.Unlock;
        end;
        if Assigned(ResultJson) then
          ResultJson.S['result']:= 'ok';
      end;
    end;
  end;
end;

{ TClientServerClientSession }

constructor TClientServerClientSession.Create;
begin

end;

procedure TClientServerClientSession.DoRequest(RequestJson,
  ResultJson: TJsonObject);
var
  method: string;
  idx: integer;
  ClientConfig: TClientConfig;
begin
  if not SessionList.Module.Active then begin
    ResultJson.O['error']:=
      JO('{"code": '+ IntToStr(-1) +
      ', "message": "Module ' + SessionList.Module.ModuleName + ' is inactive' + '"}');
    exit;
    SessionList.Module.Logger.Log('ClientSession DoRequest - ' + ResultJson.O['error'].S['message'],ltDetail);
  end;

  { process the request }
  method:= Lowercase(RequestJson.S['method']);
  idx:= Pos('.',method);
  if idx > 0 then
    method:= Copy(method,idx+1,Length(method));
  SessionList.Module.Logger.Log('ClientSession DoRequest - method: "' + method + '"',ltDetail);
  if method = 'clientconfig' then begin
    { save or update data to database }
    ProcessClientConfig(RequestJson, ResultJson);

  end
  else if method = 'getclientconfig' then begin
    if RequestJson.ObjectExists('params') then begin
      if RequestJson.O['params'].IntegerExists('id') then begin
        { get from database }
        ClientConfig:= GetClientConfig(RequestJson.O['params'].I['id']);
        if Assigned(ClientConfig) then begin
          ObjToJson(ClientConfig,ResultJson.O['result']);
          ClientConfig.Free;
        end
        else begin
          ResultJson.O['error']:=
            JO('{"code": '+ IntToStr(-1) +
            ', "message": "Unable to read client data from database."}');
          SessionList.Module.Logger.Log('ClientSession DoRequest - ' + ResultJson.O['error'].S['message'],ltError);
        end;
      end;
    end;
  end
  else begin
    SessionList.Module.Logger.Log('Unrecognised request: "' + method + '"',ltWarning);
  end;
end;


function TClientServerClientSession.GetClientConfig(
  aId: integer): TClientConfig;
var
  ClientConn: TMyConnection;
  Computer: TComputer;
  ComputerConfig: TComputerConfig;
  SoftwareLicence: TSoftwareLicence;
  ComputerIdList, ConfigIdList, LicenceIdList: TIntegerList;
  ComputerCount, ConfigCount, LicenceCount: integer;
begin
  result:= TClientConfig.Create;
  try
    ClientConn:= TMyConnection.Create(nil);
    try
      InitialiseConnection(ClientConn,
                             TModuleClientServer(SessionList.Module).ClientServerName,
                             SERVICES_DATABASE);
      ClientConn.Connect;
      LoadFromDb(result,ClientConn);
      ComputerIdList:= GetChildIdList(ClientConn,'TComputer','clientid',aId);
      try
        for ComputerCount:= 0 to ComputerIdList.Count -1 do begin
          Computer:= result.ServerList.Add;
          Computer.Id:= ComputerIdList[ComputerCount];
          LoadFromDb(Computer,ClientConn);
          ConfigIdList:= GetChildIdList(ClientConn,'TComputerConfig','computerid',Computer.Id);
          try
            for ConfigCount:= 0 to ConfigIdList.Count -1 do begin
              ComputerConfig:= Computer.ConfigList.Add;
              ComputerConfig.Id:= ConfigIdList[ConfigCount];
              LoadFromDb(ComputerConfig,ClientConn);
            end;
          finally
            ConfigIdList.Free;
          end;
          LicenceIdList:= GetChildIdList(ClientConn,'TSoftwareLicence','computerid',Computer.Id);
          try
            for LicenceCount:= 0 to LicenceIdList.Count -1 do begin
              SoftwareLicence:= Computer.LicenceList.Add;
              SoftwareLicence.Id:= LicenceIdList[LicenceCount];
              LoadFromDb(SoftwareLicence,ClientConn);
            end;
          finally
            LicenceIdList.Free;
          end;
        end;
      finally
        ComputerIdList.Free;
      end;
    finally
      ClientConn.Free;
    end;
  except
    result.Free;
    result:= nil;
 end;
end;

procedure TClientServerClientSession.ProcessClientConfig(Req,
  Res: TJsonObject);
var
  ClientConfig: TClientConfig;
  Computer: TComputer;
  Config, ConfigOld, ConfigNew: TComputerConfig;
  Licence, SavedLicence: TSoftwareLicence;
  ClientConn: TMyConnection;
  ServerCount, ConfigCount, LicenceCount: integer;
  IdList: TIntegerList;
  NewLicenceStatus: TSoftwareLicenceStatus;
  NewLicenceStatusReason: string;
//  ConfigChangeStr: string;
  O: TJsonObject;
  NewConfigIdList: TIntegerList;
  IdChanged: boolean;
  sl: TStringList;

begin
  try
    ClientConfig:= TClientConfig.Create;
    NewConfigIdList:= TIntegerList.Create;
    try
      ClientConn:= TMyConnection.Create(nil);
      try
        InitialiseConnection(ClientConn,
                             TModuleClientServer(SessionList.Module).ClientServerName,
                             SERVICES_DATABASE);

        ClientConn.Connect;
        ClientConn.StartTransaction;
        try
          IdChanged:= false;
          JsonToObj(req.O['params'],ClientConfig);
          SessionList.Module.Logger.Log('ClientSession ProcessClientConfig - Client: "' +
            clientConfig.Name + '" Computers: ' + clientConfig.ServerList.ComputerNameCommaText + ' Id: ' + IntToStr(ClientConfig.Id),ltDetail);

//          req.O['params'].SaveToFile('c:\ERP Software\Utilities\Log\' + clientConfig.Name + '.txt');
          try
            req.O['params'].SaveToFile(ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Log\ClientConfig\' + clientConfig.Name + '.txt');
          except
          end;
          if ClientConfig.Id < 1 then begin
            { new client so save it }
            SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Saving new config.',ltDetail);
            SaveToDb(ClientConfig,ClientConn);
          end
          else if not IdExists(ClientConfig,ClientConn) then begin
            SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Could not find client with id ' + IntToStr(ClientConfig.Id) + ' so saving new record!',ltWarning);
            ClientConfig.Id:= 0;
            SaveToDb(ClientConfig,ClientConn);
            IdChanged:= true;
          end
          else begin
            { check for updates }
            SessionList.Module.Logger.Log('Checking database for updates for client: ' + ClientConfig.Name,ltDetail);
            if SavedObjIsNewer(ClientConfig,ClientConn) then begin
              SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     We have changed client details so updating clients copy.',ltDetail);
              LoadFromDb(ClientConfig,ClientConn);
            end;
          end;

          for ServerCount:= 0 to ClientConfig.ServerList.Count -1 do begin
            Computer:= TComputer(ClientConfig.ServerList.Items[ServerCount]);
            if Computer.Id < 1 then begin
              { this is a new server, so save it }
              SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Saving new computer (server) details.',ltDetail);
              Computer.ClientId:= ClientConfig.Id;
              SaveToDb(Computer,ClientConn);
            end
            else if not IdExists(Computer,ClientConn) then begin
              Computer.Id:= 0;
              SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Could not find existing computer (server) id so saving new copy!',ltWarning);
              Computer.ClientId:= ClientConfig.Id;
              SaveToDb(Computer,ClientConn);
              IdChanged:= true;
            end
            else begin
              if SavedObjIsNewer(Computer,ClientConn) then begin
                { check to see if we have changed computer.. if so send back to client }
                SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     We have updated computer (server) details so updating clients copy.',ltDetail);
                LoadFromDb(Computer,ClientConn);
              end;
            end;

            sl:= TStringList.Create;
            try
              LicenceCount:= 0;
              while LicenceCount < Computer.LicenceList.Count do begin
                Licence:= TSoftwareLicence(Computer.LicenceList.Items[LicenceCount]);
                if sl.IndexOf(Licence.SoftwareName) > -1 then begin
                  { there is more than one ocurance of this licence type! }
//                  SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Found more than one licence!',ltWarning);
//                  SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Deleting the following licence:',ltWarning);
//                  SessionList.Module.Logger.Log(Licence.Description('          '),ltWarning);
//                  DeleteFromDb(Licence,ClientConn);
//                  Computer.LicenceList.Delete(LicenceCount);
                  { for now ignore duplicates }
                  Inc(LicenceCount);
                end
                else begin
                  sl.Add(Licence.SoftwareName);
                  if Licence.Id < 1 then begin
                    SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Saving new licence.',ltDetail);
                    Licence.ComputerId:= Computer.Id;
                    SaveToDb(Licence,ClientConn);
                  end
                  else begin
                    { Licence record has an id }
                    if not IdExists(Licence,ClientConn) then begin
                      SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Could not find existing licence id!',ltDetail);
                      { id does not match anything in our database ...
                        ( this may be a duplicate record that we have deleted at our end )}
                      if Computer.LicenceList.ByName(Licence.SoftwareName) = nil then begin
                        { we dont have any record for this software type .. so add this one }
                        Licence.ComputerId:= Computer.Id;
                        Licence.Id:= 0;
                        SaveToDb(Licence,ClientConn);
                        SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Could not find existing licence for software "' +
                          Licence.SoftwareName + '" so saving record from client!',ltDetail);
                        IdChanged:= true;
                      end
                      else begin
                        { we do, so change the id }
                        Licence.ComputerId:= Computer.Id;
                        Licence.Id:= 0;
                        SaveToDb(Licence,ClientConn);
                        SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Licence record exists for "' +
                          Licence.SoftwareName + '" so saving record from client with new ID!',ltDetail);
                        IdChanged:= true;
                      end;
                    end
                    else begin
                      SavedLicence:= TSoftwareLicence.Create(nil);
                      try
                        LoadFromDb(SavedLicence,ClientConn,Licence.Id);
                        { if datatext has been updated at client side update our copy }
                        if SavedLicence.DataText <> Licence.DataText then begin
                          SavedLicence.Id:= Licence.Id;
                          SavedLicence.DataText:= Licence.DataText;
                          SaveToDb(SavedLicence,ClientConn);
                          SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Licence DataText has changed so updating our copy.',ltDetail);
                        end;
                      finally
                        SavedLicence.Free;
                      end;
                    end;
                    if Licence.Status in [lsLicenced, lsHold, lsReview] then begin
                      if Trunc(NowUTC) > Trunc(Licence.ExpireDate) then begin
                        Licence.Status:= lsExpired;
                        Licence.StatusReason:= 'Licence Expired';
                        SaveToDb(Licence,ClientConn);
                        SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Licence has expired so updating status.',ltDetail);
                      end;
                    end;
                  end;
                  Inc(LicenceCount);
                end;
              end;
            finally
              sl.Free;
            end;

            { clear Licence's and send latest back from us }
            Computer.LicenceList.Clear;
            IdList:= GetChildIdList(ClientConn,'TSoftwareLicence','ComputerId',Computer.Id);
            try
              for LicenceCount:= 0 to IdList.Count -1 do begin
                Licence:= Computer.LicenceList.Add;
                Licence.Id:= IdList[LicenceCount];
                LoadFromDb(Licence,ClientConn);
              end;
            finally
              IdList.Free;
            end;


            if Computer.ConfigList.Count > 0 then begin
              { get last config record from clients data }
              ConfigNew:= TComputerConfig(Computer.ConfigList.Items[Computer.ConfigList.Count -1]);
              if ConfigNew.Id < 1 then begin
                { this is a new config record so somthing has changed on clients machine }
                { get existing config id list from db }
                IdList:= GetChildIdList(ClientConn,'TComputerConfig','ComputerId',Computer.Id);
                try
                  if IdList.Count = 0 then begin
                    { we dont have any config records yet so just save this one }
                    SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Saving new computer (server) config.',ltDetail);
                    ConfigNew.ComputerId:= Computer.Id;
                    SaveToDb(ConfigNew,ClientConn);
                  end
                  else begin
                    { grab most recent config we have and compare }
                    ConfigOld:= TComputerConfig.Create(nil);
                    try
                      LoadFromDb(ConfigOld,ClientConn,IdList.Last);

                      { compare the important bits }
                      NewLicenceStatus:= lsUnknown;
                      NewLicenceStatusReason:= '';
                      if IdChanged then begin
                        NewLicenceStatus:= lsCancelled;
                        NewLicenceStatusReason:= 'Registration data does not match ERP Head Office records.';
                        if ConfigOld.Text <> ConfigNew.Text then begin
                          { update most recent record with new text data fro client }
                          ConfigOld.Text:= ConfigNew.Text;
                          SaveToDb(ConfigOld,ClientConn);
                        end;
                      end
                      else if ConfigOld.Config.S['computername'] <> ConfigNew.Config.S['computername'] then begin
                        NewLicenceStatus:= lsHold;
                        NewLicenceStatusReason:= 'Server name changed';
                        { save the new config so we can see changes in gui }
                        ConfigNew.ComputerId:= Computer.Id;
                        ConfigNew.AddNote(NewLicenceStatusReason);
                        SaveToDb(ConfigNew,ClientConn);
                      end
                      else if ConfigOld.Config.O['system'].AsString <> ConfigNew.Config.O['system'].AsString then begin
                        NewLicenceStatus:= lsHold;
                        NewLicenceStatusReason:= 'Server processor configuration changed';
                        { save the new config so we can see changes in gui }
                        ConfigNew.ComputerId:= Computer.Id;
                        ConfigNew.AddNote(NewLicenceStatusReason);
                        SaveToDb(ConfigNew,ClientConn);
                      end
                      else if ConfigOld.Config.O['network'].AsString <> ConfigNew.Config.O['network'].AsString then begin
                        { mac address changed }
                        NewLicenceStatusReason:= 'Server network/mac address configuration changed';
                        ConfigOld.Text:= ConfigNew.Text;
                        ConfigNew.AddNote(NewLicenceStatusReason);
                        SaveToDb(ConfigOld,ClientConn);
                      end
                      else if ConfigOld.Config.O['storage'].O['C'].AsString <>
                        ConfigNew.Config.O['storage'].O['C'].AsString then begin
                        NewLicenceStatus:= lsHold;
                        NewLicenceStatusReason:= 'Server primary disk (drive C) configuration changed';
                        { save the new config so we can see changes in gui }
                        ConfigNew.ComputerId:= Computer.Id;
                        ConfigNew.AddNote(NewLicenceStatusReason);
                        SaveToDb(ConfigNew,ClientConn);
                      end
                      else if ConfigOld.Config.O['memory'].AsString <> ConfigNew.Config.O['memory'].AsString then begin
                        NewLicenceStatus:= lsReview;
                        NewLicenceStatusReason:= 'Server memory configuration changed';
                        { save the new config so we can see changes in gui }
                        ConfigNew.ComputerId:= Computer.Id;
                        ConfigNew.AddNote(NewLicenceStatusReason);
                        SaveToDb(ConfigNew,ClientConn);
                      end
                      else if ConfigOld.Config.O['bios'].AsString <> ConfigNew.Config.O['bios'].AsString then begin
                        NewLicenceStatus:= lsReview;
                        NewLicenceStatusReason:= 'Server BIOS configuration changed';
                        { save the new config so we can see changes in gui }
                        ConfigNew.ComputerId:= Computer.Id;
                        ConfigNew.AddNote(NewLicenceStatusReason);
                        SaveToDb(ConfigNew,ClientConn);
                      end
                      { removed to avoid problems with people plugging in and removing USB devices }
//                      else if ConfigOld.Config.O['storage'].AsString <>
//                        ConfigNew.Config.O['storage'].AsString then begin
//                        NewLicenceStatusReason:= 'Server disk configuration changed';
//                        ConfigOld.Text:= ConfigNew.Text;
//                        ConfigNew.AddNote(NewLicenceStatusReason);
//                        SaveToDb(ConfigOld,ClientConn);
//                      end
                      else begin
                        NewLicenceStatus:= lsReview;
                        NewLicenceStatusReason:= 'Server configuration changed';
                        { save the new config so we can see changes in gui }
                        ConfigNew.ComputerId:= Computer.Id;
                        ConfigNew.AddNote(NewLicenceStatusReason);
                        SaveToDb(ConfigNew,ClientConn);
                      end;

                      if NewLicenceStatus <> lsUnknown then begin
                        { update licences if need be }
                        for LicenceCount:= 0 to Computer.LicenceList.Count -1 do begin
                          Licence:= TSoftwareLicence(Computer.LicenceList.Items[LicenceCount]);
                          if (Licence.Status <> lsUnknown) and (Licence.Status <> NewLicenceStatus) then begin
                            if Licence.Status = lsLicenced then begin
                              Licence.Status:= NewLicenceStatus;
                              Licence.StatusReason:= NewLicenceStatusReason;
                              SaveToDb(Licence,ClientConn);
                            end;
                          end;
                        end;
                      end;

                    finally
                      ConfigOld.Free;
                    end;
                  end;
                finally
                  IdList.Free;
                end;
              end;
            end;

            { limit the number of computer config records we keep in database ... }
            TrimOldComputerConfigs(Computer.Id,ClientConn);

            {update clients config list from ours}
            Computer.ConfigList.Clear;
            IdList:= GetChildIdList(ClientConn,'TComputerConfig','ComputerId',Computer.Id);
            try
              for ConfigCount:= 0 to IdList.Count -1 do begin
                Config:= Computer.ConfigList.Add;
                Config.Id:= IdList[ConfigCount];
                LoadFromDb(Config,ClientConn);
              end;
            finally
              IdList.Free;
            end;

          end;
          { send result back }
          O:= JO;
          ObjToJson(ClientConfig,O);
          Res.O['result']:= O;
          SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     All done, sending config info record back to client.',ltDetail);

          ClientConn.Commit;
        except
          ClientConn.Rollback;
          raise;
        end;


      finally
        ClientConn.Free;
      end;

    finally
      ClientConfig.Free;
      NewConfigIdList.Free;
    end;
  except
    on e: exception do begin
      SessionList.Module.Logger.Log('Error processing ClientConfig request with message: ' + e.Message,ltError);
      Res.O['error']:=
        JO('{"code": '+ IntToStr(-1) +
        ', "message": "Error processing ClientConfig request with message: ' + e.Message + '"}');
    end;
  end;
end;

initialization
  if not Assigned(fModuleClientServer) then
    fModuleClientServer:= TModuleClientServer.Create;

finalization
  fModuleClientServer.Free;
  fModuleClientServer:= nil;

end.
