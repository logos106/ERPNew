unit RollaBlindTechDataList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton;

type
  TRollaBlindTechDataListGUI = class(TBaseListingGUI)
    qryMainMeasurementID: TIntegerField;
    qryMainGlobalRef: TStringField;
    qryMainInstallID: TFloatField;
    qryMainType: TStringField;
    qryMainCategory: TStringField;
    qryMainGuideType: TStringField;
    qryMainMeasurement: TIntegerField;
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
  CommonLib, RollaBlindTechData, Forms;

procedure TRollaBlindTechDataListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := True;
  inherited;
end;

procedure TRollaBlindTechDataListGUI.cmdNewClick(Sender: TObject);
var
  TmpComp: TComponent;
begin
  inherited;
  TmpComp := GetComponentByClassName('TRollaBlindTechDataGUI');

  if Assigned(TmpComp) then begin
    with TRollaBlindTechDataGUI(TmpComp) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TRollaBlindTechDataListGUI);
finalization
  UnRegisterClass(TRollaBlindTechDataListGUI);
end.
