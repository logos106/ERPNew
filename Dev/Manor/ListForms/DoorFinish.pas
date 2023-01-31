unit DoorFinish;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingDoorLookups, kbmMemTable, DB, CustomInputBox, Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton;

type
  TDoorfinishGUI = class(TBaseListingDoorLookupGUI)
    qryMainGlobalRef: TStringField;
    qryMainCost: TStringField;
    qryMainActive: TStringField;
    qryMainFinishName: TStringField;
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses BaseInputDoorLookups, CommonLib;

{$R *.dfm}

procedure TDoorfinishGUI.cmdNewClick(Sender: TObject);
var
    Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmDoorFinish');
  if Assigned(Form) then begin //if has acess
    with TBaseInputdoorLookupGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;
procedure TDoorfinishGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end; 
end;

initialization
  RegisterClassOnce(TDoorfinishGUI);

finalization
  UnRegisterClass(TDoorfinishGUI);
end.
