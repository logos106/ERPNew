unit Workflows;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup;

type
  TWorkflowsGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainIsERpWorkflow: TWideStringField;
    qryMainCreatedBy: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    SaveDialog1: TSaveDialog;
    N1: TMenuItem;
    ExportSelectedRecordsasSQL1: TMenuItem;
    qryMainLanguageID: TIntegerField;
    btnExportasSQL: TDNMSpeedButton;
    qryMainCategory: TWideStringField;
    qryMainSkinsGroup: TWideStringField;
    qryMainTabGroup: TIntegerField;
    btnDelete: TDNMSpeedButton;
    qryMainLanguage: TWideStringField;
    DNMSpeedButton2: TDNMSpeedButton;
    GrpLanguage: TRadioGroup;
    qryMainVideoName: TWideStringField;
    qryMainCompanyName: TWideStringField;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure cmdNewClick(Sender: TObject);
    procedure ExportSelectedRecordsasSQL1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject); override;
    procedure GrpLanguageClick(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    Procedure Playworkflow;
    Function WorkflowRecSQL:String;
    procedure LocateLastWorkflowAccessed;
  Protected
    procedure SetGridColumns; Override;
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
    Procedure RefreshQuery;Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Function ExportAll:Boolean;
  end;


implementation

uses
  Clipbrd, CommonLib, CommonFormLib, frmWorkflowPlay, MainSwitchFrm2, MAIN,
  tcConst, AppEnvironment, BusobjWorkflow, AppEnvironmentVirtual, WorkflowObj, tcDataUtils,
  LanguageTranslationObj, ShellAPI, ERPErrorEmailUtils;

{$R *.dfm}
{ TWorkflowsGUI }

procedure TWorkflowsGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.LanguageOption'].asInteger := GrpLanguage.ItemIndex ;
  GuiPrefs.Node['Options.LastWorkflowAccessed'].asInteger  := qryMainID.asInteger;
end;

procedure TWorkflowsGUI.btnDeleteClick(Sender: TObject);
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

procedure TWorkflowsGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  MainSwitch2.bringtofront;
  MainSwitch2.SetFocus;
  MainForm.DoStartrecording;
  Self.Close;
end;

procedure TWorkflowsGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  openErpform('TfmWorkflow' , QrymainId.asInteger);
end;

procedure TWorkflowsGUI.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  ImportWorkflows;
  RefreshQuery;
end;

function TWorkflowsGUI.ExportAll: Boolean;
var
  Key: word;
begin
  fbExportingall := TRue;
  try
    Result := False;
    if not(Sametext(GuiPrefs.Node['SearchMode.type'].asString, 'Full')) then begin
      Key :=VK_F5;
      FormKeyUp(grdmain, Key, []);
    end;
    Grdmain.SelectAll;
    btnExportasSQL.Click;
    Self.Close;
  finally
    fbExportingall := False;
  end;
end;

procedure TWorkflowsGUI.ExportSelectedRecordsasSQL1Click(Sender: TObject);
var
  filename :String;
begin
  filename :='';
  if ExporttoSQL('Workflow' , filename) then begin

  end;
end;
procedure TWorkflowsGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
begin
  inherited;
  if IterateProcno = ItearteProcno4ExportToSQL then begin
    fsExportedSQL:= fsExportedSQL + WorkflowRecSQL;
  end;
end;

function TWorkflowsGUI.WorkflowRecSQL: String;
begin
  result := '';
  if qryMainID.asInteger =0 then exit;
  result := TWorkFlow.WorkflowRecSQL(qryMainID.asInteger);
end;
procedure TWorkflowsGUI.FormCreate(Sender: TObject);
begin
  GrpLanguage.items[0] := 'WorkFlows of ' + quotedstr(LanguageName(TLanguageTranslationObj.Inst.UserLanguageId));
  inherited;
end;

procedure TWorkflowsGUI.grdMainDblClick(Sender: TObject);
begin
  //inherited;
  Playworkflow;
end;


procedure TWorkflowsGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;
end;

procedure TWorkflowsGUI.GrpLanguageClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TWorkflowsGUI.Playworkflow;
begin
  WorkflowPlayForm.Playworkflow(QrymainId.AsInteger);
  Self.Close;
end;
procedure TWorkflowsGUI.LocateLastWorkflowAccessed;
begin
  if not Qrymain.Active then exit;
  if not GuiPrefs.Active then GuiPrefs.Active := True;
  if GuiPrefs.Node.Exists('Options.LastWorkflowAccessed') then
      if Qrymain.locate('ID', GuiPrefs.Node['Options.LastWorkflowAccessed'].asInteger , []) then begin
        grdmain.SelectRecord;
        setcontrolfocus(grdmain);
      end;
end;

procedure TWorkflowsGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LocateLastWorkflowAccessed;
end;

procedure TWorkflowsGUI.ReadnApplyGuiPrefExtra;
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

procedure TWorkflowsGUI.RefreshQuery;
begin
  if GrpLanguage.itemindex =0 then
    Qrymain.ParamByName('LanguageID').asInteger := TLanguageTranslationObj.Inst.UserLanguageId
  else
    Qrymain.ParamByName('LanguageID').asInteger := 0;
  inherited;
end;

procedure TWorkflowsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainId.FieldName);
  RemoveFieldfromGrid(QrymainLanguageID.FieldName);
  RemoveFieldfromGrid(qryMainTabGroup.FieldName);
end;



initialization
  RegisterClassOnce(TWorkflowsGUI);

end.

