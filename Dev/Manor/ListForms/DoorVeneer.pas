unit DoorVeneer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingDoorLookups, kbmMemTable, DB, CustomInputBox, Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton;

type
  TDoorVeneerGUI = class(TBaseListingDoorLookupGUI)
    qryMainGlobalRef: TStringField;
    qryMainCostPerSq: TStringField;
    qryMainVeneerName: TStringField;
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

procedure TDoorVeneerGUI.cmdNewClick(Sender: TObject);
var
    Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmDoorStopType');
  if Assigned(Form) then begin //if has acess
    with TBaseInputdoorLookupGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;
procedure TDoorVeneerGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end; 
end;

initialization
  RegisterClassOnce(TDoorVeneerGUI);

finalization
  UnRegisterClass(TDoorVeneerGUI);

end.
