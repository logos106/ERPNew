program InstallZipMaker;

uses
  Forms,
  frmInstallZipMaker in 'frmInstallZipMaker.pas' {fmInstallZipMaker};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmInstallZipMaker, fmInstallZipMaker);
  Application.Run;
end.
