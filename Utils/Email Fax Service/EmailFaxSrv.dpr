program EmailFaxSrv;

uses
  ExcMagic,
  ExcMagicCON,
  SvcMgr,
  EmailFaxServerUnit in 'Source\Common\EmailFaxServerUnit.pas' {Email_Fax_Server: TService},
  ExMagicUnit in 'Source\Common\ExMagicUnit.pas',
  SendEmailsThread in 'Source\Email\SendEmailsThread.pas',
  SendFaxesThread in 'Source\Fax\SendFaxesThread.pas',
  EmailFaxServerLib in 'Source\Common\EmailFaxServerLib.pas',
  ReportTemplates in 'Source\Common\ReportTemplates.pas',
  LogLib in 'Source\Common\LogLib.pas',
  LogGUI in 'Source\Common\LogGUI.pas' {LogView},
  ConfigGUI in 'Source\Common\ConfigGUI.pas' {Config},
  INIFileObj in 'Source\Common\INIFileObj.pas',
  FileCipherObj in 'Source\Common\FileCipherObj.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Email Fax Server';
  Application.CreateForm(TEmailFaxServer, EmailFaxServer);
  Application.Run;
end.
