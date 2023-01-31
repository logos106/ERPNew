program ServiceGui;

uses
  Forms,
  frmSvcGuiBase in 'frmSvcGuiBase.pas' {fmSvcGuiBase},
  datSvcControlClient in 'datSvcControlClient.pas' {SvcControlClient: TDataModule},
  datSvcControlServer in 'datSvcControlServer.pas' {SvcControlServer: TDataModule},
  AppVarsObj in '..\..\Dev\General\Objects\CommonObjects\AppVarsObj.pas',
  ServiceGuiCommon in 'ServiceGuiCommon.pas',
  frmLog in 'frmLog.pas' {fmLog},
  frmSvcGuiConfig in 'frmSvcGuiConfig.pas' {fmSvcGuiConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmSvcGuiBase, fmSvcGuiBase);
  Application.Run;
end.
