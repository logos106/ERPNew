unit X12Lib;

interface

function CCYYMMDDDateToDate(aDate: string): TDate;

implementation

uses sysutils;

function CCYYMMDDDateToDate(aDate: string): TDate;
begin
  result:= EncodeDate(StrToInt(Copy(aDate,1,4)),StrToInt(Copy(aDate,5,2)),StrToInt(Copy(aDate,7,2)));
end;

end.
