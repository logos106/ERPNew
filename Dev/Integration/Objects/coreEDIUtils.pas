unit coreEDIUtils;

interface

uses
  JsonObject, classes, ShellAPI, Windows, Dialogs,  SysUtils,sgcBase_Classes,  sgcTCP_Classes, sgcWebSocket_Classes, sgcWebSocket_Classes_Indy,
  IdIOHandler, IdIOHandlerSocket, IdHeaderList, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,  IdTCPClient, IdHTTP,
  sgcWebSocket_Client, sgcWebSocket, kbmMemTable, IdBaseComponent, IdComponent, IdIPMCastBase, IdIPMCastClient;

function BuildJSON(ACommand: string; AConnectionId: Integer = 0; AJobId: Integer = 0; ASummaryId: Integer = 0; AJSONFields: TJSONArray = Nil; AFromSystem: string = ''; AToSystem: string = ''): string;
function GetDefaultBrowser : string;
function AuthenticateCoreEDI(AWsClient: TsgcWebSocketClient; ADisplayError: Boolean = True): Boolean;
function  CheckYodleeEnabled(AWSClient: TsgcWebSocketClient): Boolean;

implementation

uses AppEnvironment, CommonLib;

function  AuthenticateCoreEDI(AWsClient: TsgcWebSocketClient; ADisplayError: Boolean = True): Boolean;
var
  jsonToSend : TJSonObject;
  jsonResp   : TJSonObject;
  ErrorStr   : string;
begin
  Result          := False;

  if ADisplayError = False then AWsClient.Tag := 1 else AWsClient.Tag := 0;
  AWsClient.Active := False;
  AWsClient.Host   := AppEnv.CompanyPrefs.CoreEDIServiceHost;
  AWsClient.Port   := AppEnv.CompanyPrefs.CoreEDIServicePort;
  jsonToSend      := JO;
  try
    try
      With jsonToSend do begin
         S['UserEmail']    := AppEnv.CompanyPrefs.CoreEDIServiceUserName;
         S['UserPassword'] := AppEnv.CompanyPrefs.CoreEDIServicePassword;
         S['Command']      := 'AUTHENTICATE';
      end;

      AWsClient.Active := True;
      sleep(1000);
      if not AwsClient.Active then exit;
      ErrorStr := AWsClient.WriteAndWaitData(JsonToSend.AsString);
      if ErrorStr = '' then exit; //mostly an exception which is trapped by the assign exceptionhandler
      jsonResp := JO(ErrorStr);
      if jsonResp.B['Error'] then begin
        if ADisplayError then
          MessageDlgXP_vista(jsonResp.S['ErrorMessage'] +  #13#10 +
           'Please check your user name, password, host and port.', mtInformation, [mbOK], 0);
      end else begin
        if ADisplayError then
          MessageDlgXP_vista(jsonResp.S['ErrorMessage'], mtInformation, [mbOK], 0);
        Result := True;
      end;
      except on E:Exception do begin
        MessageDlgXP_vista('Error when connecting to CoreEDI Server. ' + E.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    jsonToSend.Free;
  end;
end;

function GetDefaultBrowser : string;
var
   Path      : array[0..MAX_PATH] of char;
   tempFolder: array[0..MAX_PATH] of Char;
begin
  GetTempPath(MAX_PATH, @tempFolder);
  CloseHandle(CreateFile(PChar(tempFolder + 'default.html'), GENERIC_WRITE, FILE_SHARE_WRITE, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0));
  FindExecutable(PChar(tempFolder + 'default.html'), nil, Path); //Find the executable (default browser) associated with the html file.
  DeleteFile(PChar(tempFolder + 'default.html'));
  Result := Path;
end;

function BuildJSON(ACommand: string; AConnectionId: Integer = 0; AJobId: Integer = 0; ASummaryId: Integer = 0; AJSONFields: TJSONArray = Nil; AFromSystem: string = ''; AToSystem: string = ''): string;
var
  jsonToSend: TJSonObject;
begin
  jsonToSend      := JO;
  try
    With jsonToSend do begin
       S['UserEmail']    := AppEnv.CompanyPrefs.CoreEDIServiceUserName;
       S['UserPassword'] := AppEnv.CompanyPrefs.CoreEDIServicePassword;
       S['Command']      := ACommand;
       I['ConnectionId'] := AConnectionId;
       S['FromSystem']   := AFromSystem;
       S['ToSystem']     := AToSystem;
       I['JobId']        := AJobId;
       I['SummaryId']    := ASummaryId;
       if AJSONFields <> Nil then
         A['Fields']       := AJSONFields;
    end;
    Result := JsonToSend.AsString;
  finally
    jsonToSend.Free;
  end;
end;

(*
  wsClient.Host       := AppEnv.CompanyPrefs.CoreEDIServiceHost;
  wsClient.Port       := AppEnv.CompanyPrefs.CoreEDIServicePort;
  if ((AppEnv.CompanyPrefs.CoreEDIServiceUserName <> '') and (AppEnv.CompanyPrefs.CoreEDIServicePassword <> '')) then begin
    wsClient.Active     := True;
    sleep(1000);
    FConnected          := True;
    Panel2.Height       := 52;
  end else begin
    lblListHint.Caption := 'Connection to CoreEDI is not possible since your username/password is empty. Please contact CoreEDI.';
    FConnected          := False;
    Panel2.Height       := 20;
  end;


*)

function  CheckYodleeEnabled(AWSClient: TsgcWebSocketClient)  : Boolean;
var
  sJSON             : string;
  sResult           : string;
  JObject           : TJSONObject;
  //wsClient          : TsgcWebSocketClient;
begin
  Result          := False;
  JObject         := Nil;
  //wsClient        := TsgcWebSocketClient.Create(Nil);
  try
    if not AuthenticateCoreEDI(AWSClient, False) then exit;
    if not AWSClient.Active then exit;
    sJSON   := BuildJSON('CHECKYODLEEENABLED');
    sResult := AWSClient.WriteAndWaitData(sJSON);
    JObject := JO(sResult);
    Result  := not JObject.B['Error'];
  finally
    //wsClient.Active := False;
    //wsClient.Free;
    if JOBject <> Nil then JObject.Free;
  end;
end;

end.
