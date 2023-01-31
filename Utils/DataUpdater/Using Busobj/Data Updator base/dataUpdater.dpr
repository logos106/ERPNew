program dataUpdater;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  DataUpdaterconfig in 'DataUpdaterconfig.pas',
  DLLConnectObj in 'DLLConnectObj.pas',
  DataUpdateObj in 'DataUpdateObj.pas',
  Objects in 'Objects.pas',
  frmMainBase in 'frmMainBase.pas' {fmMainBase};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
