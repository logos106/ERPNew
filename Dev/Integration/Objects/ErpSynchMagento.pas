unit ErpSynchMagento;

interface

uses JsonObject, ErpSynchObj , BusObjBase;

Type
TErpSynchMagento = Class(TErpSynch)
  private

    function MakeMagentoSalesOrder(Data: TJsonObject;conn: TMyDacDataConnection): Integer;
    function ValidateMagentoSalesOrder(Data: TJsonObject;conn :TMyDacDataConnection): Boolean;
    procedure AddorUpdate(Data: TJsonObject);
    procedure NoEntriesLog;

  Protected
  Public
    Procedure SynchOrders;
    Procedure InitTosynchOrders;
    Procedure SynchCustomers;
    Procedure SynchProducts;
    Function UploadProduct(aProductID:Integer):Boolean;
    Procedure UploadProducts;
End;

implementation

uses ERPdbComponents, utCoreEDIConst,SysUtils,BusobjExternalXRef, BusObjClient, BusObjSales,
  AppEnvironment, CommonLib, tcConst, BusobjCountries, LogLib,
  utMagentoService, BusObjStock, DbSharedObjectsObj, CommonDbLib, MagentoLib;


procedure TErpSynchMagento.AddorUpdate(Data: TJsonObject);
var
  fiID:Integer;
  fExternalXRef :TExternalXRef;
  msg:String;
  Procedure ExternalXRefNewInstance;
  begin
    if fExternalXRef = nil then fExternalXRef :=TExternalXRef.NewInstance(nil);
  end;
begin
  Log('=============================================');
  fExternalXRef := nil;
  if SameText(CoreService.ServiceName, Servicename_Magento) then begin
      if (fCurrentSynchItemType = SynchItemType_Orders) then begin
        {Magento Sales Orders}
        ExternalXRefNewInstance;
        try
          if fExternalXRef.DoStartNew(CoreService.ServiceName ,TMagentoCoreService(CoreService).ExRef_Objtype_MagentoSales, inttostr(Data.I['entity_id']), msg) then begin
              Log('Synching Magento the Order # '+ Data.S['increment_id']);
              if fExternalXRef.ERPID =0 then begin
                fExternalXRef.Connection.BeginTransaction;
                try
                 fiID:= MakeMagentoSalesOrder(Data , fExternalXRef.Connection);
                 if fiID <> 0 then begin
                    Log('Created ERP Order # '+ inttostr(fiid) );
                    fExternalXRef.DoComplete(CoreService.ServiceName, TMagentoCoreService(CoreService).ExRef_Objtype_MagentoSales, fiID, inttostr(Data.I['entity_id']), msg);
                 end;
                  fExternalXRef.Connection.CommitTransaction;
                Except
                  fExternalXRef.Connection.RollbackTransaction;
                end;
                Log('Synched Magento Order # '+ Data.S['increment_id']);
              end;
          end;
        finally
          freeandnil(fExternalXRef);
        end;
      end else if (fCurrentSynchItemType = SynchItemType_Customers) then begin
        {Magento Customer}
        ExternalXRefNewInstance;
        try
          if fExternalXRef.DoStartNew(CoreService.ServiceName ,ExRef_Objtype_Customer, inttostr(Data.I['Id']), msg) then begin
              Log('Synching Magento the Customer # '+ Data.S['firstname']);
              //if fExternalXRef.ERPID =0 then begin
                fExternalXRef.Connection.BeginTransaction;
                try
                   (*if fExternalXRef.ERPID =0 then
                      fiID:= Tcustomer.MakeMagentoCustomer(Data, fExternalXRef.Connection , Servicename_Magento)
                   else fiID:=fExternalXRef.ERPID ;*)
                   fiID:= Tcustomer.MakeMagentoCustomer(Data, fExternalXRef.Connection , Servicename_Magento);
                   if fiID <> 0 then begin
                      Log('Created ERP Customer # '+ Data.S['firstname'] );
                      if Data.DT['updated_at'] > Data.DT['created_at'] then
                           fExternalXRef.DoComplete(CoreService.ServiceName, ExRef_Objtype_Customer, fiID, inttostr(Data.I['Id']), msg,Data.DT['updated_at'])
                      else fExternalXRef.DoComplete(CoreService.ServiceName, ExRef_Objtype_Customer, fiID, inttostr(Data.I['Id']), msg,Data.DT['created_at']);
                   end;
                   fExternalXRef.Connection.CommitTransaction;
                Except
                  fExternalXRef.Connection.RollbackTransaction;
                end;
                Log('Synched Magento Customer # '+ Data.S['firstname']);
              //end;
          end;
        finally
          freeandnil(fExternalXRef);
        end;
      end else if (fCurrentSynchItemType = SynchItemType_Products) then begin
        {Magento Customer}
        ExternalXRefNewInstance;
        try
          if fExternalXRef.DoStartNew(CoreService.ServiceName ,ExRef_Objtype_Product, inttostr(Data.I['Id']), msg) then begin
              Log('Synching Magento the Product # '+ Data.S['name']);
              //if fExternalXRef.ERPID =0 then begin
                fExternalXRef.Connection.BeginTransaction;
                try
                 fiID:= TProduct.MakeMagentoProduct(Data, fExternalXRef.Connection , Servicename_Magento);
                 if fiID <> 0 then begin
                    Log('Created ERP Product # '+ Data.S['name'] );
                    if Data.DT['updated_at'] > Data.DT['created_at'] then
                         fExternalXRef.DoComplete(CoreService.ServiceName, ExRef_Objtype_Product, fiID, inttostr(Data.I['Id']), msg, Data.DT['updated_at'])
                    else fExternalXRef.DoComplete(CoreService.ServiceName, ExRef_Objtype_Product, fiID, inttostr(Data.I['Id']), msg, Data.DT['created_at']);
                 end;
                 fExternalXRef.Connection.CommitTransaction;
                Except
                 fExternalXRef.Connection.RollbackTransaction;
                end;
                Log('Synched Magento Product # '+ Data.S['name']);
              (*end else begin
                fExternalXRef.DoComplete(CoreService.ServiceName, ExRef_Objtype_Product, fExternalXRef.ERPID, inttostr(Data.I['Id']), msg, Data.DT['updated_at']);
              end;*)
          end;
        finally
          freeandnil(fExternalXRef);
        end;
      end;
  end;
end;
Function TErpSynchMagento.ValidateMagentoSalesOrder(Data: TJsonObject;conn :TMyDacDataConnection):Boolean;
var
  CustomerID : Integer;
  ctr1: integer;
  aitem:TJsonObject;
  ProductID:Integer;

begin
  REsult := true;
  if (Data.I['customer_id'] =0)  then begin
    //CustomerId := TClient.DoMakeclientRec(nil,  conn, Data.S['customer_firstname'], Data.S['customer_lastname'],Data.S['customer_email'], true,false,false, true, 'Magento');
    CustomerId := TCustomer.MakeMagentoGuestCustomer(Data, conn , 'Magento');
    if CustomerId =0 then begin
      Log('Customer ' + Data.S['customer_firstname']+' ' + Data.S['customer_lastname']+' doesn''t Exists in ERP for Magento Order #' + inttostr(Data.I['entity_id']));
      REsult := False;
      Exit;
    end;

    Data.I['ERP_customer_id'] := CustomerID;
(*    Log('Created ERP Customer # '+ Data.S['customer_firstname'] );
    if Data.DT['updated_at'] <> 0 then
         fExternalXRef.DoComplete(CoreService.ServiceName, ExRef_Objtype_Customer, CustomerId, inttostr(Data.I['Id']), msg,Data.DT['updated_at']);*)
  end else if not TExternalXRef.IsDone(CoreService.ServiceName,ExRef_Objtype_Customer, inttostr(Data.I['customer_id']), 0) then begin
    Log('Customer ' + Data.S['customer_firstname']+' ' + Data.S['customer_lastname']+' doesn''t Exists in ERP for Magento Order #' + inttostr(Data.I['entity_id']));
    REsult := False;
      Exit;
  end else begin
    CustomerId := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName,ExRef_Objtype_Customer, inttostr(Data.I['customer_id']));
    if CustomerId =0 then begin
      Log('Customer ' + Data.S['customer_firstname']+' ' + Data.S['customer_lastname']+' doesn''t Exists in ERP for Magento Order #' + inttostr(Data.I['entity_id']));
      REsult := False;
      Exit;
    end;
  end;

  
  if (not(Data.Exists('items') )) or
     (Data.A['items'].Count =0)  then begin
    Log('No Products in Magento Order #' + inttostr(Data.I['entity_id']));
    REsult := False;
    Exit;
  end else begin
      for ctr1:= 0 to Data.A['items'].Count -1 do begin
              aitem :=(data.A['items'].items[ctr1].asObject);
              if not TExternalXRef.IsDone(CoreService.ServiceName,ExRef_Objtype_Product, inttostr(aitem.I['product_id']), 0) then begin
                Log('Product ' + aitem.S['name']+' doesn''t Exists in ERP for Magento Order #' + inttostr(Data.I['entity_id']));
                REsult := False;
                Exit;
              end else begin
                ProductID := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName,ExRef_Objtype_Product,  inttostr(aitem.I['product_id']));
                if ProductID =0 then begin
                  Log('Product ' + aitem.S['name']+' doesn''t Exists in ERP for Magento Order #' + inttostr(Data.I['entity_id']));
                  REsult := False;
                  Exit;
                end;
              end;
      end;
  end;
  if Data.Exists('base_shipping_amount') and (Data.F['base_shipping_incl_tax']<>0) and (Appenv.CompanyPrefs.FreightChargeProduct = '') then begin
          Log('Please choose "Freight Charge Product" (Preferances -> Sales). Shiping Cost to be Applied ' + inttostr(Data.I['entity_id']));
          REsult := False;
          Exit;
  end;
end;
procedure TErpSynchMagento.InitTosynchOrders;
begin
  TMagentoCoreService(CoreService).SynchCounter:= 0;
end;

Function TErpSynchMagento.MakeMagentoSalesOrder(Data: TJsonObject; conn :TMyDacDataConnection):Integer;
var
  SalesObj :TSales;
  ctr1:Integer;
  aitem:TJsonObject;
  amsg:String;
  function FloatValue(ajson :TJsonObject; anodename :String; adescription:String):String;
  begin
     if Data.Exists(anodename) and (Data.F[anodename]<>0) then
          result := adescription+':' + Floattostr(Data.F[anodename])
     else result := '';
  end;
  function StringValue(ajson :TJsonObject; anodename :String; adescription:String):String;
  begin
     if Data.Exists(anodename) and (Data.S[anodename]<>'') then
          result := adescription+':' + Data.S[anodename]
     else result := '';
  end;
  function Billfirstname(abillingaddress:TJsonObject):String; begin Result := ''; if abillingaddress.Exists('firstname')  then result :=abillingaddress.S['firstname'];  end;
  function Billlastname (abillingaddress:TJsonObject):String; begin Result := ''; if abillingaddress.Exists('lastname')   then result :=abillingaddress.S['lastname'] ;  end;
  function Billcity     (abillingaddress:TJsonObject):String; begin Result := ''; if abillingaddress.Exists('city')       then result :=abillingaddress.S['city']     ;  end;
  function Billregion   (abillingaddress:TJsonObject):String; begin Result := ''; if abillingaddress.Exists('region')     then result :=abillingaddress.S['region']   ;  end;
  function Billpostcode (abillingaddress:TJsonObject):String; begin Result := ''; if abillingaddress.Exists('postcode')   then result :=abillingaddress.S['postcode'] ;  end;
  function Billemail    (abillingaddress:TJsonObject):String; begin Result := ''; if abillingaddress.Exists('email')      then result :=abillingaddress.S['email']    ;  end;

  function billAddress(abillingaddress:TJsonObject; iaddressindex:Integer):String;
  begin
    result := '';
    if abillingaddress.Exists('street') then
      if abillingaddress.A['street'].count > iaddressindex then
        result := abillingaddress.A['street'].Items[iaddressindex].AsString;
  end;
  Procedure MakeSaleSObj;
  begin
    if Appenv.CompanyPrefs.IsMagentoSalestypeSO then
          SalesObj := TSalesOrder.Create(nil)
    else  SalesObj := TInvoice.Create(nil);
    SalesObj.Connection := conn;
    SalesObj.load(0);
  end;
begin
  result := 0;
  if TExternalXRef.IsDone(CoreService.ServiceName,TMagentoCoreService(CoreService).ExRef_Objtype_MagentoSales, inttostr(Data.I['entity_id']), 0) then begin
    {Sales Orders are created in Magento and shipment is handled from ERP - Dene
    Any changes done in Magento to Synched Order is ignored}
    Exit;
  end;

  if not ValidateMagentoSalesOrder(data, conn ) then exit;

  conn.beginnestedTransaction;
  try
        MakeSalesObj;
        try
          SalesObj.New;
          {customer}
          if Data.I['customer_id'] =0 then SalesObj.CustomerId   := Data.I['ERP_customer_id']
          else SalesObj.CustomerId   := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName,ExRef_Objtype_Customer, inttostr(Data.I['customer_id']));

          if SalesObj.CustomerId  =0 then begin
             Log('blank customer id');

              if Data.I['customer_id'] =0 then SalesObj.CustomerId   := Data.I['ERP_customer_id']
              else SalesObj.CustomerId   := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName,ExRef_Objtype_Customer, inttostr(Data.I['customer_id']));

          end;

          SalesObj.CustomerName := trim(Data.S['customer_firstname'])+' ' + trim(Data.S['customer_lastname']);
          SalesObj.CustPONumber := trim(Data.S['increment_id']);

          {Foreign Exchange }
          if Data.Exists('base_currency_code') and (Data.S['base_currency_code'] <> '') and (Data.S['base_currency_code'] <> Appenv.RegionalOptions.ForeignExDefault) then begin
            SalesObj.ForeignExchangeCode :=Data.S['base_currency_code'];
            if Data.Exists('base_to_global_rate') and (Data.F['base_to_global_rate']<>0) then SalesObj.ForeignExchangeRate := Data.F['base_subtotal_incl_tax'] else SalesObj.ForeignExchangeRate := 1;
          end;

          {sales Status}
          if data.Exists('status')  and (data.S['status']<>'') then SalesObj.SalesStatus := data.S['status'];

          {billing address}
          if data.Exists('billing_address') then begin
            SalesObj.InvoiceToDesc := InvoiceAddress({firstname}  billfirstname(Data.O['billing_address']),
                                                       {middlename} '',
                                                       {lastname}   billlastname(Data.O['billing_address']),
                                                       {companyname}'',
                                                       {jobname}    '',
                                                       {contactname}'',
                                                       {address1}   billAddress(Data.O['billing_address'],0),
                                                       {address2}   billAddress(Data.O['billing_address'],1),
                                                       {address3}   billAddress(Data.O['billing_address'],2),
                                                       {city}       billcity(Data.O['billing_address']),
                                                       {state}      billregion(Data.O['billing_address']),
                                                       {postcode}   billpostcode(Data.O['billing_address']),
                                                       {country}    TCountries.CountryForCode(Data.O['billing_address'].S['country_id']),
                                                       {extraInfo}  '');
          end;
          for ctr1:= 0 to Data.A['items'].Count -1 do begin
            aitem :=(data.A['items'].items[ctr1].asObject);
            SalesObj.Lines.New;
            SalesObj.Lines.ProductID := TExternalXRef.ERPIdForExternalId(CoreService.ServiceName,ExRef_Objtype_Product,  inttostr(aitem.I['product_id']));
            //SalesObj.Lines.Productname := aitem.S['name'];
            SalesObj.Lines.QtySold := aitem.F['qty_ordered'];
            SalesObj.Lines.UOMqtyshipped := 0;
            SalesObj.Lines.OriginalLinePrice:= aitem.F['original_price'];
            SalesObj.Lines.LinePrice:= aitem.F['price'];
            SalesObj.Lines.LinePriceInc:= aitem.F['price_incl_tax'];
            SalesObj.Lines.DiscountAmount:= aitem.F['discount_amount'];
            SalesObj.Lines.PostDB;
            SalesObj.Lines.CalcLineTotals;
          end;
          if Data.F['discount_amount']<>0 then begin
            SalesObj.Lines.New;
            SalesObj.Lines.Productname := TOTALDISCOUNT_PRODUCT;
            SalesObj.Lines.UOMQtySold := 1;
            SalesObj.Lines.UOMqtyshipped := 0;
            SalesObj.Lines.LinePriceInc :=0-Data.F['discount_amount'];
            SalesObj.Lines.PostDB;
          end;

          if Data.F['base_shipping_incl_tax']<>0 then begin
            SalesObj.Lines.New;
            SalesObj.Lines.Productname := Appenv.CompanyPrefs.FreightChargeProduct;
            SalesObj.Lines.UOMQtySold := 1;
            SalesObj.Lines.UOMqtyshipped := 0;
            SalesObj.Lines.LinePriceInc :=Data.F['base_shipping_incl_tax'];
            SalesObj.Lines.PostDB;
          end;
          SalesObj.CalcOrderTotals;
          SalesObj.Comments :=Trim( 'Shipping Amount :' +
                                      '   ' +FloatValue(data,'base_shipping_amount'                        , 'Ex'                       )+NL+
                                      '   ' +FloatValue(data,'base_shipping_discount_amount'               , 'Discount'                 )+NL+
                                      '   ' +FloatValue(data,'base_shipping_discount_tax_compensation_amnt', 'Discount TAx compensation')+NL+
                                      '   ' +FloatValue(data,'base_shipping_tax_amount'                    , 'Tax'                      )+NL+
                                      '   ' +FloatValue(data,'base_shipping_incl_tax'                      , 'Inc'                      )+NL+
                                      '   ' +FloatValue(data,'base_subtotal'                               , 'Ex(Tax) and Ex(Shipment)' )+NL+
                                      '   ' +FloatValue(data,'base_subtotal_incl_tax'                      , 'Inc(Tax)and Ex(Shipment)' )+NL+
                                      StringValue(data,'customer_email'                             , 'Customer Email'                  )+NL+
                                      StringValue(Data.O['billing_address']   , 'email'             , 'Email'                           )+NL+
                                      StringValue(Data.O['billing_address']   , 'telephone'         ,'Tel'                              )+NL);
        SalesObj.PostDB;
        if SalesObj.save then begin
          if TExternalXRef.Complete(CoreService.ServiceName,TMagentoCoreService(CoreService).ExRef_Objtype_MagentoSales, SalesObj.ID, inttostr(Data.I['entity_id']),amsg , 0,TERPconnection(SalesObj.connection.connection), trim(Data.S['increment_id'])) then begin
              Conn.commitnestedTransaction;
              REsult :=SalesObj.ID;
              Exit;
          end;
        end;
      Conn.rollbacknestedTransaction;
    finally
      Freeandnil(SalesObj);
    end;
  Except
    on E:Exception do begin
      Conn.rollbacknestedTransaction;
    end;
  end;
end;
procedure TErpSynchMagento.SynchOrders;
var
  json: TJsonObject;
  ctr:Integer;
begin
    if SameTExt(CoreService.ServiceName, Servicename_Magento) then begin
      fCurrentSynchItemType := SynchItemType_Orders;
        {Binny : check in utMagentoService.TMagentoCoreService.InitRequestParams for the query parameters}
      if CoreService.GetData(GetData_Req_Type_SynchOrders) then begin
        if CoreService.ResultData.A['items'].Count > 0 then begin
          Log('Found ' + inttostr(CoreService.ResultData.A['items'].Count)+' New Entries Found.');

          for ctr:= 0 to CoreService.ResultData.A['items'].Count -1 do begin
            json := CoreService.ResultData.A['items'][ctr].AsObject;
            AddorUpdate(json);

          end;
          TMagentoCoreService(CoreService).SynchCounter := TMagentoCoreService(CoreService).SynchCounter +1;
          SynchOrders;// repeat until there is no more order
        end else begin
          NoEntriesLog;
        end;
      end else begin
          NoEntriesLog;
      end;
    end;
end;

procedure TErpSynchMagento.SynchCustomers;
var
  ctr:Integer;
  json: TJsonObject;
begin
    if SameTExt(CoreService.ServiceName, Servicename_Magento) then begin
      fCurrentSynchItemType := SynchItemType_Customers;
      if CoreService.GetData(GetData_Req_Type_SynchCustomers) then begin
        Log('Found ' + inttostr(CoreService.ResultData.A['items'].Count)+' New Entries Found.');
        if CoreService.ResultData.A['items'].Count > 0 then begin
          for ctr:= 0 to CoreService.ResultData.A['items'].Count -1 do begin
            json := CoreService.ResultData.A['items'][ctr].AsObject;
            AddorUpdate(json);
          end;
          SynchCustomers;
        end else begin
          NoEntriesLog;
        end;
      end else begin
          NoEntriesLog;
      end;
    end;

end;
procedure TErpSynchMagento.SynchProducts;
var
  ctr:Integer;
  json: TJsonObject;
begin
    if SameTExt(CoreService.ServiceName, Servicename_Magento) then begin
      fCurrentSynchItemType := SynchItemType_Products;
      if CoreService.GetData(GetData_Req_Type_SynchProducts) then begin
        Log('Found ' + inttostr(CoreService.ResultData.A['items'].Count)+' New Entries Found.');
        if CoreService.ResultData.A['items'].Count > 0 then begin
          for ctr:= 0 to CoreService.ResultData.A['items'].Count -1 do begin
            json := CoreService.ResultData.A['items'][ctr].AsObject;
            AddorUpdate(json);
          end;
          SynchProducts;
        end else begin
          NoEntriesLog;
        end;
      end else begin
          NoEntriesLog;
      end;
    end;
end;
Procedure TErpSynchMagento.UploadProducts;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(qry);
    Log('Checking For Modified Products to Upload');
    ProductsForMagentoSQL('' ,ServiceName_Magento, False, qry.SQL);
    opendb(qry);
    qry.filter := 'SynchState =' +quotedstr('F');
    qry.Filtered := True;
    if qry.recordcount =0 then begin
      Log('No Modified Products Found');
      exit;
    end;
      Log(inttostr(qry.recordcount) +' Products Found to Upload');
    qry.first;
    While qry.eof = False do begin
      Log(qry.fieldbyname('ProductName').asString+':'+ inttostr(qry.recno)+'  of  ' + inttostr(qry.recordcount));
      Log('........... Uploading...');
      UpLoadProduct(qry.fieldbyname('PartsId').asInteger);
      Log('........... Done');
      qry.Next;
    end;
    SynchProducts;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
Function TErpSynchMagento.UploadProduct(aProductID:Integer) :Boolean;
var
  aProduct: TJsonObject;
  ProductObj :TProduct;
  amsg:STring;
  function XReftimeStamp:Tdatetime;
  begin
    if ProductObj.RunningPQAtimestamp > ProductObj.msTimeStamp then
         Result := ProductObj.RunningPQAtimestamp
    else Result := ProductObj.msTimeStamp ;
  end;
begin
    Result := False;
    if SameTExt(CoreService.ServiceName, Servicename_Magento) then begin
      fCurrentSynchItemType := SynchItemType_ProductUpload;
      aProduct := JO;
      try
        ProductObj := TProduct.CreateWithNewConn(nil);
        try
          ProductObj.load(aProductID);
          aProduct := Serialise(ProductObj);
          aProduct.O['fields'].I['ExID']        := ProductObj.MagentoID;
          aProduct.O['fields'].F['InStockQty']  := ProductObj.RunningInStockQty;
          aProduct.O['fields'].F['AvailableQty']:= ProductObj.RunningAvailableQty;
          aProduct.O['fields'].F['InvBOQty']    := ProductObj.RunningInvBOQty;
          aProduct.O['fields'].F['SOQty']       := ProductObj.RunningSOQty;
          aProduct.O['fields'].F['SOBOQty']     := ProductObj.RunningSOBOQty;
          aProduct.O['fields'].F['POBOQty']     := ProductObj.RunningPOBOQty;
          aProduct.O['fields'].S['Magento_ProductName']           := Appenv.CompanyPrefs.MagentoConfig.Magento_ProductName;
          aProduct.O['fields'].B['Magento_PrintNameToShortDesc']  := Appenv.CompanyPrefs.MagentoConfig.Magento_PrintNameToShortDesc;
          aProduct.O['fields'].B['Magento_CopyProductinfoToERP']  := Appenv.CompanyPrefs.MagentoConfig.Magento_CopyProductinfoToERP;
          Result := TMagentoCoreService(CoreService).SendMagentoDoc(aProduct);
          if result and (ProductObj.MagentoID<>0) then
            TExternalXRef.Complete(CoreService.ServiceName,ExRef_Objtype_Product,
                                   aProductId,inttostr(ProductObj.MagentoID),amsg,
                                   XReftimeStamp,TERPconnection(Productobj.Connection.Connection));

        finally
          Freeandnil(ProductObj);
        end;
      finally
        aProduct.Free;
      end;
    end;

end;

Procedure TErpSynchMagento.NoEntriesLog;
begin
  Log('-------- No New Entries Found --------');
end;
end.
