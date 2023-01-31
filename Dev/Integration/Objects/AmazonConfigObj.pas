unit AmazonConfigObj;

interface

uses
  JsonDbPrefsConfigObj, MyAccess;

type

  {$M+}
  TAmazonConfig = class(TJsonDbPefConfig)
  private
    function GetAccessKey: string;
    function GetActive: boolean;
    function GetMarketplaceId: string;
    function GetMWSAuthToken: string;
    function GetSecretKey: string;
    function GetSellerId: string;
    function GetServiceURL: string;
    procedure SetAccessKey(const Value: string);
    procedure SetActive(const Value: boolean);
    procedure SetMarketplaceId(const Value: string);
    procedure SetMWSAuthToken(const Value: string);
    procedure SetSecretKey(const Value: string);
    procedure SetSellerId(const Value: string);
    procedure SetServiceURL(const Value: string);
    function GetAmazonCustomerID: integer;
    function GetAmazonAFNClassID: integer;
    function GetAmazonMFNClassID: integer;
    procedure SetAmazonCustomerID(const Value: integer);
    procedure SetAmazonAFNClassID(const Value: integer);
    procedure SetAmazonMFNClassID(const Value: integer);
    function GetAutoCheckForOrders: boolean;
    procedure SetAutoCheckForOrders(const Value: boolean);
  public
    constructor Create; override;
    procedure Load(connection: TMyConnection); override;
  published
    property Active: boolean read GetActive write SetActive;
    property AccessKey: string read GetAccessKey write SetAccessKey;
    property SecretKey: string  read GetSecretKey write SetSecretKey;
    property ServiceURL: string read GetServiceURL write SetServiceURL;
    property MWSAuthToken: string read GetMWSAuthToken write SetMWSAuthToken;
    property SellerId: string read GetSellerId write SetSellerId;
    property MarketplaceId: string read GetMarketplaceId write SetMarketplaceId;
    property AmazonCustomerID: integer read GetAmazonCustomerID write SetAmazonCustomerID;
    property AmazonAFNClassID: integer read GetAmazonAFNClassID write SetAmazonAFNClassID;
    property AmazonMFNClassID: integer read GetAmazonMFNClassID write SetAmazonMFNClassID;
    property AutoCheckForOrders: boolean read GetAutoCheckForOrders write SetAutoCheckForOrders;
  end;
  {$M-}

implementation

{ TAmazonConfig }

constructor TAmazonConfig.Create;
begin
  inherited;
  Encrypt := true;
  Name := 'Config_EDI_Amazon';
end;

function TAmazonConfig.GetAccessKey: string;
begin
  result := S['AccessKey'];
end;

function TAmazonConfig.GetActive: boolean;
begin
  result := B['Active'];
end;

function TAmazonConfig.GetAmazonCustomerID: integer;
begin
  result := I['AmazonCustomerID'];
end;
function TAmazonConfig.GetAmazonAFNClassID: integer;
begin
  result := I['AmazonAFNClassID'];
end;
function TAmazonConfig.GetAmazonMFNClassID: integer;
begin
  result := I['AmazonMFNClassID'];
end;

function TAmazonConfig.GetAutoCheckForOrders: boolean;
begin
  result := B['AutoCheckForOrders'];
end;

function TAmazonConfig.GetMarketplaceId: string;
begin
  result := S['MarketplaceId'];
end;

function TAmazonConfig.GetMWSAuthToken: string;
begin
  result := S['MWSAuthToken'];
end;

function TAmazonConfig.GetSecretKey: string;
begin
  result := S['SecretKey'];
end;

function TAmazonConfig.GetSellerId: string;
begin
  result := S['SellerId'];
end;

function TAmazonConfig.GetServiceURL: string;
begin
  result := S['ServiceURL'];
end;

procedure TAmazonConfig.Load(connection: TMyConnection);
begin
  inherited;
  if (AccessKey = '') and (SecretKey = '') then begin
    AccessKey := 'AKIAIY7XPM5YTTRNKJ6Q';
    SecretKey := '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';
    Save(connection);
  end;
  if (ServiceURL = '') then begin
    ServiceURL := 'https://mws.amazonservices.com';
    Save(connection);
  end;
end;

procedure TAmazonConfig.SetAccessKey(const Value: string);
begin
  S['AccessKey'] := value;
end;

procedure TAmazonConfig.SetActive(const Value: boolean);
begin
  B['Active'] := value;
end;

procedure TAmazonConfig.SetAmazonCustomerID(const Value: integer);
begin
  I['AmazonCustomerID'] := Value;
end;
procedure TAmazonConfig.SetAmazonAFNClassID(const Value: integer);
begin
  I['AmazonAFNClassID'] := Value;
end;
procedure TAmazonConfig.SetAmazonMFNClassID(const Value: integer);
begin
  I['AmazonMFNClassID'] := Value;
end;

procedure TAmazonConfig.SetAutoCheckForOrders(const Value: boolean);
begin
  B['AutoCheckForOrders'] := Value;
end;

procedure TAmazonConfig.SetMarketplaceId(const Value: string);
begin
  S['MarketplaceId'] := value;
end;

procedure TAmazonConfig.SetMWSAuthToken(const Value: string);
begin
  S['MWSAuthToken'] := value;
end;

procedure TAmazonConfig.SetSecretKey(const Value: string);
begin
  S['SecretKey'] := value;
end;

procedure TAmazonConfig.SetSellerId(const Value: string);
begin
  S['SellerId'] := value;
end;

procedure TAmazonConfig.SetServiceURL(const Value: string);
begin
  S['ServiceURL'] := value;
end;

end.
