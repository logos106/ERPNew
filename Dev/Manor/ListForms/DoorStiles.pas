unit DoorStiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingDoorLookups, kbmMemTable, DB, CustomInputBox, Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton;

type
  TDoorStilesGUI = class(TBaseListingDoorLookupGUI)
    qryMainGlobalRef: TStringField;
    qryMainCode: TStringField;
    qryMainCostPerMetre: TStringField;
    qryMainStiles: TStringField;
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

procedure TDoorStilesGUI.cmdNewClick(Sender: TObject);
var
    Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmDoorStiles');
  if Assigned(Form) then begin //if has acess
    with TBaseInputdoorLookupGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;
procedure TDoorStilesGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end; 
end;

initialization
  RegisterClassOnce(TDoorStilesGUI);

finalization
  UnRegisterClass(TDoorStilesGUI);

end.
