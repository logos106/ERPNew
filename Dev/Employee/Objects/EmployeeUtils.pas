unit EmployeeUtils;

interface

uses SysUtils, MyAccess,ERPdbComponents;

function GetAppointmentsForServiceCount(const AServiceID: integer; const AMinDate: TDateTime): integer;
procedure DeleteAppointmentsByService(const AServiceID: integer; const AMinDate: TDateTime; const UseDate: boolean = true);

implementation

uses CommonDBLib;

function GetAppointmentsForServiceCount(const AServiceID: integer; const AMinDate: TDateTime): integer;
begin
  with TERPQuery.Create(nil) do try
      Connection := CommonDBLib.GetSharedMyDacConnection; 
      SQL.Add('SELECT Count(*) FROM tblappointments');
      SQL.Add('WHERE ServiceID = :ServiceID AND AppDate >= :MinDate');
      ParamByName('ServiceID').AsInteger := AServiceID;
      ParamByName('MinDate').AsDateTime := AMinDate;
      Open;
      Result := Fields[0].AsInteger;
    finally
      Free;
    end;
end;

procedure DeleteAppointmentsByService(const AServiceID: integer; const AMinDate: TDateTime; const UseDate: boolean = true);
begin
  with TERPQuery.Create(nil) do try
      Connection := CommonDBLib.GetSharedMyDacConnection; 
      SQL.Add('DELETE FROM tblappointments');
      SQL.Add('WHERE ServiceID = :ServiceID');
    
      if UseDate then begin
        SQL.Add('AND AppDate >= :MinDate');
        ParamByName('MinDate').AsDateTime := AMinDate;
      end;
    
      ParamByName('ServiceID').AsInteger := AServiceID;
      Execute;
    finally
      Free;
    end;
end;

end.
