unit RosettaNetConectorObj;

interface

{$I Connector.inc}
uses
  ConnectorBaseObj, LogThreadBase, LogMessageTypes,
  //IdHttpServer,
  IdContext, IdCustomHTTPServer,
  SysUtils, Classes,
  XMLIntf, IdURI, WebAPIClientObj, Contnrs, JsonObject, ERPWebApiObj,
  MessageInfoObj, {datServer,} AS2ClientObj, AS2ServerObj;


type

  TTimerThread = class;


  TRosettaNetConnector = class(TConnectorBase)
  private
//    ClientServer: TIdHttpServer;
//    Server: TdmServer;
    AS2Server: TAS2Server;
    AS2Client: TAS2Client;
    fCheckERPSettingsOk: boolean;
//    fWebAPIConfigStr: string;
    fNextInvoiceCheckTime: TDateTime;
    fNextERPCheckTime: TDateTime;
    ERP: TERPWebApi;
    TimerThread: TTimerThread;
//    procedure DoOnCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
//    procedure DoOnConnect(AContext: TIdContext);
//    procedure DoOnDisconnect(AContext: TIdContext);
//    procedure DoServerThreadException(AContext:TIdContext; AException: Exception);
    function ProcessXMLRequest(DocStream: TStream; MessageInfo: TMessageInfo): boolean;
    function RoseettaNetConfigPage(msg: string = ''): string;
    function TestEmailConfig(var msg: string): boolean;
    procedure EmailAdmin(aSubject: string; aBody: TStrings);
    function CreatePip3A4PurchaseOrderConfirmation(Doc: IXMLDocument; SaleId: integer; var msg: string): IXMLDocument;
//    function GetCompanyInfo(var Obj: TJsonObject; var msg: string): boolean;
    procedure Error(const aError, aDetail: string; MessageInfo: TMessageInfo = nil);
//    function CheckERPSettings(var msg: string): boolean;
    procedure CheckForInvoices;
    procedure CheckForMessages;
    procedure SendInvoice(const InvId: integer);
    procedure CheckRosettaNetSalesCategoryExists;
//    function PartnerPage: string;
  protected
    function SetConfigDefaults: boolean; override;
    function DoPage(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo; URI: TIdURI): boolean; override;
  public
    constructor Create(aLogger: TLoggerBase); override;
    destructor Destroy; override;
    procedure DoOnTimer;
  end;

  TTimerThread = class(TThread)
  private
    fCount: integer;
  protected
  public
    Connector: TRosettaNetConnector;
    procedure Execute; override;
    constructor Create(CreateSuspended: boolean);
  end;

implementation

uses
  IdSSLOpenSSL, IdSSL, ModuleFileNameUtils, XMLDoc, msxmldom, ActiveX,
  JsonXmlMappingObj, Mappings, XMLHelperUtils, Variants, IdSMTP, IdMessage,
  JsonObjectUtils, StrUtils, DateTimeUtils,
  CountryCodeObj, idCoderMIME,
  SBASUtils, SBAS2, SBASCommon, SBUTILS, IOUtils, Windows, RosettaNetUtils,
  StringUtils, IdAttachment, IdAttachmentMemory, FileVersion;

const
  SalesCategory_RosettaNet = 'RosettaNet';
  Retry_Count = 5;

{ RosettaNetConector }

procedure TRosettaNetConnector.CheckForMessages;
var
  sr: TSearchRec;
  FileAttrs: Integer;
  sl: TStringList;
  I: Integer;
  dir: string;
  stream: TStringStream;
  fileStream: TFileStream;
  MessageInfo: TMessageInfo;
  MessageInfoPath: string;
  inf: TStringList;
begin
  {###################################################}
//  exit;
  {###################################################}

 FileAttrs := 0;
 dir := AS2Server.InboundMessageFolder + '\';
 if SysUtils.FindFirst(dir + '*.bin',FileAttrs, sr) = 0 then begin
   sl:= TStringList.Create;
   stream := TStringStream.Create;
   try
     repeat
       sl.Add(sr.Name);
       Log('Found file ' + sr.Name, ltDetail);
     until FindNext(sr) <> 0;
     SysUtils.FindClose(sr);
     for I := 0 to sl.Count -1 do begin
       stream.Clear;
       MessageInfo:= nil;
       MessageInfoPath := dir + 'History\' + Copy(StringReplace(sl[I],ExtractFileExt(sl[I]),'',[]),9,255);
       ForceDirectories(MessageInfoPath);
       if DirectoryExists(MessageInfoPath) then
         MessageInfo := TMessageInfo.Create(MessageInfoPath);
       try
         try
           stream.LoadFromFile(dir + sl[I]);
         except
           on e:exception do begin
             Error('Error loading message file "' + dir + sl[I] + '"',e.message,MessageInfo);
             continue;
           end;
         end;
         try
//           Log('here');
           if FileExists(ChangeFileExt(dir + sl[I],'.mdn')) then begin
             try
               MessageInfo.Receipt := TElAS2Receipt.Create(nil);
               fileStream := TFileStream.Create(ChangeFileExt(dir + sl[I],'.mdn'), fmOpenRead);
               try
                 try
                  TElAS2Receipt(MessageInfo.Receipt).Load(fileStream);
                 except
                   on e: exception do begin
                     Error('Error loading receipt file.',e.message,MessageInfo);
                     exit;
                   end;
                 end;
               finally
                 fileStream.Free;
               end;
             except
               on e: exception do begin
                 Error('Error creating receipt object.',e.message,MessageInfo);
                 exit;
               end;
             end;
           end;
//           Log('here2');
           if FileExists(ChangeFileExt(dir + sl[I],'.inf')) then begin
             inf := TStringList.Create;
             try
               inf.LoadFromFile(ChangeFileExt(dir + sl[I],'.inf'));
               MessageInfo.Info.Values['mdnURL'] := inf.Values['mdnURL'];
             finally
               inf.Free;
             end;
           end;

//           Log('here3');

           {  what sort of message is it .. }
           if SameText(Copy(Trim(stream.ReadString(20)),1,5),'<?xml') then begin

             stream.Position := 0;
             if (not ProcessXMLRequest(stream,MessageInfo)) and (MessageInfo.RetryCount <= Retry_Count) then
               continue;  { don't delete the message until we have tried a number od times to process it }

           end
           else begin
             Error('Unknown file format for message "' + dir + sl[I] + '"','',MessageInfo);
           end;

           {$IFNDEF DISABLE_MESSAGE_DELETE}
           if not SysUtils.DeleteFile(dir + sl[I]) then begin
             Error('Could not delete message "' + dir + sl[I] + '"','',MessageInfo);
           end;
           SysUtils.DeleteFile(ChangeFileExt(dir + sl[I],'.mdn'));
           SysUtils.DeleteFile(ChangeFileExt(dir + sl[I],'.inf'));
           {$ENDIF}
         except
           on e: exception do begin
             Error('Error checking for messages.',e.message,MessageInfo);
             exit;
           end;
         end;

       finally
         if Assigned(MessageInfo) then begin
           MessageInfo.Save;
           MessageInfo.Free;
         end;
       end;

     end;
   finally
     sl.Free;
     stream.Free;
   end;
  end;

end;

procedure TRosettaNetConnector.CheckRosettaNetSalesCategoryExists;
var
  SalesCatList, SalesCat: TJsonObject;
begin
  SalesCatList:= nil;
  try
    SalesCatList := ERP.GetList('TSalesCategory','([TypeName] = "RosettaNet")');
    if SalesCatList.A['TSalesCategory'].Count = 0 then begin
      SalesCat := JO;
      try
        SalesCat.S['type'] := 'TSalesCategory';
        SalesCat.O['fields'].S['TypeName'] := SalesCategory_RosettaNet;
        SalesCat.O['fields'].S['Description'] := 'RosettaNet Sale';
        ERP.SaveObject(SalesCat);
      finally
        SalesCat.Free;
      end;
    end;
  finally
    SalesCatList.Free;
  end;
end;

//function TRosettaNetConnector.CheckERPSettings(var msg: string): boolean;
//var
//  cfgStr: string;
//  api: TWebAPIClient;
//  obj, salesCat: TJsonObject;
//  x: integer;
//  found: boolean;
//begin
//  if fCheckERPSettingsOk then begin
//    cfgStr := Config.O['WebAPI'].AsString;
//    if fWebAPIConfigStr <> cfgStr then begin
//      fWebAPIConfigStr := cfgStr;
//      fCheckERPSettingsOk := false;
//    end;
//  end;
//  if not fCheckERPSettingsOk then begin
//    { make sure ERP has a TSalesCategory of RosettaNet }
//
//    obj := nil;
//    api:= self.GetApiClient;
//    salesCat := JO;
//    try
//      if api.Get('TSalesCategory',Obj) then begin
//        found:= false;
//        for x := 0 to obj.A['TSalesCategory'].Count -1 do begin
//          if SameText(obj.A['TSalesCategory'].Items[x].AsObject.S['KeyValue'],SalesCategory_RosettaNet) then begin
//            found := true;
//            fCheckERPSettingsOk := true;
//            break;
//          end;
//        end;
//        if not found then begin
//          { create it }
//          salesCat.S['type'] := 'TSalesCategory';
//          salesCat.O['fields'].S['TypeName'] := SalesCategory_RosettaNet;
//          salesCat.O['fields'].S['Description'] := 'RosettaNet Sale';
//          if not api.Post('TSalesCategory',salesCat,obj) then begin
//            msg := 'Error creating "RosettaNet" Sales Category in ERP: ' + api.ErrorMessage;
//            exit;
//          end
//          else
//            fCheckERPSettingsOk := true;
//        end;
//      end
//      else begin
//        msg := 'Error getting Sales Category list from ERP: ' + api.ErrorMessage;
//        exit;
//      end;
//    finally
//      api.Free;
//      obj.Free;
//      salesCat.Free;
//    end;
//
//
//  end;
//  result := fCheckERPSettingsOk;
//end;

procedure TRosettaNetConnector.CheckForInvoices;
var
  invList, printList: TJsonObject;
  invPos, invId: integer;
begin
 if not Config.O['RosettaNet'].B['SendInvoices'] then
   exit;
  invList := nil;
  printList := nil;
  try
    if now >= fNextInvoiceCheckTime then begin
      try
        { get list of RoesttaNet invoices that have not been paid .. }
        invList := ERP.GetList('TInvoice','([TotalPaid]=0 and [Deleted] = "false" and [SalesCategory]="RosettaNet")');
        for invPos := 0 to invList.A['tinvoice'].Count -1 do begin
          { now check for invoices that have not allready been sent via EDI }
          invId := invList.A['tinvoice'].Items[invPos].AsObject.I['Id'];
          if invId < 1 then
            continue;
          FreeAndNil(printList);
          printList := ERP.GetList('TInvoicePrintDoc','([DocOutputType] = "dotEDI" and [DocId] = ' + IntToStr(invId) + ')');
          if printList.ArrayExists('TInvoicePrintDoc') and (printList.A['TInvoicePrintDoc'].Count = 0) then begin
            { send this invoice }
            Log('Invoice ' + IntToStr(invId) + ' needs to be sent.',ltDetail);
            SendInvoice(invId);
          end;
        end;

      finally
        invList.Free;
        printList.Free;
      end;

      fNextInvoiceCheckTime := now + ((1/24/60/60) * 5);
    end;
    if now >= fNexterpCheckTime then begin
      erp.RemoveOldObjects;
      fNextERPCheckTime := now + + ((1/24/60/60) * 60);
    end;
  except
    on e: TERPWebApiException do begin
      Error(e.Message,e.DetailMessage);
    end;
    on e: Exception do begin
      Error(e.Message,'');
    end;
  end;
end;

constructor TRosettaNetConnector.Create(aLogger: TLoggerBase);
var
  path: string;
begin
  inherited;
  fCheckERPSettingsOk := false;
  fConnectorName := 'ERP B2B RosettaNet Connector';
  try
    Log(ClassName + ' started.',ltInfo);
    ERP := TERPWebApi.Create(Config.O['WebAPI']);
    path:= ExtractFilePath(GetCurrentModuleName);

    AS2Server := TAS2Server.Create;
    AS2Server.Logger := aLogger;
    AS2Server.OnError := Error;
    AS2Server.ServerPort := Config.O['RosettaNet'].I['ServerPort'];
    AS2Server.AddServerCertificate(path + 'receiver.b2b.telstra.com.der.cer');
    AS2Server.AddServerCertificate(path + 'adhere.adherepromotions.com.au.DER.cer', path + 'private.key');
    try
      AS2Server.InboundMessageFolder := ExtractFilePath(GetCurrentModuleName)+'Inbound';
      AS2Server.Active := true;
    except
      on e: exception do begin
        Error('Error occurred while initializing RosettaNet server.',e.Message);
      end;
    end;

    AS2Client := TAS2Client.Create;
    AS2Client.OnError := Error;
    AS2Client.Logger:= fLogger;
    AS2Client.OutboundMessageFolder := ExtractFilePath(GetCurreThe connector ntModuleName)+'\Outbound';
    AS2Client.AddServerCertificate(path + 'VerisignCA.der.cer');
    AS2Client.AddServerCertificate(path + 'VerisignIntermediary.der.cer');
    AS2Client.AddServerCertificate(path + 'receiver.b2b.telstra.com.der.cer');
    AS2Client.AddClientCertificate(path + 'adhere.adherepromotions.com.au.DER.cer', path + 'private.key');

    Menu.Clear;
    Menu.Add(JO('{"href":"home","caption":"Home"}'));
    Menu.Add(JO('{"href":"webapiconfig","caption":"Web API Config"}'));
    Menu.Add(JO('{"href":"rosettanetconfig","caption":"RosettaNet Config"}'));
  //  Menu.Add(JO('{"href":"partnerconfig","caption":"Partner Config"}'));
    Menu.Add(JO('{"href":"log","caption":"Log"}'));
    Menu.Add(JO('{"href":"logout","caption":"Logout"}'));
  //  Menu.Add(JO('{"href":"terminate","caption":"Terminate Server"}'));
    fNextInvoiceCheckTime := now + ((1/24/60/60) * 5);
    fNextERPCheckTime := now + + ((1/24/60/60) * 60);
    TimerThread:= TTimerThread.Create(true);
    TimerThread.Connector := self;
    TimerThread.FreeOnTerminate := true;
    TimerThread.Start;
    Log(fConnectorName + ' created.',ltInfo);
  except
    on e: exception do begin
      Log('Error creating ' + fConnectorName + ': ' + e.Message, ltError);

    end;
  end;
end;

function TRosettaNetConnector.CreatePip3A4PurchaseOrderConfirmation(
  Doc: IXMLDocument; SaleId: integer; var msg: string): IXMLDocument;
var
  sl: TStringList;
//  node, lineNode: IXMLNode;
//  x: integer;
begin
  result := nil;

//  try



  sl := TStringList.Create;
  try
//    if not GetCompanyInfo(CompanyInfo,msg) then begin
//      exit;
//    end;


    sl.Add('<?xml version="1.0" encoding="utf-8"?>');
    sl.Add('<!DOCTYPE Pip3A4PurchaseOrderConfirmation SYSTEM "3A4_MS_V02_00_PurchaseOrderConfirmation.dtd">');
    sl.Add('<Pip3A4PurchaseOrderConfirmation>');
    sl.Add('	<fromRole>');
    sl.Add('		<PartnerRoleDescription>');
    sl.Add('			<GlobalPartnerRoleClassificationCode></GlobalPartnerRoleClassificationCode>');
    sl.Add('			<PartnerDescription>');
    sl.Add('				<BusinessDescription>');
    sl.Add('				</BusinessDescription>');
    sl.Add('			</PartnerDescription>');
    sl.Add('		</PartnerRoleDescription>');
    sl.Add('	</fromRole>');
    sl.Add('	<GlobalDocumentFunctionCode>Responce</GlobalDocumentFunctionCode>');
    sl.Add('	<PurchaseOrder>');
    sl.Add('		<GlobalPurchaseOrderStatusCode></GlobalPurchaseOrderStatusCode>');
    sl.Add('		<GlobalPurchaseOrderTypeCode></GlobalPurchaseOrderTypeCode>');
    sl.Add('		<isDropShip>');
    sl.Add('			<AffirmationIndicator></AffirmationIndicator>');
    sl.Add('		</isDropShip>');
    sl.Add('		<ProductLineItem>');
    sl.Add('			<buyerLineItem>');
    sl.Add('				<LineNumber></LineNumber>');
    sl.Add('			</buyerLineItem>');
    sl.Add('			<GlobalProductUnitOfMeasureCode></GlobalProductUnitOfMeasureCode>');
    sl.Add('			<GlobalPurchaseOrderStatusCode></GlobalPurchaseOrderStatusCode>');
    sl.Add('			<isDropShip>');
    sl.Add('				<AffirmationIndicator></AffirmationIndicator>');
    sl.Add('			</isDropShip>');
    sl.Add('			<LineNumber></LineNumber>');
    sl.Add('			<OrderQuantity>');
    sl.Add('				<requestedQuantity>');
    sl.Add('					<ProductQuantity></ProductQuantity>');
    sl.Add('				</requestedQuantity>');
    sl.Add('			</OrderQuantity>');
    sl.Add('			<ProductIdentification>');
    sl.Add('			</ProductIdentification>');
    sl.Add('			<requestedEvent>');
    sl.Add('				<TransportationEvent>');
    sl.Add('					<DateStamp></DateStamp>');
    sl.Add('					<GlobalTransportEventCode></GlobalTransportEventCode>');
    sl.Add('				</TransportationEvent>');
    sl.Add('			</requestedEvent>');
    sl.Add('		</ProductLineItem>');
    sl.Add('	</PurchaseOrder>');
    sl.Add('	<requestingDocumentDateTime>');
    sl.Add('		<DateTimeStamp></DateTimeStamp>');
    sl.Add('	</requestingDocumentDateTime>');
    sl.Add('	<requestingDocumentIdentifier>');
    sl.Add('		<ProprietaryDocumentIdentifier></ProprietaryDocumentIdentifier>');
    sl.Add('	</requestingDocumentIdentifier>');
    sl.Add('	<thisDocumentGenerationDateTime>');
    sl.Add('		<DateTimeStamp></DateTimeStamp>');
    sl.Add('	</thisDocumentGenerationDateTime>');
    sl.Add('	<thisDocumentIdentifier>');
    sl.Add('		<ProprietaryDocumentIdentifier></ProprietaryDocumentIdentifier>');
    sl.Add('	</thisDocumentIdentifier>');
    sl.Add('	<toRole>');
    sl.Add('		<PartnerRoleDescription>');
    sl.Add('			<GlobalPartnerRoleClassificationCode></GlobalPartnerRoleClassificationCode>');
    sl.Add('			<PartnerDescription>');
    sl.Add('				<BusinessDescription>');
    sl.Add('				</BusinessDescription>');
    sl.Add('			</PartnerDescription>');
    sl.Add('		</PartnerRoleDescription>');
    sl.Add('	</toRole>');
    sl.Add('</Pip3A4PurchaseOrderConfirmation>');


    result:= TXMLDocument.Create(nil);
    result.XML.Assign(sl);
    result.Active := true;



//    sl.Text := ReplaceStr(Doc.XML.Text,'PurchaseOrderRequest','PurchaseOrderConfirmation');
//    result:= TXMLDocument.Create(nil);
//    result.XML.Assign(sl);
//    result.Active := true;
//    { fromRole }
//    node := result.DocumentElement.ChildNodes.FindNode('fromRole');
//    node.ChildNodes.Clear;
//    node:= node.AddChild('PartnerRoleDescription');
//    node.AddChild('GlobalPartnerRoleClassificationCode').NodeValue:= 'Seller';
//    node:= node.AddChild('BusinessDescription');
//    node.AddChild('GlobalBusinessIdentifier').NodeValue := Config.O['RosettaNet'].S['GlobalBusinessIdentifier'];
//    node.AddChild('GlobalSupplyChainCode').NodeValue := Config.O['RosettaNet'].S['GlobalSupplyChainCode'];
//    node.AddChild('businessName').AddChild('FreeFormText').NodeValue := Config.O['RosettaNet'].S['BusinessName'];
//
//    { toRole }
//
//
//    { Function Code }
//    result.DocumentElement.ChildNodes.FindNode('GlobalDocumentFunctionCode').NodeValue := 'Responce';
//
//    { document time and id }
//    result.DocumentElement.AddChild('requestingDocumentDateTime').AddChild('DateTimeStamp').NodeValue := DateTimeToISO8601(now);
//    result.DocumentElement.AddChild('requestingDocumentIdentifier').AddChild('ProprietaryDocumentIdentifier').NodeValue := IntToStr(SaleId);
//
//
//    { Purchase Order }
//    node := result.DocumentElement.ChildNodes.FindNode('PurchaseOrder');
//    node.AddChild('GlobalPurchaseOrderStatusCode').NodeValue := 'Accept';
//
//    { now lines ... }
//    for x := 0 to node.ChildNodes.Count -1 do begin
//      if SameText(node.ChildNodes[x].NodeName,'ProductLineItem') then begin
//        lineNode := node.ChildNodes[x];
//        lineNode.AddChild('buyerLineItem').AddChild('LineNumber').NodeValue := lineNode.ChildNodes.FindNode('LineNumber').NodeValue;
//
//      end;
//    end;

  finally
    sl.Free;
  end;
end;

destructor TRosettaNetConnector.Destroy;
begin
  Log(ClassName + ' stopping.',ltInfo);
  TimerThread.Terminate;
  AS2Client.Free;
  AS2Server.Free;
  ERP.Free;
  inherited;
end;

//procedure TRosettaNetConnector.DoOnCommandGet(AContext: TIdContext;
//  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
//var
//  StringStream: TStringStream;
//  reader: TStreamReader;
//  s: string;
////  x: integer;
//  xml: IXMLDocument;
////  msgPath: string;
//  MessageInfo: TMessageInfo;
//  MemStream: TMemoryStream;
//  Msg: TElAS2Message;
//
//begin
//  MessageInfo:= TMessageInfo(AContext.Data);
//  Log('Received request type: '+ ARequestInfo.Command,ltDetail);
//  MessageInfo.Info.Values['HTTP Request Type']:= ARequestInfo.Command;
//  Log('Document: '+ ARequestInfo.Document,ltDetail);
//  Log('Remote IP: '+ ARequestInfo.RemoteIP,ltDetail);
//  MessageInfo.Info.Values['Remote IP']:= ARequestInfo.RemoteIP;
//  Log('Content type: '+ ARequestInfo.ContentType,ltDetail);
//  Log('Content length: '+ IntToStr(ARequestInfo.ContentLength),ltDetail);
//  Log('Raw HTTP Command: '+ ARequestInfo.RawHTTPCommand,ltDetail);
//
//  if (ARequestInfo.CommandType = hcPOST) and SameText(ARequestInfo.Document, '/as2handler') then begin
//    Log(Format('[%s:%d] Receiving new AS2 message', [AContext.Binding.PeerIP, AContext.Binding.PeerPort]),ltDetail);
//    MemStream:= TMemoryStream.Create;
//    StringStream := TStringStream.Create;
//    try
//      ARequestInfo.RawHeaders.SaveToStream(MemStream);
//      SBASUtils.WriteLine(MemStream, '');
//      MemStream.CopyFrom(ARequestInfo.PostStream, 0);
//      MessageInfo.AddDocument('RawAS2Message.bin',MemStream);
//      Msg := TElAS2Message.Create(nil);
//      try
//        try
//          //Msg.Encryption.CertStorage := DecryptingCertificates;
//          //Msg.Signature.CertStorage := VerifyingCertificates;
//          if not Msg.Load(MemStream, StringStream) then // (FileName, ChangeFileExt(FileName, '.bin')) then
//          begin
//            Log('Could not load message from stream',ltError);
//            MessageInfo.Info.Values['Error']:= 'Could not load message from stream';
//            AResponseInfo.ResponseNo := 500;
//            AResponseInfo.ResponseText := 'Internal Server Error';
//            AResponseInfo.ContentType := 'text/plain';
//            AResponseInfo.ContentText := 'Could not load message from stream';
//            AResponseInfo.WriteContent;
//            exit;
//          end
//          else begin
//            { process the message  }
//            MessageInfo.AddDocument('DecodedAS2Message.txt',StringStream);
//
//
//            AResponseInfo.ResponseNo := 200;
//            AResponseInfo.ResponseText := 'OK';
//            AResponseInfo.ContentType := '';
//
//          end;
//
//        except
//          on E: EElASMessageError do
//          begin
//            Log('Message parsing error: ' + E.Message,ltError);
//            MessageInfo.Info.Values['Error']:= 'Message parsing error: ' + E.Message;
//            AResponseInfo.ResponseNo := 500;
//            AResponseInfo.ResponseText := 'Internal Server Error';
//            AResponseInfo.ContentType := 'text/plain';
//            AResponseInfo.ContentText := E.Message;
//            AResponseInfo.WriteContent;
//            exit;
//            // TODO: add advanced AS2 critical errors handling here
//          end;
//          on E: Exception do begin
//            Log('Message error: ' + E.Message,ltError);
//            MessageInfo.Info.Values['Error']:= 'Message error: ' + E.Message;
//            AResponseInfo.ResponseNo := 500;
//            AResponseInfo.ResponseText := 'Internal Server Error';
//            AResponseInfo.ContentType := 'text/plain';
//            AResponseInfo.ContentText := E.Message;
//            AResponseInfo.WriteContent;
//            exit;
//          end;
//        end;
//      finally
//        Msg.Free;
//      end;
//
//
//
//    finally
//      MemStream.Free;
//      StringStream.Free;
//    end;
//  end
//  else if Assigned(ARequestInfo.PostStream) then begin
//    StringStream := TStringStream.Create;
//    reader:= TStreamReader.Create(StringStream);
//    Coinitialize(nil);
//    try
//      StringStream.LoadFromStream(ARequestInfo.PostStream);
//      StringStream.Position := 0;
////      msgPath:= ExtractFilePath(GetModuleName)+'\Inbound';
////      ForceDirectories(msgPath);
////      stream.SaveToFile(msgPath + '\message_'+ FormatDateTime('yyyy-mm-dd-hh-nn-ss-zzz',now)+ '.txt');
////      Log('Saved message content to file',ltDetail);
////      stream.Position := 0;
//      { what sort of request is this ... }
//      s:= Trim(Reader.ReadLine);
//      if Pos('<?xml',Lowercase(s)) = 1 then begin
//        MessageInfo.Info.Values['Message Type']:= 'XML Document';
//        MessageInfo.AddDocument('Input Document.xml',ARequestInfo.PostStream);
//        Log('This is a XML request ..',ltDetail);
//        {  xml doc }
//        xml:= TXMLDocument.Create(nil);
//        try
//          try
//            StringStream.Position := 0;
//            xml.LoadFromStream(StringStream);
//            // xml.SaveToFile('c:\temp\temp1.xml');
//          except
//            on e: exception do begin
//              Error('Error reading received XML document',e.Message,MessageInfo);
//              AResponseInfo.ResponseNo := 400; { Bad Request }
//              exit;
//            end;
//          end;
//          { else request is ok }
//          ProcessXMLRequest(xml, AResponseInfo,MessageInfo);
//        finally
//          xml := nil;
//        end;
//      end
//      else begin
//        MessageInfo.Info.Values['Message Type']:= 'Unknown';
//        MessageInfo.AddDocument('Input Document.txt',ARequestInfo.PostStream);
//        Log('Rejecting unknown request.',ltWarning);
//        Log('First line of request: ' + s,ltWarning);
//        MessageInfo.Info.Values['Error']:= 'Unknown request';
//        AResponseInfo.ResponseNo := 403; { Forbidden }
//      end;
//
//    finally
//      StringStream.Free;
//      CoUninitialize;
//    end;
//  end
//  else begin
//    {  no post stream }
//    Log('Message does not contain any content',ltWarning);
//  end;
//
//end;

//procedure TRosettaNetConnector.DoOnConnect(AContext: TIdContext);
//begin
//  Log('Client connect',ltDetail);
//  AContext.Data := TMessageInfo.Create;
//  {  passthrough must be false for ssl }
//  TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).passThrough:= false;
//end;

//procedure TRosettaNetConnector.DoOnDisconnect(AContext: TIdContext);
//begin
//  Log('Client disconnect',ltDetail);
//  TMessageInfo(AContext.Data).Save(ExtractFilePath(GetModuleName)+'\Inbound');
//end;

procedure TRosettaNetConnector.DoOnTimer;
begin
  CheckForMessages;
  CheckForInvoices;
end;

function TRosettaNetConnector.DoPage(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
  URI: TIdURI): boolean;
var
  msg: string;
begin
  result := inherited;
  if not result then begin

    if SameText(URI.Document,'rosettanetconfig') then begin
      if ARequestInfo.CommandType = hcGet then begin
        AResponseInfo.ContentText := self.RoseettaNetConfigPage;
        result:= true;
      end
      else if ARequestInfo.CommandType = hcPost then begin
        result:= true;
        { if form check box's are not checked they will not be included in
          parameters .. so add with a value of "false" if missing }

        if self.UpdateJsonFromParams(Config.O['RosettaNet'],ARequestInfo.Params) then begin
          Config.Save;
          if AS2Server.ServerPort <> Config.O['RosettaNet'].I['ServerPort'] then begin
            AS2Server.ServerPort := Config.O['RosettaNet'].I['ServerPort'];
          end;

          if SameText(ARequestInfo.Params.Values['button'],'Save') then begin
            AResponseInfo.ContentText := self.RoseettaNetConfigPage('<h3>Changes have been saved.</h3><br />');
            Log('RosettaNet config changed by user.',ltInfo);
          end
          else if SameText(ARequestInfo.Params.Values['button'],'Test Email') then begin
            { test it }
            if not TestEmailConfig(msg) then begin
              AResponseInfo.ContentText := self.RoseettaNetConfigPage('<h3>Changes have been saved.<br />'+msg+'</h3><br />');
            end
            else begin
              AResponseInfo.ContentText := self.RoseettaNetConfigPage('<h3>Changes have been saved.<br />Communication with SMTP Mail Server working OK.</h3><br />');
            end;
            Log('RosettaNet config changed by user.',ltInfo);
          end;
        end
        else begin
          { nothing changed }
          if SameText(ARequestInfo.Params.Values['button'],'Test Email') then begin
            { test it }
            if not TestEmailConfig(msg) then
              AResponseInfo.ContentText := self.RoseettaNetConfigPage('<h3>'+msg + '</h3><br />')
            else
              AResponseInfo.ContentText := self.RoseettaNetConfigPage('<h3>Communication with SMTP Mail Server working OK.</h3><br />');
          end
          else begin
            AResponseInfo.ContentText := self.RoseettaNetConfigPage();
          end;
        end;
      end;
    end
    else if SameText(URI.Document,'home') then begin
      AResponseInfo.ContentText := MakePage('Home','<h1>Home</h1>','<h3>TrueERP RosettaNet Connector Version: '+GetFileVersion+'</h3>');
      result := true;
    end;
//    else if SameText(URI.Document,'partnerconfig') then begin
//      AResponseInfo.ContentText := PartnerPage;
//      result := true;
//    end;
  end;
end;

//procedure TRosettaNetConnector.DoServerThreadException(AContext: TIdContext;
//  AException: Exception);
//begin
//  Error('Server error',AException.Message,TMessageInfo(AContext.Data));
//end;

procedure TRosettaNetConnector.EmailAdmin(aSubject: string; aBody: TStrings);
var
  SMTP: TIdSMTP;
  mail: TIdMessage;
begin
  if (Config.O['RosettaNet'].S['SMTPServer'] = '') or
     (Config.O['RosettaNet'].I['SMTPPort'] = 0) or
     (Config.O['RosettaNet'].S['SMTPUserName'] = '') or
     (Config.O['RosettaNet'].S['SMTPPassword'] = '') or
     (Config.O['RosettaNet'].S['AdminEmailAddress'] = '') then
    exit;

  SMTP := TIdSMTP.Create(nil);
  mail := TIdMessage.Create(nil);
  try
    SMTP.Host := Config.O['RosettaNet'].S['SMTPServer'];
    SMTP.Port := Config.O['RosettaNet'].I['SMTPPort'];
    SMTP.Username := Config.O['RosettaNet'].S['SMTPUserName'];
    SMTP.Password := Config.O['RosettaNet'].S['SMTPPassword'];
//    mail.From.Address := Config.O['RosettaNet'].S['AdminEmailAddress'];
    mail.From.Name := 'ERP RosettaNet Connector';
    mail.Recipients.EMailAddresses := Config.O['RosettaNet'].S['AdminEmailAddress'];
    mail.Subject := aSubject;
    mail.Body.Assign(aBody);

    try
      SMTP.Connect;
      SMTP.Send(mail);
    except
      on e: exception do begin
        Log('Could not send Error email message: ' + e.Message,ltError);
      end;
    end;

  finally
    SMTP.Free;
    mail.Free;
  end;
end;

procedure TRosettaNetConnector.Error(const aError, aDetail: string;
  MessageInfo: TMessageInfo);
var
  s: string;
  sl: TStringList;
  x: integer;
  doSendMail: boolean;
begin
  doSendMail := true;
  s:= aError;
  if aDetail <> '' then
    s := s + #13#10 + aDetail;
  sl:= TStringList.Create;
  try
    sl.Add('The ERP RosettaNet Connector encounted an error.');
    if aDetail <> '' then begin
      sl.Add('');
      sl.Add(aDetail);
    end;
    if Assigned(MessageInfo) then begin
      if aDetail = '' then
        MessageInfo.Info.Values['Error'] := aError
      else
        MessageInfo.Info.Values['Error'] := aError + ': ' + aDetail;
      sl.Add('');
      sl.Add('Info on the message being processed:');
      sl.Add('');
      for x := 0 to MessageInfo.Info.Count -1 do
        sl.Add(MessageInfo.Info[x]);
      if Assigned(MessageInfo.Receipt) then begin
        TElAS2Receipt(MessageInfo.Receipt).Errors.Add(0,aError,aDetail,dmFailure);
      end;
      MessageInfo.RetryCount := MessageInfo.RetryCount + 1;
      doSendMail := MessageInfo.RetryCount >= Retry_Count;
      s := s + #13#10 + 'Retry Count = ' + IntToStr(MessageInfo.RetryCount);
    end;
    Log(s,ltError);
    if doSendMail then
      EmailAdmin(aError,sl);
  finally
    sl.Free;
  end;

end;

//function TRosettaNetConnector.GetCompanyInfo(var Obj: TJsonObject;
//  var msg: string): boolean;
//var
//  api: TWebAPIClient;
//begin
//  result := true;
//  api:= self.GetApiClient;
//  try
//    if api.Get('TCompanyInfo',1,Obj) then begin
//
//    end
//    else begin
//      result := false;
//      msg := 'Error getting company information from ERP: ' + api.ErrorMessage;
//      exit;
//    end;
//  finally
//    api.Free;
//  end;
//end;

//function TRosettaNetConnector.PartnerPage: string;
//var
//  body: string;
//  x: integer;
//  partner: TJsonObject;
//begin
//  body :=
//    '<table border="1" cellpadding="10">' +
//      '<tr>' +
//        '<th>ERP Client</th>'+
//        '<th>DUNs</th>'+
//        '<th>URL</th>'+
//      '</tr>';
//    for x := 0 to Config.O['RosettaNet'].A['Partners'].Count -1 do begin
//      partner := Config.O['RosettaNet'].A['Partners'].Items[x].AsObject;
//      Body := Body +
//      '<tr>' +
//      '<td>' + partner.S['ERPClient'] + '</td>' +
//      '<td>' + partner.S['DUNS'] + '</td>' +
//      '<td>' + partner.S['URL'] + '</td>' +
//      '</tr>';
//    end;
//
//    Body := Body +
//    '</table>';
//  result:= self.MakePage('RosettaNet Partners','<h1>RosettaNet Partnere</h1>',Body, true);
//end;

function TRosettaNetConnector.ProcessXMLRequest(DocStream: TStream; MessageInfo: TMessageInfo): boolean;
var
  SO, Attachment: TJsonObject;
  SOId, AttachmentId: integer;
  Mapper: TJsonXmlMapper;
  msg: string;
  PONode, node, TaxExemptStatusNode: IXMLNode;
  x, y, z: integer;
  json: TJsonObject;
  MIMEEncoder: TIdEncoderMIME;
  Stream: TMemoryStream;
  xmlDoc: IXMLDocument;
//  AS2Client: TAS2Client;
  ProdName, RetailerProdName, ShopperProdName: string;
  Prod: TJsonObject;
  Payment, invList, BankList, JLI, userList: TJsonObject;
  CustName: string;
  RemittanceAdviceNode, RemittanceLineItemNode: IXMLNode;
//  PaymentDate: TDateTime;
//  CurrencyCode: string;
  AccountNo, AccountBSB: string;
  GLAccountName: string;
  InvRefNo: string;
  InvoiceFound: boolean;
  PaymentLine: TJsonObject;
  PaymentTotal: double;
  RefNoList: string;
  PaymentId: integer;
  UOMName: string;
  UOMMult: double;
  i: integer;
//  Path: string;
//  s: string;
//  xmlConfirmation: IXMLDocument;

  function ClientNameFromGlobalBusinessIdentifier(GlobalId: string): string;
  var
    lst: TJsonObject;
    id: integer;
  begin
    result := '';
    lst := ERP.GetList('TClientCustomFieldValues','[Description]="Global Business Identifier" and [Value] = "'+GlobalId+'"','MasterId');
    try
      if lst.A['TClientCustomFieldValues'].Count = 0 then begin
        Error('Customer not found in ERP','Could not find a customer in ERP with a Global Business Identifier of ' + GlobalId, MessageInfo);
        exit;
      end;
      id:= lst.A['TClientCustomFieldValues'].Items[0].AsObject.I['MasterId'];
      lst := ERP.GetList('TCustomer','[Id]=' + IntToStr(id),'ClientName');
      if lst.A['TCustomer'].Count = 0 then begin
        Error('Customer not found in ERP','Could not find a customer in ERP with an ID of ' + IntToStr(id), MessageInfo);
        exit;
      end;
      result := lst.A['TCustomer'].Items[0].AsObject.S['ClientName'];
      if result = '' then
        Error('Customer not found in ERP','Could not find a customer in ERP with an ID of ' + IntToStr(id), MessageInfo);
    finally
      lst.Free;
    end;
  end;


begin
  result := false;
  try
    try
      Coinitialize(nil);
      xmlDoc := TXmlDocument.Create(nil);
      try
        try
          xmlDoc.LoadFromStream(DocStream);
        except
          on e: exception do begin
            Error('Error loading XML Document from stream.',e.Message,MessageInfo);
            exit;
          end;
        end;
        Log('XML request type: ' + xmlDoc.DocumentElement.NodeName, ltDetail);
        MessageInfo.Info.Values['Document Type'] := xmlDoc.DocumentElement.NodeName;
        if SameText(xmlDoc.DocumentElement.NodeName,'Pip3A4PurchaseOrderRequest') or
           SameText(xmlDoc.DocumentElement.NodeName,'esb:PurchaseOrderMessage') then begin
          { Purchase Order Request }

          self.CheckRosettaNetSalesCategoryExists;

          { map to an ERP TSalesOrder }
          SO := JO;
          Attachment := JO;
          try
            SO.S['type']:= 'TSalesOrder';
            { have to get client name from DUNS number }
            CustName := ClientNameFromGlobalBusinessIdentifier(GetNodeVal(RootNode(xmlDoc), 'fromRole.PartnerRoleDescription.PartnerDescription.BusinessDescription.GlobalBusinessIdentifier'));
            if CustName = '' then
              exit;
            SO.O['fields'].S['CustomerName'] := CustName;
            SO.O['fields'].S['SalesCategory'] := SalesCategory_RosettaNet;
            Mapper := TJsonXmlMapper.Create;
            try
              Mapper.XMLMapType := xtRosettaNet;
              Mappings.AddSOHeadderMappings(Mapper);
              if not Mapper.MapXmlToJson(RootNode(xmlDoc),SO, msg) then begin
                Error('Error mapping Pip3A4PurchaseOrderRequest to ERP Sales Order',msg,MessageInfo);
                exit;
              end;

              Mapper.Clear;

              Mappings.AddSOLineMappings(Mapper);
              PONode := GetNode(RootNode(xmlDoc),'PurchaseOrder');
              if not Assigned(PONode) then begin
                Error('Missing XML element in Pip3A4PurchaseOrderRequest','Could not find PurchaseOrder Node',MessageInfo);
                exit;
              end;
              for x:= 0 to PONode.ChildNodes.Count -1 do begin
                node := PONode.ChildNodes.Nodes[x];
                if SameText(node.NodeName,'ProductLineItem') then begin
                  json:= JO;
                  json.S['type'] := 'TSalesOrderLine';

                  { optional node }
                  TaxExemptStatusNode := GetNode(node,'TaxExemptStatus.isTaxExempt.AffirmationIndicator');
//                  if not Assigned(TaxExemptStatusNode) then begin
//                    Error('Missing XML element in Pip3A4PurchaseOrderRequest','Could not find TaxExemptStatus information',MessageInfo);
//                    exit;
//                  end;
                  if Assigned(TaxExemptStatusNode) then begin
                    if (not VarIsNull(TaxExemptStatusNode.NodeValue)) and SameText(TaxExemptStatusNode.NodeValue,'Yes') then
                      json.O['fields'].S['LineTaxCode'] := Config.O['RosettaNet'].S['ExemptTaxCode'];
                  end;

//                  ProdName := RosettaNetUtils.GetRetailerProductIdentifier(node);
//                  if (ProdName = '') and (not Assigned(ERP.GetObject('TProductWeb',ProdName))) then begin
//                    RetailerProdName := ProdName;
//                    ProdName := RosettaNetUtils.GetShopperProductIdentifier(node);
//                    if (ProdName = '') and (not Assigned(ERP.GetObject('TProductWeb',ProdName))) then begin
//
//                      Error('Error mapping Pip3A4PurchaseOrderRequest ProductLineItem.',
//                        'ProprietaryProductIdentifier not found for GlobalPartnerClassificationCode ' +
//                          '"Shopper" ('+ProdName+') or "Retailer" ('+RetailerProdName+').',MessageInfo);
//                      exit;
//                    end;
//                  end;

                  RetailerProdName := RosettaNetUtils.GetRetailerProductIdentifier(node);
                  ShopperProdName := RosettaNetUtils.GetShopperProductIdentifier(node);
                  if (RetailerProdName = '') and (ShopperProdName = '') then begin
                    Error('Error mapping Pip3A4PurchaseOrderRequest ProductLineItem.',
                      'ProprietaryProductIdentifier not found for GlobalPartnerClassificationCode ' +
                        '"Shopper" or "Retailer".',MessageInfo);
                    exit;
                  end;
                  Prod := nil;
                  if RetailerProdName <> '' then begin
                    try
                      Prod := ERP.GetObject('TProductWeb',RetailerProdName);
                    except
                      on e: TERPWebApiException do begin
                        if pos('404 Not Found', e.DetailMessage) > 0 then begin
                          { ignore exception if product not found }
                        end
                        else
                          raise;
                      end
                      else
                        raise;
                    end;
                  end;
                  if assigned(Prod) then begin
                    ProdName := RetailerProdName;
                    UOMName := Prod.O['fields'].S['UOMSales'];
                    UOMMult := Prod.O['fields'].F['UOMSalesMultiplier'];
                    Prod.Free;
                  end
                  else begin
                    Prod := nil;
                    if ShopperProdName <> '' then begin
                      try
                        Prod := ERP.GetObject('TProductWeb',ShopperProdName);
                      except
                        on e: TERPWebApiException do begin
                          if pos('404 Not Found', e.DetailMessage) > 0 then begin
                            { ignore exception if product not found }
                          end
                          else
                            raise;
                        end
                        else
                          raise;
                      end;
                    end;
                    if assigned(Prod) then begin
                      ProdName := ShopperProdName;
                      UOMName := Prod.O['fields'].S['UOMSales'];
                      UOMMult := Prod.O['fields'].F['UOMSalesMultiplier'];
                      Prod.Free;
                    end
                    else begin
                      { use default product }
                      ProdName := 'FREETEXT';
                      UOMMult := 1;
                      UOMName := 'Units';
                      if RetailerProdName <> '' then
                        json.O['fields'].S['Product_Description_Memo'] := RetailerProdName;
                      if json.O['fields'].S['Product_Description_Memo'] <> '' then begin
                        if ShopperProdName <> '' then
                          json.O['fields'].S['Product_Description_Memo'] := json.O['fields'].S['Product_Description_Memo'] +
                          ', ' + ShopperProdName;
                      end
                      else
                        json.O['fields'].S['Product_Description_Memo'] := ShopperProdName;
                    end;
                  end;

                  json.O['fields'].S['ProductName'] := ProdName;

                  { save the PO line xml in the SO Custom Data field
                    NOTE must be after product Name as bus obj clears
                         custome data when product set }
                  json.O['fields'].S['CustomData'] := node.XML;

                  if not Mapper.MapXmlToJson(node,json,msg) then begin
                    Error('Error mapping Pip3A4PurchaseOrderRequest to ERP JSON format',msg,MessageInfo);
                    exit;
                  end;
                  json.O['fields'].S['UnitOfMeasure'] := UOMName;

                  { price received is UOM price eg price for "pack of 10" ..}
                  { need to convert to unit price  }
                  if (json.O['fields'].F['LinePrice'] <> 0) and (UOMMult <> 1) and (UOMMult <> 0) then begin
                    json.O['fields'].F['LinePrice'] := json.O['fields'].F['LinePrice'] / UOMMult;
                  end;


                  SO.O['fields'].A['Lines'].Add(json);

                  { for first line only do this .. }
                  if SO.O['fields'].A['Lines'].Count = 1 then begin
                    if SO.O['fields'].S['Comments'] <> '' then
                      SO.O['fields'].S['Comments'] := SO.O['fields'].S['Comments'] + #13#10;
                    SO.O['fields'].S['Comments'] := SO.O['fields'].S['Comments'] + json.O['fields'].S['MemoLine'];
                  end;

                end;
              end;


//              if not Mapper.MapXmlToJson(xmlDoc.DocumentElement,SO, msg) then begin
//                Error('Error mapping Pip3A4PurchaseOrderRequest to ERP JSON format',msg,MessageInfo);
//                exit;
//              end;


            finally
              Mapper.Free;
            end;


            MessageInfo.AddDocument('ERP Salses Order.txt',JsonToStrFormat(SO));
            SOId := ERP.SaveObject(SO);
            Log('Sales Order Number '+IntToStr(SOId)+' created in ERP', ltDetail);
            MessageInfo.Info.Values['Sales Order ID'] := IntToStr(SOId);

            { now need to save PO xml doc in ERP  }

            MIMEEncoder := TIdEncoderMIME.Create(nil);
            Stream := TMemoryStream.Create;
            try
              Attachment.S['type'] := 'TAttachment';
              Attachment.O['fields'].S['AttachmentName'] := 'Pip3A4PurchaseOrderRequest.xml';
              Attachment.O['fields'].S['Description'] := 'EDI Purchase Order Request';
              Attachment.O['fields'].S['TableName'] := 'tblSales';
              Attachment.O['fields'].I['TableId'] := SOId;
              xmlDoc.SaveToStream(Stream);
              Stream.Position := 0;
              Attachment.O['fields'].S['Attachment'] := MIMEEncoder.Encode(Stream);
            finally
              MIMEEncoder.Free;
              Stream.Free;
            end;;

            AttachmentId := ERP.SaveObject(Attachment);
            Log('Attachment Number '+IntToStr(AttachmentId)+' created in ERP', ltDetail);
            MessageInfo.Info.Values['Attachment ID'] := IntToStr(AttachmentId);

    //        xmlConfirmation:= CreatePip3A4PurchaseOrderConfirmation(xmlDoc, SOId,msg);
    //        if not Assigned(xmlConfirmation) then begin
    //
    //        end;
    //        MessageInfo.AddDocument('Confirmation.xml',xmlConfirmation);

            if Assigned(MessageInfo.Receipt) then begin
              TElAS2Receipt(MessageInfo.Receipt).Text := 'Your message has been received and processed successfully';
            end;

            result := true;

          finally
            SO.Free;
            Attachment.Free;
          end;
        end
        else if SameText(xmlDoc.DocumentElement.NodeName,'Pip3C6RemittanceAdviceNotification') then begin
          { Remitance Advice }
          invList := nil;
          BankList := nil;
          userList := nil;
          Payment := JO;
          Mapper := TJsonXmlMapper.Create;
          try
            Mapper.XMLMapType := xtRosettaNet;
            Payment.S['type'] := 'TCustomerPayment';
            userList := ERP.GetList('TUser','[LogonName]="'+Config.O['WebAPI'].S['ERPUserName']+'"','LogonName,EmployeeName');

            if userList.A['TUser'].Count = 0 then begin
              Error('User not found','Could not find Employee Name for user: ' + Config.O['WebAPI'].S['ERPUserName'],MessageInfo);
              exit;
            end;


            Payment.O['fields'].S['EmployeeName'] := userList.A['TUser'].Items[0].AsObject.S['EmployeeName'];

            CustName := GetNodeVal(xmlDoc.DocumentElement,'fromRole.PartnerRoleDescription.PartnerDescription.BusinessDescription.businessName.FreeFormText');
            if CustName = '' then begin
              Error('Could not read customer name from Remitance Advice.', 'Customer not found for path fromRole.PartnerDescription.BusinessDescription.businessName.FreeFormText',MessageInfo);
              exit;
            end;

            Payment.O['fields'].S['CompanyName'] := CustName;

            { get a list of outstanding invoices for this customer from ERP }
            // ?select=([CustomerName] = "Ian Blakeley") and ([TotalBalance] <> 0) and ([Deleted] = false) &PropertyList=TotalBalance
            invList := ERP.GetList('TInvoice','([TotalBalance]<>0 and [Deleted]="false" and [CustomerName]="' + CustName + '")','DocNumber,TotalAmountInc,TotalBalance,TotalPaid');
            if invList.A['TInvoice'].Count = 0 then begin
              Error('No outstanding invoices found.','No outstanding invoices found for customer: "' + CustName + '".',MessageInfo);
              exit;
            end;

            { get account information for bank accounts }
            // TAccount?select=[AccountTypeName]="Bank"&PropertyList=AccountName,BankAccountName,BankAccountNumber,BSB
            BankList := ERP.GetList('TAccount','[AccountTypeName]="Bank"','AccountName,BankAccountName,BankAccountNumber,BSB');

            Payment.O['fields'].S['PaymentMethodName'] := 'E.F.T.';

            // AccountNo, AccountBSB
            AccountNo := GetNodeVal(RootNode(xmlDoc),'RemittanceAdvice.PaymentOrder.transferTo.AccountDescription.AccountNumber');
            if AccountNo = '' then begin
              Error('Missing XML element in Pip3C6RemittanceAdviceNotification','Could not find RemittanceAdvice.PaymentOrder.transferTo.AccountDescription.AccountNaumber Node',MessageInfo);
              exit;
            end;
            AccountBSB := GetNodeVal(RootNode(xmlDoc),'RemittanceAdvice.PaymentOrder.transferTo.AccountDescription.FundTransferRoutingNumber');
            if AccountBSB = '' then begin
              Error('Missing XML element in Pip3C6RemittanceAdviceNotification','Could not find RemittanceAdvice.PaymentOrder.transferTo.AccountDescription.FundTransferRoutingNumber Node',MessageInfo);
              exit;
            end;
            { find the bank account that the money was paid into }
            GLAccountName := '';
            for x := 0 to BankList.A['TAccount'].Count -1 do begin
              JLI := BankList.A['TAccount'].Items[x].AsObject;
              if (RemoveLeadingZeros(AccountNo) = RemoveLeadingZeros(Trim(JLI.S['BankAccountNumber']))) and
                 (StripNonIntChars(AccountBSB) = StripNonIntChars(Trim(JLI.S['BSB']))) then begin
                GLAccountName := JLI.S['AccountName'];
                break;
              end;
            end;
            if GLAccountName = '' then begin
              Error('Unknown bank account','The bank account used for the remittance payment is unknown in ERP, Account No: ' + AccountNo + ' BSB: ' + AccountBSB,MessageInfo);
              exit;
            end;
            Payment.O['fields'].S['AccountName']:= GLAccountName;

            Mapper.Clear;
            Mapper.AddMapping('ForeignExchangeCode','RemittanceAdvice.PaymentOrder.totalInvoiceAmount.FinancialAmount.GlobalCurrencyCode');
            Mapper.AddMapping('Amount','RemittanceAdvice.PaymentOrder.totalInvoiceAmount.FinancialAmount.MonetaryAmount');
            Mapper.AddMapping('Applied','RemittanceAdvice.PaymentOrder.totalInvoiceAmount.FinancialAmount.MonetaryAmount');
            Mapper.AddMapping('ReferenceNo','thisDocumentIdentifier.ProprietaryDocumentIdentifier');
            Mapper.AddMapping('PaymentDate','thisDocumentGenerationDateTime.DateTimeStamp');
            if not Mapper.MapXmlToJson(RootNode(xmlDoc),Payment.O['fields'], msg) then begin
              Error('Error mapping Pip3C6RemittanceAdviceNotification to ERP JSON format',msg,MessageInfo);
              exit;
            end;
            if not SameText(Payment.O['fields'].S['ForeignExchangeCode'],'AUD') then begin
              Error('Error mapping Pip3C6RemittanceAdviceNotification to ERP, payments in foreign currencies not supported.', 'Currency code ' + Payment.O['fields'].S['ForeignExchangeCode'] + ' not supported.', MessageInfo);
              exit;
            end;

            RemittanceAdviceNode := GetNode(RootNode(xmlDoc),'RemittanceAdvice');

            {  lines }
            PaymentTotal := 0;
            RefNoList := '';
            Mapper.Clear;
            Mapper.AddMapping('Payment','paymentAmount.FinancialAmount.MonetaryAmount');
            for x:= 0 to RemittanceAdviceNode.ChildNodes.Count -1 do begin
              RemittanceLineItemNode := RemittanceAdviceNode.ChildNodes.Nodes[x];
              if SameText(RemittanceLineItemNode.NodeName,'RemittanceLineItem') then begin
                { can have multiple propriority doc refe nos .. }
                InvoiceFound := false;
//                for y := 0 to RemittanceLineItemNode.ChildNodes.Count - 1 do begin
//                  node := RemittanceLineItemNode.ChildNodes[y];
//                  InvRefNo := GetNodeVal(node,'ProprietaryDocumentIdentifier');
                  InvRefNo := GetNodeVal(RemittanceLineItemNode,'ProprietaryDocumentIdentifier');
                  if InvRefNo = '' then begin
                    Error('Error mapping Pip3C6RemittanceAdviceNotification to ERP, ProprietaryDocumentIdentifier (Invoice Number) not found.',
                      'ProprietaryDocumentIdentifier (Invoice Number) not found / blank for RemittanceLineItem.', MessageInfo);
                    exit;
                  end
                  else begin
                    if RefNoList <> '' then RefNoList :=  RefNoList + ',';
                    RefNoList := RefNoList + InvRefNo;
                    { do we have this invoice in our list of unpaid invoices }
                    for z := 0 to invList.A['TInvoice'].Count -1 do begin
                      JLI := invList.A['TInvoice'].Items[z].AsObject;
                      if SameText(InvRefNo,JLI.S['DocNumber']) then begin
                        { found the invoice they are paying .. }
                        InvoiceFound := true;
                        PaymentLine := JO;
                        PaymentLine.S['type'] := 'TCustomerPaymentLine';

                        PaymentLine.O['fields'].I['InvoiceId'] := JLI.I['Id'];
                        if not Mapper.MapXmlToJson(RemittanceLineItemNode,PaymentLine.O['fields'],msg) then begin
                          Error('Error mapping Pip3C6RemittanceAdviceNotification to ERP JSON format',msg,MessageInfo);
                          exit;
                        end;
                        PaymentTotal := PaymentTotal + PaymentLine.O['fields'].F['Payment'];

                        Payment.O['fields'].A['Lines'].Add(PaymentLine);
                        Break;
                      end;
                    end;
                  end;
//                end;
                if not InvoiceFound then begin
                  { error }
                  Error('Unable to identify ERP invoice for payment.','Could not find an unpaid invoice in ERP for reference number(s) provided ' + RefNoList,MessageInfo);
                  exit;
                end;
              end;
            end;
            { finished lines }

            if PaymentTotal <> Payment.O['fields'].F['Amount'] then  begin
              Error('Payment lines total does not match total amount.', 'The sum of the payment lines ' + FloatToStr(PaymentTotal) + ' does not match the remittance total ' + FloatToStr(Payment.O['fields'].F['Amount']), MessageInfo);
              exit;
            end;

            { all good so send payment to ERP }

            MessageInfo.AddDocument('ERP Customer Payment.txt',JsonToStrFormat(Payment));
            PaymentId := ERP.SaveObject(Payment);
            Log('Customer Payment Number '+IntToStr(PaymentId)+' created in ERP', ltDetail);
            MessageInfo.Info.Values['Customer Payment ID'] := IntToStr(PaymentId);

            if Assigned(MessageInfo.Receipt) then begin
              TElAS2Receipt(MessageInfo.Receipt).Text := 'Your message has been received and processed successfully';
            end;

            result := true;

          finally
            Payment.Free;
            invList.Free;
            BankList.Free;
            Mapper.Free;
            userList.Free;
          end;
        end
        else begin
          Error('Request type is not supported by ERP RosettaNet connector','Document type: ' + xmlDoc.DocumentElement.NodeName,MessageInfo);
          result := true;
          exit;
        end;
      finally
        xmlDoc:= nil;
        CoUninitialize;

      end;

    except
      on e: TERPWebApiException do begin
        Error(e.Message,e.DetailMessage,MessageInfo);
      end;
      on e: Exception do begin
        Error(e.Message,'',MessageInfo);
      end;
    end;
  finally
    { if we have a mdn reveipt we need to send it back here }
    if Assigned(MessageInfo.Receipt) then begin
      if MessageInfo.Info.Values['mdnURL'] <> '' then begin
//        AS2Client := TAS2Client.Create;
        try
//          AS2Client.OnError := Error;
//          AS2Client.Logger:= fLogger;
//          AS2Client.OutboundMessageFolder := ExtractFilePath(GetCurrentModuleName)+'\Outbound';
//          path:= ExtractFilePath(GetCurrentModuleName);
//          AS2Client.AddServerCertificate(path + 'VerisignCA.der.cer');
//          AS2Client.AddServerCertificate(path + 'VerisignIntermediary.der.cer');
//          AS2Client.AddServerCertificate(path + 'receiver.b2b.telstra.com.der.cer');
//          AS2Client.AddClientCertificate(path + 'adhere.adherepromotions.com.au.DER.cer', path + 'private.key');
          if TElAS2Receipt(MessageInfo.Receipt).errors.Status = dsFailed then
            TElAS2Receipt(MessageInfo.Receipt).Text := 'Your message was received successfully but errors have occurred during processing.';
          {$IFNDEF DISABLE_RECEIPT}
          i := 0;
          { remove warnings! }
          while i < TElAS2Receipt(MessageInfo.Receipt).Errors.Count do begin
            if TElAS2Receipt(MessageInfo.Receipt).Errors.Items[i].Modifier = dmWarning then
              TElAS2Receipt(MessageInfo.Receipt).Errors.Delete(i)
            else
              Inc(i);
          end;


          if not AS2Client.SendReceipt(MessageInfo.Info.Values['mdnURL'],TElAS2Receipt(MessageInfo.Receipt)) then begin
            //exit;
          end;
          {$ENDIF}
        finally
//          AS2Client.Free;
        end;
      end
      else begin
        Error('Could not send receipt.','Receipt URL not specified.',MessageInfo);
      end;

    end;
  end;
end;

function TRosettaNetConnector.RoseettaNetConfigPage(msg: string): string;
var
  form: string;
  SendInvoicesChecked: string;
begin
  if Config.O['RosettaNet'].B['SendInvoices'] then
    SendInvoicesChecked := 'checked'
  else
    SendInvoicesChecked := '';

  form :=
    '<form class="feedbackform" action="rosettanetconfig" method="post">' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="ServerPort" class="styled">B2B Server Port:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="text" id="ServerPort" value="' + IntToStr(Config.O['RosettaNet'].I['ServerPort']) + '" name="ServerPort" size="20" /><br />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="exempttaxcode" class="styled">Exempt Tax Code:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="text" id="exempttaxcode" value="' + Config.O['RosettaNet'].S['ExemptTaxCode'] + '" name="exempttaxcode" size="30" /><br />' + #13#10 +
		'<span style="font-size: 90%">*Note: This must be the Exempt Tax Code defined in ERP</span>' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

(*
    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="GlobalSupplyChainCode" class="styled">Global Supply Chain Code:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="text" id="GlobalSupplyChainCode" value="' + Config.O['RosettaNet'].S['GlobalSupplyChainCode'] + '" name="GlobalSupplyChainCode" size="30" /><br />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +
*)
(*
    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="DUNS" class="styled">DUNs Number:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="text" id="DUNS" value="' + Config.O['RosettaNet'].S['DUNS'] + '" name="DUNS" size="30" /><br />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +
*)
    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="sendinvoices" class="styled">Send Invoices:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="checkbox" id="sendinvoices" value="true" name="sendinvoices" ' + SendInvoicesChecked + '/>' + #13#10 +
    '<input type="hidden" value="false" name="sendinvoices.hidden"/>'  + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<hr>' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="adminemailaddress" class="styled">Admin Email:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="email" id="adminemailaddress" value="' + Config.O['RosettaNet'].S['AdminEmailAddress'] + '" name="adminemailaddress" size="30" /><br />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="smtpserver" class="styled">SMTP Mail Server:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="text" id="smtpserver" value="' + Config.O['RosettaNet'].S['SMTPServer'] + '" name="smtpserver" size="30" /><br />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="smtpport" class="styled">SMTP Server Port:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="number" id="smtpport" value="' + IntToStr(Config.O['RosettaNet'].I['SMTPPort']) + '" name="smtpport" size="10" />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="smtpusername" class="styled">SMTP User Name:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="text" id="smtpusername" value="' + Config.O['RosettaNet'].S['SMTPUserName'] + '" name="smtpusername" size="30" />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="smtppassword" class="styled">SMTP Password:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="text" id="smtppassword" value="' + Config.O['RosettaNet'].S['SMTPPassword'] + '" name="smtppassword" size="30" />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="buttonsdiv">' + #13#10 +
	  '<input type="submit" value="Save" name="button" style="margin-left: 150px;" /><input type="submit" value="Test Email" name="button" />' + #13#10 +
    '</div>' + #13#10 +
    '</form>';

  result:= self.MakePage('RosettaNet Config','<h1>RosettaNet Config</h1>',msg+form, true);
end;

procedure TRosettaNetConnector.SendInvoice(const InvId: integer);
var
  MessageInfo: TMessageInfo;
  Inv, InvLine, Cust, AttachmentList, Attachment, CompanyInfo: TJsonObject;
  sl: TStringList;
//  PODoc,
  InvDoc: IXMLDocument;
  MIMEDecoder: TIdDecoderMIME;
  LineNo: integer;
  POLine: IXMLDocument;
  GlobalLocationIdentifier: string;
//  AS2Client: TAS2Client;
  MemStream: TMemoryStream;
  AnsiStr: AnsiString;
//  StrStream: TStringStream;
  FDataString: AnsiString;
  dt: TDateTime;
  x: integer;
  ShippedFound: boolean;


//  function GetPOLine(aLineIdx: integer; aProdName: string): IXMLNode;
//  var
//    subIdx, currIdx, x, y: integer;
//    subPO, node1, node2: IXMLNode;
//  begin
//    result := nil;
//    currIdx := -1;
//    for subIdx := 0 to subPO.ChildNodes.Count -1 do begin
//      if subPO.ChildNodes[subIdx].NodeName = 'ProductLineItem' then begin
//        Inc(currIdx);
//        if currIdx = aLineIdx then begin
//          for x := 0 to subPO.ChildNodes[subIdx].ChildNodes.Count -1 do begin
//            node1 := subPO.ChildNodes[subIdx].ChildNodes[x];
//            if SameText(node1.NodeName,'ProductIdentification') then begin
//              for y := 0 to node1.ChildNodes.Count -1 do begin
//                node2 := node1.ChildNodes[y];
//                if SameText(node2.NodeName, 'PartnerProductIdentification') then begin
//                  if SameText(GetNodeVal(node2,'ProprietaryProductIdentifier'),aProdName) then begin
//                    result:= subPO.ChildNodes[subIdx];
//                    exit;
//                  end;
//                end;
//              end;
//            end;
//          end;
//        end;
//      end;
//    end;
//  end;

  function CustGlobalBusinessIdentifier: string;
  var
    cfIdx: integer;
    cf: TJsonObject;
  begin
    result := '';
    for cfIdx := 0 to Cust.O['fields'].A['ClientCustomFieldValues'].Count -1 do begin
      cf := Cust.O['fields'].A['ClientCustomFieldValues'].Items[cfIdx].AsObject;
      if SameText(cf.O['fields'].S['Description'],'Global Business Identifier') then begin
        result := cf.O['fields'].S['Value'];
        break;
      end;
    end;
  end;

  function CustB2BURL: string;
  var
    cfIdx: integer;
    cf: TJsonObject;
  begin
    result := '';
    for cfIdx := 0 to Cust.O['fields'].A['ClientCustomFieldValues'].Count -1 do begin
      cf := Cust.O['fields'].A['ClientCustomFieldValues'].Items[cfIdx].AsObject;
      if SameText(cf.O['fields'].S['Description'],'B2B URL') then begin
        result := cf.O['fields'].S['Value'];
        break;
      end;
    end;
  end;

  procedure FlagAsSent;
  var
    PrintDoc: TJsonObject;
  begin
    {  flag as sent in ERP }
    PrintDoc := JO('{"type":"TInvoicePrintDoc"}');
    try
      PrintDoc.O['fields'].S['DocOutputType'] := 'dotEDI';
      PrintDoc.O['fields'].I['DocId'] := InvId;
      PrintDoc.O['fields'].S['PrintedFrom'] := 'RosettaNet Connector';
      ERP.SaveObject(PrintDoc);
    finally
      PrintDoc.Free;
    end;
  end;

begin
  MessageInfo := TMessageInfo.NewInst(ExtractFilePath(GetCurrentModuleName)+'\Outbound\History','Invoice_'+ IntToStr(InvId)+'_' + FormatDateTime('yyyy_mm_dd-hh-nn-ss-zzz',now));
  MessageInfo.Info.Values['ERP Invoice Number'] := IntToStr(InvId);
  try
    try
      Inv := nil;
      Cust := nil;
      AttachmentList := nil;
      Attachment := nil;
      CompanyInfo := nil;
      sl := TStringList.Create;
      POLine := TXMLDocument.Create(nil);
      Coinitialize(nil);
      try
        Inv := ERP.GetObject('TInvoice',InvId);
        if Assigned(Inv) then begin
          if not Inv.O['fields'].ArrayExists('Lines') then begin
            Log('Invoice contains no lines, does not require processing.',ltDetail);
            FlagAsSent;
            exit;
          end
          else begin
            { need at least one line shipped }
            ShippedFound := false;
            for x := 0 to Inv.O['fields'].A['Lines'].Count -1 do begin
              if Inv.O['fields'].A['Lines'].Items[x].AsObject.O['fields'].F['UOMQtyShipped'] <> 0 then begin
                ShippedFound := true;
                break;
              end;
            end;
            if not ShippedFound then begin
              Log('All lines on Invoice are back ordered, skipping processing.',ltDetail);
              exit;
            end;
          end;

          CompanyInfo:= ERP.CompanyInfo;
          if Trim(CompanyInfo.O['fields'].S['CompanyNumber']) = '' then begin
            Error('The Company Number is blank in ERP Company Information',
              'The Company Number is the GlobalBusinessIdentifier (Dunns Number) used in messages, can not send message without this.',MessageInfo);
            exit;
          end;


          { Customer  }
          Cust := ERP.GetObject('TCustomer',Inv.O['fields'].S['ClientName']);
          if CustGlobalBusinessIdentifier = '' then begin
            Error('Global Business Identifier not defined for customer ' + Cust.O['fields'].S['ClientName'],
            'Customer Custom field either not defined or is blank for "Global Business Identifier"',MessageInfo);
            exit;
          end;
          if CustB2BURL = '' then begin
            Error('B2B URL not defined for customer ' + Cust.O['fields'].S['ClientName'],
            'Customer Custom field either not defined or is blank for "B2B URL"',MessageInfo);
            exit;
          end;
//          { get original PO doc }
//          AttachmentList := ERP.GetList('TAttachment','([TableId] = '+IntToStr(InvId)+' and [TableName] = "tblSales" and [AttachmentName] = "Pip3A4PurchaseOrderRequest.xml")');
//          if AttachmentList.A['TAttachment'].Count = 0 then begin
//            Error('Error getting Invoice information from ERP for Invoice ' + IntToStr(InvId),'Could not find Invoice attachment (Pip3A4PurchaseOrderRequest.xml)',MessageInfo);
//            exit;
//          end;
//          Attachment := ERP.GetObject('TAttachment',AttachmentList.A['TAttachment'].Items[0].AsObject.I['ID']);
//          PODoc:= TXMLDocument.Create(nil);
//          MIMEDecoder := TIdDecoderMIME.Create(nil);
//          try
//            PODoc.XML.Text := MIMEDecoder.DecodeString(Attachment.O['fields'].S['Attachment']);
//            PODoc.Active := true;
//          finally
//            MIMEDecoder.Free;
//          end;

          sl.Add('<?xml version="1.0" encoding="utf-8"?>');
          sl.Add('<!DOCTYPE Pip3C3InvoiceNotification SYSTEM "3C3_MS_V01_01_InvoiceNotification.dtd">');
          sl.Add('<Pip3C3InvoiceNotification>');
          sl.Add('	<fromRole>');
          sl.Add('		<PartnerRoleDescription>');

          sl.Add('		  <ContactInformation>');
          sl.Add('		    <contactName>');
          sl.Add('          <FreeFormText>' + CompanyInfo.O['fields'].S['CompanyName'] + '</FreeFormText>');
          sl.Add('		    </contactName>');
          sl.Add('		    <EmailAddress>' + CompanyInfo.O['fields'].S['Email'] + '</EmailAddress>');
          sl.Add('		    <telephoneNumber>');
          sl.Add('		     <CommunicationsNumber>' + CompanyInfo.O['fields'].S['PhoneNumber'] + '</CommunicationsNumber>');
          sl.Add('		    </telephoneNumber>');
          sl.Add('		  </ContactInformation>');

          sl.Add('			<GlobalPartnerRoleClassificationCode>Invoice Provider</GlobalPartnerRoleClassificationCode>');

          sl.Add('			<PartnerDescription>');
          sl.Add('				<BusinessDescription>');
          sl.Add('          <GlobalBusinessIdentifier>' + CompanyInfo.O['fields'].S['CompanyNumber'] + '</GlobalBusinessIdentifier>');
          sl.Add('				  <businessName>');
          sl.Add('            <FreeFormText>' + CompanyInfo.O['fields'].S['CompanyName'] + '</FreeFormText>');
          sl.Add('				  </businessName>');
          sl.Add('				  <PartnerBusinessIdentification>');
          sl.Add('			  	  <ProprietaryBusinessIdentifier>' + CompanyInfo.O['fields'].S['ABN'] + '</ProprietaryBusinessIdentifier>');
          sl.Add('		  		  <ProprietaryDomainIdentifier>ABN</ProprietaryDomainIdentifier>');
          sl.Add('				  </PartnerBusinessIdentification>');
          sl.Add('				</BusinessDescription>');
//          sl.Add('				<GlobalPartnerClassificationCode>' + Config.O['RosettaNet'].S['GlobalSupplyChainCode'] + '</GlobalPartnerClassificationCode>');
          sl.Add('				<GlobalPartnerClassificationCode>' + 'Manufacturer' + '</GlobalPartnerClassificationCode>');
          sl.Add('			</PartnerDescription>');

          sl.Add('		</PartnerRoleDescription>');
          sl.Add('	</fromRole>');

          sl.Add('	<GlobalDocumentFunctionCode>Request</GlobalDocumentFunctionCode>');

          sl.Add('	<Invoice>');
//          sl.Add('    <proprietaryInformation>');
//          sl.Add('      <FreeFormText>Tax Invoice</FreeFormText>');
//          sl.Add('    </proprietaryInformation>');

          sl.Add('		<billFrom>');
          sl.Add('			<PartnerTaxDescription>');
//          GlobalLocationIdentifier := GetNodeVal(PODoc.DocumentElement,'PurchaseOrder.AccountDescription.billTo.PartnerRoleDescription.ContactInformation.PhysicalAddress.GlobalLocationIdentifier');
//          if GlobalLocationIdentifier <> '' then begin
//            sl.Add('			  <PhysicalLocation>');
//            sl.Add('			    <GlobalLocationIdentifier>' + GlobalLocationIdentifier + '</GlobalLocationIdentifier>');
//            sl.Add('			  </PhysicalLocation>');
//          end;
          sl.Add('				<BusinessDescription>');
          sl.Add('				  <businessName>');
          sl.Add('				    <FreeFormText>' + CompanyInfo.O['fields'].S['CompanyName'] + '</FreeFormText>');
          sl.Add('				  </businessName>');
          sl.Add('				</BusinessDescription>');
//          sl.Add('				<GlobalPartnerClassificationCode>' + Config.O['RosettaNet'].S['GlobalSupplyChainCode'] + '</GlobalPartnerClassificationCode>');
          sl.Add('				<GlobalPartnerClassificationCode>' + 'Manufacturer' + '</GlobalPartnerClassificationCode>');
          sl.Add('			</PartnerTaxDescription>');
          sl.Add('		</billFrom>');

          sl.Add('		<billTo>');
          sl.Add('			<PartnerTaxDescription>');

          sl.Add('				<BusinessDescription>');

          sl.Add('				  <businessName>');
          sl.Add('				    <FreeFormText>' + Cust.O['fields'].S['ClientName'] + '</FreeFormText>');
          sl.Add('				  </businessName>');

          sl.Add('				</BusinessDescription>');
          sl.Add('				<GlobalPartnerClassificationCode>Manufacturer</GlobalPartnerClassificationCode>');

          sl.Add('				<PhysicalLocation>');
          sl.Add('	   			<PhysicalAddress>');
          if Cust.O['fields'].S['BillStreet'] <> '' then begin
            sl.Add('	   		  	<addressLine1>');
            sl.Add('	     		  	<FreeFormText>' + Cust.O['fields'].S['BillStreet'] + '</FreeFormText>');
            sl.Add('	   		  	</addressLine1>');
          end;
          if Cust.O['fields'].S['BillStreet2'] <> '' then begin
            sl.Add('	   		  	<addressLine2>');
            sl.Add('	     		  	<FreeFormText>' + Cust.O['fields'].S['BillStreet2'] + '</FreeFormText>');
            sl.Add('	   		  	</addressLine2>');
          end;
          if Cust.O['fields'].S['BillStreet3'] <> '' then begin
            sl.Add('	   		  	<addressLine3>');
            sl.Add('	     		  	<FreeFormText>' + Cust.O['fields'].S['BillStreet3'] + '</FreeFormText>');
            sl.Add('	   		  	</addressLine3>');
          end;
          sl.Add('	   		  	<cityName>');
          sl.Add('	   		  	  <FreeFormText>' + Cust.O['fields'].S['BillSuburb'] + '</FreeFormText>');
          sl.Add('	   		  	</cityName>');
          sl.Add('	   		  	<GlobalCountryCode>' + TCountryCode.CountryCode(Cust.O['fields'].S['BillCountry']) + '</GlobalCountryCode>');
          sl.Add('	   		  	<NationalPostalCode>' + Cust.O['fields'].S['BillPostcode'] + '</NationalPostalCode>');
          sl.Add('	   		  	<regionName>');
          sl.Add('	     		  	<FreeFormText>' + Cust.O['fields'].S['BillState'] + '</FreeFormText>');
          sl.Add('	   		  	</regionName>');

          sl.Add('	   			</PhysicalAddress>');
          sl.Add('				</PhysicalLocation>');

          sl.Add('			</PartnerTaxDescription>');
          sl.Add('		</billTo>');

          sl.Add('		<GlobalDocumentTypeCode>Invoice</GlobalDocumentTypeCode>');

          { line items ... }
          for LineNo := 0 to Inv.O['fields'].A['Lines'].Count - 1 do begin
            InvLine := Inv.O['fields'].A['Lines'].Items[LineNo].AsObject;

            { don't include zero quantity lines (ie backorders) }
            if InvLine.O['fields'].F['UOMQtyShipped'] = 0 then
              continue;

            if InvLine.O['fields'].S['CustomData'] <> '' then begin
              POLine.XML.Text := InvLine.O['fields'].S['CustomData'];
              POLine.Active := true;
            end;
//            POLine := GetPOLine(LineNo,InvLine.O['fields'].S['ProductName']);
//            if not Assigned(POLine) then begin
//              Error('Could not find line on Purchase Order','Could not find Invoice line ' + IntToStr(LineNo + 1) +
//                ' for product ' + InvLine.O['fields'].S['ProductName'] + ' on clients original Purchase Oreder', MessageInfo);
//              exit;
//            end;

            sl.Add('		<InvoiceLineItem>');
            sl.Add('		  <invoiceAmount>');
            sl.Add('		    <FinancialAmount>');
            sl.Add('		      <GlobalCurrencyCode>' + Inv.O['fields'].S['ForeignExchangeCode'] + '</GlobalCurrencyCode>');
            sl.Add('		      <GlobalMonetaryAmountTypeCode>Debit</GlobalMonetaryAmountTypeCode>');
            sl.Add('		      <InvoiceChargeTypeCode>Allowances and Charges</InvoiceChargeTypeCode>');
            sl.Add('		      <MonetaryAmount>' + FloatToStr(InvLine.O['fields'].F['TotalLineAmount']) + '</MonetaryAmount>');
            sl.Add('		    </FinancialAmount>');
            sl.Add('		  </invoiceAmount>');
            sl.Add('			<LineNumber>' + IntToStr(LineNo+1) + '</LineNumber>');

            sl.Add('			<OrderStatus>');
            sl.Add('				<PurchaseOrder>');
            sl.Add('					<ProductLineItem>');

            if InvLine.O['fields'].S['CustomData'] <> '' then begin
              sl.Add('						<GlobalProductUnitOfMeasureCode>' + GetNodeVal(POLine.DocumentElement,'GlobalProductUnitOfMeasureCode') + '</GlobalProductUnitOfMeasureCode>');
              sl.Add('						<LineNumber>' + GetNodeVal(POLine.DocumentElement,'LineNumber') + '</LineNumber>');
            end;

            sl.Add('						<ProductDescription>');
            sl.Add('							<ProductIdentification>');
            sl.Add('                <PartnerProductIdentification>');
            sl.Add('                  <GlobalPartnerClassificationCode>Manufacturer</GlobalPartnerClassificationCode>');
            sl.Add('                  <ProprietaryProductIdentifier>' + InvLine.O['fields'].S['ProductName'] + '</ProprietaryProductIdentifier>');
            sl.Add('                </PartnerProductIdentification>');
            sl.Add('							</ProductIdentification>');
            sl.Add('						</ProductDescription>');

            sl.Add('						<ProductQuantity>' + FloatToStr(InvLine.O['fields'].F['UOMQtyShipped']) + '</ProductQuantity>');

            sl.Add('						<TaxSummary>');
            sl.Add('						  <NationalTax>');
            sl.Add('						    <FinancialAmount>');
            sl.Add('						      <GlobalCurrencyCode>' + Inv.O['fields'].S['ForeignExchangeCode'] + '</GlobalCurrencyCode>');
            sl.Add('						      <GlobalMonetaryAmountTypeCode>Debit</GlobalMonetaryAmountTypeCode>');
            sl.Add('						      <MonetaryAmount>' + FloatToStr(InvLine.O['fields'].F['LinePrice']) + '</MonetaryAmount>');
            sl.Add('						    </FinancialAmount>');
            sl.Add('						    <NationalBusinessTaxIdentifier>');
            sl.Add('						      <BusinessTaxIdentifier>' + CompanyInfo.O['fields'].S['ABN'] + '</BusinessTaxIdentifier>');
            sl.Add('						      <GlobalCountryCode>' + TCountryCode.CountryCode(CompanyInfo.O['fields'].S['Country']) + '</GlobalCountryCode>');
            sl.Add('						    </NationalBusinessTaxIdentifier>');
            sl.Add('						    <taxRate>');
            sl.Add('						      <PercentAmount>' + FloatToStr(InvLine.O['fields'].F['LineTaxRate']*100) + '</PercentAmount>');
            sl.Add('						    </taxRate>');
            sl.Add('						  </NationalTax>');
            sl.Add('						</TaxSummary>');


            sl.Add('						<unitPrice>');
            sl.Add('							<FinancialAmount>');
            sl.Add('								<GlobalCurrencyCode>' + Inv.O['fields'].S['ForeignExchangeCode'] + '</GlobalCurrencyCode>');
            sl.Add('						    <GlobalMonetaryAmountTypeCode>Debit</GlobalMonetaryAmountTypeCode>');
            sl.Add('								<MonetaryAmount>' + FloatToStr(InvLine.O['fields'].F['TotalLineAmount']) + '</MonetaryAmount>');
            sl.Add('							</FinancialAmount>');
            sl.Add('						</unitPrice>');

            sl.Add('					</ProductLineItem>');

            sl.Add('          <purchaseOrderNumber>');
            sl.Add('            <ProprietaryDocumentIdentifier>' + Inv.O['fields'].S['CustPONumber'] + '</ProprietaryDocumentIdentifier>');
            sl.Add('          </purchaseOrderNumber>');

            sl.Add('				</PurchaseOrder>');
            sl.Add('			</OrderStatus>');

            sl.Add('			<packingSlipIdentifier>');
            sl.Add('			  <ProprietaryDocumentIdentifier>NA</ProprietaryDocumentIdentifier>');
            sl.Add('			</packingSlipIdentifier>');

            sl.Add('			<totalLineItemAmount>');
            sl.Add('				<FinancialAmount>');
            sl.Add('					<GlobalCurrencyCode>' + Inv.O['fields'].S['ForeignExchangeCode'] + '</GlobalCurrencyCode>');
            sl.Add('					<GlobalMonetaryAmountTypeCode>Debit</GlobalMonetaryAmountTypeCode>');
            sl.Add('					<MonetaryAmount>' + FloatToStr(InvLine.O['fields'].F['TotalLineAmountInc']) + '</MonetaryAmount>');
            sl.Add('				</FinancialAmount>');
            sl.Add('			</totalLineItemAmount>');
            sl.Add('		</InvoiceLineItem>');

          end; { end InvoiceLineItem  }

          sl.Add('		<isLockBoxUsed>');
          sl.Add('			<AffirmationIndicator>No</AffirmationIndicator>');
          sl.Add('		</isLockBoxUsed>');
          sl.Add('		<isRebill>');
          sl.Add('			<AffirmationIndicator>No</AffirmationIndicator>');
          sl.Add('		</isRebill>');

          sl.Add('		<soldToTax>');
          sl.Add('  		<TaxSummary>');
          sl.Add('    		<FinancialAmount>');
          sl.Add('       		<GlobalCurrencyCode>' + Inv.O['fields'].S['ForeignExchangeCode'] + '</GlobalCurrencyCode>');
          sl.Add('       		<GlobalMonetaryAmountTypeCode>Debit</GlobalMonetaryAmountTypeCode>');
          sl.Add('       		<MonetaryAmount>' + FloatToStr(Inv.O['fields'].F['TotalTax']) + '</MonetaryAmount>');
          sl.Add('    		</FinancialAmount>');
          sl.Add('  		</TaxSummary>');
          sl.Add('		</soldToTax>');

          sl.Add('		<totalInvoiceAmount>');
          sl.Add('			<FinancialAmount>');
          sl.Add('				<GlobalCurrencyCode>' + Inv.O['fields'].S['ForeignExchangeCode'] + '</GlobalCurrencyCode>');
          sl.Add('     		<GlobalMonetaryAmountTypeCode>Debit</GlobalMonetaryAmountTypeCode>');
          sl.Add('				<MonetaryAmount>' + FloatToStr(Inv.O['fields'].F['TotalAmountInc']) + '</MonetaryAmount>');
          sl.Add('			</FinancialAmount>');
          sl.Add('		</totalInvoiceAmount>');

          sl.Add('	</Invoice>');

          sl.Add('	<thisDocumentGenerationDateTime>');
          sl.Add('		<DateTimeStamp>' +DateTimeToISO8601(Inv.O['fields'].DT['SaleDateTime'],true) + '</DateTimeStamp>');
          sl.Add('	</thisDocumentGenerationDateTime>');
          sl.Add('	<thisDocumentIdentifier>');
          sl.Add('		<ProprietaryDocumentIdentifier>' + Inv.O['fields'].S['DocNumber'] + '</ProprietaryDocumentIdentifier>');
          sl.Add('	</thisDocumentIdentifier>');

          sl.Add('	<toRole>');
          sl.Add('		<PartnerRoleDescription>');
          sl.Add('			<GlobalPartnerRoleClassificationCode>Invoice Receiver</GlobalPartnerRoleClassificationCode>');
          sl.Add('			<PartnerDescription>');
          sl.Add('				<BusinessDescription>');
          sl.Add('				  <GlobalBusinessIdentifier>' + CustGlobalBusinessIdentifier + '</GlobalBusinessIdentifier>');
          sl.Add('				</BusinessDescription>');
          sl.Add('				<GlobalPartnerClassificationCode>End User</GlobalPartnerClassificationCode>');
          sl.Add('			</PartnerDescription>');
          sl.Add('		</PartnerRoleDescription>');
          sl.Add('	</toRole>');
          sl.Add('</Pip3C3InvoiceNotification>');

          InvDoc := TXMLDocument.Create(nil);
          try
            InvDoc.LoadFromXML(sl.Text);
            InvDoc.Active := true;
            MessageInfo.AddDocument('Pip3C3InvoiceNotification.xml',InvDoc);

            MemStream := TMemoryStream.Create;

            try
              AS2Client.OnError := Error;
              AS2Client.AS2From := CompanyInfo.O['fields'].S['CompanyNumber']; // Config.O['RosettaNet'].S['DUNS'];
              AS2Client.AS2To := CustGlobalBusinessIdentifier;
              AS2Client.Logger:= fLogger;
              AS2Client.Subject := 'Pip3C3InvoiceNotification';
              AS2Client.OutboundMessageFolder := ExtractFilePath(GetCurrentModuleName)+'\Outbound';

              MemStream.Position := 0;
//              dt := NowUTC;
//              sl.Clear;
//              sl.Add('Message-ID: <Invoice-'+IntToStr(InvId)+'-'+ FormatDateTime('yyyy-mm-dd-hh-nn-ss-zzz',dt) +  '>');
//              sl.Add('MIME-Version: 1.0');
//              sl.Add('Content-Type: multipart/related;');
//              sl.Add(#9 + 'boundry="---MessageBoundry";');
//              sl.Add(#9 + 'type="Application/x-RosettaNet"');
//              sl.Add('Content-Description: This is the RosettaNet Business Message');
//              sl.Add('Content-ID: "' + IntToStr(InvId) +FormatDateTime('yyyymmddhhnnsszz',dt) + '"');
//              sl.Add('');
//              sl.Add('---MessageBoundry');
//              sl.Add('Content-Type: Application/xml; rnsubtype=preamble-header; name=Preamble');
//              sl.Add('Content-Transfer-Encoding: binary');
//              sl.Add('Content-Disposition: attachment; filename=Preamble');
//              sl.Add('Content-ID: <Preamble.' + FormatDateTime('yyyymmddhhnnsszz',dt)+ '>');
//              sl.Add('Content-Description:  This is the Preamble Header part of the Business Message');
//              sl.Add('');
//              sl.Add('<?xml version="1.0" encoding="UTF-8"?>');
//              sl.Add('<!DOCTYPE Preamble SYSTEM "PreamblePartMessageGuideline.dtd">');
//              sl.Add('<Preabmble>');
//              sl.Add('    <DateTimeStamp>' + DateTimeToISO8601(NowUTC, True) + '</DateTimeStamp>');
//              sl.Add('    <GlobalAdministeringAuthorityCode>RosettaNet</GlobalAdministeringAuthorityCode>');
//              sl.Add('    <GlobalUsageCode>Production</GlobalUsageCode>');
//              sl.Add('    <VersionIdentifier>1.1</VersionIdentifier>');
//              sl.Add('</Preabmble>');
//              sl.Add('');
//              sl.Add('---MessageBoundry');
//              sl.Add('Content-Type: Application/xml; rnsubtype=service-header; name=ServiceHeader');
//              sl.Add('Content-Transfer-Encoding: binary');
//              sl.Add('Content-Disposition: attachment; filename=ServiceHeader');
//              sl.Add('Content-ID: <ServiceHeader.' + FormatDateTime('yyyymmddhhnnsszz',dt)+ '>');
//              sl.Add('Content-Description:  This is the Service Header part of the Business Message');
//              sl.Add('');
//
//              AnsiStr := sl.Text;
//              //sl.SaveToStream(StrStream);
//              MemStream.Write(PAnsiChar(AnsiStr)^, Length(AnsiStr));
//              //InvDoc.SaveToStream(StrStream);
//              AnsiStr := InvDoc.XML.Text;
//              MemStream.Write(PAnsiChar(AnsiStr)^, Length(AnsiStr));
//              sl.Clear;
//              sl.Add('---MessageBoundry');
////              sl.SaveToStream(StrStream);
//              AnsiStr := sl.Text;
//              MemStream.Write(PAnsiChar(AnsiStr)^, Length(AnsiStr));
//
//              MemStream.Position:= 0;
//              MemStream.SaveToFile('c:\temp\temp.txt');
//              MemStream.Position:= 0;

              InvDoc.SaveToStream(MemStream);
              MemStream.Position := 0;
              if not AS2Client.SendXMLDoc(CustB2BURL,MemStream, MessageInfo) then begin

                exit;
              end;
            finally
//              AS2Client.Free;
              MemStream.Free;
//              Msg.Free;
            end;
          finally
            InvDoc := nil;
          end;

          FlagAsSent;

          Log('Invoice ' + IntToStr(invId) + ' sent.',ltDetail);


        end;
      finally
        CoUninitialize;
        sl.Free;
        Inv.Free;
        Cust.Free;
        CompanyInfo.Free;
        AttachmentList.Free;
        Attachment.Free;
        POLine:= nil;
//        PODoc := nil;
      end;
    except
      on e: TERPWebApiException do begin
        Error(e.Message,e.DetailMessage,MessageInfo);
      end;
      on e: Exception do begin
        Error(e.Message,'',MessageInfo);
      end;
    end;
  finally
    MessageInfo.Save;
    MessageInfo.Free;
  end;
end;

function TRosettaNetConnector.SetConfigDefaults: boolean;
begin
  result := inherited;
  if not Config.O['RosettaNet'].Exists('ServerPort') then begin
    Config.O['RosettaNet'].I['ServerPort'] := 443;
    result:= true;
  end;
  if not Config.O['RosettaNet'].Exists('ExemptTaxCode') then begin
    Config.O['RosettaNet'].S['ExemptTaxCode'] := 'E';
    result:= true;
  end;
  if not Config.O['RosettaNet'].Exists('SMTPPort') then begin
    Config.O['RosettaNet'].I['SMTPPort'] := 25;
    result:= true;
  end;
end;


function TRosettaNetConnector.TestEmailConfig(var msg: string): boolean;
var
  SMTP: TIdSMTP;
  mail: TIdMessage;
begin
  result := true;
  SMTP := TIdSMTP.Create(nil);
  mail := TIdMessage.Create(nil);
  try
    SMTP.Host := Config.O['RosettaNet'].S['SMTPServer'];
    SMTP.Port := Config.O['RosettaNet'].I['SMTPPort'];
    SMTP.Username := Config.O['RosettaNet'].S['SMTPUserName'];
    SMTP.Password := Config.O['RosettaNet'].S['SMTPPassword'];
//    mail.From.Address := Config.O['RosettaNet'].S['AdminEmailAddress'];
    mail.From.Name := 'ERP RosettaNet Connector';
    mail.Recipients.EMailAddresses := Config.O['RosettaNet'].S['AdminEmailAddress'];
    mail.Subject := 'Test Message';
    mail.Body.Text := 'This is a test message from ' + self.ConnectorName;

    try
      SMTP.Connect;
      SMTP.Send(mail);
    except
      on e: exception do begin
        result:= false;
        msg := e.Message;
        msg:= 'Error connecting to SMTP Server:<br />' + StringReplace(e.Message,#13#10,'<br />',[rfReplaceAll]);
      end;
    end;

  finally
    SMTP.Free;
    mail.Free;
  end;
end;

{ TTimerThread }

constructor TTimerThread.Create(CreateSuspended: boolean);
begin
  inherited Create(CreateSuspended);
  fCount := 0;
end;

procedure TTimerThread.Execute;
var
  NextTime: TDateTime;
const
  OneSec = 1/24/60/60;
  OneMin = OneSec * 60;
begin
  inherited;
  NexTTime := now + (OneSec * 60);
  {$IFDEF FAST_MESSAGE_CHECK}
    NexTTime := now + (OneSec * 5);
  {$ENDIF}
  while not Terminated do begin
    try
      if now >= NextTime then begin
        try
          Connector.DoOnTimer;
        finally
          Inc(fCount);
          if fCount > 4 then
            NexTTime := now + (OneMin * 15)
          else
            NexTTime := now + (OneSec * 60);
        end;
        {$IFDEF FAST_MESSAGE_CHECK}
          NexTTime := now + (OneSec * 5);
        {$ENDIF}
      end
      else
        Sleep(10);
    except

    end;
  end;
end;

initialization
  msxmldom.MSXML6_ProhibitDTD:= false;

finalization


end.
