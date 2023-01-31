unit ERPEDIObj;

interface

uses
  utBaseCoreService, LogThreadBase, JsonObject, ERPEDIBase;

type

  TERPEDI = class(TERPEDIBase)
  private
//    fCoreService: TBaseCoreService;
//    fOnLog: TOnLogStrEvent;
    fReturnCode: string;
    fUserMessage: string;
    fAPIMEssage: string;
//    procedure Log(const msg: string; const aType: string = '');
    function Serialise(obj: TObject): TJsonObject;
    procedure DoOnProgress(msg: string; var Continue: boolean);
  public
//    property CoreService: TBaseCoreService read fCoreService write fCoreService;
//    property OnLog: TOnLogStrEvent read fOnLog write fOnLog;
    property UserMessage: string read fUserMessage;
    property APIMessage: string read fAPIMEssage;
    property ReturnCode: string read fReturnCode;

    function Send_X12_PurchaseOrder(aPOID: integer): boolean;
    function Send_X12_Invoice(aSaleID: integer): boolean;

    function GetPOEDIDocList(aClientIDs: String): boolean;
  end;

implementation

uses
  BusObjOrders, ObjectSerialiser, BusObjCoreEDIConfig, CommonDbLib,
  AppEnvironment, BusObjSeqNumber, CommonLib, SysUtils, utCoreEDIConst, x12,
  JsonObjectUtils, ErpX12Obj, BusObjShippingAddress, BusObjSales;

(*
   Obj in ERPToX12 can have O['Data'] optinal object that contains:
   "Data": {
     "EDIFormat":"X12",
     "Contacts": [
       {
         "ContactType": "Buyer",
         "Name": "Fred Smith",
         "Phone": "123 456",
         "Fax": "123 456",
         "Email": "soneone@somewhere.com"
       },
       {
         "ContactType": "Info",
         "Name": "Sue Black",
         "Phone": "123 456",
         "Fax": "123 456",
         "Email": "soneone@somewhere.com"
       }
     ],
     "SenderCode":"",
     "ReceiverCode":"",
     "BackorderRequirementCode": ""

   }
*)


{ TERPEDI }

//procedure TERPEDI.Log(const msg, aType: string);
//begin
//  if Assigned(fOnLog) then
//    fOnLog(msg, aType)
//end;

procedure TERPEDI.DoOnProgress(msg: string; var Continue: boolean);
begin
  self.DoProgress(msg);
end;

function TERPEDI.GetPOEDIDocList(aClientIDs: string): boolean;
var
  ClientConfig: TCoreEDIConfig;
  Config, DeleteConfig: TJsonObject;
  Data: TJsonObject;
  obj: TJsonObject;
  x: integer;
  X12Doc: TX12;
  ErpX12: TErpX12;
  msg: string;
  Configs:Array of String;
  Function isConfigProcessed(aconfig:String):Boolean;
  var
    i:Integer;
  begin
    Result := False;
    try
      if length(Configs)=0 then exit;
      for i := low(Configs) to high(Configs) do begin
        if sametext(Configs[i], aConfig) then begin
          result := True;
          Exit;
        end;
      end;
    finally
      if not result then begin
        Setlength(Configs,length(Configs)+1);
        Configs[high(Configs)]:= aconfig;
      end;
    end;
  end;
begin
  result := False;
  if aClientIDs = '' then exit;
  ClientConfig := TCoreEDIConfig.CreateWithNewConn(nil);
  Config := JO;
  Data:= JO;
  X12Doc := TX12.Create;
  ErpX12 := TErpX12.Create;
  try
    ErpX12.OnProgress := DoOnProgress;
    ClientConfig.SilentMode := true;
    ClientConfig.LoadSelect('ClientID in ( ' + aClientIDs+')' );
    if ClientConfig.count =0 then exit;
    ClientConfig.First;
    Setlength(Configs,0);
    While ClientConfig.EOF = FAlse do begin
        if not isConfigProcessed(ClientConfig.Config.O['PO'].O['FTP'].AsString) then begin
            Config.O['FTP'].Assign(ClientConfig.Config.O['PO'].O['FTP']);
            result := CoreService.GetPOEDIDocList(Data, Config);
            if result then begin
              //Data.SaveToFile('c:\temp\data.json');
              for x := 0 to Data.A['List'].Count -1 do begin
                self.DoProgress('Processing ' + IntToStr(x+1) + ' of ' + IntToStr(Data.A['List'].Count) + ' files.');
                obj := Data.A['List'][x].AsObject;
                //obj.S['FileName']
                //obj.S['LocalFileName']
                //obj.S['FileDir']
                //obj.S['DocType'] // X12 doc
                //obj.S['Doc']
                self.DoProgress('Processing file: ' + obj.S['FileName']);
                if obj.Exists('Doc') then begin
                    X12Doc.ReadString(obj.S['Doc']);
                end else begin
                    X12Doc.Data.Assign(obj);
                end;

                    if ErpX12.ProcessX12(X12Doc.Data,msg) then begin
                      { can now delete this file }
                      DeleteConfig := JO;
                      try
                        DeleteConfig.O['FTP'].Assign(ClientConfig.Config.O['PO'].O['FTP']);
                        DeleteConfig.S['FileDir'] := obj.S['FileDir'];
                        DeleteConfig.S['FileName'] := obj.S['FileName'];
                        if CoreService.DeleteMessage(DeleteConfig) then begin
                          self.DoProgress('Message file deleted.');
                        end
                        else begin
                          self.DoProgress('Could not delete Message file.');
                        end;
                      finally
                        DeleteConfig.Free;
                      end;
                    end
                    else begin
                      result := false;
                      self.DoError(msg);
                      //exit;
                    end;


        //        X12Doc.Data.SaveToFile('c:\temp\data' + IntToStr(x) + '.json');
                JsonToFileFormated(X12Doc.Data, 'c:\temp\data' + IntToStr(x) + '.json');

              end;



            end
            else begin
              result := false;
              fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
              fUserMessage := CoreService.ResultData.S[Name_UserMessage];
              fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
              self.DoError;
            end;
        end;
        ClientConfig.Next;
    end;
  finally
    ClientConfig.Free;
    Config.Free;
    Data.Free;
    X12Doc.Free;
    ErpX12.Free;
  end;
end;

function TERPEDI.Send_X12_PurchaseOrder(aPOID: integer): boolean;
var
  PO: TPurchaseOrder;
  POJson, EmployeeJson, SupplierJson, ShipAddressJson: TJsonObject;
  Config: TCoreEDIConfig;
  DocConfig: TJsonObject;
  InterchangeControlNo: string;
  SeqNoName: string;
  msg: string;
  ShippingAddress: TShippingAddress;
begin
//  result := true;
  fReturnCode := '';
  fUserMessage := '';
  fAPIMEssage := '';
  PO := TPurchaseOrder.CreateWithNewConn(nil);
  Config := TCoreEDIConfig.CreateWithNewConn(nil);
  DocConfig := JO;
  try
    PO.SilentMode := true;
    if PO.LockTrans(msg) then begin
      try
        Config.SilentMode := true;
        PO.Load(aPOID);
        Config.LoadSelect('ClientID = ' + IntToStr(PO.ClientId));
        POJson := self.Serialise(PO);
        try
          { we need employee details }
          EmployeeJson := self.Serialise(PO.Employee);
          POJson.O['fields'].Add('Employee', EmployeeJSON);

          { .. and supplier }
          SupplierJson := self.Serialise(PO.Supplier);
          POJson.O['fields'].Add('Supplier', SupplierJSON);

          if PO.ShipToId > 0 then begin
            ShippingAddress := TShippingAddress.Create(nil);
            try
              ShippingAddress.Connection := PO.Connection;
              ShippingAddress.SilentMode := true;
              ShippingAddress.Load(PO.ShipToId);
              ShipAddressJson := self.Serialise(ShippingAddress);
              POJson.O['fields'].Add('ShippingAddress', ShipAddressJson);
            finally
              ShippingAddress.Free;
            end;
          end;

//          JsonToFileFormated(POJson,'c:\temp\PO.JSON');

          DocConfig.O['FTP'].Assign(Config.Config.O['PO'].O['FTP']);
          DocConfig.S['EDIFormat'] := 'X12';
          DocConfig.S['DocType'] := 'PO';
          DocConfig.S['SenderCode'] := AppEnv.CompanyPrefs.EDIConfig.DocSenderCode;
          DocConfig.S['ReceiverCode'] := Config.Config.S['EDIVendorCode'];
          SeqNoName := Copy('InterchangeControlNo_' + PO.ClientName,1,255);
          TSeqNumber.CheckCreate(SeqNoName,999999999);
          InterchangeControlNo := LeftPadStr(GetSequenceNumber(SeqNoName) ,9,'0');
          DocConfig.S['InterchangeControlNo'] := InterchangeControlNo;
          result := CoreService.SendEDIDoc(POJson, DocConfig);
          if result then begin
            { document sent .. update the PO Status }
            PO.Connection.BeginTransaction;
            try
              PO.OrderStatus := AppEnv.CompanyPrefs.EDIConfig.POSentStatus;
              PO.PostDb;
              PO.Connection.CommitTransaction;
            finally
              if PO.Connection.InTransaction then
                PO.Connection.RollbackTransaction;
            end;
          end
          else begin
            { send faild }
            result := false;
            fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
            fUserMessage := CoreService.ResultData.S[Name_UserMessage];
            fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
            self.DoError;
          end;
        finally
          POJson.Free;
        end;
      finally
        PO.UnLock;
      end;
    end
    else begin
      DoError('Could not lock PO ' + IntToStr(PO.ID) + ' ' + PO.ClientPrintName + ': ' + msg);
      result := false;
    end;
  finally
    PO.Free;
    Config.Free;
    DocConfig.Free;
  end;


end;
function TERPEDI.Send_X12_Invoice(aSaleID: integer): boolean;
var
  Invoice: TInvoice;
  InvoiceJson, EmployeeJson, CustomerJson, ShipAddressJson: TJsonObject;
  Config: TCoreEDIConfig;
  DocConfig: TJsonObject;
  InterchangeControlNo: string;
  SeqNoName: string;
  msg: string;
  ShippingAddress: TShippingAddress;
begin
//  result := true;
  fReturnCode := '';
  fUserMessage := '';
  fAPIMEssage := '';
  Invoice := TInvoice.CreateWithNewConn(nil);
  Config := TCoreEDIConfig.CreateWithNewConn(nil);
  DocConfig := JO;
  try
    Invoice.SilentMode := true;
    if Invoice.LockTrans(msg) then begin
      try
        Config.SilentMode := true;
        Invoice.Load(aSaleID);
        Config.LoadSelect('ClientID = ' + IntToStr(Invoice.ClientId));
        InvoiceJson := self.Serialise(Invoice);
        try
          { we need employee details }
          EmployeeJson := self.Serialise(Invoice.Employee);
          InvoiceJson.O['fields'].Add('Employee', EmployeeJSON);

          { .. and supplier }
          CustomerJson := self.Serialise(Invoice.Customer);
          InvoiceJson.O['fields'].Add('Customer', CustomerJson);

          if Invoice.ShipToId > 0 then begin
            ShippingAddress := TShippingAddress.Create(nil);
            try
              ShippingAddress.Connection := Invoice.Connection;
              ShippingAddress.SilentMode := true;
              ShippingAddress.Load(Invoice.ShipToId);
              ShipAddressJson := self.Serialise(ShippingAddress);
              InvoiceJson.O['fields'].Add('ShippingAddress', ShipAddressJson);
            finally
              ShippingAddress.Free;
            end;
          end;

//          JsonToFileFormated(InvoiceJson,'c:\temp\Invoice.JSON');

          DocConfig.O['FTP'].Assign(Config.Config.O['SALES'].O['FTP']);
          DocConfig.S['EDIFormat'] := 'X12';
          DocConfig.S['DocType'] := 'Invoice';
          DocConfig.S['SenderCode'] := AppEnv.CompanyPrefs.EDIConfig.DocSenderCode;
          DocConfig.S['ReceiverCode'] := Config.Config.S['EDIVendorCode'];
          SeqNoName := Copy('InterchangeControlNo_' + Invoice.ClientName,1,255);
          TSeqNumber.CheckCreate(SeqNoName,999999999);
          InterchangeControlNo := LeftPadStr(GetSequenceNumber(SeqNoName) ,9,'0');
          DocConfig.S['InterchangeControlNo'] := InterchangeControlNo;
          result := CoreService.SendEDIDoc(InvoiceJson, DocConfig);
          if result then begin
            { document sent .. update the Invoice Status }
            Invoice.Connection.BeginTransaction;
            try
              Invoice.SalesStatus := AppEnv.CompanyPrefs.EDIConfig.SalesSentStatus;
              Invoice.PostDb;
              Invoice.Connection.CommitTransaction;
            finally
              if Invoice.Connection.InTransaction then
                Invoice.Connection.RollbackTransaction;
            end;
          end
          else begin
            { send faild }
            result := false;
            fReturnCode := CoreService.ResultData.S[Name_ReturnCode];
            fUserMessage := CoreService.ResultData.S[Name_UserMessage];
            fAPIMessage := CoreService.ResultData.S[Name_APIMessage];
            self.DoError;
          end;
        finally
          InvoiceJson.Free;
        end;
      finally
        Invoice.UnLock;
      end;
    end
    else begin
      DoError('Could not lock Invoice ' + IntToStr(Invoice.ID) + ' ' + Invoice.ClientPrintName + ': ' + msg);
      result := false;
    end;
  finally
    Invoice.Free;
    Config.Free;
    DocConfig.Free;
  end;


end;
function TERPEDI.Serialise(obj: TObject): TJsonObject;
var
  JSONSerialiser: TJSONSerialiser;
begin
  JSONSerialiser := TJSONSerialiser.Create;
  try
    result := JSONSerialiser.SerialiseObject(obj);
  finally
    JSONSerialiser.Free;
  end;
end;

end.
