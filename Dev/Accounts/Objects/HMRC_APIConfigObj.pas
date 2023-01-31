unit HMRC_APIConfigObj;

interface

uses
  JsonDbPrefsConfigObj, MyAccess;

type

  {$M+}
  THMRC_APIConfig = class(TJsonDbPefConfig)
  private
    procedure SetSandboxClientID(const Value: string);
    function GetSandboxClientID: string;
    function GetSandboxClientSecret: string;
    procedure SetSandboxClientSecret(const Value: string);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    function GetTestMode: boolean;
    procedure SetTestMode(const Value: boolean);
    function GetVATRegistrationNumber: string;
    procedure SetVATRegistrationNumber(const Value: string);
    function GetProductionClientID: string;
    function GetProductionClientSecret: string;
    procedure SetProductionClientID(const Value: string);
    procedure SetProductionClientSecret(const Value: string);
  public
    constructor Create; override;
    function Validate(var msg: string): boolean;
  published
    property Active: boolean read GetActive write SetActive;
    property SandboxClientID: string read GetSandboxClientID write SetSandboxClientID;
    property SandboxClientSecret: string read GetSandboxClientSecret write SetSandboxClientSecret;

    property ProductionClientID: string read GetProductionClientID write SetProductionClientID;
    property ProductionClientSecret: string read GetProductionClientSecret write SetProductionClientSecret;

    property VATRegistrationNumber: string read GetVATRegistrationNumber write SetVATRegistrationNumber;
    property TestMode: boolean read GetTestMode write SetTestMode;
  end;
  {$M-}

implementation

const
  Default_Sandbox_ClientID = 'kg7_7eJ3gsu3eyIDgZrhujntOwsa';
  Default_Sandbox_ClientSecret = '18e71235-e94a-4d78-b180-e5cfae12cee3';

  Default_Production_ClientID = 'b0OMfT6TliBfRrpQW8VNq7eWBO8a';
  Default_Production_ClientSecret = '3ec3693c-0964-4a5b-be71-32927939473c';

{ THRMC_APIConfig }

procedure THMRC_APIConfig.SetSandboxClientID(const Value: string);
begin
  S['SandboxClientID'] := Value;
end;

constructor THMRC_APIConfig.Create;
begin
  inherited;
  self.Encrypt := true;
end;

function THMRC_APIConfig.GetSandboxClientID: string;
begin
  result := S['SandboxClientID'];
  if result = '' then
    result := Default_Sandbox_ClientID;
end;

function THMRC_APIConfig.GetSandboxClientSecret: string;
begin
  result := S['SandboxClientSecret'];
  if result = '' then
    result := Default_Sandbox_ClientSecret;
end;

function THMRC_APIConfig.GetActive: boolean;
begin
  result := B['Active'];
end;

function THMRC_APIConfig.GetProductionClientID: string;
begin
  result := S['ProductionClientID'];
  if result = '' then
    result := Default_Production_ClientID;
end;

function THMRC_APIConfig.GetProductionClientSecret: string;
begin
  result := S['ProductionClientSecret'];
  if result = '' then
    result := Default_Production_ClientSecret;
end;

function THMRC_APIConfig.GetTestMode: boolean;
begin
  result := B['TestMode'];
end;

function THMRC_APIConfig.GetVATRegistrationNumber: string;
begin
  result := S['VATRegistrationNumber'];
end;

procedure THMRC_APIConfig.SetSandboxClientSecret(const Value: string);
begin
  S['SandboxClientSecret'] := Value;
end;

procedure THMRC_APIConfig.SetActive(const Value: boolean);
begin
  B['Active'] := Value;
end;

procedure THMRC_APIConfig.SetProductionClientID(const Value: string);
begin
  S['ProductionClientID'] := Value;
end;

procedure THMRC_APIConfig.SetProductionClientSecret(const Value: string);
begin
  S['ProductionClientSecret'] := value;
end;

procedure THMRC_APIConfig.SetTestMode(const Value: boolean);
begin
  B['TestMode'] := Value;
end;

procedure THMRC_APIConfig.SetVATRegistrationNumber(const Value: string);
begin
  S['VATRegistrationNumber'] := Value;
end;

function THMRC_APIConfig.Validate(var msg: string): boolean;
begin
  result := false;
  if not Active then begin
    msg := 'The API is not ticked as active in HMRC Config.';
    exit;
  end;
  if TestMode then begin
    if SandboxClientID = '' then begin
      msg := 'Sandbox ClientID is blank in HMRC Config.';
      exit;
    end;
    if SandboxClientSecret = '' then begin
      msg := 'Sandbox Client Secret is blank in HMRC Config.';
      exit;
    end;
  end
  else begin
    if ProductionClientID = '' then begin
      msg := 'Production ClientID is blank in HMRC Config.';
      exit;
    end;
    if ProductionClientSecret = '' then begin
      msg := 'Production Client Secret is blank in HMRC Config.';
      exit;
    end;
  end;
  if VATRegistrationNumber = '' then begin
    msg := 'VAT Registration Number is blank in HMRC Config.';
    exit;
  end;
  result := true;
end;

end.
