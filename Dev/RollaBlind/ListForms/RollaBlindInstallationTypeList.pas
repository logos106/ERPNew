unit RollaBlindInstallationTypeList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton;

type
  TRollaBlindInstallationTypeListGUI = class(TBaseListingGUI)
    qryMainInstallationType: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib, RollaBlindInstallationType, Forms;

procedure TRollaBlindInstallationTypeListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := True;
  inherited;
end;

procedure TRollaBlindInstallationTypeListGUI.cmdNewClick(Sender: TObject);
var
  TmpComp: TComponent;
begin
  inherited;
  TmpComp := GetComponentByClassName('TRollaBlindInstallationTypeGUI');

  if Assigned(TmpComp) then begin
    with TRollaBlindInstallationTypeGUI(TmpComp) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TRollaBlindInstallationTypeListGUI);
finalization
  UnRegisterClass(TRollaBlindInstallationTypeListGUI);
end.
