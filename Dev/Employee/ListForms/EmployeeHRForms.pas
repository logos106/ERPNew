unit EmployeeHRForms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  PrintedHRForms;

type
  TEmployeeHRFormsGUI = class(TPrintedHRFormsGUI)
    qryMainemployeEName: TWideStringField;
    qryMainEmployeeId: TIntegerField;
  private

  Protected
    procedure SetGridColumns; Override;
    procedure initHRFormsList(Sender: TObject);Override;
  public
  end;


implementation

uses CommonLib, HRForms;

{$R *.dfm}

{ TEmployeeHRFormsGUI }

procedure TEmployeeHRFormsGUI.initHRFormsList(Sender: TObject);
begin
  if not(Sender is  THRFormsGUI) then exit;
  THRFormsGUI(Sender).FilterString := 'formtype = ' +quotedstr('E');
  THRFormsGUI(Sender).chkAdvancedPrinting.checked:= False;
  THRFormsGUI(Sender).chkAdvancedPrinting.Visible := False;
end;


procedure TEmployeeHRFormsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainEmployeeId.fieldname);
end;


initialization
  RegisterClassOnce(TEmployeeHRFormsGUI);
end.
