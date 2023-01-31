unit AS2ClientObj;

interface

uses
  LogThreadBase, LogMessageTypes, MessageInfoObj, classes,
  SBX509, SBASCommon, ConTnrs, CertFileObj, SBCustomCertStorage, SBSSLCommon,
  SysUtils, SBSSLClient, SBAS2, SBTypes;

type
  TErrorEvent = procedure (const aError, aDetail: string; MessageInfo: TMessageInfo = nil) of object;

  TAS2Client = class
  private
    fCertFileList: TObjectList;
    fLogger: TLoggerBase;
    fOnError: TErrorEvent;
    FAS2From: string;
    FOutboundMessageFolder: string;
    FSubject: string;
    FAS2To: string;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    procedure Error(const aError, aDetail: string; MessageInfo: TMessageInfo = nil);
    procedure SetAS2From(const Value: string);
    procedure SetAS2To(const Value: string);
    procedure SetOutboundMessageFolder(const Value: string);
    procedure SetSubject(const Value: string);
    procedure LoadCertificates(ServerCertStorage, ClientCertStorage: TElCustomCertStorage);

    { AS2Client events }
    procedure OnCertificateValidateEvent(Sender: TObject; X509Certificate: TElX509Certificate; var Validate: boolean);
//    procedure DoOnCertificateChoose(Sender: TObject; Certificates : array of TElX509Certificate; var CertificateIndex : integer);
//    procedure DoOnCertificateNeededEx(Sender: TObject; var Certificate : TElX509Certificate);
//    procedure DoOnCertificateStatus(Sender: TObject; CertificateStatus : TSBCertificateStatusType; const Data: ByteArray);
//    procedure DoOnCiphersNegotiated(Sender: TObject);
    procedure DoOnError(Sender: TObject; ErrorCode: integer; Fatal: boolean; Remote : boolean);
//    procedure DoOnCloseConnection(Sender: TObject; Reason : TSBCloseReason);
//    procedure DoOnKeyNeeded(Sender: TObject; const Hint : string; var Identity : string; var Key : ByteArray);
  public
    constructor Create;
    destructor Destroy; override;
    property Logger: TLoggerBase read fLogger write fLogger;
    property OnError: TErrorEvent read fOnError write fOnError;
    function SendXMLDoc(const URL: string; DocStream: TStream; aMessageInfo: TMessageInfo = nil): boolean;
    property AS2From: string read FAS2From write SetAS2From;
    property AS2To: string read FAS2To write SetAS2To;
    property Subject: string read FSubject write SetSubject;
    property OutboundMessageFolder: string read FOutboundMessageFolder write SetOutboundMessageFolder;
    function SendReceipt(URL: string; Receipt: TElASReceipt): boolean;
    procedure AddClientCertificate(aCertFileName: string; aPrivateKeyFileName: string = '');
    procedure AddServerCertificate(aCertFileName: string; aPrivateKeyFileName: string = '');
  end;

implementation

uses
  msxmldom, SBUTILS, SBWinCertStorage, SBConstants;

{ TAS2Client }

procedure TAS2Client.AddClientCertificate(aCertFileName,
  aPrivateKeyFileName: string);
var
  rec: TCertFileRec;
begin
  rec := TCertFileRec.Create;
  rec.CertType := 'client';
  rec.CertFileName := aCertFileName;
  rec.PrivateKeyFileName := aPrivateKeyFileName;
  fCertFileList.Add(rec);
end;

procedure TAS2Client.AddServerCertificate(aCertFileName,
  aPrivateKeyFileName: string);
var
  rec: TCertFileRec;
begin
  rec := TCertFileRec.Create;
  rec.CertType := 'server';
  rec.CertFileName := aCertFileName;
  rec.PrivateKeyFileName := aPrivateKeyFileName;
  fCertFileList.Add(rec);
end;

constructor TAS2Client.Create;
begin
  fCertFileList := TObjectList.Create;

end;

destructor TAS2Client.Destroy;
begin
  fCertFileList.Free;
  inherited;
end;

//procedure TAS2Client.DoOnCertificateChoose(Sender: TObject;
//  Certificates: array of TElX509Certificate; var CertificateIndex: integer);
//begin
//  Log('OnCertificateChoose - CertificateIndex: ' + IntToStr(CertificateIndex), ltDetail);
//end;

//procedure TAS2Client.DoOnCertificateNeededEx(Sender: TObject;
//  var Certificate: TElX509Certificate);
//begin
//  if Assigned(Certificate) then
//    Log('OnCertificateNeededEx - Certificate: ' + Certificate.SubjectName.Organization, ltDetail)
//  else
//    Log('OnCertificateNeededEx - Certificate is blank', ltDetail);
//end;

//procedure TAS2Client.DoOnCiphersNegotiated(Sender: TObject);
//begin
//  Log('OnCiphersNegotiated', ltDetail);
//end;

//procedure TAS2Client.DoOnCloseConnection(Sender: TObject;
//  Reason: TSBCloseReason);
//begin
//  Log('OnCloseConnection - Reason: ' + IntToStr(Ord(Reason)), ltDetail);
//end;

procedure TAS2Client.DoOnError(Sender: TObject; ErrorCode: integer; Fatal,
  Remote: boolean);
begin
  Log('OnError - Code: ' + IntToStr(ErrorCode) + ' Fatal: ' + BoolToStr(Fatal, true) + ' Remote: ' + BoolToStr(Remote, true), ltDetail);
end;

//procedure TAS2Client.DoOnKeyNeeded(Sender: TObject; const Hint: string;
//  var Identity: string; var Key: ByteArray);
//begin
//  Log('OnKeyNeeded - Hint: ' + Hint + ' Identity: ' + Identity, ltDetail);
//end;

//procedure TAS2Client.DoOnCertificateStatus(Sender: TObject;
//  CertificateStatus: TSBCertificateStatusType; const Data: ByteArray);
//begin
//  Log('OnCertificateStatus - CertificateStatus: ' + IntToStr(Ord(CertificateStatus)), ltDetail);
//end;

procedure TAS2Client.Error(const aError, aDetail: string;
  MessageInfo: TMessageInfo);
begin
  if Assigned(fOnError) then
    fOnError(aError,aDetail,MessageInfo);
end;

procedure TAS2Client.LoadCertificates(ServerCertStorage, ClientCertStorage: TElCustomCertStorage);
var
  x: integer;
  Stream: TFileStream;
  Certificate: TElX509Certificate;
begin
  for x := 0 to fCertFileList.Count -1 do begin
    Certificate := TElX509Certificate.Create(nil);
    try
//      Log('Loading certificate: ' + TCertFileRec(fCertFileList[x]).CertFileName, ltDetail);
      Stream := TFileStream.Create(TCertFileRec(fCertFileList[x]).CertFileName , fmOpenRead or fmShareDenyWrite);
      try
        Certificate.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
      if TCertFileRec(fCertFileList[x]).PrivateKeyFileName <> '' then begin
//        Log('Loading key: ' + TCertFileRec(fCertFileList[x]).PrivateKeyFileName, ltDetail);
        Stream := TFileStream.Create(TCertFileRec(fCertFileList[x]).PrivateKeyFileName , fmOpenRead or fmShareDenyWrite);
        try
          Certificate.LoadKeyFromStream(Stream);
        finally
          Stream.Free;
        end;
      end;
      if TCertFileRec(fCertFileList[x]).CertType = 'client' then
        ClientCertStorage.Add(Certificate);
      if TCertFileRec(fCertFileList[x]).CertType = 'server' then
        ServerCertStorage.Add(Certificate);
    finally
      Certificate.Free;
    end;
  end;
end;

procedure TAS2Client.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg,LogMessageType);
end;

procedure TAS2Client.OnCertificateValidateEvent(Sender: TObject;
  X509Certificate: TElX509Certificate; var Validate: boolean);
begin
//  if Assigned(X509Certificate) then
//    Log('OnCertificateValidate - Certificate: ' + X509Certificate.SubjectName.Organization, ltDetail)
//  else
//    Log('OnCertificateValidate - Certificate is blank', ltDetail);
  Validate := true;
end;

function TAS2Client.SendReceipt(URL: string; Receipt: TElASReceipt): boolean;
var
  ASA2Client: TElAS2Client;
  MessageInfo: TMessageInfo;
  stream: TMemoryStream;
  HTTPResult: integer;
  ClientCertStorage, ServerCertStorage:  TElMemoryCertStorage;
//  x: integer;
begin
  result := false;
  try
    Log('Sending Receipt to ' + URL,ltDetail);
    MessageInfo := TMessageInfo.NewInst(self.OutboundMessageFolder+'\History');
    MessageInfo.TryCount := MessageInfo.TryCount + 1;
    ASA2Client := TElAS2Client.Create(nil);
    ClientCertStorage := TElMemoryCertStorage.Create(ASA2Client);
    ServerCertStorage := TElMemoryCertStorage.Create(ASA2Client);
    stream := TMemoryStream.Create;
    try
      ASA2Client.SSL.ClientCertStorage := ClientCertStorage;
      ASA2Client.SSL.CertStorage := ServerCertStorage;
      self.LoadCertificates(ServerCertStorage,ClientCertStorage);
//      ClientCertStorage.SystemStores.Clear;
//	    ClientCertStorage.SystemStores.Add('ROOT');
      MessageInfo.Info.Values['URL'] := URL;
      ASA2Client.OnCertificateValidate := OnCertificateValidateEvent;
//      ASA2Client.OnCertificateChoose := DoOnCertificateChoose;
//      ASA2Client.OnCertificateNeededEx := DoOnCertificateNeededEx;
//      ASA2Client.OnCertificateStatus := DoOnCertificateStatus;
//      ASA2Client.OnCiphersNegotiated := DoOnCiphersNegotiated;
      ASA2Client.OnError := DoOnError;
//      ASA2Client.OnCloseConnection := DoOnCloseConnection;
//      ASA2Client.OnKeyNeeded := DoOnKeyNeeded;


//      https://www.eldos.com/forum/read.php?FID=7&TID=4501&MID=25140&sphrase_id=449434#message25140

//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_ID_RSA_ENCRYPTION] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_MD2_RSA_ENCRYPTION] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_MD5_RSA_ENCRYPTION] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_SHA1_RSA_ENCRYPTION] := true;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_ID_DSA] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_ID_DSA_SHA1] := true;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_DH_PUBLIC] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_SHA224_RSA_ENCRYPTION] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_SHA256_RSA_ENCRYPTION] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_SHA384_RSA_ENCRYPTION] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_SHA512_RSA_ENCRYPTION] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_ID_RSAPSS] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_ID_RSAOAEP] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_RSASIGNATURE_RIPEMD160] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_ID_ELGAMAL] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_SHA1_ECDSA] := true;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_RECOMMENDED_ECDSA] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_SHA224_ECDSA] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_SHA224_ECDSA] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_SHA256_ECDSA] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_SHA384_ECDSA] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_SHA512_ECDSA] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_EC] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_SPECIFIED_ECDSA] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_GOST_R3410_1994] := false;
//      ASA2Client.SSL.CipherSuites[SBConstants.SB_CERT_ALGORITHM_UNKNOWN] := false;



      Receipt.Save(stream);
      MessageInfo.AddDocument('Receipt',stream);
      stream.Position := 0;

      ASA2Client.Socks.Port := 443;

      Log('About to send Receipt',ltDetail);

      HTTPResult:= ASA2Client.SendReceipt(URL, stream);
      MessageInfo.Info.Values['Result']:= IntToStr(HTTPResult);
      if HTTPResult = 200 then begin
        result := true;
        Log('Receipt sent',ltDetail);
      end
      else begin
//        Log('Sending receipt to ' + URL + ' failed with return code ' + IntToStr(HTTPResult),ltError);
        Error('Sending receipt to ' + URL + ' failed with return code ' + IntToStr(HTTPResult),'',MessageInfo);
      end;

    finally
      ASA2Client.Free;
      stream.Free;
      MessageInfo.Save;
      MessageInfo.Free;
    end;
  except
    on e: exception do begin
//      Log('Error sending receipt to ' + URL + ': ' + e.Message,ltError);
      Error('Error sending receipt', 'Error sending receipt to ' + URL + ': ' + e.Message,MessageInfo);
    end;
  end;
end;

function TAS2Client.SendXMLDoc(const URL: string; DocStream: TStream; aMessageInfo: TMessageInfo = nil): boolean;
var
  AS2Message: TElAS2Message;
  AS2Client: TElAS2Client;
  OutStream: TMemoryStream;
  ReceiptStream: TStringStream;
  HTTPResult: integer;
  MessageInfo: TMessageInfo;
  Rcpt: TElAS2Receipt;
  ClientCertStorage, ServerCertStorage:  TElMemoryCertStorage;
  s: string;
  x: integer;
begin
  result := false;
  Log('Sending Document to ' + URL,ltDetail);
  if Assigned(aMessageInfo) then
    MessageInfo := aMessageInfo
  else
    MessageInfo := TMessageInfo.NewInst(self.OutboundMessageFolder+'\History');
  MessageInfo.TryCount := MessageInfo.TryCount + 1;
  AS2Message := TElAS2Message.Create(nil);
  AS2Client := TElAS2Client.Create(nil);
  ClientCertStorage := TElMemoryCertStorage.Create(AS2Client);
  ServerCertStorage := TElMemoryCertStorage.Create(AS2Client);
  try
    AS2Client.SSL.ClientCertStorage := ClientCertStorage;
    AS2Client.SSL.CertStorage := ServerCertStorage;
    self.LoadCertificates(ServerCertStorage,ClientCertStorage);
    MessageInfo.AddDocument('outbound.xml',DocStream);
    MessageInfo.Info.Values['URL'] := URL;
    AS2Client.OnCertificateValidate := OnCertificateValidateEvent;

    AS2Message.Version := as2Ver11;  { must be Ver1.1 }
    AS2Message.AS2From := self.AS2From;
    AS2Message.AS2To := self.AS2To;
    AS2Message.Subject := self.Subject;
    AS2Message.ContentType := 'application/xml';

    AS2Message.ReceiptRequest.Enabled := true; { request a Message Disposition Notification [MDN] }
    OutStream := TMemoryStream.Create;
    ReceiptStream := TStringStream.Create;
    try
      DocStream.Position := 0;
      AS2Message.Save(DocStream,OutStream);
      OutStream.Position := 0;
      try
        HTTPResult := AS2Client.Send(URL,OutStream,ReceiptStream);
      except
        on e: exception do begin
          Error('Sending message to ' + URL + ' failed with message: ' + e.Message,'',MessageInfo);
          exit;
        end;
      end;
      if HTTPResult = 200 then begin
        result := true;
        MessageInfo.Info.Values['Result']:= IntToStr(HTTPResult);
        MessageInfo.AddDocument('Receipt.txt',ReceiptStream);
        ReceiptStream.Position:= 0;
        if (ReceiptStream.Size > 0) and (Pos('disposition-notification',ReceiptStream.DataString) > 0) then begin

          Rcpt := TElAS2Receipt.Create(nil);
          try
            try
              Rcpt.Load(ReceiptStream);
              MessageInfo.Info.Values['Receipt'] := Rcpt.Text;
              Log('Received Receipt: ' + Rcpt.Text,ltDetail);
              if Rcpt.Errors.Status <> dsProcessed then begin
                { error receiving or processing our invoice }
                result := false;
                for x := 0 to Rcpt.Errors.Count -1 do begin
                  if x > 0 then s := s + #13#10;
                  case Rcpt.Errors.Items[x].Modifier of
                    dmWarning: s:= s + 'Warning ';
                    dmError: s:= s + 'Error ';
                    dmFailure: s:= s + 'Failure ';
                  end;
                  s := s + IntToStr(Rcpt.Errors.Items[x].Code) + ' ' +
                    Rcpt.Errors.Items[x].Description;
                end;
                Error('Sending message to ' + URL + ' failed with MDN receipt error.',s,MessageInfo);
                exit;
              end;
            except
              on e: exception do begin
                result := false;
                Error('Error loading receipt: ' + e.Message,'',MessageInfo);
              end;
            end;
          finally
            Rcpt.Free;
          end;

        end
        else begin
          Log('No MDN received',ltDetail);
        end;
      end
      else begin
        MessageInfo.Info.Values['Result']:= IntToStr(HTTPResult);
        Error('Sending message to ' + URL + ' failed with return code ' + IntToStr(HTTPResult),'',MessageInfo);
      end;

    finally
      OutStream.Free;
      ReceiptStream.Free;
    end;
  finally
    AS2Message.Free;
    AS2Client.Free;
    MessageInfo.Save;
    if not Assigned(aMessageInfo) then
      MessageInfo.Free;
  end;
end;

procedure TAS2Client.SetAS2From(const Value: string);
begin
  FAS2From := Value;
end;

procedure TAS2Client.SetAS2To(const Value: string);
begin
  FAS2To := Value;
end;

procedure TAS2Client.SetOutboundMessageFolder(const Value: string);
begin
  FOutboundMessageFolder := Value;
end;

procedure TAS2Client.SetSubject(const Value: string);
begin
  FSubject := Value;
end;

initialization
  msxmldom.MSXML6_ProhibitDTD:= false;


end.
