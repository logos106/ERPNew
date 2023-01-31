program ClientUploads;

uses
  Forms,
  frmClientUploadsGUI in 'frmClientUploadsGUI.pas' {ClientUploadsGUI},
  InstallConst in '..\..\Common\InstallConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Client File Uploader';
  Application.CreateForm(TClientUploadsGUI, ClientUploadsGUI);
  Application.Run;
end.
