unit frmScopingPropertyListEditor;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 09/12/05 1.00.00  MV   Class required for supporting Access levels.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, frmUDDPropertyListEditor, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  StdCtrls, ExtCtrls, DNMPanel, Menus, AdvMenus,
  DNMSpeedButton, Shader;

type
  TScopingListEditor = class(TUDDListEditor)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{var
  ScopingListEditor: TScopingListEditor;}

implementation

uses
   // For exception handling in FormShow
  FormFactory,    // Only required if FormFact used in initialization
  CommonLib;

{$R *.dfm}

initialization
  RegisterClassOnce(TScopingListEditor);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
  end;

finalization
  UnRegisterClass(TScopingListEditor);
end.
