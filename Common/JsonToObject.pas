unit JsonToObject;

interface

uses
  JsonObject;

  procedure ObjToJson(Obj: TObject; Json: TJsonObject); overload;
  function ObjToJson(Obj: TObject): TJsonObject; overload;
  procedure ObjStructToJson(Obj: TObject; Json: TJsonObject; prefix: string = '');
  procedure JsonToObj(Json: TJsonObject; Obj: TObject);
  function ObjToStr(Obj: TObject; encrypt: boolean = false): string;
  procedure StrToObj(str: string; obj: TObject; encrypt: boolean = false);
  procedure ObjToFile(obj: TObject; FileName: string; encrypt: boolean = false);
  procedure FileToObj(FileName: string; obj: TObject; encrypt: boolean = false);
  procedure ObjToObj(SrcObj, DestObj: TObject);
  procedure JsonToEncryptedFile(Json: TJsonObject; FileName: string);
  procedure EncryptedFileToJson(Json: TJsonObject; FileName: string);

implementation
uses
  {$IfDef VER220}
  Windows,
  {$Else}
  {$EndIf}
  TypInfo, variants, contnrs, classes, sysutils, CipherUtils;

type
  ObjArray = array of TObject;
  StrArray = array of string;

const
  Hidedsfuncfields = False;

function IsClassByString(const aObject: TObject; const aClassName: string): boolean;
var
  ClassRef: TClass;
begin
  result:= false;
  ClassRef:= aObject.ClassType;
  while ClassRef <> nil do begin
    if ClassRef.ClassNameIs(aClassName) then begin
      result:= true;
      break;
    end;
    ClassRef:= ClassRef.ClassParent;
  end;
end;

procedure ObjToJson(Obj: TObject; Json: TJsonObject);
var
  count, x, idx: integer;
  PropList: PPropList;
  propName: string;
  Val: Variant;
  subObj: TObject;
  subJson: TJsonObject;
  ArrayPointer: Pointer;
  s: string;
begin
  Count := GetPropList(obj.ClassInfo, tkProperties, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(obj.ClassInfo, tkProperties, PropList);
    for x := 0 to Count -1 do begin
      try
            propName:=String(PropList[x].Name);
            if Hidedsfuncfields then
              if sametext(propName , 'ISEmpty') then continue
              else if sametext(propName , 'KeyStringFieldName') then continue
              else if sametext(propName , 'KeyValue') then continue
              else if sametext(propName , 'MsTimeStamp') then continue
              else if sametext(propName , 'MsUpdateSiteCode') then continue
              else if sametext(propName , 'Recno') then continue;
            case PropList[x].PropType^.Kind of
              tkEnumeration:
                begin
                  val:= GetPropValue(obj, propName);
                  if (not VarIsNull(val)) then begin
                    if PropList[x].PropType^.Name = 'Boolean' then begin
                      if Val = 'True' then Json.B[propName]:= true
                      else if Val = 'False' then Json.B[propName]:= false
                    end
                    else
                      Json.S[propName]:= val;
                  end;
                end;
              tkInteger : Json.I[propName]:= GetOrdProp(obj,propName);
              tkInt64 : Json.I[propName]:= GetInt64Prop(obj,propName);
              tkFloat :
                if Json.Exists(propName) and (Json.ItemByName[propName].ValueType = valNumber) then
                  Json.F[propName]:= GetFloatProp(obj,propName)
                else begin
                  if PropList[x].PropType^.Name = 'TDateTime' then
                    //Json.ItemByName[propName].Value.AsString := FormatDateTime(JsonDateTimeFormat,GetFloatProp(obj,propName))
                    Json.DT[propName] := GetFloatProp(obj,propName)
                  else
                    //Json.ItemByName[propName].Value.AsFloat := GetFloatProp(obj,propName);
                    Json.F[propName] := GetFloatProp(obj,propName);
                end;
              tkChar,
              tkString,
              tkWChar,
              tkLString,
              tkWString,
              tkUString : Json.S[propName]:= GetStrProp(obj, propName);
              tkSet,
              tkMethod,
              tkVariant,
              tkArray,
              tkRecord,
              tkInterface,
              tkUnknown:
                begin
                  val:= GetPropValue(obj, propName);
                  if (not VarIsNull(val)) then begin
                    Json.S[propName]:= val;
                  end
                  else
                   Json.Add(propName,valNull);
                end;
              tkDynArray:
                begin
                  ArrayPointer := GetDynArrayProp(obj, propName);
                  { try array of object .. }
                  try
                    for idx := Low(ObjArray(ArrayPointer)) to High(ObjArray(ArrayPointer)) do begin
                      subObj:= ObjArray(ArrayPointer)[idx];
                      if Assigned(subObj) then begin
                        subJson:= JO;
                        ObjToJson(subObj,subJson);
                        Json.A[propName].Add(subJson);
                      end;
                    end;
                  except
                    on e: exception do begin
                      { try for array of string .. }
                      try
                        for idx := Low(StrArray(ArrayPointer)) to High(StrArray(ArrayPointer)) do begin
                          s:= StrArray(ArrayPointer)[idx];
                          Json.A[propName].Add(s);
                        end;
                      except
                        raise Exception.Create('Error - Unknown array type for property "' + propName + '"');
                      end;
                    end;
                  end;
                end;
              tkClass:
                begin
                  subObj:= GetObjectProp(obj, propName);
                  if Assigned(subObj) then begin
                    if subObj is TJSONValue then begin
                      case TJsonValue(subObj).ValueType of
                        TJSONValueType.valNone:;
                        TJSONValueType.valString: Json.S[propName] := TJsonValue(subObj).AsString;
                        TJSONValueType.valNumber: Json.F[propName] := TJsonValue(subObj).AsFloat;
                        TJSONValueType.valObject: Json.O[propName].Assign(TJsonValue(subObj).AsObject);
                        TJSONValueType.valArray: Json.A[propName].AsString := TJsonValue(subObj).AsString;
                        TJSONValueType.valNull: Json.Add(propName,TJsonValue(subObj));
                        TJSONValueType.valBoolean: Json.B[propName] := TJsonValue(subObj).AsBoolean;
                      end;
                    end
                    else begin
                      subJson:= JO;
                      ObjToJson(subObj,subJson);
                      Json.O[propName]:= subJson;
                    end;
                  end;
                end;
            end;
      Except
        // kill exception
      end;
    end;
  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;
  if (Obj is TObjectList) then begin
    for idx:= 0 to TObjectList(Obj).Count -1 do begin
      subObj:= TObjectList(Obj).Items[idx];
      subJson:= JO;
      ObjToJson(subObj,subJson);
      Json.A['Items'].Add(subJson);
    end;
  end
  else if (Obj is TCollection) then begin
    for idx:= 0 to TCollection(Obj).Count -1 do begin
      subObj:= TCollection(Obj).Items[idx];
      subJson:= JO;
      ObjToJson(subObj,subJson);
      Json.A['Items'].Add(subJson);
    end;
  end;
end;

function ObjToJson(Obj: TObject): TJsonObject; overload;
begin
  result := JO;
  ObjToJson(Obj, result);
end;

procedure JsonToObj(Json: TJsonObject; Obj: TObject);
var
  propIdx, x: integer;
  valPair: TJSONValuePair;
  subObj: TObject;
  item: TCollectionItem;
  PropInfo: PPropInfo;
begin
  if IsClassByString(Obj,'TCollection') then
    TCollection(Obj).Clear;
  for propIdx:= 0 to Json.Count-1 do begin
    try
      valPair:= Json.Items[propIdx];
      if not Assigned(valPair) then
        continue;
      PropInfo:= TypInfo.GetPropInfo(obj,valPair.Name);
      if Assigned(PropInfo) and
        (PropInfo.PropType^.Kind <> tkClass) and (not Assigned(PropInfo.SetProc))  then
        continue;
      case valPair.Value.ValueType of
        JsonObject.valString:
          begin
            if Assigned(PropInfo) then begin
              if TypInfo.GetPropInfo(obj,valPair.Name).PropType^.kind = tkEnumeration then
                TypInfo.SetEnumProp(Obj,valPair.Name, ValPair.Value.AsString)
              else if (TypInfo.GetPropInfo(obj,valPair.Name).PropType^ = System.TypeInfo(TDateTime)) or
                      (TypInfo.GetPropInfo(obj,valPair.Name).PropType^ = System.TypeInfo(TTime)) or
                      (TypInfo.GetPropInfo(obj,valPair.Name).PropType^ = System.TypeInfo(TDate)) then
                TypInfo.SetFloatProp(Obj,valPair.Name, ValPair.Value.AsDateTime)
              else
                TypInfo.SetWideStrProp(Obj,valPair.Name, ValPair.Value.AsString);
            end;
          end;
        valNumber:
          begin
            if Assigned(PropInfo) then begin
              case PropType(Obj,valPair.Name) of
                tkInteger, tkEnumeration: TypInfo.SetOrdProp(Obj,valPair.Name, ValPair.Value.AsInteger);
                tkFloat: TypInfo.SetFloatProp(Obj,valPair.Name, ValPair.Value.AsFloat);
                tkVariant: TypInfo.SetVariantProp(Obj,valPair.Name, ValPair.Value.AsFloat);
                tkInt64: TypInfo.SetInt64Prop(Obj,valPair.Name, ValPair.Value.AsInteger);
              end;
            end;
          end;
        valBoolean:
          begin
            if Assigned(PropInfo) then begin
              if ValPair.Value.AsBoolean then
                TypInfo.SetEnumProp(Obj,valPair.Name,'True')
              else
                TypInfo.SetEnumProp(Obj,valPair.Name,'False');
            end;
          end;
        valArray:
          begin
            if IsClassByString(Obj,'TCollection') then begin
              { assume an array of objects }
              TCollection(Obj).Clear;
              for x:= 0 to TJSONArray(ValPair.Value).Count -1 do begin
                item:= TCollection(Obj).Add;
                { populate list item object }
                JsonToObj(TJsonObject(TJSONArray(ValPair.Value).Items[x]),item);
              end;
            end
            else if PropType(Obj,valPair.Name) = tkClass then begin
              subObj:= TypInfo.GetObjectProp(obj,valPair.Name);
              if Assigned(subObj) then begin
                if subObj is TJSONValue then begin
                  if subObj is TJsonObject then TJsonObject(subObj).Clear
                  else if subObj is TJsonArray then TJsonArray(subObj).Clear;
                  TJSONValue(subObj).AsString :=  ValPair.Value.AsString;
                end;
              end;
            end;
          end;
        valNull: SetVariantProp(Obj,valPair.Name,null);
        valObject:
          begin
            if Assigned(PropInfo) then begin
              { sub object }
              subObj:= TypInfo.GetObjectProp(obj,valPair.Name);
              if Assigned(subObj) then begin
                JsonToObj(TJsonObject(ValPair.Value),subObj);
              end;
            end;
          end;
      end;
    except
      on e: exception do begin
        raise;
      end;
    end;
  end;
end;

function ObjToStr(Obj: TObject; encrypt: boolean): string;
var
  Json: TJsonObject;
  s: string;
begin
  Json:= JO;
  try
    ObjToJson(obj, Json);
    s := Json.AsString;
    if encrypt then
      result := CipherUtils.EncryptString(s)
    else
      result:= s;
  finally
    Json.Free;
  end;
end;

procedure StrToObj(str: string; obj: TObject; encrypt: Boolean);
var
  Json: TJsonObject;
begin
  Json := JO;
  try
    if encrypt then
      Json.AsString := CipherUtils.DecryptString(str)
    else
      Json.AsString := str;
    JsonToObj(Json, obj);
  finally
    Json.Free;
  end;
end;

procedure ObjToFile(obj: TObject; FileName: string; encrypt: boolean = false);
var
  Json: TJsonObject;
  MemStream: TMemoryStream;
  FileStream: TFileStream;
begin
  Json:= JO;
  if FileExists(FileName) then
    sysutils.DeleteFile(FileName);
  FileStream:= TFileStream.Create(FileName,fmCreate);
  try
    ObjToJson(obj, Json);
    if encrypt then begin
      MemStream:= TMemoryStream.Create;
      try
        Json.SaveToStream(MemStream);
        MemStream.Position:= 0;
        CipherUtils.Encrypt(MemStream, FileStream);
      finally
        MemStream.Free;
      end;
    end
    else begin
      Json.SaveToStream(FileStream);
    end;
  finally
    FileStream.Free;
    Json.Free;
  end;
end;

procedure FileToObj(FileName: string; obj: TObject; encrypt: boolean = false);
var
  Json: TJsonObject;
  MemStream: TMemoryStream;
  FileStream: TFileStream;
begin
  if FileExists(FileName) then begin
    Json:= JO;
    FileStream:= TFileStream.Create(FileName, fmOpenRead);
    try
      if encrypt then begin
        MemStream:= TMemoryStream.Create;
        try
          CipherUtils.Decrypt(FileStream, MemStream);
          MemStream.Position:= 0;
          Json.ReadFromStream(MemStream);
        finally
          MemStream.Free;
        end;
      end
      else begin
        Json.ReadFromStream(FileStream);
      end;
      JsonToObj(Json,obj);
    finally
      Json.Free;
      FileStream.Free;
    end;
  end;  
end;

procedure ObjToObj(SrcObj, DestObj: TObject);
var
  Json: TJsonObject;
begin
  Json:= JO;
  try
    ObjToJson(SrcObj,Json);
    JsonToObj(Json,DestObj);
  finally
    Json.Free;
  end;
end;

procedure JsonToEncryptedFile(Json: TJsonObject; FileName: string);
var
  MemStream: TMemoryStream;
  FileStream: TFileStream;
begin
  FileStream:= TFileStream.Create(FileName,fmCreate);
  try
    MemStream:= TMemoryStream.Create;
    try
      Json.SaveToStream(MemStream);
      MemStream.Position:= 0;
      CipherUtils.Encrypt(MemStream, FileStream);
    finally
      MemStream.Free;
    end;
  finally
    FileStream.Free;
  end;
end;

procedure EncryptedFileToJson(Json: TJsonObject; FileName: string);
var
  MemStream: TMemoryStream;
  FileStream: TFileStream;
begin
  if FileExists(FileName) then begin
    FileStream:= TFileStream.Create(FileName, fmOpenRead);
    try
      MemStream:= TMemoryStream.Create;
      try
        CipherUtils.Decrypt(FileStream, MemStream);
        MemStream.Position:= 0;
        Json.ReadFromStream(MemStream);
      finally
        MemStream.Free;
      end;
    finally
      FileStream.Free;
    end;
  end
  else
    Json.Clear;
end;

procedure ObjStructToJson(Obj: TObject; Json: TJsonObject; prefix: string = '');
var
  count, x: integer;
//  idx: integer;
  PropList: PPropList;
  propName: string;
//  Val: Variant;
  subObj: TObject;
  o: TJsonObject;
  ExcludeList: TStringList;
  ExcludeListChecked: boolean;
//  subJson: TJsonObject;
//  ArrayPointer: Pointer;
//  s: string;

  procedure AddEntry;
  begin
    o := JO;
    if True then
    if Assigned(PropList[x]^.GetProc) and Assigned(PropList[x]^.SetProc) then
      o.S['ReadWrite'] := 'ReadWrite'
    else if Assigned(PropList[x]^.GetProc) then
      o.S['ReadWrite'] := 'Read'
    else if Assigned(PropList[x]^.SetProc) then
      o.S['ReadWrite'] := 'Write';
  end;

  function Include(aPropName: string): boolean;
  begin
    result := true;
    if (not Assigned(ExcludeList)) and (not ExcludeListChecked) then begin
      ExcludeListChecked := true;
      ExcludeList := TStringList(GetObjectProp(obj, 'ExportExcludeList'));
      if Assigned(ExcludeList) then
        ExcludeList.CaseSensitive := false;
    end;
    if Assigned(ExcludeList) and (ExcludeList.IndexOf(aPropName) > -1) then
      result := false;
  end;

begin
  ExcludeList := nil;
  ExcludeListChecked := false;

  Count := GetPropList(obj.ClassInfo, tkProperties, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(obj.ClassInfo, tkProperties, PropList);
    for x := 0 to Count -1 do begin

      propName:=String(PropList[x].Name);
      o := nil;

      case PropList[x].PropType^.Kind of
        tkEnumeration:
          begin
            if not Include(propName) then continue;
            AddEntry;
            o.S['DataType'] := 'Boolean';
//            val:= GetPropValue(obj, propName);
//            if (not VarIsNull(val)) then begin
//              if Val = 'True' then Json.B[propName]:= true
//              else if Val = 'False' then Json.B[propName]:= false
//              else Json.S[propName]:= val;
//            end;
          end;
        tkInteger,
        tkInt64:
          begin
            if not Include(propName) then continue;
            AddEntry;
            o.S['DataType'] := 'Integer'; //   Json.I[propName]:= GetInt64Prop(obj,propName);
          end;
        tkFloat:
          begin
            if not Include(propName) then continue;
            if PropList[x].PropType^.Name = 'TDateTime' then begin
              AddEntry;
              o.S['DataType'] := 'DateTime';
            end
            else begin
              AddEntry;
              o.S['DataType'] := 'Float';
            end;
          end;
//          if (not Json.Exists(propName)) or (Json.ItemByName[propName].ValueType = valNumber) then
//            Json.F[propName]:= GetFloatProp(obj,propName)
//          else
//            Json.ItemByName[propName].Value.AsFloat := GetFloatProp(obj,propName);
        tkChar,
        tkString,
        tkWChar,
        tkLString,
        tkWString,
        tkUString:
          begin
            if not Include(propName) then continue;
            AddEntry;
            o.S['DataType'] := 'String';
//            Json.S[propName]:= GetStrProp(obj,propName);
          end;
        tkSet,
        tkMethod,
        tkVariant,
        tkArray,
        tkRecord,
        tkInterface,
        tkUnknown:
          begin
//            val:= GetPropValue(obj, propName);
//            if (not VarIsNull(val)) then begin
//              Json.S[propName]:= val;
//            end
//            else
//             Json.Add(propName,valNull);
          end;
        tkDynArray:
          begin
//            ArrayPointer := GetDynArrayProp(obj, propName);
//            { try array of object .. }
//            try
//              for idx := Low(ObjArray(ArrayPointer)) to High(ObjArray(ArrayPointer)) do begin
//                subObj:= ObjArray(ArrayPointer)[idx];
//                if Assigned(subObj) then begin
//                  subJson:= JO;
//                  ObjToJson(subObj,subJson);
//                  Json.A[propName].Add(subJson);
//                end;
//              end;
//            except
//              on e: exception do begin
//                { try for array of string .. }
//                try
//                  for idx := Low(StrArray(ArrayPointer)) to High(StrArray(ArrayPointer)) do begin
//                    s:= StrArray(ArrayPointer)[idx];
//                    Json.A[propName].Add(s);
//                  end;
//                except
//                  raise Exception.Create('Error - Unknown array type for property "' + propName + '"');
//                end;
//              end;
//            end;
          end;
        tkClass:
          begin
            if not Include(propName) then continue;
            AddEntry;
            o.S['DataType'] := 'Object';
            subObj:= GetObjectProp(obj, propName);
            if prefix <> '' then
              ObjStructToJson(subObj,Json,prefix + '.' + propName)
            else
              ObjStructToJson(subObj,Json,propName);
//            subJson:= JO;
//            if Assigned(subObj) then begin
//              ObjToJson(subObj,subJson);
//            end;
//            Json.O[propName]:= subJson;
          end;
      end;
      if Assigned(o) then begin
        if prefix <> '' then
          Json.Add(prefix + '.' + propName,o)
        else
          Json.Add(propName,o);
      end;
    end;
  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;
//  if (Obj is TObjectList) then begin
//    for idx:= 0 to TObjectList(Obj).Count -1 do begin
//      subObj:= TObjectList(Obj).Items[idx];
//      subJson:= JO;
//      ObjToJson(subObj,subJson);
//      Json.A['Items'].Add(subJson);
//    end;
//  end
//  else if (Obj is TCollection) then begin
//    for idx:= 0 to TCollection(Obj).Count -1 do begin
//      subObj:= TCollection(Obj).Items[idx];
//      subJson:= JO;
//      ObjToJson(subObj,subJson);
//      Json.A['Items'].Add(subJson);
//    end;
//  end;
end;


end.
