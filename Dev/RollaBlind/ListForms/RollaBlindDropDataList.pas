unit RollaBlindDropDataList;

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
  TRollaBlindDropDataListGUI = class(TBaseListingGUI)
    qryMainProfileType: TStringField;
    qryMainCategory: TStringField;
    qryMainMinDrop: TFloatField;
    qryMainMaxDrop: TFloatField;
    qryMainHiddenProfiles: TFloatField;
    qryMainProfileWidth: TFloatField;
    qryMainHousingHeight: TFloatField;
    qryMainPerforated: TStringField;
    qryMainGlobalRef: TStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainProfDataID: TIntegerField;
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
  CommonLib, RollaBlindDropData, Forms;

procedure TRollaBlindDropDataListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := True;
  inherited;
  LabelGridFromFieldNames := False;
end;

procedure TRollaBlindDropDataListGUI.cmdNewClick(Sender: TObject);
var
  TmpComp: TComponent;
begin
  inherited;
  TmpComp := GetComponentByClassName('TRollaBlindDropDataGUI');

  if Assigned(TmpComp) then begin
    with TRollaBlindDropDataGUI(TmpComp) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TRollaBlindDropDataListGUI);
finalization
  UnRegisterClass(TRollaBlindDropDataListGUI);
end.
