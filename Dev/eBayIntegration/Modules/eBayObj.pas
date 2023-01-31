unit eBayObj;

interface

uses IdHTTP, SOAPHTTPClient , classes , ebaysvc;

type
  TERPEbayObj = class(TCOmponent)
    Private
      fsReqVersion: String;
      fsAPI       : String;
      fsDevId     : String;
      fsAppID     : String;
      fsSiteId    : String;
      fsUsertocken: String;
      fsCertId    : String;
      SecurityHdr : RequesterCredentials;              // eBay security header
      Credentials : UserIdPasswordType;                // eBay credentials
      fsErrMsg    : String;
      fsCallName  : String;
      fsrouting   : String;
      function IsOktoCallfunction :Boolean;
      function URL:String;

    Protected
    Public
      Rio         : THTTPRIO;

      Property AppID        :String read fsAppID        Write fsAppID;
      Property DevId        :String read fsDevId        write fsDevId;
      Property CertId       :String read fsCertId       write fsCertId;
      Property Usertocken   :String read fsUsertocken   write fsUsertocken;
      Property API          :String read fsAPI          write fsAPI;
      property ReqVersion   :String read fsReqVersion   write fsReqVersion;
      Property routing      :String read fsrouting      write fsrouting;
      Property SiteId       :String read fsSiteId       write fsSiteId;
      Property ErrMsg       :String read fsErrMsg       write fsErrMsg;
      Property CallName     :String read fsCallName     write fsCallName;
      function  GetOrders(ORR: GetOrdersRequest; var Msg:String): GetOrdersResponse;
      function  CompleteSale(CSR: CompleteSaleRequest; var Msg:String): CompleteSaleResponse;
      function GetOrderscont(ORR: GetOrdersRequest): GetOrdersResponse;

      Constructor Create(Aowner :TComponent ); override;
      Destructor Destroy; override;
  end;

implementation

uses sysutils,dialogs, eBayLib, eBayConfig;


{ TERPEbayObj }
function  TERPEbayObj.CompleteSale(CSR: CompleteSaleRequest; var Msg:String): CompleteSaleResponse;
var
  Service:eBayAPIInterface;
  ST:TStringList;
begin
  result:= nil;
  try
    Msg:='';
    CallName := 'CompleteSale';
    if not(IsOktoCallfunction) then exit;
    Rio.URL := URL;
    service := Rio as eBayAPIInterface;
    st:= TStringList.create;
    try
      ListComponentProperties(CSR, ST);
    finally
      ST.savetofile('d:\erp.log');
      Freeandnil(ST);
    end;
    Result := service.CompleteSale(CSR);
  Except
    on E:Exception do begin
      Msg:= E.Message;
    end;
  end;
end;
function  TERPEbayObj.GetOrders(ORR: GetOrdersRequest; var Msg:String): GetOrdersResponse;
var
  Service:eBayAPIInterface;
begin
  result:= nil;
  try
    Msg:='';
    CallName := 'GetOrders';
    if not(IsOktoCallfunction) then exit;
    Rio.URL := URL;
    service := Rio as eBayAPIInterface;
    REsult := service.GetOrders(ORR);
  Except
    on E:Exception do begin
      Msg:= E.Message;
    end;
  end;
end;


function  TERPEbayObj.GetOrderscont(ORR: GetOrdersRequest): GetOrdersResponse;
var
  Service:eBayAPIInterface;
begin
  Result:= nil;
  try
    service := Rio as eBayAPIInterface;
    REsult := service.GetOrders(ORR);
  Except
    on E:Exception do begin
      showmessage(E.Message);
    end;
  end;
end;


constructor TERPEbayObj.Create(Aowner: TComponent);
begin
  inherited;
  SecurityHdr := RequesterCredentials.Create;
  Credentials := UserIdPasswordType.Create;
  RIO := THTTPRIO.Create(nil);
  ReqVersion  := ebayReqVersion;
  routing     := 'New';
end;

destructor TERPEbayObj.Destroy;
begin
  try  Freeandnil(SecurityHdr); Except end;
  try  Freeandnil(Credentials); Except end;
  inherited;
end;

function TERPEbayObj.IsOktoCallfunction: Boolean;
begin
  ErrMsg:= '';
  Result:= False;
  if AppId = '' then begin
    ErrMsg := 'Connection to the EBay API failed.  Please provide teh ''EBay DEveloper Program - AppID';
    Exit;
  end;
  if DevId = '' then begin
    ErrMsg := 'Connection to the EBay API failed.  Please provide teh ''EBay DEveloper Program - DevId';
    Exit;
  end;
  if CertId = '' then begin
    ErrMsg := 'Connection to the EBay API failed.  Please provide teh ''EBay DEveloper Program - CertId';
    Exit;
  end;
  if UserTocken = '' then begin
    ErrMsg := 'Connection to the EBay API failed.  Please provide teh ''EBay DEveloper Program - User Tocken';
    Exit;
  end;
   Try
     SecurityHdr.eBayAuthToken        := UserTocken;
     SecurityHdr.Credentials          := Credentials;
     SecurityHdr.Credentials.AppId    := appID;
     SecurityHdr.Credentials.DevId    := DevID;
     SecurityHdr.Credentials.AuthCert := CertID;
     Rio.SOAPHeaders.Send(SecurityHdr);
     Rio.SOAPHeaders.SetOwnsSentHeaders(True);
   Except
    on E:Exception do begin
      ErrMsg:= 'Connection to the EBay API failed.  ' + E.Message;
      exit;
    end;
   End;
   Result:= true;
end;

function TERPEbayObj.URL: String;
begin
  result:= '';
  if sameText(Api , 'Trading') then begin
    result := //'https://api.sandbox.ebay.com/wsapi' +
            'https://api.ebay.com/wsapi'+
            //'https://api.ebay.com/ws/api.dll'+
            '?callname='  + CallName  +
            '&siteid='    + SiteID    +
            '&appid='     + AppID     +
            '&version='   + ReqVersion+
            '&routing='   + routing;
  end;
end;

end.

