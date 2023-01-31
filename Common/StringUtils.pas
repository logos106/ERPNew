unit StringUtils;

interface

uses
  Types, classes;

function StrCount(SubStr,Str: string): integer;
function StringIsNumber(str: string): boolean;
function StringIsBoolean(str: string): boolean;
function StringIsInteger(str: string): boolean;
//function StringIsCurrency(str: string): boolean;
function StripQuotes(str: string): string;
function StringToFloatDef(str: string; default: extended): extended;
function StringToFloat(str: string): extended;
function RemoveLeadingZeros(str: string): string;
function StripNonIntChars(str: string): string;
function ReplaceSpaceWithPlus(str: string): string;
function IncludeTrailingForwardSlash(str: string): string;
function SeparateWords(str: string): string;
Function ProperCase(str: string): string;
Function IncStr(Str:STring; incby :Integer = 1):String;
{ case insensitive search }
function IndexOf(str: string; list: TStringDynArray): integer;
function SplitString(const s, Delimiters: string; QuoteStr: string = ''): TStringDynArray; 
function IntToAZ (Value: Int64): string;
function AZToInt (Value : string) : int64;
function EscSqlSpecialChars(str: string): string;
{ comma seperated list with each item quoted }
function QuotedCommaText(strings: TStrings; const QuoteChar: Char = '"'): string;Overload;
function QuotedCommaText(strings: String; const QuoteChar: Char = '"'): string;  Overload;
function StringIsQuoted(const str: string; QuoteChar: Char = #0): boolean;
function StringContainsLetter(const str: string): boolean;
function StringContainsNumber(const str: string): boolean;
function StringContainsUppercaseLetter(const str: string): boolean;
function StringContainsLowercaseLetter(const str: string): boolean;
function StrJoin(s1,s2: string): string;
function RandomString(const aLength: integer): string;
function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
function StringPadLeft(str, padChar: string; aLength: integer): string;
function StringPadRight(str, padChar: string; aLength: integer): string;

implementation

uses
  Character, SysUtils, StrUtils;

function StrCount(SubStr,Str: string): integer;
begin
  result:= Trunc((Length(str) - Length(StringReplace(Str,SubStr,'',[rfIgnoreCase,rfReplaceAll]))) / Length(SubStr));
end;


function StringIsNumber(str: string): boolean;
var
  i: integer;
  curPos: integer;
begin
  if str = '' then begin
    result:= false;
    exit;
  end;
  result:= true;
  curPos := Pos(FormatSettings.CurrencyString,str);
  if (curPos > 0) and (StrCount(FormatSettings.CurrencyString,str) > 1)  then
    curPos := 0; { should only be one occurance of currency symbol }
  for i := 1 to Length(str) do begin
    if Character.IsNumber(str[i]) then begin //  or CharInSet(str[i], ['.','+','-','e'])) then begin
      { allow }
    end
    else if CharInSet(str[i], [FormatSettings.DecimalSeparator,'+','-','e']) then begin
      { each should only occure once }
      if StrCount(str[i],str) > 1 then begin
        result:= false;
        break;
      end;
    end
    else if str[i] = FormatSettings.ThousandSeparator then  begin
      // alow multiple
    end
    else if (curPos > 0) and (i >= curPos) and (i <= curPos + (Length(FormatSettings.CurrencyString)-1)) then begin
      // allow currency symbol string
    end
    else begin
      result:= false;
      break;
    end;
  end;
end;

function StringIsBoolean(str: string): boolean;
begin
  result := SameText(str,'True') or SameText(str,'False');
end;

function StringIsInteger(str: string): boolean;
var
  x: integer;
begin
  result := true;
  for x := 1 to Length(str) do begin
    if not CharInSet(str[x],['0'..'9']) then begin
      result := false;
      exit;
    end;
  end;
end;

//function StringIsCurrency(str: string): boolean;
//var
//  fmt: TFormatSettings;
//begin
//  result := true;
//  fmt := TFormatSettings.Create;
//  try
//
//
//    StrToFloat(str,fmt);
//  except
//    result := false;
//  end;
//end;

function StripQuotes(str: string): string;
begin
  if ((Copy(str,1,1) = '"') and (Copy(str,Length(str),1) = '"')) or
     ((Copy(str,1,1) = '''') and (Copy(str,Length(str),1) = '''')) then
    result := Copy(str,2,Length(Str)-2)
  else
    result := str;
end;

function StringToFloatDef(str: string; default: extended): extended;
var
  s: string;
begin
  if Trim(str) = '' then begin
    result := 0;
    exit;
  end;
  { remove currency symbol and thousand separators .. }
  s:= StringReplace(str, FormatSettings.CurrencyString, '', [rfIgnoreCase]);
  s:= StringReplace(s, FormatSettings.ThousandSeparator, '', [rfIgnoreCase, rfReplaceAll]);
  result := StrToFloatDef(s,default);
end;

function StringToFloat(str: string): extended;
var
  s: string;
  DecimalSep: char;
begin
  if Trim(str) = '' then begin
    result := 0;
    exit;
  end;
  { remove currency symbol and thousand separators .. }
  s:= StringReplace(str, FormatSettings.CurrencyString, '', [rfIgnoreCase]);
  s:= StringReplace(s, FormatSettings.ThousandSeparator, '', [rfIgnoreCase, rfReplaceAll]);
  try
    result := StrToFloat(s);
  except
    on EConvertError do begin
      { could be different decimal separator }
      DecimalSep := FormatSettings.DecimalSeparator;
      try
         FormatSettings.DecimalSeparator := '.';
         result := StrToFloat(s);
      finally
        FormatSettings.DecimalSeparator := DecimalSep;
      end;

    end
    else
      raise;
  end;
end;

function RemoveLeadingZeros(str: string): string;
var
  x: integer;
begin
  result := '';
  for x := 1 to Length(Str) do begin
    if str[x] = '0' then
      continue
    else begin
      result := Copy(str,x,Length(str));
      exit;
    end;
  end;
end;

function StripNonIntChars(str: string): string;
var
  x: integer;
begin
  result := '';
  for x := 1 to Length(Str) do begin
    if (str[x] = '-') and (result = '') then
      result := '-'
    else if CharInSet(str[x],['0' .. '9']) then
      result := result + str[x];
  end;
end;

function ReplaceSpaceWithPlus(str: string): string;
var
  x: integer;
begin
  result := '';
  for x := 0 to Length(str) do begin
    if str[x] = ' ' then begin
      if result[Length(result)] <> '+' then
        result := result + '+';
    end
    else
      result := result + str[x];
  end;
end;

function IncludeTrailingForwardSlash(str: string): string;
begin
  result := str;
  if RightStr(result,1) <> '/' then
    result := result + '/';
end;
Function ProperCase(str: string): string;
var
  x: integer;
begin
  result := '';
  if Length(str) =0 then exit;
  result := UpperCase(str[1]);
  for x := 2 to Length(str) do begin
    if x=1 then
      result := result + UpperCase(str[x])
    else if str[x-1] = ' ' then
      result := result + UpperCase(str[x])
    else result := result + LowerCase(str[x]);
  end;
  //result := result + LowerCase(str[x]);
end;

function SeparateWords(str: string): string;
var
  x: integer;
begin
  result := '';
  for x := 1 to Length(str) do begin
    if IsUpper(str[x]) and (not ((x > 1) and (IsUpper(str[x-1]) or (str[x-1] =' ') or IsPunctuation((str[x-1]))) )) then begin
      if result <> '' then
        result := result + ' ';
    end;
    result := result + str[x];
  end;
end;
Function IncStr(Str:STring; incby :Integer = 1):String;
var
  ctr:Integer;
  s:String;
  Flag:Boolean;
begin
  REsult := '';
  Flag:=False;
  for ctr:= length(str) downto 1 do begin
    s:= copy(str,ctr,1);
    if s<> '' then begin
      try
        if TCharacter.IsNumber(s,1) then begin
          if Flag = False then begin
            if strtoint(s)<9 then begin
              Result := inttostr(strtoint(s)+ incby)+ result;
              Flag:= TRue;
            end else begin
              Result := '0' +result;
            end;
          end else begin
            REsult := s+result;
          end;
        end else begin
          if not flag then result := '1'+result;
          Result := Copy(str,1,ctr)+result;
          Flag:= true;
          break;
        end;
      Except
        on E:Exception do begin
          if not flag then result := '1'+result;
          Result := Copy(str,1,ctr)+result;
          Flag:= true;
          break;
        end;
      end;
    end;
  end;
  if not Flag then result := '1'+result;
end;

function IndexOf(str: string; list: TStringDynArray): integer;
var
  x: integer;
begin
  result := -1;
  for x := Low(list) to High(list) do begin
    if SameText(list[x],str) then begin
      result := x;
      break;
    end;

  end;
end;

function SplitString(const s, Delimiters: string; QuoteStr: string = ''): TStringDynArray;
var
  x: integer;
  QuoteCount: integer;
  IsQuoted: boolean;
  part: string;

  function QuoteIsEscaped: boolean;
  var EscPos: integer;
  begin
    result := false;
    EscPos := Length(part) - Length(QuoteStr);
    if (EscPos > 0) and (part[EscPos] = '\') then begin
      { quote is escaped }
      result := true;
      if (EscPos > 1) and (part[EscPos-1] = '\') then
        { an escaped escape }
        result := false;
    end;
  end;

begin
  part := '';
  QuoteCount := 0;
  IsQuoted := QuoteStr <> '';
  for x := 1 to Length(s) do begin
    part := part + s[x];
    if IsQuoted then begin
      if RightStr(part,Length(QuoteStr)) = QuoteStr then begin
        if not QuoteIsEscaped then
          Inc(QuoteCount);
      end
      else if RightStr(part,Length(Delimiters)) = Delimiters then begin
        if not Odd(QuoteCount) then begin
          part := LeftStr(part,Length(part)-Length(Delimiters));
          SetLength(result,Length(result) +1);
          result[High(result)] := part;
          part := '';
          QuoteCount := 0;
        end;
      end;

    end
    else begin
      if RightStr(part,Length(Delimiters)) = Delimiters then begin
        part := LeftStr(part,Length(part)-Length(Delimiters));
        SetLength(result,Length(result) +1);
        result[High(result)] := part;
        part := '';
      end;
    end;
  end;
  SetLength(result,Length(result) +1);
  result[High(result)] := part;
end;

function IntToAZ (Value: Int64): string;
var
  i : integer;
  neg : boolean;
  divided: boolean;
begin
  i := Value;
  neg:=i<0;
  if neg then i:=-i;
  Result:='';
  divided := false;
  repeat
    if divided then
      i := i - 1;
    Result := chr(Ord('A')+(i mod 26)) + Result;
    divided := i >= 26;
    i:=(i div 26);
  until i=0;
  if neg then Result:='-'+result;
end;


{ NOTE - the following is NOT tested }
function AZToInt (Value : string) : int64;
var
  i : integer;
  neg : boolean;
begin
  Result:=0;
  neg:=copy(Value,1,1)='-';
  if neg then Value:=copy(Value,2,maxint);
  i:=1;
  while i<length(Value) do begin
    Result:=Result*26+ord(Value[i])-ord('A');
    inc (i);
  end;
  if neg then Result:=-result;
end;

function EscSqlSpecialChars(str: string): string;
var
  x: integer;
begin
  result := '';
  for x := 1 to Length(str) do begin
    if CharInSet(str[x],[#0,#8,#10,#13,#9,#26,'\','%']) then
      result := result + '\' + str[x]
    else
      result := result + str[x];
  end;
end;
function QuotedCommaText(strings: String; const QuoteChar: Char = '"'): string;
begin
  REsult := QuoteChar +Strings +QuoteChar ;
  result := replaceStr(REsult, ',' ,QuoteChar +',' +QuoteChar );
end;
function QuotedCommaText(strings: TStrings; const QuoteChar: Char): string;
var
  x: integer;
begin
  result := '';
  for x := 0 to strings.Count -1 do begin
    if x > 0 then result := result + ',';
    result := result + QuoteChar + strings[x] + QuoteChar;
  end;
end;

function StringIsQuoted(const str: string; QuoteChar: Char): boolean;

  function IsQuoted(const qc: Char): boolean;
  begin
    result := (Copy(str,1,1) = qc) and (Copy(str,Length(str),1) = qc);
  end;

begin
  if QuoteChar <> #0 then
    result := IsQuoted(QuoteChar)
  else
    result := IsQuoted('''') or IsQuoted('"');
end;

function StringContainsLetter(const str: string): boolean;
var
  x: integer;
begin
  result := false;
  for x := 1 to Length(str) do begin
    if TCharacter.IsLetter(str[x]) then begin
      result := true;
      exit;
    end;
  end;
end;

function StringContainsUppercaseLetter(const str: string): boolean;
var
  x: integer;
begin
  result := false;
  for x := 1 to Length(str) do begin
    if TCharacter.IsUpper(str[x]) then begin
      result := true;
      exit;
    end;
  end;
end;

function StringContainsLowercaseLetter(const str: string): boolean;
var
  x: integer;
begin
  result := false;
  for x := 1 to Length(str) do begin
    if TCharacter.IsLower(str[x]) then begin
      result := true;
      exit;
    end;
  end;
end;

function StringContainsNumber(const str: string): boolean;
var
  x: integer;
begin
  result := false;
  for x := 1 to Length(str) do begin
    if TCharacter.IsNumber(str[x]) then begin
      result := true;
      exit;
    end;
  end;
end;
function StrJoin(s1,s2: string): string;
begin
  result := s1;
  if (result <> '') then begin
    if s2 <> '' then
      result := result + ' ' + s2;
  end
  else
    result := s2;
end;

function RandomString(const aLength: integer): string;
begin

end;
function ReplaceStr(const sString, sOldStr, sNewStr: string): string;
begin
  Result := StringReplace(sString, sOldStr, sNewStr,[rfReplaceAll,rfIgnoreCase]);
end;

function StringPadLeft(str, padChar: string; aLength: integer): string;
begin
  result := str;
  while Length(result) < aLength do
    result := padChar + result;
end;

function StringPadRight(str, padChar: string; aLength: integer): string;
begin
  result := str;
  while Length(result) < aLength do
    result := result + padChar;
end;

end.
