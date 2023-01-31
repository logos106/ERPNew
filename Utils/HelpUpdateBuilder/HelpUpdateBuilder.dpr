program HelpUpdateBuilder;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  AppVarsObj in '..\..\Dev\General\Objects\CommonObjects\AppVarsObj.pas',
  CipherUtils in '..\..\Common\CipherUtils.pas',
  DbConst in '..\..\Common\DbConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
