unit DoorDet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingDoorLookups, kbmMemTable, DB, CustomInputBox, Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton;

type
  TDoorDetGUI = class(TBaseListingDoorLookupGUI)
    qryMainGlobalRef: TStringField;
    qryMainAddGoCost: TStringField;
    qryMainBcsCostM: TStringField;
    qryMainBcsCostRb: TStringField;
    qryMainBcsCostSt: TStringField;
    qryMainBcsCostSy: TStringField;
    qryMainComputerCode: TStringField;
    qryMainDescription: TStringField;
    qryMainDoorType: TStringField;
    qryMainFinish: TStringField;
    qryMainFrameType: TStringField;
    qryMainInternalExternal: TStringField;
    qryMainLabCost: TStringField;
    qryMainLamLabCost: TStringField;
    qryMainLippingStile: TStringField;
    qryMainMaxHeight: TStringField;
    qryMainMaxWidth: TStringField;
    qryMainMinHeight: TStringField;
    qryMainMinWidth: TStringField;
    qryMainMonoLux: TStringField;
    qryMainNoComp: TStringField;
    qryMainPlyDepth: TStringField;
    qryMainRebated: TStringField;
    qryMainReportNotes: TStringField;
    qryMainShortType: TStringField;
    qryMainStandard: TStringField;
    qryMainSundries: TStringField;
    qryMainSystem90: TStringField;
    qryMainThickness: TStringField;
    qryMainTwinFastScrews: TStringField;
    qryMainActive: TStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib, BaseInputDoorLookups;

{$R *.dfm}
procedure TDoorDetGUI.cmdNewClick(Sender: TObject);
var
    Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmDoorDet');
  if Assigned(Form) then begin //if has acess
    with TBaseInputdoorLookupGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TDoorDetGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end; 
end;

initialization
  RegisterClassOnce(TDoorDetGUI);

finalization
  UnRegisterClass(TDoorDetGUI);
end.
