unit PnLdialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, dblookup, DBCtrls;

type
  TfrmPnLDialog = class(TBaseInputGUI)
    qryGroups: TMyQuery;
    dsGroups: TDataSource;
    lblName: TLabel;
    lblGroup: TLabel;
    edtGroupName: TEdit;
    btnApplty: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    cboGroups: TDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnAppltyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    LayoutID : Integer;
    SelectedGroup : Integer;
    IsGroup : Boolean;
    IsRename : Boolean;
    GroupName : string;
  end;

var
  frmPnLdialog: TfrmPnLdialog;

implementation

uses CommonLib;

{$R *.dfm}

procedure TfrmPnLdialog.FormCreate(Sender: TObject);
begin
  inherited;
  GroupName := '';
end;

procedure TfrmPnLdialog.FormShow(Sender: TObject);
begin
  inherited;

    // Refresh the combo
  qryGroups.ParamByName('lid').AsInteger := LayoutID;
  qryGroups.Active := False;
  qryGroups.Active := True;

  if IsGroup then begin
    lblName.Visible := True;
    edtGroupName.Visible := True;
  end
  else if IsRename then begin
    lblName.Visible := True;
    edtGroupName.Visible := True;
    edtGroupName.Text := GroupName;
    lblGroup.Visible := False;
    cboGroups.Visible := False;
  end
  else begin
    lblName.Visible := False;
    edtGroupName.Visible := False;
  end;
end;

procedure TfrmPnLdialog.btnAppltyClick(Sender: TObject);
begin
  inherited;

  if not IsRename and (cboGroups.Text = '') then begin
    ModalResult := mrNone;
    Exit;
  end;

  if (IsGroup or IsRename) and (edtGroupName.Text = '') then begin
    ShowMessage('Input group name');
    ModalResult := mrNone;
    Exit;
  end;

  if VarIsNull(cboGroups.KeyValue) then
    SelectedGroup := 0
  else
    SelectedGroup := cboGroups.KeyValue;

  if IsGroup or IsRename then GroupName := edtGroupName.Text;
end;

initialization

  RegisterClassOnce(TfrmPnLdialog);

end.
