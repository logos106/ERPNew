unit BusObjPayTaxConfig;

interface

uses
  BusObjBase, Classes;

type

  TPayTaxConfig = class(TMSBusObj)
  private
    function GetActive: Boolean;
    function GetExpenseAccountId: integer;
    function GetLiabilityAccountId: integer;
    function GetTaxName: string;
    function GetRegionId: integer;
    function GetTaxType: string;
    procedure SetActive(const Value: Boolean);
    procedure SetExpenseAccountId(const Value: integer);
    procedure SetLiabilityAccountId(const Value: integer);
    procedure SetTaxName(const Value: string);
    procedure SetRegionId(const Value: integer);
    procedure SetTaxType(const Value: string);
    function GetRoundTax: boolean;
    procedure SetRoundTax(const Value: boolean);
    function TaxNameUnique: boolean;
    procedure MakeOthersNonePrimary;
    function GetPrimaryTax: boolean;
    procedure SetPrimaryTax(const Value: boolean);
    function GetAllowanceAmount: double;
    procedure SetAllowanceAmount(const Value: double);
    function GetDefaultTaxScaleId: integer;
    procedure SetDefaultTaxScaleId(const Value: integer);
    function GetGroupType: string;
    procedure SetGroupType(const Value: string);
  protected
    Function  DoAfterInsert(Sender :TDatasetBusObj): Boolean; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    function Save: boolean; override;
    function ValidateData: boolean; override;
  published
    property RegionId: integer read GetRegionId write SetRegionId;
    property TaxName: string read GetTaxName write SetTaxName;
    property ExpenseAccountId: integer read GetExpenseAccountId write SetExpenseAccountId;
    property LiabilityAccountId: integer read GetLiabilityAccountId write SetLiabilityAccountId;
    { TaxType = Employee,Company }
    property TaxType: string read GetTaxType write SetTaxType;
    { GroupType = Federal,State,Other,SocialSecurity,Medicare }
    property GroupType: string read GetGroupType write SetGroupType;
    property AllowanceAmount: double read GetAllowanceAmount write SetAllowanceAmount;
    property PrimaryTax: boolean read GetPrimaryTax write SetPrimaryTax;
    property RoundTax: boolean read GetRoundTax write SetRoundTax;
    property DefaultTaxScaleId: integer read GetDefaultTaxScaleId write SetDefaultTaxScaleId;
    property Active: Boolean read GetActive write SetActive;
  end;

implementation

uses
  AppEnvironment, SysUtils, ERPDbComponents, DbSharedObjectsObj;

{ TPayTaxConfig }

constructor TPayTaxConfig.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  fBusObjectTypeDescription := 'PayTaxConfig';
  fSQL := 'SELECT * FROM tblpaytaxconfig';
end;

destructor TPayTaxConfig.Destroy;
begin

  inherited;
end;

function TPayTaxConfig.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  RegionId := AppEnv.RegionalOptions.ID;
end;

function TPayTaxConfig.GetActive: Boolean;
begin
  result := GetBooleanField('Active');
end;

function TPayTaxConfig.GetAllowanceAmount: double;
begin
  result := GetFloatField('AllowanceAmount');
end;

class function TPayTaxConfig.GetBusObjectTablename: string;
begin
  result := 'tblpaytaxconfig';
end;

function TPayTaxConfig.GetDefaultTaxScaleId: integer;
begin
  result := GetIntegerField('DefaultTaxScaleId');
end;

function TPayTaxConfig.GetExpenseAccountId: integer;
begin
  result := GetIntegerField('ExpenseAccountId');
end;

function TPayTaxConfig.GetGroupType: string;
begin
  result := GetStringField('GroupType');
end;

class function TPayTaxConfig.GetIDField: string;
begin
  result := 'Id';
end;

function TPayTaxConfig.GetLiabilityAccountId: integer;
begin
  result := GetIntegerField('LiabilityAccountId');
end;

function TPayTaxConfig.GetPrimaryTax: boolean;
begin
  result := GetBooleanField('PrimaryTax');
end;

function TPayTaxConfig.GetTaxName: string;
begin
  result := GetStringField('TaxName');
end;

function TPayTaxConfig.GetRegionId: integer;
begin
  result := GetIntegerField('RegionId');
end;

function TPayTaxConfig.GetRoundTax: boolean;
begin
  result := GetBooleanField('RoundTax');
end;

function TPayTaxConfig.GetTaxType: string;
begin
  result := GetStringField('TaxType');
end;

procedure TPayTaxConfig.MakeOthersNonePrimary;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(self.Connection.Connection);
  try
    qry.SQL.Add('update tblpaytaxconfig');
    qry.SQL.Add('set PrimaryTax = "F"');
    qry.SQL.Add('where RegionId = ' + IntToStr(RegionId));
    qry.SQL.Add('and ID <> ' + IntToStr(ID));
    qry.Execute;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TPayTaxConfig.Save: boolean;
begin
 PostDb;
 ResultStatus.Clear;
 result := ValidateData;

end;

procedure TPayTaxConfig.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TPayTaxConfig.SetAllowanceAmount(const Value: double);
begin
  SetFloatField('AllowanceAmount', Value);
end;

procedure TPayTaxConfig.SetDefaultTaxScaleId(const Value: integer);
begin
  SetIntegerField('DefaultTaxScaleId', Value);
end;

procedure TPayTaxConfig.SetExpenseAccountId(const Value: integer);
begin
  SetIntegerField('ExpenseAccountId', Value);
end;

procedure TPayTaxConfig.SetGroupType(const Value: string);
begin
  SetStringField('GroupType', Value);
end;

procedure TPayTaxConfig.SetLiabilityAccountId(const Value: integer);
begin
  SetIntegerField('ExpenseAccountId', Value);
end;

procedure TPayTaxConfig.SetPrimaryTax(const Value: boolean);
begin
  SetBooleanField('PrimaryTax', Value);
end;

procedure TPayTaxConfig.SetTaxName(const Value: string);
begin
  SetStringField('TaxName',Value);
end;

procedure TPayTaxConfig.SetRegionId(const Value: integer);
begin
  SetIntegerField('RegionId', Value);
end;

procedure TPayTaxConfig.SetRoundTax(const Value: boolean);
begin
  SetBooleanField('RoundTax', Value);
end;

procedure TPayTaxConfig.SetTaxType(const Value: string);
begin
  SetStringField('TaxType', Value);
end;

function TPayTaxConfig.TaxNameUnique: boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(self.Connection.Connection);
  try
    qry.SQL.Add('select Id from tblpaytaxconfig');
    qry.SQL.Add('where RegionId = ' + IntToStr(RegionId));
    qry.SQL.Add('and TaxName = ' + QuotedStr(TaxName));
    qry.SQL.Add('and ID <> ' + IntToStr(ID));
    qry.Open;
    result := qry.IsEmpty;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TPayTaxConfig.ValidateData: boolean;
begin
  result := inherited;
  if not result then exit;
  result := false;
  if RegionId = 0 then begin
    AddResult(false,rssWarning,0,'Region is blank');
    exit;
  end;
  if Trim(TaxName) = '' then begin
    AddResult(false,rssWarning,0,'Tax Name is blank');
    exit;
  end;
  if not TaxNameUnique then begin
    AddResult(false,rssWarning,0,'Tax Name "' + TaxName +'" already exists');
    exit;
  end;
  if GroupType = '' then begin
    AddResult(false,rssWarning,0,'Group Type is blank');
    exit;
  end;

  if Active then begin
    if (ExpenseAccountId = 0) and (LiabilityAccountId = 0) then begin
      AddResult(false,rssWarning,0,'Expense and Liability Accounts are blank');
      exit;
    end;
  end;
  if PrimaryTax then
    self.MakeOthersNonePrimary;

  result := true;
end;

end.
