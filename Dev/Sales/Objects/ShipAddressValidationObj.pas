unit ShipAddressValidationObj;

interface
{$I ERP.inc}

uses
  ibxezaddress, JsonObject, ShipIntegrationTypes,
  ConTnrs, ibxuspsship;

type
  ShippingProviderSet = set of TibxezaddressProviders;
  //ShippingPostageProviderSet = set of ibxuspsship.TibxuspsshipPostageProviders;

  TShipAddressValidation = class(TObject)
  private
    fAllowUserSelect: boolean;
    fAddress: TAddress;
    fProviders: ShippingProviderSet; //TibxezaddressProviders;
    fPostageProviders: TibxuspsshipPostageProviders;
    fErrMessage: string;
    json: TJsonObject;
    function DoValidate(AddressValidator: TObject): boolean;
    function DoUserValidate(AddressValidatorList: TObjectList): boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property Address: TAddress read fAddress write fAddress;
    property Providers: ShippingProviderSet read fProviders write fProviders; //TibxezaddressProviders read fProvider write fProvider;
    property PostageProviders: TibxuspsshipPostageProviders read fPostageProviders write fPostageProviders; //TibxezaddressProviders read fProvider write fProvider;
    function ValidateAddress: boolean;
    property AllowUserSelect: boolean read fAllowUserSelect write fAllowUserSelect;
    property ErrMessage: string read fErrMessage write fErrMessage;
  end;

implementation

uses
  SysUtils, AppEnvironment, frmShipAddressValidateSelect, ibxupsaddress, classes,
  BusObjCountries, ProgressDialog, ibxFedExAddress, ibxUSPSAddress, tcConst , ibxuspsshipintl,
  IntegrationPrefsLib;

{ TShipAddressValidation }

constructor TShipAddressValidation.Create;
begin
  { set defaults }
  //fProvider := pFedEx;
  fProviders := [pFedEx];
  fPostageProviders := TibxuspsshipPostageProviders(ppNone);
  fAllowUserSelect := true;
  fErrMessage := '';
  json := JO;
  fAddress := TAddress.Create;
end;

destructor TShipAddressValidation.Destroy;
begin
  json.Free;
  fAddress.Free;
  inherited;
end;

function TShipAddressValidation.DoUserValidate(
  AddressValidatorList: TObjectList): boolean;
var
  AddressValidator: TObject;
  I: integer;
begin
  self.fErrMessage := '';
  for I := 0 to AddressValidatorList.Count -1 do begin
    AddressValidator := AddressValidatorList[I];
    repeat
      result := DoValidate(AddressValidator);
      if not result then begin
        if not AllowUserSelect then break;
        if json.A['list'].count = 0 then break;
        { this will show list of matching address to user, allow them to select one
          and update the Address object }
        if not TfmShipAddressValidateSelect.SelectCorrectAddress(fAddress,json) then
          break;
      end;
    until result;

    if result then
      exit;
  end;
end;

function TShipAddressValidation.DoValidate(AddressValidator: TObject): boolean;
var
  Err: TShipperError;
  mCount: integer;
  mAddress1: string;
  mAddress2: string;
  mCity: string;
  mState: string;
  mPostCode: string;
  mCountryCode: string;
  mCompany: string;
  dlg: TProgressDialog;
  s: string;

  procedure LoadList;
  var
    x: integer;
    item: TJsonObject;
  begin
    if AddressValidator is TibxUPSAddress then begin
      for x := 0 to TibxUPSAddress(AddressValidator).MatchCount -1 do begin
        item := JO;
        item.S[Match_Address1] := TibxUPSAddress(AddressValidator).MatchAddress1[x];
        item.S[Match_Address2] := TibxUPSAddress(AddressValidator).MatchAddress2[x];
        //item.S[Match_ChangeType] := TibxUPSAddress(AddressValidator).MatchChangeType[x];
        item.S[Match_City] := TibxUPSAddress(AddressValidator).MatchCity[x];
        item.S[Match_Company] := TibxUPSAddress(AddressValidator).MatchCompany[x];
        item.S[Match_CountryCode] := TibxUPSAddress(AddressValidator).MatchCountryCode[x];
        if item.S[Match_CountryCode] <> '' then
          item.S[Match_Country] := BusObjCountries.TCountries.CountryForShortCode(item.S[Match_CountryCode]);
        item.I[Match_MatchPercent] := Trunc(StrToFloatDef(TibxUPSAddress(AddressValidator).MatchQuality[x],0) * 100);
        item.S[Match_ResidentialStatus] := TibxUPSAddress(AddressValidator).MatchResidentialStatus[x];
        item.S[Match_State] := TibxUPSAddress(AddressValidator).MatchState[x];
        item.S[Match_PostCode] := TibxUPSAddress(AddressValidator).MatchZipCode[x];
        json.A['list'].Add(item);
      end;
    end
    else if AddressValidator is TibxFedExAddress then begin
      for x := 0 to TibxFedExAddress(AddressValidator).MatchCount -1 do begin
        item := JO;
        item.S[Match_Address1] := TibxFedExAddress(AddressValidator).MatchAddress1[x];
        item.S[Match_Address2] := TibxFedExAddress(AddressValidator).MatchAddress2[x];
        //item.S[Match_ChangeType] := TibxUPSAddress(AddressValidator).MatchChangeType[x];
        item.S[Match_City] := TibxFedExAddress(AddressValidator).MatchCity[x];
        item.S[Match_Company] := TibxFedExAddress(AddressValidator).MatchCompany[x];
        item.S[Match_CountryCode] := TibxFedExAddress(AddressValidator).MatchCountryCode[x];
        if item.S[Match_CountryCode] <> '' then
          item.S[Match_Country] := BusObjCountries.TCountries.CountryForShortCode(item.S[Match_CountryCode]);
        item.I[Match_MatchPercent] := Trunc(StrToFloatDef(TibxFedExAddress(AddressValidator).MatchQuality[x],0) * 100);
        item.S[Match_ResidentialStatus] := TibxFedExAddress(AddressValidator).MatchResidentialStatus[x];
        item.S[Match_State] := TibxFedExAddress(AddressValidator).MatchState[x];
        item.S[Match_PostCode] := TibxFedExAddress(AddressValidator).MatchZipCode[x];
        json.A['list'].Add(item);
      end;
    end
    else if AddressValidator is TibxUSPSAddress then begin
      for x := 0 to TibxUSPSAddress(AddressValidator).MatchCount -1 do begin
        item := JO;
        item.S[Match_Address1] := TibxUSPSAddress(AddressValidator).MatchAddress1[x];
        item.S[Match_Address2] := TibxUSPSAddress(AddressValidator).MatchAddress2[x];
        //item.S[Match_ChangeType] := TibxUPSAddress(AddressValidator).MatchChangeType[x];
        item.S[Match_City] := TibxUSPSAddress(AddressValidator).MatchCity[x];
        item.S[Match_Company] := TibxUSPSAddress(AddressValidator).MatchCompany[x];
        item.S[Match_CountryCode] := TibxUSPSAddress(AddressValidator).MatchCountryCode[x];
        if item.S[Match_CountryCode] <> '' then
          item.S[Match_Country] := BusObjCountries.TCountries.CountryForShortCode(item.S[Match_CountryCode]);
//        item.I[Match_MatchPercent] := Trunc(StrToFloatDef(TibxUSPSAddress(AddressValidator).MatchQuality[x],0) * 100);
//        item.S[Match_ResidentialStatus] := TibxUSPSAddress(AddressValidator).MatchResidentialStatus[x];
        item.S[Match_State] := TibxUSPSAddress(AddressValidator).MatchState[x];
        item.S[Match_PostCode] := TibxUSPSAddress(AddressValidator).MatchZipCode[x];
        json.A['list'].Add(item);
      end;
    end;
  end;

begin
  json.Clear;
  result := true;
//  fErrMessage := '';
  if AddressValidator is TibxUPSAddress then begin
    TibxUPSAddress(AddressValidator).Address1 := Address.AddressLine1;
    if Address.AddressLine2 <> '' then begin
      if Address.AddressLine3 <> '' then
        TibxUPSAddress(AddressValidator).Address2 := Address.AddressLine2 + ' ' + Address.AddressLine3
      else
        TibxUPSAddress(AddressValidator).Address2 := Address.AddressLine2;
    end;
    TibxUPSAddress(AddressValidator).City := Address.City;
    TibxUPSAddress(AddressValidator).State := Address.State;
    TibxUPSAddress(AddressValidator).ZipCode := Address.PostCode;
    if Address.CountryCode <> '' then
      TibxUPSAddress(AddressValidator).CountryCode := TCountries.ShortCodeForCountry(Address.CountryCode)
    else begin
      if Address.Country <> '' then
        TibxUPSAddress(AddressValidator).CountryCode :=
          TCountries.ShortCodeForCountry(Address.Country);
    end;
  end
  else if AddressValidator is TibxFedExAddress then begin
    TibxFedExAddress(AddressValidator).Address1 := Address.AddressLine1;
    if Address.AddressLine2 <> '' then begin
      if Address.AddressLine3 <> '' then
        TibxFedExAddress(AddressValidator).Address2 := Address.AddressLine2 + ' ' + Address.AddressLine3
      else
        TibxFedExAddress(AddressValidator).Address2 := Address.AddressLine2;
    end;
    TibxFedExAddress(AddressValidator).City := Address.City;
    TibxFedExAddress(AddressValidator).State := Address.State;
    TibxFedExAddress(AddressValidator).ZipCode := Address.PostCode;
    if Address.CountryCode <> '' then
      TibxFedExAddress(AddressValidator).CountryCode := TCountries.ShortCodeForCountry(Address.CountryCode)
    else begin
      if Address.Country <> '' then
        TibxFedExAddress(AddressValidator).CountryCode :=
          TCountries.ShortCodeForCountry(Address.Country);
    end;
  end
  else if AddressValidator is TibxUSPSAddress then begin

    TibxUSPSAddress(AddressValidator).Address1 := Address.AddressLine1;
    if Address.AddressLine2 <> '' then begin
      if Address.AddressLine3 <> '' then
        TibxUSPSAddress(AddressValidator).Address2 := Address.AddressLine2 + ' ' + Address.AddressLine3
      else
        TibxUSPSAddress(AddressValidator).Address2 := Address.AddressLine2;
    end;
    TibxUSPSAddress(AddressValidator).City := Address.City;
    TibxUSPSAddress(AddressValidator).State := Address.State;
    TibxUSPSAddress(AddressValidator).ZipCode := Address.PostCode;
//    if Address.CountryCode <> '' then
//      TibxUSPSAddress(AddressValidator).CountryCode := Address.CountryCode
//    else begin
//      if Address.Country <> '' then
//        TibxUSPSAddress(AddressValidator).CountryCode :=
//          TCountries.ShortCodeForCountry(Address.Country);
//    end;
  end;

  try
    dlg := TProgressDialog.Create(nil);
    try
      dlg.Caption := 'Checking Address';
      dlg.MaxValue := 5;
      dlg.Step := 1;
      dlg.TimerUpdate := true;
      dlg.Execute;
      if AddressValidator is TibxUPSAddress then
        TibxUPSAddress(AddressValidator).ValidateAddress
      else if AddressValidator is TibxFedExAddress then
        TibxFedExAddress(AddressValidator).ValidateAddress
      else if AddressValidator is TibxUSPSAddress then
        TibxUSPSAddress(AddressValidator).ValidateAddress;
      FreeAndNil(dlg);
    except
      on e: exception do begin
        FreeAndNil(dlg);
        result := false;
        Err := TShipperError.Create(e);
        try
//          fErrMessage := '';//fErrMessage := 'Error While Validating Address From ';
          if Err.ErrorDesc <> '' then
//            if AddressValidator is TibxUPSAddress then
//              fErrMessage := ErrMessage + 'UPS Server: ' +  Quotedstr(Err.ErrorDesc)
//            else if AddressValidator is TibxFedExAddress then
//              fErrMessage := ErrMessage + 'FedEx Server: ' +  Quotedstr(Err.ErrorDesc)
//            else if AddressValidator is TibxUSPSAddress then
//              fErrMessage := ErrMessage + 'USPS Server: ' +  Quotedstr(Err.ErrorDesc)
//            else
//              fErrMessage := ErrMessage + '[Unknown] Address Validating Server: ' +  Quotedstr(Err.ErrorDesc);
//            fErrMessage := Trim(fErrMessage);
            if AddressValidator is TibxUPSAddress then
              s := 'UPS Server: ' +  Quotedstr(Err.ErrorDesc)
            else if AddressValidator is TibxFedExAddress then
              s := 'FedEx Server: ' +  Quotedstr(Err.ErrorDesc)
            else if AddressValidator is TibxUSPSAddress then
              s := 'USPS Server: ' +  Quotedstr(Err.ErrorDesc)
            else
              s := '[Unknown] Address Validating Server: ' +  Quotedstr(Err.ErrorDesc);
            if fErrMessage <> '' then fErrMessage := fErrMessage + #13#10;
            fErrMessage := fErrMessage + Trim(s);
        finally
          Err.Free;
        end;
        exit;
      end;
    end;
  finally
    FreeAndNil(dlg);
  end;


//  mCount := 0;
  mAddress1 := '';
  mAddress2 := '';
  mCity := '';
  mState := '';
  mPostCode := '';
  mCompany := '';
  mCountryCode := '';

  if AddressValidator is TibxUPSAddress then begin
    mCount := TibxUPSAddress(AddressValidator).MatchCount;
    mAddress1 := TibxUPSAddress(AddressValidator).MatchAddress1[0];
    mAddress2 := TibxUPSAddress(AddressValidator).MatchAddress2[0];
    mCity := TibxUPSAddress(AddressValidator).MatchCity[0];
    mState := TibxUPSAddress(AddressValidator).MatchState[0];
    mPostCode := TibxUPSAddress(AddressValidator).MatchZipCode[0];
    mCompany := TibxUPSAddress(AddressValidator).MatchCompany[0];
    mCountryCode := TibxUPSAddress(AddressValidator).MatchCountryCode[0];
  end
  else if AddressValidator is TibxFedExAddress then begin
    mCount := TibxFedExAddress(AddressValidator).MatchCount;
    mAddress1 := TibxFedExAddress(AddressValidator).MatchAddress1[0];
    mAddress2 := TibxFedExAddress(AddressValidator).MatchAddress2[0];
    mCity := TibxFedExAddress(AddressValidator).MatchCity[0];
    mState := TibxFedExAddress(AddressValidator).MatchState[0];
    mPostCode := TibxFedExAddress(AddressValidator).MatchZipCode[0];
    mCompany := TibxFedExAddress(AddressValidator).MatchCompany[0];
    mCountryCode := TibxFedExAddress(AddressValidator).MatchCountryCode[0];
  end
  else if AddressValidator is TibxUSPSAddress then begin
    mCount := TibxUSPSAddress(AddressValidator).MatchCount;
    if mCount > 0 then begin
      mAddress1 := TibxUSPSAddress(AddressValidator).MatchAddress1[0];
      mAddress2 := TibxUSPSAddress(AddressValidator).MatchAddress2[0];
      mCity := TibxUSPSAddress(AddressValidator).MatchCity[0];
      mState := TibxUSPSAddress(AddressValidator).MatchState[0];
      mPostCode := TibxUSPSAddress(AddressValidator).MatchZipCode[0];
      mCompany := TibxUSPSAddress(AddressValidator).MatchCompany[0];
      mCountryCode := TibxUSPSAddress(AddressValidator).MatchCountryCode[0];
    end;
  end
  else
    exit;


  if (mCount > 1) then begin
    result := false;
    if fErrMessage <> '' then fErrMessage := fErrMessage + #13#10;
    fErrMessage :=  fErrMessage + 'Multiple address matches (' + IntToStr(mCount) + ') found';
    if AllowUserSelect then
      LoadList;
    exit;
  end;
  if Address.PostCode <> mPostCode then begin
    result := false;
    if (mPostCode = '') or (mPostCode = '-') then begin
      if fErrMessage <> '' then fErrMessage := fErrMessage + #13#10;
      fErrMessage := fErrMessage + 'Zip Code not found';
    end
    else begin
      if fErrMessage <> '' then fErrMessage := fErrMessage + #13#10;
      fErrMessage := fErrMessage + 'Zip Code does not match for this address - found '+ mPostCode + ' that matches the address lines provided';
    end;
    if (json.A['list'].Count = 0) then LoadList;
  end;
  if not SameText(Address.State, mState) then begin
    result := false;
    if fErrMessage <> '' then fErrMessage := fErrMessage + #13#10;
    if mState = '' then
      fErrMessage := fErrMessage + 'State is not found'
    else
      fErrMessage := fErrMessage + 'State does not match - found: '+ mState;
    if (json.A['list'].Count = 0) then LoadList;
  end;
  if not SameText(Address.City, mCity) then begin
    result := false;
    if fErrMessage <> '' then fErrMessage := fErrMessage + #13#10;
    if mCity = '' then
      fErrMessage := fErrMessage + 'City is not found'
    else
      fErrMessage := fErrMessage + 'City does not match - found: '+ mCity;
    if (json.A['list'].Count = 0) then LoadList;
  end;
  if (mCountryCode <> '') and (not SameText(Address.CountryCode, mCountryCode)) then begin
    if (Address.CountryCode <> '') then begin
      result := false;
      if fErrMessage <> '' then fErrMessage := fErrMessage + #13#10;
      fErrMessage := fErrMessage + 'Country Code does not match - found: '+ mCountryCode;
      if (json.A['list'].Count = 0) then LoadList;
    end
  end;

end;

function TShipAddressValidation.ValidateAddress: boolean;
var
  AddressValidator: TObject;
  AddressValidatorList: TObjectList;
begin
  fErrMessage := '';
  AddressValidator := nil;
  result := false;
  if Trim(Address.AddressLine1) = '' then begin
    fErrMessage := 'Address line 1 is blank, this must contain a value';
    exit;
  end;
  if Trim(Address.City) = '' then begin
    fErrMessage := 'Address City/Place is blank, this must contain a value';
    exit;
  end;
//  if Trim(Address.State) = '' then begin
//    fErrMessage := 'Address State is blank, this must contain a value';
//    exit;
//  end;
  if Trim(Address.PostCode) = '' then begin
    fErrMessage := 'Address Zip/Post Code is blank, this must contain a value';
    exit;
  end;
  if (Trim(Address.Country) = '') and (Trim(Address.CountryCode) = '') then begin
    fErrMessage := 'Address Country is blank, this must contain a value';
    exit;
  end;
  if (Trim(Address.Country) <> '') and (Trim(Address.CountryCode) = '') then begin
    if Length(Trim(Address.Country)) = 2 then
      Address.CountryCode := Trim(Address.Country)
    else
      Address.CountryCode := BusObjCountries.TCountries.ShortCodeForCountry(Trim(Address.Country));
  end;
  if Trim(Address.CountryCode) = '' then begin
    fErrMessage := 'Unable to find Country Code for Country "' + Address.Country + '".';
    exit;
  end;

//  EzAddress := TibxEzAddress.Create(nil);
  AddressValidatorList := TObjectList.Create;
  try
    (*
    case fProvider of
      pFedEx:
        begin
          AddressValidator := TibxFedExAddress.Create(nil);
          TibxFedExAddress(AddressValidator).FedExDeveloperKey := AppEnv.CompanyPrefs.FedExConfig.AccessKey;
          TibxFedExAddress(AddressValidator).FedExAccountNumber := AppEnv.CompanyPrefs.FedExConfig.AccountNumber;
          TibxFedExAddress(AddressValidator).FedExMeterNumber := AppEnv.CompanyPrefs.FedExConfig.MeterNumber;
          TibxFedExAddress(AddressValidator).FedExPassword := AppEnv.CompanyPrefs.FedExConfig.Password;
          TibxFedExAddress(AddressValidator).FedExServer := AppEnv.CompanyPrefs.FedExConfig.Server;
        end;
      pUPS:
        begin
          AddressValidator := TibxUPSAddress.Create(nil);
          //EzAddress.Provider := fProvider;
          { use TLS 1.2 }
          TibxUPSAddress(AddressValidator).Config('SSLEnabledProtocols=3072');
          TibxUPSAddress(AddressValidator).UPSAccessKey := AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey;
          TibxUPSAddress(AddressValidator).UPSAccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;
          TibxUPSAddress(AddressValidator).UPSUserId := AppEnv.CompanyPrefs.UPSConfig.UPSUserID;
          TibxUPSAddress(AddressValidator).UPSPassword := AppEnv.CompanyPrefs.UPSConfig.UPSPassword;
          TibxUPSAddress(AddressValidator).UPSServer := AppEnv.CompanyPrefs.UPSConfig.UPSServer + '/XAV';
        end;
      pUSPS:
        begin
          AddressValidator := TibxUSPSAddress.Create(nil);
          TibxUSPSAddress(AddressValidator).USPSUserId := AppEnv.CompanyPrefs.USPSConfig.USPSUserID;
          TibxUSPSAddress(AddressValidator).USPSPassword := AppEnv.CompanyPrefs.USPSConfig.USPSPassword;
          TibxUSPSAddress(AddressValidator).USPSServer := AppEnv.CompanyPrefs.USPSConfig.ShipServer;
          TibxUSPSAddress(AddressValidator).USPSAccountNumber := AppEnv.CompanyPrefs.USPSConfig.USPSAccountNumber;
        end;
      pCanadaPost:
        begin
          fErrMessage := 'Canada Post not supported.';
          exit;
        end;
    end;
    *)

    if pFedEx in self.Providers then begin
      result := AppEnv.CompanyPrefs.FedExConfig.Validate(fErrMessage);
      if not result then exit;

      AddressValidator := TibxFedExAddress.Create(nil);
      TibxFedExAddress(AddressValidator).FedExDeveloperKey := AppEnv.CompanyPrefs.FedExConfig.AccessKey;
      TibxFedExAddress(AddressValidator).FedExAccountNumber := AppEnv.CompanyPrefs.FedExConfig.AccountNumber;
      TibxFedExAddress(AddressValidator).FedExMeterNumber := AppEnv.CompanyPrefs.FedExConfig.MeterNumber;
      TibxFedExAddress(AddressValidator).FedExPassword := AppEnv.CompanyPrefs.FedExConfig.Password;
      TibxFedExAddress(AddressValidator).FedExServer := AppEnv.CompanyPrefs.FedExConfig.Server;
      AddressValidatorList.Add(AddressValidator);
    end;
    if pUPS in self.Providers then begin
      result := AppEnv.CompanyPrefs.UPSConfig.Validate(fErrMessage);
      if not result then exit;

      AddressValidator := TibxUPSAddress.Create(nil);
      //EzAddress.Provider := fProvider;
      { use TLS 1.2 }
      TibxUPSAddress(AddressValidator).Config('SSLEnabledProtocols=3072');
      TibxUPSAddress(AddressValidator).UPSAccessKey := AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey;
      TibxUPSAddress(AddressValidator).UPSAccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;
      TibxUPSAddress(AddressValidator).UPSUserId := AppEnv.CompanyPrefs.UPSConfig.UPSUserID;
      TibxUPSAddress(AddressValidator).UPSPassword := AppEnv.CompanyPrefs.UPSConfig.UPSPassword;
      if AppEnv.CompanyPrefs.UPSConfig.TestMode then
        TibxUPSAddress(AddressValidator).UPSServer := AppEnv.CompanyPrefs.UPSConfig.TestURL + '/XAV'
      else
        TibxUPSAddress(AddressValidator).UPSServer := AppEnv.CompanyPrefs.UPSConfig.UPSServer + '/XAV';
      AddressValidatorList.Add(AddressValidator);
    end;
    if pUSPS in self.Providers then begin
      result := AppEnv.CompanyPrefs.USPSConfig.Validate(fErrMessage ,self.PostageProviders );

      if not result then exit;

      AddressValidator := TibxUSPSAddress.Create(nil);
      TibxUSPSAddress(AddressValidator).USPSUserId    := AppEnv.CompanyPrefs.USPSConfig.USPSUserID;
      TibxUSPSAddress(AddressValidator).USPSPassword  := AppEnv.CompanyPrefs.USPSConfig.USPSPassword;
      TibxUSPSAddress(AddressValidator).USPSServer    := AppEnv.CompanyPrefs.USPSConfig.ShipServer;
      TibxUSPSAddress(AddressValidator).USPSAccountNumber := AppEnv.CompanyPrefs.USPSConfig.USPSAccountNumber;

      if AppEnv.CompanyPrefs.USPSConfig.USPSUserID ='' then begin
        TibxUSPSAddress(AddressValidator).USPSUserId    := TestUSPSUserID;
        TibxUSPSAddress(AddressValidator).USPSPassword  := TestUSPSPassword;
        TibxUSPSAddress(AddressValidator).USPSServer    := TestShipServer;
      end;

      AddressValidatorList.Add(AddressValidator);
    end;


    if not DoUserValidate(AddressValidatorList) then begin
      Result := False;
      exit;
    end;

  finally
    //AddressValidator.Free;
    AddressValidatorList.Free;
  end;
  result := true;
end;

end.
