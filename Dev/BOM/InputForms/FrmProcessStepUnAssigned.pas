unit FrmProcessStepUnAssigned;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Shader, DNMPanel, DNMSpeedButton, Buttons,
  Wwdbigrd, Grids, Wwdbgrid;

type
  TFmProcessStepUnAssigned = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    qryNoEmp: TERPQuery;
    dsNoEmp: TDataSource;
    dsNoRes: TDataSource;
    qryNoRes: TERPQuery;
    qryNoResProcessstep: TWideStringField;
    qryNoEmpProcessstep: TWideStringField;
    qryNoResProcessStepId: TIntegerField;
    qryNoEmpProcessStepId: TIntegerField;
    DNMPanel2: TDNMPanel;
    Label3: TLabel;
    DNMPanel4: TDNMPanel;
    Label1: TLabel;
    grdNoEmp: TwwDBGrid;
    btnGrid: TwwIButton;
    DNMPanel5: TDNMPanel;
    Label2: TLabel;
    grdNoRes: TwwDBGrid;
    wwIButton1: TwwIButton;
    procedure FormShow(Sender: TObject);
    procedure grdNoEmpDblClick(Sender: TObject);
    procedure grdNoResDblClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
  private
    procedure initProcessStepId(Sender: TObject);
  public
  end;


implementation

uses CommonFormLib, frmProcResourceEdit, CommonLib;

{$R *.dfm}

procedure TFmProcessStepUnAssigned.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if (fsModal in self.FormState) then modalresult := mrOk else Self.close;
end;

procedure TFmProcessStepUnAssigned.FormShow(Sender: TObject);
begin
  inherited;
  Openqueries;
  windowState := wsNormal;
end;

procedure TFmProcessStepUnAssigned.grdNoEmpDblClick(Sender: TObject);
begin
  inherited;
  if qryNoEmpProcessStepId.asInteger =0 then exit;
  if (fsModal in self.FormState) then OpenERPFormModal('TfmProcessStep' , qryNoEmpProcessStepId.asInteger ) else OpenERPForm('TfmProcessStep' , qryNoEmpProcessStepId.asInteger );
end;
procedure TFmProcessStepUnAssigned.grdNoResDblClick(Sender: TObject);
begin
  inherited;
  if qryNoResProcessStepId.asInteger =0 then exit;
  if (fsModal in self.FormState) then OpenERPFormModal('TfmProcResourceEdit' , 0 ,initProcessStepId) else OpenERPForm('TfmProcResourceEdit' , 0 ,initProcessStepId );
end;
procedure TFmProcessStepUnAssigned.initProcessStepId(Sender: TObject);
begin
  if not(Sender is TfmProcResourceEdit) then exit;
  TfmProcResourceEdit(Sender).ProcessStepID := qryNoResProcessStepId.asInteger;
end;
initialization
  RegisterClassOnce(TFmProcessStepUnAssigned);
end.
