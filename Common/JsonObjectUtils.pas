unit JsonObjectUtils;

interface

uses
  JsonObject;

  procedure SaveToEncrypedFile(obj: TJSONObject; aFileName: string; aKey: string = '');
  procedure LoadFromEncrypedFile(obj: TJSONObject; aFileName: string; aKey: string = '');
  procedure JsonToFileFormated(obj: TJSONObject; aFileName: string);
  function JsonToStrFormat(obj: TJSONObject): string; overload;
  function JsonToStrFormat(JsonStr: string): string; overload;
  procedure FlattenERPJson(json: TJsonObject);
  procedure ExpandERPJson(json: TJsonObject);
  procedure RemoveFields(json: TJsonObject; fieldList: string);


implementation

uses
  classes, sysutils, CipherUtils;


procedure SaveToEncrypedFile(obj: TJSONObject; aFileName: string; aKey: string = '');
var
  InStream: TMemoryStream;
  OutStream: TFileStream;
begin
  InStream:= TMemoryStream.Create;
  OutStream:= TFileStream.Create(aFileName, fmCreate);
  try
    Obj.SaveToStream(InStream);
    InStream.Position:= 0;
    Encrypt(InStream, OutStream);
  finally
    InStream.Free;
    OutStream.Free;
  end;
end;

procedure LoadFromEncrypedFile(obj: TJSONObject; aFileName: string; aKey: string = '');
var
  InStream: TFileStream;
  OutStream: TMemoryStream;
begin
  if FileExists(aFileName) then begin
    InStream:= TFileStream.Create(aFileName, fmOpenRead);
    OutStream:= TMemoryStream.Create;
    try
      Decrypt(InStream, OutStream);
      OutStream.Position:= 0;
      obj.ReadFromStream(OutStream);
    finally
      InStream.Free;
      OutStream.Free;
    end;
  end
  else
    obj.Clear;
end;

procedure JsonToFileFormated(obj: TJSONObject; aFileName: string);
var
  sl: TStringList;
  x: integer;
  ident: integer;
  isObj: boolean;

  function PadStr: string;
  var y: integer;
  begin
    result:= '';
    for y:= 0 to ident -1 do
      result:= result + '    ';
  end;

begin
  sl:= TStringList.Create;
  try
    sl.Text:= obj.AsString;
    ident:= 0;
    for x:= 0 to sl.Count-1 do begin
      if (Pos('}',sl[x]) = 1) and (ident > 0) then
        dec(ident);
      isObj:= Pos('{',sl[x]) = 1;
      sl[x]:= PadStr + sl[x];
      if IsObj then Inc(ident);
    end;
    sl.SaveToFile(aFileName);
  finally
    sl.Free;
  end;
end;


function JsonToStrFormat(JsonStr: string): string; overload;
var
  sl: TStringList;
  x: integer;
  ident: integer;
  isObj: boolean;

  function PadStr: string;
  var y: integer;
  begin
    result:= '';
    for y:= 0 to ident -1 do
      result:= result + '    ';
  end;

begin
  sl:= TStringList.Create;
  try
    sl.Text:= JsonStr;
    ident:= 0;
    for x:= 0 to sl.Count-1 do begin
      if (Pos('}',sl[x]) = 1) and (ident > 0) then
        dec(ident);
      isObj:= Pos('{',sl[x]) = 1;
      sl[x]:= PadStr + sl[x];
      if IsObj then Inc(ident);
    end;
    result := sl.text;
  finally
    sl.Free;
  end;
end;

function JsonToStrFormat(obj: TJSONObject): string;
begin
  result := JsonToStrFormat(obj.AsString);
end;

{ Flatten out ERP Object Json
  ie get rid of "fields" object and move its values, change "type" to "_type"  }
procedure FlattenERPJson(json: TJsonObject);
var
  fields: TJsonObject;
  x: integer;
  arr: TJsonArray;
begin
  if json.StringExists('type') and json.ObjectExists('fields') then begin
    json.S['_type'] := json.S['type'];
    json.Delete('type');
    fields := json.O['fields'];
    while fields.Count > 0 do begin
      if fields[0].ValueType = valObject then
        FlattenERPJson(fields[0].Value.AsObject)
      else if fields[0].ValueType = valArray then begin
        arr := TJsonArray(fields[0].Value);
        for x := 0 to arr.Count -1 do begin
          if arr[x].ValueType = valObject then
            FlattenERPJson(arr[x].AsObject);
        end;
      end;
      json.Add(fields.Extract(0));
    end;
    json.Delete('fields');
  end;
end;

{ does the reverse of FlattenERPJson }
procedure ExpandERPJson(json: TJsonObject);
var
  fields: TJsonObject;
  x: integer;
  arr: TJsonArray;
begin
  if not json.ObjectExists('fields') then begin
    fields := JO;
    while json.Count > 0 do begin
      if json[0].ValueType = valObject then
        ExpandERPJson(json[0].Value.AsObject)
      else if json[0].ValueType = valArray then begin
        arr := TJsonArray(json[0].Value);
        for x := 0 to arr.Count -1 do begin
          if arr[x].ValueType = valObject then
            ExpandERPJson(arr[x].AsObject);
        end;
      end;
      fields.Add(json.Extract(0));
    end;
    if fields.StringExists('_type') then begin
      json.S['type'] := fields.S['_type'];
      fields.Delete('_type');
    end;
    json.O['fields'] := fields;
  end;
end;

procedure RemoveFields(json: TJsonObject; fieldList: string);
var
  sl: TStringList;

  procedure DoRemove(obj: TJsonObject);
  var
    x, y: integer;
    pair: TJsonValuePair;
  begin
    for x := 0 to sl.Count -1 do
      obj.Delete(sl[x]);
    for x := 0 to obj.Count -1 do begin
      pair := obj.Items[x];
      if pair.ValueType = valObject then
        DoRemove(pair.Value.AsObject)
      else if pair.ValueType = valArray then begin
        for y := 0 to TJsonArray(pair.Value).Count -1 do
          if TJsonArray(pair.Value).Items[y].IsTypeObject then
            DoRemove(TJsonArray(pair.Value).Items[y].AsObject);
      end;
    end;
  end;

begin
  sl := TStringList.Create;
  try
    sl.CommaText := fieldList;

    DoRemove(json);

  finally
    sl.Free;
  end;
end;

end.
