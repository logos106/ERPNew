unit frmRosterDatePicker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, DNMSpeedButton, StdCtrls, wwdbdatetimepicker, ExtCtrls,
  DNMPanel, Menus;

type
  TDateMode = (tdmDaily =1, tdmWeekly =2, tdmMonthly =3);

  TfmRosterDatePicker = class(TfrmBaseGUI)
    pnlDate: TDNMPanel;
    dtpMonth: TwwDBDateTimePicker;
    btnPrev: TDNMSpeedButton;
    btnNext: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure dtpMonthChange(Sender: TObject);
  private
    fDateMode: TDateMode;
    fdStartDate: TDateTime;
    fOnDateChange: TNotifyEvent;
    procedure setDateMode(const Value: TDateMode);
    procedure setStartDate(const Value: TDateTime);
    function GetStartDate: TDateTime;
    function getMinDate: TdateTime;
    function getMaxdate: TdateTime;
    procedure setMindate(const Value: TdateTime);
    procedure setMaxdate(const Value: TdateTime);
    function getEndDate: TDateTime;
  public
    Property DateMode :TDateMode REad fDateMode write setDateMode;
    Property StartDate :TDateTime read GetStartDate write setStartDate;
    Property EndDate :TDateTime read getEndDate ;
    Property OnDateChange :TNotifyEvent read fOnDateChange write fOnDateChange;
    Property minDate :TdateTime read getMinDate write setMindate;
    Property Maxdate :TdateTime read getMaxdate write setMaxdate;

    Class Function MakeRosterDatePicker(AOwner:TComponent ; ParentPanel :TDNMPanel; aOnDateChange:TNotifyEvent; aAlign: TAlign = AlLeft;ShowDate:Boolean=False):TfmRosterDatePicker;
  end;

implementation

uses DateUtils;

{$R *.dfm}

{ TfmRosterDatePicker }


procedure TfmRosterDatePicker.setDateMode(const Value: TDateMode);
begin
  fDateMode := Value;

    if Value = tdmMonthly then begin
      dtpMonth.DisplayFormat := 'mmmm yyyy';
    end else if Value = tdmWeekly then begin
      dtpMonth.DisplayFormat := FormatSettings.ShortDateformat;
    end else if value = tdmDaily then begin
      //dtpMonth.DisplayFormat := 'dd mmmm yyyy';
      dtpMonth.displayFormat := FormatSettings.ShortDateformat;
    end;
    if dtpMonth.date=0 then setStartDate(fdStartDate);
end;



procedure TfmRosterDatePicker.btnNextClick(Sender: TObject);
begin
  inherited;
  if DateMode = tdmMonthly then begin
    dtpMonth.Date := incMonth(dtpMonth.Date , 1);
  end else if DateMode = tdmWeekly then begin
    dtpMonth.Date := incDay(dtpMonth.Date , 14);
  end else begin
    dtpMonth.Date := incday(dtpMonth.Date , 1);
  end;
  if Assigned(fOnDateChange) then fOnDateChange(dtpMonth);
end;

procedure TfmRosterDatePicker.btnPrevClick(Sender: TObject);
begin
  inherited;
  if DateMode = tdmMonthly then begin
    dtpMonth.Date := incMonth(dtpMonth.Date , -1);
  end else if DateMode = tdmWeekly then begin
    dtpMonth.Date := incDay(dtpMonth.Date , -14);
  end else begin
    dtpMonth.Date := incday(dtpMonth.Date , -1);
  end;
  if Assigned(fOnDateChange) then fOnDateChange(dtpMonth);
end;

procedure TfmRosterDatePicker.dtpMonthChange(Sender: TObject);
begin
  inherited;
  if Assigned(fOnDateChange) then fOnDateChange(dtpMonth);
end;

procedure TfmRosterDatePicker.FormCreate(Sender: TObject);
begin
  inherited;
  fdStartDate:= 0;
end;
procedure TfmRosterDatePicker.setMindate(const Value: TdateTime);
begin
  dtpMonth.mindate := Value;
end;
procedure TfmRosterDatePicker.setMaxdate(const Value: TdateTime);
begin
  dtpMonth.Maxdate := Value;
end;

function TfmRosterDatePicker.getMinDate: TdateTime;
begin
  result := dtpMonth.MinDate;
end;
function TfmRosterDatePicker.getEndDate: TDateTime;
begin
       if DateMode  = tdmMonthly then Result := Endoftheday(EndofThemonth(dtpMonth.date))
  else if DateMode  = tdmWeekly then Result := Endoftheday(incDay(dtpMonth.date , 14))
  else Result := Endoftheday(dtpMonth.date);
end;

function TfmRosterDatePicker.getMaxdate: TdateTime;
begin
  result := dtpMonth.Maxdate;
end;

function TfmRosterDatePicker.GetStartDate: TDateTime;
begin
       if DateMode  = tdmMonthly then Result := StartofThemonth(dtpMonth.date)
  else if DateMode  = tdmWeekly then Result := dtpMonth.date
  else Result := dtpMonth.date;
end;

class function TfmRosterDatePicker.MakeRosterDatePicker(AOwner: TComponent;ParentPanel: TDNMPanel; aOnDateChange:TNotifyEvent; aAlign: TAlign = AlLeft;ShowDate:Boolean=False): TfmRosterDatePicker;
begin
  REsult := TfmRosterDatePicker.Create(AOwner);
  Result.pnlDate.Parent:= ParentPanel;
  Result.pnlDate.Align := aAlign;
  Result.OnDateChange := aOnDateChange;
  Result.pnlDate.visible := ShowDate;
end;

procedure TfmRosterDatePicker.setStartDate(const Value: TDateTime);
begin
  if value =0 then
    dtpMonth.date := Date
  else
  dtpMonth.date := Value;
  if fdStartDate <> dtpMonth.date then fdStartDate := dtpMonth.date;
end;

end.
