unit RandomUtils;

interface

function MakeRandomString(Len: Integer): string;

implementation

function MakeRandomString(Len: Integer): string;
var
  str: string;
begin
  Randomize;
  //string with all possible chars
  str    := '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  Result := '';
  repeat
    Result := Result + str[Random(Length(str)) + 1];
  until (Length(Result) = Len)
end;

end.
