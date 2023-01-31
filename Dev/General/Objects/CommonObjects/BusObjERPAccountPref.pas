unit BusObjERPAccountPref;

interface

uses
  BusObjBase, Db, Classes, BusObjERPPreference;

type

  TERPAccountPref = class(TERPPreference)
  private
    function GetAccountId: integer;
    function GetAccountName: string;
    procedure SetAccountId(const Value: integer);
    procedure SetAccountName(const Value: string);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    class function _Schema: string; override;
  published
    property AccountId: integer read GetAccountId write SetAccountId;
    property AccountName: string read GetAccountName write SetAccountName;
  end;


implementation

uses
  SysUtils, BusObjSchemaLib, BusObjGLAccount;

{ TERPAccountPref }

constructor TERPAccountPref.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'ERPAccountPreference';
//  fSQL := 'SELECT * FROM tbldbpreferences where LocalPref = "F" and RefType = "Account"';
  fSQL := 'SELECT * FROM tbldbpreferences where RefType = "Account"';
  ExportExcludeList.Add('accountid');
end;

function TERPAccountPref.GetAccountId: integer;
begin
  if SameText(FieldType,'ftInteger') or SameText(FieldType,'ftLargeInt') then begin
    result:= StrToIntDef(FieldValue,0);
  end
  else if SameText(FieldType,'ftString') then begin
    if FieldValue <> '' then
      result := TAccount.IDToggle(FieldValue, Connection.Connection)
    else
      result := 0;
  end
  else
    raise Exception.Create('TERPAccountPref - Invalid Field Type for an Account Type Preference: ' + FieldType);
end;

function TERPAccountPref.GetAccountName: string;
begin
  if SameText(FieldType,'ftInteger') or SameText(FieldType,'ftLargeInt') then begin
    if FieldValue <> '' then
      result := TAccount.IDToggle(StrToIntDef(FieldValue,0), Connection.Connection)
    else
      result := '';
  end
  else if SameText(FieldType,'ftString') then begin
    result := FieldValue
  end
  else
    raise Exception.Create('TERPAccountPref - Invalid Field Type for an Account Type Preference: ' + FieldType);
end;

procedure TERPAccountPref.SetAccountId(const Value: integer);
begin
  if SameText(FieldType,'ftInteger') or SameText(FieldType,'ftLargeInt') then begin
    FieldValue := IntToStr(Value);
  end
  else if SameText(FieldType,'ftString') then begin
    if Value > 0 then
      FieldValue := TAccount.IDToggle(Value, Connection.Connection)
    else
      FieldValue := '0';
  end
  else
    raise Exception.Create('TERPAccountPref - Invalid Field Type for an Account Type Preference: ' + FieldType);
end;

procedure TERPAccountPref.SetAccountName(const Value: string);
begin
  if SameText(FieldType,'ftInteger') or SameText(FieldType,'ftLargeInt') then begin
    if Value <> '' then
      FieldValue :=  IntToStr(TAccount.IDToggle(Value, Connection.Connection))
    else
      FieldValue := '0';
  end
  else if SameText(FieldType,'ftString') then begin
    FieldValue := Value;
  end
  else
    raise Exception.Create('TERPAccountPref - Invalid Field Type for an Account Type Preference: ' + FieldType);
end;

class function TERPAccountPref._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountID','ID');
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountName','AccountName');
end;

initialization

RegisterClass(TERPAccountPref);

end.
