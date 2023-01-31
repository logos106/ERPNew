program HelpContexts;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  DFMObj in 'DFMObj.pas',
  AppVarsObj in '..\..\Dev\General\Objects\CommonObjects\AppVarsObj.pas',
  DataTreeBaseObj in '..\..\Dev\General\Objects\CommonObjects\DataTreeBaseObj.pas',
  XMLFuncLib in '..\..\Dev\General\Objects\CommonObjects\XMLFuncLib.pas',
  IntegerListObj in '..\..\Dev\General\Objects\CommonObjects\IntegerListObj.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
