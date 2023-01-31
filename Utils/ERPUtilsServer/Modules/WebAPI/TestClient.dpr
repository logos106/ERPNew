program TestClient;

uses
  Forms,
  frmTestClient in 'frmTestClient.pas' {fmTestClient},
  JSONObject in '..\..\..\..\Common\JSONObject.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmTestClient, fmTestClient);
  Application.Run;
end.
