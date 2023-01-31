  unit ModClientServer;

interface

uses
  ServerModuleObj, JsonObject, ThreadProperty, SysUtils, ClientConfigObj,
  LogThreadBase;


type

  TModClientServer = class(TServerModule)
  private
    fClientServerNameProp: TThreadProperty;
    fNexExpireCheckTime: TDateTime;
    function GetClientServerName: string;
    procedure SetClientServerName(const Value: string);
    procedure ProcessClientConfig(Req, Res: TJsonObject);
    function GetClientConfig(aId: integer): TClientConfig;
  protected
    function GetModuleDescription: string; override;
//    function GetModuleVersion: string; override;
    procedure AfterLoadConfig; override;

    procedure DoOnMessage(aClientId: integer; aData: string; ctx: TJsonObject); override;
    procedure DoOnMessage(aClientId: integer; aData: TJsonObject; ctx: TJsonObject); override;
    procedure DoOnCommandMessage(aData: string; ctx: TJsonObject); override;

    procedure DoOnRequest(aClientId: integer; aRequest: string; ctx: TJsonObject; var aResponse: string); override;
    procedure DoOnRequest(aClientId: integer; aRequest: TJsonObject; ctx: TJsonObject; aResponse: TJsonObject = nil); override;
    procedure DoOnCommandRequest(aRequest: string; var aResponse: string); override;

    procedure DoWork; override;
    function GetGuiInERP: boolean; override;
  public
    constructor Create(aLogger: TLoggerBase = nil); override;
    destructor Destroy; override;
//    procedure LoadConfig(encrypt: boolean = false); override;
//    procedure SaveConfig(encrypt: boolean = false); override;
  published
    property ClientServerName: string read GetClientServerName write SetClientServerName;
  end;

implementation

uses
  Classes, LogMessageTypes, JsonToObject, JsonRPCUtils, JsonRPCConst, MyAccess,
  IntegerListObj, DbConst, ClientServerDbUtils, InstallConst, DateTimeUtils,
  JsonObjectUtils;

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


{ TModClientServer }

procedure TModClientServer.AfterLoadConfig;
begin
  inherited;

end;

constructor TModClientServer.Create(aLogger: TLoggerBase);
begin
  fClientServerNameProp := TThreadProperty.Create('');
  inherited;
  LoadConfig;
  fNexExpireCheckTime := now + (1/24);
  ForceDirectories(ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Log\ClientConfig');
end;

destructor TModClientServer.Destroy;
begin
  fClientServerNameProp.Free;
  inherited;
end;

procedure TModClientServer.DoOnCommandMessage(aData: string; ctx: TJsonObject);
begin
  inherited;

end;

procedure TModClientServer.DoOnCommandRequest(aRequest: string;
  var aResponse: string);
begin
  inherited;

end;

procedure TModClientServer.DoOnMessage(aClientId: integer; aData: string;
  ctx: TJsonObject);
begin
  inherited;

end;

procedure TModClientServer.DoOnMessage(aClientId: integer; aData,
  ctx: TJsonObject);
begin
  inherited;

end;

procedure TModClientServer.DoOnRequest(aClientId: integer; aRequest, ctx,
  aResponse: TJsonObject);
var
  methodName: string;
  idx: integer;
  ClientConfig: TClientConfig;
begin
  if Terminated then
    exit;
  methodName:= Lowercase(aRequest.S['method']);
  Log('Request: ' +  methodName, ltDetail);
  try
    inherited;

    idx:= Pos('.',methodName);
    if idx > 0 then
      methodName:= Copy(methodName,idx+1,Length(methodName));

    if SameText(methodName,'GetConfig') then begin
      ObjToJson(self, aResponse.O['result']);
    end
    else if SameText(methodName,'SetConfig') then begin
      if aRequest.ObjectExists('params') then begin
        JsonToObj(aRequest.O['params'],self);
        self.SaveConfig;
        JsonRPCUtils.AddResultOk(aResponse);
      end
      else begin
        JsonRPCUtils.AddResultError(aResponse,'Params object missing from request',RPC_INVALID_PARAMS);
      end;
    end
    else if SameText(methodName,'startsession') then begin
      Log('StartSession',ltDetail);
      if Assigned(aResponse) then begin
        Log('  Setting response to OK',ltDetail);
        aResponse.S['result']:= 'ok';
      end
      else begin
        Log('  No response object defined',ltDetail);
      end;
    end
    else begin
      if Active then begin

        if SameText(methodName,'clientconfig') then begin
          { save or update data to database }
          Log('DoRequest: clientconfig start',ltDetail);
          ProcessClientConfig(aRequest, aResponse);
          Log('DoRequest: clientconfig end',ltDetail);
        end
        else if SameText(methodName,'getclientconfig') then begin
          if aRequest.ObjectExists('params') then begin
            if aRequest.O['params'].IntegerExists('id') then begin
              { get from database }
              ClientConfig:= GetClientConfig(aRequest.O['params'].I['id']);
              if Assigned(ClientConfig) then begin
                ObjToJson(ClientConfig,aResponse.O['result']);
                ClientConfig.Free;
              end
              else begin
                JsonRPCUtils.AddResultError(aResponse,'Unable to read client data from database.');
                Log(ModuleName +' DoRequest - ' + aResponse.O['error'].S['message'],ltError);
              end;
            end;
          end;
        end
        else begin
            AddResultError(aResponse,'Request method (' + methodName + ') not found',RPC_METHOD_NOT_FOUND);
        end;
      end
      else begin
        { not active }
        JsonRPCUtils.AddResultError(aResponse,'Module ' + ModuleName + ' is inactive');
      end;


    end;

  finally
//    if Assigned(aResponse) then begin
//      if aResponse.Exists('result') then
//        Log('Result: ' + aResponse.ItemByName['result'].Value.AsString,ltDetail);
//    end;
  end;
end;

procedure TModClientServer.DoOnRequest(aClientId: integer; aRequest: string;
  ctx: TJsonObject; var aResponse: string);
begin
  inherited;

end;

procedure TModClientServer.DoWork;
var
  Conn: TMyConnection;
begin
  inherited;
  Sleep(100);
  if fNexExpireCheckTime < now then begin
    try
      try
        Conn:= TMyConnection.Create(nil);
        try
          InitialiseConnection(Conn, ClientServerName, SERVICES_DATABASE);
          Conn.Connect;
          UpdateExpired(Conn);
        finally
          Conn.Free;
        end;
      except
        on e: exception do begin
          Log('Error while checking for expired licences: ' + e.Message,ltError);
        end;
      end;
    finally
      fNexExpireCheckTime := now + (1/24);
    end;
  end;
end;

function TModClientServer.GetClientConfig(aId: integer): TClientConfig;
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
                             ClientServerName,
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

function TModClientServer.GetClientServerName: string;
begin
  result := fClientServerNameProp.AsString;
end;

function TModClientServer.GetGuiInERP: boolean;
begin
  result := false;
end;

function TModClientServer.GetModuleDescription: string;
begin
  result := 'Module to provide various functions for client ERP installations';
end;

//function TModClientServer.GetModuleVersion: string;
//begin
//  result := '11.0.0.0';
//end;

//procedure TModClientServer.LoadConfig(encrypt: boolean);
//var
//  configFileName: string;
//begin
//  configFileName:= ChangeFileExt(self.ModuleFileName, '_Config.cfg');
//  if not FileExists(configFileName) then begin
//    { set defaults }
//    self.LoggingLevel := llInfo;
//    self.ClientServerName := 'localhost';
//    self.Active := true;
//    SaveConfig(encrypt);
//  end;
//  inherited;
//end;

procedure TModClientServer.ProcessClientConfig(Req, Res: TJsonObject);
var
  ClientConfig: TClientConfig;
//  Computer: TComputer;
//  Config, ConfigOld, ConfigNew: TComputerConfig;
//  Licence, SavedLicence: TSoftwareLicence;
  ClientConn: TMyConnection;
//  ServerCount, ConfigCount, LicenceCount: integer;
//  IdList: TIntegerList;
//  NewLicenceStatus: TSoftwareLicenceStatus;
//  NewLicenceStatusReason: string;
////  ConfigChangeStr: string;
  O: TJsonObject;
//  NewConfigIdList: TIntegerList;
//  IdChanged: boolean;
//  sl: TStringList;

begin
  Log('ProcessClientConfig: start', ltDetail);
  try
    ClientConfig := TClientConfig.Create;
//    NewConfigIdList:= TIntegerList.Create;
    try
      ClientConn := TMyConnection.Create(nil);
      try
        InitialiseConnection(ClientConn,
                             ClientServerName,
                             SERVICES_DATABASE);

        ClientConn.Connect;
        ClientConn.StartTransaction;
        try
//          IdChanged:= false;
          JsonToObj(req.O['params'], ClientConfig);
          Log('ProcessClientConfig - Client: "' +
            clientConfig.Name + '" Computers: ' + clientConfig.ServerList.ComputerNameCommaText + ' Id: ' + IntToStr(ClientConfig.Id), ltDetail);

//          req.O['params'].SaveToFile('c:\ERP Software\Utilities\Log\' + clientConfig.Name + '.txt');
          try
            JsonToFileFormated(req.O['params'], ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Log\ClientConfig\' + clientConfig.Name + '_In.json');
          except
            Log('Error logging ClientConfig to file ..', ltError);
            Log('  Name: '+ clientConfig.Name, ltError);
          end;

          TLicenceUtils.ProcessLicence(ClientConfig, ClientConn, Log);

//          if ClientConfig.Id < 1 then begin
//            { new client so save it }
//            Log('ProcessClientConfig -     Saving new config.',ltDetail);
//            SaveToDb(ClientConfig,ClientConn);
//          end
//          else if not IdExists(ClientConfig,ClientConn) then begin
//            Log('ProcessClientConfig -     Could not find client with id ' + IntToStr(ClientConfig.Id) + ' so saving new record!',ltWarning);
//            ClientConfig.Id:= 0;
//            SaveToDb(ClientConfig,ClientConn);
//            IdChanged:= true;
//          end
//          else begin
//            { check for updates }
//            Log('ProcessClientConfig -     Checking database for updates for client: ' + ClientConfig.Name+ ' Id: ' + IntToStr(ClientConfig.Id),ltDetail);
//            if SavedObjIsNewer(ClientConfig,ClientConn) or (not ReleaseTypesMatch(ClientConfig,ClientConn)) then begin
//              Log('ProcessClientConfig -     We have changed client details so updating clients copy.',ltDetail);
//              LoadFromDb(ClientConfig,ClientConn);
//            end;
//          end;
//
//          for ServerCount:= 0 to ClientConfig.ServerList.Count -1 do begin
//            Computer:= TComputer(ClientConfig.ServerList.Items[ServerCount]);
//            if Computer.Id < 1 then begin
//              { this is a new server, so save it }
//              Log('ProcessClientConfig -     Saving new computer (server) details.',ltDetail);
//              Computer.ClientId:= ClientConfig.Id;
//              SaveToDb(Computer,ClientConn);
//            end
//            else if not IdExists(Computer,ClientConn) then begin
//              Computer.Id:= 0;
//              Log('ProcessClientConfig -     Could not find existing computer (server) id so saving new copy!',ltWarning);
//              Computer.ClientId:= ClientConfig.Id;
//              SaveToDb(Computer,ClientConn);
//              IdChanged:= true;
//            end
//            else begin
//              if SavedObjIsNewer(Computer,ClientConn) then begin
//                { check to see if we have changed computer.. if so send back to client }
//                Log('ProcessClientConfig -     We have updated computer (server) details so updating clients copy.',ltDetail);
//                LoadFromDb(Computer,ClientConn);
//              end;
//            end;
//
//            sl:= TStringList.Create;
//            try
//              LicenceCount:= 0;
//              while LicenceCount < Computer.LicenceList.Count do begin
//                Licence:= TSoftwareLicence(Computer.LicenceList.Items[LicenceCount]);
//                if sl.IndexOf(Licence.SoftwareName) > -1 then begin
//                  { there is more than one ocurance of this licence type! }
////                  SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Found more than one licence!',ltWarning);
////                  SessionList.Module.Logger.Log('ClientSession ProcessClientConfig -     Deleting the following licence:',ltWarning);
////                  SessionList.Module.Logger.Log(Licence.Description('          '),ltWarning);
////                  DeleteFromDb(Licence,ClientConn);
////                  Computer.LicenceList.Delete(LicenceCount);
//                  { for now ignore duplicates }
//                  Inc(LicenceCount);
//                end
//                else begin
//                  sl.Add(Licence.SoftwareName);
//                  if Licence.Id < 1 then begin
//                    Log('ProcessClientConfig -     Saving new licence.',ltDetail);
//                    Licence.ComputerId:= Computer.Id;
//                    SaveToDb(Licence,ClientConn);
//                  end
//                  else begin
//                    { Licence record has an id }
//                    if not IdExists(Licence,ClientConn) then begin
//                      Log('ProcessClientConfig -     Could not find existing licence id!',ltDetail);
//                      { id does not match anything in our database ...
//                        ( this may be a duplicate record that we have deleted at our end )}
//                      if Computer.LicenceList.ByName(Licence.SoftwareName) = nil then begin
//                        { we dont have any record for this software type .. so add this one }
//                        Licence.ComputerId:= Computer.Id;
//                        Licence.Id:= 0;
//                        SaveToDb(Licence,ClientConn);
//                        Log('ProcessClientConfig -     Could not find existing licence for software "' +
//                          Licence.SoftwareName + '" so saving record from client!',ltDetail);
//                        IdChanged:= true;
//                      end
//                      else begin
//                        { we do, so change the id }
//                        Licence.ComputerId:= Computer.Id;
//                        Licence.Id:= 0;
//                        SaveToDb(Licence,ClientConn);
//                        Log('ProcessClientConfig -     Licence record exists for "' +
//                          Licence.SoftwareName + '" so saving record from client with new ID!',ltDetail);
//                        IdChanged:= true;
//                      end;
//                    end
//                    else begin
//                      SavedLicence:= TSoftwareLicence.Create(nil);
//                      try
//                        LoadFromDb(SavedLicence,ClientConn,Licence.Id);
//                        { if datatext has been updated at client side update our copy }
////                        if SavedLicence.DataText <> Licence.DataText then begin
//                       if not SavedObjIsNewer(Licence,ClientConn) then begin
//                          Log('ProcessClientConfig -     Licence DataText has changed so updating our copy.',ltDetail);
////                          SavedLicence.DataText:= Licence.DataText;
////                          SaveToDb(SavedLicence,ClientConn);
//                          SaveToDb(Licence,ClientConn);
//                        end;
//                      finally
//                        SavedLicence.Free;
//                      end;
//                    end;
//                    if Licence.Status in [lsLicenced, lsHold, lsReview] then begin
//                      if Trunc(NowUTC) > Trunc(Licence.ExpireDate) then begin
//                        Licence.Status:= lsExpired;
//                        Licence.StatusReason:= 'Licence Expired';
//                        SaveToDb(Licence,ClientConn);
//                        Log('ProcessClientConfig -     Licence has expired so updating status.',ltDetail);
//                      end;
//                    end;
//                  end;
//                  Inc(LicenceCount);
//                end;
//              end;
//            finally
//              sl.Free;
//            end;
//
//            { clear Licence's and send latest back from us }
//            Computer.LicenceList.Clear;
//            IdList:= GetChildIdList(ClientConn,'TSoftwareLicence','ComputerId',Computer.Id);
//            try
//              for LicenceCount:= 0 to IdList.Count -1 do begin
//                Licence:= Computer.LicenceList.Add;
//                Licence.Id:= IdList[LicenceCount];
//                LoadFromDb(Licence,ClientConn);
//              end;
//            finally
//              IdList.Free;
//            end;
//
//
//            if Computer.ConfigList.Count > 0 then begin
//              { get last config record from clients data }
//              ConfigNew:= TComputerConfig(Computer.ConfigList.Items[Computer.ConfigList.Count -1]);
//              if ConfigNew.Id < 1 then begin
//                { this is a new config record so somthing has changed on clients machine }
//                { get existing config id list from db }
//                IdList:= GetChildIdList(ClientConn,'TComputerConfig','ComputerId',Computer.Id);
//                try
//                  if IdList.Count = 0 then begin
//                    { we dont have any config records yet so just save this one }
//                    Log('ProcessClientConfig -     Saving new computer (server) config.',ltDetail);
//                    ConfigNew.ComputerId:= Computer.Id;
//                    SaveToDb(ConfigNew,ClientConn);
//                  end
//                  else begin
//                    { grab most recent config we have and compare }
//                    ConfigOld:= TComputerConfig.Create(nil);
//                    try
//                      LoadFromDb(ConfigOld,ClientConn,IdList.Last);
//
//                      { serial number info is not reliable so set it the same so its ignored in comparison below }
//                      ConfigOld.Config.O['storage'].O['C'].F['volumeserialnumber'] :=
//                        ConfigNew.Config.O['storage'].O['C'].F['volumeserialnumber'];
//
//                      { compare the important bits }
//                      NewLicenceStatus:= lsUnknown;
//                      NewLicenceStatusReason:= '';
//                      if IdChanged then begin
//                        NewLicenceStatus:= lsCancelled;
//                        NewLicenceStatusReason:= 'Registration data does not match ERP Head Office records.';
//                        if ConfigOld.Text <> ConfigNew.Text then begin
//                          { update most recent record with new text data fro client }
//                          ConfigOld.Text:= ConfigNew.Text;
//                          SaveToDb(ConfigOld,ClientConn);
//                        end;
//                      end
//                      else if ConfigOld.Config.S['computername'] <> ConfigNew.Config.S['computername'] then begin
//                        NewLicenceStatus:= lsHold;
//                        NewLicenceStatusReason:= 'Server name changed';
//                        { save the new config so we can see changes in gui }
//                        ConfigNew.ComputerId:= Computer.Id;
//                        ConfigNew.AddNote(NewLicenceStatusReason);
//                        SaveToDb(ConfigNew,ClientConn);
//                      end
//                      else if ConfigOld.Config.O['system'].AsString <> ConfigNew.Config.O['system'].AsString then begin
//                        NewLicenceStatus:= lsHold;
//                        NewLicenceStatusReason:= 'Server processor configuration changed';
//                        { save the new config so we can see changes in gui }
//                        ConfigNew.ComputerId:= Computer.Id;
//                        ConfigNew.AddNote(NewLicenceStatusReason);
//                        SaveToDb(ConfigNew,ClientConn);
//                      end
//                      else if ConfigOld.Config.O['network'].AsString <> ConfigNew.Config.O['network'].AsString then begin
//                        { mac address changed }
//                        NewLicenceStatusReason:= 'Server network/mac address configuration changed';
//                        ConfigOld.Text:= ConfigNew.Text;
//                        ConfigNew.AddNote(NewLicenceStatusReason);
//                        SaveToDb(ConfigOld,ClientConn);
//                      end
//                      else if ConfigOld.Config.O['storage'].O['C'].AsString <>
//                        ConfigNew.Config.O['storage'].O['C'].AsString then begin
//                        NewLicenceStatus:= lsHold;
//                        NewLicenceStatusReason:= 'Server primary disk (drive C) configuration changed';
//                        { save the new config so we can see changes in gui }
//                        ConfigNew.ComputerId:= Computer.Id;
//                        ConfigNew.AddNote(NewLicenceStatusReason);
//                        SaveToDb(ConfigNew,ClientConn);
//                      end
//                      else if ConfigOld.Config.O['memory'].AsString <> ConfigNew.Config.O['memory'].AsString then begin
//                        NewLicenceStatus:= lsReview;
//                        NewLicenceStatusReason:= 'Server memory configuration changed';
//                        { save the new config so we can see changes in gui }
//                        ConfigNew.ComputerId:= Computer.Id;
//                        ConfigNew.AddNote(NewLicenceStatusReason);
//                        SaveToDb(ConfigNew,ClientConn);
//                      end
//                      else if ConfigOld.Config.O['bios'].AsString <> ConfigNew.Config.O['bios'].AsString then begin
//                        NewLicenceStatus:= lsReview;
//                        NewLicenceStatusReason:= 'Server BIOS configuration changed';
//                        { save the new config so we can see changes in gui }
//                        ConfigNew.ComputerId:= Computer.Id;
//                        ConfigNew.AddNote(NewLicenceStatusReason);
//                        SaveToDb(ConfigNew,ClientConn);
//                      end
//                      { removed to avoid problems with people plugging in and removing USB devices }
////                      else if ConfigOld.Config.O['storage'].AsString <>
////                        ConfigNew.Config.O['storage'].AsString then begin
////                        NewLicenceStatusReason:= 'Server disk configuration changed';
////                        ConfigOld.Text:= ConfigNew.Text;
////                        ConfigNew.AddNote(NewLicenceStatusReason);
////                        SaveToDb(ConfigOld,ClientConn);
////                      end
//                      else begin
//                        NewLicenceStatus:= lsReview;
//                        NewLicenceStatusReason:= 'Server configuration changed';
//                        { save the new config so we can see changes in gui }
//                        ConfigNew.ComputerId:= Computer.Id;
//                        ConfigNew.AddNote(NewLicenceStatusReason);
//                        SaveToDb(ConfigNew,ClientConn);
//                      end;
//
//                      if NewLicenceStatus <> lsUnknown then begin
//                        { update licences if need be }
//                        for LicenceCount:= 0 to Computer.LicenceList.Count -1 do begin
//                          Licence:= TSoftwareLicence(Computer.LicenceList.Items[LicenceCount]);
//                          if (Licence.Status <> lsUnknown) and (Licence.Status <> NewLicenceStatus) then begin
//                            if Licence.Status = lsLicenced then begin
//                              Licence.Status:= NewLicenceStatus;
//                              Licence.StatusReason:= NewLicenceStatusReason;
//                              SaveToDb(Licence,ClientConn);
//                            end;
//                          end;
//                        end;
//                      end;
//
//                    finally
//                      ConfigOld.Free;
//                    end;
//                  end;
//                finally
//                  IdList.Free;
//                end;
//              end;
//            end;
//
//            { limit the number of computer config records we keep in database ... }
//            TrimOldComputerConfigs(Computer.Id,ClientConn);
//
//            {update clients config list from ours}
//            Computer.ConfigList.Clear;
//            IdList:= GetChildIdList(ClientConn,'TComputerConfig','ComputerId',Computer.Id);
//            try
//              for ConfigCount:= 0 to IdList.Count -1 do begin
//                Config:= Computer.ConfigList.Add;
//                Config.Id:= IdList[ConfigCount];
//                LoadFromDb(Config,ClientConn);
//              end;
//            finally
//              IdList.Free;
//            end;
//
//          end;
          { send result back }
          try
            JsonToFileFormated(req.O['params'], ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Log\ClientConfig\' + clientConfig.Name + '_Out.json');
          except

          end;
          O := JO;
          ObjToJson(ClientConfig, O);
          Res.O['result'] := O;
          Log('ProcessClientConfig -     All done, sending config info record back to client.', ltDetail);

//          ClientConn.Commit;
        except
          ClientConn.Rollback;
          raise;
        end;


      finally
        ClientConn.Free;
      end;

    finally
      ClientConfig.Free;
//      NewConfigIdList.Free;
    end;
    Log('ProcessClientConfig: end',ltDetail);
  except
    on e: exception do begin
      Log('Error processing ClientConfig request with message: ' + e.Message,ltError);
      JsonRPCUtils.AddResultError(Res,'Error processing ClientConfig request with message: ' + e.Message);
    end;
  end;
end;

//procedure TModClientServer.SaveConfig(encrypt: boolean);
//begin
//  inherited;
//
//end;

procedure TModClientServer.SetClientServerName(const Value: string);
begin
  fClientServerNameProp.AsString := Value;
end;

end.
