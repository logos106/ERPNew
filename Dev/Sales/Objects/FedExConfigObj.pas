unit FedExConfigObj;

interface

uses
  JsonDbPrefsConfigObj, MyAccess;

type

  {$M+}
  TFedExConfig = class(TJsonDbPefConfig)
  private
    function GetAccessKey: string;
    function GetAccountNumber: string;
    function GetDefaultPackage: string;
    function GetDefaultService: string;
    function GetDefaultWeight: double;
    function GetFedExEnabled: boolean;
    function GetLastServerID: string;
    function GetMeterNumber: string;
    function GetPassword: string;
    function GetServer: string;
    procedure SetAccessKey(const Value: string);
    procedure SetAccountNumber(const Value: string);
    procedure SetDefaultPackage(const Value: string);
    procedure SetDefaultService(const Value: string);
    procedure SetDefaultWeight(const Value: double);
    procedure SetFedExEnabled(const Value: boolean);
    procedure SetLastServerID(const Value: string);
    procedure SetMeterNumber(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetServer(const Value: string);
    function GetDefaultHeight: double;
    function GetDefaultLength: double;
    function GetDefaultWidth: double;
    procedure SetDefaultHeight(const Value: double);
    procedure SetDefaultLength(const Value: double);
    procedure SetDefaultWidth(const Value: double);
  public
    procedure Load(connection: TMyConnection); override;
//    function CheckComms(var msg: string): boolean;
  published
    property FedExEnabled: boolean read GetFedExEnabled write SetFedExEnabled;
    property AccessKey: string read GetAccessKey write SetAccessKey;
    property Password: string  read GetPassword write SetPassword;
    property AccountNumber: string read GetAccountNumber write SetAccountNumber;
    property MeterNumber: string read GetMeterNumber write SetMeterNumber;
//    property UPSUserID: string read GetUPSUserID write SetUPSUserID;
    property Server: string read GetServer write SetServer;
    property DefaultService: string read GetDefaultService write SetDefaultService;
    property DefaultPackage: string read GetDefaultPackage write SetDefaultPackage;
    property DefaultWeight: double read GetDefaultWeight write SetDefaultWeight;
    property DefaultLength: double read GetDefaultLength write SetDefaultLength;
    property DefaultHeight: double read GetDefaultHeight write SetDefaultHeight;
    property DefaultWidth: double read GetDefaultWidth write SetDefaultWidth;
    property LastServerID: string read GetLastServerID write SetLastServerID;
    function Validate(var msg: string): boolean;
  end;
  {$M-}

implementation

uses
  CommonLib, ibxFedExShip, SysUtils, ShipIntegrationTypes;

{ TFedExConfig }

//function TFedExConfig.CheckComms(var msg: string): boolean;
//var
////  UPSAddress: TibxUPSAddress;
//  UPSError: TShipperError;
//  FedExShip: TibxFedExShip;
//begin
//  result := false;
//  if Server = '' then begin
//    msg := 'FedEx Server URL is blank';
//    exit;
//  end;
////  if UPSUserID = '' then begin
////    msg := 'User ID is blank';
////    exit;
////  end;
//  if AccountNumber = '' then begin
//    msg := 'Account Number is blank';
//    exit;
//  end;
//  if MeterNumber = '' then begin
//    msg := 'Meter Number is blank';
//    exit;
//  end;
//  if AccessKey = '' then begin
//    msg := 'Access Key is blank';
//    exit;
//  end;
//  if Password = '' then begin
//    msg := 'Password is blank';
//    exit;
//  end;
//
//  result := true;
//
//  FedExShip := TibxFedExShip.Create(nil);
//  try
//    FedExShip.FedExDeveloperKey := AccessKey;
//    FedExShip.FedExAccountNumber := AccountNumber;
//    FedExShip.FedExMeterNumber := MeterNumber;
//    FedExShip.FedExPassword := Password;
//    { use test server }
//    FedExShip.FedExServer := 'https://gatewaybeta.fedex.com:443/web-services';
////    upsShip.UPSUserId := UPSUserID;
//
//    FedExShip.ServiceType := stFedExGround;
//    FedExShip.LabelImageType := fitPDF; //fitPNG;
//    FedExShip.PayorType := ptSender;
//    FedExShip.PayorAccountNumber := AccountNumber;
//    FedExShip.ShipDate := FormatDateTime('yyyy-mm-dd',now);
//
//    FedExShip.RecipientCompany := 'Test';
//    FedExShip.RecipientAddress1 := '123 Nowhere Ln';
//    FedExShip.RecipientCity := 'Durham';
//    FedExShip.RecipientState := 'NC';
//    FedExShip.RecipientZipCode := '27713';
//    FedExShip.RecipientCountryCode := 'US';
//    FedExShip.RecipientPhone := '0123456789';
//
//    FedExShip.SenderCompany := 'Test';
//    FedExShip.SenderAddress1 := '456 Somewhere St';
//    FedExShip.SenderCity := 'New York';
//    FedExShip.SenderState := 'NY';
//    FedExShip.SenderZipCode := '10001';
//    FedExShip.SenderCountryCode := 'US';
//    FedExShip.SenderPhone := '0123456789';
//
//    FedExShip.PackageCount := 1;
//
//    FedExShip.PackageWeight[0] := '2';
//
//    { use TLS 1.2 }
//    FedExShip.Config('SSLEnabledProtocols=3072');
//
//    try
//      FedExShip.GetPackageLabel(0);
//    except
//      on e: exception do begin
//        UPSError := TShipperError.Create(e);
//        try
//          if UPSError.ErrorName <> 'TransientError' then begin
//            { wrong auth settings }
//            result := false;
//            msg := UPSError.ErrorNameHuman;
//            if Pos(UPSError.ErrorDesc, UPSError.ErrorNameHuman) = 0 then
//              msg := msg + ' ' + UPSError.ErrorDesc;
////            if UPSError.ErrorDesc <> '' then msg := UPSError.ErrorDesc
////            else msg := UPSError.ErrorNameHuman;
//            exit;
//          end;
//        finally
//          UPSError.Free;
//        end;
//      end;
//    end;
//
//  finally
//    FedExShip.Free;
//  end;
//end;

function TFedExConfig.GetAccessKey: string;
begin
  result := S['AccessKey'];
end;

function TFedExConfig.GetAccountNumber: string;
begin
  result := S['AccountNumber'];
end;

function TFedExConfig.GetDefaultHeight: double;
begin
  result := F['DefaultHeight'];
end;

function TFedExConfig.GetDefaultLength: double;
begin
  result := F['DefaultLength'];
end;

function TFedExConfig.GetDefaultPackage: string;
begin
  result := S['DefaultPackage'];
end;

function TFedExConfig.GetDefaultService: string;
begin
  result := S['DefaultService'];
end;

function TFedExConfig.GetDefaultWeight: double;
begin
  result := F['DefaultWeight'];
end;

function TFedExConfig.GetDefaultWidth: double;
begin
  result := F['DefaultWidth'];
end;

function TFedExConfig.GetFedExEnabled: boolean;
begin
  result := B['FedExEnabled'];
end;

function TFedExConfig.GetLastServerID: string;
begin
  result := S['LastServerID'];
end;

function TFedExConfig.GetMeterNumber: string;
begin
  result := S['MeterNumber'];
end;

function TFedExConfig.GetPassword: string;
begin
  result := S['Password'];
end;

function TFedExConfig.GetServer: string;
begin
  result := S['Server'];
end;

procedure TFedExConfig.Load(connection: TMyConnection);
begin
  inherited;
  if DevMode then begin
//    if AccessKey = '' then begin
//      AccessKey := 'cLpTXKEQEqOXkpDb';
//      Save(connection);
//    end;
//    if Password = '' then begin
//      Password := '7HvkJOZdHpQX2ihPxZNHstRrq';
//      Save(connection);
//    end;
//    if AccountNumber = '' then begin
//      AccountNumber := '510087860';
//      Save(connection);
//    end;
//    if MeterNumber = '' then begin
//      MeterNumber := '118682029';
//      Save(connection);
//    end;
//    if Server = '' then begin
//      Server := 'https://gatewaybeta.fedex.com:443/web-services';
//      Save(connection);
//    end;
  end
  else begin
    if Server = '' then begin
      Server := 'https://wsbeta.fedex.com:443/web-services';
      Save(connection);
    end;
  end;
end;

procedure TFedExConfig.SetAccessKey(const Value: string);
begin
  S['AccessKey'] := Value;
end;

procedure TFedExConfig.SetAccountNumber(const Value: string);
begin
  S['AccountNumber'] := Value;
end;

procedure TFedExConfig.SetDefaultHeight(const Value: double);
begin
  F['DefaultHeight'] := Value;
end;

procedure TFedExConfig.SetDefaultLength(const Value: double);
begin
  F['DefaultLength'] := Value;
end;

procedure TFedExConfig.SetDefaultPackage(const Value: string);
begin
  S['DefaultPackage'] := Value;
end;

procedure TFedExConfig.SetDefaultService(const Value: string);
begin
  S['DefaultService'] := Value;
end;

procedure TFedExConfig.SetDefaultWeight(const Value: double);
begin
  F['DefaultWeight'] := Value;
end;

procedure TFedExConfig.SetDefaultWidth(const Value: double);
begin
  F['DefaultWidth'] := Value;
end;

procedure TFedExConfig.SetFedExEnabled(const Value: boolean);
begin
  B['FedExEnabled'] := Value;
end;

procedure TFedExConfig.SetLastServerID(const Value: string);
begin
  S['LastServerID'] := Value;
end;

procedure TFedExConfig.SetMeterNumber(const Value: string);
begin
  S['MeterNumber'] := Value;
end;

procedure TFedExConfig.SetPassword(const Value: string);
begin
  S['Password'] := Value;
end;

procedure TFedExConfig.SetServer(const Value: string);
begin
  S['Server'] := Value;
end;

function TFedExConfig.Validate(var msg: string): boolean;
begin
  result := false;
  if FedExEnabled then begin
    if AccountNumber = '' then begin
      msg := 'Can not check address, Account Number is missing in FedEx Preferences.';
      exit;
    end;
    if Password = '' then begin
      msg := 'Can not check address, Password is missing in FedEx Preferences.';
      exit;
    end;
    if MeterNumber = '' then begin
      msg := 'Can not check address, Meter Number is missing in FedEx Preferences.';
      exit;
    end;
    if AccessKey = '' then begin
      msg := 'Can not check address, Access Key is missing in FedEx Preferences.';
      exit;
    end;
    if Server = '' then begin
      msg := 'Can not check address, Server is missing in FedEx Preferences.';
      exit;
    end;
  end
  else begin
    msg := 'FedEx is not enabled in Preferences.';
    exit;
  end;
  result := true;
end;

end.
