unit utQuickbooksCoreService;

interface

uses
  utBaseCoreService;

type
  TQuickbooksCoreService = class(TBaseCoreService)
  private
    fCompanyID: string;
    fSandboxMode: boolean;
    fClientID: string;
    fClientSecret: string;
    fCompanyRegion: string;
  protected
    Class function GetServiceName: string; override;
  public
    procedure Process(const data: string); override;
    function ProcessAndReturn(const data: string): string; override;
    { the Quickbooks company ID }
    property CompanyID    : string  read fCompanyID     write fCompanyID;
    property ClientID     : string  read fClientID      write fClientID;
    property ClientSecret : string  read fClientSecret  write fClientSecret;
    property CompanyRegion: string  read fCompanyRegion write fCompanyRegion;
    property SandboxMode  : boolean read fSandboxMode   write fSandboxMode;
    function Initialize   : boolean; override;
  end;


implementation

uses
  JsonObject, SysUtils, ErpSynchObj, utCoreEDIConst, AppEnvironment;

{ TQuickbooksCoreService }

Class function TQuickbooksCoreService.GetServiceName: string;
begin
  result := Servicename_Quickbooks;
end;

function TQuickbooksCoreService.Initialize: boolean;
var
  //s: string;
  req: TJsonObject;
begin
  SandboxMode := AppEnv.CompanyPrefs.IntuitConfig.SandboxMode;
  if SandboxMode then begin
    ClientID := AppEnv.CompanyPrefs.IntuitConfig.SandboxClientID;
    ClientSecret := AppEnv.CompanyPrefs.IntuitConfig.SandboxClientSecret;
  end
  else begin
    ClientID := AppEnv.CompanyPrefs.IntuitConfig.ProductionClientID;
    ClientSecret := AppEnv.CompanyPrefs.IntuitConfig.ProductionClientSecret;
  end;
  CompanyID := AppEnv.CompanyPrefs.IntuitConfig.CompanyID;
  CompanyRegion := AppEnv.RegionalOptions.Region;
  req := JO;
  try
    req.FormatOutput := false;
    req.S['Command'] := 'Initialize';
    req.O['Params'].B['SandboxMode'] := SandboxMode;
    req.O['Params'].S['CompanyID'] := CompanyID;
    req.O['Params'].S['CompanyRegion'] := CompanyRegion;
    req.O['Params'].S['ClientID'] := ClientID;
    req.O['Params'].S['ClientSecret'] := ClientSecret;
    req.O['Params'].S['CompanyRegion'] := CompanyRegion;
    fResultData.AsString := self.WriteAndWait(req.AsString);
    result := fResultData.S['ReturnCode'] = 'Ok';
    if SameText(fResultData.S['ReturnCode'], 'UserAuthRequired') then begin
      result := false;
    end;
  finally
    req.Free;
  end;
end;

procedure TQuickbooksCoreService.Process(const data: string);
begin
  inherited;

end;

function TQuickbooksCoreService.ProcessAndReturn(const data: string): string;
begin

end;

end.
