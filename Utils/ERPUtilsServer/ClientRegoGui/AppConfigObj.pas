unit AppConfigObj;

interface

uses
  JsonObject;

type
  TAppConfig = class(TObject)
  private
    FConfigFileName: string;
    procedure SetConfigFileName(const Value: string);
  public
    Data: TJsonObject;
    constructor Create;
    destructor Destroy; override;
    property ConfigFileName: string read FConfigFileName write SetConfigFileName;
    procedure Load;
    procedure Save;
  end;

  function AppConfig: TAppConfig;

implementation

uses
  JsonToObject, sysutils, forms;

var
  fAppConfig: TAppConfig;

function AppConfig: TAppConfig;
begin
  if not Assigned(fAppConfig) then
    fAppConfig:= TAppConfig.Create;
  result:= fAppConfig;
end;

{ TAppConfig }

constructor TAppConfig.Create;
begin
  FConfigFileName:= ChangeFileExt(Application.ExeName,'_Config.cfg');
  data:= TJsonObject.Create;
  Load;
end;

destructor TAppConfig.Destroy;
begin
  Save;
  data.Free;
  inherited;
end;

procedure TAppConfig.Load;
begin
  if FileExists(FConfigFileName) then
    data.LoadFromFile(FConfigFileName);
end;

procedure TAppConfig.Save;
begin
  data.SaveToFile(FConfigFileName);
end;

procedure TAppConfig.SetConfigFileName(const Value: string);
begin
  FConfigFileName := Value;
end;

initialization
  fAppConfig:= nil;

finalization
  fAppConfig.Free;

end.
