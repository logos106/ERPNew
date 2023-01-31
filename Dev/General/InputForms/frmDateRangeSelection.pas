unit frmDateRangeSelection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, wwdbdatetimepicker, DNMPanel;

type
  TfmDateRangeSelection = class(TfrmBaseGUI)
    pnlDateRangeSelection: TDNMPanel;
    lblTo: TLabel;
    lblFrom: TLabel;
    chkIgnoreDates: TCheckBox;
    cboDateRange: TComboBox;
    dtFrom: TwwDBDateTimePicker;
    dtTo: TwwDBDateTimePicker;
    procedure FormCreate(Sender: TObject);
  private
    procedure SetHasIgnoreDateRange(const Value: Boolean);
    procedure SetHasCustomRangeOptions(const Value: Boolean);
    procedure setHasDateFrom(const Value: Boolean);
    procedure setHasDateTo(const Value: Boolean);
    function getDatefrom: TDateTime;
    function getDateTo: TDateTime;
    procedure SetDateFrom(const Value: TDateTime);
    procedure SetDateTo(const Value: TDateTime);
  public
    Property HasIgnoreDateRange :Boolean Write SetHasIgnoreDateRange;
    Property HasCustomRangeOptions :Boolean write SetHasCustomRangeOptions;
    Property HasDateFrom :Boolean write setHasDateFrom;
    Property HasDateTo :Boolean write setHasDateTo;
    Property DateFrom : TDateTime read getDatefrom write SetDateFrom;
    Property DateTo : TDateTime read getDateTo write SetDateTo;
  end;

Function DateRangeSelection(Owner :TForm;aParent : TWinControl; aPoint :TPoint; dDateFrom:TDatetime =0; dDateTo:TDateTime =0):TfmDateRangeSelection;

implementation

uses dateutils, AppEnvironment;

{$R *.dfm}

{ TfmDateRangeSelection }
Function DateRangeSelection(Owner :TForm;aParent : TWinControl; aPoint :TPoint; dDateFrom:TDatetime =0; dDateTo:TDateTime =0):TfmDateRangeSelection;
begin
  Result := TfmDateRangeSelection.create(Owner);
  Result.pnlDateRangeSelection.parent   := aParent;
  Result.pnlDateRangeSelection.Left     := aPoint.x;
  Result.pnlDateRangeSelection.top      := aPoint.y;
  Result.pnlDateRangeSelection.Visible  := True;
  if (dDateFrom <>0) and (dDateTo > dDateFrom) then Result.dtFrom.date  := dDateFrom;
  if (dDateTo   <>0) and (dDateTo > dDateFrom) then Result.dtTo.date    := dDateTo;
end;
procedure TfmDateRangeSelection.FormCreate(Sender: TObject);
begin
  inherited;
  dtFrom.Date := Date +1;
  dtTo.Date := Date + 7;
  (*if (AppEnv.Employee.ListDaysFuture <>0)  then begin
    dtTo.Date := Date + AppEnv.Employee.ListDaysFuture ;
  end else begin
    dtTo.Date := Date + 8;
  end;*)
end;

function TfmDateRangeSelection.getDatefrom: TDateTime;
begin
  Result := dateof(dtFrom.DateTime);
    if not(dtFrom.visible) then Result:= 0
    else if chkIgnoreDates.Visible then
      if chkIgnoreDates.Checked then
        Result:= 0;
end;

function TfmDateRangeSelection.getDateTo: TDateTime;
begin
  Result := IncSecond(IncDay(dateof(dtTo.DateTime), 1), -1);
  if not(dtTo.visible) then Result:= MaxDateTime
  else if chkIgnoreDates.Visible then
    if chkIgnoreDates.Checked then
      Result:= MaxDateTime;

end;

procedure TfmDateRangeSelection.SetDateFrom(const Value: TDateTime);
begin
  dtfrom.Date := Value;
end;

procedure TfmDateRangeSelection.SetDateTo(const Value: TDateTime);
begin
    dtTo.Date := Value;
end;

procedure TfmDateRangeSelection.SetHasCustomRangeOptions(const Value: Boolean);begin  cboDateRange.Enabled  := Value;end;
procedure TfmDateRangeSelection.SetHasIgnoreDateRange   (const Value: Boolean);begin  chkIgnoreDates.Enabled:= Value;end;
procedure TfmDateRangeSelection.setHasDateFrom          (const Value: Boolean);begin  lblFrom.Enabled       := Value;dtFrom.Enabled:= Value;end;
procedure TfmDateRangeSelection.setHasDateTo            (const Value: Boolean);begin  lblto.Enabled         := Value;dtTo.Enabled  := Value;end;

end.
