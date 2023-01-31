unit GatewayTransactionExpress;

interface
uses
  GatewayBase, CardPaymentObj, DbGen;

type
  TTransactionExpressGateway = class(TBaseGateway)
  private
    fID: string;
    fRegKey: string;
  public
    function CreateCharge(var CardPayment: TCardPayment; Conn: TDbConnection; var msg: string): boolean;
    property ID: string read fID write fID;
    property RegKey: string read fRegKey write fRegKey;
    function TestGateway(var msg: string): boolean;
  end;

implementation

{$Define CertMode}

uses
  PaymentGatewayConst,
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
  TransactionExpressUtils,

{$IfDef CertMode}
  MerchantWebServices_v1_Cert
{$Else}
  MerchantWebServices_v1_Prod
{$EndIf}
;

const

  ProdDefWSDL = 'https://ws.processnow.com/portal/merchantframework/MerchantWebServices-v1?wsdl';
  ProdDefURL  = 'https://ws.transactionexpress.com/portal/merchantframework/MerchantWebServices-v1';

  CertDefWSDL = 'https://ws.cert.transactionexpress.com/portal/merchantframework/MerchantWebServices-v1?wsdl';
  CertDefURL  = 'https://ws.cert.transactionexpress.com/portal/merchantframework/MerchantWebServices-v1';


{ TTransactionExpressGateway }

function TTransactionExpressGateway.CreateCharge(var CardPayment: TCardPayment;
  Conn: TDbConnection; var msg: string): boolean;
var
  merchant: Merc;
  cc: Card;
  request: SendTranRequest;
  response: SendTranResponse;
  service: MerchantWebServicesPortType;
  s: string;
begin
  result := true;
  try
    merchant := Merc.Create;
    merchant.id := ID;
    merchant.inType := 1;
    merchant.regKey := RegKey;

    cc := Card.Create;
    cc.pan := CardPayment.Card.Number;
    cc.xprDt := CardPayment.Card.CardExpiryYYMM;

    request := SendTranRequest.Create;
    request.merc := merchant;
    request.card := cc;

    request.reqAmt := FormatFloat('"0"#00',CardPayment.Amount);
    request.tranCode := tranCode._1;

    CoInitialize(nil);
    try
      service := GetMerchantWebServicesPortType;

      response := service.SendTran(request);
      if DecodeTransactionResponse(response.extRspCode,s) then begin
        { success }
        CardPayment.PaymentID := response.tranData.tranNr;
        CardPayment.PaymentStatus := Ord(cpsProcessed);
        CardPayment.StatusComment := 'Processed';
      end
      else begin
        { fail }
        result := false;
        msg := s;
      end;

    finally
      CoUninitialize;
    end;
  except
    on e: exception do begin
      result := false;
      if e is SystemFault then begin
        msg := SystemFault(e).message_ + ' Code: ' + SystemFault(e).errorCode;
        s := DecodeErrorCode(SystemFault(e).errorCode);
        if s <> '' then msg := msg + ' ' + s;
      end
      else if e is ServiceFault then begin
        msg := ServiceFault(e).message_ + ' Code: ' + ServiceFault(e).errorCode;
        s := DecodeErrorCode(ServiceFault(e).errorCode);
        if s <> '' then msg := msg + ' ' + s;
      end
      else begin
//        msg := 'Error sending request to Transaction Express: ' + e.Message;
        msg := e.Message;
      end;
      Log(msg,ltError);
      Log('Exception Type: ' + e.ClassName,ltError);
    end;
  end;

end;

function TTransactionExpressGateway.TestGateway(var msg: string): boolean;
begin
  result := true;
end;

end.
