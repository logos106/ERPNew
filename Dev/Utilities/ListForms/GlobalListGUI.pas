unit GlobalListGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GlobalListSearchGUI, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  wwcheckbox, CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TGlobalListFrm = class(TGlobalListSearchFrm)
    procedure FormCreate(Sender: TObject);
    procedure btnToggleClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib, BaseListingForm, AppEnvironment,frmMarketingContact ;

{$R *.dfm}

procedure TGlobalListFrm.FormCreate(Sender: TObject);
begin
  inherited;
  Qrymain.SQL.text := 'Select *' + #13#10 + 'from ' + tableName ;
  Self.caption := 'Global List';
end;

procedure TGlobalListFrm.btnToggleClick(Sender: TObject);
Var Form : TComponent;
begin
  //inherited;
  if not FormStillOpen('TGlobalListSearchFrm') then begin
    Form := GetComponentByClassName('TGlobalListSearchFrm');
    if Assigned(Form) then begin
      with TBaseListingGUI(Form) do begin
          FormStyle :=fsMDIChild;
          BringToFront;
      end;
    end;
  end else TBaseListingGUI(FindExistingComponent('TGlobalListSearchFrm')).show;
  Application.ProcessMessages;
  Self.Close;
end;

procedure TGlobalListFrm.FormShow(Sender: TObject);
begin
  inherited;
  edtSearch.SetFocus;
end;

initialization
  RegisterClassOnce(TGlobalListFrm);

end.
