program ModuleTest;

uses
  Forms,
  frmModuleTest in 'frmModuleTest.pas' {fmModuleTest},
  ServerModuleObj in '..\ServerModuleObj.pas',
  ThreadProperty in '..\..\ThreadProperty.pas',
  ModuleComms in '..\..\ModuleComms.pas',
  SimplePipes in '..\..\SimplePipes.pas',
  SystemLib in '..\..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  ModuleFileNameUtils in '..\..\ModuleFileNameUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmModuleTest, fmModuleTest);
  Application.Run;
end.
