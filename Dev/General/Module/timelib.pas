unit timelib;

interface

uses DBCtrls,StdCtrls;

  procedure LocateTime(Sender: TObject; timeValue: String);
  function ValidStrToTime(const S: string): TDateTime;
  function minToHours(Const value:Integer):String;
  function Day1:Integer;
  function Day2:Integer;
  function Day3:Integer;
  function Day4:Integer;
  function Day5:Integer;
  function Day6:Integer;
  function Day7:Integer;
  function DayToDayName(const Dayno:Integer):String;
  function DayToDayLongame(const Dayno:Integer):String;
  Procedure PopulateTimecombo(Sender:TDBCombobox);overload;
  Procedure PopulateTimecombo(Sender:TCombobox);overload;

implementation

uses  SysUtils,  Wwdbcomb , DateUtils,
   BusObjRegionalOptions, CommonDbLib, MySQLConst, AppEnvironment;


function ValidStrToTime(const S: string): TDateTime;
begin
  result := 0;
  if Length(S) < 7 then exit;
    Result := StrToTime(S);
end;

procedure LocateTime(Sender: TObject; timeValue: String);
var
  dtimeValue:TDAtetime;
  i:Integer;
begin
  if timeValue = '' then exit;
  if sender is Tdbcombobox then begin
     if TDBComboBox(Sender).Items.Count = 0 then exit;

     if Tdbcombobox(sender).Items.Indexof(timevalue)>=0 then begin
          TDBComboBox(Sender).itemindex := Tdbcombobox(sender).Items.Indexof(timevalue);
            exit;
     end;
     try
      dtimeValue :=ValidStrToTime(timeValue);
        for i := 0 to TDBComboBox(Sender).Items.Count-1 do
          if dtimeValue = ValidStrToTime(TDBComboBox(Sender).Items[i]) then exit
          else if dtimeValue < ValidStrToTime(TDBComboBox(Sender).Items[i]) then begin
            TDBComboBox(Sender).itemindex := i;
            exit;
          end;
        TDBComboBox(Sender).itemindex :=TDBComboBox(Sender).Items.Count-1;
      except

      end;
  end else if sender is twwDBCombobox then begin
     if twwDBCombobox(Sender).Items.Count = 0 then exit;
     try
        for i := 0 to twwDBCombobox(Sender).Items.Count-1 do
          if timeValue = twwDBCombobox(Sender).Items[i] then begin
            twwDBCombobox(Sender).itemindex := i;
            break;
          end;
      except
      end;
  end else if Sender is Tcombobox then begin
     if TCombobox(Sender).Items.Count = 0 then exit;
     try
        for i := 0 to TCombobox(Sender).Items.Count-1 do
          if timeValue = TCombobox(Sender).Items[i] then begin
            TCombobox(Sender).itemindex := i;
            break;
          end;
      except
      end;
  end;
end;

function minToHours(Const value:Integer):String;
begin
    if Value =trunc((Value)/60)*60 then
      result := IntToStr(trunc((Value)/60))+'h '
    else if Value - trunc((Value)/60)*60 = 59 then
      result := IntToStr(trunc((Value)/60)+1)+'h '
    else if Value - trunc((Value)/60)*60 = 29 then
      result := IntToStr(trunc((Value)/60))+'h '  + '30 m'
    else result := IntToStr(trunc((Value)/60))+'h '  + IntToStr(Value - trunc((Value)/60)*60)+'m';
end;

function Day1:Integer; begin result := appenv.RegionalOptions.WeekStartDay; end;
function Day2:Integer;begin result := Day1+1 ; if result >7 then result := 1; end;
function Day3:Integer;begin result := Day2+1 ; if result >7 then result := 1; end;
function Day4:Integer;begin result := Day3+1 ; if result >7 then result := 1; end;
function Day5:Integer;begin result := Day4+1 ; if result >7 then result := 1; end;
function Day6:Integer;begin result := Day5+1 ; if result >7 then result := 1; end;
function Day7:Integer;begin result := Day6+1 ; if result >7 then result := 1; end;

function DayToDayName(const Dayno:Integer):String;
begin
    case Dayno of
      DayMonday   :Result := 'Mon';
      DayTuesday  :Result := 'Tue';
      DayWednesday:Result := 'Wed';
      DayThursday :Result := 'Thu';
      DayFriday   :Result := 'Fri';
      DaySaturday :Result := 'Sat';
      DaySunday   :Result := 'Sun';
      else Result := '';
    end;
end;
function DayToDayLongame(const Dayno:Integer):String;
begin
    case Dayno of
      DayMonday   :Result := 'Monday';
      DayTuesday  :Result := 'Tuesday';
      DayWednesday:Result := 'Wednesday';
      DayThursday :Result := 'Thursday';
      DayFriday   :Result := 'Friday';
      DaySaturday :Result := 'Saturday';
      DaySunday   :Result := 'Sunday';
      else Result := '';
    end;
end;

Procedure PopulateTimecombo(Sender:TDBCombobox);
var
  tdTime: TTime;
  lStr:String;
begin
  with TempMyquery do try
    SQL.add('SELECT * FROM tbltimeinc Where EmployeeID= ' +inttostr(AppEnv.Employee.EmployeeID));
    open;
    if not (Eof and bof) then begin
      Sender.Items.Clear;
      tdTime := StrToTime('00:00');
      while (tdTime <= 1) do begin
        if tdTime = 1 then tdTime := EndOfTheDay(0);
        lStr := FormatDateTime(MysqlTimeFormat12hr, tdTime);
        Sender.Items.Add(lStr);
        tdTime := IncMinute(tdTime, FieldByName('TimeInc').AsInteger);
      end;
    end;
  finally
    ClosenFree;
  end;
end;
Procedure PopulateTimecombo(Sender:TCombobox);
var
  tdTime: TTime;
  lStr:String;
begin
  with TempMyquery do try
    SQL.add('SELECT * FROM tbltimeinc Where EmployeeID= ' +inttostr(AppEnv.Employee.EmployeeID));
    open;
    if not (Eof and bof) then begin
      Sender.Items.Clear;
      tdTime := StrToTime('00:00');
      while (tdTime <= 1) do begin
        if tdTime = 1 then tdTime := EndOfTheDay(0);
        lStr := FormatDateTime(MysqlTimeFormat12hr, tdTime);
        Sender.Items.Add(lStr);
        tdTime := IncMinute(tdTime, FieldByName('TimeInc').AsInteger);
      end;
    end;
  finally
    ClosenFree;
  end;
end;

end.
