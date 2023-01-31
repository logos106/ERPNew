unit HowToWorkflows;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TfrmHowToWorkflows = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainIsERpWorkflow: TWideStringField;
    qryMainCreatedBy: TWideStringField;
    SaveDialog1: TSaveDialog;
    N1: TMenuItem;
    ExportSelectedRecordsasSQL1: TMenuItem;
    qryMainLanguageID: TIntegerField;
    qryMainCategory: TWideStringField;
    qryMainSkinsGroup: TWideStringField;
    qryMainTabGroup: TIntegerField;
    qryMainLanguage: TWideStringField;
    GrpLanguage: TRadioGroup;
    qryMainVideoName: TWideStringField;
    qryMainCompanyName: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);override;
    procedure cmdNewClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure GrpLanguageClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
//    Function WorkflowRecSQL:String;
    procedure LocateLastWorkflowAccessed;
    function GetWorkFlowId: integer;
    function GetWorkFlowDescription: string;
  Protected
    procedure SetGridColumns; Override;
    Procedure RefreshQuery;Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    property WorkflowId : integer read GetWorkFlowId;
    property WorkFlowDescription : string read GetWorkFlowDescription;
  end;


implementation

uses Clipbrd, CommonLib, CommonFormLib, frmWorkflowPlay, MainSwitchFrm2, MAIN,tcConst, AppEnvironment, BusobjWorkflow, AppEnvironmentVirtual, WorkflowObj, tcDataUtils,
  LanguageTranslationObj, ShellAPI;

{$R *.dfm}
{ TWorkflowsGUI }

(*
function TfrmHowToWorkflows.WorkflowRecSQL: String;
begin
  result := '';
  if qryMainID.asInteger =0 then exit;
  result := TWorkFlow.WorkflowRecSQL(qryMainID.asInteger);
end;
*)

procedure TfrmHowToWorkflows.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.LanguageOption'].asInteger := GrpLanguage.ItemIndex ;
  GuiPrefs.Node['Options.LastWorkflowAccessed'].asInteger  := qryMainID.asInteger;
end;

procedure TfrmHowToWorkflows.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if QrymainId.AsInteger =0 then exit;
  if MessageDlgXP_Vista('Deleting a workflow will remove it physically and its not possible to restore it.'+ NL+
                          'Are you sure you want to delete  workflow ' +quotedstr(Qrymaindescription.AsString) +'?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;

  With TWorkFlow.CreateWithNewConn(Self) do try
    Load(QrymainId.AsInteger );
    if count =0 then exit;
    if not(Lock) then begin
      MessageDlgXP_Vista(replacestr(userlock.LockMessage , 'Unable to update data.' , 'Unable to delete Workflow.'), mtWarning, [mbOK], 0);
      Exit;
    end;
    connection.BeginTransaction;
    try
      Delete;
      Connection.CommitTransaction;
      TimerMsg(FilterLabel , 'Workflow ' +Quotedstr(Qrymaindescription.AsString)+' is deleted.');
      RefreshQuery;
    Except
      on E:Exception do begin
        MessageDlgXP_vista('Deletion of workflow failed.'+NL+NL+E.Message, mtWarning, [mbOK], 0);
        Connection.RollbackTransaction;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TfrmHowToWorkflows.cmdNewClick(Sender: TObject);
begin
  // No inherited
  if fsModal in FormState then
    ModalResult := mrOK
  else
    Close;
end;

procedure TfrmHowToWorkflows.cmdPrintClick(Sender: TObject);
begin
// no  inherited;
  if fsModal in FormState then
    ModalResult := mrCancel
  else
    Close;
end;

procedure TfrmHowToWorkflows.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  ImportWorkflows;
  RefreshQuery;
end;

procedure TfrmHowToWorkflows.FormCreate(Sender: TObject);
begin
  GrpLanguage.items[0] := 'WorkFlows of ' + quotedstr(LanguageName(TLanguageTranslationObj.Inst.UserLanguageId));
  inherited;
end;

procedure TfrmHowToWorkflows.FormShow(Sender: TObject);
begin
  inherited;
  cmdNew.Enabled := true; //Visible := false;
  cmdClose.Visible := false;
end;

function TfrmHowToWorkflows.GetWorkFlowDescription: string;
begin
  Result := qryMain.FieldByName('Description').asString;
end;

function TfrmHowToWorkflows.GetWorkFlowId: integer;
begin
  Result := qryMain.FieldByName('ID').AsInteger;
end;

procedure TfrmHowToWorkflows.grdMainDblClick(Sender: TObject);
begin
  if fsModal in FormState then
    ModalResult := mrOk
  else
    Close;
end;


procedure TfrmHowToWorkflows.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TfrmHowToWorkflows.GrpLanguageClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfrmHowToWorkflows.LocateLastWorkflowAccessed;
begin
  if not Qrymain.Active then exit;
  if not GuiPrefs.Active then GuiPrefs.Active := True;
  if GuiPrefs.Node.Exists('Options.LastWorkflowAccessed') then
      if Qrymain.locate('ID', GuiPrefs.Node['Options.LastWorkflowAccessed'].asInteger , []) then begin
        grdmain.SelectRecord;
        setcontrolfocus(grdmain);
      end;
end;

procedure TfrmHowToWorkflows.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LocateLastWorkflowAccessed;
end;

procedure TfrmHowToWorkflows.ReadnApplyGuiPrefExtra;
var
  x: integer;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.LanguageOption') then begin
        x := GuiPrefs.Node['Options.LanguageOption'].asInteger;
        if x >= 0 then GrpLanguage.ItemIndex :=  GuiPrefs.Node['Options.LanguageOption'].asInteger;
    end;
    LocateLastWorkflowAccessed;
end;

procedure TfrmHowToWorkflows.RefreshQuery;
begin
  if GrpLanguage.itemindex =0 then
    Qrymain.ParamByName('LanguageID').asInteger := TLanguageTranslationObj.Inst.UserLanguageId
  else
    Qrymain.ParamByName('LanguageID').asInteger := 0;
  inherited;
end;

procedure TfrmHowToWorkflows.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainId.FieldName);
  RemoveFieldfromGrid(QrymainLanguageID.FieldName);
  RemoveFieldfromGrid(qryMainTabGroup.FieldName);
end;



initialization
  RegisterClassOnce(TfrmHowToWorkflows);
end.

