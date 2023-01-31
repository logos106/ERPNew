unit JsonToBusObj;

interface

uses
  JsonObject, classes;

  procedure BusObjectToJson(Obj: TObject; Json: TJsonObject;
              const ExportSupObjects: boolean = false;
              Exporter: TObject = nil;
              Forcewhenempty:boolean =False);
  function JsonToBusObject(Json: TJsonObject; Obj: TObject; msg: TStrings; InsertIfIdNotfound:boolean =False; IgnoreNonMappedfields :Boolean = False): boolean;

implementation

uses
  TypInfo, Variants, contnrs, sysutils, BusObjBase, BusObjNDSBase,
  IntegerListObj, ExportDataObj, forms;

function TypeKindToUserStr(const aTypeKind: TTypeKind): string;
begin
  case aTypeKind of
    tkUnknown: result:= 'Unknown';
    tkInteger: result:= 'Number';
    tkChar: result:= 'Character';
    tkEnumeration: result:= 'Text';
    tkFloat: result:= 'Number';
    tkString: result:= 'Text';
    tkSet: result:= 'Set';
    tkClass: result:= 'Object';
    tkMethod: result:= 'Unknown';
    tkWChar: result:= 'Character';
    tkLString: result:= 'Text';
    tkWString: result:= 'Text';
    tkUString: result:= 'Text';
    tkVariant: result:= 'Unknown';
    tkArray: result:= 'Array';
    tkRecord: result:= 'Record';
    tkInterface: result:= 'Interface';
    tkInt64: result:= 'Number';
    tkDynArray: result:= 'Dynamic Array';
    else result:= 'Unknown';
  end;
end;


procedure BusObjectToJson(Obj: TObject; Json: TJsonObject;
              const ExportSupObjects: boolean = false;
              Exporter: TObject = nil;Forcewhenempty:boolean =False);
var
  count, idx: integer;
  PropList: PPropList;
  propName: string;
  Val: Variant;
  subObj: TObject;
  subJson: TJsonObject;

  procedure ReadProps(item: TJsonObject; DoProps, DoClasses: boolean; Propnames:TStringlist = nil);
  var
    x: integer;
    PropInfo: PPropInfo;
  begin
    try
      { make sure ID is not first column to avoid problems wit MS Excel
        deciding that it is a SYLK file }
//      PropInfo:= GetPropInfo(obj,'Count');
//      if Assigned(PropInfo) then item.I['Count']:= GetInt64Prop(obj,PropInfo);
//      PropInfo:= GetPropInfo(obj,'ID');
//      if Assigned(PropInfo) then item.I['ID']:= GetInt64Prop(obj,PropInfo);
//      PropInfo:= GetPropInfo(obj,'Active');
//      if Assigned(PropInfo) then item.B['Active']:= GetEnumProp(obj,PropInfo) = 'True';

      for x := 0 to Count -1 do begin

//        Application.ProcessMessages;
        if (Propnames<> nil) and (Propnames.count>0) and (x> Propnames.count-1 ) then break;
        if (Propnames<> nil) and (Propnames.count>0) then PropInfo:= GetPropInfo(Obj,Propnames[x])
        else PropInfo:= GetPropInfo(Obj,String(PropList[x].Name));
        if Assigned(PropInfo) then begin
          if (not Assigned(PropInfo.GetProc))  then
            { this is a write-only property so skip it }
            continue;
        end;

        propName:= String((*PropList[x].*)PropInfo.Name);
        if Obj is TBusObjBase then begin
          if TBusObjBase(Obj).ExportExcludeList.IndexOf(Lowercase(propName)) > -1 then
            continue;
        end;

        case (*PropList[x].*)PropInfo.PropType^.Kind of
          tkEnumeration:
            begin
              if DoProps then begin
                val:= GetPropValue(obj, propName);
                if ((*PropList[x].*)PropInfo.PropType^.Name = 'Boolean') then begin
                  item.B[propName]:= (not VarIsNull(val)) and (Val = 'True');
                end
                else begin
                  if (not VarIsNull(val)) then begin
                    item.S[propName]:= val;
                  end
                  else begin
                    item.S[propName]:= '';
                  end;
                end;
              end;
            end;
          tkInteger : if DoProps then item.I[propName] := GetOrdProp(obj,propName);
          tkInt64 : if DoProps then item.I[propName]:= GetInt64Prop(obj,propName);
          tkFloat :
            begin
              if DoProps then begin
                if ((*PropList[x].*)PropInfo.PropType^.Name = 'TDateTime') then  begin
                  if GetFloatProp(obj,propName) = 0 then
                    item.S[propName]:= ''
                  else
                    item.S[propName]:= FormatDateTime(JsonDateTimeFormat,GetFloatProp(obj,propName));
                end
                else
                  item.F[propName]:= GetFloatProp(obj,propName);
              end;
            end;
          tkChar,
          tkString,
          tkWChar,
          tkLString,
          tkUString,
          tkWString : if DoProps then item.S[propName]:= GetStrProp(obj,propName);
          tkSet,
          tkMethod,
          tkVariant,
          tkArray,
          tkRecord,
          tkInterface,
          tkDynArray,
//          tkClassRef, tkPointer, tkProcedure,
          tkUnknown:
            begin
              if DoProps then begin
                val:= GetPropValue(obj, propName);
                if (not VarIsNull(val)) then begin
                  item.S[propName]:= val;
                end;
              end;
            end;
          tkClass:
            begin
              if DoClasses then begin
                subObj:= GetObjectProp(obj, propName);
                subJson:= JO;
                if Assigned(subObj) then begin
                  BusObjectToJson(subObj,subJson,true);
                end;
                item.O[propName]:= subJson;
              end;
            end;
        end;
      end;

    except
    end;
  end;

begin
  if obj is TBusObjNDSList then begin
    for idx:= 0 to TBusObjNDSList(Obj).Count -1 do begin
      if Assigned(Exporter) and (Exporter is TDataExporter) then begin
        if not TDataExporter(Exporter).Active then break;
        TDataExporter(Exporter).DoProgress('Exporting ...',idx +1,TBusObjNDSList(Obj).Count);
      end;
      BusObjectToJson(
        TBusObjNDSList(Obj).Item[idx],Json.O[TBusObjNDSList(Obj).Item[idx].ClassName + '_' + IntToStr(idx)],ExportSupObjects);
    end;
    exit;
  end
  else if obj is TBusObjNDSTreeChildList then begin
    for idx:= 0 to TBusObjNDSTreeChildList(Obj).Count -1 do begin
      if Assigned(Exporter) and (Exporter is TDataExporter) then begin
        if not TDataExporter(Exporter).Active then break;
        TDataExporter(Exporter).DoProgress('Exporting ...',idx +1,TBusObjNDSTreeChildList(Obj).Count);
      end;
      BusObjectToJson(
        TBusObjNDSTreeChildList(Obj).Item[idx],Json.O[TBusObjNDSTreeChildList(Obj).Item[idx].ClassName + '_' + IntToStr(idx)],ExportSupObjects);
    end;
    exit;
  end;

  Count := GetPropList(obj.ClassInfo, tkProperties, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(obj.ClassInfo, tkProperties, PropList);

    if obj is TDatasetBusObj then begin
      if TDatasetBusObj(obj).Count > 0 then begin
        if (TDatasetBusObj(obj).Count > 1) then begin
          TDatasetBusObj(obj).First;
          while not TDatasetBusObj(obj).EOF do begin
            if Assigned(Exporter) and (not TDataExporter(Exporter).Active) then break;
            idx:= TDatasetBusObj(obj).Dataset.RecNo;
            if Assigned(Exporter) and (Exporter is TDataExporter) then
              TDataExporter(Exporter).DoProgress('Exporting ...',idx +1,TDatasetBusObj(obj).Count);
            ReadProps(Json.O[obj.ClassName + '_' + IntToStr(idx)],true,false , TDatasetBusObj(obj).Propnames);
            if ExportSupObjects then
              ReadProps(Json.O[obj.ClassName + '_' + IntToStr(idx)],false,true,TDatasetBusObj(obj).Propnames );
            TDatasetBusObj(obj).Next;
          end;
        end
        else begin
          { only one record }
          ReadProps(Json.O[obj.ClassName + '_' + IntToStr(TDatasetBusObj(obj).Dataset.RecNo)],true,false, TDatasetBusObj(obj).Propnames);
          if ExportSupObjects then
            ReadProps(Json.O[obj.ClassName + '_' + IntToStr(TDatasetBusObj(obj).Dataset.RecNo)],false,true, TDatasetBusObj(obj).Propnames);
        end;
      end else if Forcewhenempty then begin
         ReadProps(Json.O[obj.ClassName + '_' + IntToStr(TDatasetBusObj(obj).Dataset.RecNo)],true,false, TDatasetBusObj(obj).Propnames);
      end;
    end
    else begin
      ReadProps(Json,true,false);
      if ExportSupObjects then
        ReadProps(Json,false,true);
    end;

  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;
end;

function ObjectName(obj: TObject): string;
begin
  if obj is TBusObjBase then result:= TBusObjBase(obj).ObjectUserName
  else result:= Copy(obj.ClassName,2,255);
end;

function IsStringProp(PropInfo: PPropInfo): boolean;
begin
  result:=
    PropInfo.PropType^.Kind in
      [tkChar, tkEnumeration, tkString, tkWChar, tkUString, tkLString, tkWString, tkUString, tkVariant];
end;

function IsIntProp(PropInfo: PPropInfo): boolean;
begin
  result:= PropInfo.PropType^.Kind in [tkInteger, tkInt64];
end;

function IsFloatProp(PropInfo: PPropInfo): boolean;
begin
  result:= PropInfo.PropType^.Kind in [tkFloat];
end;

function JsonToBusObject(Json: TJsonObject; Obj: TObject; msg: TStrings; InsertIfIdNotfound:boolean =False; IgnoreNonMappedfields :Boolean = False): boolean;
var
  id: integer;
  newId: integer;
  x: integer;
//  msgIdx: integer;
  PropInfo: PPropInfo;
  Item: TJsonValuePair;
  subObj: TObject;
  dsObj: TDatasetBusObj;
  subIdx: integer;
  subIDList: TIntegerList;
  subJson: TJsonObject;

  function ObjectId(aObject: TObject): integer;
  var PInfo: PPropInfo;
  begin
    result:= 0;
    PInfo:= GetPropInfo(aObject,'ID');
    if Assigned(PInfo) then result:= GetInt64Prop(aObject,PInfo);
  end;

begin
  result:= true;
  try
    if Obj is TBusObjBase then begin
      id:= ObjectId(Obj);
      if Json.IntegerExists('id') then newId:= Json.I['id']
      else newId:= 0;

      if (id <> newId) or (id=0) then begin
        TBusObjBase(Obj).Load(newId);
        if (newId > 0) and (Obj is TDatasetBusObj) and (TDatasetBusObj(obj).Count = 0) and (not(InsertIfIdNotfound)) then begin
          result:= false;
          msg.Add('Could not find existing record to update for ID ' + IntToStr(newID));
          exit;
        end;
      end;
      if (newId = 0) or (TDatasetBusObj(obj).Count = 0) then begin

        if InsertIfIdNotfound and (TDatasetBusObj(obj).Count = 0) and (newId<>0) then
          TDatasetBusObj(Obj).ExportExcludeList.Delete(TDatasetBusObj(Obj).ExportExcludeList.indexof(TDatasetBusObj(Obj).GetKeyStringField));

        TBusObjBase(Obj).New;
        TBusObjBase(Obj).OnAfterJsonToBusObjectNew;

      end;
    (*      if (newId > 0) then begin
        if (id <> newId) then
          TBusObjBase(Obj).Load(newId);
      end
      else
        TBusObjBase(Obj).New;*)
      TBusObjBase(Obj).ResultStatus.Clear;
    end;
    for x:= 0 to Json.Count -1 do begin
      Item:= Json.Items[x];
      if Obj is TBusObjBase then begin
        if TBusObjBase(Obj).ExportExcludeList.IndexOf(Lowercase(Item.Name)) > -1 then begin
          continue;
        end;
      end;

      PropInfo:= GetPropInfo(Obj,Item.Name);
      if Assigned(PropInfo) then begin
        if (PropInfo.PropType^.Kind <> tkClass) and (not Assigned(PropInfo.SetProc))  then
          { this is a read-only property so skip it }
          continue;
      end
      else begin
        { property not found! }
        if IgnoreNonMappedfields then continue;
        result:= false;
        msg.Add(ObjectName(Obj) + ' - import data property "' + Item.Name +
          '" not found.');
        exit;
      end;

      try
        case Item.ValueType of
          JSONObject.valNone: ;
          JSONObject.valString:
            begin
              if IsStringProp(PropInfo) then
                SetStrProp(Obj,PropInfo,Item.Value.AsString)
              else if PropInfo.PropType^.Name = 'TDateTime' then begin
                SetFloatProp(Obj,PropInfo,Item.Value.AsDateTime);
              end
              else if IsIntProp(PropInfo) then begin
                SetOrdProp(Obj,PropInfo,Item.Value.AsInteger)
              end
              else if IsFloatProp(PropInfo) then begin
                {  need to check for currency symbols }
                SetFloatProp(Obj,PropInfo,StrToFloat(StringReplace(Item.Value.AsString,FormatSettings.CurrencyString,'',[])));
              end
              else begin
                result:= false;
                msg.Add(ObjectName(Obj) + ' - import data type mismatch for property "' +
                  Item.Name + '", data is Text but object needs ' +
                  TypeKindToUserStr(PropInfo.PropType^.Kind) + '.');
                exit;
              end;
            end;
          JSONObject.valNumber:
            begin
              if IsIntProp(PropInfo) then begin
                if Frac(Item.Value.AsFloat) = 0 then
                  SetOrdProp(Obj,PropInfo,Item.Value.AsInteger)
                else begin
                  result:= false;
                  msg.Add(ObjectName(Obj) + ' - import data type mismatch for property "' +
                    Item.Name + '", data contains a Number with a fractional part but object needs ' +
                    'a non fractional Number.');
                  exit;
                end;
              end
              else if IsFloatProp(PropInfo) then
                SetFloatProp(Obj,PropInfo,Item.Value.AsFloat)
              else if IsStringProp(PropInfo) then begin
                try
                  SetStrProp(Obj,PropInfo,Item.Value.AsString);
                except
                  msg.Add(ObjectName(Obj) + ' - import data type mismatch for property "' +
                    Item.Name + '", data contains a Number and an error occured converting this to the expected data type Text.');
                  exit;
                end;
              end
              else begin
                msg.Add(ObjectName(Obj) + ' - import data type mismatch for property "' +
                  Item.Name + '", data contains a Number but different type expected.');
                exit;
              end;
            end;
          JSONObject.valArray: ;
          JSONObject.valNull: ;
          JSONObject.valBoolean:
            begin
              if (PropInfo.PropType^.Name = 'Boolean') then begin
                if Item.Value.AsBoolean then SetEnumProp(Obj,PropInfo,'True')
                else SetEnumProp(Obj,PropInfo,'False');
              end
              else begin
                result:= false;
                msg.Add(ObjectName(Obj) + ' - import data type mismatch for property "' +
                  Item.Name + '", data contains boolean value (true/false) but object needs ' +
                  TypeKindToUserStr(PropInfo.PropType^.Kind) + '.');
                exit;
              end;
            end;
          JSONObject.valObject:
            begin
              subJson:= Item.Value.AsObject;
              if (PropInfo.PropType^.Kind = tkClass) then begin
                subObj:= TypInfo.GetObjectProp(Obj,PropInfo);
                if Assigned(subObj) then begin
                  if subObj is TDatasetBusObj then begin
                    dsObj:= TDatasetBusObj(subObj);
                    subIDList:= TIntegerList.Create;
                    try
                      { load sub objects }
                      for subIdx:= 0 to subJson.Count -1 do begin
                        if subJson.Items[subIdx].Value.ValueType = JSONObject.valObject then begin
                          if subJson.Items[subIdx].Value.AsObject.I['id'] > 0 then begin
                            if not dsObj.LocateId(subJson.Items[subIdx].Value.AsObject.I['id']) then begin
                              result:= false;
                              msg.Add(ObjectName(subObj) + ' - import failed ' +
                                ', could not update existing record, id "' +
                                IntToStr(subJson.Items[subIdx].Value.AsObject.I['id']) + '".');
                              exit;
                            end;
                          end;
                          if not JsonToBusObject(subJson.Items[subIdx].Value.AsObject,dsObj,msg) then begin
                            result:= false;
                            exit;
                          end;
                          dsObj.PostDB;
                          subIdList.Add(dsObj.ID);
                        end
                        else begin
                          { not an object property }


                        end;
                      end;
                      { now delete }
                      dsObj.First;
                      while not dsObj.EOF do begin
                        if subIdList.InList(dsObj.ID) then dsObj.Next
                        else begin
                          if not dsObj.Delete then begin
                            result:= false;
                            msg.Add(ObjectName(subObj) + ' - import failed ' +
                              ', could not delete existing record, id "' +
                              IntToStr(dsObj.id) + '".');
                            exit;
                          end;
                        end;
                      end;
                    finally
                      subIdList.Free;
                    end;
                  end;
                end
                else begin
                  result:= false;
                  msg.Add(ObjectName(Obj) + ' - import of child object "' +
                    Item.Name + '", failed, unable to get an instance of child object.');
                  exit;
                end;
              end
              else begin
                result:= false;
                msg.Add(ObjectName(Obj) + ' - import data type mismatch for property "' +
                  Item.Name + '", data contains a child object but object needs ' +
                  TypeKindToUserStr(PropInfo.PropType^.Kind) + '.');
                exit;
              end;
            end;
        end;
      except
        on e: exception do begin
          result:= false;
          msg.Add(ObjectName(Obj) + ' - error while setting property data for "' +
            Item.Name + '", with message: ' + e.Message);
          exit;
        end;
      end;
    end;
    if Obj is TBusObjBase then begin
      if TBusObjBase(Obj).ResultStatus.HasAnyMessage then begin
        //TBusObjBase(Obj).ResultStatus.Messages
        TBusObjBase(Obj).ResultStatus.ReadMessages(msg);
      end;
      if not TBusObjBase(Obj).ResultStatus.OperationOk then begin
        result:= false;
        exit;
      end;
    end;
  except
    on e: exception do begin
      result:= false;
      msg.Add(ObjectName(Obj) + ' - import data failed with exception: ' + e.Message);
      exit;
    end;
  end;
end;

end.
