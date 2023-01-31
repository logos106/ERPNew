unit ResourceUnavailability;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TResourceUnavailabilityGUI = class(TBaseListingGUI)
    qryMainProcResourceId: TIntegerField;
    qryMainProcResourceDetailId: TIntegerField;
    qryMainProcResourceUnAvailabilityId: TIntegerField;
    qryMainResourceName: TWideStringField;
    qryMainResourceDetailName: TWideStringField;
    qryMainUnAvailabledesc: TWideStringField;
    qryMainTimeStart: TDateTimeField;
    qryMainTimeEnd: TDateTimeField;
    procedure grdMainDblClick(Sender: TObject);override;
  private
    procedure SetfocustounAvailGrid(Sender: TObject);
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, CommonFormLib, frmProcResourceEdit;

{$R *.dfm}
{ TResourceUnavailabilityGUI }

procedure TResourceUnavailabilityGUI.grdMainDblClick(Sender: TObject);
begin
//  inherited;
  if qryMainProcResourceId.AsInteger <> 0 then
    OpenERPForm('TfmProcResourceEdit' , qryMainProcResourceId.AsInteger , SetfocustounAvailGrid);
end;
procedure TResourceUnavailabilityGUI.SetfocustounAvailGrid(Sender:TObject);
begin
  if not (Sender is TfmProcResourceEdit) then exit;

  Setcontrolfocus(TfmProcResourceEdit(Sender).grdUnavailaibility);
  if TfmProcResourceEdit(Sender).qryProcResourceDetails.Locate('ID' , qryMainProcResourceDetailId.AsInteger , []) then
    if  TfmProcResourceEdit(Sender).QryprocresourceUnavailability.Locate('ProcResourceUnAvailabilityId' ,qryMainProcResourceUnAvailabilityId.AsInteger , [] ) then exit;

end;
procedure TResourceUnavailabilityGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

procedure TResourceUnavailabilityGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainProcResourceId.FieldName);
  RemoveFieldfromGrid(QrymainProcResourceDetailId.FieldName);
  RemoveFieldfromGrid(QrymainProcResourceUnAvailabilityId.FieldName);
end;

initialization
  RegisterClassOnce(TResourceUnavailabilityGUI);

end.
