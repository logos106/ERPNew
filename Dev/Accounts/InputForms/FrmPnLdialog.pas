unit frmPnLdialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, dblookup, DBCtrls;

type
  TfmPnLdialog = class(TBaseInputGUI)
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
    SelectedGroup : Integer;
    IsGroup : Boolean;
    GroupName : string;
  end;

var
  fmPnLdialog: TfmPnLdialog;

implementation

{$R *.dfm}

procedure TfmPnLdialog.FormCreate(Sender: TObject);
begin
  inherited;
  GroupName := '';
end;

procedure TfmPnLdialog.btnAppltyClick(Sender: TObject);
begin
  inherited;

    if cboGroups.Text = '' then begin
    ModalResult := mrNone;
    Exit;
  end;

  if IsGroup and (edtGroupName.Text = '') then begin
    ShowMessage('Input group name');
    ModalResult := mrNone;
    Exit;
  end;

  SelectedGroup := cboGroups.KeyValue;
  if IsGroup then GroupName := edtGroupName.Text;
end;

procedure TfmPnLdialog.FormShow(Sender: TObject);
begin
  inherited;

    // Refresh the combo
  qryGroups.Active := False;
  qryGroups.Active := True;

  if IsGroup then begin
    lblName.Visible := True;
    edtGroupName.Visible := True;
  end
  else begin
    lblName.Visible := False;
    edtGroupName.Visible := False;
  end;

end;

end.
