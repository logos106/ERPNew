unit MailReaderObj;

interface

uses
  JsonObject, EmailConst, IdMessage, ERPDbComponents, ConTnrs,
  LogThreadBase, LogMessageTypes;

type

//  TCheckMessageProc = procedure (aMessageHeader: TIdMessage; var ProcessMessage: boolean; var Continue: boolean) of object;
//  TProcessMessageProc = procedure (aMessage: TIdMessage; var DeleteMessage: boolean; var Continue: boolean) of object;

  TOnProgressProc = procedure (const msg: string; var Continue: boolean) of object;
  TOnGetMessageCount = procedure (const MessageCount: integer) of object;

 TClientContactEmailList = class;
 TMailReader = class
  private
    fConnection: TERPConnection;
    fOnProgress: TOnProgressProc;
    fEmailList: TClientContactEmailList;
    fOnGetMessageCount: TOnGetMessageCount;
    fActive: boolean;
    fOnLog: LogThreadBase.TOnLogEvent;
    function DoProgContinue(const msg: string): boolean;
    function EmailList: TClientContactEmailList;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
  public
    Config: TJsonObject;
    EmailAddress: string;
    Logger: TLoggerBase;
    constructor Create;
    destructor Destroy; override;
    property Connection: TERPConnection read fConnection write fConnection;
    property OnProgress: TOnProgressProc read fOnProgress write fOnProgress;
    property OnGetMessageCount: TOnGetMessageCount read fOnGetMessageCount write fOnGetMessageCount;
    function GetMail(var msg: string): boolean;
    property Active: boolean read fActive write fActive;
    property OnLog: LogThreadBase.TOnLogEvent read fOnLog write fOnLog;
  end;

  TClientContactEmailItem = class
  public
    ClientId,
    ContactId,
    MarketingContactId,
    EmployeeId: integer;
    IsCustomer,
    IsSupplier,
    IsOtherContact,
    IsMarketinfContact,
    IsEmployee: boolean;
    EmailAddress: string;
  end;

  TClientContactEmailList = class
  private
    fLIst: TObjectList;
  public
    DatabaseName: string;
    constructor Create;
    destructor Destroy; override;
    procedure Add(aClientId, aContactId, aMarketingContactId, aEmployeeId: integer;
      aIsCustomer: boolean; aIsSupplier: boolean; aIsOtherContact: boolean;
      aIsMarketingContact: boolean; aIsEmployee: boolean; aEmailAddress: string);
    procedure Clear;
    function ItemByEmail(aEmailAddress: string): TClientContactEmailItem;
  end;

//  TMessageComparisonItem = class
//  public
//    Id: integer;
//    SubjectMatchPercent: double;
//    SecondsBetween: integer;
//  end;

//  TMessageComparison = class
//  private
//    fList: TObjectList;
//  public
//    constructor Create;
//    destructor Destroy; override;
//    procedure Clear;
//    procedure Add(aId: integer; aListTime: TDateTime; aListSubject: string; aMessage: TIdMessage);
//  end;

implementation

uses
  Classes, SysUtils, Db, DbTables, DateUtils, SimpleEncrypt, Types, StrUtils,
  IdPOP3, IdSMTP, IdExplicitTLSClientServerBase, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdGlobal, IdText,
  IdSMTPBase, IdIMAP4;

{ TMailReader }

constructor TMailReader.Create;
begin
  Config := TJsonObject.Create;
  EmailAddress := '';
end;

destructor TMailReader.Destroy;
begin
  Config.Free;
  fEmailList.Free;
  inherited;
end;

function TMailReader.DoProgContinue(const msg: string): boolean;
var
  Continue: boolean;
begin
  Continue:= true;
  if Assigned(fOnProgress) then
    fOnProgress(msg, Continue);
  result := Continue;
end;

function TMailReader.EmailList: TClientContactEmailList;
var
  qry: TERPQuery;
begin
  if not Assigned(fEmailList) then
    fEmailList := TClientContactEmailList.Create;
  if not SameText(fEmailList.DatabaseName,Connection.Database) then begin
    { build a list email addresses for all contacts }
    fEmailList.Clear;
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := Connection;
      qry.SQL.Add('select tblclients.ClientID, tblContacts.ContactID, Null as MarketingContactID, Null as EmployeeID, Customer, Supplier, OtherContact, "F" as MarketingContact, "F" as Employee, tblContacts.ContactEmail as Email');
      qry.SQL.Add('from tblclients, tblcontacts');
      qry.SQL.Add('where tblcontacts.ClientID = tblclients.ClientID');
      qry.SQL.Add('and tblContacts.ContactEmail > ""');
      qry.SQL.Add('union all');
      qry.SQL.Add('select tblclients.ClientID, Null as ContactID, Null as MarketingContactID, Null as EmployeeID, Customer, Supplier, OtherContact, "F" as MarketingContact, "F" as Employee, tblClients.Email as Email');
      qry.SQL.Add('from tblclients');
      qry.SQL.Add('where tblClients.Email > ""');
      qry.SQL.Add('union all');
      qry.SQL.Add('select Null as ClientID, Null as ContactID, Null as MarketingContactID, tblEmployees.EmployeeID, "F" as Customer, "F" as Supplier, "F" as OtherContact, "F" as MarketingContact, "T" as Employee, tblEmployees.Email');
      qry.SQL.Add('from tblEmployees');
      qry.SQL.Add('where tblEmployees.EmailsFromEmployeeAddress = "T" and tblEmployees.Email > ""');
      qry.SQL.Add('union all');
      qry.SQL.Add('select Null as ClientID, Null as ContactID, tblMarketingContacts.ID as MarketingContactID, Null as EmployeeID, "F" as Customer, "F" as Supplier, "F" as OtherContact, "T" as MarketingContact, "F" as Employee, tblMarketingContacts.Email');
      qry.SQL.Add('from tblMarketingContacts');
      qry.SQL.Add('where (IsNull(tblMarketingContacts.ClientID) or (tblMarketingContacts.ClientID = 0)) and tblMarketingContacts.Email > ""');

      qry.Open;
      while not qry.Eof do begin
        fEmailList.Add(qry.FieldByName('ClientId').AsInteger,
                       qry.FieldByName('ContactId').AsInteger,
                       qry.FieldByName('MarketingContactId').AsInteger,
                       qry.FieldByName('EmployeeId').AsInteger,
                       qry.FieldByName('Customer').AsBoolean,
                       qry.FieldByName('Supplier').AsBoolean,
                       qry.FieldByName('OtherContact').AsBoolean,
                       qry.FieldByName('MarketingContact').AsBoolean,
                       qry.FieldByName('Employee').AsBoolean,
                       qry.FieldByName('Email').AsString);
        qry.Next;
      end;
    finally
      qry.Free;
    end;
    fEmailList.DatabaseName := Connection.Database;
  end;
  result := fEmailList;
end;

function TMailReader.GetMail(var msg: string): boolean;
var
  POP: TIdPOP3;
  IMAP: TIdIMAP4;
  IndySSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  MessageCount: integer;
  MailMsg: TIdMessage;
  x, y: integer;
  qryMessageExists: TERPQuery;
  qryMessage: TERPQuery;
  cmd: TERPCommand;
  ClientContactEmailItem: TClientContactEmailItem;
  BlobStream: TStream;
  s: string;

  function MessageExists: boolean;
  var MessageID: string;
  begin
    result := true;
    MessageId := Copy(MailMsg.MsgId,2,Length(MailMsg.MsgId)-2);
    qryMessageExists.ParamByName('MessageId').AsString := MessageId;
    qryMessageExists.Open;
    if qryMessageExists.IsEmpty then
      result := false;
    qryMessageExists.Close;
  end;

  function IsBCCMessage: boolean;
  var
    RecipIdx: integer;
  begin
    result := false;
    if SameText(MailMsg.Headers.Values['Envelope-To'],EmailAddress) then begin
      result := true;
      exit;
    end;
    for RecipIdx := 0 to MailMsg.BccList.Count -1 do begin
      if SameText(MailMsg.BccList[RecipIdx].Address,EmailAddress) then begin
        result := true;
        exit;
      end;
    end;
  end;

  function ExtractID(const LineStr, DbRef: string): integer;
  var
    StrArray : TStringDynArray;
    StrArrayPos: integer;
    RefPos: integer;
    s: string;
  begin
    result:= 0;
    StrArray := SplitString(LineStr,' ');
    for StrArrayPos := Low(StrArray) to High(StrArray) do begin
      s := StrArray[StrArrayPos];
      refPos := Pos(DbRef,s);
      if refPos > 0 then begin
        s:= Trim(Copy(s,RefPos+Length(DbRef),Length(s)));
        result:= StrToIntDef(s,0);
        break;
      end;
    end;
  end;

  function GetMessageRefId: integer;
  var
    DbRef: string;
    DbRefPos: integer;
    LineNo, PartNo: integer;
  begin
    result := 0;
    DbRef := SimpleCrypt(Connection.Database) + '-id-';
    if MailMsg.MessageParts.Count > 0 then begin
      for PartNo := 0 to MailMsg.MessageParts.Count -1 do begin
        if (MailMsg.MessageParts[PartNo] is TIdText) then begin
          for LineNo := 0 to TIdText(MailMsg.MessageParts[PartNo]).Body.Count -1 do begin
            DbRefPos := Pos(DbRef, TIdText(MailMsg.MessageParts[PartNo]).Body[LineNo]);
            if DbRefPos > 0 then begin
              result:= ExtractId(TIdText(MailMsg.MessageParts[PartNo]).Body[LineNo],DbRef);
              exit;
            end;
          end;
        end;
      end;
    end
    else begin
      { simple body }
      for LineNo := 0 to MailMsg.Body.Count -1 do begin
        DbRefPos := Pos(DbRef, MailMsg.Body[LineNo]);
        if DbRefPos > 0 then begin
          result:= ExtractId(MailMsg.Body[LineNo],DbRef);
          exit;
        end;
      end;
    end;
  end;

  function StripQuotes(aQuoteStr: string): string;
  begin
    result:= aQuoteStr;
    if (LeftStr(result,1) = '"') or (LeftStr(result,1) = '''') then
      result := Copy(result,2,MaxInt);
    if (Copy(result,Length(result)) = '"') or (Copy(result,Length(result)) = '''') then
      result := Copy(result,1,Length(result) -1);
  end;

  procedure AddMessage;
  var
    MessageID: string;
    MessageRefID: integer;
    RecipIdx: integer;
    ToStr: string;
  begin
    qryMessage.Close;
    MessageId := Copy(MailMsg.MsgId,2,Length(MailMsg.MsgId)-2);

    { get the ID from the reference in the body of the message }
    MessageRefID := GetMessageRefID;
    if MessageRefID > 0 then begin
      { if user has generated this email from within ERP there should be an entry in the table .. }

      qryMessage.SQL.Text := 'select * from tblReference where RefId = ' + IntToStr(MessageRefID);
      qryMessage.Open;

    end
    else begin
      { was not BCC'd so did not originate from erp }
    end;

    if not qryMessage.Active then begin
      qryMessage.SQL.Text := 'select * from tblReference where Ref_Type = "Email" and MessageId = ' + QuotedStr(MessageId);
      qryMessage.Open;
    end;

    if qryMessage.RecordCount = 0 then
      qryMessage.Insert
    else
      qryMessage.Edit;

    qryMessage.FieldByName('MessageId').AsString := MessageId;
    if ClientContactEmailItem.IsCustomer then
      qryMessage.FieldByName('CusId').AsInteger := ClientContactEmailItem.ClientId;
    if ClientContactEmailItem.IsSupplier then
      qryMessage.FieldByName('SupId').AsInteger := ClientContactEmailItem.ClientId;
    if ClientContactEmailItem.IsOtherContact then
      qryMessage.FieldByName('OtherContactId').AsInteger := ClientContactEmailItem.ClientId;
    if ClientContactEmailItem.ContactId > 0 then
      qryMessage.FieldByName('ContactId').AsInteger := ClientContactEmailItem.ContactId;
    if ClientContactEmailItem.EmployeeId > 0 then
      qryMessage.FieldByName('EmployeeId').AsInteger := ClientContactEmailItem.EmployeeId;
    if ClientContactEmailItem.MarketingContactId > 0 then
      qryMessage.FieldByName('MarketingContactId').AsInteger := ClientContactEmailItem.MarketingContactId;
    qryMessage.FieldByName('Ref_type').AsString := 'Email';
    if Trim(MailMsg.Subject) <> '' then
      qryMessage.FieldByName('ReferenceTxt').AsString := MailMsg.Subject
    else
      qryMessage.FieldByName('ReferenceTxt').AsString := 'No Subject';
    qryMessage.FieldByName('Ref_Date').AsDateTime := MailMsg.Date;
    if qryMessage.FieldByName('MessageFrom').AsString = '' then
      qryMessage.FieldByName('MessageFrom').AsString := MailMsg.From.Name + ' (' + MailMsg.From.Address + ')';
    if qryMessage.FieldByName('MessageTo').AsString = '' then begin
      ToStr := '';
      for RecipIdx := 0 to MailMsg.Recipients.Count -1 do begin
        s:= '';
        if MailMsg.Recipients[RecipIdx].Name <> '' then begin
          s:= MailMsg.Recipients[RecipIdx].Name;
          if not SameText(StripQuotes(MailMsg.Recipients[RecipIdx].Name),MailMsg.Recipients[RecipIdx].Address) then
            s:= s + ' (' + MailMsg.Recipients[RecipIdx].Address + ')';
        end
        else
          s := MailMsg.Recipients[RecipIdx].Address;

        if Length(ToStr + ',' + s) <= 230 then begin
          if ToStr <> '' then ToStr := ToStr + ',';
          ToStr := ToStr + s;
        end
        else begin
          if ToStr <> '' then ToStr := ToStr + ',';
          ToStr := ToStr + ' plus ' + IntToStr(MailMsg.Recipients.Count - RecipIdx -1)+ ' more';
          break;
        end;
      end;
      qryMessage.FieldByName('MessageTo').AsString := ToStr;
    end;

    qryMessage.Post;
    cmd.ParamByName('NewId').AsInteger := qryMessage.InsertId;
    cmd.Execute;
    qryMessage.Edit;

    { NOTE: SavetoStream with the occassional message not return!
            so we save the massage above and when this process is terminated and
            re-run it will not check that message again. }
    BlobStream := qryMessage.CreateBlobStream(qryMessage.FieldByName('ReferenceData'),bmWrite);
    try
      try
        MailMsg.SaveToStream(BlobStream);
      except
        on e: exception do begin
          Log('Error saving mail message: ' + e.Message,ltError);
        end;
      end;
    finally
      BlobStream.Free;
    end;
    qryMessage.Post;
    qryMessage.Close;
  end;

begin
  if EmailAddress = '' then
    raise Exception.Create(Self.Classname + ' - Eamil Address not defined.');
  Active := true;
  result := true;
  try
    POP := nil;
    IMAP := nil;
    MailMsg:= TIdMessage.Create(nil);
    qryMessageExists := TERPQuery.Create(nil);
    qryMessage := TERPQuery.Create(nil);
    cmd:= TERPCommand.Create(nil);
    try
      qryMessageExists.Connection := Connection;
      qryMessageExists.SQL.Add('select RefID from tblReference where MessageID = :MessageID');
      qryMessage.Connection := Connection;

      cmd.Connection := Connection;
      cmd.SQL.Add('update tblReference');
      cmd.SQL.Add('set GlobalRef = Concat((select SiteCode from tblmsbackendid where BEDefault = "T" limit 1),:NewId),');
      cmd.SQL.Add('msUpdateSiteCode = (select SiteCode from tblmsbackendid where BEDefault = "T" limit 1)');
      cmd.SQL.Add('where RefId = :NewId');


      if SameText(Config.S[Email_ServerType],Email_ServerTypePOP) then begin
        POP := TIdPOP3.Create(nil);
        POP.Host := Config.S[Email_Server];
        POP.Username := Config.S[Email_ServerUserName];
        POP.Password := Config.S[Email_ServerPassword];
        POP.Port := Config.I[Email_Port];
        POP.AutoLogin := true;
        POP.ConnectTimeout := 30000;
        if SameText(Config.S[Email_AuthType],'Normal Password') or SameText(Config.S[Email_AuthType],'') then begin
          POP.AuthType := patUserPass;
        end
        else if SameText(Config.S[Email_AuthType],'Encrypted Password') then begin
          POP.AuthType := patAPOP;
        end;

        if SameText(Config.S[Email_TLS], 'None') or SameText(Config.S[Email_TLS], '') then begin
          POP.IOHandler := nil;
          POP.UseTLS := utNoTLSSupport;
        end
        else if SameText(Config.S[Email_TLS], 'Explicit TLS') then begin
          IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(POP);
          POP.IOHandler := IndySSLHandler;
          POP.UseTLS := utUseExplicitTLS;
        end
        else if SameText(Config.S[Email_TLS], 'Implicit TLS') then begin
          IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(POP);
          POP.IOHandler := IndySSLHandler;
          POP.UseTLS := utUseImplicitTLS;
        end
        else if SameText(Config.S[Email_TLS], 'Require TLS') then begin
          IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(POP);
          POP.IOHandler := IndySSLHandler;
          POP.UseTLS := utUseRequireTLS;
        end;
        if Assigned(POP.IOHandler) then begin
          POP.IOHandler.MaxLineAction := maException;
          TIdSSLIOHandlerSocketOpenSSL(POP.IOHandler).SSLOptions.Method := sslvTLSv1;
          TIdSSLIOHandlerSocketOpenSSL(POP.IOHandler).SSLOptions.Mode := sslmUnassigned;
          TIdSSLIOHandlerSocketOpenSSL(POP.IOHandler).SSLOptions.VerifyMode := [];
          TIdSSLIOHandlerSocketOpenSSL(POP.IOHandler).SSLOptions.VerifyDepth := 0;
        end;
        POP.Connect;
      end;
      if SameText(Config.S[Email_ServerType],Email_ServerTypeIMAP) then begin
        IMAP := TIdIMAP4.Create(nil);
        IMAP.Host := Config.S[Email_Server];
        IMAP.Username := Config.S[Email_ServerUserName];
        IMAP.Password := Config.S[Email_ServerPassword];
        IMAP.Port := Config.I[Email_Port];
        IMAP.ConnectTimeout := 30000;

        if SameText(Config.S[Email_AuthType],'Normal Password') or SameText(Config.S[Email_AuthType],'') then begin
          IMAP.AuthType := iatUserPass;
        end
        else if SameText(Config.S[Email_AuthType],'Encrypted Password') then begin
          IMAP.AuthType := iatSASL;
        end;

        if SameText(Config.S[Email_TLS], 'None') or SameText(Config.S[Email_TLS], '') then begin
          IMAP.IOHandler := nil;
          IMAP.UseTLS := utNoTLSSupport;
        end
        else if SameText(Config.S[Email_TLS], 'Explicit TLS') then begin
          IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(IMAP);
          IMAP.IOHandler := IndySSLHandler;
          IMAP.UseTLS := utUseExplicitTLS;
        end
        else if SameText(Config.S[Email_TLS], 'Implicit TLS') then begin
          IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(IMAP);
          IMAP.IOHandler := IndySSLHandler;
          IMAP.UseTLS := utUseImplicitTLS;
        end
        else if SameText(Config.S[Email_TLS], 'Require TLS') then begin
          IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(IMAP);
          IMAP.IOHandler := IndySSLHandler;
          IMAP.UseTLS := utUseRequireTLS;
        end;
        if Assigned(IMAP.IOHandler) then begin
          IMAP.IOHandler.MaxLineAction := maException;
          TIdSSLIOHandlerSocketOpenSSL(IMAP.IOHandler).SSLOptions.Method := sslvSSLv3; //sslvTLSv1;
          TIdSSLIOHandlerSocketOpenSSL(IMAP.IOHandler).SSLOptions.Mode := sslmUnassigned;
          TIdSSLIOHandlerSocketOpenSSL(IMAP.IOHandler).SSLOptions.VerifyMode := [];
          TIdSSLIOHandlerSocketOpenSSL(IMAP.IOHandler).SSLOptions.VerifyDepth := 0;
        end;
        IMAP.Connect();
        IMAP.SelectMailBox('INBOX');
      end;

      if (not Assigned(POP)) and (not Assigned(IMAP)) then begin
        result := false;
        msg := 'Mail Server type not supported.';
        exit;
      end;

      try
        if Assigned(POP) then MessageCount := POP.CheckMessages
        else MessageCount := IMAP.MailBox.TotalMsgs;
        if Assigned(fOnGetMessageCount) then
          fOnGetMessageCount(MEssageCount);
        for x:= 1 to MessageCount do begin
          try
            if (not Active) or (not DoProgContinue('Checking message ' + IntToStr(x) + ' of ' + IntToStr(MessageCount))) then
              exit;
            ClientContactEmailItem := nil;
            if (Assigned(POP) and POP.RetrieveHeader(x,MailMsg))
            or (Assigned(IMAP) and IMAP.RetrieveHeader(x,MailMsg)) Then begin
//                Log(MailMsg.Subject,ltDetail);
//                Log(MailMsg.From.Text,ltDetail);
//                Log(MailMsg.ContentType,ltDetail);

              { CheckMessage should check the MsgId to make sure we don't already have this message }
              if not MessageExists then begin
                { process message }
                if (Assigned(POP) and POP.Retrieve(x,MailMsg))
                or (Assigned(IMAP) and IMAP.Retrieve(x,MailMsg)) Then begin
                  { who is it from .. }
                  ClientContactEmailItem := EmailList.ItemByEmail(MailMsg.From.Address);
                  if Assigned(ClientContactEmailItem) then begin

                    { email from a client contact .. }
                    AddMessage;
                  end
                  else begin
                    for y := 0 to MailMsg.Recipients.Count -1 do begin
                      { has this user BCC'd or CC'd a message he sent to a contact back to himself }
                      ClientContactEmailItem := EmailList.ItemByEmail(MailMsg.Recipients[y].Address);
                      if Assigned(ClientContactEmailItem) then begin
                        AddMessage;
                        break;
                      end;
                    end;
                  end;
                end;
              end;
            end
            else begin
              Log('Could not retrieve email message header.',ltWarning);
            end;
          except
            on e: exception do begin
              { skip error }
              Log('Error downloading email: ' + e.Message,ltError);
            end;
          end;
        end;
      finally
        POP.Disconnect;
      end;

    finally
      qryMessageExists.Free;
      qryMessage.Free;
      cmd.Free;
      MailMsg.Free;
      POP.Free;
      IMAP.Free;
      Active := false;
    end;
  except
    on e: exception do begin
      result := false;
      msg := 'Error: ' + Trim(e.Message);
    end;
  end;
end;

procedure TMailReader.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(Logger) then
    Logger.Log(msg,LogMessageType);
  if Assigned(fOnLog) then
    fOnLog(msg, LogMessageType);
end;

{ TClientContactEmailList }

procedure TClientContactEmailList.Add(aClientId, aContactId, aMarketingContactId, aEmployeeId: integer;
      aIsCustomer: boolean; aIsSupplier: boolean; aIsOtherContact: boolean;
      aIsMarketingContact: boolean; aIsEmployee: boolean; aEmailAddress: string);
var
  newItem: TClientContactEmailItem;
begin
  newItem := TClientContactEmailItem.Create;
  newItem.ClientId := aClientId;
  newItem.ContactId := aContactId;
  newItem.MarketingContactId := aMarketingContactId;
  newItem.EmployeeId := aEmployeeID;
  newItem.IsCustomer := aIsCustomer;
  newItem.IsSupplier := aIsSupplier;
  newItem.IsOtherContact := aIsOtherContact;
  newItem.IsMarketinfContact := aIsMarketingContact;
  newItem.IsEmployee := aIsEmployee;
  newItem.EmailAddress := aEmailAddress;
  fList.Add(newItem);
end;

procedure TClientContactEmailList.Clear;
begin
  fList.Clear;
end;

constructor TClientContactEmailList.Create;
begin
  fList := TObjectList.Create;
end;

destructor TClientContactEmailList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TClientContactEmailList.ItemByEmail(
  aEmailAddress: string): TClientContactEmailItem;
var
  I: integer;
begin
  result:= nil;
  for I := 0 to fList.Count -1 do begin
    if SameText(TClientContactEmailItem(fList[I]).EmailAddress,aEmailAddress) then begin
      result := TClientContactEmailItem(fList[I]);
      break;
    end;
  end;
end;

//{ TMessageComparison }
//
//procedure TMessageComparison.Add(aId: integer; aListTime: TDateTime;
//  aListSubject: string; aMessage: TIdMessage);
//var
//  newItem: TMessageComparisonItem;
//  sl1, sl2: TStringList;
//  PercentPerWord: double;
//  x: integer;
//  Percent: double;
//begin
//  newItem := TMessageComparisonItem.Create;
//  newItem.Id := aId;
//  newItem.SecondsBetween := SecondsBetween(aListTime,aMessage.Date);
//  if SameText(aListSubject,aMessage.Subject) then
//    newItem.SubjectMatchPercent := 100
//  else begin
//    Percent := 0;
//    sl1 := TStringList.Create;
//    sl2 := TStringList.Create;
//    try
//      sl1.CommaText := Lowercase(aListSubject);
//      sl2.CommaText := Lowercase(aMessage.Subject);
//      if sl1.Count < sl2.Count then begin
//        PercentPerWord := 100/ sl1.Count;
//        for x := 0 to sl1.Count -1 do begin
//          if sl2.IndexOf(sl1[x]) > -1 then
//            Percent := Percent + PercentPerWord;
//        end;
//      end
//      else begin
//        PercentPerWord := 100/ sl2.Count;
//        for x := 0 to sl2.Count -1 do begin
//          if sl1.IndexOf(sl2[x]) > -1 then
//            Percent := Percent + PercentPerWord;
//        end;
//      end;
//    finally
//      sl1.Free;
//      sl2.Free;
//    end;
//    newItem.SubjectMatchPercent := Percent;
//  end;
//
//  fList.Add(newItem);
//end;
//
//procedure TMessageComparison.Clear;
//begin
//  fList.Clear;
//end;
//
//constructor TMessageComparison.Create;
//begin
//  fList := TObjectList.Create;
//end;
//
//destructor TMessageComparison.Destroy;
//begin
//  fList.Free;
//  inherited;
//end;

end.
