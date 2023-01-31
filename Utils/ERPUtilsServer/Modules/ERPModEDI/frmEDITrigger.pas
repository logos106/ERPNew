unit frmEDITrigger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, JsonObject, StdCtrls, ComCtrls, ExtCtrls, DNMPanel,
  AdvEdit;

type
  TfmEDITrigger = class(TForm)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    cboType: TComboBox;
    pagesType: TPageControl;
    tabFile: TTabSheet;
    tabUnknown: TTabSheet;
    pnlUnknown: TDNMPanel;
    Label5: TLabel;
    pnlFile: TDNMPanel;
    Label3: TLabel;
    edtMapName: TEdit;
    Label2: TLabel;
    edtFileMask: TEdit;
    Label4: TLabel;
    edtFilePath: TEdit;
    Label6: TLabel;
    edtProcessedPath: TEdit;
    edtIntervalHours: TAdvEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtIntervalMins: TAdvEdit;
    Label9: TLabel;
    OpenDialog: TOpenDialog;
    btnFilePath: TButton;
    btnProcessedPath: TButton;
    Label10: TLabel;
    edtFailPath: TEdit;
    btnFailPath: TButton;
    chkEmailOnError: TCheckBox;
    chkEmailOnSuccess: TCheckBox;
    Label11: TLabel;
    edtEmail: TEdit;
    btnTest: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboTypeChange(Sender: TObject);
    procedure edtIntervalHoursChange(Sender: TObject);
    procedure btnFilePathClick(Sender: TObject);
    procedure btnProcessedPathClick(Sender: TObject);
    procedure btnFailPathClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
  private
    Config: TJsonObject;
    procedure Load;
    procedure Save;
  public
    { Public declarations }
  end;

function DoEDITriggerEdit(Sender: TForm; aConfig: TJsonObject): boolean;

implementation

uses
  Vista_MessageDlg, EmailUtilsSimple;

{$R *.dfm}

function DoEDITriggerEdit(Sender: TForm; aConfig: TJsonObject): boolean;
var
  form: TfmEDITrigger;
begin
  form := TfmEDITrigger.Create(nil);
  try
    form.Color := Sender.Color;
    form.Config.Assign(aConfig);
    result := form.ShowModal = mrOk;
    if result then
      aConfig.Assign(form.Config);
  finally
    form.Release;
  end;
end;

{ TfmEDITrigger }

procedure TfmEDITrigger.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfmEDITrigger.btnFailPathClick(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do try
    Options := [fdoPickFolders];
    if edtFailPath.Text <> '' then
      DefaultFolder  := edtFailPath.Text;
    if Execute then begin
      edtFailPath.Text := FileName;
    end;
  finally
    Free;
  end;
end;

procedure TfmEDITrigger.btnFilePathClick(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do try
    Options := [fdoPickFolders];
    if edtFilePath.Text <> '' then
      DefaultFolder  := edtFilePath.Text;
    if Execute then begin
      edtFilePath.Text := FileName;
    end;
  finally
    Free;
  end;
end;

procedure TfmEDITrigger.btnProcessedPathClick(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do try
    Options := [fdoPickFolders];
    if edtProcessedPath.Text <> '' then
      DefaultFolder  := edtProcessedPath.Text;
    if Execute then begin
      edtProcessedPath.Text := FileName;
    end;
  finally
    Free;
  end;
end;

procedure TfmEDITrigger.btnSaveClick(Sender: TObject);
begin
  if edtFilePath.Text = '' then begin
    MessageDlgXP_Vista('Please enter a File Source',mtInformation,[mbOk],0);
    exit;
  end;
  if edtProcessedPath.Text = '' then begin
    MessageDlgXP_Vista('Please enter a Processed File Path',mtInformation,[mbOk],0);
    exit;
  end;
  if edtFailPath.Text = '' then begin
    MessageDlgXP_Vista('Please enter a Failed File Path',mtInformation,[mbOk],0);
    exit;
  end;
  if (chkEmailOnError.Checked or chkEmailOnSuccess.Checked) and (edtEmail.Text = '') then begin
    MessageDlgXP_Vista('Please enter an Email Address',mtInformation,[mbOk],0);
    exit;
  end;

  Save;
  ModalResult := mrOk;
end;

procedure TfmEDITrigger.btnTestClick(Sender: TObject);
begin
  if edtEmail.Text = '' then begin
    MessageDlgXP_Vista('Please enter an Email Address',mtInformation,[mbOk],0);
    exit;
  end;
  try
    SendEmail(edtEmail.Text,'Test Email','This is a test email sent from TrueERP EDI Configuration',false);
    MessageDlgXP_Vista('The email has been sent, please check that you have received it.',mtInformation,[mbOk],0);
  except
    on e: exception do begin
      MessageDlgXP_Vista('The following error occured when sending the test email: ' + e.Message ,mtError,[mbOk],0);
    end;
  end;
end;

procedure TfmEDITrigger.cboTypeChange(Sender: TObject);
begin
  if SameText(cboType.Text,'File') then begin
    self.pagesType.ActivePage := tabFile

  end
  else begin
    self.pagesType.ActivePage := tabUnknown;

  end;
end;

procedure TfmEDITrigger.edtIntervalHoursChange(Sender: TObject);
begin
  if TAdvEdit(Sender).IntValue > 59 then
    TAdvEdit(Sender).IntValue := 59;
end;

procedure TfmEDITrigger.FormCreate(Sender: TObject);
var
  x: integer;
begin
  Config := TJsonObject.Create;
  self.pagesType.ActivePage := tabUnknown;
  for x := 0 to pagesType.PageCount -1 do begin
    pagesType.Pages[x].TabVisible := false;
  end;
end;

procedure TfmEDITrigger.FormDestroy(Sender: TObject);
begin
  Config.Free;
end;

procedure TfmEDITrigger.FormShow(Sender: TObject);
begin
  Load;
end;

procedure TfmEDITrigger.Load;
begin
  cboType.ItemIndex := cboType.Items.IndexOf(Config.S['Type']);
  if SameText(cboType.Text,'File') then begin
    self.pagesType.ActivePage := tabFile;
    edtMapName.Text := Config.S['MapName'];
    edtFileMask.Text := Config.S['FileMask'];
    edtFilePath.Text := Config.S['FilePath'];
    edtFailPath.Text := Config.S['FailPath'];
    edtEmail.Text := Config.S['EmailAddress'];
    chkEmailOnError.Checked := Config.B['EmailOnError'];
    chkEmailOnSuccess.Checked := Config.B['EmailOnSuccess'];
    edtProcessedPath.Text := Config.S['ProcessedPath'];
    edtIntervalHours.IntValue := StrToIntDef(Copy(Config.O['CheckFrequency'].S['Interval'],1,2),0);
    edtIntervalMins.IntValue := StrToIntDef(Copy(Config.O['CheckFrequency'].S['Interval'],4,2),0);
  end

end;

procedure TfmEDITrigger.Save;

  function IntToStrFmt(int: integer): string;
  begin
    result := IntToStr(int);
    while Length(result) < 2 do
      result := '0' + result;
  end;

begin
  Config.S['Type'] := cboType.Text;
  if SameText(cboType.Text,'File') then begin
    Config.S['MapName'] := edtMapName.Text;
    Config.S['FileMask'] := edtFileMask.Text;
    Config.S['FilePath'] := edtFilePath.Text;
    Config.S['FailPath'] := edtFailPath.Text;
    Config.S['EmailAddress'] := edtEmail.Text;
    Config.B['EmailOnError'] := chkEmailOnError.Checked;
    Config.B['EmailOnSuccess'] := chkEmailOnSuccess.Checked;
    Config.S['ProcessedPath'] := edtProcessedPath.Text;
    Config.O['CheckFrequency'].S['Interval'] := IntToStrFmt(edtIntervalHours.IntValue) + ':' + IntToStrFmt(edtIntervalMins.IntValue);
  end
end;

end.
