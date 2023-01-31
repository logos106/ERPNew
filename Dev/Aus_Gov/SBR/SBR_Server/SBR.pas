namespace SBR_Server;

interface

uses
  System.Collections.Generic,
  System.Linq,
  System.Net,
  System.Text,
  System.Security,
  System.Security.Cryptography.X509Certificates,
  System.IO,
  System.Xml,
  System.Reflection,
  Newtonsoft.Json.Linq,
  Abr.AuskeyManager.KeyStore,
  Abr.SecurityTokenManager,
  Abr.AuskeyManager,
  Sbr.Core.Services.Requester,
  Sbr.Core.Services,
  Sbr.Core.Services.Model;

type

  SBR = public class
  private
    fCompany, 
    fSoftware,
    fVersion: String;
    class var instance: SBR := nil;
    class var padlock: Object := new Object();
    class method getInstance: SBR;
    method MakeError(desc: String): String;
    method MakeOk(): String;
    method MakeOk(DataJson: JObject): String;
    method GetKeyStore(aFileName: String): AbrKeyStore;
    method GetPrivateKey(keyStore: AbrKeyStore; keyAlias: String; password: SecureString): X509Certificate2;
    method InitSoftwareInfo;
    method ResponseToJson(res: IResponse): JObject;
    method GetSoftwareInformation: SoftwareInformationType;
    method GetSecurityToken(appliesTo: String; clientCertificate: X509Certificate2): SecurityToken;
  public
    constructor;
    class property Inst: SBR read getInstance;
    class method DoWebRequest(req: HttpListenerRequest): String;
    method WebRequest(req: HttpListenerRequest): String;
    method ValidatePassword(KeyStoreFile, KeyStoreID, KeyStorePass: String; var msg: String): Boolean;
    method GetKeyStoreData(KeyStoreFile: String): JObject;
    method DoRequest(aCoreService: Integer; aAency, aServiceEndPoint, aMessageType, aKeyStoreFile, aKeyStoreId, aKeyStorePass: String; aDocList: JArray): JObject;

  end;

implementation

class method SBR.getInstance: SBR;
begin
  locking padlock do begin
    if instance = nil then begin
      instance := new SBR();
    end;
    exit instance;
  end;
end;

constructor SBR;
begin
  //fCompany := 'TrueERP Software'; 
  fCompany := AssemblyCompanyAttribute(Attribute.GetCustomAttribute(&Assembly.GetExecutingAssembly(), typeOf(AssemblyCompanyAttribute), false)).Company;  
  //fSoftware := 'TrueERP';
  fSoftware := AssemblyProductAttribute(Attribute.GetCustomAttribute(&Assembly.GetExecutingAssembly(), typeOf(AssemblyProductAttribute), false)).Product;  
  //fVersion := '2018.0.0.0';
  fVersion := &Assembly.GetExecutingAssembly().GetName().Version.ToString(); 
  // AssemblyFileVersionAttribute(Attribute.GetCustomAttribute(&Assembly.GetExecutingAssembly(), typeOf(AssemblyFileVersionAttribute), false)).Version;  
end;

class method SBR.DoWebRequest(req: HttpListenerRequest): String;
begin
  result := SBR.Inst.WebRequest(req);
end;

(*
{
  "Command":"DoRequest",
  "CoreService":0,
  "Agency":"ato.gov.au",
  "ServiceEndPoint":"https://test.sbr.gov.au/services/list.02.service",
  "MessageType":"message.ping",
  "KeyStoreFileName":"C:\\Users\\user\\AppData\\Roaming\\AUSkey\\keystore.xml",
  "KeyStoreID":"ABRD:11000002568_INGLETON153",
  "KeyStorePass":"Password1!",
  "DocumentList":[
    "<xbrli:xbrl xmlns:xbrli= \"http:\/\/www.xbrl.org\/2003\/instance\" xmlns:link= \"http:\/\/www.xbrl.org\/2003\/linkbase\" xmlns:xlink= \"http:\/\/www.w3.org\/1999\/xlink\"><link:schemaRef xlink:type= \"simple\" xlink:href= \"http:\/\/sbr.gov.au\/taxonomy\/sbr_au_reports\/\" \/>Simple xbrl instance for ping testing. Anything can go in here for a ping...<\/xbrli:xbrl>"
  ]  
} 

{
  "Command":"ValidatePassword",
  "KeyStoreFile":"C:\\Users\\user\\AppData\\Roaming\\AUSkey\\keystore.xml",
  "KeyStoreID":"ABRD:11000002568_INGLETON153",
  "KeyStorePass":"Password1!"
}  

{
  "Command":"TErminate"
}  

 
*)


method SBR.WebRequest(req: HttpListenerRequest): String;
begin
  if req.HttpMethod = 'POST' then begin
    var body: System.IO.Stream := req.InputStream;
    var encoding: System.Text.Encoding := req.ContentEncoding;
    var reader: System.IO.StreamReader := new System.IO.StreamReader(body, encoding);
    if req.ContentType ≠ nil then begin
        Logger.Log('Client data content type '+ req.ContentType, 'Detail');
    end;
    Logger.Log('Client data content length '+ req.ContentLength64, 'Detail');

    var s: String := reader.ReadToEnd();
    Logger.Log('Request: ' + s,'Detail');
    //Logger.Log(s,'Detail');
    
    try
      var jo := JObject.Parse(s);
      case jo['Command'].ToString.ToLower of
        'terminate': result := 'Terminating';
        'getkeystoredata': result := MakeOk( GetKeyStoreData(jo['KeyStoreFileName'].ToString));
        'validatepassword': 
          begin
            var msg: String;
            var aKeyStoreFileName: String;
            var aKeyStoreID: String;
            var aKeyStorePass: String;
            try aKeyStoreFileName := String(jo['KeyStoreFileName']); except on e: Exception do raise new Exception('KeyStoreFileName ' + e.Message); end;
            try aKeyStoreID := String(jo['KeyStoreID']); except on e: Exception do raise new Exception('KeyStoreID ' + e.Message); end;
            try aKeyStorePass := String(jo['KeyStorePass']); except on e: Exception do raise new Exception('KeyStorePass ' + e.Message); end;
            if ValidatePassword(
              aKeyStoreFileName,
              aKeyStoreID,
              aKeyStorePass,
              var msg) 
            then result := MakeOk()
            else result := MakeError(msg);
          end;
        'dorequest':
          begin
            var CoreService: Integer;
            var ServiceEndPoint: String;
            var Agency: String;
            var MessageType: String;
            var KeyStoreFileName: String;
            var KeyStoreID: String;
            var KeyStorePass: String;
            var DocumentList: JArray;
            try CoreService := Integer(jo['CoreService']); except on e: Exception do raise new Exception('CoreService ' + e.Message); end;
            try Agency := String(jo['Agency']); except on e: Exception do raise new Exception('Agency ' + e.Message); end;
            try ServiceEndPoint := String(jo['ServiceEndPoint']); except on e: Exception do raise new Exception('ServiceEndPoint ' + e.Message); end;
            try MessageType := String(jo['MessageType']); except on e: Exception do raise new Exception('MessageType ' + e.Message); end;
            try KeyStoreFileName := String(jo['KeyStoreFileName']); except on e: Exception do raise new Exception('KeyStoreFileName ' + e.Message); end;
            try KeyStoreID := String(jo['KeyStoreID']); except on e: Exception do raise new Exception('KeyStoreID ' + e.Message); end;
            try KeyStorePass := String(jo['KeyStorePass']); except on e: Exception do raise new Exception('KeyStorePass ' + e.Message); end;
            try DocumentList := JArray(jo['DocumentList']); except on e: Exception do raise new Exception('DocumentList ' + e.Message); end;
            var res: JObject := DoRequest(
              CoreService,
              Agency,
              ServiceEndPoint,
              MessageType,
              KeyStoreFileName,
              KeyStoreID,
              KeyStorePass,
              DocumentList);
            result := MakeOk(res);
          end;
        else
          result := MakeError('Unknown Web Request: ' +  s);
      end;
    except
      on e: Exception do begin
        Logger.Log('Exception: ' + e.ToString, 'Error');
        result := MakeError(e.Message);
        exit;
      end;
    end;
    
    body.Close();
    reader.Close();
  end;
  Logger.Log('WebRequest result: ' + result,'Detail');
end;

method SBR.MakeError(&desc: String): String;
begin
 var jo: JObject := new JObject;
 jo.Add('Result', new JValue('Error'));
 jo.Add('Description', new JValue(&desc));
 result := jo.ToString;
end;

method SBR.ValidatePassword(KeyStoreFile: String; KeyStoreID: String; KeyStorePass: String; var msg: String): Boolean;
begin
  result := true;
  try
    var keyPassword: SecureString := new SecureString();
    for each c: Char in KeyStorePass do
      keyPassword.AppendChar(c);
  
    var keyStore: AbrKeyStore := GetKeyStore(KeyStoreFile);
    result := assigned(GetPrivateKey(keyStore,KeyStoreID,keyPassword));
  except
    on e: Exception do begin
      result := false;
      if e.Message.Contains('Password is invalid') then
        msg := 'Password is invalid'
      else
        msg := e.Message;
    end;
  end;

end;

method SBR.GetKeyStore(aFileName: String): AbrKeyStore;
begin
  if not File.Exists(aFileName) then begin
    raise new Exception('Could not find Key File');
  end;
  try
    //AbrProperties.SetSoftwareInfo(fCompany,fSoftware,fVersion, DateTime.Now.ToString());  
    InitSoftwareInfo;
    using fs := File.OpenRead(aFileName) do begin
      exit new AbrKeyStore(fs);
    end;
  except
    on e: Exception do begin
      Logger.Log('GetKeyStore - Exception: ' + e.Message,'Error');
      raise;
    end;
  end;

end;

method SBR.GetPrivateKey(keyStore: AbrKeyStore; keyAlias: String; password: SecureString): X509Certificate2;
begin
  var cr: AbrCredential := keyStore.GetCredential(keyAlias);
  if cr.IsReadyForRenewal() then begin
    //  Must check for renewal but don't have to actually do it
    //  If renewing it's best to do on a background thread
    // cr.Renew(keystorePassword);
  end;
  var privateKey: X509Certificate2 := cr.PrivateKey(password, X509KeyStorageFlags.DefaultKeySet);
  exit privateKey;
end;

method SBR.GetKeyStoreData(KeyStoreFile: String): JObject;
begin
  InitSoftwareInfo;
  var keyStore: Abr.AuskeyManager.KeyStore.AbrKeyStore := GetKeyStore(KeyStoreFile);
  var jo: JObject := new JObject;
  var arr: JArray := new JArray;
  for cr in keyStore.GetCredentials do begin
    var subJo: JObject := new JObject;
    subJo.Add('legalName',new JValue(cr.LegalName));
    subJo.Add('id',new JValue(cr.Id));
    subJo.Add('IsExpired',new JValue(cr.IsExpired));
    arr.Add(subJo);
  end;
  jo.Add('credentials',arr);
  result := jo;
end;

method SBR.InitSoftwareInfo;
begin
  Abr.AuskeyManager.KeyStore.AbrProperties.SetSoftwareInfo(fCompany,fSoftware,fVersion,'');
end;

method SBR.MakeOk: String;
begin
  var jo: JObject := new JObject;
  jo.Add('Result', new JValue('ok'));
  result := jo.ToString;
end;

method SBR.ResponseToJson(res: IResponse): JObject;
begin
  var jo: JObject:= new JObject; 

  if assigned(res) then begin
    for busdoc in res.BusinessDocuments do 
      Logger.Log(busdoc.ToString);

    var messageEvent: JObject:= new JObject;
    jo.Add('MessageEvent',messageEvent);
    messageEvent.Add('MessageEventMaximumSeverityCode', new JValue(res.MessageEvent.MessageEventMaximumSeverityCode.ToString));
    var MessageEventItemArr: JArray:= new JArray;
    for each mei: MessageEventItemType in res.MessageEvent.MessageEventItems do begin
      var o: JObject := new JObject;
      o.Add('MessageEventItemErrorCode', new JValue(mei.MessageEventItemErrorCode));
      try o.Add('MessageEventItemSeverityCode', new JValue(mei.MessageEventItemSeverityCode.ToString)); except end;
      o.Add('MessageEventItemShortDescription', new JValue(mei.MessageEventItemShortDescription));
      MessageEventItemArr.Add(o);
    end;
    messageEvent.Add('MessageEventItems',MessageEventItemArr);

    var TimeStampsArr: JArray := new JArray;
    for each timestamp: MessageTimestampType in res.Timestamps do begin
      var o: JObject := new JObject;
      o.Add('MessageTimestampGenerationSourceCode', new JValue(timestamp.MessageTimestampGenerationSourceCode.ToString()));
      o.Add('MessageTimestampGenerationDatetime', new JValue(timestamp.MessageTimestampGenerationDatetime.ToString('yyyy-MM-dd hh:mm:ss')));
      TimeStampsArr.Add(o);
    end;
    jo.Add('Timestamps',TimeStampsArr);

    if assigned(res.LodgementReceipt) then begin
      var LogmentReceipt: JObject := new JObject;
      LogmentReceipt.Add('LodgementReceiptItentifier',res.LodgementReceipt.LodgementReceiptIdentifier);
      LogmentReceipt.Add('LodgementReceiptDatetime',res.LodgementReceipt.LodgementReceiptDatetime.ToString('yyyy-MM-dd hh:mm:ss'));
      LogmentReceipt.Add('LodgementReceiptDatetimeSpecified',res.LodgementReceipt.LodgementReceiptDatetimeSpecified);

      jo.Add('LogmentReceipt',LogmentReceipt);
    end;
    jo.Add('Sender',res.Sender);


  end;
  result := jo;
end;

method SBR.DoRequest(
  aCoreService: Integer; 
  aAency: String; 
  aServiceEndPoint: String; 
  aMessageType: String; 
  aKeyStoreFile: String; 
  aKeyStoreId: String; 
  aKeyStorePass: String; 
  aDocList: JArray): JObject;
begin
  var keyPassword: SecureString := new SecureString();
  for each c: Char in aKeyStorePass do
    keyPassword.AppendChar(c);
  var keyStore: AbrKeyStore := GetKeyStore(aKeyStoreFile);
  var privateKey: X509Certificate2 := GetPrivateKey(keyStore,aKeyStoreId,keyPassword);
  var factory: SBRCoreServicesRequestFactory := new SBRCoreServicesRequestFactory(GetSoftwareInformation);
  factory.DefaultBusinessCertificate := privateKey;
  //ServiceType.
  var request: IRequest := factory.CreateRequest(ServiceType(aCoreService), aAency, aMessageType, aServiceEndPoint);
  var securityToken: SecurityToken := GetSecurityToken(aServiceEndPoint, privateKey);
  // add documents if we have them ..
  if assigned(aDocList) then begin
    for item in aDocList do begin
      
        var xbrlSMPDoc: XmlDocument := new XmlDocument();
        var s: String := item.ToString;
        xbrlSMPDoc.LoadXml(s);
        request.AddBusinessDocument(xbrlSMPDoc.DocumentElement, DateTime.Now);
    end;
  end;
  var response: IResponse := request.GetResponse(securityToken.AssertionAsXML, securityToken.ProofTokenAsString, securityToken.Expires);
  result := ResponseToJson(response);

end;

method SBR.GetSoftwareInformation: SoftwareInformationType;
begin
  var swInfo: SoftwareInformationType := new SoftwareInformationType();
  swInfo.OrganisationNameDetailsOrganisationalNameText := fCompany;
  swInfo.SoftwareInformationProductNameText := fSoftware ;
  swInfo.SoftwareInformationProductVersionText := fVersion;
  exit swInfo;
end;

method SBR.GetSecurityToken(appliesTo: String; clientCertificate: X509Certificate2): SecurityToken;
begin
  //  In this sample the ABR STM configuration settings are in the app.config file.
  //              * They can also be set programmatically.
  //              * 
  var additionalClaims: String := '';
  var stm: SecurityTokenManager := new SecurityTokenManager();
  
  try
    exit stm.GetSecurityIdentityToken(appliesTo, additionalClaims, clientCertificate);
  except
    on e: Exception do begin
      Logger.Log('GetSecurityToken - Exception: ' + e.Message, 'Error');
      raise;
    end;
  end;

end;

method SBR.MakeOk(DataJson: JObject): String;
begin
  var jo: JObject := new JObject;
  jo.Add('Result', new JValue('ok'));
  jo.Add('Data', DataJson);
  result := jo.ToString;

end;

end.
