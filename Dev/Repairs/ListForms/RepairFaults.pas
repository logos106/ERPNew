unit RepairFaults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox;

type
  TRepairFaultGUI = class(TBaseListingGUI)
    qryMainRepairFaultID: TLargeintField;
    qryMainGlobalref: TWideStringField;
    qryMainCategory: TWideStringField;
    qryMainCategoryDesc: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainmsTimestamp: TDateTimeField;
    qryMaincode: TWideStringField;
    qryMainManufacture: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



implementation

uses CommonLib, frmRepairFaults;

{$R *.dfm}
procedure TRepairFaultGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmRepairFaults');
  if Assigned(Form) then begin //if has acess
    with TfmRepairFaults(Form) do begin
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;  

end;

initialization
  RegisterClassOnce(TRepairFaultGUI);

end.
