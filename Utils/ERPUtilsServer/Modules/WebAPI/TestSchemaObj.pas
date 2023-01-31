unit TestSchemaObj;

interface

uses
  classes, contnrs, BusObjBase;

type

  TTestBase = class(TPersistent)
  public
    class function _Schema: string; virtual;
  end;


  TTest = class(TTestBase)
  private
  public
    class function _Schema: string; override;
  published
  end;





implementation

uses
  JsonObject;

{ TSchema }


{ TTestBase }

class function TTestBase._Schema: string;
begin
  result:= '{"type":"' + self.ClassName + '"}';
end;

{ TTest }

class function TTest._Schema: string;
begin
  result:= inherited;

  with JO(result) do begin
    A['Mappings'].Add(JO('{"RepID":{"MapToType":"TEmployeeDetails","MapToField":"ID"}}'));
    A['Mappings'].Add(JO('{"RepName":{"MapToType":"TEmployeeDetails","MapToField":"EmployeeName"}}'));
    result:= AsString;
    free;
  end;
end;

initialization
  RegisterClass(TTest);

end.
