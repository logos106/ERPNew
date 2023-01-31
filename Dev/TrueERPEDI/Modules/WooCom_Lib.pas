unit WooCom_Lib;

interface


type
  TWoocommRequestFn   = Function (sConsumerKey : pchar;sConsumerSecret : pchar;sBaseURL : pchar;dtFrom :pchar; var ErrMsg:pChar):pChar; stdcall;
  TonGetWooCommResponse = Procedure (Const aWooCommResponseJson :Pchar; const aErrMsg:Pchar) of Object;

  TWooCommRequest = class(TObject)
  Private
      dllWooHandle : cardinal;
      acustomerKey:pChar;var aSecretKey:pChar;var aBaseURL:pChar;
      aWooOrdersRequest   : TWoocommRequestFn;
      aWooProductsRequest : TWoocommRequestFn;
      Function WooDLLName:String;
  Protected
    constructor Create;
  Public
    Class Function GetWooCommOrders(onGetWooCommOrders:TonGetWooCommResponse ):Boolean;
    Class Function GetWooCommProducts(onGetWooCommOrders:TonGetWooCommResponse):Boolean;
    destructor Destroy; override;
  end;




implementation

uses ModuleFileNameUtils, sysutils, AppEnvironment,Windows;

{ TWooCommRequest }

function TWooCommRequest.WooDLLName: String;
begin
  Result :=  GetCurrentModulePath+'lib\WooDll.Dll';
end;

constructor TWooCommRequest.Create;
begin
//  dllWooHandle := LoadLibrary(pchar(WooDLLName)) ;
//  if dllWooHandle = 0 then begin
//    raise Exception.Create(ClassName + ' - '+ quotedstr(WooDLLName) +' not found.');
//    Exit;
//  end;
//
//  acustomerKey:= pchar(Appenv.Companyprefs.WooCommerce_consumerKey);
//  aSecretKey  := pchar(Appenv.Companyprefs.WooCommerce_consumerSecretKey);
//  aBaseURL    := pchar(Appenv.Companyprefs.WooCommerce_URL);
//
//  @aWooProductsRequest := GetProcAddress(dllWooHandle, 'getWooProducts');
//  @aWooOrdersRequest    := GetProcAddress(dllWooHandle, 'getWooOrders');
end;

destructor TWooCommRequest.Destroy;
begin
  FreeLibrary(dllWooHandle);
  inherited;
end;
class Function TWooCommRequest.GetWooCommProducts(onGetWooCommOrders:TonGetWooCommResponse):Boolean;
//var
//  //acustomerKey,aSecretKey,aBaseURL:pChar;
//  aResult :PChar;var Errmsg:Pchar;
begin
  result :=False;
//  with TWooCommRequest.Create do try
//    if @aWooProductsRequest = nil then begin
//      errmsg := pchar('Can''t Locate the DLL function ' + quotedstr('getWooProducts')+' in ' + Quotedstr(WooDLLName));
//      exit;
//    end;
//    try
//      aResult := aWooProductsRequest(acustomerKey,aSecretKey,aBaseURL,'', errmsg);
//      onGetWooCommOrders(AResult, errmsg);
//      Result := True;
//    Except
//      on E:Exception do begin
//        Errmsg:= pchar(errmsg+ chr(13) + E.message);
//      end;
//    end;
//  finally
//    Free;
//  end;
end;
class Function TWooCommRequest.GetWooCommOrders(onGetWooCommOrders:TonGetWooCommResponse):Boolean;
//var
//  //acustomerKey,aSecretKey,aBaseURL:pChar;
//  aResult :PChar;var Errmsg:Pchar;
begin
  result :=False;
//    with TWooCommRequest.Create do try
//      if @aWooOrdersRequest = nil then begin
//        errmsg := pchar('Can''t Locate the DLL function ' + quotedstr('getWooOrders')+' in ' + Quotedstr(WooDLLName));
//        exit;
//      end;
//      try
//        aResult := aWooOrdersRequest(acustomerKey,aSecretKey,aBaseURL,'', errmsg);
//        onGetWooCommOrders(AResult, errmsg);
//        Result := True;
//      Except
//        on E:Exception do begin
//          Errmsg:= pchar(errmsg+ chr(13) + E.message);
//        end;
//      end;
//    finally
//      Free;
//    end;
end;


end.
