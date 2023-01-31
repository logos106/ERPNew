unit FillCharUnit;

interface

procedure FillChar_CJG_Pas_5_d(var Dest; count: Integer; Value: Char);

implementation

uses
 SysUtils;

procedure FillChar_CJG_Pas_5_d(var Dest; count: Integer; Value: Char);
var
  I, J, K : Integer;
  P    : Pointer;
  Label P01, P02, P03, P04, P05, P06, P07, P08, P09, P10, P11, P12;
begin
  if Count > 0 then
    begin
      P := @Dest;
      If Count >= 12 then
        begin
          J := Byte(Value);
          J := J or (J shl  8);
          J := J or (J shl 16);

          PInteger(P)^ := J;
          PInteger(Integer(P) + Count - 4)^ := J;

          I := Count shr 2;

          if Count >= 256 then
            begin
              if count < 448 then
                begin
                  PIntegerArray(P)[1] := J;
                  PIntegerArray(P)[2] := J;
                  PIntegerArray(P)[3] := J;

                  repeat
                    Dec(I,4);
                    PIntegerArray(P)[I]   := J;
                    PIntegerArray(P)[I+1] := J;
                    PIntegerArray(P)[I+2] := J;
                    PIntegerArray(P)[I+3] := J;
                  until I < 4;
                end
              else
                begin
                  I := Count;
                  K := (Integer(P) and 3) - 4;
                  Dec(I, 16);
                  Dec(PByte(P), K);
                  Inc(I, K);
                  Inc(PByte(P), I);
                  PintegerArray(P)[0] := J;
                  PintegerArray(P)[1] := J;
                  PintegerArray(P)[2] := J;
                  PintegerArray(P)[3] := J;
                  repeat
                    PintegerArray(Integer(P)-I)[0] := J;
                    PintegerArray(Integer(P)-I)[1] := J;
                    PintegerArray(Integer(P)-I)[2] := J;
                    PintegerArray(Integer(P)-I)[3] := J;
                    Dec(I, 16);
                  until I <= 0;
                end
             end
          else
            begin
              repeat
                Dec(I,2);
                PIntegerArray(P)[I] := J;
                PIntegerArray(P)[I+1] := J;
              until I < 2;
            end
        end
      else
        begin
          case Count of
            1:  goto P01;
            2:  goto P02;
            3:  goto P03;
            4:  goto P04;
            5:  goto P05;
            6:  goto P06;
            7:  goto P07;
            8:  goto P08;
            9:  goto P09;
            10: goto P10;
            11: goto P11;
            12: goto P12;
          end;
          P12: PByteArray(P)[11] := Byte(Value);
          P11: PByteArray(P)[10] := Byte(Value);
          P10: PByteArray(P)[09] := Byte(Value);
          P09: PByteArray(P)[08] := Byte(Value);
          P08: PByteArray(P)[07] := Byte(Value);
          P07: PByteArray(P)[06] := Byte(Value);
          P06: PByteArray(P)[05] := Byte(Value);
          P05: PByteArray(P)[04] := Byte(Value);
          P04: PByteArray(P)[03] := Byte(Value);
          P03: PByteArray(P)[02] := Byte(Value);
          P02: PByteArray(P)[01] := Byte(Value);
          P01: PByteArray(P)[00] := Byte(Value);

        end
    end;
end;

end.
