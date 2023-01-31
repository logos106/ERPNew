program ErrorTrack;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  AppVarsObj in 'AppVarsObj.pas',
  Lib in 'Lib.pas',
  frmSelectText in 'frmSelectText.pas' {fmSelectText},
  ERPServerDetailsObj in '..\..\Dev\General\Objects\CommonObjects\ERPServerDetailsObj.pas',
  JsonToObject in '..\..\Common\JsonToObject.pas',
  CipherUtils in '..\..\Common\CipherUtils.pas',
  UpdaterConst in '..\ERPUpdater\UpdaterConst.pas',
  FileDownloadFuncs in '..\..\Dev\General\Objects\CommonObjects\FileDownloadFuncs.pas',
  SystemLib in '..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  ModuleFileNameUtils in '..\..\Common\ModuleFileNameUtils.pas',
  JSONObject in '..\..\Common\JSONObject.pas',
  HTTPConst in '..\..\Common\HTTPConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
