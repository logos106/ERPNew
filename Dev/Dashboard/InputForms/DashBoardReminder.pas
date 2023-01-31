unit DashBoardReminder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DashBoardBase, ExtCtrls, DNMPanel, StdCtrls, Menus , db,
  SelectionDialog;

type
  TDashBoardReminderGUI = class(TDashBoardBaseGUI)
    d1:Tlabel;d2:Tlabel;d3:Tlabel;d4:Tlabel;d5:Tlabel;d6:Tlabel;d7:Tlabel;d8:Tlabel;d9:Tlabel;d10:Tlabel;d11:Tlabel;d12:Tlabel;d13:Tlabel;d14:Tlabel;q2:Tlabel;q3:Tlabel;q4:Tlabel;q5:Tlabel;q6:Tlabel;q7:Tlabel;q8:Tlabel;q9:Tlabel;q10:Tlabel;q11:Tlabel;q12:Tlabel;q13:Tlabel;q14:Tlabel;
    q1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    tablename :String;
    procedure resetlabels(const entries: Integer);Overload;

  Protected
      Labels :Array [1..14] of array [1..3] of TLabel ;
     fballemployees:Boolean;
     procedure Showreminderentry(const ds: TDataset);virtual;
     Procedure HideAll; virtual;
     Procedure resetlabels(Seqno, labeltop:Integer);Overload;virtual;
  public
    Procedure RefreshQuery; override;
  end;

implementation

uses CommonLib, CommonDbLib, FastFuncs, ERPdbComponents, AppEnvironment,
   ReminderList;

{$R *.dfm}

{ TDashBoardBaseGUI1 }
Procedure TDashBoardReminderGUI.resetlabels(Seqno, labeltop:Integer);
begin
          Labels[seqno , 1].Top := Labeltop;
          Labels[seqno , 2].Top := Labeltop;
end;

Procedure TDashBoardReminderGUI.resetlabels(const entries:Integer);
var
  ctr:Integer;
  fitop:Integer;
  fiGap :Integer;
begin
  fitop:= d1.top;
  fiGap := trunc((pnlDetails.Height - fitop) / entries);
  (*if entries*(Labels[1 , 1].height+1) < (pnlDetails.Height - fitop) then fiGap :=1*)
  if fiGap > d1.height +1 then fiGap := d1.height +1;
  for ctr:= 1 to entries do begin
    resetlabels(ctr , fitop);
    fitop := fitop + figap;
  end;
end;

procedure TDashBoardReminderGUI.RefreshQuery;
var
  Qry:TERPQuery;
begin
  HideAll;
  //tablename := TRemindersListGUI.PopulateTable(fbAllEmployees, fiemployeeID);
  tablename := TReminderListGUI.PopulateTable(fbAllEmployees, fiemployeeID);
  Qry := commondbLib.TempMyQuery;
  try
    with Qry do begin
        SQL.add('SELECT Type,count(ID) as ctr , avg(abs(`In Days`)) as Indays from ' +tablename + ' group by type   ' );
        open;
        if recordcount = 0 then begin
          Exit;
        end;
        First;
        SEQNo:= 1;
        while (Eof = False) and (Seqno<14) do begin
          Seqno:= Recno;
          Showreminderentry(Qry);
          next;
        end;
        resetlabels(recordcount);
    end;
  finally
      if Qry.active then Qry.close;
      Qry.free;
  end;
  inherited;
end;
Procedure TDashBoardREminderGUI.Showreminderentry(const ds:TDataset);
begin
          Labels[seqno , 1].caption :=ds.fieldByname('type').asString;
          Labels[seqno , 2].caption :=ds.fieldByname('ctr').asString;
          Labels[seqno , 1].Visible := true;
          Labels[seqno , 2].Visible := true;
end;
procedure TDashBoardReminderGUI.FormCreate(Sender: TObject);
var
  ctr:Integer;
begin
  inherited;
  fiemployeeID:=Appenv.employee.employeeID;
  fballemployees:=False;
  for ctr := 1 to 14 do
    Labels[ctr, 1] := TLabel(findcomponent('d' + Trim(IntToStr(ctr))));
  for ctr := 1 to 14 do
    Labels[ctr, 2] := TLabel(findcomponent('q' + Trim(IntToStr(ctr))));
end;

procedure TDashBoardReminderGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  CommonDbLib.DestroyUserTemporaryTable(tablename);
end;

procedure TDashBoardReminderGUI.HideAll;
var
  ctr:Integer;
begin
  for ctr:= low(Labels) to high(Labels) do begin
    Labels[ctr,1].visible := False;
    Labels[ctr,2].visible := False;
  end;
end;

initialization
  RegisterClassOnce(TDashBoardReminderGUI);

end.
