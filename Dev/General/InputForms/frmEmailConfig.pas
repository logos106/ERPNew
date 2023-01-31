unit frmEmailConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, AdvEdit,
  BusObjEmailConfig, JSONBinding;

type
  TfmEmailConfig = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    edtEmailAddress: TEdit;
    Label2: TLabel;
    edtMailServer: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtUserName: TEdit;
    Label5: TLabel;
    edtPassword: TEdit;
    edtPort: TAdvEdit;
    Label6: TLabel;
    btnTest: TDNMSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtOutMailServer: TEdit;
    edtOutPort: TAdvEdit;
    Label11: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure edtEmailAddressChange(Sender: TObject);
  private
    Bindings: TJSONBindings;
    fConfig: TEmailConfig;
    dlg: TProgressDialog;
    procedure SetConfig(const Value: TEmailConfig);
    procedure DoOnProgress(const msg: string);
    property Config: TEmailConfig read fConfig write SetConfig;
  public
    { Public declarations }
  end;

var
  fmEmailConfig: TfmEmailConfig;


  function DoEmailConfig(EmailConfig: TEmailConfig): boolean;

implementation

uses
  JSONObject, CommonLib, EmailConst;

{$R *.dfm}

function DoEmailConfig(EmailConfig: TEmailConfig): boolean;
var
  form: TfmEmailConfig;
begin
  result:= false;
  EmailConfig.Connection.BeginNestedTransaction;
  form := TfmEmailConfig.Create(nil);
  try
    form.Config := EmailConfig;
    result := form.ShowModal = mrOk;

  finally
    form.Free;
    if result then begin
      EmailConfig.Save;
      EmailConfig.Connection.CommitNestedTransaction;
    end
    else begin
      EmailConfig.Connection.RollbackNestedTransaction;
      EmailConfig.Load();
    end;

  end;
end;

procedure TfmEmailConfig.btnSaveClick(Sender: TObject);
begin
  inherited;
  if Config.ConfigValid and Bindings.Dirty then
    Config.ConfigValid := false;
  ModalResult:= mrOk;
end;

procedure TfmEmailConfig.DoOnProgress(const msg: string);
begin
  if Assigned(dlg) then begin
    dlg.Message := msg;
    dlg.StepIt;
  end;
end;

procedure TfmEmailConfig.edtEmailAddressChange(Sender: TObject);
begin
  inherited;
  if not SameText(fConfig.EmailAddress, TEdit(Sender).Text) then begin
    fConfig.EmailAddress := TEdit(Sender).Text;
    Bindings.Dirty := true;
  end;
end;

procedure TfmEmailConfig.btnTestClick(Sender: TObject);
var
  msg: string;
begin
  inherited;
  dlg := TProgressDialog.Create(nil);
  try
    dlg.MaxValue := 5;
    dlg.Step := 1;
    dlg.Caption := 'Checking Mail Box access';
    dlg.Execute;

    if Config.ValidateSettings(msg) then begin
      dlg.CloseDialog;
      CommonLib.MessageDlgXP_Vista('Mail server connection ok',mtInformation,[mbOk],0);
      Config.ConfigValid := true;
      Bindings.Dirty := false;
    end
    else begin
      dlg.CloseDialog;
      CommonLib.MessageDlgXP_Vista(msg,mtWarning,[mbOk],0);

    end;


  finally
    FreeAndNil(dlg);
  end;
end;

procedure TfmEmailConfig.FormCreate(Sender: TObject);
begin
  inherited;
  Bindings := TJSONBindings.Create(self);
end;

procedure TfmEmailConfig.SetConfig(const Value: TEmailConfig);
begin
  fConfig := Value;
  Bindings.JSONObject := fConfig.Config;
//  Bindings.AddBinding(Email_EmailAddress,JsonObject.valString,edtEmailAddress);
  Bindings.AddBinding(Email_Password,JsonObject.valString,edtPassword);
  Bindings.AddBinding(Email_UserName,JsonObject.valString,edtUserName);
  Bindings.AddBinding(Email_ServerPort,JsonObject.valNumber,edtPort);
  Bindings.AddBinding(Email_ServerName,JsonObject.valString,edtMailServer);
  Bindings.AddBinding(Email_outServerPort,JsonObject.valNumber,edtoutPort);
  Bindings.AddBinding(Email_outServerName,JsonObject.valString,edtoutMailServer);
  edtEmailAddress.Text := fConfig.EmailAddress;
  Bindings.Dirty := false;
  fConfig.OnProgress := DoOnProgress;
end;

end.
