program DtdToXml;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  JsonConfigObj in '..\..\Common\JsonConfigObj.pas',
  FileVersion in '..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  JsonObjectUtils in '..\..\Common\JsonObjectUtils.pas',
  CipherUtils in '..\..\Common\CipherUtils.pas',
  DtdObj in 'DtdObj.pas',
  ModuleFileNameUtils in '..\..\Common\ModuleFileNameUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
