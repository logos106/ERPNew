unit RollaBlindGuideDataList;

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
  TRollaBlindGuideDataListGUI = class(TBaseListingGUI)
    qryMainProfileType: TStringField;
    qryMainGuideType: TStringField;
    qryMainItemNumber: TStringField;
    qryMainPerforated: TStringField;
    qryMainShutterClipped: TStringField;
    qryMainStandard: TStringField;
    qryMainLength: TFloatField;
    qryMainGlobalRef: TStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainGuideDataID: TIntegerField;
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
  CommonLib, RollaBlindGuideData, Forms;

procedure TRollaBlindGuideDataListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := True;
  inherited;
  LabelGridFromFieldNames := False;
end;

procedure TRollaBlindGuideDataListGUI.cmdNewClick(Sender: TObject);
var
  TmpComp: TComponent;
begin
  inherited;
  TmpComp := GetComponentByClassName('TRollaBlindGuideDataGUI');

  if Assigned(TmpComp) then begin
    with TRollaBlindGuideDataGUI(TmpComp) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TRollaBlindGuideDataListGUI);
finalization
  UnRegisterClass(TRollaBlindGuideDataListGUI);
end.
