unit JsonConfigObj;

interface

uses
  JsonObject, SyncObjs, classes;

type

  TJsonConfig = class(TJSONObject)
  private
    FConfigFileName: string;
    fFirstLoad: boolean;
    fFileDateTime: TDateTime;
    procedure SetConfigFileName(const Value: string);
  public
    constructor Create; override;
    property ConfigFileName: string read FConfigFileName write SetConfigFileName;
    procedure Load;
    procedure Save;
    property FileDateTime: TDateTime read fFileDateTime;
  end;

  TThreadJsonConfig = class(TObject)
  private
    fLock: TCriticalSection;
    fConfig: TJsonConfig;
//    fLastFileTimeStamp: TDateTime;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Lock: TJsonConfig;
    procedure Unlock;
  end;

  TConfigUpdateChecker = class;

  TConfigAutoUpdate = class(TThreadJsonConfig)
  private
    fConfigUpdateChecker: TConfigUpdateChecker;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TConfigUpdateChecker = class(TThread)
  private
    fConfig: TConfigAutoUpdate;
    fNextCheckTime: TDateTime;
  protected
    procedure Execute; override;
  public
    constructor Create(aConfig: TConfigAutoUpdate);
  end;

  function Config: TJsonConfig;

implementation

uses
  Windows, SysUtils, FileVersion, JsonObjectUtils, ModuleFileNameUtils,
  DateUtils;

var
  fConfig: TJsonConfig;

function Config: TJsonConfig;
begin
  if Not Assigned(fConfig) then
    fConfig := TJsonConfig.Create;
  result := fConfig;
end;

{ TJsonConfig }

constructor TJsonConfig.Create;
begin
  inherited;
  fFileDateTime := 0;
  fFirstLoad := true;
  FConfigFileName := ChangeFileExt(GetCurrentModuleName,'_Config.cfg');
end;

procedure TJsonConfig.Load;
var
  ConfigChanged: boolean;
  Val: string;
begin
  if FileExists(FConfigFileName) then begin
    Self.LoadFromFile(FConfigFileName);
    fFileDateTime := FileDateToDateTime(FileAge(FConfigFileName));
  end;
  if fFirstLoad then begin
    ConfigChanged := false;
    Val := ChangeFileExt(ExtractFileName(GetCurrentModuleName),'');
    if not SameText(self.S['name'], Val) then begin
      self.S['name'] := Val;
      ConfigChanged := true;
    end;
    Val := GetFileVersion();
    if (not SameText(self.S['version'], Val)) and (Val <> '') then begin
      self.S['name'] := Val;
      ConfigChanged := true;
    end;
    if ConfigChanged then
      Save;
    fFirstLoad := false;
  end;
end;

procedure TJsonConfig.Save;
begin
  JsonToFileFormated(self, FConfigFileName);
  fFileDateTime := FileDateToDateTime(FileAge(FConfigFileName));
end;

procedure TJsonConfig.SetConfigFileName(const Value: string);
begin
  FConfigFileName := Value;
end;

{ TThreadJsonConfig }

constructor TThreadJsonConfig.Create;
begin
  fLock := TCriticalSection.Create;
  fConfig := TJsonConfig.Create;
end;

destructor TThreadJsonConfig.Destroy;
begin
  fLock.Free;
  fConfig.Free;
  inherited;
end;

function TThreadJsonConfig.Lock: TJsonConfig;
begin
  fLock.Acquire;
  result := fConfig;
end;

procedure TThreadJsonConfig.Unlock;
begin
  fLock.Release;
end;

{ TConfigAutoUpdate }

constructor TConfigAutoUpdate.Create;
begin
  inherited;
  fConfigUpdateChecker := TConfigUpdateChecker.Create(self);

end;

destructor TConfigAutoUpdate.Destroy;
begin
  fConfigUpdateChecker.Terminate;
  inherited;
end;

{ TConfigUpdateChecker }

constructor TConfigUpdateChecker.Create(aConfig: TConfigAutoUpdate);
begin
  fConfig := aConfig;
  FreeOnTerminate := true;
  fNextCheckTime := now + (5 * OneMinute);
  inherited Create(false);
end;

procedure TConfigUpdateChecker.Execute;
var
  dtFile: TDateTime;
  cfg: TJsonConfig;
begin
  inherited;
  { every 5 minutes check if somthing else has updated the file }
  while not Terminated do begin
    try
      Sleep(50);
      if now >= fNextCheckTime then begin
        try
          cfg := fConfig.Lock;
          try
            if cfg.ConfigFileName <> '' then begin
              dtFile := FileDateToDateTime(FileAge(cfg.ConfigFileName));
              if dtFile > cfg.FileDateTime then
                cfg.Load;
            end;
          finally
            fConfig.Unlock;
          end;
        finally
          fNextCheckTime := now + (5 * OneMinute);
        end;
      end;
    except

    end;

  end;
end;

initialization
  fConfig := nil;

finalization
  fConfig.Free;
end.
