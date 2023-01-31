unit AddressUtils;

interface

  function ValidateAddress(var msg: string;
    Line1, Line2, Line3,
    Place, State, PostCode, Country: string): boolean; overload;
  function ValidateAddress(Line1, Line2, Line3,
    Place, State, PostCode, Country: string): boolean; overload;

implementation

uses
  AppEnvironment, ibxEzAddress, sysutils, ShipIntegrationUtils, ProgressDialog,
  CommonLib, Dialogs;

function ValidateAddress(var msg: string;
  Line1, Line2, Line3,
  Place, State, PostCode, Country: string): boolean;
var
  shipper: string;
  Add: TibxEzAddress;
  Err: TShipperError;
begin
  result := true;
  if Trim(Line1) = '' then begin
    result := false;
    msg := 'Address line 1 is blank, this must contain a value';
    exit;
  end;
  msg:= '';
  shipper := '';
  if AppEnv.CompanyPrefs.UPSConfig.UPSEnabled then
    shipper := 'UPS';

  if shipper = '' then begin
    result := false;
    msg := 'ERP does not have any shipper (eg UPS / FedEx) configured and/or enabled to validate the address against.';
    exit;
  end;
  Add := TibxEzAddress.Create(nil);
  try
    if shipper = 'UPS' then begin
      { UPS specific stuff }
      Add.Provider := pUPS;
      { set up auth stuff }
      Add.AccessKey := AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey;
      Add.AccountNumber := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;
      Add.UserId := AppEnv.CompanyPrefs.UPSConfig.UPSUserID;
      Add.Password := AppEnv.CompanyPrefs.UPSConfig.UPSPassword;
      Add.Server := AppEnv.CompanyPrefs.UPSConfig.UPSServer + '/XAV';
    end;
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
          msg := 'Error validating address';
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
      exit;
    end;
    if PostCode <> Add.MatchZipCode[0] then begin
      result := false;
      if (Add.MatchZipCode[0] = '') or (Add.MatchZipCode[0] = '-') then
        msg := 'Zip Code not found'
      else
        msg := 'Zip Code does not match for this address - found '+ Add.MatchZipCode[0] + ' that matches the address lines provided';
    end;
    if not SameText(State, Add.MatchState[0]) then begin
      result := false;
      if msg <> '' then msg := msg + ', ';
      if Add.MatchState[0] = '' then
        msg := msg + 'State is not found'
      else
        msg := msg + 'State does not match - found: '+ Add.MatchState[0];
    end;
    if not SameText(Place, Add.MatchCity[0]) then begin
      result := false;
      if msg <> '' then msg := msg + ', ';
      if Add.MatchState[0] = '' then
        msg := msg + 'City is not found'
      else
        msg := msg + 'City does not match - found: '+ Add.MatchCity[0];
    end;
  finally
    Add.Free;
  end;
end;

function ValidateAddress(Line1, Line2, Line3,
  Place, State, PostCode, Country: string): boolean; overload;
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
    result := ValidateAddress(msg, Line1, Line2, Line3, Place, State, PostCode, Country);
  finally
    Dlg.Free;
  end;
  if result then
    CommonLib.MessageDlgXP_Vista('Address is valid ' + msg, mtInformation, [mbOk], 0)
  else
    CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOk], 0);
end;


end.
