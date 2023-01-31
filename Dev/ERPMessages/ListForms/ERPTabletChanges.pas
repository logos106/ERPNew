unit ERPTabletChanges;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ERPMessages, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,ERPChangesBase,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TERPTabletChangesGUI = class(TERPChangesBaseGUI)
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

procedure TERPTabletChangesGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Tasktype:=ERPMESSAGE_Tablet;
end;

procedure TERPTabletChangesGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpfilters.itemindex := 3;
end;

initialization
  RegisterClassOnce(TERPTabletChangesGUI);

end.
