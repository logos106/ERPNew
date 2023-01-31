unit StSClassUnAssignedList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StSBaseClassList, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TStSClassUnAssignedListGUI = class(TStSBaseClassListGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib, AppEnvironment;

{$R *.dfm}

procedure TStSClassUnAssignedListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Choose '+ AppEnv.DefaultClass.ClassHeading + ' For Seed To Sale ';
end;

initialization
  RegisterClassOnce(TStSClassUnAssignedListGUI);
end.
