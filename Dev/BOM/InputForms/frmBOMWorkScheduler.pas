unit frmBOMWorkScheduler;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSizeablePanel, DNMPanel, Shader , BaseListingForm,
  DNMSpeedButton, Grids, Wwdbigrd, Wwdbgrid, frmBOMWorkOrder;

type
  TfmBOMWorkScheduler = class(TBaseInputGUI)
    pnlMain: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    PnlBOMJobs: TDNMSizeablePanel;
    pnlResources: TDNMSizeablePanel;
    pnlDetails: TDNMPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    btnDefaultWidth: TDNMSpeedButton;
    PnlBOMJobsPnl: TDNMPanel;
    DNMPanel1: TDnmPanel;
    lblBomJobs: TLabel;
    DNMPanel6: TDnmPanel;
    lblEmployeesnProcess: TLabel;
    DNMPanel7: TDnmPanel;
    lblWorkOrders: TLabel;
    chkHideemployeenProcess: TCheckBox;
    grdEmpProcess: TwwDBGrid;
    dsPS: TDataSource;
    QryPS: TERPQuery;
    QryPSEmployeeName: TWideStringField;
    QryPSdescription: TWideStringField;
    tmrSubForms: TTimer;
    
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDefaultWidthClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure chkHideemployeenProcessClick(Sender: TObject);
    procedure DNMPanel3DblClick(Sender: TObject);
    procedure tmrSubFormsTimer(Sender: TObject);
  private
    fiOldWidth:Integer;
    BOMJobs : TBaseListingGUI;
    BOMWorkOrder : TfmBOMWorkOrder;
    Procedure ReadguiPrefs;
    Procedure WriteguiPrefs;
    procedure ShowBOMjobs;
    Procedure ShowBomWorkOrders;
  public
    Procedure Allocate(PPID, PSID, PTID, employeeId: Integer; aDate:TDate; aDuration:Integer);
  end;


implementation

uses  CommonLib, CommonFormLib ;

{$R *.dfm}

procedure TfmBOMWorkScheduler.Allocate(PPID, PSID, PTID, employeeId: Integer; aDate:TDate; aDuration:Integer);
begin
  BOMWorkOrder.Allocate(PPID, PSID, PTID, employeeId, aDate, aDuration);
end;

procedure TfmBOMWorkScheduler.btnDefaultWidthClick(Sender: TObject);
begin
  inherited;
  PnlBOMJobs.Width := trunc(PnlBOMJobs.Parent.Width/3);
  pnlResources.Width := PnlBOMJobs.Width;
end;

procedure TfmBOMWorkScheduler.chkHideemployeenProcessClick(Sender: TObject);
begin
  inherited;
  pnlResources.Visible := chkHideemployeenProcess.checked =False;
  if pnlResources.Visible  then pnlResources.Left :=   PnlBOMJobs.width;
  if IsFormshown then
      if pnlResources.Visible then  PnlBOMJobs.Width := PnlBOMJobs.Width  - pnlResources.Width else  PnlBOMJobs.Width := PnlBOMJobs.Width  + pnlResources.Width;
end;

procedure TfmBOMWorkScheduler.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfmBOMWorkScheduler.DNMPanel3DblClick(Sender: TObject);
begin
  inherited;
  if DEvmode then begin
    lblBomJobs.caption :=BOMJobs.Classname;
    lblWorkOrders.caption :=BOMWorkOrder.Classname;
    tmrSubForms.enabled := True;
  end;

end;

procedure TfmBOMWorkScheduler.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteguiPrefs;
  inherited;
  Action := caFree;
end;

procedure TfmBOMWorkScheduler.FormResize(Sender: TObject);
var
  xRatio:double;
begin
  if not (isformshown) then exit;
  xRatio := Width / fiOldWidth;
  try
    PnlBOMJobs.Width := trunc(PnlBOMJobs.Width*xRatio);
    pnlResources.Width := trunc(pnlResources.Width*xRatio);
  finally
    fiOldWidth:= Self.Width;
  end;
end;

procedure TfmBOMWorkScheduler.FormShow(Sender: TObject);
(*var
  QueryNamesNotToOpen: Array Of String;*)
begin
  inherited;
(*  Setlength(QueryNamesNotToOpen, 1);
  QueryNamesNotToOpen[1] := 'tblMaster';
  OpenQueries(QueryNamesNotToOpen);*)
  OpenQueries;
  ReadguiPrefs;
  fiOldWidth:=Self.Width;
  showBOMjobs;
  ShowBomWorkOrders;
end;
Procedure TfmBOMWorkScheduler.ShowBOMjobs;
var
  i:Integer;
Procedure showfromBOMJobs(const control :Tcontrol);
begin
   control.anchors:= [akleft, akTop];
   control.Left   := control.left  - i;
   control.Parent   := PnlBOMJobsPnl;
   control.visible   := True;
   control.Top := control.top ;
end;
begin
  CreateHistorylistform('TBOMJobsForWorkOrdersGUI' ,Self, BOMJobs);
  BOMJobs.grdmain.Parent:= PnlBOMJobsPnl;
  BOMJobs.grdmain.align := albottom;
  BOMJobs.grdmain.Anchors := [akleft,aktop,akbottom,aktop];
  BOMJobs.grdmain.height :=PnlBOMJobspnl.Height-35 ;
  i:= BOMJobs.chkIgnoreDates.Left-10 ;

  showfromBOMJobs(BOMJobs.cboDateRange);
  showfromBOMJobs(BOMJobs.chkIgnoreDates);
  showfromBOMJobs(BOMJobs.dtFrom);
  showfromBOMJobs(BOMJobs.dtTo);
  showfromBOMJobs(BOMJobs.lblTo);
  showfromBOMJobs(BOMJobs.lblFrom);
  BOMJobs.fbIgnoreQuerySpeed := true;
  try
    BOMJobs.formShow(BOMJobs);
  except
    FreeAndNil(BOMJobs);
  end;
end;

procedure TfmBOMWorkScheduler.ShowBomWorkOrders;
begin
  BOMWorkOrder := TfmBOMWorkOrder.Create(nil);
  BOMWorkOrder.grdBOMWorkOrder.parent := pnlDetails;
  BOMWorkOrder.grdBOMWorkOrder.Align :=  alclient;
  BOMWorkOrder.KeyID := 0;
  BOMWorkOrder.FormShow(BOMWorkOrder);
  BOMWorkOrder.PnlTop.visible := False;
  BOMWorkOrder.pnlBottom.visible := False;
end;

procedure TfmBOMWorkScheduler.tmrSubFormsTimer(Sender: TObject);
begin
  inherited;
    lblBomJobs.caption :='BOM Jobs';
    lblWorkOrders.caption :='Work Orders';
    tmrSubForms.enabled := False;
end;

procedure TfmBOMWorkScheduler.ReadguiPrefs;
begin
  if not GuiPrefs.active then GuiPrefs.active := true;
  if GuiPrefs.Node.Exists('Options.PnlBOMJobsWith')                 then PnlBOMJobs.Width               := GuiPrefs.Node['Options.PnlBOMJobsWith'].asInteger;
  if GuiPrefs.Node.Exists('Options.pnlResourcesWith')               then pnlResources.Width             := GuiPrefs.Node['Options.pnlResourcesWith'].asInteger;
  if GuiPrefs.Node.Exists('Options.grdEmpProcessDescriptionwidth')  then QryPSdescription.DisplayWidth  := GuiPrefs.Node['Options.grdEmpProcessDescriptionwidth'].asInteger;
  if GuiPrefs.Node.Exists('Options.grdEmpProcessEmpNameWidth')      then QryPSEmployeeName.DisplayWidth := GuiPrefs.Node['Options.grdEmpProcessEmpNameWidth'].asInteger;
  if GuiPrefs.Node.Exists('Options.HideemployeenProcess')           then chkHideemployeenProcess.Checked:= GuiPrefs.Node['Options.HideemployeenProcess'].asBoolean;
end;

procedure TfmBOMWorkScheduler.WriteguiPrefs;
begin
   GuiPrefs.Node['Options.PnlBOMJobsWith'].asInteger                := PnlBOMJobs.Width;
   GuiPrefs.Node['Options.pnlResourcesWith'].asInteger              := pnlResources.Width;
   GuiPrefs.Node['Options.grdEmpProcessDescriptionwidth'].asInteger := QryPSdescription.DisplayWidth;
   GuiPrefs.Node['Options.grdEmpProcessEmpNameWidth'].asInteger     := QryPSEmployeeName.DisplayWidth;
   GuiPrefs.Node['Options.HideemployeenProcess'].asBoolean          := chkHideemployeenProcess.Checked;
  fbIsLocalPrefChanged := True;
end;

initialization
 RegisterClassOnce(TfmBOMWorkScheduler);

end.
