unit CorrespondenceObj;

interface
{$I ERP.inc}

uses
  classes, BusObjCorrespondence, BusObjEmailConfig, ConTnrs,
  InlineAttachmentListObj, HTMLUtils , TaskDialog;

type

  TCorrespondenceType = (ctEmail, ctSMS, ctHRForm, ctPrint);

//  TCorresEntityID = record
//    ContactId,
//    CustomerId,
//    SupplierId,
//    MarketingContactId,
//    EmployeeId,
//    OtherContactId,
//    RepairID: integer;
//  end;

  TRecipientType = (rtUnknown,rtContact,rtCustomer,rtSupplier,rtMarketingContact,rtEmployee,rtOtherContact,rtRepair ,rtHrform);

  TCorrespondenceGui = class(TObject)
  private
    fMessageText: string;
    fSupId: Integer;
    fContactId: Integer;
    fCorrespondenceType: TCorrespondenceType;
    fCCList: string;
    fMarketingContactId: integer;
    fSubject: string;
    fRepairID: Integer;
    fHRFormID: Integer;
    fOtherContactId: Integer;
    fEmployeeId: Integer;
    fBCCList: string;
    fRecipientList: string;
    fReplyTo: string;
    fCusId: Integer;
    fFrom: string;
    fEmailConfig: TEmailConfig;
    fMessageRichText: string;
    fRecipientType: TRecipientType;
    fAssignedEmailConfig: TEmailConfig;
    fbCheckForMailAttachments: Boolean;
    fsAttachmentTablename: String;
    fiAttachmentTableID: Integer;
    fDeleteAttachments: boolean;
    fsREferenceDatafile: String;
    procedure OnTagStart(Sender: THTMLParser; TagName: string);
    function GetEmailConfig: TEmailConfig;
    function getBCCList: string;
    function getCCList: string;
    function getRecipientList: string;
    function getReplyTo: string;
    procedure SetRecipientList(const Value: string);
  public
    AttachmentList: TStringList;
    InlineAttachmentList: TInlineAttachmentList;
    GroupRecipientList: TStringList;
    Correspondence: TCorrespondence;
    constructor Create;
    destructor Destroy; override;
    property CorrespondenceType: TCorrespondenceType read fCorrespondenceType write fCorrespondenceType;
    property RecipientList: string read getRecipientList write SetRecipientList;
    property CCList: string read getCCList write fCCList;
    property BCCList: string read getBCCList write fBCCList;
    property ReplyTo: string read getReplyTo write fReplyTo;
    property Subject: string read fSubject write fSubject;
    property MessageText: string read fMessageText write fMessageText;
    property MessageRichText: string read fMessageRichText write fMessageRichText;
    property From: string read fFrom write fFrom;

    Property ContactId: Integer Read fContactId Write fContactId;
    Property CustomerId: Integer Read fCusId Write fCusId;
    Property SupplierId: Integer Read fSupId Write fSupId;
    property MarketingContactId: integer read fMarketingContactId write fMarketingContactId;
    Property EmployeeId: Integer Read fEmployeeId Write fEmployeeId;
    Property OtherContactId: Integer Read fOtherContactId Write fOtherContactid;
    Property RepairID: Integer Read fRepairID Write fRepairID;
    Property HRFormID: Integer Read fHRFormID Write fHRFormID;
    Property CheckForMailAttachments :Boolean read fbCheckForMailAttachments write fbCheckForMailAttachments;
    Property AttachmentTablename :String read fsAttachmentTablename write fsAttachmentTablename;
    Property AttachmentTableID :Integer read fiAttachmentTableID write fiAttachmentTableID;
    property DeleteAttachments: boolean read fDeleteAttachments write fDeleteAttachments;
    Property REferenceDatafile :String read fsREferenceDatafile write fsREferenceDatafile;

    property RecipientType: TRecipientType read fRecipientType write fRecipientType;

    property EmailConfig: TEmailConfig read GetEmailConfig write fAssignedEmailConfig;

    procedure Clear;

    function Execute(const Silent: boolean = false; const aSecret : boolean = false): boolean;  { silent = just send without showing gui }

    class function Email(const aTo, aCC, aSubject, aBody: string;aContactId, aCustomerId, aSupplierId, aMarketingContactId, aEmployeeId, aOtherContactId, aRepairId, aHRFormID: integer;aSilent: boolean = false; const aSecret : boolean = false;aMessageOption:Integer =104;aDoNotAskMsg :Boolean=False;aDoOnDoNotAskMsgCheck:TTaskDialogVerifyClickEvent =nil): boolean; overload;
    class function Email(const aTo, aCC, aSubject, aBody: string; aId: integer; aRecipientType: TRecipientType;aSilent: boolean = false; const aSecret : boolean = false): boolean; overload;
    class function EmailCustomer(aTo, aSubject, aBody: string;
      aCustomerId: integer; aSilent: boolean = false): boolean; overload;
    class function EmailCustomerSale(const aTo, aCC, aSubject, aBody: string;
      aCustomerId: integer; aSilent: boolean = false): boolean;overload;
    class function EmailSupplier(aTo, aSubject, aBody: string;
      aSupplier: integer; aSilent: boolean = false; aSecret : boolean = false): boolean;
    class function EmailEmployee(aTo, aSubject, aBody: string;aEmployeeID: integer; aSilent: boolean = false;aMessageOption:Integer =104; aDoNotAskMsg :Boolean = false;aDoOnDoNotAskMsgCheck:TTaskDialogVerifyClickEvent = nil): boolean;

    class function SMS(aTo, aBody: string;
      aContactId, aCustomerId, aSupplierId, aMarketingContactId, aEmployeeId, aOtherContactId, aRepairId, aHRFormID: integer;
      aSilent: boolean = false): boolean; overload;
    class function SMS(aTo, aBody: string; aId: integer; aRecipientType: TRecipientType;
      aSilent: boolean = false): boolean; overload;
    class function SMSCustomer(aTo, aBody: string;
      aCustomerId: integer; aSilent: boolean = false): boolean;
    class function SMSSupplier(aTo, aBody: string;
      aSupplierId: integer; aSilent: boolean = false): boolean;
  end;

//  procedure ClearEntityIDs(var ID: TCorresEntityID);
Function EmailToAddress(Const aTo:String):String;

implementation

{ NOTE: This must be included for ERP.exe build but comment out for server module builds
    Moved this to ERP.INC as Ian suggested}
// {$DEFINE GUIAPP}

uses
  SysUtils, Vista_MessageDlg, Dialogs, SMSUtils,
  ERPdbComponents, AppEnvironment, SimpleEncrypt, EmailUtils, StrUtils, StringUtils,
  Controls, Forms , db
//  {$IFDEF CONSOLE}
//  {$ELSE}
  {$IFDEF GUIAPP}
  ,frmSMSMessage, EmailExtraUtils, frmEmailMessage
  {$ENDIF}
  , CommonLib, BusObjAttachment, SystemLib, RandomUtils, tcConst;

//procedure ClearEntityIDs(var ID: TCorresEntityID);
//begin
//  ID.ContactId := 0;
//  ID.CustomerId := 0;
//  ID.SupplierId := 0;
//  ID.MarketingContactId := 0;
//  ID.EmployeeId := 0;
//  ID.OtherContactId := 0;
//  ID.RepairID := 0;
//end;

const
  blank_ContactId = 0;
  blank_CustomerId = 0;
  blank_SupplierId = 0;
  blank_MarketingContactId = 0;
  blank_EmployeeId = 0;
  blank_OtherContactId = 0;
  blank_RepairId = 0;
  Blank_HRFormID = 0;

{ TCorrespondenceGui }

procedure TCorrespondenceGui.Clear;
begin
  AttachmentLIst.Clear;
  InlineAttachmentList.Clear;
  self.RecipientList := '';
  self.CCList := '';
  self.BCCList := '';
  self.ReplyTo := '';
  self.Subject := '';
  self.MessageText := '';
  self.MessageRichText := '';
  self.From := '';
  self.ContactId := 0;
  self.CustomerId := 0;
  self.SupplierId := 0;
  self.MarketingContactId := 0;
  self.EmployeeId := 0;
  self.OtherContactId := 0;
  self.RepairID := 0;
  self.HRFormID := 0;
end;

constructor TCorrespondenceGui.Create;

  function DomainFromEmail(aEmail: string): string;
  var i: integer;
  begin
    result := '';
    i := Pos('@',aEmail);
    if i > 0 then
      result := Copy(aEmail,i,Length(aEmail));
  end;

begin
  REferenceDatafile := '';
  CheckForMailAttachments := false;
  fCorrespondenceType := ctEmail;
  AttachmentList := TStringList.Create;
  GroupRecipientList := TStringList.Create;
  InlineAttachmentList := TInlineAttachmentList.Create;
  InlineAttachmentList.Domain := DomainFromEmail(EmailConfig.EmailAddress);
  Correspondence := TCorrespondence.CreateWithNewConn(nil);
  Correspondence.Load(0);
  fRecipientType := rtUnknown;
  fDeleteAttachments := false;
end;

destructor TCorrespondenceGui.Destroy;
begin
  AttachmentList.Free;
  InlineAttachmentList.Free;
  GroupRecipientList.Free;
  Correspondence.Free;
  fEmailConfig.Free;
  inherited;
end;

class function TCorrespondenceGui.Email(const aTo, aCC, aSubject, aBody: string;aContactId, aCustomerId, aSupplierId, aMarketingContactId, aEmployeeId, aOtherContactId, aRepairId, aHRFormID: integer;aSilent: boolean = false; const aSecret : boolean = false;aMessageOption:Integer =104;aDoNotAskMsg :Boolean=False;aDoOnDoNotAskMsgCheck:TTaskDialogVerifyClickEvent =nil): boolean;
var
  corres: TCorrespondenceGui;
//  {$IFNDEF CONSOLE}
  {$IFDEF GUIAPP}
  lSecret : boolean;
  {$ENDIF}
begin
  Result := false;
  corres := TCorrespondenceGui.Create;
  try
    corres.CorrespondenceType := ctEmail;
    corres.RecipientList := EmailToAddress(aTo);
    corres.Subject := aSubject;
    corres.MessageText := aBody;
    if aCC <> '' then
      corres.CCList := aCC;
    corres.ContactId := aContactId;
    corres.CustomerId := aCustomerId;
    corres.SupplierId := aSupplierId;
    corres.MarketingContactId := aMarketingContactId;
    corres.EmployeeId := aEmployeeID;
    corres.OtherContactId := aOtherContactId;
    corres.RepairID := aRepairId;
    corres.HRFormID := aHRFormID;
//    {$IFNDEF CONSOLE}
    {$IFDEF GUIAPP}
    lSecret := false;
    if aSilent and not aSecret then
    begin
      if SameText(Corres.EmailConfig.IntegrationType, 'Email Client') then
        case EmailSendMode(1, false ,aMessageOption ,  aDoNotAskMsg , aDoOnDoNotAskMsgCheck) of
          smSilent : lSecret := true;
          smSend : lSecret := false;
          smNone : exit;
        end;
    end
    else
      lSecret := aSecret;
    result := corres.Execute(aSilent, lSecret);
    {$ELSE}
    Result := corres.Execute(aSilent, aSecret);
    {$ENDIF}

  finally
    corres.Free;
  end;
end;

class function TCorrespondenceGui.EmailCustomer(aTo, aSubject, aBody: string;
  aCustomerId: integer; aSilent: boolean): boolean;
begin
  result := TCorrespondenceGui.Email(EmailToAddress(aTo), '', aSubject, aBody,
    blank_ContactId, aCustomerId, blank_SupplierId, blank_MarketingContactId, blank_EmployeeId, blank_OtherContactId, blank_RepairId,Blank_HRFormID,
    aSilent);
end;

class function TCorrespondenceGui.EmailCustomerSale(const aTo, aCC, aSubject,
  aBody: string; aCustomerId: integer; aSilent: boolean): boolean;
begin
  result := TCorrespondenceGui.Email(EmailToAddress(aTo), aCC, aSubject, aBody,
    blank_ContactId, aCustomerId, blank_SupplierId, blank_MarketingContactId, blank_EmployeeId, blank_OtherContactId, blank_RepairId,Blank_HRFormID,
    aSilent);
end;

class function TCorrespondenceGui.EmailEmployee(aTo, aSubject, aBody: string;
      aEmployeeID: integer; aSilent: boolean = false;aMessageOption:Integer =104;aDoNotAskMsg :Boolean = false;aDoOnDoNotAskMsgCheck:TTaskDialogVerifyClickEvent = nil): boolean;
begin
  result := TCorrespondenceGui.Email(EmailToAddress(aTo), '', aSubject, aBody,
    blank_ContactId, blank_CustomerId, blank_SupplierId, blank_MarketingContactId, aEmployeeId, blank_OtherContactId, blank_RepairId,Blank_HRFormID,
    aSilent ,False, aMessageOption, aDoNotAskMsg ,aDoOnDoNotAskMsgCheck);
end;

class function TCorrespondenceGui.EmailSupplier(aTo, aSubject, aBody: string;
  aSupplier: integer; aSilent: boolean; aSecret : boolean): boolean;
begin
  result := TCorrespondenceGui.Email(EmailToAddress(aTo), '', aSubject, aBody,
    blank_ContactId, blank_CustomerId, aSupplier, blank_MarketingContactId, blank_EmployeeId, blank_OtherContactId, blank_RepairId,Blank_HRFormID,
    aSilent, aSecret);
end;

function EmailToAddress(const aTo: String): String;
begin
  if devmode then result := ERPEmailId else result := ATo;
end;

class function TCorrespondenceGui.Email(const aTo, aCC, aSubject, aBody: string;
  aId: integer; aRecipientType: TRecipientType; aSilent: boolean = false; const aSecret : boolean = false): boolean;
var
  corres: TCorrespondenceGui;
  lSecret : boolean;
begin
  corres := TCorrespondenceGui.Create;
  try
    corres.CorrespondenceType := ctEmail;
    corres.RecipientList := EmailToAddress(aTo);
    corres.Subject := aSubject;
    corres.MessageText := aBody;
    if aCC <> '' then
      corres.CCList := aCC;

    corres.ContactId := 0;
    corres.CustomerId := 0;
    corres.SupplierId := 0;
    corres.MarketingContactId := 0;
    corres.EmployeeId := 0;
    corres.OtherContactId := 0;
    corres.RepairID := 0;
    corres.HRFormID := 0;

    case aRecipientType of
      rtUnknown: ;
      rtContact: corres.ContactId := aId;
      rtCustomer: corres.CustomerId := aId;
      rtSupplier: corres.SupplierId := aId;
      rtMarketingContact: corres.MarketingContactId := aId;
      rtEmployee: corres.EmployeeId := aId;
      rtOtherContact: corres.OtherContactId := aId;
      rtRepair: corres.RepairID := aId;
      rtHrForm: corres.HRFormID := aId;
    end;

//    {$IFNDEF CONSOLE}
    {$IFDEF GUIAPP}
    lSecret := false;
    if aSilent and not aSecret then
    begin
      if SameText(Corres.EmailConfig.IntegrationType, 'Email Client') then
        case EmailSendMode(1, false) of
          smSilent : lSecret := true;
          smSend : lSecret := false;
          smNone : begin
            Result := false;
            exit;
          end;
        end;
    end
    else
      lSecret := aSecret;

    result := corres.Execute(aSilent, lSecret);
    {$ELSE}
    Result := corres.Execute(aSilent, aSecret);
    {$ENDIF}

  finally
    corres.Free;
  end;
end;

function TCorrespondenceGui.Execute(const Silent: boolean = false; const aSecret : boolean = false): boolean;
var
  ShowGui: boolean;
  trackRef: string;
  sl: TStringList;
  MailSender: TMailSender;
  sigName, sigDir: string;
  s: string;
  Parser: THTMLParser;
  Save_Cursor: TCursor;
  SendCount: integer;
  Procedure SaveREferenceDatafile;
  var
    BLOB : TStream;
    fs : TFileStream;
  begin
    if REferenceDatafile = '' then exit;
   try
    Correspondence.EditDB;
    fs := TFileStream.Create(REferenceDatafile , fmOpenRead);
    fs.Position:= 0;
    blob := TERPQuery(Correspondence.dataset).CreateBlobStream(Correspondence.dataset.fieldByname('ReferenceData') , bmWrite);
    blob.CopyFrom(fs,0);
    Correspondence.PostDB;
  finally
    Freeandnil(fs);
    Freeandnil(blob);
  end;

  end;
  Procedure MakeNewHRRecord;
  begin
    Correspondence.New;
    Correspondence.Ref_Type := 'HR Doc';
    Correspondence.Ref_Date := now;
    Correspondence.ReferenceTxt := Copy(Subject,1,50);
    Correspondence.CusId := CustomerId;
    Correspondence.EmployeeId := EmployeeId;
    Correspondence.HRFormID := HRFormID;
    Correspondence.PostDb;
  end;
  procedure MakeNewCorrespondenceEmailRecord;
  begin
    Correspondence.New;
    Correspondence.Ref_Type := 'Email';
    Correspondence.Ref_Date := now;
    Correspondence.ReferenceTxt := Copy(Subject,1,50);
    Correspondence.MessageTo := RecipientList;
    if From  = '' then
      From := AppEnv.Employee.EmployeeName + ' <' +  EmailConfig.EmailAddress + '>';
    Correspondence.MessageFrom := From;

    Correspondence.ContactId := ContactId;
    Correspondence.CusId := CustomerId;
    Correspondence.SupId := SupplierId;
    Correspondence.MarketingContactId := MarketingContactId;
    Correspondence.EmployeeId := EmployeeId;
    Correspondence.OtherContactId := OtherContactId;
    Correspondence.RepairID := RepairID;
    Correspondence.HRFormID := HRFormID;
    Correspondence.PostDb;
  end;

  function MakeNewCorrespondenceSMSRecord(aMessageTo: string = ''): boolean;
  begin
    result := true;
    Correspondence.New;
    Correspondence.Ref_Type := 'SMS';
    Correspondence.Ref_Date := now;
    Correspondence.ReferenceTxt := Copy(Subject,1,50);
    if aMessageTo <> '' then
      Correspondence.MessageTo := aMessageTo
    else
      Correspondence.MessageTo := RecipientList;
    Correspondence.MessageFrom := From;
    Correspondence.ContactId := ContactId;
    Correspondence.CusId := CustomerId;
    Correspondence.SupId := SupplierId;
    Correspondence.MarketingContactId := MarketingContactId;
    Correspondence.EmployeeId := EmployeeId;
    Correspondence.OtherContactId := OtherContactId;
    Correspondence.RepairID := RepairID;
    Correspondence.HRFormID := HRFormID;

    Correspondence.Status := 'Waiting';
    Correspondence.SMS.Format := 'SMS';
    Correspondence.SMS.Status := 'Waiting';
    if aMessageTo <> '' then
      Correspondence.SMS.PhoneNumber := aMessageTo
    else
      Correspondence.SMS.PhoneNumber := RecipientList;
    {$IFDEF DevMode}
    Correspondence.SMS.PhoneNumber := SMSUtils.DevMode_MobileNumber;
    {$ENDIF}
    Correspondence.SMS.Content := MessageText;
    Correspondence.ReferenceTxt := Copy(Correspondence.SMS.Content,1,50);
    if not Correspondence.Save then begin
      MessageDlgXP_Vista(Correspondence.ResultStatus.Messages,mtWarning,[mbOk],0);
      Correspondence.Connection.RollbackTransaction;
      result := false;
      exit;
    end;
  end;

  function  DoCheckForMailAttachments:String;
  var
    Att: TAttachment;
    attName: string;
  begin
    Result := '';
    if not CheckForMailAttachments  then exit;
    if (AttachmentTablename = '') then exit;
    if (AttachmentTableID   = 0 ) then Exit;

    Att := TAttachment.Create(nil);
    try
      Att.Connection := Correspondence.Connection;
      Att.LoadSelect('TableName = ' + Quotedstr(AttachmentTablename)+ ' and TableId = ' + inttostr(AttachmentTableID));
      if Att.Count > 0 then begin
        while not Att.EOF do begin
          // GetAppTempDir
          attName := IncludeTrailingPathDelimiter(GetAppTempDir) + ChangeFileExt(Att.AttachmentName,' ' + MakeRandomString(6) + ExtractFileExt(Att.AttachmentName));
          Att.SaveToFile(attName);
          AttachmentList.Add(attName);
          if result <> '' then result := result + ',';
          result := result + Att.AttachmentName;
          Att.Next;
        end;
      end;
    finally
      Att.Free;
    end;
  end;

begin
  result := false;
  ShowGui := not Silent;
  if CorrespondenceType = ctEmail then begin
    (*if (EmailConfig.Count = 0) and not aSecret then begin  // secret email uses default ERP mail server
      MessageDlgXP_Vista('Email settings have not been configured', mtInformation,[mbOk], 0);
      if devmode then result := TRue; // just for the devmode to override the erorr
      exit;
    end;*)
    if (not ShowGui) and ((RecipientList = '') or (MessageText = '') or (Subject = '')) then begin
      { missing data so we need to show the form }
      ShowGui := true;
    end;

    if GroupRecipientList.Count > 0 then begin
        case self.RecipientType of
            rtUnknown: ;
            rtContact: ContactId := Integer(GroupRecipientList.Objects[0]);
            rtCustomer: self.CustomerId := Integer(GroupRecipientList.Objects[0]);
            rtSupplier: self.SupplierId := Integer(GroupRecipientList.Objects[0]);
            rtMarketingContact: MarketingContactId := Integer(GroupRecipientList.Objects[0]);
            rtEmployee: EmployeeId := Integer(GroupRecipientList.Objects[0]);
            rtOtherContact: OtherContactId := Integer(GroupRecipientList.Objects[0]);
            rtRepair: RepairID := Integer(GroupRecipientList.Objects[0]);
            rthrform: HRFormID := Integer(GroupRecipientList.Objects[0]);
          end;
    end;



    Correspondence.Connection.BeginTransaction;
    try
      MakeNewCorrespondenceEmailRecord;

      if Trim(ReplyTo) = '' then
        ReplyTo := EmailConfig.ReplyEmailAddress;

      { add tracking if needed }
      if (AppEnv.Employee.TrackEmails) and (EmailConfig.EmailAddress <> '') then begin
        if BCCList <> '' then BCCList := BCCList + ',';
        BCCList := BCCList + AppEnv.Employee.EmployeeName + ' <' + EmailConfig.EmailAddress + '>';
        trackRef := SimpleCrypt(Correspondence.Connection.Connection.Database)+ '-id-'+ IntToStr(Correspondence.ID);
      end;

      if SameText(EmailConfig.IntegrationType, 'Server') or aSecret then begin //@@@
        { html message formatting }
        s := '<p>' + StrUtils.ReplaceStr(MessageText,#13#10,'<br>') + '</p>';

        MessageRichText :=
          '<html>' + #13#10 +
          '  <head>' + #13#10 +
          '  <title>Email generated by TrueERP</title>' + #13#10 +
          '  </head>' + #13#10 +
          '  <body bgcolor="#ffffff" leftmargin=10 topmargin=5 rightmargin=10 bottommargin=5>' + #13#10 +
          '    <font size=2 color="#000000" face="Arial">' + #13#10 +
                 s + '<br>' + #13#10 +
          '    </font>' + #13#10 +
          '    <!--SignaturePlaceHolder-->' + #13#10 +
          '    <!--TrackingPlaceHolder-->' + #13#10 +
          '  </body>' + #13#10 +
          '</html>';


        { signature handling .. }
        sl := TStringList.Create;
        try
          sigName := EmailConfig.SignatureFile;
          if (sigName <> '') then begin
            sl.LoadFromFile(sigName);
            if SameText(ExtractFileExt(sigName),'.htm') or SameText(ExtractFileExt(sigName),'.html') then begin
              { html attachment }
              { is this a whole html document }
              if IsHTMLDoc(sl) then begin
                MessageRichText := ReplaceStr(MessageRichText,'<!--SignaturePlaceHolder-->',ExtractBody(sl));
              end
              else begin
                MessageRichText := ReplaceStr(MessageRichText,'<!--SignaturePlaceHolder-->',sl.Text);
              end;
            end
            else if SameText(ExtractFileExt(sigName),'.txt') then begin
              { plain text signature }
              s := sl.Text;
              s := ReplaceStr(s,#13#10,'<br>');
              MessageRichText := ReplaceStr(MessageRichText,'<!--SignaturePlaceHolder-->',s);
              { add signature to plain message as well }
              MessageText := MessageText + #13#10 + sl.Text;
            end
            else begin
              { image signature }
              MessageRichText := ReplaceStr(MessageRichText,'<!--SignaturePlaceHolder-->','<img src=file://' + sigName + '>');
            end;
          end
          else begin
            { no signature file }

          end;
        finally
          sl.Free;
        end;

        if AppEnv.Employee.TrackEmails then begin
          { add tracking ref to html message }
          s := '<br><br>' + #13#10 +
            '<hr width="25%" align="left">' + #13#10 +
            '<p style="text-align: left; font-size: 9px;"><font size="1">' + #13#10 +
            'Sent by <a href="http://www.TrueERP.com">TrueERP</a><br>' + #13#10 +
            'Reference: '+ trackRef +' (do not remove or edit)</font></p>' + #13#10;
          MessageRichText := ReplaceStr(MessageRichText,'<!--TrackingPlaceHolder-->',s);
        end;
      end
      else begin
        { mail client integration, plain text only }
        sigName := EmailConfig.SignatureFile;
        if (sigName <> '') and SameText(ExtractFileExt(sigName),'.txt') then begin
          with TStringList.Create do begin
            LoadFromFile(sigName);
            MessageText := MessageText + #13#10 + Text;
            Free;
          end;
        end
        else begin
          { no signature }
        end;

        if AppEnv.Employee.TrackEmails then begin
          { add tracking ref to plain text message }
          MessageText := MessageText + #13#10 + #13#10 + #13#10 +
            '----------------------------------------------' + #13#10 +
            'Sent by TrueERP (www.trueerp.com)' + #13#10 +
            'Reference: ' + trackRef + ' (do not remove or edit)' + #13#10;
        end;
      end;

      if ShowGui and SameText(EmailConfig.IntegrationType, 'Server') then begin
        { need to do a bit of html formatting so text displays correctly in the editor }
        MessageText := '<p><font size="2">' + StrUtils.ReplaceStr(MessageText,#13#10,'<br>') + '</font></p>';
//        {$IFDEF CONSOLE}
        {$IFNDEF GUIAPP}
        result := false;
        exit;
        {$ELSE}
        if not frmEmailMessage.EditEmailMessage(self) then
          exit;
        {$ENDIF}
        Correspondence.ReferenceTxt := Copy(Subject,1,50);
        Correspondence.MessageTo := RecipientList;
        Correspondence.MessageFrom := From;
        Correspondence.PostDb;
      end
      else begin
        if SameText(EmailConfig.IntegrationType, 'Server') then begin
          { only need to do this for HTML formatted emails .. ie direct to server }
          EmailConfig.SignatureFiles.First;
          sigDir := ExtractFilePath(EmailConfig.SignatureFile);
          while not EmailConfig.SignatureFiles.EOF do begin
            if not EmailConfig.SignatureFiles.IsPrimary then
              InlineAttachmentList.AddFile(sigDir + EmailConfig.SignatureFiles.FileName);
            EmailConfig.SignatureFiles.Next;
          end;
        end;
      end;

        DoCheckForMailAttachments;
//      with TStringList.Create do begin
//        Text := MessageRichText;
//        savetofile('c:\temp\temp.html');
//      end;


      if self.InlineAttachmentList.Count > 0 then begin

        Parser := THTMLParser.Create;
        try
          Parser.HtmlText := MessageRichText;
          Parser.OnTagStart := OnTagStart;
          Parser.Parse;
          MessageRichText := Parser.HtmlText;
        finally
          Parser.Free;
        end;
      end;

      { now send the message }
      Save_Cursor := Screen.Cursor;
      Screen.Cursor := crHourGlass;
      try
        MailSender := TMailSender.Create;
        try
        (*
          if self.GroupRecipientList.Count > 0 then
            SendCount := self.GroupRecipientList.Count - 1
          else
        *)
            SendCount := 0;

          while (SendCount = 0) or (SendCount < GroupRecipientList.Count) do begin

            if SendCount > 0 then begin
              MakeNewCorrespondenceEmailRecord;
              Correspondence.ContactId := 0;
              Correspondence.CusId := 0;
              Correspondence.SupId := 0;
              Correspondence.MarketingContactId := 0;
              Correspondence.EmployeeId := 0;
              Correspondence.OtherContactId := 0;
              Correspondence.RepairID := 0;
              Correspondence.HRFormID := 0;
              case self.RecipientType of
                rtUnknown: ;
                rtContact: Correspondence.ContactId := Integer(GroupRecipientList.Objects[SendCount]);
                rtCustomer: Correspondence.CusId := Integer(GroupRecipientList.Objects[SendCount]);
                rtSupplier: Correspondence.SupId := Integer(GroupRecipientList.Objects[SendCount]);
                rtMarketingContact: Correspondence.MarketingContactId := Integer(GroupRecipientList.Objects[SendCount]);
                rtEmployee: Correspondence.EmployeeId := Integer(GroupRecipientList.Objects[SendCount]);
                rtOtherContact: Correspondence.OtherContactId := Integer(GroupRecipientList.Objects[SendCount]);
                rtRepair: Correspondence.RepairID := Integer(GroupRecipientList.Objects[SendCount]);
                rthrform: Correspondence.HRFormID := Integer(GroupRecipientList.Objects[SendCount]);
              end;

              Correspondence.PostDb;
              self.RecipientList := GroupRecipientList[SendCount];
            end;

            MailSender.EmailConfig := EmailConfig;
            MailSender.DeleteAttachments := DeleteAttachments;
            MailSender.RecipientList := self.RecipientList;
            MailSender.CCList := self.CCList;
            MailSender.BCCList := self.BCCList;
            MailSender.ReplyTo := self.ReplyTo;
            MailSender.From := self.From;
            MailSender.Subject := self.Subject;
            MailSender.MessageText := self.MessageText;
            MailSender.MessageRichText := self.MessageRichText;

            MailSender.AttachmentList.Assign(self.AttachmentList);
            MailSender.InlineAttachmentList.Assign(self.InlineAttachmentList);
            if aSecret and (RecipientList <> '') then
              Result := MailSender.Send(smSecret)
            else if SameText(EmailConfig.IntegrationType,'Server') then
              result := MailSender.Send(smServer)
            else
              result := MailSender.Send(smClient,false,ShowGUI);
            if not result then
              exit;
            if hrformId <> 0 then SaveREferenceDatafile;
            Inc(SendCount);
          end;
        finally
          MailSender.Free;
        end;
      finally
        Screen.Cursor := Save_Cursor;
      end;

      Correspondence.Connection.CommitTransaction;
    finally
      if Correspondence.Connection.InTransaction then
        Correspondence.Connection.RollbackTransaction;
    end;

  end
  else if CorrespondenceType = ctSMS then begin
    if (not ShowGui) and ((RecipientList = '') or (MessageText = '')) then begin
      { missing data so we need to show the form }
      ShowGui := true;
    end;
//    {$IFDEF CONSOLE}
    {$IFNDEF GUIAPP}
    result := false;
    exit;
    {$ELSE}
    if ShowGui and (not frmSMSMessage.EditSMSMessage(self)) then
      exit;
    {$ENDIF}
    Correspondence.Connection.BeginTransaction;

    if GroupRecipientList.Count > 0 then begin
      { multiple records to send }
      for SendCount := 0 to GroupRecipientList.Count -1 do begin
        ContactId := 0;
        CustomerId := 0;
        SupplierId := 0;
        MarketingContactId := 0;
        EmployeeId := 0;
        OtherContactId := 0;
        RepairID := 0;
        HRFormID := 0;
        case self.RecipientType of
          rtUnknown: ;
          rtContact: ContactId := Integer(GroupRecipientList.Objects[SendCount]);
          rtCustomer: CustomerId := Integer(GroupRecipientList.Objects[SendCount]);
          rtSupplier: SupplierId := Integer(GroupRecipientList.Objects[SendCount]);
          rtMarketingContact: MarketingContactId := Integer(GroupRecipientList.Objects[SendCount]);
          rtEmployee: EmployeeId := Integer(GroupRecipientList.Objects[SendCount]);
          rtOtherContact: OtherContactId := Integer(GroupRecipientList.Objects[SendCount]);
          rtRepair: RepairID := Integer(GroupRecipientList.Objects[SendCount]);
          rthrform: HRFormID := Integer(GroupRecipientList.Objects[SendCount]);
        end;
        if not MakeNewCorrespondenceSMSRecord(GroupRecipientList[SendCount]) then
          exit;
      end;
    end
    else begin
      { single record to send }
      if not MakeNewCorrespondenceSMSRecord then
        exit;
    end;


////    SendCount := self.GroupRecipientList.Count;
//    SendCount := 0;
//
//    while (SendCount = 0) or (SendCount < GroupRecipientList.Count) do begin
//      if SendCount > 0 then begin
//        ContactId := 0;
//        CustomerId := 0;
//        SupplierId := 0;
//        MarketingContactId := 0;
//        EmployeeId := 0;
//        OtherContactId := 0;
//        RepairID := 0;
//        HRFormID := 0;
//        case self.RecipientType of
//          rtUnknown: ;
//          rtContact: ContactId := Integer(GroupRecipientList.Objects[SendCount]);
//          rtCustomer: CustomerId := Integer(GroupRecipientList.Objects[SendCount]);
//          rtSupplier: SupplierId := Integer(GroupRecipientList.Objects[SendCount]);
//          rtMarketingContact: MarketingContactId := Integer(GroupRecipientList.Objects[SendCount]);
//          rtEmployee: EmployeeId := Integer(GroupRecipientList.Objects[SendCount]);
//          rtOtherContact: OtherContactId := Integer(GroupRecipientList.Objects[SendCount]);
//          rtRepair: RepairID := Integer(GroupRecipientList.Objects[SendCount]);
//          rthrform: HRFormID := Integer(GroupRecipientList.Objects[SendCount]);
//        end;
//        self.RecipientList := GroupRecipientList[SendCount];
//
//      end;
//      if not MakeNewCorrespondenceSMSRecord then exit;
//
//
//      Inc(SendCount);
//    end;

    Correspondence.Connection.CommitTransaction;
    AppEnv.UtilsClient.TriggerSMSSend;
  end else if CorrespondenceType = ctHRForm then begin
     MakeNewHRRecord;
     SaveREferenceDatafile;
     Correspondence.PostDB;
     Correspondence.Connection.CommitTransaction;
     REsult := True;
  end
  else begin
    raise Exception.Create(self.Classname + ' Unknown Correspondence Type');
  end;
end;


function TCorrespondenceGui.GetEmailConfig: TEmailConfig;
begin
  if Assigned(fAssignedEmailConfig) then
    Result := fAssignedEmailConfig
  else begin
    if not Assigned(fEmailConfig) then begin
      fEmailConfig := TEmailConfig.CreateWithSharedConn(nil);
      if AppEnv.Employee.UseEmpEmailAsFromAddress then
        fEmailConfig.LoadSelect('EntityName = ' + QuotedStr(AppEnv.Employee.EmployeeName))
      else
        fEmailConfig.LoadSelect('EntityName = "Company"');
    end;
    result := fEmailConfig;
  end;
end;


procedure TCorrespondenceGui.OnTagStart(Sender: THTMLParser; TagName: string);
var
  src: string;
  x: integer;
  i: integer;
begin
  if SameText(TagName, 'img') then begin
    src := StripQuotes(Sender.Attribute['src']);
    i := Pos('file:///',Lowercase(src));
    if i = 1 then begin
      src := Copy(src,9,Length(src));
      src := StrUtils.ReplaceStr(src,'/','\');
    end;
    for x := 0 to self.InlineAttachmentList.Count -1 do begin
      if SameText(src, InlineAttachmentList[x].FileName) or SameText(src, ExtractFileName(InlineAttachmentList[x].FileName)) then
        Sender.Attribute['src'] := '"' + 'cid:' + InlineAttachmentList[x].ContentID + '"';


    end;
  end;
end;

class function TCorrespondenceGui.SMS(aTo, aBody: string; aContactId,
  aCustomerId, aSupplierId, aMarketingContactId, aEmployeeId, aOtherContactId,
  aRepairId,aHRFormID: integer; aSilent: boolean): boolean;
var
  corres: TCorrespondenceGui;
begin
  corres := TCorrespondenceGui.Create;
  try
    corres.CorrespondenceType := ctSMS;
    corres.RecipientList := EmailToAddress(aTo);
    corres.MessageText := aBody;

    corres.ContactId := aContactId;
    corres.CustomerId := aCustomerId;
    corres.SupplierId := aSupplierId;
    corres.MarketingContactId := aMarketingContactId;
    corres.EmployeeId := aEmployeeID;
    corres.OtherContactId := aOtherContactId;
    corres.RepairID := aRepairId;
    corres.HRFormID := aHRFormID;

    result := corres.Execute(aSilent);
  finally
    corres.Free;
  end;
end;

procedure TCorrespondenceGui.SetRecipientList(const Value: string);
begin
  fRecipientList := Value;
end;

class function TCorrespondenceGui.SMS(aTo, aBody: string; aId: integer;
  aRecipientType: TRecipientType; aSilent: boolean): boolean;
var
  corres: TCorrespondenceGui;
begin
  corres := TCorrespondenceGui.Create;
  try
    corres.CorrespondenceType := ctSMS;
    corres.RecipientList := EmailToAddress(aTo);
    corres.MessageText := aBody;

    corres.ContactId := 0;
    corres.CustomerId := 0;
    corres.SupplierId := 0;
    corres.MarketingContactId := 0;
    corres.EmployeeId := 0;
    corres.OtherContactId := 0;
    corres.RepairID := 0;
    corres.HRFormID := 0;

    case aRecipientType of
      rtUnknown: ;
      rtContact: corres.ContactId := aId;
      rtCustomer: corres.CustomerId := aId;
      rtSupplier: corres.SupplierId := aId;
      rtMarketingContact: corres.MarketingContactId := aId;
      rtEmployee: corres.EmployeeId := aId;
      rtOtherContact: corres.OtherContactId := aId;
      rtRepair: corres.RepairID := aId;
      rtHrform: corres.HRFormID := aId;
    end;

    result := corres.Execute(aSilent);
  finally
    corres.Free;
  end;
end;

class function TCorrespondenceGui.SMSCustomer(aTo, aBody: string;
  aCustomerId: integer; aSilent: boolean): boolean;
begin
  result := TCorrespondenceGui.SMS(EmailToAddress(aTo), aBody,
    blank_ContactId, aCustomerId, blank_SupplierId, blank_MarketingContactId, blank_EmployeeId, blank_OtherContactId, blank_RepairId,Blank_HRFormID,
    aSilent);
end;

class function TCorrespondenceGui.SMSSupplier(aTo, aBody: string;
  aSupplierId: integer; aSilent: boolean): boolean;
begin
  result := TCorrespondenceGui.SMS(EmailToAddress(aTo), aBody,
    blank_ContactId, blank_CustomerId, aSupplierId, blank_MarketingContactId, blank_EmployeeId, blank_OtherContactId, blank_RepairId,Blank_HRFormID,
    aSilent);
end;

function MakeAddressList(AList : string; const aSubstitute : string) : string;
var
  lPos : integer;

  procedure AddOne(var ATo : string);
  begin
    if ATo = '' then
      ATo := ASubstitute
    else
      ATo := ATo + ';' + ASubstitute;
  end;
begin

  Result := '';
  while AList <> '' do
  begin
    lPos := pos(';', AList);
    if lPos > 0 then
    begin
      AddOne(Result);
      AList := Copy(AList,lPos +1, Length(AList));
    end
    else if AList <> '' then
    begin
      AddOne(Result);
      AList := '';
    end;
  end;
end;

function TCorrespondenceGui.getBCCList      : string;
begin
(*
  Result := fBCCList;
  if result <> '' then
    if devmode then
      Result := ERPEmailId;
*)
  if DevMode then
    Result := MakeAddressList(fBCCList, ERPEmailId)
  else
    Result := fBCCList;
end;
function TCorrespondenceGui.getCCList       : string;
begin
(*
  Result := fCCList;
  if result <> '' then
    if devmode then
      Result := ERPEmailId;
*)
  if DevMode then
    Result := MakeAddressList(fCCList, ERPEmailId)
  else
    Result := fCCList;
end;

function TCorrespondenceGui.getRecipientList: string;
begin
(*
  Result := fRecipientList;
  if result <> '' then
    if devmode then
    begin
      Result := ERPEmailId;
      Result := '';

    end;
  *)
  if DevMode then
    Result := MakeAddressList(fRecipientList, ERPEmailId)
  else
    Result := fRecipientList;

//Result := 'andrei.gribanov@gmail.com;andrei@erpoz.com';
end;

function TCorrespondenceGui.getReplyTo      : string;
begin
(*
  Result := fReplyTo;
  if result <> '' then
    if devmode then
      Result := ERPEmailId;
*)
  if DevMode then
    Result := MakeAddressList(fReplyTo, ERPEmailId)
  else
    Result := fReplyTo;
end;
end.
