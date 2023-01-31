unit frm_InstallPath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DNMSpeedButton, jpeg;

type
  TSetupType = (tstServer, tstUser, tstService);

  TfrmInstallPath = class(TForm)
  {$WARN SYMBOL_PLATFORM OFF}
    FileOpenDialog1: TFileOpenDialog;
    FileOpenDialog2: TFileOpenDialog;
    pnlTop: TPanel;
    lblHeader: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Edit2: TEdit;
    SpeedButton2: TSpeedButton;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Image1: TImage;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    fSetupType: TSetupType;
    fUserDir: string;
    fServerDir: string;
    fMySqlDir: string;
    FMySQLChanged: boolean;
    FUserChanged: boolean;
    FServerChanged: boolean;
    procedure SetSetupType(const Value: TSetupType);
    procedure ResizeLabels;
    procedure ResizeEdits;
    function FormatPath(const aPath : string) : string;
    {$WARN SYMBOL_PLATFORM OFF}
    procedure SetupMySql(aDialog : TFileOpenDialog);
    procedure SetupUser(aDialog : TFileOpenDialog);
    procedure SetupServer(aDialog : TFileOpenDialog);
    {$WARN SYMBOL_PLATFORM ON}
    procedure SetMySQLChanged(const Value: boolean);
    procedure SetServerChanged(const Value: boolean);
    procedure SetUserChanged(const Value: boolean);
  protected
    property UserDir : string read fUserDir write fUserDir;
    property ServerDir : string read fServerDir write fServerDir;
    property MySQLDir : string read fMySqlDir write fMySqlDir;
    property MySQLChanged : boolean read FMySQLChanged write SetMySQLChanged;
    property ServerChanged : boolean read FServerChanged write SetServerChanged;
    property UserChanged : boolean read FUserChanged write SetUserChanged;
  public
    { Public declarations }
    property SetupType : TSetupType read fSetupType write SetSetupType;
  end;


  function SetFolders(aType : TSetupType): boolean;

implementation

{$R *.dfm}
uses
  InstallConst;

procedure TfrmInstallPath.BitBtn1Click(Sender: TObject);
var
  lSave : boolean;
begin
  lSave := false;
  case SetupType of
    tstServer:
      begin
//        if MySQLDir <>  MySQL_ERP_DIR then
        if MySQLChanged then
        begin
//          ERPConfiguration.MySQL_ERP_DIR := MySQLDir;
          ERPConfiguration.MySQL_ERP_DIR := Edit1.Text;
          lSave := true;
          ForceDirectories(Edit1.Text);
        end;

        if ServerChanged then
        begin
        //  if ServerDir <> ERP_SERVER_ROOT_DIR then
        begin
        //  ERPConfiguration.ERP_SERVER_ROOT_DIR := ServerDir;
          ERPConfiguration.ERP_SERVER_ROOT_DIR := Edit2.Text;
          lSave := true;
          ForceDirectories(Edit2.Text);
        end;
        end;
      end;
    tstUser:
      //if UserDir <> ERP_USER_ROOT_DIR then
      if UserChanged then
      begin
        //ERPConfiguration.ERP_USER_ROOT_DIR := UserDir;
        ERPConfiguration.ERP_USER_ROOT_DIR := Edit1.Text;
        lSave := true;
        ForceDirectories(Edit1.Text);
      end;
    tstService:
      //if ServerDir <> ERP_SERVER_ROOT_DIR then
      if ServerChanged then
      begin
        //ERPConfiguration.ERP_SERVER_ROOT_DIR := ServerDir;
        ERPConfiguration.ERP_SERVER_ROOT_DIR := Edit1.Text;
        lSave := true;
        ForceDirectories(Edit1.Text);
      end;
  end;
  if lSave then
    ERPConfiguration.Save;
end;

procedure TfrmInstallPath.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmInstallPath.btnOKClick(Sender: TObject);
begin
  BitBtn1Click(Sender);
  ModalResult := mrOK;
end;

procedure TfrmInstallPath.Edit1Change(Sender: TObject);
begin
  case SetupType of
    tstServer: MysqlChanged := true;
    tstUser: UserChanged := true;
    tstService: ServerChanged := true;
  end;

end;

procedure TfrmInstallPath.Edit2Change(Sender: TObject);
begin
  if SetupType = tstServer then
    ServerChanged := true;
end;

function TfrmInstallPath.FormatPath(const aPath: string): string;
var
  idx,
  lPos : integer;
begin
  lPos := Pos(':', aPath);
  Result := aPath;
  if lPos > 0 then
    for idx := 1 to lPos - 1 do
      Result[idx] := UpCase(Result[idx]);
end;

procedure TfrmInstallPath.FormCreate(Sender: TObject);
begin
  UserDir := ERP_USER_ROOT_DIR;
  ServerDir := ERP_SERVER_ROOT_DIR;
  MySqlDir := MySQL_ERP_DIR;
end;

procedure TfrmInstallPath.ResizeEdits;
var
  delta : integer;
begin
// second edit set to invisible
  Delta := Edit2.Top + Edit2.Height - Label2.Top;
  Self.Height := Self.Height - Delta;
end;

procedure TfrmInstallPath.ResizeLabels;
begin
  lblHeader.Left := (pnlTop.ClientWidth - lblHeader.Width) div 2;
end;

procedure TfrmInstallPath.SetMySQLChanged(const Value: boolean);
begin
  FMySQLChanged := Value;
end;

procedure TfrmInstallPath.SetServerChanged(const Value: boolean);
begin
  FServerChanged := Value;
end;

procedure TfrmInstallPath.SetSetupType(const Value: TSetupType);
begin
  fSetupType := Value;
  case SetupType of
    tstServer: begin
      Label1.Caption := 'TrueERP Server Path';
      Label2.Caption := 'TrueERP Utilities Path';
      Edit1.Text := FormatPath(MySQL_ERP_DIR);
      Edit2.Text := FormatPath(ERP_SERVER_ROOT_DIR);
      lblHeader.Caption := 'Server Install';
      end;
    tstUser: begin
      lblHeader.Caption := 'User Install';
      Label1.Caption := 'TrueERP User Path';
      Edit1.Text := FormatPath(ERP_USER_ROOT_DIR);
      Label2.Visible := false;
      Edit2.Visible := false;
      SpeedButton2.Visible := false;
      ResizeEdits;
      end;
    tstService: begin
      lblHeader.Caption := 'Services Install';
      Label1.Caption := 'TrueERP Utilities Path';
      Edit1.Text := FormatPath(ERP_SERVER_ROOT_DIR);
      Label2.Visible := false;
      Edit2.Visible := false;
      SpeedButton2.Visible := false;
      ResizeEdits;
      end;
  end;
  ResizeLabels;
end;
{$WARN SYMBOL_PLATFORM OFF}
procedure TfrmInstallPath.SetupMySql(aDialog: TFileOpenDialog);
begin
  aDialog.DefaultFolder := MySQLDir;
  if aDialog.Execute then
  begin
    MySQLDir := FormatPath(aDialog.Files[0]);
    Edit1.Text := MySQLDir;
    MySQLChanged := true;
  end;
end;

procedure TfrmInstallPath.SetupServer(aDialog: TFileOpenDialog);
begin
  aDialog.DefaultFolder := ServerDir;
  if aDialog.Execute then
  begin
    ServerDir := FormatPath(aDialog.Files[0]);
    if aDialog = FileOpenDialog1 then
      Edit1.Text := FormatPath(ServerDir)
    else
      Edit2.Text := FormatPath(ServerDir);
    ServerChanged := true;
  end;
end;

procedure TfrmInstallPath.SetupUser(aDialog: TFileOpenDialog);
begin
  aDialog.DefaultFolder := UserDir;
  if aDialog.Execute then
  begin
    UserDir := FormatPath(aDialog.Files[0]);
    Edit1.Text := UserDir;
    UserChanged := true;
  end;
end;
{$WARN SYMBOL_PLATFORM ON}
procedure TfrmInstallPath.SetUserChanged(const Value: boolean);
begin
  FUserChanged := Value;
end;

procedure TfrmInstallPath.SpeedButton1Click(Sender: TObject);
begin
//
  case SetupType of
   tstServer : SetupMySql(FileOpenDialog1);
   tstUser : SetupUser(FileOpenDialog1);
   tstService : SetupServer(FileOpenDialog1);
  end;
end;

procedure TfrmInstallPath.SpeedButton2Click(Sender: TObject);
begin
  SetupServer(FileOpenDialog2);
end;

//======================================================//
function SetFolders(aType : TSetupType): boolean;
var
  lForm : TfrmInstallPath;
begin
  lForm := TfrmInstallPath.Create(nil);
  try
    lForm.SetupType := aType;
    Result := lForm.ShowModal = mrOk;
  finally
    lForm.Free;
  end;
end;

end.
