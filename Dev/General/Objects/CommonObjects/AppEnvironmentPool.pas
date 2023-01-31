unit AppEnvironmentPool;

interface

uses
  AppEnvironment, syncobjs, contnrs, LogThreadBase, LogMessageTypes;

type

  TAppEnvPoolResult = (aeprFail, aeprOk, aeprMaxExceeded, aeprInactive);

  TAppEnvRec = class(TObject)
  public
    AppEnvInst: TAppEnvironment;
    InUse: boolean;
    constructor Create;
    destructor Destroy; override;
  end;

  TAppEnvironmentPool = class(TObject)
  private
    fLock: TCriticalSection;
    fList: TObjectList;
    fActive: boolean;
    FMinPoolSize: integer;
    FMaxPoolSize: integer;
    procedure SetMaxPoolSize(const Value: integer);
    procedure SetMinPoolSize(const Value: integer);
    procedure CheckPoolSize;
  public
    constructor Create;
    destructor Destroy; override;
    property MaxPoolSize: integer read FMaxPoolSize write SetMaxPoolSize;
    property MinPoolSize: integer read FMinPoolSize write SetMinPoolSize;
    function GetAppEnv(aDatabase: string; aUserName: string; aPassword: string; Logger: TLoggerBase = nil): TAppEnvPoolResult;
    procedure ReleaseAppEnv(Logger: TLoggerBase = nil);
    property Active: boolean read fActive write fActive;
//    procedure Clear;
  end;

var
  AppEnvPool: TAppEnvironmentPool;

implementation

uses
  windows, SysUtils;

{ TAppEnvironmentPool }

procedure TAppEnvironmentPool.CheckPoolSize;
var
  x: integer;
  newRec: TAppEnvRec;
begin
  if ((FMaxPoolSize > 0) and (fList.Count > FMaxPoolSize)) or (fList.Count < FMinPoolSize) then begin
    fLock.Acquire;
    try
      { create the minimum number of connections }
      while fList.Count < FMinPoolSize do begin
        newRec:= TAppEnvRec.Create;
        newRec.InUse:= false;
        fList.Add(newRec);
      end;
      if ((FMaxPoolSize > 0) and (fList.Count > FMaxPoolSize)) then begin
        x:= 0;
        while x < fList.Count do begin
          if not TAppEnvRec(fList[x]).InUse then begin
            fList.Delete(x);
            if fList.Count <= FMaxPoolSize then
              break;
          end
          else
            Inc(x);
        end;
      end;
    finally
      fLock.Release;
    end;
  end;
end;

//procedure TAppEnvironmentPool.Clear;
//begin
//
//end;

constructor TAppEnvironmentPool.Create;
begin
  FMaxPoolSize:= 20;
  FMinPoolSize:= 0;
  fList:= TObjectList.Create(true);
  fLock:= TCriticalSection.Create;
  fActive:= true;
end;

destructor TAppEnvironmentPool.Destroy;
begin
  fList.Free;
  fLock.Free;
  inherited;
end;

function TAppEnvironmentPool.GetAppEnv(aDatabase: string; aUserName: string;
  aPassword: string; Logger: TLoggerBase = nil): TAppEnvPoolResult;
var
  env: TAppEnvironment;
  x: integer;
  newRec: TAppEnvRec;
//  oldRec: TAppEnvRec;
//  AllInUse: boolean;

  procedure Log(s: string);
  begin
    if Assigned(Logger) then Logger.Log(s, ltDetail);
  end;

begin
//  Log(self.ClassName + ' GetAppEnv ' + aDatabase + ' ' + aUserName + ' ' + aPassword);
  result:= aeprFail;
  env:= nil;
  if fActive then begin
    CheckPoolSize;
    fLock.Acquire;
    try
//      AllInUse:= true;
      for x := 0 to fList.Count -1 do begin
        if (not TAppEnvRec(fList[x]).InUse) then begin
//          AllInUse:= false;
          if (TAppEnvRec(fList[x]).AppEnvInst.AppDb.Database = aDatabase) and
             (TAppEnvRec(fList[x]).AppEnvInst.AppDb.UserName = aUserName) and
             (TAppEnvRec(fList[x]).AppEnvInst.AppDb.UserPass = aPassword) then begin
            result:= aeprOk;
            TAppEnvRec(fList[x]).InUse:= true;
            env:= TAppEnvRec(fList[x]).AppEnvInst;
//            env.Reset;
            Log(self.ClassName + ' GetAppEnv ' + 'found existing entry.');
            break;
          end;
        end;
      end;

//      oldRec := nil;
//      if (not Assigned(env)) {and (not AllInUse)} then begin
//        for x := 0 to fList.Count -1 do begin
//          if (not TAppEnvRec(fList[x]).InUse) then begin
////            if TAppEnvRec(fList[x]).AppEnvInst.ThreadId = GetCurrentThreadID then begin
//              result:= aeprOk;
//              TAppEnvRec(fList[x]).InUse:= true;
//              env:= TAppEnvRec(fList[x]).AppEnvInst;
//              env.Reset;
//              env.AppDb.Database := aDatabase;
//              env.AppDb.UserName := aUserName;
//              env.AppDb.UserPass := aPassword;
//              Log(self.ClassName + ' GetAppEnv ' + 'found unused entry.');
//              break;
////            end
////            else begin
////              { get oldest (top of list) unused record }
////              if not Assigned(oldRec) then
////                oldRec := TAppEnvRec(fList[x]);
////            end;
//          end;
//        end;
//      end;

//      if Assigned(oldRec) and ((FMaxPoolSize > 0) and (fList.Count >= FMaxPoolSize)) then
//        fList.Delete(fList.IndexOf(oldRec));

      { no free ones in list }
      if not Assigned(env) then begin
        if (FMaxPoolSize = 0) or (fList.Count < FMaxPoolSize) then begin
          { add a new one }
          newRec:= TAppEnvRec.Create;
          fList.Add(newRec);
          env:= newRec.AppEnvInst;
          env.AppDb.Database := aDatabase;
          env.AppDb.UserName := aUserName;
          env.AppDb.UserPass := aPassword;
          result:= aeprOk;
          Log(self.ClassName + ' GetAppEnv ' + 'created new entry.');
        end
        else
          result:= aeprMaxExceeded;
      end;
      if Assigned(env) then begin
        Log(self.ClassName + ' GetAppEnv ' + 'Old Thread ID: '+ IntToStr(env.ThreadId));
        env.ThreadId:= GetCurrentThreadID;
        Log(self.ClassName + ' GetAppEnv ' + 'New Thread ID: '+ IntToStr(env.ThreadId));
      end;
    finally
      fLock.Release;
    end;
  end
  else
    result:= aeprInactive;
end;

procedure TAppEnvironmentPool.ReleaseAppEnv(Logger: TLoggerBase = nil);
var
  x: integer;
  env: TAppEnvironment;

  procedure Log(s: string);
  begin
    if Assigned(Logger) then Logger.Log(s, ltDetail);
  end;

begin
  env:= AppEnvList.AppEnvForThread(GetCurrentThreadID,false);
  if not Assigned(env) then begin
    Log(self.ClassName + ' ReleaseAppEnv ' + 'Could not find Enviroment with Thread ID: '+ IntToStr(env.ThreadId));
    exit;
  end;
  fLock.Acquire;
  try
    for x := 0 to fList.Count -1 do begin
      if TAppEnvRec(fList[x]).AppEnvInst.ThreadID = env.ThreadID then begin
        TAppEnvRec(fList[x]).InUse:= false;
        Log(self.ClassName + ' ReleaseAppEnv ' + 'Found Enviroment with Thread ID: '+ IntToStr(env.ThreadId));
        break;
      end;
    end;
  finally
    fLock.Release;
  end;
  CheckPoolSize;
end;

procedure TAppEnvironmentPool.SetMaxPoolSize(const Value: integer);
begin
  FMaxPoolSize := Value;
  CheckPoolSize;
end;

procedure TAppEnvironmentPool.SetMinPoolSize(const Value: integer);
begin
  FMinPoolSize := Value;
  if (FMaxPoolSize > 0) and (FMaxPoolSize < FMinPoolSize) then
    FMaxPoolSize:= FMinPoolSize;
  CheckPoolSize;
end;

{ TAppEnvRec }

constructor TAppEnvRec.Create;
begin
  InUse:= true;
  AppEnvInst:= AppEnvList.AppEnvForThread(GetCurrentThreadID, true);
end;

destructor TAppEnvRec.Destroy;
//var
//  env: TAppEnvironment;
//  x: integer;
begin
//  x:= AppEnvList.IndexOf(AppEnv);
//  if x > -1 then begin
//    AppEnvList.Items[x].Free;
//    AppEnvList.Delete(x);
//  end;
  try
    AppEnvList.RemoveAppEnvInstance(AppEnvInst.ThreadId);
  except

  end;
  inherited;
end;

initialization
  AppEnvPool:= TAppEnvironmentPool.Create;
//  AppEnvPool.MinPoolSize:= 2;


finalization
  AppEnvPool.Free;

end.
