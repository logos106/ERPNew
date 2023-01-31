unit EmailHTML;

interface
uses
  SysUtils,Classes,IdSMTP,IdMessage,
  IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient,
  IdText, IdAttachmentFile;

type
  TGroupRec = class(TObject)
  private
  public
    sGroup: string;
    sSend: Boolean;
    sTemplateName: string;
  end;

type
  TEmailHTML = class
  private
    fSMTP:TIdSMTP;
    fMsg:TIdMessage;
    FConnectTimeout: integer;
    fSubject:string;
    function Validated:boolean;
    procedure FileReplaceString(const FileName, searchstring, replacestring: string);
  public
    constructor Create;
    destructor Destroy; override;   
    property Subject:String read fSubject write fSubject;
    
    function Execute(const EmailAddress:string):Boolean;
  end;

implementation

uses
  MyAccess,ERPdbComponents,DnMLib,systemlib,CommonDBLib, CommonLib;

constructor TEmailHTML.Create;
begin
  Inherited;
  FMsg := TIdMessage.Create(nil);
  FSMTP := TIdSMTP.Create(nil);
  FConnectTimeout := -1;
end;

destructor TEmailHTML.Destroy;
begin
  FreeAndNil(FMsg);
  FreeAndNil(FSMTP);
  inherited;
end;

//procedure TEmailHTML.Execute(const EmailAddress:String);
//var
//  qry:TERPQuery;
//  htmpart,txtPart:TIdText;
// // idAttach : TIdAttachmentFile;  //indy10
//begin
//  qry := CommonDbLib.TempMyQuery;
//  try
//    qry.SQL.Text := 'SELECT * FROM tblmailmergehost';
//    qry.open;
//
//    fMsg.IsEncoded := True;
//    fMsg.CharSet   := 'iso-8859-1';
//    fMsg.Encoding  := meMIME;
//    fMsg.Subject   := fSubject;
//    fMsg.From.Text := qry.fieldByName('EmailAddress').AsString;
//    fMsg.From.Name := qry.fieldByName('FromContact').AsString;
//
//    fsmtp.Host := qry.fieldByName('SMTPHost').AsString;
//    fsmtp.Port := qry.fieldByName('SMTPPort').AsInteger;
//    fsmtp.Username := qry.fieldByName('UserID').AsString;
//    fsmtp.Password := qry.fieldByName('UserPassword').AsString; 
//    if not Validated then exit;
//    if not fsmtp.Connected then fsmtp.Connect();
//
//    fMsg.Recipients.Clear;
//    fMsg.Recipients.Add.Text := emailAddress;
//    fMsg.CCList.Clear;
//    fMsg.ContentType := 'multipart/related';
//    fMsg.Body.Clear;
//    htmPart := TidText.Create(fMsg.MessageParts);
//    txtPart := TidText.Create(fMsg.MessageParts);
//    try
//      htmPart.Body.LoadFromFile(ExeDir +  'MailMergeFiles\RPT0001.htm');
//      htmPart.ContentType  := 'text/html';
//      txtPart.ContentType  := 'text/plain';
//
//      { TODO -oRobin : when we get indy10 we can embed images }
//
//   //   try
//    //    idAttach:=TIdAttachmentFile.Create(MyMessage.MessageParts,ExeDir + '\MailMergeFiles\IMG0000.jpg');
//  //      idAttach.ContentType := 'image/jpeg';
//  //      idAttach.ExtraHeaders.Add('Content-ID: <'+ ExeDire +'\MailMergeFiles\IMG0000.jpg>');
//  //      idAttach.ExtraHeaders.Values['content-id'] := ExeDir + '\MailMergeFiles\IMG0000.jpg' ;
//  //      idAttach.DisplayName:= ExeDir + '\MailMergeFiles\IMG0000.jpg' ;
//  //      idAttach.ContentDisposition := 'inline';
//  //    except
//    //    idAttach.CleanupInstance ;
//    //  end;
//      fSMTP.Send(fMsg);
//    finally
//      htmPart.Free;
//    end;
//    fSMTP.Disconnect;
//  finally
//    FreeAndNil(qry);
//  end;
//end;

function TEmailHTML.Execute(const EmailAddress:String):Boolean;
var
  qry:TERPQuery;
  htmpart,txtPart:TIdText;
  bmppart,bmppart2,bmppart3,bmppart4: TIdAttachmentFile;
  html: TStrings;
begin
  Result := True;
  qry := CommonDbLib.TempMyQuery;

   bmppart := nil;
   bmppart2 := nil;
   bmppart3 := nil;
   bmppart4 := nil;
   txtPart := nil;
   htmPart := nil ;
   html    := nil; 
  try
    qry.SQL.Text := 'SELECT * FROM tblmailmergehost';
    qry.open;

    fMsg.IsEncoded := True;
    fMsg.CharSet   := 'iso-8859-1';
    fMsg.Encoding  := meMIME;
    fMsg.Subject   := fSubject;
    fMsg.From.Text := qry.fieldByName('EmailAddress').AsString;
    fMsg.From.Name := qry.fieldByName('FromContact').AsString;

    fsmtp.Host := qry.fieldByName('SMTPHost').AsString;
    fsmtp.Port := qry.fieldByName('SMTPPort').AsInteger;
    fsmtp.Username := qry.fieldByName('UserID').AsString;
    fsmtp.Password := qry.fieldByName('UserPassword').AsString;
    if not Validated then exit;

    fMsg.Recipients.Clear;
    fMsg.Recipients.Add.Text := emailAddress;
    fMsg.CCList.Clear;
    fMsg.ContentType := 'multipart/related';
    fMsg.Body.Clear;

    txtPart := TidText.Create(fMsg.MessageParts);
    txtPart.ContentType  := 'text/plain';
    htmPart := TidText.Create(fMsg.MessageParts,html);
    htmPart.ContentType  := 'text/html';
    if fileexists(ExeDir +  'MailMergeFiles\RPT0001.htm') then begin
     FileReplaceString(ExeDir +  'MailMergeFiles\RPT0001.htm', 'img src="', 'img src="cid:');
     htmPart.Body.LoadFromFile(ExeDir +  'MailMergeFiles\RPT0001.htm');
    end;

    if FileExists(ExeDir +  'MailMergeFiles\IMG0000.jpg') then begin
      bmppart := TIdAttachmentFile.Create(fMsg.MessageParts, ExeDir +  'MailMergeFiles\IMG0000.jpg'); //,
      bmppart.ContentType := 'image/jpeg';
      bmppart.ContentDisposition := 'inline';
      bmppart.ExtraHeaders.Values['content-id'] := 'IMG0000.jpg';
      bmppart.DisplayName := 'IMG0000.jpg';
    end;
    if FileExists(ExeDir +  'MailMergeFiles\IMG0001.jpg') then begin
      bmppart2 := TIdAttachmentFile.Create(fMsg.MessageParts,ExeDir +  'MailMergeFiles\IMG0001.jpg');
      bmppart2.ContentType := 'image/jpeg';
      bmppart2.ContentDisposition := 'inline';
      bmppart2.ExtraHeaders.Values['content-id'] := 'IMG0001.jpg';
      bmppart2.DisplayName := 'IMG0001.jpg';
    end;
    if FileExists(ExeDir +  'MailMergeFiles\IMG0002.jpg') then begin
      bmppart3 := TIdAttachmentFile.Create(fMsg.MessageParts, ExeDir +  'MailMergeFiles\IMG0002.jpg');
      bmppart3.ContentType := 'image/jpeg';
      bmppart3.ContentDisposition := 'inline';
      bmppart3.ExtraHeaders.Values['content-id'] := 'IMG0002.jpg';
      bmppart3.DisplayName := 'IMG0002.jpg';
    end;
    if FileExists(ExeDir +  'MailMergeFiles\IMG0003.jpg') then  begin
      bmppart4 := TIdAttachmentFile.Create(fMsg.MessageParts, ExeDir +  'MailMergeFiles\IMG0003.jpg');
      bmppart4.ContentType := 'image/jpeg';
      bmppart4.ContentDisposition := 'inline';
      bmppart4.ExtraHeaders.Values['content-id'] := 'IMG0003.jpg';
      bmppart4.DisplayName := 'IMG0003.jpg';
    end;
    //  bmppart.ExtraHeaders.Add('IMG0001.jpg');
    if not fsmtp.Connected then fsmtp.Connect();

    try
      fSMTP.Send(fMsg);
    except
      Result := False;
    end;

    fSMTP.Disconnect;
  finally
    FreeAndNil(qry);
    htmPart.Free;
    if Assigned(bmppart) then bmppart.Free;
    if Assigned(bmppart2) then bmppart2.Free;
    if Assigned(bmppart3) then bmppart3.Free;
    if Assigned(bmppart4) then bmppart4.Free;
    if Assigned(txtPart) then txtPart.Free;
  end;
end;


function TEmailHTML.Validated:boolean;
begin
  Result := True;
  if fsmtp.Host = '' then Result := False;
  if fsmtp.Port = 0 then Result := False;
  if fsmtp.Username = '' then Result := False;
  if fsmtp.Password = '' then Result := False;
end;

procedure TEmailHTML.FileReplaceString(const FileName, searchstring, replacestring: string);
var
  fs: TFileStream;
  S: string;
begin
  fs := TFileStream.Create(FileName, fmOpenread or fmShareDenyNone);
  try
    Setlength(S, fs.Size);
    fs.ReadBuffer(S[1], fs.Size);
  finally
    fs.Free;
  end;
  S  := StringReplace(S, SearchString, replaceString, [rfReplaceAll, rfIgnoreCase]);
  fs := TFileStream.Create(FileName, fmCreate);
  try
    fs.WriteBuffer(S[1], char_length(S));
  finally
    fs.Free;
  end;
end;

end.
