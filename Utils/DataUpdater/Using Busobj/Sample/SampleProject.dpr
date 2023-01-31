program SampleProject;

uses
  Forms,
  DLLConnectObj in '..\Data Updator base\DLLConnectObj.pas',
  DataUpdateObj in '..\Data Updator base\DataUpdateObj.pas',
  frmMainBase in '..\Data Updator base\frmMainBase.pas' {fmMainBase},
  Objects in 'Objects',
  duConsts in 'duConsts.pas',
  DataUpdaterconfig in '..\Data Updator base\DataUpdaterconfig.pas',
  frmMain in 'frmMain.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
