unit EmailConst;

interface

const
  { config (json) value names }
  Email_EntityName = 'EntityName';
  Email_EmailName = 'EmailName';
  Email_SignatureText = 'SignatureText';
  Email_SignatureFromFile = 'SignatureFromFile';
  Email_ReplyEmailAddress = 'ReplyEmailAddress';
  Email_EmailFormat = 'EmailFormat';

  { outgoing SMTP settings }
  Email_SMTPServer = 'SMTPServer';
  Email_SMTPPort = 'SMTPPort';
  Email_SMTPTLS = 'SMTPTLS';
  Email_SMTPAuthType = 'SMTPAuthType';
  Email_SMTPUserName = 'SMTPUserName';
  Email_SMTPPassword = 'SMTPPassword';
  Email_ServerType = 'ServerType';

  { incoming POP/IMAP settings }
  EMail_Server = 'Server';
  Email_Port = 'Port';
  Email_TLS = 'TLS';
  Email_AuthType = 'AuthType';
  Email_ServerUserName = 'ServerUserName';
  Email_ServerPassword = 'ServerPassword';


  { config (json) values }
  Email_ServerTypePOP = 'POP';
  Email_ServerTypeIMAP = 'IMAP';

  EmailContentNotAvailable =
    '[ Email content not available. ]' + '<br />' +
    '[ Either email server is not configured in TrueERP or emails have not' +
    ' been downloaded / received from email server for TrueERP. ]';

implementation

end.
