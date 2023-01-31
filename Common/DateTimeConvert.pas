unit DateTimeConvert;

interface

type
  TDtPartType = (ptUnknown, ptYear, ptMonth, ptDay, ptHour, ptMinute, ptSecond, ptmSecond, ptAmPm);

  TDtPart = class(TObject)
  private
    fValStr: string;
    fFormat: string;
    function GetPartType: TDtPartType;
    function GetValue: integer;
    function AllSameFmtChar(aChar: Char): boolean;
    function GetMaxLength: integer;
  public
    property Format: string read fFormat write fFormat;
    property ValStr: string read fValStr write fValStr;
    property PartType: TDtPartType read GetPartType;
    property Value: integer read GetValue;
    property MaxLength: integer read GetMaxLength;
  end;

  TDateTimeConverter = class
  private
    fFormat: string;
    fAsDateTime: TDateTime;
    fAsString: string;
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsString(const Value: string);
    procedure SetFormat(const Value: string);
    procedure ConverStrToDateTime;
    function GetAsString: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Format: string read fFormat write SetFormat;
    property AsString: string read GetAsString write SetAsString;
    property AsDateTime: TDateTime read fAsDateTime write SetAsDateTime;
    class function StrToDateTimeFmt(aFormat, aDateTime: string): TDateTime;
  end;

implementation

uses
  SysUtils, DateUtils, contnrs, Character, DateTimeUtils, Classes;


{ TDateTimeConverter }

procedure TDateTimeConverter.ConverStrToDateTime;
var
  list: TObjectList;
  x: integer;
  part: TDtPart;
  fmt: string;
  val: string;
  lastChar: char;
  idx: integer;
  year, month, day, hour, min, sec, msec: word;
  IsPM: boolean;

  function CurPart: TDtPart;
  begin
    result := TDtPart(list[idx]);
  end;

begin
  if (fFormat = '') or (fAsString = '') then exit;

  year := 0;
  month := 0;
  day := 0;
  hour := 0;
  min := 0;
  sec := 0;
  msec := 0;

  fmt := Lowercase(Format);
  list := TObjectList.Create;
  try
    { format .. }
    part := nil;
    for x := 1 to Length(fmt) do begin
      if CharInSet(fmt[x], ['d','m','y','h','n','s','z','a','p','/']) then begin
        if Assigned(part) then begin
          lastChar := part.Format[Length(part.Format)];
          if lastChar = fmt[x] then
            part.Format := part.Format + fmt[x]
          else if (lastChar = 'a') and (fmt[x] = 'm') then
            part.Format := part.Format + fmt[x]
          else if (lastChar = 'a') and (fmt[x] = '/') then
            part.Format := part.Format + fmt[x]
          else if (lastChar = '/') and (fmt[x] = 'p') then
            part.Format := part.Format + fmt[x]
          else if (lastChar = 'm') and (fmt[x] = 'p') then
            part.Format := part.Format + fmt[x]
          else if (lastChar = 'm') and (fmt[x] = '/') then
            part.Format := part.Format + fmt[x]
          else if (lastChar = 'p') and (fmt[x] = 'm') then
            part.Format := part.Format + fmt[x]
(*          else if (lastChar = 'y') and (fmt[x] = '/') then
            //part.Format := part.Format + fmt[x]
          else if (lastChar = 'd') and (fmt[x] = '/') then
            //part.Format := part.Format + fmt[x]*)
          else begin
            { new part }
            part := TDtPart.Create;
            part.Format := fmt[x];
            list.Add(part);
          end;
        end
        else begin
          part := TDtPart.Create;
          part.Format := fmt[x];
          list.Add(part);
        end;
      end;
    end;

    { data .. }
    val := Lowercase(fAsString);
    idx := 0;
    for x := 1 to Length(val) do begin
      if idx > list.Count -1 then
        raise Exception.Create('Invalid date/time format: "' + fAsString + '"');
//      lastChar := #0;
//      if CurPart.ValStr <> '' then
//        lastChar := CurPart.ValStr[Length(CurPart.ValStr)];

      if CharInSet(val[x], ['0'..'9','a'..'z']) then begin
        if (CurPart.MaxLength > 0) and (CurPart.MaxLength = Length(CurPart.ValStr)) then
          Inc(idx);
        CurPart.ValStr := CurPart.ValStr + val[x];
      end
      else
        Inc(idx);
    end;

    { now construct the result }
    IsPm := false;
    for idx := 0 to list.Count -1 do begin
      case CurPart.PartType of
        ptUnknown:
          raise Exception.Create('Error converting data time "' + fAsString + '" using format "' + fFormat + '"');
        ptYear: year := CurPart.Value;
        ptMonth: month := CurPart.Value;
        ptDay: day := CurPart.Value;
        ptHour: hour := CurPart.Value;
        ptMinute: min := CurPart.Value;
        ptSecond: sec := CurPart.Value;
        ptmSecond: msec := CurPart.Value;
        ptAmPm:
          begin
            if (CurPart.ValStr = 'pm') or (CurPart.ValStr = 'p') then
              IsPM := true;
          end;
      end;
    end;
    if IsPM then
      hour := hour + 12;
  finally
    list.Free;
  end;
  fAsDateTime := EncodeDateTime(year,month,day,hour,min,sec,msec);

end;

constructor TDateTimeConverter.Create;
begin

end;

destructor TDateTimeConverter.Destroy;
begin

  inherited;
end;

class function TDateTimeConverter.StrToDateTimeFmt(aFormat,
  aDateTime: string): TDateTime;
begin
  with TDateTimeConverter.Create do begin
    Format := aFormat;
    AsString := aDateTime;
    result := AsDateTime;
    Free;
  end;
end;

function TDateTimeConverter.GetAsString: string;
begin
  result := '';
  if fFormat = '' then exit;
  result := FormatDateTime(fFormat,fAsDateTime);
end;

procedure TDateTimeConverter.SetAsDateTime(const Value: TDateTime);
begin
  fAsDateTime := Value;
end;

procedure TDateTimeConverter.SetAsString(const Value: string);
begin
  fAsString := Value;
  ConverStrToDateTime;
end;

procedure TDateTimeConverter.SetFormat(const Value: string);
begin
  fFormat := Value;
  ConverStrToDateTime;
end;

{ TDtPart }

function TDtPart.AllSameFmtChar(aChar: Char): boolean;
var
  x: integer;
begin
  result := true;
  if fFormat = '' then begin
    result := false;
    exit;
  end;
  for x := 1 to Length(fFormat) do begin
    if fFormat[x] <> aChar then begin
      result := false;
      break;
    end;
  end;
end;

function TDtPart.GetMaxLength: integer;
begin
  result := 0;
  if (PartType = ptMonth) and (Length(fFormat) > 2) then exit;
  if (PartType = ptDay) and (Length(fFormat) > 2) then exit;
  result := Length(fFormat);
  if result = 1 then result := 2;
end;

function TDtPart.GetPartType: TDtPartType;
begin
  if AllSameFmtChar('y') then result := ptYear
  else if AllSameFmtChar('m') then result := ptMonth
  else if AllSameFmtChar('d') then result := ptday
  else if AllSameFmtChar('h') then result := ptHour
  else if AllSameFmtChar('n') then result := ptMinute
  else if AllSameFmtChar('s') then result := ptSecond
  else if AllSameFmtChar('z') then result := ptMSecond
  else if (fFormat = 'am/pm') or (fFormat = 'a/p') or (fFormat = 'ampm') then
    result := ptAmPm
  else
    result := ptUnknown;
end;

function TDtPart.GetValue: integer;
begin
  result := 0;
  case PartType of
    ptUnknown: ;
    ptYear:
      begin
        if fFormat = 'yy' then
          result := (StrToInt(Copy(FormatDateTime('yyyy',now),1,2))*100) + StrToInt(fValStr)
        else
          result := StrToInt(fValStr);
      end;
    ptMonth:
      begin
        if (fFormat = 'm') or (fFormat = 'mm') then
          result := StrToInt(fValStr)
        else if (fFormat = 'mmm') then
          result := MonthShortNameToInt(fValStr)
        else if (fFormat = 'mmmm') then
          result := MonthLongNameToInt(fValStr)
      end;
    ptDay:
      begin
        if (fFormat = 'd') or (fFormat = 'dd') then
          result := StrToInt(fValStr)
        else if (fFormat = 'ddd') then
          result := DayShortNameToInt(fValStr)
        else if (fFormat = 'dddd') then
          result := DayLongNameToInt(fValStr);
      end;
    ptHour,
    ptMinute,
    ptSecond,
    ptmSecond: result := StrToInt(fValStr);
    ptAmPm: ;
  end;
end;

end.
