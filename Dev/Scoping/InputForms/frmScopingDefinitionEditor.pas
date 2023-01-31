unit frmScopingDefinitionEditor;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 09/12/05 1.00.00  MV   Class required for supporting Access levels.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, frmUDDDefinitionEditor, ActnList, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  Grids, BaseGrid, AdvGrid, StdCtrls,
  wwcheckbox, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, ComCtrls, Menus, AdvMenus,
  Shader;

type
  TScopingDefinitionEditor = class(TUDDDefinitionEditor)
    procedure UserDefinedGridButtonClick(Sender: TObject; ACol, ARow: integer);
    procedure UserDefinedGridEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

{var
  ScopingDefinitionEditor: TScopingDefinitionEditor;}

implementation

uses
   // For exception handling in FormShow
  FormFactory, frmScopingPropertyListEditor, daBase, Forms, CommonLib,
  FastFuncs;    // Only required if FormFact used in initialization

{$R *.dfm}

procedure TScopingDefinitionEditor.UserDefinedGridButtonClick(Sender: TObject; ACol, ARow: integer);
var
    Form :TScopingListEditor;
begin
    Form := TScopingListEditor(GetComponentByClassName('TScopingListEditor'));
    Try
        Form.Definition := HDDef.DetailDefs.Item[ARow - 1];
        Form.ShowModal;
    finally
        FreeandNil(Form);
    end;
end;

procedure TScopingDefinitionEditor.UserDefinedGridEnter(Sender: TObject);
begin
  inherited;
    if FastFuncs.Trim(edtName.Text) = '' then begin
        CommonLib.MessageDlgXP_Vista('Name should not be blank', mtError, [mbOk], 0);
        SetControlFocus(edtName);
        Exit;
    end;
end;

initialization
  RegisterClassOnce(TScopingDefinitionEditor);
  with FormFact do begin
    RegisterMe(TUDDDefinitionEditor, 'TScopingDefinitionGUI_*=DAID');
  end;

finalization
  UnRegisterClass(TScopingDefinitionEditor);
end.

