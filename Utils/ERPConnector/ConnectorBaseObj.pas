unit ConnectorBaseObj;

interface

uses
  LogThreadBase, LogMessageTypes, JsonConfigObj, JsonObject,
  IdHttpServer, IdContext, IdCustomHTTPServer, SysUtils, IdURI, Classes,
  WebAPIClientObj;

type
  TConnectorBase = class
  private
    TerminateServer: boolean;
    LogList: TStringList;
    procedure DoLogEvent(Sender: TObject; const Event, Value : string);
    procedure DoOnCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure DoOnConnect(AContext: TIdContext);
    procedure DoOnDisconnect(AContext: TIdContext);
    procedure DoServerThreadException(AContext:TIdContext; AException: Exception);
    procedure DoOnInvalidSession(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo; var VContinueProcessing: Boolean; const AInvalidSessionID: String);
    function LoginPage(msg: string = ''): string;
    function LogPage: string;
    function WebAPIConfigPage(msg: string = ''): string;
    function MakeMenu: string;
  protected
    FLogger: TLoggerBase;
    fConnectorName: string;
    Config: TJsonConfig;
    Menu: TJSONArray;
//    fConfigPort: integer;
    ConfigServer: TIdHttpServer;
    property ConnectorName: string read fConnectorName;
    function MainCSS: string;
    function MenuCSS: string;
    function FormCSS: string;
    function MakePage(const aTitle, aHeader, aBody: string; ShowMenu: boolean = true): string;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    function DoPage(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo; URI: TIdURI): boolean; virtual;
    function SetConfigDefaults: boolean; virtual;
    { write params to json object if values found, returns true if any changed }
    function UpdateJsonFromParams(obj: TJsonObject; params: TStrings): boolean;
    function TestERPConnectivity(var msg: string): boolean;
    function GetApiClient: TWebAPIClient;
  public
    constructor Create(aLogger: TLoggerBase); virtual;
    destructor Destroy; override;
  end;

implementation

uses
  strutils, windows, Messages, ModuleFileNameUtils;

const
  Config_User = 'Admin';

{ TConnectorBase }

constructor TConnectorBase.Create(aLogger: TLoggerBase);
begin
  fConnectorName := 'ERP Connector';
  TerminateServer:= false;
  LogList := TStringList.Create;
  fLogger := aLogger;
  try
    fLogger.HistoryLines(2000, LogList);
    fLogger.Events.AddMultiEvent(DoLogEvent);
    Config := TJsonConfig.Create;
    Config.Load;
    if SetConfigDefaults then
      Config.Save;
    Log('Using config file: ' + Config.ConfigFileName+ ' Port: ' + IntToStr(Config.I['ConfigPort']), ltInfo);
    ConfigServer := TIdHttpServer.Create(nil);
    ConfigServer.Bindings.Clear;
    ConfigServer.DefaultPort := Config.I['ConfigPort'];
    ConfigServer.OnCommandGet := DoOnCommandGet;
    ConfigServer.OnConnect := DoOnConnect;
    ConfigServer.OnDisconnect := DoOnDisconnect;
    ConfigServer.OnException := DoServerThreadException;
    ConfigServer.OnInvalidSession := DoOnInvalidSession;
    ConfigServer.SessionState := true;
    ConfigServer.AutoStartSession := true;
    ConfigServer.SessionTimeOut := 60000 * 30; { 30 mins }
    Log('Starting config HTTP Server on port ' + IntToStr(ConfigServer.DefaultPort), ltDetail);
    try
      ConfigServer.Active := true;
    except
      on e: exception do begin
        Log('Error starting config HTTP server: ' + e.Message, ltError);
      end;
    end;
    Menu := TJSONArray.Create;
    Menu.Clear;
    Menu.Add(JO('{"href":"home","caption":"Home"}'));
    Menu.Add(JO('{"href":"webapiconfig","caption":"Web API Config"}'));
    Menu.Add(JO('{"href":"log","caption":"Log"}'));
    Menu.Add(JO('{"href":"logout","caption":"Logout"}'));
    Menu.Add(JO('{"href":"terminate","caption":"Terminate Server"}'));
  except
    on e: exception do begin
      Log('Error creating '+fConnectorName+': ' + e.Message, ltError);
    end;
  end;
end;

destructor TConnectorBase.Destroy;
begin
  ConfigServer.Free;
  Config.Free;
  Menu.Free;
  LogList.Free;
  inherited;
end;

procedure TConnectorBase.DoLogEvent(Sender: TObject; const Event,
  Value: string);
begin
  LogList.Add(Value);
  while LogList.Count > 2000 do
    LogList.Delete(0);
end;

procedure TConnectorBase.DoOnCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  uri: TIdURI;
begin
  uri := TIdURI.Create(ARequestInfo.URI);
  try
//    Log(ARequestInfo.URI + ' Doc: ' + ARequestInfo.Document);
//    Log('Path: ' + uri.Path + ' Doc: ' + uri.Document);
    if SameText(uri.Document,'favicon.ico') then begin
      exit;
    end;
    if not Assigned(ARequestInfo.Session) then begin
      AResponseInfo.ContentText :=  MakePage('Login Fail','<h1>Login fail</h1>','Could not retreive session information.');
      exit;
    end;
    if not Assigned(ARequestInfo.Session.Content) then begin
      AResponseInfo.ContentText :=  MakePage('Login Fail','<h1>Login fail</h1>','Could not retreive session content information.');
      exit;
    end;

    if uri.Document <> 'login_form' then begin
      if (ARequestInfo.Session.Content.IndexOfName('Authorized') > -1) and (ARequestInfo.Session.Content.Values['Authorized'] = 'true') then begin

      end
      else begin
        if (ARequestInfo.Session.Content.IndexOfName('LoginCount') = -1) or (StrToIntDef(ARequestInfo.Session.Content.Values['LoginCount'],0) >= 5) then
          AResponseInfo.ContentText :=  LoginPage()
        else
          AResponseInfo.ContentText :=  MakePage('Login Fail','<h1>Login fail</h1>','<h2>Maximum mumber of login attempts exceeded.</h2>',false);
        exit;
      end;
    end;
    if ARequestInfo.CommandType = hcGet then begin
      if uri.Document = 'logout' then begin
        AResponseInfo.ContentText := LoginPage();
        ConfigServer.EndSession(AResponseInfo.Session.SessionID);
        Log('User logged out of config.',ltInfo);
      end
      else if uri.Document = 'home' then begin
        if not DoPage(AContext,ARequestInfo,AResponseInfo,uri) then
          AResponseInfo.ContentText := MakePage('Home','<h1>Home</h1>','');
      end
      else if uri.Document = 'log' then begin
        AResponseInfo.ContentText := self.LogPage;
      end
      else begin
        self.DoPage(AContext,ARequestInfo,AResponseInfo,uri);

      end;
    end
    else if ARequestInfo.CommandType = hcPost then begin
      if uri.Document = 'login_form' then begin
//        Log(ARequestInfo.Params.CommaText);
        if (ARequestInfo.Session.Content.IndexOfName('LoginCount') > -1) and (StrToIntDef(ARequestInfo.Session.Content.Values['LoginCount'],0) >= 5) then begin
          AResponseInfo.ContentText :=  MakePage('Login Fail','<h1>Login fail</h1>','<h2>Maximum mumber of login attempts exceeded.</h2>',false);
          Log('Maximum mumber of login attempts exceeded.',ltWarning);
          exit;
        end;
        if SameText(ARequestInfo.Params.Values['username'],Config_User) and
           SameText(ARequestInfo.Params.Values['password'],Config.S['Password']) then begin
          { user logged in ok }
          if ARequestInfo.Session.Content.IndexOfName('Authorized') < 0 then
            ARequestInfo.Session.Content.Add('Authorized=true')
          else
            ARequestInfo.Session.Content.Values['Authorized'] := 'true';
          uri.Document := 'home';
          if not DoPage(AContext,ARequestInfo,AResponseInfo,uri) then
            AResponseInfo.ContentText :=  MakePage('Home','<h1>Home</h1>','');
          Log('User logged into config.',ltInfo);
        end
        else begin
          { login fail }
          if ARequestInfo.Session.Content.IndexOfName('LoginCount') < 0 then
            ARequestInfo.Session.Content.Add('LoginCount=1')
          else
            ARequestInfo.Session.Content.Values['LoginCount'] :=
              IntToStr(StrToIntDef(ARequestInfo.Session.Content.Values['LoginCount'],0) + 1);

          AResponseInfo.ContentText :=  LoginPage('<h2>Invalid Username / Password combination.</h2>');

        end;
      end
      else begin
        { not login form }
        self.DoPage(AContext,ARequestInfo,AResponseInfo,uri);
      end;
    end;

  finally
    uri.Free;
  end;
end;

procedure TConnectorBase.DoOnConnect(AContext: TIdContext);
begin
//  Log('HTTP Connect', ltDetail);
end;


procedure TConnectorBase.DoOnDisconnect(AContext: TIdContext);
var
  hwnd: THandle;
begin
  if TerminateServer then begin
    //Application.Terminate;
    //Halt;
    hwnd := FindWindow(nil,PChar(GetCurrentModuleName));
    PostMessage(hwnd, WM_KEYDOWN, VK_RETURN, 0);
    PostMessage(hwnd, WM_KEYUP, VK_RETURN, 0);
  end;
end;

procedure TConnectorBase.DoOnInvalidSession(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
  var VContinueProcessing: Boolean; const AInvalidSessionID: String);
begin
  VContinueProcessing := true;
//  Log('DoOnInvalidSession');
end;

function TConnectorBase.DoPage(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
  URI: TIdURI): boolean;
var
  msg: string;
begin
  result := false;
  if SameText(URI.Document,'terminate') then begin
    TerminateServer:= true;
    AResponseInfo.ContentText :=  MakePage('Server Terminate','<h1>Server Terminate</h1>','<h2>Bye Bye ..</h2>',false);
    result:= true;
  end
  else if SameText(URI.Document,'webapiconfig') then begin
    if ARequestInfo.CommandType = hcGet then begin
      AResponseInfo.ContentText := self.WebAPIConfigPage;
      result:= true;
    end
    else if ARequestInfo.CommandType = hcPost then begin
      result:= true;
//      Log(ARequestInfo.FormParams);
      { if form check box's are not checked they will not be included in
        parameters .. so add with a value of "false" if missing }
      if ARequestInfo.Params.IndexOfName('usessl') < 0 then
        ARequestInfo.Params.Add('usessl=false');

      if self.UpdateJsonFromParams(Config.O['WebAPI'],ARequestInfo.Params) then begin
        Config.Save;
        if SameText(ARequestInfo.Params.Values['button'],'Save') then begin
          AResponseInfo.ContentText := self.WebAPIConfigPage('<h3>Changes have been saved.</h3><br />');
          Log('WebAPI config changed by user.',ltInfo);
        end
        else if SameText(ARequestInfo.Params.Values['button'],'Test') then begin
          { test it }
          if not TestERPConnectivity(msg) then begin
            AResponseInfo.ContentText := self.WebAPIConfigPage('<h3>Changes have been saved.<br />'+msg+'</h3><br />');
          end
          else begin
            AResponseInfo.ContentText := self.WebAPIConfigPage('<h3>Changes have been saved.<br />Communication with ERP Web API is working OK.</h3><br />');
          end;
          Log('WebAPI config changed by user.',ltInfo);
        end;
      end
      else begin
        { nothing changed }
        if SameText(ARequestInfo.Params.Values['button'],'Test') then begin
          { test it }
          if not TestERPConnectivity(msg) then
            AResponseInfo.ContentText := self.WebAPIConfigPage('<h3>'+msg + '</h3><br />')
          else
            AResponseInfo.ContentText := self.WebAPIConfigPage('<h3>Communication with ERP Web API is working OK.</h3><br />');
        end
        else begin
          AResponseInfo.ContentText := self.WebAPIConfigPage();
        end;
      end;






    end;
  end;
end;

procedure TConnectorBase.DoServerThreadException(AContext: TIdContext;
  AException: Exception);
begin
  Log(AException.Message, ltError);
end;

function TConnectorBase.FormCSS: string;
begin
  result :=
    '.feedbackform{' + #13#10 +
    'padding: 5px;' + #13#10 +
    '}' + #13#10 +
    '' + #13#10 +
    'div.fieldwrapper{ /*field row DIV (includes two columns- Styled label column and "thefield" column)*/' + #13#10 +
    'width: 550px; /*width of form rows*/' + #13#10 +
    'overflow: hidden;' + #13#10 +
    'padding: 5px 0;' + #13#10 +
    '}' + #13#10 +
    '' + #13#10 +
    'div.fieldwrapper label.styled{ /* label elements that should be styled (left column within fieldwrapper DIV) */' + #13#10 +
    'float: left;' + #13#10 +
    'width: 150px; /*width of label (left column)*/' + #13#10 +
    'text-transform: uppercase;' + #13#10 +
    'border-bottom: 1px solid red;' + #13#10 +
    'margin-right: 15px; /*spacing with right column*/' + #13#10 +
    '}' + #13#10 +
    '' + #13#10 +
    'div.fieldwrapper div.thefield{ /* DIV that wraps around the actual form fields (right column within fieldwrapper DIV) */' + #13#10 +
    'float: left;' + #13#10 +
    'margin-bottom: 10px; /* space following the field */' + #13#10 +
    '}' + #13#10 +
    '' + #13#10 +
    'div.fieldwrapper div.thefield input[type="text"]{ /* style for INPUT type="text" fields. Has no effect in IE7 or below! */' + #13#10 +
    'width: 250px;' + #13#10 +
    '}' + #13#10 +
    '' + #13#10 +
    'div.fieldwrapper div.thefield textarea{ /* style for TEXTAREA fields. */' + #13#10 +
    'width: 300px;' + #13#10 +
    'height: 150px;' + #13#10 +
    '}' + #13#10 +
    '' + #13#10 +
    'div.buttonsdiv{ /*div that wraps around the submit/reset buttons*/' + #13#10 +
    'margin-top: 5px; /*space above buttonsdiv*/' + #13#10 +
    '}' + #13#10 +
    '' + #13#10 +
    'div.buttonsdiv input{ /* style for INPUT fields within "buttonsdiv". Assumed to be form buttons. */' + #13#10 +
    'width: 80px;' + #13#10 +
    'background: #e1dfe0;' + #13#10 +
    '}';
end;

function TConnectorBase.GetApiClient: TWebAPIClient;
begin
  result := TWebApiClient.Create;
  result.UserName := Config.O['WebAPI'].S['ERPUserName'];
  result.Password := Config.O['WebAPI'].S['ERPUserPassword'];
  result.Database := Config.O['WebAPI'].S['ERPDatabase'];
  if Config.O['WebAPI'].B['USeSSL'] then
    result.URL := 'https://' + Config.O['WebAPI'].S['ServerName'] + ':' + IntToStr(Config.O['WebAPI'].I['ServerPort'])
  else
    result.URL := 'http://' + Config.O['WebAPI'].S['ServerName'] + ':' + IntToStr(Config.O['WebAPI'].I['ServerPort']);
end;

function TConnectorBase.MainCSS: string;
begin
  result :=
    'body {' + #13#10 +
     'font-family: Arial, Helvetica, sans-serif;' + #13#10 +
     'font-size: 13px;' + #13#10 +
    '}' + #13#10 +
    '#wrapper {' + #13#10 +
     'margin: 0 auto;' + #13#10 +
     'width: 922px;' + #13#10 +
    '}' + #13#10 +
    '#header {' + #13#10 +
     'color: #333;' + #13#10 +
     'width: 900px;' + #13#10 +
     'float: left;' + #13#10 +
     'padding: 10px;' + #13#10 +
     'border: 1px solid #ccc;' + #13#10 +
     'height: 80px;' + #13#10 +
     'margin: 10px 0px 0px 0px;' + #13#10 +
     'background: #E7DBD5;' + #13#10 +
    '}' + #13#10 +
//    '#navigation {' + #13#10 +
//     'float: left;' + #13#10 +
//     'width: 900px;' + #13#10 +
//     'color: #333;' + #13#10 +
//     'padding: 10px;' + #13#10 +
//     'border: 1px solid #ccc;' + #13#10 +
//     'margin: 0px 0px 0px 0px;' + #13#10 +
//     'background: #BD9C8C;' + #13#10 +
//    '}' + #13#10 +
    '#leftcolumn {' + #13#10 +
     'color: #333;' + #13#10 +
     'border: 1px solid #ccc;' + #13#10 +
     'background: #E7DBD5;' + #13#10 +
     'margin: 0px 0px 0px 0px;' + #13#10 +
     'padding: 10px;' + #13#10 +
//     'height: 350px;' + #13#10 +
     'height: 600px;' + #13#10 +
     'width: 190px;' + #13#10 +
     'float: left;' + #13#10 +
    '}' + #13#10 +
    '#rightcolumn {' + #13#10 +
     'float: right;' + #13#10 +
     'color: #333;' + #13#10 +
     'border: 1px solid #ccc;' + #13#10 +
     'background: #F2F2E6;' + #13#10 +
     'margin: 0px 0px 0px 0px;' + #13#10 +
     'padding: 10px;' + #13#10 +
//     'height: 350px;' + #13#10 +
     'height: 600px;' + #13#10 +
     'width: 688px;' + #13#10 +
     'display: inline;' + #13#10 +
     'position: relative;' + #13#10 +
    '}'
    ;
end;

procedure TConnectorBase.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg, LogMessageType);
end;

function TConnectorBase.LoginPage(msg: string): string;
const
  form =
    '<form class="feedbackform" action="login_form" method="post">' + #13#10 +
//    '<form action="login_form.htm" method="get">' + #13#10 +
    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="username" class="styled">User Name:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="text" id="username" value="Admin" name="username" size="30" />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="password" class="styled">Password:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="password" id="password" value="" name="password" size="30" />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="buttonsdiv">' + #13#10 +
	  '<input type="submit" value="Submit" style="margin-left: 150px;" />' + #13#10 +
    '</div>' + #13#10 +
    '</form>';
begin
  result:= self.MakePage('Login','<h1>Login</h1>'+msg,form, false);
end;

function TConnectorBase.LogPage: string;
var
  s: string;
  x: integer;
begin
  s:=
    '<div style="height:595px;' + #13#10 +
    'width:683px;border:1px solid #ccc;' + #13#10 +
//    'font:16px/26px Georgia, Garamond, Serif;' + #13#10 +
    'overflow:auto;">' + #13#10;
  for x := LogList.Count -1 downto 0 do
    s := s + LogList[x] + '<br />';
  s:= s + #13#10 + '</div>';
  result:= self.MakePage('Log','<h1>Log</h1>',s, true);
end;

function TConnectorBase.MakeMenu: string;
var
  x: integer;
begin
//  result :=
//    '<ul class="buttonmenu">' + #13#10 +
//    '<li><a href="http://www.dynamicdrive.com/">Dynamic Drive</a></li>' + #13#10 +
//    '<li><a href="http://www.dynamicdrive.com/style/">CSS Library</a></li>' + #13#10 +
//    '<li><a href="http://www.cssdrive.com/">CSS Drive</a></li>' + #13#10 +
//    '<li><a href="http://tools.dynamicdrive.com/imageoptimizer/">Gif Optimizer</a></li>' + #13#10 +
//    '<li><a href="http://tools.dynamicdrive.com/favicon/">Favicon Creator</a></li>' + #13#10 +
//    '<li><a href="http://tools.dynamicdrive.com/button/">Button Maker</a></li>' + #13#10 +
//    '<li><a href="logout">Logout</a></li>' + #13#10 +
//    '</ul>';

  result:= '<ul class="buttonmenu">';
  for x := 0 to Menu.Count -1 do begin
    result := result + #13#10 +
      '<li><a href="' + Menu.Items[x].AsObject.S['href'] + '">' + Menu.Items[x].AsObject.S['caption'] + '</a></li>';
  end;
  result:= result + '</ul>';

end;

function TConnectorBase.MakePage(const aTitle, aHeader, aBody: string; ShowMenu: boolean): string;
begin
  result :=
    '<!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"">' + #13#10 +
    '<html xmlns="http://www.w3.org/1999/xhtml">' + #13#10 +
//    '<html>' + #13#10 +
    '<head>' + #13#10 +
    '<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />' + #13#10 +
    '<title>' + aTitle +'</title>' + #13#10 +

    '<style type="text/css">' + #13#10 +
    MainCSS + #13#10 +
    MenuCSS + #13#10 +
    FormCSS + #13#10 +
    '</style>'  + #13#10 +

    '</head>' + #13#10 +

    '<body>' + #13#10 +
    '<!-- Begin Wrapper -->' + #13#10 +
    '<div id="wrapper">' + #13#10 +

    '<!-- Begin Header -->' + #13#10 +
    '<div id="header">' + #13#10 +
    aHeader + #13#10 +
    '</div>' + #13#10 +

	  '<!-- Begin Left Column -->' + #13#10 +
		'<div id="leftcolumn">' + #13#10;

  if ShowMenu then begin
    result := result +
      MakeMenu + #13#10;
  end;
  result := result +
    '</div>' + #13#10 +
	  '<!-- Begin Right Column -->' + #13#10 +
		'<div id="rightcolumn">' + #13#10 +
    aBody + #13#10 +
   '</div>' + #13#10 +

   '</div>' + #13#10 +
   '<!-- End Wrapper -->' + #13#10 +
   '</body>' + #13#10 +
   '</html>';
end;

function TConnectorBase.MenuCSS: string;
begin
  result :=
    '.buttonmenu{' + #13#10 +
    'list-style-type: none;' + #13#10 +
    'margin: 0;' + #13#10 +
    'padding: 0;' + #13#10 +
    'width: 180px;' + #13#10 +
    '}' + #13#10 +
    '' + #13#10 +
    '.buttonmenu li a{' + #13#10 +
    'color: white;' + #13#10 +
    'display: block;' + #13#10 +
    'width: 100%;' + #13#10 +
    'padding: 2px 4px;' + #13#10 +
    'text-decoration: none;' + #13#10 +
    'font-weight: bold;' + #13#10 +
    'border: 1px solid;' + #13#10 +
    'border-color:#D5BFD0 #5A3A54 #5A3A54 #D5BFD0; /*light dark dark light*/' + #13#10 +
    'background-color: #704968;' + #13#10 +
    'text-decoration:none;' + #13#10 +
    '}' + #13#10 +
    '' + #13#10 +

    '.buttonmenu li a:visited{' + #13#10 +
    'color: white;' + #13#10 +
    '}' + #13#10 +
    '' + #13#10 +
    '.buttonmenu li a:hover, .buttonmenu li a:active{' + #13#10 +
    'color: black;' + #13#10 +
    'background-color: #CDB4C8;' + #13#10 +
    '}';
end;
function TConnectorBase.SetConfigDefaults: boolean;
begin
  result:= false;
  if (not Config.IntegerExists('ConfigPort')) or (Config.I['ConfigPort'] < 1) then begin
    Config.I['ConfigPort'] := 80;
    result := true;
  end;
  if (not Config.StringExists('Password')) or (Config.S['Password'] = '') then begin
    Config.S['Password'] := 'admin';
    result := true;
  end;
  if not Config.ObjectExists('WebAPI') then begin
    Config.O['WebAPI'].S['ServerName'] := 'localhost';
    Config.O['WebAPI'].I['ServerPort'] := 443;
    Config.O['WebAPI'].B['UseSSL'] := true;
    Config.O['WebAPI'].S['ERPUserName'] := 'webuser';
    Config.O['WebAPI'].S['ERPUserPassword'] := 'webuser';
    Config.O['WebAPI'].S['ERPDatabase'] := 'sample_company';
    result := true;
  end;
end;

function TConnectorBase.TestERPConnectivity(var msg: string): boolean;
var
  api: TWebApiClient;
  json: TJsonObject;
begin
  result:= true;
  json := JO;
  api := GetApiClient;
  try
    if not api.Get('TErpSysInfo',json) then begin
      result := false;
      msg:= 'Error connecting to Web API:<br />' + StringReplace(api.ErrorMessage,#13#10,'<br />',[rfReplaceAll]);
    end;
  finally
    api.Free;
    json.Free;
  end;
end;

function TConnectorBase.UpdateJsonFromParams(obj: TJsonObject;
  params: TStrings): boolean;
var
  x: integer;
  name: string;
begin
  result:= false;
  for x := 0 to params.Count -1 do begin
    if obj.Exists(params.Names[x]) then begin
      if obj.ItemByName[params.Names[x]].Value.AsString <> params.ValueFromIndex[x] then begin
        obj.ItemByName[params.Names[x]].Value.AsString := params.ValueFromIndex[x];
        result:= true;
      end;
    end
    else if Pos('.hidden',params.Names[x]) > 0 then begin
      name := Copy(params.Names[x], 1, Pos('.hidden',params.Names[x])-1);
      if obj.Exists(name) then begin
        if params.IndexOf(name) < 0 then begin
          obj.ItemByName[name].Value.AsString := params.ValueFromIndex[x];
          result:= true;
        end;
      end;
    end;
  end;
end;

function TConnectorBase.WebAPIConfigPage(msg: string): string;
var
  form: string;
  UseSSLChecked: string;
begin
  if Config.O['WebAPI'].B['UseSSL'] then
    UseSSLChecked := 'checked'
  else
    UseSSLChecked := '';

  form :=
    '<form class="feedbackform" action="webapiconfig" method="post">' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="servername" class="styled">Web API Server:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="text" id="servername" value="' + Config.O['WebAPI'].S['ServerName'] + '" name="servername" size="30" /><br />' + #13#10 +
		'<span style="font-size: 90%">*Note: Server Name or IP address (eg 127.1.1.10)</span>' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="serverport" class="styled">Server Port:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="number" id="serverport" value="' + IntToStr(Config.O['WebAPI'].I['ServerPort']) + '" name="serverport" size="30" />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="usessl" class="styled">Use SSL:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="checkbox" id="usessl" value="true" name="usessl" ' + UseSSLChecked + '/>' + #13#10 +
    '<input type="hidden" value="false" name="usessl.hidden"/>'  + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="erpusername" class="styled">ERP User Name:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="text" id="erpusername" value="' + Config.O['WebAPI'].S['ERPUserName'] + '" name="erpusername" size="30" />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="erppassword" class="styled">ERP Password:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="password" id="erppassword" value="' + Config.O['WebAPI'].S['ERPUserName'] + '" name="erppassword" size="30" />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="fieldwrapper">' + #13#10 +
	  '<label for="erpdatabase" class="styled">ERP Database:</label>' + #13#10 +
	  '<div class="thefield">' + #13#10 +
		'<input type="text" id="erpdatabase" value="' + Config.O['WebAPI'].S['ERPDatabase'] + '" name="erpdatabase" size="30" />' + #13#10 +
	  '</div>' + #13#10 +
    '</div>' + #13#10 +

    '<div class="buttonsdiv">' + #13#10 +
	  '<input type="submit" value="Save" name="button" style="margin-left: 150px;" /><input type="submit" value="Test" name="button" />' + #13#10 +
    '</div>' + #13#10 +
    '</form>';

  result:= self.MakePage('ERP WebAPI Config','<h1>ERP WebAPI Config</h1>',msg+form, true);
end;

(*
<form class="feedbackform">

<div class="fieldwrapper">
	<label for="username" class="styled">Your Name:</label>
	<div class="thefield">
		<input type="text" id="username" value="" size="30" />
	</div>
</div>

<div class="fieldwrapper">
	<label for="email" class="styled">Email address:</label>
	<div class="thefield">
		<input type="text" id="email" value="" size="30" /><br />
		<span style="font-size: 80%">*Note: Please make sure it's correctly entered!</span>
	</div>
</div>

<div class="fieldwrapper">
	<label for="somehighschool" class="styled">education:</label>
	<div class="thefield">
		<ul style="margin-top:0;">
		<li><input type="radio" id="somehighschool" name="education" value=""/> <label for="somehighschool">Some Highschool</label></li>
		<li><input type="radio" id="highschool" name="education" value="" /> <label for="highschool">Highschool graduate</label></li>
		<li><input type="radio" id="somecollege" name="education" value="" /> <label for="somecollege">Some college</label></li>
		<li><input type="radio" id="vocation" name="education" value="" /> <label for="vocation">Vocation school</label></li>
		<li><input type="radio" id="college" name="education" value="" /> <label for="college">College graduate or higher</label></li>
		</ul>
	</div>
</div>

<div class="fieldwrapper">
	<label for="html" class="styled">Skills:</label>
	<div class="thefield">
		<ul style="margin-top:0;">
		<li><input type="checkbox" id="html" name="skills" value="" /> <label for="html">HTML/ CSS</label></li>
		<li><input type="checkbox" id="javascript" name="skills" value=""/> <label for="javascript">JavaScript</label></li>
		<li><input type="checkbox" id="ajax" name="skills" value="" /> <label for="ajax">Ajax and XML</label></li>
		<li><input type="checkbox" id="php" name="skills" value="" /> <label for="php">PHP and Database</label></li>
		</ul>
		<span style="font-size: 80%">* Please check all that apply.</span>
	</div>
</div>

<div class="fieldwrapper">
	<label for="agegroup" class="styled">Department:</label>
	<div class="thefield">
		<select id="agegroup">
		<option value="2.1">HR department</option>
		<option value="3">Sales</option>
		<option value="4.1">Customer Service/ Support</option>
		<option value="5.2">Accounting</option>
		</select>
	</div>
</div>

<div class="fieldwrapper">
	<label for="about" class="styled">About yourself:</label>
	<div class="thefield">
		<textarea id="about"></textarea>
</div>
</div>

<div class="buttonsdiv">
	<input type="submit" value="Submit" style="margin-left: 150px;" /> <input type="reset" value="Reset" />
</div>

</form>
*)
end.
