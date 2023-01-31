unit BusObjEmailConfig;

interface

{$I ERP.inc}

uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf, JsonObject,
  IdMessage, MyAccess;

type
  TCheckMessageFunc = function (aMessage: TIdMessage): boolean of object;
  TProcessMessageProc = procedure (aMessage: TIdMessage; var DeleteMessage: boolean) of object;
  TOnProgress = procedure(const msg: string) of object;


  TEmailSinatureFile = class(TMSBusObj)
  private
    function GetEmailConfigId: integer;
    function GetFileName: string;
    function GetIsPrimary: boolean;
    procedure SetEmailConfigId(const Value: integer);
    procedure SetFileName(const Value: string);
    procedure SetIsPrimary(const Value: boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    Function DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Load(const fIsReadonly: boolean = False); override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property EmailConfigId: integer read GetEmailConfigId write SetEmailConfigId;
    property IsPrimary: boolean read GetIsPrimary write SetIsPrimary;
    property FileName: string read GetFileName write SetFileName;
  end;


  TEmailConfig = class(TMSBusObj)
  private
    fConfig: TJsonObject;
    fOnProgress: TOnProgress;
    function GetEntityName: string;
    function GetEmailAddress: string;
    function GetConfigJSON: string;
    function GetConfigValid: Boolean;
    procedure SetEntityName(const Value: string);
    procedure SetEmailAddress(const Value: string);
    procedure SetConfigJSON(const Value: string);
    procedure SetConfigValid(const Value: Boolean);
    function GetConfig: TJsonObject;
    function CheckConfig(var msg: string): boolean;
    procedure SendProgress(const aMsg: string);
//    function getServerName: String;
//    function getOutServerName: String;
//    function getServerPort: Integer;
//    function getOutServerPort: Integer;
//    function getUserName  : String;
//    function getPassword  : String;
    function GetSignatureFiles: TEmailSinatureFile;
    function GetEmailName: string;
    procedure SetEmailName(const Value: string);
    function GetSignatureText: string;
    procedure SetSignatureText(const Value: string);
    function GetSignatureFromFile: boolean;
    procedure SetSignatureFromFile(const Value: boolean);
    function GetReplyEmailAddress: string;
    procedure SetReplyEmailAddress(const Value: string);
    function GetSMTPServer: string;
    procedure SetSMTPServer(const Value: string);
    function GetSMTPPort: integer;
    procedure SetSMTPPort(const Value: integer);
    function GetSMTPAuthType: string;
    procedure SetSMTPAuthType(const Value: string);
    function GetSMTPUserName: string;
    procedure SetSMTPUserName(const Value: string);
    function GetSMTPPassword: string;
    procedure SetSMTPPassword(const Value: string);
    function GetServerType: string;
    procedure SetServerType(const Value: string);
    function GetServer: string;
    procedure SetServer(const Value: string);
    function GetPort: integer;
    procedure SetPort(const Value: integer);
//    function GetUseTLS: boolean;
//    procedure SetUseTLS(const Value: boolean);
    function GetAuthType: string;
    procedure SetAuthType(const Value: string);
    function GetServerUserName: string;
    procedure SetServerUserName(const Value: string);
    function GetServerPassword: string;
    procedure SetServerPassword(const Value: string);
    function GetEmailFormat: string;
    procedure SetEmailFormat(const Value: string);
    function GetSMTPTLS: string;
    procedure SetSMTPTLS(const Value: string);
    function GetTLS: string;
    procedure SetTLS(const Value: string);
    function GetIntegrationType: string;
    procedure SetIntegrationType(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    Function DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
    Function DoAfterOpen(Sender :TDatasetBusObj ):Boolean; override;
    function GetDirty: boolean; override;
    function GetAnyDirty: boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Load(const fIsReadonly: boolean = False); override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property Config: TJsonObject read GetConfig;
    function ValidateSettings(var msg: string): boolean;
//    function GetMail(CheckMessage: TCheckMessageFunc; ProcessMessage: TProcessMessageProc; var msg: string): boolean;
    property OnProgress: TOnProgress read fOnProgress write fOnProgress;
    class function EntityConfigValid(const aEntity: string; Connection: TCustomMyConnection = nil): boolean;
//    property ServerName :String read getServerName ;
//    property OutServerName :String read getOutServerName ;
//    property ServerPort :Integer read getServerPort ;
//    property OutServerPort :Integer read getOutServerPort ;
//    property UserName   :String read getUserName ;
//    property Password   :String read getPassword ;
    procedure LoadSignatureFile(aFileName: string);
    function SignatureFile: string;
  published
    property EntityName: string read GetEntityName write SetEntityName;
    property EmailAddress: string read GetEmailAddress write SetEmailAddress;
    property ConfigJSON: string read GetConfigJSON write SetConfigJSON;
    property ConfigValid: Boolean read GetConfigValid write SetConfigValid;
    property IntegrationType: string read GetIntegrationType write SetIntegrationType; { 'Email Client', 'Server' }
    property SignatureFiles: TEmailSinatureFile read GetSignatureFiles;
    property EmailName: string read GetEmailName write SetEmailName;
    property SignatureText: string read GetSignatureText write SetSignatureText;
    property SignatureFromFile: boolean read GetSignatureFromFile write SetSignatureFromFile;
    property ReplyEmailAddress: string read GetReplyEmailAddress write SetReplyEmailAddress;
    property EmailFormat: string read GetEmailFormat write SetEmailFormat; { HTML, Plain Text }

    property SMTPServer: string read GetSMTPServer write SetSMTPServer;
    property SMTPPort: integer read GetSMTPPort write SetSMTPPort;
    property SMTPTLS: string read GetSMTPTLS write SetSMTPTLS;
    property SMTPAuthType: string read GetSMTPAuthType write SetSMTPAuthType;
    property SMTPUserName: string read GetSMTPUserName write SetSMTPUserName;
    property SMTPPassword: string read GetSMTPPassword write SetSMTPPassword;

    property ServerType: string read GetServerType write SetServerType; { POP, IMAP }
    property Server: string read GetServer write SetServer;
    property Port: integer read GetPort write SetPort;
//    property UseTLS: boolean read GetUseTLS write SetUseTLS;
    property TLS: string read GetTLS write SetTLS;
    property AuthType: string read GetAuthType write SetAuthType;
    property ServerUserName: string read GetServerUserName write SetServerUserName;
    property ServerPassword: string read GetServerPassword write SetServerPassword;
  end;


implementation

uses
  tcDataUtils, CommonLib, SysUtils, ERPDbComponents, CommonDbLib, EmailConst,
  IdPOP3, IdSMTP, IdExplicitTLSClientServerBase, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdGlobal,
  IdSMTPBase, IdIMAP4, EmailLib, DnMLib;

{ TEmailConfig }

function TEmailConfig.CheckConfig(var msg: string): boolean;
var
  OutOk, InOk: boolean;

  procedure AddMsg(aMsg: string);
  begin
    if msg <> '' then msg := msg + #13#10;
    msg := msg + aMsg;
  end;

begin
  OutOk := true;
  InOk := true;
  msg := '';

  { check SMTP settings }
  if SMTPServer = '' then begin
    AddMsg('Configuration SMTP (Outgoing) Server is blank.');
    OutOk := false;
  end;
  if SMTPPort = 0 then begin
    AddMsg('Configuration SMTP (Outgoing) Server Port is not set.');
    OutOk := false;
  end;
  if SMTPUserName = '' then begin
    AddMsg('Configuration SMTP (Outgoing) User Name is blank.');
    OutOk := false;
  end;
  if SMTPPassword = '' then begin
    AddMsg('Configuration SMTP (Outgoing) Password is blank.');
    OutOk := false;
  end;

  { incoming settings }
  if ServerType = '' then begin
    AddMsg('Configuration (Incoming) Server Type is blank.');
    InOk := false;
  end;
  if Server = '' then begin
    AddMsg('Configuration (Incoming) Server is blank.');
    InOk := false;
  end;
  if Port = 0 then begin
    AddMsg('Configuration (Incoming) Port is not set.');
    InOk := false;
  end;
  if ServerUserName = '' then begin
    AddMsg('Configuration (Incoming) Server User Name is blank.');
    InOk := false;
  end;
  if ServerPassword = '' then begin
    AddMsg('Configuration (Incoming) Server Password is blank.');
    InOk := false;
  end;

  result := OutOk or InOk;

end;

constructor TEmailConfig.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'EmailConfig';
  fSQL := 'SELECT * FROM tblemailconfig';
end;

destructor TEmailConfig.Destroy;
begin
  inherited;
end;

procedure TEmailConfig.Load(const fIsReadonly: boolean);
begin
  inherited;
  FreeAndNil(fConfig);
end;

procedure TEmailConfig.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'EntityName');
  SetPropertyFromNode(node, 'EmailAddress');
  SetPropertyFromNode(node, 'ConfigJSON');
  SetBooleanPropertyFromNode(node, 'ConfigValID');
end;

procedure TEmailConfig.LoadSignatureFile(aFileName: string);
var
  sl, fileList: TStringList;
  ext: string;
  stream: TMemoryStream;
  s, text: string;
  x, y: integer;
  BlobStream: TStream;
  FileStream: TFileStream;
  CommentStart, CommentEnd: integer;
begin

  ResultSTatus.Clear;
  SignatureFiles.DeleteAll;
  if not FileExists(aFileName) then begin
    AddResult(false, rssError, 0, 'File not found: "' + aFileName + '"');
    exit;
  end;
  fileList := TStringList.Create;
  try
    SignatureFiles.New;
    SignatureFiles.FileName := ExtractFileName(aFileName);
    SignatureFiles.IsPrimary := true;
    ext := ExtractFileExt(aFileName);
    if SameText(ext, '.htm') or SameText(ext, '.html') then begin
      { need to search through for linked files }
      sl := TStringList.Create;
      stream := TMemoryStream.Create;
      try
        sl.LoadFromFile(aFileName);
        text := sl.Text;
        while Pos('<!--',text) > 0 do begin
          commentStart := Pos('<!--',text);
          commentEnd := Pos('-->',text);
          if commentStart < commentEnd then begin
            text := Copy(text, 1, CommentStart-1) + Copy(text, CommentEnd+2, Length(text));
          end
          else
            break;
        end;

        for x := 1 to Length(Text) do begin
          if CharInSet(text[x], ['f','F','i','I','l','L','e','E',':','/']) then
            s := s + text[x]
          else
            s := '';
          if SameText(s,'file:///') then begin
            for y := x+1 to Length(text) do begin
              if text[y] = '"' then begin
                fileList.Add(s);
                s:= '';
                break;
              end
              else
                s := s + text[y];
            end;
          end;
        end;
        for x := 0 to fileList.Count -1 do begin
          s := fileList[x];
          s := Copy(s,9,Length(s));
          s := StringReplace(s,#124,':',[rfReplaceAll]);
          s := StringReplace(s,'/','\',[rfReplaceAll]);
          if not FileExists(s) then begin
            AddResult(false, rssError, 0, 'File not found: "' + s + '"');
            exit;
          end;
          { remove path and replace with a marker }
          text := StringReplace(text,fileList[x],'file:///<!--LocalPath-->'+ExtractFileName(s),[rfIgnoreCase,rfReplaceAll]);
        end;
        sl.Text := text;
        sl.SaveToStream(stream);
        stream.Position := 0;
//        TBlobField(SignatureFiles.Dataset.FieldByName('Data')).LoadFromStream(stream);

        BlobStream := SignatureFiles.Dataset.CreateBlobStream(SignatureFiles.Dataset.FieldByName('Data'),bmWrite);
        try
          Blobstream.CopyFrom(stream,0);
        finally
          BlobStream.Free;
        end;

        SignatureFiles.PostDb;
        { now get the rest of the files }
        for x := 0 to fileList.Count -1 do begin
          s := fileList[x];
          s := Copy(s,9,Length(s));
          s := StringReplace(s,#124,':',[rfReplaceAll]);
          s := StringReplace(s,'/','\',[rfReplaceAll]);
          SignatureFiles.New;
          SignatureFiles.FileName := ExtractFileName(s);
          SignatureFiles.IsPrimary := false;

          FileStream := TFileStream.Create(s, fmOpenRead);
          BlobStream := SignatureFiles.Dataset.CreateBlobStream(SignatureFiles.Dataset.FieldByName('Data'),bmWrite);
          try
            Blobstream.CopyFrom(FileStream,0);
          finally
            BlobStream.Free;
            FileStream.Free;
          end;

//          TBlobField(SignatureFiles.Dataset.FieldByName('Data')).LoadFromFile(s);
          SignatureFiles.PostDb;
        end;
      finally
        sl.Free;
        stream.Free;
      end;
    end
    else begin
      FileStream := TFileStream.Create(s, fmOpenRead);
      BlobStream := SignatureFiles.Dataset.CreateBlobStream(SignatureFiles.Dataset.FieldByName('Data'),bmWrite);
      try
        Blobstream.CopyFrom(FileStream,0);
      finally
        BlobStream.Free;
        FileStream.Free;
      end;
      //TBlobField(SignatureFiles.Dataset.FieldByName('Data')).LoadFromFile(aFileName);
    end;
    SignatureFiles.PostDb;
    self.FlagAsUpdated();
    self.PostDb;
    self.Dirty := true;
  finally
    fileList.Free;
  end;
end;

function TEmailConfig.SignatureFile: string;
var
  sl: TStringList;
  createFiles: boolean;
  sigName: string;
begin
  result := '';
  if (not SignatureFromFile) and (Trim(Signaturetext) = '') then
    exit;
  createFiles := true;
  sl := TStringList.Create;
  try
    result := EmailLib.EmailTempSignatureDir;
    if DirectoryExists(result) then begin
      if FileExists(result + 'timestamp.txt') then
        sl.LoadFromFile(result + 'timestamp.txt');
      createFiles := not SameText(sl.Text, FormatDateTime('yyyy-mm-dd hh:nn:ss',msTimestamp));
    end;
    if SignatureFromFile then begin
      if self.SignatureFiles.Dataset.Locate('IsPrimary','T',[loCaseInsensitive]) then
        sigName := self.SignatureFiles.FileName
      else begin
        result := '';
        exit;
      end;
    end
    else
      sigName := 'Signature.txt';
    if (not createFiles) and (not FileExists(result + sigName)) then
      createFiles := true;
    if createFiles then begin
      ForceDirectories(result);
      DeleteFiles(result, '*.*');

      if SignatureFromFile then begin
        { <!--LocalPath--> }
         SignatureFiles.First;
         while not SignatureFiles.EOF do begin
           TBlobField(SignatureFiles.Dataset.FieldByName('Data')).SaveToFile(result + SignatureFiles.FileName);
           if SignatureFiles.IsPrimary and
             (SameText(ExtractFileExt(SignatureFiles.FileName),'.html') or SameText(ExtractFileExt(SignatureFiles.FileName),'.htm')) then begin
             { html file .. we need to fix up directories }
             sl.LoadFromFile(result + SignatureFiles.FileName);
             sl.Text := ReplaceStr(sl.Text,'<!--LocalPath-->',ReplaceStr(result,'\','/'));
             sl.SaveToFile(result + SignatureFiles.FileName);
           end;
           SignatureFiles.Next;
         end;
      end
      else begin
        sl.Text := SignatureText;
        sl.SaveToFile(result + sigName);
      end;
      sl.Text := FormatDateTime('yyyy-mm-dd hh:nn:ss',msTimestamp);
      sl.SaveToFile(result + 'timestamp.txt');
    end;
    result := result + sigName;
  finally
    sl.Free;
  end;
end;

procedure TEmailConfig.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'EntityName', EntityName);
  AddXMLNode(node, 'EmailAddress', EmailAddress);
  AddXMLNode(node, 'ConfigJSON', ConfigJSON);
  AddXMLNode(node, 'ConfigValID', ConfigValid);
end;

function TEmailConfig.ValidateData: Boolean;
begin
//  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TEmailConfig.ValidateSettings(var msg: string): boolean;
var
  POP: TIdPOP3;
  exSMTP: TIdSMTP;
  IndySSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  IMAP: TIdIMAP4;
  OutOk, InOk: boolean;
begin
  SendProgress('Checking settings');
  result := CheckConfig(msg);
  if not result then exit;
  InOk := true;
  OutOk := true;

  POP:= nil;
  IMAP:= nil;
  exSMTP := TIdSMTP.Create(nil);
  if SameText(ServerType, 'POP') then POP := TIdPOP3.Create(nil)
  else if SameText(ServerType, 'IMAP') then IMAP := TIdIMAP4.Create(nil);
  try
    try
      exSMTP.Host     := SMTPServer;
      exSMTP.Username := SMTPUserName;;
      exSMTP.Password := SMTPPassword;
      exSMTP.Port     := SMTPPort;
      exSMTP.ConnectTimeout := 30000;
      if SameText(SMTPAuthType,'Normal Password') then
        exSMTP.AuthType := satDefault
      else if SameText(SMTPAuthType,'None') then
        exSMTP.AuthType := satNone
      else if SameText(SMTPAuthType,'SASL') then
        exSMTP.AuthType := satSASL
      else
        exSMTP.AuthType := satDefault;

   // http://www.delphipraxis.net/178523-smtp-ssl-mit-indy10.html
      if SameText(SMTPTLS, 'None') or SameText(SMTPTLS, '') then begin
        exSMTP.IOHandler := nil;
        exSMTP.UseTLS := utNoTLSSupport;
      end
      else if SameText(SMTPTLS, 'Explicit TLS') then begin
        IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(exSMTP);
        exSMTP.IOHandler := IndySSLHandler;
        exSMTP.UseTLS := utUseExplicitTLS;
        exSMTP.UseEhlo := true;
       end
      else if SameText(SMTPTLS, 'Implicit TLS') then begin
        IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(exSMTP);
        exSMTP.IOHandler := IndySSLHandler;
        exSMTP.UseTLS := utUseImplicitTLS;
       end
      else if SameText(SMTPTLS, 'Require TLS') then begin
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

      SendProgress('Connecting to SMTP (outgoing) mail server');
      exSMTP.Connect;

      if Assigned(exSMTP.IOHandler) then begin
        SendProgress('Authenticateing SMTP (outgoing) mail server');
        exSMTP.Authenticate;
      end;

      SendProgress('Disconnecting from SMTP (outgoing) mail server');
      exSMTP.Disconnect;
      SendProgress('Connection ok');
      FreeAndNil(IndySSLHandler);

    except
      on e: exception do begin
        OutOk := false;
        if msg <> '' then msg := msg + #13#10 + #13#10;
        msg := msg + 'Could not connect to SMTP (outgoing) Mail Server. ' + e.Message;
//        msg := 'Could not connect to SMTP (outgoing) Mail Server. ' + e.Message;
//        result := false;
//        exit;
      end;
    end;

    if Assigned(POP) then begin
      try
        POP.Host := Server;
        POP.Username := ServerUserName;
        POP.Password := ServerPassword;
        POP.Port := Port;
        POP.AutoLogin := true;
        POP.ConnectTimeout := 30000;
        if SameText(AuthType,'Normal Password') or SameText(AuthType,'') then begin
          POP.AuthType := patUserPass;
        end
        else if SameText(AuthType,'Encrypted Password') then begin
          POP.AuthType := patAPOP;
        end;

        if SameText(TLS, 'None') or SameText(TLS, '') then begin
          POP.IOHandler := nil;
          POP.UseTLS := utNoTLSSupport;
        end
        else if SameText(TLS, 'Explicit TLS') then begin
          IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(POP);
          POP.IOHandler := IndySSLHandler;
          POP.UseTLS := utUseExplicitTLS;
         end
        else if SameText(TLS, 'Implicit TLS') then begin
          IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(POP);
          POP.IOHandler := IndySSLHandler;
          POP.UseTLS := utUseImplicitTLS;
         end
        else if SameText(TLS, 'Require TLS') then begin
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

        { see if we can connect to mail server }
        SendProgress('Connecting to incoming mail server');
        POP.Connect;
        SendProgress('Disconnecting from incoming mail server');
        POP.Disconnect;
        SendProgress('Connection ok');
      except
        on e: exception do begin
          InOk := false;
          if msg <> '' then msg := msg + #13#10 + #13#10;
          msg := msg + 'Could not connect to POP (incoming) Mail Server. ' + e.Message;
//          msg := 'Could not connect to POP (incoming) Mail Server. ' + e.Message;
//          result := false;
//          exit;
        end;
      end;
    end;

    if Assigned(IMAP) then begin
      try
        IMAP.Host := Server;
        IMAP.Username := ServerUserName;
        IMAP.Password := ServerPassword;
        IMAP.Port := Port;
        IMAP.ConnectTimeout := 30000;
        //IMAP.AutoLogin := true;
        if SameText(AuthType,'Normal Password') or SameText(AuthType,'') then begin
          IMAP.AuthType := iatUserPass;
        end
        else if SameText(AuthType,'Encrypted Password') then begin
          IMAP.AuthType := iatSASL;
        end;

        if SameText(TLS, 'None') or SameText(TLS, '') then begin
          IMAP.IOHandler := nil;
          IMAP.UseTLS := utNoTLSSupport;
        end
        else if SameText(TLS, 'Explicit TLS') then begin
          IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(IMAP);
          IMAP.IOHandler := IndySSLHandler;
          IMAP.UseTLS := utUseExplicitTLS;
         end
        else if SameText(TLS, 'Implicit TLS') then begin
          IndySSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(IMAP);
          IMAP.IOHandler := IndySSLHandler;
          IMAP.UseTLS := utUseImplicitTLS;
         end
        else if SameText(TLS, 'Require TLS') then begin
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

        { see if we can connect to mail server }
        SendProgress('Connecting to incoming mail server');
        IMAP.Connect;
        SendProgress('Disconnecting from incoming mail server');
        IMAP.Disconnect;
        SendProgress('Connection ok');
      except
        on e: exception do begin
          InOk := false;
          if msg <> '' then msg := msg + #13#10 + #13#10;
          msg := msg + 'Could not connect to IMAP (incoming) Mail Server. ' + e.Message;
//          msg := 'Could not connect to IMAP (incoming) Mail Server. ' + e.Message;
//          result := false;
//          exit;
        end;
      end;
    end;


    result := OutOk or InOk;
  finally
    exSMTP.Free;
    POP.Free;
    IMAP.Free;
  end;


end;

function TEmailConfig.Save: Boolean;
begin
  Result := False;
  if Assigned(fConfig) then
    ConfigJSON := fConfig.AsString;
  PostDb;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TEmailConfig.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TEmailConfig.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.fieldName, 'EntityName') then begin


  end
  else if Sysutils.SameText(Sender.fieldName, 'EmailAddress') then begin


  end
  else if Sysutils.SameText(Sender.fieldName, 'ConfigJSON') then begin


  end
  else if Sysutils.SameText(Sender.fieldName, 'ConfigValid') then begin


  end;
end;

class function TEmailConfig.EntityConfigValid(const aEntity: string;
  Connection: TCustomMyConnection): boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection := Connection
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select ConfigValid from tblEmailConfig');
    qry.SQL.Add('where EntityName = ' + QuotedStr(aEntity));
    qry.Open;
    result := qry.FieldByName('ConfigValid').AsBoolean;
  finally
    qry.Free;
  end;
end;

function TEmailConfig.GetServerType: string;
begin
  result := Config.S[Email_ServerType];
end;

function TEmailConfig.GetServerUserName: string;
begin
  result := Config.S[Email_ServerUserName];
end;

function TEmailConfig.GetSignatureFiles: TEmailSinatureFile;
begin
  result := TEmailSinatureFile(GetContainerComponent(TEmailSinatureFile, 'EmailConfigId = ' + IntToStr(self.ID)));
end;

function TEmailConfig.GetSignatureFromFile: boolean;
begin
  result := Config.B[Email_SignatureFromFile];
end;

function TEmailConfig.GetSignatureText: string;
begin
  result := Config.S[Email_SignatureText];
end;

function TEmailConfig.GetSMTPAuthType: string;
begin
  result := Config.S[Email_SMTPAuthType];
end;

function TEmailConfig.GetSMTPPassword: string;
begin
  result := Config.S[Email_SMTPPassword];
end;

function TEmailConfig.GetSMTPPort: integer;
begin
  result := Config.I[Email_SMTPPort];
end;

function TEmailConfig.GetSMTPServer: string;
begin
  result := Config.S[Email_SMTPServer];
end;

function TEmailConfig.GetSMTPTLS: string;
begin
  result := Config.S[Email_SMTPTLS];
end;

function TEmailConfig.GetSMTPUserName: string;
begin
  result := Config.S[Email_SMTPUserName];
end;

function TEmailConfig.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TEmailConfig.GetTLS: string;
begin
  result := Config.S[Email_TLS];
end;

class function TEmailConfig.GetIDField: string;
begin
  Result := 'EmailConfigID'
end;

function TEmailConfig.GetIntegrationType: string;
begin
  result := GetStringField('IntegrationType');
end;

//function TEmailConfig.GetMail(CheckMessage: TCheckMessageFunc;
//  ProcessMessage: TProcessMessageProc; var msg: string): boolean;
//var
//  POP: TIdPOP3;
//  MessageCount: integer;
//  MailMsg: TIdMessage;
//  x: integer;
//  DoDelete: boolean;
//begin
//  result := CheckConfig(msg);
//  if not result then exit;
//
//  if SameText(Config.S[Email_ServerType],Email_ServerTypePOP) then begin
//    POP := TIdPOP3.Create(nil);
//    MailMsg:= TIdMessage.Create(nil);
//    try
//      POP.Host := Config.S[Email_ServerName];
//      POP.Username := Config.S[Email_UserName];
//      POP.Password := Config.S[Email_Password];
//      POP.Port := Config.I[Email_ServerPort];
//      POP.AutoLogin := true;
//
//      { see if we can connect to mail server }
//      try
//        POP.Connect;
//        try
//          MessageCount := POP.CheckMessages;
//          for x:= 0 to MessageCount -1 do begin
//            try
//              if POP.RetrieveHeader(x,MailMsg) then begin
//                { CheckMessage should check the MsgId to make sure we don't already have this message }
//                if CheckMessage(MailMsg) then begin
//                  { now pass whole message to ProcessMessag }
//                  if POP.Retrieve(x,MailMsg) then begin
//                    DoDelete := false;
//                    ProcessMessage(MailMsg,DoDelete);
//                    if DoDelete then
//                      POP.Delete(x);
//                  end;
//                end;
//
//              end;
//            except
//              on e: exception do begin
//                { skip error }
//
//              end;
//            end;
//          end;
//        finally
//          POP.Disconnect;
//        end;
//      except
//        on e: exception do begin
//          msg := 'Error getting mail from server. ' + e.Message;
//          result := false;
//          exit;
//        end;
//      end;
//
//    finally
//      MailMsg.Free;
//      POP.Free;
//    end;
//  end;
//end;

function TEmailConfig.GetAnyDirty: boolean;
begin
  result := inherited;
  if Assigned(fConfig) then begin
    if not result then
      result := ConfigJSON <> fConfig.AsString;
  end;
end;

function TEmailConfig.GetAuthType: string;
begin
  result := Config.S[Email_AuthType];
end;

class function TEmailConfig.GetBusObjectTablename: string;
begin
  Result := 'tblemailconfig';
end;

function TEmailConfig.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited;
  { set default data .. }
//  Config.I[Email_ServerPort] := 110;
  Config.S[Email_ServerType] := Email_ServerTypePOP;
end;

function TEmailConfig.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
end;

function TEmailConfig.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TEmailConfig.GetEntityName: string;
begin
  Result := GetStringField('EntityName');
end;

function TEmailConfig.GetEmailAddress: string;
begin
  Result := GetStringField('EmailAddress');
end;

function TEmailConfig.GetEmailFormat: string;
begin
  result := Config.S[Email_EmailFormat];
end;

function TEmailConfig.GetEmailName: string;
begin
  result := Config.S[Email_EmailName];
end;

function TEmailConfig.GetConfig: TJsonObject;
begin
  if not Assigned(fConfig) then begin
    fConfig := TJsonObject.Create;
    fConfig.AsString := ConfigJSON;
//    if fConfig.I[Email_ServerPort] = 0 then
//      fConfig.I[Email_ServerPort] := 110;
//    if fConfig.I[Email_OutServerPort] = 0 then
//      fConfig.I[Email_OutServerPort] := 25;
    if Config.S[Email_ServerType] = '' then
      Config.S[Email_ServerType] := Email_ServerTypePOP;
  end;
  result := fConfig;
end;

function TEmailConfig.GetConfigJSON: string;
begin
  Result := GetStringField('ConfigJSON');
end;

function TEmailConfig.GetConfigValid: Boolean;
begin
  Result := GetBooleanField('ConfigValID');
end;

function TEmailConfig.GetDirty: boolean;
begin
  result := inherited;
  if Assigned(fConfig) then begin
    if not result then
      result := ConfigJSON <> fConfig.AsString;
  end;
end;

procedure TEmailConfig.SetEntityName(const Value: string);
begin
  SetStringField('EntityName', Value);
end;

procedure TEmailConfig.SetIntegrationType(const Value: string);
begin
  SetStringField('IntegrationType', Value);
end;

procedure TEmailConfig.SetPort(const Value: integer);
begin
  Config.I[Email_Port] := Value;
end;

procedure TEmailConfig.SetReplyEmailAddress(const Value: string);
begin
  Config.S[Email_ReplyEmailAddress] := Value;
end;

procedure TEmailConfig.SetServer(const Value: string);
begin
  Config.S[Email_Server] := Value;
end;

procedure TEmailConfig.SetServerPassword(const Value: string);
begin
  Config.S[Email_ServerPassword] := Value;
end;

procedure TEmailConfig.SetServerType(const Value: string);
begin
  Config.S[Email_ServerType] := Value;
end;

procedure TEmailConfig.SetServerUserName(const Value: string);
begin
  Config.S[Email_ServerUserName] := Value;
end;

procedure TEmailConfig.SetSignatureFromFile(const Value: boolean);
begin
  Config.B[Email_SignatureFromFile] := Value;
end;

procedure TEmailConfig.SetSignatureText(const Value: string);
begin
  Config.S[Email_SignatureText] := Value;
end;

procedure TEmailConfig.SetSMTPAuthType(const Value: string);
begin
  Config.S[Email_SMTPAuthType] := Value;
end;

procedure TEmailConfig.SetSMTPPassword(const Value: string);
begin
  Config.S[Email_SMTPPassword] := Value;
end;

procedure TEmailConfig.SetSMTPPort(const Value: integer);
begin
  Config.I[Email_SMTPPort] := Value;
end;

procedure TEmailConfig.SetSMTPServer(const Value: string);
begin
  Config.S[Email_SMTPServer] := Value;
end;

procedure TEmailConfig.SetSMTPTLS(const Value: string);
begin
  Config.S[Email_SMTPTLS] := Value;
end;

procedure TEmailConfig.SetSMTPUserName(const Value: string);
begin
  Config.S[Email_SMTPUserName] := Value;
end;

procedure TEmailConfig.SetTLS(const Value: string);
begin
  Config.S[Email_TLS] := Value;
end;

procedure TEmailConfig.SetEmailAddress(const Value: string);
begin
  SetStringField('EmailAddress', Value);
end;

procedure TEmailConfig.SetEmailFormat(const Value: string);
begin
  Config.S[Email_EmailFormat] := Value;
end;

procedure TEmailConfig.SetEmailName(const Value: string);
begin
  Config.S[Email_EmailName] := Value;
end;

procedure TEmailConfig.SendProgress(const aMsg: string);
begin
  if Assigned(fOnProgress) then
    fOnProgress(aMsg);
end;

procedure TEmailConfig.SetAuthType(const Value: string);
begin
  Config.S[Email_AuthType] := Value;
end;

procedure TEmailConfig.SetConfigJSON(const Value: string);
begin
  SetStringField('ConfigJSON', Value);
end;

procedure TEmailConfig.SetConfigValid(const Value: Boolean);
begin
  SetBooleanField('ConfigValID', Value);
end;

//function TEmailConfig.getServerName : String;begin  REsult:= Config.S[Email_ServerName] ;end;

function TEmailConfig.GetServerPassword: string;
begin
  result := Config.S[Email_ServerPassword];
end;

//function TEmailConfig.getOutServerName : String;begin  REsult:= Config.S[Email_OutServerName] ;end;
//function TEmailConfig.getServerPort : Integer;begin REsult:= Config.I[Email_ServerPort] ;end;
//function TEmailConfig.getOutServerPort : Integer;begin REsult:= Config.I[Email_OutServerPort] ;end;
//function TEmailConfig.getUserName   : String;begin  REsult:= Config.S[Email_UserName]   ;end;

//function TEmailConfig.GetUseTLS: boolean;
//begin
//  result := Config.B['UseTLS'];
//end;

//function TEmailConfig.getPassword   : String;begin  REsult:= Config.S[Email_Password]   ;end;

function TEmailConfig.GetPort: integer;
begin
  result := Config.I[Email_Port];
end;

function TEmailConfig.GetReplyEmailAddress: string;
begin
  result := Config.S[Email_ReplyEmailAddress];
end;

function TEmailConfig.GetServer: string;
begin
  result := Config.S[Email_Server];
end;

{ TEmailSinatureFile }

constructor TEmailSinatureFile.Create(AOwner: TComponent);
begin
  inherited;

end;

destructor TEmailSinatureFile.Destroy;
begin

  inherited;
end;

function TEmailSinatureFile.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if Assigned(Owner) and (Owner is TEmailConfig) then
    self.EmailConfigId := TEmailConfig(Owner).ID;
end;

function TEmailSinatureFile.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
end;

procedure TEmailSinatureFile.DoFieldOnChange(Sender: TField);
begin
  inherited;

end;

class function TEmailSinatureFile.GetBusObjectTablename: string;
begin
  result := 'tblemailSignature';
end;

function TEmailSinatureFile.GetEmailConfigId: integer;
begin
  result := GetIntegerField('EmailConfigId');
end;

function TEmailSinatureFile.GetFileName: string;
begin
  result := GetStringField('FileName');
end;

class function TEmailSinatureFile.GetIDField: string;
begin
  result := 'ID';
end;

function TEmailSinatureFile.GetIsPrimary: boolean;
begin
  result := GetBooleanField('IsPrimary');
end;

function TEmailSinatureFile.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

procedure TEmailSinatureFile.Load(const fIsReadonly: boolean);
begin
  inherited;

end;

procedure TEmailSinatureFile.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TEmailSinatureFile.OnDataIdChange(
  const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

function TEmailSinatureFile.Save: Boolean;
begin
  Result := False;
  PostDb;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TEmailSinatureFile.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TEmailSinatureFile.SetEmailConfigId(const Value: integer);
begin
  SetIntegerField('EmailConfigId', Value);
end;

procedure TEmailSinatureFile.SetFileName(const Value: string);
begin
  SetStringField('FileName', Value);
end;

procedure TEmailSinatureFile.SetIsPrimary(const Value: boolean);
begin
  SetBooleanField('IsPrimary', Value);
end;

function TEmailSinatureFile.ValidateData: Boolean;
begin
  result := inherited;
end;

initialization

  RegisterClass(TEmailConfig);

end.
