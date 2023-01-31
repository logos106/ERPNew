unit frmScopingInputForm;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 09/12/05 1.00.00  MV   Class required for supporting Access levels.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, frmUDDInputForm, DB, MemDS, DBAccess, MyAccess, ActnList,
  DataState, SelectionDialog, AppEvnts,  Grids, BaseGrid, AdvGrid,
  StdCtrls, wwdblook, ComCtrls, ExtCtrls, wwcheckbox, Buttons, DNMSpeedButton, DNMPanel,
  Menus, AdvMenus, Shader;

type
  TScopingInputForm = class(TUDDInputForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{var
  ScopingInputForm: TScopingInputForm;}

implementation

uses
   // For exception handling in FormShow
  FormFactory    // Only required if FormFact used in initialization
  , CommonLib;

{$R *.dfm}

initialization
  RegisterClassOnce(TScopingInputForm);
  with FormFact do begin
        RegisterMe(TScopingInputForm, 'TScopeListForm_*=DAID');
  end;
finalization
  UnRegisterClass(TScopingInputForm);
end.
