unit EmailUtils;
{$I ERP.inc}
interface

uses
  SysUtils, Classes, IdMessage, IdBaseComponent, IdComponent, Windows,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP, IdEMailAddress,
  MyAccess,ERPdbComponents,DB, BusObjEmailConfig, InlineAttachmentLIstObj;

type


  TPopulateStringListCallback = procedure (sl: TStringList) of Object;

  TMailUtils = class
  public
    class function SubstituteText(text: string; subsList: TStringList): string; overload;
    class function SubstituteText(text: string; Callback: TPopulateStringListCallback): string; overload;
  end;

  TMailSendMethod = (smClient, smServer, smSecret);

  TMailSender = class
  private
    fMessageText: string;
    fCCList: string;
    fEmailConfig: TEMailConfig;
    fSubject: string;
    fBCCList: string;
    fRecipientList: string;
    fReplyTo: string;
    fFrom: string;
    fMessageRichText: string;
    fDeleteAttachments: boolean;
    procedure setRecipientList(const Value: string);

  public
    AttachmentList: TStringList;
    InlineAttachmentList: TInlineAttachmentList;
    GroupRecipientList: TStringList;
    constructor Create;
    destructor Destroy; override;
    property RecipientList: string read fRecipientList write setRecipientList;
    property CCList: string read fCCList write fCCList;
    property BCCList: string read fBCCList write fBCCList;
    property ReplyTo: string read fReplyTo write fReplyTo;
    property Subject: string read fSubject write fSubject;
    property MessageText: string read fMessageText write fMessageText;
    property MessageRichText: string read fMessageRichText write fMessageRichText;
    property From: string read fFrom write fFrom;  { "John Doe" <jdoe@some.net> }
    property EmailConfig: TEmailConfig read fEmailConfig write fEmailConfig;
    property DeleteAttachments: boolean read fDeleteAttachments write fDeleteAttachments;
    function Send(SendMethod: TMailSendMethod = smServer; showerror: boolean = true; AlwaysPreview: boolean = false): boolean;Virtual;
  end;

  procedure MakeBodyWithRef(const aRef: string; BodyLines: TStrings);

implementation

uses
  CommonDbLib, Dialogs, Controls, AppEnvironment, CommonLib, StrUtils,
  Types,  EmailUtilsDefaultMailClient, MailServerConst, SystemLib
  {$IfDef COMPILER_22_UP}
  ,IdAttachmentFile
  ,IdMessageParts
  ,IdText
  ,IdExplicitTLSClientServerBase, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdGlobal,
  IdSMTPBase
  {$EndIf}
  , MessageDlgXP_Vistaobj, GlobalEventsObj, tcConst;


procedure MakeBodyWithRef(const aRef: string; BodyLines: TStrings);
var
 s: string;
begin
  BodyLines.Insert(0,'<html><head></head><body>');
  s :=          '        <hr width="25%" align="left">' +
                '        <p style="text-align: left;">' +
                '        Sent by <a href="http://www.TrueERP.com">TrueERP</a>';
  if aRef <> '' then
    s:= s +     '        <br/>Reference: ' + aRef + ' (do not remove or edit)';
  s := s +      '        </p></body></html>';
  BodyLines.Add(s);
end;



{ TMailUtils }

class function TMailUtils.SubstituteText(text: string;
  subsList: TStringList): string;
var
  s: string;
  x: integer;
begin
  s:= text;
  if Assigned(subsList) then begin
    for x := 0  to subsList.Count -1 do
      s := StringReplace(s, subsList.Names[x], subsList.ValueFromIndex[x], [rfReplaceAll,rfIgnoreCase]);
  end;
  result := s;
end;

class function TMailUtils.SubstituteText(text: string;
  Callback: TPopulateStringListCallback): string;
var
  sl: TstringList;
begin
  sl := TstringList.Create;
  try
    Callback(sl);
    result := TMailUtils.SubstituteText(text, sl);
  finally
    sl.Free;
  end;
end;

{ TMailSender }

constructor TMailSender.Create;
begin
  AttachmentList := TStringList.Create;
  GroupRecipientList := TStringList.Create;
  InlineAttachmentList := TInlineAttachmentList.Create;
  fDeleteAttachments := false;
end;

destructor TMailSender.Destroy;
begin
  AttachmentList.Free;
  InlineAttachmentList.Free;
  GroupRecipientList.Destroy;
  inherited;
end;

function TMailSender.Send(SendMethod: TMailSendMethod; showerror: boolean; AlwaysPreview: boolean): boolean;
var
  msg: TIdMessage;
  strArray: TStringDynArray;
  x : integer;
  msgTxt: TIdText;
  msgFile: TIdAttachmentFile;
  exSMTP: TIdSMTP;
  IndySSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  indyAttachment : TidAttachmentFile;
  TempDir: string;
  TempFileName: string;
  Parts : integer;

  function GetDomain: string;
  var
    n: integer;
  begin
    result := '';
    n := Pos('@',From);
    if n > 0 then
      result := Copy(From,n,Length(From));
  end;

begin
  result := true;
  msg := TIdMessage.Create(nil);
  msg.Recipients.EmailAddresses := self.RecipientList;
  msg.From.Text := From;

  { need to add messag-id .. don't know why, should be added by server but is not }
  msg.MsgId := FormatFloat('#0.000000',now) + '.' + IntToStr(Integer(self)) + GetDomain;
  msg.ExtraHeaders.Values['Message-Id'] := msg.MsgId;

  msg.Date := now;
  strArray := SplitString(ReplyTo,',');
  for x := Low(strArray) to High(strArray) do
    msg.ReplyTo.Add.Text := strArray[x];
  strArray := SplitString(CCList,',');
  for x := Low(strArray) to High(strArray) do
    msg.CCList.Add.Text := strArray[x];
  strArray := SplitString(BCCList,',');
  for x := Low(strArray) to High(strArray) do
    msg.BCCList.Add.Text := strArray[x];
  msg.Subject := Subject;

  if (MessageRichText <> '') and (SendMethod <> smClient) then begin
    if AttachmentList.Count > 0 then
    begin  // Need a separator - otherwise the first attachment is not considered to be an attachment
      msgTxt := TIdText.Create(msg.MessageParts);
      msgTxt.ContentType := 'multipart/mixed';
      Parts := 1;
    end
    else
      Parts := 0;

    { part 0 }
    msgTxt := TIdText.Create(msg.MessageParts);
    msgTxt.ContentType := 'multipart/alternative';

    { part 1}
    msgTxt := TIdText.Create(msg.MessageParts);
    msgTxt.ContentType := 'text/plain';
    msgTxt.ContentTransfer := '7bit';
    msgTxt.CharSet := 'utf-8';
    msgTxt.Body.Text := MessageText;
    msgTxt.ParentPart := Parts;

    if InlineAttachmentList.Count > 0 then begin
      { part 2}
      msgTxt := TIdText.Create(msg.MessageParts);
      msgTxt.ContentType := 'multipart/related';
      msgTxt.ParentPart := Parts;

      { part 3}
      msgTxt := TIdText.Create(msg.MessageParts);
      msgTxt.ContentType := 'text/html';
      msgTxt.ContentTransfer := '7bit';
      msgTxt.CharSet := 'utf-8';
      msgTxt.Body.Text := MessageRichText;
      msgTxt.ParentPart := Parts + 2;
    end
    else begin
      { part 2}
      msgTxt := TIdText.Create(msg.MessageParts);
      msgTxt.ContentType := 'text/html';
      msgTxt.ContentTransfer := '7bit';
      msgTxt.CharSet := 'utf-8';
      msgTxt.Body.Text := MessageRichText;
      msgTxt.ParentPart := Parts;
    end;

    { do we have extra signature  attachments .. eg images}
    for x := 0 to InlineAttachmentList.Count -1 do begin
      msgFile := TIdAttachmentFile.Create(msg.MessageParts, InlineAttachmentList[x].FileName);
      msgFile.ContentType := InlineAttachmentList[x].ContentType;
      msgFile.ContentID := InlineAttachmentList[x].ContentID;
      msgFile.FileIsTempFile := false;
      msgFile.ContentDisposition := 'inline';
      msgTxt.ParentPart := Parts + 2;
    end;
  end
  else if SendMethod=smClient then
  begin
    msg.Body.Text := MessageText;
    if AttachmentList.Count > 0 then
      msg.ContentType := 'multipart/mixed'
    else
      msg.ContentType := 'text/plain';
    msg.FromList.Clear;
  end
  else begin
  if AttachmentList.Count > 0 then
  begin
    msgTxt := TIdText.Create(msg.MessageParts);  //@@@
    msgTxt.ContentType := 'multipart/mixed';  //@@@
    msgTxt := TIdText.Create(msg.MessageParts);
    msgTxt.ContentType := 'text/plain';
    msgTxt.ContentTransfer := '7bit';
    msgTxt.CharSet := 'utf-8';
    msgTxt.Body.Text := MessageText;
    msgTxt.ParentPart := 0;
  end
  else
    msg.Body.Add(MessageText);
  end;

  { and now the general attachments }
  if (SendMethod in [smServer, smSecret]) then begin
    TempDir := GetAppTempDir + '\TempEmailAttach\';
    ForceDirectories(TempDir);
  end;

  for x := 0 to AttachmentList.Count -1 do
  begin
    if SendMethod <> smClient then begin
      TempFileName := TempDir + ExtractFileName(AttachmentList[x]);
      TempFileName := ChangeFileNameIfExists(TempFileName);
      MoveFileEx(PChar(AttachmentList[x]),PChar(TempFileName), MOVEFILE_REPLACE_EXISTING +MOVEFILE_WRITE_THROUGH);
      indyAttachment := TIdAttachmentFile.Create(msg.MessageParts, TempFileName);
      indyAttachment.FileIsTempFile := true;// DeleteAttachments;
    end
    else begin
      { smClient }
      indyAttachment := TIdAttachmentFile.Create(msg.MessageParts, AttachmentList[x]);
      indyAttachment.FileIsTempFile := false;// DeleteAttachments;
    end;
  end;

  try
    if SendMethod = smClient then begin
      { mapi to users email client }
      SendMail(msg, AlwaysPreview);
    end else if (SendMethod = smServer) or (SendMethod=smSecret) then begin
      { direct to server }

      exSMTP := TIdSMTP.Create(nil);
      try
        try
          (*if SendMethod=smSecret then begin
            exSMTP.Host := System_SMTPHost;
            exSMTP.Username := System_SMTPUsername;
            exSMTP.Password := System_SMTPPassword;
            exSMTP.Port := System_SMTPPort;
            exSMTP.ConnectTimeout := 30000;
            exSMTP.AuthType := satDefault;
            IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(exSMTP);
            exSMTP.IOHandler := IndySSLHandler;
            exSMTP.UseTLS := utUseExplicitTLS;
            exSMTP.IOHandler.MaxLineAction := maException;
            TIdSSLIOHandlerSocketOpenSSL(exSMTP.IOHandler).SSLOptions.Method := sslvTLSv1;
            TIdSSLIOHandlerSocketOpenSSL(exSMTP.IOHandler).SSLOptions.Mode := sslmUnassigned;
            TIdSSLIOHandlerSocketOpenSSL(exSMTP.IOHandler).SSLOptions.VerifyMode := [];
            TIdSSLIOHandlerSocketOpenSSL(exSMTP.IOHandler).SSLOptions.VerifyDepth := 0;
//            msg.From.Text := exSMTP.Username;
            msg.From.Name := 'True ERP System';
          end else begin*)
            exSMTP.Host     := EmailConfig.SMTPServer;
            exSMTP.Username := EmailConfig.SMTPUserName;;
            exSMTP.Password := EmailConfig.SMTPPassword;
            exSMTP.Port     := EmailConfig.SMTPPort;
            exSMTP.ConnectTimeout := 30000;
            if SameText(EmailConfig.SMTPAuthType,'Normal Password') then
{-}              exSMTP.AuthType := satDefault
            else if SameText(EmailConfig.SMTPAuthType,'None') then
              exSMTP.AuthType := satNone
            else if SameText(EmailConfig.SMTPAuthType,'SASL') then
              exSMTP.AuthType := satSASL
            else
              exSMTP.AuthType := satDefault;

            // http://www.delphipraxis.net/178523-smtp-ssl-mit-indy10.html
            if SameText(EmailConfig.SMTPTLS, 'None') or SameText(EmailConfig.SMTPTLS, '') then begin
{-}           exSMTP.IOHandler := nil;
              exSMTP.UseTLS := utNoTLSSupport;
            end
            else if SameText(EmailConfig.SMTPTLS, 'Explicit TLS') then begin
              IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(exSMTP);
              exSMTP.IOHandler := IndySSLHandler;
              exSMTP.UseTLS := utUseExplicitTLS;
             end
            else if SameText(EmailConfig.SMTPTLS, 'Implicit TLS') then begin
              IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(exSMTP);
              exSMTP.IOHandler := IndySSLHandler;
              exSMTP.UseTLS := utUseImplicitTLS;
             end
            else if SameText(EmailConfig.SMTPTLS, 'Require TLS') then begin
              IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(exSMTP);
              exSMTP.IOHandler := IndySSLHandler;
              exSMTP.UseTLS := utUseRequireTLS;
            end;
            if Assigned(exSMTP.IOHandler) then begin
              exSMTP.IOHandler.MaxLineAction := maException;
              TIdSSLIOHandlerSocketOpenSSL(exSMTP.IOHandler).SSLOptions.Method := sslvTLSv1;
              TIdSSLIOHandlerSocketOpenSSL(exSMTP.IOHandler).SSLOptions.Mode := sslmUnassigned;
              TIdSSLIOHandlerSocketOpenSSL(exSMTP.IOHandler).SSLOptions.VerifyMode := [];
              TIdSSLIOHandlerSocketOpenSSL(exSMTP.IOHandler).SSLOptions.VerifyDepth := 0;
            end;
          (*end;*)

         {1}try
              exSMTP.Connect;
            Except
              on E:Exception do begin
                REsult := False;
                MessageDlgXP_Vista('Could not CONNECT for email with error: '   + e.Message + #13#10 + #13#10 +
                  'Please check your Email Settings under the Address section on the '+ iif(sametext(Emailconfig.EntityName, 'Company' ), 'Company Information' , 'EntityNameEmployee Card')+'.'+nl+nl+
                  '                                     Host : ' + exSMTP.Host     +Nl+
                  '                                     User : ' + exSMTP.Username      +Nl+
                  '                                     Port : ' + inttostr(exSMTP.Port),mtInformation,[mbOk],0);
                exit;
              end;
            end;

          { sending can be quite slow, especially if email has large attachments so execute in separate thread ... }
          TThread.CreateAnonymousThread(
            procedure
            begin
              try
                 (*{1}try
                      exSMTP.Connect;
                    Except
                      on E:Exception do begin
                        GlobalEvents.Notify(Nil, GEVENT_MESSAGEDLGXP_VISTA , TMessageDlgXP_Vista.NewMessageDlgXP_Vista('Could not CONNECT for email with error: '   + e.Message + #13#10 + #13#10 +
                          'Please check your Email Settings under the Address section on the Employee Card  / Company Information..',mtInformation,[mbOk],0));
                        exit;
                      end;
                    end;*)

                 {2}try
                      exSMTP.Send(msg);
                    Except
                      on E:Exception do begin
                        GlobalEvents.Notify(Nil, GEVENT_MESSAGEDLGXP_VISTA , TMessageDlgXP_Vista.NewMessageDlgXP_Vista('2- Could not SEND email with error: '          + e.Message + #13#10 + #13#10 +
                          'Please check your Email Settings under the Address section on the Employee Card  / Company Information.',mtInformation,[mbOk],0));
                        exit;
                      end;
                    end;
                 {3}try
                      exSMTP.Disconnect;
                    Except
                      on E:Exception do begin
                        GlobalEvents.Notify(Nil, GEVENT_MESSAGEDLGXP_VISTA , TMessageDlgXP_Vista.NewMessageDlgXP_Vista('3-Could not DISCONNECT for email with error: '+ e.Message + #13#10 + #13#10 +
                          'Please check your Email Settings under the Address section on the Employee Card  / Company Information.',mtInformation,[mbOk],0));
                        exit;
                      end;
                    end;
              except
                on e: exception do begin
                  if showerror then begin
                    GlobalEvents.Notify(Nil, GEVENT_MESSAGEDLGXP_VISTA , TMessageDlgXP_Vista.NewMessageDlgXP_Vista('4-Could not SEND EMAIL message to '+msg.Recipients.EMailAddresses+' with error: ' + e.Message + #13#10 + #13#10 +
                      'Please check your Email Settings under the Address section on the Employee Card  / Company Information.',mtInformation,[mbOk],0));

                  end;
                end;
              end;
              exSMTP.Free;
              msg.Free;
            end
          ).Start;

        except
          on e: exception do begin
            result := false;
            if showerror then
              GlobalEvents.Notify(Nil, GEVENT_MESSAGEDLGXP_VISTA , TMessageDlgXP_Vista.NewMessageDlgXP_Vista('5-Could not send email message: ' + e.Message + #13#10 + #13#10 +
                'Please check your Email Settings under the Address section on the Employee Card / Company Information.',mtInformation,[mbOk],0));
            exit;
          end;
        end;
      finally
      end;
    end
    else begin
      result := false;
      raise Exception.Create(Classname + ' - Invalid Send Method');
    end;

    if DeleteAttachments and (AttachmentList.Count > 0) then begin
      for x := 0 to AttachmentList.Count -1 do
        SysUtils.DeleteFile(AttachmentList[x]);
    end;

  finally
  end;
end;



procedure TMailSender.setRecipientList(const Value: string);
begin
  fRecipientList := Value;
end;
end.
