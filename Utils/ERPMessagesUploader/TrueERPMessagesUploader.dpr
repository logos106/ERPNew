program TrueERPMessagesUploader;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  MySQLUtils in '..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\Common\DbConst.pas',
  AppRunUtils in '..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  DbSharedObjectsObj in '..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  IntegerListObj in '..\..\Dev\General\Objects\CommonObjects\IntegerListObj.pas',
  CipherUtils in '..\..\Common\CipherUtils.pas',
  UpdaterConst in '..\ERPUpdater\UpdaterConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
