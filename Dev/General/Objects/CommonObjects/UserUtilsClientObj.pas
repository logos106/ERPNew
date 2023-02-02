unit UserUtilsClientObj;
//{$I ERP.inc}

interface

uses
  JsonRpcBase, JsonRpcTcpClient, JsonObject, OpProgressObj, contnrs,
  ProgressDialog, ExtCtrls, classes, MultiEventObj, LogThreadBase,
  LogMessageTypes, ERPDbComponents, CreditCardObj;

type

  TLoggedInUserCountChange = procedure (NewUserCount: integer) of object;

  TPayGatewayClient = class;
  TUserUtilsClient = class
  private
    fOnLoggedInUserCountChange: TLoggedInUserCountChange;
    fOnLostConnection: TNotifyEvent;
    ProgressDialog: TProgressDialog;
    fUserDisconnected: boolean;
    fOnLog: TOnLogEvent;
    function GetConnected: boolean;
    procedure SetConnected(const Value: boolean);
    procedure DoOnRequest(Client: TJsonRpcBase; ReqObj: TJSONObject; ResObj: TJSONObject = nil);
    procedure DoOnConnect(Client: TJsonRpcBase);
    procedure DoOnDisconnect(Client: TJsonRpcBase);
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
  public
    Client: TJsonRpcTcpClient;
    Events: TMultiEventClass;
    Logger: TLoggerBase;
    ServerModuleList: TJSONArray;
    PayGateway: TPayGatewayClient;
    constructor Create;
    destructor Destroy; override;
    procedure Connect(aServerName, aUserName: string);
    function AddUser(const aUserName, aDatabaseName: string;
      var msg: string; aFirstName: string = ''; aLastName: string = ''; aMultilogon: boolean = false; aSystemUser: boolean = false): boolean;
    function ConnectUser(var msg: string; const aServerName, aDatabaseName, aUserName: string;
      aFirstName: string = ''; aLastName: string = ''; aMultilogon: boolean = false): boolean;
    procedure RemoveUser(const aUserName, aDatabaseName: string);
    procedure Disconnect;
    property Connected: boolean read GetConnected write SetConnected;
    function LockLogon(var msg: string; const aDatabaseName, aReason: string): boolean;
    procedure UnlockLogon;
    function GetLoggedOnUserList(var UserList: string; aDatabaseName: string = ''): boolean;
    function HasUserLogedIn(UserName, aDatabaseName:String ): boolean;
    function GetDatabaseUserList(var UserList: string; const aDatabaseName, aUserName: string; ExcludeCurrentUser: boolean = true): boolean;
    function GetLoggedOnUserCount(aDatabaseName: string = ''; ExcludeMultiLogonUsers: boolean = false): integer;
    function GetDatabaseUserCount(const aDatabaseName: string): integer;
    property OnLoggedInUserCountChange: TLoggedInUserCountChange read fOnLoggedInUserCountChange
      write fOnLoggedInUserCountChange;
    function SendPresence(var ResponseInterval: TDateTime): boolean;
    function GetBackupArchiveList(var msg, list: string; const aDatabaseName: string = ''): boolean;
    function GetDatabaseList(const aServerName: string = ''): string;
    function GetUserUpdateInfo(const aVersion: string): TJsonObject;
    function GetFullUserList: TJsonObject;
    function DeleteServerFile(const aFileName: string): boolean;
    function DeleteServerFiles(const aFileNameMask: string): boolean;
    function DeleteAllTempFilesForReport(aTempFileName: string): boolean;
    function DeleteAllTempFilesForReportFromTempTable(aTempTableName: string; Connection: TERPConnection): boolean;
    property OnLostConnection: TNotifyEvent read fOnLostConnection write fOnLostConnection;
    function GetLicense(const aSoftwareName: string): TJsonObject;
    function GetModuleList(ModArray: TJSONArray): boolean;
    function ForceLicenceCheck: boolean;
    function ForceUpdateCheck: boolean;
    procedure TriggerSMSSend;
    procedure TriggerSMSCheck;
    function GetServerID: string;
    property OnLog: TOnLogEvent read fOnLog write fOnLog;
    function ServerModuleInstalled(const aModuleName: string): boolean;
    function ServerModuleActive(const aModuleName: string): boolean;
    function LicenceOptionEnabled(const OptionName: string): boolean;
    function GetTaskList: TJsonObject;
  end;

  TPayGatewayClient = class(TObject)
  private
    fUtilsClient: TUserUtilsClient;
    fModuleInstalled: boolean;
  public
    constructor Create(aUtilsClient: TUserUtilsClient);
    function Installed: boolean;
    procedure Initialise;
    function EnabledGatewayList: string;
    { get the bank account that is linked to gateway for currency ... }
    function BankAccountForCurrency(const aDatabase, aGatewayName, aCurrency: string; var msg: string): string;
    //function ProcessPayment(const aDatabase: string; aCard: TCreditCard; aCustPaymentId: integer; var msg: string): boolean;
    function ProcessPayment(const aDatabase: string; aCardPaymentID: integer; var msg: string): boolean;
  end;

const
  UserPresenceInterval = 20000;  { 20 sec }
  NetworkSpeedResponsePeriod = 75; //33;
  LockLogon_UserCount_RetryInterval = (1/24/60/60) * 2; { 2 seconds }
  LockLogon_UserCount_RetryPeriod = (1/24/60/60) * 60;  { 1 minute }
  USERS_IN_SYSTEM_MESSAGE = 'Users in system';

implementation

uses
  JsonRpcConst, sysutils, forms, JsonToObject,
  Dialogs, Vista_MessageDlg, ModuleConst, UtilsLib, Types, StrUtils,
  MySQLUtils, {CommonDbLib,} VersionUtils, InstallConst, {TempTableUtils,}
  CipherUtils, utCloudconst;

const
  MAX_PROGRESS_WAIT = (1/24/60) * 60; { 60 mins }

{ TUserUtilsClient }

procedure TUserUtilsClient.Connect(aServerName, aUserName: string);
var
  resp, o: TJsonObject;
begin
  if Connected then
    Disconnect;
  Client.ServerName := aServerName;

  try
    Client.Connected := true;
  except
  end;

  if Client.Connected then
  begin
    o := JO;
    o.S['sessiontype'] := 'client';
    o.S['username'] := aUserName;
    resp := Client.SendRequest('UserUtils.startsession', o);
    try
      if Assigned(resp) then
      begin
        if resp.StringExists('result') and (resp.S['result'] = 'ok') then
        begin
        end
        else
        begin
          { failed to establisg a session }
          Client.Connected := false;
        end;
      end
      else
      begin
        Client.Connected := false;
      end;
    finally
      Resp.Free;
    end;
  end;
end;

function TUserUtilsClient.AddUser(const aUserName, aDatabaseName: string;
  var msg: string; aFirstName: string = ''; aLastName: string = ''; aMultilogon: boolean = false; aSystemUser: boolean = false): boolean;
var
  JsonParams, JsonResult: TJsonObject;
begin
  result:= false;
  msg:= '';
  if not Client.Connected then begin
    msg:= 'Not connected to Utils Server';
    exit;
  end;
  JsonParams:= JO;
  JsonParams.S['user']:= aUserName;
  JsonParams.S['databasename']:= aDatabaseName;
  JsonParams.S['firstname']:= aFirstName;
  JsonParams.S['lastname']:= aLastName;
  JsonParams.B['multilogon']:= aMultilogon;
  JsonParams.B['SystemUser']:= aSystemUser;
  JsonResult:= Client.SendRequest('UserUtils.adduser',JsonParams);
  if Assigned(JsonResult) then begin
    try
      if JsonResult.ObjectExists('error') then begin
        msg:= 'Error: ' + JsonResult.O['error'].S['message'];
      end
      else begin
        if JsonResult.O['result'].B['ok'] = true then
          result:= true
        else
          msg:= 'Failed to add user "' + aUserName + '" for database "' + aDatabaseName + '".';
      end;
    finally
      JsonResult.Free;
    end;
  end
  else begin
    msg:= 'No response from Utils Server';
  end;
end;

function TUserUtilsClient.ConnectUser(var msg: string;
  const aServerName, aDatabaseName, aUserName: string;
  aFirstName: string = ''; aLastName: string = ''; aMultilogon: boolean = false): boolean;
var
  JsonParams, JsonResult : TJsonObject;
begin
  Result := false;
  msg := '';
  try
    Connect(aServerName, aUserName);
  except
  end;
  if not Client.Connected then begin
    msg:=
      'ERP is unable to connect to the ERP Service Menu.' + #13#10 + #13#10 +
      'Please ensure that this is installed on the same machine as the ERP MySQL Server.';
    exit;
  end;
  JsonParams := JO;
  JsonParams.S['user'] := aUserName;
  JsonParams.S['firstname'] := aFirstName;
  JsonParams.S['lastname'] := aLastName;
  JsonParams.B['multilogon'] := aMultilogon;
  JsonParams.S['databasename'] := aDatabaseName;
  JsonParams.S['softwarename'] := 'ERP';
  JsonResult := Client.SendRequest('UserUtils.validate', JsonParams);
  try
    if Assigned(JsonResult) then
    begin
      if JsonResult.O['result'].B['valid'] = false then begin
          msg :=
            'Unable to start ERP.' + #13#10 + #13#10 +
            JsonResult.O['result'].S['reason'];
          Log(msg, ltWarning);
        end
      else if JsonResult.O['result'].StringExists('serverversion') and
        (VersionUtils.VersionComp(JsonResult.O['result'].S['serverversion'], '1.0.1.1') < 0) then begin
        msg := 'Unable to start ERP.' + #13#10 + #13#10 +
          'This version of ERP requires ERP Service Menu version 1.0.1.2 or newer.';
        Log(msg,ltWarning);
      end
      else if JsonResult.O['result'].StringExists('moduleversion') and
        (VersionUtils.VersionComp(JsonResult.O['result'].S['moduleversion'], '1.0.1.5') < 0) then begin
        msg := 'Unable to start ERP.' + #13#10 + #13#10 +
          'This version of ERP requires ERP Service Menu version 1.0.1.2 and ERP UserUtils Module version 1.0.1.5 or newer.';
        Log(msg,ltWarning);
      end
      else
        Result := true;
    end
    else
    begin
    msg := 'Unable to start ERP.'#13#10#13#10'No response from server.';
      Log(msg,ltWarning);
    end;
  finally
    JsonResult.Free;
  end;
end;

constructor TUserUtilsClient.Create;
begin
  fUserDisconnected:= false;
  Events:= TMultiEventClass.Create;
  ServerModuleList := TJSONArray.Create;
  Client := TJsonRpcTcpClient.Create;
  Client.Port := JsonRpcConst.DEFAULT_TCP_PORT;
  Client.OnConnect := DoOnConnect;
  Client.OnDisconnect := DoOnDisconnect;
  Client.OnRequest := DoOnRequest;
  PayGateway := TPayGatewayClient.Create(self);
end;

destructor TUserUtilsClient.Destroy;
begin
  Client.Free;
  Events.Free;
  PayGateway.Free;
  ServerModuleList.Free;
  inherited;
end;

procedure TUserUtilsClient.Disconnect;
begin
  fUserDisconnected:= true;
  try
    Client.Connected:= false;
  finally
    fUserDisconnected:= false;
  end;
end;

procedure TUserUtilsClient.DoOnConnect(Client: TJsonRpcBase);
begin
  GetModuleList(ServerModuleList);
  PayGateway.Initialise;
end;

procedure TUserUtilsClient.DoOnDisconnect(Client: TJsonRpcBase);
begin
  if not fUserDisconnected then begin
    if Assigned(ProgressDialog) then begin
      ProgressDialog.CloseDialog;
      ProgressDialog.Free;
      ProgressDialog:= nil;
    end;
    if Assigned(fOnLostConnection) then
      fOnLostConnection(self);
  end;
end;

procedure TUserUtilsClient.DoOnRequest(Client: TJsonRpcBase;
                                ReqObj: TJSONObject; ResObj: TJSONObject = nil);
var
  method: string;
  idx: integer;
begin
  { process the request }
  method:= Lowercase(ReqObj.S['method']);
  idx:= Pos('.',method);
  if idx > 0 then
    method:= Copy(method,idx+1,Length(method));
  if method = 'usercountchange' then begin
    if Assigned(fOnLoggedInUserCountChange) then
      fOnLoggedInUserCountChange(ReqObj.O[TAG_CLOUD_Params].I['usercount']);
  end
  else if method = 'ping' then begin
    ResObj.S['result']:= 'ok';
  end
  else if method = 'progress' then begin

  end
  else if method = 'event' then begin
    if ReqObj.ObjectExists(TAG_CLOUD_Params) then begin
      if ReqObj.O[TAG_CLOUD_Params].StringExists('eventname') then begin
        if ReqObj.O[TAG_CLOUD_Params].StringExists('Value') then
          Events.FireEvent(self,ReqObj.O[TAG_CLOUD_Params].S['eventname'],ReqObj.O[TAG_CLOUD_Params].S['Value'])
        else if ReqObj.O[TAG_CLOUD_Params].ObjectExists('Value') then
          Events.FireEvent(self,ReqObj.O[TAG_CLOUD_Params].S['eventname'],ReqObj.O[TAG_CLOUD_Params].O['Value'].AsString);
      end;
    end;
  end;
end;

function TUserUtilsClient.ForceLicenceCheck: boolean;
var
  j: TJsonObject;
begin
  Result := false;
  j := Client.SendRequest('UserUtils.forcelicencecheck', nil);
  try
    if Assigned(j) then begin
      Result := SameText(j.S['result'], 'ok');
    end;
  finally
    j.Free;
  end;
end;

function TUserUtilsClient.ForceUpdateCheck: boolean;
var
  j: TJsonObject;
begin
  Result := False;
  j := Client.SendRequest('UserUtils.forceupdatecheck', nil);
  try
    if Assigned(j) then begin
      Result := SameText(j.S['result'], 'ok');
    end;
  finally
    j.Free;
  end;
end;

function TUserUtilsClient.GetConnected: boolean;
begin
  result:= Client.Connected;
end;

function TUserUtilsClient.LicenceOptionEnabled(const OptionName: string): boolean;
var
  obj, data: TJsonObject;
begin
  result := false;
  obj := GetLicense('ERP');
  if not Assigned(obj) then exit;
  data := JO;
  try
    data.AsString := obj.S['DataText'];
    result := data.O['Options'].B[OptionName];
  finally
    data.Free;
    obj.Free;
  end;
end;

function TUserUtilsClient.LockLogon(var msg: string; const aDatabaseName, aReason: string): boolean;
var
  JsonParams, JsonResult: TJsonObject;
  timeStart, RetryTimeStart: TDateTime;
  ProgressDlg: TProgressDialog;
  count: Integer;
  UsersOut: boolean;
begin
  result:= false;
  UsersOut:= false;
  ProgressDlg:= nil;
  if Connected then begin
    JsonParams:= JO;
    JsonParams.S['lockreason']:= aReason;
    JsonParams.S['databasename']:= aDatabaseName;
    JsonResult:= Client.SendRequest('UserUtils.locklogon',JsonParams);
    if Assigned(JsonResult) then begin
      try
        if JsonResult.ObjectExists('error') then begin
          msg:= 'Error: ' + JsonResult.O['error'].S['message'];
        end
        else begin
          if JsonResult.O['result'].B['ok'] = true then begin
            result:= true;
            { now wait till there is just one user in system }
            timeStart:= now;
            count:= 0;
            while true do begin
              Inc(Count);
              if (count = 2) then  begin
                if Application.MainForm <> nil then begin
                  ProgressDlg:= TProgressDialog.Create(nil);
                  ProgressDlg.Caption:= 'Locking user logon';
                  ProgressDlg.MaxValue:= Trunc(LockLogon_UserCount_RetryPeriod / LockLogon_UserCount_RetryInterval) + 1;
                  ProgressDlg.Step:= 1;
                  ProgressDlg.Value:= count;
                  ProgressDlg.Execute;
                end;
              end;
              if GetLoggedOnUserCount(aDatabaseName) <= 1 then begin
                UsersOut:= true;
                break;
              end;
              if (timeStart + LockLogon_UserCount_RetryPeriod) < now then begin
                result:= false;
                msg:= USERS_IN_SYSTEM_MESSAGE;
                break;
              end;
              RetryTimeStart:= now;
              repeat
                Sleep(50);
              until ((RetryTimeStart + LockLogon_UserCount_RetryInterval) < now);
              if ProgressDlg <> nil then begin
                ProgressDlg.StepIt;
                Application.ProcessMessages;
              end;
            end;
            ProgressDlg.Free;
            if not UsersOut then begin
              JsonParams:= JO;
              Client.SendNotification('UserUtils.unlocklogon',JsonParams);
            end;
          end
          else
            msg:= JsonResult.O['result'].S['reason'];
        end;
      finally
        JsonResult.Free;
      end;
    end
    else begin
      msg:= 'No response from ERP Service Menu';
    end;
  end
  else begin
    msg:= 'Not connected to ERP Service Menu';
  end;
end;

procedure TUserUtilsClient.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(logger) then
    Logger.Log(msg, LogMessageType);
  if Assigned(fOnLog) then
    fOnLog(msg, LogMessageType);
end;

procedure TUserUtilsClient.RemoveUser(const aUserName, aDatabaseName: string);
var
  params, j: TJsonObject;
begin
  params:= JO;
  params.S['user']:= aUserName;
  params.S['databasename']:= aDatabaseName;
  j := Client.SendRequest('UserUtils.removeuser',params);
  if Assigned(j) then begin
    try

    finally
      j.Free;
    end;
  end;
end;

procedure TUserUtilsClient.UnlockLogon;
var
  JsonParams: TJsonObject;
begin
  if Connected then begin
    JsonParams:= JO;
    Client.SendNotification('UserUtils.unlocklogon',JsonParams);
  end;
end;

procedure TUserUtilsClient.SetConnected(const Value: boolean);
begin
end;

procedure TUserUtilsClient.TriggerSMSCheck;
begin
  if Connected then begin
    Client.SendNotification('UserUtils.SMSCheck',nil);
  end;
end;

procedure TUserUtilsClient.TriggerSMSSend;
begin
  if Connected then begin
    Client.SendNotification('UserUtils.SMSSend',nil);
  end;
end;

function TUserUtilsClient.HasUserLogedIn(UserName, aDatabaseName:String ): boolean;
var
  JsonParams, JsonResult: TJsonObject;
  UserList:STring;
begin
  result:= True;
  if Connected then begin
    JsonParams:= JO;
    JsonParams.S['databasename']:= aDatabaseName;
    JsonResult:= Client.SendRequest('UserUtils.getuserlist',JsonParams);
    if Assigned(JsonResult) then begin
      try
        UserList:= JsonResult.O['result'].S['userlist'];
        result:= pos('"'+UserName+'"',UserList )<>0;
      finally
        JsonResult.Free;
      end;
    end;
  end;


end;
function TUserUtilsClient.GetLoggedOnUserList(var UserList: string;
  aDatabaseName: string = ''): boolean;
var
  JsonParams, JsonResult: TJsonObject;
begin
  result:= false;
  if Connected then begin
    JsonParams:= JO;
    JsonParams.S['databasename']:= aDatabaseName;
    JsonResult:= Client.SendRequest('UserUtils.getuserlist',JsonParams);
    if Assigned(JsonResult) then begin
      try
        UserList:= JsonResult.O['result'].S['userlist'];
        result:= true;
      finally
        JsonResult.Free;
      end;
    end;
  end;
end;

function TUserUtilsClient.GetModuleList(ModArray: TJSONArray): Boolean;
var
  json: TJsonObject;
  x: Integer;
  mdl: TJsonObject;
  lst: TJsonArray;
begin
  Result := False;
  ModArray.Clear;
  if not Connected then Exit;
  json := Client.SendRequest('getmodules', nil);
  if Assigned(json) then begin
    try
      Result := True;
      lst := json.O['result'].O['ModuleList'].A['Items'];
      for x := 0 to lst.Count - 1 do begin
        mdl := JO;
        mdl.Assign(lst.Items[x].AsObject.O['Module']);
        ModArray.Add(mdl);
      end;
    finally
      json.Free;
    end;
  end;
end;

function TUserUtilsClient.GetServerID: string;
var
  JsonResult: TJsonObject;
begin
  result := '';
  JsonResult:= Client.SendRequest('UserUtils.getserverid',nil);
  if Assigned(JsonResult) then begin
    try
      result:= JsonResult.O['result'].S['serverid'];
    finally
      JsonResult.Free;
    end;
  end;
end;

function TUserUtilsClient.GetTaskList: TJsonObject;
var
  resp: TJsonObject;
begin
  result:= nil;
  if Client.Connected then begin
    resp:= Client.SendRequest('gettasklist', nil);
    if Assigned(resp) then begin
      try
        if resp.ObjectExists('result') then begin
          result:= TJsonObject.Create;
          result.Assign(resp.O['result']);
        end
        else begin

        end;
      finally
        resp.Free;
      end;
    end;
  end;
end;

function TUserUtilsClient.GetLicense(const aSoftwareName: string): TJsonObject;
var
  resp,params: TJsonObject;
begin
  result:= nil;
  if Client.Connected then begin
    params:= JO;
    params.S['softwarename']:= aSoftwareName;
    resp:= Client.SendRequest('UserUtils.getlicence',params);
    if Assigned(resp) then begin
      try
        if resp.ObjectExists('result') and resp.O['result'].ObjectExists('licence') then begin
          result:= TJsonObject.Create;
          result.Assign(resp.O['result'].O['licence']);
        end
        else begin

        end;
      finally
        resp.Free;
      end;
    end;
  end;
end;

function TUserUtilsClient.GetLoggedOnUserCount(aDatabaseName: string = ''; ExcludeMultiLogonUsers: boolean = false): integer;
var
  JsonParams, JsonResult: TJsonObject;
begin
  result:= -1;
  if Connected then begin
    JsonParams:= JO;
    JsonParams.S['databasename']:= aDatabaseName;
    JsonParams.B['ExcludeMultiLogonUsers']:= ExcludeMultiLogonUsers;
    JsonResult:= Client.SendRequest('UserUtils.getdatabaseusercount',JsonParams);
    try
    if Assigned(JsonResult) then begin
        if JsonResult.ObjectExists('result') and JsonResult.O['result'].IntegerExists('usercount') then
          result:= JsonResult.O['result'].I['usercount'];
    end;
    finally
      JsonResult.Free;
    end;
  end;
end;

function TUserUtilsClient.GetDatabaseUserList(var UserList: string; const aDatabaseName, aUserName: string; ExcludeCurrentUser: boolean): boolean;
var
  sl: TStringList;
  s: string;
begin
  result:= false;
  if GetLoggedOnUserList(s,aDatabaseName) then begin

    sl:= TStringList.Create;
    try
      sl.CommaText:= s;
      if ExcludeCurrentUser then begin
        if sl.IndexOf(aUserName) > -1 then
          sl.Delete(sl.IndexOf(aUserName));
      end;
      UserList:= sl.CommaText;
      result:= true;
    finally
      sl.Free;
    end;
  end;
end;

function TUserUtilsClient.GetDatabaseUserCount(const aDatabaseName: string): integer;
begin
  result:= GetLoggedOnUserCount(aDatabaseName);
end;

function TUserUtilsClient.SendPresence(
  var ResponseInterval: TDateTime): boolean;
var
  JsonParams, JsonResult: TJsonObject;
  timeSent: TDateTime;
begin
  result:= false;
  ResponseInterval:= 0;
  if Connected then begin
    JsonParams:= JO;
    timeSent:= now;
    JsonResult:= Client.SendRequest('UserUtils.ping',JsonParams);
    if Assigned(JsonResult) then begin
      try
        if JsonResult.S['result'] = 'ok' then begin
          ResponseInterval:= now - timeSent;
          result:= true;
        end;
      finally
        JsonResult.Free;
      end;
    end;
  end;
end;


function TUserUtilsClient.ServerModuleActive(
  const aModuleName: string): boolean;
var
  x: integer;
begin
  result := false;
  for x := 0 to ServerModuleList.Count -1 do begin
    if SameText(ServerModuleList[x].AsObject.S['ModuleName'],aModuleName) then begin
      if ServerModuleList[x].AsObject.BooleanExists('Active') and ServerModuleList[x].AsObject.B['Active'] then
        result := true;
      exit;
    end;
  end;
end;

function TUserUtilsClient.ServerModuleInstalled(
  const aModuleName: string): boolean;
var
  x: integer;
begin
  result := false;
  for x := 0 to ServerModuleList.Count -1 do begin
    if SameText(ServerModuleList[x].AsObject.S['ModuleName'],aModuleName) then begin
      result := true;
      exit;
    end;
  end;
end;

function TUserUtilsClient.GetBackupArchiveList(var msg, list: string;
  const aDatabaseName: string): boolean;
var
  JsonParams: TJsonObject;
  JsonResult: TJsonObject;
  sl: TStringList;
  x: integer;
  dbName: string;
begin
  result:= false;
  list:= '';
  if Connected then begin
    JsonParams:= JO;
    JsonResult:= Client.SendRequest('UserUtils.getbackuparchivelist',JsonParams);
    if Assigned(JsonResult) then begin
      try
        if JsonResult.ObjectExists('error') then begin
          msg:= 'Error: ' + JsonResult.O['error'].S['message'];
          exit;
        end
        else begin
          result:= true;
          list:= JsonResult.S['result'];
          if aDatabaseName <> '' then begin
            sl:= TStringList.Create;
            try
              dbName:= Lowercase(aDatabaseName);
              sl.CommaText:= list;
              x:= 0;
              while x < sl.Count do begin
                if pos(dbName,sl[x]) = 1 then
                  Inc(x)
                else
                  sl.Delete(x);
              end;
              list:= sl.CommaText;
            finally
              sl.Free;
            end;
          end;
        end;
      finally
        JsonResult.Free;
      end;
    end
    else begin
      Msg:= 'No response received from ERP Service Menu';
      exit;
    end;
  end
  else begin
    Msg:= 'Not connected to ERP Service Menu';
  end;
end;

function TUserUtilsClient.GetDatabaseList(
  const aServerName: string): string;
var
  JsonParams: TJsonObject;
  JsonResult: TJsonObject;
begin
  result:= '';
  if Connected then begin
    JsonParams:= JO;
    JsonParams.S['servername']:= aServerName;
    JsonResult:= Client.SendRequest('UserUtils.getdatabaselist',JsonParams);
    if Assigned(JsonResult) then begin
      try
        result:= JsonResult.S['result'];
      finally
        JsonResult.Free;
      end;
    end;
  end;
end;

function TUserUtilsClient.GetUserUpdateInfo(const aVersion: string): TJsonObject;
var
  resp,o: TJsonObject;
begin
  result := nil;
  if Client.Connected then begin
    o := JO;
    o.S['version'] := aVersion;
    resp := Client.SendRequest('UserUtils.getuserupdateinfo', o);
    if Assigned(resp) then begin
      try
        if resp.ObjectExists('result') then begin
          Result := TJsonObject.Create;
          Result.Assign(resp.O['result']);
        end
        else begin
        end;
      finally
        resp.Free;
      end;
    end;
  end;
end;

function TUserUtilsClient.GetFullUserList: TJsonObject;
var
  resp: TJsonObject;
begin
  result:= nil;
  if Client.Connected then begin
    resp:= Client.SendRequest('UserUtils.getfulluserlist',nil);
    if Assigned(resp) then begin
      try
        if resp.ObjectExists('result') then begin
          if resp.O['result'].O['userlist'].Count > 0 then begin
            result:= TJsonObject.Create;
            result.Assign(resp.O['result'].O['userlist']);
          end
        end;
      finally
        resp.Free;
      end;
    end;
  end;
end;

function TUserUtilsClient.DeleteAllTempFilesForReport(
  aTempFileName: string): boolean;
var
  path, fileName: string;
  arr: TStringDynArray;
  s: string;
begin
  { NOTE: this expects a file format of:
    [File Path]\tmp_erp_[Machine Signature]_[Report Identifier]_[Random name].tmp
    C:\Windows\Temp\tmp_erp_5510C74D_GlobalList_HY139G2D.tmp }
  result := false;
  path := ExtractFilePath(aTempFileName);
  fileName := ExtractFileName(aTempFileName);
  arr := SplitString(fileName, '_');
  if High(arr) < 3 then exit;
  s := path + arr[0] + '_' + arr[1] + '_' + arr[2] + '_' + arr[3] + '_*.tmp';
  result := DeleteServerFiles(s);
end;

function TUserUtilsClient.DeleteAllTempFilesForReportFromTempTable(
  aTempTableName: string; Connection: TERPConnection): boolean;
var
  arr: TStringDynArray;
  s: string;
begin
  { NOTE: this expects a table name format of:
    tmp_erp_[Machine Signature]_[Report Identifier]_[Random name]
    tmp_erp_5510C74D_GlobalList_HY139G2D }
  result := false;
  arr := SplitString(aTempTableName, '_');
  if High(arr) < 3 then exit;
  s := StringReplace(GetMySQLTempDir(Connection),'\','/',[rfReplaceAll]) +
  arr[0] + '_' + arr[1] + '_' + arr[2] + '_' + arr[3] + '_*.tmp';
  result := DeleteServerFiles(s);
end;

function TUserUtilsClient.DeleteServerFile(
  const aFileName: string): boolean;
var
  resp, o: TJsonObject;
begin
  result:= false;
  if Client.Connected then begin
    o:= TJsonObject.Create;
    o.S['filename']:= aFileName;
    resp:= Client.SendRequest('UserUtils.deletefile',o);
    if Assigned(resp) then begin
      try
        if resp.BooleanExists('result') then begin
          result:= resp.B['result'];
        end;
      finally
        resp.Free;
      end;
    end;
  end;
end;

function TUserUtilsClient.DeleteServerFiles(const aFileNameMask: string): boolean;
var
  resp, o: TJsonObject;
begin
  result := false;
  if Client.Connected then begin
    o:= TJsonObject.Create;
    o.S['filename']:= aFileNameMask;
//    Client.SendNotification('UserUtils.deletefiles',o);
    resp := Client.SendRequest('UserUtils.deletefiles',o);
    if Assigned(resp) then begin
      try
        if resp.BooleanExists('result') then
          result:= resp.B['result']
        else if resp.StringExists('result') then
          result := resp.S['result'] = 'ok';
      finally
        resp.Free;
      end;
    end;
  end;
end;


{ TPayGatewayClient }

function TPayGatewayClient.BankAccountForCurrency(const aDatabase, aGatewayName,
  aCurrency: string; var msg: string): string;
var
  resp, params: TJsonObject;
begin
  result := '';
  if not Installed then exit;

  if fUtilsClient.Client.Connected then begin
    params := JO;
    params.S['Database'] := aDatabase;
    params.S['Gateway'] := aGatewayName;
    params.S['Currency'] := aCurrency;
    resp:= fUtilsClient.Client.SendRequest('PaymentGateway.GetLinkedAccount', params);
    if Assigned(resp) then begin
      try
        if resp.StringExists('result') then begin
          result:= resp.S['result'];
        end
        else if resp.ObjectExists('error') then begin
          msg := resp.O['error'].S['message'];
        end;

      finally
        resp.Free;
      end;
    end
    else begin
      result := '';
      msg := 'No Responce from TrueERP Server';
    end;
  end;
end;

constructor TPayGatewayClient.Create(aUtilsClient: TUserUtilsClient);
begin
  fUtilsClient := aUtilsClient;
end;

function TPayGatewayClient.EnabledGatewayList: string;
var
  resp: TJsonObject;
begin
  result := '';
  if not Installed then exit;

  if fUtilsClient.Client.Connected then begin
    resp:= fUtilsClient.Client.SendRequest('PaymentGateway.GetActiveGateways', nil);
    if Assigned(resp) then begin
      try
        if resp.StringExists('result') then begin
          result:= resp.S['result'];
        end;
      finally
        resp.Free;
      end;
    end;
  end;
end;

procedure TPayGatewayClient.Initialise;
begin
  fModuleInstalled := fUtilsClient.ServerModuleInstalled('ERPModPaymentGateway');
end;

function TPayGatewayClient.Installed: boolean;
begin
  result := fModuleInstalled;
end;

function TPayGatewayClient.ProcessPayment(const aDatabase: string;
  aCardPaymentID: integer; var msg: string): boolean;
var
  params, resp: TJSONObject;
begin
  result := true;
  if not Installed then begin
    result := false;
    msg := 'Payment Gateway Module not installed on the Server';
    exit;
  end;
  if fUtilsClient.Client.Connected then begin
    params := JO;
    params.I['CardPaymentID'] := aCardPaymentID;
    params.S['Database'] := aDatabase;
    resp:= fUtilsClient.Client.SendRequest('PaymentGateway.ProcessPayment', params);
    if Assigned(resp) then begin
      try
        if resp.StringExists('result') then begin
          result := true; //resp.S['result'];
        end
        else if resp.ObjectExists('error') then begin
          result := false;
          msg := resp.O['error'].S['message'];
        end;
      finally
        resp.Free;
      end;
    end
    else begin
      result := false;
      msg := 'No Responce from TrueERP Server';
    end;
  end
  else begin
    result := false;
    msg := 'Not connected to the ERP Server.';
    exit;
  end;
end;

(*
function TPayGatewayClient.ProcessPayment(const aDatabase: string;
  aCard: TCreditCard; aCustPaymentId: integer; var msg: string): boolean;
var
  resp, params, o: TJsonObject;
begin
  result := false;
  if not Installed then exit;

  if fUtilsClient.Client.Connected then begin
    params := JO;
    o := JO;
    try
      o.S['Database'] := aDatabase;
      ObjToJson(aCard,o.O['Card']);
      o.I['CustomerPaymentID'] := aCustPaymentID;
      { send data encrypted .. }
      params.S['Data'] := EncryptString(o.AsString);
      finally
      o.Free;
    end;
    resp:= fUtilsClient.Client.SendRequest('PaymentGateway.ProcessPayment', params);
    if Assigned(resp) then begin
      try
        if resp.StringExists('result') then begin
          result := true; //resp.S['result'];
        end
        else if resp.ObjectExists('error') then begin
          msg := resp.O['error'].S['message'];
        end;

      finally
        resp.Free;
      end;
    end
    else begin
      result := false;
      msg := 'No Responce from TrueERP Server';
    end;
  end;
end;
*)

end.
