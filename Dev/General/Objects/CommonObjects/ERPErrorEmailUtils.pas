unit ERPErrorEmailUtils;

interface
uses
  Sysutils;

function SendEmailtoErp(Const Subject:String; Value:String;emaillogPrefix:String='emaillog'; Attachmentfilename:String = '';EmailAddress:String =''):String;
function SendExceptionEmail(E: Exception  ; ExtraComments:String ):String;


implementation

uses
  //{$IFNDEF CONSOLE}
//  EMHelper,
//  {$ENDIF}
  {$IFDEF GUI}
  EMHelper,
  {$ENDIF}
  IdMessage, IdSMTP, IdAttachment, MailServerConst, tcConst,
  CommonLib, Dialogs, IdAttachmentFile, AppEnvironment, AppDatabase ,Forms,
  ERPVersionConst;

function SendExceptionEmail(E: Exception  ; ExtraComments:String ):String;
begin
  if not devmode then exit;
  SendEmailtoErp('Error Error from :  ' + Appenv.Employee.EmployeeName+' ('+ Appenv.CompanyInfo.Companyname+')',
                                        'From     : ' + Appenv.CompanyInfo.Companyname+ chr(13) +
                                        'User     : ' + Appenv.Employee.EmployeeName+ chr(13) +
                                        'Version  : ' +TABLE_VERSION+chr(13) +
                                        'Date     : ' +formatDateTime('dd-mm-yyyy hh:nn' , now()) +chr(13)+
                                        'ERP form Name : ' +Screen.activeform.classname +chr(13)+
                                        'Error :' + E.Message, '' );

end;

function SendEmailtoErp(Const Subject:String; Value:String;emaillogPrefix:String='emaillog'; Attachmentfilename:String = '';EmailAddress:String =''):String;
var
  exMessage: TIdMessage;
  exSMTP: TIdSMTP;
  ExceptionLogFile:String;
  VAttachment: TIdAttachment;
begin
  result := '';
  exMessage := TIdMessage.Create(nil);
  exSMTP := TIdSMTP.Create(nil);
  try
    try

      exSMTP.Host := SMTPHost;
      exSMTP.Port := SMTP3Port;
//      {$ifdef COMPILER_22_UP}
      exSMTP.AuthType := satDefault;
//      {$else}
//      exSMTP.AuthenticationType := atLogin;
//      {$endif}
      exSMTP.Username := SMTPUsername;
      exSMTP.Password := SMTPPassword;
      exMessage.From.Text := 'ERPLog <' + ERPEmailId +'>';
      if EmailAddress = '' then exMessage.Recipients.EMailAddresses := 'ERPLog <' + ERPEmailId +'>'
      else exMessage.Recipients.EMailAddresses := EmailAddress;
      exMessage.Subject := Subject;
      if devmode then exMessage.Subject := 'DEVMODE EMAIL..... ' + exMessage.Subject;

      if (Attachmentfilename <> '') and (FileExists(Attachmentfilename)) then begin
          VAttachment:= nil;
          exMessage.DoCreateAttachment(nil , VAttachment);
          if assigned(VAttachment) then begin
            VAttachment.Loadfromfile(Attachmentfilename);
            VAttachment.FileName:=Attachmentfilename;
          end;
      end;
      exMessage.Body.Add(Value);

//      {$IFNDEF CONSOLE}
      {$IFDEF GUI}
      if Assigned(UserActions) and (char_length(UserActions.EventList.Text) > 0) then begin
        exMessage.Body.Add('');
        exMessage.Body.Add('User Actions:');
        exMessage.Body.Add(UserActions.EventList.Text);
      end;
      {$ENDIF}

      Try
//        {$ifdef COMPILER_22_UP}
        exSMTP.ConnectTimeout:= 5000;
        exSMTP.Connect;
//        {$else}
//        exSMTP.Connect(5000);
//        {$endif}
      except
      end;

      if exSMTP.Connected then  begin
        try
          exSMTP.Send(exMessage);
        Except
          on E:Exception do begin
            CommonLib.MessageDlgXP_Vista('Export and Email failed:' + E.Message, mtWarning, [mbOK], 0);
          end;
        end;
      end else Begin
        exSMTP.Host := System_SMTPHost;
        exSMTP.Port := System_SMTPPort;
//        {$ifdef COMPILER_22_UP}
          exSMTP.AuthType := satNone;
//        {$else}
//        If ExceptionAppInfo.EmailUseAuthentication then Begin
//          exSMTP.AuthenticationType := atLogin;
//        end else Begin
//          exSMTP.AuthenticationType := atNone;
//        end;
//        {$endif}
        try
          exSMTP.Username := System_SMTPUsername;
          exSMTP.Password := System_SMTPPassword;
//          {$ifdef COMPILER_22_UP}
          exSMTP.ConnectTimeout:= 5000;
          exSMTP.Connect;
//          {$else}
//          exSMTP.Connect(5000);
//          {$endif}
        Except
          on E:Exception do begin
            CommonLib.MessageDlgXP_Vista('Export and Email failed:' + E.Message, mtWarning, [mbOK], 0);
          end;
        end;

        if not exSMTP.Connected then begin
          CommonLib.MessageDlgXP_Vista('Export and Email failed. Please Contact ERP' , mtWarning, [mbOK], 0);
          Exit;
        end;

        try
          exSMTP.Send(exMessage)
        Except
          on E:Exception do begin
            CommonLib.MessageDlgXP_Vista('Export and Email failed:' + E.Message, mtWarning, [mbOK], 0);
          end;
        end;
      end;
    except
      ExceptionLogFile:= GetSendEmailtoErpExcLogFileName(emaillogPrefix);
      if FileExists(ExceptionLogFile) then Begin
//        {$ifdef COMPILER_22_UP}
        TIdAttachmentFile.Create(exMessage.MessageParts, ExceptionLogFile);
//        {$else}
//        TIdAttachment.Create(exMessage.MessageParts, ExceptionLogFile);
//        {$endif}
        result :=ExceptionLogFile;
      end;
    end;
  finally
    FreeAndNil(exMessage);
    FreeAndNil(exSMTP);
  end;

end;


end.
