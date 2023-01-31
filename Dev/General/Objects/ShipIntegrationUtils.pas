unit ShipIntegrationUtils;

interface
{$I ERP.inc}

uses
  SysUtils, BusObjSales, ibxEzAddress, ibxezship, JsonObject, ShipIntegrationTypes;

//  function ValidateAddress(var msg: string;
//    Line1, Line2, Line3,
//    Place, State, PostCode, Country: string;
//    EzAddress: TibxEzAddress = nil; list: TJsonObject = nil;
//    Shipper: TShipperType = spNone): boolean; overload;
  function ValidateAddress(var msg: string;
    Line1, Line2, Line3,
    Place, State, PostCode, Country: string;
    list: TJsonObject = nil;
    Shipper: TShipperType = spNone): boolean; overload;
  function ValidateAddress(Line1, Line2, Line3,
    Place, State, PostCode, Country: string; list: TJsonObject = nil): boolean; overload;

//  function ShipOrder(Sale: TSales; var msg: string): boolean;

  procedure CheckShippingMethods(aShipperType: TShipperType; Options: TShipServiceOptionSet);

  function SaleShipProvider(const ASaleId: integer; var ServiceType: TibxezshipServiceTypes;
    var aClientShipperAccountNo, aClientBillCountryCode, aClientBillPostcode: string; var aPayorType:String): TibxezshipProviders;
  function SaleShipVia(const ASaleId: integer): string;


//  function StrToUPSShipServiceType(str: string): TibxezshipServiceTypes;

  function DefaultPackageType(Provider: TibxezshipProviders): TibxezshipPackageTypes;

  function StrToAlphaNumeric(const s: string; aLength: integer): string;

//type

implementation

uses
  types, StrUtils, Character,
  AppEnvironment, ProgressDialog, CommonLib, Dialogs, BusObjShippingAddress,
  BusObjCommon, CommonDbLib, Controls, ERPDBComponents, DbSharedObjectsObj,
  BusObjCountries, ibxupsaddress, ibxfedexaddress, ibxuspsaddress;


function SaleShipProvider(const aSaleId: integer; var ServiceType: TibxezshipServiceTypes;
  var aClientShipperAccountNo, aClientBillCountryCode, aClientBillPostcode: string; var aPayorType:String): TibxezshipProviders;
var
  qry: TERPQuery;
  s: string;
  x: integer;
begin
  result := pFedEx;
  qry := TERPQuery.Create(nil);
  try
    try
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Add('select Shipping from tblSales');
      qry.SQL.Add('where SaleId = ' + IntToStr(aSaleId));
      qry.Open;
      s := qry.FieldByName('Shipping').AsString;

      if s <> '' then begin
        { UPS ? }
        for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do begin
          if SameText(s, ShipServiceTypeList[x].Name) then begin
            if ppFedEx in ShipServiceTypeList[x].Providers then result := pFedEx
            else if ppUPS in ShipServiceTypeList[x].Providers then result := pUPS
            else if ppUSPS in ShipServiceTypeList[x].Providers then result := pUSPS
            else if ppCanadaPost in ShipServiceTypeList[x].Providers then result := pCanadaPost
            else if ppUSPSEndicia in ShipServiceTypeList[x].Providers then result := pUSPS
            else if ppUSPSStamps in ShipServiceTypeList[x].Providers then result := pUSPS;
            ServiceType := ShipServiceTypeList[x].Service;
            exit;
          end;
        end;
        { not found , check for client's defaults }
             Closedb(qry);
             qry.sql.text := 'Select C.* '+
                             ' from tblsales S  '+
                             ' inner join tblcustomershippingoptions  C on S.ClientID = C.CustomerID and C.isdefault ="T" and C.active ="T" '+
                             ' where ifnull(C.ShipperType,"") <>"" and  S.saleId =  ' + IntToStr(aSaleId);
             Opendb(qry);
             if (qry.recordcount >0) then begin
              if SameText(trim(qry.fieldbyname('Shippertype').asString), 'FedEx') then begin
                result := pFedEx;
                aClientShipperAccountNo := trim(qry.fieldbyname('AccountNumber').asString);
                aPayorType := trim(qry.fieldbyname('PayorType').asString);
                if AppEnv.CompanyPrefs.FedexConfig.DefaultService <> '' then
                    ServiceType := StrToShipServiceType(AppEnv.CompanyPrefs.FedexConfig.DefaultService);
                exit;
              end else if SameText(trim(qry.fieldbyname('Shippertype').asString), 'UPS') then begin
                result := pUPS;
                aClientShipperAccountNo := trim(qry.fieldbyname('AccountNumber').asString);
                aPayorType := trim(qry.fieldbyname('PayorType').asString);
                if AppEnv.CompanyPrefs.UPSConfig.DefaultService <> '' then
                  ServiceType := StrToShipServiceType(AppEnv.CompanyPrefs.UPSConfig.DefaultService);
                exit;
              end else if SameText(trim(qry.fieldbyname('Shippertype').asString), 'USPS') then begin
                result := pUSPS;
                aClientShipperAccountNo := trim(qry.fieldbyname('AccountNumber').asString);
                aPayorType := trim(qry.fieldbyname('PayorType').asString);
                if AppEnv.CompanyPrefs.USPSConfig.DefaultService <> '' then
                  ServiceType := StrToShipServiceType(AppEnv.CompanyPrefs.USPSConfig.DefaultService);
                exit;
              end else if SameText(trim(qry.fieldbyname('Shippertype').asString), 'Canada') then begin
                result := pCanadaPost;
                aClientShipperAccountNo := trim(qry.fieldbyname('AccountNumber').asString);
                aPayorType := trim(qry.fieldbyname('PayorType').asString);
                exit;
              end

             end;

        { not found so try somthing else .. }
        //for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do begin
          if SameText(Trim(s), 'FedEx') then begin
            result := pFedEx;
            exit;
          end else if SameText(Trim(s), 'UPS') then begin
            result := pUPS;
            exit;
          end else if SameText(Trim(s), 'USPS') then begin
            result := pUSPS;
            exit;
          end else if SameText(Trim(s), 'Canada') then begin
            result := pCanadaPost;
            exit;
          end
        //end;
      end;
      if AppEnv.CompanyPrefs.FedExConfig.FedExEnabled then begin
        result := pFedEx;
        if AppEnv.CompanyPrefs.FedexConfig.DefaultService <> '' then
          ServiceType := StrToShipServiceType(AppEnv.CompanyPrefs.FedexConfig.DefaultService);
        exit;
      end;
      if AppEnv.CompanyPrefs.UPSConfig.UPSEnabled then begin
        result := pUPS;
        if AppEnv.CompanyPrefs.UPSConfig.DefaultService <> '' then
          ServiceType := StrToShipServiceType(AppEnv.CompanyPrefs.UPSConfig.DefaultService);
        exit;
      end;
      if AppEnv.CompanyPrefs.USPSConfig.USPSEnabled then begin
        result := pUSPS;
        if AppEnv.CompanyPrefs.USPSConfig.DefaultService <> '' then
          ServiceType := StrToShipServiceType(AppEnv.CompanyPrefs.USPSConfig.DefaultService);
        exit;
      end;

      if AppEnv.CompanyPrefs.UPSConfig.UPSEnabled then begin
        result := pUPS;
        ServiceType := StrToShipServiceType(AppEnv.CompanyPrefs.UPSConfig.DefaultService);
        exit;
      end;
    finally
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('SELECT c.ClientShipperAccountNo, c.BillCountry, c.BillPostCode FROM tblClients c');
      qry.SQL.Add('INNER JOIN tblsales s on s.ClientID = c.ClientID and s.SaleID = ' + IntToStr(aSaleId));
      qry.Open;
      aClientShipperAccountNo := qry.FieldByName('ClientShipperAccountNo').AsString;
      aClientBillPostcode := qry.FieldByName('BillPostCode').AsString;
      aClientBillCountryCode := TCountries.CodeForCountry(qry.FieldByName('BillCountry').AsString);
    end;
  finally
    qry.Free;
  end;
end;

function SaleShipVia(const ASaleId: integer): string;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'select Shipping from tblsales where SaleID = ' + IntToStr(ASaleId);
    qry.open;
    result := qry.FieldByName('Shipping').AsString;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function ShipperType: TShipperType;
begin
  result := spNone;
  if AppEnv.CompanyPrefs.UPSConfig.UPSEnabled then result := spUPS;
end;

(*
function GetEzAddress(var msg: string; Shipper: TShipperType = spNone): TibxEzAddress;
var
  st: TShipperType;
begin
  st := Shipper;
  if st = spNone then
    st := ShipperType;
  result := TibxEzAddress.Create(nil);
  case st of
    spNone:
      begin
        FreeAndNil(result);
        raise Exception.Create('ERP does not have any shipper (eg UPS / FedEx) configured and/or enabled.');
      end;
    spUPS:
      begin
        if not AppEnv.CompanyPrefs.UPSConfig.Validate(msg) then begin
          FreeAndNil(result);
          exit;
        end;
        { set up auth stuff }
        result.Reset;
        result.Provider := TIbxEzAddressProviders(pUPS);
        result.AccessKey := AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey;
        result.AccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;
        result.UserId := AppEnv.CompanyPrefs.UPSConfig.UPSUserID;
        result.Password := AppEnv.CompanyPrefs.UPSConfig.UPSPassword;
        if AppEnv.CompanyPrefs.UPSConfig.TestMode then
          result.Server := AppEnv.CompanyPrefs.UPSConfig.TestURL + '/XAV'
        else
          result.Server := AppEnv.CompanyPrefs.UPSConfig.UPSServer + '/XAV';
      end;
    spFedEx:
      begin
        if not AppEnv.CompanyPrefs.FedExConfig.Validate(msg) then begin
          FreeAndNil(result);
          exit;
        end;
        result.Reset;
        result.DeveloperKey := AppEnv.CompanyPrefs.FedExConfig.AccessKey;
        result.Provider := TIbxEzAddressProviders(pFedEx);
        //result.AccessKey := AppEnv.CompanyPrefs.FedExConfig.AccessKey;
        result.AccountNumber := AppEnv.CompanyPrefs.FedExConfig.AccountNumber;
        //result.UserId := ;
        result.Password := AppEnv.CompanyPrefs.FedExConfig.Password;
        result.Server := AppEnv.CompanyPrefs.FedExConfig.Server;
      end;
    spUSPS:
      begin
        if not AppEnv.CompanyPrefs.USPSConfig.Validate(msg) then begin
          FreeAndNil(result);
          exit;
        end;
        result.Reset;
        result.Provider := TIbxEzAddressProviders(pUSPS);
        //result.AccessKey :=
        result.AccountNumber := AppEnv.CompanyPrefs.USPSConfig.USPSAccountNumber;
        result.UserId := AppEnv.CompanyPrefs.USPSConfig.USPSUserID;
        result.Password := AppEnv.CompanyPrefs.USPSConfig.USPSPassword;
        result.Server := AppEnv.CompanyPrefs.USPSConfig.ShipServer;
      end;
    else
      begin
        raise Exception.Create('GetEzAddress - Unknown shipper');
      end;
  end;
end;
*)

function GetAddressComp(var msg: string; Shipper: TShipperType = spNone): TObject;
var
  st: TShipperType;
begin
  st := Shipper;
  if st = spNone then
    st := ShipperType;
  case st of
    spNone:
      begin
        FreeAndNil(result);
        raise Exception.Create('ERP does not have any shipper (eg UPS / FedEx) configured and/or enabled.');
      end;
    spUPS:
      begin
        if not AppEnv.CompanyPrefs.UPSConfig.Validate(msg) then begin
          exit;
        end;
        result := TibxUPSAddress.Create(nil);
        { set up auth stuff }
//        result.Reset;
//        result.Provider := TIbxEzAddressProviders(pUPS);
//        result.AccessKey := AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey;
//        result.AccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;
//        result.UserId := AppEnv.CompanyPrefs.UPSConfig.UPSUserID;
//        result.Password := AppEnv.CompanyPrefs.UPSConfig.UPSPassword;
//        if AppEnv.CompanyPrefs.UPSConfig.TestMode then
//          result.Server := AppEnv.CompanyPrefs.UPSConfig.TestURL + '/XAV'
//        else
//          result.Server := AppEnv.CompanyPrefs.UPSConfig.UPSServer + '/XAV';

        TibxUPSAddress(result).UPSAccessKey := AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey;
        TibxUPSAddress(result).UPSAccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;
        TibxUPSAddress(result).UPSUserId := AppEnv.CompanyPrefs.UPSConfig.UPSUserID;
        TibxUPSAddress(result).UPSPassword := AppEnv.CompanyPrefs.UPSConfig.UPSPassword;
        if AppEnv.CompanyPrefs.UPSConfig.TestMode then
          TibxUPSAddress(result).UPSServer := AppEnv.CompanyPrefs.UPSConfig.TestURL + '/XAV'
        else
          TibxUPSAddress(result).UPSServer := AppEnv.CompanyPrefs.UPSConfig.UPSServer + '/XAV';

      end;
    spFedEx:
      begin
        if not AppEnv.CompanyPrefs.FedExConfig.Validate(msg) then begin
          exit;
        end;
        result := TibxFedExAddress.Create(nil);
//        result.Reset;
//        result.DeveloperKey := AppEnv.CompanyPrefs.FedExConfig.AccessKey;
//        result.Provider := TIbxEzAddressProviders(pFedEx);
//        result.AccountNumber := AppEnv.CompanyPrefs.FedExConfig.AccountNumber;
//        result.Password := AppEnv.CompanyPrefs.FedExConfig.Password;
//        result.Server := AppEnv.CompanyPrefs.FedExConfig.Server;

        TibxFedExAddress(result).FedExDeveloperKey := AppEnv.CompanyPrefs.FedExConfig.AccessKey;
        TibxFedExAddress(result).FedExAccountNumber := AppEnv.CompanyPrefs.FedExConfig.AccountNumber;
        TibxFedExAddress(result).FedExMeterNumber := AppEnv.CompanyPrefs.FedExConfig.MeterNumber;
        TibxFedExAddress(result).FedExPassword := AppEnv.CompanyPrefs.FedExConfig.Password;
        TibxFedExAddress(result).FedExServer := AppEnv.CompanyPrefs.FedExConfig.Server;
      end;
    spUSPS:
      begin
        if not AppEnv.CompanyPrefs.USPSConfig.Validate(msg) then begin
          exit;
        end;
        result := TibxUSPSAddress.Create(nil);
//        result.Reset;
//        result.Provider := TIbxEzAddressProviders(pUSPS);
//        result.AccountNumber := AppEnv.CompanyPrefs.USPSConfig.USPSAccountNumber;
//        result.UserId := AppEnv.CompanyPrefs.USPSConfig.USPSUserID;
//        result.Password := AppEnv.CompanyPrefs.USPSConfig.USPSPassword;
//        result.Server := AppEnv.CompanyPrefs.USPSConfig.ShipServer;

        TibxUSPSAddress(result).USPSAccountNumber := AppEnv.CompanyPrefs.USPSConfig.USPSAccountNumber;
        TibxUSPSAddress(result).USPSUserId := AppEnv.CompanyPrefs.USPSConfig.USPSUserID;
        TibxUSPSAddress(result).USPSPassword := AppEnv.CompanyPrefs.USPSConfig.USPSPassword;
        TibxUSPSAddress(result).USPSServer := AppEnv.CompanyPrefs.USPSConfig.ShipServer;
      end;
    else
      begin
        raise Exception.Create('GetEzAddress - Unknown shipper');
      end;
  end;
end;

function GetEzShip: TibxEzShip;
begin
  result := TibxEzShip.Create(nil);
  case ShipperType of
    spNone:
      begin
        FreeAndNil(result);
        raise Exception.Create('ERP does not have any shipper (eg UPS / FedEx) configured and/or enabled.');
      end;
    spUPS:
      begin
        result.Provider := TibxezshipProviders(pUPS);
        { set up auth stuff }
        result.Reset;
        result.AccessKey := AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey;
        result.AccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;
        result.UserId := AppEnv.CompanyPrefs.UPSConfig.UPSUserID;
        result.Password := AppEnv.CompanyPrefs.UPSConfig.UPSPassword;
        if AppEnv.CompanyPrefs.UPSConfig.TestMode then
          result.Server := AppEnv.CompanyPrefs.UPSConfig.TestURL + '/Ship'
        else
        result.Server := AppEnv.CompanyPrefs.UPSConfig.UPSServer + '/Ship';
      end;
    spFedEx:
      begin
        raise Exception.Create('GetEzShip - FedEx not implemented');
      end;
    else
      begin
        raise Exception.Create('GetEzShip - Unknown shipper');
      end;
  end;
end;

(*
  Example of message from UPS exceotion:

  527: AuthenticationError:[250003] Invalid Access License number.
  Error occurred on: /soap:Envelope[1]/soap:Header[1]/UPSSecurity[1]/ServiceAccessToken[1]/AccessLicenseNumber[1]

  or

  11002: [11002] Non-authoritative ''Host not found'' (try again or check DNS setup)

*)

(*
function ValidateAddress(var msg: string;
  Line1, Line2, Line3,
  Place, State, PostCode, Country: string;
  EzAddress: TibxEzAddress = nil; list: TJsonObject = nil;
  Shipper: TShipperType = spNone): boolean;
var
  Add: TibxEzAddress;
  Err: TShipperError;
  json: TJsonObject;

  procedure LoadList;
  var
    x: integer;
  begin
    list.Clear;
    for x := 0 to Add.MatchCount -1 do begin
      json := JO;
      json.S[Match_Address1] := Add.MatchAddress1[x];
      json.S[Match_Address2] := Add.MatchAddress2[x];
      json.S[Match_ChangeType] := Add.MatchChangeType[x];
      json.S[Match_City] := Add.MatchCity[x];
      json.S[Match_Company] := Add.MatchCompany[x];
      json.S[Match_CountryCode] := Add.MatchCountryCode[x];
      json.I[Match_MatchPercent] := Trunc(StrToFloatDef(Add.MatchQuality[x],0) * 100);
      json.S[Match_ResidentialStatus] := Add.MatchResidentialStatus[x];
      json.S[Match_State] := Add.MatchState[x];
      json.S[Match_PostCode] := Add.MatchZipCode[x];
      list.A['list'].Add(json);
    end;
  end;

begin
  result := true;
  if Trim(Line1) = '' then begin
    result := false;
    msg := 'Address line 1 is blank, this must contain a value';
    exit;
  end;
  msg:= '';
  if ShipperType = spNone then begin
    result := false;
    msg := 'ERP does not have any shipper (eg UPS / FedEx) configured and/or enabled to validate the address against.';
    exit;
  end;
  if Assigned(EzAddress) then Add := EzAddress
  else Add := GetEzAddress(msg, Shipper);
  if not Assigned(Add) then begin
    result := false;
    exit;
  end;
  try

    { generic }
    Add.Address1 := Line1;
    if Line2 <> '' then begin
      if Line3 <> '' then
        Add.Address2 := Line2 + ' ' + Line3
      else
        Add.Address2 := Line2;
    end;
    Add.City := Place;
    Add.State := State;
    Add.ZipCode := PostCode;
    { country ? }
    try
      Add.ValidateAddress;
    except
      on e: exception do begin
        result := false;
        Err := TShipperError.Create(e);
        try
          msg := 'Error While Validating Address';
          if Err.ErrorDesc <> '' then
            msg := msg + ': ' +  Err.ErrorDesc;
        finally
          Err.Free;
        end;
        exit;
      end;
    end;
    if Add.MatchCount > 1 then begin
      result := false;
      msg := 'Multiple address matches (' + IntToStr(Add.MatchCount) + ') found';
      if not assigned(list) then begin
        exit;
      end
      else begin
        { return the list of matching address }
        LoadList;
        exit;
      end;
    end;
    if PostCode <> Add.MatchZipCode[0] then begin
      result := false;
      if (Add.MatchZipCode[0] = '') or (Add.MatchZipCode[0] = '-') then
        msg := 'Zip Code not found'
      else
        msg := 'Zip Code does not match for this address - found '+ Add.MatchZipCode[0] + ' that matches the address lines provided';
      if Assigned(list) and (list.A['list'].Count = 0) then LoadList;
    end;
    if not SameText(State, Add.MatchState[0]) then begin
      result := false;
      if msg <> '' then msg := msg + ', ';
      if Add.MatchState[0] = '' then
        msg := msg + 'State is not found'
      else
        msg := msg + 'State does not match - found: '+ Add.MatchState[0];
      if Assigned(list) and (list.A['list'].Count = 0) then LoadList;
    end;
    if not SameText(Place, Add.MatchCity[0]) then begin
      result := false;
      if msg <> '' then msg := msg + ', ';
      if Add.MatchState[0] = '' then
        msg := msg + 'City is not found'
      else
        msg := msg + 'City does not match - found: '+ Add.MatchCity[0];
      if Assigned(list) and (list.A['list'].Count = 0) then LoadList;
    end;
  finally
    if not Assigned(EzAddress) then
      Add.Free;
  end;
end;
*)

function ValidateAddress(var msg: string;
  Line1, Line2, Line3,
  Place, State, PostCode, Country: string;
  list: TJsonObject = nil;
  Shipper: TShipperType = spNone): boolean;
var
  Addr: TObject;
  Err: TShipperError;
  json, fList, FirstMatch: TJsonObject;


  procedure LoadList;
  var
    x: integer;
  begin
    fList.Clear;
    if addr is TibxUPSAddress then begin
      for x := 0 to TibxUPSAddress(addr).MatchCount -1 do begin
        json := JO;
        json.S[Match_Address1] := TibxUPSAddress(addr).MatchAddress1[x];
        json.S[Match_Address2] := TibxUPSAddress(addr).MatchAddress2[x];
        json.S[Match_ChangeType] := ''; //TibxUPSAddress(addr).MatchChangeType[x];
        json.S[Match_City] := TibxUPSAddress(addr).MatchCity[x];
        json.S[Match_Company] := TibxUPSAddress(addr).MatchCompany[x];
        json.S[Match_CountryCode] := TibxUPSAddress(addr).MatchCountryCode[x];
        json.I[Match_MatchPercent] := Trunc(StrToFloatDef(TibxUPSAddress(addr).MatchQuality[x],0) * 100);
        json.S[Match_ResidentialStatus] := TibxUPSAddress(addr).MatchResidentialStatus[x];
        json.S[Match_State] := TibxUPSAddress(addr).MatchState[x];
        json.S[Match_PostCode] := TibxUPSAddress(addr).MatchZipCode[x];
        fList.A['list'].Add(json);
      end;
    end
    else if addr is TibxFedExAddress then begin
      for x := 0 to TibxFedExAddress(addr).MatchCount -1 do begin
        json := JO;
        json.S[Match_Address1] := TibxFedExAddress(addr).MatchAddress1[x];
        json.S[Match_Address2] := TibxFedExAddress(addr).MatchAddress2[x];
        json.S[Match_ChangeType] := TibxFedExAddress(addr).MatchChangeType[x];
        json.S[Match_City] := TibxFedExAddress(addr).MatchCity[x];
        json.S[Match_Company] := TibxFedExAddress(addr).MatchCompany[x];
        json.S[Match_CountryCode] := TibxFedExAddress(addr).MatchCountryCode[x];
        json.I[Match_MatchPercent] := Trunc(StrToFloatDef(TibxFedExAddress(addr).MatchQuality[x],0) * 100);
        json.S[Match_ResidentialStatus] := TibxFedExAddress(addr).MatchResidentialStatus[x];
        json.S[Match_State] := TibxFedExAddress(addr).MatchState[x];
        json.S[Match_PostCode] := TibxFedExAddress(addr).MatchZipCode[x];
        fList.A['list'].Add(json);
      end;
    end
    else if addr is TibxUSPSAddress then begin
      for x := 0 to TibxUSPSAddress(addr).MatchCount -1 do begin
        json := JO;
        json.S[Match_Address1] := TibxUSPSAddress(addr).MatchAddress1[x];
        json.S[Match_Address2] := TibxUSPSAddress(addr).MatchAddress2[x];
        json.S[Match_ChangeType] := ''; //TibxUSPSAddress(addr).MatchChangeType[x];
        json.S[Match_City] := TibxUSPSAddress(addr).MatchCity[x];
        json.S[Match_Company] := TibxUSPSAddress(addr).MatchCompany[x];
        json.S[Match_CountryCode] := TibxUSPSAddress(addr).MatchCountryCode[x];
        json.I[Match_MatchPercent] := 0; //Trunc(StrToFloatDef(TibxUSPSAddress(addr).MatchQuality[x],0) * 100);
        json.S[Match_ResidentialStatus] := ''; //TibxUSPSAddress(addr).MatchResidentialStatus[x];
        json.S[Match_State] := TibxUSPSAddress(addr).MatchState[x];
        json.S[Match_PostCode] := TibxUSPSAddress(addr).MatchZipCode[x];
        fList.A['list'].Add(json);
      end;
    end
  end;

begin
  result := true;
  if Trim(Line1) = '' then begin
    result := false;
    msg := 'Address line 1 is blank, this must contain a value';
    exit;
  end;
  msg:= '';
  if ShipperType = spNone then begin
    result := false;
    msg := 'ERP does not have any shipper (eg UPS / FedEx) configured and/or enabled to validate the address against.';
    exit;
  end;
  Addr := GetAddressComp(msg, Shipper);
  if not Assigned(Addr) then begin
    result := false;
    exit;
  end;
  fList := JO;
  try
    try
      if addr is TibxUPSAddress then begin
        TibxUPSAddress(addr).Address1 := Line1;
        if Line2 <> '' then begin
          if Line3 <> '' then
            TibxUPSAddress(addr).Address2 := Line2 + ' ' + Line3
          else
            TibxUPSAddress(addr).Address2 := Line2;
        end;
        TibxUPSAddress(addr).City := Place;
        TibxUPSAddress(addr).State := State;
        TibxUPSAddress(addr).ZipCode := PostCode;
        if Country <> '' then
          TibxUPSAddress(addr).CountryCode := TCountries.ShortCodeForCountry(Country);

        TibxUPSAddress(addr).ValidateAddress;
      end
      else if addr is TibxFedExAddress then begin
        TibxFedExAddress(addr).Address1 := Line1;
        if Line2 <> '' then begin
          if Line3 <> '' then
            TibxFedExAddress(addr).Address2 := Line2 + ' ' + Line3
          else
            TibxFedExAddress(addr).Address2 := Line2;
        end;
        TibxFedExAddress(addr).City := Place;
        TibxFedExAddress(addr).State := State;
        TibxFedExAddress(addr).ZipCode := PostCode;
        if Country <> '' then
          TibxFedExAddress(addr).CountryCode := TCountries.ShortCodeForCountry(Country);

        TibxFedExAddress(addr).ValidateAddress;
      end
      else if addr is TibxUSPSAddress then begin
        TibxUSPSAddress(addr).Address1 := Line1;
        if Line2 <> '' then begin
          if Line3 <> '' then
            TibxUSPSAddress(addr).Address2 := Line2 + ' ' + Line3
          else
            TibxUSPSAddress(addr).Address2 := Line2;
        end;
        TibxUSPSAddress(addr).City := Place;
        TibxUSPSAddress(addr).State := State;
        TibxUSPSAddress(addr).ZipCode := PostCode;
        //if Country <> '' then
        //  TibxUSPSAddress(addr).CountryCode := TCountries.ShortCodeForCountry(Country);

        TibxUSPSAddress(addr).ValidateAddress;
      end
    except
      on e: exception do begin
        result := false;
        Err := TShipperError.Create(e);
        try
          msg := 'Error While Validating Address';
          if Err.ErrorDesc <> '' then
            msg := msg + ': ' +  Err.ErrorDesc;
        finally
          Err.Free;
        end;
        exit;
      end;
    end;

    LoadList;

    if fList.A['list'].Count > 1 then begin
      result := false;
      msg := 'Multiple address matches (' + IntToStr(fList.A['list'].Count) + ') found';
      if not assigned(list) then begin
        exit;
      end
      else begin
        { return the list of matching address }
        list.Assign(fList);
        exit;
      end;
    end
    else if fList.A['list'].Count = 0 then begin
      result := false;
      msg := 'Address not found';
      exit;
    end;
    FirstMatch := fList.A['list'][0].AsObject;
    if PostCode <> FirstMatch.S[Match_PostCode] then begin
      result := false;
      if (FirstMatch.S[Match_PostCode] = '') or (FirstMatch.S[Match_PostCode] = '-') then
        msg := 'Zip Code not found'
      else
        msg := 'Zip Code does not match for this address - found '+ FirstMatch.S[Match_PostCode] + ' that matches the address lines provided';
      if Assigned(list) and (list.A['list'].Count = 0) then LoadList;
    end;
    if not SameText(State, FirstMatch.S[Match_State]) then begin
      result := false;
      if msg <> '' then msg := msg + ', ';
      if FirstMatch.S[Match_State] = '' then
        msg := msg + 'State is not found'
      else
        msg := msg + 'State does not match - found: '+ FirstMatch.S[Match_State];
      if Assigned(list) and (list.A['list'].Count = 0) then LoadList;
    end;
    if not SameText(Place, FirstMatch.S[Match_City]) then begin
      result := false;
      if msg <> '' then msg := msg + ', ';
      if FirstMatch.S[Match_City] = '' then
        msg := msg + 'City is not found'
      else
        msg := msg + 'City does not match - found: '+ FirstMatch.S[Match_City];
      if Assigned(list) and (list.A['list'].Count = 0) then LoadList;
    end;
  finally
    addr.Free;
    fList.Free;
  end;
end;

function ValidateAddress(Line1, Line2, Line3,
  Place, State, PostCode, Country: string; list: TJsonObject = nil): boolean; overload;
var
  Dlg: TProgressDialog;
  msg: string;
begin
  Dlg := TProgressDialog.Create(nil);
  try
    Dlg.Caption := 'Validating Address';
    Dlg.Message := 'Please wait ..';
    Dlg.MaxValue := 15;
    Dlg.TimerUpdate := true;
    Dlg.Execute;
    result := ValidateAddress(msg, Line1, Line2, Line3, Place, State, PostCode, Country, list);
  finally
    Dlg.Free;
  end;
  if result then
    CommonLib.MessageDlgXP_Vista('Address is valid ' + msg, mtInformation, [mbOk], 0)
  else begin
    if (not Assigned(list)) {or (list.A['list'].Count < 2)} then
      CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOk], 0);
  end;
end;

procedure CheckShippingMethods(aShipperType: TShipperType; Options: TShipServiceOptionSet);
var
  Meth: TShippingMethod;
  x: integer;
  UserAllowed: boolean;

  function CheckAddMethodWithUser: boolean;
  begin
    if not UserAllowed then
      UserAllowed := CommonLib.MessageDlgXP_Vista('One or more Shipping Methods for this shipper are missing from your Shipping Method List, would you like these Methods automatically added?',mtConfirmation,[mbYes,mbNo],0) = mrYes;
    result := UserAllowed;
  end;

begin
  UserAllowed := false;
  Meth := TShippingMethod.Create(nil, CommonDbLib.GetSharedMyDacConnection);
  try
    case aShipperType of
      spNone:;
      spUPS:
        begin
          for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do begin
            if (ppUPS in ShipServiceTypeList[x].Providers) and
              ((Options = []) or (Options <= ShipServiceTypeList[x].Options)) then begin

              Meth.LoadSelect('ShippingMethod = ' + QuotedStr(ShipServiceTypeList[x].Name));
              if Meth.Count = 0 then begin
                if not CheckAddMethodWithUser then exit;
                Meth.New;
                Meth.ShippingMethod := ShipServiceTypeList[x].Name;
                Meth.Active := true;
                Meth.Save;
              end;
            end;
          end;
        end;
      spFedEx:
        begin
          for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do begin
            if (ppFedEx in ShipServiceTypeList[x].Providers) and
              ((Options = []) or (Options <= ShipServiceTypeList[x].Options)) then begin

              Meth.LoadSelect('ShippingMethod = ' + QuotedStr(ShipServiceTypeList[x].Name));
              if Meth.Count = 0 then begin
                if not CheckAddMethodWithUser then exit;
                Meth.New;
                Meth.ShippingMethod := ShipServiceTypeList[x].Name;
                Meth.Active := true;
                Meth.Save;
              end;
            end;
          end;
        end;
      spUSPS:
        begin
          for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do begin
            if (ppUSPS in ShipServiceTypeList[x].Providers) and
              ((Options = []) or (Options <= ShipServiceTypeList[x].Options)) then begin

              Meth.LoadSelect('ShippingMethod = ' + QuotedStr(ShipServiceTypeList[x].Name));
              if Meth.Count = 0 then begin
                if not CheckAddMethodWithUser then exit;
                Meth.New;
                Meth.ShippingMethod := ShipServiceTypeList[x].Name;
                Meth.Active := true;
                Meth.Save;
              end;
            end;
          end;
        end;
      spTNT:
        begin
          Meth.LoadSelect('ShippingMethod = ' + QuotedStr(Ship_TNT));
          if Meth.Count = 0 then begin
            if not CheckAddMethodWithUser then exit;
            Meth.New;
            Meth.ShippingMethod := Ship_TNT;
            Meth.Active := true;
            Meth.Save;
          end;
        end;
    end;
  finally
    Meth.Free;
  end;
end;

function DefaultPackageType(Provider: TibxezshipProviders): TibxezshipPackageTypes;
begin
  result := ptNone;
  case Provider of
    pFedEx:
      begin
        if AppEnv.CompanyPrefs.FedExConfig.DefaultPackage <> '' then
          result := StrToPackageType(AppEnv.CompanyPrefs.FedexConfig.DefaultPackage, ppFedEx);
      end;
    pUPS:
      begin
        if AppEnv.CompanyPrefs.UPSConfig.DefaultPackage <> '' then
          result := StrToPackageType(AppEnv.CompanyPrefs.UPSConfig.DefaultPackage, ppUPS);
      end;
    pUSPS:
      begin
        if AppEnv.CompanyPrefs.USPSConfig.DefaultPackage <> '' then
          result := StrToPackageType(AppEnv.CompanyPrefs.USPSConfig.DefaultPackage, ppUSPS);
      end;
    pCanadaPost: ;
  end;

end;

function StrToAlphaNumeric(const s: string; aLength: integer): string;
var
  x: integer;
begin
  result := '';
  for x := 1 to Length(s) do begin
    if TCharacter.IsLetterOrDigit(s[x]) then begin
      result := result + s[x];
      if Length(result) >= aLength then
        exit;
    end;
  end;
end;


end.
