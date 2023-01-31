unit TwilioApiObj;

interface

uses
  SMSConfigObj, {IdHTTP,} IdURI, URILib, JsonObject, {IdSSLOpenSSL,}
  DateTimeUtils, Classes, LogThreadBase, LogMessageTypes, HttpSSLClientObj;

type

  TTwilioList = class;
  TCallList = class;

  TTwilioApi = class(TObject)
  private
    fConfig: TSMSConfig;
    fLogger: TLoggerBase;
    fOnLog: LogThreadBase.TOnLogEvent;
  public
    procedure Log(const aMsg: string; const LogMessageType: TLogMessageType);
    constructor Create(aLogger: TLoggerBase = nil);
    destructor Destroy; override;
    property Config: TSMSConfig read fConfig write fConfig;
    function SendSMS(ToNumber, Body: string; var msg: string; json: TJsonObject): boolean;
    { GetSMSList Params:
       To=[ToNumber]&From=[FromNumber]&DateSent=yyyy-mm-dd
       DateSent<=  DateSent>= }
    function GetSMSList(Params: TStringList = nil): TTwilioList;
    { GetCallList Params:
       To=[ToNumber]
       From=[FromNumber]
       Status=[Status] ( queued, ringing, in-progress, canceled, completed, failed, busy, no-answer )
       StartTime=[yyyy-mm-dd]
       StartTime>=[yyyy-mm-dd]
       StartTime<=[yyyy-mm-dd]
       ParentCallSid=[ParentSid] }
    function GetCallList(Params: TStringList = nil): TCallList;
    { GetRecordingList Params:
       CallSid=[CallSid]
       DateCreated<=[yyyy-mm-dd]
       DateCreated>=[yyyy-mm-dd]
    }
    function GetRecordingList(Params: TStringList = nil): TTwilioList;
    procedure GetRecordingMP3(sid: string; stream: TStream);
    procedure DeleteRecording(const sid: string);
    { Twilio format: "Thu, 31 Oct 2013 05:12:15 +0000" }
    class function StrToUTC(const s: string): TDateTime;
    property OnLog: LogThreadBase.TOnLogEvent read fOnLog write fOnLog;
  end;

  TTwilioList = class(TObject)
  private
    fData: TJsonObject;
    fClient: THttpSSLClient;
    fList: TJsonObject;
    fListType: string;
    fPos, fPagePos: integer;
    fBOF: boolean;
    fEOF: boolean;
    fApi: TTwilioApi;
    function GetCount: integer;
//    function GetPageCount: integer;
  public
    constructor Create(aAPI: TTwilioApi; json: TJsonObject; aClient: THttpSSLClient; listType: string);
    destructor Destroy; override;
    property EOF: boolean read fEOF;
    property BOF: boolean read fBOF;
    procedure First; virtual;
    procedure Next; virtual;
    procedure Prior; virtual;
    property Data: TJsonObject read fData;
    property Count: integer read GetCount;
//    property PageCount: integer read GetPageCount;
    function IsEmpty: boolean;
    property Pos: integer read fPos;
  end;

  TCallList = class(TTwilioList)
  private
    fRecordings: TTwilioList;
    function GetRecordings: TTwilioList;
  public
    constructor Create(aAPI: TTwilioApi; json: TJsonObject; aClient: THttpSSLClient);
    destructor Destroy; override;
    property Recordings: TTwilioList read GetRecordings;
    procedure First; override;
    procedure Next; override;
    procedure Prior; override;
  end;

implementation

uses
  SysUtils, Types, StrUtils, HTTPConst, SystemLib, Windows;

const
  Twilio_URL = 'https://api.twilio.com/';
  Twilio_Ver = '2010-04-01';

(*
function GetHttpClient(Config: TSMSConfig): TIdHttp;
var
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  result := TIdHttp.Create(nil);
  result.Request.UserAgent := HTTPConst.TrueERPUserAgent;
  SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(result);
  result.IOHandler:= SSLHandler;
  SSLHandler.SSLOptions.SSLVersions + [TIdSSLVersion.sslvTLSv1_2];

  result.Request.BasicAuthentication:= true;
  result.Request.Username:= Config.SMSUser;
  result.Request.Password:= Config.SMSPass;
  result.Request.ContentType := 'application/x-www-form-urlencoded';
  result.ConnectTimeout := 30000;
  result.ReadTimeout := 30000;
end;
*)
function GetHttpClient(Config: TSMSConfig): THttpSSLClient;
begin
  result := THttpSSLClient.Create;
  // result.DebugMode := true;
  result.ClearSSLVersions;
  result.AddSSLVersion('1.2');
  result.BasicAuthentication(Config.SMSUser, Config.SMSPass);
  result.ConnectTimeout := 30000;
  result.ReadTimeout := 30000;
end;



{ TTwilioApi }

constructor TTwilioApi.Create(aLogger: TLoggerBase);
begin
  fLogger := aLogger;
end;

procedure TTwilioApi.DeleteRecording(const sid: string);
var
  Client: THttpSSLClient;
begin
  Client:= GetHttpClient(Config);
  try
    try
      Client.Delete(Twilio_URL + Twilio_Ver + '/Accounts/' + Config.SMSUser + '/Recordings/' + sid + '.json');
    except
      on e: exception do begin
        Log('Error deleting recorded message: ' + e.Message,ltError);
      end;
    end;
  finally
    Client.Free;
  end;
end;

destructor TTwilioApi.Destroy;
begin

  inherited;
end;

  { GetCallList Params:
     To=[ToNumber]
     From=[FromNumber]
     Status=[Status] ( queued, ringing, in-progress, canceled, completed, failed, busy, no-answer )
     StartTime=[yyyy-mm-dd]
     StartTime>=[yyyy-mm-dd]
     StartTime<=[yyyy-mm-dd]
     ParentCallSid=[ParentSid] }
function TTwilioApi.GetCallList(Params: TStringList): TCallList;
var
  Client: THttpSSLClient;
  json: TJsonObject;
  s, url: string;
  x: integer;
begin
  Client:= GetHttpClient(Config);
  try
    json := JO;
    url := Twilio_URL + Twilio_Ver + '/Accounts/' + Config.SMSUser + '/Calls.json';
    if Assigned(Params) and (Params.Count > 0) then begin
      for x := 0 to Params.Count -1 do begin
        if x = 0 then url := url + '?'
        else url := url + '&';
        url := url + Params[x];
      end;
    end;
    s:= Client.Get(url);
    json.AsString := s;
    result:= TCallList.Create(self, json, Client);
  finally
    Client.Free;
  end;
end;


  { GetRecordingList Params:
     CallSid=[CallSid]
     DateCreated<=[yyyy-mm-dd]
     DateCreated>=[yyyy-mm-dd]
  }
procedure TTwilioApi.GetRecordingMP3(sid: string; stream: TStream);
var
  Client: THttpSSLClient;
  FileStream: TFileStream;
  TempFileName: string;
begin
  TempFileName := SystemLib.GetTempFileName();
  try
    Client:= GetHttpClient(Config);
    try
      Client.GetFile(Twilio_URL + Twilio_Ver + '/Accounts/' + Config.SMSUser + '/Recordings/' + sid +'.mp3', TempFileName);
      FileStream := TFileStream.Create(TempFileName, fmOpenRead);
      try
        stream.CopyFrom(FileStream, 0);
      finally
        FileStream.Free;
      end
    finally
      Client.Free;
    end;
  finally
    SysUtils.DeleteFile(TempFileName);
  end;
end;

function TTwilioApi.GetRecordingList(Params: TStringList): TTwilioList;
var
  Client: THttpSSLClient;
  json: TJsonObject;
  s, url: string;
  x: integer;
begin
  Client:= GetHttpClient(Config);
  try
    json := JO;
    url := Twilio_URL + Twilio_Ver + '/Accounts/' + Config.SMSUser + '/Recordings.json';
    if Assigned(Params) and (Params.Count > 0) then begin
      for x := 0 to Params.Count -1 do begin
        if x = 0 then url := url + '?'
        else url := url + '&';
        url := url + Params[x];
      end;
    end;
    s:= Client.Get(url);
    json.AsString := s;
    result:= TTwilioList.Create(self, json,Client,'recordings');
  finally
//    Client.Free;
  end;
end;

function TTwilioApi.GetSMSList(Params: TStringList): TTwilioList;
var
  Client: THttpSSLClient;
  json: TJsonObject;
  s, url: string;
  x: integer;
begin
  Client:= GetHttpClient(Config);
  try
    json := JO;
    url := Twilio_URL + Twilio_Ver + '/Accounts/' + Config.SMSUser + '/SMS/Messages.json';
    if Assigned(Params) and (Params.Count > 0) then begin
      for x := 0 to Params.Count -1 do begin
        if x = 0 then url := url + '?'
        else url := url + '&';
        url := url + Params[x];
      end;
    end;
    s:= Client.Get(url);
    json.AsString := s;
    result:= TTwilioList.Create(self, json,Client,'sms_messages');
  finally
//    Client.Free;
  end;
end;

procedure TTwilioApi.Log(const aMsg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(fLogger) then
    fLogger.Log(aMsg, LogMessageType);
  if Assigned(fOnLog) then
    fOnLog(aMsg, LogMessageType);
end;

function TTwilioApi.SendSMS(ToNumber, Body: string; var msg: string; json: TJsonObject): boolean;
var
  Client: THttpSSLClient;
  stream: TStringStream;
  s: string;
  params: string;
//  obj: TJsonObject;
begin
  result := true;
  msg := '';
  Client := GetHttpClient(Config);
//  Log('GetHttpClient Version: ' + Client.DLLVersion, ltInfo);
//  stream := TStringStream.Create;
//  obj := JO;
  try
//    stream.WriteString('From=' + URILib.PercentEncode(Config.PhoneNumber));
//    stream.WriteString('&To=' + URILib.PercentEncode(ToNumber));
//    stream.WriteString('&Body=' + URILib.PercentEncode(Body));
    params := 'From=' + URILib.PercentEncode(Config.PhoneNumber) +
      '&To=' + URILib.PercentEncode(ToNumber) +
      '&Body=' + URILib.PercentEncode(Body);
//    stream.Position := 0;
//    obj.S['From'] := Config.PhoneNumber;
//    obj.S['To'] := ToNumber;
//    obj.S['Body'] := Body;
    Client.ContentType := 'application/x-www-form-urlencoded';
    try
      s := Client.Post(Twilio_URL + Twilio_Ver +'/Accounts/' + Config.SMSUser + '/Messages.json', params); //stream.DataString);
      json.AsString := s;
    except
      on e: exception do begin
        result:= false;
        //msg := e.Message;
        msg := Client.LastError;
      end;
    end;

  finally
    Client.Free;
//    stream.Free;
//    obj.Free;
  end;
end;

class function TTwilioApi.StrToUTC(const s: string): TDateTime;
begin
  { "Thu, 31 Oct 2013 05:12:15 +0000" }
  result := DateTimeUtils.RFC2822StrToDateTime(s);
end;

{ TTwilioList }

constructor TTwilioList.Create(aAPI: TTwilioApi; json: TJsonObject; aClient: THttpSSLClient; listType: string);
begin
  fApi := aAPI;
  fList := json;
  fClient := aClient;
  fListType := listType;
  fPos := -1;
  fPagePos := -1;
  fBOF := true;
  fData := nil;
  if Count = 0 then begin
    fEOF := true;
  end
  else begin
   fEOF := false;
   fPos := 0;
   fPagePos := 0;
   fData := fList.A[fListType].Items[fPagePos].AsObject;
  end;
end;

destructor TTwilioList.Destroy;
begin
  fLIst.Free;
  fClient.Free;
  inherited;
end;

procedure TTwilioList.First;
var
  s: string;
begin
  if count > 0 then begin
    s:= fClient.Get(ExcludeTrailingPathDelimiter(Twilio_URL) + fList.S['firts_page_uri']);
    fList.AsString := s;
    fPagePos := 0;
    fPos := 0;
    fBOF := True;
    fEOF := false;
    fData := fList.A[fListType].Items[fPagePos].AsObject;
  end
  else begin
    fBOF := true;
    fEOF:= true;
    fData := nil;
  end;
end;

function TTwilioList.GetCount: integer;
begin
  result := fList.I['total'];
end;

//function TTwilioList.GetPageCount: integer;
//begin
//  result := fList.I['page_size'];
//end;

function TTwilioList.IsEmpty: boolean;
begin
  result := BOF and EOF;
end;

procedure TTwilioList.Next;
var
  s: string;
begin
  if fPos < Count -1 then begin
    if fPagePos < fList.A[fListType].Count -1 then begin
      Inc(fPagePos);
      Inc(fPos);
      fBOF := false;
      fData := fList.A[fListType].Items[fPagePos].AsObject;
    end
    else begin
      { next page? }
      if fList.ItemByName['next_page_uri'].ValueType <> valNull  then begin
        s:= fClient.Get(ExcludeTrailingPathDelimiter(Twilio_URL) + fList.S['next_page_uri']);
        fList.AsString := s;
        fPagePos := 0;
        Inc(fPos);
        fBOF := false;
        fData := fList.A[fListType].Items[fPagePos].AsObject;
      end
      else begin
        { end }
        fEOF := true;
      end;
    end;
  end
  else begin
    fEOF := true;
  end;
end;

procedure TTwilioList.Prior;
var
  s: string;
begin
  if fPos > 0 then begin
    if fPagePos > 0 then begin
      Dec(fPagePos);
      Dec(fPos);
      fEOF := false;
      fData := fList.A[fListType].Items[fPagePos].AsObject;
    end
    else begin
      { previous page? }
      if fList.ItemByName['previous_page_uri'].ValueType <> valNull  then begin
        s:= fClient.Get(ExcludeTrailingPathDelimiter(Twilio_URL) + fList.S['previous_page_uri']);
        fList.AsString := s;
        fPagePos := fList.A[fListType].Count -1;
        Dec(fPos);
        fEOF := false;
        fData := fList.A[fListType].Items[fPagePos].AsObject;
      end
      else begin
        { end }
        fBOF := true;
      end;
    end;
  end
  else begin
    fBOF := true;
  end;
end;

{ TCallList }

constructor TCallList.Create(aAPI: TTwilioApi; json: TJsonObject; aClient: THttpSSLClient);
begin
  inherited Create(aAPI, json,aClient,'calls');
end;

destructor TCallList.Destroy;
begin
  inherited;
end;

procedure TCallList.First;
begin
  inherited;
  FreeAndNil(fRecordings);
end;

function TCallList.GetRecordings: TTwilioList;
var
  aClient: THttpSSLClient;
  fRecordingList: TJsonObject;
begin
  result := nil;
  if (not Assigned(fRecordings)) and (not IsEmpty) then begin
    aClient := GetHttpClient(fAPI.Config);
    fRecordingList := JO;
    try
      fRecordingList.AsString := aClient.Get(Twilio_URL + Data.O['subresource_uris'].S['recordings']);
    except
      on e: exception do begin
//        fAPI.Log('Error getting list of recording: ' + e.Message, ltError);
        fAPI.Log('Error getting list of recording: ' + aClient.LastError, ltError);
        aClient.Free;
        fRecordingList.Free;
        exit;
      end;
    end;
    fRecordings:= TTwilioList.Create(fAPI, fRecordingList,aClient,'recordings');
  end;
  result := fRecordings;
end;

procedure TCallList.Next;
begin
  inherited;
  FreeAndNil(fRecordings);
end;

procedure TCallList.Prior;
begin
  inherited;
  FreeAndNil(fRecordings);
end;

end.
