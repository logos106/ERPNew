unit FastFuncs;

interface

uses
  Classes, SysUtils;


//function StringReplace(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
function PosExIgnoreCase(const SubStr, S: string; Offset: Cardinal = 1): Integer;
procedure Split(const aValue: string; const aDelimiter: char; var Result: TStringList);
function Splitcount(const aValue: string; const aDelimiter: char):Integer;
function LowerCase(const s: string): string;
(*function UpperCase(const s: string): string;*)
function CompareText(const S1, S2: string): Integer;
function SameText(const S1, S2: string): Boolean;
function IntToStr(Const I : Integer) : String;
(* function StrToBoolean(Const Value:String):boolean; *)
(* function BooleanToStr(const Value:Boolean):String; *)
function StrToInt(const S: string): Integer;
procedure FillChar(var Dest; Const count: Integer; Const Value: Char);
function Strlength(const Str: string): Integer;
function StrLen(const Str: PChar): Cardinal;
function Trim(const Str: string): string;
function LeftStr(const aSourceString: string; Const Size: integer): string;
function RightStr(const aSourceString: string; Const Size: integer): string;
(*function StringCount(const aSourceString, aFindString: string; const CaseSensitive: boolean = true): integer;*)
function RandomStr(const aLength: longint): string;

var
  FastCPUType :Boolean;

implementation

uses
  {StringReplaceUnit,}PosExUnit,{PosIExUnit,}FastStringFuncs,
  {UpperCaseUnit,}FillCharUnit,StrLenUnit,StrUtils, AnsiStrings;

//function StringReplace(const S, OldPattern, NewPattern: AnsiString; Flags: TReplaceFlags): AnsiString;
//Begin
//  result:= AnsiStrings.StringReplace(S,OldPattern,NewPattern,Flags);
////  If FastCPUType then
////    Result := StringReplaceUnit.StringReplace_JOH_PAS_12(S, OldPattern, NewPattern, Flags)
////  else
////    Result := SysUtils.StringReplace(S, OldPattern, NewPattern, Flags);
//end;


function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
Begin
  If FastCPUType then
    Result := PosExUnit.PosEx(SubStr, S, Offset)
  else
    Result := System.Pos(SubStr, S);
end;


function PosExIgnoreCase(const SubStr, S: string; Offset: Cardinal = 1): Integer;
Begin
  result:= PosEx(Lowercase(SubStr),Lowercase(s),Offset);
//  If FastCPUType then
//    Result := PosIExUnit.PosIEx_DKC_Pas_24_a(SubStr, S,Offset)
//  else
//    Result := System.Pos(SysUtils.LowerCase(SubStr), SysUtils.LowerCase(S));
end;


function Splitcount(const aValue: string; const aDelimiter: char):Integer;
var
  x: TStringList;
begin
  x:= TStringList.create;
  try
    Split(aValue, aDelimiter , x);
    REsult := x.Count;
  finally
      freeandnil(x);
  end;

end;
procedure Split(const aValue: string; const aDelimiter: char; var Result: TStringList);
Begin
  FastStringFuncs.Split(aValue, aDelimiter,Result)
end;

function LowerCase(const s: string): string;
begin
//  If FastCPUType then
//    Result := LowerCaseUnit.LowerCase_Sha_Pas_2_d(s)
//  else
    Result := SysUtils.LowerCase(s);
end;


function UpperCase(const s: string): string;
begin
  result:= SysUtils.UpperCase(s);
//  If FastCPUType then
//    Result := UpperCaseUnit.UpperCase_DKC_Pas_32_b(s)
//  else
//    Result := SysUtils.UpperCase(s);
end;


function CompareText(const S1, S2: string): Integer;
Begin
//  If FastCPUType then
//    Result := CompareTextUnit.CompareText_Sha_Pas_5_d(S1, S2)
//  else
    Result := SysUtils.CompareText(S1, S2);
end;

function SameText(const S1, S2: string): Boolean;
Begin
  If FastCPUType then
    Result := (FastFuncs.CompareText(S1, S2)=0)
  else
    Result := SysUtils.SameText(S1, S2);
end;
(* function BooleanToStr(const Value:Boolean):String;
begin
  if Value then result := 'T' else result := 'F';
end; *)
(* function StrToBoolean(Const Value:String):boolean;
begin
  if (SameText(value , 'T')) or (SameText(Value, 'True')) then result := true else result := False;
end; *)
function IntToStr(Const I : Integer) : String;
Begin
//  If FastCPUType then
//    Result := IntToStrUnit.IntToStr_DKC_IA32_3(I)
//  else
{No Results}
    Result := SysUtils.IntToStr(I);
end;

function StrToInt(const S: string): Integer;
Begin
//  If FastCPUType then
//    Result := StrToIntUnit.StrToInt32_JOH_IA32_7_c(S)
//  else
{RTL PAS QUICKER}
    Result := SysUtils.StrToInt(S);
end;

procedure FillChar(var Dest; Const count: Integer; Const Value: Char);
Begin
  If FastCPUType then
    FillCharUnit.FillChar_CJG_Pas_5_d(Dest,count,Value)
  else
    System.FillChar(Dest,count,Value);
end;

function Strlength(const Str: string): Integer;
Begin
  If FastCPUType then
    Result := StrLenUnit.StrLen_JOH_PAS_3_b(PChar(Str))
  else
    Result := System.length(Str);
end;

function StrLen(const Str: PChar): Cardinal;
Begin
  If FastCPUType then
    Result := StrLenUnit.StrLen_JOH_PAS_3_b(Str)
  else
    Result := SysUtils.StrLen(Str);
end;

function Trim(const Str: string): string;
Begin
//  If FastCPUType then
//    Result := TrimUnit.Trim_DLA_PAS_24_d(Str)
//  else
    Result := SysUtils.Trim(Str);
end;

function LeftStr(const aSourceString: string; Const Size: integer): string;
Begin
  If FastCPUType then begin
    If Size=0 then
      Result := aSourceString
    else
      Result := FastStringFuncs.LeftStr(aSourceString,Size);
  end else
    Result := StrUtils.LeftStr(aSourceString,Size);
end;

function RightStr(const aSourceString: string; Const Size: integer): string;
Begin
  If FastCPUType then Begin
    If Size=0 then
      Result := aSourceString
    else
    Result := FastStringFuncs.RightStr(aSourceString,Size)
  end else
    Result := StrUtils.RightStr(aSourceString,Size);
end;

(*function StringCount(const aSourceString, aFindString: string; const CaseSensitive: boolean = true): integer;
Begin
  Result := FastStringFuncs.StringCount(aSourceString,aFindString,CaseSensitive)
end;*)

function RandomStr(const aLength: longint): string;
Begin
  Result := FastStringFuncs.RandomStr(aLength)
end;

initialization
 { TODO -oIanos : Fast funcs Memory Bug }
  FastCPUType := False;  // Set To False big data import failed with wierd memory issue with memorytable
                        // Turned off fast funcs fixed it ???? need more time to fix see which func causes it.
end.






















