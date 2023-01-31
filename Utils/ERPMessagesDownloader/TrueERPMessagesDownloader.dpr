program TrueERPMessagesDownloader;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  MessagesDownloaderObj in 'MessagesDownloaderObj.pas',
  LogThreadLib in '..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  FileDownloadFuncs in '..\..\Dev\General\Objects\CommonObjects\FileDownloadFuncs.pas',
  SystemLib in '..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  InstallConst in '..\..\Common\InstallConst.pas',
  UpdaterConst in '..\ERPUpdater\UpdaterConst.pas',
  TrueERPMessagesConst in '..\..\Common\TrueERPMessagesConst.pas',
  CipherUtils in '..\..\Common\CipherUtils.pas',
  MySQLUtils in '..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\Common\DbConst.pas',
  AppRunUtils in '..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  DbSharedObjectsObj in '..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  ERPMessagesDb in '..\ERPMessages\ERPMessagesDb.pas';

var
  fd: TMessagesDownloader;

begin
  try
    fd := TMessagesDownloader.Create;
    try
      fd.DownloadAndProcess;

    finally
      fd.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
