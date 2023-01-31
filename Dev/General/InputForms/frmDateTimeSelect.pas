unit frmDateTimeSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, StdCtrls, ComCtrls, ExtCtrls, DNMPanel;

type

  TTimeInterval = (ti15Mins, ti30Mins, ti60Mins);

  TfmDateTimeSelect = class(TForm)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    MonthCalendar: TMonthCalendar;
    TimePicker: TDateTimePicker;
    lstTimes: TListBox;
    procedure MonthCalendarClick(Sender: TObject);
    procedure lstTimesClick(Sender: TObject);
    procedure TimePickerChange(Sender: TObject);
  private
    fTimeInterval: TTimeInterval;
    fDateTime: TDateTime;
    loading: boolean;
    fTimeStep: word;
    procedure SetDateTime(const Value: TDateTime);
    procedure SetTimeInterval(const Value: TTimeInterval);
    procedure SelectTime(aTime: TDateTime);
    function StrToTime(s: string): TDateTime;

    property TimeStep : word read fTimeStep write fTimeStep;
    Procedure DisplayTime;
    { Private declarations }
  public
    property DateTime: TDateTime read fDateTime write SetDateTime;
    property TimeInterval: TTimeInterval read fTimeInterval write SetTimeInterval;
  end;

  function SelectDateTime(var aDateTime: TdateTime; aInterval: TTimeInterval = ti30Mins): boolean;

implementation

uses
  DateUtils, CommonLib;

const
  TimeFormat = 'hh:nn am/pm';

{$R *.dfm}

function SelectDateTime(var aDateTime: TdateTime; aInterval: TTimeInterval = ti30Mins): boolean;
var
  form: TfmDateTimeSelect;
begin
  form := TfmDateTimeSelect.Create(nil);
  try
    form.TimeInterval := aInterval;
    form.DateTime := aDateTime;
    result := form.ShowModal = mrOk;
    if result then
      aDateTime := form.DateTime;
  finally
    form.Free;
  end;
end;

{ TfmDateTimeSelect }

procedure TfmDateTimeSelect.DisplayTime;
begin
  if not devmode then exit;
  Self.Caption := formatDateTime('dd-mm-yyyy hh:nn:ss' , fdateTime);
end;

procedure TfmDateTimeSelect.lstTimesClick(Sender: TObject);
begin
  if loading then exit;
  if lstTimes.ItemIndex < 0 then exit;

  fDateTime := Trunc(fDAteTime) + StrToTime(lstTimes.Items[lstTimes.ItemIndex]);
  TimePicker.Time := Frac(fDateTime); //   StrToTime(lstTimes.Items[lstTimes.ItemIndex]);
  DisplayTime;
end;

procedure TfmDateTimeSelect.MonthCalendarClick(Sender: TObject);
begin
  if loading then exit;
  fDateTime := Trunc(MonthCalendar.Date) + Frac(fDateTime);
  DisplayTime;
end;

procedure TfmDateTimeSelect.SelectTime(aTime: TDateTime);
var
//  s: string;
  idx, x: integer;
  dt1, dt2: TDateTime;
begin
//  s:= FormatDateTime(TimeFormat,aTime);
  loading := true;
  try
    //idx := lstTimes.Items.IndexOf(s);

    idx := -1;
    for x := 0 to lstTimes.Items.Count -1 do begin
      dt1 := StrToTime(lstTimes.Items[x]);
      if x < (lstTimes.Items.Count -1) then
        dt2 := StrToTime(lstTimes.Items[x+1])
      else
        dt2 := 0;

      if dt1 = Frac(aTime) then begin
        idx := x;
        break;
      end;
      if Frac(aTime) > dt1 then begin

        if dt2 > 0 then begin
          if Frac(aTime) <= dt2 then begin
            if (Frac(aTime) - dt1) < (dt2 - Frac(aTime)) then begin
              { closer to first time .. }
              idx := x;
              break;
            end
            else begin
              { closer to second time .. }
              idx := x+1;
              break;
            end;
          end;
        end
        else begin
          idx := x;
          break;
        end;
      end;
    end;
    if idx > -1 then
    begin
      lstTimes.Selected[idx] := true;
//      lstTimesClick(self);
      fDateTime := Trunc(fDAteTime) + StrToTime(lstTimes.Items[lstTimes.ItemIndex]);
      TimePicker.Time := Frac(fDateTime); //   StrToTime(lstTimes.Items[lstTimes.ItemIndex]);
    end;
//    TimePicker.Time := Frac(aTime);
  finally

  end;
  loading := false;
end;

procedure TfmDateTimeSelect.SetDateTime(const Value: TDateTime);
begin
  fDateTime := Value;
  loading := true;
  try
    if fDateTime <> 0 then begin
      MonthCalendar.Date := fDateTime;
      SelectTime(fDateTime);
    end;
  finally
    loading := false;
  end;
  DisplayTime;
end;

procedure TfmDateTimeSelect.SetTimeInterval(const Value: TTimeInterval);
var
  addTime: double;
  dt: TDateTime;
begin
  fTimeInterval := Value;
  lstTimes.Clear;
  case fTimeInterval of
    ti15Mins: addTime := DateUtils.OneMinute * 15 ;
    ti30Mins: addTime := DateUtils.OneMinute * 30 ;
    ti60Mins: addTime := DateUtils.OneMinute * 60 ;
    else addTime := DateUtils.OneMinute * 30;
  end;

  case fTimeInterval of
    ti15Mins: timeStep := 15;
    ti30Mins: TimeStep := 30;
    ti60Mins: TimeStep := 60;
    else
              TimeStep := 30;
  end;

  dt := 0;
  while dt < 1 do begin
    lstTimes.Items.Add(FormatDateTime(TimeFormat,dt));
    dt := dt + addTime;
  end;

end;

function TfmDateTimeSelect.StrToTime(s: string): TDateTime;
var
  hr, min: word;
begin
  hr := StrToInt(Copy(s,1,2));
  min := StrToInt(Copy(s,4,2));
  if Pos('am',s) > 0 then begin
    if hr = 12 then
      hr := 0;
  end
  else begin
    { pm }
    if hr < 12 then
      hr := hr + 12;
  end;
  result := EncodeTime(hr,min,0,0);
end;

procedure TfmDateTimeSelect.TimePickerChange(Sender: TObject);
var
  h,m,h1,m1 : word;
begin
  if loading then exit;
  h := hourof(fDateTime);
  h1 := HourOf(TimePicker.Time);
  m := MinuteOf(fDateTime);
  m1 := MinuteOf(TimePicker.Time);
  // Be careful
  // 12.00 -> 12.01 means Increment minutes by TimeStep => 12:30
  // 12:00 -> 12:59 means decrement minutes, so => 11:30
  // Decrement button in the picker's minutes does not decrement hours, only minutes
  if (h1 > h) or ((h1 = h) and (m1 > m) and ((m1-m) div TimeStep = 0)) then
  begin // new time greater than old
    if h1 > h then
      m1 := m   // increase hour
    else
    begin
      m1 := m + TimeStep;
      if m1 >= 60 then
      begin
        m1 := 0;
        h1 := h1 + 1;
      end;
    end;
  end
  else
  begin
    if h1 < h then
      m1 := m //m1 - TimeStep
    else
    begin
      if m=0 then
      begin
        m1 := 60 - TimeStep;
        h1 := h1 - 1;
      end
      else
        m1 := m - TimeStep;
    end;
  end;

  fDateTime := EncodeTime(h1, m1, 0, 0) + DateOf(fDateTime);
  SelectTime(fDateTime);
(*  as it was
  fDateTime := Trunc(fDateTime) + Frac(TimePicker.Time);
  SelectTime(fDateTime);
*)
  DisplayTime;
end;

end.
