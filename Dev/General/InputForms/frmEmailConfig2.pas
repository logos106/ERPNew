unit frmEmailConfig2;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, Shader, DNMPanel, ComCtrls, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, Grids, Wwdbigrd, Wwdbgrid, wwcheckbox, BaseInputForm,
  ProgressDialog, ImgList, AdvMenus, DataState, AppEvnts,
  BusObjEmailConfig, ObjGuiBindingObj, BusObjBase, Mask, AdvSpin;

type
  TfmEmailConfig2 = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnTest: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlEmailConfig: TDNMPanel;
    Bevel8: TBevel;
    PageControl1: TPageControl;
    tabGeneral: TTabSheet;
    pnlGeneral: TDNMPanel;
    EmailName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtEmailAddress: TEdit;
    qryEmailSignature: TERPQuery;
    dsEmailSignature: TDataSource;
    qryEmailSignatureGlobalRef: TWideStringField;
    qryEmailSignatureID: TIntegerField;
    qryEmailSignatureEmailConfigID: TIntegerField;
    qryEmailSignatureFileName: TWideStringField;
    qryEmailSignaturemsTimeStamp: TDateTimeField;
    qryEmailSignaturemsUpdateSiteCode: TWideStringField;
    OpenDialog1: TOpenDialog;
    qryEmailSignatureIsPrimary: TWideStringField;
    qryEmailSignatureData: TBlobField;
    Label3: TLabel;
    ReplyEmailAddress: TEdit;
    tabOutgoing: TTabSheet;
    DNMPanel1: TDNMPanel;
    Label4: TLabel;
    Label5: TLabel;
    SMTPServer: TEdit;
    Label6: TLabel;
    SMTPPort: TAdvSpinEdit;
    lblSMTPDefaultPort: TLabel;
    SMTPAuthType: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    SMTPUserName: TEdit;
    Label10: TLabel;
    SMTPPassword: TEdit;
    tabIncoming: TTabSheet;
    DNMPanel2: TDNMPanel;
    Label11: TLabel;
    Label12: TLabel;
    ServerType: TComboBox;
    Label13: TLabel;
    Server: TEdit;
    Label14: TLabel;
    Port: TAdvSpinEdit;
    lblServerPort: TLabel;
    Label16: TLabel;
    AuthType: TComboBox;
    Label17: TLabel;
    ServerUserName: TEdit;
    Label18: TLabel;
    ServerPassword: TEdit;
    Label15: TLabel;
    EmailFormat: TComboBox;
    tabSignature: TTabSheet;
    DNMPanel3: TDNMPanel;
    lblSignatureText: TLabel;
    SignatureText: TMemo;
    SignatureFromFile: TwwCheckBox;
    ChooseFile: TDNMSpeedButton;
    grdAttach: TwwDBGrid;
    Label19: TLabel;
    SMTPTLS: TComboBox;
    Label7: TLabel;
    TLS: TComboBox;
    btnGmail: TDNMSpeedButton;
    btnSMTPGmailDefaults: TDNMSpeedButton;
    Label20: TLabel;
    cboIntegrationType: TComboBox;
    lblIntegrationType: TLabel;
    lblOutServerInstructions: TLabel;
    lblInServerInstructions: TLabel;
    btnSMTPOfficeDefaults: TDNMSpeedButton;
    btnOffice: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtEmailAddressChange(Sender: TObject);
    procedure ChooseFileClick(Sender: TObject);
    procedure SignatureFromFileClick(Sender: TObject);
    procedure ServerTypeChange(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure SMTPTLSChange(Sender: TObject);
    procedure btnGmailClick(Sender: TObject);
    procedure btnSMTPGmailDefaultsClick(Sender: TObject);
    procedure cboIntegrationTypeChange(Sender: TObject);
    procedure btnSMTPOfficeDefaultsClick(Sender: TObject);
    procedure btnOfficeClick(Sender: TObject);
  private
    fEmailConfig: TEmailConfig;
    Bindings: TObjGuiBindings;
    dlg: TProgressDialog;
    procedure SetEmailConfig(const Value: TEmailConfig);
    procedure UpdateDisplay;
    procedure SetDefaults;
    procedure DoOnProgress(const msg: string);
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    property EmailConfig: TEmailConfig read fEmailConfig write SetEmailConfig;
  end;

  function DoEmailConfig(aEmailConfig: TEmailConfig): boolean;

implementation

uses
  BusObjConst, DnmLib, CommonLib, PreferancesLib;

{$R *.dfm}

function DoEmailConfig(aEmailConfig: TEmailConfig): boolean;
var
  form: TfmEmailConfig2;
begin
  form := TfmEmailConfig2.Create(nil);
  try
    form.EmailConfig := aEmailConfig;
    result := form.ShowModal = mrOk;
  finally
    form.Release;
  end;
end;

{ TfmEmailConfig2 }

procedure TfmEmailConfig2.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfmEmailConfig2.btnGmailClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This will change your incoming mail server settings to the Gmail defaults, ' +
    'is that what you want to do?', mtConfirmation, [mbYes,mbNo],0) = mrYes then begin
    ServerType.ItemIndex := ServerType.Items.IndexOf('IMAP');
    ServerType.OnChange(ServerType); // Text := 'IMAP';
    Server.Text := 'imap.gmail.com';
    Port.Value := 993;
    TLS.ItemIndex := TLS.Items.IndexOf('Implicit TLS');
    TLS.OnChange(TLS); //  Text := 'Implicit TLS';
    AuthType.ItemIndex := AuthType.Items.IndexOf('Encrypted Password');
    AuthType.OnChange(AuthType); // Text := 'Encrypted Password';
  end;
end;

procedure TfmEmailConfig2.btnOfficeClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This will change your incoming mail server settings to the Windows Office 365 defaults, ' +
    'is that what you want to do?', mtConfirmation, [mbYes,mbNo],0) = mrYes then begin
    if ServerType.Text = 'POP' then begin
      Server.Text := 'outlook.office365.com';
      Port.Value := 995;
    end
    else if ServerType.Text = 'IMAP' then begin
      Server.Text := 'outlook.office365.com';
      Port.Value := 993;
    end
    else begin
      CommonLib.MessageDlgXP_Vista('Please select a Server Type first.',mtInformation,[mbOk],0);
      exit;
    end;
    TLS.ItemIndex := TLS.Items.IndexOf('Implicit TLS');
    TLS.OnChange(TLS); //  Text := 'Implicit TLS';
    AuthType.ItemIndex := AuthType.Items.IndexOf('Encrypted Password');
    AuthType.OnChange(AuthType); // Text := 'Encrypted Password';
  end;
end;

procedure TfmEmailConfig2.btnSaveClick(Sender: TObject);
begin
  inherited;
  if EmailConfig.Save then begin
    PreferancesLib.DoPrefAuditTrail;
    ModalResult := mrOk;
  end;
end;

procedure TfmEmailConfig2.btnSMTPGmailDefaultsClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This will change your SMTP (outgoing) mail server settings to the Gmail defaults, ' +
    'is that what you want to do?', mtConfirmation, [mbYes,mbNo],0) = mrYes then begin
    SMTPServer.Text := 'smtp.gmail.com';
    SMTPPort.Value := 587;
    SMTPTLS.ItemIndex := SMTPTLS.Items.IndexOf('Explicit TLS');
    SMTPTLS.OnChange(SMTPTLS);
    SMTPAuthType.ItemIndex := SMTPAuthType.Items.IndexOf('Normal Password');
    SMTPAuthType.OnChange(SMTPAuthType);
 end;
end;

procedure TfmEmailConfig2.btnSMTPOfficeDefaultsClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This will change your SMTP (outgoing) mail server settings to the Microsoft Office 365 defaults, ' +
    'is that what you want to do?', mtConfirmation, [mbYes,mbNo],0) = mrYes then begin
    SMTPServer.Text := 'smtp.office365.com';
    SMTPPort.Value := 587;
    SMTPTLS.ItemIndex := SMTPTLS.Items.IndexOf('Explicit TLS');
    SMTPTLS.OnChange(SMTPTLS);
    SMTPAuthType.ItemIndex := SMTPAuthType.Items.IndexOf('Normal Password');
    SMTPAuthType.OnChange(SMTPAuthType);
  end;
end;

procedure TfmEmailConfig2.btnTestClick(Sender: TObject);
var
  msg: string;
  s: string;
begin
  inherited;
  dlg := TProgressDialog.Create(nil);
  try
    dlg.MaxValue := 5;
    dlg.Step := 1;
    dlg.Caption := 'Checking Mail Account Settings';
    dlg.Execute;

    if EmailConfig.ValidateSettings(msg) then begin
      dlg.CloseDialog;
      s := 'Mail Server Connection Ok';
      if msg <> '' then
        s := s + ' With The Following Warnings:' + #13#10 + #13#10 + msg;
      CommonLib.MessageDlgXP_Vista(s,mtInformation,[mbOk],0);
      EmailConfig.ConfigValid := true;
//      Bindings.Dirty := false;
    end
    else begin
      dlg.CloseDialog;
      CommonLib.MessageDlgXP_Vista(msg,mtWarning,[mbOk],0);

    end;


  finally
    FreeAndNil(dlg);
  end;
end;

procedure TfmEmailConfig2.cboIntegrationTypeChange(Sender: TObject);
begin
  inherited;
  if cboIntegrationType.Text <> '' then
    EmailConfig.IntegrationType := cboIntegrationType.Text;
  UpdateDisplay;
end;

procedure TfmEmailConfig2.ChooseFileClick(Sender: TObject);
begin
  inherited;
  if OpenDialog1.Execute then begin
    EmailConfig.LoadSignatureFile(OpenDialog1.FileName);
  end;
end;

procedure TfmEmailConfig2.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if sender is TEmailSinatureFile then begin
      if qryEmailSignature.Connection <> EmailConfig.Connection.Connection then begin
        qryEmailSignature.Close;
        qryEmailSignature.Connection := EmailConfig.Connection.Connection;
        qryEmailSignature.Open;
      end;
      TEmailSinatureFile(Sender).Dataset := qryEmailSignature;
    end;
  end;
end;

procedure TfmEmailConfig2.DoOnProgress(const msg: string);
begin
  if Assigned(dlg) then begin
    dlg.Message := msg;
    dlg.StepIt;
  end;
end;

procedure TfmEmailConfig2.edtEmailAddressChange(Sender: TObject);
begin
  inherited;
  EmailConfig.EmailAddress := edtEmailAddress.Text;
end;

procedure TfmEmailConfig2.FormCreate(Sender: TObject);
begin
  inherited;
  Bindings := TObjGuiBindings.Create(self);
  PageControl1.ActivePageIndex := 0;
end;

procedure TfmEmailConfig2.ServerTypeChange(Sender: TObject);
begin
  inherited;
  UpdateDisplay;
end;

procedure TfmEmailConfig2.SetDefaults;
begin
  if SMTPPort.Value = 0 then begin
    SMTPPort.Value := 465;
    SMTPAuthType.ItemIndex := SMTPAuthType.Items.IndexOf('Normal Password');
    SMTPAuthType.OnChange(SMTPAuthType); // Text := 'Normal Password';
  end;
  if ServerType.Text = '' then begin
    ServerType.ItemIndex := ServerType.Items.IndexOf('POP');
    ServerType.OnChange(ServerType); //  Text := 'POP';
    Port.Value := 110;
    TLS.ItemIndex := 0;
    TLS.OnChange(TLS); // Text := 'None';
    AuthType.ItemIndex := AuthType.Items.IndexOf('Normal Password');
    AuthType.OnChange(AuthType); // Text := 'Normal Password';
  end;
  if EmailFormat.Text = '' then begin
    EmailFormat.ItemIndex := EmailFormat.Items.IndexOf('HTML');
    EmailFormat.OnChange(EmailFormat);  //Text := 'HTML';
  end;
  if SMTPAuthType.ItemIndex < 0 then begin
    SMTPAuthType.ItemIndex := 0;
    SMTPAuthType.OnChange(SMTPAuthType); //Text := 'Normal Password';
  end;
  if AuthType.ItemIndex < 0 then begin
    AuthType.ItemIndex := 0;
    AuthType.OnChange(AuthType); // text := 'Normal Password';
  end;
end;

procedure TfmEmailConfig2.SetEmailConfig(const Value: TEmailConfig);
begin
  Bindings.Clear;
  fEmailConfig := Value;
  fEmailConfig.BusObjEvent := DoBusinessObjectEvent;
//  fEmailConfig.SignatureFiles.CloseDb;
  fEmailConfig.RefreshDB;
  fEmailConfig.SignatureFiles;
  Bindings.Obj := fEmailConfig;
  Bindings.AutoLoad;
  Bindings.PopulateGUI;
  edtEmailAddress.Text := fEmailConfig.EmailAddress;
  UpdateDisplay;
  SetDefaults;
  RealignTabControl(PageControl1, 1);
  EmailConfig.OnProgress := DoOnProgress;
end;

procedure TfmEmailConfig2.SignatureFromFileClick(Sender: TObject);
begin
  inherited;
  UpdateDisplay;
end;

procedure TfmEmailConfig2.SMTPTLSChange(Sender: TObject);
begin
  inherited;
  UpdateDisplay;
end;

procedure TfmEmailConfig2.UpdateDisplay;
begin
  ChooseFile.Enabled := SignatureFromFile.Checked;
  grdAttach.Enabled := SignatureFromFile.Checked;
  SignatureText.Enabled := not SignatureFromFile.Checked;
  lblSignatureText.Enabled := not SignatureFromFile.Checked;
  if ServerType.Text = 'POP' then
    lblServerPort.Caption := 'Default: 110'
  else
    lblServerPort.Caption := 'Default: 993';

  if SMTPTLS.ItemIndex <= 0 then
    lblSMTPDefaultPort.Caption := 'Default: 25 or 2525 or 587'
  else
    lblSMTPDefaultPort.Caption := 'Default: 465 or 25 or 587 or 2526';
  cboIntegrationType.ItemIndex := cboIntegrationType.Items.IndexOf(EmailConfig.IntegrationType);
  if SameText(cboIntegrationType.Text,'Server') then
    lblIntegrationType.Caption := 'As configured in this form on above tabs. Messages sent as HTML and Plain Text.'
  else if SameText(cboIntegrationType.Text,'Email Client') then
    lblIntegrationType.Caption := 'Your email program on your machine. Messages sent as Plain Text'
  else
    lblIntegrationType.Caption := '';
end;

end.
