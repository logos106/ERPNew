// Constants for our ws stuff
unit wsConsts;

interface
uses
  Windows,
  SysUtils,
  Classes,
  sgcWebSocket_Classes;

type
  // debugging
  TMessageProc = procedure(const aMessage : string) of object;
  TErrorSeverity = (esError, esException);
  TErrorProc = procedure(AConnection : TsgcWSConnection; const aText : string; ASeverity : TErrorSeverity) of object;
  TSignInEvent = function(const AUser : string; const APassword : string) : boolean of object;
  TMethodAuthorisationUser = function(const AUser : string; const AMethod : string) : integer of object;
  TMethodAuthorisation = function(aConnection: TsgcWSConnection; const aMethodName : string) : integer of object;

  TwsConnectionStatus = (csNone, csConnected, csWaitingForTunnel, csTunnel);
  TwsConnectionStatusesArray = array [TwsConnectionStatus] of string;

  TwsCommand = (cmdNone,
     // Register in 2 flavours
     // /i<name> - local registers its readable name
     // /t<GUID> - response to the Open command from remote with GUID of the connection local is created for
     cmdRegister,  // Local is ready to accept connections
     // Authorisation
     // /u<user> /p<Password>  -- request
     // /u<R> /p<R> where R=1 if ok, 0 if not
     cmdSignIn,
     // Open /i<Name> - when sent from remote, request for tunnel to the local with name <Name>
     cmdOpen,      // remote asks for connection to local
     cmdClose,      // remote finished
     cmdStatus,    // Server: request for status, Client - returned status
     cmdError,
     cmdLast       // to be used in loops - not a command
     );

  TwsCommandsArray = array [TwsCommand] of String;

const
  cswsCommands : TwsCommandsArray = ('$None', '$Register', '$Sign', '$Open', '$Close', '$Status', '$Error', '');
  csStatuses : TwsConnectionStatusesArray = ('0: None', '1: Connected', '2: Waiting For Tunnel', '3: Tunnel');

  csRemoteClient = 'ERPRemote';
  csLocalClient = 'ERPLocal';

  // Standard methods
  CS_METHOD = 'method';
  CS_RESULT = 'result';
  CS_DATASET = 'dataset';
  CS_ERP_DATASET = 'ERP@DATASET';
  CS_PropertyList = 'PropertyList';
  CS_LIMITCOUNT = 'LimitCount';
  CS_LIMITFROM = 'LimitFrom';
  CS_SELECT = 'select';

// RPC
  // Standard codes from RPC specification
  csParseError = -32700;
  csInvalidRequest = -32600;
  csMethodNotFound = -32601;
  csInvalidParams = -32602;
  csInternalError = -32603;
  // -32000 to -32099 - implementation defined server errors
  // 32000, 32001 - are used

  csAuthorised = 0;
  csNoUser     = -32003;
  csNoMethod   = -32601;
  csNotAuthorised = -32001;
  CS_NO_USER_LOGGED = csNoUser;
  S_NO_USER_LOGGED = 'User has not been logged in';
  CS_METHOD_NOT_FOUND = csNoMethod;
  S_METHOD_NOT_FOUND = 'Method Not Found';
  CS_NOT_AUTHORISED = csNotAuthorised;
  S_NOT_AUTHORISED = 'User Not Authorised To Run This Method';
  S_INTERNAL_ERROR = 'Internal Error While Authorising Method';

  // GET
  S_Resource = 'resource';
  csResourceNotFound = -32002;
  csDatabaseProblem = -32003;
  S_RESOURCE_NOT_FOUND = 'Resource Not Defined In The Call';
  S_Database='ERPDatabase';
  S_USER = 'ERPUser';
  S_PASSWORD = 'ERPPassword';
  csResourceGetProblem = -32004;
  csBadKeyFields = -32005;

  // Post
  csBadData = -32006;



function ExtractCommand(const aCmd : string) : TwsCommand;
function ExtractParam(const aParam : string; const aCommand : string) : string;
function GetComputerName: string;

implementation

function ExtractCommand(const aCmd : string) : TwsCommand;
var
  idx : TwsCommand;
  lPos : integer;
  lStr : string;
begin
  Result := cmdNone;
  if aCmd = '' then
    exit;
  if (aCmd[1] <> '$') then
    exit;


  lPos := Pos(' ', aCmd);
  if lPos > 0 then
    lStr := Copy(aCmd, 1, lPos - 1)
  else
    lStr := aCmd;
  for idx := cmdNone to Pred(cmdLast) do
    if SameText(lStr, cswsCommands[idx]) then
    begin
    Result := idx;
    exit;
    end;

end;

function ExtractParam(const aParam : string; const aCommand : string) : string;
var
 lPos : integer;
 sep : char;
begin
  Result := '';
  if (aParam = '') then
    Exit;
  if aCommand = '' then
    Exit;

  lPos := pos(UpperCase(aParam), aCommand);
  if lPos = 0 then
  begin
    lPos := pos(LowerCase(aParam), aCommand);
    if lPos = 0 then
      exit;
  end;

  lPos := lPos + Length(aParam);
  if lPos >=Length(aCommand) then
    exit;

  while (lPos < length(aCommand)) and (aCommand[lPos] = ' ') do
    lPos := lPos + 1;

  if lPos >=Length(aCommand) then
    exit;

  if aCommand[lPos] = '"' then
  begin
    sep := '"';
    lPos := lPos + 1;
  end
  else if aCommand[lPos] = '''' then
  begin
    sep := '''';
    lPos := lPos + 1;
  end
  else
    sep := ' ';

  while (lPos <= length(aCommand)) and (aCommand[lPos] <> sep) do
  begin
    Result := Result + aCommand[lPos];
    inc(lPos);
  end;
end;

function GetComputerName: string;
var
  buffer: array[0..MAX_COMPUTERNAME_LENGTH + 1] of Char;
  Size: Cardinal;
begin
  Size := MAX_COMPUTERNAME_LENGTH + 1;
  Windows.GetComputerName(@buffer, Size);
  Result := StrPas(buffer);
end;

end.
