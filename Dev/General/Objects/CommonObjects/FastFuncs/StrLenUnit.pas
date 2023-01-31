unit StrLenUnit;

interface

function StrLen_JOH_PAS_3_b(const Str: PChar): Cardinal;

implementation

function StrLen_JOH_PAS_3_b(const Str: PChar): Cardinal;
var
  P, PStr: PChar;
  I, J: Integer;
begin
  if Str^ = #0 then
    begin
      Result := 0; Exit;
    end;
  if Str[1] = #0 then
    begin
      Result := 1; Exit;
    end;
  if Str[2] = #0 then
    begin
      Result := 2; Exit;
    end;
  if Str[3] = #0 then
    begin
      Result := 3; Exit;
    end;
 P := Pointer(Str);
 PStr := P;
 P := Pointer(Integer(P) and -4);
 repeat
   Inc(P, 4);
   I := PInteger(P)^;
   J := I - $01010101;
   I := not(I);
   I := I and J;
 until (I and $80808080) <> 0;
 Result := P - PStr;
 if I and $80 = 0 then
   if I and $8000 <> 0 then
     Inc(Result)
   else
     if I and $800000 <> 0 then
       Inc(Result, 2)
     else
       Inc(Result, 3)
end;


end.
