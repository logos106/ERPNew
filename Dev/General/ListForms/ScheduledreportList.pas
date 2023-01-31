unit ScheduledreportList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScheduledReports, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, DBCtrls, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TScheduledreportListGUI = class(TScheduledReportsGUI)
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    CurrentreportformID:Integer;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure Customiseforemployee(const EmployeeID:Integer; fiCurrentreportformID:Integer);
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TScheduledreportListGUI }

procedure TScheduledreportListGUI.Customiseforemployee(const EmployeeID: Integer; fiCurrentreportformID: Integer);
begin
  FilterString :='EmployeeId = ' + inttostr(EmployeeID);
  RefreshQuery;
  HideHeaderwhenFormInPanel;
  CurrentreportformID:=fiCurrentreportformID;
end;

procedure TScheduledreportListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  CurrentreportformID:=0;

end;

procedure TScheduledreportListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if CurrentreportformID<> 0 then
    if QrymainformId.AsInteger = CurrentreportformID then
      ABrush.Color := $00A8FFA8;

end;

procedure TScheduledreportListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainemployeeName.fieldname);
end;

initialization
  RegisterClassOnce(TScheduledreportListGUI);
end.

