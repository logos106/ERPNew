program SvcControllTest;

uses
  Forms,
  frmMain in 'frmMain.pas' {Form2},
  datSvcControlClient in '..\datSvcControlClient.pas' {SvcControlClient: TDataModule},
  datSvcControlServer in '..\datSvcControlServer.pas' {SvcControlServer: TDataModule},
  ServiceCommon in '..\ServiceCommon.pas',
  ServiceGuiCommon in '..\ServiceGuiCommon.pas',
  AppVarsObj in '..\..\..\Dev\General\Objects\CommonObjects\AppVarsObj.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
