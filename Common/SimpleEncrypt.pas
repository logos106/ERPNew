unit SimpleEncrypt;

interface

function DeCrypt(const EnCryptedText: string; const KEY: string): string;
function SimpleCrypt(const s: string): string;


implementation

function DeCrypt(const EnCryptedText: string; const KEY: string): string;
var
  i, j, v: integer;
begin
  Result := '';
  j := 1;
  for i := 1 to Length(EnCryptedText) do begin
    v := Ord(EnCryptedText[i]) - Ord(KEY[j]);
    if v < 0 then v := v + 256;
    Result := Result + Chr(v);
    Inc(j);
    if j > Length(KEY) then j := 1;
  end;
end;

function SimpleCrypt(const s: string): string;
var i: integer;
begin
  result := s;
  for i := 1 to length(s) do
    case ord(s[i]) of
    ord('A')..ord('M'),ord('a')..ord('m'): result[i] := chr(ord(s[i])+13);
    ord('N')..ord('Z'),ord('n')..ord('z'): result[i] := chr(ord(s[i])-13);
    ord('0')..ord('4'): result[i] := chr(ord(s[i])+5);
    ord('5')..ord('9'): result[i] := chr(ord(s[i])-5);
    end;
end;

end.
