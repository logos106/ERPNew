unit frmImportDataMappingFormatDate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmImportDataMappingFormatBase, DNMSpeedButton, ExtCtrls, StdCtrls;

type
  TfmImportDataMappingFormatDate = class(TfmImportDataMappingFormatBase)
    cboSeparator: TComboBox;
    Label1: TLabel;
    cboPart1: TComboBox;
    lblSep1: TLabel;
    cboPart2: TComboBox;
    lblSep2: TLabel;
    cboPart3: TComboBox;
    cboTime: TComboBox;
    procedure cboSeparatorChange(Sender: TObject);
  private
    fFormat: string;
    procedure SetFormat(const Value: string);
    function GetFormat: string;
  protected
    function ValidateData: boolean; override;
  public
    property Format: string read GetFormat write SetFormat;
  end;

  function GetDateTimeFormat(var Format: string): boolean;

implementation

{$R *.dfm}

uses
  types, strutils;

function GetDateTimeFormat(var Format: string): boolean;
var
  form: TfmImportDataMappingFormatDate;
begin
  form:= TfmImportDataMappingFormatDate.Create(nil);
  try
    form.Format:= Format;
    result:= form.ShowModal = mrOK;
    if result then
      Format:= form.Format;

  finally
    form.Free;
  end;
end;

procedure TfmImportDataMappingFormatDate.cboSeparatorChange(Sender: TObject);
begin
  inherited;
  lblSep1.Caption:= cboSeparator.Text;
  lblSep2.Caption:= cboSeparator.Text;
end;

function TfmImportDataMappingFormatDate.GetFormat: string;
begin
  result:= cboPart1.Text + lblSep1.Caption + cboPart2.Text + lblSep2.Caption  + cboPart3.Text + ' ' + cboTime.Text;
  result:= Trim(result);
end;

procedure TfmImportDataMappingFormatDate.SetFormat(const Value: string);
var
  datePart, timePart: string;
  x: integer;
  parts: TStringDynArray;
begin
  fFormat := Value;
  if Pos('-',fFormat) > 0 then
    cboSeparator.ItemIndex:= 0
  else if Pos('/',fFormat) > 0 then
    cboSeparator.ItemIndex:= 1
  else
    cboSeparator.ItemIndex:= 0;

  datePart:= '';
  timePart:= '';
  if fFormat <> '' then begin
    x:= Pos(' ',fFormat);
    if x > 0 then begin
      { we have date and time parts }
      datePart:= Copy(fFormat,1,x-1);
      timePart:= Copy(fFormat,x+1,Length(fFormat));
    end
    else begin
      datePart:= fFormat;
    end;
    parts:= SplitString(datePart,cboSeparator.Text);
    if High(parts) = 2 then begin
      cboPart1.ItemIndex:= cboPart1.Items.IndexOf(parts[0]);
      cboPart2.ItemIndex:= cboPart2.Items.IndexOf(parts[1]);
      cboPart3.ItemIndex:= cboPart3.Items.IndexOf(parts[2]);
    end;
    cboTime.ItemIndex:= cboTime.Items.IndexOf(timePart);
    lblSep1.Caption:= cboSeparator.Text;
    lblSep2.Caption:= cboSeparator.Text;
  end;
end;

function TfmImportDataMappingFormatDate.ValidateData: boolean;
begin
  result:= inherited;
end;

end.
