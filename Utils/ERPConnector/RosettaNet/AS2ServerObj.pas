unit AS2ServerObj;

interface

uses
  SysUtils, ConTnrs, Classes, SBCustomCertStorage, SBX509, SBWinCertStorage,
  SBSessionPool, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdCustomHTTPServer, IdHTTPServer, IdServerIOHandler, IdSSL,
  SBIndyServerIOHandler10,
  MessageInfoObj, LogThreadBase, LogMessageTypes, IdContext, SBASCommon, SBAS2,
  SBSSLConstants, CertFileObj;

type

  TErrorEvent = procedure (const aError, aDetail: string; MessageInfo: TMessageInfo = nil) of object;

  TAS2Server = class(TObject)
  private
    fCertFileList: TObjectList;
    HTTPServer: TIdHttpServer;
    IOHandler: TElIndySSLServerIOHandler;
    SessionPool: TElSessionPool;
    ClientCertStorage: TElWinCertStorage;
    CertStorage: TElMemoryCertStorage;
    fLogger: TLoggerBase;
    fServerPort: integer;
    fInboundMessageFolder: string;
    fOnError: TErrorEvent;
    Procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    procedure SetInboundMessageFolder(const Value: string);
    procedure SetServerPort(const Value: integer);
    procedure IOHandlerCertificateValidate(Sender: TObject;
      X509Certificate: TElX509Certificate;
      IOHandler: TElClientServerIndySSLIOHandlerSocket; var Validate: Boolean);
    procedure HTTPServerConnect(AContext: TIdContext);
    procedure HTTPServerDisconnect(AContext: TIdContext);
    procedure HTTPServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    function SaveMessage(stream: TStream; MessageInfo: TMessageInfo): boolean; overload;
    function SaveMessage(MessageStream, mdnStream: TStream; MessageInfo: TMessageInfo): boolean; overload;
    procedure Error(const aError, aDetail: string; MessageInfo: TMessageInfo = nil);
    procedure AS2MessageError(Sender: TObject; Code: Integer;
      const Description: string; Critical: Boolean;
      var Modifier: TSBASDispositionModifier; var ReportTag: string;
      var Ignore: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    property Logger: TLoggerBase read fLogger write fLogger;
    property ServerPort: integer read fServerPort write SetServerPort;
    property Active: boolean read GetActive write SetActive;
    procedure AddServerCertificate(aCertFileName: string; aPrivateKeyFileName: string = '');
    property InboundMessageFolder: string read fInboundMessageFolder write SetInboundMessageFolder;
    property OnError: TErrorEvent read fOnError write fOnError;
  end;

implementation

uses
  SBASUtils, ModuleFileNameUtils, SBUTILS, SBMIME, Windows, SBSSLServer;

{ TAS2Server }

procedure TAS2Server.AddServerCertificate(aCertFileName, aPrivateKeyFileName: string);
var
  rec: TCertFileRec;
begin
  rec := TCertFileRec.Create;
  rec.CertType := 'server';
  rec.CertFileName := aCertFileName;
  rec.PrivateKeyFileName := aPrivateKeyFileName;
  fCertFileList.Add(rec);
end;

procedure TAS2Server.AS2MessageError(Sender: TObject; Code: Integer;
  const Description: string; Critical: Boolean;
  var Modifier: TSBASDispositionModifier; var ReportTag: string;
  var Ignore: Boolean);
begin
  Log('AS2Message - Code: ' + IntToStr(Code) + ' Message: ' + Description,ltWarning);
end;

constructor TAS2Server.Create;
begin
  fCertFileList := TObjectList.Create(true);
  HTTPServer := TIdHttpServer.Create(nil);
  HTTPServer.OnConnect := HTTPServerConnect;
  HTTPServer.OnDisconnect := HTTPServerDisconnect;
  HTTPServer.OnCommandGet := HTTPServerCommandGet;
  IOHandler := TElIndySSLServerIOHandler.Create(nil);
  HTTPServer.IOHandler := IOHandler;
  IOHandler.CipherSuites[SB_SUITE_RSA_RC4_MD5] := true;
  IOHandler.CipherSuites[SB_SUITE_RSA_RC4_MD5_EXPORT] := true;
  IOHandler.CipherSuites[SB_SUITE_RSA_3DES_SHA] := true;
  IOHandler.CipherSuites[SB_SUITE_DHE_RSA_3DES_SHA] := true;
  IOHandler.CipherSuites[SB_SUITE_DH_RSA_3DES_SHA] := true;
  IOHandler.CipherSuites[SB_SUITE_DH_ANON_RC4_MD5] := true;
  IOHandler.CipherSuites[SB_SUITE_RSA_AES256_SHA] := true;
  IOHandler.Versions := IOHandler.Versions + [sbSSL2];
  IOHandler.Versions := IOHandler.Versions + [sbSSL3];
  IOHandler.Versions := IOHandler.Versions + [sbTLS1];
  IOHandler.Versions := IOHandler.Versions + [sbTLS11];

  IOHandler.OnCertificateValidate := IOHandlerCertificateValidate;
  SessionPool := TElSessionPool.Create(nil);
  ClientCertStorage := TElWinCertStorage.Create(nil);
  ClientCertStorage.Options := [csoStrictChainBuilding];
  CertStorage := TElMemoryCertStorage.Create(nil);
  CertStorage.Options := [csoStrictChainBuilding];
  IOHandler.SessionPool := SessionPool;
  IOHandler.CertStorage := ClientCertStorage;
  IOHandler.ServerCertStorage := CertStorage;
  IOHandler.AuthenticationLevel := alRequestCert;
  IOHandler.ConnectTimeout := -1;
  IOHandler.ReadTimeout := -1;

end;

destructor TAS2Server.Destroy;
begin
  HTTPServer.Free;
  IOHandler.Free;
  SessionPool.Free;
  fCertFileList.Free;
  ClientCertStorage.Free;
  CertStorage.Free;
  inherited;
end;

procedure TAS2Server.Error(const aError, aDetail: string;
  MessageInfo: TMessageInfo);
begin
  if Assigned(fOnError) then
    fOnError(aError,aDetail,MessageInfo);
end;

function TAS2Server.GetActive: boolean;
begin
  result := HTTPServer.Active;
end;

procedure TAS2Server.HTTPServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  StringStream: TStringStream;
  MessageInfo: TMessageInfo;
  MemStream, RStream, Temp: TMemoryStream;
  Rcpt: TElAS2Receipt;
  Buffer: AnsiString;
  AS2Message: TElAS2Message;

begin
  Log('Received request type: '+ ARequestInfo.Command,ltDetail);
  Log('Document: '+ ARequestInfo.Document,ltDetail);
  Log('Remote IP: '+ ARequestInfo.RemoteIP,ltDetail);
  Log('Content type: '+ ARequestInfo.ContentType,ltDetail);
  Log('Content length: '+ IntToStr(ARequestInfo.ContentLength),ltDetail);
  Log('Raw HTTP Command: '+ ARequestInfo.RawHTTPCommand,ltDetail);

  //if (ARequestInfo.CommandType = hcPOST) and SameText(ARequestInfo.Document, '/as2handler') then begin
  if (ARequestInfo.CommandType = hcPOST) and Assigned(ARequestInfo.PostStream) then begin
    AContext.Data := TMessageInfo.NewInst(self.InboundMessageFolder+'\History');
    MessageInfo:= TMessageInfo(AContext.Data);
    MessageInfo.Info.Values['HTTP Request Type']:= ARequestInfo.Command;
    MessageInfo.Info.Values['Remote IP']:= ARequestInfo.RemoteIP;

    Log(Format('[%s:%d] Receiving new AS2 message', [AContext.Binding.PeerIP, AContext.Binding.PeerPort]),ltDetail);
    MemStream:= TMemoryStream.Create;
    StringStream := TStringStream.Create;
    AS2Message:= TElAS2Message.Create(nil);
    try
      AS2Message.Version := as2Ver11;
      AS2Message.OnError := As2MessageError;
      ARequestInfo.RawHeaders.SaveToStream(MemStream);
      SBASUtils.WriteLine(MemStream, '');
      MemStream.CopyFrom(ARequestInfo.PostStream, 0);
      MessageInfo.AddDocument('RawAS2Message.bin',MemStream);
      Memstream.Position := 0;
      try
        if not AS2Message.Load(MemStream, StringStream) then // (FileName, ChangeFileExt(FileName, '.bin')) then
        begin
          Log('Non-critical errors, message header information missing',ltDetail);
        end;
          { process the message  }
        MessageInfo.AddDocument('DecodedAS2Message.txt',StringStream);

        if (AS2Message.ReceiptRequest.Enabled) then begin
          Log('Receipt has been requested.',ltDetail);

          Rcpt := TElAS2Receipt.Create(nil);
          try
            Rcpt.Assign(AS2Message);
            Rcpt.Text := 'Your message has been received successfully. This does not guarantee that the message has been read or understood.';
            RStream := TMemoryStream.Create;
            try
              Rcpt.Save(RStream);
              RStream.Position := 0;
//              MessageInfo.AddDocument('ReceiptContent',RStream);
              RStream.Position := 0;

              if AS2Message.ReceiptRequest.AsyncReceipt then begin
                { Async - save receipt and send later }
                Log('Async Receipt has been requested',ltDetail);

                MessageInfo.Info.Values['mdnURL'] := AS2Message.ReceiptRequest.URL;
                if not SaveMessage(StringStream,RStream,MessageInfo) then begin
                  AResponseInfo.ResponseNo := 500;
                  AResponseInfo.ResponseText := 'Internal Server Error';
                  AResponseInfo.ContentType := 'text/plain';
                  AResponseInfo.ContentText := 'Error saving message file.';
                  AResponseInfo.WriteContent;
                  exit;
                end;

                AResponseInfo.ResponseNo := 200;
                AResponseInfo.ResponseText := 'OK';
                AResponseInfo.ContentType := '';


              end
              else begin
                { Sync - send receipt now }
                Log('Sync Receipt has been requested',ltDetail);

                if not SaveMessage(StringStream,MessageInfo) then begin
                  AResponseInfo.ResponseNo := 500;
                  AResponseInfo.ResponseText := 'Internal Server Error';
                  AResponseInfo.ContentType := 'text/plain';
                  AResponseInfo.ContentText := 'Error saving message file.';
                  AResponseInfo.WriteContent;
                  exit;
                end;

                AResponseInfo.ResponseNo := 200;
                AResponseInfo.ResponseText := 'OK';
                AResponseInfo.ContentType := '';

                // Because of limitations of Indy library we have to do the following:
                // 1. Read receipt headers from the stream
                Buffer := SBMIME.GetHeaderFromStream(RStream);
                // 2. Remove the last 2 characters (#13#10) from the headers
                Delete(Buffer, Length(Buffer) - 1, 2);
                // 3. Put the headers into CustomHeaders field of the AResponseInfo object
                AResponseInfo.CustomHeaders.Text := {$ifdef UNICODE}String(Buffer){$else}Buffer{$endif};
  //              MessageInfo.Info.Values['CustomHeaders'] := AResponseInfo.CustomHeaders.Text;
                // 4. After step 1 the RStream is positioned on the beginning of the message body.
                //    Thus Indy rewinds the stream to its start, we need to copy the message body
                //    to a temporary stream.
                Temp := TMemoryStream.Create;
                try
                  Temp.CopyFrom(RStream, RStream.Size - RStream.Position);
                  AResponseInfo.ContentStream := Temp;
                  AResponseInfo.FreeContentStream := False;
                  AResponseInfo.WriteContent;
                finally
                  FreeAndNil(Temp);
                end;
              end;





            finally
              RStream.Free;
            end;
          finally
            Rcpt.Free;
          end;

        end
        else begin
          {no ReceiptRequest required}
          if not SaveMessage(StringStream,MessageInfo) then begin
            AResponseInfo.ResponseNo := 500;
            AResponseInfo.ResponseText := 'Internal Server Error';
            AResponseInfo.ContentType := 'text/plain';
            AResponseInfo.ContentText := 'Error saving message file.';
            AResponseInfo.WriteContent;
            exit;
          end;

          AResponseInfo.ResponseNo := 200;
          AResponseInfo.ResponseText := 'OK';
          AResponseInfo.ContentType := '';
        end;


      except
        on E: EElASMessageError do
        begin
          Log('Message parsing error: ' + E.Message,ltError);
          MessageInfo.Info.Values['Error']:= 'Message parsing error: ' + E.Message;
          AResponseInfo.ResponseNo := 500;
          AResponseInfo.ResponseText := 'Internal Server Error';
          AResponseInfo.ContentType := 'text/plain';
          AResponseInfo.ContentText := E.Message;
          AResponseInfo.WriteContent;
          exit;
          // TODO: add advanced AS2 critical errors handling here
        end;
        on E: Exception do begin
          Log('Message error: ' + E.Message,ltError);
          MessageInfo.Info.Values['Error']:= 'Message error: ' + E.Message;
          AResponseInfo.ResponseNo := 500;
          AResponseInfo.ResponseText := 'Internal Server Error';
          AResponseInfo.ContentType := 'text/plain';
          AResponseInfo.ContentText := E.Message;
          AResponseInfo.WriteContent;
          exit;
        end;
      end;

    finally
      AS2Message.Free;
      MemStream.Free;
      StringStream.Free;
      MessageInfo.Info.Values['Result']:= IntToStr(AResponseInfo.ResponseNo);
    end;
  end
end;

procedure TAS2Server.HTTPServerConnect(AContext: TIdContext);
begin
  Log('',ltDetail);
  Log('Client connect, Remote IP: '+ AContext.Connection.Socket.Binding.PeerIP, ltDetail);
end;

procedure TAS2Server.HTTPServerDisconnect(AContext: TIdContext);
begin
  Log('Client disconnect, Remote IP: '+ AContext.Connection.Socket.Binding.PeerIP,ltDetail);
  if Assigned(AContext.Data) then
    TMessageInfo(AContext.Data).Save;
end;

procedure TAS2Server.IOHandlerCertificateValidate(Sender: TObject;
  X509Certificate: TElX509Certificate;
  IOHandler: TElClientServerIndySSLIOHandlerSocket; var Validate: Boolean);
var
  S : string;
  Validity : TSBCertificateValidity;
  Reason : TSBCertificateValidityReason;
begin
  Log('Certificate arrived',ltDetail);
  Log('---Certificate data start---',ltDetail);
  IOHandler.InternalValidate(Validity, Reason);
  case Validity of
    cvOk : S := 'Certificate is valid';
    cvSelfSigned : S := 'Certificate is self-signed';
    cvInvalid : S := 'Certificate is invalid';
  else
    S := 'Storage error occured while processing certificate';
  end;
  Log(S,ltDetail);
  S := '';
  if vrBadData in Reason then
    S := S + 'Certificate data is corrupt. ';
  if vrRevoked in Reason then
    S := S + 'Certificate is revoked. ';
  if vrNotYetValid in Reason then
    S := S + 'Certificate is not yet valid. ';
  if vrExpired in Reason then
    S := S + 'Certificate is expired. ';
  if vrInvalidSignature in Reason then
    S := S + 'Certificate contains invalid digital signature. ';
  if vrUnknownCA in Reason then
    S := S + 'Certificate is signed by unknown CA. ';
  Log(S,ltDetail);
  S := 'Issuer: ' + 'CN=' + X509Certificate.IssuerName.CommonName + ', C=' + X509Certificate.IssuerName.Country +
    ', O=' + X509Certificate.IssuerName.Organization + ', L=' + X509Certificate.IssuerName.Locality;
  Log(S,ltDetail);
  S := 'Subject: ' + 'CN=' + X509Certificate.SubjectName.CommonName + ', C=' + X509Certificate.SubjectName.Country +
    ', O=' + X509Certificate.SubjectName.Organization + ', L=' + X509Certificate.SubjectName.Locality;
  Log(S,ltDetail);
  Log('---Certificate data end---',ltDetail);
  Validate := true;
end;

procedure TAS2Server.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg,LogMessageType);
end;

function TAS2Server.SaveMessage(stream: TStream;
  MessageInfo: TMessageInfo): boolean;
var
  fName: string;
  fileStream: TFileStream;
begin
  result := false;
  fileStream := nil;
  fName := self.InboundMessageFolder + '\message_' + MessageInfo.ID;
  try
    try
      fileStream := TFileStream.Create(fName + '.tmp',fmCreate or fmShareDenyWrite);
      fileStream.CopyFrom(stream,0);
    finally
      fileStream.Free;
    end;
    if SysUtils.RenameFile(fName + '.tmp',fName + '.bin') then begin
      result := true;
      exit;
    end
    else begin
      Error('Error saving inbound message ' + fName,'Could not rename file',MessageInfo);
      exit;
    end;
  except
    on e: exception do begin
      Error('Error saving inbound message ' + fName,e.Message,MessageInfo);
      { clean up }
      SysUtils.DeleteFile(fName + '.tmp');
      SysUtils.DeleteFile(fName + '.bin');
      exit;
    end;
  end;
end;

function TAS2Server.SaveMessage(MessageStream, mdnStream: TStream;
  MessageInfo: TMessageInfo): boolean;
var
  fName: string;
  fileStream: TFileStream;
begin
  result := false;
  fileStream := nil;
  fName := self.InboundMessageFolder + '\message_' + MessageInfo.ID;
  try
    try
      fileStream := TFileStream.Create(fName + '.mdn',fmCreate or fmShareDenyWrite);
      mdnStream.Position := 0;
      fileStream.CopyFrom(mdnStream,0);
      { save a copy }
      MessageInfo.AddDocument('save_' + MessageInfo.ID + '.mdn', mdnStream);

    finally
      fileStream.Free;
    end;

    MessageInfo.Info.SaveToFile(fName + '.inf');
   { save a copy }
   MessageInfo.AddDocument('save_' + MessageInfo.ID + '.inf', MessageInfo.Info.Text);

    try
      fileStream := TFileStream.Create(fName + '.tmp',fmCreate or fmShareDenyWrite);
      MessageStream.Position := 0;
      fileStream.CopyFrom(MessageStream,0);
      { save a copy }
      MessageInfo.AddDocument('save_' + MessageInfo.ID + '.bin', fileStream);
    finally
      fileStream.Free;
    end;

    if SysUtils.RenameFile(fName + '.tmp',fName + '.bin') then begin
      result := true;
      exit;
    end
    else begin
      Error('Error saving inbound message ' + fName,'Could not rename file',MessageInfo);
      exit;
    end;
  except
    on e: exception do begin
      Error('Error saving inbound message ' + fName,e.Message,MessageInfo);
      { clean up }
      SysUtils.DeleteFile(fName + '.tmp');
      SysUtils.DeleteFile(fName + '.bin');
      SysUtils.DeleteFile(fName + '.mdn');
      SysUtils.DeleteFile(fName + '.inf');
      exit;
    end;
  end;
end;

procedure TAS2Server.SetActive(const Value: boolean);
var
  Stream: TFileStream;
  Certificate: TElX509Certificate;
  x: integer;
begin
  if HTTPServer.Active <> Value then begin
    if not Value then begin
      HTTPServer.Active := false;
    end
    else begin
      CertStorage.Clear;
      if HTTPServer.DefaultPort <> fServerPort then begin
        HTTPServer.Bindings.Clear;
        HTTPServer.DefaultPort := fServerPort;
      end;

      for x := 0 to fCertFileList.Count -1 do begin
        if TCertFileRec(fCertFileList[x]).CertType = 'server' then begin
          Certificate := TElX509Certificate.Create(nil);
          try
//            Log('Loading certificate: ' + TCertFileRec(fCertFileList[x]).CertFileName, ltDetail);
            Stream := TFileStream.Create(TCertFileRec(fCertFileList[x]).CertFileName , fmOpenRead or fmShareDenyWrite);
            try
              Certificate.LoadFromStream(Stream);
            finally
              Stream.Free;
            end;
            if TCertFileRec(fCertFileList[x]).PrivateKeyFileName <> '' then begin
//              Log('Loading key: ' + TCertFileRec(fCertFileList[x]).PrivateKeyFileName, ltDetail);
              Stream := TFileStream.Create(TCertFileRec(fCertFileList[x]).PrivateKeyFileName , fmOpenRead or fmShareDenyWrite);
              try
                Certificate.LoadKeyFromStream(Stream);
              finally
                Stream.Free;
              end;
            end;
            CertStorage.Add(Certificate);
          finally
            Certificate.Free;
          end;
        end;
      end;

      ClientCertStorage.SystemStores.Clear;
	    ClientCertStorage.SystemStores.Add('ROOT');
      HTTPServer.Active := true;
    end;
  end;
end;

procedure TAS2Server.SetInboundMessageFolder(const Value: string);
begin
  if fInboundMessageFolder <> Value then begin
    if ForceDirectories(Value) then
      fInboundMessageFolder := Value
    else
      raise Exception.Create('Unable to create Inbound Message Folder "' + Value + '"');
  end;
end;

procedure TAS2Server.SetServerPort(const Value: integer);
var
  SaveActive: boolean;
begin
  if fServerPort <> Value then begin
    SaveActive := Active;
    Active := false;
    fServerPort := Value;
    Active := SaveActive;
  end;
end;


end.
