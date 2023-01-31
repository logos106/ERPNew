unit USPSConfigObj;

interface

uses
  JsonDbPrefsConfigObj, MyAccess, ibxuspsship;

type

  {$M+}
  TUSPSConfig = class(TJsonDbPefConfig)
  private
    function GetDefaultPackage: string;
    function GetDefaultService: string;
    function GetDefaultWeight: double;
    function GetLastServerID: string;
    function GetUSPSPassword: string;
    function GetShipServer: string;
    function GetUSPSUserID: string;
    procedure SetDefaultPackage(const Value: string);
    procedure SetDefaultService(const Value: string);
    procedure SetDefaultWeight(const Value: double);
    procedure SetLastServerID(const Value: string);
    procedure SetUSPSPassword(const Value: string);
    procedure SetShipServer(const Value: string);
    procedure SetUSPSUserID(const Value: string);
    function GetEndiciaAccountNumber: string;
    procedure SetEndiciaAccountNumber(const Value: string);
    function GetStampsUserID: string;
    procedure SetStampsUserID(const Value: string);
    function GetUSPSEnabled: boolean;
    procedure SetUSPSEnabled(const Value: boolean);
    function GetEndiciaTestMode: integer;
    procedure SetEndiciaTestMode(const Value: integer);
    function GetEndiciaPassword: string;
    procedure SetEndiciaPassword(const Value: string);
    function GetStampsAccountNumber: string;
    procedure SetStampsAccountNumber(const Value: string);
    function GetStampsPassword: string;
    procedure SetStampsPassword(const Value: string);
    function GetStampsServer: string;
    procedure SetStampsServer(const Value: string);
    function GetUSPSAccountNumber: string;
    procedure SetUSPSAccountNumber(const Value: string);
    function GetStampsTestMode: integer;
    procedure SetStampsTestMode(const Value: integer);
    function GetEndiciaDefaultPackage: string;
    function GetEndiciaDefaultService: string;
    function GetEndiciaDefaultWeight: double;
    procedure SetEndiciaDefaultPackage(const Value: string);
    procedure SetEndiciaDefaultService(const Value: string);
    procedure SetEndiciaDefaultWeight(const Value: double);
    function GetStampsDefaultPackage: string;
    function GetStampsDefaultService: string;
    function GetStampsDefaultWeight: double;
    procedure SetStampsDefaultPackage(const Value: string);
    procedure SetStampsDefaultService(const Value: string);
    procedure SetStampsDefaultWeight(const Value: double);
    procedure SetDefaultHeight(const Value: double);
    procedure SetDefaultLength(const Value: double);
    procedure SetDefaultWidth(const Value: double);
    function GetDefaultHeight: double;
    function GetDefaultLength: double;
    function GetDefaultWidth: double;
    function GetEndiciaDefaultHeight: double;
    function GetEndiciaDefaultLength: double;
    function GetEndiciaDefaultWidth: double;
    function GetStampsDefaultHeight: double;
    function GetStampsDefaultLength: double;
    function GetStampsDefaultWidth: double;
    procedure SetEndiciaDefaultHeight(const Value: double);
    procedure SetEndiciaDefaultLength(const Value: double);
    procedure SetEndiciaDefaultWidth(const Value: double);
    procedure SetStampsDefaultHeight(const Value: double);
    procedure SetStampsDefaultLength(const Value: double);
    procedure SetStampsDefaultWidth(const Value: double);
  public
    procedure Load(connection: TMyConnection); override;
    function CheckComms(aProvider: integer; var msg: string): boolean;
  published
    property USPSEnabled: boolean read GetUSPSEnabled write SetUSPSEnabled;
    property DefaultService: string read GetDefaultService write SetDefaultService;
    property DefaultPackage: string read GetDefaultPackage write SetDefaultPackage;
    property DefaultWeight: double read GetDefaultWeight write SetDefaultWeight;
    property DefaultLength: double read GetDefaultLength write SetDefaultLength;
    property DefaultHeight: double read GetDefaultHeight write SetDefaultHeight;
    property DefaultWidth: double read GetDefaultWidth write SetDefaultWidth;
    property LastServerID: string read GetLastServerID write SetLastServerID;
    { usps }
    property USPSUserID: string read GetUSPSUserID write SetUSPSUserID;
    property USPSPassword: string  read GetUSPSPassword write SetUSPSPassword;
    property USPSAccountNumber: string read GetUSPSAccountNumber write SetUSPSAccountNumber;
    property ShipServer: string read GetShipServer write SetShipServer;
    { endicia }
    property EndiciaAccountNumber: string read GetEndiciaAccountNumber write SetEndiciaAccountNumber;
    property EndiciaPassword: string  read GetEndiciaPassword write SetEndiciaPassword;
    property EndiciaTestMode: integer read GetEndiciaTestMode write SetEndiciaTestMode;
    property EndiciaDefaultService: string read GetEndiciaDefaultService write SetEndiciaDefaultService;
    property EndiciaDefaultPackage: string read GetEndiciaDefaultPackage write SetEndiciaDefaultPackage;
    property EndiciaDefaultWeight: double read GetEndiciaDefaultWeight write SetEndiciaDefaultWeight;
    property EndiciaDefaultLength: double read GetEndiciaDefaultLength write SetEndiciaDefaultLength;
    property EndiciaDefaultHeight: double read GetEndiciaDefaultHeight write SetEndiciaDefaultHeight;
    property EndiciaDefaultWidth: double read GetEndiciaDefaultWidth write SetEndiciaDefaultWidth;
    { stamps }
    property StampsUserID: string read GetStampsUserID write SetStampsUserID;
    property StampsAccountNumber: string read GetStampsAccountNumber write SetStampsAccountNumber;
    property StampsPassword: string read GetStampsPassword write SetStampsPassword;
    property StampsTestMode: integer read GetStampsTestMode write SetStampsTestMode;
    property StampsServer: string read GetStampsServer write SetStampsServer;
    property StampsDefaultService: string read GetStampsDefaultService write SetStampsDefaultService;
    property StampsDefaultPackage: string read GetStampsDefaultPackage write SetStampsDefaultPackage;
    property StampsDefaultWeight: double read GetStampsDefaultWeight write SetStampsDefaultWeight;
    property StampsDefaultLength: double read GetStampsDefaultLength write SetStampsDefaultLength;
    property StampsDefaultHeight: double read GetStampsDefaultHeight write SetStampsDefaultHeight;
    property StampsDefaultWidth: double read GetStampsDefaultWidth write SetStampsDefaultWidth;
    function Validate(var msg: string;Postageprovide: TibxuspsshipPostageProviders= ppNone): boolean;
  end;
  {$M-}


implementation

uses
  CommonLib, SysUtils, ShipIntegrationTypes;

{ TUSPSConfig }

function TUSPSConfig.CheckComms(aProvider: integer; var msg: string): boolean;
var
//  UPSAddress: TibxUPSAddress;
  UPSError: TShipperError;
  USPSExShip: TibxUSPSShip;
begin
  result := false;
  if USPSUserID = '' then begin
    msg := 'USPS User ID is blank';
    exit;
  end;
  if USPSPassword = '' then begin
    msg := 'USPS Password is blank';
    exit;
  end;

  result := true;

  USPSExShip := TibxUSPSShip.Create(nil);
  try
    USPSExShip.USPSUserId := USPSUserId;
    USPSExShip.USPSPassword := USPSPassword;
    { use test server }
    USPSExShip.USPSServer := 'https://secure.shippingapis.com/ShippingAPI.dll';//'https://secure.shippingapis.com/ShippingAPITest.dll';

    case aProvider of
      0: begin  { USPS }
           USPSExShip.PostageProvider := ppNone;
           if USPSUserID = '' then begin
             msg := 'User ID is required.';
             exit;
           end;
           USPSExShip.USPSUserId := USPSUserID;
           { password is optional }
           USPSExShip.USPSPassword := USPSPassword;
           USPSExShip.USPSAccountNumber := USPSAccountNumber;
         end;
      1: begin  { Endicia }
           USPSExShip.PostageProvider := ppEndicia;
           if EndiciaAccountNumber = '' then begin
             msg := 'Endicia Account Number is required.';
             exit;
           end;
           USPSExShip.USPSAccountNumber := EndiciaAccountNumber;
           if USPSPassword = '' then begin
             msg := 'Password is required.';
             exit;
           end;
           if EndiciaPassword = '' then begin
             msg := 'Endicia Password is required.';
             exit;
           end;
           USPSExShip.USPSPassword := EndiciaPassword;
           if self.EndiciaTestMode > 0 then
             USPSExShip.Config('EndiciaTestMode=' + IntToStr(EndiciaTestMode));
           USPSExShip.TransactionId := '999';
         end;
      2: begin  { Stamps }
           USPSExShip.PostageProvider := ppStamps;
           if StampsUserID = '' then begin
             msg := 'Stamps User ID is required.';
             exit;
           end;
           USPSExShip.USPSUserId := StampsUserID;
           if StampsAccountNumber = '' then begin
             msg := 'Stamps Account Number required.';
             exit;
           end;
           USPSExShip.USPSAccountNumber := StampsAccountNumber;
           if StampsPassword = '' then begin
             msg := 'Stamps Password required.';
             exit;
           end;
           USPSExShip.USPSPassword := StampsPassword;
         end;
    end;

//    if USPSAccountNumber <> '' then begin
//      { they are using Endicia }
//      USPSExShip.PostageProvider := ppEndicia;
//      USPSExShip.USPSAccountNumber := USPSAccountNumber;
//      USPSExShip.CustomerId := CustomerId;
//      USPSExShip.TransactionId := '999';
//    end
//    else begin
//      USPSExShip.PostageProvider := ppNone;
//    end;

    USPSExShip.Config('Certify=true'); // test mode

    USPSExShip.ServiceType := stUSPSPriority;
    if USPSExShip.PostageProvider = ppStamps  then
      USPSExShip.LabelImageType := sitPNG
    else
      USPSExShip.LabelImageType := sitTIF; //fitPNG;

    USPSExShip.ShipDate := FormatDateTime('mm/dd/yyyy',now);

    USPSExShip.RecipientFirstName := 'Sue';
    USPSExShip.RecipientLastName := 'Smith';
    USPSExShip.RecipientCompany := 'Test';
    USPSExShip.RecipientAddress1 := '8 Wildwood Drive';
    USPSExShip.RecipientCity := 'Old Lyme';
    USPSExShip.RecipientState := 'CT';
    USPSExShip.RecipientZipCode := '06371';
    USPSExShip.RecipientPhone := '0123456789';

    USPSExShip.SenderFirstName := 'Peter';
    USPSExShip.SenderLastName := 'Brown';
    USPSExShip.SenderCompany := 'Test';
    USPSExShip.SenderAddress1 := '475 Enfant Plaza, SW';
    USPSExShip.SenderCity := 'Washington';
    USPSExShip.SenderState := 'DC';
    USPSExShip.SenderZipCode := '20260';
    USPSExShip.SenderPhone := '0123456789';

    USPSExShip.LabelOption := '1';
    USPSExShip.PackageCount := 1;

    if USPSExShip.PostageProvider = ppEndicia then
      USPSExShip.PackageWeight[0] := '48' {oz}
    else
      USPSExShip.PackageWeight[0] := '2 lbs 8 oz';

    USPSExShip.PackageSignatureType[0] := stNoSignatureRequired;

    try
      USPSExShip.GetPackageLabel();
    except
      on e: exception do begin
        UPSError := TShipperError.Create(e);
        try
          if UPSError.ErrorName <> 'TransientError' then begin
            { wrong auth settings }
            result := false;
            if UPSError.ErrorDesc <> '' then msg := UPSError.ErrorDesc
            else msg := UPSError.ErrorNameHuman;
            exit;
          end;
        finally
          UPSError.Free;
        end;
      end;
    end;

  finally
    USPSExShip.Free;
  end;

end;

function TUSPSConfig.GetStampsAccountNumber: string;
begin
  result := S['StampsAccountNumber'];
end;

function TUSPSConfig.GetStampsDefaultHeight: double;
begin
  result := F['StampsDefaultHeight'];
end;

function TUSPSConfig.GetStampsDefaultLength: double;
begin
  result := F['StampsDefaultLength'];
end;

function TUSPSConfig.GetStampsDefaultPackage: string;
begin
  result := S['StampsDefaultPackage'];
end;

function TUSPSConfig.GetStampsDefaultService: string;
begin
  result := S['StampsDefaultService'];
end;

function TUSPSConfig.GetStampsDefaultWeight: double;
begin
  result := F['StampsDefaultWeight'];
end;

function TUSPSConfig.GetStampsDefaultWidth: double;
begin
  result := F['StampsDefaultWidth'];
end;

function TUSPSConfig.GetStampsPassword: string;
begin
  result := S['StampsPassword'];
end;

function TUSPSConfig.GetStampsServer: string;
begin
  result := S['StampsServer'];
end;

function TUSPSConfig.GetStampsTestMode: integer;
begin
  result := I['StampsTestMode'];
end;

function TUSPSConfig.GetStampsUserID: string;
begin
  result := S['StampsUserID'];
end;

function TUSPSConfig.GetDefaultHeight: double;
begin
  result := F['DefaultHeight'];
end;

function TUSPSConfig.GetDefaultLength: double;
begin
  result := F['DefaultLength'];
end;

function TUSPSConfig.GetDefaultPackage: string;
begin
  result := S['DefaultPackage'];
end;

function TUSPSConfig.GetDefaultService: string;
begin
  result := S['DefaultService'];
end;

function TUSPSConfig.GetDefaultWeight: double;
begin
  result := F['DefaultWeight'];
end;

function TUSPSConfig.GetDefaultWidth: double;
begin
  result := F['DefaultWidth'];
end;

function TUSPSConfig.GetEndiciaTestMode: integer;
begin
  result := I['EndiciaTestMode'];
end;

function TUSPSConfig.GetLastServerID: string;
begin
  result := S['LastServerID'];
end;

function TUSPSConfig.GetEndiciaAccountNumber: string;
begin
  result := S['EndiciaAccountNumber'];
end;

function TUSPSConfig.GetEndiciaDefaultHeight: double;
begin
  result := F['EndiciaDefaultHeight'];
end;

function TUSPSConfig.GetEndiciaDefaultLength: double;
begin
  result := F['EndiciaDefaultLength'];
end;

function TUSPSConfig.GetEndiciaDefaultPackage: string;
begin
  result := S['EndiciaDefaultPackage'];
end;

function TUSPSConfig.GetEndiciaDefaultService: string;
begin
  result := S['EndiciaDefaultService'];
end;

function TUSPSConfig.GetEndiciaDefaultWeight: double;
begin
  result := F['EndiciaDefaultWeight'];
end;

function TUSPSConfig.GetEndiciaDefaultWidth: double;
begin
  result := F['EndiciaDefaultWidth'];
end;

function TUSPSConfig.GetEndiciaPassword: string;
begin
  result := S['EndiciaPassword'];
end;

function TUSPSConfig.GetUSPSAccountNumber: string;
begin
  result := S['USPSAccountNumber'];
end;

function TUSPSConfig.GetUSPSEnabled: boolean;
begin
  result := B['USPSEnabled'];
end;

function TUSPSConfig.GetUSPSPassword: string;
begin
  result := S['USPSPassword'];
end;

function TUSPSConfig.GetShipServer: string;
begin
  result := S['ShipServer'];
end;

function TUSPSConfig.GetUSPSUserID: string;
begin
  result := S['USPSUserID'];
end;

procedure TUSPSConfig.Load(connection: TMyConnection);
begin
  inherited;
  if DevMode then begin
//    if USPSUserID = '' then begin
//      USPSUserID := '397TRUEE3338';
//      Save(connection);
//    end;
//    if USPSPassword = '' then begin
//      USPSPassword := '200BP72RY813';
//      Save(connection);
//    end;
//    if ShipServer = '' then begin
//      ShipServer := 'https://secure.shippingapis.com/ShippingAPI.dll'; //'https://secure.shippingapis.com/ShippingAPITest.dll';
//      Save(connection);
//    end;
  end
  else begin
    if ShipServer = '' then begin
      ShipServer := 'https://secure.shippingapis.com/ShippingAPI.dll';
      Save(connection);
    end;
  end;
end;

procedure TUSPSConfig.SetStampsAccountNumber(const Value: string);
begin
  S['StampsAccountNumber'] := Value;
end;

procedure TUSPSConfig.SetStampsDefaultHeight(const Value: double);
begin
  F['StampsDefaultHeight'] := Value;
end;

procedure TUSPSConfig.SetStampsDefaultLength(const Value: double);
begin
  F['StampsDefaultLength'] := Value;
end;

procedure TUSPSConfig.SetStampsDefaultPackage(const Value: string);
begin
  S['StampsDefaultPackage'] := Value;
end;

procedure TUSPSConfig.SetStampsDefaultService(const Value: string);
begin
  S['StampsDefaultService'] := Value;
end;

procedure TUSPSConfig.SetStampsDefaultWeight(const Value: double);
begin
  F['StampsDefaultWeight'] := Value;
end;

procedure TUSPSConfig.SetStampsDefaultWidth(const Value: double);
begin
  F['StampsDefaultWidth'] := Value;
end;

procedure TUSPSConfig.SetStampsPassword(const Value: string);
begin
  S['StampsPassword'] := Value;
end;

procedure TUSPSConfig.SetStampsServer(const Value: string);
begin
  S['StampsServer'] := Value;
end;

procedure TUSPSConfig.SetStampsTestMode(const Value: integer);
begin
  I['StampsTestMode'] := Value;
end;

procedure TUSPSConfig.SetStampsUserID(const Value: string);
begin
  S['StampsUserID'] := Value;
end;

procedure TUSPSConfig.SetDefaultHeight(const Value: double);
begin
  F['DefaultHeight'] := Value;
end;

procedure TUSPSConfig.SetDefaultLength(const Value: double);
begin
  F['DefaultLength'] := Value;
end;

procedure TUSPSConfig.SetDefaultPackage(const Value: string);
begin
  S['DefaultPackage'] := Value;
end;

procedure TUSPSConfig.SetDefaultService(const Value: string);
begin
  S['DefaultService'] := Value;
end;

procedure TUSPSConfig.SetDefaultWeight(const Value: double);
begin
  F['DefaultWeight'] := Value;
end;

procedure TUSPSConfig.SetDefaultWidth(const Value: double);
begin
  F['DefaultWidth'] := Value;
end;

procedure TUSPSConfig.SetEndiciaTestMode(const Value: integer);
begin
  I['EndiciaTestMode'] := Value;
end;

procedure TUSPSConfig.SetLastServerID(const Value: string);
begin
  S['LastServerID'] := Value;
end;

procedure TUSPSConfig.SetEndiciaAccountNumber(const Value: string);
begin
  S['EndiciaAccountNumber'] := Value;
end;

procedure TUSPSConfig.SetEndiciaDefaultHeight(const Value: double);
begin
  F['EndiciaDefaultHeight'] := Value;
end;

procedure TUSPSConfig.SetEndiciaDefaultLength(const Value: double);
begin
  F['EndiciaDefaultLength'] := Value;
end;

procedure TUSPSConfig.SetEndiciaDefaultPackage(const Value: string);
begin
  S['EndiciaDefaultPackage'] := Value;
end;

procedure TUSPSConfig.SetEndiciaDefaultService(const Value: string);
begin
  S['EndiciaDefaultService'] := Value;
end;

procedure TUSPSConfig.SetEndiciaDefaultWeight(const Value: double);
begin
  F['EndiciaDefaultWeight'] := Value;
end;

procedure TUSPSConfig.SetEndiciaDefaultWidth(const Value: double);
begin
  F['EndiciaDefaultWidth'] := Value;
end;

procedure TUSPSConfig.SetEndiciaPassword(const Value: string);
begin
  S['EndiciaPassword'] := Value;
end;

procedure TUSPSConfig.SetUSPSAccountNumber(const Value: string);
begin
  S['USPSAccountNumber'] := Value;
end;

procedure TUSPSConfig.SetUSPSEnabled(const Value: boolean);
begin
  B['USPSEnabled'] := Value;
end;

procedure TUSPSConfig.SetUSPSPassword(const Value: string);
begin
  S['USPSPassword'] := Value;
end;

procedure TUSPSConfig.SetShipServer(const Value: string);
begin
  S['ShipServer'] := Value;
end;

procedure TUSPSConfig.SetUSPSUserID(const Value: string);
begin
  S['USPSUserID'] := Value;
end;

function TUSPSConfig.Validate(var msg: string;Postageprovide: TibxuspsshipPostageProviders= ppNone): boolean;
begin
  result := false;
  if USPSEnabled then begin
    if Postageprovide = ppEndicia then begin
           if EndiciaAccountNumber = '' then begin
             msg := 'Endicia Account Number is required.';
             exit;
           end;
           if USPSPassword = '' then begin
             msg := 'Endicia Password is required.';
             exit;
           end;
           if EndiciaPassword = '' then begin
             msg := 'Endicia Password is required.';
             exit;
           end;
    end else if Postageprovide = ppStamps then begin
           if StampsUserID = '' then begin
             msg := 'Stamps User ID is required.';
             exit;
           end;
           if StampsAccountNumber = '' then begin
             msg := 'Stamps Account Number required.';
             exit;
           end;
           if StampsPassword = '' then begin
             msg := 'Stamps Password required.';
             exit;
           end;
    end else begin
        if USPSUserID = '' then begin
          msg := 'Can not check address, User ID is missing in USPS Preferences.';
          exit;
        end;
        if USPSPassword = '' then begin
          msg := 'Can not check address, Password is missing in USPS Preferences.';
          exit;
        end;
        if ShipServer = '' then begin
          msg := 'Can not check address, USPS Server is missing in USPS Preferences.';
          exit;
        end;
    end;
  end
  else begin
    result := false;
    msg := 'USPS is not enabled in Preferences.';
    exit;
  end;
  result := true;
end;

end.
