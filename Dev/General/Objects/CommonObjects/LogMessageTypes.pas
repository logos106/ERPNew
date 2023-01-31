unit LogMessageTypes;

interface
type

  TLogMessageType = (ltNone, ltError, ltWarning, ltInfo, ltDetail, ltBlank, ltDebug);
  TLogMessageTypes = set of TLogMessageType;

  TLoggingLevel = (llError, llWarning, llInfo, llDetail, llDebug);

  function LogMessageTypeToStr(const LogMessageType: TLogMessageType): string;
  function StrToLogMessageType(const s: string): TLogMessageType;
  function LogMessageTypesToStr(Const LogMessageTypes: TLogMessageTypes): string;
  function StrToLogMessageTypes(Const s: string): TLogMessageTypes;

  function LoggingLevelToStr(aLoggingLevel: TLoggingLevel): string;
  function StrToLoggingLevel(s: string): TLoggingLevel;

const
  ErrorMessageTypes = [ltError, ltWarning];
  InfoMessageTypes = [ltError, ltWarning, ltInfo];
  DetailMessageTypes = [ltNone, ltError, ltWarning, ltInfo, ltDetail, ltBlank, ltDebug];

implementation

uses
  sysutils, classes, LogThreadLib;

function LoggingLevelToStr(aLoggingLevel: TLoggingLevel): string;
begin
  case aLoggingLevel of
    llError   : result:= 'llError';
    llWarning : result:= 'llWarning';
    llInfo    : result:= 'llInfo';
    llDetail  : result:= 'llDetail';
    llDebug   : result:= 'llDebug';
    else raise Exception.Create('LoggingLevelToStr - Invalid LoggingLevel value');
  end;
end;


function StrToLoggingLevel(s: string): TLoggingLevel;
begin
  if s = 'llError' then result:= llError
  else if s = 'llWarning' then result:= llWarning
  else if s = 'llInfo' then result:= llInfo
  else if s = 'llDetail' then result:= llDetail
  else result:= llDetail;
//  else raise Exception.Create('StrToLoggingLevel - Invalid LoggingLevel string value: "' + s + '"');
end;

function LogMessageTypeToStr(const LogMessageType: TLogMessageType): string;
begin
  case LogMessageType of
    ltNone: result:= 'None';
    ltError: result:= 'Error';
    ltWarning: result:= 'Warning';
    ltInfo: result:= 'Info';
    ltDetail: result:= 'Detail';
    ltBlank: Result := '';
    ltDebug: Result := 'Debug';
    else result:= '';
  end;
end;

function StrToLogMessageType(const s: string): TLogMessageType;
begin
  if s = 'Error' then result:= ltError
  else if s = 'Warning' then result:= ltWarning
  else if s = 'Info' then result:= ltInfo
  else if s = 'Detail' then result:= ltDetail
  else if s = 'None' then result:= ltNone
  else if s = 'Debug' then result:= ltDebug
  else if s = '' then result:= ltBlank
  else
    raise Exception.Create('StrToLogMessageType - Invalid message type string: "' + s + '"');
end;

function LogMessageTypesToStr(Const LogMessageTypes: TLogMessageTypes): string;
var
  mt: TLogMessageType;
begin
  result:= '';
  for mt:= Low(TLogMessageType) to High(TLogMessageType) do begin
    if mt in LogMessageTypes then begin
      if result <> '' then result:= result + ',';
      result:= result + LogMessageTypeToStr(mt);
    end;
  end;
end;

function StrToLogMessageTypes(Const s: string): TLogMessageTypes;
var
  sl: TStringList;
  x: integer;
begin
  result:= [];
  sl:= TStringList.Create;
  try
    sl.CommaText:= s;
    for x:= 0 to sl.count-1 do begin
      Include(result, StrToLogMessageType(sl[x]));
    end;
  finally
    sl.Free;
  end;
end;



end.
