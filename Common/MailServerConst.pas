unit MailServerConst;

interface

//const
//  EMAIL_ERROR_RECEPIENT = 'ERPLog <erplog@erpaustralia.com.au>';
//  EMAIL_SUPPORT_RECEPIENT = 'ERP Support <support@trueerp.com>';

//  SMTPHost     = 'mail.erpaustralia.com.au';
//  SMTP3Port     = 25;
//  SMTPUsername = 'erplog@erpaustralia.com.au';
  { old password used when mail was hosted by Crazy Domains }
  //SMTPPassword = 'catforpetesdinner';
  { New password used from 7-Nov-2016, now hosted by digital pacific }
//  SMTPPassword = '3UmdrNWgz8t4';

//  System_SMTPHost     = 'mail.trueerp.com';
//  System_SMTPPort     = 25;
//  System_SMTPUsername = 'system@trueerp.com';
//  System_SMTPPassword = 'g\85]sg<9cTa;4yp';

  { moved these settings onto trueerp.com }

  function EMAIL_ERROR_RECEPIENT: string;
  function EMAIL_SUPPORT_RECEPIENT: string;

  function SMTPHost: string;
  function SMTP3Port: integer;
  function POPPort: integer;
  function SMTPUsername: string;
  function SMTPPassword: string;

  function System_SMTPHost: string;
  function System_SMTPPort: integer;
  function System_POPPort: integer;
  function System_SMTPUsername: string;
  function System_SMTPPassword: string;

implementation

uses
  ERPServerDetailsObj;

function EMAIL_ERROR_RECEPIENT: string;
begin
  result := '';
  if ERPServerDetails.IsBlank then exit;
  result := ERPServerDetails.S['EMAIL_ERROR_RECEPIENT'];
end;

function EMAIL_SUPPORT_RECEPIENT: string;
begin
  result := '';
  if ERPServerDetails.IsBlank then exit;
  result := ERPServerDetails.S['EMAIL_SUPPORT_RECEPIENT'];
end;

function SMTPHost: string;
begin
  result := '';
  if ERPServerDetails.IsBlank then exit;
  result := ERPServerDetails.O['erplog_email'].S['Host'];
end;

function SMTP3Port: integer;
begin
  result := 0;
  if ERPServerDetails.IsBlank then exit;
  result := ERPServerDetails.O['erplog_email'].I['SMTPPort'];
end;

function POPPort: integer;
begin
  result := 0;
  if ERPServerDetails.IsBlank then exit;
  result := ERPServerDetails.O['erplog_email'].I['POPPort'];
end;


function SMTPUsername: string;
begin
  result := '';
  if ERPServerDetails.IsBlank then exit;
  result := ERPServerDetails.O['erplog_email'].S['Username'];
end;

function SMTPPassword: string;
begin
  result := '';
  if ERPServerDetails.IsBlank then exit;
  result := ERPServerDetails.O['erplog_email'].S['Password'];
end;

function System_SMTPHost: string;
begin
  result := '';
  if ERPServerDetails.IsBlank then exit;
  result := ERPServerDetails.O['system_email'].S['Host'];
end;

function System_SMTPPort: integer;
begin
  result := 0;
  if ERPServerDetails.IsBlank then exit;
  result := ERPServerDetails.O['system_email'].I['SMTPPort'];
end;

function System_POPPort: integer;
begin
  result := 0;
  if ERPServerDetails.IsBlank then exit;
  result := ERPServerDetails.O['system_email'].I['POPPort'];
end;

function System_SMTPUsername: string;
begin
  result := '';
  if ERPServerDetails.IsBlank then exit;
  result := ERPServerDetails.O['system_email'].S['Username'];
end;

function System_SMTPPassword: string;
begin
  result := '';
  if ERPServerDetails.IsBlank then exit;
  result := ERPServerDetails.O['system_email'].S['Password'];
end;


end.

