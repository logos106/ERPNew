unit JsonRpcBase;

interface

uses
  classes, JSONObject, contnrs;

type
  TDataMode = (dmRead, dmWrite);

  TJsonRpcBase = class;
  TJsonRpcRequestProc = procedure (Client: TJsonRpcBase; ReqJson: TJSONObject; ResJson: TJSONObject = nil) of object;
  TJsonRpcBaseEvent = procedure (Client: TJsonRpcBase) of object;


  TJsonRpcMethodItem = class
  public
    MethodName: string;
    RequestProc: TJsonRpcRequestProc;
  end;

  TJsonRpc = class
  private
    fConfig: TJsonObject;
    procedure SetConfig(const Value: TJsonObject);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property Config: TJsonObject read fConfig write SetConfig;
  end;

  TJsonRpcBase = class(TJsonRpc)
  private
    fRequestWaitSecs: integer;
    fNextMessageId: integer;
    fCurrentMessageId: integer;
    fProcessingMessage: boolean;
  protected
    fDoLog: boolean;
    fDoLogError: boolean;
    fLogDir: string;
    ResponseObj: TJSONObject;
    fOnRequest: TJsonRpcRequestProc;
    fOnDisconnect: TJsonRpcBaseEvent;
    fOnConnect: TJsonRpcBaseEvent;
    procedure SendStream(stream: TStream); virtual;
    procedure ReceiveStream(stream: TStream); virtual;
    procedure DoRequest(reqJson: TJSONObject); virtual;
    function WaitOnResult: TJSONObject; virtual;
    function CheckForData: boolean; virtual;
    procedure SendJson(Json: TJsonObject);
    property ProcessingMessage: boolean read fProcessingMessage write fProcessingMessage;
    procedure LogMessage(o: TJsonObject; aName: string; IsError: boolean = false); overload;
    procedure LogMessage(stream: TStream; aName: string; IsError: boolean = false); overload;
  public
    constructor Create; override;
    destructor Destroy; override;
    property RequestWaitSecs: integer read fRequestWaitSecs write fRequestWaitSecs;
    function SendRequest(aMethodName: string; obj: TJSONObject; id: integer = 0): TJSONObject; virtual;
    procedure SendNotification(aMethodName: string; obj: TJSONObject);
    property OnRequest: TJsonRpcRequestProc read fOnRequest write fOnRequest;
    property OnConnect: TJsonRpcBaseEvent read fOnConnect write fOnConnect;
    property OnDisconnect: TJsonRpcBaseEvent read fOnDisconnect write fOnDisconnect;
  end;

  TJsonRpcServer = class(TJsonRpc)
  private
  protected
    function GetActive: boolean; virtual;
    procedure SetActive(const Value: boolean); virtual;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Active: boolean read GetActive write SetActive;
  end;

  TJsonRpcClient = class(TJsonRpcBase)
  private
  protected
    function GetConnected: boolean; virtual;
    procedure SetConnected(const Value: boolean); virtual;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Connected: boolean read GetConnected write SetConnected;
  end;

implementation

uses
  sysutils, JsonRpcConst, forms, windows, utCloudconst;


{ TJsonRpc }

constructor TJsonRpc.Create;
begin
  fConfig:= TJsonObject.Create;
end;

destructor TJsonRpc.Destroy;
begin
  fConfig.Free;
  inherited;
end;

procedure TJsonRpc.SetConfig(const Value: TJsonObject);
begin
  fConfig.Assign(Value);
end;

{ TJsonRpcBase }

constructor TJsonRpcBase.Create;
begin
  inherited;
  ResponseObj:= nil;
  fProcessingMessage:= false;
  fRequestWaitSecs:= 30;
  fDoLog:= false;
  fDoLogError:= true;
  fNextMessageId:= 1;
  fCurrentMessageId:= 0;
end;

destructor TJsonRpcBase.Destroy;
begin
  inherited;
end;

function TJsonRpcBase.SendRequest(aMethodName: string;
  obj: TJSONObject; id: integer = 0): TJSONObject;
var
  o: TJSONObject;
begin
  if ProcessingMessage then begin
    result:= nil;
    obj.Free;
    exit;
  end;

  ProcessingMessage:= true;
  try
    if id <> 0 then
      fCurrentMessageId:= id
    else begin
      fCurrentMessageId:= fNextMessageId;
      Inc(fNextMessageId);
    end;

    ResponseObj:= nil;
    o:= JO('{"jsonrpc": "2.0", "method": "' + aMethodName + '"}');
    try
      if Assigned(obj) then
        o.O[TAG_CLOUD_Params]:= obj;
      o.I['id']:= fCurrentMessageId;

      LogMessage(o,'Request');

      try
        self.SendJson(o);
      except
      end;
    finally;
      o.Free;
    end;
    result:= self.WaitOnResult;
  finally
    ProcessingMessage:= false;
  end;
end;

procedure TJsonRpcBase.SendNotification(aMethodName: string; obj: TJSONObject);
var
  o: TJSONObject;
begin
  if ProcessingMessage then begin
    obj.Free;
    Exit;
  end;
  ProcessingMessage := True;
  try
    o := JO('{"jsonrpc": "2.0", "method": "' + aMethodName + '"}');
    try
      if Assigned(obj) then
        o.O[TAG_CLOUD_Params] := obj;

      LogMessage(o, 'Notification');
      Self.SendJson(o);
    finally
      o.Free;
    end;
  finally
    ProcessingMessage := false;
  end;
end;

procedure TJsonRpcBase.ReceiveStream(stream: TStream);
var
  id: integer;
  o: TJSONObject;

  procedure SendError(errorCode: integer; errorMessage: string);
  var errorObj, resp: TJSONObject;
  begin
    resp:= JO('{"jsonrpc": "2.0"}');
    try
      errorObj:= JO('{"code": '+ IntToStr(errorCode) +
        ', "message": "' + errorMessage + '"}');
      resp.O['error']:= errorObj;
      SendJson(resp);
    finally
      resp.Free;
    end;
  end;

begin
  if stream.Size > 0 then begin
    stream.Position:= 0;
    o:= JO;
    try
      o.ReadFromStream(stream);
    except
      on e: exception do begin
        LogMessage(stream,'ErrorRequest');
        SendError(RPC_INVALID_REQUEST,'Invalid Request: ' + e.Message);
        o.Free;
        exit;
      end;
    end;
    try
      if Assigned(o) then begin
        { validate JSON }
        LogMessage(o,'ReceiveStream');
        if not o.Exists('jsonrpc') then begin
          SendError(RPC_INVALID_REQUEST,'Invalid Request.');
          o.Free;
          exit;
        end
        else if o.S['jsonrpc'] <> '2.0' then begin
          SendError(RPC_INVALID_REQUEST,'Invalid Request.');
          o.Free;
          exit;
        end;

        if o.Exists('method') then begin
          { this is a request or notification }

          if ProcessingMessage and o.IntegerExists('id') then begin
            { an new request ... we are busy with another message ...
              ditch this new request }
            o.Free;
            exit;
          end;

          LogMessage(o,'Request');
          DoRequest(o);
        end
        else if o.Exists('result') or o.Exists('error') then begin
          { this is a response }
          if o.Exists('id') then id:= o.I['id']
          else id:= 0;
          LogMessage(o,'Response');
          if (id = fCurrentMessageId) or (id = 0) then begin
            { we have sent a message and this is the response with matching id }
            ResponseObj:= o;
          end
          else begin
            { unrecognised response id }
            o.Free;
          end;
        end
        else begin
          { do not recognise JSON RPC type }
          SendError(RPC_INVALID_REQUEST,'Invalid Request.');
        end;
      end
      else begin
         { there was data but was not valid JSON structure }
        SendError(RPC_PARSE_ERROR,'Parse Error.');
        o.Free;
      end;
    finally
    end;
  end;
end;

function TJsonRpcBase.WaitOnResult: TJSONObject;
var
  startTime: TDateTime;
begin
  startTime:= now;
  CheckForData;
  while (not Assigned(ResponseObj)) and
        ((now - starttime) <= (fRequestWaitSecs * (1/24/60/60))) do begin
    Sleep(10);
    Application.ProcessMessages;
    CheckForData;
  end;
  result:= ResponseObj;
end;

procedure TJsonRpcBase.SendStream(stream: TStream);
begin

end;

procedure TJsonRpcBase.DoRequest(reqJson: TJSONObject);
var
  methName: string;
  str: string;
  respJson: TJsonObject;
begin
  respJson:= nil;
  try
    if reqJson.IntegerExists('id') then begin
      { has an id so is a request
        (as opposed to a notification which does not expect a result) }
      respJson:= JO('{"jsonrpc": "2.0"}');
      respJson.I['id']:= reqJson.I['id'];
    end;

    if Assigned(fOnRequest) then
      fOnRequest(self,reqJson, respJson)
    else begin
      if Assigned(respJson) then begin
        methName:= reqJson.S['method'];
        str:= '{"code": ' + IntToStr(RPC_METHOD_NOT_FOUND) +
          ', "message": "Method not found - (' +methName+')."}';
        respJson.O['error']:= JO(str);
      end;
    end;

    { send the resonce back if this is not a notification }
    if Assigned(respJson) then
      SendJson(respJson);

  finally
    respJson.Free;
    reqJson.Free;
  end;
end;

function GetModuleNameStr: String;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;


procedure TJsonRpcBase.LogMessage(stream: TStream; aName: string; IsError: boolean);
var
  sl: TStringList;
begin
  if fDoLog or (IsError and fDoLogError) then begin
    fLogDir:= ExtractFilePath(GetModuleNameStr) + 'Log';
    if not DirectoryExists(fLogDir) then
      ForceDirectories(fLogDir);

    if not DirectoryExists(fLogDir) then
      exit;
    sl := TStringList.Create;
    try
      stream.Position := 0;
      sl.LoadFromStream(stream);
      sl.SaveToFile(fLogDir + '\' + FormatDateTime('dd-mm-yyyy_hh-nn-ss-zzz',now) +
        '_' + aName + '.txt');
    finally
      sl.Free;
    end;
  end;
end;

function TJsonRpcBase.CheckForData: boolean;
begin
  result:= false;
end;

procedure TJsonRpcBase.SendJson(Json: TJsonObject);
var
  stream: TMemoryStream;
begin
  LogMessage(Json, 'Sent');
  stream:= TMemoryStream.Create;
  try
    Json.SaveToStream(stream);
    stream.Position:= 0;
    Self.SendStream(stream);
  finally
    stream.Free;
  end;
end;

procedure TJsonRpcBase.LogMessage(o: TJsonObject; aName: string; IsError: boolean);
begin
  if fDoLog or (IsError and fDoLogError) then begin
    fLogDir:= ExtractFilePath(GetModuleNameStr) + 'Log';
    if not DirectoryExists(fLogDir) then
      ForceDirectories(fLogDir);

    if not DirectoryExists(fLogDir) then
      exit;
    if o.IntegerExists('id') then
      o.SaveToFile(fLogDir + '\' + FormatDateTime('dd-mm-yyyy_hh-nn-ss-zzz',now) +
        '_' + aName + '_' + IntToStr(o.I['id']) +'.txt')
    else
      o.SaveToFile(fLogDir + '\' + FormatDateTime('dd-mm-yyyy_hh-nn-ss-zzz',now) +
        '_' + aName + '.txt');
  end;
end;

{ TJsonRpcServer }

constructor TJsonRpcServer.Create;
begin
  inherited;
end;

destructor TJsonRpcServer.Destroy;
begin
  inherited;
end;

function TJsonRpcServer.GetActive: boolean;
begin
  result:= false;
end;

procedure TJsonRpcServer.SetActive(const Value: boolean);
begin

end;

{ TJsonRpcClient }

constructor TJsonRpcClient.Create;
begin
  inherited;
end;

destructor TJsonRpcClient.Destroy;
begin
  inherited;
end;

function TJsonRpcClient.GetConnected: boolean;
begin
  result:= false;
end;

procedure TJsonRpcClient.SetConnected(const Value: boolean);
begin

end;

end.
