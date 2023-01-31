unit SMSConfigObj;

interface

uses
  JsonDbPrefsConfigObj, DB,
  MyAccess;

type
  TSMSConfig = class(TJsonDbPefConfig)
  private
    function GetSMSPass: string;
    function GetSMSUser: string;
    function GetSMSEnabled: boolean;
    procedure SetSMSPass(const Value: string);
    procedure SetSMSUser(const Value: string);
    procedure SetSMSEnabled(const Value: boolean);
    function GetPhoneNumber: string;
    procedure SetPhoneNumber(const Value: string);
    function GetPriceMargin: double;
    function GetPriceMinInbound: double;
    function GetPriceMinOutbound: double;
    procedure SetPriceMargin(const Value: double);
    procedure SetPriceMinInbound(const Value: double);
    procedure SetPriceMinOutbound(const Value: double);
    function GetLastServerID: string;
    procedure SetLastServerID(const Value: string);
  public
    procedure Load(connection: TMyConnection); overload; override;
    procedure Load(ds: TDataset); overload; override;
    procedure Save(connection: TMyConnection); override;

    property SMSEnabled: boolean read GetSMSEnabled write SetSMSEnabled;
    property SMSUser: string read GetSMSUser write SetSMSUser;
    property SMSPass: string read GetSMSPass write SetSMSPass;
    property PhoneNumber: string read GetPhoneNumber write SetPhoneNumber;
    property PriceMargin: double read GetPriceMargin write SetPriceMargin;
    property PriceMinInbound: double read GetPriceMinInbound write SetPriceMinInbound;
    property PriceMinOutbound: double read GetPriceMinOutbound write SetPriceMinOutbound;
    property LastServerID: string read GetLastServerID write SetLastServerID;
    function PriceIn(BasePrice: double): double;
    function PriceOut(BasePrice: double): double;
  end;

implementation

uses
  SysUtils;

{ TSMSConfig }

function TSMSConfig.GetSMSPass: string;
begin
  result := S['SMSPass'];
end;

function TSMSConfig.GetSMSUser: string;
begin
  result := S['SMSUser'];
end;

procedure TSMSConfig.Load(connection: TMyConnection);
begin
  inherited;

end;

procedure TSMSConfig.Load(ds: TDataset);
begin
  inherited;

end;

function TSMSConfig.PriceIn(BasePrice: double): double;
begin
  result := BasePrice;
  if (result > 0) and (PriceMargin > 0) then
    result := result + (result * PriceMargin);
  if PriceMinInbound > result then
    result := PriceMinInbound;
end;

function TSMSConfig.PriceOut(BasePrice: double): double;
begin
  result := BasePrice;
  if (result > 0) and (PriceMargin > 0) then
    result := result + (result * PriceMargin);
  if PriceMinOutbound > result then
    result := PriceMinOutbound;
end;

function TSMSConfig.GetLastServerID: string;
begin
  result := S['LastServerID'];
end;

function TSMSConfig.GetPhoneNumber: string;
begin
  result := S['PhoneNumber'];
end;

function TSMSConfig.GetPriceMargin: double;
begin
  result := F['PriceMargin'];
end;

function TSMSConfig.GetPriceMinInbound: double;
begin
  result := F['PriceMinInbound'];
end;

function TSMSConfig.GetPriceMinOutbound: double;
begin
  result := F['PriceMinOutbound'];
end;

function TSMSConfig.GetSMSEnabled: boolean;
begin
  result := B['SMSEnabled'];
end;

procedure TSMSConfig.SetSMSPass(const Value: string);
begin
  S['SMSPass'] := Value;
end;

procedure TSMSConfig.SetSMSUser(const Value: string);
begin
  S['SMSUser'] := Value;
end;

procedure TSMSConfig.Save(connection: TMyConnection);
begin
  inherited;

end;

procedure TSMSConfig.SetLastServerID(const Value: string);
begin
  S['LastServerID'] := Value;
end;

procedure TSMSConfig.SetPhoneNumber(const Value: string);
begin
  S['PhoneNumber'] := Value;
end;

procedure TSMSConfig.SetPriceMargin(const Value: double);
begin
  F['PriceMargin'] := Value;
end;

procedure TSMSConfig.SetPriceMinInbound(const Value: double);
begin
  F['PriceMinInbound'] := Value;
end;

procedure TSMSConfig.SetPriceMinOutbound(const Value: double);
begin
  F['PriceMinOutbound'] := Value;
end;

procedure TSMSConfig.SetSMSEnabled(const Value: boolean);
begin
  B['SMSEnabled'] := Value;
end;

end.
