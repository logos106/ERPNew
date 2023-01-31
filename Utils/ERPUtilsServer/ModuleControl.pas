unit ModuleControl;

interface

uses
  classes, JsonRpcBase, JsonObject, ModuleFunctions,
  ModuleInfoObj, syncobjs, LogThreadLib, LogMessageTypes;

type

  TModuleList = class(TCollection)
  private
    fListLock: TCriticalSection;
    fServerVersion: string;
    fServerModuleName: string;
    function GetItemByName(aModuleName: string): TModuleInfo;
    function GetModuleInfoItem(index: integer): TModuleInfo;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType);
  protected
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
  public
    Loger: TLogger;
    constructor Create;
    destructor Destroy; override;
    procedure LoadModules(aPath: string);
    procedure LoadModule(ModuleFileName: string);
    procedure UnloadModule(ModuleName: string);
    property ItemByName[aModuleName: string]: TModuleInfo read GetItemByName;
    property ModuleInfoItem[index: integer]: TModuleInfo read GetModuleInfoItem;
    function DoRequest(Client: TJsonRpcBase; ReqJson: TJsonObject; ResJson: TJsonObject = nil): boolean;
    procedure DoDisconnect(Client: TJsonRpcBase);
    procedure LockList;
    procedure UnlockList;
    property ServerModuleName: string read fServerModuleName;
    property ServerVersion: string read fServerVersion;
  end;


implementation

uses
  sysutils, windows, ModuleUtils, SystemLib;

{ TModuleList }

constructor TModuleList.Create;
begin
  inherited Create(TModuleInfo);
  Loger:= nil;
  fListLock:= TCriticalSection.Create;
  fServerModuleName:= GetModuleNameStr;
  fServerVersion:= GetFileVersion(fServerModuleName);
end;

destructor TModuleList.Destroy;
begin
  self.Clear;
  fListLock.Free;
  inherited;
end;

procedure TModuleList.DoDisconnect(Client: TJsonRpcBase);
var
  x: integer;
  ModInfo: TModuleInfo;
begin
  for x:= 0 to Count-1 do begin
    ModInfo:= TModuleInfo(Items[x]);
    ModInfo.Module.DoDisconnect(client);
  end;
end;

function TModuleList.DoRequest(Client: TJsonRpcBase; ReqJson: TJsonObject; ResJson: TJsonObject = nil): boolean;
var
  methName, moduleName: string;
  x: integer;
  ModInfo: TModuleInfo;
//  m1, m2: cardinal;
//  t1,t2: TDateTime;

  function Pad(s: string; places: integer): string;
  begin
    result := s;
    while Length(result) < places do
      result := result + ' ';
  end;

begin
  result:= false;
  if ReqJson.StringExists('method') then begin
    methName:= Lowercase(ReqJson.S['method']);
    x:= Pos('.',methName);
    if x > 1 then begin
      moduleName:= Copy(methName,1,x-1);
      ModInfo:= ItemByName[moduleName];
      if Assigned(ModInfo) then begin
        if Assigned(ModInfo.Module) then begin
//          m1:= SystemLib.CurrentMemoryUsage;
//          t1:= now;
          ModInfo.Module.DoRequest(Client, ReqJson, ResJson);
          result:= true;
//          t2:= now;
//          m2:= SystemLib.CurrentMemoryUsage;
//          Log('Processed request: ' + Pad(ReqJson.S['method'],30) + #9 + 'Time: ' + FormatDateTime('hh:nn:ss:zzz',t2-t1) +
//            #9 + 'Mem Change: ' + Pad(FormatFloat('#,##0;(#,##0)',m2-m1),20) + #9 + 'Tot Mem: ' + FormatFloat('#,##0;(#,##0)',m2),ltInfo);

        end;
      end
      else begin
      end;
    end;
  end;
end;

function TModuleList.GetItemByName(aModuleName: string): TModuleInfo;
var
  x: integer;
  ModInfo: TModuleInfo;
begin
  result:= nil;
  LockList;
  try
    for x:= 0 to Count -1 do begin
      ModInfo:= TModuleInfo(Items[x]);
      if Assigned(ModInfo.Module) and (Lowercase(ModInfo.Module.ModuleName) = Lowercase(aModuleName)) then begin
        result:= ModInfo;
        break;
      end;
    end;
  finally
    UnlockList;
  end;
end;

function TModuleList.GetModuleInfoItem(index: integer): TModuleInfo;
begin
  result:= TModuleInfo(Items[index]);
end;

procedure TModuleList.LoadModule(ModuleFileName: string);
var
  info: TModuleInfo;
begin
  if not FileExists(ModuleFileName) then begin
    Log('Load Module Error - Module file not found: "'  + ModuleFileName + '"', ltError);
    exit;
  end;
  LockList;
  try
    Log('About to load Module: "'  + ModuleFileName + '" ..', ltInfo);
    info:= TModuleInfo(Add);
    try
      if not info.LoadModule(ModuleFileName) then begin
        self.Delete(info.Index);
        Log('Loading Module failed', ltInfo);
      end
      else begin
        Log('Loaded module: ' + Info.Module.ModuleName, ltInfo);
      end;
    except
      on e: exception do begin
        Log('  Exception wile loading module: "' + ModuleFileName + '" with message: ' + e.Message, ltError);
        if Assigned(info) then begin
          try
            self.Delete(info.Index);
          except
          end;
        end;
      end;
    end;
  finally
    UnlockList;
  end;
end;

procedure TModuleList.LoadModules(aPath: string);
var
  sr: TSearchRec;
  info: TModuleInfo;
begin
  Log('Looking for ERP Server modules to load ...', ltInfo);
  if DirectoryExists(aPath) then begin
    if FindFirst(aPath + '*.dll', faAnyFile, sr) = 0 then begin
      LockList;
      try
        repeat
          if (Lowercase(sr.Name) = 'userutils.dll') or
             (Lowercase(sr.Name) = 'multisite.dll') or
             (Lowercase(sr.Name) = 'webapi.dll') or
             (Lowercase(sr.Name) = 'googleanalytics.dll') or
             (Lowercase(sr.Name) = 'siteintegration.dll') or
             (Lowercase(sr.Name) = 'clientserver.dll') then begin
            info:= TModuleInfo(Add);
            try
              if not info.LoadModule(aPath + sr.Name) then begin
                self.Delete(info.Index);
              end
              else begin
                Log('  Loaded module: ' + sr.Name, ltInfo);
              end;
            except
              on e: exception do begin
                Log('  Exception wile loading module: ' + sr.Name + ' with message: ' + e.Message, ltError);
                if Assigned(info) then begin
                  try
                    self.Delete(info.Index);
                  except
                  end;
                end;
              end;
            end;
          end;
        until FindNext(sr) <> 0;
        sysutils.FindClose(sr);
      finally
        UnlockList;
      end;
    end;
  end;
  Log('Done loading modules.', ltInfo);
end;

procedure TModuleList.LockList;
begin
  fListLock.Acquire;
end;

procedure TModuleList.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(Loger) then
    Loger.Log(msg, LogMessageType);
end;

procedure TModuleList.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
//  if (Action = cnDeleting) or (Action = cnExtracting) then
//    Log('Deleting module: ' + TModuleInfo(Item).Module.ModuleName, ltDetail);
  inherited;
end;

procedure TModuleList.UnloadModule(ModuleName: string);
var
  info: TModuleInfo;
begin
  LockList;
  try
    info:= self.ItemByName[ModuleName];
    if Assigned(info) then begin
      Log('About to unloading module: ' + ModuleName + ' ..', ltInfo);
      Sleep(1000);
      try
        Delete(info.Index);
      Log('Module unloaded', ltInfo);
      except
        on e: exception do begin
          Log('Exception wile unloading module: ' + ModuleName + ' with message: ' + e.Message, ltError);
        end;
      end;
    end
    else
      Log('Unload Module Failed - module not loaded: ' + ModuleName, ltError);

  finally
    UnlockList;
  end;
end;

procedure TModuleList.UnlockList;
begin
  fListLock.Release;
end;

end.
