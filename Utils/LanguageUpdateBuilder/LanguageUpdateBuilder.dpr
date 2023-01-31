program LanguageUpdateBuilder;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  DbConst in '..\..\Common\DbConst.pas',
  CipherUtils in '..\..\Common\CipherUtils.pas',
  AppVarsObj in '..\..\Dev\General\Objects\CommonObjects\AppVarsObj.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
