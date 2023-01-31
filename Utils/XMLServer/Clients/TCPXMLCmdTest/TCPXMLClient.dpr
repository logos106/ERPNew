program TCPXMLClient;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  XMLRequestConst in '..\..\..\..\Dev\General\Objects\CommonObjects\XMLRequestConst.pas',
  AppVarsObj in '..\..\..\..\Dev\General\Objects\CommonObjects\AppVarsObj.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
