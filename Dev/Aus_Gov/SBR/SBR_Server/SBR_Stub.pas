unit SBR_Stub;

interface

uses
//  CNClrLib.Host,
//  CNClrLib.Host.Helper,
//  CNClrLib.Core,
//  CNClrLib.Enums,
//  CNClrLib.Core.Intf,
  XMLIntf,
  JsonObject,
  IdHttp;

type
  TSBR = class(TObject)
  private
    fKeyStoreFileName: string;
    Client: TIdHttp;
    fServerPort: integer;
//    function GetKeyStoreData: TJsonObject;
//    SBR: _ClrObject;
//    ClrHost: TClrHost;
//    AAsm: _Assembly;
//    domain: TClrAppDomain;

//    function GetKeyStoreName: string;
//    procedure SetKeyStoreName(const Value: string);
//    function GetKeystoreData: string;
    function GetServerPort: integer;
    function SendCommand(const aCommand: string; Data: TJsonObject = nil): TJsonObject;
//    function GetKeyStoreDataStr: string;
  protected
    property ServerPort: integer read GetServerPort;
  public
    constructor Create;
    destructor Destroy; override;
    property KeyStoreFileName: string read fKeyStoreFileName write fKeyStoreFileName;
//    property KeyStoreData: TJsonObject read GetKeyStoreData;
//    property KeyStoreDataStr: string read GetKeyStoreDataStr;
    function ValidatePassword(aKeyStoreFileName, aKeyStoreID, aKeyStorePass: string; var msg: string): boolean; overload;
    function ValidatePassword(aKeyStoreID, aKeyStorePass: string; var msg: string): boolean; overload;
    function GetKeyStoreData(aKeyStoreFileName: string = ''): TJsonObject;
//    function GetKeyStoreDataStr(aKeyStoreFileName: string = ''): string;
//    procedure AddBusinessDocument(aDoc: String);
//    function DoRequest(aCoreService, agency, aServiceEndPoint, aMessageType, keyStoreId, keyStorePass: String; documentList: IXMLNodeList): string;
    function DoRequest(aCoreService: Integer; aAgency, aServiceEndPoint, aMessageType, aKeyStoreFileName, aKeyStoreID, aKeyStorePass: String; aDocumentList: IXMLNodeList): TJSONObject; overload;
    function DoRequest(aCoreService: Integer; aAgency, aServiceEndPoint, aMessageType, aKeyStoreFileName, aKeyStoreID, aKeyStorePass: String; aDocumentList: TJsonArray): TJSONObject; overload;
    function DoRequest(aCoreService: Integer; aAgency, aServiceEndPoint, aMessageType, aKeyStoreFileName, aKeyStoreID, aKeyStorePass: String; aDocument: string = ''): TJSONObject; overload;
  end;

const
  ServiceType_List = 0;
  ServiceType_Lodge = 1;
  ServiceType_Prefil = 2;
  ServiceType_Prelodge = 3;

implementation

uses
  ModuleFileNameUtils, SysUtils, SystemLib, classes,
  XMLDoc, ActiveX;

var
  inst: TSBR;

{ TSBR }

//procedure TSBR.AddBusinessDocument(aDoc: String);
//var
//  objectArray: _ObjectArray;
//begin
//  objectArray := CoObjectArray.CreateInstance(1);
//  objectArray[0] := aDoc;
//
//  SBR.InvokeMethod_1('AddBusinessDocument','System.string',objectArray);
//end;
//
//procedure TSBR.ClearBusinessDocumentList;
//begin
//  SBR.InvokeMethod('ClearBusinessDocumentList');
//end;

constructor TSBR.Create;
var
  binPath: string;
//  SBRType: _Type;
//  domainInfo: _AppDomainSetup;
begin
  fServerPort := 0;
  Client := nil;
  binPath := GetCurrentModulePath + 'bin\';
  if FileExists(binPath + 'SBR_Server.exe') then begin
    if not ProcessExists('SBR_Server.exe') then
      ExecNewProcess(binPath + 'SBR_Server.exe',false);
    Client := TIdHttp.Create;
    Client.Request.ContentType := 'application/json';

  end
  else begin
    raise Exception.Create('Could not find the SBR Server file: ' + binPath + 'SBR_Server.exe');

  end;


//
//
//  if FileExists(binPath + 'TrueERP_SBR.dll') then begin
////    domaininfo := CoAppDomainSetup.CreateInstance;
////    domaininfo.ApplicationBase := binPath;
////    domaininfo.ConfigurationFile := binPath + 'TrueERP_SBR.dll.config';
//
//    // Create the application domain.
////    domain := TClrAppDomain(TClrAppDomain.CreateDomain('TrueERP_SBR', nil, domaininfo));
//    ClrHost := TClrHost.GetDefault;
//    AAsm := TClrAssembly.LoadFrom(binPath + 'TrueERP_SBR.dll');
//    SBRType := TClrAssembly.GetType('TrueERP_SBR.SBR');
//    SBR := CoClrObject.CreateInstance(SBRType, nil);
////    KeyStoreName := GetLocalAppDataDir + 'keystore.xml';
//
//  end
//  else
//    raise Exception.Create(ClassName + ' - ' + binPath + 'TrueERP_SBR.dll not found');
//
//
end;

destructor TSBR.Destroy;
begin
//  try
//    SendCommand('Terminate');
//  except
//    //
//  end;
  TThread.CreateAnonymousThread(
    procedure
    var
      http: TIdHttp;
      stream: TStringStream;
    begin
      http := TIdHttp.Create(nil);
      stream := TStringStream.Create;
      try
        stream.Create('{"Command":"Terminate"}');
        try
          http.Post('http://localhost:' + IntToStr(ServerPort) + '/SBR', stream);
        except
        end;
      finally
        http.Free;
        stream.Free;
      end;

    end
  ).Start;
  Client.Free;
  inherited;
end;

function TSBR.DoRequest(aCoreService: Integer; aAgency, aServiceEndPoint,
  aMessageType, aKeyStoreFileName, aKeyStoreID, aKeyStorePass,
  aDocument: string): TJSONObject;
var
  DocList: TJsonArray;
begin
  DocList := TJsonArray.Create;
  try
    if aDocument <> '' then
      DocList.Add(aDocument);
    result :=
      DoRequest(aCoreService, aAgency, aServiceEndPoint, aMessageType,
        aKeyStoreFileName, aKeyStoreID, aKeyStorePass, DocList);
  finally
    DocList.Free;
  end;
end;

function TSBR.DoRequest(aCoreService: Integer; aAgency, aServiceEndPoint,
  aMessageType, aKeyStoreFileName, aKeyStoreID, aKeyStorePass: String;
  aDocumentList: TJsonArray): TJSONObject;
var
  j: TJsonObject;
  x: integer;
begin
  j := JO;
  try
    j.I['CoreService'] := aCoreService;
    j.S['Agency'] := aAgency;
    j.S['ServiceEndPoint'] := aServiceEndPoint;
    j.S['MessageType'] := aMessageType;
    j.S['KeyStoreFileName'] := aKeyStoreFileName;
    j.S['KeyStoreID'] := aKeyStoreID;
    j.S['KeyStorePass'] := aKeyStorePass;
    j.A['DocumentList'].Assign(aDocumentList);
    result := self.SendCommand('DoRequest',j)
  finally
    j.Free;
  end;
end;

function TSBR.DoRequest(aCoreService: Integer; aAgency, aServiceEndPoint,
  aMessageType, aKeyStoreFileName, aKeyStoreID, aKeyStorePass: String;
  aDocumentList: IXMLNodeList): TJSONObject;
var
  x: integer;
  DocList: TJsonArray;
begin
  DocList := TJsonArray.Create;
  try
    for x:= 0 to aDocumentList.Count -1 do begin
      DocList.Add(aDocumentList[x].XML)
    end;
    result :=
      DoRequest(aCoreService, aAgency, aServiceEndPoint, aMessageType,
        aKeyStoreFileName, aKeyStoreID, aKeyStorePass, DocList);
  finally
    DocList.Free;
  end;
end;

function TSBR.GetKeyStoreData(aKeyStoreFileName: string): TJsonObject;
var
  j: TJsonObject;
begin
  j := JO;
  try
    if aKeyStoreFileName <> '' then
      j.S['KeyStoreFileName'] := aKeyStoreFileName
    else
      j.S['KeyStoreFileName'] := self.KeyStoreFileName;
    result := self.SendCommand('GetKeyStoreData',j);
  finally
    j.Free;
  end;

end;

//function TSBR.GetKeyStoreDataStr(aKeyStoreFileName: string): string;
//begin
//  with GetKeyStoreData(aKeyStoreFileName) do begin
//    result := AsString;
//    Free;
//  end;
//end;

function TSBR.GetServerPort: integer;
var
  doc: IXmlDocument;
  appSettings: IXMLNode;
  x: Integer;
  setting: IXMLNode;
begin
  if fServerPort = 0 then begin
    fServerPort := 8080; // default
    doc := TXmlDocument.Create(nil);
    try
      //doc.Active := true;
      CoInitialize(nil);
      try
        doc.LoadFromFile(GetCurrentModulePath + 'bin\SBR_Server.exe.config');
        doc.Options := doc.Options - [doAttrNull];
        appSettings := doc.DocumentElement.ChildNodes.FindNode('appSettings');
        for x := 0 to appSettings.ChildNodes.Count -1 do begin
          setting := appSettings.ChildNodes[x];
          if SameText(setting.NodeName,'add') then begin
            if setting.Attributes['Server.Port'] <> '' then begin
              fServerPort := StrToInt(setting.Attributes['Server.Port']);
              exit;
            end;
          end;
        end;
      finally
        CoUninitialize();
      end;
    finally
      doc := nil;
    end;
  end;

  result := fServerPort;
end;

function TSBR.SendCommand(const aCommand: string;
  Data: TJsonObject): TJsonObject;
var
  j: TJsonObject;
//  resJ: TJsonObject;
  s: string;
  stream: TMemoryStream;
begin
  result := JO;
//  resJ := JO;
  j := JO;
  stream := TMemoryStream.Create;
  try
    if Assigned(Data) then
      j.Assign(Data);
    j.S['Command'] := aCommand;
    j.SaveToStream(stream);
    s := Client.Post('http://localhost:' + IntToStr(ServerPort) + '/SBR', stream);
    result.AsString := s;

//    resJ.AsString := s;
//    if SameText(resJ.S['Result'],'ok') then begin
//      if resJ.ObjectExists('Data') then
//        result.Assign(resJ.O['Data']);
//
//    end
//    else begin
//      if resJ.S['Description'] <> '' then
//        raise Exception.Create(resJ.S['Description'])
//      else
//        raise Exception.Create('Error sending command');
//    end;

  finally
    j.Free;
//    resJ.Free;
    stream.Free;
  end;

end;

function TSBR.ValidatePassword(aKeyStoreID, aKeyStorePass: string;
  var msg: string): boolean;
begin
  result := ValidatePassword(KeyStoreFileName,aKeyStoreID, aKeyStorePass,msg);
end;

function TSBR.ValidatePassword(aKeyStoreFileName, aKeyStoreID,
  aKeyStorePass: string; var msg: string): boolean;
var
  res, j: TJsonObject;
begin
  result := true;
  res := nil;
  j := JO;
  try
    j.S['KeyStoreFileName'] := aKeyStoreFileName;
    j.S['KeyStoreID'] := aKeyStoreID;
    j.S['KeyStorePass'] := aKeyStorePass;
    try
      res := self.SendCommand('ValidatePassword', j);
      if not SameText(res.S['Result'], 'ok') then begin
        result := false;
        if res.S['Description'] <> '' then
          msg := res.S['Description']
        else
          msg := 'Error validating password';
      end;
    except
      on e: exception do begin
        result := false;
        msg := e.Message;
      end;

    end;

  finally
    res.Free;
    j.Free;
  end;

end;

//function TSBR.DoRequest(aCoreService, agency, aServiceEndPoint, aMessageType,
//  keyStoreId, keyStorePass: String; documentList: IXMLNodeList): string;
//var
//  x: integer;
//  objectArray: _ObjectArray;
//begin
//  result := '';
//  ClearBusinessDocumentList;
//  { first add the documents we want to send .. }
//  for x := 0 to documentList.Count -1 do begin
//    self.AddBusinessDocument(documentList[x].XML);
//  end;
//  objectArray := CoObjectArray.CreateInstance(6);
//  objectArray[0] := aCoreService;
//  objectArray[1] := agency;
//  objectArray[2] := aServiceEndPoint;
//  objectArray[3] := aMessageType;
//  objectArray[4] := keyStoreId;
//  objectArray[5] := keyStorePass;
//
//  result := SBR.InvokeMethod_1(
//    'DoRequest',
//    'System.string;System.string;System.string;System.string;System.string;System.string',
//    objectArray);
//
//end;

//function TSBR.GetKeyStoreName: string;
//begin
//  result := SBR.GetPropertyValue('KeyStoreName');
//end;
//
//function TSBR.GetKeyStoreData: string;
//begin
//  result := SBR.GetPropertyValue('KeyStoreData');
//end;
//
//procedure TSBR.SetKeyStoreName(const Value: string);
//begin
//  SBR.SetPropertyValue('KeyStoreName', Value);
//end;

//function TSBR.ValidatePassword(id, password: string): boolean;
//var
////  cArray: TClrArray;
//  objectArray: _ObjectArray;
//begin
////  cArray := TClrArray.Create('System.string',2);
////  cArray.Item[0] := id;
////  cArray.Item[1] := password;
//  objectArray := CoObjectArray.CreateInstance(2);
//  objectArray[0] := id;
//  objectArray[1] := password;
//
//  //result := SBR.InvokeMethod_1('ValidatePassword','System.string;System.string',[id,password]);
//  try
//    result := SBR.InvokeMethod_1('ValidatePassword','System.string;System.string',objectArray);
//  except
//    on e: exception do begin
//      result := false;
//    end;
//  end;
//end;

initialization
//  inst := TSBR.Create;

finalization
//  inst.Free;


end.
