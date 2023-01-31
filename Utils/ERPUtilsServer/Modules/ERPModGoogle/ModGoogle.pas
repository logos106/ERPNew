unit ModGoogle;

interface

uses
  ServerModuleObj, JsonObject, SysUtils, LogThreadBase;

type

  TModGoogle = class(TServerModule)
  private
    fNextCheckTime: TDateTime;
    procedure GetTerminated(var IsTerminated: boolean);
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
    procedure SetActive(const Value: boolean); override;
    function GetActive: boolean; override;
  public
    constructor Create(aLogger: TLoggerBase = nil); override;
    destructor Destroy; override;
//    procedure LoadConfig; override;
//    procedure SaveConfig; override;
  published

  end;

implementation

uses
  LogMessageTypes, JsonToObject, JsonRPCUtils, JsonRPCConst, AnalyticsObj,
  Classes, DbUtils, SharedAppUserListObj, ModuleConst;

const
  OneMinute = 1/26/60;
  CheckInterval = OneMinute * 60;
  InitialCheckInterval = OneMinute {* 30};


{ TModGoogle }

procedure TModGoogle.AfterLoadConfig;
begin
  inherited;

end;

constructor TModGoogle.Create(aLogger: TLoggerBase);
begin
  inherited;
  LoadConfig;
  fNextCheckTime:= now + InitialCheckInterval;
end;

destructor TModGoogle.Destroy;
begin

  inherited;
end;

procedure TModGoogle.DoOnCommandMessage(aData: string; ctx: TJsonObject);
begin
  inherited;

end;

procedure TModGoogle.DoOnCommandRequest(aRequest: string;
  var aResponse: string);
begin
  inherited;

end;

procedure TModGoogle.DoOnMessage(aClientId: integer; aData: string;
  ctx: TJsonObject);
begin
  inherited;

end;

procedure TModGoogle.DoOnMessage(aClientId: integer; aData, ctx: TJsonObject);
begin
  inherited;

end;

procedure TModGoogle.DoOnRequest(aClientId: integer; aRequest, ctx,
  aResponse: TJsonObject);
var
  methodName: string;
  idx: integer;
begin
  if Terminated then
    exit;
  methodName:= Lowercase(aRequest.S['method']);
  Log('Request: ' +  methodName, ltDetail);
  try
    inherited;

    if ctx.B['Handled'] = true then
      exit;

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
    else begin
      AddResultError(aResponse,'Request method (' + methodName + ') not found',RPC_METHOD_NOT_FOUND);
    end;

  finally
    if Assigned(aResponse) then begin
      if aResponse.Exists('result') then
        Log('Result: ' + aResponse.ItemByName['result'].Value.AsString,ltDetail);
    end;
  end;
end;

procedure TModGoogle.DoOnRequest(aClientId: integer; aRequest: string;
  ctx: TJsonObject; var aResponse: string);
begin
  inherited;

end;

procedure TModGoogle.DoWork;
var
  GoogleAnalytics: TGoogleAnalytics;
  dbList: TStringList;
  x: integer;
  SaveLoggingLevel: TLoggingLevel;
  AppUserList: TSharedAppUserList;
  msg: string;
  aUser, aReason: string;
begin
  inherited;
  if now >= fNextCheckTime then begin
    try
      if not Active then begin
        Log('Google Analitics cis not Active, skipping check.',ltInfo);
        exit;
      end;
      Log('Starting Google Analitics check ..',ltDetail);
      SaveLoggingLevel := self.LoggingLevel;
      GoogleAnalytics := TGoogleAnalytics.Create;
      dbList:= TStringList.Create;
      AppUserList := TSharedAppUserList.Create;
      try
        GoogleAnalytics.DbServerName := 'localhost';
        dbList.CommaText:= GetDatabaseList('localhost',true);
        GoogleAnalytics.Logger := self.Logger;
        GoogleAnalytics.OnGetTerminated := self.GetTerminated;
        for x:= 0 to dbList.Count -1 do begin
          if self.Terminated then
            exit;
          if TSharedAppUserList.ExLocked(dbList[x],self.MySQLServer,aReason,aUser) then begin
            Log('Could not check ERP Database ' + dbList[x] + ' ' + aReason,ltDetail);
            continue;
          end;

          GoogleAnalytics.DbDatabaseName:= dbList[x];
          Log('Checking ERP Database ' + dbList[x],ltDetail);
          if GoogleAnalytics.AnalyticsEnabled then begin
            Log('Starting check ..',ltDetail);
            if AppUserList.AddUser(msg,ERP_ADMIN_USER,dbList[x],'',0,'','',false,true) then begin
              try
//                LoggingLevel:= GoogleAnalytics.LoggingLevel;
                GoogleAnalytics.CheckForNewData;
              finally
                AppUserList.RemoveUser(ERP_ADMIN_USER,dbList[x]);
              end;
              self.LoggingLevel := SaveLoggingLevel;
            end
            else begin
              Log(self.ModuleName + ' is unable to check Google Analitics for database ' + dbList[x] + ': ' + msg,ltWarning);
            end;
          end
          else begin
            Log('Google Analitics not enabled for ' + dbList[x],ltDetail);
          end;
        end;
      finally
        GoogleAnalytics.Free;
        dbList.Free;
        AppUserList.Free;
      end;
      Log('Google Analitics check finished.',ltDetail);
    finally
      fNextCheckTime := now + CheckInterval;
    end;
  end;
end;

function TModGoogle.GetActive: boolean;
begin
  result := true; { module is always active, indervidual database configs can be active/inactive }
end;

function TModGoogle.GetModuleDescription: string;
begin
  result := 'Module to download Google Analytics data';
end;

//function TModGoogle.GetModuleVersion: string;
//begin
//  result := '11.0.0.0';
//end;

procedure TModGoogle.GetTerminated(var IsTerminated: boolean);
begin
  IsTerminated := self.Terminated;
end;

//procedure TModGoogle.LoadConfig;
//var
//  configFileName: string;
//begin
//  configFileName:= ChangeFileExt(self.ModuleFileName, '_Config.cfg');
//  if not FileExists(configFileName) then begin
//    { set defaults }
//    self.LoggingLevel := llInfo;
//    self.Active := true;
//    SaveConfig;
//  end;
//  inherited;
//
//end;
//
//procedure TModGoogle.SaveConfig;
//begin
//  inherited;
//
//end;

procedure TModGoogle.SetActive(const Value: boolean);
begin
  inherited;

end;

end.
