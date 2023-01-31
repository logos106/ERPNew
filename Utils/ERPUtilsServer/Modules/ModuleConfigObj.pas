unit ModuleConfigObj;

interface

uses
  classes, syncobjs, JsonObject, JsonObjectUtils;

type

  TModuleConfig = class(TPersistent)
  private
    fConfigLock: TCriticalSection;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
    procedure SaveToFile(aFileName: string = ''); virtual;
    procedure LoadFromFile(aFileName: string = ''); virtual;
    procedure Clear; virtual;
  published
  end;

  function GetModuleName: string;

implementation

uses
  windows, sysutils, JsonToObject;

function GetModuleName: string;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  FillChar(szFileName, SizeOf(szFileName), #0);
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;


{ TModuleConfig }

procedure TModuleConfig.Clear;
begin

end;

constructor TModuleConfig.Create;
begin
  fConfigLock:= TCriticalSection.Create;

end;

destructor TModuleConfig.Destroy;
begin
  fConfigLock.Free;
  inherited;
end;

procedure TModuleConfig.LoadFromFile(aFileName: string);
var
  fName: string;
  Json: TJsonObject;
begin
  Lock;
  try
    Clear;
    fName:= aFileName;
    if fName = '' then
      fName:= ChangeFileExt(GetModuleName,'_config.cfg');
    Json:= JO;
    try
      if FileExists(fName) then begin
        Json.LoadFromFile(fName);
        JsonToObj(Json,self);
      end;
    finally
      Json.Free;
    end;
  finally
    Unlock;
  end;    
end;

procedure TModuleConfig.Lock;
begin
  fConfigLock.Acquire;
end;

procedure TModuleConfig.SaveToFile(aFileName: string);
var
  fName: string;
  Json: TJsonObject;
begin
  Lock;
  try
    fName:= aFileName;
    if fName = '' then
      fName:= ChangeFileExt(GetModuleName,'_config.cfg');
    Json:= JO;
    try
      ObjToJson(self,Json);
      Json.SaveToFile(fName);
    finally
      Json.Free;
    end;
  finally
    Unlock;
  end;    
end;

procedure TModuleConfig.Unlock;
begin
  fConfigLock.Release;
end;

end.
