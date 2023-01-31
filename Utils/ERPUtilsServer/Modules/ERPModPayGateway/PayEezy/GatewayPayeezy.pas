unit GatewayPayeezy;

interface

uses
  GatewayBase, CardPaymentObj, DbGen;

type
  TPayeezyGateway = class(TBaseGateway)
  private
    fPassword: string;
    fID: string;
    fTestMode: boolean;
  public
    function CreateCharge(var CardPayment: TCardPayment; Conn: TDbConnection; var msg: string): boolean;
    property ID: string read fID write fID;
    property Password: string read fPassword write fPassword;
    property TestMode: boolean read fTestMode write fTestMode;
    function TestGateway(var msg: string): boolean;
  end;

implementation

uses
  PayeezySOAP,
  {$IfDef VER220}
  Sysutils,
  StrUtils,
  ActiveX,
  {$Else}
  System.Sysutils,
  System.StrUtils,
  WinAPI.ActiveX,
  {$EndIf}
  LogMessageTypes,
  PaymentGatewayConst;

const
  DemoURL = 'https://api.demo.globalgatewaye4.firstdata.com/transaction';
  LiveURL = 'https://api.globalgatewaye4.firstdata.com/transaction';

{ TPayeezyGateway }

function TPayeezyGateway.CreateCharge(var CardPayment: TCardPayment;
  Conn: TDbConnection; var msg: string): boolean;
var
  Service: ServiceSoap;
  Url: string;
  Trans: Transaction;
  TransResult: TransactionResult;
begin
  result := true;
  TransResult := nil;
  try
    if TestMode then Url := DemoURL
//    else Url := '';
    else Url := LiveURL;
    Service := PayeezySOAP.GetServiceSoap(false,Url);

    CoInitialize(nil);
    try
      Trans := Transaction.Create;
      Trans.ExactID := ID;
      Trans.Password := Password;
      if CardPayment.Amount >= 0 then begin
        Trans.Transaction_Type := PZ_TxnType_Purchase;
      end
      else begin
        Trans.Transaction_Type := PZ_TxnType_Refund;
      end;

      Trans.DollarAmount := FormatFloat('#0.00',Abs(CardPayment.Amount));
      Trans.Card_Number := CardPayment.Card.Number;
      Trans.Expiry_Date := CardPayment.Card.CardExpiryMMYY;
      Trans.CardHoldersName := CardPayment.Card.CardholderName;
      if CardPayment.Card.CVC <> '' then begin
        Trans.CVDCode := CardPayment.Card.CVC;
        Trans.CVD_Presence_Ind := '1';
      end
      else begin
        Trans.CVDCode := '';
        Trans.CVD_Presence_Ind := '0';
      end;
      Trans.Currency := CardPayment.CurrencyCode;
      Trans.Customer_Ref := IntToStr(CardPayment.ID);

      try
        TransResult := Service.SendAndCommit(Trans);
      except
        on e: exception do begin
          result := false;
          msg := e.Message;
        end;
      end;

    finally
      CoUninitialize;
    end;
    if TransResult.Transaction_Error then begin
      result := false;
      msg := TransResult.EXact_Message;

      exit;
    end;
    if not TransResult.Transaction_Approved then begin
      result := false;
      msg := TransResult.EXact_Message;

      exit;
    end;

    CardPayment.PaymentID := TransResult.SequenceNo;
    CardPayment.PaymentStatus := Ord(cpsProcessed);
    CardPayment.StatusComment := 'Processed';


  except
    on e: exception do begin
      result := false;
      msg := 'Error sending request to Payeezy: ' + e.Message;
      Log(msg,ltError);
      Log('Exception Type: ' + e.ClassName,ltError);
    end;
  end;

end;

function TPayeezyGateway.TestGateway(var msg: string): boolean;
var
  Service: ServiceSoap;
  Url: string;
  Trans: Transaction;
//  TransResult: TransactionResult;
begin
  result := true;
  try
    if TestMode then Url := DemoURL
//    else Url := '';
    else Url := LiveURL;
    Service := PayeezySOAP.GetServiceSoap(false,Url);

    CoInitialize(nil);
    try
      Trans := Transaction.Create;
      Trans.ExactID := ID;
      Trans.Password := Password;

//      TransResult := Service.SendAndCommit(Trans);
      Service.SendAndCommit(Trans);

    finally
      CoUninitialize;
    end;

  except
    on e: exception do begin
      if Pos('Unauthorized',e.Message) > 0 then begin
        result := false;
        msg := 'Unauthorized';
        Log(msg,ltError);
        //Log('Exception Type: ' + e.ClassName,ltError);
      end;
    end;
  end;
end;

end.
