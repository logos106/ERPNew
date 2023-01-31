unit frmExtraEmails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Shader, DNMPanel, Grids, Wwdbigrd, Wwdbgrid,
  DNMSpeedButton, Buttons;

type
  TfmExtraEmails = class(TBaseInputGUI)
    grdMain: TwwDBGrid;
    qryMaster: TERPQuery;
    DSMaster: TDataSource;
    qryMasterGlobalRef: TWideStringField;
    qryMasterForwardId: TIntegerField;
    qryMasterName: TWideStringField;
    qryMasterEMail: TWideStringField;
    qryMasterTask: TWideStringField;
    qryMastermsTimeStamp: TDateTimeField;
    qryMastermsUpdateSiteCode: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    qryMasterSilent: TWideStringField;
    btnDelete: TwwIButton;
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryMasterBeforePost(DataSet: TDataSet);
    procedure btnDeleteClick(Sender: TObject);
  private
    fTask : string;

    procedure ResizeTitle;
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    function GetTask: string;
    procedure SetTask(const Value: string);
  public
    { Public declarations }
    property Title : string read GetTitle write SetTitle;
    property Task : string read GetTask write SetTask;
  end;

implementation

{$R *.dfm}
uses
  CommonLib, PreferancesLib;

procedure TfmExtraEmails.btnCloseClick(Sender: TObject);
begin

  inherited;
  if qryMaster.Connection.InTransaction then
    qryMaster.Connection.Rollback;
  Self.Close;
end;

procedure TfmExtraEmails.btnCompletedClick(Sender: TObject);
begin
  Try
    inherited;
//    qryMaster.Edit;
    qryMaster.First;
    while not qryMaster.eof do
    begin
      if qryMaster.FieldByName('Email').AsString = '' then
        qryMaster.Delete;
      qryMaster.Next;
    end;
    qryMaster.First;
    while not qryMaster.Eof  do
    begin
      qryMaster.Edit;
      qryMaster.FieldByName('Silent').AsBoolean := true;
      qryMaster.Post;
      qryMaster.Next;
    end;
    qryMaster.Edit;
    qryMaster.Post;
    CommitTransaction;
    PreferancesLib.DoPrefAuditTrail;
    Self.close;
  except
    on e: Exception do begin
      RollbackTransaction;
      Self.Close;
    end;
  end;
end;

procedure TfmExtraEmails.btnDeleteClick(Sender: TObject);
begin
  qryMaster.Edit;
  qryMaster.Delete;
//  qryMaster.Post;
end;

procedure TfmExtraEmails.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmExtraEmails.FormShow(Sender: TObject);
begin
  inherited;

  ResizeTitle;
  OpenQueries;
  qryMaster.Open;
  grdMain.OnKeyDown := nil;  // disable Personal Tabs
  BeginTransaction;
end;

function TfmExtraEmails.GetTask: string;
begin
  Result := fTask;
end;

function TfmExtraEmails.GetTitle: string;
begin
  Result := TitleLabel.Caption;
end;

procedure TfmExtraEmails.qryMasterBeforePost(DataSet: TDataSet);
begin
  inherited;
    DataSet.FieldByName('Task').AsString := fTask;
  DataSet.FieldByName('Silent').AsBoolean := true;
end;

procedure TfmExtraEmails.ResizeTitle;
var
  lWidth : integer;
begin
  lWidth := TitleLabel.Canvas.TextWidth(TitleLabel.Caption);
  pnlTitle.Width := lWidth + 16;
  pnlTitle.Left := ((Self.ClientRect.Right - Self.ClientRect.Left) - pnlTitle.Width) div 2 + Self.ClientRect.Left;
end;

procedure TfmExtraEmails.SetTask(const Value: string);
var
  lState : TDataSetState;
begin
  if fTask = Value then
    exit;
  fTask := Value;
  lState := qryMaster.State;
  case lState of
    dsBrowse : begin
      qryMaster.Close;
      RollbackTransaction;
      end;
    dsEdit,
    dsInsert: begin
      qryMaster.Post;
      qryMaster.Close;
      RollbackTransaction;
      end;
    else ;
  end;

  qryMaster.SQL.Text := 'SELECT * from tblEmailForwards where Task="' + fTask + '"';

  if lState <> dsInactive then
  begin
    qryMaster.Open;
    BeginTransaction;
  end;

end;

procedure TfmExtraEmails.SetTitle(const Value: string);
begin
  TitleLabel.Caption := Value;
  Self.Caption := Value;
  ResizeTitle;
end;
initialization
  RegisterClassOnce(TfmExtraEmails);
end.
