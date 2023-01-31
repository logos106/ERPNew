unit JsonBsonUtils;

interface

uses
  JsonObject, MongoBson, MongoDb;

type

  TBsonArray = array of TBson;

  function JsonToBson(json: TJsonObject; CreateId: boolean = true): TBson;
  function BsonToJson(bson: TBson; json: TJsonObject = nil): TJsonObject;
  function MongoCursorToJsonArray(cursor: TMongoCursor; arr: TJsonArray = nil): TJsonArray;
  function JsonArrayToBsonArray(arr: TJsonArray): TBsonArray;

implementation

uses
  Variants, SysUtils, MongoDBObjectID;



function JsonToBson(json: TJsonObject; CreateId: boolean = true): TBson;
var
  BB: TBsonBuffer;
  x: integer;
    pair: TJsonValuePair;

  procedure AppendData(valType: TJSONValueType; Name: string; Value: TJSONValue);
  var
    dt: TDateTime;
    i: integer;
    obj: TJsonObject;
    pr: TJsonValuePair;
    arr: TJsonArray;
    jVal: TJsonValue;
    OID: TBsonOID;
  begin
    case valType of
      valNone:; // do nothing
      valString:
        begin
          if SameText(Name, '_id') then begin
            OID := TBsonOID.Create(Value.AsString);
            BB.append('_id',OID);
            OID.Free;
          end
          else begin
            if StrIsDateTime(Value.AsString, dt) then
              BB.append(Name, dt)
            else
              BB.append(Name, Value.AsString);
          end;
        end;
      valNumber: BB.append(Name, Value.AsFloat);
      valObject:
        begin
          BB.startObject(Name);
          obj := Value.AsObject;
          for i := 0 to obj.Count -1 do begin
            pr:= obj[i];
            AppendData(pr.ValueType, pr.Name, pr.Value);
          end;
          BB.finishObject;
        end;
      valArray:
        begin
          BB.StartArray(Name);
          arr := TJsonArray(Value);
          for i := 0 to arr.Count -1 do begin
            jVal := arr[i];
            AppendData(jVal.ValueType, IntToStr(i), jVal);
          end;
          BB.FinishObject;
        end;
      valNull: BB.append(Name, Variants.Null);
      valBoolean: BB.append(Name, Value.AsBoolean);
    end;
  end;

begin
  BB := TBsonBuffer.Create;
  if CreateId and (json.S['_id'] = '') then
    json.S['_id'] := MongoDBObjectID.MongoObjectIdStr;
  for x := 0 to json.Count -1 do begin
    pair := json.Items[x];
    AppendData(pair.ValueType, pair.Name, Pair.Value);
  end;
  result:= BB.finish;
end;

function BsonToJson(bson: TBson; json: TJsonObject = nil): TJsonObject;

  procedure DoIterate(iterator: TBsonIterator; jsonVal: TJSONValue);
  var
    newVal: TJsonValue;
  begin
    if not Assigned(iterator) then exit;
    while iterator.next do begin
      newVal := nil;
      case iterator.kind of
        bsonEOO:
          begin
            newVal := TJSONNull.Create;
          end;
        bsonDOUBLE:
          begin
            newVal := TJSONNumber.Create;
            newVal.AsFloat := iterator.value;
          end;
        bsonSTRING:
          begin
            newVal := TJSONString.Create;
            newVal.AsString := iterator.value;
          end;
        bsonOBJECT:
          begin
            newVal := TJSONObject.Create;
            DoIterate(Iterator.subiterator,newVal);
          end;
        bsonARRAY:
          begin
            newVal := TJSONArray.Create;
            DoIterate(Iterator.subiterator,newVal);
          end;
        bsonBINDATA:;
        bsonUNDEFINED:;
        bsonOID:
          begin
            newVal := TJSONString.Create;
            newVal.AsString := iterator.getOID.AsString;
          end;
        bsonBOOL:
          begin
            newVal := TJSONBoolean.Create;
            newVal.AsBoolean := iterator.value;
          end;
        bsonDATE:
          begin
            newVal := TJSONString.Create;
            newVal.AsDateTime := iterator.value;
          end;
        bsonNULL:
          begin
            newVal := TJSONNull.Create;
          end;
        bsonREGEX:;
        bsonDBREF:; (* Deprecated. *)
        bsonCODE:;
        bsonSYMBOL:;
        bsonCODEWSCOPE:;
        bsonINT:
          begin
            newVal := TJSONNumber.Create;
            newVal.AsInteger := iterator.value;
          end;
        bsonTIMESTAMP:
          begin
            newVal := TJSONString.Create;
            newVal.AsDateTime := iterator.getTimestamp.time;
          end;
        bsonLONG:
          begin
            newVal := TJSONNumber.Create;
            newVal.AsFloat := iterator.value;
          end;
      end;
      if Assigned(newVal) then begin
        if jsonVal.ValueType = valObject then
          jsonVal.AsObject.Add(iterator.key, newVal)
        else if jsonVal.ValueType = valArray then
          TJsonArray(jsonVal).Add(newVal);
      end;
    end;
  end;

begin
  if Assigned(json) then result := json
  else result := JO;
  DoIterate(bson.iterator, result);
end;

function MongoCursorToJsonArray(cursor: TMongoCursor; arr: TJsonArray = nil): TJsonArray;
begin
  if Assigned(arr) then result := arr
  else result := TJsonArray.Create;
  while cursor.next do
    result.Add(BsonToJson(Cursor.value));
end;

function JsonArrayToBsonArray(arr: TJsonArray): TBsonArray;
var
  x: integer;
  val: TJsonValue;
  bson: TBson;
begin
  for x := 0 to arr.Count -1 do begin
    val := arr[x];
    if val.IsTypeObject then begin
      bson := JsonToBson(TJsonObject(val));
      SetLength(result, Length(result)+1);
      result[High(result)] := BSON;
    end;
  end;
end;

end.
