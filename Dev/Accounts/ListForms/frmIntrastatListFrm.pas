unit frmIntrastatListFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, DNMPanel, ComCtrls,AdvOfficeStatusBar, DNMSpeedButton, DAScript,
  MyScript, CustomInputBox, wwcheckbox;

type
  TfrmIntrastatList = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainIntrastatType: TWideStringField;
    qryMainSubmittedDate: TDateField;
    qryMainMonth: TWideStringField;
    qryMainYear: TIntegerField;
    qryMainIntrastatID: TIntegerField;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}
uses
  CommonLib,frmIntrastatDeclarationFrm;

procedure TfrmIntrastatList.cmdNewClick(Sender: TObject);
var
  frm: TComponent;
begin
  inherited;
  Frm := GetComponentByClassName('TfrmIntrastatDeclaration');
  if Assigned(Frm) then begin
    with TfrmIntrastatDeclaration(Frm) do begin
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
  Close;
end;

initialization
  RegisterClassOnce(TfrmIntrastatList);

end.
