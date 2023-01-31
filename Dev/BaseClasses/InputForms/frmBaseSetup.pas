unit frmBaseSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, ComCtrls;

type
  TfmBaseSetup = class(TBaseInputGUI)
    pnkheader: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlFooter: TDNMPanel;
    btnCancel: TDNMSpeedButton;
    MainPage: TPageControl;
    TabSheet1: TTabSheet;
    sbMain: TScrollBox;
    mem_Note: TMemo;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  Protected
    Procedure highlightNewBtn(Sender: TObject); Virtual;
    procedure SetDefaultColor; override;
    Procedure InitDescLabel(pnlparent,pnlAction, pnlworkflow:TDnmPanel; Lbl:TLabel; Description:String; HideWorkFlow: boolean = false);
    Procedure Playworkflow(WorkflowID: Integer); overload;
    Procedure Playworkflow(WorkflowName: string); overload;
  public
    { Public declarations }
  end;


implementation

uses frmWorkflowPlay, BaseListingForm, StringUtils, tcConst, tcDataUtils,
  CommonLib;

{$R *.dfm}

procedure TfmBaseSetup.btnCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmBaseSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmBaseSetup.highlightNewBtn(Sender: TObject);
begin
  if Sender is TBaseListingGUI then begin
      TBaseListingGUI(sender).ListTimerMsg( 'Choose New to Create a New Record' , TBaseListingGUI(Sender).cmdNew );
  end;

end;

procedure TfmBaseSetup.InitDescLabel(pnlparent,pnlAction, pnlworkflow:TDnmPanel;Lbl: TLabel; Description: String; HideWorkFlow: boolean = false);
var
  fi:Integer;
begin
  lbl.caption := Description;
  fi := strCount(NL , Description);
  if fi <=1 then pnlparent.height := 80
  else pnlparent.height  := 80 + (fi-1)*20;
 pnlAction.top := 2;
 pnlworkflow.top := 40;
 pnlAction.Left := pnlparent.width - pnlAction.width -10;
 pnlworkflow.Left := pnlAction.Left ;
 pnlAction.visible := True;
 pnlworkflow.visible := not HideWorkFlow;
end;



procedure TfmBaseSetup.SetDefaultColor;
var
  x: integer;
begin
  inherited;
  for x := 0 to self.ComponentCount -1 do begin
    if self.Components[x] is TShader then begin
      if self.Components[x].Tag = 1 then begin
        TShader(self.Components[x]).FromColor := $00B7FFB7;
        TShader(self.Components[x]).ToColorMirror :=$00B7FFB7;
      end
      else if self.Components[x].Tag = 2 then begin
        TShader(self.Components[x]).FromColor := $00CAFFFF;
        TShader(self.Components[x]).ToColorMirror :=$0080FFFF;
      end;
      TShader(self.Components[x]).caption := '';
    end else if self.Components[x] is TDnmPanel then begin
      TDnmPanel(self.Components[x]).caption := '';
    end;
  end;
end;

procedure TfmBaseSetup.Playworkflow(WorkflowName: string);
var
  WorkflowID: integer;
begin
  ProcessingCursor(True);
  try
    WorkFlowId := tcDataUtils.WorkflowID(WorkFlowName);
    if WorkflowID =0 then begin
      MessageDlgXP_Vista('Workflow "'+WorkFlowName+'" is missing in the system. Please contact ERP', mtWarning, [mbOK], 0);
      Exit;
    end;
    WorkflowPlayForm.Playworkflow(WorkflowID)
  finally
    ProcessingCursor(False);
  end;
end;

procedure TfmBaseSetup.Playworkflow(WorkflowID: Integer);
begin
  if WorkflowID =0 then begin
    MessageDlgXP_Vista('Specified workflow is missing in the system. Please contact ERP', mtWarning, [mbOK], 0);
    Exit;
  end;
  ProcessingCursor(True);
  try
    WorkflowPlayForm.Playworkflow(WorkflowID)
  finally
    ProcessingCursor(False);
  end;
end;
end.
