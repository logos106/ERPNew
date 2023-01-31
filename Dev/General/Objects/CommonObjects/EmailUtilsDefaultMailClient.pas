unit EmailUtilsDefaultMailClient;
{$I ERP.inc}
interface
uses
  Controls,IdMessage;

type
  TDummySender = class(TControl)
  private
    procedure DoTooManyFiles(Sender: TObject);
    procedure DoTooManyRecips(Sender: TObject);
    procedure DoTextTooLarge(Sender: TObject);
    procedure DoUserAbort(Sender: TObject);
    procedure AttachmentNotFound(Sender: TObject);
    procedure AttachmentOpenFailure(Sender: TObject);
  end;

procedure SendMail(Const EMessage: TIdMessage; AlwaysPreview: boolean = false); overload;
procedure SendMail(const Recipients, Subject, Body: string); overload;

implementation

uses
  AFQuickMail,SysUtils, Vista_MessageDlg,Dialogs, AppEnvironment, EmailLib
  {$ifdef COMPILER_22_UP}
  ,IdMessageParts
  ,IdAttachment
  {$endif}, CommonLib, SystemLib, forms;

procedure TDummySender.DoTooManyFiles(Sender: TObject);
begin
  Vista_MessageDlg.MessageDlgXP_Vista('Email message not sent, too many attached files.',mtWarning,[mbOk],0);
end;

procedure TDummySender.DoTooManyRecips(Sender: TObject);
begin
  Vista_MessageDlg.MessageDlgXP_Vista('Email message not sent, too many recipients.',mtWarning,[mbOk],0);
end;

procedure TDummySender.DoTextTooLarge(Sender: TObject);
begin
  Vista_MessageDlg.MessageDlgXP_Vista('Email message not sent, body text too large.',mtWarning,[mbOk],0);
end;

procedure TDummySender.DoUserAbort(Sender: TObject);
begin
  Vista_MessageDlg.MessageDlgXP_Vista('Email message not sent, cancelled by user.',mtInformation,[mbOk],0);
end;

procedure TDummySender.AttachmentNotFound(Sender: TObject);
begin
  Vista_MessageDlg.MessageDlgXP_Vista('Attachment Not Found.',mtWarning,[mbOk],0);
end;

procedure TDummySender.AttachmentOpenFailure(Sender: TObject);
begin
  Vista_MessageDlg.MessageDlgXP_Vista('Attachment Open Failure.',mtWarning,[mbOk],0);
end;

procedure SendMail(Const EMessage: TIdMessage; AlwaysPreview: boolean = false);
Var
  DummySender: TDummySender;
  QuickMail: TAFQuickMail;
  I:Integer;
  MP: TIdMessagePart;
  s: string;
  x: integer;
begin
  DummySender := TDummySender.Create(nil);
  QuickMail := TAFQuickMail.Create(DummySender);
  try
    QuickMail.OnAttachmentNotFound := DummySender.AttachmentNotFound;
    QuickMail.OnAttachmentOpenFailure := DummySender.AttachmentOpenFailure;
    QuickMail.OnTooManyFiles := DummySender.DoTooManyFiles;
    QuickMail.OnTooManyRecips := DummySender.DoTooManyRecips;
    QuickMail.OnTextTooLarge := DummySender.DoTextTooLarge;
    QuickMail.OnUserAbort := DummySender.DoUserAbort;
    QuickMail.ResetAll;
    QuickMail.TextToSend := EMessage.Body;
    s := '';
    for x := 0 to EMessage.Recipients.Count -1 do begin
      //if s <> '' then s := s + ';';
      //s := s + EMessage.Recipients[x].Address;
      QuickMail.ToEmail.Add(EMessage.Recipients[x].Address);
    end;

//    QuickMail.ToEmail.Text := EMessage.Recipients.EMailAddresses;
//    QuickMail.ToEmail.Text := s;
    QuickMail.Subject :=  EMessage.Subject;
    QuickMail.ToCCEmail.Text := EMessage.CCList.EMailAddresses;
    QuickMail.ToBCCEmail.Text := EMessage.BccList.EMailAddresses;
    for I := 0 to EMessage.MessageParts.Count - 1 do begin
      MP := EMessage.MessageParts[I];
      if MP is TIdAttachment then begin
        if SameText(MP.ContentDisposition,'Inline') then
          QuickMail.FileNames.Add(EmailLib.EmailTempMessageDir + TIdAttachment(MP).FileName)
        else if FileExists(EmailLib.EmailTempAttachmentDir +TIdAttachment(MP).FileName) then
          QuickMail.FileNames.Add( EmailLib.EmailTempAttachmentDir +TIdAttachment(MP).FileName)
        else if FileExists(Commonlib.TempDir +TIdAttachment(MP).FileName) then
          QuickMail.FileNames.Add( Commonlib.TempDir +TIdAttachment(MP).FileName)
        else if FileExists(GetAppTempDir + '\' + TIdAttachment(MP).FileName) then
          QuickMail.FileNames.Add( GetAppTempDir + '\' + TIdAttachment(MP).FileName);
      end;
    end;
    QuickMail.ShowDialog := AppEnv.CompanyPrefs.DefaultMailClientPreview or AlwaysPreview;
    try
      QuickMail.Execute;
    except
      on e: exception do begin
        showmessage(e.Message);
      end;
    end;
    systemLib.BringWindowToFront(EMessage.Subject);
    Application.ProcessMessages;
  finally
    FreeandNil(QuickMail);
    FreeandNil(DummySender);
  end;
end;

procedure SendMail(const Recipients, Subject, Body: string); overload;
var
  FMessage: TIdMessage;
begin
  FMessage:= TIdMessage.Create(nil);
  try
    fMessage.Recipients.EMailAddresses:= Recipients;
    fMessage.Subject:= Subject;
    fMessage.Body.Text:= Body;
    SendMail(fMessage,true);

  finally
    fMessage.Free;
  end;
end;


end.
