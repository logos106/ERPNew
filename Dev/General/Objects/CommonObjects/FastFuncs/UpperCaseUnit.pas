unit UpperCaseUnit;

interface

function UpperCase_DKC_Pas_32_b(const S: string): string;

implementation

uses
 SysUtils;

var
 LookUpTable : array of Char;

procedure InitializeLookUpTable;
var
 I : Byte;
 S1, S2 : AnsiString;

begin
 SetLength(LookUpTable, 256);
 for I := 0 to 255 do
  begin
   S1 := Char(I);
   S2 := UpperCase(S1);
   LookUpTable[I] := S2[1];
  end;
end;

function UpperCase_DKC_Pas_32_b(const S: string): string;
var
 Max, CharNo : Cardinal;
 pResult : PChar;

begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max > 0 then
  begin
   pResult := PChar(Result);
   CharNo := 0;
   repeat
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
    if CharNo >= Max then
     Break;
    pResult[CharNo] := LookUpTable[Ord(S[CharNo+1])];
    Inc(CharNo);
   until(CharNo >= Max);
  end;
end;

initialization
 InitializeLookUpTable;
end.


