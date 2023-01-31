unit CreditCardObj;

interface

type
  {$M+}
  TCreditCard = class(TObject)
  private
    FAddressZip: string;
    FAddressState: string;
    FExpMonth: integer;
    FAddressLine2: string;
    FAddressLine1: string;
    FCVC: string;
    FAddressCountry: string;
    FCardType: string;
    FAddressCity: string;
    FCardholderName: string;
    FNumber: string;
    FExpYear: integer;
    fGatewayName: string;
    procedure SetAddressCity(const Value: string);
    procedure SetAddressCountry(const Value: string);
    procedure SetAddressLine1(const Value: string);
    procedure SetAddressLine2(const Value: string);
    procedure SetAddressState(const Value: string);
    procedure SetAddressZip(const Value: string);
    procedure SetCardholderName(const Value: string);
    procedure SetCardType(const Value: string);
    procedure SetCVC(const Value: string);
    procedure SetExpMonth(const Value: integer);
    procedure SetExpYear(const Value: integer);
    procedure SetNumber(const Value: string);
  public
    function LoadFromErpClient(aClientID: integer; aDatabase, aServer: string; var msg: string): boolean;
    function SaveToErpClient(aClientID: integer; aDatabase, aServer: string; var msg: string): boolean;
    function HiddenNumber: string;
    function CardExpiryDate: string; { convert to format used in tblclients }
    function CardExpiryMMYY: string;
    function CardExpiryYYMM: string;
    class function CardTypeFromNumber(const aCardNo: string): string;
  published
    property ExpYear: integer read FExpYear write SetExpYear;
    property ExpMonth: integer read FExpMonth write SetExpMonth;
    property Number: string read FNumber write SetNumber;
    property CVC: string read FCVC write SetCVC;
    property CardholderName: string read FCardholderName write SetCardholderName;

    property GatewayName: string read fGatewayName write fGatewayName;

    property CardType: string read FCardType write SetCardType;
    property AddressLine1: string read FAddressLine1 write SetAddressLine1;
    property AddressLine2: string read FAddressLine2 write SetAddressLine2;
    property AddressCity: string read FAddressCity write SetAddressCity;
    property AddressState: string read FAddressState write SetAddressState;
    property AddressZip: string read FAddressZip write SetAddressZip;
    property AddressCountry: string read FAddressCountry write SetAddressCountry;
  end;
  {$M-}

implementation

uses
  {$IfDef VER220}
  SysUtils,
  StrUtils,
  {$Else}
  System.SysUtils,
  System.StrUtils,
  Data.DB,
  {$EndIf}
  DbGen, EncryptFix,  CipherUtils;

{ TCreditCard }

function TCreditCard.CardExpiryDate: string;
begin
  if (ExpYear > 0) and (ExpMonth > 0) then
    result := IntToStr(ExpMonth) + '/' + Copy(IntToStr(ExpYear),3,2)
  else
    result := '';
end;

// https://en.wikipedia.org/wiki/Payment_card_number
function TCreditCard.CardExpiryMMYY: string;
var
  s: string;
begin
  result := IntToStr(ExpMonth);
  while Length(result) < 2 do
    result := '0' + result;

  s := IntToStr(ExpYear);
  if Length(s) > 2 then
    s := RightStr(s,2)
  else begin
    while Length(s) < 2 do
      s:= '0' + s;
  end;
  result := result + s;
end;

function TCreditCard.CardExpiryYYMM: string;
var
  s: string;
begin
  result := IntToStr(ExpYear);
  if Length(result) > 2 then
    result := RightStr(result,2)
  else begin
    while Length(result) < 2 do
      result := '0' + result;
  end;

  s := IntToStr(ExpMonth);
  while Length(s) < 2 do
    s := '0' + s;

  result := result + s;
end;

class function TCreditCard.CardTypeFromNumber(const aCardNo: string): string;
begin
  result := '';
  if Length(aCardNo) < 10 then exit;
  if Pos('#',aCardNo) > 0 then exit;


  if (LeftStr(aCardNo,2) = '34') or (LeftStr(aCardNo,2) = '37') then
    result := 'American Express'
  else if (LeftStr(aCardNo,2) = '62') then
    result := 'China UnionPay'
  else if (LeftStr(aCardNo,2) = '36') or (LeftStr(aCardNo,2) = '38') or (LeftStr(aCardNo,2) = '39') or
    (LeftStr(aCardNo,4) = '3095') or
    ((StrToInt(LeftStr(aCardNo,3)) >= 300) and (StrToInt(LeftStr(aCardNo,3)) <= 305)) then
    result := 'Diners Club International'
//  else if (LeftStr(aCardNo,2) = '54') or (LeftStr(aCardNo,2) = '55') then
//    result := 'Diners Club'
  else if (LeftStr(aCardNo,2) = '64') or (LeftStr(aCardNo,2) = '65') or (LeftStr(aCardNo,4) = '6011') then
    result := 'Discover Card'
  else if (LeftStr(aCardNo,3) = '636') then
    result := 'InterPayment'
  else if ((StrToInt(LeftStr(aCardNo,3)) >= 637) and (StrToInt(LeftStr(aCardNo,3)) <= 639)) then
    result := 'InstaPayment'
  else if ((StrToInt(LeftStr(aCardNo,4)) >= 3528) and (StrToInt(LeftStr(aCardNo,4)) <= 3589)) then
    result := 'JCB'
  else if (LeftStr(aCardNo,4) = '6304') or (LeftStr(aCardNo,4) = '6706') or
    (LeftStr(aCardNo,4) = '6771') or (LeftStr(aCardNo,4) = '6709') then
    result := 'Laser'
  else if (LeftStr(aCardNo,2) = '50') or (LeftStr(aCardNo,1) = '6') or
    ((StrToInt(LeftStr(aCardNo,2)) >= 56) and (StrToInt(LeftStr(aCardNo,2)) <= 58)) then
    result := 'Maestro'
  else if ((StrToInt(LeftStr(aCardNo,4)) >= 2200) and (StrToInt(LeftStr(aCardNo,4)) <= 2204)) then
    result := 'MIR'
  else if ((StrToInt(LeftStr(aCardNo,4)) >= 2221) and (StrToInt(LeftStr(aCardNo,4)) <= 2720)) or
          ((StrToInt(LeftStr(aCardNo,2)) >= 51) and (StrToInt(LeftStr(aCardNo,2)) <= 55)) then
    result := 'MasterCard'
  else if (LeftStr(aCardNo,4) = '6334') or (LeftStr(aCardNo,4) = '6767') then
    result := 'Solo'
  else if (LeftStr(aCardNo,4) = '4903') or (LeftStr(aCardNo,4) = '4905') or
          (LeftStr(aCardNo,4) = '4911') or (LeftStr(aCardNo,4) = '4936') or
          (LeftStr(aCardNo,6) = '564182') or (LeftStr(aCardNo,6) = '633110') or
          (LeftStr(aCardNo,4) = '6333') or (LeftStr(aCardNo,4) = '6759') then
    result := 'Switch'
  else if (LeftStr(aCardNo,1) = '4') then
    result := 'Visa'
  else if (LeftStr(aCardNo,1) = '1') then
    result := 'UATP'
  else if ((StrToInt(LeftStr(aCardNo,6)) >= 506099) and (StrToInt(LeftStr(aCardNo,6)) <= 506198)) or
          ((StrToInt(LeftStr(aCardNo,6)) >= 650002) and (StrToInt(LeftStr(aCardNo,6)) <= 650027)) then
    result := 'Verve'
  else if ((StrToInt(LeftStr(aCardNo,6)) >= 979200) and (StrToInt(LeftStr(aCardNo,6)) <= 979589)) then
    result := 'TROY'
  else if (LeftStr(aCardNo,4) = '5392') then
    result := 'CARDGUARD EAD BG ILS';

end;

function TCreditCard.HiddenNumber: string;
var
  x, cnt: integer;
begin
  result := '';
  cnt := 1;
  for x := Length(Number) downto 1 do begin
    if cnt <= 4 then
      result := Number[x] + result
    else
      result := '#' + result;
    Inc(cnt);
  end;
end;

function TCreditCard.LoadFromErpClient(aClientID: integer; aDatabase, aServer: string; var msg: string): boolean;
var
  conn: TDbConnection;
  qry: TDbQuery;
  x: integer;
  Server: string;
  expDate: string;
begin
  result := true;
  { get credit card data from database .. }
  Server := aServer;
  if Server = '' then  Server := '127.0.0.1';

  conn := TDbGen.NewConnection(aDatabase,Server);
  qry := TDbQuery.Create(nil);
  try
    qry := TDbQuery.Create(conn);
    qry.DBConnection := conn;
    conn.Connect;
    qry.SQL.Add('select CreditCardCardHolderName, CreditCardExpiryDate,');
    qry.SQL.Add('CreditCardNumber, CreditCardCVC, CreditCardNotes, CreditCardType');
    qry.SQL.Add('from tblClients where ClientID = ' + IntToStr(aClientID));
    qry.Open;
    if qry.IsEmpty then begin
      result := false;
      msg := 'Client not found for ID ' + IntToStr(aClientID);
      exit;
    end;
    self.CardType := qry.FieldByName('CreditCardType').AsString;
    self.Number := EncryptFix.DecryptString(qry.FieldByName('CreditCardNumber').AsString);
    if self.Number = '' then begin
      result := false;
      msg := 'Card Number is Blank on Customer Card.';
      exit;
    end;
    self.CVC := qry.FieldByName('CreditCardCVC').AsString;
    self.CardholderName := qry.FieldByName('CreditCardCardHolderName').AsString;
    expDate := Trim(qry.FieldByName('CreditCardExpiryDate').AsString);
    x := Pos('/',expDate);
    if x < 2 then begin
      result := false;
      msg := 'Invalid Card Expiry Date on Customer Card';
      exit;
    end;
    self.ExpMonth := StrToInt(Copy(expDate,1,x-1));
    expDate := Copy(expDate,x+1,255);
    if Length(expDate) = 2 then
      expDate := Copy(FormatDateTime('yyyy',now),1,2) + expDate;
    self.ExpYear := StrToInt(expDate);
  finally
    qry.Free;
    conn.Free;
  end;
end;

function TCreditCard.SaveToErpClient(aClientID: integer; aDatabase,
  aServer: string; var msg: string): boolean;
var
  conn: TDbConnection;
  qry: TDbQuery;
  Server: string;
begin
  result := true;
  { get credit card data from database .. }
  Server := aServer;
  if Server = '' then  Server := '127.0.0.1';

  try
    conn := TDbGen.NewConnection(aDatabase,Server);
    try
      qry := TDbQuery.Create(conn);
      conn.Connect;
      conn.StartTransaction;
      qry.SQL.Add('update tblclients');
      qry.SQL.Add('set CreditCardNumber = ' + QuotedStr(CipherUtils.EncryptString(self.Number)));
      qry.SQL.Add(', CreditCardExpiryDate = ' + QuotedStr(self.CardExpiryDate));
      qry.SQL.Add(', CreditCardCardHolderName = ' + QuotedStr(self.CardholderName));
      if self.CVC <> '' then
        qry.SQL.Add(', CreditCardCVC = ' + QuotedStr(self.CVC))
      else
        qry.SQL.Add(', CreditCardCVC = NULL');
      qry.SQL.Add(', CreditCardType = ' + QuotedStr(CardTypeFromNumber(Number)));
      qry.SQL.Add('where ClientID = ' + IntToStr(aClientID));
      qry.Execute;
      conn.Commit;
    finally
      if conn.InTransaction then
        conn.Rollback;
      conn.Free;
    end;
  except
    on e: exception do begin
      result := false;
      msg := 'Unable to Save Card Details: ' + e.Message;

    end;

  end;
end;

procedure TCreditCard.SetAddressCity(const Value: string);
begin
  FAddressCity := Value;
end;

procedure TCreditCard.SetAddressCountry(const Value: string);
begin
  FAddressCountry := Value;
end;

procedure TCreditCard.SetAddressLine1(const Value: string);
begin
  FAddressLine1 := Value;
end;

procedure TCreditCard.SetAddressLine2(const Value: string);
begin
  FAddressLine2 := Value;
end;

procedure TCreditCard.SetAddressState(const Value: string);
begin
  FAddressState := Value;
end;

procedure TCreditCard.SetAddressZip(const Value: string);
begin
  FAddressZip := Value;
end;

procedure TCreditCard.SetCardholderName(const Value: string);
begin
  FCardholderName := Value;
end;

procedure TCreditCard.SetCardType(const Value: string);
begin
  FCardType := Value;
end;

procedure TCreditCard.SetCVC(const Value: string);
begin
  FCVC := Value;
end;

procedure TCreditCard.SetExpMonth(const Value: integer);
begin
  FExpMonth := Value;
end;

procedure TCreditCard.SetExpYear(const Value: integer);
begin
  FExpYear := Value;
end;

procedure TCreditCard.SetNumber(const Value: string);
begin
  FNumber := Value;
end;

end.
