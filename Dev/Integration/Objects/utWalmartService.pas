unit utWalmartService;

interface

uses
  JSONObject, utBaseCoreService;

const
  Walmart_CORRELATION_ID = 'c388670e-d953-4616-b4dc-99ace7b9c268';

type
  TWalmartCoreService = class(TBaseCoreService)
  Private
    fsClientID: String;
    fsClientSecret: String;
    fssynchAccount: String;
    fssynchAccountDescription: String;
    fbEnableWalmart: Boolean;
    fbAutosynchList: Boolean;
    //fsTokenURL: String;
  Protected
    procedure InitRequestParams(areq :TJsonObject);override;
  Public
    function Initialize: boolean; override;
    Property EnableWalmart : Boolean read fbEnableWalmart write fbEnableWalmart;
    Property AutosynchList :Boolean read fbAutosynchList write fbAutosynchList;
    Property ClientID :String read fsClientID write fsClientID;
    Property ClientSecret :String read fsClientSecret write fsClientSecret;
    Property synchAccount :String read fssynchAccount write fssynchAccount;
    Property synchAccountDescription :String read fssynchAccountDescription write fssynchAccountDescription;
    class function GetServiceName: string; override;
    //Property TokenURL :String read fsTokenURL write fsTokenURL;
  end;

implementation

uses LogLib, AppEnvironment, utCoreEDIConst;

{ TWalmartCoreService }


Class function TWalmartCoreService.GetServiceName: string;
begin
  Result := Servicename_Walmart;
end;

function TWalmartCoreService.Initialize: boolean;
var
  req: TJsonObject;
begin
  Logtext('TWalmartCoreService.Command = Initialize');
  req := JO;
  try
    req.FormatOutput := false;
    req.S['Command'] := 'Initialize';
    InitRequestParams(req);
    Logtext('WriteAndWait');
    fResultData.AsString := self.WriteAndWait(req.AsString);
    result := fResultData.S['ReturnCode'] = 'Ok';
  finally
    req.Free;
  end;

  EnableWalmart          := Appenv.CompanyPrefs.Walmartconfig.EnableWalmart          ;
  AutosynchList          := Appenv.CompanyPrefs.Walmartconfig.AutosynchList          ;
  ClientID               := Appenv.CompanyPrefs.WalmartClientID           ;
  ClientSecret           := Appenv.CompanyPrefs.WalmartClientSecret        ;
  synchAccount           := Appenv.CompanyPrefs.WalmartsynchAccount        ;
  synchAccountDescription:= Appenv.CompanyPrefs.WalmartsynchAccountDescription        ;
  //TokenURL         := Appenv.CompanyPrefs.WalmartTokenURL        ;
  Logtext('TWalmartCoreService Proeprties set fom companyprefs');
end;

procedure TWalmartCoreService.InitRequestParams(areq: TJsonObject);
begin
  inherited;
    areq.O['Params'].B['EnableWalmart']           := Appenv.CompanyPrefs.Walmartconfig.EnableWalmart           ;
    areq.O['Params'].B['AutosynchList']           := True;
    areq.O['Params'].S['ClientID']                := Appenv.CompanyPrefs.WalmartClientID  ;
    areq.O['Params'].S['ClientSecret']            := Appenv.CompanyPrefs.WalmartClientSecret        ;
    areq.O['Params'].S['synchAccount']            := Appenv.CompanyPrefs.WalmartsynchAccount        ;
    areq.O['Params'].S['synchAccountDescription'] := Appenv.CompanyPrefs.WalmartsynchAccountDescription        ;
    areq.O['Params'].S['TokenURL']                := Appenv.CompanyPrefs.WalmartTokenURL        ;
    areq.O['Params'].S['Order_Released_URL']      := Appenv.CompanyPrefs.Walmart_Order_Released_URL;
    areq.O['Params'].S['Order_Released_Cont_URL'] := Appenv.CompanyPrefs.Walmart_Order_Released_Cont_URL;
    areq.O['Params'].S['Order_All_URL']           := Appenv.CompanyPrefs.Walmart_Order_All_URL;
    areq.O['Params'].S['Order_All_cont_URL']      := Appenv.CompanyPrefs.Walmart_Order_All_cont_URL;
    areq.O['Params'].S['Order_Single_URL']        := Appenv.CompanyPrefs.Walmart_Order_Single_URL;
    areq.O['Params'].S['Order_Ack_URL']           := Appenv.CompanyPrefs.Walmart_Order_Ack_URL;
    areq.O['Params'].S['Order_Cancel_URL']        := Appenv.CompanyPrefs.Walmart_Order_Cancel_URL;
    areq.O['Params'].S['Order_Refund_URL']        := Appenv.CompanyPrefs.Walmart_Order_Refund_URL;
    areq.O['Params'].S['Order_Shipping_URL']      := Appenv.CompanyPrefs.Walmart_Order_Shipping_URL;
    areq.O['Params'].S['FeedStatus_URL']          := Appenv.CompanyPrefs.Walmart_FeedStatus_URL;
    areq.O['Params'].DT['OrdersSynchedUntil']     := Appenv.CompanyPrefs.Walmart_OrdersSynchedUntil;
    areq.O['Params'].S['Correlation_ID']          := Walmart_CORRELATION_ID;
end;

end.
