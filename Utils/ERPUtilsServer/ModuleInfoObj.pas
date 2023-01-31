unit ModuleInfoObj;

interface

uses
  classes,  ModuleBaseObj, LogMessageTypes;

type

  TModuleInfo = class(TCollectionItem)
  private
    FHandle: HMODULE;
    fModule: TModuleBase;
    fServerVersion: string;
    procedure SetHandle(const Value: HMODULE);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Handle: HMODULE read FHandle write SetHandle;
    function LoadModule(const ModuleFileName: string): boolean;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType);
  published
    property Module: TModuleBase read fModule write fModule;
    property ServerVersion: string read fServerVersion;
  end;



implementation

uses
  sysutils, ModuleControl, ModuleUtils, windows, ModuleFunctions, forms;

{ TModuleInfo }

constructor TModuleInfo.Create(Collection: TCollection);
begin
  inherited;
  fServerVersion:= GetFileVersion(GetModuleNameStr);
end;

destructor TModuleInfo.Destroy;
var
  result: LongBool;
begin
  if fHandle <> 0 then begin
    Log('  Unloading module: ' + Module.ModuleName + ' ..', ltInfo);
    result:= true;
    try
      result:= FreeLibrary(fHandle);
      Log('  .. done.', ltDetail);
    except
      on e: exception do begin
        Log('  Error while unloading module with message: ' + e.Message, ltWarning);
      end;
    end;
    if not result then begin
//      error:= GetLastError();
    end;
    fHandle:= 0;
  end;
  Sleep(50);
  inherited;
end;

function TModuleInfo.LoadModule(const ModuleFileName: string): boolean;
var
  GetModule: TGetModule;
begin
  try
    fHandle := LoadLibrary(PChar(ModuleFileName));
//    fHandle := LoadLibrary(ModuleFileName);
  except
    on E: Exception do begin
      raise;
    end;
  end;
  if fHandle <> 0 then begin

    @GetModule:= GetProcAddress(fHandle, 'GetModule');
    if @GetModule <> nil then begin
      fModule:= GetModule(Application);
    end;
  end;
  result:= Assigned(fModule);
end;

procedure TModuleInfo.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(TModuleList(Collection).Loger) then
    TModuleList(Collection).Loger.Log(msg, LogMessageType);
end;

procedure TModuleInfo.SetHandle(const Value: HMODULE);
begin
  FHandle := Value;
end;

end.
