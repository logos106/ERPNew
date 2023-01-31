unit DailyWorkListingFrm;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 21/10/05  1.00.01 MV   Addition of daily work record list support
 
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ProgressDialog, DB, DBAccess, MyAccess, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Menus, AdvMenus, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, DNMPanel, ComCtrls,AdvOfficeStatusBar, wwdblook, CustomInputBox, Shader,
  kbmMemTable;

type
  TDailyWorkListingGUI = class(TBaseListingGUI)
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
    procedure ModifyControlRequirements;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, BaseInputForm;

{$R *.dfm}

procedure TDailyWorkListingGUI.FormShow(Sender: TObject);
begin
  inherited;
  if not self.fbFormOpenedOk then
    exit;

  // Call to modify appearance
  ModifyControlRequirements;

  // Open the main query
  qryMain.Open;
end;

procedure TDailyWorkListingGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  // Close the main query
  qryMain.Close;
  
end;

procedure TDailyWorkListingGUI.ModifyControlRequirements;
begin
  // Modifiy control requirements
  pnlHeader.Caption := 'Daily Work Summary';
  //Caption := 'Daily Work Summary';

  // Hide the following controls
  cboDateRange.Visible := false;
  lblFrom.Visible := false;
  dtFrom.Visible := false;
  lblTo.Visible := false;
  dtTo.Visible := false;
end;

procedure TDailyWorkListingGUI.cmdNewClick(Sender: TObject);
var
    form :TBaseInputGUI;
begin
  inherited;
  form :=TBaseInputGUI(GetComponentByClassName('TfrmDailyWorkRecord'));
  if not Assigned(Form) then exit;
    with Form  do begin
        KeyId := 0;
        FormStyle := fsMDIChild;
        bringtofront;
    end;
end;

initialization
  RegisterClassOnce(TDailyWorkListingGUI);

finalization
  UnRegisterClass(TDailyWorkListingGUI);
end.
