unit SalesDashBoardReminder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashBoardReminder, Menus, ExtCtrls, DNMPanel, StdCtrls, db;

type
  TSalesDashBoardReminderGUI = class(TDashBoardReminderGUI)
    a2: TLabel;
    a3: TLabel;
    a4: TLabel;
    a5: TLabel;
    a6: TLabel;
    a7: TLabel;
    a8: TLabel;
    a9: TLabel;
    a10: TLabel;
    a11: TLabel;
    a12: TLabel;
    a13: TLabel;
    a14: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    a1: TLabel;
    procedure FormCreate(Sender: TObject);
  private

  Protected
    procedure Showreminderentry(const ds: TDataset); override;
    procedure HideAll;override;
    Procedure resetlabels(Seqno, labeltop:Integer);Override;
  public
    Procedure RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean); overload;override;
  end;

implementation

uses CommonLib;

{$R *.dfm}

{ TSalesDashBoardReminderGUI }

procedure TSalesDashBoardReminderGUI.FormCreate(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  for ctr := 1 to 14 do
    Labels[ctr, 3] := TLabel(findcomponent('a' + Trim(IntToStr(ctr))));
end;

procedure TSalesDashBoardReminderGUI.RefreshQuery(Const EmployeeID:Integer; DateFrom, DateTo:TDateTime; ignoreDates:Boolean);
begin
  inherited RefreshQuery(EmployeeId, dateFrom, DateTo,ignoredates);
  fiemployeeID:= EmployeeID;
  fballemployees:=EmployeeID=0;
  RefreshQuery;
(*  q1.Visible := True;
  q1.Top := 26;
  q1.Left := 71;*)
end;

procedure TSalesDashBoardReminderGUI.resetlabels(Seqno, labeltop: Integer);
begin
  inherited resetlabels(Seqno, labeltop);
  Labels[seqno , 3].Top := Labeltop;
end;

procedure TSalesDashBoardReminderGUI.Showreminderentry(const ds: TDataset);
begin
  inherited;
  if ds.fieldByname('Indays').asFloat = 0 then Labels[seqno , 3].caption := '0' else Labels[seqno , 3].caption := floatTostr(Round(ds.fieldByname('Indays').asFloat, 0));
  Labels[seqno , 3].Visible := true;
end;

procedure TSalesDashBoardReminderGUI.HideAll;
var
  ctr:Integer;
begin
  inherited;
  for ctr:= low(Labels) to high(Labels) do begin
    Labels[ctr,3].visible := False;
  end;
end;

initialization
  RegisterClassOnce(TSalesDashBoardReminderGUI);

end.

