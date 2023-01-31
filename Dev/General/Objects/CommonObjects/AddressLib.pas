unit AddressLib;

interface

Function add1(const aAdd1, aAdd2, aAdd3:String):string;
Function add2(const aAdd1, aAdd2, aAdd3:String):string;
Function add3(const aAdd1, aAdd2, aAdd3:String):string;

implementation

uses SysUtils;

Function add1(const aAdd1, aAdd2, aAdd3:String):string;
begin
   result := '';
   if trim(aAdd1)<> '' then begin
     Result := Trim(aAdd1);
     exit;
   end;
   if trim(aAdd2)<> '' then begin
     Result := Trim(aAdd2);
     exit;
   end;
   if trim(aAdd3)<> '' then begin
     Result := Trim(aAdd3);
     exit;
   end;
end;
Function add2(const aAdd1, aAdd2, aAdd3:String):string;
begin
   REsult := '';
   if trim(aAdd1)<> '' then begin
     if trim(aAdd2)<> '' then begin
       Result := Trim(aAdd2);
       exit;
     end;
     if trim(aAdd3)<> '' then begin
       Result := Trim(aAdd3);
       exit;
     end;
     Exit;
   end;
   if trim(aAdd2)<> '' then begin
     if trim(aAdd3)<> '' then begin
       Result := Trim(aAdd3);
       exit;
     end;
     exit;
   end;
end;
Function add3(const aAdd1, aAdd2, aAdd3:String):string;
begin
   REsult := '';
    if trim(aAdd1)<> '' then begin
      if trim(aAdd2)<> '' then begin
        Result := Trim(aAdd3);
        Exit;
      end;
    end;
 end;

end.
