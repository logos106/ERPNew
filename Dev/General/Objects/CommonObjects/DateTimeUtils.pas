unit DateTimeUtils;

interface

uses
  Types;


function StrToDateTimeFmt(const Format, Str: string): TDateTime; overload;
function StrToDateTimeFmt(const DateFormat, TimeFormat, Str: string): TDateTime; overload;
function CenturyOfDate(dt: TDateTime): word;
function PreviousCentury(dt: TDateTime): word;
function RoundTimeToMinutes(const dt: TDateTime): TDateTime;
function MonthNameToNumber(const MonthName: string): integer;
function MonthNumberToName(const MonthNo: integer): string;
function FiscalYearStart(const aDate: TDateTime; const FiscalYearStartMonthName: string): TDateTime;
function PriorFiscalYearStart(const aDate: TDateTime; const FiscalYearStartMonthName: string): TDateTime;
function LastFiscalYearEnd(const aDate: TDateTime; const FiscalYearStartMonthName: string): TDateTime;

function ISO8601ToDateTime(val: string; ConvertToUTC: boolean = false): TDateTime;
function DateTimeToISO8601(dt: TDateTime; RosettaNetFormat: boolean = false): string;

function RFC3339StrToDateTimeUTC(dtStr: string): TDateTime;
function RFC3339StrToDateTimeLocal(dtStr: string): TDateTime;
function RFC3339StrToDateTime(dtStr: string): TDateTime;
function DateTimeToRFC3339Str(dt: TDateTime; UTCOffset: TDateTime): string;
function DateTimeLocalToRFC3339Str(dtLocal: TDateTime): string;

function GetUTCOffset: double;
function LocalToUTC(const aLocalTime: TDateTime): TDateTime;
function UTCToLocal(const aUTCTime: TDateTime): TDateTime;
function NowUTC: TDateTime;

function RFC2822StrToDateTime(const dtStr: string): TDateTime;
function IncQuarter(const Date: TDateTime; NumberOfQuarters: integer): TDateTime;
function GetMonthName(const MonthNo: integer): string;
function EndOfTheQuarter(const AValue: TDateTime): TDateTime;
function QuarterOf(const AValue: TDateTime): integer;

{ MySQL DateTime and Timestamp fields dont support milliseconds untill Ver 5.6.4 }
function CompareDateTimeNoMS(const A, B: TDateTime): TValueRelationship;

function StringToTime(const s: string): TDateTime;

Function Years(const Datefrom, Dateto:TDateTime):Double;
Function Months(const Datefrom, Dateto:TDateTime):Double;
Function Weeks(const Datefrom, Dateto:TDateTime):Double;
Function Days(const Datefrom, Dateto:TDateTime):Double;
Function Hours(const Datefrom, Dateto:TDateTime):Double;
function IncYears(Const value :TDatetime ; incValue :Double):Tdatetime;
function IncMonths(Const value :TDatetime ; incValue :Double):Tdatetime;
function IncWeeks(Const value :TDatetime ; incValue :Double):Tdatetime;
function IncDays(Const value :TDatetime ; incValue :Double):Tdatetime;

function MonthShortNameToInt(s: string): integer;
function MonthLongNameToInt(s: string): integer;
function DayShortNameToInt(s: string): integer;
function DayLongNameToInt(s: string): integer;
Function WeekDay(DayName :String) :Integer; overload;
Function WeekDay(DayNo :Integer) :String; overload;
Function Skipdays(CurDay, noofDays: Integer): Integer;
function TimezoneToStr: string;

// To store in the DB as enum type, we cannot rely on the system locale, so need to have these names persistent
type
  TMonthArray = array [0..11] of string;
const
  csMonths : TMonthArray = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

implementation

uses
  sysutils, DateUtils, StrUtils, IdGlobalProtocols, //ERPdbComponents,
  windows, DateTimeConvert;


function GetUTCOffset: double;
var
  TimeZone: TTimeZoneInformation;
begin
  GetTimeZoneInformation(TimeZone);
  result:=  -TimeZone.Bias * (1/24/60);
end;

function LocalToUTC(const aLocalTime: TDateTime): TDateTime;
begin
  result := aLocalTime - GetUTCOffset;
end;

function UTCToLocal(const aUTCTime: TDateTime): TDateTime;
begin
  result := aUTCTime + GetUTCOffset;
end;

function NowUTC: TDateTime;
begin
  result := LocalToUTC(Now);
end;

function CenturyOfDate(dt: TDateTime): word;
begin
  result:= StrToInt(Copy(FormatDateTime('yyyy',dt),1,2)+'00');
end;

function PreviousCentury(dt: TDateTime): word;
begin
  result:= CenturyOfDate(dt)-100;
end;

function StrToDateTimeFmt(const Format, Str: string): TDateTime;
//var
//  fmt: string;
//  year,month,day, hour, minute, second: word;
//  x: integer;
//  shortMonthName: string;
//  MonthFound: boolean;
//
//  function StrToIntErr(s, partName: string): word;
//  begin
//    try
//      result:= StrToInt(s);
//    except
//      on e: exception do begin
//        raise EConvertError.Create('Error converting ' + partName + ' part of date/time');
//      end;
//    end;
//  end;

begin
  result := TDateTimeConverter.StrToDateTimeFmt(Format, Str);
//  fmt:= Lowercase(Format);
//  hour:= 0;
//  minute:= 0;
//  second:= 0;
//  { year part }
//  x:= Pos('yyyy',fmt);
//  if x > 0 then
//    year:= StrToIntErr(Copy(Str,x,4),'year')
//  else begin
//    x:= Pos('yy',fmt);
//    if x > 0 then begin
//      year:= StrToIntErr(Copy(Str,x,2),'year');
//      if (year - 50) >= 0 then
//        year:= PreviousCentury(now) + year
//      else
//        year:= CenturyOfDate(now)  + year;
//    end
//    else
//     raise EConvertError.Create('Error converting date/time, year not specified');
//  end;
//  { month part }
//  x:= Pos('mmm',fmt);
//  if x > 0 then begin
//    shortMonthName := Copy(Str,x,3);
//    MonthFound := false;
//    for month := Low(FormatSettings.ShortMonthNames) to High(FormatSettings.ShortMonthNames) do begin
//      if SameText(shortMonthName, FormatSettings.ShortMonthNames[month]) then begin
//        MonthFound := true;
//        break;
//      end;
//    end;
//    if not MonthFound then
//      raise EConvertError.Create('Error converting date/time, month name not valid: ' + shortMonthName);
//  end
//  else begin
//    x:= Pos('mm',fmt);
//    if x > 0 then
//      month:= StrToIntErr(Copy(Str,x,2),'month')
//    else
//     raise EConvertError.Create('Error converting date/time, month not specified');
//  end;
//  { day part }
//  x:= Pos('dd',fmt);
//  if x > 0 then
//    day:= StrToIntErr(Copy(Str,x,2),'day')
//  else
//   raise EConvertError.Create('Error converting date/time, day not specified');
//  { hours }
//  x:= Pos('hh',fmt);
//  if x > 0 then
//    hour:= StrToIntErr(Copy(Str,x,2),'hours');
//  { minutes }
//  x:= Pos('nn',fmt);
//  if x > 0 then
//    minute:= StrToIntErr(Copy(Str,x,2),'minutes');
//  { seconds }
//  x:= Pos('ss',fmt);
//  if x > 0 then
//    second:= StrToIntErr(Copy(Str,x,2),'seconds');
//  if pos('pm',fmt) > 0 then begin
//    hour:= hour + 12;
//    if hour > 23 then
//      raise EConvertError.Create('Error converting date/time, invalid time');
//  end;
//  result:= EncodeDate(year,month,day) + EncodeTime(hour,minute,second,0);
end;

function StrToDateTimeFmt(const DateFormat, TimeFormat, Str: string): TDateTime;
//var
//  fmt: TFormatSettings;
//  sep: Char;
//
//  function GetSeparator(s: string): Char;
//  var
//    i: integer;
//  begin
//    result := #0;
//    for I := 1 to Length(s) do begin
//      if not CharInSet(s[i],['h','n','s','z','y','m','d','a','p','c','e']) then begin
//        result := s[i];
//        break;
//      end;
//    end;
//  end;

begin
  result := TDateTimeConverter.StrToDateTimeFmt(DateFormat +' '+TimeFormat, Str);

//  fmt := TFormatSettings.Create;
//  if DateFormat <> '' then begin
//    fmt.ShortDateFormat := DateFormat;
//    sep := GetSeparator(DateFormat);
//    if sep <> #0 then
//      fmt.DateSeparator := sep;
//  end;
//  if TimeFormat <> '' then begin
//    fmt.ShortTimeFormat := TimeFormat;
//    sep := GetSeparator(TimeFormat);
//    if sep <> #0 then
//      fmt.TimeSeparator := sep;
//  end;
//  result := StrToDateTimeDef(Str,0,fmt);
end;


function RoundTimeToMinutes(const dt: TDateTime): TDateTime;
var
  hour, min, sec, msec: word;
begin
  DecodeTime(dt,hour,min,sec,msec);
  if msec < 500 then
    msec := 0
  else begin
    sec := sec + 1;
    msec := 0;
  end;
  if sec < 30 then begin
    sec := 0;
    result := Trunc(dt) + EncodeTime(hour,min,sec,msec);
  end
  else begin
    sec := 0;
    result := IncMinute(Trunc(dt + EncodeTime(hour,min,sec,msec)));
  end;
end;

function MonthNameToNumber(const MonthName: string): integer;
begin
  if SameText(MonthName,'January') then result := 1
  else if SameText(MonthName,'February') then result := 2
  else if SameText(MonthName,'March') then result := 3
  else if SameText(MonthName,'April') then result := 4
  else if SameText(MonthName,'May') then result := 5
  else if SameText(MonthName,'June') then result := 6
  else if SameText(MonthName,'July') then result := 7
  else if SameText(MonthName,'August') then result := 8
  else if SameText(MonthName,'September') then result := 9
  else if SameText(MonthName,'October') then result := 10
  else if SameText(MonthName,'November') then result := 11
  else if SameText(MonthName,'December') then result := 12
  else result := 0;
end;

function MonthNumberToName(const MonthNo: integer): string;
begin
  case MonthNo of
    1: Result := 'January';
    2: Result := 'February';
    3: Result := 'March';
    4: Result := 'April';
    5: Result := 'May';
    6: Result := 'June';
    7: Result := 'July';
    8: Result := 'August';
    9: Result := 'September';
    10: Result := 'October';
    11: Result := 'November';
    12: Result := 'December';
  end;
end;

function FiscalYearStart(const aDate: TDateTime; const FiscalYearStartMonthName: string): TDateTime;
var
  tmpYear, tmpMonth, tmpDay: word;
begin
  DecodeDate(aDate, tmpYear, tmpMonth, tmpDay);
  if (tmpMonth < MonthNameToNumber(FiscalYearStartMonthName)) then tmpYear := tmpYear - 1;
  Result := EncodeDate(tmpYear, MonthNameToNumber(FiscalYearStartMonthName), 1);
end;

function PriorFiscalYearStart(const aDate: TDateTime; const FiscalYearStartMonthName: string): TDateTime;
var
  tmpYear, tmpMonth, tmpDay: word;
begin
  DecodeDate(aDate, tmpYear, tmpMonth, tmpDay);
  if (tmpMonth < MonthNameToNumber(FiscalYearStartMonthName)) then tmpYear := tmpYear - 1;
  tmpYear := tmpYear - 1;
  Result := EncodeDate(tmpYear, MonthNameToNumber(FiscalYearStartMonthName), 1);
end;

function LastFiscalYearEnd(const aDate: TDateTime; const FiscalYearStartMonthName: string): TDateTime;
begin
  Result := IncDay(FiscalYearStart(aDate,FiscalYearStartMonthName), -1);
end;

function ISO8601ToDateTime(val: string; ConvertToUTC: boolean): TDateTime;
var
  x: integer;
  IsUTC, datePart, timePart, offsetPart: boolean;
  dateStr, timeStr, offsetStr: string;
  year, month, day, hour, min, sec, msec: word;
  StrArray: TStringDynArray;
  posn: integer;
  offsetMins: integer;
begin
  IsUTC := false;
  dateStr := '';
  timeStr := '';
  offsetStr := '';
  datePart:= true;
  timePart:= false;
  offsetPart := false;
  year := 0;
  month := 0;
  day := 0;
  hour:= 0;
  min := 0;
  sec := 0;
  msec := 0;
  val := trim(val);
  if (val ='') or
     (val ='0') or
     (val ='0.0') or
     (val ='0.00') or
     (sametext(val ,'null')) then begin
      Result := 0;
      Exit;
    end;

  for x := 1 to Length(Val) do begin
    if CharInSet(Val[x],['z','Z']) then begin
      IsUTC := true;
    end
    else if CharInSet(Val[x],['t','T']) then begin
      datePart:= false;
      timePart:= true;
    end
    else if CharInSet(Val[x],['-','+']) then begin
      timePart:= false;
      offsetPart := true;
      offsetStr := Val[x];
    end
    else if Val[x] = '' then begin

    end
    else if datePart and CharInSet(Val[x],['0'..'9','-']) then begin
      dateStr := dateStr + Val[x]
    end
    else if timePart and CharInSet(Val[x],['0'..'9',':','.']) then begin
      timeStr := timeStr + Val[x]
    end
    else if offsetPart and CharInSet(Val[x],['0'..'9',':']) then begin
      offsetStr := offsetStr + Val[x]
    end
  end;
  if dateStr <> '' then begin
    if Pos('-',dateStr) > 0 then begin
      StrArray := SplitString(dateStr,'-');
      for x := 0 to High(StrArray) do begin
        case x of
          0: year := StrToInt(StrArray[x]);
          1: month := StrToInt(StrArray[x]);
          2: day := StrToInt(StrArray[x]);
        end;
      end;
    end
    else begin
      { no seperators in date }
      if Length(dateStr) < 6 then
        raise Exception.Create('ISO8601ToDateTime - Invalid date format in input string (' + Val + ')');
      year := StrToInt(Copy(dateStr,1,4));
      month := StrToInt(Copy(dateStr,5,2));
      if Length(dateStr) > 6 then
        day := StrToInt(Copy(dateStr,7,2));
    end;
  end;
  if timeStr <> '' then begin
    posn:= Pos('.', timeStr);
    if posn = 0 then
      posn:= Pos(',', timeStr);
    if posn > 0 then begin
      msec := StrToInt(Copy(timeStr,posn+1,Length(timeStr)));
      timeStr := Copy(timeStr,1,posn-1);
    end;
    if Pos(':',timeStr) > 0 then begin
      StrArray := SplitString(timeStr,':');
      for x := 0 to High(StrArray) do begin
        case x of
          0: hour := StrToInt(StrArray[x]);
          1: min := StrToInt(StrArray[x]);
          2: sec := StrToInt(StrArray[x]);
        end;
      end;
    end
    else begin
      { no seperators in time }
      if Length(dateStr) < 4 then
        raise Exception.Create('ISO8601ToDateTime - Invalid time format in input string (' + Val + ')');
      hour := StrToInt(Copy(timeStr,1,2));
      min := StrToInt(Copy(timeStr,3,2));
      if Length(dateStr) > 4 then
        sec := StrToInt(Copy(timeStr,5,2));
    end;
  end;
  result := EncodeDateTime(year,month,day,hour,min,sec,msec);
  if IsUtc then
    //result :=  result + TimeZoneBias;
    result :=  UTCToLocal(result)
  else if (offsetStr <> '') and ConvertToUTC then begin
    { concert to utc }
    offsetMins := (StrToInt(Copy(offsetStr,2,2)) * 60) + StrToInt(Copy(offsetStr,5,2));
    if Copy(offsetStr,0,1) = '+' then
      result := result - (offsetMins * OneMinute)
    else
      result := result + (offsetMins * OneMinute);
  end;
end;

function DateTimeToISO8601(dt: TDateTime; RosettaNetFormat: boolean = false): string;
var
  t: TDateTime;
begin
  //t := dt - TimeZoneBias;
  t :=  LocalToUTC(dt);//dt - GetUTCOffset;
  if RosettaNetFormat then
    result := FormatDateTime('yyyymmdd',t) + 'T' + FormatDateTime('hhnnss.zzz',t)+ 'Z'
  else
    result := FormatDateTime('yyyy-mm-dd',t) + 'T' + FormatDateTime('hh:nn:ss.zzz',t)+ 'Z';

end;


{ returns UTC }
function RFC2822StrToDateTime(const dtStr: string): TDateTime;
var
  list: TStringDynArray;
  year, month, day, hour, min, sec: word;
  s: string;
  aTime: TTime;
begin
  { "Thu, 31 Oct 2013 05:12:15 +0000" }
  result := 0;
  list := StrUtils.SplitString(dtStr,' ');
  if High(list) < 4 then exit;
  day := StrToInt(list[1]);
  year := StrToInt(list[3]);
  if SameText(list[2],'Jan') then
    month := 1
  else if SameText(list[2],'Feb') then
    month := 2
  else if SameText(list[2],'Mar') then
    month := 3
  else if SameText(list[2],'Apr') then
    month := 4
  else if SameText(list[2],'May') then
    month := 5
  else if SameText(list[2],'Jun') then
    month := 6
  else if SameText(list[2],'Jul') then
    month := 7
  else if SameText(list[2],'Aug') then
    month := 8
  else if SameText(list[2],'Sep') then
    month := 9
  else if SameText(list[2],'Oct') then
    month := 10
  else if SameText(list[2],'Nov') then
    month := 11
  else if SameText(list[2],'Dec') then
    month := 12
  else
    raise Exception.Create('RFC2822StrToDateTime - Invalid month value: "'+ list[2] + '"');
  s := list[4];
  hour := StrToInt(Copy(s,1,2));
  min := StrToInt(Copy(s,4,2));
  sec := StrToInt(Copy(s,7,2));

  result := EncodeDateTime(year,month,day,hour,min,sec,0);

  { adjust to UTC }
  if High(list) >= 5 then begin
    s:= list[5];
    hour := StrToInt(Copy(s,2,2));
    min := StrToInt(Copy(s,4,2));
    aTime:= EncodeTime(hour,min,0,0);
    if (aTime > 0) then begin
    if Copy(s,1,1) = '+' then
      result := result - aTime
    else if Copy(s,1,1) = '-' then
      result := result + aTime;
    end;
  end;

end;
function IncQuarter(const Date: TDateTime; NumberOfQuarters: integer): TDateTime;
begin
  Result := IncMonth(Date, NumberOfQuarters * 3);
end;
function GetMonthName(const MonthNo: integer): string;
begin
  case MonthNo of
    1: Result := 'Jan';
    2: Result := 'Feb';
    3: Result := 'Mar';
    4: Result := 'Apr';
    5: Result := 'May';
    6: Result := 'June';
    7: Result := 'July';
    8: Result := 'Aug';
    9: Result := 'Sep';
    10: Result := 'Oct';
    11: Result := 'Nov';
    12: Result := 'Dec';
  end;
end;
function EndOfTheQuarter(const AValue: TDateTime): TDateTime;
var
  Quarter: integer;
begin
  Quarter := QuarterOf(AValue);
  Result := AValue;
  case Quarter of
    1:  Result := EndOfTheMonth(IncMonth(AValue, 3 - MonthOf(AValue)));
    2:  Result := EndOfTheMonth(IncMonth(AValue, 6 - MonthOf(AValue)));
    3:  Result := EndOfTheMonth(IncMonth(AValue, 9 - MonthOf(AValue)));
    4:  Result := EndOfTheMonth(IncMonth(AValue, 12 - MonthOf(AValue)));
  end;
end;

function QuarterOf(const AValue: TDateTime): integer;
begin
  case MonthOfTheYear(aValue) of
    1,2,3: result := 1;
    4,5,6: result := 2;
    7,8,9: result := 3;
    10,11,12: result := 4;
    else
      raise Exception.Create('QuarterOf - invalid month number (' + IntToStr(MonthOfTheYear(aValue)) + ') for date ' + DateTimeToStr(AValue));
  end;
end;

{ returns UTC datetime }
{ Sample forrmats:
    2002-10-02T15:00:00Z
    2014-02-06T00:45:40.000Z
    2002-10-02T15:00:00.05Z
    2014-02-05T17:30:00+10:00
}
function RFC3339StrToDateTimeUTC(dtStr: string): TDateTime;
var
  s: string;
  mSec: word;
  offsetTime: TDateTime;
  posZ, posOffset: integer;
begin
  mSec := 0;
  offSetTime := 0;
  s := Copy(dtStr,20,Length(dtStr));
  if s[1] = '.' then           { remove m sec decilal point }
    s := Copy(s,2,Length(s));
  posZ := Pos('Z',s);
  if posZ > 0 then begin
    { UTC time }
    if posZ > 1 then
      mSec := StrToInt(Copy(s,1,posZ-1));
  end
  else begin
    posOffset := pos('+',s);
    if posOffset < 1 then
      posOffset := pos('+',s);

    if posOffset > 0 then begin
      if posOffset > 1 then begin
        mSec := StrToInt(Copy(s,1,posOffset-1));
        s:= Copy(s, posOffset, Length(s));
      end;
      { s is now off set part eg +10:00  }
      offsetTime := EncodeTime(StrToInt(Copy(dtStr,2,2)),StrToInt(Copy(dtStr,5,2)),0,0);
      if s[1] = '-' then
        offsetTime := - offsetTime;
    end;
  end;

  result :=
    EncodeDateTime(StrToInt(Copy(dtStr,1,4)),StrToInt(Copy(dtStr,6,2)),StrToInt(Copy(dtStr,9,2)),     {date}
      StrToInt(Copy(dtStr,12,2)),StrToInt(Copy(dtStr,15,2)),StrToInt(Copy(dtStr,15,2)),mSec);         {time}
  result := result - offsetTime; { convert to UTC }
end;

function RFC3339StrToDateTime(dtStr: string): TDateTime;
var
  s: string;
  mSec: word;
//  offsetTime: TDateTime;
  posZ, posOffset: integer;
begin
  if Trim(dtStr) = '' then begin
    result := 0;
    exit;
  end;
  mSec := 0;
//  offSetTime := 0;
  s := Copy(dtStr,20,Length(dtStr));
  if s[1] = '.' then           { remove m sec decilal point }
    s := Copy(s,2,Length(s));
  posZ := Pos('Z',s);
  if posZ > 0 then begin
    { UTC time }
    if posZ > 1 then
      mSec := StrToInt(Copy(s,1,posZ-1));
  end
  else begin
    posOffset := pos('+',s);
    if posOffset < 1 then
      posOffset := pos('+',s);

    if posOffset > 0 then begin
      if posOffset > 1 then begin
        mSec := StrToInt(Copy(s,1,posOffset-1));
        s:= Copy(s, posOffset, Length(s));
      end;
      { s is now off set part eg +10:00  }
//      offsetTime := EncodeTime(StrToInt(Copy(dtStr,2,2)),StrToInt(Copy(dtStr,5,2)),0,0);
//      if s[1] = '-' then
//        offsetTime := - offsetTime;
    end;
  end;

  result :=
    EncodeDateTime(StrToInt(Copy(dtStr,1,4)),StrToInt(Copy(dtStr,6,2)),StrToInt(Copy(dtStr,9,2)),     {date}
      StrToInt(Copy(dtStr,12,2)),StrToInt(Copy(dtStr,15,2)),StrToInt(Copy(dtStr,15,2)),mSec);         {time}
  if posZ > 0 then
  result := result + GetUTCOffset; { convert from UTC to local }
end;

function RFC3339StrToDateTimeLocal(dtStr: string): TDateTime;
begin
  result := RFC3339StrToDateTimeUTC(dtStr);
  result := result + GetUTCOffset;
end;

function DateTimeToRFC3339Str(dt: TDateTime; UTCOffset: TDateTime): string;
var
  hr,min,sec,msec: word;
  hrStr,minStr: string;
begin
  result := FormatDateTime('yyyy-mm-dd"T"hh:mm:ss"."zzz',dt);
//  result := FormatDateTime('yyyy-mm-dd"T"hh:mm:ss',dt);
  if UTCOffset = 0 then
    result := result + 'Z'
  else begin
    DecodeTime(Abs(UTCOffset),hr,min,sec,msec);
    hrStr := IntToStr(hr);
    while Length(hrStr) < 2 do
      hrStr := '0' + hrStr;
    minStr := IntToStr(min);
    while Length(minStr) < 2 do
      minStr := '0' + minStr;
    if UTCOffset < 0 then
      result := result + '-' + hrStr + ':' + minStr
    else
      result := result + '+' + hrStr + ':' + minStr;
  end;
end;

function DateTimeLocalToRFC3339Str(dtLocal: TDateTime): string;
begin
  result := DateTimeToRFC3339Str(dtLocal,GetUTCOffset);
end;

{ MySQL DateTime and Timestamp fields dont support milliseconds untill Ver 5.6.4 }
function CompareDateTimeNoMS(const A, B: TDateTime): TValueRelationship;
var
  yearA, monthA, dayA, hourA, minA, secA, msecA,
  yearB, monthB, dayB, hourB, minB, secB, msecB: word;

begin
  result := 0;
  DecodeDateTime(A,yearA,monthA,dayA,hourA,minA,secA,msecA);
  DecodeDateTime(B,yearB,monthB,dayB,hourB,minB,secB,msecB);
  if yearA > yearB then begin
    result := 1;
    exit;
  end
  else if yearA < yearB then begin
    result := -1;
    exit;
  end
  else if monthA > monthB then begin
    result := 1;
    exit;
  end
  else if monthA < monthB then begin
    result := -1;
    exit;
  end
  else if dayA > dayB then begin
    result := 1;
    exit;
  end
  else if dayA < dayB then begin
    result := -1;
    exit;
  end
  else if hourA > hourB then begin
    result := 1;
    exit;
  end
  else if hourA < hourB then begin
    result := -1;
    exit;
  end
  else if minA > minB then begin
    result := 1;
    exit;
  end
  else if minA < minB then begin
    result := -1;
    exit;
  end
  else if secA > secB then begin
    result := 1;
    exit;
  end
  else if secA < secB then begin
    result := -1;
    exit;
  end
end;

function StringToTime(const s: string): TDateTime;
var
  hrs,mins,secs,msecs,ampm: string;
  x: integer;
  part: integer;
begin
  part := 1;
  hrs := '';
  mins := '';
  secs := '';
  msecs := '';
  ampm := '';
  for x := 1 to Length(s) do begin
    if CharInSet(s[x],['0'..'9']) then begin
      case part of
        1: hrs := hrs + s[x];
        2: mins := mins + s[x];
        3: secs := secs + s[x];
        4: msecs := msecs + s[x];
      end;
    end
    else if CharInSet(s[x],[':','.']) and (part < 4) then begin
      Inc(part);
    end
    else if CharInSet(s[x],['a','A']) then begin
      ampm := 'am';
      break;
    end
    else if CharInSet(s[x], ['p','P']) then begin
      ampm := 'pm';
      break;
    end;
  end;
  result := EncodeTime(StrToIntDef(hrs,0),StrToIntDef(mins,0),StrToIntDef(secs,0),StrToIntDef(msecs,0));
  if ampm = 'pm' then
    result := result + 0.5;
end;


Function Years(const Datefrom, Dateto:TDateTime):Double;
var
  i:Integer;
begin
  i := yearsbetween(Datefrom, DateTo);
  if IncYear(Datefrom,i) = dateto then begin
      REsult := i;
      exit;
  end;
  result := i + Daysbetween(incyear(Datefrom, i) , dateto)/365;
  (*if i =0 then begin
    i := MonthsBetween(Datefrom, DateTo);
    if (i>=11) and (Incmonth(Datefrom,i) < dateto) then begin
        REsult := 1;
        exit;
    end else begin
      Result := 0;
      Exit;
    end;
  end;
  REsult := i;*)
end;
Function Months(const Datefrom, Dateto:TDateTime):Double;
var
  i:Integer;
begin
  i := Monthsbetween(Datefrom, DateTo);
  if IncMonth(Datefrom,i) = dateto then begin
      REsult := i;
      exit;
  end;
  result := i + Daysbetween(incMonth(Datefrom, i) , dateto)/30;
  (*if i =0 then begin
    i := WeeksBetween(Datefrom, DateTo);
    if (i>=4) and (IncWeek(Datefrom,i) < dateto) then begin
        REsult := 1;
        exit;
    end else begin
      Result := 0;
      Exit;
    end;
  end;
  REsult := i;*)
end;
Function Weeks(const Datefrom, Dateto:TDateTime):Double;
var
  i:Integer;
begin
  i := Weeksbetween(Datefrom, DateTo);
  if IncWeek(Datefrom,i) = dateto then begin
      REsult := i;
      exit;
  end;
  result := i + Daysbetween(incWeek(Datefrom, i) , dateto)/7;
  (*if i =0 then begin
    i := DaysBetween(Datefrom, DateTo);
    if (i>=7) and (IncDay(Datefrom,i) < dateto) then begin
        REsult := 1;
        exit;
    end else begin
      Result := 0;
      Exit;
    end;
  end;
  REsult := i;*)
end;
Function Days(const Datefrom, Dateto:TDateTime):Double;
var
  i:Integer;
begin
  i := Daysbetween(Datefrom, DateTo);
  if IncDay(Datefrom,i) = dateto then begin
      REsult := i;
      exit;
  end;
  result := i + HoursBetween(incDay(Datefrom, i) , dateto)/24;
  (*if i =0 then begin
    i := hoursBetween(Datefrom, DateTo);
    if (i>=23) and (Inchour(Datefrom,i) < dateto) then begin
        REsult := 1;
        exit;
    end;
    if i >= hoursBetween(AppEnv.CompanyPrefs.StartOfDay,AppEnv.CompanyPrefs.EndOfDay) then begin
        REsult := 1;
        exit;
    end else begin
      Result := 0;
      Exit;
    end;
  end;
  REsult := i;*)
end;

Function Hours(const Datefrom, Dateto:TDateTime):Double;
var
  i:Integer;
begin
  i := Hoursbetween(Datefrom, DateTo);
  if IncHour(Datefrom,i) = dateto then begin
      REsult := i;
      exit;
  end;
  if Datefrom<>  DateTo then begin
    REsult := i+1;
    Exit;
  end;
  Result := i;
end;

function IncYears(Const value :TDatetime ; incValue :Double):Tdatetime;
begin
   Result := incyear(Value , trunc(incValue));
   if  incValue =trunc(incValue) then exit;
   incValue := trunc((incValue - Trunc(IncValue))*365);
   Result := incDays(REsult , incValue);
end;

function IncMonths(Const value :TDatetime ; incValue :Double):Tdatetime;
begin
   Result := incmonth(Value , trunc(incValue));
   if  incValue =trunc(incValue) then exit;
   incValue := trunc((incValue - Trunc(IncValue))*30);
   Result := incDays(REsult , incValue);
end;

function IncWeeks(Const value :TDatetime ; incValue :Double):Tdatetime;
begin
   Result := incWeek(Value , trunc(incValue));
   if  incValue =trunc(incValue) then exit;
   incValue := trunc((incValue - Trunc(IncValue))*7);
   Result := incDays(REsult , incValue);
end;

function IncDays(Const value :TDatetime ; incValue :Double):Tdatetime;
begin
   Result := incDay(Value , trunc(incValue));
   if  incValue =trunc(incValue) then exit;
   incValue := trunc((incValue - Trunc(IncValue))*24);
   Result := IncHour(REsult , trunc(incValue));
end;

function MonthShortNameToInt(s: string): integer;
var
  x: integer;
begin
  result := 0;
  for x := Low(FormatSettings.ShortMonthNames) to High(FormatSettings.ShortMonthNames) do begin
    if SameText(FormatSettings.ShortMonthNames[x],s) then begin
      result := x;
      break;
    end;
  end;
  if result = 0 then
    raise Exception.Create('Invalid short month name "' + s + '"');
end;

function MonthLongNameToInt(s: string): integer;
var
  x: integer;
begin
  result := 0;
  for x := Low(FormatSettings.LongMonthNames) to High(FormatSettings.LongMonthNames) do begin
    if SameText(FormatSettings.LongMonthNames[x],s) then begin
      result := x;
      break;
    end;
  end;
  if result = 0 then
    raise Exception.Create('Invalid long month name "' + s + '"');
end;

function DayShortNameToInt(s: string): integer;
var
  x: integer;
begin
  result := 0;
  for x := Low(FormatSettings.ShortDayNames) to High(FormatSettings.ShortMonthNames) do begin
    if SameText(FormatSettings.ShortDayNames[x],s) then begin
      result := x;
      break;
    end;
  end;
  if result = 0 then
    raise Exception.Create('Invalid short day name "' + s + '"');
end;

function DayLongNameToInt(s: string): integer;
var
  x: integer;
begin
  result := 0;
  for x := Low(FormatSettings.LongDayNames) to High(FormatSettings.ShortMonthNames) do begin
    if SameText(FormatSettings.LongDayNames[x],s) then begin
      result := x;
      break;
    end;
  end;
  if result = 0 then
    raise Exception.Create('Invalid long day name "' + s + '"');
end;
Function WeekDay(DayNo :Integer) :String;
begin
    Result := '';
    Case DayNo of
        Daysunday   : Result := 'Sunday';
        Daymonday   : Result := 'Monday';
        Daytuesday  : Result := 'Tuesday';
        DayWedNesday: Result := 'Wednesday';
        DayThursday : Result := 'Thursday';
        DayFriday   : Result := 'Friday';
        DaySaturday : Result := 'Saturday';
    end;
end;
Function WeekDay(DayName :String) :Integer;
begin
    Result := 0;
    DayName := uppercase(DayName);
         if DayName = 'SUNDAY'      then Result := Daysunday
    else if DayName = 'MONDAY'      then Result := DayMonday
    else if DayName = 'TUESDAY'     then Result := Daytuesday
    else if DayName = 'WEDNESDAY'   then Result := DayWednesday
    else if DayName = 'THURSDAY'    then Result := DayThursday
    else if DayName = 'FRIDAY'      then Result := DayFriday
    else if DayName = 'SATURDAY'    then Result := DaySaturday;
end;
Function Skipdays(CurDay, noofDays: Integer): Integer;
begin
  if noofDays <0 then noofDays := 7+noofDays;
  REsult := CurDay+ noofDays;
  if result > 7 then REsult := Result -7;
end;

function TimezoneToStr: string;
var
  offset: double;
  offsetMins, offsetHours: integer;
begin
  offset := GetUTCOffset;
  if offset = 0 then begin
    result := '+00:00';
    exit;
  end;
  offsetMins := Round(Abs(offset) / OneMinute);
  if offsetMins > 60 then begin
    offsetHours := Trunc(offsetMins / 60);
    offsetMins := offsetMins - (offsetHours * 60);
  end
  else begin
    offsetHours := 0;
  end;
  result := FormatFloat('00',offsetHours) + ':' + FormatFloat('00',offsetMins);
  if offset < 0 then
    result := '-' + result
  else
    result := '+' + result;
end;

end.

