unit BUsObjERPPaymentMethodPref;

interface

uses
  BusObjBase, Db, Classes, BusObjERPPreference;

type

  TERPPaymentMethodPref = class(TERPPreference)
  private
    function GetPaymentMethodId: integer;
    function GetPaymentMethodName: string;
    procedure SetPaymentMethodId(const Value: integer);
    procedure SetPaymentMethodName(const Value: string);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    class function _Schema: string; override;
  published
    property PaymentMethodId: integer read GetPaymentMethodId write SetPaymentMethodId;
    property PaymentMethodName: string read GetPaymentMethodName write SetPaymentMethodName;
  end;

implementation

uses
  SysUtils, BusObjSchemaLib, BusObjPayMethods;

{ TERPPaymentMethodPref }

constructor TERPPaymentMethodPref.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'ERPPAymentMethodPreference';
  fSQL := 'SELECT * FROM tbldbpreferences where LocalPref = "F" and RefType = "PaymentMethod"';
  ExportExcludeList.Add('paymentmethodid');
end;

function TERPPaymentMethodPref.GetPaymentMethodId: integer;
begin
  if SameText(FieldType,'ftInteger') or SameText(FieldType,'ftLargeInt') then begin
    result:= StrToIntDef(FieldValue,0);
  end
  else if SameText(FieldType,'ftString') then begin
    if FieldValue <> '' then
      result := TPaymentMethod.IDToggle(FieldValue, Connection.Connection)
    else
      result := 0;
  end
  else
    raise Exception.Create(ClassName + ' - Invalid Field Type for an Account Type Preference: ' + FieldType);
end;

function TERPPaymentMethodPref.GetPaymentMethodName: string;
begin
  if SameText(FieldType,'ftInteger') or SameText(FieldType,'ftLargeInt') then begin
    if FieldValue <> '' then
      result := TPaymentMethod.IDToggle(StrToIntDef(FieldValue,0), Connection.Connection)
    else
      result := '';
  end
  else if SameText(FieldType,'ftString') then begin
    result := FieldValue
  end
  else
    raise Exception.Create(ClassName + ' - Invalid Field Type for an Account Type Preference: ' + FieldType);
end;

procedure TERPPaymentMethodPref.SetPaymentMethodId(const Value: integer);
begin
  if SameText(FieldType,'ftInteger') or SameText(FieldType,'ftLargeInt') then begin
    FieldValue := IntToStr(Value);
  end
  else if SameText(FieldType,'ftString') then begin
    if Value > 0 then
      FieldValue := TPaymentMethod.IDToggle(Value, Connection.Connection)
    else
      FieldValue := '0';
  end
  else
    raise Exception.Create(ClassName + ' - Invalid Field Type for an Account Type Preference: ' + FieldType);
end;

procedure TERPPaymentMethodPref.SetPaymentMethodName(const Value: string);
begin
  if SameText(FieldType,'ftInteger') or SameText(FieldType,'ftLargeInt') then begin
    if Value <> '' then
      FieldValue :=  IntToStr(TPaymentMethod.IDToggle(Value, Connection.Connection))
    else
      FieldValue := '0';
  end
  else if SameText(FieldType,'ftString') then begin
    FieldValue := Value;
  end
  else
    raise Exception.Create(ClassName + ' - Invalid Field Type for an Account Type Preference: ' + FieldType);
end;

class function TERPPaymentMethodPref._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TPaymentMethod','PaymentMethodObj','PaymentMethodID','ID');
  TBOSchema.AddRefType(result,'TPaymentMethod','PaymentMethodObj','PaymentMethodName','PaymentMethodName');
end;

initialization

RegisterClass(TERPPaymentMethodPref);

end.
