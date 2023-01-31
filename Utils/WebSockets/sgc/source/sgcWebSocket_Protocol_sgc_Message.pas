{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Protocol_sgc_Message;

interface

uses
  Classes, SysUtils,
  sgcWebSocket_Protocol_Base_Message, sgcJSON;

type
  TsgcWSMessage = class(TsgcWSMessage_Base)
  private
    FChannel: String;
    Ferrorcode: Integer;
    Ferrordata: string;
    Ferrormessage: string;
    FGuid: String;
    Fid: string;
    FJSONResult: TsgcObjectJSON;
    Fmethod: string;
    Fparams: string;
    Fresult: string;
    FText: String;
    Fversion: String;
    function GetJSONResult: TsgcObjectJSON;
    procedure Seterrorcode(const Value: Integer);
  protected
    procedure DoReadMethods; virtual;
    function DoGetResult(const aMessage : string) : string;
  public
    constructor Create(aOwner: TCOmponent); override;
  public
    procedure Clear(aForceClear: Boolean = False); override;
  public
    procedure Read(const aMessage: String); override;
    function Write: string; override;
  public
  { custom }
  public
    property Text: String read FText write FText;
    property Channel: String read FChannel write FChannel;
    property Guid: String read FGuid write FGuid;
  { custom }

  { json-rpc }
  public
    property errorcode: Integer read Ferrorcode write Seterrorcode;
    property errordata: string read Ferrordata write Ferrordata;
    property errormessage: string read Ferrormessage write Ferrormessage;
    property id: string read Fid write Fid;
    property JSONResult: TsgcObjectJSON read GetJSONResult write FJSONResult;
    property method: string read Fmethod write Fmethod;
    property params: string read Fparams write Fparams;
    property result: string read Fresult write Fresult;
    property version: String read Fversion;
  { json-rpc }
  end;

implementation

uses
  sgcWebSocket_Const;

constructor TsgcWSMessage.Create(aOwner: TCOmponent);
begin
  inherited;
  Fversion := CS_JSONRPC_VERSION;
end;

procedure TsgcWSMessage.Clear(aForceClear: Boolean = False);
begin
  if (not FIsWriting and not FIsReading) or (aForceClear = True) then
  begin
    Text := '';
    Channel := '';
    Guid := '';
    errorcode := 0;
    errordata := '';
    errormessage := '';
    id := '';
    method := '';
    params := '';
    result := '';
    JSONResult.Clear;
    inherited;
  end;
end;

function TsgcWSMessage.DoGetResult(const aMessage: string): string;
var
  lPos, lCount : integer;
  firstChar, lastChar : char;
begin
  Result := '';
  lPos := pos('"result"', aMessage);
  if lPos = 0 then
    exit;
  while (lPos < length(aMessage)) and not(aMessage[lPos] in ['{', '[']) do//(aMessage[lPos] <> '{') do
    inc(lPos);
  lCount := 0;
  firstChar := aMessage[lPos];
  if firstChar =  '{' then
    lastChar := '}'
  else
    lastChar := ']';
  while (lPos <= Length(aMessage)) do
  begin
    Result := Result + aMessage[lPos];
    if aMessage[lPos] = LastChar then
      dec(lCount)
    else if aMessage[lPos] = firstChar then
      inc(lCount);
    if lCount = 0 then
      break;
    inc(lPos);
  end;

end;

procedure TsgcWSMessage.DoReadMethods;
var
  oJSON: TsgcJSON;
begin
  oJSON := TsgcJSON.Create(nil);
  Try
    if ((method = CS_SGC_BROADCAST) or (method = CS_SGC_MESSAGE)) then
    begin
      oJSON.Read(params);
      if oJSON.Node[CS_MESSAGE] <> nil then
        Text := oJSON.Node[CS_MESSAGE].Value;
      if oJSON.Node[CS_CHANNEL] <> nil then
        Channel := oJSON.Node[CS_CHANNEL].Value;
    end
    else if ((method = CS_SGC_PUBLISH) or (method = CS_SGC_EVENT)) then
    begin
      oJSON.Read(params);
      if oJSON.Node[CS_MESSAGE] <> nil then
        Text := oJSON.Node[CS_MESSAGE].Value;
      if oJSON.Node[CS_CHANNEL] <> nil then
        Channel := oJSON.Node[CS_CHANNEL].Value;
    end
    else if ((method = CS_SGC_SUBSCRIBE) or (method = CS_SGC_UNSUBSCRIBE)) then
    begin
      oJSON.Read(params);
      if oJSON.Node[CS_CHANNEL] <> nil then
        Channel := oJSON.Node[CS_CHANNEL].Value;
    end;
  Finally
    FreeAndNil(oJSON);
  End;
end;

function TsgcWSMessage.GetJSONResult: TsgcObjectJSON;
begin
  if not Assigned(FJSONResult) then
    FJSONResult := TsgcObjectJSON.Create(self);
  Result := FJSONResult;
end;

procedure TsgcWSMessage.Read(const aMessage: String);
begin
  DoEnterRead(aMessage);

  if DoReadJSONValue(CS_JSON_RPC) <> CS_JSONRPC_VERSION then
    raise Exception.Create('Error decoding message.');

  // ... result
  if FJSON.Node[CS_RESULT] <> nil then
  begin
    Result := FJSON.Node[CS_RESULT].Value;
    if (Result = '') and (FJson.Node[CS_RESULT].JSONObject <> nil) then
      Result := FJson.Node[CS_RESULT].JSONObject.Text;
    if Result[1] = '{' then
      Result := DoGetResult(aMessage) else
    if Result = '[' then
      Result := DoGetResult(aMessage);
    method := DoReadJSONValue(CS_METHOD, FJSON.Node[CS_RESULT]);
    text := DoReadJSONValue(CS_MESSAGE, FJSON.Node[CS_RESULT]);
    channel := DoReadJSONValue(CS_CHANNEL, FJSON.Node[CS_RESULT]);
  end
  // ... error
  else if FJSON.Node[CS_ERROR] <> nil then
  begin
  (*
    errorcode := DoReadJSONValue(CS_ERROR, FJSON.Node[CS_CODE]);
    errormessage := DoReadJSONValue(CS_ERROR, FJSON.Node[CS_MESSAGE]);
    errordata := DoReadJSONValue(CS_ERROR, FJSON.Node[CS_DATA]);
    *)
    errorcode := DoReadJSONValue(CS_CODE, FJSON.Node[CS_ERROR]);
    errormessage := DoReadJSONValue(CS_MESSAGE, FJSON.Node[CS_ERROR]);
    errordata := DoReadJSONValue(CS_DATA, FJSON.Node[CS_ERROR]);
  end
  else
  // ... method
  begin
    method := DoReadJSONValue(CS_METHOD);
    params := DoReadJSONValue(CS_PARAMS);
    // ... read methods
    DoReadMethods;
  end;
  id := DoReadJSONValue(CS_ID);

  inherited;
end;

procedure TsgcWSMessage.Seterrorcode(const Value: Integer);
begin
  Ferrorcode := Value;
end;

function TsgcWSMessage.Write: string;
var
  oJSON: TsgcObjectJSON;
begin
  DoEnterWrite;

  DoWriteJSONValue(CS_JSON_RPC, version);
  // ... error
  if errorcode <> 0  then
  begin
    oJSON := DoAddJSONObject(CS_ERROR);
    DoWriteJSONValue(CS_CODE, errorcode, oJSON);
    DoWriteJSONValue(CS_MESSAGE, errormessage, oJSON);
    if errordata <> '' then
      DoWriteJSONValue(CS_DATA, errordata, oJSON);
  end
  // ... result
  else if JSONResult.Count > 0 then
  begin
    oJSON := DoAddJSONObject(CS_RESULT);
    oJSON.JSONObject := JSONResult.JSONObject;
  end
  else if Fresult <> '' then
  begin
    // ... subscription
    if (method = CS_SGC_SUBSCRIBE) or (method = CS_SGC_UNSUBSCRIBE) then
    begin
      oJSON := DoAddJSONObject(CS_RESULT);
      DoWriteJSONValue(CS_METHOD, method, oJSON);
      DoWriteJSONValue(CS_CHANNEL, channel, oJSON);
    end
    // ... broadcast
    else if ((method = CS_SGC_BROADCAST) or (method = CS_SGC_MESSAGE))  then
    begin
      oJSON := DoAddJSONObject(CS_RESULT);
      DoWriteJSONValue(CS_METHOD, CS_SGC_MESSAGE, oJSON);
      DoWriteJSONValue(CS_CHANNEL, channel, oJSON);
      DoWriteJSONValue(CS_MESSAGE, text, oJSON);
    end
    // ... publish
    else if ((method = CS_SGC_PUBLISH) or (method = CS_SGC_EVENT))  then
    begin
      oJSON := DoAddJSONObject(CS_RESULT);
      DoWriteJSONValue(CS_METHOD, method, oJSON);
      DoWriteJSONValue(CS_CHANNEL, channel, oJSON);
      DoWriteJSONValue(CS_MESSAGE, text, oJSON);
    end
    else
      DoWriteJSONValue(CS_RESULT, Fresult);
  end
  else
  // ... method
  begin
    DoWriteJSONValue(CS_METHOD, method);
    if params <> '' then
      DoWriteJSONValue(CS_PARAMS, params)
    else if ((Text <> '') or (channel <> '')) then
    begin
      oJSON := DoAddJSONObject(CS_PARAMS);
      if text <> '' then
        DoWriteJSONValue(CS_MESSAGE, Text, oJSON);
      if Channel <> '' then
        DoWriteJSONValue(CS_CHANNEL, Channel, oJSON);
      if Guid <> '' then
        DoWriteJSONValue(CS_GUID, Channel, oJSON);
    end;
  end;
  if id <> '' then
    DoWriteJSONValue(CS_ID, id);
  result := inherited Write;
end;

end.
