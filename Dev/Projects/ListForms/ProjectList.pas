unit ProjectList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess, MyAccess, MemDS,
  wwdbdatetimepicker, ProgressDialog, CustomInputBox, wwdblook, Shader,
  kbmMemTable;

type
  TfrmProjectList = class(TBaseListingGUI)
    procedure cmdNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmProjectList: TfrmProjectList;

implementation

uses frmProjectfrm, FormFactory, frmSalesOrder, CommonLib;

{$R *.dfm}

procedure TfrmProjectList.cmdNewClick(Sender: TObject);
Var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TSalesOrderGUI');
  If not Assigned(tmpComponent) then Exit;
  with TSalesOrderGUI(tmpComponent) do begin
    AttachObserver(Self);
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;



procedure TfrmProjectList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  frmProjectList := nil;
end;

initialization
  RegisterClassOnce(TfrmProjectList);  
  with FormFact do begin
    RegisterMe(TfrmProject, 'TfrmProjectList_*=ProjectID');
  end;
end.
