unit frmImportDataMappingFormatBoolean;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmImportDataMappingFormatBase, DNMSpeedButton, ExtCtrls, StdCtrls;

type
  TfmImportDataMappingFormatBoolean = class(TfmImportDataMappingFormatBase)
    Label1: TLabel;
    cboFormat: TComboBox;
    procedure FormCreate(Sender: TObject);
  private
    fFormat: string;
    function GetFormat: string;
    procedure SetFormat(const Value: string);
  protected
    function ValidateData: boolean; override;
  public
    property Format: string read GetFormat write SetFormat;
  end;

  function GetBooleanFormat(var Format: string): boolean;

implementation

{$R *.dfm}

uses
  ImportDataMappingConst;

function GetBooleanFormat(var Format: string): boolean;
var
  form: TfmImportDataMappingFormatBoolean;
begin
  form:= TfmImportDataMappingFormatBoolean.Create(nil);
  try
    form.Format:= Format;
    result:= form.ShowModal = mrOK;
    if result then
      Format:= form.Format;

  finally
    form.Free;
  end;
end;

{ TfmImportDataMappingFormatBoolean }

procedure TfmImportDataMappingFormatBoolean.FormCreate(Sender: TObject);
begin
  inherited;
  cboFormat.Items.Clear;
  cboFormat.Items.Add(Format_Bool_TrueFalse);
  cboFormat.Items.Add(Format_Bool_TF);
  cboFormat.Items.Add(Format_Bool_YesNo);
  cboFormat.Items.Add(Format_Bool_YN);
end;

function TfmImportDataMappingFormatBoolean.GetFormat: string;
begin
  result:= cboFormat.Text;
end;

procedure TfmImportDataMappingFormatBoolean.SetFormat(const Value: string);
begin
  fFormat := Value;
  cboFormat.ItemIndex:= cboFormat.Items.IndexOf(Value);
  if cboFormat.ItemIndex < 0 then
    cboFormat.ItemIndex:= 0;
end;

function TfmImportDataMappingFormatBoolean.ValidateData: boolean;
begin
  result:= inherited;
end;

end.
