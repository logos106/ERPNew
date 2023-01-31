unit frmGaAccountEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, wwcheckbox, DNMSpeedButton, Shader, DNMPanel;

type
  TfmGaAccountEdit = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    edtPassword: TEdit;
    edtEmail: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function DoGaAccountEdit(var Email, Password: string; var Active: boolean; IsNew: boolean): boolean;

implementation

{$R *.dfm}

uses
  CommonLib;



function DoGaAccountEdit(var Email, Password: string; var Active: boolean; IsNew: boolean): boolean;
var
  form: TfmGaAccountEdit;
begin
  form:= TfmGaAccountEdit.Create(nil);
  try
    form.edtEmail.Text:= Email;
    form.edtPassword.Text:= Password;
    form.chkActive.Checked:= Active;
    form.edtEmail.ReadOnly:= not IsNew;
    result:= form.ShowModal = mrOk;
    Email:= form.edtEmail.Text;
    Password:= form.edtPassword.Text;
    Active:= form.chkActive.Checked;
  finally
    form.Free;
  end;
end;

procedure TfmGaAccountEdit.btnSaveClick(Sender: TObject);
begin
  inherited;
  if self.edtEmail.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please enter the accounts email address.',mtInformation,[mbOk],0);
    SetControlFocus(edtEmail);
    exit;
  end;
  if self.edtPassword.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Please enter the accounts password.',mtInformation,[mbOk],0);
    SetControlFocus(edtPassword);
    exit;
  end;
  ModalResult:= mrOk;
end;

procedure TfmGaAccountEdit.FormShow(Sender: TObject);
begin
  inherited;
  if edtEmail.ReadOnly then
    SetControlFocus(edtPassword)
  else
    SetControlFocus(edtEmail);
end;

end.
