unit ModPaymentGateway;

interface

{$I PaymentGateway.inc}

uses
  ServerModuleObj, JSONObject, LogThreadBase, CardPaymentObj, DbGen;

type
  TModPaymentGateway = class(TServerModule)
  private
    fStripe_LiveSecretKey: string;
    fStripe_Enabled: boolean;
    fStripe_TestSecretKey: string;
    fStripe_BankAccountInfo: string;
    fStripe_TestMode: boolean;
    fPaymentExpress_Enabled: boolean;
    fPaymentExpress_Password: string;
    fPaymentExpress_UserName: string;
    fPayeezy_TestMode: boolean;
    fPayeezy_ID: string;
    fPayeezy_Password: string;
    fPayeezy_Enabled: boolean;
    FTransactionExpress_ID: string;
    FTransactionExpress_RegKey: string;
    FTransactionExpress_Enabled: boolean;
    FTransactionExpress_TestMode: boolean;
    function GuiStr: string;
    function LicenceOptionEnabled(const OptionName: string): boolean;
  protected
    function GetModuleDescription: string; override;
    procedure AfterLoadConfig; override;

    procedure DoOnMessage(aClientId: integer; aData: string; ctx: TJsonObject); override;
    procedure DoOnMessage(aClientId: integer; aData: TJsonObject; ctx: TJsonObject); override;
    procedure DoOnCommandMessage(aData: string; ctx: TJsonObject); override;

    procedure DoOnRequest(aClientId: integer; aRequest: string; ctx: TJsonObject; var aResponse: string); override;
    procedure DoOnRequest(aClientId: integer; aRequest: TJsonObject; ctx: TJsonObject; aResponse: TJsonObject = nil); override;
    procedure DoOnCommandRequest(aRequest: string; var aResponse: string); override;

//    function CreateNewLogger: TLoggerBase; override;
    procedure DoWork; override;
    procedure SetActive(const Value: boolean); override;
    function EncryptConfig: boolean; override;
    function StripeLinkedAccount(const aDatabase, aCurrency: string; var msg: string): string;
    function ProcessPayment(const aCardPaymentID: integer; const aDatabase: string; var msg: string): boolean;
    function ProcessPayment_Stripe(var aCardPayment: TCardPayment; aConn: TDbConnection; var msg: string): boolean;
    function ProcessPayment_PaymentExpress(var aCardPayment: TCardPayment; aConn: TDbConnection; var msg: string): boolean;
    function ProcessPayment_Payeezy(var aCardPayment: TCardPayment; aConn: TDbConnection; var msg: string): boolean;
    function ProcessPayment_TransactionExpress(var aCardPayment: TCardPayment; aConn: TDbConnection; var msg: string): boolean;
  public
    constructor Create(aLogger: TLoggerBase = nil); override;
    destructor Destroy; override;
    procedure LoadConfig; override;
//    procedure SaveConfig; override;
  published
    property Stripe_Enabled: boolean read fStripe_Enabled write fStripe_Enabled;
    property Stripe_LiveSecretKey: string read fStripe_LiveSecretKey write fStripe_LiveSecretKey;
    property Stripe_TestSecretKey: string read fStripe_TestSecretKey write fStripe_TestSecretKey;
    property Stripe_BankAccountInfo: string read fStripe_BankAccountInfo write fStripe_BankAccountInfo;
    property Stripe_TestMode: boolean read fStripe_TestMode write fStripe_TestMode;

    property PaymentExpress_Enabled: boolean read fPaymentExpress_Enabled write fPaymentExpress_Enabled;
    property PaymentExpress_UserName: string read fPaymentExpress_UserName write fPaymentExpress_UserName;
    property PaymentExpress_Password: string read fPaymentExpress_Password write fPaymentExpress_Password;

    property Payeezy_Enabled: boolean read fPayeezy_Enabled write fPayeezy_Enabled;
    property Payeezy_ID: string read fPayeezy_ID write fPayeezy_ID;
    property Payeezy_Password: string read fPayeezy_Password write fPayeezy_Password;
    property Payeezy_TestMode: boolean read fPayeezy_TestMode write fPayeezy_TestMode;

    property TransactionExpress_Enabled: boolean read FTransactionExpress_Enabled write FTransactionExpress_Enabled;
    property TransactionExpress_ID: string read FTransactionExpress_ID write FTransactionExpress_ID;
    property TransactionExpress_RegKey: string read FTransactionExpress_RegKey write FTransactionExpress_RegKey;
    property TransactionExpress_TestMode: boolean read FTransactionExpress_TestMode write FTransactionExpress_TestMode;
  end;

implementation

uses
  {$IfDef VER220}
  SysUtils,
  Classes,
  {$Else}
  SysUtils,
  System.Classes,
  {$EndIf}
  LogMessageTypes, JsonToObject, JsonRPCUtils, JsonRpcConst, LogThreadDbLib,
  GatewayStripe, CreditCardObj, CipherUtils, ObjectStorer, LogThreadLib,
  PaymentGatewayConst, GatewayPaymentExpress, GatewayPayeezy,
  GatewayTransactionExpress, ConfigDbObj, ClientConfigObj, MachineSignature,
  Windows;

const
  StripePanelHeight = 250;
  PaymentExpressPanelHeight = 100;
  PayeezyPanelHeight = 100;
  TransactionExpressPanelHeight = 100;

{ TModPaymentGateway }

procedure TModPaymentGateway.AfterLoadConfig;
begin
  inherited;

end;

constructor TModPaymentGateway.Create(aLogger: TLoggerBase);
begin
  inherited ;
  //AppDatabase.MIN_TABLE_VERSION := '2018.0.0.0';
  Logger.LogAllTypes;
  LoadConfig; //(false);
  Log(ClassName + ' Created.',ltDetail);
end;

(*
function TModPaymentGateway.CreateNewLogger: TLoggerBase;
begin
//  result := inherited;
  result := TDbLogger.Create(nil);
//  result := TLogger.Create(nil);
end;
*)
destructor TModPaymentGateway.Destroy;
begin

  inherited;
end;

procedure TModPaymentGateway.DoOnCommandMessage(aData: string;
  ctx: TJsonObject);
begin
  inherited;
  Log('DoOnCommandMessage: ' + aData, ltDetail);
end;

procedure TModPaymentGateway.DoOnCommandRequest(aRequest: string;
  var aResponse: string);
begin
  inherited;
  Log('DoOnCommandRequest: ' + aRequest, ltDetail);
end;

procedure TModPaymentGateway.DoOnMessage(aClientId: integer; aData,
  ctx: TJsonObject);
begin
  Log('DoOnMessage: ' + aData.AsString, ltDetail);
end;

procedure TModPaymentGateway.DoOnMessage(aClientId: integer; aData: string;
  ctx: TJsonObject);
begin
  Log('DoOnMessage: ' + aData, ltDetail);
end;

procedure TModPaymentGateway.DoOnRequest(aClientId: integer; aRequest, ctx,
  aResponse: TJsonObject);
var
  methodName: string;
  idx: integer;
  stripe: TStripeGateway;
  PaymentExpress: TPaymentExpressGateway;
  Payeezy: TPayeezyGateway;
  TransExpress: TTransactionExpressGateway;
  msg: string;
  s: string;
//  obj, res: TJsonObject;
begin
  if Terminated then
    exit;
  try
    methodName:= Lowercase(aRequest.S['method']);
    Log('Request: ' +  methodName, ltDetail);
    try
      inherited;

      if ctx.B['Handled'] = true then
        exit;

      idx:= Pos('.',methodName);
      if idx > 0 then
        methodName:= Copy(methodName,idx+1,Length(methodName));

      if SameText(methodName,'GetConfig') then begin
        aResponse.O['result'].B['Encrypted'] := true;
        aResponse.O['result'].S['Data'] := ObjToStr(self, true);
//        ObjToJson(self, aResponse.O['result']);
      end
      else if SameText(methodName,'SetConfig') then begin
        if aRequest.ObjectExists('params') then begin
          if aRequest.O['params'].BooleanExists('Encrypted') and aRequest.O['params'].B['Encrypted'] then
            StrToObj(aRequest.O['params'].S['Data'],self,true)
          else
            JsonToObj(aRequest.O['params'],self);
          self.SaveConfig;
          JsonRPCUtils.AddResultOk(aResponse);
        end
        else begin
          JsonRPCUtils.AddResultError(aResponse,'Params object missing from request',RPC_INVALID_PARAMS);
        end;
      end
      else if SameText(methodName,'GetGUI') then begin
        aResponse.O['result'].AsString := GuiStr;
      end
      else if SameText(methodName,'Click') then begin
        if SameText(aRequest.O['Params'].S['Name'],'btnStripeTestLive') or SameText(aRequest.O['Params'].S['Name'],'btnStripeTestTest') then begin
          stripe := TStripeGateway.Craeate;
          try
            stripe.Stripe_LiveSecretKey := self.fStripe_LiveSecretKey;
            stripe.Stripe_TestSecretKey := self.fStripe_TestSecretKey;
            stripe.OnLogEvent := Log;
            if stripe.TestGateway(msg,SameText(aRequest.O['Params'].S['Name'],'btnStripeTestTest')) then begin
              { ok }
              JsonRPCUtils.AddResultOk(aResponse);
              aResponse.O['Dialog'].S['Message'] := 'Communications with Stripe Server are OK.';
              aResponse.O['Dialog'].S['Type'] := 'mtInformation';
              aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
            end
            else begin
              { fail }
              JsonRPCUtils.AddResultOk(aResponse);
              aResponse.O['Dialog'].S['Message'] := 'Error Communicationg with Stripe Server.' + #13#10 + #13#10 + msg;
              aResponse.O['Dialog'].S['Type'] := 'mtError';
              aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
            end;

          finally
            stripe.Free;
          end;
        end
        else if SameText(aRequest.O['Params'].S['Name'], 'btnPaymentExpressTest') then begin
          PaymentExpress := TPaymentExpressGateway.Craeate;
          try
            PaymentExpress.OnLogEvent := Log;
            PaymentExpress.UserName := self.PaymentExpress_UserName;
            PaymentExpress.Password := self.PaymentExpress_Password;
            if PaymentExpress.TestGateway(msg) then begin
              { ok }
              JsonRPCUtils.AddResultOk(aResponse);
              aResponse.O['Dialog'].S['Message'] := 'Communications with Payment Express Server are OK.';
              aResponse.O['Dialog'].S['Type'] := 'mtInformation';
              aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
            end
            else begin
              { fail }
              JsonRPCUtils.AddResultOk(aResponse);
              aResponse.O['Dialog'].S['Message'] := 'Error Communicationg with Payment Express Server.' + #13#10 + #13#10 + msg;
              aResponse.O['Dialog'].S['Type'] := 'mtError';
              aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
            end;
          finally
            PaymentExpress.Free;
          end;
        end
        else if SameText(aRequest.O['Params'].S['Name'], 'btnPayeezyTest') then begin
          Payeezy := TPayeezyGateway.Craeate;
          try
            Payeezy.OnLogEvent := Log;
            Payeezy.ID := self.Payeezy_ID;
            Payeezy.Password := self.Payeezy_Password;
            Payeezy.TestMode := self.Payeezy_TestMode;
            if Payeezy.TestGateway(msg) then begin
              { ok }
              JsonRPCUtils.AddResultOk(aResponse);
              aResponse.O['Dialog'].S['Message'] := 'Communications with Payeezy Server are OK.';
              aResponse.O['Dialog'].S['Type'] := 'mtInformation';
              aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
            end
            else begin
              { fail }
              JsonRPCUtils.AddResultOk(aResponse);
              aResponse.O['Dialog'].S['Message'] := 'Error Communicationg with Payeezy Server.' + #13#10 + #13#10 + msg;
              aResponse.O['Dialog'].S['Type'] := 'mtError';
              aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
            end;
          finally
            Payeezy.Free;
          end;
        end
        else if SameText(aRequest.O['Params'].S['Name'], 'btnTransactionExpressTest') then begin
          TransExpress := TTransactionExpressGateway.Craeate;
          try
            TransExpress.OnLogEvent := Log;
            TransExpress.ID := self.TransactionExpress_ID;
            TransExpress.RegKey := self.TransactionExpress_RegKey;
            TransExpress.TestMode := self.TransactionExpress_TestMode;
            if TransExpress.TestGateway(msg) then begin
              { ok }
              JsonRPCUtils.AddResultOk(aResponse);
              aResponse.O['Dialog'].S['Message'] := 'Communications with Transation Express Server are OK.';
              aResponse.O['Dialog'].S['Type'] := 'mtInformation';
              aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
            end
            else begin
              { fail }
              JsonRPCUtils.AddResultOk(aResponse);
              aResponse.O['Dialog'].S['Message'] := 'Error Communicationg with Transaction Express Server.' + #13#10 + #13#10 + msg;
              aResponse.O['Dialog'].S['Type'] := 'mtError';
              aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
            end;
          finally
            Payeezy.Free;
          end;
        end
        else if SameText(aRequest.O['Params'].S['Name'], 'Stripe_Enabled') then begin
          JsonRPCUtils.AddResultOk(aResponse);
          if self.Stripe_Enabled and (not LicenceOptionEnabled('Stripe')) then begin
            self.Stripe_Enabled := false;
            aResponse.O['Dialog'].S['Message'] := 'This Option is not enabled in your TrueERP Licence, please contact ERP Support.';
            aResponse.O['Dialog'].S['Type'] := 'mtInformation';
            aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
            self.SaveConfig;
          end;
        end
        else if SameText(aRequest.O['Params'].S['Name'], 'PaymentExpress_Enabled') then begin
          JsonRPCUtils.AddResultOk(aResponse);
          if self.PaymentExpress_Enabled and (not LicenceOptionEnabled('PaymentExpress')) then begin
            self.PaymentExpress_Enabled := false;
            aResponse.O['Dialog'].S['Message'] := 'This Option is not enabled in your TrueERP Licence, please contact ERP Support.';
            aResponse.O['Dialog'].S['Type'] := 'mtInformation';
            aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
            self.SaveConfig;
          end;
        end
        else if SameText(aRequest.O['Params'].S['Name'], 'Payeezy_Enabled') then begin
          JsonRPCUtils.AddResultOk(aResponse);
          if self.Payeezy_Enabled and (not LicenceOptionEnabled('Payeezy')) then begin
            self.Payeezy_Enabled := false;
            aResponse.O['Dialog'].S['Message'] := 'This Option is not enabled in your TrueERP Licence, please contact ERP Support.';
            aResponse.O['Dialog'].S['Type'] := 'mtInformation';
            aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
            self.SaveConfig;
          end;
        end
        else if SameText(aRequest.O['Params'].S['Name'], 'TransactionExpress_Enabled') then begin
          JsonRPCUtils.AddResultOk(aResponse);
          if self.TransactionExpress_Enabled and (not LicenceOptionEnabled('TransactionExpress')) then begin
            self.TransactionExpress_Enabled := false;
            aResponse.O['Dialog'].S['Message'] := 'This Option is not enabled in your TrueERP Licence, please contact ERP Support.';
            aResponse.O['Dialog'].S['Type'] := 'mtInformation';
            aResponse.O['Dialog'].A['Buttons'].Add('mbOK');
            self.SaveConfig;
          end;
        end;
      end
      else if SameText(methodName,'GetActiveGateways') then begin
        s := '';
        if Stripe_Enabled then begin
          if s <> '' then s := s +',';
          s := s + '"'+Gateway_Stripe+'"';
        end;
        if PaymentExpress_Enabled then begin
          if s <> '' then s := s +',';
          s := s + '"'+Gateway_PaymentExpress+'"';
        end;
        if Payeezy_Enabled then begin
          if s <> '' then s := s +',';
          s := s + '"'+Gateway_Payeezy+'"';
        end;
        if TransactionExpress_Enabled then begin
          if s <> '' then s := s +',';
          s := s + '"'+Gateway_TransactionExpress+'"';
        end;
        aResponse.S['result'] := s;
      end
      else if SameText(methodName,'GetLinkedAccount') then begin
        s := '';
        if SameText(aRequest.O['params'].S['Gateway'],'Stripe') then begin
          s := StripeLinkedAccount(aRequest.O['params'].S['Database'],aRequest.O['params'].S['Currency'],msg);
          if s <> '' then begin
            aResponse.S['result'] := s;
          end
          else begin
            AddResultError(aResponse,msg,0);
          end;
        end
        else begin
//          AddResultError(aResponse,'Unknown Gateway "' + aRequest.O['params'].S['Gateway'] + '"',0);
          aResponse.S['result'] := s;
        end;
      end
      else if SameText(methodName,'ProcessPayment') then begin
        if self.ProcessPayment(aRequest.O['params'].I['CardPaymentID'],
                               aRequest.O['params'].S['Database'],msg) then begin
          JsonRPCUtils.AddResultOk(aResponse);
        end
        else begin
          AddResultError(aResponse,msg,0);
        end;
      end
      else begin
        AddResultError(aResponse,'Request method (' + methodName + ') not found',RPC_METHOD_NOT_FOUND);
      end;

    finally
      if Assigned(aResponse) then begin
//        if aResponse.Exists('result') then
//          Log('Result: ' + aResponse.ItemByName['result'].Value.AsString,ltDetail);
      end;
    end;
  except
    on e: exception do begin
      Log('Error processeng request: ' + e.Message,ltError);
    end;
  end;
end;

procedure TModPaymentGateway.DoOnRequest(aClientId: integer; aRequest: string;
  ctx: TJsonObject; var aResponse: string);
begin
  Log('DoOnRequest: ' + aRequest, ltDetail);
end;

procedure TModPaymentGateway.DoWork;
begin
  inherited;

end;

function TModPaymentGateway.EncryptConfig: boolean;
begin
  result := true;
end;

function TModPaymentGateway.GetModuleDescription: string;
begin
  result := 'ERP Payment Gateway Module';
end;

function TModPaymentGateway.GuiStr: string;
var
  GuiHeight: integer;
  PanelTop: integer;
const
  crlf = #13#10;
begin
  GuiHeight := 100;
  GuiHeight := GuiHeight + StripePanelHeight;
  {$IfDef PaymentExpress}
  GuiHeight := GuiHeight + PaymentExpressPanelHeight + 10;
  {$EndIf}
  {$IfDef Payeezy}
  GuiHeight := GuiHeight + PayeezyPanelHeight + 10;
  {$EndIf}
  {$IfDef TransactionExpress}
  GuiHeight := GuiHeight + TransactionExpressPanelHeight + 10;
  {$EndIf}
  PanelTop := 70;  { first panel Top }
  result :=
  '{' + crlf +
  '    "Height":'+IntToStr(GuiHeight)+',' + crlf +
  '    "Children":[' + crlf +
  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Top":14,' + crlf +
  '                "Width":116,' + crlf +
  '                "Height":40,' + crlf +
  '                "Caption":"Payment Gateway",' + crlf +
  '                "Font.Color":128,' + crlf +
  '                "WordWrap":true,' + crlf +
  '                "Font.Style": ["fsBold","fsUnderline"]' + crlf +
  '        },' + crlf +

  '        {' + crlf +
  '                "ClassName": "TLabel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Width":60,' + crlf +
  '                "Top":44,' + crlf +
  '                "Caption":"Active",' + crlf +
  '                "Font.Style": ["fsBold"]' + crlf +
  '        },' + crlf +
  '        {' + crlf +
  '                "ClassName": "TCheckBox",' + crlf +
  '                "Left":84,' + crlf +
  '                "Top":44,' + crlf +
  '                "Width":50,' + crlf +
  '                "Hint":"Click to Enable/Disable this module",' + crlf +
  '                "Name":"Active"' + crlf +
  '        },' + crlf +

           {  STRIPE Integration }
  '        {' + crlf +
  '                "ClassName": "TPanel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Top":'+IntToStr(PanelTop)+',' + crlf +
  '                "Width":510,' + crlf +
  '                "Height":' + IntToStr(StripePanelHeight)+ ',' + crlf +
  '                "BevelOuter":"bvLowered",' + crlf +
  '                "Children":[' + crlf +
  '                  {'  + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":20,' + crlf +
  '                    "Width":150,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Caption": "Stripe",' + crlf +
  '                    "Font.Style": ["fsBold","fsUnderline"]' + crlf +
  '                  }'  + crlf +

  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":150,' + crlf +
  '                    "Width":60,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Caption":"Enabled",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TCheckBox",' + crlf +
  '                    "Left":210,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Width":150,' + crlf +
  '                    "Hint":"Click to Enable/Disable Stripe Integration",' + crlf +
  '                    "Name":"Stripe_Enabled"' + crlf +
  '                  },' + crlf +

  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":380,' + crlf +
  '                    "Width":60,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Caption":"Test Mode",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TCheckBox",' + crlf +
  '                    "Left":450,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Width":15,' + crlf +
  '                    "Hint":"Click to Enable/Disable Test Mode",' + crlf +
  '                    "Name":"Stripe_TestMode"' + crlf +
  '                  },' + crlf +

  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":40,' + crlf +
  '                    "Width":100,' + crlf +
  '                    "Top":44,' + crlf +
  '                    "Caption":"Live Secret Key",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TEdit",' + crlf +
  '                    "Left":150,' + crlf +
  '                    "Top":42,' + crlf +
  '                    "Width":250,' + crlf +
  '                    "PasswordChar":"*",' + crlf +
  '                    "Hint":"Live Secret Key from your Stripe Account",' + crlf +
  '                    "Name":"Stripe_LiveSecretKey"' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TDNMSpeedButton",' + crlf +
  '                    "Caption":"Test",' + crlf +
  '                    "Width":87,' + crlf +
  '                    "Height":27,' + crlf +
  '                    "Left":410,' + crlf +
  '                    "Top":41,' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                    "Style": "bsModern",' + crlf +
  '                    "Hint":"Click to test Stripe Communications.",' + crlf +
  '                    "Name":"btnStripeTestLive"' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":40,' + crlf +
  '                    "Width":100,' + crlf +
  '                    "Top":74,' + crlf +
  '                    "Caption":"Test Secret Key",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TEdit",' + crlf +
  '                    "Left":150,' + crlf +
  '                    "Top":72,' + crlf +
  '                    "Width":250,' + crlf +
  '                    "PasswordChar":"*",' + crlf +
  '                    "Hint":"Test Secret Key from your Stripe Account",' + crlf +
  '                    "Name":"Stripe_TestSecretKey"' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TDNMSpeedButton",' + crlf +
  '                    "Caption":"Test",' + crlf +
  '                    "Width":87,' + crlf +
  '                    "Height":27,' + crlf +
  '                    "Left":410,' + crlf +
  '                    "Top":71,' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                    "Style": "bsModern",' + crlf +
  '                    "Hint":"Click to test Stripe Communications.",' + crlf +
  '                    "Name":"btnStripeTestTest"' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":40,' + crlf +
  '                    "Width":460,' + crlf +
  '                    "Top":104,' + crlf +
  '                    "Caption":"Database Bank Account (eg \"sample_company\",\"Bank\",\"aud,usd\")",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TMemo",' + crlf +
  '                    "Left":40,' + crlf +
  '                    "Top":130,' + crlf +
  '                    "Width":460,' + crlf +
  '                    "Hint":"",' + crlf +
  '                    "Height":100,' + crlf +
  '                    "Name":"Stripe_BankAccountInfo"' + crlf +
  '                  },' + crlf +
  '                ]' +
  '        }' + crlf;

  PanelTop := panelTop + StripePanelHeight + 10;

  {$IfDef PaymentExpress}
  {  Payment Express Integration }
  result := result +
  '        ,{' + crlf +
  '                "ClassName": "TPanel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Top":'+IntToStr(PanelTop)+',' + crlf +
  '                "Width":510,' + crlf +
  '                "Height":'+IntToStr(PaymentExpressPanelHeight)+',' + crlf +
  '                "BevelOuter":"bvLowered",' + crlf +
  '                "Children":[' + crlf +
  '                  {'  + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":20,' + crlf +
  '                    "Width":150,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Caption": "Payment Express",' + crlf +
  '                    "Font.Style": ["fsBold","fsUnderline"]' + crlf +
  '                  },'  + crlf +

  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":150,' + crlf +
  '                    "Width":60,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Caption":"Enabled",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TCheckBox",' + crlf +
  '                    "Left":210,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Width":150,' + crlf +
  '                    "Hint":"Click to Enable/Disable Payment Express Integration",' + crlf +
  '                    "Name":"PaymentExpress_Enabled"' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":40,' + crlf +
  '                    "Width":100,' + crlf +
  '                    "Top":44,' + crlf +
  '                    "Caption":"User Name",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TEdit",' + crlf +
  '                    "Left":150,' + crlf +
  '                    "Top":42,' + crlf +
  '                    "Width":250,' + crlf +
//  '                    "PasswordChar":"*",' + crlf +
  '                    "Hint":"User Name from your Payment Express Account",' + crlf +
  '                    "Name":"PaymentExpress_UserName"' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TDNMSpeedButton",' + crlf +
  '                    "Caption":"Test",' + crlf +
  '                    "Width":87,' + crlf +
  '                    "Height":27,' + crlf +
  '                    "Left":410,' + crlf +
  '                    "Top":41,' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                    "Style": "bsModern",' + crlf +
  '                    "Hint":"Click to test Payment Express Communications.",' + crlf +
  '                    "Name":"btnPaymentExpressTest"' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":40,' + crlf +
  '                    "Width":100,' + crlf +
  '                    "Top":74,' + crlf +
  '                    "Caption":"Password",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TEdit",' + crlf +
  '                    "Left":150,' + crlf +
  '                    "Top":72,' + crlf +
  '                    "Width":250,' + crlf +
  '                    "PasswordChar":"*",' + crlf +
  '                    "Hint":"Password from your Payment Express Account",' + crlf +
  '                    "Name":"PaymentExpress_Password"' + crlf +
  '                  }' + crlf +
  '                ]' +
  '        }' + crlf;
  PanelTop := panelTop + PaymentExpressPanelHeight + 10;
  {$EndIf}

  {$IfDef Payeezy}
  {  Payment Express Integration }
  result := result +
  '        ,{' + crlf +
  '                "ClassName": "TPanel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Top":'+IntToStr(PanelTop)+',' + crlf +
  '                "Width":510,' + crlf +
  '                "Height":'+IntToStr(PayeezyPanelHeight)+',' + crlf +
  '                "BevelOuter":"bvLowered",' + crlf +
  '                "Children":[' + crlf +
  '                  {'  + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":20,' + crlf +
  '                    "Width":150,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Caption": "Payeezy",' + crlf +
  '                    "Font.Style": ["fsBold","fsUnderline"]' + crlf +
  '                  },'  + crlf +

  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":150,' + crlf +
  '                    "Width":60,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Caption":"Enabled",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TCheckBox",' + crlf +
  '                    "Left":210,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Width":150,' + crlf +
  '                    "Hint":"Click to Enable/Disable Payeezy Integration",' + crlf +
  '                    "Name":"Payeezy_Enabled"' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":380,' + crlf +
  '                    "Width":60,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Caption":"Test Mode",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TCheckBox",' + crlf +
  '                    "Left":450,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Width":15,' + crlf +
  '                    "Hint":"Click to Enable/Disable Test Mode",' + crlf +
  '                    "Name":"Payeezy_TestMode"' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":40,' + crlf +
  '                    "Width":100,' + crlf +
  '                    "Top":44,' + crlf +
  '                    "Caption":"ID",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TEdit",' + crlf +
  '                    "Left":150,' + crlf +
  '                    "Top":42,' + crlf +
  '                    "Width":250,' + crlf +
//  '                    "PasswordChar":"*",' + crlf +
  '                    "Hint":"ID from your Payeezy Account",' + crlf +
  '                    "Name":"Payeezy_ID"' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TDNMSpeedButton",' + crlf +
  '                    "Caption":"Test",' + crlf +
  '                    "Width":87,' + crlf +
  '                    "Height":27,' + crlf +
  '                    "Left":410,' + crlf +
  '                    "Top":41,' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                    "Style": "bsModern",' + crlf +
  '                    "Hint":"Click to test Payeezy Communications.",' + crlf +
  '                    "Name":"btnPayeezyTest"' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":40,' + crlf +
  '                    "Width":100,' + crlf +
  '                    "Top":74,' + crlf +
  '                    "Caption":"Password",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TEdit",' + crlf +
  '                    "Left":150,' + crlf +
  '                    "Top":72,' + crlf +
  '                    "Width":250,' + crlf +
  '                    "PasswordChar":"*",' + crlf +
  '                    "Hint":"Password from your Payeezy Account",' + crlf +
  '                    "Name":"Payeezy_Password"' + crlf +
  '                  }' + crlf +
  '                ]' +
  '        }' + crlf;
//  PanelTop := panelTop + PayeezyPanelHeight + 10;
  {$EndIf}

  {$IfDef TransactionExpress}
  {  Payment Express Integration }
  PanelTop := panelTop + PayeezyPanelHeight + 10;
  result := result +
  '        ,{' + crlf +
  '                "ClassName": "TPanel",' + crlf +
  '                "Left":14,' + crlf +
  '                "Top":'+IntToStr(PanelTop)+',' + crlf +
  '                "Width":510,' + crlf +
  '                "Height":'+IntToStr(TransactionExpressPanelHeight)+',' + crlf +
  '                "BevelOuter":"bvLowered",' + crlf +
  '                "Children":[' + crlf +
  '                  {'  + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":20,' + crlf +
  '                    "Width":150,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Caption": "Transaction Express",' + crlf +
  '                    "Font.Style": ["fsBold","fsUnderline"]' + crlf +
  '                  },'  + crlf +

  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":150,' + crlf +
  '                    "Width":60,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Caption":"Enabled",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TCheckBox",' + crlf +
  '                    "Left":210,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Width":15,' + crlf +
  '                    "Hint":"Click to Enable/Disable Transaction Express Integration",' + crlf +
  '                    "Name":"TransactionExpress_Enabled"' + crlf +
  '                  },' + crlf +
(*
  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":380,' + crlf +
  '                    "Width":60,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Caption":"Test Mode",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TCheckBox",' + crlf +
  '                    "Left":450,' + crlf +
  '                    "Top":14,' + crlf +
  '                    "Width":15,' + crlf +
  '                    "Hint":"Click to Enable/Disable Test Mode",' + crlf +
  '                    "Name":"TransactionExpress_TestMode"' + crlf +
  '                  },' + crlf +
 *)
  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":40,' + crlf +
  '                    "Width":100,' + crlf +
  '                    "Top":44,' + crlf +
  '                    "Caption":"ID",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TEdit",' + crlf +
  '                    "Left":150,' + crlf +
  '                    "Top":42,' + crlf +
  '                    "Width":250,' + crlf +
//  '                    "PasswordChar":"*",' + crlf +
  '                    "Hint":"ID from your Transaction Express Account",' + crlf +
  '                    "Name":"TransactionExpress_ID"' + crlf +
  '                  },' + crlf +
(*
  '                  {' + crlf +
  '                    "ClassName": "TDNMSpeedButton",' + crlf +
  '                    "Caption":"Test",' + crlf +
  '                    "Width":87,' + crlf +
  '                    "Height":27,' + crlf +
  '                    "Left":410,' + crlf +
  '                    "Top":41,' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                    "Style": "bsModern",' + crlf +
  '                    "Hint":"Click to test Transaction Express Communications.",' + crlf +
  '                    "Name":"btnTransactionExpressTest"' + crlf +
  '                  },' + crlf +
 *)
  '                  {' + crlf +
  '                    "ClassName": "TLabel",' + crlf +
  '                    "Left":40,' + crlf +
  '                    "Width":100,' + crlf +
  '                    "Top":74,' + crlf +
  '                    "Caption":"Reg Key",' + crlf +
  '                    "Font.Style": ["fsBold"]' + crlf +
  '                  },' + crlf +
  '                  {' + crlf +
  '                    "ClassName": "TEdit",' + crlf +
  '                    "Left":150,' + crlf +
  '                    "Top":72,' + crlf +
  '                    "Width":250,' + crlf +
  '                    "PasswordChar":"*",' + crlf +
  '                    "Hint":"Reg Key for your Transaction Express Account",' + crlf +
  '                    "Name":"TransactionExpress_RegKey"' + crlf +
  '                  }' + crlf +
  '                ]' +
  '        }' + crlf;
  PanelTop := panelTop + PayeezyPanelHeight + 10;
  {$EndIf}


  result := result +
//  '                ]' +

//  '        },' + crlf +
  '    ]' + crlf +
  '}';
end;

function TModPaymentGateway.LicenceOptionEnabled(
  const OptionName: string): boolean;
var
  ConfigDb: TConfigDb;
  ClientConfig: TJsonObject;
  Config: TClientConfig;
  Licence: TSoftwareLicence;
begin
  result := false;
  ClientConfig := JO;
  try
    ConfigDb := TConfigDb.Create('ClientConfig',self.MySQLServer);
    try
      ClientConfig.AsString := DecryptString(ConfigDb.Value);
    finally
      ConfigDb.Free;
    end;
    Config := TClientConfig.Create;
    try
      if ClientConfig.ObjectExists('clientconfig') then
        JsonToObj(ClientConfig.O['clientconfig'],Config)
      else
        JsonToObj(ClientConfig,Config);
      Licence:= Config.LicenceByName(MachineSignature.GetPcName,'ERP');
      if Assigned(Licence) then begin
        result := Licence.Data.O['Options'].B[OptionName];
      end;
    finally
      Config.Free;
    end;

  finally
    ClientConfig.Free;
  end;
end;

procedure TModPaymentGateway.LoadConfig;
var
  configFileName: string;
  stream: TStringStream;
  s: string;
  ConfigDb: TConfigDb;
begin
  try
    ConfigDb := TConfigDb.Create(self.ModuleName + '_Config',self.MySQLServer);
    try
      if not ConfigDb.Exists then begin
        { virtual methods for decendents to inherit }
        ConfigNotFound;
        { check to see if we have old style config file on disk .. }
        configFileName:= ChangeFileExt(self.ModuleFileName, '_Config.cfg');
        if FileExists(configFileName) then begin
          try
            if self.EncryptConfig then begin

              stream := TStringStream.Create;
              try
                stream.LoadFromFile(configFileName);
                s := CipherUtils.DecryptString(stream.DataString);
                StrToObj(s,self,false);
              finally
                stream.Free;
              end;
            end
            else begin
              try
                FileToObj(configFileName, self, self.EncryptConfig);
              except
                on e: exception do begin
                  Log('Error reading old config file: ' + e.Message,ltError);
                end;
              end;
            end;
          except
            on e: exception do begin
              Log('Error reading old config file: ' + e.Message,ltError);
            end;
          end;
          SaveConfig;
          SysUtils.DeleteFile(configFileName);
        end;
      end;
      { load config }
      try
        StrToObj(ConfigDb.Value, self, self.EncryptConfig);
      except
        on e: exception do begin
          Log('Error reading config data drom database: ' + e.Message, ltError);
          Log('Dataread: ' + ConfigDb.Value, ltError);
        end;
      end;
    finally
      ConfigDb.Free;
    end;

    AfterLoadConfig;
  except
    on e: exception do begin
      Log('Error reading config file: ' + e.Message,ltError);
      raise;
    end;
  end;
end;

function TModPaymentGateway.ProcessPayment(const aCardPaymentID: integer;
  const aDatabase: string; var msg: string): boolean;
var
  CardPayment: TCardPayment;
  Conn: TDbConnection;
begin
//  result := true;
  try
    Conn := TDbGen.NewConnection(aDatabase);
    try
      Conn.Connect;
      try
        CardPayment := TCardPayment.Create;
        try
          TObjStore.LoadObject(CardPayment,TCardPayment.TableName,Conn,aCardPaymentID);
          if SameText(CardPayment.Gateway,Gateway_Stripe) then
            result := ProcessPayment_Stripe(CardPayment,Conn,msg)
          else if SameText(CardPayment.Gateway,Gateway_PaymentExpress) then
            result := ProcessPayment_PaymentExpress(CardPayment,Conn,msg)
          else if SameText(CardPayment.Gateway,Gateway_Payeezy) then
            result := ProcessPayment_Payeezy(CardPayment,Conn,msg)
          else if SameText(CardPayment.Gateway,Gateway_TransactionExpress) then
            result := ProcessPayment_TransactionExpress(CardPayment,Conn,msg)
          else begin
            result := false;
            msg := 'Unknown Gateway Type "' + CardPayment.Gateway + '".';
            CardPayment.PaymentStatus := Ord(cpsFailed);
            CardPayment.StatusComment := msg;
            exit;
          end;
          TObjStore.SaveObject(CardPayment,TCardPayment.TableName,Conn);
        finally;
          FreeAndNil(CardPayment);
        end;

      finally
      end;
    finally
      Conn.Free;
    end;
  except
    on e: exception do begin
      result := false;
      msg := 'Error Loading Card Payment: ' + e.Message;
    end;
  end;
end;

function TModPaymentGateway.ProcessPayment_Payeezy(
  var aCardPayment: TCardPayment; aConn: TDbConnection;
  var msg: string): boolean;
var
  Payeezy: TPayeezyGateway;
begin
  Payeezy := TPayeezyGateway.Craeate;
  try
    Payeezy.OnLogEvent := Log;
    Payeezy.ID := self.Payeezy_ID;
    Payeezy.Password := self.Payeezy_Password;
    Payeezy.TestMode := self.Payeezy_TestMode;

    result := Payeezy.CreateCharge(aCardPayment,aConn,msg);
    if not result then begin
      aCardPayment.PaymentStatus := Ord(cpsFailed);
      aCardPayment.StatusComment := msg;
    end;

  finally
    Payeezy.Free;
  end;
end;

function TModPaymentGateway.ProcessPayment_PaymentExpress(
  var aCardPayment: TCardPayment; aConn: TDbConnection;
  var msg: string): boolean;
var
  PaymentExpress: TPaymentExpressGateway;
begin
  PaymentExpress := TPaymentExpressGateway.Craeate;
  try
    PaymentExpress.OnLogEvent := Log;
    PaymentExpress.UserName := self.PaymentExpress_UserName;
    PaymentExpress.Password := self.PaymentExpress_Password;

    result := PaymentExpress.CreateCharge(aCardPayment,aConn,msg);
    if not result then begin
      aCardPayment.PaymentStatus := Ord(cpsFailed);
      aCardPayment.StatusComment := msg;
    end;

  finally
    PaymentExpress.Free;
  end;
end;

function TModPaymentGateway.ProcessPayment_Stripe(var aCardPayment: TCardPayment;
  aConn: TDbConnection; var msg: string): boolean;
var
  stripe: TStripeGateway;
  CardToken: string;
//  payID: string;
begin
  stripe := TStripeGateway.Craeate;
  try
    stripe.Stripe_LiveSecretKey := self.fStripe_LiveSecretKey;
    stripe.Stripe_TestSecretKey := self.fStripe_TestSecretKey;
    stripe.OnLogEvent := Log;
    stripe.TestMode := self.Stripe_TestMode;

    cardToken := Stripe.CreateCardToken(aCardPayment.Card,msg);
    if cardToken = '' then begin
      { somthing went wrong .. }
      result := false;
      aCardPayment.PaymentStatus := Ord(cpsFailed);
      aCardPayment.StatusComment := msg;
      exit;
    end;
      { we now have a card token }
    result := Stripe.CreateCharge(aCardPayment,CardToken,aConn,msg);
  finally
    stripe.Free;
  end;
end;

function TModPaymentGateway.ProcessPayment_TransactionExpress(
  var aCardPayment: TCardPayment; aConn: TDbConnection;
  var msg: string): boolean;
var
  TransExpress: TTransactionExpressGateway;
begin
  TransExpress := TTransactionExpressGateway.Craeate;
  try
    TransExpress.OnLogEvent := Log;
    TransExpress.ID := self.TransactionExpress_ID;
    TransExpress.RegKey := self.TransactionExpress_RegKey;

    result := TransExpress.CreateCharge(aCardPayment,aConn,msg);
    if not result then begin
      aCardPayment.PaymentStatus := Ord(cpsFailed);
      aCardPayment.StatusComment := msg;
    end;

  finally
    TransExpress.Free;
  end;
end;

function TModPaymentGateway.StripeLinkedAccount(const aDatabase, aCurrency: string;
  var msg: string): string;
var
  Lines,sl: TStringList;
  x: integer;
begin
  result := '';
  Lines := TStringList.Create;
  sl := TStringList.Create;
  try
    Lines.CommaText := self.Stripe_BankAccountInfo;
    for x := 0 to Lines.Count -1 do begin
      if Trim(Lines[x]) <> '' then begin
        sl.CommaText := Trim(Lines[x]);
        if sl.Count < 2 then begin
          msg := 'The format of the Stripe Preference for Bank Accounts is invalid. ' + #13#10 +
            'Each line must be in the following format:'  + #13#10 +
            '"[database name]","[Bank Account Name]","[List of currencies for this account]". ' +  #13#10 +
            'Note: leave curreny list blank or use "all" to allow all currencies for this account.';
          exit;
        end;
        if SameText(sl[0],aDatabase) then begin
          if (sl.Count = 2) or (Pos('all',sl[2]) > 0) or (Pos(aCurrency,sl[2]) > 0) then begin
            result := sl[1];
            exit;
          end;
        end;
      end;
    end;
    if result = '' then begin
      msg := 'Could not find Preference - Stripe Bank Account Name for Database "' + aDatabase + '" and Currency "' + aCurrency + '"';
    end;

  finally
    Lines.Free;
    sl.Free;
  end;

end;

//procedure TModPaymentGateway.SaveConfig;
//var
//  configFileName: string;
//  s: string;
//  stream: TStringStream;
//begin
//  if self.EncryptConfig then begin
//    configFileName:= ChangeFileExt(self.ModuleFileName, '_Config.cfg');
//    s := ObjToStr(self, true);
//    stream := TStringStream.Create;
//    try
//      stream.WriteString(s);
//      stream.Position := 0;
//      stream.SaveToFile(configFileName);
//    finally
//      stream.Free;
//    end;
//
////    ObjToFile(self, configFileName, self.EncryptConfig  {encrypt});
//  end
//end;

procedure TModPaymentGateway.SetActive(const Value: boolean);
begin
  inherited;

end;

end.
