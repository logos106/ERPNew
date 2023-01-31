unit AppEnvironment;

interface

uses

  AccessLevelObj, BranchObj, CompanyPrefObj, BusObjRegionalOptions, EmployeeObj,
  DefaultClassObj, PayPreferencesObj, busobjcompinfo, AppDatabase,
  ObjectFieldListObj,Contnrs,SyncObjs, ColoursPrefsObj, soundObj,
  UserUtilsClientObj, Controls, busobjAchInfo, GoogleUpdateObj, BusobjDocPath ,
  BusobjCrossStockCompanies;

type
  TAppEnvironment = class(TObject)
  private
    fThreadId: Cardinal;
    fEmployeeId: integer;
    fAccessLevels: TAccessLevelObj;
    fDbSupplied: TAppDatabase;
    fAppDb: TAppDatabase;
    fBranch: TBranchObj;
    fCompanyInfo: TCompanyInfo;
    fACHInfo :TACHInfo ;
    fColoursPrefs: TColoursPrefsObj;
    fEmployee: TEmployeeObj;
    fSoundObj :TSoundObj;
    fDefaultClass: TDefaultClassObj;
    fPayPrefs: TPayPreferencesObj;
    fRegionalOptions: TRegionalOptions;
    fCrossStockCompanies: TCrossStockCompanies;
    fDocPath: TDocPath;
    fCompanyPrefs: TCompanyPrefObj;
    fBusObjFieldList: TObjectFieldList;
    fUtilsClient: TUserUtilsClient;
    fGoogleUpdater: TGoogleUpdater;
    fDatabase, fServer: string;
    fServerID: string;
    fAPIMode: boolean;
    function GetAccessLevels: TAccessLevelObj;
    function GetAppDb: TAppDatabase;
    function GetBranch: TBranchObj;
    function GetCompanyInfo: TCompanyInfo;
    function GetAchInfo : TACHInfo;
    function GetCompanyPrefs: TCompanyPrefObj;
    function GetEmployee: TEmployeeObj;
    Function GetSoundObj :TSoundObj;
    function GetPayPrefs: TPayPreferencesObj;
    function GetColourPrefs: TColoursPrefsObj;
    function GetRegionalOptions: TRegionalOptions;
    function GetCrossStockCompanies: TCrossStockCompanies;
    function GetDocPath: TDocPath;
    function GetDefaultClass: TDefaultClassObj;
    function GetBusObjFieldList: TObjectFieldList;
    function GetAppName:String;
    function GetUtilsClient: TUserUtilsClient;
    procedure OnApplicationHint(var HintStr: String; var CanShow: Boolean;var HintInfo: Controls.THintInfo);
    function GetGoogleUpdater: TGoogleUpdater;
    function GetServerID: string;
    function getIsDBconnected: Boolean;

  public
//    constructor Create(Const EmployeeId: integer; Const aServer, aDatabase, aUser, aPass: string); overload;
//    constructor Create(Const EmployeeId: integer; Const aAppDb: TAppDatabase); overload;
//    constructor Create(Const aServer, aDatabase: string); overload;
    constructor Create(aAPIMode: boolean);   //overload;
    destructor Destroy; override;
    property ThreadId: Cardinal read fThreadId write fThreadId;
    property AppDb: TAppDatabase read GetAppDb;
    property AccessLevels: TAccessLevelObj read GetAccessLevels;
    property Branch: TBranchObj read GetBranch;
    property CompanyPrefs: TCompanyPrefObj read GetCompanyPrefs;
    property RegionalOptions: TRegionalOptions read GetRegionalOptions;
    property CrossStockCompanies: TCrossStockCompanies read GetCrossStockCompanies;
    property DocPath: TDocPath read GetDocPath;
    property Employee: TEmployeeObj read GetEmployee;
    Property SoundObj :TSoundObj Read getSoundObj;
    property DefaultClass: TDefaultClassObj read GetDefaultClass;
    property PayPrefs: TPayPreferencesObj read GetPayPrefs;
    property CompanyInfo: TCompanyInfo read GetCompanyInfo;
    Property AchInfo :TACHInfo read getAchInfo;
    property ColourPrefs: TColoursPrefsObj read GetColourPrefs;
    property BusObjFieldList: TObjectFieldList read GetBusObjFieldList;
    property ApplicationName:String read getAppName;
    procedure Reset;
    property UtilsClient: TUserUtilsClient read GetUtilsClient;
    Procedure ResetAchinfo;
    property GoogleUpdater: TGoogleUpdater read GetGoogleUpdater;
    property Server: string read fServer write fServer;
    property ServerID: string read GetServerID;
    Property IsDBConnected :Boolean read getIsDBconnected;
    property APIMode: boolean read fAPIMode write fAPIMode;
  end;

  TAppEnvironmentList = class(TObjectList)
  private
    fMySQLServer: string;
    fAPIMode: boolean;
  public
    constructor Create; overload;
    constructor Create(AOwnesObjects: boolean); overload;
    procedure RemoveAppEnvInstance(const aThreadId: cardinal = 0);
    function AppEnvForThread(const ThreadId: cardinal; AutoCreate: boolean = false): TAppEnvironment;
    property MySQLServer: string read fMySQLServer write fMySQLServer;
    property APIMode: boolean read fAPIMode write fAPIMode;
  end;

  function AppEnv :TAppEnvironment;
  function AppEnvList :TAppEnvironmentList;


implementation

uses
  SysUtils,Windows,Forms, BusObjBase;
var
  fAppEnvListLock :TCriticalSection;
  fAppEnvList :TAppEnvironmentList; { RPC Dll needs to access this }

//ThreadVar
//  fAppEnv: TAppEnvironment;

function AppEnvListLock :TCriticalSection;
begin
   if fAppEnvListLock = nil then
    fAppEnvListLock := TCriticalSection.Create;
   result := fAppEnvListLock ;
end;

{ TAppEnvironment }

procedure TAppEnvironment.OnApplicationHint(var HintStr: String; var CanShow: Boolean;      var HintInfo: Controls.THintInfo);
begin
  HintInfo.hintMaxwidth :=3000;
  HintInfo.HideTimeout := 10*1000; // 10 seconds
end;

//constructor TAppEnvironment.Create(Const EmployeeId: integer; Const aServer, aDatabase,  aUser, aPass: string);
//begin
//  inherited Create;
//  fDatabase := aDatabase;
//  fServer := aServer;
//  Application.OnShowHint := OnApplicationHint;
//  fEmployeeId:= EmployeeId;
//  fDbSupplied:= nil;
//  fAppDb:= TAppDatabase.Create(aServer, aDatabase);
//  fAppDb.ConnectUser(aUser, aPass);
//end;
//
//constructor TAppEnvironment.Create(Const EmployeeId: integer; Const aAppDb: TAppDatabase);
//begin
//  inherited Create;
//  Application.OnShowHint := OnApplicationHint;
//  fEmployeeId:= EmployeeId;
//  fDbSupplied:= aAppDb;
//  fAppDb:= nil;
//end;
//
//constructor TAppEnvironment.Create(Const aServer, aDatabase: string);
//begin
//  inherited Create;
//  fDatabase := aDatabase;
//  fServer := aServer;
//  Application.OnShowHint := OnApplicationHint;
//  fEmployeeId:= 0;
//  fDbSupplied:= nil;
//  fAppDb:= TAppDatabase.Create(aServer, aDatabase);
//end;

constructor TAppEnvironment.Create(aAPIMode: boolean);
begin
  inherited Create;;
  fAPIMode := aAPIMOde;
  Application.OnShowHint := OnApplicationHint;
  fEmployeeId:= 0;
  fDbSupplied:= nil;
  fAppDb:= TAppDatabase.Create(FServer, '', fAPIMode);
  fSoundObj := nil;
  fServerID := '';
end;

destructor TAppEnvironment.Destroy;
begin
  Application.OnShowHint := Nil;
  Reset;
  FreeAndNil(fUtilsClient);
//  if Assigned(fAppDb) then FreeAndNil(fAppDb);
  FreeAndNil(fAppDb);
  fGoogleUpdater.Free;
  inherited;
end;

function TAppEnvironment.GetAccessLevels: TAccessLevelObj;
begin
  if not Assigned(fAccessLevels) then begin
    fAccessLevels:= TAccessLevelObj.Create;
    AppEnv.AccessLevels.RightsAliasList.Values['TGlobalsearchGUI'] := 'TGlobalListFrm';
    AppEnv.AccessLevels.RightsAliasList.Values['TGlobalListSearchFrm'] := 'TGlobalListFrm';
  end;
  result:= fAccessLevels;
end;

function TAppEnvironment.GetAppDb: TAppDatabase;
begin
  if Assigned(fDbSupplied) then result:= fDbSupplied
  else begin
    if Not Assigned(fAppDb) then begin
      fAppDb:= TAppDatabase.Create(fServer, fDatabase, APIMode);
    end;
    result:= fAppDb
  end;
end;

function TAppEnvironment.GetBranch: TBranchObj;
begin
  if not Assigned(fBranch) then
    fBranch:= TBranchObj.Create;
  result:= fBranch;
end;

function TAppEnvironment.GetBusObjFieldList: TObjectFieldList;
begin
  if not Assigned(fBusObjFieldList) then
    fBusObjFieldList:= TObjectFieldList.Create;
  result:= fBusObjFieldList;
end;


function TAppEnvironment.GetCompanyInfo: TCompanyInfo;
begin
  if not Assigned(fCompanyInfo) then begin
    fCompanyInfo := TCompanyInfo.Create(nil);
    fCompanyInfo.IgnoreAccesslevel := true;
    fCompanyInfo.Load;
  end;
  fCompanyInfo.Opendb;
  result:= fCompanyInfo;
end;

function TAppEnvironment.GetAchInfo: TAchInfo;
begin
  if not Assigned(fAchInfo) then begin
    fAchInfo := TAchInfo.Create(nil);
    fAchInfo.Load;
  end;
  result:= fAchInfo;
end;

function TAppEnvironment.GetCompanyPrefs: TCompanyPrefObj;
begin
  if not Assigned(fCompanyPrefs) then begin
    try
      fCompanyPrefs := TCompanyPrefObj.Create;
      fCompanyPrefs.PopulateMe;
    Except
      on E:Exception do begin
        fCompanyPrefs := nil;
      end;
    end;
  end;
  result:= fCompanyPrefs;
end;

function TAppEnvironment.GetDefaultClass: TDefaultClassObj;
begin
  if not Assigned(fDefaultClass) then begin
    fDefaultClass:= TDefaultClassObj.Create;
    fDefaultClass.PopulateMe;
  end;
  result:= fDefaultClass;
end;

function TAppEnvironment.GetEmployee: TEmployeeObj;
begin
  if Assigned(fEmployee) then begin
    if fEmployee.EmployeeID <> AppEnv.AppDb.EmployeeID then
      FreeAndNil(fEmployee);
  end;
  if not Assigned(fEmployee) then begin
    fEmployee:= TEmployeeObj.Create;
    if fEmployeeId > 0 then
      fEmployee.PopulateMe(fEmployeeId)
    else begin
      fEmployee.PopulateMe(AppEnv.AppDb.EmployeeID);
    end;
  end;
  result:= fEmployee;
end;

function TAppEnvironment.GetGoogleUpdater: TGoogleUpdater;
begin
  if Assigned(fGoogleUpdater) then begin
    if (not SameText(fGoogleUpdater.Server,AppDb.Server)) or
    (not SameText(fGoogleUpdater.Database,AppDb.Database)) then
      FreeAndNil(fGoogleUpdater);
  end;

  if not Assigned(fGoogleUpdater) then
    fGoogleUpdater := TGoogleUpdater.Create(AppDb.Server, AppDb.Database);
  result := fGoogleUpdater;
end;

function TAppEnvironment.getIsDBconnected: Boolean;
begin
  result := Assigned(fAppDb) and
            fAppDb.IsDBconnected;
end;

function TAppEnvironment.GetPayPrefs: TPayPreferencesObj;
begin
  if not Assigned(fPayPrefs) then begin
    fPayPrefs:= TPayPreferencesObj.Create;
    fPayPrefs.PopulateMe;
  end;
  Result:= fPayPrefs;
end;

function TAppEnvironment.GetColourPrefs: TColoursPrefsObj;
begin
  if not Assigned(fColoursPrefs) then begin
    fColoursPrefs:= TColoursPrefsObj.Create;
    fColoursPrefs.PopulateMe;
  end;
  Result:= fColoursPrefs;
end;

function TAppEnvironment.GetRegionalOptions: TRegionalOptions;
begin
  if not Assigned(fRegionalOptions) then begin
    fRegionalOptions:= TRegionalOptions.Create(nil);
    fRegionalOptions.Connection:= TMyDacDataConnection.Create(fRegionalOptions);
    fRegionalOptions.Connection.Connection:= self.AppDb.Connection;
  end;

  if fRegionalOptions.count = 0 then begin
    fRegionalOptions.LoadSelect('Region = ' + QuotedStr(CompanyPrefs.CompanyRegion));
    fRegionalOptions.SetupRegion;
  end;
  result:= fRegionalOptions;
end;
function TAppEnvironment.GetCrossStockCompanies: TCrossStockCompanies;
begin
  if not Assigned(fCrossStockCompanies) then begin
    fCrossStockCompanies:= TCrossStockCompanies.Create(nil);
    fCrossStockCompanies.Connection:= TMyDacDataConnection.Create(fCrossStockCompanies);
    fCrossStockCompanies.Connection.Connection:= self.AppDb.Connection;
  end;

  if fCrossStockCompanies.count = 0 then begin
    fCrossStockCompanies.Load;
  end;
  result:= fCrossStockCompanies;
end;
function TAppEnvironment.GetDocPath: TDocPath;
begin
  if not Assigned(fDocPath) then begin
    fDocPath:= TDocPath.Create(nil);
    fDocPath.Connection:= TMyDacDataConnection.Create(fDocPath);
    fDocPath.Connection.Connection:= self.AppDb.Connection;
    fDocPath.Load;
  end;
  result:= fDocPath;
end;

function TAppEnvironment.GetAppName:String;
var
  AppName:string;
  i:integer;
begin
  AppName := ExtractFileName(Application.ExeName);
  i := Pos('.',AppName);
  if i > 0 then begin
    Result := Copy(AppName,0,i-1);
  end else Result := AppName;
end;

procedure TAppEnvironment.Reset;
begin
  FreeAndNil(fAccessLevels);
  FreeAndNil(fBranch);
  FreeAndNil(fCompanyInfo);
  FreeAndNil(fAchInfo);
  FreeAndNil(fCompanyPrefs);
  FreeAndNil(fEmployee);
  FreeAndNil(fSoundObj);
  FreeAndNil(fDefaultClass);
  FreeAndNil(fPayPrefs);
  FreeAndNil(fColoursPrefs);
  FreeAndNil(fRegionalOptions);
  FreeAndNil(fCrossStockCompanies);
  FreeAndNil(fDocPath);
  FreeAndNil(fBusObjFieldList);
//  if Assigned(fAppDb) then begin
//    fDatabase := fAppDb.Database;
//    fServer := fAppDb.Server;
//    FreeAndNil(fAppDb);
//  end;
  FreeAndNil(fGoogleUpdater);
  fServerID := '';
end;

procedure TAppEnvironment.ResetAchinfo;
begin
  if Assigned(fAchInfo) then FreeAndNil(fAchInfo);
  AchInfo;
end;

function TAppEnvironment.GetServerID: string;
begin
  if fServerId = '' then begin
    fServerID := self.UtilsClient.GetServerID;
  end;
  result := fServerID;
end;

function TAppEnvironment.GetSoundObj: TSoundObj;
begin
  if fSoundObj = nil then
    fSoundObj := TSoundObj.create(nil);
  result := fSoundObj;
end;

function TAppEnvironment.GetUtilsClient: TUserUtilsClient;
begin
  if not Assigned(fUtilsClient) then
    fUtilsClient:= TUserUtilsClient.Create;
  result:= fUtilsClient;
end;

{ TAppEnvironmentList }

function TAppEnvironmentList.AppEnvForThread(const ThreadId: cardinal;
  AutoCreate: boolean): TAppEnvironment;
Var
  tmpAppEnv :TAppEnvironment;
  I:Integer;
begin
  result:= nil;
(*  if not Assigned(AppEnvListLock) then
    exit;*)
  AppEnvListLock.Acquire;
  Try
    If Self.Count > 0 then
      for I := 0 to Self.Count-1 do begin
        tmpAppEnv := TAppEnvironment(Self.Items[I]);
        If (tmpAppEnv.fThreadId = ThreadId) Then Begin
          Result := tmpAppEnv;
          break;
        end;
    end;
    if (not Assigned(result)) and AutoCreate then begin
      tmpAppEnv := TAppEnvironment.Create(APIMode);
      tmpAppEnv.Server := MySQLServer;
      tmpAppEnv.fThreadId := ThreadId;
      Result := tmpAppEnv;
      Self.Add(tmpAppEnv);
    end;  
  Finally;
    AppEnvListLock.Release;
  End;
end;


constructor TAppEnvironmentList.Create;
begin
  inherited Create;
  fMySQLServer := '127.0.0.1';
  fAPIMode := false;
end;

constructor TAppEnvironmentList.Create(AOwnesObjects: boolean);
begin
  inherited Create(AOwnesObjects);
  fMySQLServer := '127.0.0.1';
  fAPIMode := false;
end;

procedure TAppEnvironmentList.RemoveAppEnvInstance(const aThreadId: cardinal = 0);
Var
  tmpAppEnv :TAppEnvironment;
  I:Integer;
  Id: Cardinal;
begin
  AppEnvListLock.Acquire;
  Try
    if aThreadId = 0 then Id:= GetCurrentThreadID
    else Id:= aThreadId;
    If Self.Count>0 then
      for I := 0 to Self.Count-1 do begin
        tmpAppEnv := TAppEnvironment(Self.Items[I]);
        If (tmpAppEnv.fThreadId = ID) Then Begin
          Self.Remove(tmpAppEnv);
          Break;
        end;
      end;
  Finally;
    AppEnvListLock.Release;
  End;
end;

function AppEnv: TAppEnvironment;
begin
  Result := AppEnvList.AppEnvForThread(GetCurrentThreadID,true);
//  if not Assigned(fAppEnv) then
//    fAppEnv := TAppEnvironment.Create;
end;

function AppEnvList :TAppEnvironmentList;
begin
  if fAppEnvList = nil then
    fAppEnvList := TAppEnvironmentList.Create;
  result :=fAppEnvList;
end;

initialization


finalization
//  AppEnvList.RemoveAppEnvInstance;
  if Assigned(fAppEnvList) then
    fAppEnvList.RemoveAppEnvInstance;
  FreeAndNil(fAppEnvList);
  FreeAndNil(fAppEnvListLock);
//  FreeAndNil(fAppEnv);
end.






