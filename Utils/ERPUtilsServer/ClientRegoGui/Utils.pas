unit Utils;

interface

  function NowUTC: TDateTime;


implementation

uses
  windows, sysutils;

function NowUTC: TDateTime;
var
  st: TSystemTime;
begin
  Windows.GetSystemTime(st);
  result:= EncodeDate(st.wYear,st.wMonth,st.wDay) +
    EncodeTime(st.wHour,st.wMinute,st.wSecond,st.wMilliseconds);
end;

end.
