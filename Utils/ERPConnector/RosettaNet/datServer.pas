unit datServer;

interface

uses
  SysUtils, Classes, SBCustomCertStorage, SBX509, SBWinCertStorage,
  SBSessionPool, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdCustomHTTPServer, IdHTTPServer, IdServerIOHandler, IdSSL,
  SBIndyServerIOHandler10,
  MessageInfoObj, LogThreadBase, LogMessageTypes, IdContext, SBASCommon, SBAS2,
   SBSSLConstants;

type
  TErrorEvent = procedure (const aError, aDetail: string; MessageInfo: TMessageInfo = nil) of object;


  TdmServer = class(TDataModule)
    HTTPServer: TIdHTTPServer;
    SessionPool: TElSessionPool;
    ClientCertStorage: TElWinCertStorage;
    CertStorage: TElMemoryCertStorage;
    IOHandler: TElIndySSLServerIOHandler;
    procedure IOHandlerCertificateValidate(Sender: TObject;
      X509Certificate: TElX509Certificate;
      IOHandler: TElClientServerIndySSLIOHandlerSocket; var Validate: Boolean);
    procedure HTTPServerConnect(AContext: TIdContext);
    procedure HTTPServerDisconnect(AContext: TIdContext);
    procedure HTTPServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure HTTPServerCommandError(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
      AException: Exception);
    procedure HTTPServerException(AContext: TIdContext; AException: Exception);
    procedure IOHandlerError(Sender: TObject; ErrorCode: Integer; Fatal,
      Remote: Boolean);
    procedure HTTPServerStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure IOHandlerStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure HTTPServerListenException(AThread: TIdListenerThread;
      AException: Exception);
    procedure IOHandlerSSLEstablished(Sender: TObject; Version: TSBVersion;
      CipherSuite: TSBCipherSuite);
    procedure IOHandlerCiphersNegotiated(Sender: TObject);
    procedure HTTPServerCommandOther(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure HTTPServerHeaderExpectations(AContext: TIdContext;
      const AExpectations: string; var VContinueProcessing: Boolean);
  private
    fLogger: TLoggerBase;
    fPrivateKeyFileName: string;
    fDERCertificateFileName: string;
    fServerPort: integer;
    fInboundMessageFolder: string;
    fOnError: TErrorEvent;
    Procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    procedure SetDERCertificateFileName(const Value: string);
    procedure SetPrivateKeyFileName(const Value: string);
    procedure SetServerPort(const Value: integer);
    procedure SetInboundMessageFolder(const Value: string);
    function SaveMessage(stream: TStream; MessageInfo: TMessageInfo): boolean;
    procedure Error(const aError, aDetail: string; MessageInfo: TMessageInfo = nil);
    procedure AS2MessageError(Sender: TObject; Code: Integer;
      const Description: string; Critical: Boolean;
      var Modifier: TSBASDispositionModifier; var ReportTag: string;
      var Ignore: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property Logger: TLoggerBase read fLogger write fLogger;
    property ServerPort: integer read fServerPort write SetServerPort;
    property Active: boolean read GetActive write SetActive;
    property DERCertificateFileName: string read fDERCertificateFileName write SetDERCertificateFileName;
    property PrivateKeyFileName: string read fPrivateKeyFileName write SetPrivateKeyFileName;
    property InboundMessageFolder: string read fInboundMessageFolder write SetInboundMessageFolder;
    property OnError: TErrorEvent read fOnError write fOnError;
  end;

//var
//  dmServer: TdmServer;

implementation

{$R *.dfm}

uses
  SBASUtils, ModuleFileNameUtils, SBUTILS, SBMIME, Windows;

{ TdmServer }

procedure TdmServer.AS2MessageError(Sender: TObject; Code: Integer;
  const Description: string; Critical: Boolean;
  var Modifier: TSBASDispositionModifier; var ReportTag: string;
  var Ignore: Boolean);
begin
  Log('AS2Message - Code: ' + IntToStr(Code) + ' Message: ' + Description,ltWarning);
end;

constructor TdmServer.Create(AOwner: TComponent);
begin
  inherited;
  fServerPort := 443;
  IOHandler.CipherSuites[SB_SUITE_RSA_RC4_MD5] := true;
  IOHandler.CipherSuites[SB_SUITE_RSA_RC4_MD5_EXPORT] := true;
  IOHandler.CipherSuites[SB_SUITE_RSA_3DES_SHA] := true;
  IOHandler.CipherSuites[SB_SUITE_DHE_RSA_3DES_SHA] := true;
  IOHandler.CipherSuites[SB_SUITE_DH_RSA_3DES_SHA] := true;
  IOHandler.CipherSuites[SB_SUITE_DH_ANON_RC4_MD5] := true;
  IOHandler.CipherSuites[SB_SUITE_RSA_AES256_SHA] := true;

end;

procedure TdmServer.Error(const aError, aDetail: string;
  MessageInfo: TMessageInfo);
begin
  if Assigned(fOnError) then
    fOnError(aError,aDetail,MessageInfo);
end;

function TdmServer.GetActive: boolean;
begin
  result := HTTPServer.Active;
end;

procedure TdmServer.HTTPServerCommandError(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
  AException: Exception);
begin
  Log('Command Error: ' + AException.Message, ltError);
end;

procedure TdmServer.HTTPServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  StringStream: TStringStream;
//  reader: TStreamReader;
//  s: string;
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

        if (AS2Message.ReceiptRequest.Enabled) then begin
          Log('Receipt has been requested, sending receipt',ltDetail);
          Rcpt := TElAS2Receipt.Create(nil);
          try
            Rcpt.Assign(AS2Message);
            Rcpt.Text := 'Your message has been received successfully. This does not guarantee that the message has been read or understood.';
            RStream := TMemoryStream.Create;
            try
              Rcpt.Save(RStream);
              RStream.Position := 0;

              // Because of limitations of Indy library we have to do the following:
              // 1. Read receipt headers from the stream
              Buffer := SBMIME.GetHeaderFromStream(RStream);
              // 2. Remove the last 2 characters (#13#10) from the headers
              Delete(Buffer, Length(Buffer) - 1, 2);
              // 3. Put the headers into CustomHeaders field of the AResponseInfo object
              AResponseInfo.CustomHeaders.Text := {$ifdef UNICODE}String(Buffer){$else}Buffer{$endif};
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


            finally
              RStream.Free;
            end;
          finally
            Rcpt.Free;
          end;

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

procedure TdmServer.HTTPServerCommandOther(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  Log('HTTP Server - Command Other',ltDetail);
end;

procedure TdmServer.HTTPServerConnect(AContext: TIdContext);
begin
  Log('',ltDetail);
  Log('Client connect, Remote IP: '+ AContext.Connection.Socket.Binding.PeerIP, ltDetail);
//  AContext.Data := TMessageInfo.NewInst(self.InboundMessageFolder+'\History');
  {  passthrough must be false for ssl }
//  TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).passThrough:= false;
end;

procedure TdmServer.HTTPServerDisconnect(AContext: TIdContext);
begin
  Log('Client disconnect, Remote IP: '+ AContext.Connection.Socket.Binding.PeerIP,ltDetail);
  if Assigned(AContext.Data) then
    TMessageInfo(AContext.Data).Save;
end;

procedure TdmServer.HTTPServerException(AContext: TIdContext;
  AException: Exception);
begin
  Log('Server Exception: ' + AException.Message, ltError);
end;

procedure TdmServer.HTTPServerHeaderExpectations(AContext: TIdContext;
  const AExpectations: string; var VContinueProcessing: Boolean);
begin
  Log('Header Expectations: ' + AExpectations,ltDetail);
  VContinueProcessing := true;
end;

procedure TdmServer.HTTPServerListenException(AThread: TIdListenerThread;
  AException: Exception);
begin
  Log('Listner Exception: ' + AException.Message,ltDetail);
end;

procedure TdmServer.HTTPServerStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
  Log('Server Status: ' + AStatusText,ltDetail);
end;

procedure TdmServer.IOHandlerCertificateValidate(Sender: TObject;
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

procedure TdmServer.IOHandlerCiphersNegotiated(Sender: TObject);
begin
  Log('CiphersNegotiated', ltDetail);
end;

procedure TdmServer.IOHandlerError(Sender: TObject; ErrorCode: Integer; Fatal,
  Remote: Boolean);
begin
  Log('IOHandler Error: Error Code: ' + IntToStr(ErrorCode) + ' Fatal: ' + BoolToStr(Fatal,true) + ' Remote: ' + BoolToStr(Remote,true), ltError);
end;

procedure TdmServer.IOHandlerSSLEstablished(Sender: TObject;
  Version: TSBVersion; CipherSuite: TSBCipherSuite);
begin
  Log('IOHandlerSSLEstablished - Version: ' + IntToStr(Ord(Version)) + ' CipherSuite: ' + IntToStr(CipherSuite), ltDetail);
end;

procedure TdmServer.IOHandlerStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
  Log('IOHandler Status: ' + AStatusText,ltDetail);
end;

procedure TdmServer.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg,LogMessageType);
end;

function TdmServer.SaveMessage(stream: TStream; MessageInfo: TMessageInfo): boolean;
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
      exit;
    end;
  end;
end;

procedure TdmServer.SetActive(const Value: boolean);
var
  Stream: TFileStream;
  Buffer : array of byte;
  Certificate: TElX509Certificate;
  path: string;
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

      path := ModuleFileNameUtils.GetCurrentModulePath;;
      Certificate := TElX509Certificate.Create(nil);
      try

        Stream := TFileStream.Create(path + 'receiver.b2b.telstra.com.der.cer', fmOpenRead or fmShareDenyWrite);
        try
          SetLength(Buffer, Stream.Size);
          Stream.ReadBuffer(Buffer[0], Stream.Size);
          Certificate.LoadFromBuffer(@Buffer[0], Stream.Size);
          CertStorage.Add(Certificate);
        finally
          Stream.Free;
        end;

        Stream := TFileStream.Create(path + 'VerisignCA.der.cer', fmOpenRead or fmShareDenyWrite);
        try
          SetLength(Buffer, Stream.Size);
          Stream.ReadBuffer(Buffer[0], Stream.Size);
          Certificate.LoadFromBuffer(@Buffer[0], Stream.Size);
          CertStorage.Add(Certificate);
        finally
          Stream.Free;
        end;

        Stream := TFileStream.Create(path + 'VerisignIntermediary.der.cer', fmOpenRead or fmShareDenyWrite);
        try
          SetLength(Buffer, Stream.Size);
          Stream.ReadBuffer(Buffer[0], Stream.Size);
          Certificate.LoadFromBuffer(@Buffer[0], Stream.Size);
          CertStorage.Add(Certificate);
        finally
          Stream.Free;
        end;



        Stream := TFileStream.Create(fDERCertificateFileName, fmOpenRead or fmShareDenyWrite);
        try
          SetLength(Buffer, Stream.Size);
          Stream.ReadBuffer(Buffer[0], Stream.Size);
          Certificate.LoadFromBuffer(@Buffer[0], Stream.Size);
        finally
          FreeAndNil(Stream);
        end;
        Stream := TFileStream.Create(fPrivateKeyFileName, fmOpenRead or fmShareDenyWrite);

        try
          SetLength(Buffer, Stream.Size);
          Stream.ReadBuffer(Buffer[0], Stream.Size);
          Certificate.LoadKeyFromBufferPEM(@Buffer[0], Stream.Size, '123456');
        finally
          FreeAndNil(Stream);
        end;
        CertStorage.Add(Certificate);

      finally;
        Certificate.Free;
      end;


      ClientCertStorage.SystemStores.Clear;
	    ClientCertStorage.SystemStores.Add('ROOT');
      HTTPServer.Active := true;
    end;
  end;
end;

procedure TdmServer.SetDERCertificateFileName(const Value: string);
var
  SaveActive: boolean;
begin
  if fDERCertificateFileName <> Value then begin
    SaveActive := Active;
    Active := false;
    fDERCertificateFileName := Value;
    Active := SaveActive;
  end;
end;

procedure TdmServer.SetInboundMessageFolder(const Value: string);
begin
  if fInboundMessageFolder <> Value then begin
    if ForceDirectories(Value) then
      fInboundMessageFolder := Value
    else
      raise Exception.Create('Unable to create Inbound Message Folder "' + Value + '"');
  end;
end;

procedure TdmServer.SetPrivateKeyFileName(const Value: string);
var
  SaveActive: boolean;
begin
  if fPrivateKeyFileName <> Value then begin
    SaveActive := Active;
    Active := false;
    fPrivateKeyFileName := Value;
    Active := SaveActive;
  end;
end;

procedure TdmServer.SetServerPort(const Value: integer);
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

initialization

   SBUTILS.SetLicenseKey('A7A24C6D93839EDECE3885D93A823492EB7A28BECCE22AE32B864849BBAFD87E' +
  '07D98B7BD629708B67492685DDCF32D07104E98AC803E2DBB511BAE15A3A55EB' +
  '695008E1816BBD92AA43B3F4F88826A3CF206F1854A37049FE1AC8A9AC265F37' +
  '21AE17A7AD59AAADBEE59B398CF3FE0D90765C51135B7AA45B737F72AC4831F4' +
  '9FC4F68BB367BE839471B209398FA45F177E63835D2B08E01ED41227D1CD1462' +
  'DD0FAB901E0157CE88412DC36CDE1C797C74EC32DEE57B91FC210FD1BCA173AD' +
  '1836E1CC35848A1E33E47747527811DBA3FB28CBEC19A92114B29317D05426F8' +
  'EC386B39DBDA821DA9A21A9034851F5A9F530F9293F56D3646A1C7246CA03296');



end.
