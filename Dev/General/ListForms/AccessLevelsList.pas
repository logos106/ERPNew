unit AccessLevelsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TAccessLevelsListGUI = class(TBaseListingGUI)
    qryMainAccess: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainSkinsGroup: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainEmployeeId: TIntegerField;
    procedure FormCreate(Sender: TObject);
  private
    fiEmployeeId :Integer;
    function getemployeeId: Integer;
    procedure setemployeeId(const Value: Integer);
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery; Override;
    Property employeeId :Integer read getemployeeId write setemployeeId;
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TAccessLevelsListGUI.FormCreate(Sender: TObject);
begin
  fiEmployeeId := 0;
  inherited;
  HaveDateRangeSelection := False;
  SelectionOption := soEmployee;
end;

function TAccessLevelsListGUI.getemployeeId: Integer;
begin
  result := fiEmployeeId;
  if assigned(EmployeeLookupform) then Result := EmployeeLookupform.LookupId;
end;

procedure TAccessLevelsListGUI.RefreshQuery;
begin
  if   AllEmployees then Qrymain.parambyname('employeeId').asInteger := 0
  else Qrymain.parambyname('employeeId').asInteger := SelectedEmployeeID;
  inherited;

end;

procedure TAccessLevelsListGUI.setemployeeId(const Value: Integer);
begin
  fiemployeeId := Value;
  if Assigned(EmployeeLookupform)    then
    EmployeeLookupform.LookupId := Value;
end;

procedure TAccessLevelsListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainemployeeId.fieldname);
end;

initialization
  RegisterClassOnce(TAccessLevelsListGUI);

end.
