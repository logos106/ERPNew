unit URILib;

interface

uses
  types;

function PercentEncode(const InStr: string): string;
function PercentEncodeAll(const InStr: string): string;
function URLEncode(const InStr: string): string;
function SplitURI(const URI: string): TStringDynArray;


implementation

uses
  SysUtils, {idURI,} Character;

function PercentEncode(const InStr: string): string;
var
  x: integer;
begin
  result:= '';
  for x := 1 to Length(InStr) do begin
    if InStr[x] = ' ' then
      result:= result + '%20'
    else if InStr[x] = '!' then
      result:= result + '%21'
    else if InStr[x] = '#' then
      result:= result + '%23'
    else if InStr[x] = '$' then
      result:= result + '%24'
    else if InStr[x] = '%' then
      result:= result + '%25'
    else if InStr[x] = '&' then
      result:= result + '%26'
    else if InStr[x] = '''' then
      result:= result + '%27'
    else if InStr[x] = '(' then
      result:= result + '%28'
    else if InStr[x] = ')' then
      result:= result + '%29'
    else if InStr[x] = '*' then
      result:= result + '%2A'
    else if InStr[x] = '+' then
      result:= result + '%2B'
    else if InStr[x] = ',' then
      result:= result + '%2C'
    else if InStr[x] = '/' then
      result:= result + '%2F'
    else if InStr[x] = ':' then
      result:= result + '%3A'
    else if InStr[x] = ';' then
      result:= result + '%3B'
    else if InStr[x] = '=' then
      result:= result + '%3D'
    else if InStr[x] = '?' then
      result:= result + '%3F'
    else if InStr[x] = '@' then
      result:= result + '%40'
    else if InStr[x] = '[' then
      result:= result + '%5B'
    else if InStr[x] = ']' then
      result:= result + '%5D'
    else if InStr[x] = '+' then
      result:= result + '%2B'
    else
     result := result + InStr[x];
  end;
end;

function PercentEncodeAll(const InStr: string): string;
var
  x: integer;
begin
  result := '';
  for x := 1 to Length(InStr) do begin
    result := result + '%' + IntToHex(Ord(InStr[x]),2);
  end;
end;


function URLEncode(const InStr: string): string;
var
  x: integer;
  c: char;
begin
  result := '';
  for x := 1 to Length(InStr) do begin
    c := Character.ToLower(InStr[x]);
    if InStr[x] = #13 then
      continue
    else if CharInSet(c,['a'..'z']) or CharInSet(InStr[x],['0'..'9']) or CharInSet(InStr[x],['-','_','.','~']) then
      result := result + InStr[x]
    else
      result := result + '%' + IntToHex(Ord(InStr[x]),2);
  end;
end;

function SplitURI(const URI: string): TStringDynArray;
var
  SplitPoints: Integer;
  i: Integer;
  s: string;
  InSingleQuote,
  inDoubleQuote: boolean;

  function IsQuoteEnd(CurrPos: integer): boolean;
  var
    x: integer;
  begin
    result:= true;
    for x := CurrPos + 1 to Length(URI) do begin
      if URI[x] = '/' then
        exit
      else if URI[x] <> ' ' then begin
        result:= false;
        exit;
      end;
    end;
  end;

begin
  Result := nil;

  if URI <> '' then
  begin
    s:= '';
    InSingleQuote:= false;
    InDoubleQuote:= false;
    SplitPoints := 0;
    SetLength(Result, SplitPoints + 1);
    for i := 1 to Length(URI) do begin
      if URI[i] = '/' then begin
        if InSingleQuote or InDoubleQuote then
          s:= s + URI[i]
        else begin
          if (s <> '') and (Result[SplitPoints] = '') then
            Result[SplitPoints]:= s;
          Inc(SplitPoints);
          SetLength(Result, SplitPoints + 1);
          s:= '';
        end;

      end
      else if URI[i] = '''' then begin
        s:= s + URI[i];
        if InSingleQuote then begin
          if IsQuoteEnd(i) then begin
            InSingleQuote:= false;
            Result[SplitPoints]:= s;
            s:= '';
          end;
        end
        else begin
          { not in single quote }
          if not InDoubleQuote then
            InSingleQuote:= true;
        end;
      end
      else if URI[i] = '"' then begin
        s:= s + URI[i];
        if InDoubleQuote then begin
          if IsQuoteEnd(i) then begin
            InDoubleQuote:= false;
            Result[SplitPoints]:= s;
            s:= '';
          end;
        end
        else begin
          { not in double quote }
          if not InSingleQuote then
            InDoubleQuote:= true;
        end;
      end
      else
        s:= s + URI[i];

    end;
    if (s <> '') and (Result[SplitPoints] = '') then
      Result[SplitPoints]:= s;
  end;
end;


end.
