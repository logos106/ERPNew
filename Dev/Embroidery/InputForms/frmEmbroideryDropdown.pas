unit frmEmbroideryDropdown;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 07/11/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, Buttons, DNMSpeedButton, Mask, DBCtrls, ExtCtrls,
  DNMPanel, SelectionDialog, AppEvnts, DB,  Grids, Wwdbigrd, Wwdbgrid,
  wwcheckbox, wwdblook, DBAccess, MyAccess, DataState, Menus, AdvMenus, MemDS,
  wwdbedit, Wwdotdot, Wwdbcomb, Shader;

type
  TEmbroideryDropdownGUI = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    btnCancel: TDNMSpeedButton;
    btnSave: TDNMSpeedButton;
    grdAxisValues: TwwDBGrid;
    qryMain: TMyQuery;
    dsMain: TDataSource;
    btnDelete: TwwIButton;
    cboAxis: TwwDBComboBox;
    Label1: TLabel;
    qryMainAxisType: TStringField;
    qryMainAxisValue: TStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grdAxisValuesExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cboAxisCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure qryMainBeforePost(DataSet: TDataSet);
  private
    procedure RefreshMainGrid;
  public
    { Public declarations }
  end;


implementation

uses
  Dnmlib, CommonLib;

{$R *.dfm}

{ TCustomiseDropdownGUI }

procedure TEmbroideryDropdownGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TEmbroideryDropdownGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult in [mrNone, mrCancel] then begin
    inherited;
    CloseQueries;
    RollbackTransaction;

    if fsModal in FormState then
      ModalResult := mrCancel
    else
      Action := caFree;
  end;    
end;

procedure TEmbroideryDropdownGUI.FormShow(Sender: TObject);
begin
  inherited;
  qryMain.Params.ParamByName('AxisType').asString := cboAxis.Text;
  OpenQueries;
  RefreshMainGrid;
end;

procedure TEmbroideryDropdownGUI.RefreshMainGrid;
begin
  qryMain.Close;
  qryMain.Params.ParamByName('AxisType').asString := cboAxis.Text;
  qryMain.Open;
end;

procedure TEmbroideryDropdownGUI.grdAxisValuesExit(Sender: TObject);
begin
  inherited;
  qryMain.Edit;
  qryMain.Post;
  qryMain.Edit;
end;

procedure TEmbroideryDropdownGUI.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := True;
  inherited;
  BeginTransaction;
end;

procedure TEmbroideryDropdownGUI.btnSaveClick(Sender: TObject);
begin
  inherited;

  try
    if MyConnection.InTransaction then begin
      qryMain.Edit;
      qryMain.Post;
      CommitTransaction;
    end;
  except
    RollbackTransaction;
  end;

  if fsModal in FormState then
    ModalResult := mrOK
  else
    Release;
end;

procedure TEmbroideryDropdownGUI.btnDeleteClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(grdAxisValues.DataSource.DataSet);
end;

procedure TEmbroideryDropdownGUI.cboAxisCloseUp(Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  RefreshMainGrid;
end;

procedure TEmbroideryDropdownGUI.qryMainBeforePost(DataSet: TDataSet);
begin
  inherited;
  DataSet.Edit;
  DataSet.FieldByName('AxisType').AsString := cboAxis.Text;
end;

initialization
  RegisterClassOnce(TEmbroideryDropdownGUI);
finalization
  UnRegisterClass(TEmbroideryDropdownGUI);
end.
