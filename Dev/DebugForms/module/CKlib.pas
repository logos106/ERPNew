unit CKlib;

interface

  Uses  Http, Rest , CK_DLLCommon_WalmartLib;

Function GetWoocommerceOrderstest(LogProc: TLogProc; s1:PWideChar ; s2:PWideChar ; s3:PWideChar): String;
Function GetWoocommerceOrderstest1(LogProc: TLogProc; s1:PWideChar ; s2:PWideChar ; s3:PWideChar): String;

implementation

  uses StringBuilder, AppEnvironment, sysutils, Global , OAuth1, CK_DLL_Const;

Function GetWoocommerceOrderstest1(LogProc: TLogProc; s1:PWideChar ; s2:PWideChar ; s3:PWideChar): String;
var
rest: HCkRest;
success: Boolean;
sbJson: HCkStringBuilder;
oauth1: HCkOAuth1;

begin
oauth1 := CkOAuth1_Create();
CkGlobal_UnlockBundle( oauth1, CHILCAT_UNLOCK_KEY);
CkOAuth1_putConsumerKey(oauth1,'ck_a928e5957f681264ab25f9b8ddc695ba88bb3189');
CkOAuth1_putConsumerSecret(oauth1,'cs_14abad5a7bbee6da84c2340412d04ab5f5be439d');

rest := CkRest_Create();

CkRest_SetAuthBasic(rest,'ck_a928e5957f681264ab25f9b8ddc695ba88bb3189','cs_14abad5a7bbee6da84c2340412d04ab5f5be439d');


//success := CkRest_Connect(rest,'mywoocommercesite.com',443,True,True);
success := CkRest_Connect(rest,'localhost:8080/wordpress/index.php',443,True,True);
if (success <> True) then
  begin
    logtext(CkRest__lastErrorText(rest),LogProc);
    Exit;
  end;

sbJson := CkStringBuilder_Create();
//success := CkRest_FullRequestNoBodySb(rest,'GET','/wp-json/wc/v2/products',sbJson);
success := CkRest_FullRequestNoBodySb(rest,'GET','/wp-json/wc/v3/orders',sbJson);
if (success <> True) then
  begin
    logtext(CkRest__lastErrorText(rest),LogProc);
    Exit;
  end;

if (CkRest_getResponseStatusCode(rest) <> 200) then
  begin
    logtext('Received error response code: ' + IntToStr(CkRest_getResponseStatusCode(rest)),LogProc);
    logtext('Response body:',LogProc);
    logtext(CkStringBuilder__getAsString(sbJson),LogProc);
    Exit;
  end;

logtext('Example Completed.',LogProc);
CkRest_Dispose(rest);
CkStringBuilder_Dispose(sbJson);
end;

Function GetWoocommerceOrderstest(LogProc: TLogProc; s1:PWideChar ; s2:PWideChar ; s3:PWideChar): String;
var
oauth1: HCkOAuth1;
success: Boolean;
rest: HCkRest;
bUseQueryParams: Boolean;
bTls: Boolean;
port: Integer;
bAutoReconnect: Boolean;
responseJson: PWideChar;

begin
//  Demonstrates how to do OAuth1 authentication for a Wordpress site using Woo Commerce.

//  This example requires the Chilkat API to have been previously unlocked.
//  See Global Unlock Sample for sample code.

//  Prepare an OAuth 1.0 object for use with the Chilkat REST API.
Logtext('==================================================================',LogProc);
try
logtext(s1,LogProc);
logtext(s2,LogProc);
logtext(s3,LogProc);

oauth1 := CkOAuth1_Create();
CkGlobal_UnlockBundle( oauth1, CHILCAT_UNLOCK_KEY);
CkOAuth1_putConsumerKey(oauth1,'ck_a928e5957f681264ab25f9b8ddc695ba88bb3189');
CkOAuth1_putConsumerSecret(oauth1,'cs_14abad5a7bbee6da84c2340412d04ab5f5be439d');

//  The signature method can be HMAC-SHA1 or HMAC-SHA256
CkOAuth1_putSignatureMethod(oauth1,'HMAC-SHA256');

//  The OauthUrl property will need to be updated each time a request is sent.
//  The domain here must match the domain passed to the Connect method (below).
//  The domain must be exact.  For example, "www.your-wordpress-site.com" vs. "your-wordpress-site.com".
//  One might work while the other does not..
//CkOAuth1_putOauthUrl(oauth1,'http://your-wordpress-site.com/wc-api/v3/orders');
  CkOAuth1_putOauthUrl(oauth1,s1);

//  The OAuthMethod property will be set automatically when the REST request is sent.
//  Setting it here is not actually necessary.
CkOAuth1_putOauthMethod(oauth1,'GET');

//  Generate an initial nonce so that Chilkat knows the desired size of the nonce.
success := CkOAuth1_GenNonce(oauth1,32);

rest := CkRest_Create();

//  Tell the REST object to use the OAuth1 object for authentication.
//  Also, indicate that the OAuth authentication parameters should be query parameters
//  and not located within the Authorization header.
bUseQueryParams := True;
success := CkRest_SetAuthOAuth1(rest,oauth1,bUseQueryParams);

//  Make the initial connection (without sending a request yet) to the WooCommerce endpoint at your Wordpress blog.
bTls := False;
port := 8080;
bAutoReconnect := True;
//success := CkRest_Connect(rest,'localhost:8080',port,bTls,bAutoReconnect);
//if s2 = '' then s2 :='http://localhost:8080/wordpress/index.php';
success := CkRest_Connect(rest,s2,port,bTls,bAutoReconnect);
if (success <> True) then
  begin
    Logtext(CkRest__lastErrorText(rest), LogProc);
    Exit;
  end;

//  Send a GET request to list orders.

//  When the request is sent, the OAuth1 object's Timestamp and Nonce properties are automatically
//  regenerated.  Also, the OAuth1 object's OauthMethod property is automatically set to the HTTP method
//  used for the request (in this case it is "GET").
//responseJson := CkRest__fullRequestNoBody(rest,'GET','/wc-api/v3/orders');
//if s3 = '' then s3 :='/wp-json/wc/v3/orders';
responseJson := CkRest__fullRequestNoBody(rest,'GET',s3);
//responseJson := CkRest__fullRequestNoBody(rest,'GET','/wc/v3/orders');
//responseJson := CkRest__fullRequestNoBody(rest,'GET','/v3/orders');
if (CkRest_getLastMethodSuccess(rest) <> True) then
  begin
    Logtext(CkRest__lastErrorText(rest), LogProc);
    Exit;
  end;

//  When successful, the response status code will equal 200.
if (CkRest_getResponseStatusCode(rest) <> 200) then
  begin
    //  Examine the request/response to see what happened.
    Logtext('response status code = ' + IntToStr(CkRest_getResponseStatusCode(rest)), LogProc);
    Logtext('response status text = ' + CkRest__responseStatusText(rest), LogProc);
    Logtext('response header: ' + CkRest__responseHeader(rest), LogProc);
    Logtext('response body (if any): ' + responseJson, LogProc);
    Logtext('---', LogProc);
    Logtext('LastRequestStartLine: ' + CkRest__lastRequestStartLine(rest), LogProc);
    Logtext('LastRequestHeader: ' + CkRest__lastRequestHeader(rest), LogProc);
    Exit;
  end;

Logtext(responseJson, LogProc);
Logtext('Success.', LogProc);

CkOAuth1_Dispose(oauth1);
CkRest_Dispose(rest);

finally
  Logtext('==================================================================',LogProc);
end;
END;

end.
