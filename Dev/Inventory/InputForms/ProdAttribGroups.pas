unit ProdAttribGroups;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TProdAttribGroupsGUI = class(TBaseListingGUI)
    qryMainPAG_ID: TIntegerField;
    qryMainName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainXAttribName: TWideStringField;
    qryMainYAttribName: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure cmdNewClick(Sender: TObject);
  private

  public
    
  end;

implementation

uses frmProdAttribMain, CommonLib;

{$R *.dfm}

procedure TProdAttribGroupsGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;
procedure TProdAttribGroupsGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmProdAttribMain');
  if Assigned(Form) then begin //if has acess
    with TfmProdAttribMain(Form) do begin
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TProdAttribGroupsGUI);

end.

