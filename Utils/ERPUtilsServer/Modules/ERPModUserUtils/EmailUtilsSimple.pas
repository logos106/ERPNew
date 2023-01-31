unit EmailUtilsSimple;

interface

uses
  Classes;

  procedure SendEmail(aRecipients, aSubject, aBody: string; IgnoreExceptions: boolean = true; HtmlContent: boolean = false);
//  procedure SendEmail(aRecipients, aSender, aSubject, aBody: string;
//    aAttachmentFileName: string = '';
//    IgnoreExceptions: boolean = true; HtmlContent: boolean = false); overload;

implementation

uses
  IdSMTP, IdMessage, MailServerConst, SysUtils, Types, StrUtils, IdEmailAddress;

//procedure SendEmail(aRecipients, aSender, aSubject, aBody: string;
//  aAttachmentFileName: string = '';
//  IgnoreExceptions: boolean = true; HtmlContent: boolean = false);
//var
//  SMTP: TIdSMTP;
//  mail: TIdMessage;
//  list: TStringDynArray;
//  addressItem: TIdEmailAddressItem;
//  x: integer;
//begin
//
//  SMTP := TIdSMTP.Create(nil);
//  mail := TIdMessage.Create(nil);
//  try
//    if HtmlContent then
//      mail.ContentType := 'text/html';
//    SMTP.Host := System_SMTPHost;
//    SMTP.Port := System_SMTPPort;
//    SMTP.Username := System_SMTPUsername;
//    SMTP.Password := System_SMTPPassword;
//    mail.From.Name := aSender;
//    mail.From.Address := aSender;
//    list := SplitString(aRecipients,',');
//    try
//      for x := Low(list) to High(list) do begin
//        addressItem := mail.Recipients.Add;
//        addressItem.Address := list[x];
//        addressItem.Name := list[x];
//      end;
//    except
//    end;
//    mail.Subject := aSubject;
//    mail.Body.Text := aBody;
//    mail.at
//    try
//      SMTP.Connect;
//      SMTP.Send(mail);
//    except
//      on e: exception do begin
//        if not IgnoreExceptions then
//          raise;
//      end;
//    end;
//
//  finally
//    SMTP.Free;
//    mail.Free;
//  end;
//end;

procedure SendEmail(aRecipients, aSubject, aBody: string; IgnoreExceptions: boolean = true; HtmlContent: boolean = false);
var
  SMTP: TIdSMTP;
  mail: TIdMessage;
  list: TStringDynArray;
  addressItem: TIdEmailAddressItem;
  x: integer;
begin

  SMTP := TIdSMTP.Create(nil);
  mail := TIdMessage.Create(nil);
  try
    if HtmlContent then
      mail.ContentType := 'text/html';
    SMTP.Host := System_SMTPHost;
    SMTP.Port := System_SMTPPort;
    SMTP.Username := System_SMTPUsername;
    SMTP.Password := System_SMTPPassword;
    mail.From.Name := 'True ERP System';
//    mail.From.Address := System_SMTPUsername;
    list := SplitString(aRecipients,',');
    try
      for x := Low(list) to High(list) do begin
        addressItem := mail.Recipients.Add;
        addressItem.Address := list[x];
        addressItem.Name := list[x];
      end;
    except
    end;
//    mail.Recipients.EMailAddresses := aRecipients;
    mail.Subject := aSubject;
    mail.Body.Text := aBody;
    try
      SMTP.Connect;
      SMTP.Send(mail);
    except
      on e: exception do begin
        if not IgnoreExceptions then
          raise;
      end;
    end;

  finally
    SMTP.Free;
    mail.Free;
  end;
end;



end.
