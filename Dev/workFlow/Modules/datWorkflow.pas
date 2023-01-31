unit datWorkflow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGUIDatamodule, ImgList, ActnList, DNMAction, Menus, AdvMenus, frmReportSelectorFrm;

type
  TdtWorkflow = class(TdtmGUI)
    ActionList: TActionList;
    actStartRecording: TDNMAction;
    actStoprecording: TDNMAction;
    actCancelrecording: TDNMAction;
    MainMenu: TAdvMainMenu;
    Workflow: TMenuItem;
    CancelRecording1: TMenuItem;
    StopRecording1: TMenuItem;
    StopRecording2: TMenuItem;
    actWorkflows: TDNMAction;
    WorkFlows1: TMenuItem;
    actImportWorkflow: TDNMAction;
    ImportWorkflows1: TMenuItem;
    ExportAllWorkFlows1: TMenuItem;
    actExportAllWorkflows: TDNMAction;
    Procedure DoStartRecording(Sender: TObject);
    Procedure DoStopRecording(Sender: TObject);
    Procedure DoCancelRecording(Sender: TObject);
    procedure actImportWorkflowExecute(Sender: TObject);
    procedure actExportAllWorkflowsExecute(Sender: TObject);
  private
  Protected
    procedure DoAddReports(Const ReportSelector: TfrmReportSelectorGUI); Override;
  public
    Procedure DoLogrecording(Sender: TObject);
  end;


implementation

uses CommonLib, tcConst, GlobalEventsObj, MAIN,Workflows, WorkflowObj;

{$R *.dfm}

{ TdtWorkflow }
Procedure TdtWorkflow.DoLogrecording(Sender: TObject);
begin
  MainForm.DoLogrecording;
end;
Procedure TdtWorkflow.DoStartrecording(Sender: TObject);
begin
  MainForm.DoStartrecording;
end;
Procedure TdtWorkflow.DoStoprecording(Sender: TObject);
begin
  try
    MainForm.DoStoprecording;
  except
  end;
end;
Procedure TdtWorkflow.DoCancelrecording(Sender: TObject);
begin
  try
    MainForm.DoCancelrecording;
  except
  end;
end;

procedure TdtWorkflow.actExportAllWorkflowsExecute(Sender: TObject);
var
  fform:TForm;
begin
  inherited;
  if MessageDlgXP_vista('Are you sure you want to export all workflows as SQL?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  AnyActionExecute(actExportAllWorkflows);
  fform:= FindFormInstance(actExportAllWorkflows.ClassExecute);
  if Assigned(fform) and (fform is TWorkflowsGUI) then
    TWorkflowsGUI(fForm).exportAll;
end;

procedure TdtWorkflow.actImportWorkflowExecute(Sender: TObject);
begin
  ImportWorkflows;
end;

procedure TdtWorkflow.DoAddReports(Const ReportSelector: TfrmReportSelectorGUI);
begin
    if Assigned(ReportSelector) then begin
      ReportSelector.Add(REPORT_GROUP_WORKFLOW, 'WorkFlows'     , 'TWorkflowsGUI'    , 0);
    end;
end;


end.

