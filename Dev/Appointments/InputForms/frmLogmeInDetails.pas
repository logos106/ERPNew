unit frmLogmeInDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Mask, DBCtrls, Shader, DNMPanel, MemDS, ImgList;

type
  TfmLogmeInDetails = class(TBaseInputGUI)
    qryContacts: TERPQuery;
    qryContactsGlobalRef: TWideStringField;
    qryContactsContactID: TAutoIncField;
    frmContactSrc: TDataSource;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label2: TLabel;
    txtCompany: TDBEdit;
    qryContactsLogMeInComputerIPAddress: TWideStringField;
    qryContactsLogMeInContactEmail: TWideStringField;
    qryContactsLogMeInEmailPassword: TWideStringField;
    qryContactsLogMeInUserName: TWideStringField;
    qryContactsLogMeInPassword: TWideStringField;
    qryContactsLogMeInERPUserName: TWideStringField;
    qryContactsLogMeInERPPassword: TWideStringField;
    qryContactsCompany: TWideStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    btnOk: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    Box72: TBevel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    qryContactsLogMeIncomputerPassword: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses CommonLib, frmPhSupportLog;

{$R *.dfm}
procedure TfmLogmeInDetails.FormShow(Sender: TObject);
var
  StatusAndToolbarHeight:Integer;
begin
  inherited;
  StatusAndToolbarHeight := commonlib.StatusAndToolbarHeight;
  Left := Application.MainForm.Left + ((Application.MainForm.ClientWidth - Self.Width) shr 1);

  if (Self.FormStyle <> fsMDIChild) then begin
    Top := ((Application.MainForm.ClientHeight + StatusAndToolbarHeight) - Self.Height) shr 1;
  end else begin
    Top := ((Application.MainForm.ClientHeight - StatusAndToolbarHeight) - Self.Height) shr 1;
  end;
  if qryContacts.Active then qryContacts.Close;
  qryContacts.Params.ParamByName('KeyID').AsInteger := KeyID;
  qryContacts.Open;
  TitleLabel.Caption := qryContactsCompany.asString;
  Self.Caption := qryContactsCompany.asString +' LogInMe Details';
end;
procedure TfmLogmeInDetails.btnOkClick(Sender: TObject);
begin
  inherited;
  if qryContacts.State in [dsEdit, dsInsert] then qryContacts.Post;
  if MyConnection.InTransaction then MyConnection.Commit;
  if Assigned(Self.Owner) and (Self.Owner is TPhSupportLogGUI) then begin
    if TPhSupportLogGUI(Self.Owner).qryContacts.active then TPhSupportLogGUI(Self.Owner).qryContacts.Close;
    TPhSupportLogGUI(Self.Owner).qryContacts.Open;
  end;
  Self.close; 
end;

procedure TfmLogmeInDetails.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if qryContacts.State in [dsEdit, dsInsert] then qryContacts.Cancel;
  if MyConnection.InTransaction then MyConnection.Rollback;
  Self.close;
end;

procedure TfmLogmeInDetails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

initialization
  RegisterClassOnce(TfmLogmeInDetails);

end.
