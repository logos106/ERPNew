unit frmBudgetExportImportSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader,
  DNMPanel;

type
  TfmBudgetExportImportSelect = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    edtFileName: TEdit;
    btnFile: TButton;
    Label1: TLabel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure btnFileClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    IsSave: boolean;
  end;

  function GetImportExportFileName(var aFileName: string; IsSave: boolean = false): boolean;


implementation

{$R *.dfm}

uses
  Vista_MessageDlg;

function GetImportExportFileName(var aFileName: string; IsSave: boolean): boolean;
var
  form: TfmBudgetExportImportSelect;
begin
  result := False;
  form := TfmBudgetExportImportSelect.Create(nil);
  try
    form.edtFileName.Text := aFileName;
    form.IsSave := IsSave;
    if form.ShowModal = mrOK then begin
      result := true;
      aFileName := form.edtFileName.Text;
    end;
  finally
    form.Free;
  end;

end;


procedure TfmBudgetExportImportSelect.btnFileClick(Sender: TObject);
begin
  inherited;
  if IsSave then begin
    if SaveDialog.Execute then
      edtFileName.Text :=  SaveDialog.FileName;
  end
  else begin
    if OpenDialog.Execute then
      edtFileName.Text :=  OpenDialog.FileName;
  end;
end;

procedure TfmBudgetExportImportSelect.btnOkClick(Sender: TObject);
begin
  inherited;
  if edtFileName.Text = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('No file selected',mtInformation,[mbOk],0);
    exit;
  end;
  ModalResult := mrOk;
end;

end.
