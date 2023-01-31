unit RollaBlindProfileTypesList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 18/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton;

type
  TRollaBlindProfileTypesListGUI = class(TBaseListingGUI)
    qryMainProfileTypeID: TIntegerField;
    qryMainGlobalRef: TStringField;
    qryMainProfileType: TStringField;
    qryMainDescription: TStringField;
    qryMainmsTimeStamp: TDateTimeField;
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
  CommonLib, RollaBlindProfileTypes, Forms;

procedure TRollaBlindProfileTypesListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := True;
  inherited;
end;

procedure TRollaBlindProfileTypesListGUI.cmdNewClick(Sender: TObject);
var
  TmpComp: TComponent;
begin
  inherited;
  TmpComp := GetComponentByClassName('TRollaBlindProfileTypesGUI');

  if Assigned(TmpComp) then begin
    with TRollaBlindProfileTypesGUI(TmpComp) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TRollaBlindProfileTypesListGUI);
finalization
  UnRegisterClass(TRollaBlindProfileTypesListGUI);
end.
