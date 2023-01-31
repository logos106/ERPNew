unit UPSConfigObj;

interface

uses
  JsonDbPrefsConfigObj, MyAccess;

type

  TUPSConfig = class(TJsonDbPefConfig)
  private
    function GetUPSAccessKey: string;
    function GetUPSAccountNumber: string;
    function GetUPSEnabled: boolean;
    function GetUPSPassword: string;
    function GetUPSServer: string;
    function GetUPSUserID: string;
    procedure SetUPSAccessKey(const Value: string);
    procedure SetUPSAccountNumber(const Value: string);
    procedure SetUPSEnabled(const Value: boolean);
    procedure SetUPSPassword(const Value: string);
    procedure SetUPSServer(const Value: string);
    procedure SetUPSUserID(const Value: string);
    function GetDefaultService: string;
    procedure SetDefaultService(const Value: string);
    function GetDefaultPackage: string;
    procedure SetDefaultPackage(const Value: string);
    function GetDefaultWeight: double;
    procedure SetDefaultWeight(const Value: double);
    function GetLastServerID: string;
    procedure SetLastServerID(const Value: string);
    function GetDefaultHeight: double;
    function GetDefaultLength: double;
    function GetDefaultWidth: double;
    procedure SetDefaultHeight(const Value: double);
    procedure SetDefaultLength(const Value: double);
    procedure SetDefaultWidth(const Value: double);
    function GetTestMode: boolean;
    procedure SetTestMode(const Value: boolean);
    function GetTestURL: string;
  public
    procedure Load(connection: TMyConnection); override;
    property UPSEnabled: boolean read GetUPSEnabled write SetUPSEnabled;
    property UPSAccessKey: string read GetUPSAccessKey write SetUPSAccessKey;
    property UPSPassword: string  read GetUPSPassword write SetUPSPassword;
    property UPSAccountNumber: string read GetUPSAccountNumber write SetUPSAccountNumber;
    property UPSUserID: string read GetUPSUserID write SetUPSUserID;
    property UPSServer: string read GetUPSServer write SetUPSServer;
    property TestMode: boolean read GetTestMode write SetTestMode;
    property DefaultService: string read GetDefaultService write SetDefaultService;
    property DefaultPackage: string read GetDefaultPackage write SetDefaultPackage;
    property DefaultWeight: double read GetDefaultWeight write SetDefaultWeight;
    property DefaultLength: double read GetDefaultLength write SetDefaultLength;
    property DefaultHeight: double read GetDefaultHeight write SetDefaultHeight;
    property DefaultWidth: double read GetDefaultWidth write SetDefaultWidth;
    property LastServerID: string read GetLastServerID write SetLastServerID;
    property TestURL: string read GetTestURL;
    function Validate(var msg: string): boolean;
//    function CheckComms(var msg: string): boolean;
  end;

implementation

uses
  ibxUPSTrack, ibxCore, sysutils, classes, ShipIntegrationUtils, ShipIntegrationTypes,
  ibxupsaddress, ibxupsship;

{ TUPSConfig }

//function TUPSConfig.CheckComms(var msg: string): boolean;
//var
////  UPSTrack: TibxUPSTrack;
//  UPSAddress: TibxUPSAddress;
//  UPSError: TShipperError;
//  upsShip: TibxUPSShip;
//begin
//  result := false;
//  if UPSServer = '' then begin
//    msg := 'UPS Server URL is blank';
//    exit;
//  end;
//  if UPSUserID = '' then begin
//    msg := 'User ID is blank';
//    exit;
//  end;
//  if UPSAccountNumber = '' then begin
//    msg := 'Account Number is blank';
//    exit;
//  end;
//  if UPSAccessKey = '' then begin
//    msg := 'Access Key is blank';
//    exit;
//  end;
//  if UPSPassword = '' then begin
//    msg := 'Password is blank';
//    exit;
//  end;
//
//  result := true;
//
//  upsShip := TibxUPSShip.Create(nil);
//  try
//    { use TLS 1.2 }
//    upsShip.Config('SSLEnabledProtocols=3072');
//    upsShip.UPSAccessKey := UPSAccessKey;
//    upsShip.UPSAccountNumber := UPSAccountNumber;
//    upsShip.UPSPassword := UPSPassword;
//    { use test server }
//    upsShip.UPSServer := 'https://wwwcie.ups.com/webservices/Ship';
//    upsShip.UPSUserId := UPSUserID;
//
//    upsShip.ServiceType := stUPSNextDayAir;
//    upsShip.LabelImageType := uitGIF;
//    upsShip.PayorType := ptSender;
//    upsShip.PayorAccountNumber := UPSAccountNumber;
//    upsShip.ShipDate := FormatDateTime('yyyy-mm-dd',now);
//
//    upsShip.RecipientCompany := 'Test';
//    upsShip.RecipientAddress1 := '123 Nowhere Ln';
//    upsShip.RecipientCity := 'Durham';
//    upsShip.RecipientState := 'NC';
//    upsShip.RecipientZipCode := '27713';
//    upsShip.RecipientCountryCode := 'US';
//    upsShip.RecipientPhone := '0123456789';
//
//    upsShip.SenderCompany := 'Test';
//    upsShip.SenderAddress1 := '456 Somewhere St';
//    upsShip.SenderCity := 'New York';
//    upsShip.SenderState := 'NY';
//    upsShip.SenderZipCode := '10001';
//    upsShip.SenderCountryCode := 'US';
//    upsShip.SenderPhone := '0123456789';
//
//    upsShip.PackageCount := 1;
//
//    upsShip.PackageWeight[0] := '2';
//
//    try
//      upsShip.GetShipmentLabels;
//    except
//      on e: exception do begin
//        UPSError := TShipperError.Create(e);
//        try
//          if UPSError.ErrorName <> 'TransientError' then begin
//            { wrong auth settings }
//            result := false;
//            if UPSError.ErrorDesc <> '' then msg := UPSError.ErrorDesc
//            else msg := UPSError.ErrorNameHuman;
//            exit;
//          end;
//        finally
//          UPSError.Free;
//        end;
//      end;
//    end;
//
//  finally
//    upsShip.Free;
//  end;
//
//  UPSAddress := TibxUPSAddress.Create(nil);
//  try
//    UPSAddress.Reset;
//    { use TLS 1.2 }
//    UPSAddress.Config('SSLEnabledProtocols=3072');
//    UPSAddress.UPSAccessKey := UPSAccessKey;
//    UPSAddress.UPSAccountNumber := UPSAccountNumber;
//    UPSAddress.UPSPassword := UPSPassword;
//    UPSAddress.UPSServer := UPSServer + '/XAV';
//    UPSAddress.UPSUserId := UPSUserID;
//    UPSAddress.ZipCode := '95827';
//    UPSAddress.State := 'CA';
//    UPSAddress.City := 'Sacramento';
//    UPSAddress.CountryCode := 'US';
//    UPSAddress.Address1 := '1910 J Street';
//    try
//      UPSAddress.ValidateAddress;
//
//    except
//      on e: exception do begin
//        UPSError := TShipperError.Create(e);
//        try
//            { wrong auth settings }
//            result := false;
//            if UPSError.ErrorDesc <> '' then msg := UPSError.ErrorDesc
//            else msg := UPSError.ErrorNameHuman;
//            exit;
//        finally
//          UPSError.Free;
//        end;
//      end;
//    end;
//  finally
//    UPSAddress.Free;
//  end;
//end;

function TUPSConfig.GetDefaultHeight: double;
begin
  result := F['DefaultHeight'];
end;

function TUPSConfig.GetDefaultLength: double;
begin
  result := F['DefaultLength'];
end;

function TUPSConfig.GetDefaultPackage: string;
begin
  result := S['DefaultPackage'];
end;

function TUPSConfig.GetDefaultService: string;
begin
  result := S['DefaultService'];
end;

function TUPSConfig.GetDefaultWeight: double;
begin
  result := F['DefaultWeight'];
end;

function TUPSConfig.GetDefaultWidth: double;
begin
  result := F['DefaultWidth'];
end;

function TUPSConfig.GetLastServerID: string;
begin
  result := S['LastServerID'];
end;

function TUPSConfig.GetTestMode: boolean;
begin
  result := B['TestMode'];
end;

function TUPSConfig.GetTestURL: string;
begin
  result := 'https://wwwcie.ups.com/webservices';
end;

function TUPSConfig.GetUPSAccessKey: string;
begin
  result := S['UPSAccessKey'];
end;

function TUPSConfig.GetUPSAccountNumber: string;
begin
  result := S['UPSAccountNumber'];
end;

function TUPSConfig.GetUPSEnabled: boolean;
begin
  result := B['UPSEnabled'];
end;

function TUPSConfig.GetUPSPassword: string;
begin
  result := S['UPSPassword'];
end;

function TUPSConfig.GetUPSServer: string;
begin
  result := S['UPSServer'];
end;

function TUPSConfig.GetUPSUserID: string;
begin
  result := S['UPSUserID'];
end;

procedure TUPSConfig.Load(connection: TMyConnection);
begin
  inherited;
  if DefaultService = '' then begin
    DefaultService := 'UPS Ground';
    Save(connection);
  end;
end;

procedure TUPSConfig.SetDefaultHeight(const Value: double);
begin
  F['DefaultHeight'] := Value;
end;

procedure TUPSConfig.SetDefaultLength(const Value: double);
begin
  F['DefaultLength'] := Value;
end;

procedure TUPSConfig.SetDefaultPackage(const Value: string);
begin
  S['DefaultPackage'] := Value;
end;

procedure TUPSConfig.SetDefaultService(const Value: string);
begin
  S['DefaultService'] := Value;
end;

procedure TUPSConfig.SetDefaultWeight(const Value: double);
begin
  F['DefaultWeight'] := Value;
end;

procedure TUPSConfig.SetDefaultWidth(const Value: double);
begin
  F['DefaultWidth'] := Value;
end;

procedure TUPSConfig.SetLastServerID(const Value: string);
begin
  S['LastServerID'] := Value;
end;

procedure TUPSConfig.SetTestMode(const Value: boolean);
begin
  B['TestMode'] := Value;
end;

procedure TUPSConfig.SetUPSAccessKey(const Value: string);
begin
  S['UPSAccessKey'] := Value;
end;

procedure TUPSConfig.SetUPSAccountNumber(const Value: string);
begin
  S['UPSAccountNumber'] := Value;
end;

procedure TUPSConfig.SetUPSEnabled(const Value: boolean);
begin
  B['UPSEnabled'] := Value;
end;

procedure TUPSConfig.SetUPSPassword(const Value: string);
begin
  S['UPSPassword'] := Value;
end;

procedure TUPSConfig.SetUPSServer(const Value: string);
begin
  S['UPSServer'] := Value;
end;

procedure TUPSConfig.SetUPSUserID(const Value: string);
begin
  S['UPSUserID'] := Value;
end;

function TUPSConfig.Validate(var msg: string): boolean;
begin
  result := false;
  if UPSEnabled then begin
    if UPSAccountNumber = '' then begin
      msg := 'Can not check address, Account Number is missing in UPS Preferences.';
      exit;
    end;
    if UPSPassword = '' then begin
      msg := 'Can not check address, Password is missing in UPS Preferences.';
      exit;
    end;
    if UPSUserID = '' then begin
      msg := 'Can not check address, User ID is missing in UPS Preferences.';
      exit;
    end;
    if UPSAccessKey = '' then begin
      msg := 'Can not check address, Access Key is missing in UPS Preferences.';
      exit;
    end;
    if UPSServer = '' then begin
      msg := 'Can not check address, Server is missing in UPS Preferences.';
      exit;
    end;
  end
  else begin
    msg := 'UPS is not enabled in Preferences.';
    exit;
  end;
  result := true;
end;

end.
