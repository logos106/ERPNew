unit IntuitConfigObj;

interface

uses
  JsonDbPrefsConfigObj, MyAccess, DB;

type
  TIntuitConfig = class(TJsonDbPefConfig)
  private
    function GetSandboxClientID: string;
    function GetSandboxClientSecret: string;
    procedure SetSandboxClientID(const Value: string);
    procedure SetSandboxClientSecret(const Value: string);
    (*function GetCoreEDIUser: string;
    procedure SetCoreEDIUser(const Value: string);*)
    function GetCompanyID: string;
    procedure SetCompanyID(const Value: string);
    (*function GetCoreEDIPassword: string;
    procedure SetCoreEDIPassword(const Value: string);*)
    function GetSandboxMode: boolean;
    procedure SetSandboxMode(const Value: boolean);
    function GetAutoSynchFromList: boolean;
    procedure SetAutoSynchFromList(const Value: boolean);
    function GetSynchFromDate: TDateTime;
    procedure SetSynchFromDate(const Value: TDateTime);
    function GetEnableQuickbooks: boolean;
    procedure SetEnableQuickbooks(const Value: boolean);
    function GetShowQuickbooksonMainmenubyDefault: boolean;
    procedure SetShowQuickbooksonMainmenubyDefault(const Value: boolean);
    function GetProductionClientID: string;
    function GetProductionClientSecret: string;
    procedure SetProductionClientID(const Value: string);
    procedure SetProductionClientSecret(const Value: string);
    procedure CheckDefaults;
  public
    procedure Load(connection: TMyConnection); overload; override;
    procedure Load(ds: TDataset); overload; override;
    property SandboxClientID: string read GetSandboxClientID write SetSandboxClientID;
    property SandboxClientSecret: string read GetSandboxClientSecret write SetSandboxClientSecret;
    property ProductionClientID: string read GetProductionClientID write SetProductionClientID;
    property ProductionClientSecret: string read GetProductionClientSecret write SetProductionClientSecret;
    property CompanyID: string read GetCompanyID write SetCompanyID;
    (*property CoreEDIUser: string read GetCoreEDIUser write SetCoreEDIUser;*)
    (*property CoreEDIPassword: string read GetCoreEDIPassword write SetCoreEDIPassword;*)
    property SandboxMode: boolean read GetSandboxMode write SetSandboxMode;
    property AutoSynchFromList: boolean read GetAutoSynchFromList write SetAutoSynchFromList;
    property SynchFromDate: TDateTime read GetSynchFromDate write SetSynchFromDate;
    property EnableQuickbooks: boolean read GetEnableQuickbooks write SetEnableQuickbooks;
    property ShowQuickbooksOnMainMenuByDefault: boolean read GetShowQuickbooksonMainmenubyDefault write SetShowQuickbooksonMainmenubyDefault;
  end;



implementation

uses
  CipherUtils;

{ TIntuitConfig }

procedure TIntuitConfig.CheckDefaults;
begin
  if SandboxClientID = '' then begin
    SandboxClientID := 'ABmtLSa6Tt0FiuSCT1kWiv9DSiHk268xWZ1pKl2UATUdbpNatx';
  end;
  if SandboxClientSecret = '' then begin
    SandboxClientSecret := 'oOuBz8QJY68wfslKRMPyQ1v4sadbD899Edor3RBM';
  end;
  if ProductionClientID = '' then begin
    ProductionClientID := 'ABfpkoUmSVlBGvGA4CsnVdiPSImQ77HT1Hqr3sMObHKyopKkzf';
  end;
  if ProductionClientSecret = '' then begin
    ProductionClientSecret := 'a6BLhKrAPCCQaRBv5n24eN3ENmzObqfhYD5Amczy';
  end;
end;

function TIntuitConfig.GetAutoSynchFromList: boolean;
begin
  result := B['AutoSynchFromList'];
end;

function TIntuitConfig.GetSandboxClientID: string;
begin
  result := S['SandboxClientID'];
end;

function TIntuitConfig.GetSandboxClientSecret: string;
begin
  result := DecryptString(S['SandboxClientSecret']);
end;

function TIntuitConfig.GetCompanyID: string;
begin
  result := S['CompanyID'];
end;

(*function TIntuitConfig.GetCoreEDIPassword: string;
begin
  result := S['CoreEDIPassword'];
end;*)

(*function TIntuitConfig.GetCoreEDIUser: string;
begin
  result := S['CoreEDIUser'];
end;*)

function TIntuitConfig.GetSandboxMode: boolean;
begin
  result := B['SandboxMode'];
end;

function TIntuitConfig.GetSynchFromDate: TDateTime;
begin
  result := DT['SynchFromDate'];
end;
procedure TIntuitConfig.Load(connection: TMyConnection);
begin
  inherited;
  CheckDefaults;
end;

procedure TIntuitConfig.Load(ds: TDataset);
begin
  inherited;
  CheckDefaults;
end;

function TIntuitConfig.GetEnableQuickbooks: boolean;
begin
  result := B['EnableQuickbooks'];
end;

function TIntuitConfig.GetProductionClientID: string;
begin
  result := S['ProductionClientID'];
end;

function TIntuitConfig.GetProductionClientSecret: string;
begin
  result := S['ProductionClientSecret'];
end;

function TIntuitConfig.GetShowQuickbooksonMainmenubyDefault: boolean;
begin
  result := B['ShowQuickbooksonMainmenubyDefault'];
end;
procedure TIntuitConfig.SetAutoSynchFromList(const Value: boolean);
begin
  B['AutoSynchFromList'] := Value;
end;

procedure TIntuitConfig.SetSandboxClientID(const Value: string);
begin
   S['SandboxClientID'] := Value;
end;

procedure TIntuitConfig.SetSandboxClientSecret(const Value: string);
begin
  S['SandboxClientSecret'] := EncryptString(Value);
end;

procedure TIntuitConfig.SetCompanyID(const Value: string);
begin
  S['CompanyID'] := Value;
end;

(*procedure TIntuitConfig.SetCoreEDIPassword(const Value: string);
begin
  S['CoreEDIPassword'] := Value;
end;*)

(*procedure TIntuitConfig.SetCoreEDIUser(const Value: string);
begin
  S['CoreEDIUser'] := Value;
end;*)

procedure TIntuitConfig.SetSandboxMode(const Value: boolean);
begin
  B['SandboxMode'] := Value;
end;

procedure TIntuitConfig.SetSynchFromDate(const Value: TDateTime);
begin
  DT['SynchFromDate'] := Value;
end;
procedure TIntuitConfig.SetEnableQuickbooks(const Value: boolean);
begin
  B['EnableQuickbooks'] := Value;
end;
procedure TIntuitConfig.SetProductionClientID(const Value: string);
begin
  S['ProductionClientID'] := Value;
end;

procedure TIntuitConfig.SetProductionClientSecret(const Value: string);
begin
  S['ProductionClientSecret'] := Value;
end;

procedure TIntuitConfig.SetShowQuickbooksonMainmenubyDefault(const Value: boolean);
begin
  B['ShowQuickbooksonMainmenubyDefault'] := Value;
end;

end.
