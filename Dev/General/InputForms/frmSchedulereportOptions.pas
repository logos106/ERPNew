unit frmSchedulereportOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmRepeat, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, ComCtrls, StdCtrls, Spin, Shader,
  DNMPanel, DNMSpeedButton, BaseFormForm, wwdbdatetimepicker;

type
  TRepeatFrequency = (rfDay=1, rfWeek=2, rfMonth=3);
  TfmSchedulereportOptions = class(TRepeatFrm)
    chkIndefinit: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure dtFinalDateEnter(Sender: TObject);
    procedure chkIndefinitClick(Sender: TObject);
  private
    function getRepeatFrequency: TRepeatFrequency;
    procedure SetRepeatFrequency(const Value: TRepeatFrequency);
    function RepeatFrequencyToItemindex(Const Value :TRepeatFrequency):Integer;
    function ItemindextoRepeatFrequency(Const Value :Integer):TRepeatFrequency;
    function getEvery: Integer;
    procedure setEvery(const Value: Integer);
    function getRepeatWeekDay: Integer;
    procedure setRepeatWeekDay(const Value: Integer);
    function getBeginFromOption: String;
    procedure setBeginFromOption(const Value: String);
    function egtMonthDays: Integer;
    procedure setMonthDays(const Value: Integer);
    function getStartDate: TDateTime;
    function getEndDate: TDateTime;
    procedure setStartDate(const Value: TDateTime);
    procedure setEndDate(const Value: TDateTime);
    function getHolidayAction: String;
    function getSatAction: String;
    function getsunAction: String;
    procedure setHolidayAction(const Value: String);
    procedure setSatAction(const Value: String);
    procedure setsunAction(const Value: String);
    function DaysActionTostr(const Value: Integer): String;
    function strToDaysAction(Value: String): Integer;
    function getContinueIndefinitely: Boolean;
    procedure setContinueIndefinitely(const Value: Boolean);
   Protected
      procedure initform;Override;
   public
    Property RepeatFrequency : TRepeatFrequency Read getRepeatFrequency Write SetRepeatFrequency;
    Property Every :Integer read getEvery Write setEvery;
    Property RepeatWeekDay :Integer read getRepeatWeekDay write setRepeatWeekDay;
    Property BeginFromOption :String read getBeginFromOption write setBeginFromOption;
    Property MonthDays :Integer read egtMonthDays write setMonthDays;
    Property StartDate :TDateTime read getStartDate write setStartDate;
    Property EndDate :TDateTime read getEndDate write setEndDate;
    Property SatAction :String read getSatAction write setSatAction;
    Property sunAction :String read getsunAction write setsunAction;
    Property HolidayAction :String read getHolidayAction Write setHolidayAction;
    Property ContinueIndefinitely :Boolean read getContinueIndefinitely write setContinueIndefinitely;
  end;


implementation

uses CommonLib;

{$R *.dfm}
function TfmSchedulereportOptions.RepeatFrequencyToItemindex(const Value: TRepeatFrequency): Integer;
begin
  if Value = rfDay then result := 0
  else if Value = rfWeek  then result := 1
  else result := 2;
end;
function TfmSchedulereportOptions.ItemindextoRepeatFrequency(const Value: Integer): TRepeatFrequency;
begin
  if Value = 0 then result := rfDay
  else if Value = 1  then result := rfWeek
  else result := rfMonth;
end;

function TfmSchedulereportOptions.getStartDate: TDateTime;begin  Result:= dtBaseDate.Date;end;

function TfmSchedulereportOptions.getEndDate: TDateTime;begin  Result:= dtFinalDate.Date;end;
function TfmSchedulereportOptions.getRepeatFrequency: TRepeatFrequency;begin  Result := ItemindextoRepeatFrequency(rgFrequency.ItemIndex );end;
function TfmSchedulereportOptions.getRepeatWeekDay: Integer;begin  result := cbWeekday.ItemIndex;end;
function TfmSchedulereportOptions.getBeginFromOption: String;begin   if Sametext(cbMonthBeginEnd.text , 'Begin of Month plus') then result := 'S' else result := 'E';end;
function TfmSchedulereportOptions.getContinueIndefinitely: Boolean;begin  result:= chkIndefinit.checked;end;

function TfmSchedulereportOptions.egtMonthDays: Integer;begin  result:= seMonthDays.Value;end;
procedure TfmSchedulereportOptions.FormCreate(Sender: TObject);
begin
  inherited;
  StartBaseDate := Now;
end;

procedure TfmSchedulereportOptions.SetRepeatFrequency(const Value: TRepeatFrequency);begin  rgFrequency.ItemIndex := RepeatFrequencyToItemindex(Value);end;
procedure TfmSchedulereportOptions.setBeginFromOption(const Value: String);begin   if Value = 'S' then cbMonthBeginEnd.text := 'Begin of Month plus' else cbMonthBeginEnd.text := 'End of Month minus';end;
procedure TfmSchedulereportOptions.setContinueIndefinitely(const Value: Boolean);begin  chkIndefinit.checked := Value;end;

procedure TfmSchedulereportOptions.setMonthDays(const Value: Integer);begin  seMonthDays.value := value;end;
procedure TfmSchedulereportOptions.setRepeatWeekDay(const Value: Integer);begin  cbWeekday.ItemIndex := Value;end;

procedure TfmSchedulereportOptions.setStartDate(const Value: TDateTime);begin  dtBaseDate.Date := Value;end;

procedure TfmSchedulereportOptions.setEndDate(const Value: TDateTime);begin  dtFinalDate.Date := Value;end;
function TfmSchedulereportOptions.getEvery: Integer;begin
       if RepeatFrequency = rfday then result := seDayDays.Value
  else if RepeatFrequency = rfweek then result := seWeekDays.Value
  else result := seMonthMonths.Value;
end;


procedure TfmSchedulereportOptions.setEvery(const Value: Integer);
begin
       if RepeatFrequency = rfday then seDayDays.Value := Value
  else if RepeatFrequency = rfweek then seWeekDays.Value := Value
  else seMonthMonths.Value := Value;
end;
procedure TfmSchedulereportOptions.chkIndefinitClick(Sender: TObject);
begin
  inherited;
    if screen.ActiveControl =dtFinalDate then SetControlFocus(chkIndefinit);
    dtFinalDate.Enabled:= False;
end;

function TfmSchedulereportOptions.DaysActionTostr(Const Value :Integer):String;
begin
       if Value =0 then result :='P'
  else if Value =1 then result :='D'
  else if Value =2 then result :='A'
  else if Value =3 then result :='F'
  else result := '';
end;
procedure TfmSchedulereportOptions.dtFinalDateEnter(Sender: TObject);
begin
  inherited;
  if ContinueIndefinitely then begin
    SetControlFocus(chkIndefinit);
    dtFinalDate.Enabled:= False;
  end;
end;

function  TfmSchedulereportOptions.strToDaysAction(Value:String):Integer;
begin
       if Value ='P' then result :=0
  else if Value ='D' then result :=1
  else if Value ='A' then result :=2
  else if Value ='B' then result :=3
  else result := -1;
end;
function  TfmSchedulereportOptions.getHolidayAction : String; begin Result := DaysActionTostr(rgHoliday.ItemIndex)  ; end;
function  TfmSchedulereportOptions.getSatAction     : String; begin Result := DaysActionTostr(rgSaturday.ItemIndex) ;end;
function  TfmSchedulereportOptions.getsunAction     : String; begin Result := DaysActionTostr(rgSunday.ItemIndex)   ;end;
procedure TfmSchedulereportOptions.initform;
begin
  inherited;
end;

procedure TfmSchedulereportOptions.setHolidayAction (const Value: String); begin rgHoliday.itemindex  :=strToDaysAction(Value); end;
procedure TfmSchedulereportOptions.setSatAction     (const Value: String); begin rgSaturday.itemindex :=strToDaysAction(Value); end;
procedure TfmSchedulereportOptions.setsunAction     (const Value: String); begin rgSunday.itemindex   :=strToDaysAction(Value); end;

initialization
  RegisterClassOnce(TfmSchedulereportOptions);
end.

