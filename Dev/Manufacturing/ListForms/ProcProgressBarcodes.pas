unit ProcProgressBarcodes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProcProgressReport, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, DNMAction, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, CheckComboBox, wwdbdatetimepicker, wwcheckbox, wwdblook,
  DNMSpeedButton, wwclearbuttongroup, wwradiogroup, Shader, DBCtrls, DNMPanel,
  GIFImg;

type
  TProcProgressBarcodesGUI = class(TProcProgressReportGUI)
    ChkShowCurrentOnly: TwwCheckBox;
    qryMainProcessEmployeeId: TIntegerField;
    procedure ChkShowCurrentOnlyClick(Sender: TObject);
    procedure actPrintSerialnumberExecute(Sender: TObject);
  private
  Protected
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
    Function ShowCurrentUserOnly:Boolean;Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses frmProcProgress, ProcProgressLib, CommonLib, Preferences, AppEnvironment,
  FrmProcProgressBarcodes, LogLib;

{$R *.dfm}

{ TProcProgressBarcodesGUI }

procedure TProcProgressBarcodesGUI.actPrintSerialnumberExecute(Sender: TObject);
var
  AccLevel: Integer;
begin
  AccLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel('TPreferencesGUI');

  if Assigned(Owner) and (Owner is TFmProcProgressBarcodes) then
    if TFmProcProgressBarcodes(Owner).PrintBuildReport(qryMainPPGID.asInteger , StrToDoneQtytype(qryMainbBuildStatus.asString)) then exit;

  if Assigned(Owner) and (Owner is TfmProcProgress) then
    if TfmProcProgress(Owner).PrintBuildReport(qryMainID.asInteger , StrToDoneQtytype(qryMainBuildStatus.asString)) then exit;

  case MessageDlgXP_Vista('None of the reports are selected to be Printed in the Preferences. Do you wish to print the default Template ''SerialNumber Barcode'' ? ',
                                mtConfirmation, [], 0 ,nil , '' , '' , False, nil ,'Print Serial Number Barcode,Open Preference,Cancel'   ) of
    100: inherited;
    101: OpenPrefform('Manufacturing' ,  'btnSetupReportProgressBuild' , AccLevel , true , '' , '' );
    102:Exit;
  end;

end;

procedure TProcProgressBarcodesGUI.ChkShowCurrentOnlyClick(Sender: TObject);
begin
  inherited chkfilterlistClick(nil);
  if ChkShowCurrentOnly.checked then begin
    if GroupfilterString <> '' then GroupfilterString := '(' + GroupfilterString +') AND ';
    //groupfilterString := 'ProcessEmployeeId = ' + inttostr(ProcessEmployeeId)+' Or PPGID is null';
    //Dene doesn't want to see the tree, only want to see the activity on the station (for steel mains).
    groupfilterString := 'ProcessEmployeeId = ' + inttostr(ProcessEmployeeId)+' and qty_4>0';
  end;
  inherited grpFiltersclick(nil);
end;

procedure TProcProgressBarcodesGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options.ShowCurrentOnly') then
    ChkShowCurrentOnly.checked :=  GuiPrefs.Node['Options.ShowCurrentOnly'].AsBoolean;
end;

procedure TProcProgressBarcodesGUI.RefreshQuery;
begin
  inherited;
  Qrymain.First;
  While (Qrymain.eof = False) and ( qryMainSerialNumber.asString = '') do Qrymain.next;
  logtext(qrymain.sql.text);
end;

function TProcProgressBarcodesGUI.ShowCurrentUserOnly: Boolean;
begin
  REsult :=  ChkShowCurrentOnly.visible and  ChkShowCurrentOnly.checked;
end;

procedure TProcProgressBarcodesGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.ShowCurrentOnly'].AsBoolean := ChkShowCurrentOnly.checked;
end;

end.
