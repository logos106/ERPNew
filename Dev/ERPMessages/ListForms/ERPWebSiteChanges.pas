unit ERPWebSiteChanges;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ERPMessages, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel, ERPChangesBase,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TERPWebSiteChangesGUI = class(TERPChangesBaseGUI)
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib, ERPMessageTypes;

{$R *.dfm}
procedure TERPWebSiteChangesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Tasktype:=ERPMESSAGE_Website;
end;

procedure TERPWebSiteChangesGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpfilters.itemindex := 2;
end;

initialization
  RegisterClassOnce(TERPWebSiteChangesGUI);

end.
