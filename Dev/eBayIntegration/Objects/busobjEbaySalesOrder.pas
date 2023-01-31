Unit busobjEbaySalesOrder;

Interface

Uses
  Busobjsales, db, busobjbase, busobjPrepayments, busobjsalesprepayments, busobjtrans, classes;

Type
  TEbaySOPrepayment = Class(TCustPrePayments)
    Private
      function getSalesPrepayments: TSalesPrepayments;
      function getSalesOriginalRef: String;
      function getSalesRef: String;
      function getPayMethod: String;
      procedure setPayMethod(const Value: String);
      Function OwnerSOclientID:Integer;
      Function OwnerSOCustomerName:String;

    Protected
      Function  DoAfterInsert     (Sender             : TDatasetBusObj):Boolean;  Override;
      Procedure DoFieldOnChange   (Sender             : TField);                  Override;
    Public
      Property SalesPrepayments : TSalesPrepayments read getSalesPrepayments;
      Property SalesRef :String read getSalesRef;
      Property SalesOriginalRef :String read getSalesOriginalRef;
      function Save:Boolean; Override;
    Published
      Property PayMethod:String read getPayMethod write setPayMethod;
  End;
  TEBaySaleSorderLine = class(TSalesOrderLine)
    Private
      function MakeProduct(const Value:String):Integer;
    function getSKU: String;
    procedure SetSKU(const Value: String);
    Protected
      procedure DoFieldOnChange(Sender: TField); Override;
      Function  DoAfterInsert     (Sender             : TDatasetBusObj):Boolean;  Override;
      Procedure SetProductDescription(Const Value: String);Override;
    public
      Procedure CalcLineTotals; Override;
      Function SAve: Boolean ; override;
    Published
      Property SKU :String read getSKU write SetSKU;
  end;
  TEBaySalesOrder = Class(TSalesOrder)
  Private
    FsShippingAddressCompanyName              : String;
    FsShippingAddressPhoneCountryCode         : String;
    FsShippingAddressInternationalName        : String;
    FsShippingAddressReferenceID              : String;
    FsShippingAddressAddressStatus            : String;
    FsShippingAddressInternationalStreet      : String;
    FsShippingAddressPhone                    : String;
    FsShippingAddressStateOrProvince          : String;
    FsShippingAddressAddressUsage             : String;
    FsShippingAddressCountry                  : String;
    FsShippingAddressCountryName              : String;
    FsShippingAddressPhone2CountryPrefix      : String;
    FsShippingAddressName_                    : String;
    FsShippingtoDesc                          : String;
    FsShippingAddressPhone2LocalNumber        : String;
    FsShippingAddressFirstName                : String;
    FsShippingAddressPhone2AreaOrCityCode     : String;
    FsShippingAddressCityName                 : String;
    FsShippingAddressExternalAddressID        : String;
    FsShippingAddressCounty                   : String;
    FsShippingAddressStreet2                  : String;
    FsShippingAddressPhoneCountryPrefix       : String;
    FsShippingAddressStreet1                  : String;
    FsShippingAddressPhone2CountryCode        : String;
    FsShippingAddressAddressOwner             : String;
    FsShippingAddressPhoneLocalNumber         : String;
    FsShippingAddressPhoneAreaOrCityCode      : String;
    FsShippingAddressAddressRecordType        : String;
    FsShippingAddressLastName                 : String;
    FsShippingAddressStreet                   : String;
    FsShippingAddressPhone2                   : String;
    FsShippingAddressInternationalStateAndCity: String;
    FsShippingAddressAddressID                : String;
    FsShippingAddressPostalCode               : String;
    fbSingleCustomer: Boolean;
    fsEbayCustomer: String;
    function MakeCustomer:Integer;
    function getEbaySalesOrderline: TEBaySaleSorderLine;
    function getSOPrepayments: TEbaySOPrepayment;
    Function HasShippingDetails :Boolean;
  Protected
      procedure DoFieldOnChange   (Sender: TField); Override;
      procedure SetCustomerName   (Value : string); Override;
      Function  DoAfterInsert     (Sender          : TDatasetBusObj       ):Boolean;  Override;
      procedure OnDataIdChange    (const ChangeType: TBusObjDataChangeType); Override;
      function  GetLines          : TTransLineBase; Override;
      function  GetSalesOrderLines: TSalesOrderLine;Override;
  Public
    Function    Save         : Boolean    ; Override;
    Function    ValidateData : Boolean    ; Override;
    Constructor Create(AOwner: TComponent); Override;
  Published
    property Lines          : TEBaySaleSorderLine   Read getEbaySalesOrderline;
    Property SOPrepayments  : TEbaySOPrepayment     Read getSOPrepayments;
    Property ShippingAddressCompanyName              : String  Read FsShippingAddressCompanyName               Write FsShippingAddressCompanyName;
    Property ShippingAddressCountryName              : String  Read FsShippingAddressCountryName               Write FsShippingAddressCountryName;
    Property ShippingAddressName_                    : String  Read FsShippingAddressName_                     Write FsShippingAddressName_;
    Property ShippingAddressStreet                   : String  Read FsShippingAddressStreet                    Write FsShippingAddressStreet;
    Property ShippingAddressStreet1                  : String  Read FsShippingAddressStreet1                   Write FsShippingAddressStreet1;
    Property ShippingAddressStreet2                  : String  Read FsShippingAddressStreet2                   Write FsShippingAddressStreet2;
    Property ShippingAddressCityName                 : String  Read FsShippingAddressCityName                  Write FsShippingAddressCityName;
    Property ShippingAddressCounty                   : String  Read FsShippingAddressCounty                    Write FsShippingAddressCounty;
    Property ShippingAddressStateOrProvince          : String  Read FsShippingAddressStateOrProvince           Write FsShippingAddressStateOrProvince;
    Property ShippingAddressCountry                  : String  Read FsShippingAddressCountry                   Write FsShippingAddressCountry;
    Property ShippingAddressPhone                    : String  Read FsShippingAddressPhone                     Write FsShippingAddressPhone;
    Property ShippingAddressPhoneCountryCode         : String  Read FsShippingAddressPhoneCountryCode          Write FsShippingAddressPhoneCountryCode;
    Property ShippingAddressPhoneCountryPrefix       : String  Read FsShippingAddressPhoneCountryPrefix        Write FsShippingAddressPhoneCountryPrefix;
    Property ShippingAddressPhoneAreaOrCityCode      : String  Read FsShippingAddressPhoneAreaOrCityCode       Write FsShippingAddressPhoneAreaOrCityCode;
    Property ShippingAddressPhoneLocalNumber         : String  Read FsShippingAddressPhoneLocalNumber          Write FsShippingAddressPhoneLocalNumber;
    Property ShippingAddressPhone2CountryCode        : String  Read FsShippingAddressPhone2CountryCode         Write FsShippingAddressPhone2CountryCode;
    Property ShippingAddressPhone2CountryPrefix      : String  Read FsShippingAddressPhone2CountryPrefix       Write FsShippingAddressPhone2CountryPrefix;
    Property ShippingAddressPhone2AreaOrCityCode     : String  Read FsShippingAddressPhone2AreaOrCityCode      Write FsShippingAddressPhone2AreaOrCityCode;
    Property ShippingAddressPhone2LocalNumber        : String  Read FsShippingAddressPhone2LocalNumber         Write FsShippingAddressPhone2LocalNumber;
    Property ShippingAddressPostalCode               : String  Read FsShippingAddressPostalCode                Write FsShippingAddressPostalCode;
    Property ShippingAddressAddressID                : String  Read FsShippingAddressAddressID                 Write FsShippingAddressAddressID;
    Property ShippingAddressAddressOwner             : String  Read FsShippingAddressAddressOwner              Write FsShippingAddressAddressOwner;
    Property ShippingAddressAddressStatus            : String  Read FsShippingAddressAddressStatus             Write FsShippingAddressAddressStatus;
    Property ShippingAddressExternalAddressID        : String  Read FsShippingAddressExternalAddressID         Write FsShippingAddressExternalAddressID;
    Property ShippingAddressInternationalName        : String  Read FsShippingAddressInternationalName         Write FsShippingAddressInternationalName;
    Property ShippingAddressInternationalStateAndCity: String  Read FsShippingAddressInternationalStateAndCity Write FsShippingAddressInternationalStateAndCity;
    Property ShippingAddressInternationalStreet      : String  Read FsShippingAddressInternationalStreet       Write FsShippingAddressInternationalStreet;
    Property ShippingAddressAddressRecordType        : String  Read FsShippingAddressAddressRecordType         Write FsShippingAddressAddressRecordType;
    Property ShippingAddressFirstName                : String  Read FsShippingAddressFirstName                 Write FsShippingAddressFirstName;
    Property ShippingAddressLastName                 : String  Read FsShippingAddressLastName                  Write FsShippingAddressLastName;
    Property ShippingAddressPhone2                   : String  Read FsShippingAddressPhone2                    Write FsShippingAddressPhone2;
    Property ShippingAddressAddressUsage             : String  Read FsShippingAddressAddressUsage              Write FsShippingAddressAddressUsage;
    Property ShippingAddressReferenceID              : String  Read FsShippingAddressReferenceID               Write FsShippingAddressReferenceID;
    Property ShippingtoDesc                          : String  Read FsShippingtoDesc                           Write FsShippingtoDesc;
    Property EbayCustomer                            : String  Read fsEbayCustomer                             Write fsEbayCustomer;
    Property SingleCustomer                          : Boolean Read fbSingleCustomer                           Write fbSingleCustomer;

  End;

Implementation

uses Sysutils,Busobjclient, busobjstock, Variants, CommonLib, tcConst,
  AddressLib, LogUtils, AppEnvironment;

{ TEBaySalesOrder }
constructor TEBaySalesOrder.Create(AOwner: TComponent);
begin
  inherited;
end;

function TEBaySalesOrder.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
end;

procedure TEBaySalesOrder.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  if Sysutils.SameText(Sender.FieldName , 'CustomerName') then begin
    if (Sender.OldValue <> Sender.AsString) then begin
      ClientID := MakeCustomer;
      InitShiptoAddress;
    end;
(*  end else if Sysutils.SameText(Sender.FieldName , 'ShipTo') then begin
    if (Sender.OldValue <> Sender.AsString) then begin
      MakeCustomer;
      InitShiptoAddress;
    end;*)
  end;


  inherited;
end;

function TEBaySalesOrder.getEbaySalesOrderline: TEBaySaleSorderLine;
begin
    Result := TEBaySaleSorderLine(getContainerComponent(TEBaySaleSorderLine, 'SaleID = '+ IntToStr(Self.Id)));
end;

function TEBaySalesOrder.GetLines: TTransLineBase;
begin
  Result:= self.getEbaySalesOrderline;
  if Self.SilentMode then Result.SilentMode := True;
end;

function TEBaySalesOrder.GetSalesOrderLines: TSalesOrderLine;
begin
  Result:= self.getEbaySalesOrderline;
  if Self.SilentMode then Result.SilentMode := True;
end;

function TEBaySalesOrder.getSOPrepayments: TEbaySOPrepayment;
begin
    Result := TEbaySOPrepayment(getContainerComponent(TEbaySOPrepayment, 'PrePaymentID = 0' ));
end;

function TEBaySalesOrder.HasShippingDetails: Boolean;
begin
    result := (Trim(ShippingAddressCompanyName)<> '') Or
              (Trim(ShippingAddressCountryName)<> '') Or
              (Trim(ShippingAddressName_)<> '') Or
              (Trim(ShippingAddressStreet)<> '') Or
              (Trim(ShippingAddressStreet1)<> '') Or
              (Trim(ShippingAddressStreet2)<> '') Or
              (Trim(ShippingAddressCityName)<> '') Or
              (Trim(ShippingAddressCounty)<> '') Or
              (Trim(ShippingAddressStateOrProvince)<> '') Or
              (Trim(ShippingAddressCountry)<> '');
end;

function TEBaySalesOrder.MakeCustomer:Integer;
var
  Customer :TCustomer;
  sText :String;
  fs:String;
  function add1:String;
  begin
    REsult := AddressLib.add1(ShippingAddressStreet, ShippingAddressStreet1, ShippingAddressStreet2);
  end;
  function add2:String;
  begin
    REsult := AddressLib.add2(ShippingAddressStreet, ShippingAddressStreet1, ShippingAddressStreet2);
  end;
  function add3:String;
  begin
    REsult := AddressLib.add3(ShippingAddressStreet, ShippingAddressStreet1, ShippingAddressStreet2);
  end;
begin
  result:= 0;
  Customer := TCustomer.CreateWithNewConn(Self);
  try
    Customer.connection.BeginTransaction;
    try
      Customer.Loadselect('company = ' + quotedstr(CustomerName));
      if Customer.count =0 then begin
        Customer.New;
        Customer.ClientName               := CustomerName;
        Customer.FirstName                := ShippingAddressFirstName;
        Customer.LastName                 := ShippingAddressLastName;
        Customer.Street                   := add1;
        Customer.Street2                  := add2;
        Customer.Street3                  := add3;
        Customer.Suburb                   := ShippingAddressCityName;
        Customer.State                    := ShippingAddressStateOrProvince;
        Customer.Phone                    := ShippingAddressPhoneCountryPrefix + ShippingAddressPhoneAreaOrCityCode+ ShippingAddressPhone;
        Customer.ALTPhone                 := ShippingAddressPhone2CountryPrefix +ShippingAddressPhone2AreaOrCityCode + ShippingAddressPhoneLocalNumber;
        Customer.Postcode                 := ShippingAddressPostalCode;
        Customer.ClientTypeName           := ShippingAddressAddressOwner;
        Customer.Mobile                   := ShippingAddressPhone2;
        Customer.Country                  := ShippingAddressCountryName;
        Customer.PostDB;
        LogD('Customer Created', LbBegin);
      end else begin
        LogD('Customer Already exists', LbBegin);
      end;
      result :=Customer.ID;

      if (trim(ShippingAddressStreet) <> '') or
         (trim(ShippingAddressStreet1) <> '') or
         (trim(ShippingAddressStreet2) <> '') or
         (trim(ShippingAddressCityName) <> '') or
         (trim(ShippingAddressPostalCode) <> '') or
         (trim(ShippingAddressStateOrProvince) <> '') or
         (trim(ShippingAddressCountryName) <> '')  then begin
          if not Customer.ShippingAddresses.Locate('CompanyName;Customer_ID;ShipAddress;ShipAddress1;ShipCity;ShipPostCode;ShipState;ShipCountry;ShipAddress2' ,
                                       varArrayof([Customer.ClientName,Customer.Id,add1,add2,ShippingAddressCityName,ShippingAddressPostalCode,ShippingAddressStateOrProvince,ShippingAddressCountryName,add3]), []) then begin
            Customer.ShippingAddresses.New;
            Customer.ShippingAddresses.CompanyName:= Customer.ClientName;
            Customer.ShippingAddresses.CustomerID:= Customer.Id;
            Customer.ShippingAddresses.ShipAddress:=add1;
            Customer.ShippingAddresses.ShipAddress1:= add2;
            Customer.ShippingAddresses.ShipAddress2:= add3;
            Customer.ShippingAddresses.ShipCity:= ShippingAddressCityName;
            Customer.ShippingAddresses.ShipPostCode:= ShippingAddressPostalCode;
            Customer.ShippingAddresses.ShipState:= ShippingAddressStateOrProvince;
            Customer.ShippingAddresses.ShipCountry:= ShippingAddressCountryName;
            Customer.ShippingAddresses.PostDB;
            LogD('Customer Shipping address Created', LbBegin);
          end else begin
            LogD('Customer Shipping address Exists', LbBegin);
          end;
      end else begin
          LogD('Customer Shipping address is blank', LbBegin);
      end;
      if (Customer.ShippingAddresses.ID<>0) then
        if not Customer.ShippingAddressLink.Locate('ClientID;ShipAddressID' , vararrayof([Customer.Id,Customer.ShippingAddresses.ID]) , []) then begin
          Customer.ShippingAddressLink.new;
          Customer.ShippingAddressLink.clientId := customer.ID;
          Customer.ShippingAddressLink.ShipAddressID :=Customer.ShippingAddresses.ID;
          Customer.ShippingAddressLink.PostDB;
          LogD('Customer Shipping address link Created', LbBegin);
        end else begin
          LogD('Customer Shipping address link exists', LbBegin);
        end;
      ShipToID :=Customer.ShippingAddresses.ID;
      sText := '';
      sText := sText + Customer.ClientName;
      if not Empty(Customer.ShippingAddresses.ShipAddress)  then sText := sText + #13 + Customer.ShippingAddresses.ShipAddress;
      if not Empty(ShippingAddressStreet1)                  then sText := sText + #13 + ShippingAddressStreet1;
      if not Empty(ShippingAddressStreet2)                  then sText := sText + #13 + ShippingAddressStreet2;
      if not Empty(ShippingAddressCityName)                 then sText := sText + #13 + ShippingAddressCityName;
      if not Empty(ShippingAddressStateOrProvince)          then sText := sText + ' ' + ShippingAddressStateOrProvince;
      if not Empty(ShippingAddressPostalCode)               then sText := sText + ' ' + ShippingAddressPostalCode;
      if not Empty(ShippingAddressCountryName)              then sText := sText + #13 + ShippingAddressCountryName;
      ShippingtoDesc := SText;
      PostDB;
      Customer.connection.CommitTransaction;
    Except
      on E:Exception do begin
        Customer.connection.RollbackTransaction;
      end;
    end;
  finally
    FreeandNil(Customer);
  end;
end;

procedure TEBaySalesOrder.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  EbayCustomer  := '';
  SingleCustomer:= False;
end;

function TEBaySalesOrder.Save: Boolean;
begin
  result := inherited Save;
  if not Result then exit;
  ClientID := MakeCustomer;
  PostDB;
(*  if HasShippingDetails then begin
    ShippingAddressObj.New;
    ShippingAddressObj.CustomerID     := CustomerID;
    ShippingAddressObj.CompanyName    := ShippingAddressCompanyName;
    ShippingAddressObj.ShipCountry    := ShippingAddressCountryName ;
    ShippingAddressObj.ContactName    := ShippingAddressName_ ;
    ShippingAddressObj.ShipAddress    := ShippingAddressStreet ;
    ShippingAddressObj.ShipAddress1   := ShippingAddressStreet1 ;
    ShippingAddressObj.ShipAddress2   := ShippingAddressStreet2 ;
    ShippingAddressObj.ShipCity       := ShippingAddressCityName ;
    ShippingAddressObj.ShipCountry    := ShippingAddressCounty ;
    ShippingAddressObj.ShipState      := ShippingAddressStateOrProvince ;
    ShippingAddressObj.ShipCountry    := ShippingAddressCountry ;
    ShippingAddressObj.Phone          := ShippingAddressPhone ;
    ShippingAddressObj.ShipPostCode   := ShippingAddressPostalCode ;
    if ShippingAddressObj.ContactName  = '' then ShippingAddressObj.ContactName        := ShippingAddressInternationalName ;
    ShippingAddressObj.PostDB;
    ShipToDesc                        := ShippingtoDesc;
    PostDB;
  end;*)
  (*if HasShippingDetails then begin
    ShippingAddressObj.New;
    ShippingAddressObj.CustomerID     := CustomerID;
    ShippingAddressObj.CompanyName    := ShippingAddressCompanyName;
    ShippingAddressObj.ShipCountry    := ShippingAddressCountryName ;
    ShippingAddressObj.ContactName    := ShippingAddressName_ ;
    ShippingAddressObj.ShipAddress    := Add1(ShippingAddressStreet, ShippingAddressStreet1  , ShippingAddressStreet2) ;
    ShippingAddressObj.ShipAddress1   := Add2(ShippingAddressStreet, ShippingAddressStreet1  , ShippingAddressStreet2) ;
    ShippingAddressObj.ShipAddress2   := Add3(ShippingAddressStreet, ShippingAddressStreet1  , ShippingAddressStreet2) ;
    ShippingAddressObj.ShipCity       := ShippingAddressCityName ;
    ShippingAddressObj.ShipCountry    := ShippingAddressCounty ;
    ShippingAddressObj.ShipState      := ShippingAddressStateOrProvince ;
    ShippingAddressObj.ShipCountry    := ShippingAddressCountry ;
    ShippingAddressObj.Phone          := ShippingAddressPhone ;
    ShippingAddressObj.ShipPostCode   := ShippingAddressPostalCode ;
    if ShippingAddressObj.ContactName  = '' then ShippingAddressObj.ContactName        := ShippingAddressInternationalName ;
    ShippingAddressObj.PostDB;
    ShipToID := ShippingAddressObj.ID;
    ShipToDesc := ShippingAddressObj.ShiptoForSales;
    InvoiceToDesc := ShipToDesc;
    PostDB;
    if (ShippingAddressObj.ID<>0) and not Customer.ShippingAddressLink.Locate('ClientID;ShipAddressID' , vararrayof([Customer.Id,ShippingAddressObj.ID]) , []) then begin
        Customer.ShippingAddressLink.new;
        Customer.ShippingAddressLink.clientId := customer.ID;
        Customer.ShippingAddressLink.ShipAddressID :=ShippingAddressObj.ID;
        Customer.ShippingAddressLink.PostDB;
      end;
  end else  if ShippingtoDesc <> '' then begin
    ShipToDesc := ShippingtoDesc;
  end;*)
end;

procedure TEBaySalesOrder.SetCustomerName(Value: string);
begin
  if Value = '' then Value := CLIENT_CASH;
  inherited;
end;

function TEBaySalesOrder.ValidateData: Boolean;
begin
  result := inherited  ValidateData;
  if not result then Exit;
  if(trim(EbayCustomer)<> '') and SingleCustomer then begin
    if TCustomer.idtoggle(EbayCustomer)<>0 then begin
      Customername :=EbayCustomer;
    end;
  end;
end;

{ TEBaySaleSorderLine }

procedure TEBaySaleSorderLine.CalcLineTotals;
begin
  if linePrice <>  linepriceinc then linePrice :=  linepriceinc;
  if LineTaxRate <> 0 then begin
    if linetaxcode <>  AppEnv.RegionalOptions.taxcodenotax then
      linetaxcode :=  AppEnv.RegionalOptions.taxcodenotax;
    LineTaxRate := 0;
  end;
  inherited CalcLineTotals;
end;

function TEBaySaleSorderLine.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  if not result then exit;
  linetaxcode :=  AppEnv.RegionalOptions.taxcodenotax;
end;

procedure TEBaySaleSorderLine.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  if Sysutils.SameText(Sender.FieldName , 'ProductName') then begin
    if  (Sender.AsString<>'') and  (Sender.OldValue <> Sender.AsString) then begin
      productID := MakeProduct(Sender.AsString);
      linetaxcode :=  AppEnv.RegionalOptions.taxcodenotax;
    end;
  end else if Sysutils.SameText(Sender.FieldName , 'LinePrice') then begin
    linepriceinc := linePrice;
  end else if Sysutils.SameText(Sender.FieldName , 'LinePriceinc') then begin
    linePrice:= linepriceinc;
  end else if Sysutils.SameText(Sender.FieldName , 'LineTaxCode') then begin
    if linetaxcode <>  AppEnv.RegionalOptions.taxcodenotax then
      linetaxcode :=  AppEnv.RegionalOptions.taxcodenotax;
  end else if Sysutils.SameText(Sender.FieldName , 'LineTaxRate') then begin
    if LineTaxRate <> 0 then LineTaxRate := 0;
  end;
  inherited;
end;

function TEBaySaleSorderLine.getSKU: String;
begin
  REsult := Vars.Values.ByName['SKU'].asString;
end;
procedure TEBaySaleSorderLine.SetSKU(const Value: String);
begin
  Vars.Values.ByName['SKU'].asString := Value;
end;

(*function TEBaySaleSorderLine.getProductname: String;
begin
  result := getStringfield('productname');
end;*)

function TEBaySaleSorderLine.MakeProduct(const Value:String):Integer;
var
  fProduct :TProduct;
begin
  REsult:= 0;
  fProduct :=TProduct.CreateWithNewConn(Self);
  try
    fProduct.Connection.BeginTransaction;
    try
      fProduct.LoadSelect('Partname =' + Quotedstr(Value));
      if fProduct.count = 0 then begin
        fProduct.New;
        fProduct.Productname :=Value;
        fProduct.SKU := SKU;
        fProduct.SalesDescription := Self.Product_Description;
        fProduct.ProductType := 'INV';
        fProduct.SellQty1 := 1;
        fProduct.SellQty1PriceInc := Self.LinePriceInc;
        fProduct.SellQty2 := 1;
        fProduct.SellQty2PriceInc := Self.LinePriceInc;
        fProduct.SellQty3 := 1;
        fProduct.SellQty3PriceInc := Self.LinePriceInc;
        fProduct.Active := True;
      end else begin
        if (Trim(fProduct.SKU) = '') and (Trim(SKU) <> '') then  fProduct.SKU := SKU;
      end;
      fProduct.PostDB;
      fProduct.Connection.CommitTransaction;
      Result:= fProduct.ID;
    Except
      fProduct.connection.RollbackTransaction;
    end;
  finally
    Freeandnil(fProduct);
  end;

end;

function TEBaySaleSorderLine.SAve: Boolean;
begin
  if linePrice <>  linepriceinc then linePrice :=  linepriceinc;
  if LineTaxRate <> 0 then begin
    if linetaxcode <>  AppEnv.RegionalOptions.taxcodenotax then
      linetaxcode :=  AppEnv.RegionalOptions.taxcodenotax;
    LineTaxRate := 0;
  end;
  result := inherited Save;
end;

procedure TEBaySaleSorderLine.SetProductDescription(const Value: String);
begin
  inherited;
  if trim(Productname) = '' then
    Productname := Value;
end;


(*procedure TEBaySaleSorderLine.SetProductname(const Value: String);
begin
  MakeProduct;
  result := SetStringfield('productname', Value);
end;*)
{ TEbaySOPrepayment }

function TEbaySOPrepayment.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if owner is TEBaySalesOrder then begin
      ClassID := TEBaySalesOrder(Owner).SaleClassId;
    end;
end;

procedure TEbaySOPrepayment.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    if Sysutils.SameText(Sender.fieldName, 'CompanyName') then begin
        if CompanyName = '' then companyname := OwnerSOCustomerName;
    end else if Sysutils.SameText(Sender.fieldName, 'ClientID') then begin
        if clientID=0 then ClientID := OwnerSOclientID;
    end;
    inherited;
end;

function TEbaySOPrepayment.getPayMethod: String;
begin
    with GetNewDataset('select Name from tblpaymentmethods where PaymethodID = ' + inttostr(PaymethodID), true) do try
      Result:= Fieldbyname('Name').AsString;
    finally
      if active then close;
      Free;
    end;
end;

function TEbaySOPrepayment.getSalesOriginalRef: String;
begin
  result:= '';
  if assigned(Owner) then
    if owner is TSalesOrder then
      result :=TSalesOrder(Owner).OriginalDocNumber;
end;

function TEbaySOPrepayment.getSalesPrepayments: TSalesPrepayments;
begin
    Result := TSalesPrepayments(getContainerComponent(TSalesPrepayments , 'PrepayRef = ' +Quotedstr(Globalref)));
end;

function TEbaySOPrepayment.getSalesRef: String;
begin
  result:= '';
  if assigned(Owner) then
    if owner is TSalesOrder then
      result :=TSalesOrder(Owner).globalref;
end;

function TEbaySOPrepayment.OwnerSOclientID: Integer;
begin
  result:= 0;
  if Assigned(Owner) then
    if Owner is TEBaySalesOrder then
      result:= TEBaySalesOrder(Owner).clientID;
end;

function TEbaySOPrepayment.OwnerSOCustomerName: String;
begin
  result:= '';
  if Assigned(Owner) then
    if Owner is TEBaySalesOrder then
      result:= TEBaySalesOrder(Owner).CustomerName;

end;

function TEbaySOPrepayment.Save: Boolean;
begin
  REsult:= inherited SAve;
  if not result then exit;
  with SalesPrepayments do begin
    if count =0 then begin
      New;
      SalesRef:= Self.SalesRef;
      SalesOriginalRef:= Self.SalesOriginalRef;
      PrepayRef := Self.GlobalRef;
      IsSalesOrder:= True;
      PostDB;
    end;
  end;
end;

procedure TEbaySOPrepayment.setPayMethod(const Value: String);
begin
    with GetNewDataset('select * from tblpaymentmethods where Name = ' + Quotedstr(Value), true) do try
      if recordcount =0 then begin
        Append;
        FieldByname('Name').AsString := Value;
        Post;
      end;
      PaymethodId := fieldByname('PaymethodID').AsInteger;
    finally
      if active then close;
      Free;
    end;
end;

initialization
  RegisterClass(TEBaySaleSorderLine);
  RegisterClass(TEBaySalesOrder);
  RegisterClass(TEbaySOPrepayment);


End.

