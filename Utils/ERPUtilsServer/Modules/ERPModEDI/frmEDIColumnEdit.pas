unit frmEDIColumnEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, JsonObject, StdCtrls, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb;

type
  TfmEDIColumnEdit = class(TForm)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lblDisplayLablel: TLabel;
    Label1: TLabel;
    edtName: TEdit;
    chkRequired: TCheckBox;
    Label2: TLabel;
    lblDateFormat: TLabel;
    edtDateFormat: TEdit;
    lblTimeFormat: TLabel;
    edtTimeFormat: TEdit;
    cboType: TwwDBComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNameChange(Sender: TObject);
    procedure chkRequiredClick(Sender: TObject);
    procedure cboTypeChange(Sender: TObject);
    procedure edtDateFormatChange(Sender: TObject);
    procedure edtTimeFormatChange(Sender: TObject);
  private
    Config: TJsonObject;
    Loading: Boolean;
    procedure Load;
    procedure SetDataType;
  public
    { Public declarations }
  end;

  function DoEditEDIColumn(DisplayLabel: string; aObj: TJSonObject; aColour: TColor): boolean;

implementation

uses
  Vista_MessageDlg, EDIUtils;

{$R *.dfm}

function DoEditEDIColumn(DisplayLabel: string; aObj: TJSonObject; aColour: TColor): boolean;
var
  form: TfmEDIColumnEdit;
begin
  form := TfmEDIColumnEdit.Create(nil);
  try
    form.Config.Assign(aObj);
    form.Color := aColour;
    form.lblDisplayLablel.Caption := DisplayLabel;
    result := form.ShowModal = mrOk;
    if result then
      aObj.Assign(form.Config);

  finally
    form.Release;
  end;
end;

procedure TfmEDIColumnEdit.btnSaveClick(Sender: TObject);
begin
  if Trim(edtName.Text) = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Please enter a name for this column',mtInformation,[mbOk],0);
    exit;
  end;
  if cboType.Text = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Please enter a Data Type for this column',mtInformation,[mbOk],0);
    exit;
  end;
  if cboType.Value = 'DateTime' then begin
    if (Trim(edtDateFormat.Text) = '') and (Trim(edtTimeFormat.Text) = '') then begin
      Vista_MessageDlg.MessageDlgXP_Vista('Please enter a Date and/or a Time Format',mtInformation,[mbOk],0);
      exit;
    end;
  end;

  ModalResult := mrOk;
end;

procedure TfmEDIColumnEdit.cboTypeChange(Sender: TObject);
begin
  if Loading then exit;

  if Config.S['DataType'] <> cboType.Value then begin
    Config.S['DataType'] := cboType.Value;
    if cboType.Value = 'DateTime' then begin

      Config.S['DateFormat'] := SysUtils.FormatSettings.ShortDateFormat;
      Config.S['TimeFormat'] := SysUtils.FormatSettings.ShortTimeFormat;
    end;

    SetDataType;
  end;
end;

procedure TfmEDIColumnEdit.chkRequiredClick(Sender: TObject);
begin
  if Loading then exit;
  Config.B['Required'] := chkRequired.Checked;
end;

procedure TfmEDIColumnEdit.edtDateFormatChange(Sender: TObject);
begin
  if Loading then exit;
  Config.S['DateFormat'] := TEdit(Sender).Text;
end;

procedure TfmEDIColumnEdit.edtNameChange(Sender: TObject);
begin
  if Loading then exit;
  Config.S['Name'] := edtName.Text;
end;

procedure TfmEDIColumnEdit.edtTimeFormatChange(Sender: TObject);
begin
  if Loading then exit;
  Config.S['TimeFormat'] := TEdit(Sender).Text;
end;

procedure TfmEDIColumnEdit.FormCreate(Sender: TObject);
var
  x: integer;
begin
  Config := JO;
  cboType.Items.Clear;
  for x := Low(MapDataTypes) to High(MapDataTypes) do
    cboType.Items.Add(MapDataTypes[x].Name + #9 + MapDataTypes[x].Value);
end;

procedure TfmEDIColumnEdit.FormDestroy(Sender: TObject);
begin
  Config.Free;
end;

procedure TfmEDIColumnEdit.FormShow(Sender: TObject);
begin
  Load;
end;

procedure TfmEDIColumnEdit.Load;
begin
  Loading := true;
  try
    edtName.Text := Config.S['Name'];
    cboType.Value := Config.S['DataType'];
    if cboType.ItemIndex < 0 then cboType.ItemIndex := 0;
    chkRequired.Checked := Config.B['Required'];
    SetDataType;
  finally
    Loading := false;
  end;
end;

procedure TfmEDIColumnEdit.SetDataType;
begin
  if SameText(Config.S['DataType'],'DateTime') then begin
    lblDateFormat.Visible := true;
    edtDateFormat.Visible := true;
    lblTimeFormat.Visible := true;
    edtTimeFormat.Visible := true;

    edtDateFormat.Text := Config.S['DateFormat'];
    edtTimeFormat.Text := Config.S['TimeFormat'];
  end
  else begin
    lblDateFormat.Visible := false;
    edtDateFormat.Visible := false;
    lblTimeFormat.Visible := false;
    edtTimeFormat.Visible := false;

    Config.Delete('DateFormat');
    Config.Delete('TimeFormat');
  end;
end;

end.
