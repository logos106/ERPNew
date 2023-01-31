unit SiteIntergrationTestObj;

interface

uses
  IdHttp, IdSSLOpenSSL, JsonRpcTcpClient, Classes, JsonObject, Contnrs, TesterObj;

type

  TSiteIntergrationTestList = class(TTestList)
  public
    constructor Create;
  end;

  TSiteIntergrationTest = class(TTestStep)
  private
  public
    constructor Create;
    procedure DoTest(context: TJsonObject); override;
  end;

  TRemoteAPITestedTest = class(TTestStep)
  private
  public
    constructor Create;
    procedure DoTest(context: TJsonObject); override;
  end;

implementation

uses
  UtilsTestObj, sysutils, WebApiClientObj, IdURI;

{ TSiteIntergrationTestList }

constructor TSiteIntergrationTestList.Create;
var
  Test: TTestStep;
begin
  inherited;
  Test := TRemoteAPITestedTest.Create;
  AddTest(Test);
  Test := TUtilsServerTest.Create;
  AddTest(Test);
  Test:= TWebAPIConfigTest.Create;
  AddTest(Test);
  Test:= TMySQLTest.Create;
  AddTest(Test);
  Test:= TWebAPIModuleInternalTest.Create;
  AddTest(Test);
  Test := TSiteIntergrationTest.Create;
  AddTest(Test);
end;

{ TSiteIntergrationTest }

constructor TSiteIntergrationTest.Create;
begin
  inherited;
  fCaption := 'Check Site Integration settings';
end;

procedure TSiteIntergrationTest.DoTest(context: TJsonObject);
var
  ApiClient: TWebApiClient;
  json: TJsonObject;
  site: TJsonObject;
  x: integer;
  URL: string;


  procedure ProcessError(msg: string);
  var
    aPort: string;
    URI: TIdURI;
  begin
    URI:= TIdURI.Create(ApiClient.URL);
    try
      if SameText(URI.Protocol,'https') then aPort:= '443'
      else if SameText(URI.Protocol,'http') then aPort:= '8080'
      else aPort:= '0';
      AddDetail('Error testing site:');
      AddDetail(msg,2);
      AddDetail('');
      if Pos('invalid user name',Lowercase(msg)) > 0 then begin
        AddDetail('Make sure the database contains an employee with a Logon Name that matches the one specified ('+ ApiClient.UserName +').');
      end
      else if Pos('invalid user password',Lowercase(msg)) > 0 then begin
        AddDetail('Make sure the database contains an employee with a Logon Password that matches the one specified ('+ ApiClient.Password +').');
      end
      else if Pos('host not found',Lowercase(msg)) > 0 then begin
        AddDetail('Please chect the following:');
        AddDetail('1) The URL is correct for the server you wish to connect to ('+ApiClient.URL+').',2);
        AddDetail('2) The specified port matches the server Web API port ('+aPort+').',2);
        AddDetail('3) Routers and firewalls are configured to allow access to the specified port.',2);
      end
      else if Pos('connection refused',Lowercase(msg)) > 0 then begin
        AddDetail('Please chect the following:');
        AddDetail('1) The specified port matches the server Web API port ('+aPort+').',2);
        AddDetail('2) Routers and firewalls are configured to allow access to the specified port.',2);
      end
      else begin
        AddDetail('Please chect the following:');
        AddDetail('1) The URL is correct for the server you wish to connect to ('+ApiClient.URL+').',2);
        AddDetail('2) The specified port matches the server Web API port ('+aPort+').',2);
        AddDetail('3) Routers and firewalls are configured to allow access to the specified port.',2);
        AddDetail('4) Make sure the database name specified ('+ ApiClient.Database +') matches the database on the server ('+ ApiClient.URL +').',2);
      end;
      AddDetail('For more information see the TrueERP Wiki:');
      AddDetail('http://www.trueerp.com/wiki/EDI_Integration');
    finally
      URI.Free;
    end;
  end;

begin
  inherited;
  fStatus := tssPass;
  AddDetail('');

  if Context.S['ModuleList'] = '' then begin
    AddDetail('Could not get a list of Modules installed on your ERP Server so can not continue with test.');
    fStatus := tssFail;
    exit;
  end
  else if (Pos('webapi',Lowercase(Context.S['ModuleList'])) =0) then begin
    AddDetail('The WebAPI Module is not installed on your ERP Server ('+context.S['ERPServer']+').');
    AddDetail('This module is required to run Site Integration, can not continue with testing.');
    fStatus := tssFail;
    exit;
  end
  else if (Pos('siteintegration',Lowercase(Context.S['ModuleList'])) =0) then begin
    AddDetail('The Site Integration Module is not installed on your ERP Server ('+context.S['ERPServer']+').');
    AddDetail('This means that you will not be able to configure or run Site Intergration from your server,');
    AddDetail('BUT other ERP Sites will still be able to Integrate with your Server as long as they have ');
    AddDetail('the Site Integration module installed and configured.');
    fStatus := tssWarn;
    exit;
  end
  else if (context.O['Config'].A['Sites'].Count = 0) then begin
    AddDetail('You do not have sites configured for Site Integration.');
    AddDetail('Please go to the "EDI and Integration" section in Preferences and add an entry under "Site Integration Config".');
    fStatus := tssFail;
    exit;
  end
  else if (context.S['SelectedSite'] = '') then begin
    AddDetail('No site has been selected for testing.');
    fStatus := tssFail;
    exit;
  end;

  { now we can do the actual test }
  AddDetail('Testing site: ' + context.S['SelectedSite']);
  AddDetail('');

  site:= nil;
  for x := 0 to context.O['Config'].A['Sites'].Count -1 do begin
    if SameText(context.O['Config'].A['Sites'].Items[x].AsObject.S['Name'], context.S['SelectedSite']) then begin
      site:= context.O['Config'].A['Sites'].Items[x].AsObject;
      break;
    end;
  end;
  if not Assigned(site) then begin
    AddDetail('Could not find the configuration for ' + context.S['SelectedSite'] + '.');
    fStatus := tssFail;
    exit;
  end;

  { check config values }
  URL:= Lowercase(site.S['SourceURL']);
  if URL = '' then begin
    AddDetail('The Source URL is blank.');
    fStatus := tssFail;
    exit;
  end
  else if not ((Pos('https://', URL) = 1) or (Pos('http://', URL) = 1)) then begin
    AddDetail('The Source URL format is invalid, this should be somthing like: https://localhost');
    fStatus := tssFail;
    exit;
  end
  else if site.S['SourceDatabase'] = '' then begin
    AddDetail('The Source URL is blank.');
    fStatus := tssFail;
    exit;
  end
  else if site.S['SourceUserName'] = '' then begin
    AddDetail('The Source User Name is blank.');
    fStatus := tssFail;
    exit;
  end
  else if site.S['SourcePassword'] = '' then begin
    AddDetail('The Source Password is blank.');
    fStatus := tssFail;
    exit;
  end;

  URL:= Lowercase(site.S['DestinationURL']);
  if URL = '' then begin
    AddDetail('The Destination URL is blank.');
    fStatus := tssFail;
    exit;
  end
  else if not ((Pos('https://', URL) = 1) or (Pos('http://', URL) = 1)) then begin
    AddDetail('The Destination URL format is invalid, this should be somthing like: https://localhost');
    fStatus := tssFail;
    exit;
  end
  else if site.S['DestinationDatabase'] = '' then begin
    AddDetail('The Destination URL is blank.');
    fStatus := tssFail;
    exit;
  end
  else if site.S['DestinationUserName'] = '' then begin
    AddDetail('The Destination User Name is blank.');
    fStatus := tssFail;
    exit;
  end
  else if site.S['DestinationPassword'] = '' then begin
    AddDetail('The Destination Password is blank.');
    fStatus := tssFail;
    exit;
  end;


  ApiClient := TWebApiClient.Create;
  json:= JO;
  try
    ApiClient.URL := Lowercase(site.S['SourceURL']);
    ApiClient.UserName := site.S['SourceUserName'];
    ApiClient.Password := site.S['SourcePassword'];
    ApiClient.Database := site.S['SourceDatabase'];

    AddDetail('Testing source: ' + ApiClient.URL + '  ...');
    if not ApiClient.Get('TErpSysInfo',json) then begin
      ProcessError(ApiClient.ErrorMessage);
      fStatus := tssFail;
      exit;
    end;
    AddDetail('Passed Ok.');
    AddDetail('');

    { now destination }
    ApiClient.URL := Lowercase(site.S['DestinationURL']);
    ApiClient.UserName := site.S['DestinationUserName'];
    ApiClient.Password := site.S['DestinationPassword'];
    ApiClient.Database := site.S['DestinationDatabase'];

    AddDetail('Testing destination: ' + ApiClient.URL + '  ...');
    if not ApiClient.Get('TErpSysInfo',json) then begin
      ProcessError(ApiClient.ErrorMessage);
      fStatus := tssFail;
      exit;
    end;
    AddDetail('Passed Ok.');


  finally
    json.Free;
    ApiClient.Free;
  end;


end;

{ TRemoteAPITestedTest }

constructor TRemoteAPITestedTest.Create;
begin
  inherited;
  fCaption := 'User has run WebAPI tests on remote site';
end;

procedure TRemoteAPITestedTest.DoTest(context: TJsonObject);
begin
  inherited;
  fStatus := tssPass;
  if not context.B['UserHasTestedRemoteWebAPI'] then begin
    fStatus := tssFail;
    AddDetail('Please open the "Link To" buton and select "Link to Web Site" on the remote ERP site.');
    AddDetail('Once done and all passed please tick "WebAPI tests have been run on remote ERP Server".');
  end;
end;

end.
