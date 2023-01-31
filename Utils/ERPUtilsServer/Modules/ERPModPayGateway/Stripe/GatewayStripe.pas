unit GatewayStripe;

interface

uses
  GatewayBase, JSONObject, CreditCardObj, CardPaymentObj, DbGen;

type
  TStripeGateway = class(TBaseGateway)
  private
    fStripe_LiveSecretKey: string;
    fStripe_TestSecretKey: string;
    function CurrencyToInt(const aAmount: double; const aCurrencyCode, aDatabase: string): integer; overload;
    function CurrencyToInt(const aAmount: double; const aCurrencyCode: string; Conn: TDbConnection): integer; overload;
    function GetErrorMessage(const aStr: string): string;
  public
    property Stripe_LiveSecretKey: string read fStripe_LiveSecretKey write fStripe_LiveSecretKey;
    property Stripe_TestSecretKey: string read fStripe_TestSecretKey write fStripe_TestSecretKey;
    function TestGateway(var msg: string; UseTest: boolean): boolean;
//    function ChargeCard(JsonIn, JsonOut: TJSONObject): boolean; override;
    function CreateCardToken(aCard: TCreditCard; var msg: string): string;
//    function CreateCharge(const CardToken: string; amount: double;
//      currency: string; desc, aDatabase: string; var msg: string): string; overload;
//    function CreateCharge(const CardToken: string; aCustomerPaymentID: integer;
//      desc, aDatabase: string; var msg: string): string; overload;
    function CreateCharge(var CardPayment: TCardPayment; const CardToken: string;
      Conn: TDbConnection; var msg: string): boolean;

  end;

implementation

uses
  IdHTTP,
  {$IfDef VER220}
  Sysutils,
  Classes,
  DB,
  {$Else}
  System.Sysutils,
  System.Classes,
  Data.DB,
  {$EndIf}
  LogMessageTypes, URILib;

const
  StripeBaseURL = 'https://api.stripe.com/v1/';


{ TStripeGatewat }

//function TStripeGateway.ChargeCard(JsonIn, JsonOut: TJSONObject): boolean;
//begin
//  { step one - Get token for card }
//  { step two - Create charge }
//end;

{ will return newly created token }
function TStripeGateway.CreateCardToken(aCard: TCreditCard;
  var msg: string): string;
var
  http: TIdHTTP;
  params: string;
  s: string;
  sl: TStringList;
begin
  result := '';
  http := NewNTTPClient;
  sl := TStringList.Create;
  try
    if TestMode then
      http.Request.Username := Stripe_TestSecretKey
    else
      http.Request.Username := Stripe_LiveSecretKey;

//    urlParams := '?card[exp_month]=9&card[exp_year]=2021&card[number]=4242424242424242&card[cvc]=123' ;
//    s := client.Post('https://api.stripe.com/v1/tokens'+ urlParams,params);
    params :=
      '?card[exp_month]=' + IntToStr(aCard.ExpMonth) +
      '&card[exp_year]='  + IntToStr(aCard.ExpYear) +
      '&card[number]='    + aCard.Number;
    if aCard.CVC <> '' then
      params := params + '&card[cvc]=' + aCard.CVC;
    if aCard.CardholderName <> '' then
      params := params + '&card[name]=' + URILib.PercentEncode(aCard.CardholderName);
//    if aCard.AddressCity <> '' then
    { TODO : Add other card child items }

    try
      s := http.Post(StripeBaseURL + 'tokens' + params, sl);

      if s <> '' then begin
        with TJSONObject.StrToJsonObject(s) do begin
          result := S['id'];
          Free;
        end;
      end
      else begin
        msg := 'Nothing returned from Stripe Server for Token Request';
      end;

    except
      on E: EIdHTTPProtocolException do begin
        if E.ErrorMessage <> '' then
          msg := GetErrorMessage(E.ErrorMessage)
        else
          msg := E.Message;
      end;
      on E: Exception do begin
        msg := E.Message;
      end;
    end;


  finally
    http.Free;
    sl.Free;
  end;
end;

function TStripeGateway.CreateCharge(var CardPayment: TCardPayment;
  const CardToken: string; Conn: TDbConnection; var msg: string): boolean;
var
  params: string;
  http: TIdHTTP;
  sl: TStringList;
  s: string;
  obj: TJsonObject;
  amountInt: integer;
begin
//    urlParams :=
//      '?amount=2000&currency=aud&description=test&source=' + token;
//      s := client.Post('https://api.stripe.com/v1/charges'+ urlParams,params);
//  result := true;
  if CardPayment.CurrencyCode = '' then begin
    result := false;
    msg := 'Card Payment Currancy Code is Blank.';
    CardPayment.PaymentStatus := Ord(cpsFailed);
    CardPayment.StatusComment := msg;
    exit;
  end;

  amountInt := CurrencyToInt(CardPayment.Amount,CardPayment.CurrencyCode,conn);

  http := NewNTTPClient;
  sl := TStringList.Create;
  try
    if TestMode then
      http.Request.Username := Stripe_TestSecretKey
    else
      http.Request.Username := Stripe_LiveSecretKey;

    params :=
      '?amount=' + IntToStr(amountInt) +
      '&currency='  + CardPayment.CurrencyCode +
      '&source='    + CardToken;
    if CardPayment.Description <> '' then
      params := params + '&description=' + URILib.PercentEncode(CardPayment.Description);

    try
      s := http.Post(StripeBaseURL + 'charges' + params, sl);

      if s <> '' then begin
        obj := TJSONObject.StrToJsonObject(s);
        try
          CardPayment.PaymentID := obj.S['id'];
          CardPayment.PaymentStatus := Ord(cpsProcessed);
          CardPayment.StatusComment := 'Processed';
          result := true;
        finally
          obj.Free;
        end;
      end
      else begin
        result := false;
        msg := 'Nothing returned from Stripe Server for Charge Request';
        exit;
      end;

    except
      on E: EIdHTTPProtocolException do begin
        result := false;
        if E.ErrorMessage <> '' then
          msg := GetErrorMessage(E.ErrorMessage)
        else
          msg := E.Message;
        CardPayment.PaymentStatus := Ord(cpsFailed);
        CardPayment.StatusComment := msg;
      end;
      on E: Exception do begin
        result := false;
        msg := E.Message;
        CardPayment.PaymentStatus := Ord(cpsFailed);
        CardPayment.StatusComment := msg;
      end;
    end;
  finally
    http.Free;
    sl.Free;
  end;
end;

function TStripeGateway.CurrencyToInt(const aAmount: double;
  const aCurrencyCode: string; Conn: TDbConnection): integer;
var
  x,i: integer;
  val: double;
  qry: TDbQuery;
begin
  x := 0;
  val := aAmount;
  qry := TDbQuery.Create(nil);
  try
    qry.DBConnection := Conn;
    qry.SQL.Add('select DecimalPlaces, ForeignExDefault from tblRegionalOptions');
    qry.SQL.Add('where ForeignExDefault = ' + QuotedStr(aCurrencyCode));
    qry.Open;
    if qry.IsEmpty then
      raise Exception.Create('No record defined in Regional Options for Currency ' + aCurrencyCode);
    x := qry.FieldByName('DecimalPlaces').AsInteger;
  finally
    qry.Free;
  end;
  for I := 1 to x do
    val := val * 10;
  result := Round(val);
end;

function TStripeGateway.CurrencyToInt(const aAmount: double; const aCurrencyCode, aDatabase: string): integer;
var
  conn: TDbConnection;
begin
  conn := TDbGen.NewConnection(aDatabase);
  try
    conn.Connect;
    result := CurrencyToInt(aAmount,aCurrencyCode,conn);
  finally
    conn.Free;
  end;
end;

function TStripeGateway.GetErrorMessage(const aStr: string): string;
var
  json: TJSONObject;
begin
  result := aStr;
  try
    json := TJSONObject.StrToJsonObject(aStr);
    try
      if json.ObjectExists('error') then
        result := json.O['error'].S['message'];
      if result = '' then
        result := aStr;
    finally
      json.Free;
    end;
  except

  end;

end;

(*
function TStripeGateway.CreateCharge(const CardToken: string; aCustomerPaymentID: integer; desc, aDatabase: string; var msg: string): string;
var
  qry: TDbQuery;
  conn: TDbConnection;
begin
  result := '';
  conn := TDbGen.NewConnection(aDatabase);
  try
    qry := TDbQuery.Create(conn);
    conn.Connect;
    qry.DBConnection := conn;
    qry.SQL.Text := 'select * from tbldeposits where PaymentID = ' + IntToStr(aCustomerPaymentID);
    qry.Open;
    result := CreateCharge(CardToken,qry.FieldByName('ForeignCurrencyAmount').AsFloat,qry.FieldByName('ForeignExchangeCode').AsString,desc,aDatabase,msg);
  finally
    conn.Free;
  end;
end;

{ returnes the id of the newly created charge if successful }
function TStripeGateway.CreateCharge(const CardToken: string; amount: double; currency: string; desc, aDatabase: string; var msg: string): string;
var
  params: string;
  http: TIdHTTP;
  sl: TStringList;
  s: string;
  obj: TJsonObject;
  amountInt: integer;
begin
//    urlParams :=
//      '?amount=2000&currency=aud&description=test&source=' + token;
//      s := client.Post('https://api.stripe.com/v1/charges'+ urlParams,params);
  result := '';
  amountInt := CurrencyToInt(amount,currency,aDatabase);

  http := NewNTTPClient;
  sl := TStringList.Create;
  try
    if TestMode then
      http.Request.Username := Stripe_TestSecretKey
    else
      http.Request.Username := Stripe_LiveSecretKey;

    params :=
      '?amount=' + IntToStr(amountInt) +
      '&currency='  + currency +
      '&source='    + CardToken;
    if desc <> '' then
      params := params + '&description=' + URILib.PercentEncode(desc);

    try
      s := http.Post(StripeBaseURL + 'charges' + params, sl);

      if s <> '' then begin
        obj := TJSONObject.StrToJsonObject(s);
        try
          result := obj.S['id'];
        finally
          obj.Free;
        end;
      end
      else begin
        msg := 'Nothing returned from Stripe Server for Charge Request';
      end;

    except
      on E: EIdHTTPProtocolException do begin
        if E.ErrorMessage <> '' then
          msg := GetErrorMessage(E.ErrorMessage)
        else
          msg := E.Message;
      end;
      on E: Exception do begin
        msg := E.Message;
      end;
    end;
  finally
    http.Free;
    sl.Free;
  end;
end;
*)

function TStripeGateway.TestGateway(var msg: string; UseTest: boolean): boolean;
var
  http: TIdHTTP;
  key: string;
  s: string;
begin
//  result := true;
  if UseTest then begin
    if Stripe_TestSecretKey = '' then begin
      result := false;
      msg := 'Please enter the Stripe Test Secret Key into the Payment Gateway Preferences for your Stripe Account.';
      exit;
    end;
    key := Stripe_TestSecretKey;
  end
  else begin
    {live}
    if Stripe_LiveSecretKey = '' then begin
      result := false;
      msg := 'Please enter the Stripe Live Secret Key into the Payment Gateway Preferences for your Stripe Account.';
      exit;
    end;
    key := Stripe_LiveSecretKey;
  end;

  { base class sets up client .. }
  http := NewNTTPClient;
  try
    { Stripe just use key as user name, password not required .. }
    http.Request.Username := key;

    try
      s := http.Get(StripeBaseURL + 'balance');
      result := http.ResponseCode = 200;
      if not result then begin
        msg := 'Unknown error';
        Log('TestGateway failed with error: ' + msg, ltError);
      end
      else
        Log('TestGateway OK', ltDetail);
    except
      on E: EIdHTTPProtocolException do begin
        result := false;
        if E.ErrorMessage <> '' then
          msg := GetErrorMessage(E.ErrorMessage)
        else
          msg := E.Message;
        Log('TestGateway failed with error: ' + msg, ltError);
        exit;
      end;
      on E: Exception do begin
        result := false;
        msg := E.Message;
        Log('TestGateway failed with error: ' + msg, ltError);
        exit;
      end;
    end;
  finally
    http.Free;
  end;
end;

end.
