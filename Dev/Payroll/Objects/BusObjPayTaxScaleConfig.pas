unit BusObjPayTaxScaleConfig;

interface

uses
  BusObjBase, Classes, MyAccess;

type

  TPayTaxScaleConfig = class(TMSBusObj)
   private
    function GetAllowanceQty: integer;
    function GetEmployeeId: integer;
    function GetPayTaxConfigId: integer;
    function GetTaxScaleId: integer;
    procedure SetAllowanceQty(const Value: integer);
    procedure SetEmployeeId(const Value: integer);
    procedure SetPayTaxConfigId(const Value: integer);
    procedure SetTaxScaleId(const Value: integer);
    function GetExpenseAccountId: integer;
    function GetLiabilityAccountId: integer;
    procedure SetExpenseAccountId(const Value: integer);
    procedure SetLiabilityAccountId(const Value: integer);
   public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    class procedure CreateAllForEmployee(aEmployeeId: integer; Conn: TCustomMyConnection = nil);
  published
    property PayTaxConfigId: integer read GetPayTaxConfigId write SetPayTaxConfigId;
    property EmployeeId: integer read GetEmployeeId write SetEmployeeId;
    property TaxScaleId: integer read GetTaxScaleId write SetTaxScaleId;
    property AllowanceQty: integer read GetAllowanceQty write SetAllowanceQty;
    property ExpenseAccountId: integer read GetExpenseAccountId write SetExpenseAccountId;
    property LiabilityAccountId: integer read GetLiabilityAccountId write SetLiabilityAccountId;
  end;


implementation

uses
  CommonDbLib, SysUtils, ERPDbComponents, DbSharedObjectsObj, AppEnvironment;

{ TPayTaxScaleConfig }

constructor TPayTaxScaleConfig.Create(aOwner: TComponent);
begin
  inherited;
  inherited Create(aOwner);
  fBusObjectTypeDescription := 'PayTaxScaleConfig';
  fSQL := 'SELECT * FROM tblPayTaxScaleConfig';
end;

class procedure TPayTaxScaleConfig.CreateAllForEmployee(aEmployeeId: integer;
  Conn: TCustomMyConnection);
var
  ts: TPayTaxScaleConfig;
  qry: TERPQuery;
begin
  ts := TPayTaxScaleConfig.Create(nil);
  try
    ts.Connection := TMyDacDataConnection.Create(ts);
    if Assigned(Conn) then ts.Connection.Connection := Conn
    else ts.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
    ts.LoadSelect('EmployeeId = ' + IntToStr(aEmployeeId));
    qry := DbSharedObj.GetQuery(ts.Connection.Connection);
    try
      qry.SQL.Add('SELECT * FROM tblPayTaxConfig');
      qry.SQL.Add('WHERE RegionId=' + IntToStr(AppEnv.RegionalOptions.Id));
      qry.SQL.Add('AND Active="T"');
      qry.Open;
      while not qry.Eof do begin
        if not ts.Dataset.Locate('PayTaxConfigId',qry.FieldByName('Id').AsInteger,[]) then begin
          ts.New;
          ts.EmployeeId := aEmployeeId;
          ts.PayTaxConfigId := qry.FieldByName('ID').AsInteger;
          ts.TaxScaleId := qry.FieldByName('DefaultTaxScaleId').AsInteger;
          ts.ExpenseAccountId := qry.FieldByName('ExpenseAccountId').AsInteger;
          ts.LiabilityAccountId := qry.FieldByName('LiabilityAccountId').AsInteger;
        end
        else
          if (qry.FieldByName('GroupType').AsString = 'Medicare') or (qry.FieldByName('GroupType').AsString = 'SocialSecurity') then
            ts.TaxScaleId := qry.FieldByName('DefaultTaxScaleId').AsInteger;

        ts.PostDb;

        qry.Next;
      end;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;

  finally
    ts.Free;
  end;
end;

destructor TPayTaxScaleConfig.Destroy;
begin

  inherited;
end;

function TPayTaxScaleConfig.GetAllowanceQty: integer;
begin
  result := GetIntegerField('AllowanceQty')
end;

class function TPayTaxScaleConfig.GetBusObjectTablename: string;
begin
  result := 'tblPayTaxScaleConfig';
end;

function TPayTaxScaleConfig.GetEmployeeId: integer;
begin
  result := GetIntegerField('EmployeeId');
end;

function TPayTaxScaleConfig.GetExpenseAccountId: integer;
begin
  result := GetIntegerField('ExpenseAccountId');
end;

class function TPayTaxScaleConfig.GetIDField: string;
begin
  result := 'Id';
end;

function TPayTaxScaleConfig.GetLiabilityAccountId: integer;
begin
  result := GetIntegerField('LiabilityAccountId');
end;

function TPayTaxScaleConfig.GetPayTaxConfigId: integer;
begin
  result := GetIntegerField('PayTaxConfigId');
end;

function TPayTaxScaleConfig.GetTaxScaleId: integer;
begin
  result := GetIntegerField('TaxScaleId');
end;

procedure TPayTaxScaleConfig.SetAllowanceQty(const Value: integer);
begin
  SetIntegerField('AllowanceQty', Value);
end;

procedure TPayTaxScaleConfig.SetEmployeeId(const Value: integer);
begin
  SetIntegerField('EmployeeId', Value);
end;

procedure TPayTaxScaleConfig.SetExpenseAccountId(const Value: integer);
begin
  SetIntegerField('ExpenseAccountId', Value);
end;

procedure TPayTaxScaleConfig.SetLiabilityAccountId(const Value: integer);
begin
  SetIntegerField('LiabilityAccountId', Value);
end;

procedure TPayTaxScaleConfig.SetPayTaxConfigId(const Value: integer);
begin
  SetIntegerField('PayTaxConfigId', Value);
end;

procedure TPayTaxScaleConfig.SetTaxScaleId(const Value: integer);
begin
  SetIntegerField('TaxScaleId', Value);
end;

end.
