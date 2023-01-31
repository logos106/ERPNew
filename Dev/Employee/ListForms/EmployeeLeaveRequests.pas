unit EmployeeLeaveRequests;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TEmployeeLeaveRequestsGUI = class(TBaseListingGUI)
    qryMainid: TIntegerField;
    qryMainEmployeename: TWideStringField;
    qryMainLeavetype: TWideStringField;
    qryMainStartDate: TDateField;
    qryMainStartTime: TTimeField;
    qryMainEndDate: TDateField;
    qryMainEndTime: TTimeField;
    qryMainHours: TFloatField;
    qryMainActive: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}
{ TEmployeeLeaveRequestsGUI }

procedure TEmployeeLeaveRequestsGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmEmployeeLeaveRequests' , 0);
end;

procedure TEmployeeLeaveRequestsGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

procedure TEmployeeLeaveRequestsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainID.fieldname);
end;

initialization
  RegisterClassOnce(TEmployeeLeaveRequestsGUI);

end.
