unit clientHRForms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , PrintedHRForms,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TclientHRFormsGUI = class(TPrintedHRFormsGUI)
    qryMainClientName: TWideStringField;
    qryMainclientID: TIntegerField;
  private
  Protected
    procedure SetGridColumns; Override;
    procedure initHRFormsList(Sender: TObject);Override;
  public
  end;


implementation

uses CommonLib, HRForms;

{$R *.dfm}

{ TcleintHRFormsGUI }

procedure TclientHRFormsGUI.initHRFormsList(Sender : TObject);
begin
  if not(Sender is  THRFormsGUI) then exit;
  THRFormsGUI(Sender).FilterString := 'formtype = ' +quotedstr('C');
  THRFormsGUI(Sender).chkAdvancedPrinting.checked:= False;
  THRFormsGUI(Sender).chkAdvancedPrinting.Visible := False;
end;

procedure TclientHRFormsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainclientID.fieldname);
end;


initialization
  RegisterClassOnce(TclientHRFormsGUI);

end.
