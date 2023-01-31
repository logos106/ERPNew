unit CardPaymentObj;

interface

uses

  {$IfDef VER220}
  Classes,
  {$Else}
  System.Classes,
  {$EndIf}
  CreditCardObj;

type
  TCardPaymentStatus = (cpsNone, cpsProcessed, cpsFailed);

  {$M+}
  TCardPayment = class(TObject)
  private
    fMsUpdateSiteCode: string;
    fERPTransID: integer;
    fCurrencyCode: string;
    fPaymentID: string;
    fERPTransType: string;
    fMsTimeStamp: TDateTime;
    fID: integer;
    fAmount: double;
    fDescription: string;
    fCard: TCreditCard;
    fStatusComment: string;
    fGateway: string;
    fPaymentStatus: integer;
    fGlobalRef: string;
    fRefID: string;
    fCardNumber: string;
    fERPBankAccount: string;
    function GetCardData: string;
    procedure SetCardData(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property Card: TCreditCard read fCard;
    class function TableName: string;
    class function PaymentMade(const aERPTransType: string; const aERPTransID: integer; const aDatabase, aServer: string): boolean;
  published
    property ID: integer read fID write fID;                      { erp db ID }
    property GlobalRef: string read fGlobalRef write fGlobalRef;  { erp db GlobalRef }
    property MsUpdateSiteCode: string read fMsUpdateSiteCode write fMsUpdateSiteCode; { erp db MsUpdateSiteCode }
    property MsTimeStamp: TDateTime read fMsTimeStamp write fMsTimeStamp; { erp db MsTimStamp }

    property PaymentID: string read fPaymentID write fPaymentID; { id returned from gateway }
    property Gateway: string read fGateway write fGateway;  { eg Stripe or Authorize }
    property Amount: double read fAmount write fAmount;     { charge amount in specified currency }
    property CurrencyCode: string read fCurrencyCode write fCurrencyCode;  { eg AUD }
    property RefID: string read fRefID write fRefID;        { ERP assigned reference }
    property Description: string read fDescription write fDescription; { erp assigned description }
    property CardNumber: string read fCardNumber write fCardNumber;  { last 4 digits of card for reference }
    property CardData: string read GetCardData write SetCardData;    { encrypted TCreditCard }

    property ERPTransType: string read fERPTransType write fERPTransType; { erp linked Transaction type eg CustomerPayment }
    property ERPTransID: integer read fERPTransID write fERPTransID;      { erp id of linked Transaction eg Customer Payment ID }
    property ERPBankAccount: string read fERPBankAccount write fERPBankAccount; { ERP bank account where funds will be deposited }
    property PaymentStatus: integer read fPaymentStatus write fPaymentStatus;
    property StatusComment: string read fStatusComment write fStatusComment;
  end;
  {$M-}

implementation

uses
  JsonToObject, SysUtils, DbGen;

{ TCardPayment }

constructor TCardPayment.Create;
begin
  fCard := TCreditCard.Create;
  PaymentStatus := Ord(cpsNone);
  ID := 0;
end;

destructor TCardPayment.Destroy;
begin
  fCard.Free;
  inherited;
end;

function TCardPayment.GetCardData: string;
begin
  result := ObjToStr(fCard,true);
end;

class function TCardPayment.PaymentMade(const aERPTransType: string;
  const aERPTransID: integer; const aDatabase, aServer: string): boolean;
var
  conn: TDbConnection;
  qry: TDbQuery;
begin
  conn := TDbGen.NewConnection(aDatabase,aServer);
  try
    conn.Connect;
    qry := TDbQuery.Create(conn);
    qry.SQL.Text := 'select ID from ' + TCardPayment.TableName +
      ' where ERPTransType = ' + QuotedStr(aERPTransType) +
      ' and ERPTransID = ' + IntToStr(aERPTransID) +
      ' and PaymentStatus = 1';
    qry.Open;
    result := not qry.IsEmpty;
  finally
    conn.Free;
  end;
end;

procedure TCardPayment.SetCardData(const Value: string);
begin
  StrToObj(Value,fCard,true);
end;

class function TCardPayment.TableName: string;
begin
  result := 'tblCardPayment';
end;

end.
