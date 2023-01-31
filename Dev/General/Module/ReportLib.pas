unit ReportLib;

interface

Function Date_Thismonth(IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
Function Datefrom_1_30 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
Function Datefrom_30_60(IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
Function Datefrom_60_90(IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;

Function Date_today (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
Function Date_1_7 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
Function Date_7_14 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
Function Date_14_21 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;

Function Date_1_30 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
Function Date_30_60 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
Function Date_60_90 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
Function DateformatStr(const Userformat:Boolean):String;
Function CurDateifIgnoredateRange(IgnoreDateRange:Boolean;dDate:TdateTime):TDatetime;


implementation

uses SysUtils, MySQLConst, dateutils , TransactionsTable , DateTimeUtils,
  SystemLib;

Function DateformatStr(const Userformat:Boolean):String;
begin
  if  Userformat then REsult := FormatSettings.shortdateformat else REsult := MysqlDateFormat;
end;
Function Date_Thismonth(IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),0)));end;
Function Datefrom_1_30 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-1)));end;
Function Datefrom_30_60(IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-2))) end;
Function Datefrom_60_90(IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-3))) end;

Function Date_today (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time));end;
Function Date_1_7 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),Incdays(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-7));end;
Function Date_7_14 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),Incdays(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-14));end;
Function Date_14_21 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),Incdays(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-21));end;

Function Date_1_30 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),Incdays(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-30));end;
Function Date_30_60 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),Incdays(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-60));end;
Function Date_60_90 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),Incdays(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-90));end;
Function CurDateifIgnoredateRange(IgnoreDateRange:Boolean;dDate:TdateTime):TDatetime;
begin
  if IgnoreDateRange  then result := Date
  else if dDate =  ERPListMaxDatetime then result := Date
  else  Result := dDate;
end;

end.
