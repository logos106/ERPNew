unit BusObjERPEmployeePref;

interface
uses
  BusObjBase, Db, Classes, BusObjERPPreference;

type

  TERPEmployeePref = class(TERPPreference)
  private
    function GetEmployeeId: integer;
    function GetEmployeeName: string;
    procedure SetEmployeeId(const Value: integer);
    procedure SetEmployeeName(const Value: string);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    class function _Schema: string; override;
  published
    property EmployeeId: integer read GetEmployeeId write SetEmployeeId;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
  end;

implementation

uses
  SysUtils, BusObjSchemaLib, BusObjEmployee;

{ TERPEmployeePref }

constructor TERPEmployeePref.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'ERPEmployeePreference';
  fSQL := 'SELECT * FROM tbldbpreferences where LocalPref = "F" and RefType = "Employee"';
  ExportExcludeList.Add('employeeid');
end;

function TERPEmployeePref.GetEmployeeId: integer;
begin
  if SameText(FieldType,'ftInteger') or SameText(FieldType,'ftLargeInt') then begin
    result:= StrToIntDef(FieldValue,0);
  end
  else if SameText(FieldType,'ftString') then begin
    if FieldValue <> '' then
      result := TEmployee.IDToggle(FieldValue, Connection.Connection)
    else
      result := 0;
  end
  else
    raise Exception.Create(ClassName + ' - Invalid Field Type for an Account Type Preference: ' + FieldType);
end;

function TERPEmployeePref.GetEmployeeName: string;
begin
  if SameText(FieldType,'ftInteger') or SameText(FieldType,'ftLargeInt') then begin
    if FieldValue <> '' then
      result := TEmployee.IDToggle(StrToIntDef(FieldValue,0), Connection.Connection)
    else
      result := '';
  end
  else if SameText(FieldType,'ftString') then begin
    result := FieldValue
  end
  else
    raise Exception.Create(ClassName + ' - Invalid Field Type for an Account Type Preference: ' + FieldType);
end;

procedure TERPEmployeePref.SetEmployeeId(const Value: integer);
begin
  if SameText(FieldType,'ftInteger') or SameText(FieldType,'ftLargeInt') then begin
    FieldValue := IntToStr(Value);
  end
  else if SameText(FieldType,'ftString') then begin
    if Value > 0 then
      FieldValue := TEmployee.IDToggle(Value, Connection.Connection)
    else
      FieldValue := '0';
  end
  else
    raise Exception.Create(ClassName + ' - Invalid Field Type for an Account Type Preference: ' + FieldType);
end;

procedure TERPEmployeePref.SetEmployeeName(const Value: string);
begin
  if SameText(FieldType,'ftInteger') or SameText(FieldType,'ftLargeInt') then begin
    if Value <> '' then
      FieldValue :=  IntToStr(TEmployee.IDToggle(Value, Connection.Connection))
    else
      FieldValue := '0';
  end
  else if SameText(FieldType,'ftString') then begin
    FieldValue := Value;
  end
  else
    raise Exception.Create(ClassName + ' - Invalid Field Type for an Account Type Preference: ' + FieldType);
end;

class function TERPEmployeePref._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeID','ID');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeName','EmployeeName');
end;

initialization

RegisterClass(TERPEmployeePref);

end.
