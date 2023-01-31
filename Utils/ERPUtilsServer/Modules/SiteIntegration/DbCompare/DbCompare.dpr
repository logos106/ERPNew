program DbCompare;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  JSONObject in '..\..\..\..\..\Common\JSONObject.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
