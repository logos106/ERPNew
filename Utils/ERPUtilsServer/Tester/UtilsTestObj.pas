unit UtilsTestObj;

interface

uses
  IdHttp, IdSSLOpenSSL, JsonRpcTcpClient, Classes, JsonObject, Contnrs, TesterObj;

type
  TUtilsServerTest = class(TTestStep)
  private
    function ConnectToUtilsServer(Client: TJsonRpcTcpClient; context: TJsonObject): boolean;
  public
    constructor Create;
    procedure DoTest(context: TJsonObject); override;
  end;

  TWebAPIModuleInternalTest = class(TTestStep)
  public
    constructor Create;
    procedure DoTest(context: TJsonObject); override;
  end;

  TWebAPIConfigTest = class(TTestStep)
  private
    function ConnectToUtilsModule(Client: TJsonRpcTcpClient; ModuleName: string; context: TJsonObject): boolean;
  public
    constructor Create;
    procedure DoTest(context: TJsonObject); override;
  end;

  TMySQLTest = class(TTestStep)
  public
    constructor Create;
    procedure DoTest(context: TJsonObject); override;
  end;


implementation

uses
  SysUtils, JsonRpcConst, MyAccess, MySQLUtils, DbConst,
  StrUtils, SimpleEncrypt, HTTPConst;

const
  KEY = 'z';

function PadRight(str: string; count: integer): string;
begin
  result := str;
  while Length(result) < count do
    result:= result + ' ';
end;

{ TUtilsServerTest }

function TUtilsServerTest.ConnectToUtilsServer(Client: TJsonRpcTcpClient;
  context: TJsonObject): boolean;
var
  json: TJsonObject;
begin
  result:= true;
  if context.S['ERPServer'] = '' then begin
    result:= false;
    AddDetail('Could not run test, the IP Address/ Computer Name of your ERP Server was blank.');
    exit;
  end;


  Client.ServerName:= context.S['ERPServer'];
  Client.Port:= DEFAULT_TCP_PORT;   { use default }
  try
    Client.Connected:= true;
    json:= Client.SendRequestRetry('startconfigsession',nil);
    if Assigned(Json) then begin
      try
        if json.StringExists('result') and (json.S['result'] = 'ok') then begin
          { all good }
        end
        else begin
          //MessageDlg('No responce received from ERP Server while trying to connect.', mtInformation, [mbOk],0);
          Client.Connected:= false;
          result:= false;
          AddDetail('Could not connect to your ERP Server: ' + context.S['ERPServer']);
          AddDetail('The server returned and invalid responce.');
        end;
      finally
        json.Free;
      end;
    end
    else begin
      result:= false;
      AddDetail('Could not connect to your ERP Server: ' + context.S['ERPServer']);
      AddDetail('The server did not respond to a connection request.');
    end;
  except
    on e: exception do begin
      result:= false;
      AddDetail('Could not connect to your ERP Server: ' + context.S['ERPServer']);
      AddDetail('The error returned was: ' + e.Message);
    end
  end;
  if not result then begin
    AddDetail('');
    AddDetail('Please check the followning:');
    AddDetail('1) Make sure the ERP Utilities Service is installed and running on your ERP Server machine (' + context.S['ERPServer'] + ')',4 );
    AddDetail('2) Server Name/IP (' + context.S['ERPServer'] + ') is the correct one for your ERP Server machine',4);
    AddDetail('3) The windows port (' + IntToStr(Client.Port) + ') is not blocked by a Firewall on your computer or your ERP Server machine.',4);
  end;
end;

constructor TUtilsServerTest.Create;
begin
  inherited;
  fCaption := 'Check the ERP Utilities Server';
end;

procedure TUtilsServerTest.DoTest(context: TJsonObject);
var
  Client: TJsonRpcTcpClient;
  o, resp: TJsonObject;
  x: integer;
begin
  inherited;
  fStatus := tssPass;

  Client := TJsonRpcTcpClient.Create;
  try
    Client.RequestWaitSecs:= 30;
    if not ConnectToUtilsServer(Client, context) then begin
      fStatus := tssFail;
      exit;
    end;

    resp:= Client.SendRequestRetry('GetModules',nil);
    try
      if Assigned(resp) then begin
        if resp.Exists('result') then begin
          AddDetail('The following modules are installed on your server:');
          for x := 0 to resp.O['result'].O['ModuleList'].A['Items'].Count -1 do begin
            o := resp.O['result'].O['ModuleList'].A['Items'].Items[x].AsObject;
            AddDetail(PadRight(o.O['Module'].S['ModuleName'],18) + PadRight('  Ver ' + o.O['Module'].S['ModuleVersion'],15)  + '  ' + o.O['Module'].S['ModuleDescription'],4);
            if Context.S['ModuleList'] <> '' then Context.S['ModuleList'] := Context.S['ModuleList'] + ',';
            Context.S['ModuleList']:= Context.S['ModuleList'] + o.O['Module'].S['ModuleName'];
          end;
        end;
      end
      else begin
        fStatus := tssFail;
        AddDetail('Error getting configuration information from ERP Server.');
        AddDetail('The server did not returned a result.');
      end;
    finally
      resp.Free;
    end;
  finally
    Client.Free;
  end;
end;

{ TWebAPIModuleInternalTest }

constructor TWebAPIModuleInternalTest.Create;
begin
  inherited;
  fCaption := 'Check Internal Communications with ERP through the WebAPI Module';
end;

procedure TWebAPIModuleInternalTest.DoTest(context: TJsonObject);
var
  Client: TIdHttp;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  URL: string;
  data, error: string;
  retryCount: integer;
  Port: integer;
  Database, Password: string;
  x: integer;
  json: TJsonObject;
  seconds: double;
  dt: TDateTime;
  SkipError: boolean;
const
  max_retry = 3;

begin
  inherited;
  fStatus := tssFail;
  AddDetail('This is testing if we can communicate to the WebAPI Module on your ERP Server (' + context.S['ERPServer'] + ')' );
  AddDetail('This Module allows other programs and Web Sites to communicate with ERP,');
  AddDetail('it is also required by the Site Intergration Module to connect multiple ERP Sites.');
  AddDetail('');

  if context.S['ERPServer'] = '' then begin
    fStatus := tssFail;
    AddDetail('Could not run test, the IP Address/ Computer Name of your ERP Server was blank.');
    exit;
  end;

  if Pos('webservice', Lowercase(Context.S['ModuleList'])) = 0 then begin
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
    AddDetail('You do not have any Databases (company files) containging the user "' + Context.O['WebAPIConfig'].S['WebUserName'] + '".');
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

  AddDetail('Running the test using the following settings:');
  AddDetail(PadRight('Server: ',20) + context.S['ERPServer'],4);
  AddDetail(PadRight('Port: ',20) + IntToStr(Port),4);
  AddDetail(PadRight('UseSSL: ',20) + BoolToStr(Context.O['WebAPIConfig'].B['UseSSL'],true),4);
  AddDetail(PadRight('Database: ',20) + database,4);
  AddDetail(PadRight('User: ',20) + Context.O['WebAPIConfig'].S['WebUserName'],4);
  AddDetail(PadRight('Password: ',20) + Password,4);

  if Context.O['WebAPIConfig'].B['UseSSL'] then
    URL := 'https://' + context.S['ERPServer'] + ':' + IntToStr(Port) + '/erpapi/TERPSysInfo'
  else
    URL := 'http://' + context.S['ERPServer'] + ':' + IntToStr(Port) + '/erpapi/TERPSysInfo';


  Client := TIdHttp.Create(nil);
  try
    Client.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    if Context.O['WebAPIConfig'].B['UseSSL'] then begin
      SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(client);
      Client.IOHandler:= SSLHandler;
      Client.Request.BasicAuthentication:= true;
      Client.Request.Username:= Context.O['WebAPIConfig'].S['WebUserName'];
      Client.Request.Password:= Password;
    end
    else begin
      Client.Request.CustomHeaders.AddValue('username', Context.O['WebAPIConfig'].S['WebUserName']);
      Client.Request.CustomHeaders.AddValue('password', Password);
    end;

    Client.ReadTimeout:= 1000 * 60*2;
    Client.Request.CustomHeaders.AddValue('database', database);

    retryCount := 1;
    while retryCount <= max_retry do begin
      SkipError:= false;
      error:= '';
      try
        dt:= now;
        AddDetail(URL);
        data := Client.Get(URL);
        if Client.ResponseCode = 200 then begin
          seconds:= (now - dt) * (1/24/60/60);
          seconds := Round(seconds * 1000) / 1000;
          fStatus := tssPass;
          AddDetail('');
          AddDetail('The WebAPI module can be accessed from the internet ok and is working correctly.');
          AddDetail('Response time was: ' + FloatToStr(seconds) + ' seconds.');
          exit;
        end;
      except
        on e: exception do begin
          AddDetail('error :' + e.message);
          if (retryCount = 1) and (Pos('Software caused connection abort', e.MEssage) > 0) then begin
            { ignore this .. always get it for first connect }
            SkipError:= true;
          end
          else
            error:= e.Message;
        end;
      end;
      if Client.Response.RawHeaders.Values['errormessage'] <> '' then begin
        { this means we have communicated to the server ok but server is returning an error }
        error := Client.Response.RawHeaders.Values['errormessage'];
        AddDetail('');
        AddDetail('Was able to communicate with WebAPI ok but the module returned the error: ');
        AddDetail(URL);
        AddDetail(error, 2);
        if Pos('Server and database versions',error) > 0 then
          AddDetail('For database version errors, try restarting your ERP Server.');

        exit;
      end;

      if not SkipError then begin
        if error <> '' then begin
          AddDetail('Error:');
          AddDetail(error, 2);
        end
        else
          AddDetail('Error running test.');
        AddDetail('');
        AddDetail('Trying again ...');
      end;

      Inc(retryCount);
    end;
  finally
    Client.Free;
  end;

  AddDetail('');
  AddDetail('Failed to connect to, or communicate with, your WebAPI module please check the following:');
  AddDetail('1) The WebAPI Port (' + IntToStr(Port) + ') is not blocked by your server firewall.',2);
  AddDetail('2) If your ERP server is not on your local network (eg in another office)',2);
  AddDetail('   and the networks are connected via Routers,',2);
  AddDetail('   make sure this port (' + IntToStr(Port) + ') is "port forwarded" in the router to your server machine.',2);
  AddDetail('   Please contact your web administrator or ISP as ERP cannot do this.',2);
  AddDetail('');
  AddDetail('Suggested web sites for more information re ports and forwarding:');
  AddDetail('http://www.yougetsignal.com/tools/open-ports');
  AddDetail('http://www.t1shopper.com/tools/port-scan');
  AddDetail('http://en.wikipedia.org/wiki/Port_forwarding');
end;


{ TWebAPIConfigTest }

function TWebAPIConfigTest.ConnectToUtilsModule(Client: TJsonRpcTcpClient;
  ModuleName: string; context: TJsonObject): boolean;
var
  o, resp: TJsonObject;
begin
  result:= true;
  if context.S['ERPServer'] = '' then begin
    result:= false;
    AddDetail('Could not run test, the IP Address/ Computer Name of your ERP Server was blank.');
    exit;
  end;
  Client.ServerName:= context.S['ERPServer'];
  Client.Port:= DEFAULT_TCP_PORT;   { use default }
  try
    Client.Connected:= true;
  except
    on e: exception do begin
      result:= false;
      AddDetail('Could not connect to your ERP Server: ' + context.S['ERPServer']);
      AddDetail('The error returned was:');
      AddDetail(e.Message,4);
      exit;
    end;
  end;


  o:= JO;
  o.S['sessiontype']:= 'config';

  resp:= Client.SendRequest(ModuleName + '.StartSession',o);
  if Assigned(resp) then begin
    try
      if resp.StringExists('result') and (resp.S['result'] = 'ok') then begin
        { All Good! }

      end
      else begin
        { failed to establisg a session }
        result:= false;
        Client.Connected:= false;
        AddDetail('Could not connect to your ERP Server Moule: ' + ModuleName);
        AddDetail('The Module returned and invalid responce to the Start Session request.');
      end;
    finally
      resp.Free;
    end;
  end
  else begin
    result:= false;
    AddDetail('Could not connect to your ERP Server Module: ' + ModuleName);
    AddDetail('The Module did not respond to a Start Session request.');
  end;
end;

constructor TWebAPIConfigTest.Create;
begin
  inherited;
  fCaption := 'Check Web API Module Configuration';
end;

procedure TWebAPIConfigTest.DoTest(context: TJsonObject);
var
  Client: TJsonRpcTcpClient;
  o, resp: TJsonObject;
begin
  inherited;
  fStatus := tssPass;
  AddDetail('This module is used for communication between ERP and things like Web Shopping Cart applications.');
  AddDetail('It is also used for communication between different ERP servers (Site Integration).');
  AddDetail('');

  if Pos('webservice', Lowercase(Context.S['ModuleList'])) = 0 then begin
    fStatus := tssFail;
    AddDetail('The Web API Module is not installed or can not be accessed on your server (' + context.S['ERPServer'] + ').');
    Exit;
  end;

  Client := TJsonRpcTcpClient.Create;
  try

    if Pos('webservice',Lowercase(Context.S['ModuleList'])) > 0 then begin
      { new web api module }

      Client.RequestWaitSecs := 30;
      if context.S['ERPServer'] = '' then begin
        AddDetail('Could not run test, the IP Address/ Computer Name of your ERP Server was blank.');
        exit;
      end;
      Client.ServerName := context.S['ERPServer'];
      Client.Port := DEFAULT_TCP_PORT;   { use default }
      try
        Client.Connected:= true;
      except
        on e: exception do begin
          AddDetail('Could not connect to your ERP Server: ' + context.S['ERPServer']);
          AddDetail('The error returned was:');
          AddDetail(e.Message,4);
          exit;
        end;
      end;

      resp:= Client.SendRequest('ERPWebService.GetConfig',nil);
      if Assigned(resp) then begin
        try
          if resp.ObjectExists('result') then begin

            AddDetail('The current WebAPI Module configuration settings are as follows:');
            if SameText(resp.O['result'].S['LoggingLevel'],'llEror') then
              AddDetail(PadRight('Logging Level:',18) + 'Error         - Only errors will be recorded in the module log file.',2)
            else if SameText(resp.O['result'].S['LoggingLevel'],'llWarning') then
              AddDetail(PadRight('Logging Level:',18) + 'Warning       - Only errors and warnings will be recorded in the module log file.',2)
            else if SameText(resp.O['result'].S['LoggingLevel'],'llInfo') then
              AddDetail(PadRight('Logging Level:',18) + 'Info          - Errors, warnings and information messages will be recorded in the module log file.',2)
            else if SameText(resp.O['result'].S['LoggingLevel'],'llDetail') then
              AddDetail(PadRight('Logging Level:',18) + 'Detail        - Detail information messages will be recorded in the module log file.',2)
            else
              AddDetail(PadRight('Logging Level:',18) + Copy(resp.O['result'].S['LoggingLevel'],3,255),2);
            if resp.O['result'].S['WebUserName'] = '' then
              AddDetail(PadRight('Web User Name:',18) + '(not set)     - Warning: This must be set to match the ERP User account to use when connecting to ERP via the WebAPI.',2)
            else
              AddDetail(PadRight('Web User Name:',18) +  PadRight(resp.O['result'].S['WebUserName'],12) + '  - The ERP User Name to be used when processing WebAPI requests',2);
            if resp.O['result'].I['MaxConnections'] = 0 then
              AddDetail(PadRight('Max Connections:',18) +  '0             - No limit on the number of simultaneous connections to the WebAPI module.',2)
            else
              AddDetail(PadRight('Max Connections:',18) +  IntToStr(resp.O['result'].I['MaxConnections']) + '  - Number of Simultaneous connections to the WebAPI module will be limited to ' + IntToStr(resp.O['result'].I['MaxConnections']) + '.',2);
            if resp.O['result'].B['UseSSL'] then begin
              if resp.O['result'].I['DefaultSSLPort'] = 0 then
                AddDetail(PadRight('Server SSL Port:',18) +  '0             - Warning: This port is not set, the module will not be able receive WebAPI requests.',2)
              else
                AddDetail(PadRight('Server SSL Port:',18) + PadRight(IntToStr(resp.O['result'].I['DefaultSSLPort']),12) + '  - The port used for secure (SSL) WebAPI requests, "Use SSL" enabled.',2);
              AddDetail(PadRight('Server Port:',18) + PadRight(IntToStr(resp.O['result'].I['DefaultPort']),12) + '  - The port used for WebAPI requests.',2);
              AddDetail(PadRight('Use SSL:',18) + 'True        ' + '  - Secure connections will be used for processing WebAPI requests.',2)
            end
            else begin
              AddDetail(PadRight('Server SSL Port:',18) + PadRight(IntToStr(resp.O['result'].I['DefaultSSLPort']),12) + '  - The port used for secure (SSL) WebAPI requests, when "Use SSL" enabled.',2);
              if resp.O['result'].I['DefaultPort'] = 0 then
                AddDetail(PadRight('Server Port:',18) +  '0             - Warning: This port is not set, the module will not be able receive WebAPI requests.',2)
               else
                AddDetail(PadRight('Server Port:',18) + PadRight(IntToStr(resp.O['result'].I['DefaultPort']),12) + '  - The port used for secure WebAPI requests.',2);
              AddDetail(PadRight('Use SSL:',18) + 'False       ' + '  - Secure connections will not be used for processing WebAPI requests.',2)
            end;
            if resp.O['result'].B['Active'] then
              AddDetail(PadRight('Active:',18) + 'True        ' + '  - The WebAPI module is able to accept requests.',2)
            else
              AddDetail(PadRight('Active:',18) + 'False       ' + '  - Warning: The WebAPI module is not able to accept requests.',2);

            context.O['WebAPIConfig'].Assign(resp.O['result']);




          end
          else begin
            fStatus := tssFail;
            AddDetail('Error getting configuration information from WebAPI Module.');
            AddDetail('The response returned from the server does not contain a result object.');
          end;
        finally
          resp.Free;
        end;
      end
      else begin
        fStatus := tssFail;
        AddDetail('Error getting configuration information from WebAPI Module.');
        AddDetail('The server did not returned a result.');
      end;
    end
    else begin
      Client.RequestWaitSecs:= 30;
      if not ConnectToUtilsModule(Client, 'WebAPI', Context) then begin
        fStatus := tssFail;
        exit;
      end;

      o:= JO('{"classname":"THTTPServerConfig"}');
      resp:= Client.SendRequest('getobject',O);
      try
        if Assigned(resp) then begin
          if resp.Exists('result') then begin

            AddDetail('The current WebAPI Module configuration settings are as follows:');
            if SameText(resp.O['result'].O['object'].S['LoggingLevel'],'llEror') then
              AddDetail(PadRight('Logging Level:',18) + 'Error         - Only errors will be recorded in the module log file.',2)
            else if SameText(resp.O['result'].O['object'].S['LoggingLevel'],'llWarning') then
              AddDetail(PadRight('Logging Level:',18) + 'Warning       - Only errors and warnings will be recorded in the module log file.',2)
            else if SameText(resp.O['result'].O['object'].S['LoggingLevel'],'llInfo') then
              AddDetail(PadRight('Logging Level:',18) + 'Info          - Errors, warnings and information messages will be recorded in the module log file.',2)
            else if SameText(resp.O['result'].O['object'].S['LoggingLevel'],'llDetail') then
              AddDetail(PadRight('Logging Level:',18) + 'Detail        - Detail information messages will be recorded in the module log file.',2)
            else
              AddDetail(PadRight('Logging Level:',18) + Copy(resp.O['result'].O['object'].S['LoggingLevel'],3,255),2);
            if resp.O['result'].O['object'].S['WebUserName'] = '' then
              AddDetail(PadRight('Web User Name:',18) + '(not set)     - Warning: This must be set to match the ERP User account to use when connecting to ERP via the WebAPI.',2)
            else
              AddDetail(PadRight('Web User Name:',18) +  PadRight(resp.O['result'].O['object'].S['WebUserName'],12) + '  - The ERP User Name to be used when processing WebAPI requests',2);
            if resp.O['result'].O['object'].I['MaxConnections'] = 0 then
              AddDetail(PadRight('Max Connections:',18) +  '0             - No limit on the number of simultaneous connections to the WebAPI module.',2)
            else
              AddDetail(PadRight('Max Connections:',18) +  IntToStr(resp.O['result'].O['object'].I['MaxConnections']) + '  - Number of Simultaneous connections to the WebAPI module will be limited to ' + IntToStr(resp.O['result'].O['object'].I['MaxConnections']) + '.',2);
            if resp.O['result'].O['object'].B['UseSSL'] then begin
              if resp.O['result'].O['object'].I['DefaultSSLPort'] = 0 then
                AddDetail(PadRight('Server SSL Port:',18) +  '0             - Warning: This port is not set, the module will not be able receive WebAPI requests.',2)
              else
                AddDetail(PadRight('Server SSL Port:',18) + PadRight(IntToStr(resp.O['result'].O['object'].I['DefaultSSLPort']),12) + '  - The port used for secure (SSL) WebAPI requests, "Use SSL" enabled.',2);
              AddDetail(PadRight('Server Port:',18) + PadRight(IntToStr(resp.O['result'].O['object'].I['DefaultPort']),12) + '  - The port used for WebAPI requests.',2);
              AddDetail(PadRight('Use SSL:',18) + 'True        ' + '  - Secure connections will be used for processing WebAPI requests.',2)
            end
            else begin
              AddDetail(PadRight('Server SSL Port:',18) + PadRight(IntToStr(resp.O['result'].O['object'].I['DefaultSSLPort']),12) + '  - The port used for secure (SSL) WebAPI requests, when "Use SSL" enabled.',2);
              if resp.O['result'].O['object'].I['DefaultPort'] = 0 then
                AddDetail(PadRight('Server Port:',18) +  '0             - Warning: This port is not set, the module will not be able receive WebAPI requests.',2)
              else
                AddDetail(PadRight('Server Port:',18) + PadRight(IntToStr(resp.O['result'].O['object'].I['DefaultPort']),12) + '  - The port used for secure WebAPI requests.',2);
              AddDetail(PadRight('Use SSL:',18) + 'False       ' + '  - Secure connections will not be used for processing WebAPI requests.',2)
            end;
            if resp.O['result'].O['object'].B['Active'] then
              AddDetail(PadRight('Active:',18) + 'True        ' + '  - The WebAPI module is able to accept requests.',2)
            else
              AddDetail(PadRight('Active:',18) + 'False       ' + '  - Warning: The WebAPI module is not able to accept requests.',2);

            context.O['WebAPIConfig'].Assign(resp.O['result'].O['object']);

          end;
        end
        else begin
          fStatus := tssFail;
          AddDetail('Error getting configuration information from WebAPI Module.');
          AddDetail('The server did not returned a result.');
        end;
      finally
        resp.Free;
      end;
    end;
  finally
    Client.Free;
  end;
end;

{ TMySQLTest }

constructor TMySQLTest.Create;
begin
  inherited;
  fCaption := 'Check ERP MySQL Server';
end;

procedure TMySQLTest.DoTest(context: TJsonObject);
var
  conn: TMyConnection;
  sl: TStringList;
  qry: TMyQuery;
  x: integer;
  WebUserString, versionString: string;
  maxLength: integer;
  WebUser: string;
  json: TJsonObject;
begin
  inherited;
  fStatus := tssPass;
  if context.S['ERPServer'] = '' then begin
    fStatus := tssFail;
    AddDetail('Could not run test, the IP Address/ Computer Name of your ERP Server was blank.');
    exit;
  end;

  conn := TMyConnection.Create(nil);
  qry:= TMyQuery.Create(nil);
  sl:= TStringList.Create;
  try
    SetConnectionProps(conn,DbConst.MYSQL_DATABASE,context.S['ERPServer']);
    qry.Connection:= conn;
    try
      conn.Connect;
    except
      on e: exception do begin
        fStatus := tssFail;
        AddDetail('Error connecting to MySQL on ' + context.S['ERPServer']);
        AddDetail('The Error returned:');
        AddDetail(e.Message,2);
        AddDetail('');
        AddDetail('Please check the following:');
        AddDetail('1) The Server Name/IP (' + context.S['ERPServer'] + ') is the correct one for your ERP Server machine.',2);
        AddDetail('2) The MySQL service (MySQL_ERP) is running on your ERP server.',2);
        AddDetail('3) The MySQL Port (' + IntToStr(Conn.Port)+ ') is not blocked be the windows firewall or virus scanner on your ERP Server.',2);
        AddDetail('   Please contact your IT manager as ERP cannot do this.',2);
        exit;
      end;
    end;

    { get the WeUser from the WebAPI config in context .. }
    if Context.ObjectExists('WebAPIConfig') then
      WebUser := Context.O['WebAPIConfig'].S['WebUserName']
    else
      WebUser := '';

    AddDetail('The following ERP databases where found on the server:');
    conn.GetDatabaseNames(sl);
    MaxLength:= 0;
    for x:= 0 to sl.Count -1 do begin
      if Length(sl[x]) > MaxLength then
        MaxLength := Length(sl[x]);
    end;
    MaxLength := MaxLength + 2;
    for x:= 0 to sl.Count -1 do begin
      conn.Disconnect;
      conn.Database := sl[x];
      conn.Connect;
      qry.Close;
      qry.SQL.Text:= 'show tables';
      qry.Open;
      if qry.RecordCount > 300 then begin
        qry.Close;
        qry.SQL.Text:= 'show tables like "tblupdatedetails"';
        qry.Open;
        if not qry.IsEmpty then begin
          qry.Close;
          qry.SQL.Text := 'select Version from tblUpdateDetails';
          qry.Open;
          versionString := qry.FieldByName('Version').AsString;

          WebUserString := '';
          qry.Close;
          if (WebUser <> '') and (not SameText(sl[x],'erpnewdb')) then begin
            qry.SQL.Text := 'select * from tblPassword where Logon_Name = ' + QuotedStr(WebUser);
            qry.Open;
            if not qry.IsEmpty then begin
              WebUserString := '  - User "' + WebUser + '" exists in this database.  ' ;
              json:= JO;
              json.S['database'] := sl[x];
              json.S['password'] := DeCrypt(qry.FieldByName('Logon_Password').AsString, KEY);
              Context.A['WebApiDatabases'].Add(json);
            end
            else
              WebUserString := '  - Warning: User "' + WebUser + '" does not exist in this database.  '
          end;
          AddDetail(PadRight(sl[x],MaxLength) + 'Ver ' + PadRight(versionString,10) +    WebUserString,4);
        end;
      end;
    end;
  finally
    sl.Free;
    qry.Free;
    conn.Free;
  end;
end;

end.
