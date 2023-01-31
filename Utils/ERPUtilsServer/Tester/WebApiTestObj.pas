unit WebApiTestObj;

interface

uses
  IdHttp, IdSSLOpenSSL, JsonRpcTcpClient, Classes, JsonObject, Contnrs, TesterObj;

type

  TWebApiTestList = class(TTestList)
  public
    constructor Create;
  end;

  TExternalIPTest = class(TTestStep)
  public
    constructor Create;
    procedure DoTest(context: TJsonObject); override;
  end;

  TWebAPIModuleExternTest = class(TTestStep)
  public
    constructor Create;
    procedure DoTest(context: TJsonObject); override;
  end;

implementation

uses
  SysUtils, JsonRpcConst, MyAccess, MySQLUtils, DbConst,
  StrUtils, SimpleEncrypt, UtilsTestObj, HTTPConst, HTTPUtils;


function PadRight(str: string; count: integer): string;
begin
  result := str;
  while Length(result) < count do
    result:= result + ' ';
end;

procedure SplitData(data: string; sl: TStringList);
var
  s: string;
  x: integer;
begin
  s := ReplaceStr(data,'<html>','');
  s := ReplaceStr(s,'</html>','');
  s := ReplaceStr(s,'<body>','');
  s := ReplaceStr(s,'</body>','');
  sl.Text := Trim(s);
  x:= 0;
  while x < sl.Count do begin
    if Trim(sl[x]) = '' then
      sl.Delete(x)
    else
      Inc(x);
  end;
end;


{ TWebApiTestList }

constructor TWebApiTestList.Create;
var
  Test: TTestStep;
begin
  inherited;
  Test:= TExternalIPTest.Create;
  AddTest(Test);
  Test:= TUtilsServerTest.Create;
  AddTest(Test);
  Test:= TWebAPIConfigTest.Create;
  AddTest(Test);
  Test:= TMySQLTest.Create;
  AddTest(Test);
  Test:= TWebAPIModuleInternalTest.Create;
  AddTest(Test);
  Test:= TWebAPIModuleExternTest.Create;
  AddTest(Test);
end;

{ TExternalIPTest }

constructor TExternalIPTest.Create;
begin
  inherited;
  fCaption := 'Check internet access and find your public (internet) IP address';
end;

procedure TExternalIPTest.DoTest(context: TJsonObject);
var
  Client: TIdHttp;
  IP: string;
begin
  inherited;
  AddDetail('Your IP Address must be fixed to allow external access to the WebAPI.');
  AddDetail('(Obtain this from your Internet Service Provider or ISP)');
  AddDetail('');
  Client := TIdHttp.Create(nil);
  try
    try
      Client.Request.UserAgent := HTTPConst.TrueERPUserAgent;
      IP := Client.Get('http://www.trueerp.com/whatsmyip.php');
      if (IP <> '') then begin
        fStatus := tssPass;
        AddDetail('Your IP address on the internet is ' + IP);
        if (context.S['PublicIP'] = '') then
          context.S['PublicIP'] := IP;
      end
      else begin
        fStatus := tssFail;
        AddDetail('The IP address returned from the test server (www.truerp.com) was blank.');
      end;
    except
      on e :Exception do begin
        fStatus := tssFail;
        AddDetail('Internet connection failed.');
        AddDetail('Actual error returned:');
        AddDetail(e.Message,4);
      end;
    end;
  finally
    Client.Free;
  end;
  context.B['InternetAccessOk'] := fStatus = tssPass;
end;

{ TWebAPIMpduleTest }

constructor TWebAPIModuleExternTest.Create;
begin
  inherited;
  fCaption := 'Check External Communications with ERP through the WebAPI Module';
end;

procedure TWebAPIModuleExternTest.DoTest(context: TJsonObject);
var
  Client: TIdHttp;
  URL: string;
  data, error: string;
  retryCount: integer;
  sl: TStringList;
  Port: integer;
  Database, Password: string;
  x: integer;
  json: TJsonObject;
const
  max_retry = 3;

//  function GetData: boolean;
//  begin
//    result := true;
//    error := '';
//    try
//      data := Client.Get(URL);
//    except
//      on e: exception do begin
//        result:= false;
//        error := e.Message;
//      end;
//    end;
//  end;

begin
  inherited;
  fStatus := tssPass;
  AddDetail('This is testing if an IP address outside your office/network (eg another site or web page)');
  AddDetail('can communicate with ERP through your WebAPI Module using IP address: ('+ context.S['PublicIP'] + ')');
  AddDetail('');

  if Pos('webapi',Lowercase(Context.S['ModuleList'])) = 0 then begin
    fStatus := tssFail;
    AddDetail('The Web API Module is not installed on your server.');
    exit;
  end;

  if not Context.O['WebAPIConfig'].B['Active'] then begin
    fStatus := tssFail;
    AddDetail('The Web API Module is stopped (not Active) on your server.');
    exit;
  end;

  if Context.O['WebAPIConfig'].S['WebUserName'] = '' then begin
    fStatus := tssFail;
    AddDetail('Your Web User Name is blank in the configuration, can not run test without this.');
    exit;
  end;

  if Context.A['WebApiDatabases'].Count = 0 then begin
    fStatus := tssFail;
    AddDetail('You do not have and Databases (company files) containging the user "' + Context.O['WebAPIConfig'].S['WebUserName'] + '".');
    AddDetail('Can not run the test without this.');
    exit;
  end
  else begin
    for x := 0 to Context.A['WebApiDatabases'].Count -1 do begin
      json:= Context.A['WebApiDatabases'].Items[x].AsObject;
      if (x = 0) or SameText('sample_company',json.S['database']) then begin
        Database := json.S['database'];
        Password := json.S['password'];
        if SameText('sample_company',json.S['database']) then
          break; { use sample_company by default .. else first in list }
      end;
    end;
  end;

  if Context.O['WebAPIConfig'].B['UseSSL'] then begin
    Port := Context.O['WebAPIConfig'].I['DefaultSSLPort'];
    if Port = 0 then begin
      fStatus := tssFail;
      AddDetail('The Web API Module is configured to use SSL but the SSL Port is not set.');
      exit;
    end;
  end
  else begin
    Port := Context.O['WebAPIConfig'].I['DefaultPort'];
    if Port = 0 then begin
      fStatus := tssFail;
      AddDetail('The Web API Module configuration Port is not set.');
      exit;
    end;
  end;

  if context.S['PublicIP'] = '' then begin
    fStatus := tssFail;
    AddDetail('Your Server/Public IP on the internet is blank, can not run test without this.');
    exit;
  end;

  AddDetail('Running the test using the following settings:');
  AddDetail(PadRight('Server: ',20) + context.S['PublicIP'],4);
  AddDetail(PadRight('Port: ',20) + IntToStr(Port),4);
  AddDetail(PadRight('UseSSL: ',20) + BoolToStr(Context.O['WebAPIConfig'].B['UseSSL'],true),4);
  AddDetail(PadRight('Database: ',20) + database,4);
  AddDetail(PadRight('User: ',20) + Context.O['WebAPIConfig'].S['WebUserName'],4);
  AddDetail(PadRight('Password: ',20) + Password,4);

  URL := 'http://www.trueerp.com/apitest.php';
  URL := URL + '?server=' + context.S['PublicIP'];
  URL := URL + '&port=' + IntToStr(POrt);;
  if Context.O['WebAPIConfig'].B['UseSSL'] then URL := URL + '&useSSL=true'
  else URL := URL + '&useSSL=false';
  URL := URL + '&database=' + Database;
  URL := URL + '&user=' + Context.O['WebAPIConfig'].S['WebUserName'];
  URL := URL + '&password=' + Password;


  Client := TIdHttp.Create(nil);
  sl := TStringList.Create;
  try
    Client.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    retryCount := 1;
    while retryCount <= max_retry do begin
//      if GetData then begin
      if THTTPUtils.Get(URL,data,error,Client) then begin
        SplitData(data,sl);
        if sl.Values['resultCode'] = '200' then begin
          AddDetail('');
          AddDetail('The WebAPI module can be accessed from the internet ok and is working correctly.');
          AddDetail('Response time was: ' + sl.Values['seconds'] + ' seconds.');
          exit;
        end
        else begin
          fStatus := tssFail;
          AddDetail('');
          AddDetail('Error requesting data from your WebAPI Module.');
          if sl.Values['error'] <> '' then begin
            AddDetail('The error returned was:');
            AddDetail(sl.Values['error'],2);
          end;
        end;
      end
      else begin
        if error <> '' then
          AddDetail('Error: ' + error)
        else
          AddDetail('Error running test.');

      end;
      AddDetail('');
      AddDetail('Trying again ...');
      Inc(retryCount);
    end;
  finally
    Client.Free;
  end;

  fStatus := tssFail;
  AddDetail('');
  AddDetail('Failed to connect to, or communicate with, your WebAPI module please check the following:');
  AddDetail('1) The WebAPI Port (' + IntToStr(Port) + ') is not blocked by your server firewall.',2);
  AddDetail('2) If your server is connected to the internet by a Router,',2);
  AddDetail('   make sure this port (' + IntToStr(Port) + ') is "port forwarded" in the router to your server machine.',2);
  AddDetail('   Please contact your web administrator or ISP as ERP cannot do this.',2);
  AddDetail('');
  AddDetail('Suggested web sites for more information re ports and forwarding:');
  AddDetail('http://www.yougetsignal.com/tools/open-ports');
  AddDetail('http://www.t1shopper.com/tools/port-scan');
  AddDetail('http://en.wikipedia.org/wiki/Port_forwarding');
end;


end.
