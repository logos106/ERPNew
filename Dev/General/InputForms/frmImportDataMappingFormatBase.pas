unit frmImportDataMappingFormatBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, ExtCtrls, DNMSpeedButton, StdCtrls;

type
  TfmImportDataMappingFormatBase = class(TBaseForm)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
  private
  protected
    function ValidateData: boolean; virtual;
  public
    { Public declarations }
  end;

var
  fmImportDataMappingFormatBase: TfmImportDataMappingFormatBase;

implementation

{$R *.dfm}

procedure TfmImportDataMappingFormatBase.btnSaveClick(Sender: TObject);
begin
  inherited;
  if ValidateData then
    ModalResult:= mrOK;
end;

procedure TfmImportDataMappingFormatBase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

function TfmImportDataMappingFormatBase.ValidateData: boolean;
begin
  Result:= true;
end;

end.
