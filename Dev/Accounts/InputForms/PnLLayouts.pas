unit PnLLayouts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Shader, DNMSpeedButton, DNMPanel, Grids, Wwdbigrd,
  Wwdbgrid, PnLLayout;

type
  TfrmPnlLayouts = class(TBaseInputGUI)
    HeaderPanel: TPanel;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Panel1: TPanel;
    grdMain: TwwDBGrid;
    FooterPanel: TDNMPanel;
    btnSave: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    qryMain: TMyQuery;
    dsMain: TDataSource;
    qryMainLayoutID: TIntegerField;
    qryMainLName: TWideStringField;
    Panel2: TPanel;
    pnlButtons: TPanel;
    btnRequery: TDNMSpeedButton;
    btnOpen: TDNMSpeedButton;
    qryMainDefaultLayout: TWideStringField;
    qryTemp: TMyQuery;
    btnDelete: TDNMSpeedButton;
    qryMainIsCurrentLayout: TWideStringField;
    procedure btnRequeryClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);
    procedure qryMainAfterPost(DataSet: TDataSet);
    procedure btnDeleteClick(Sender: TObject);

  private
    DefaultID : Integer;

  public
    { Public declarations }
  end;

var
  frmPnlLayouts: TfrmPnlLayouts;

implementation

uses CommonFormLib, CommonLib;

{$R *.dfm}

procedure TfrmPnlLayouts.btnDeleteClick(Sender: TObject);
var
  LID : Integer;
begin
  inherited;

  if qryMainDefaultLayout.Value = 'T' then begin
    MessageDlgXP_Vista('Default layout can not be deleted.', mtWarning, [mbOK], 0);
    Exit;
  end;

  if MessageDlgXP_Vista('Are you sure to delete the group?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    qryMain.Delete;
    qryMain.Close;
    qryMain.Open;
  end;

end;

procedure TfrmPnlLayouts.btnOpenClick(Sender: TObject);
var
  frmLayout : TfmPnLLayout;
begin
  inherited;
  try
    frmLayout := TfmPnLLayout.Create(nil);
    frmLayout.LayoutID := qryMainLayoutID.Value;
    frmLayout.ShowModal;
  finally
    frmLayout.Free;
  end;
end;

procedure TfrmPnlLayouts.btnRequeryClick(Sender: TObject);
begin
  inherited;
  qryMain.Close;
  qryMain.Open;
end;

procedure TfrmPnlLayouts.btnSaveClick(Sender: TObject);
begin
  inherited;
  qryMain.Post;
end;

procedure TfrmPnlLayouts.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmPnlLayouts.FormShow(Sender: TObject);
begin
  inherited;

  with qryMain do begin
    Close;
    Open;
    Locate('DefaultLayout', 'T', []);
    DefaultID := FieldByName('LayoutID').AsInteger;
  end;

end;

procedure TfrmPnlLayouts.grdMainDblClick(Sender: TObject);
begin
  inherited;
  btnOpenClick(nil);
end;

procedure TfrmPnlLayouts.qryMainAfterPost(DataSet: TDataSet);
var
  LID : Integer;
begin
  inherited;

//  // Get the modified ID
//  LID := qryMain.FieldByName('LayoutID').AsInteger;
//
//  // Duplicate data from default layout
//  with qryTemp do begin
//    SQL.Clear;
//    SQL.Add('DELETE FROM tblPnLLayoutData WHERE layoutid=' + IntToStr(LID) + ';');
//    SQL.Add('INSERT INTO tblpnllayoutdata (Parent, Pos, `Name`, IsAccount, IsRoot, AccountID, LayoutID)');
//    SQL.Add('SELECT Parent, Pos, `Name`, IsAccount, IsRoot, AccountID, ' + IntToStr(LID));
//    SQL.Add('FROM tblpnllayoutdata WHERE layoutID=' + IntToStr(DefaultID));
//
//    Execute;
//  end;

end;

initialization
  RegisterClassOnce(TfrmPnlLayouts);

end.
