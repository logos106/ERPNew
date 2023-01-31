program EncryptedConfigEdit;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  JSONObject in '..\..\..\Common\JSONObject.pas',
  CipherUtils in '..\..\..\Common\CipherUtils.pas',
  JsonObjectUtils in '..\..\..\Common\JsonObjectUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
