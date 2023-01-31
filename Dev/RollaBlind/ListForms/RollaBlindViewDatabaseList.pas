unit RollaBlindViewDatabaseList;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 05/07/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls, DNMSpeedButton, CustomInputBox, wwdblook,
  Shader;

type
  TRollaBlindViewDatabaseListGUI = class(TBaseListingGUI)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

procedure TRollaBlindViewDatabaseListGUI.FormCreate(Sender: TObject);
begin
  fbEnableWebSearch := True;
  inherited;
  LabelGridFromFieldNames := False;
end;

initialization
  RegisterClassOnce(TRollaBlindViewDatabaseListGUI);
finalization
  UnRegisterClass(TRollaBlindViewDatabaseListGUI);
end.
