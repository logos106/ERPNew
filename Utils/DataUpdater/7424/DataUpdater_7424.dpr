program DataUpdater_7424;

uses
  Forms,
  frmMainBase in '..\frmMainBase.pas' {fmMainBase},
  frmMain in 'frmMain.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
