unit LicenceCheckThreadTask;

interface

uses
  ServerModuleThreadTask, DBBackupObj, JsonRpcTcpClient;

type

  TLicenceCheckThreadTask = class(TServerModuleThreadTask)
  private
    function StartERPServerSession(var msg: string; aERPClient: TJsonRpcTcpClient): boolean;
  protected
    procedure DoWork; override;
  end;

const
  OneMinute = 1/24/60;
  UPDATE_USER = 'Client';
  PERIOD_VALIDATION_CHECK = OneMinute * 240;  // four hours
  PERIOD_REVALIDATION_CHECK = OneMinute * 30; // half hour
  PERIOD_NO_CONNECT_CANCEL = 7;

implementation

uses
  ClientConfigObj, JsonObject, ERPDbInfo, LogMessageTypes,
  JsonToObject, DateTimeUtils, SysUtils, MachineSignature, ModUserUtils,
  ERPVersionConst;

{ TLicenceCheckThreadTask }

procedure TLicenceCheckThreadTask.DoWork;
var
  StoredConfig: TClientConfig;
  ConfigChanged: boolean;
  ReceivedConfigChanged: boolean;
  Sig: TJsonObject;
  pcName: string;
  thisPc: TComputer;
  ComputerConfig: TComputerConfig;
  SoftwareLicence: TSoftwareLicence;
  msg: string;
  json: TJsonObject;
  req, resp: TJsonObject;
  ErpInfo: TJsonObject;
  ERPClient: TJsonRpcTcpClient;
  UserUtils: TModUserUtils;
begin
  try
    if (not Assigned(ServerModule)) or (not (ServerModule is TModUserUtils)) then
      raise Exception.Create('Eror TLicenceCheckThreadTask - TModUserUtils Server Module not assigned');
    UserUtils := TModUserUtils(ServerModule);
    configChanged:= false;

    { if we dont have erp databasees on this machine we dont need to
      check licence or do updates }
    if not ERPDbInfo.GetERPDatabaseInfo(ErpInfo, MySQLServer) then begin
      if Assigned(ErpInfo) then begin
        Log('Error checking ERP databases on this computer: ' + #13#10 +
          '          "' + ErpInfo.S['error'] + '"' + #13#10 +
          '          ' + 'Aborting licence check.',ltError);
        ErpInfo.Free;
      end
      else begin
        Log('No ERP database found on this computer, aborting licence check.',ltError);
      end;
      exit;
    end;



    { have a look at the current stored licence config info }
    StoredConfig:= TClientConfig.Create;
    try

      Json:= JO;
      try
//        Json.AsString := UserUtils.ConfigText;
        Json.AsString := UserUtils.ClientConfig;
        JsonToObj(Json.O['clientconfig'],StoredConfig);
//        LastMasterValidationTime:= Module.Config.F['lastmastervalidationtime'];
      finally
        Json.Free;
      end;

      { first check for changes aginst current machine config }
      if StoredConfig.ServerList.Count = 0 then begin
        { we don't have any info so create new }
        Log('No servers found in Licence Config - Creating new config for UNKNOWN',ltWarning);
        configChanged:= true;
        StoredConfig.Name:= 'UNKNOWN';
        StoredConfig.SoftwareReleaseType:= Default_Install_Version;
        StoredConfig.Active:= true;
        StoredConfig.Id:= 0;
        StoredConfig.User:= UPDATE_USER;
        StoredConfig.DateTime:= NowUTC;
      end
      else begin
        { we have an existing config so we don't need to check so frequently }
        UserUtils.NextValidateTime:= now + PERIOD_VALIDATION_CHECK;
      end;

      { we have a list of computers }
      pcName:= MachineSignature.GetPCName;
      thisPc:= StoredConfig.ServerList.ByName(pcName);
      if not Assigned(thisPc) then begin
        { get pc info }
        Log('No config found for this server - Creating new config for ' + pcName,ltWarning);
        configChanged:= true;
        thisPc:= StoredConfig.ServerList.Add;
        thisPc.ComputerName:= pcName;
        thisPc.Id:= 0;
        thisPc.Active:= true;
        thisPc.ClientId:= 0;
        thisPc.User:= UPDATE_USER;
        thisPc.DateTime:= NowUTC;
      end;
      if thisPc.ConfigList.Count = 0 then begin
        Log('Initialising Computer Config for ' + pcName, ltWarning);
        configChanged:= true;
        ComputerConfig:= thisPc.ConfigList.Add;
        ComputerConfig.Id:= 0;
        ComputerConfig.ComputerId:= thisPc.Id;
        ComputerConfig.Active:= true;
        ComputerConfig.User:= UPDATE_USER;
        ComputerConfig.DateTime:= NowUTC;
      end
      else  begin
        ComputerConfig:= TComputerConfig(thisPc.ConfigList.Items[thisPc.ConfigList.Count-1]);
      end;

      { now signature }
      sig:= GetMachineSignature;
      try
        if ComputerConfig.Id < 1 then begin
          ComputerConfig.Text:= sig.AsString;
        end
        else begin
          if ComputerConfig.Text <> sig.AsString then begin
            { add a new config record }
            configChanged:= true;
            ComputerConfig:= thisPc.ConfigList.Add;
            ComputerConfig.Id:= 0;
            ComputerConfig.ComputerId:= thisPc.Id;
            ComputerConfig.Active:= true;
            ComputerConfig.Text:= sig.AsString;
            ComputerConfig.User:= UPDATE_USER;
            ComputerConfig.DateTime:= NowUTC;
          end else begin
          end;
        end;
      finally
        sig.Free;
      end;

      { now licence info }
      SoftwareLicence:= thisPc.LicenceList.ByName('ERP');
      if not Assigned(SoftwareLicence) then begin
        Log('No Licence found for this server - Creating new Licence with Unknown Status.',ltWarning);
        configChanged:= true;
        SoftwareLicence:= thisPc.LicenceList.Add;
        SoftwareLicence.SoftwareName:= 'ERP';
        SoftwareLicence.Status:= lsUnknown;
        SoftwareLicence.StatusReason:= 'Unknown licence status';
        SoftwareLicence.Active:= false;
        SoftwareLicence.Id:= 0;
        SoftwareLicence.ComputerId:= thisPc.Id;
        SoftwareLicence.User:= UPDATE_USER;
        SoftwareLicence.DateTime:= NowUTC;
      end else begin
      end;

      if SoftwareLicence.Data.O['erpinfo'].AsString <> ErpInfo.AsString then begin
        SoftwareLicence.Data.O['erpinfo'].AsString:= ErpInfo.AsString;
        SoftwareLicence.User:= UPDATE_USER;
        SoftwareLicence.DateTime:= NowUTC;
        configChanged:= true;
      end else begin
      end;


(*
      if FileExists(ExtractFilePath(self.ModuleFileName) + 'clientconfig_out.cfg') then begin
        Json:= JO;
        try
          ObjToJson(StoredConfig,Json.O['clientconfig']);
          Json.SaveToFile(ExtractFilePath(self.ModuleFileName) + 'clientconfig_out.cfg');
          if FileExists(ExtractFilePath(self.ModuleFileName) + 'clientconfig_in.cfg') then begin
            Json.LoadFromFile(ExtractFilePath(self.ModuleFileName) + 'clientconfig_in.cfg');
            self.ConfigText := Json.AsString;
            LastMasterValidationTime:= now;
            SaveConfig(true);
            exit;
          end;
        finally
          Json.Free;
        end;
      end;
*)

      ERPClient := TJsonRpcTcpClient.Create;
      try
        if StartERPServerSession(msg, ERPClient) then begin
          try
            Log('Communicating with ERP server.',ltDetail);
            req:= JO;
            try
              ObjToJson(StoredConfig,req);
            except
              on e: exception do begin
                Log('Error converting item to json: ' + e.message, ltError);
                exit;
              end;
            end;
            try
              resp:= ERPClient.SendRequest('ClientServer.clientconfig',req);
            except
              on e: exception do begin
                Log('Error while sending registration data: ' + e.message, ltError);
                exit;
              end;
            end;
            if not ERPClient.Connected then begin
              Log('Lost connection with head office server after sending request.', ltError);
              exit;
            end;
            if Assigned(resp) then begin
              try
                if resp.ObjectExists('result') then begin
                   ReceivedConfigChanged := not SameText(resp.O['result'].AsString, ObjToStr(StoredConfig));


                  if ConfigChanged or ReceivedConfigChanged then begin

                    if ConfigChanged then
                      Log('    Sent updated config information to ERP server.',ltDetail)
                    else
                      Log('    Updated config information received from ERP server.',ltDetail);


                    { need to update config }
                    JsonToObj(resp.O['result'],StoredConfig);

                    { write config info back }
                    Json := JO;
                    try
                      ObjToJson(StoredConfig,Json.O['clientconfig']);
//                      UserUtils.ConfigText := Json.AsString;
                      UserUtils.ClientConfig := Json.AsString;
                      UserUtils.LastMasterValidationTime:= now;
//                      UserUtils.SaveConfig(true);
//                      UserUtils.SaveConfig;
                      { Save SMS config info }
                      pcName:= MachineSignature.GetPCName;
                      thisPc:= StoredConfig.ServerList.ByName(pcName);
                      if Assigned(thisPC) then begin
                        SoftwareLicence:= thisPc.LicenceList.ByName('ERP');
                        if Assigned(SoftwareLicence) then
                          SetERPDatabaseInfo(SoftwareLicence.Data.O['erpinfo'], MySQLServer);
                      end;
                    finally
                      Json.Free;
                    end;
                  end
                  else begin
                    { update the time }
                    UserUtils.LastMasterValidationTime:= now;
//                    UserUtils.SaveConfig(true);
                    UserUtils.SaveConfig;
                  end;
                end else begin
                  ////// License Fix - to remove
                  if true then begin
                    SoftwareLicence.Status :=lsLicenced;
                  end else begin
                  ////// License Fix - to remove

                      if resp.ObjectExists('error') then begin
                        Log('    Error respone received while sending' +
                          ' client config with message: ' + resp.O['error'].S['message'],ltWarning);
                      end
                      else begin
                        Log('    Unrecognised response received from ERP Head Office server when sending registration data.',ltWarning);
                      end;
                  end;
                end;
              finally
                resp.Free;
              end;
            end
            else begin
              Log('    No response received from ERP Head Office server when sending registration data.',ltWarning);
            end;
          finally
            ERPClient.Connected:= false;
            Log('Finished communicating with ERP server.',ltDetail);
          end;
        end
        else begin
          Log('Could not establish a connection with ERP Head Office server with message: ' + msg,ltWarning);
        end;

      finally
        ERPClient.Free;
      end;
      if Assigned(SoftwareLicence) then begin
        case SoftwareLicence.Status of
          lsUnknown, lsPending, lsHold, lsReview:
            UserUtils.NextValidateTime:= now + PERIOD_REVALIDATION_CHECK;
          lsLicenced, lsCancelled: ;  { default to normal check interval }
        end;
      end;

      if (UserUtils.LastMasterValidationTime > 0) and
        ((now - UserUtils.LastMasterValidationTime) >= PERIOD_NO_CONNECT_CANCEL) then begin
        { been trying to send info back to ERP head office for too long ...
          invalidate licence and give reason }
        Log('Could not establish a connection with ERP Head Office ' +
          'server after trying for a number of days.',ltError);
      end;

    finally
      StoredConfig.Free;
      ErpInfo.Free;
    end;
  except
    on e: exception do begin
      Log('Error during CheckLicence: ' + e.Message, ltError);
    end;
  end;
end;

function TLicenceCheckThreadTask.StartERPServerSession(var msg: string;
  aERPClient: TJsonRpcTcpClient): boolean;
var
  UserUtils: TModUserUtils;
begin
  if (not Assigned(ServerModule)) or (not (ServerModule is TModUserUtils)) then
    raise Exception.Create('Eror TLicenceCheckThreadTask - TModUserUtils Server Module not assigned');
  UserUtils := TModUserUtils(ServerModule);
  msg:= '';
  result:= aERPClient.Connected;
  if result then
    exit;
  aERPClient.ServerName:= UserUtils.ERPServerName;
  aERPClient.Port:= UserUtils.ERPServerPort;
  try
    aERPClient.Connected:= true;
  except
    on exception do begin
      try
        aERPClient.ServerName:= 'ERPServer1';
        aERPClient.Connected:= true;
      except
        on exception do begin
          try
            aERPClient.ServerName:= 'Server1';
            aERPClient.Connected:= true;
          except
            on e: exception do begin
              msg:= e.Message;
            end;
          end;
        end;
      end;
    end;
  end;
  if not aERPClient.Connected then begin
    try
      aERPClient.ServerName:= 'ERPServer1';
      aERPClient.Connected:= true;
    except
    end;
  end;
  if not aERPClient.Connected then begin
    try
      aERPClient.ServerName:= 'Server1';
      aERPClient.Connected:= true;
    except
    end;
  end;

  result:= aERPClient.Connected;
end;

end.
