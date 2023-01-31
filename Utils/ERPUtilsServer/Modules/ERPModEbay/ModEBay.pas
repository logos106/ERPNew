unit ModEBay;
{$I ERP.inc}
interface

uses
  LogThreadBase,ServerModuleObj, eBayObj, ebaysvc , JSONObject  ,XSBuiltIns,
//  ConfigDbObj,
  eBay_Orders, ERPDBcomponents;

type

  TModEbay = class(TServerModule)
  private
    fNextCheckTime: TDateTime;
    fsReqVersion: String;
    fsdevid: String;
    fsAppid: String;
    fsUserTocken: String;
    fscertID: String;
//    Config: TJsonObject;
//    ConfigDb: TConfigDb;
    fsDatabase: String;
    fsEbayCustomer: String;
    fbSingleCustomer: Boolean;
//    fsAccount: String;
    CurEbayAccountName:String;
    fConn: TERPConnection;
    Databasename:String;
    fAccounts: TJsonArray;
    fEbayobj : TERPEbayObj;
    Procedure GetOrders(DFrom, DTo:TDateTime; const Pageno, totalpages:Integer);
    procedure UpdateEbayStatus(aDatefrom :TDatetime);
    Procedure SaveOrders(ORRs: GetOrdersResponse);
    function XSDttimeToDtTime(xDt: TXSDateTime): Tdatetime;
    function DoSyncFRomEbay(Account: TJsonObject; var msg: string): boolean;
    Function DoSyncToERP(const OrderID:Integer =0):Boolean;
    function SaveIntoEbaySO(Order: TeBay_Orders): Integer;
    function Conn: TERPConnection;
    procedure ReadParams(Account: TJsonObjecT);
    function EbayobjInst(ApiName:String): TERPEbayObj;
//    function GetAccounts: string;
//    procedure SetAccounts(const Value: string);
//    procedure InitEbayConfig;
//    function GetAccounts: string;
//    procedure SetAccounts(const Value: string);
  protected
//    AccountList: TJsonArray;
    function GetModuleDescription: string; override;
    procedure AfterLoadConfig; override;

    procedure DoOnMessage(aClientId: integer; aData: string; ctx: TJsonObject); override;
    procedure DoOnMessage(aClientId: integer; aData: TJsonObject; ctx: TJsonObject); override;
    procedure DoOnCommandMessage(aData: string; ctx: TJsonObject); override;

    procedure DoOnRequest(aClientId: integer; aRequest: string; ctx: TJsonObject; var aResponse: string); override;
    procedure DoOnRequest(aClientId: integer; aRequest: TJsonObject; ctx: TJsonObject; aResponse: TJsonObject = nil); override;
    procedure DoOnCommandRequest(aRequest: string; var aResponse: string); override;
    procedure UpdateConfigNextUpdateTime(AccountName: string; UpdateTime: TDateTime);
    procedure UpdateConfigDT(AccountName: string; FieldName:String;Value :TDateTime);
    procedure DoWork; override;
  public
    constructor Create(aLogger: TLoggerBase = nil); override;
    destructor Destroy; override;
//    procedure LoadConfig(*(encrypt: boolean = false)*); override;
//    procedure SaveConfig(*(encrypt: boolean = false)*); override;
    Property UserTocken : String read fsUserTocken write fsUserTocken;
    Property AppId      : String read fsAppid write fsAppid;
    Property DevId      : String read fsdevid write fsdevid;
    Property CertId     : String read fscertID write fscertID;
    Property ReqVersion : String read fsReqVersion write fsReqVersion;
    Property Database   : String read fsDatabase write fsDatabase;
    Property EbayCustomer   : String read fsEbayCustomer write fsEbayCustomer;
    Property SingleCustomer   : Boolean read fbSingleCustomer write fbSingleCustomer;
//    Property  Account    : String read fsAccount  write fsAccount;
  published
//    property Accounts: string read GetAccounts write SetAccounts;
    property Accounts: TJsonArray read fAccounts write fAccounts;
  end;


implementation

uses
  sysutils , LogMessageTypes, JsonToObject ,JsonRPCUtils , JsonRpcConst,
  eBay_orderresponse, eBaysvcLib, eBayLib, DateUtils, eBayConfig,
  WebApiClientObj, MySQLUtils, ConfigReader, AppEnvironmentVirtual;


{ TModEbay }
Function TModEbay.XSDttimeToDtTime(xDt: TXSDateTime):Tdatetime;
begin
  if xDt <> nil then
    result := xDt.AsDateTime
  else
    result := 0;
end;

procedure TModEbay.AfterLoadConfig;
begin
  inherited;

end;

constructor TModEbay.Create(aLogger: TLoggerBase);
begin
  inherited;
  fEbayobj := nil;
  fAccounts := TJsonArray.Create;
  LoadConfig;
//  Config:= TJsonObject.Create;
//  ConfigDb:= TConfigDb.Create('Ebay','localhost');
  fNextCheckTime  := IncMinute(now, 1);
//  InitEbayConfig;
end;

//Procedure TModEbay.InitEbayConfig;
////var
////  defAccount: TJsonObject;
//begin
//try
//  Config.AsString := ConfigDb.Value;
//  (*if Config.A['Accounts'].Count =0 then begin
//        {$IFDEF DevMode}
//            defAccount := JO;
//            defAccount.S['Name'] := Conn_Databse;
//            defAccount.S['UserTocken'] := ebayUserTocken;
//            defAccount.S['AppId'] := ebayAppId;
//            defAccount.S['DevId'] := ebayDevId;
//            defAccount.S['CertID'] := ebayCertId;
//            defAccount.S['ReqVersion'] := ebayReqVersion;
//            defAccount.S['Database'] := Conn_Databse;
//            defAccount.B['Active'] := TRue;
//            defAccount.DT['NextSyncTime'] := Date;
//            defAccount.DT['SyncDatefrom'] := 0;
//            config.A['Accounts'].Add(defAccount);
//            ConfigDb.Value :=config.AsString;
//        {$ENDIF}
//    end;*)
//  Except
//    on E:Exception do begin
//      log('Exception loading EBay configuration: '+ E.Message, ltDEtail);
//      Raise;
//    end;
//  end;
//end;

destructor TModEbay.Destroy;
begin
//  Config.Free;
//  ConfigDb.Free;
  fAccounts.Free;
  Freeandnil(fConn);
  inherited;
end;

procedure TModEbay.DoOnCommandMessage(aData: string; ctx: TJsonObject);
begin
  inherited;

end;

procedure TModEbay.DoOnCommandRequest(aRequest: string; var aResponse: string);
begin
  inherited;

end;

procedure TModEbay.DoOnMessage(aClientId: integer; aData, ctx: TJsonObject);
begin
  inherited;

end;

procedure TModEbay.DoOnMessage(aClientId: integer; aData: string; ctx: TJsonObject);
begin
  inherited;

end;

procedure TModEbay.DoOnRequest(aClientId: integer; aRequest, ctx, aResponse: TJsonObject);
var
  methodName: string;
  idx: integer;
begin
  if Terminated then exit;
  methodName:= Lowercase(aRequest.S['method']);
  Log('Request: ' +  methodName, ltDetail);
  try
    inherited;

    if ctx.B['Handled'] = true then
      exit;

    idx:= Pos('.',methodName);
    if idx > 0 then
      methodName:= Copy(methodName,idx+1,Length(methodName));

    if SameText(methodName,'GetConfig') then begin
      ObjToJson(self, aResponse.O['result']);
    end
    else if SameText(methodName,'SetConfig') then begin
      if aRequest.ObjectExists('params') then begin
        JsonToObj(aRequest.O['params'],self);
        self.SaveConfig;
        JsonRPCUtils.AddResultOk(aResponse);
      end
      else begin
        JsonRPCUtils.AddResultError(aResponse,'Params object missing from request',RPC_INVALID_PARAMS);
      end;
    end
    else begin
      AddResultError(aResponse,'Request method (' + methodName + ') not found',RPC_METHOD_NOT_FOUND);
    end;
  finally
  end;
end;

Procedure TModEbay.ReadParams(Account: TJsonObjecT);
begin
    UserTocken    := Account.S['UserTocken'];
    AppId         := Account.S['AppId'];
    DevId         := Account.S['DevId'];
    CertId        := Account.S['CertId'];
    ReqVersion    := ebayReqVersion;
    Database      := Account.S['Database'];
    EbayCustomer  := Account.S['EbayCustomer'];
    SingleCustomer:= Account.B['SingleCustomer'];
end;

function TModEbay.DoSyncFRomEbay(Account: TJsonObject; var msg: string): boolean;
var
  dtFrom, DtTo:TDatetime;
begin
    Result:= false;
    if Account.B['Active'] = False then exit;
    dtFrom     := Account.DT['SyncDatefrom'];
    DtTo := incDay(Date,1);
    Log('Checking for Orders between : ' + formatDAteTime(Shortdateformat , dtFrom) + '  - ' + formatDAteTime(Shortdateformat , DtTo), ltDEtail);
    Log('ANY HISTORY PRIOR TO ' + formatDAteTime(Shortdateformat , dtFrom) + ' WILL NOT BE SYNCHED.  PLEASE CHANGE "Sync Date From" IN THE SERVICE MENU IF REQUIRED', ltDEtail);
    GetOrders(DtFrom , DtTo,  1,0);
    try
      DtFrom :=Account.DT['StatusUpdatedUntil'];
    Except
      on E:Exception do begin
        DtFrom :=1;
      end;
    end;
    UpdateEbayStatus(DtFrom);
    if Terminated then exit;
    if dtFrom <> incday(date , -3) then dtFrom :=incday(date , -3);
    UpdateConfigDT(Account.S['Name'],'SyncDatefrom' , DtFrom);
    REsult:= True;
end;

function TModEbay.DoSyncToERP(const OrderID:Integer =0): Boolean;
var
  Order :TeBay_Orders;
  SOID:Integer;
  s:string;
  iOrderID:Integer;
begin
  REsult:= False;
  iOrderID := 0;
  order:= TeBay_Orders.create(nil);
  order.database := Database;
  s:='salesOrderId =0 and EbayAccountName = ' + QuotedStr(curEbayAccountName);  if OrderID<> 0 then s:= s + ' and ID > ' + inttostr(OrderID);   s:= s + ' Order by ID  Limit 10';
  Log('Adding Orders from Ebay Order #' +inttostr(OrderID) , ltInfo);
  Order.LoadSelect(s);
  try
    if order.count =0 then begin
      Log('0 Orders Found to Synch with ERP - no error'  , ltDetail);
      exit;
    end;
    order.First;
    While order.Eof = False do begin
      Log('Adding  Order # ' +Order.OrderID , ltDetail);
      SOID:= SaveIntoEbaySO(Order);
      if SOID <> 0 then begin
        Log('Flag Order - SO #' + inttostr(SOID) , ltDetail);
        order.SalesOrderID := SOID;
        Log('PostOrder' , ltDetail);
        order.PostDB;
        Log('Next' , ltDetail);
        REsult:= True;
      end;
      iOrderID := Order.ID;
      order.Next;
      if Terminated then exit;
    end;
  finally
    Freeandnil(order);
  end;
  if Terminated then exit;
  DoSyncToERP(iOrderID);
end;

procedure TModEbay.DoOnRequest(aClientId: integer; aRequest: string; ctx: TJsonObject; var aResponse: string);
begin
  inherited;

end;

procedure TModEbay.DoWork;
var
  AccountIdx: integer;
  Account: TJsonObject;
  msg: string;
  NextAccountCheckTime: TDateTime;
  dt: TDateTime;
const
  OneHour = 1/24;
  OneMin = OneHour /60;

begin
  if now < fNextCheckTime then begin
    {Log('=================================================================');
    Log('Time '+ formatdateTime('dd-mm-yy hh:nn:ss' ,Now) , ltInfo);
    Log('Next update at '+ formatdateTime('dd-mm-yy hh:nn:ss' ,fNextCheckTime) , ltInfo);
    Log('=================================================================');}
    exit;
  end;
  if Terminated then exit;
  NextAccountCheckTime := 0;
  try
    Logger.SetLoggingLevel(LoggingLevel);
    if not Active then begin
      Log('Ebay Module is not set to Active, skipping EBay check.', ltInfo);
      exit;
    end;

    Log('Ebay synch started at ' + Quotedstr(formatDatetime('dd-mm-yyyy hh:nn:ss' , now)), ltDetail);
//    Config.AsString:= ConfigDb.Value;

//    if (not Config.ArrayExists('Accounts')) or (Config.A['Accounts'].Count = 0) or (terminated) then begin
    if (Accounts.Count = 0) or (terminated) then begin
      Log('There are no EBay accounts configured, skipping EBay check.', ltInfo);
      exit;  { nothing to do }
    end;

    for AccountIdx := 0 to Accounts.Count -1 do begin
      if Terminated then exit;
      Account:= Accounts[AccountIdx].AsObject;
      Databasename := Account.S['Database'];
      Logger.SetLoggingLevel(TLoggingLevel(Account.I['LoggingLevel']));
      curEbayAccountName := Account.S['Name'];
      Log('Checking Ebay Sales from account : "' + Account.S['Name'] + '" ...',ltDetail);
      ReadParams(Account);
      if Account.B['Active'] and (Account.DT['NextSyncTime'] <= now) then begin
        try
            dt:= now;
            Log('Processing "' + Account.S['Name'] + '" ...',ltInfo);

            if DoSyncFRomEbay(Account, msg) then begin
              Log('Finished processing "' + Account.S['Name'] + '" (time taken: ' + FormatDateTime('hh:nn:ss',now-dt)+ ')',ltInfo);
              Log('Synchronizing into ERP Sales Orders.'  , ltInfo);
              if Terminated then exit;
            end else begin
              Log('Error processing "' + Account.S['Name'] + '" (time taken: ' + FormatDateTime('hh:nn:ss',now-dt)+ '): ' + msg,ltError);
            end;
        finally
          //NextAccountCheckTime := IncHour(now,1);
          NextAccountCheckTime := IncMinute(now,10);
          UpdateConfigNextUpdateTime(Account.S['Name'],NextAccountCheckTime);
          if (fNextCheckTime = 0) or (NextAccountCheckTime < fNextCheckTime) then fNextCheckTime:= NextAccountCheckTime;
        end;
      end else begin
        if not Account.B['Active'] then
          Log('Account not active.',ltDetail)
        else
          Log('Account synch not due until: ' + FormatDateTime('yyyy-mm-dd hh:nn:ss',Account.DT['NextSyncTime']),ltDetail);
      end;
      DoSyncToERP;
      if Terminated then exit;
    end;
  finally
    Logger.SetLoggingLevel(LoggingLevel);
    if NextAccountCheckTime <> 0 then fNextCheckTime:= NextAccountCheckTime
    else fNextCheckTime:= inchour(now,1);
    if NextAccountCheckTime =0 then NextAccountCheckTime :=inchour(now,1);
    Log('Ebay synch finished. Next Sync will start at ' + Quotedstr(formatDatetime('dd-mm-yyyy hh:nn:ss' , NextAccountCheckTime)), ltDetail);
  end;
end;
Function TModEbay.EbayobjInst(ApiName:String) : TERPEbayObj;
begin
  if fEbayobj = nil then begin
    fEbayobj := TERPEbayObj.Create(nil);
    fEbayobj.Api        := ApiName;
    fEbayobj.UserTocken := UserTocken;
    fEbayobj.AppId      := Appid;
    fEbayobj.DevId      := devid;
    fEbayobj.CertId     := certID;
    fEbayobj.ReqVersion := ReqVersion;
  end;
  Result := fEbayobj;
end;

Procedure TModEbay.UpdateEbayStatus(aDatefrom :TDatetime);
var
  {Complete Sale}
  CSR : CompleteSaleRequest;
  CSRs: CompleteSaleResponse;
  aEbayobj     : TERPEbayObj;
  Qry:TERPQuery;
  aCountry : CountryCodeType;
  aMsg:String;

  fShipmentTrackingDetails: Array_Of_ShipmentTrackingDetailsType;
  fShipmentLineItem: ShipmentLineItemType;
  fShippingFeatureCodeType : Array_Of_ShippingFeatureCodeType;
  fItemTransactionIDArray : ItemTransactionIDArrayType;

  aListingType : ListingTypeCodeType;
  aCurrencyCode : CurrencyCodeType;

  ctr1,ctr2:Integer;
begin
  CSRs :=nil;
  Log( Conn.database  , ltDetail);
  Log('        Updating Ebay Order Status' , ltDetail);
  Qry := TERPQuery.create(nil);
  try
    qry.Connection := Conn;
    qry.SQL.Text:= ToBeUpdatedSalesShipment(chr(13));
    qry.Parambyname('DateFrom').asDatetime := aDatefrom;
    qry.open;
    if qry.recordcount =0 then begin
      Log('        0 records found ', ltDetail);
      exit;
    end;
    Log('        '+  inttostr(qry.recordcount) +' shipment records found ', ltDetail);
    qry.First;
    While qry.Eof = False do begin
      Log('        Updating Ebay Order Status '+ inttostr(qry.recno)+' of ' + inttostr(qry.recordcount) , ltDetail);
      aEbayobj := EbayobjInst('Trading');
      Try
        CSR := CompleteSaleRequest.Create;
        CSR.FeedbackInfo   := FeedbackInfoType.Create;
        CSR.FeedbackInfo.CommentText := 'Shipment';
        CSR.FeedbackInfo.CommentType  := CommentTypeCodeType.Positive;//default
        CSR.FeedbackInfo.TargetUser := '';

        CSR.ItemID        := Qry.fieldbyname('ItemID').asString;
        CSR.OrderID           := Qry.fieldbyname('OrderID').asString;
        CSR.OrderLineItemID   := Qry.FieldByName('OrderLineItemID').AsString;
        //CSR.TransactionID := Qry.fieldbyname('TransactionID').asString;

(*      if Qry.fieldbyname('ShipQty').asInteger >0 then
             CSR.Paid  := true
        else CSR.Paid  := False;*)
        (*CSR.Paid  := true;*)


       (* StrToEnum(Qry.fieldbyname('ListingType').asString, aListingType ) ;
        CSR.ListingType := aListingType;*)


        CSR.Shipment      := ShipmentType.create;

        (*CSR.Shipment.EstimatedDeliveryDate :=  TXSDateTime.Create;
        CSR.Shipment.EstimatedDeliveryDate.AsDateTime := Qry.fieldbyname('DeliveryData').asDateTime;

        //default
        StrToEnum(Qry.fieldbyname('ForeignExchangeCode').asString, aCurrencyCode ) ;
        CSR.Shipment.InsuredValue := AmountType.Create;
        CSR.Shipment.InsuredValue.Text := 0;
        CSR.Shipment.InsuredValue.currencyID :=  aCurrencyCode;

        //default
        CSR.Shipment.PackageDepth := MeasureType.Create;
        CSR.Shipment.PackageDepth.Text := TXSDecimal.Create;
        CSR.Shipment.PackageDepth.Text.DecimalString := '1';
        CSR.Shipment.PackageDepth.measurementSystem := MeasurementSystemCodeType.English;

        //default
        CSR.Shipment.PackageLength := MeasureType.Create;
        CSR.Shipment.PackageLength.Text := TXSDecimal.Create;
        CSR.Shipment.PackageLength.Text.DecimalString := '1';
        CSR.Shipment.PackageLength.measurementSystem := MeasurementSystemCodeType.English;

        //default
        CSR.Shipment.PackageWidth := MeasureType.Create;
        CSR.Shipment.PackageWidth.Text := TXSDecimal.Create;
        CSR.Shipment.PackageWidth.Text.DecimalString := '1';
        CSR.Shipment.PackageWidth.measurementSystem := MeasurementSystemCodeType.English;

        CSR.Shipment.PostageTotal := AmountType.Create;
        CSR.Shipment.PostageTotal.Text := Qry.fieldbyname('TotalNetCharge').AsFloat;
        CSR.Shipment.PostageTotal.currencyID :=  aCurrencyCode;

        CSR.Shipment.PrintedTime := TXSDateTime.Create;
        CSR.Shipment.PrintedTime.AsDateTime := Qry.fieldbyname('ShipDate').asDateTime;

        {ShipFromAddress}
            CSR.Shipment.ShipFromAddress := AddressType.Create;
            CSR.Shipment.ShipFromAddress.FirstName        := Qry.fieldbyname('SenderFirstName').asString;
            CSR.Shipment.ShipFromAddress.LastName         := Qry.fieldbyname('SenderLastName').asString;
            CSR.Shipment.ShipFromAddress.CompanyName      := Qry.fieldbyname('SenderCompany').asString;
            CSR.Shipment.ShipFromAddress.Street           := Qry.fieldbyname('SenderAddress1').asString;
            CSR.Shipment.ShipFromAddress.Street1          := Qry.fieldbyname('SenderAddress2').asString;
            CSR.Shipment.ShipFromAddress.CityName         := Qry.fieldbyname('SenderCity').asString;
            CSR.Shipment.ShipFromAddress.StateOrProvince  := Qry.fieldbyname('SenderState').asString;
            StrToEnum(Qry.fieldbyname('SenderCountryCode').asString, aCountry ) ;
            CSR.Shipment.ShipFromAddress.Country          := aCountry;
            CSR.Shipment.ShipFromAddress.Phone            := Qry.fieldbyname('SenderPhone').asString;
            CSR.Shipment.ShipFromAddress.PhoneCountryCode          := aCountry;
            //CSR.Shipment.ShipFromAddress.Phone2CountryCode         := aCountry;
            CSR.Shipment.ShipFromAddress.AddressOwner              := AddressOwnerCodeType.eBay;
            CSR.Shipment.ShipFromAddress.AddressStatus             := AddressStatusCodeType.None;//default
            CSR.Shipment.ShipFromAddress.AddressRecordType         := AddressRecordTypeCodeType.CustomCode;//default
            CSR.Shipment.ShipFromAddress.AddressUsage              := AddressUsageCodeType.CustomCode;//default


        {ShippingAddress}
            CSR.Shipment.ShippingAddress := AddressType.Create;
            CSR.Shipment.ShippingAddress.FirstName        := Qry.fieldbyname('RecipientFirstName').asString;
            CSR.Shipment.ShippingAddress.LastName         := Qry.fieldbyname('RecipientLastName').asString;
            CSR.Shipment.ShippingAddress.CompanyName      := Qry.fieldbyname('RecipientCompany').asString;
            CSR.Shipment.ShippingAddress.Street           := Qry.fieldbyname('RecipientAddress1').asString;
            CSR.Shipment.ShippingAddress.Street1          := Qry.fieldbyname('RecipientAddress2').asString;
            CSR.Shipment.ShippingAddress.CityName         := Qry.fieldbyname('RecipientCity').asString;
            CSR.Shipment.ShippingAddress.StateOrProvince  := Qry.fieldbyname('RecipientState').asString;
            StrToEnum(Qry.fieldbyname('RecipientCountryCode').asString, aCountry) ;
            CSR.Shipment.ShippingAddress.Country          := aCountry;
            CSR.Shipment.ShippingAddress.Phone            := Qry.fieldbyname('RecipientPhone').asString;
            CSR.Shipment.ShippingAddress.PhoneCountryCode          := aCountry;
            //CSR.Shipment.ShippingAddress.Phone2CountryCode         := aCountry;
            CSR.Shipment.ShippingAddress.AddressOwner              := AddressOwnerCodeType.eBay;
            CSR.Shipment.ShippingAddress.AddressStatus             := AddressStatusCodeType.None;//default
            CSR.Shipment.ShippingAddress.AddressRecordType         := AddressRecordTypeCodeType.CustomCode;//default
            CSR.Shipment.ShippingAddress.AddressUsage              := AddressUsageCodeType.CustomCode;//default

        SetLength(fShippingFeatureCodeType,1);
        fShippingFeatureCodeType[0] :=ShippingFeatureCodeType.CustomCode;//default
        CSR.Shipment.ShippingFeature := fShippingFeatureCodeType;
        CSR.Shipment.ShippingPackage := ShippingPackageCodeType.None;//default

        //default
        CSR.Shipment.WeightMajor := MeasureType.Create;
        CSR.Shipment.WeightMajor.Text := TXSDecimal.Create;
        CSR.Shipment.WeightMajor.Text.DecimalString := '1';
        CSR.Shipment.WeightMajor.measurementSystem := MeasurementSystemCodeType.English;

        //default
        CSR.Shipment.WeightMinor := MeasureType.Create;
        CSR.Shipment.WeightMinor.Text := TXSDecimal.Create;
        CSR.Shipment.WeightMinor.Text.DecimalString := '1';
        CSR.Shipment.WeightMinor.measurementSystem := MeasurementSystemCodeType.English;

        SetLength(fItemTransactionIDArray,1);
        fItemTransactionIDArray[0]  := ItemTransactionIDType.Create;
        fItemTransactionIDArray[0].TransactionID := Qry.FieldByName('TransactionID').AsString;
        fItemTransactionIDArray[0].SKU           := Qry.FieldByName('SKU').AsString;
        fItemTransactionIDArray[0].OrderLineItemID:= Qry.FieldByName('OrderLineItemID').AsString;
        CSR.Shipment.ItemTransactionID := fItemTransactionIDArray;

        CSR.Shipment.DeliveryDate := TXSDateTime.Create;
        CSR.Shipment.DeliveryDate.AsDateTime := Qry.fieldbyname('DeliveryData').asDateTime;

        CSR.Shipment.DeliveryStatus  := ShipmentDeliveryStatusCodeType.Created;//default

        CSR.Shipment.RefundGrantedTime := TXSDateTime.Create;
        CSR.Shipment.RefundGrantedTime.AsDateTime := 1;//default

        CSR.Shipment.RefundRequestedTime := TXSDateTime.Create;
        CSR.Shipment.RefundRequestedTime.AsDateTime := 1;//default

        CSR.Shipment.Status := ShipmentStatusCodeType.Active;//default

*)


        SetLength(fShipmentTrackingDetails, 1);
        fShipmentTrackingDetails[0] := ShipmentTrackingDetailsType.Create;

        SetLength(fShipmentLineItem,1);
        fShipmentLineItem[0] := LineItemType.Create;
        fShipmentLineItem[0].CountryOfOrigin        := Qry.fieldbyname('SenderCountryCode').asString;
        fShipmentLineItem[0].Description            := '';
        fShipmentLineItem[0].ItemID                 := Qry.fieldbyname('ItemID').asString;
        fShipmentLineItem[0].Quantity               := Qry.fieldbyname('ShipQty').asInteger;
        fShipmentLineItem[0].TransactionID          := Qry.FieldByName('TransactionID').AsString;
        fShipmentTrackingDetails[0].ShipmentLineItem:= fShipmentLineItem;

        fShipmentTrackingDetails[0].ShipmentTrackingNumber := Qry.fieldbyname('MasterTrackingNumber').asString;
        fShipmentTrackingDetails[0].ShippingCarrierUsed    := ProviderTypeToStr(Qry.fieldbyname('Provider').asInteger);

        CSR.Shipment.ShipmentTrackingDetails        := fShipmentTrackingDetails;

        CSR.Shipment.ShippedTime := TXSDateTime.Create;
        if  (Qry.fieldbyname('ShipDate').asDateTime=0) or
            (Qry.fieldbyname('ShipDate').asDateTime>now) or
            (Qry.fieldbyname('ShipDate').asDateTime < Qry.fieldbyname('SaleDate').asDateTime)  then
            CSR.Shipment.ShippedTime.AsDateTime := incSecond(now,-1)
        else  CSR.Shipment.ShippedTime.AsDateTime := Qry.fieldbyname('ShipDate').asDateTime;

       (* if Qry.fieldbyname('ShipQty').asInteger >0 then
             CSR.Shipped  := true
        else CSR.Shipped  := False;*)
        CSR.Shipped  := true;
        CSR.TransactionID := Qry.fieldbyname('TransactionID').asString;
        CSR.ErrorHandling := ErrorHandlingCodeType.Legacy ; //default
        CSR.ErrorLanguage := 'English';
        CSR.MessageID := '';
        CSR.Version := aEbayobj.ReqVersion;
        CSR.WarningLevel := WarningLevelCodeType.High_;


        CSRs:= aEbayobj.CompleteSale(CSR, aMsg);
        if Terminated then exit;
        if CSRs = nil then begin
            Log('        Error from Complete Sale - ' + amsg, ltError);
            Exit;
        end;
        if (length(csrs.Errors) =1) and (csrs.Errors[0].ErrorCode = '36')  then begin
          // unknown error , sale is updated
          log(Enumtostr(CSRs.ack), ltdebug);
        end else begin
            log(Enumtostr(CSRs.ack), ltInfo);
            if length(csrs.Errors) >0 then begin
              for ctr1 := low(csrs.Errors) to high(csrs.Errors) do begin
                IF csrs.Errors[ctr1].ErrorCode = '36' then Continue;
                Log( 'Errors :'  +inttostr(ctr1+1) +' of '+ inttostr(high(csrs.Errors)+1 ), ltError);
                Log('            Error Code: ' + csrs.Errors[ctr1].ErrorCode, ltError);
                Log('            Message: ' + csrs.Errors[ctr1].LongMessage, ltError);
                if csrs.Errors[ctr1].UserDisplayHint then Log('            UserDisplayHint ', ltError);
                if length(csrs.Errors[ctr1].ErrorParameters)>0 then begin
                  Log('            Error Params : ' + inttostr(length(csrs.Errors[ctr1].ErrorParameters)), ltError);
                  for ctr2 := low(csrs.Errors[ctr1].ErrorParameters) to high(csrs.Errors[ctr1].ErrorParameters) do begin
                    Log('            '+inttostr(ctr2)+' of ' + inttostr(high(csrs.Errors[ctr1].ErrorParameters))+ '-> Param: ' + csrs.Errors[ctr1].ErrorParameters[ctr2].ParamID +', Value:' +  csrs.Errors[ctr1].ErrorParameters[ctr2].Value, ltError);
                  end;
                end;
                Log('            ErrorClassification: ' + EnumToStr(csrs.Errors[ctr1].ErrorClassification), ltError);
              end;
            end;
        end;
        Log('        Completed Sales', ltInfo);
      Finally
        Try Freeandnil(aEbayobj);Except end;
      End;
      qry.Next;
    end;
  finally
    Freeandnil(Qry);
  end;
end;
Procedure TModEbay.GetOrders(DFrom, DTo:TDateTime; const Pageno, totalpages:Integer);
Var
  aEbayobj     : TERPEbayObj;
  ORR : GetOrdersRequest;
  ORRs: GetOrdersResponse;

  DtFrom, Dtto: TXSDateTime;
  Msg :String;
Begin
  ORRs        := nil;
  try
    Log( Conn.database  , ltDetail);
    Log('        Getting the Ebay Sales : Page  ' + inttostr(Pageno) +' of ' +inttostr(totalpages) , ltDetail);

    aEbayobj := EbayobjInst('Trading');(*TERPEbayObj.Create(nil);*)
    Try
      ORR                := GetOrdersRequest.Create;
      try
        Try
          ORR.Version                   := ReqVersion;
          DtFrom                        := TXSDateTime.Create;
          Dtto                          := TXSDateTime.Create;
          Orr.CreateTimeFrom            := DtFrom;
          Orr.CreateTimeTo              := Dtto;
          Orr.CreateTimeFrom.AsDateTime := dFrom;
          Orr.CreateTimeTo.AsDateTime   := dto;
          Orr.Pagination                := PaginationType.Create;
          if Pageno =0 then Orr.Pagination.PageNumber := 1 else Orr.Pagination.PageNumber := Pageno;
          ORRs                          := aEbayobj.GetOrders(ORR, Msg);
          if Terminated then exit;
          if Orrs = nil then begin
            Log( 'Page ' + inttostr(Pageno) +' : Error '+' : '+ Msg, ltError);
            Exit;
          end;
            Log( 'Page ' + inttostr(Pageno) +' : ' + inttostr(high(Orrs.OrderArray)+1) +' records', ltInfo);
            Try
              SaveOrders(ORRs);
            Except
              on E:Exception do begin
                //Log( 'Exception : ' + E.Message, ltError);
              end;

            End;
        Finally
          Freeandnil(Dtfrom);
          Freeandnil(DtTo);
          Freeandnil(aEbayobj);
          Freeandnil(fEbayobj);
        End;
      Except
        On E:Exception do begin
          //Log('        Exception:' + E.Message, ltError);
        end;
      end;
    if Terminated then exit;
    if (totalPages >0) and (Pageno < totalPages ) then GetOrders(dfrom, dto, pageno+1, TotalPages)
    else if (totalPages =0) and (ORRS.PaginationResult <> nil) then
      if Orrs.PaginationResult.TotalNumberOfPages >1 then
        GetOrders(dfrom, dto,2, Orrs.PaginationResult.TotalNumberOfPages);
    Finally
      Freeandnil(aEbayobj);
      Freeandnil(fEbayobj);
    End;
  Except
        On E:Exception do begin
          //Log('        Exception :' + E.Message , LtError);
        end;
  end;
End;

//function TModEbay.GetAccounts: string;
//begin
//  result := AccountList.AsString;
//end;

function TModEbay.GetModuleDescription: string;
begin
  result := 'Module to download Ebay sales into ERP';

end;

//procedure TModEbay.LoadConfig(*(encrypt: boolean)*);
//begin
//  inherited;
//
//end;
//
//procedure TModEbay.SaveConfig(*(encrypt: boolean)*);
//begin
//  inherited;
//
//end;

function TModEbay.SaveIntoEbaySO(Order: TeBay_Orders): Integer;
var
  APIClient: TWebApiClient;
  SO_Source(*, ObjProductsource*): TJsonObject;
  PostResult: TJsonObject;
  (*Productfields, *)SO_Fields, Line_Source , Line_Fields, PP_Source, PP_fields: TJsonObject;
  //i1, i2:Integer;
  buyerEmail:String;
  s: string;

  procedure AddAddressLine(const aLine: string; var add: string);
  begin
    if Trim(aLine) <> '' then begin
      if add <> '' then add := add + #13#10;
      add := add + aLine;
    end;
  end;
  function shttp:String;
  begin
    result := 'http';
    if TERPModWebAPI_Config.WebApi_UseSSL(self.MySQLServer , LogProc) then result := result +'s';
  end;
  function sPort:String;
  begin
    result :=trim(inttostr(TERPModWebAPI_Config.WebApi_DefaultPort(self.MySQLServer, LogProc)));
    if TERPModWebAPI_Config.WebApi_UseSSL(self.MySQLServer, LogProc) then
      result := trim(inttostr(TERPModWebAPI_Config.WebApi_DefaultSSLPort(self.MySQLServer, LogProc)));
  end;
begin
    result:= 0;
    if Order.count =0 then exit;
    try
      APIClient:= TWebApiClient.Create;
      APIClient.UserName:= Trim(TERPModWebAPI_Config.WebApi_WebUserName(self.MySQLServer, LogProc));
      APIClient.Password:= TERPModWebAPI_Config.UserLoginPassword(APIClient.UserName,Databasename);
      APIClient.Database:= Databasename;
      APIClient.URL:= shttp+'://localhost:'+ sPort;
      SO_Source :=   JO;
      try
        SO_Source.S['type'] := 'TEBaySalesOrder';
        SO_Fields := SO_Source.O['Fields'];
        SO_Fields.S['SalesStatus'] :=Order.OrderStatus;
        SO_Fields.S['SalesCategory'] := 'Ebay Sale';
        SO_Fields.S['Comments']:= 'Ebay Order #' + Order.OrderID + '(' + inttostr(Order.ID) +')' ;
        if Order.ShippingAddress <> nil then begin
          SO_Fields.S['CustomerName'] := Order.ShippingAddress.Name_;
          SO_Fields.S['Ebaycustomer'] := EbayCustomer;
          SO_Fields.B['SingleCustomer'] := SingleCustomer;
          //SO_Fields.S['ShippingAddressCompanyName'] := Order.ShippingAddress.CompanyName;
          SO_Fields.S['ShippingAddressCompanyName'] := Order.ShippingAddress.Name_;
          SO_Fields.S['ShippingAddressFirstName'] := Order.ShippingAddress.FirstName;
          SO_Fields.S['ShippingAddressLastName'] := Order.ShippingAddress.LastName;
          SO_Fields.S['ShippingAddressStreet'] := Order.ShippingAddress.Street;
          SO_Fields.S['ShippingAddressStreet1'] := Order.ShippingAddress.Street1;
          SO_Fields.S['ShippingAddressStreet2'] := Order.ShippingAddress.Street2;
          SO_Fields.S['ShippingAddressCityName'] := Order.ShippingAddress.CityName;
          SO_Fields.S['ShippingAddressStateOrProvince'] := Order.ShippingAddress.StateOrProvince;
          SO_Fields.S['ShippingAddressPhoneCountryPrefix'] := Order.ShippingAddress.PhoneCountryPrefix;
          SO_Fields.S['ShippingAddressPhoneAreaOrCityCode'] := Order.ShippingAddress.PhoneAreaOrCityCode;
          SO_Fields.S['ShippingAddressPhone'] := Order.ShippingAddress.Phone;
          SO_Fields.S['ShippingAddressPhone2CountryPrefix'] := Order.ShippingAddress.Phone2CountryPrefix;
          SO_Fields.S['ShippingAddressPhone2AreaOrCityCode'] := Order.ShippingAddress.Phone2AreaOrCityCode;
          SO_Fields.S['ShippingAddressPhoneLocalNumber'] := Order.ShippingAddress.PhoneLocalNumber;
          SO_Fields.S['ShippingAddressPostalCode'] := Order.ShippingAddress.PostalCode;
          SO_Fields.S['ShippingAddressAddressOwner'] := Order.ShippingAddress.AddressOwner;
          SO_Fields.S['ShippingAddressPhone2'] := Order.ShippingAddress.Phone2;
          SO_Fields.S['ShippingAddressCountryName'] := Order.ShippingAddress.CountryName;
          s := '';
          AddAddressLine(Order.ShippingAddress.Name_,s);
          AddAddressLine(Order.ShippingAddress.Street,s);
          AddAddressLine(Order.ShippingAddress.Street1,s);
          AddAddressLine(Order.ShippingAddress.Street2,s);
          AddAddressLine(Order.ShippingAddress.CityName,s);
          AddAddressLine(Order.ShippingAddress.County,s);
          AddAddressLine(Order.ShippingAddress.StateOrProvince,s);
          AddAddressLine(Order.ShippingAddress.Country,s);

          SO_Fields.S['ShipToDesc'] :=  s;

          SO_Fields.S['InvoiceToDesc'] := s;

        end;
        if order.CreatedTime <>0 then begin
          SO_Fields.DT['CreationDate'] := order.CreatedTime;
          SO_Fields.DT['SaleDate'] := order.CreatedTime;
        end;

        if Order.ShippedTime <> 0 then begin
          SO_Fields.DT['SaleDateTime'] := Order.ShippedTime;
        end;
        SO_Fields.S['Comments'] := SO_Fields.S['Comments']  + chr(13) + Order.BuyerCheckoutMessage;

        if order.Totalcurcode <> '' then begin
          SO_Fields.S['ForeignExchangeCode']  :=order.Totalcurcode;
        end;
        buyerEmail := '';
        if order.Transactions.Count >0 then begin
          order.Transactions.first;
          while order.Transactions.EOF = False do begin
                  if buyerEmail = '' then if order.Transactions.Buyer.Count> 0 then  order.Transactions.Buyer.Email;
                  if order.Transactions.Item <> nil then begin
                    Line_Source := JO;
                    Line_Source.S['type'] := 'TEBaySaleSorderLine';
                    Line_Fields:=  Line_Source.O['Fields'];
                    Line_Fields.S['ProductName']  :=order.Transactions.Item.SKU;
                    Line_Fields.S['SKU']          :=order.Transactions.Item.SKU;
                    if Line_Fields.S['ProductName']  = '' then Line_Fields.S['ProductName']  :=order.Transactions.Item.Title;
                    Line_Fields.S['Product_Description']  :=order.Transactions.Item.Title;
                    Line_Fields.B['Deleted']  :=False;
                    if order.Transactions.TransactionPrice <> 0 then
                      Line_Fields.F['LinePriceInc']  := order.Transactions.TransactionPrice;
                    if order.Transactions.Item.Description <> '' then
                      Line_Fields.S['SalesDescription']  := order.Transactions.Item.Description;
                    if order.Transactions.Item.Quantity <> 0 then Line_Fields.F['UOMQtySold']  := order.Transactions.Item.Quantity else Line_Fields.F['UOMQtySold']  := 1;
                    SO_Fields.A['Lines'].Add(Line_Source);
                  end;
                  order.Transactions.NExt;
              end;
        end;
        if buyerEmail <> '' then
          SO_Fields.S['Comments'] := SO_Fields.S['Comments']  + chr(13) +'customer Email :'  + buyerEmail;
        if Order.Paidamt <> 0 then begin
                PP_Source:= JO;
                PP_Source.S['type'] := 'TEbaySOPrepayment';
                PP_Fields := PP_Source.O['Fields'];
                PP_Fields.S['CompanyName'] := SO_Fields.S['CustomerName'];
                PP_Fields.DT['PrePaymentDate'] := Order.PaidTime;
                PP_Fields.S['ForeignExchangeCode'] := Order.PaidAmtCurcode;
                PP_Fields.F['ForeignPayAmount'] := Order.Paidamt;
                if Order.CheckoutStatus.count >0 then begin
                  PP_Fields.S['PayMethod'] := Order.CheckoutStatus.PaymentMethod;
                  PP_Fields.S['Notes'] := 'PaymentAtatus : ' + Order.CheckoutStatus.eBayPaymentStatus + Chr(10)+chr(13)+
                                            'Status : ' + Order.CheckoutStatus.Status;
                end;
                SO_Fields.A['SOPrepayments'].Add(PP_Source);
        end;
         Log(SO_Source.AsString, ltInfo);
         if not APIClient.Post('TEBaySalesOrder',SO_Source,PostResult) then begin
          Log('Adding SO # ' + order.OrderID +'  Failed.' , ltDetail);
          Log('Web API Call Failed.' + APIClient.errormessage+'. Please Make Sure '+APIClient.UserName +' is a Valid User in ' +APIClient.Database +' Database ', ltDetail);
          if sameText(APIClient.ErrorMessage , 'Error: Server and database versions do not match') then begin
            Exit;
          end;
        end else begin
          Log('Added SO # ' + order.OrderID , ltDetail);
          result:= PostResult.O['fields'].I['ID'];
        end;
      finally
        Freeandnil(SO_Source);
        Freeandnil(APIClient);
      end;
      Log('#' + inttostr(Order.Dataset.RecNo), ltDetail);
    Except
      on E:Exception  do begin
        //Log('Exception :' + E.Message, ltError);
      end;
    end;
end;
function TModEbay.Conn: TERPConnection;
begin
  if fConn <> nil then begin
    if not sametext(fConn.database, database) then begin
      fConn.connected := False;
      Freeandnil(fConn);
    end;
  end;
  if fConn = nil then begin
      fConn :=TERPConnection.Create(nil);
      SetConnectionProps(fconn , Database);
  end;
  result:= fConn;
end;

procedure TModEbay.SaveOrders(ORRs: GetOrdersResponse);
var
  OrderResponse : Tebay_orderresponse;
  i1, i2(*, i3,i4,i5,i6*):Integer;
  dtmin, dtMax:TDatetime;
  function LocateOrder(const fOrderID:String):Boolean;
  var
    Qry:TERPQuery;
  begin
    Qry := TERPQuery.create(nil);
    try
      qry.Connection := Conn;
      qry.SQL.Text:= 'select id from tbleBay_Orders where OrderId = ' + quotedstr(fOrderID);
      qry.open;
      result:= Qry.FieldByName('ID').AsInteger <> 0;
    finally
      Freeandnil(Qry);
    end;
  end;
Begin
  try
    OrderResponse := Tebay_orderresponse.Create(nil );
    try
      OrderResponse.Database := database;
      OrderResponse.New;
      //Logtext(OrderResponse.classname + ' = ' + Orrs.ClassName);
      OrderResponse.Ack                          := enumtostr(Orrs.Ack);
      OrderResponse.CorrelationID                := Orrs.CorrelationID;
      OrderResponse.Message_                     := Orrs.Message_;
      OrderResponse.Version                      := Orrs.Version;
      OrderResponse.Build                        := Orrs.Build;
      OrderResponse.NotificationEventName        := Orrs.NotificationEventName;
      OrderResponse.RecipientUserID              := Orrs.RecipientUserID;
      OrderResponse.EIASToken                    := Orrs.EIASToken;
      OrderResponse.NotificationSignature        := Orrs.NotificationSignature;
      OrderResponse.HardExpirationWarning        := Orrs.HardExpirationWarning;
      OrderResponse.ExternalUserData             := Orrs.ExternalUserData;
      OrderResponse.HasMoreOrders                := BooleantoStr(Orrs.HasMoreOrders);
      OrderResponse.OrdersPerPage                := Orrs.OrdersPerPage;
      OrderResponse.PageNumber                   := Orrs.PageNumber;
      OrderResponse.ReturnedOrderCountActual     := Orrs.ReturnedOrderCountActual;
      OrderResponse.PostDB;
      try
        if high(ORRs.Errors) >=0 then
          for i1:= low(ORRs.Errors) to high(ORRs.Errors) do begin
              With OrderResponse.OrderResponse_OrderErrors do begin
                //Logtext(classname + ' = ' + Orrs.Errors[i1].ClassName);
                New;
                OrderResponse_Id             := OrderResponse.ID;
                ShortMessage                 := Orrs.Errors[i1].ShortMessage;
                LongMessage                  := Orrs.Errors[i1].LongMessage;
                ErrorCode                    := Orrs.Errors[i1].ErrorCode;
                UserDisplayHint              := BooleantoStr(Orrs.Errors[i1].UserDisplayHint);
                SeverityCode                 := enumtostr(Orrs.Errors[i1].SeverityCode);
                ErrorClassification          := enumtostr(Orrs.Errors[i1].ErrorClassification);
                PostDB;
              end;
          end;
      Except
        on E:Exception do begin
          //Log( '1 - Exception :' +E.Message, ltError);
        end;
      end;
      try
          if ORRs.PaginationResult <> nil then begin
              With OrderResponse.OrderResponse_PaginationResult do begin
                //Logtext(classname + ' = ' + ORRs.PaginationResult.ClassName);
                New;
                OrderResponse_Id             := OrderResponse.ID;
                TotalNumberOfPages           := ORRs.PaginationResult.TotalNumberOfPages;
                TotalNumberOfEntries         := ORRs.PaginationResult.TotalNumberOfEntries;
                PostDb;
              end;
          end;
      Except
        on E:Exception do begin
          //Log( '2 - Exception :' +E.Message, ltError);
        end;
      end;

      if high(Orrs.OrderArray) >=0 then begin
        dtmin := XSDttimeToDtTime(Orrs.OrderArray[0].CreatedTime);
        dtmax := XSDttimeToDtTime(Orrs.OrderArray[0].CreatedTime);
        for i1:= low(Orrs.OrderArray) to high(Orrs.OrderArray) do begin
          if Terminated then exit;
          if dtMin >  XSDttimeToDtTime(Orrs.OrderArray[i1].CreatedTime) then dtmin :=  XSDttimeToDtTime(Orrs.OrderArray[i1].CreatedTime);
          if dtMax <  XSDttimeToDtTime(Orrs.OrderArray[i1].CreatedTime) then dtMax  :=  XSDttimeToDtTime(Orrs.OrderArray[i1].CreatedTime);
           With OrderResponse.ebay_orders do begin
             try
                  //if Locate('OrderID' , Orrs.OrderArray[i1].OrderID , []) then begin
                  if LocateOrder(Orrs.OrderArray[i1].OrderID) then begin
                    //Log(Orrs.OrderArray[i1].OrderID +' already exists', ltDetail);
                    continue;
                  end;
                  New;

                  OrderResponse_Id                        := OrderResponse.ID;
                  OrderID                                 := Orrs.OrderArray[i1].OrderID;
                  OrderStatus                             := EnumtoStr(Orrs.OrderArray[i1].OrderStatus);
                  CreatingUserRole                        := EnumtoStr(Orrs.OrderArray[i1].CreatingUserRole);
                  CreatedTime                             := XSDttimeToDtTime(Orrs.OrderArray[i1].CreatedTime);
                  SellerEmail                             := Orrs.OrderArray[i1].SellerEmail;
                  BuyerUserID                             := Orrs.OrderArray[i1].BuyerUserID;
                  PaidTime                                := XSDttimeToDtTime(Orrs.OrderArray[i1].PaidTime);
                  ShippedTime                             := XSDttimeToDtTime(Orrs.OrderArray[i1].ShippedTime);
                  IntegratedMerchantCreditCardEnabled     := Orrs.OrderArray[i1].IntegratedMerchantCreditCardEnabled;
                  BundlePurchase                          := Orrs.OrderArray[i1].BundlePurchase;
                  BuyerCheckoutMessage                    := Orrs.OrderArray[i1].BuyerCheckoutMessage;
                  EIASToken                               := Orrs.OrderArray[i1].EIASToken;
                  PaymentHoldStatus                       := EnumtoStr(Orrs.OrderArray[i1].PaymentHoldStatus);
                  RefundStatus                            := Orrs.OrderArray[i1].RefundStatus;
                  IsMultiLegShipping                      := Orrs.OrderArray[i1].IsMultiLegShipping;
                  EbayAccountName                         := curEbayAccountName;
                  if orrs.OrderArray[i1].AmountSaved <> nil then begin
                        AmountSavedAmt :=orrs.OrderArray[i1].AmountSaved.Text;
                        AmountSavedCurcode  :=Enumtostr(orrs.OrderArray[i1].AmountSaved.currencyID);
                  end;

                  if orrs.OrderArray[i1].AdjustmentAmount<> nil then begin
                        Adjustmentamt :=orrs.OrderArray[i1].AdjustmentAmount.Text;
                        AdjustmentAmtCurcode :=Enumtostr(orrs.OrderArray[i1].AdjustmentAmount.currencyID);
                  end;

                  if orrs.OrderArray[i1].AmountPaid <> nil then begin
                        Paidamt :=orrs.OrderArray[i1].AmountPaid.Text;
                        PaidAmtCurcode  :=Enumtostr(orrs.OrderArray[i1].AmountPaid.currencyID);
                  end;

                  if orrs.OrderArray[i1].Subtotal <> nil then begin
                        SubTotalAmt:=orrs.OrderArray[i1].Subtotal.Text;
                        SubTotalCurcode  :=Enumtostr(orrs.OrderArray[i1].Subtotal.currencyID);
                  end;

                  if orrs.OrderArray[i1].Total <> nil then begin
                        TotalAmt:=orrs.OrderArray[i1].Total.Text;
                        TotalCurcode  :=Enumtostr(orrs.OrderArray[i1].Total.currencyID);
                  end;

                  PostDB;
              Except
                on E:Exception do begin
                  //Log( '3 - Exception :' +E.Message, ltError);
                end;
              end;
              try
                if orrs.OrderArray[i1].checkoutstatus <> nil then begin
                  //Log(checkoutStatus.classname + ' = ' + orrs.OrderArray[i1].CheckoutStatus.ClassName);
                  checkoutStatus.New;
                  checkoutStatus.OrderId := ID;
                  checkoutStatus.eBayPaymentStatus                    := EnumToStr(orrs.OrderArray[i1].CheckoutStatus.eBayPaymentStatus);
                  checkoutStatus.LastModifiedTime                     := XSDttimeToDtTime(orrs.OrderArray[i1].CheckoutStatus.LastModifiedTime);
                  checkoutStatus.PaymentMethod                        := EnumToStr(orrs.OrderArray[i1].CheckoutStatus.PaymentMethod);
                  checkoutStatus.Status                               := EnumToStr(orrs.OrderArray[i1].CheckoutStatus.Status);
                  checkoutStatus.IntegratedMerchantCreditCardEnabled  := orrs.OrderArray[i1].CheckoutStatus.IntegratedMerchantCreditCardEnabled;
                  if orrs.OrderArray[i1].CheckoutStatus.eBayPaymentMismatchDetails <> nil then begin
                    checkoutStatus.PaymentMismatch_MismatchType       := Enumtostr(orrs.OrderArray[i1].CheckoutStatus.eBayPaymentMismatchDetails.MismatchType);
                    checkoutStatus.PaymentMismatch_ActionRequiredBy   := XSDttimeToDtTime(orrs.OrderArray[i1].CheckoutStatus.eBayPaymentMismatchDetails.ActionRequiredBy);
                    checkoutStatus.PaymentMismatch_Amount             := orrs.OrderArray[i1].CheckoutStatus.eBayPaymentMismatchDetails.MismatchAmount.Text;
                    checkoutStatus.PaymentMismatch_AmountcurrencyID   := Enumtostr(orrs.OrderArray[i1].CheckoutStatus.eBayPaymentMismatchDetails.MismatchAmount.currencyID);
                  end;
                  checkoutStatus.PostDB;
                end;
            Except
              on E:Exception do begin
                //Log( '4 - Exception :' +E.Message, ltError);
              end;
            end;
            try
              if orrs.OrderArray[i1].ShippingDetails <> nil then begin
                //Log(ShippingDetails.classname + ' = ' + orrs.OrderArray[i1].ShippingDetails.ClassName);
                ShippingDetails.New;
                ShippingDetails.OrderId := ID;
                ShippingDetails.AllowPaymentEdit                             := orrs.OrderArray[i1].ShippingDetails.AllowPaymentEdit;
                ShippingDetails.ApplyShippingDiscount                        := orrs.OrderArray[i1].ShippingDetails.ApplyShippingDiscount;
                ShippingDetails.GlobalShipping                               := orrs.OrderArray[i1].ShippingDetails.GlobalShipping;
                ShippingDetails.ChangePaymentInstructions                    := orrs.OrderArray[i1].ShippingDetails.ChangePaymentInstructions;
                //ShippingDetails.InsuranceOption                              := EnumToStr(orrs.OrderArray[i1].ShippingDetails.InsuranceOption);
                ShippingDetails.InsuranceWanted                              := orrs.OrderArray[i1].ShippingDetails.InsuranceWanted;
                ShippingDetails.PaymentEdited                                := orrs.OrderArray[i1].ShippingDetails.PaymentEdited;
                ShippingDetails.PaymentInstructions                          := orrs.OrderArray[i1].ShippingDetails.PaymentInstructions;
                ShippingDetails.ShippingRateErrorMessage                     := orrs.OrderArray[i1].ShippingDetails.ShippingRateErrorMessage;
                ShippingDetails.ShippingRateType                             := EnumToStr(orrs.OrderArray[i1].ShippingDetails.ShippingRateType);
                ShippingDetails.ShippingType                                 := EnumToStr(orrs.OrderArray[i1].ShippingDetails.ShippingType);
                ShippingDetails.SellingManagerSalesRecordNumber              := orrs.OrderArray[i1].ShippingDetails.SellingManagerSalesRecordNumber;
                ShippingDetails.ThirdPartyCheckout                           := orrs.OrderArray[i1].ShippingDetails.ThirdPartyCheckout;
                ShippingDetails.GetItFast                                    := orrs.OrderArray[i1].ShippingDetails.GetItFast;
                ShippingDetails.ShippingServiceUsed                          := orrs.OrderArray[i1].ShippingDetails.ShippingServiceUsed;
                ShippingDetails.ShippingDiscountProfileID                    := orrs.OrderArray[i1].ShippingDetails.ShippingDiscountProfileID;
                ShippingDetails.PromotionalShippingDiscount                  := orrs.OrderArray[i1].ShippingDetails.PromotionalShippingDiscount;
                ShippingDetails.InternationalShippingDiscountProfileID       := orrs.OrderArray[i1].ShippingDetails.InternationalShippingDiscountProfileID;
                ShippingDetails.InternationalPromotionalShippingDiscount     := orrs.OrderArray[i1].ShippingDetails.InternationalPromotionalShippingDiscount;
                ShippingDetails.SellerexsShiptosPreference                   := orrs.OrderArray[i1].ShippingDetails.SellerExcludeShipToLocationsPreference;
                ShippingDetails.PostDB;
                (*if high(orrs.OrderArray[i1].ShippingDetails.ExcludeShipToLocation)>=0 then
                  for i2 := low(orrs.OrderArray[i1].ShippingDetails.ExcludeShipToLocation) to high(orrs.OrderArray[i1].ShippingDetails.ExcludeShipToLocation) do begin
                    //Log(ShippingDetails.exsShipto.classname + ' = ' + 'ExcludeShipToLocation' );
                    ShippingDetails.exsShipto.New;
                    ShippingDetails.exsShipto.OrderID := ShippingDetails.OrderID;
                    ShippingDetails.exsShipto.Orders_Shipping_Id:= ShippingDetails.ID;
                    ShippingDetails.exsShipto.exsShipto := orrs.OrderArray[i1].ShippingDetails.ExcludeShipToLocation[i2];
                    ShippingDetails.exsShipto.PostDB;
                  end;*)
              (*if high(orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption)>=0 then
                  for i2 := low(orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption) to high(orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption) do begin
                    //Log(ShippingDetails.intshipservc.classname + ' = ' + orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption[i2].ClassName);
                    ShippingDetails.intshipservc.New;
                    ShippingDetails.intshipservc.OrderID := ShippingDetails.OrderID;
                    ShippingDetails.intshipservc.Orders_Shipping_Id:= ShippingDetails.ID;
                    ShippingDetails.intshipservc.ShippingService                     := orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption[i2].ShippingService;
                    ShippingDetails.intshipservc.ShippingServicePriority             := orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption[i2].ShippingServicePriority;
                    ShippingDetails.intshipservc.ShippingServiceCost                 := orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption[i2].ShippingServiceCost.Text;
                    ShippingDetails.intshipservc.ShippingServiceAdditionalCost       := orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption[i2].ShippingServiceAdditionalCost.Text;
                    ShippingDetails.intshipservc.ShippingInsuranceCost               := orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption[i2].ShippingInsuranceCost.Text;
                    ShippingDetails.intshipservc.ImportCharge                        := orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption[i2].ImportCharge.Text;
                    ShippingDetails.intshipservc.ShippingServiceCostcurcode          := EnumToStr(orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption[i2].ShippingServiceCost.currencyID);
                    ShippingDetails.intshipservc.ShippingServiceAdditionalCostcurcode:= EnumToStr(orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption[i2].ShippingServiceAdditionalCost.currencyID);
                    ShippingDetails.intshipservc.ShippingInsuranceCostcurcode        := EnumToStr(orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption[i2].ShippingInsuranceCost.currencyID);
                    ShippingDetails.intshipservc.ImportChargecurcode                 := EnumToStr(orrs.OrderArray[i1].ShippingDetails.InternationalShippingServiceOption[i2].ImportCharge.currencyID);
                    ShippingDetails.intshipservc.PostDB;
                  end;*)
              (*if orrs.OrderArray[i1].ShippingDetails.SalesTax <> nil then begin
                    //Log(ShippingDetails.SalesTax.classname + ' = ' + orrs.OrderArray[i1].ShippingDetails.SalesTax.ClassName);
                    ShippingDetails.SalesTax.New;
                    ShippingDetails.SalesTax.OrderID := ShippingDetails.OrderID;
                    ShippingDetails.SalesTax.Orders_Shipping_Id:= ShippingDetails.ID;
                    ShippingDetails.SalesTax.SalesTaxPercent                              := orrs.OrderArray[i1].ShippingDetails.SalesTax.SalesTaxPercent;
                    ShippingDetails.SalesTax.SalesTaxState                                := orrs.OrderArray[i1].ShippingDetails.SalesTax.SalesTaxState   ;
                    ShippingDetails.SalesTax.ShippingIncludedInTax                        := orrs.OrderArray[i1].ShippingDetails.SalesTax.ShippingIncludedInTax;
                    if orrs.OrderArray[i1].ShippingDetails.SalesTax.SalesTaxAmount <> nil then begin
                      ShippingDetails.SalesTax.SalesTaxAmount                               := orrs.OrderArray[i1].ShippingDetails.SalesTax.SalesTaxAmount.Text;
                      ShippingDetails.SalesTax.SalesTaxAmountCurrCode                       := EnumtoStr(orrs.OrderArray[i1].ShippingDetails.SalesTax.SalesTaxAmount.currencyID);
                    end;
                    ShippingDetails.SalesTax.PostDB;
              end;*)
              (*if high(orrs.OrderArray[i1].ShippingDetails.TaxTable)>=0 then
                  for i2 := low(orrs.OrderArray[i1].ShippingDetails.TaxTable) to high(orrs.OrderArray[i1].ShippingDetails.TaxTable) do begin
                    //Log(ShippingDetails.Taxable.classname + ' = ' + orrs.OrderArray[i1].ShippingDetails.TaxTable[i2].ClassName);
                    ShippingDetails.Taxable.New;
                    ShippingDetails.Taxable.OrderID := ShippingDetails.OrderID;
                    ShippingDetails.Taxable.Orders_Shipping_Id:= ShippingDetails.ID;
                    ShippingDetails.Taxable.JurisdictionID                               := orrs.OrderArray[i1].ShippingDetails.TaxTable[i2].JurisdictionID;
                    ShippingDetails.Taxable.SalesTaxPercent                              := orrs.OrderArray[i1].ShippingDetails.TaxTable[i2].SalesTaxPercent;
                    ShippingDetails.Taxable.ShippingIncludedInTax                        := orrs.OrderArray[i1].ShippingDetails.TaxTable[i2].ShippingIncludedInTax;
                    ShippingDetails.Taxable.JurisdictionName                             := orrs.OrderArray[i1].ShippingDetails.TaxTable[i2].JurisdictionName;
                    ShippingDetails.Taxable.DetailVersion                                := orrs.OrderArray[i1].ShippingDetails.TaxTable[i2].DetailVersion;
                    ShippingDetails.Taxable.PostDB;
                  end;*)
              (*if high(orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails)>=0 then
                  for i2 := low(orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails) to high(orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails) do begin
                    //Log(ShippingDetails.ShipUptrack.classname + ' = ' + orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails[i2].ClassName);
                    ShippingDetails.ShipUptrack.New;
                    ShippingDetails.ShipUptrack.OrderID                                   := ShippingDetails.OrderID;
                    ShippingDetails.ShipUptrack.Orders_Shipping_Id                        := ShippingDetails.ID;
                    ShippingDetails.ShipUptrack.ShippingCarrierUsed                       := orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails[i2].ShippingCarrierUsed;
                    ShippingDetails.ShipUptrack.ShipmentTrackingNumber                    := orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails[i2].ShipmentTrackingNumber;
                    ShippingDetails.ShipUptrack.PostDB;
                    if high(orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails[i2].ShipmentLineItem )>=0 then
                      for i3 := low(orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails[i2].ShipmentLineItem) to high(orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails[i2].ShipmentLineItem) do begin
                        ShippingDetails.ShipUptrack.Shipline.New;
                        ShippingDetails.ShipUptrack.Shipline.OrderID                      := ShippingDetails.ShipUptrack.OrderId;
                        ShippingDetails.ShipUptrack.Shipline.Orders_Shipping_Id           := ShippingDetails.ShipUptrack.Orders_Shipping_Id;
                        ShippingDetails.ShipUptrack.Shipline.Orders_Shipping_ShiupTrack_Id:= ShippingDetails.ShipUptrack.ID;
                        ShippingDetails.ShipUptrack.Shipline.Quantity                     := orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails[i2].ShipmentLineItem[i3].Quantity ;
                        ShippingDetails.ShipUptrack.Shipline.CountryOfOrigin              := orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails[i2].ShipmentLineItem[i3].CountryOfOrigin;
                        ShippingDetails.ShipUptrack.Shipline.Description                  := orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails[i2].ShipmentLineItem[i3].Description ;
                        ShippingDetails.ShipUptrack.Shipline.ItemID                       := orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails[i2].ShipmentLineItem[i3].ItemID ;
                        ShippingDetails.ShipUptrack.Shipline.TransactionID                := orrs.OrderArray[i1].ShippingDetails.ShipmentTrackingDetails[i2].ShipmentLineItem[i3].TransactionID;
                        ShippingDetails.ShipUptrack.Shipline.PostDB;
                      end;
                  end;*)
              (*if high(orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions)>=0 then
                  for i2 := low(orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions) to high(orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions) do begin
                      //Log(ShippingDetails.ShipServ.classname + ' = ' + orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ClassName);
                      ShippingDetails.ShipServ.New;
                      ShippingDetails.ShipServ.OrderID                              := ShippingDetails.OrderId;
                      ShippingDetails.ShipServ.Orders_Shipping_Id                   := ShippingDetails.ID;
                      ShippingDetails.ShipServ.ShippingService                      := orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingService;
                      ShippingDetails.ShipServ.ShippingServicePriority              := orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingServicePriority;
                      ShippingDetails.ShipServ.ExpeditedService                     := orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ExpeditedService;
                      ShippingDetails.ShipServ.ShippingTimeMin                      := orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingTimeMin;
                      ShippingDetails.ShipServ.ShippingTimeMax                      := orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingTimeMax;
                      ShippingDetails.ShipServ.FreeShipping                         := orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].FreeShipping;
                      ShippingDetails.ShipServ.LocalPickup                          := orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].LocalPickup;

                      if orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingInsuranceCost <> nil then begin
                        ShippingDetails.ShipServ.ShippingInsuranceCostamt             := orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingInsuranceCost.Text;
                        ShippingDetails.ShipServ.ShippingInsuranceCostCurcode         := EnumtoStr(orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingInsuranceCost.CurrencyID);
                      end;

                      if orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingSurcharge <> nil then begin
                        ShippingDetails.ShipServ.ShippingSurchargeamt                 := orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingSurcharge.Text;
                        ShippingDetails.ShipServ.ShippingSurchargeCurcode             := EnumtoStr(orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingSurcharge.CurrencyID);
                      end;

                      if orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ImportCharge <> nil then begin
                        ShippingDetails.ShipServ.ImportChargeamt                      := orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ImportCharge.Text;
                        ShippingDetails.ShipServ.ImportChargeCurcode                  := EnumtoStr(orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ImportCharge.CurrencyID);
                      end;

                      if orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingServiceCost <> nil then begin
                        ShippingDetails.ShipServ.ShippingServiceCostamt               := orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingServiceCost.Text;
                        ShippingDetails.ShipServ.ShippingServiceCostCurcode           := EnumtoStr(orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingServiceCost.CurrencyID);
                      end;

                      if orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingServiceAdditionalCost <> nil then begin
                        ShippingDetails.ShipServ.ShippingServiceAdditionalCostamt     := orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingServiceAdditionalCost.Text;
                        ShippingDetails.ShipServ.ShippingServiceAdditionalCostCurcode := EnumtoStr(orrs.OrderArray[i1].ShippingDetails.ShippingServiceOptions[i2].ShippingServiceAdditionalCost.CurrencyID);
                      end;



                      ShippingDetails.ShipServ.PostDB;
                  end;*)
              end;
          Except
            on E:Exception do begin
              //Log( '5 - Exception :' +E.Message, ltError);
            end;
          end;
          try
              if high(orrs.OrderArray[i1].PaymentMethods)>=0 then
                for i2 := low(orrs.OrderArray[i1].PaymentMethods) to high(orrs.OrderArray[i1].PaymentMethods) do begin
                  if Paymethods.Locate('PaymentMethods' , EnumtOStr(orrs.OrderArray[i1].PaymentMethods[i2]) , []) = false then begin
                    //Log(Paymethods.classname + ' = ' + 'PaymentMethods');
                    Paymethods.New;
                    Paymethods.PaymentMethods := EnumtOStr(orrs.OrderArray[i1].PaymentMethods[i2]);
                    Paymethods.PostDB;
                  end;
                end;
            Except
              on E:Exception do begin
                //Log( '6 - Exception :' +E.Message, ltError);
              end;
            end;
            try
              if orrs.OrderArray[i1].ShippingAddress <> nil then begin
                //Log(ShippingDetails.classname + ' = ' + orrs.OrderArray[i1].ShippingAddress.ClassName);
                ShippingAddress.New;
                ShippingAddress.OrderId := ID;
                ShippingAddress.Name_                                        := orrs.OrderArray[i1].ShippingAddress.Name_;
                ShippingAddress.Street                                       := orrs.OrderArray[i1].ShippingAddress.Street;
                ShippingAddress.Street1                                      := orrs.OrderArray[i1].ShippingAddress.Street1;
                ShippingAddress.Street2                                      := orrs.OrderArray[i1].ShippingAddress.Street2;
                ShippingAddress.CityName                                     := orrs.OrderArray[i1].ShippingAddress.CityName;
                ShippingAddress.County                                       := orrs.OrderArray[i1].ShippingAddress.County;
                ShippingAddress.StateOrProvince                              := orrs.OrderArray[i1].ShippingAddress.StateOrProvince;
                ShippingAddress.Country                                      := EnumToStr(orrs.OrderArray[i1].ShippingAddress.Country);
                ShippingAddress.CountryName                                  := orrs.OrderArray[i1].ShippingAddress.CountryName;
                ShippingAddress.Phone                                        := orrs.OrderArray[i1].ShippingAddress.Phone;
                ShippingAddress.PhoneCountryCode                             := EnumToStr(orrs.OrderArray[i1].ShippingAddress.PhoneCountryCode);
                ShippingAddress.PhoneCountryPrefix                           := orrs.OrderArray[i1].ShippingAddress.PhoneCountryPrefix;
                ShippingAddress.PhoneAreaOrCityCode                          := orrs.OrderArray[i1].ShippingAddress.PhoneAreaOrCityCode;
                ShippingAddress.PhoneLocalNumber                             := orrs.OrderArray[i1].ShippingAddress.PhoneLocalNumber;
                //ShippingAddress.Phone2CountryCode                            := EnumToStr(orrs.OrderArray[i1].ShippingAddress.Phone2CountryCode);
                //ShippingAddress.Phone2CountryPrefix                          := orrs.OrderArray[i1].ShippingAddress.Phone2CountryPrefix;
                //ShippingAddress.Phone2AreaOrCityCode                         := orrs.OrderArray[i1].ShippingAddress.Phone2AreaOrCityCode;
                //ShippingAddress.Phone2LocalNumber                            := orrs.OrderArray[i1].ShippingAddress.Phone2LocalNumber;
                ShippingAddress.PostalCode                                   := orrs.OrderArray[i1].ShippingAddress.PostalCode;
                ShippingAddress.AddressID                                    := orrs.OrderArray[i1].ShippingAddress.AddressID;
                ShippingAddress.AddressOwner                                 := EnumToStr(orrs.OrderArray[i1].ShippingAddress.AddressOwner);
                ShippingAddress.AddressStatus                                := EnumToStr(orrs.OrderArray[i1].ShippingAddress.AddressStatus);
                ShippingAddress.ExternalAddressID                            := orrs.OrderArray[i1].ShippingAddress.ExternalAddressID;
                ShippingAddress.InternationalName                            := orrs.OrderArray[i1].ShippingAddress.InternationalName;
                ShippingAddress.InternationalStateAndCity                    := orrs.OrderArray[i1].ShippingAddress.InternationalStateAndCity;
                ShippingAddress.InternationalStreet                          := orrs.OrderArray[i1].ShippingAddress.InternationalStreet;
                ShippingAddress.CompanyName                                  := orrs.OrderArray[i1].ShippingAddress.CompanyName;
                ShippingAddress.AddressRecordType                            := EnumToStr(orrs.OrderArray[i1].ShippingAddress.AddressRecordType);
                ShippingAddress.FirstName                                    := orrs.OrderArray[i1].ShippingAddress.FirstName;
                ShippingAddress.LastName                                     := orrs.OrderArray[i1].ShippingAddress.LastName;
                ShippingAddress.Phone2                                       := orrs.OrderArray[i1].ShippingAddress.Phone2;
                ShippingAddress.AddressUsage                                 := EnumToStr(orrs.OrderArray[i1].ShippingAddress.AddressUsage);
                ShippingAddress.ReferenceID                                  := orrs.OrderArray[i1].ShippingAddress.ReferenceID;
                ShippingAddress.PostDB;
              end;
          Except
            on E:Exception do begin
              //Log( '7 - Exception :' +E.Message, ltError);
            end;
          end;
             (*if orrs.OrderArray[i1].ShippingServiceSelected <> nil then begin
                  //Log(ShipServiceSel.classname + ' = ' + orrs.OrderArray[i1].ShippingServiceSelected.ClassName);
                  ShipServiceSel.New;
                  ShipServiceSel.OrderId := ID;
                  ShipServiceSel.ShippingService                      := orrs.OrderArray[i1].ShippingServiceSelected.ShippingService;
                  ShipServiceSel.ShippingServicePriority              := orrs.OrderArray[i1].ShippingServiceSelected.ShippingServicePriority;
                  ShipServiceSel.ExpeditedService                     := orrs.OrderArray[i1].ShippingServiceSelected.ExpeditedService;
                  ShipServiceSel.ShippingTimeMin                      := orrs.OrderArray[i1].ShippingServiceSelected.ShippingTimeMin;
                  ShipServiceSel.ShippingTimeMax                      := orrs.OrderArray[i1].ShippingServiceSelected.ShippingTimeMax;
                  ShipServiceSel.FreeShipping                         := orrs.OrderArray[i1].ShippingServiceSelected.FreeShipping;
                  ShipServiceSel.LocalPickup                          := orrs.OrderArray[i1].ShippingServiceSelected.LocalPickup;

                  if orrs.OrderArray[i1].ShippingServiceSelected.ShippingInsuranceCost <> nil then begin
                    ShipServiceSel.ShippingInsuranceCost                := orrs.OrderArray[i1].ShippingServiceSelected.ShippingInsuranceCost.Text;
                    ShipServiceSel.ShippingInsuranceCostcurcode         := EnumtoStr(orrs.OrderArray[i1].ShippingServiceSelected.ShippingInsuranceCost.CurrencyID);
                  end;

                  if orrs.OrderArray[i1].ShippingServiceSelected.ShippingServiceCost <> nil then begin
                    ShipServiceSel.ShippingServiceCost                  := orrs.OrderArray[i1].ShippingServiceSelected.ShippingServiceCost.Text;
                    ShipServiceSel.ShippingServiceCostcurcode           := EnumtoStr(orrs.OrderArray[i1].ShippingServiceSelected.ShippingServiceCost.CurrencyID);
                  end;

                  if orrs.OrderArray[i1].ShippingServiceSelected.ShippingServiceAdditionalCost <> nil then begin
                    ShipServiceSel.ShippingServiceAdditionalCost        := orrs.OrderArray[i1].ShippingServiceSelected.ShippingServiceAdditionalCost.Text;
                    ShipServiceSel.ShippingServiceAdditionalCostcurcode := EnumtoStr(orrs.OrderArray[i1].ShippingServiceSelected.ShippingServiceAdditionalCost.CurrencyID);
                  end;

                  if orrs.OrderArray[i1].ShippingServiceSelected.ShippingSurcharge <> nil then begin
                    ShipServiceSel.ShippingSurcharge                    := orrs.OrderArray[i1].ShippingServiceSelected.ShippingSurcharge.Text;
                    ShipServiceSel.ShippingSurchargecurcode             := EnumtoStr(orrs.OrderArray[i1].ShippingServiceSelected.ShippingSurcharge.CurrencyID);
                  end;

                  if orrs.OrderArray[i1].ShippingServiceSelected.ImportCharge <> nil then begin
                    ShipServiceSel.ImportCharge                         := orrs.OrderArray[i1].ShippingServiceSelected.ImportCharge.Text;
                    ShipServiceSel.ImportChargecurcode                  := EnumtoStr(orrs.OrderArray[i1].ShippingServiceSelected.ImportCharge.CurrencyID);
                  end;
             end;*)
             (*if high(orrs.OrderArray[i1].ExternalTransaction) >=0 then
              for i2 := low(orrs.OrderArray[i1].ExternalTransaction) to high(orrs.OrderArray[i1].ExternalTransaction) do begin
                  //Log(ExternalTransaction.classname + ' = ' + orrs.OrderArray[i1].ExternalTransaction[i2].ClassName);
                  ExternalTransaction.New;
                  ExternalTransaction.OrderId := ID;
                  if orrs.OrderArray[i1].ExternalTransaction[i2].FeeOrCreditAmount <> nil then begin
                    ExternalTransaction.FeeOrCreditAmountCurcode        := EnumToStr(orrs.OrderArray[i1].ExternalTransaction[i2].FeeOrCreditAmount.currencyID);
                    ExternalTransaction.FeeOrCreditAmount               := orrs.OrderArray[i1].ExternalTransaction[i2].FeeOrCreditAmount.Text;
                  end;
                  if orrs.OrderArray[i1].ExternalTransaction[i2].PaymentOrRefundAmount <> nil then begin
                    ExternalTransaction.PaymentOrRefundAmountCurcode    := EnumToStr(orrs.OrderArray[i1].ExternalTransaction[i2].PaymentOrRefundAmount.currencyID);
                    ExternalTransaction.PaymentOrRefundAmount           := orrs.OrderArray[i1].ExternalTransaction[i2].PaymentOrRefundAmount.text;
                  end;

                  ExternalTransaction.ExternalTransactionTime         := XSDttimeToDtTime(orrs.OrderArray[i1].ExternalTransaction[i2].ExternalTransactionTime);
                  ExternalTransaction.PostDB;
              end;*)
            if high(orrs.OrderArray[i1].TransactionArray) >=0 then
              for i2 := low(orrs.OrderArray[i1].TransactionArray) to high(orrs.OrderArray[i1].TransactionArray) do begin
                try
                  Transactions.New;
                  Transactions.OrderId := ID;
                  Transactions.CreatedDate                     := XSDttimeToDtTime(orrs.OrderArray[i1].TransactionArray[i2].CreatedDate);
                  Transactions.DepositType                     := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].DepositType);
                  Transactions.QuantityPurchased               := orrs.OrderArray[i1].TransactionArray[i2].QuantityPurchased;
                  Transactions.TransactionID                   := orrs.OrderArray[i1].TransactionArray[i2].TransactionID;
                  Transactions.BestOfferSale                   := orrs.OrderArray[i1].TransactionArray[i2].BestOfferSale;
                  Transactions.BuyerMessage                    := orrs.OrderArray[i1].TransactionArray[i2].BuyerMessage;
                  Transactions.BuyerPaidStatus                 := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].BuyerPaidStatus);
                  Transactions.SellerPaidStatus                := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].SellerPaidStatus);
                  Transactions.TransactionSiteID               := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].TransactionSiteID);
                  Transactions.Platform_                       := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Platform_);
                  Transactions.CartID                          := orrs.OrderArray[i1].TransactionArray[i2].CartID;
                  Transactions.SellerContactBuyerByEmail       := orrs.OrderArray[i1].TransactionArray[i2].SellerContactBuyerByEmail;
                  Transactions.PayPalEmailAddress              := orrs.OrderArray[i1].TransactionArray[i2].PayPalEmailAddress;
                  Transactions.PaisaPayID                      := orrs.OrderArray[i1].TransactionArray[i2].PaisaPayID;
                  Transactions.BuyerCheckoutMessage            := orrs.OrderArray[i1].TransactionArray[i2].BuyerCheckoutMessage;
                  Transactions.BundlePurchase                  := orrs.OrderArray[i1].TransactionArray[i2].BundlePurchase;
                  Transactions.OrderLineItemID                 := orrs.OrderArray[i1].TransactionArray[i2].OrderLineItemID;
                  Transactions.RefundStatus                    := orrs.OrderArray[i1].TransactionArray[i2].RefundStatus;
                  Transactions.CodiceFiscale                   := orrs.OrderArray[i1].TransactionArray[i2].CodiceFiscale;
                  Transactions.IsMultiLegShipping              := orrs.OrderArray[i1].TransactionArray[i2].IsMultiLegShipping;
                  Transactions.IntangibleItem                  := orrs.OrderArray[i1].TransactionArray[i2].IntangibleItem;
                  Transactions.Postdb;

                  if orrs.OrderArray[i1].TransactionArray[i2].ActualHandlingCost <> nil then begin
                      Transactions.ActualHandlingCost          := orrs.OrderArray[i1].TransactionArray[i2].ActualHandlingCost.Text;
                      Transactions.ActualHandlingCostCurCode   := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].ActualHandlingCost.CurrencyID);
                  end;
                  if  orrs.OrderArray[i1].TransactionArray[i2].ActualShippingCost <> nil then begin
                      Transactions.ActualShippingCost          := orrs.OrderArray[i1].TransactionArray[i2].ActualShippingCost.Text;
                      Transactions.ActualShippingCostCurCode   := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].ActualShippingCost.CurrencyID);
                  end;
                  if orrs.OrderArray[i1].TransactionArray[i2].AdjustmentAmount <> nil then begin
                      Transactions.AdjustmentAmount            := orrs.OrderArray[i1].TransactionArray[i2].AdjustmentAmount.Text;
                      Transactions.AdjustmentAmountCurCode     := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].AdjustmentAmount.CurrencyID);
                  end;
                  if orrs.OrderArray[i1].TransactionArray[i2].AmountPaid <> nil then begin
                      Transactions.AmountPaid                  := orrs.OrderArray[i1].TransactionArray[i2].AmountPaid.Text;
                      Transactions.AmountPaidCurCode           := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].AmountPaid.CurrencyID);
                  end;
                  if orrs.OrderArray[i1].TransactionArray[i2].BuyerGuaranteePrice <> nil then begin
                      Transactions.BuyerGuaranteePrice         := orrs.OrderArray[i1].TransactionArray[i2].BuyerGuaranteePrice.Text;
                      Transactions.BuyerGuaranteePriceCurCode  := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].BuyerGuaranteePrice.CurrencyID);
                  end;
                  if orrs.OrderArray[i1].TransactionArray[i2].ConvertedAdjustmentAmount <> nil then begin
                      Transactions.ConvertedAdjustmentAmount   := orrs.OrderArray[i1].TransactionArray[i2].ConvertedAdjustmentAmount.Text;
                      Transactions.ConvertedAdjustmentAmountCurCode:= EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].ConvertedAdjustmentAmount.CurrencyID);
                  end;
                  if orrs.OrderArray[i1].TransactionArray[i2].ConvertedAmountPaid <> nil then begin
                      Transactions.ConvertedAmountPaid         := orrs.OrderArray[i1].TransactionArray[i2].ConvertedAmountPaid.Text;
                      Transactions.ConvertedAmountPaidCurCode  := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].ConvertedAmountPaid.CurrencyID);
                  end;
                  if orrs.OrderArray[i1].TransactionArray[i2].ConvertedTransactionPrice <> nil then begin
                      Transactions.ConvertedTransactionPrice   := orrs.OrderArray[i1].TransactionArray[i2].ConvertedTransactionPrice.Text;
                      Transactions.ConvertedTransactionPriceCurCode:= EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].ConvertedTransactionPrice.CurrencyID);
                  end;
                  if orrs.OrderArray[i1].TransactionArray[i2].DutchAuctionBid <> nil then begin
                      Transactions.DutchAuctionBid             := orrs.OrderArray[i1].TransactionArray[i2].DutchAuctionBid.Text;
                      Transactions.DutchAuctionBidCurCode      := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].DutchAuctionBid.CurrencyID);
                  end;
                  if orrs.OrderArray[i1].TransactionArray[i2].FinalValueFee <> nil then begin
                      Transactions.FinalValueFee               := orrs.OrderArray[i1].TransactionArray[i2].FinalValueFee.Text;
                      Transactions.FinalValueFeeCurCode        := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].FinalValueFee.CurrencyID);
                  end;
                  if orrs.OrderArray[i1].TransactionArray[i2].RefundAmount <> nil then begin
                      Transactions.RefundAmount                := orrs.OrderArray[i1].TransactionArray[i2].RefundAmount.Text;
                      Transactions.RefundAmountCurCode         := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].RefundAmount.CurrencyID);
                  end;
                  if orrs.OrderArray[i1].TransactionArray[i2].TotalPrice <> nil then begin
                      Transactions.TotalPrice                  := orrs.OrderArray[i1].TransactionArray[i2].TotalPrice.Text;
                      Transactions.TotalPriceCurCode           := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].TotalPrice.CurrencyID);
                  end;
                  if orrs.OrderArray[i1].TransactionArray[i2].TotalTransactionPrice <> nil then begin
                      Transactions.TotalTransactionPrice       := orrs.OrderArray[i1].TransactionArray[i2].TotalTransactionPrice.Text;
                      Transactions.TotalTransactionPriceCurCode:= EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].TotalTransactionPrice.CurrencyID);
                  end;
                  if orrs.OrderArray[i1].TransactionArray[i2].TransactionPrice <> nil then begin
                      Transactions.TransactionPrice            := orrs.OrderArray[i1].TransactionArray[i2].TransactionPrice.Text;
                      Transactions.TransactionPriceCurCode     := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].TransactionPrice.CurrencyID);
                  end;


                  Transactions.PostDB;
              Except
                on E:Exception do begin
                  //Log( '8 - Exception :' +E.Message, ltError);
                end;
              end;
                  if orrs.OrderArray[i1].TransactionArray[i2].Buyer <> nil then begin
                    //Log(Transactions.Buyer.classname + ' = ' + orrs.OrderArray[i1].TransactionArray[i2].Buyer.ClassName);
                    Transactions.Buyer.New;
                    Transactions.Buyer.OrderId := Transactions.OrderID;
                    Transactions.Buyer.Orders_Trans_Id            := Transactions.Id;
                    Transactions.Buyer.AboutMePage                := orrs.OrderArray[i1].TransactionArray[i2].Buyer.AboutMePage;
                    Transactions.Buyer.EIASToken                  := orrs.OrderArray[i1].TransactionArray[i2].Buyer.EIASToken;
                    Transactions.Buyer.Email                      := orrs.OrderArray[i1].TransactionArray[i2].Buyer.Email;
                    Transactions.Buyer.FeedbackScore              := orrs.OrderArray[i1].TransactionArray[i2].Buyer.FeedbackScore;
                    Transactions.Buyer.UniqueNegativeFeedbackCount:= orrs.OrderArray[i1].TransactionArray[i2].Buyer.UniqueNegativeFeedbackCount;
                    Transactions.Buyer.UniquePositiveFeedbackCount:= orrs.OrderArray[i1].TransactionArray[i2].Buyer.UniquePositiveFeedbackCount;
                    Transactions.Buyer.PositiveFeedbackPercent    := orrs.OrderArray[i1].TransactionArray[i2].Buyer.PositiveFeedbackPercent;
                    Transactions.Buyer.FeedbackPrivate            := orrs.OrderArray[i1].TransactionArray[i2].Buyer.FeedbackPrivate;
                    Transactions.Buyer.FeedbackRatingStar         := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.FeedbackRatingStar);
                    Transactions.Buyer.IDVerified                 := orrs.OrderArray[i1].TransactionArray[i2].Buyer.IDVerified;
                    Transactions.Buyer.eBayGoodStanding           := orrs.OrderArray[i1].TransactionArray[i2].Buyer.eBayGoodStanding;
                    Transactions.Buyer.NewUser                    := orrs.OrderArray[i1].TransactionArray[i2].Buyer.NewUser;
                    Transactions.Buyer.Site                       := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.Site);
                    Transactions.Buyer.Status                     := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.Status);
                    Transactions.Buyer.UserID                     := orrs.OrderArray[i1].TransactionArray[i2].Buyer.UserID;
                    Transactions.Buyer.UserIDChanged              := orrs.OrderArray[i1].TransactionArray[i2].Buyer.UserIDChanged;
                    Transactions.Buyer.VATStatus                  := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.VATStatus);
                    Transactions.Buyer.BusinessRole               := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.BusinessRole);
                    Transactions.Buyer.PayPalAccountLevel         := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.PayPalAccountLevel);
                    Transactions.Buyer.PayPalAccountType          := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.PayPalAccountType);
                    Transactions.Buyer.PayPalAccountStatus        := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.PayPalAccountStatus);
                    Transactions.Buyer.SiteVerified               := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SiteVerified;
                    Transactions.Buyer.eBayWikiReadOnly           := orrs.OrderArray[i1].TransactionArray[i2].Buyer.eBayWikiReadOnly;
                    Transactions.Buyer.TUVLevel                   := orrs.OrderArray[i1].TransactionArray[i2].Buyer.TUVLevel;
                    Transactions.Buyer.VATID                      := orrs.OrderArray[i1].TransactionArray[i2].Buyer.VATID;
                    //Transactions.Buyer.MotorsDealer               := orrs.OrderArray[i1].TransactionArray[i2].Buyer.MotorsDealer;
                    Transactions.Buyer.SellerPaymentMethod        := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerPaymentMethod);
                    Transactions.Buyer.UserAnonymized             := orrs.OrderArray[i1].TransactionArray[i2].Buyer.UserAnonymized;
                    Transactions.Buyer.UniqueNeutralFeedbackCount := orrs.OrderArray[i1].TransactionArray[i2].Buyer.UniqueNeutralFeedbackCount;
                    Transactions.Buyer.EnterpriseSeller           := orrs.OrderArray[i1].TransactionArray[i2].Buyer.EnterpriseSeller;
                    Transactions.Buyer.BillingEmail               := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BillingEmail;
                    Transactions.Buyer.QualifiesForSelling        := orrs.OrderArray[i1].TransactionArray[i2].Buyer.QualifiesForSelling;
                    Transactions.Buyer.StaticAlias                := orrs.OrderArray[i1].TransactionArray[i2].Buyer.StaticAlias;
                    Transactions.Buyer.RegistrationDate           := XSDttimeToDtTime(orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationDate);
                    Transactions.Buyer.UserIDLastChanged          := XSDttimeToDtTime(orrs.OrderArray[i1].TransactionArray[i2].Buyer.UserIDLastChanged);
                    if orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress <> nil then begin
                        Transactions.Buyer.RegistrationAddress_Name_                      := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.Name_;
                        Transactions.Buyer.RegistrationAddress_Street                     := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.Street;
                        Transactions.Buyer.RegistrationAddress_Street1                    := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.Street1;
                        Transactions.Buyer.RegistrationAddress_Street2                    := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.Street2;
                        Transactions.Buyer.RegistrationAddress_CityName                   := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.CityName;
                        Transactions.Buyer.RegistrationAddress_County                     := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.County;
                        Transactions.Buyer.RegistrationAddress_StateOrProvince            := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.StateOrProvince;
                        Transactions.Buyer.RegistrationAddress_Country                    := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.Country);
                        Transactions.Buyer.RegistrationAddress_CountryName                := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.CountryName;
                        Transactions.Buyer.RegistrationAddress_Phone                      := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.Phone;
                        Transactions.Buyer.RegistrationAddress_PhoneCountryCode           := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.PhoneCountryCode);
                        Transactions.Buyer.RegistrationAddress_PhoneCountryPrefix         := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.PhoneCountryPrefix;
                        Transactions.Buyer.RegistrationAddress_PhoneAreaOrCityCode        := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.PhoneAreaOrCityCode;
                        Transactions.Buyer.RegistrationAddress_PhoneLocalNumber           := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.PhoneLocalNumber;
                        //Transactions.Buyer.RegistrationAddress_Phone2CountryCode          := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.Phone2CountryCode);
                        //Transactions.Buyer.RegistrationAddress_Phone2CountryPrefix        := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.Phone2CountryPrefix;
                        //Transactions.Buyer.RegistrationAddress_Phone2AreaOrCityCode       := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.Phone2AreaOrCityCode;
                        //Transactions.Buyer.RegistrationAddress_Phone2LocalNumber          := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.Phone2LocalNumber;
                        Transactions.Buyer.RegistrationAddress_PostalCode                 := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.PostalCode;
                        Transactions.Buyer.RegistrationAddress_AddressID                  := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.AddressID;
                        Transactions.Buyer.RegistrationAddress_AddressOwner               := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.AddressOwner);
                        Transactions.Buyer.RegistrationAddress_AddressStatus              := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.AddressStatus);
                        Transactions.Buyer.RegistrationAddress_ExternalAddressID          := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.ExternalAddressID;
                        Transactions.Buyer.RegistrationAddress_InternationalName          := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.InternationalName;
                        Transactions.Buyer.RegistrationAddress_InternationalStateAndCity  := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.InternationalStateAndCity;
                        Transactions.Buyer.RegistrationAddress_InternationalStreet        := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.InternationalStreet;
                        Transactions.Buyer.RegistrationAddress_CompanyName                := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.CompanyName;
                        Transactions.Buyer.RegistrationAddress_AddressRecordType          := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.AddressRecordType);
                        Transactions.Buyer.RegistrationAddress_FirstName                  := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.FirstName;
                        Transactions.Buyer.RegistrationAddress_LastName                   := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.LastName;
                        Transactions.Buyer.RegistrationAddress_Phone2                     := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.Phone2;
                        Transactions.Buyer.RegistrationAddress_AddressUsage               := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.AddressUsage);
                        Transactions.Buyer.RegistrationAddress_ReferenceID                := orrs.OrderArray[i1].TransactionArray[i2].Buyer.RegistrationAddress.ReferenceID;
                  end;
                  if (orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo <> nil) and (orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress<> nil) then begin
                        Transactions.Buyer.Buyer_ShippingAddres_Name_                     := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.Name_;
                        Transactions.Buyer.Buyer_ShippingAddres_Street                    := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.Street;
                        Transactions.Buyer.Buyer_ShippingAddres_Street1                   := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.Street1;
                        Transactions.Buyer.Buyer_ShippingAddres_Street2                   := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.Street2;
                        Transactions.Buyer.Buyer_ShippingAddres_CityName                  := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.CityName;
                        Transactions.Buyer.Buyer_ShippingAddres_County                    := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.County;
                        Transactions.Buyer.Buyer_ShippingAddres_StateOrProvince           := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.StateOrProvince;
                        Transactions.Buyer.Buyer_ShippingAddres_Country                   := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.Country);
                        Transactions.Buyer.Buyer_ShippingAddres_CountryName               := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.CountryName;
                        Transactions.Buyer.Buyer_ShippingAddres_Phone                     := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.Phone;
                        Transactions.Buyer.Buyer_ShippingAddres_PhoneCountryCode          := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.PhoneCountryCode);
                        Transactions.Buyer.Buyer_ShippingAddres_PhoneCountryPrefix        := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.PhoneCountryPrefix;
                        Transactions.Buyer.Buyer_ShippingAddres_PhoneAreaOrCityCode       := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.PhoneAreaOrCityCode;
                        Transactions.Buyer.Buyer_ShippingAddres_PhoneLocalNumber          := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.PhoneLocalNumber;
                        //Transactions.Buyer.Buyer_ShippingAddres_Phone2CountryCode         := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.Phone2CountryCode);
                        //Transactions.Buyer.Buyer_ShippingAddres_Phone2CountryPrefix       := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.Phone2CountryPrefix;
                        //Transactions.Buyer.Buyer_ShippingAddres_Phone2AreaOrCityCode      := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.Phone2AreaOrCityCode;
                        //Transactions.Buyer.Buyer_ShippingAddres_Phone2LocalNumber         := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.Phone2LocalNumber;
                        Transactions.Buyer.Buyer_ShippingAddres_PostalCode                := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.PostalCode;
                        Transactions.Buyer.Buyer_ShippingAddres_AddressID                 := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.AddressID;
                        Transactions.Buyer.Buyer_ShippingAddres_AddressOwner              := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.AddressOwner);
                        Transactions.Buyer.Buyer_ShippingAddres_AddressStatus             := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.AddressStatus);
                        Transactions.Buyer.Buyer_ShippingAddres_ExternalAddressID         := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.ExternalAddressID;
                        Transactions.Buyer.Buyer_ShippingAddres_InternationalName         := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.InternationalName;
                        Transactions.Buyer.Buyer_ShippingAddres_InternationalStateAndCity := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.InternationalStateAndCity;
                        Transactions.Buyer.Buyer_ShippingAddres_InternationalStreet       := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.InternationalStreet;
                        Transactions.Buyer.Buyer_ShippingAddres_CompanyName               := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.CompanyName;
                        Transactions.Buyer.Buyer_ShippingAddres_AddressRecordType         := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.AddressRecordType);
                        Transactions.Buyer.Buyer_ShippingAddres_FirstName                 := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.FirstName;
                        Transactions.Buyer.Buyer_ShippingAddres_LastName                  := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.LastName;
                        Transactions.Buyer.Buyer_ShippingAddres_Phone2                    := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.Phone2;
                        Transactions.Buyer.Buyer_ShippingAddres_AddressUsage              := EnumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.AddressUsage);
                        Transactions.Buyer.Buyer_ShippingAddres_ReferenceID               := orrs.OrderArray[i1].TransactionArray[i2].Buyer.BuyerInfo.ShippingAddress.ReferenceID;
                    end;
                    Transactions.Buyer.PostDB;
                    (*if orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo <> nil then begin
                        //Log(Transactions.Buyer.SellerInfo.classname + ' = ' + orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.ClassName);
                        Transactions.Buyer.SellerInfo.New;
                        Transactions.Buyer.SellerInfo.OrderId                       := Transactions.Buyer.OrderID;
                        Transactions.Buyer.SellerInfo.Orders_Trans_Id               := Transactions.Buyer.Orders_Trans_Id;
                        Transactions.Buyer.SellerInfo.Orders_Trans_buyer_Id         := Transactions.Buyer.ID;
                        Transactions.Buyer.SellerInfo.PaisaPayStatus                := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.PaisaPayStatus;
                        Transactions.Buyer.SellerInfo.AllowPaymentEdit              := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.AllowPaymentEdit;
                        Transactions.Buyer.SellerInfo.BillingCurrency               := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.BillingCurrency);
                        Transactions.Buyer.SellerInfo.CheckoutEnabled               := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.CheckoutEnabled;
                        Transactions.Buyer.SellerInfo.CIPBankAccountStored          := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.CIPBankAccountStored;
                        Transactions.Buyer.SellerInfo.GoodStanding                  := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.GoodStanding;
                        Transactions.Buyer.SellerInfo.MerchandizingPref             := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.MerchandizingPref);
                        Transactions.Buyer.SellerInfo.QualifiesForB2BVAT            := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.QualifiesForB2BVAT;
                        Transactions.Buyer.SellerInfo.SellerGuaranteeLevel          := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerGuaranteeLevel);
                        Transactions.Buyer.SellerInfo.SellerLevel                   := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerLevel);
                        Transactions.Buyer.SellerInfo.StoreOwner                    := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.StoreOwner;
                        Transactions.Buyer.SellerInfo.StoreURL                      := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.StoreURL;
                        Transactions.Buyer.SellerInfo.SellerBusinessType            := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerBusinessType);
                        Transactions.Buyer.SellerInfo.RegisteredBusinessSeller      := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.RegisteredBusinessSeller;
                        Transactions.Buyer.SellerInfo.StoreSite                     := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.StoreSite);
                        Transactions.Buyer.SellerInfo.CharityRegistered             := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.CharityRegistered;
                        Transactions.Buyer.SellerInfo.SafePaymentExempt             := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SafePaymentExempt;
                        Transactions.Buyer.SellerInfo.PaisaPayEscrowEMIStatus       := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.PaisaPayEscrowEMIStatus;
                        Transactions.Buyer.SellerInfo.TransactionPercent            := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.TransactionPercent;
                        Transactions.Buyer.SellerInfo.TopRatedSeller                := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.TopRatedSeller;
                        Transactions.Buyer.SellerInfo.DomesticRateTable             := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.DomesticRateTable;
                        Transactions.Buyer.SellerInfo.InternationalRateTable        := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.InternationalRateTable;
                        Transactions.Buyer.SellerInfo.SellereBayPaymentProcessStatus:= EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellereBayPaymentProcessStatus);
                        Transactions.Buyer.SellerInfo.PaymentMethod                 := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.PaymentMethod);
                        if orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress <> nil then begin
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_Name_                    := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.Name_;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_Street                   := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.Street;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_Street1                  := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.Street1;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_Street2                  := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.Street2;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_CityName                 := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.CityName;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_County                   := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.County;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_StateOrProvince          := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.StateOrProvince;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_Country                  := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.Country);
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_CountryName              := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.CountryName;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_Phone                    := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.Phone;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_PhoneCountryCode         := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.PhoneCountryCode);
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_PhoneCountryPrefix       := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.PhoneCountryPrefix;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_PhoneAreaOrCityCode      := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.PhoneAreaOrCityCode;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_PhoneLocalNumber         := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.PhoneLocalNumber;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_Phone2CountryCode        := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.Phone2CountryCode);
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_Phone2CountryPrefix      := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.Phone2CountryPrefix;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_Phone2AreaOrCityCode     := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.Phone2AreaOrCityCode;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_Phone2LocalNumber        := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.Phone2LocalNumber;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_PostalCode               := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.PostalCode;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_AddressID                := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.AddressID;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_AddressOwner             := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.AddressOwner);
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_AddressStatus            := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.AddressStatus);
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_ExternalAddressID        := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.ExternalAddressID;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_InternationalName        := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.InternationalName;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_InternationalStateAndCity:= orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.InternationalStateAndCity;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_InternationalStreet      := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.InternationalStreet;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_CompanyName              := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.CompanyName;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_AddressRecordType        := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.AddressRecordType);
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_FirstName                := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.FirstName;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_LastName                 := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.LastName;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_Phone2                   := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.Phone2;
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_AddressUsage             := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.AddressUsage);
                          Transactions.Buyer.SellerInfo.SellerPaymentAddress_ReferenceID              := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellerPaymentAddress.ReferenceID;
                        end;
                        if orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SchedulingInfo <> nil then begin
                          Transactions.Buyer.SellerInfo.SchedulingInfo_MaxScheduledMinutes            := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SchedulingInfo.MaxScheduledMinutes;
                          Transactions.Buyer.SellerInfo.SchedulingInfo_MinScheduledMinutes            := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SchedulingInfo.MinScheduledMinutes;
                          Transactions.Buyer.SellerInfo.SchedulingInfo_MaxScheduledItems              := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SchedulingInfo.MaxScheduledItems;
                        end;
                        if orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.FeatureEligibility <> nil then begin
                          Transactions.Buyer.SellerInfo.FeatureEligibility_QualifiesForBuyItNow                := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.FeatureEligibility.QualifiesForBuyItNow;
                          Transactions.Buyer.SellerInfo.FeatureEligibility_QualifiesForBuyItNowMultiple        := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.FeatureEligibility.QualifiesForBuyItNowMultiple;
                          Transactions.Buyer.SellerInfo.FeatureEligibility_QualifiedForFixedPriceOneDayDuration:= orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.FeatureEligibility.QualifiedForFixedPriceOneDayDuration;
                          Transactions.Buyer.SellerInfo.FeatureEligibility_QualifiesForVariations              := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.FeatureEligibility.QualifiesForVariations;
                          Transactions.Buyer.SellerInfo.FeatureEligibility_QualifiedForAuctionOneDayDuration   := orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.FeatureEligibility.QualifiedForAuctionOneDayDuration;
                        end;
                        if orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellereBayPaymentProcessConsent <> nil then begin
                          Transactions.Buyer.SellerInfo.SellereBayPaymentProcessConsent_PayoutMethodSet:= orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellereBayPaymentProcessConsent.PayoutMethodSet;
                          Transactions.Buyer.SellerInfo.SellereBayPaymentProcessConsent_PayoutMethod   := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Buyer.SellerInfo.SellereBayPaymentProcessConsent.PayoutMethod);
                        end;
                        Transactions.Buyer.SellerInfo.PostDB;
                    end;*)
                  end;
                    if orrs.OrderArray[i1].TransactionArray[i2].Item <> nil then begin
                      try
                        Transactions.Item.New;
                        Transactions.Item.OrderID                                      := Transactions.OrderID;
                        Transactions.Item.Orders_Trans_Id                              := Transactions.ID;
                        Transactions.Item.ApplicationData                              := orrs.OrderArray[i1].TransactionArray[i2].Item.ApplicationData;
                        Transactions.Item.AutoPay                                      := orrs.OrderArray[i1].TransactionArray[i2].Item.AutoPay;
                        //Transactions.Item.MotorsGermanySearchable                      := orrs.OrderArray[i1].TransactionArray[i2].Item.MotorsGermanySearchable;
                        Transactions.Item.BuyerProtection                              := enumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Item.BuyerProtection);
                        Transactions.Item.CategoryMappingAllowed                       := orrs.OrderArray[i1].TransactionArray[i2].Item.CategoryMappingAllowed;
                        Transactions.Item.Country                                      := enumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Item.Country);
                        Transactions.Item.Currency                                     := enumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Item.Currency);
                        Transactions.Item.Description                                  := orrs.OrderArray[i1].TransactionArray[i2].Item.Description;
                        Transactions.Item.DescriptionReviseMode                        := enumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Item.DescriptionReviseMode);
                        //Transactions.Item.GiftIcon                                     := orrs.OrderArray[i1].TransactionArray[i2].Item.GiftIcon;
                        Transactions.Item.HitCounter                                   := enumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Item.HitCounter);
                        Transactions.Item.ItemID                                       := orrs.OrderArray[i1].TransactionArray[i2].Item.ItemID;
                        Transactions.Item.ListingDuration                              := orrs.OrderArray[i1].TransactionArray[i2].Item.ListingDuration;
                        Transactions.Item.ListingType                                  := enumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Item.ListingType);
                        Transactions.Item.Location                                     := orrs.OrderArray[i1].TransactionArray[i2].Item.Location;
                        Transactions.Item.LotSize                                      := orrs.OrderArray[i1].TransactionArray[i2].Item.LotSize;
                        Transactions.Item.PartnerCode                                  := orrs.OrderArray[i1].TransactionArray[i2].Item.PartnerCode;
                        Transactions.Item.PartnerName                                  := orrs.OrderArray[i1].TransactionArray[i2].Item.PartnerName;
                        Transactions.Item.PayPalEmailAddress                           := orrs.OrderArray[i1].TransactionArray[i2].Item.PayPalEmailAddress;
                        Transactions.Item.PrivateListing                               := orrs.OrderArray[i1].TransactionArray[i2].Item.PrivateListing;
                        Transactions.Item.Quantity                                     := orrs.OrderArray[i1].TransactionArray[i2].Item.Quantity;
                        Transactions.Item.PrivateNotes                                 := orrs.OrderArray[i1].TransactionArray[i2].Item.PrivateNotes;
                        Transactions.Item.RegionID                                     := orrs.OrderArray[i1].TransactionArray[i2].Item.RegionID;
                        Transactions.Item.RelistLink                                   := orrs.OrderArray[i1].TransactionArray[i2].Item.RelistLink;
                        Transactions.Item.Site                                         := enumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Item.Site);
                        Transactions.Item.SubTitle                                     := orrs.OrderArray[i1].TransactionArray[i2].Item.SubTitle;
                        Transactions.Item.Title                                        := orrs.OrderArray[i1].TransactionArray[i2].Item.Title;
                        Transactions.Item.UUID                                         := orrs.OrderArray[i1].TransactionArray[i2].Item.UUID;
                        Transactions.Item.SellerVacationNote                           := orrs.OrderArray[i1].TransactionArray[i2].Item.SellerVacationNote;
                        Transactions.Item.WatchCount                                   := orrs.OrderArray[i1].TransactionArray[i2].Item.WatchCount;
                        Transactions.Item.HitCount                                     := orrs.OrderArray[i1].TransactionArray[i2].Item.HitCount;
                        Transactions.Item.DisableBuyerRequirements                     := orrs.OrderArray[i1].TransactionArray[i2].Item.DisableBuyerRequirements;
                        Transactions.Item.LocationDefaulted                            := orrs.OrderArray[i1].TransactionArray[i2].Item.LocationDefaulted;
                        //Transactions.Item.ThirdPartyCheckout                           := orrs.OrderArray[i1].TransactionArray[i2].Item.ThirdPartyCheckout;
                        Transactions.Item.UseTaxTable                                  := orrs.OrderArray[i1].TransactionArray[i2].Item.UseTaxTable;
                        Transactions.Item.GetItFast                                    := orrs.OrderArray[i1].TransactionArray[i2].Item.GetItFast;
                        Transactions.Item.BuyerResponsibleForShipping                  := orrs.OrderArray[i1].TransactionArray[i2].Item.BuyerResponsibleForShipping;
                        Transactions.Item.LimitedWarrantyEligible                      := orrs.OrderArray[i1].TransactionArray[i2].Item.LimitedWarrantyEligible;
                        Transactions.Item.eBayNotes                                    := orrs.OrderArray[i1].TransactionArray[i2].Item.eBayNotes;
                        Transactions.Item.QuestionCount                                := orrs.OrderArray[i1].TransactionArray[i2].Item.QuestionCount;
                        Transactions.Item.Relisted                                     := orrs.OrderArray[i1].TransactionArray[i2].Item.Relisted;
                        Transactions.Item.QuantityAvailable                            := orrs.OrderArray[i1].TransactionArray[i2].Item.QuantityAvailable;
                        Transactions.Item.SKU                                          := orrs.OrderArray[i1].TransactionArray[i2].Item.SKU;
                        //Transactions.Item.CategoryBasedAttributesPrefill               := orrs.OrderArray[i1].TransactionArray[i2].Item.CategoryBasedAttributesPrefill;
                        Transactions.Item.PostalCode                                   := orrs.OrderArray[i1].TransactionArray[i2].Item.PostalCode;
                        //Transactions.Item.ShippingTermsInDescription                   := orrs.OrderArray[i1].TransactionArray[i2].Item.ShippingTermsInDescription;
                        //Transactions.Item.SellerInventoryID                            := orrs.OrderArray[i1].TransactionArray[i2].Item.SellerInventoryID;
                        Transactions.Item.DispatchTimeMax                              := orrs.OrderArray[i1].TransactionArray[i2].Item.DispatchTimeMax;
                        //Transactions.Item.SkypeEnabled                                 := orrs.OrderArray[i1].TransactionArray[i2].Item.SkypeEnabled;
                        //Transactions.Item.SkypeID                                      := orrs.OrderArray[i1].TransactionArray[i2].Item.SkypeID;
                        Transactions.Item.BestOfferEnabled                             := orrs.OrderArray[i1].TransactionArray[i2].Item.BestOfferEnabled;
                        Transactions.Item.LocalListing                                 := orrs.OrderArray[i1].TransactionArray[i2].Item.LocalListing;
                        //Transactions.Item.ThirdPartyCheckoutIntegration                := orrs.OrderArray[i1].TransactionArray[i2].Item.ThirdPartyCheckoutIntegration;
                        Transactions.Item.TotalQuestionCount                           := orrs.OrderArray[i1].TransactionArray[i2].Item.TotalQuestionCount;
                        Transactions.Item.ProxyItem                                    := orrs.OrderArray[i1].TransactionArray[i2].Item.ProxyItem;
                        Transactions.Item.LeadCount                                    := orrs.OrderArray[i1].TransactionArray[i2].Item.LeadCount;
                        Transactions.Item.NewLeadCount                                 := orrs.OrderArray[i1].TransactionArray[i2].Item.NewLeadCount;
                        Transactions.Item.GroupCategoryID                              := orrs.OrderArray[i1].TransactionArray[i2].Item.GroupCategoryID;
                        Transactions.Item.BidGroupItem                                 := orrs.OrderArray[i1].TransactionArray[i2].Item.BidGroupItem;
                        Transactions.Item.ListingSubtype2                              := enumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Item.ListingSubtype2);
                        Transactions.Item.MechanicalCheckAccepted                      := orrs.OrderArray[i1].TransactionArray[i2].Item.MechanicalCheckAccepted;
                        Transactions.Item.UpdateSellerInfo                             := orrs.OrderArray[i1].TransactionArray[i2].Item.UpdateSellerInfo;
                        Transactions.Item.UpdateReturnPolicy                           := orrs.OrderArray[i1].TransactionArray[i2].Item.UpdateReturnPolicy;
                        Transactions.Item.InventoryTrackingMethod                      := enumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Item.InventoryTrackingMethod);
                        Transactions.Item.IntegratedMerchantCreditCardEnabled          := orrs.OrderArray[i1].TransactionArray[i2].Item.IntegratedMerchantCreditCardEnabled;
                        Transactions.Item.ItemCompatibilityCount                       := orrs.OrderArray[i1].TransactionArray[i2].Item.ItemCompatibilityCount;
                        Transactions.Item.ConditionID                                  := orrs.OrderArray[i1].TransactionArray[i2].Item.ConditionID;
                        Transactions.Item.ConditionDescription                         := orrs.OrderArray[i1].TransactionArray[i2].Item.ConditionDescription;
                        Transactions.Item.ConditionDisplayName                         := orrs.OrderArray[i1].TransactionArray[i2].Item.ConditionDisplayName;
                        Transactions.Item.TaxCategory                                  := orrs.OrderArray[i1].TransactionArray[i2].Item.TaxCategory;
                        Transactions.Item.QuantityAvailableHint                        := enumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Item.QuantityAvailableHint);
                        Transactions.Item.QuantityThreshold                            := orrs.OrderArray[i1].TransactionArray[i2].Item.QuantityThreshold;
                        //Transactions.Item.PostCheckoutExperienceEnabled                := orrs.OrderArray[i1].TransactionArray[i2].Item.PostCheckoutExperienceEnabled;
                        //Transactions.Item.UseRecommendedProduct                        := orrs.OrderArray[i1].TransactionArray[i2].Item.UseRecommendedProduct;
                        Transactions.Item.SellerProvidedTitle                          := orrs.OrderArray[i1].TransactionArray[i2].Item.SellerProvidedTitle;
                        Transactions.Item.VIN                                          := orrs.OrderArray[i1].TransactionArray[i2].Item.VIN;
                        Transactions.Item.VINLink                                      := orrs.OrderArray[i1].TransactionArray[i2].Item.VINLink;
                        Transactions.Item.VRM                                          := orrs.OrderArray[i1].TransactionArray[i2].Item.VRM;
                        Transactions.Item.VRMLink                                      := orrs.OrderArray[i1].TransactionArray[i2].Item.VRMLink;
                        Transactions.Item.TopRatedListing                              := orrs.OrderArray[i1].TransactionArray[i2].Item.TopRatedListing;
                        Transactions.Item.IsIntermediatedShippingEligible              := orrs.OrderArray[i1].TransactionArray[i2].Item.IsIntermediatedShippingEligible;
                        Transactions.Item.RelistParentID                               := orrs.OrderArray[i1].TransactionArray[i2].Item.RelistParentID;
                        Transactions.Item.ConditionDefinition                          := orrs.OrderArray[i1].TransactionArray[i2].Item.ConditionDefinition;
                        Transactions.Item.HideFromSearch                               := orrs.OrderArray[i1].TransactionArray[i2].Item.HideFromSearch;
                        Transactions.Item.ReasonHideFromSearch                         := enumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Item.ReasonHideFromSearch);
                        Transactions.Item.IncludeRecommendations                       := orrs.OrderArray[i1].TransactionArray[i2].Item.IncludeRecommendations;
                        //Transactions.Item.OutOfStockControl                            := orrs.OrderArray[i1].TransactionArray[i2].Item.OutOfStockControl;

                        if orrs.OrderArray[i1].TransactionArray[i2].Item.BuyerGuaranteePrice<> nil then begin
                            Transactions.Item.BuyerGuaranteePrice             := orrs.OrderArray[i1].TransactionArray[i2].Item.BuyerGuaranteePrice.text;
                            Transactions.Item.BuyerGuaranteePriceCurCode      := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Item.BuyerGuaranteePrice.currencyID);
                        end;
                        if orrs.OrderArray[i1].TransactionArray[i2].Item.BuyItNowPrice<> nil then begin
                            Transactions.Item.BuyItNowPrice                   := orrs.OrderArray[i1].TransactionArray[i2].Item.BuyItNowPrice.text;
                            Transactions.Item.BuyItNowPriceCurCode            := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Item.BuyItNowPrice.currencyID);
                        end;
                        if orrs.OrderArray[i1].TransactionArray[i2].Item.CeilingPrice<> nil then begin
                            Transactions.Item.CeilingPrice                    := orrs.OrderArray[i1].TransactionArray[i2].Item.CeilingPrice.text;
                            Transactions.Item.CeilingPriceCurCode             := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Item.CeilingPrice.currencyID);
                        end;
                        if orrs.OrderArray[i1].TransactionArray[i2].Item.ClassifiedAdPayPerLeadFee<> nil then begin
                            Transactions.Item.ClassifiedAdPayPerLeadFee       := orrs.OrderArray[i1].TransactionArray[i2].Item.ClassifiedAdPayPerLeadFee.text;
                            Transactions.Item.ClassifiedAdPayPerLeadFeeCurCode:= EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Item.ClassifiedAdPayPerLeadFee.currencyID);
                        end;
                        if orrs.OrderArray[i1].TransactionArray[i2].Item.FloorPrice<> nil then begin
                            Transactions.Item.FloorPrice                      := orrs.OrderArray[i1].TransactionArray[i2].Item.FloorPrice.text;
                            Transactions.Item.FloorPriceCurCode               := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Item.FloorPrice.currencyID);
                        end;
                        if orrs.OrderArray[i1].TransactionArray[i2].Item.ReservePrice<> nil then begin
                            Transactions.Item.ReservePrice                    := orrs.OrderArray[i1].TransactionArray[i2].Item.ReservePrice.text;
                            Transactions.Item.ReservePriceCurCode             := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Item.ReservePrice.currencyID);
                        end;
                        if orrs.OrderArray[i1].TransactionArray[i2].Item.StartPrice<> nil then begin
                            Transactions.Item.StartPrice                      := orrs.OrderArray[i1].TransactionArray[i2].Item.StartPrice.text;
                            Transactions.Item.StartPriceCurCode               := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Item.StartPrice.currencyID);
                        end;

                        if orrs.OrderArray[i1].TransactionArray[i2].Item.PaymentDetails<> nil then begin
                            Transactions.Item.HoursToDeposit := orrs.OrderArray[i1].TransactionArray[i2].Item.PaymentDetails.HoursToDeposit;
                            Transactions.Item.DaysToFullPayment := orrs.OrderArray[i1].TransactionArray[i2].Item.PaymentDetails.DaysToFullPayment;
                            Transactions.Item.DepositType := enumtostr(orrs.OrderArray[i1].TransactionArray[i2].Item.PaymentDetails.DepositType);
                            if orrs.OrderArray[i1].TransactionArray[i2].Item.PaymentDetails.DepositAmount <> nil then begin
                                Transactions.Item.DepositAmount  := orrs.OrderArray[i1].TransactionArray[i2].Item.PaymentDetails.DepositAmount.Text;
                                Transactions.Item.DepositAmountCurCode := enumtostr(orrs.OrderArray[i1].TransactionArray[i2].Item.PaymentDetails.DepositAmount.currencyID);
                            end;
                        end;

                        if orrs.OrderArray[i1].TransactionArray[i2].Item.BiddingDetails <> nil then begin
                          if orrs.OrderArray[i1].TransactionArray[i2].Item.BiddingDetails.ConvertedMaxBid <> nil then begin
                            Transactions.Item.ConvertedMaxBid          := orrs.OrderArray[i1].TransactionArray[i2].Item.BiddingDetails.ConvertedMaxBid.Text;
                            Transactions.Item.ConvertedMaxBidcurcode   :=enumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Item.BiddingDetails.ConvertedMaxBid.currencyID);
                          end;
                          if orrs.OrderArray[i1].TransactionArray[i2].Item.BiddingDetails.MaxBid <> nil then begin
                            Transactions.Item.MaxBid          := orrs.OrderArray[i1].TransactionArray[i2].Item.BiddingDetails.MaxBid.Text;
                            Transactions.Item.MaxBidcurcode   := enumtoStr(orrs.OrderArray[i1].TransactionArray[i2].Item.BiddingDetails.MaxBid.currencyID);
                          end;
                          Transactions.Item.QuantityBid   := orrs.OrderArray[i1].TransactionArray[i2].Item.BiddingDetails.QuantityBid;
                          Transactions.Item.QuantityWon   := orrs.OrderArray[i1].TransactionArray[i2].Item.BiddingDetails.QuantityWon;
                          Transactions.Item.Winning       := orrs.OrderArray[i1].TransactionArray[i2].Item.BiddingDetails.Winning;
                          Transactions.Item.BidAssistant  := orrs.OrderArray[i1].TransactionArray[i2].Item.BiddingDetails.BidAssistant;
                        end;

                        if orrs.OrderArray[i1].TransactionArray[i2].Item.charity <> nil then begin
                          Transactions.Item.CharityName     := orrs.OrderArray[i1].TransactionArray[i2].Item.charity.CharityName;
                          Transactions.Item.CharityNumber   := orrs.OrderArray[i1].TransactionArray[i2].Item.charity.CharityNumber;
                          Transactions.Item.DonationPercent := orrs.OrderArray[i1].TransactionArray[i2].Item.charity.DonationPercent;
                          Transactions.Item.CharityID       := orrs.OrderArray[i1].TransactionArray[i2].Item.charity.CharityID;
                          Transactions.Item.Mission         := orrs.OrderArray[i1].TransactionArray[i2].Item.charity.Mission;
                          Transactions.Item.LogoURL         := orrs.OrderArray[i1].TransactionArray[i2].Item.charity.LogoURL;
                          Transactions.Item.Status          := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Item.charity.Status);
                          Transactions.Item.CharityListing  := orrs.OrderArray[i1].TransactionArray[i2].Item.charity.CharityListing;
                        end;

                        Transactions.Item.PostDB;
                    Except
                      on E:Exception do begin
                        //Log( '9 - Exception :' +E.Message, ltError);
                      end;
                    end;
                        (*if high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray) >=0 then
                          for i3:= low(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray) to high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray) do begin
                            if high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute ) >=0 then begin
                              for i4:= low(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute) to high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute) do begin
                                if high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].value ) >=0 then begin
                                  for i5:= low(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].value) to high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].Value) do begin
                                    if high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].value[i5].SuggestedValueLiteral ) >=0 then begin
                                      for i6:= low(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].value[i5].SuggestedValueLiteral ) to high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].value[i5].SuggestedValueLiteral ) do begin
                                        //Log(Transactions.Item.AttribSet.classname + ' = ' + orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].ClassName);
                                        Transactions.Item.AttribSet.New;
                                        Transactions.Item.AttribSet.OrderID             := Transactions.Item.OrderID;
                                        Transactions.Item.AttribSet.Orders_Trans_Id     := Transactions.Item.Orders_Trans_Id;
                                        Transactions.Item.AttribSet.Orders_Trans_Item_Id:= Transactions.Item.ID;
                                        Transactions.Item.AttribSet.attributeSetID      := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].attributeSetID;
                                        Transactions.Item.AttribSet.AttributeSetVersion := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].attributeSetVersion;
                                        Transactions.Item.AttribSet.attributeID         := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].attributeID;
                                        Transactions.Item.AttribSet.attributeLabel      := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].attributeLabel;
                                        Transactions.Item.AttribSet.ValueID             := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].Value[i5].ValueID;
                                        Transactions.Item.AttribSet.ValueLiteral        := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].Value[i5].SuggestedValueLiteral[i6];
                                        Transactions.Item.AttribSet.PostDB;
                                      end;
                                    end else begin
                                        //Log(Transactions.Item.AttribSet.classname + ' = ' + orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].ClassName);
                                        Transactions.Item.AttribSet.New;
                                        Transactions.Item.AttribSet.OrderID             := Transactions.Item.OrderID;
                                        Transactions.Item.AttribSet.Orders_Trans_Id     := Transactions.Item.Orders_Trans_Id;
                                        Transactions.Item.AttribSet.Orders_Trans_Item_Id:= Transactions.Item.ID;
                                        Transactions.Item.AttribSet.attributeSetID      := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].attributeSetID;
                                        Transactions.Item.AttribSet.AttributeSetVersion := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].attributeSetVersion;
                                        Transactions.Item.AttribSet.attributeID         := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].attributeID;
                                        Transactions.Item.AttribSet.attributeLabel      := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].attributeLabel;
                                        Transactions.Item.AttribSet.ValueID             := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].Value[i5].ValueID;
                                        Transactions.Item.AttribSet.PostDB;
                                    end;
                                  end;
                                end else begin
                                        //Log(Transactions.Item.AttribSet.classname + ' = ' + orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].ClassName);
                                        Transactions.Item.AttribSet.New;
                                        Transactions.Item.AttribSet.OrderID             := Transactions.Item.OrderID;
                                        Transactions.Item.AttribSet.Orders_Trans_Id     := Transactions.Item.Orders_Trans_Id;
                                        Transactions.Item.AttribSet.Orders_Trans_Item_Id:= Transactions.Item.ID;
                                        Transactions.Item.AttribSet.attributeSetID      := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].attributeSetID;
                                        Transactions.Item.AttribSet.AttributeSetVersion := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].attributeSetVersion;
                                        Transactions.Item.AttribSet.attributeID         := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].attributeID;
                                        Transactions.Item.AttribSet.attributeLabel      := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].Attribute[i4].attributeLabel;
                                        Transactions.Item.AttribSet.PostDB;
                                end;
                              end;
                            end else begin
                                        //Log(Transactions.Item.AttribSet.classname + ' = ' + orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].ClassName);
                                        Transactions.Item.AttribSet.New;
                                        Transactions.Item.AttribSet.OrderID             := Transactions.Item.OrderID;
                                        Transactions.Item.AttribSet.Orders_Trans_Id     := Transactions.Item.Orders_Trans_Id;
                                        Transactions.Item.AttribSet.Orders_Trans_Item_Id:= Transactions.Item.ID;
                                        Transactions.Item.AttribSet.attributeSetID      := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].attributeSetID;
                                        Transactions.Item.AttribSet.AttributeSetVersion := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeSetArray[i3].attributeSetVersion;
                                        Transactions.Item.AttribSet.PostDB;
                            end;
                          end;*)

                          (*if high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray ) >=0 then begin
                            for i4:= low(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray) to high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray) do begin
                              if high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].value ) >=0 then begin
                                for i5:= low(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].value) to high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].Value) do begin
                                  if high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].value[i5].SuggestedValueLiteral ) >=0 then begin
                                    for i6:= low(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].value[i5].SuggestedValueLiteral ) to high(orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].value[i5].SuggestedValueLiteral ) do begin
                                      //Log(Transactions.Item.AttribSet.classname + ' = ' + orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].ClassName);
                                      Transactions.Item.AttribSet.New;
                                      Transactions.Item.AttribSet.OrderID             := Transactions.Item.OrderID;
                                      Transactions.Item.AttribSet.Orders_Trans_Id     := Transactions.Item.Orders_Trans_Id;
                                      Transactions.Item.AttribSet.Orders_Trans_Item_Id:= Transactions.Item.ID;
                                      Transactions.Item.AttribSet.attributeID         := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].attributeID;
                                      Transactions.Item.AttribSet.attributeLabel      := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].attributeLabel;
                                      Transactions.Item.AttribSet.ValueID             := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].Value[i5].ValueID;
                                      Transactions.Item.AttribSet.ValueLiteral        := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].Value[i5].SuggestedValueLiteral[i6];
                                      Transactions.Item.AttribSet.PostDB;
                                    end;
                                  end else begin
                                      //Log(Transactions.Item.AttribSet.classname + ' = ' + orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].ClassName);
                                      Transactions.Item.AttribSet.New;
                                      Transactions.Item.AttribSet.OrderID             := Transactions.Item.OrderID;
                                      Transactions.Item.AttribSet.Orders_Trans_Id     := Transactions.Item.Orders_Trans_Id;
                                      Transactions.Item.AttribSet.Orders_Trans_Item_Id:= Transactions.Item.ID;
                                      Transactions.Item.AttribSet.attributeID         := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].attributeID;
                                      Transactions.Item.AttribSet.attributeLabel      := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].attributeLabel;
                                      Transactions.Item.AttribSet.ValueID             := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].Value[i5].ValueID;
                                      Transactions.Item.AttribSet.PostDB;
                                  end;
                                end;
                              end else begin
                                      //Log(Transactions.Item.AttribSet.classname + ' = ' + orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].ClassName);
                                      Transactions.Item.AttribSet.New;
                                      Transactions.Item.AttribSet.OrderID             := Transactions.Item.OrderID;
                                      Transactions.Item.AttribSet.Orders_Trans_Id     := Transactions.Item.Orders_Trans_Id;
                                      Transactions.Item.AttribSet.Orders_Trans_Item_Id:= Transactions.Item.ID;
                                      Transactions.Item.AttribSet.attributeID         := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].attributeID;
                                      Transactions.Item.AttribSet.attributeLabel      := orrs.OrderArray[i1].TransactionArray[i2].Item.AttributeArray[i4].attributeLabel;
                                      Transactions.Item.AttribSet.PostDB;
                              end;
                            end;
                          end;*)
                        end;
                  (*if orrs.OrderArray[i1].TransactionArray[i2].Taxes <> nil then begin
                    Transactions.Taxes.New;
                    Transactions.Taxes.New;
                    Transactions.Taxes.OrderId := Transactions.OrderID;
                    Transactions.Taxes.Orders_Trans_Id            := Transactions.Id;
                    if orrs.OrderArray[i1].TransactionArray[i2].Taxes.TotalTaxAmount <> nil then begin
                      Transactions.Taxes.TotalTaxamount := orrs.OrderArray[i1].TransactionArray[i2].Taxes.TotalTaxAmount.Text;
                      Transactions.Taxes.TotalTaxamountCurCode := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Taxes.TotalTaxAmount.currencyID);
                    end;
                    Transactions.Taxes.PostDB;
                    if high(orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails)>=0 then
                      for i3 := low(orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails) to high(orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails) do begin
                      Transactions.Taxes.TaxDetails.OrderID                                      := Transactions.Taxes.OrderID;
                      Transactions.Taxes.TaxDetails.Orders_Trans_Id                              := Transactions.Taxes.Orders_Trans_Id;
                      Transactions.Taxes.TaxDetails.Orders_Trans_Taxes_Id                        := Transactions.Taxes.ID;
                      Transactions.Taxes.TaxDetails.Imposition                                   := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].Imposition);
                      Transactions.Taxes.TaxDetails.TaxDescription                               := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].TaxDescription);

                      if orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].taxonsubtotalamount <> nil then begin
                        Transactions.Taxes.TaxDetails.taxonsubtotalamount := orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].taxonsubtotalamount.Text;
                        Transactions.Taxes.TaxDetails.taxonsubtotalamountCurCode := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].taxonsubtotalamount.currencyID);
                      end;

                      if orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].TaxAmount <> nil then begin
                        Transactions.Taxes.TaxDetails.TaxAmount := orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].TaxAmount.Text;
                        Transactions.Taxes.TaxDetails.TaxAmountCurCode := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].TaxAmount.currencyID);
                      end;
                      if orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].TaxOnShippingAmount <> nil then begin
                        Transactions.Taxes.TaxDetails.TaxOnShippingAmount := orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].TaxOnShippingAmount.Text;
                        Transactions.Taxes.TaxDetails.TaxOnShippingAmountCurCode := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].TaxOnShippingAmount.currencyID);
                      end;

                      if orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].TaxOnHandlingAmount <> nil then begin
                        Transactions.Taxes.TaxDetails.TaxOnHandlingAmount := orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].TaxOnHandlingAmount.Text;
                        Transactions.Taxes.TaxDetails.TaxOnHandlingAmountCurCode := EnumToStr(orrs.OrderArray[i1].TransactionArray[i2].Taxes.TaxDetails[i3].TaxOnHandlingAmount.currencyID);
                      end;
                      Transactions.Taxes.TaxDetails.PostDB;
                      end;
                  end;
                  end;*)
              end;
           end;
           end;{with OrderArray}
        Self.Log('Checked for Orders between : ' + formatDAteTime(Shortdateformat , dtmin) + '  - ' + formatDAteTime(Shortdateformat , dtmax), ltDEtail);
      end;
    finally
      Freeandnil(OrderResponse);
    end;
  Except
    on E:Exception do begin
      //Log( '10 - Exception :' +E.Message, ltError);
    end;
  end;
End;

//procedure TModEbay.SetAccounts(const Value: string);
//begin
//  AccountList.AsString := Value;
//end;

procedure TModEbay.UpdateConfigDT(AccountName, FieldName: String; Value: TDateTime);
var
  Account: TJsonObject;
  x: integer;
begin
  for x := 0 to Accounts.Count -1 do begin
    Account:= Accounts[x].AsObject;
    if SameText(Account.S['Name'],AccountName) then begin
      Account.DT[FieldName]:= Value;
      self.SaveConfig;
      break;
    end;
  end;
end;

procedure TModEbay.UpdateConfigNextUpdateTime(AccountName: string; UpdateTime: TDateTime);
var
  Account: TJsonObject;
  x: integer;
begin
  for x := 0 to Accounts.Count -1 do begin
    Account:= Accounts[x].AsObject;
    if SameText(Account.S['Name'],AccountName) then begin
      Account.DT['NextSyncTime']:= UpdateTime;
      self.SaveConfig;
      break;
    end;
  end;
end;

end.

