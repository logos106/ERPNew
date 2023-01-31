unit frmAUSKeyLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, Shader, DNMPanel, SBR_Stub, wwcheckbox, AUSKeyConfigObj,
  JsonObject;

type
  TfmAUSKeyLogin = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdLogon: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    edtKeyFile: TEdit;
    Label1: TLabel;
    btnOPenKeyFile: TButton;
    cboEntity: TComboBox;
    Label2: TLabel;
    edtPassword: TEdit;
    Label3: TLabel;
    chkSavePassword: TwwCheckBox;
    OpenDialog: TOpenDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOPenKeyFileClick(Sender: TObject);
    procedure edtKeyFileChange(Sender: TObject);
    procedure cmdLogonClick(Sender: TObject);
  private
    json: TJsonObject;
    procedure LoadEntitys;
  public
    SBR: TSBR;
    Config: TAUSKeyConfig;
  end;

  function ValidateUser(aSBR: TSBR; aConfig: TAUSKeyConfig): boolean;

implementation

uses
  CommonLib, SystemLib;

{$R *.dfm}

function ValidateUser(aSBR: TSBR; aConfig: TAUSKeyConfig): boolean;
var
  form: TfmAUSKeyLogin;
begin
  form := TfmAUSKeyLogin.Create(nil);
  try
    form.SBR := aSBR;
    form.Config := aConfig;
    result := form.ShowModal = mrOK;
  finally
    form.Free;
  end;
end;

procedure TfmAUSKeyLogin.btnOPenKeyFileClick(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute then
    edtKeyFile.Text := OpenDialog.FileName;
end;

procedure TfmAUSKeyLogin.cmdLogonClick(Sender: TObject);
var
  id: string;
  msg: string;
begin
  inherited;
  if edtKeyFile.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please select a Key File',mtInformation,[mbOk],0);
    exit;
  end;
  if not FileExists(edtKeyFile.Text) then begin
    CommonLib.MessageDlgXP_Vista('The selected Key File can not be found.',mtInformation,[mbOk],0);
    exit;
  end;
  if cboEntity.ItemIndex = -1 then begin
    CommonLib.MessageDlgXP_Vista('Please select an Entity to Log In as.',mtInformation,[mbOk],0);
    exit;
  end;
  if edtPassword.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please Enter a Password.',mtInformation,[mbOk],0);
    exit;
  end;
  id := TJsonObject(cboEntity.Items.Objects[cboEntity.ItemIndex]).S['id'];
  if not SBR.ValidatePassword(edtKeyFile.Text,id,edtPassword.Text,msg) then begin
    CommonLib.MessageDlgXP_Vista(msg, mtInformation,[mbOk],0);
    exit;
  end;
  Config.KeyFilePath := edtKeyfile.Text;
  Config.SelectedID := id;
  Config.SavePassword := chkSavePassword.Checked;
  if Config.SavePassword then
    Config.Password := edtPassword.Text
  else
    Config.Password := '';
  ModalResult := mrOk;
end;

procedure TfmAUSKeyLogin.edtKeyFileChange(Sender: TObject);
begin
  inherited;
  if not edtKeyFile.Focused then exit;
  LoadEntitys;
end;

procedure TfmAUSKeyLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmAUSKeyLogin.FormCreate(Sender: TObject);
begin
  inherited;
  json := JO;
end;

procedure TfmAUSKeyLogin.FormDestroy(Sender: TObject);
begin
  inherited;
  json.Free;
end;

procedure TfmAUSKeyLogin.FormShow(Sender: TObject);
var
  defaultFile: string;
begin
  inherited;
  defaultFile := SystemLib.GetRoamingAppDataDir + 'AUSkey\keystore.xml';
  edtKeyFile.Text := Config.KeyFilePath;
  if (edtKeyFile.Text = '') and FileExists(defaultFile) then
    edtKeyFile.Text := defaultFile;
  chkSavePassword.Checked := Config.SavePassword;
  if Config.SavePassword then
    edtPassword.Text := Config.Password;
  if (edtKeyFile.Text <> '') then
    LoadEntitys;
end;

procedure TfmAUSKeyLogin.LoadEntitys;
var
  x: integer;
  o, res: TJsonObject;
begin
  if FileExists(edtKeyFile.Text) then begin
    cboEntity.Clear;
    SBR.KeyStoreFileName := edtKeyFile.Text;
    res := SBR.GetKeyStoreData;
    try
      if not SameText(res.S['Result'], 'ok') then begin
        if res.S['Description'] <> '' then
          CommonLib.MessageDlgXP_Vista('Could not read list of entities from key file: ' + res.S['Description'], mtInformation,[mbOk],0)
         else
          CommonLib.MessageDlgXP_Vista('Could not read list of entities from key file.', mtInformation,[mbOk],0);
         exit;
      end;
      json.Assign(res.O['Data']);
    finally
      res.Free;
    end;

    for x := 0 to json.A['credentials'].Count -1 do begin
      o := json.A['credentials'][x].AsObject;
      if o.B['IsExpired'] = true then
        cboEntity.Items.AddObject(o.S['legalName'] + ' (Expired)',o)
      else
        cboEntity.Items.AddObject(o.S['legalName'],o);
    end;
    if Config.SelectedID <> '' then begin
      for x := 0 to cboEntity.Items.Count -1 do begin
        if TJsonObject(cboEntity.Items.Objects[x]).S['id'] = Config.SelectedID then begin
          cboEntity.ItemIndex := x;
          break;
        end;
      end;
    end;
  end;
end;

end.
