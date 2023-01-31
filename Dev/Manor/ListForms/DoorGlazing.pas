unit DoorGlazing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingDoorLookups, kbmMemTable, DB, CustomInputBox, Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton;

type
  TDoorGlazingGUI = class(TBaseListingDoorLookupGUI)
    qryMainGlobalRef: TStringField;
    qryMainChannelMats: TStringField;
    qryMainGlazingCost: TStringField;
    qryMainGlazingMats: TStringField;
    qryMainGlazingProformaText: TStringField;
    qryMainGlazingShape: TStringField;
    qryMainGlazingType: TStringField;
    qryMainGlazingUnit: TStringField;
    qryMainManufacturer: TStringField;
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
procedure TDoorGlazingGUI.cmdNewClick(Sender: TObject);
var
    Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmDoorGlazing');
  if Assigned(Form) then begin //if has acess
    with TBaseInputdoorLookupGUI(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TDoorGlazingGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end; 
end;

initialization
  RegisterClassOnce(TDoorGlazingGUI);

finalization
  UnRegisterClass(TDoorGlazingGUI);
end.
