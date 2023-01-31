unit RepeatDatesLib;

interface

Uses CalcRepeatDates;

Function IntToOnHoliday(const Value:Integer): TOnHoliday;
Function InttoPeriod   (const Value:Integer): TOfPeriod;
function InttoDateOfWeek(Const Value:Integer):TDayOfWeek;

Procedure DoCalcRepeatDates(Const aFrequency :Integer;
                            Const aPeriod :Integer;
                            Const aBaseDate, aFinalDate:TDatetime;
                            const aOnSaturday, aOnSunday,aOnMonday,aOnTuesday,aOnWednesday,aOnThursday,aOnFriday, aOnHoliday :Integer;
                            const aWeekday :Integer;
                            const amonthOffset:Integer;
                            var dates: TDates); Overload;

Procedure DoCalcRepeatDates(Const  aFrequency :Integer;
                            Const  aPeriod :TOfPeriod;
                            Const aBaseDate, aFinalDate:TDatetime;
                            const aOnSaturday, aOnSunday,aOnMonday,aOnTuesday,aOnWednesday,aOnThursday,aOnFriday, aOnHoliday :TOnHoliday;
                            const aWeekday :TDayOfWeek;
                            const amonthOffset:Integer;
                            var dates: TDates); Overload;



implementation

uses ERPdbComponents, DbSharedObjectsObj, CommonDbLib, sysutils, MySQLConst;
Procedure DoCalcRepeatDates(Const aFrequency :Integer;
                            Const aPeriod :Integer;
                            Const aBaseDate, aFinalDate:TDatetime;
                            const aOnSaturday, aOnSunday,aOnMonday,aOnTuesday,aOnWednesday,aOnThursday,aOnFriday, aOnHoliday :Integer;
                            const aWeekday :Integer;
                            const amonthOffset:Integer;
                            var dates: TDates);
begin
    DoCalcRepeatDates(aFrequency ,
                    InttoPeriod(aPeriod),
                    aBaseDate, aFinalDate,
                    IntToOnHoliday(aOnSaturday),
                    IntToOnHoliday(aOnSunday),
                    IntToOnHoliday(aOnMonday),
                    IntToOnHoliday(aOnTuesday),
                    IntToOnHoliday(aOnWednesday),
                    IntToOnHoliday(aOnThursday),
                    IntToOnHoliday(aOnFriday),
                    IntToOnHoliday(aOnHoliday),
                    InttoDateOfWeek(aWeekday),
                    amonthOffset,
                    dates);
end;


function InttoDateOfWeek(Const Value:Integer):TDayOfWeek;
begin
         if value =0 then result := doSU
    else if value =1 then result := doMo
    else if value =2 then result := doTu
    else if value =3 then result := doWE
    else if value =4 then result := doTH
    else if value =5 then result := doFR
    else if value =6 then result := doSA
    else if value =7 then result := doSOM
    else result := doEOM
end;
Function IntToOnHoliday(const Value:Integer): TOnHoliday;
begin
  if value = 0 then result := ohPost
  else if value =1 then REsult := ohDrop
  else if value =2 then REsult := ohShiftAfter
  else result := ohShiftBefore;
end;
Function InttoPeriod   (const Value:Integer): TOfPeriod;
begin
  if value = 0 then result := opDay
  else if value =1 then REsult := opWeek
  else result := opMonth;
end;

Procedure DoCalcRepeatDates(Const aFrequency: Integer;
                            Const aPeriod: TOfPeriod;
                            Const aBaseDate, aFinalDate: TDatetime;
                            const aOnSaturday, aOnSunday, aOnMonday,aOnTuesday, aOnWednesday, aOnThursday, aOnFriday, aOnHoliday: TOnHoliday;
                            const aWeekday :TDayOfWeek;
                            const amonthOffset:Integer;
                            var dates: TDates);
var
  CalcRepeatDates: TCalcRepeatDates;
  i: integer;
  qry: TERPQuery;
begin
  CalcRepeatDates := TCalcRepeatDates.Create;
  try
    with CalcRepeatDates do begin
      OfPeriod := aPeriod;
      every := aFrequency;
      DayOfWeek:= aWeekday;
      MonthOffset := aMonthOffset;
      BaseDate := aBaseDate;
      FinalDate := aFinalDate;

      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
        qry.SQL.Text := 'SELECT Day FROM tblpublicholidays ' +
                        ' WHERE Day BETWEEN '+ quotedstr(FormatDateTime(MysqlDateFormat, BaseDate))+
                        ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, FinalDate));
        qry.Open;
        Setlength(Holidays, qry.RecordCount);
        while not qry.Eof do begin
          Holidays[qry.RecNo - 1] := qry.FieldByName('Day').AsDateTime;
          qry.Next;
        end;
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;

      OnSaturday := aOnSaturday;
      OnSunday := aOnSunday;
      OnMonday := aOnMonday ;
      OnTuesday := aOnTuesday;
      OnWedNesDay := aOnWedNesDay;
      Onthursday := aOnthursday;
      OnFriday := aOnFriday ;
      OnHoliday := aOnHoliday;

      (*Setlength(dates, Length(ScheduledDates));

      for i := low(ScheduledDates) to high(ScheduledDates) do begin
        dates[i]:= ScheduledDates[i ];
      end;*)
      PopulateScheduledDates(dates);
    end;
  finally
    FreeAndNil(CalcRepeatDates);
  end;
end;

end.
