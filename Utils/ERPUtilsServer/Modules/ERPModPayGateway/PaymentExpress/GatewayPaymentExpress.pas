unit GatewayPaymentExpress;

interface

uses
  GatewayBase, CardPaymentObj, DbGen;

type
  TPaymentExpressGateway = class(TBaseGateway)
  private
    fPassword: string;
    fUserName: string;
  public
    function CreateCharge(var CardPayment: TCardPayment; Conn: TDbConnection; var msg: string): boolean;
    property UserName: string read fUserName write fUserName;
    property Password: string read fPassword write fPassword;
    function TestGateway(var msg: string): boolean;
  end;


implementation

uses
  PXWS,
  {$IfDef VER220}
  Sysutils,
  StrUtils,
  ActiveX,
  {$Else}
  System.Sysutils,
  System.StrUtils,
  WinAPI.ActiveX,
  {$EndIf}
  PaymentGatewayConst;


{ TPaymentExpressGateway }

function TPaymentExpressGateway.CreateCharge(var CardPayment: TCardPayment;
  Conn: TDbConnection; var msg: string): boolean;
var
  PXSOAP: PaymentExpressWSSoap;
  Trans: TransactionDetails;
  TransResult: TransactionResult2;
//  s: string;
  postPassword, postUsername: string;
begin
  result := true;
  TransResult := nil;
  try
    PXSOAP := PXWS.GetPaymentExpressWSSoap();
  except
    on e: exception do begin
      result := false;
      msg := 'Error Processing Payment Express: ' + e.Message;
      exit;
    end;
  end;

  Trans := TransactionDetails.Create;
  postPassword := fPassword;  { these are passed in the request }
  postUsername := fUserName;


  Trans.amount := FormatFloat('#.00',CardPayment.Amount);
  Trans.inputCurrency := CardPayment.CurrencyCode;
  if CardPayment.Card.CardholderName <> '' then
    Trans.cardHolderName := CardPayment.Card.CardholderName;
  Trans.cardNumber := CardPayment.Card.Number;
  Trans.txnType := PX_TxnType_Purchase;
  Trans.txnRef := IntToStr(CardPayment.ID);

  Trans.dateExpiry := CardPayment.Card.CardExpiryMMYY;

  if CardPayment.Card.CVC <> '' then begin
    Trans.cvc2 := CardPayment.Card.CVC;
    Trans.cvc2Presence := '1';
  end
  else begin
    Trans.cvc2Presence := '0';
  end;

  CoInitialize(nil);
  try

    try
      TransResult := PXSOAP.SubmitTransaction(postUsername,postPassword,Trans);
      if TransResult.authorized = '1' then begin
        CardPayment.PaymentID := TransResult.authCode;
        CardPayment.PaymentStatus := Ord(cpsProcessed);
        CardPayment.StatusComment := 'Processed';
        if TransResult.statusRequired = '0' then
          exit;
        { else get the status below }
      end
      else begin
        { not authorized }
        result := false;
        msg := TransResult.cardHolderResponseDescription;
        if TransResult.acquirerresponsetext <> msg then
          msg := msg + #13#10 + TransResult.acquirerresponsetext;
        CardPayment.PaymentStatus := Ord(cpsFailed);
        CardPayment.StatusComment := msg;
        exit;
      end;
    except
      on e: exception do begin
        if Assigned(TransResult) then begin
          { somthing returned .. but error returned }
          if TransResult.authorized = '1' then begin
            CardPayment.PaymentID := TransResult.authCode;
            CardPayment.PaymentStatus := Ord(cpsProcessed);
            CardPayment.StatusComment := 'Processed';
            if TransResult.statusRequired = '0' then
              exit;
            { else get the status below }
          end
          else begin
            result := false;
            msg := TransResult.cardHolderResponseDescription;
            if TransResult.acquirerresponsetext <> msg then
              msg := msg + #13#10 + TransResult.acquirerresponsetext;
            CardPayment.PaymentStatus := Ord(cpsFailed);
            CardPayment.StatusComment := msg;
            exit;
          end;
        end
        else begin
          { error }
          result := false;
          msg := E.Message;
          CardPayment.PaymentStatus := Ord(cpsFailed);
          CardPayment.StatusComment := msg;
          exit;
        end;
      end;
    end;

    { at this point we don't know the status of the transaction ..}
    try
      TransResult := PXSOAP.GetStatus(postUsername,postPassword,IntToStr(CardPayment.ID));
      if TransResult.authorized = '1' then begin
        CardPayment.PaymentID := TransResult.authCode;
        CardPayment.PaymentStatus := Ord(cpsProcessed);
        CardPayment.StatusComment := 'Processed';
        exit;
        { else get the status below }
      end
      else begin
        { not authorized }
        result := false;
        msg := TransResult.cardHolderResponseDescription;
        if TransResult.acquirerresponsetext <> msg then
          msg := msg + #13#10 + TransResult.acquirerresponsetext;
        CardPayment.PaymentStatus := Ord(cpsFailed);
        CardPayment.StatusComment := msg;
        exit;
      end;
    except
      on e: exception do begin
        if Assigned(TransResult) then begin
          { somthing returned .. but error returned }
          if TransResult.authorized = '1' then begin
            CardPayment.PaymentID := TransResult.authCode;
            CardPayment.PaymentStatus := Ord(cpsProcessed);
            CardPayment.StatusComment := 'Processed';
            exit;
          end
          else begin
            result := false;
            msg := TransResult.cardHolderResponseDescription;
            if TransResult.acquirerresponsetext <> msg then
              msg := msg + #13#10 + TransResult.acquirerresponsetext;
            CardPayment.PaymentStatus := Ord(cpsFailed);
            CardPayment.StatusComment := msg;
            exit;
          end;
        end
        else begin
          { error }
          result := false;
          msg := E.Message;
          CardPayment.PaymentStatus := Ord(cpsFailed);
          CardPayment.StatusComment := msg;
          exit;
        end;
      end;
    end;
  finally
    CoUninitialize;
  end;
end;

function TPaymentExpressGateway.TestGateway(var msg: string): boolean;
var
  PXSOAP: PaymentExpressWSSoap;
  TransResult: TransactionResult2;
  postPassword, postUsername: string;
begin
  result := true;
  TransResult := nil;
  try
    PXSOAP := PXWS.GetPaymentExpressWSSoap();
  except
    on e: exception do begin
      result := false;
      msg := 'Error Processing Payment Express: ' + e.Message;
      exit;
    end;
  end;
  CoInitialize(nil);
  try
    postPassword := fPassword;  { these are passed in the request }
    postUsername := fUserName;

    { try to get info on a non existent transaction to test basic comms .. }
    try
      TransResult := PXSOAP.GetStatus(postUsername,postPassword,'0');
      if TransResult.authorized = '1' then begin
        exit;
        { else get the status below }
      end
      else begin
        { not authorized }
//        result := false;
        if SameText(TransResult.responseText,'User Access Error') then begin
          result := false;
          msg := TransResult.responseText;
          exit;
        end;
      end;
    except
      on e: exception do begin
        if Assigned(TransResult) then begin
          { somthing returned .. but error returned }
          if TransResult.authorized = '1' then begin
            exit;
          end
          else begin
//            result := false;
            msg := TransResult.cardHolderResponseDescription;
            if TransResult.acquirerresponsetext <> msg then
              msg := msg + #13#10 + TransResult.acquirerresponsetext;
            exit;
          end;
        end
        else begin
          { error }
//          result := false;
          msg := E.Message;
          exit;
        end;
      end;
    end;


  finally
    CoUninitialize;
  end;
end;

end.
