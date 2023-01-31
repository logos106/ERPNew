unit HttpRequestProcessor;

interface

uses
  JsonObject, LogThreadBase;

procedure DoHTTPRequest(JsonReq, JsonResp: TJsonObject; Logger: TLoggerBase);

implementation

uses
  types, classes, MyAccess, BusobjBase, ObjectSerialiser, db, sysutils,
  ModuleConst, AppEnvironment, LogMessageTypes, strutils, AppEnvironmentPool,
  CommonDbLib, ActiveX, windows, ModuleUtils, Character, WebApiConst, typinfo,
  ObjBasicInfoObj;

const
  DefaultServer = 'localhost';


function GetModuleNameStr: string;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  FillChar(szFileName, SizeOf(szFileName), #0);
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;


procedure FormatJson(strings: TStrings);
var
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
  ident:= 0;
  for x:= 0 to strings.Count-1 do begin
    if (Pos('}',strings[x]) = 1) and (ident > 0) then
      dec(ident);
    isObj:= Pos('{',strings[x]) = 1;
    strings[x]:= PadStr + strings[x];
    if IsObj then Inc(ident);
  end;
end;

function UnQuoteStr(const Value: string): string;
begin
  result := Value;
  if ((copy(result,1,1) = '''') and (copy(result,Length(result),1) = '''')) or
     ((copy(result,1,1) = '"') and (copy(result,Length(result),1) = '"')) then begin
     result := copy(result , 2, Length(result)-2);
  end;
end;

function IsQuotedStr(const Value: string): boolean;
begin
  result := false;
  if ((copy(Value,1,1) = '''') and (copy(Value,Length(Value),1) = '''')) or
     ((copy(Value,1,1) = '"') and (copy(Value,Length(Value),1) = '"')) then begin
     result := true;
  end;
end;

function RemoveCRLF(inStr: string): string;
var
  sl: TStringList;
  x: integer;
begin
  result:= '';
  sl:= TStringList.Create;
  try
    sl.Text:= Trim(inStr);
    for x := 0 to sl.Count-1 do begin
      if x > 0 then result:= result + ' ';
      result:= result + sl[x];
    end;
  finally
    sl.Free;
  end;
end;


function MakeErrorMessage(msg: string): string;
begin
  result := msg;
  if Pos('Error',result) = 1 then exit;
  if Pos('Warning',result) = 1 then
    result := 'Error' + Copy(result,8,Length(result))
  else
    result := 'Error: ' + msg;
end;

{ The JSON data posted to the server may have created sub objects
  (eg TLead.MarketingContact) that are not created by the form, so these need
  to be saved (which calls validate) here }
function SaveBusObj(obj: TDatasetBusObj; var msg: string): boolean;
var
  Count: integer;
  PropList: PPropList;
  x: integer;
  subObj: TObject;
begin
  { find sub objects }
  Count := GetPropList(obj.ClassInfo, tkProperties, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(obj.ClassInfo, tkProperties, PropList);
    for x := 0 to Count -1 do begin
      case PropList[x].PropType^.Kind of
        tkClass:
          begin
            subObj:= GetObjectProp(obj, string(PropList[x].Name));
            if Assigned(subObj) and (subObj is TDatasetBusObj) and (TDatasetBusObj(subObj).Count =1) and (TDatasetBusObj(subObj).isreadonly = False) then begin
              { only interested in single record objects as these are more
                likly to be sub or reference business objects as opposed
                to lines type objects (which should be validated/saved by parent). }
              result:= SaveBusObj(TDatasetBusObj(subObj), msg);
              if not result then
                exit;

            end;
          end;
      end;
    end;
  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;
  result:= obj.Save;
  if not result then
    msg:= RemoveCRLF(obj.ResultStatus.Messages);
end;



function StrToKeyString(InStr: string; var OutStr: string): boolean;
begin
  result:= IsQuotedStr(InStr);
  if result then OutStr := UnQuoteStr(InStr)
  else OutStr := '';
end;

function GetObjectList(ResourceName: string; aList: TStringList; var msg: string; Logger: TLoggerBase; AddToList: boolean = true): boolean;
var
  ResourceClass: TPersistentClass;
  Resource: TPersistent;
  s: string;
  json: TJsonObject;
  x: integer;
  count: integer;
  PropList: PPropList;
  PropInfo: PPropInfo;
begin
  result:= true;
  ResourceClass:= GetClass(ResourceName);
  if Assigned(ResourceClass) then begin
    if aList.IndexOf(ResourceName) < 0 then begin
      if AddToList then
        aList.Add(ResourceName);
    end
    else
      exit;
    if ResourceClass.InheritsFrom(TBusObjBase) then begin
      s:= '';
      try
        Resource:=  TBusObjBaseClass(ResourceClass).Create(nil);
      except
        on e: exception do begin
          result:= false;
          msg := e.Message;
          exit;
        end;
      end;
      try
        s := TBusObjBase(Resource)._Schema;

        if (s <> '') then begin
          json:= JO;
          try
            json.AsString := s;
            for x := 0 to json.A['RefTypes'].Count -1 do begin
              if not GetObjectList(json.A['RefTypes'].Items[x].AsObject.S['Type'],aList,msg, Logger) then begin
                result:= false;
                exit;
              end;
            end;
          finally
            json.Free;
          end;
        end;

        { now get non-lookup sub objects eg invoice lines }
        Count := GetPropList(Resource.ClassInfo, tkProperties, nil);
        GetMem(PropList, Count * SizeOf(PPropInfo));
        try
          GetPropList(Resource.ClassInfo, tkProperties, PropList);
          for x := 0 to Count -1 do begin
            try
              PropInfo:= GetPropInfo(Resource,String(PropList[x].Name));
              if PropList[x].PropType^.Kind = tkClass then begin
                if not GetObjectList(GetObjectPropClass(PropInfo).ClassName,aList,msg,Logger,false) then begin
                  result:= false;
                  exit;
                end;
              end;
            except
              on e: exception do begin

              end;
            end;
          end;
        finally
          FreeMem(PropList, Count * SizeOf(PPropInfo));
        end;

      finally
        Resource.Free;
      end;

    end;
  end
  else begin
    { ignore things like TStringList  }
  end;
end;

procedure DoHTTPRequest(JsonReq, JsonResp: TJsonObject; Logger: TLoggerBase);
var
  ResourceName: string;
  ResourceClassName: string;
  ResourceClass: TPersistentClass;
  Resource: TPersistent;
  DsBusObj: TDatasetBusObj;
  DbConn: TMyConnection;
  ObjID: integer;
  JSONSerialiser: TJSONSerialiser;
  JSONDesrialiser: TJSONDeserialiser;
//  sl: TStringList;
  Obj: TObject;
  msg: string;
  ObjList: TStringList;
  y: integer;
  MultiLogon: boolean;
  KeyValue, GlobalRef: string;
  msTimeStamp: TDateTime;
  StartTime: TDateTime;
  FieldSL, ValSL: TStringList;
  FieldCount: integer;
  FieldSQL: string;
  fDatabase, fUserName, fPassword: string;

  procedure ListDb(json: TJsonObject);
  var
    qry: TMyQuery;
    JsonArray: TJsonArray;
    ArrayItem: TJsonObject;
    x: integer;
    WherePos: integer;
    LimitFrom, LimitCount: integer;
    field: TField;
    sl: TStringList;
    y: integer;
    s: string;
    PropList: TStringList;
    KeyValList: TStringList;
    PropInfo: PPropInfo;
    select: string;

  begin
    JsonArray:= Json.A[ResourceName];
    if JsonReq.Exists('Params') and JsonReq.O['Params'].Exists('FieldList') then begin
      WherePos:= Pos('where',Lowercase(DsBusObj.SQL));
      qry := TMyQuery.Create(nil);
      try
        qry.Connection:= DbConn;
        qry.SQL.Add('select ' + JsonReq.O['Params'].S['FieldList']);
        qry.SQL.Add('from ' + DsBusObj.BusObjectTableName);
        if WherePos > 0 then
          qry.SQL.Add(Copy(DsBusObj.SQL,WherePos,Length(DsBusObj.SQL)));
        LimitFrom:= -1;
        LimitCount:= -1;
        if JsonReq.Exists('Params') then begin
          if JsonReq.O['Params'].Exists('LimitFrom') then
            LimitFrom:= StrToInt(JsonReq.O['Params'].S['LimitFrom']);
          if JsonReq.O['Params'].Exists('LimitCount') then
            LimitCount:= StrToInt(JsonReq.O['Params'].S['LimitCount']);
        end;
        if LimitFrom > -1 then
          qry.SQL.Add('LIMIT ' + IntToStr(LimitFrom)+ ',' + IntToStr(LimitCount))
        else if LimitCount > -1 then
          qry.SQL.Add('LIMIT ' + IntToStr(LimitCount));

        qry.Open;

        while not qry.Eof do begin
          ArrayItem:= TJsonObject.Create;
          field:= qry.FindField(DsBusObj.IDFieldName);
          if Assigned(field) then begin
            ArrayItem.I['ID']:= field.AsInteger;
          end;
          field:= qry.FindField('mstimestamp');
          if Assigned(field) then
            ArrayItem.S['msTimeStamp']:= FormatDateTime(JsonDateTimeFormat, field.AsDateTime);
          field:= qry.FindField('msupdatesitecode');
          if Assigned(field) then
            ArrayItem.S['msUpdateSiteCode']:= field.AsString;
          for x:= 0 to qry.FieldCount -1 do begin
            if (Lowercase(qry.Fields[x].FieldName) <> 'mstimestamp') and
               (Lowercase(qry.Fields[x].FieldName) <> Lowercase(DsBusObj.IDFieldName)) then begin
              case qry.Fields[x].DataType of
                ftString, ftFixedChar, ftWideString, ftWideMemo, ftFixedWideChar:
                  ArrayItem.S[qry.Fields[x].FieldName] := qry.Fields[x].AsString;

                ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeint, ftLongWord,
                ftShortint, ftByte, DB.ftSingle:
                  ArrayItem.I[qry.Fields[x].FieldName] := qry.Fields[x].AsInteger;

                DB.ftFloat, DB.ftCurrency, DB.ftExtended:
                  ArrayItem.F[qry.Fields[x].FieldName] := qry.Fields[x].AsFloat;

                ftDate, ftTime, ftDateTime:
                  ArrayItem.DT[qry.Fields[x].FieldName] := qry.Fields[x].AsDateTime;

                ftUnknown, ftBoolean, ftBytes,
                ftVarBytes, ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor,
                ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftADT, ftArray, ftReference,
                ftDataSet, ftOraBlob, ftOraClob, ftVariant, ftInterface,
                ftIDispatch, ftGuid, ftTimeStamp, ftFMTBcd,
                ftOraTimeStamp, ftOraInterval, ftConnection, ftParams,
                ftStream, ftTimeStampOffset, ftObject, ftBCD: ;

              end;
            end;
          end;
          JsonArray.Add(ArrayItem);
          qry.Next;
        end;
      finally
        qry.Free;
      end;
      exit;
    end;

    PropList := TStringList.Create;
    KeyValList := TStringList.Create;
    try
      { get a list of properties to send back }
      PropList.CommaText := 'Id,MsTimeStamp,MsUpdateSiteCode,GlobalRef';
      if JsonReq.Exists('Params') and JsonReq.O['Params'].Exists('PropertyList') then begin
        sl:= TStringList.Create;
        try
          sl.CommaText := JsonReq.O['Params'].S['PropertyList'];
          for x := 0 to SL.Count -1 do
            PropList.Add(sl[x]);
        finally
          sl.Free;
        end;
      end;

      { limits on number of records ? }
      LimitFrom:= -1;
      LimitCount:= -1;
      if JsonReq.Exists('Params') then begin
        if JsonReq.O['Params'].Exists('LimitFrom') then
          LimitFrom:= StrToInt(JsonReq.O['Params'].S['LimitFrom']);
        if JsonReq.O['Params'].Exists('LimitCount') then
          LimitCount:= StrToInt(JsonReq.O['Params'].S['LimitCount']);
      end;
      if LimitFrom > -1 then
        DsBusObj.LimitFrom := LimitFrom;
      if LimitCount > -1 then
        DsBusObj.LimitCount := LimitCount;

      DsBusObj.Load(true);
      DsBusObj.First;

      { remove any properties we dont have }
      x := 0;
      while x < PropList.Count do begin
        PropInfo := GetPropInfo(DsBusObj,PropList[x]);
        if Assigned(PropInfo) and Assigned(PropInfo.GetProc) then
          Inc(x)
        else
          PropList.Delete(x);
      end;

      select := '';
      if JsonReq.O['params'].StringExists('select') then
        select := JsonReq.O['params'].S['select'];

      { now output data .. }
      while not DsBusObj.EOF do begin
        if select <> '' then begin
          if not DsBusObj.Parse(select) then begin
            DsBusObj.Next;
            Continue;
          end;
        end;

        ArrayItem:= TJsonObject.Create;
        for x := 0 to PropList.Count -1 do begin
          PropInfo := GetPropInfo(DsBusObj,PropList[x]);

          case PropInfo.PropType^.Kind of
            TTypeKind.tkInteger,
            TTypeKind.tkInt64:
              ArrayItem.I[PropList[x]] :=GetInt64Prop(DsBusObj,PropInfo);
            TTypeKind.tkFloat:
              begin
                if (CompareText(string(PropInfo^.PropType^.Name),'TDateTime') = 0) then  begin
                  if (GetFloatProp(DsBusObj,PropInfo) = 0) then
                    ArrayItem.S[PropList[x]] := ''
                  else
                    ArrayItem.DT[PropList[x]] :=  GetFloatProp(DsBusObj,PropInfo);
                end
                else
                  ArrayItem.F[PropList[x]] :=  GetFloatProp(DsBusObj,PropInfo);
              end;
            TTypeKind.tkChar,
            TTypeKind.tkWChar,
            TTypeKind.tkString,
            TTypeKind.tkLString,
            TTypeKind.tkWString,
            TTypeKind.tkUString:
              ArrayItem.S[PropList[x]] :=  GetStrProp(DsbusObj,PropInfo);
            TTypeKind.tkEnumeration:
              if (CompareText('Boolean', string(PropInfo^.PropType^.Name)) = 0) then
                ArrayItem.B[PropList[x]] := SameText(GetEnumProp(DsBusObj,PropInfo),'True')
              else
                ArrayItem.S[PropList[x]] := GetEnumProp(DsBusObj,PropInfo);
            TTypeKind.tkDynArray,
            TTypeKind.tkArray,
            TTypeKind.tkClass,
            TTypeKind.tkRecord,
            TTypeKind.tkPointer,
            TTypeKind.tkSet,
            TTypeKind.tkMethod,
            TTypeKind.tkVariant,
            TTypeKind.tkInterface,
            TTypeKind.tkClassRef,
            TTypeKind.tkProcedure:;
          end;

        end;

        KeyValList.CommaText := DsBusObj.KeyValue;
        if KeyValList.Count > 0 then begin
          if KeyValList.Count = 1 then
            ArrayItem.S['KeyValue'] := DsBusObj.KeyValue
          else begin
            for y := 0 to KeyValList.Count -1 do begin
              if y = 0 then s := '"' + KeyValList[y] + '"'
              else s := s + ',"' + KeyValList[y] + '"';
            end;
            ArrayItem.S['KeyValue'] := s;
          end;
        end;

        JsonArray.Add(ArrayItem);
        DsBusObj.Next;
      end;
    finally
      PropList.Free;
      KeyValList.Free;
    end;

  end;

begin
  StartTime:= now;
  Resource:= nil;
  try
//    Logger.Log('---------------------------------------------',ltDetail);
    Logger.Log('',ltDetail);
    Logger.Log('Processing HTTP Request',ltDetail);
    try
      ResourceName:= JsonReq.A['URIParts'].Items[2].AsString;
      ResourceClassName:= {'T' +} ResourceName;
      ResourceClass:= GetClass(ResourceClassName);
      Logger.Log('Resourse Name: ' + ResourceName,ltDetail);
      fDatabase := JsonReq.S['ERPDatabase'];
      fUserName := JsonReq.S['ERPUserName'];
      fPassword := JsonReq.S['ERPPassword'];
      if ResourceName = 'about' then begin
        JsonResp.S['ContentType']:= 'text/plain';
        JsonResp.I['ResponseNo']:= 200; { "OK" }
        JsonResp.O['JsonOut'].S['Name']:= 'ERP Web API Server';
        JsonResp.O['JsonOut'].S['Module']:= ExtractFileName(GetModuleNameStr);
        JsonResp.O['JsonOut'].S['Version']:= ModuleUtils.GetFileVersion(GetModuleNameStr);
        exit;
      end;
      if not Assigned(ResourceClass) then begin
        Logger.Log('Resourse not found.',ltError);
        JsonResp.I['ResponseNo']:= 404; { "Not Found" }
        JsonResp.S['ErrorMessage']:= 'Could not find the requested resource "' + ResourceName + '"';
        exit;
      end;
      if JsonReq.S['ERPDatabase'] = '' then begin
        Logger.Log('No Databse Name specified',ltError);
        JsonResp.I['ResponseNo']:= 406; { "Not Acceptable" }
        JsonResp.S['ErrorMessage']:= 'No ERP Database specified';
        exit;
      end;
      if JsonReq.S['ERPUserName'] = '' then begin
        Logger.Log('No User Name specified.',ltError);
        JsonResp.I['ResponseNo']:= 406; { "Not Acceptable" }
        JsonResp.S['ErrorMessage']:= 'No ERP User Name specified';
        exit;
      end;
      if JsonReq.S['ERPPassword'] = '' then begin
        Logger.Log('No User Password specified',ltError);
        JsonResp.I['ResponseNo']:= 406; { "Not Acceptable" }
        JsonResp.S['ErrorMessage']:= 'No ERP User Password specified';
        exit;
      end;

      case AppEnvPool.GetAppEnv(JsonReq.S['ERPDatabase'], JsonReq.S['ERPUserName'], JsonReq.S['ERPPassword'], Logger) of
        aeprOk:;
        aeprFail:
          begin
            Logger.Log('Failed to obtain a database connection.',ltError);
            JsonResp.I['ResponseNo']:= 503; { "Service Unavaiable" }
            JsonResp.S['ErrorMessage']:= 'Failed to obtain a database connection';
            exit;
          end;
        aeprMaxExceeded:
          begin
            Logger.Log('Server maximum number of database connections exceeded.',ltError);
            JsonResp.I['ResponseNo']:= 503; { "Service Unavaiable" }
            JsonResp.S['ErrorMessage']:= 'Server maximum number of database connections exceeded';
            exit;
          end;
        aeprInactive:
          begin
            Logger.Log('Server database connection inactive.',ltError);
            JsonResp.I['ResponseNo']:= 503; { "Service Unavaiable" }
            JsonResp.S['ErrorMessage']:= 'Server database connection inactive';
            exit;
          end;
      end;

      try
//        Logger.Log('Thread ID get: '+ IntToStr(GetCurrentThreadID), ltInfo);
        AppEnv.AppDb.Server:= DefaultServer;

        AppEnv.AppDb.Database:= JsonReq.S['ERPDatabase'];
        if not AppEnv.AppDb.VersionOk then begin
          Logger.Log('Server and database versions do not match.',ltError);
          JsonResp.I['ResponseNo']:= 500; { "Internal Server Error" }
          JsonResp.S['ErrorMessage']:= 'Error: Server and database versions do not match';
          exit;
        end;
        Logger.Log('Useing Database Server: ' + AppEnv.AppDb.Server + ' Database: ' + AppEnv.AppDb.Database, ltDetail);

        try
          AppEnv.AppDb.ConnectUser(JsonReq.S['ERPUserName'], JsonReq.S['ERPPassword']);
        except
          on eusr: exception do begin
            Logger.Log('Error: ' + eusr.Message + ' ThreadID = ' + IntToStr(GetCurrentThreadID),ltError);
            JsonResp.I['ResponseNo']:= 403; { "Forbidden" }
            JsonResp.S['ErrorMessage']:= 'Forbidden: ' + RemoveCRLF(eusr.Message);
            exit;
          end;
        end;
        if not AppEnv.AppDb.Connection.Connected then  begin
          Logger.Log('Could not connect to ERP.',ltError);
          JsonResp.I['ResponseNo']:= 403; { "Forbidden" }
          JsonResp.S['ErrorMessage']:= 'Forbidden: Could not connect to ERP';
          exit;
        end;

        MultiLogon:= Lowercase(JsonReq.S['ERPUserName']) = Lowercase(JsonReq.S['ERPWebUserName']);
        if not AppEnv.UtilsClient.ConnectUser(msg,DefaultServer,AppEnv.AppDb.Database,JsonReq.S['ERPUserName'],'','',MultiLogon) then begin
          Logger.Log('Could not connect to ERP. ' + RemoveCRLF(msg),ltError);
          JsonResp.I['ResponseNo']:= 403; { "Forbidden" }
          JsonResp.S['ErrorMessage']:= 'Forbidden: Could not connect to ERP. ' + RemoveCRLF(msg);
          exit;
        end;
        try
          DbConn:= CommonDbLib.GetNewMyDacConnection(nil);
          AppEnv.UtilsClient.Logger := Logger;
          CoInitialize(nil);
          try
            if JsonReq.S['Command'] = 'GET' then begin
//              if SysUtils.SameText(ResourceClassName,'TAppointmentStatusType') then
//                Logger.Log('');
              if ResourceClass.ClassName = TObjBasicInfoClass.ClassName then
                Resource := TObjBasicInfoClass(ResourceClass).Create(JsonReq.O['Params'].S['ClassName'],JsonReq.O['Params'].I['ID'])
              else if ResourceClass.InheritsFrom(TDatasetBusObj) then begin
                Resource:= TDatasetBusObjClass(ResourceClass).Create(nil);
              end
              else
                Resource:= ResourceClass.Create;
              DsBusObj:= nil;
              if Resource is TDatasetBusObj then begin
                DsBusObj:= TDatasetBusObj(Resource);
                DsBusObj.Connection:= TMyDacDataConnection.Create(DsBusObj);
                DsBusObj.Connection.MyDacConnection:= DbConn;
              end
              else if Resource is TPersistent then begin
                JSONSerialiser:= TJSONSerialiser.Create;
                try
                  Logger.Log('GET - Object: ' + Resource.ClassName + ' ok.',ltDetail);
                  JsonResp.O['JsonOut']:= JSONSerialiser.SerialiseObject(Resource);
                  JsonResp.I['ResponseNo']:= 200; { "OK" }
                finally
                  JSONSerialiser.Free;
                end;
                exit;
              end
              else begin
                { differnt sort of object }
                Logger.Log('Unsupported class of object.',ltError);
                JsonResp.I['ResponseNo']:= 404; { "Not Found" }
                JsonResp.S['ErrorMessage']:= 'Unsupported class of object';
                exit;
              end;
              GlobalRef:= '';
              KeyValue:= '';
              if JsonReq.Exists('Params') then begin
                if JsonReq.O['Params'].StringExists('GlobalRef') then
                  GlobalRef:= JsonReq.O['Params'].S['GlobalRef']
                else if JsonReq.O['Params'].StringExists('KeyValue') then
                  KeyValue:= SysUtils.AnsiDequotedStr(JsonReq.O['Params'].S['KeyValue'],'"');
//                  KeyValue:= UnQuoteStr(JsonReq.O['Params'].S['KeyValue']);
             end;

              if (JsonReq.A['URIParts'].Count > 3) and (SameText(JsonReq.A['URIParts'].Items[3].AsString,'Schema')) then begin
                if resource is TBusObjBase then begin
                  Logger.Log('GET Schema for ' + Resource.ClassName + ' ok.',ltDetail);
                  JsonResp.O['JsonOut'].AsString:= TBusObjBase(Resource)._Schema;
                  JsonResp.I['ResponseNo']:= 200; { "OK" }
                end
                else begin
                  Logger.Log('GET Schema for ' + Resource.ClassName + ' not found.',ltError);
                  JsonResp.I['ResponseNo']:= 404; { "Not Found" }
                  JsonResp.S['ErrorMessage']:= 'Not Found';
                end;
              end
              else if (JsonReq.A['URIParts'].Count > 3) and (SameText(JsonReq.A['URIParts'].Items[3].AsString,'ObjectList')) then begin
                Logger.Log('GET ObjectList for ' + Resource.ClassName + '.',ltDetail);
                ObjList:= TStringList.Create;
                try
                  ObjList.CaseSensitive := false;
                  if GetObjectList(ResourceName,ObjList,msg,Logger) then begin
                    with TJsonObject.Create do begin
                      try
                        for y := ObjList.Count -1 downto 0 do
                          A['List'].Add(ObjList[y]);
                        JsonResp.O['JsonOut'].AsString:= AsString;
                        JsonResp.I['ResponseNo']:= 200; { "OK" }
                      finally
                        Free;
                      end;
                    end;
                  end
                  else begin
                    JsonResp.I['ResponseNo']:= 404; { "Not Found" }
                    JsonResp.S['ErrorMessage']:= msg;
                  end;
                finally
                  ObjList.Free;
                end;
              end
              { get a list or single object instance }
              else if (JsonReq.A['URIParts'].Count > 3) or (GlobalRef <> '') or (KeyValue <> '') then begin
                if AppEnv.ThreadId <> GetCurrentThreadID then
                  Logger.Log('Threads do not match!', ltError);
                if ((GlobalRef <> '') or (KeyValue <> '') or TryStrToInt(JsonReq.A['URIParts'].Items[3].AsString,ObjID) or
                  StrToKeyString(JsonReq.A['URIParts'].Items[3].AsString,KeyValue)) then begin
                  { specific instance }
                  if (not Assigned(DsBusObj)) or
                     (Assigned(DsBusObj) and
                     ((ObjID > 0) or (KeyValue <> '') or (GlobalRef <> ''))) then begin

                    JSONSerialiser:= TJSONSerialiser.Create;
                    try
                      try
                        if Assigned(DsBusObj) then begin
                          if (ObjID > 0) then
                            DsBusObj.Load(ObjID)
                          else if (GlobalRef <> '') then
                            DsBusObj.Load(GlobalRef)
                          else begin
                            if DsBusObj.GetKeyStringField <> '' then begin
                              FieldSL:= TStringList.Create;
                              ValSL:= TStringList.Create;
                              try
                                FieldSQL:= '';
                                FieldSL.CommaText:= DsBusObj.GetKeyStringField;
                                if FieldSL.Count = 1 then
                                  FieldSQL:= '`' + FieldSL[0] + '` = ' + QuotedStr(StringReplace(KeyValue,'\','\\',[rfReplaceAll]))
                                else begin
                                  ValSL.CommaText:= KeyValue;
                                  if ValSL.Count <> FieldSL.Count then begin
                                    Logger.Log('GET - Key Value list count ('+IntToStr(ValSL.Count)+') does not match Key Property list count ('+IntToStr(FieldSL.Count)+') for ' + DsBusObj.ClassName,ltError);
                                    JsonResp.I['ResponseNo']:= 406; { "Not Acceptable" }
                                    JsonResp.S['ErrorMessage']:= 'Error: Key Value list count ('+IntToStr(ValSL.Count)+') does not match Key Property list count ('+IntToStr(FieldSL.Count)+') for ' + DsBusObj.ClassName;
                                    exit;
                                  end;
                                  for FieldCount := 0 to FieldSL.Count -1 do begin
                                    if ValSL[FieldCount] <> '' then begin
                                      if FieldSQL <> '' then FieldSQL:= FieldSQL + ' and ';
                                      FieldSQL:= FieldSQL + '`' + FieldSL[FieldCount] + '` = ' + QuotedStr(StringReplace(ValSL[FieldCount],'\','\\',[rfReplaceAll]));
                                    end;
                                  end;
                                end;
                              finally
                                FieldSL.Free;
                                ValSL.Free;
                              end;
                              DsBusObj.LoadSelect(FieldSQL);
//                              DsBusObj.LoadSelect(DsBusObj.GetKeyStringField + ' = ' + QuotedStr(KeyStringProperty));
                            end
                            else begin
                              Logger.Log('GET - KeyStringField not defined for ' + DsBusObj.ClassName,ltError);
                              JsonResp.I['ResponseNo']:= 500; { "Internal Server Error" }
                              JsonResp.S['ErrorMessage']:= 'Error: KeyStringField not defined for ' + DsBusObj.ClassName;
                              exit;
                            end;
                          end;
                          if DsBusObj.Count = 0 then begin
                            if (ObjID > 0) then
                              JsonResp.S['ErrorMessage']:= 'Instance not found for object "' + DsBusObj.ClassName +
                                '" and ID ' + IntToStr(ObjID)
                            else if (GlobalRef <> '') then
                              JsonResp.S['ErrorMessage']:= 'Instance not found for object "' + DsBusObj.ClassName +
                                '" and GlobalRef "' + GlobalRef + '"'
                            else
                              JsonResp.S['ErrorMessage']:= 'Instance not found for object "' + DsBusObj.ClassName +
                                '" and Key Value "' + KeyValue + '"';

                            Logger.Log('GET - Instance not found for object "' + DsBusObj.ClassName +
                              '" Key Value ("' + KeyValue + '") ID (' + IntToStr(ObjID) + ') GlobalRef (' + GlobalRef + ').',ltError);
                            JsonResp.I['ResponseNo']:= 404; { "Not Found" }
                            exit;
                          end;
                        end;
                        if AppEnv.ThreadId <> GetCurrentThreadID then
                          Logger.Log('Threads do not match!', ltError);
                        JsonResp.O['JsonOut']:= JSONSerialiser.SerialiseObject(Resource);
                        if (not JsonResp.O['JsonOut'].StringExists('type')) or (JsonResp.O['JsonOut'].S['type'] = '') then begin
                          Logger.Log('GET - Error reading object for "' + Resource.ClassName + '", object type missing',ltError);
                          JsonResp.I['ResponseNo']:= 500; { "Internal Server Error" }
                          JsonResp.S['ErrorMessage']:= 'Error reading object for "' + Resource.ClassName + '", object type missing';
                          exit;
                        end;
                      except
                        on exc: exception do begin
                          Logger.Log('GET - Error: ' + exc.Message + ' ThreadID = ' + IntToStr(GetCurrentThreadID),ltError);
                          JsonResp.I['ResponseNo']:= 500; { "Internal Server Error" }
                          JsonResp.S['ErrorMessage']:= 'Error: ' + RemoveCRLF(exc.Message);
                          exit;
                        end;
                      end;
                    finally
                      JSONSerialiser.Free;
                    end;

                    JsonResp.I['ResponseNo']:= 200; { "OK" }
                  end
                  else begin
                    { invalid ID  }

                    Logger.Log('GET - Invalid Object/ID.',ltError);
                    JsonResp.I['ResponseNo']:= 500; { "Internal Server Error" }
                    JsonResp.S['ErrorMessage']:= 'Error: Invalid Object/ID.';
                  end;


                end
                else begin
                  Logger.Log('GET - Invalid URI: "' +JsonReq.S['URI'] + '".',ltError);
                  JsonResp.I['ResponseNo']:= 404; { "Not Found" }
                  JsonResp.S['ErrorMessage']:= 'Invalid URI: "' +JsonReq.S['URI'] + '"';
                  exit;
                end;
              end
              else begin
                 {  }
                { list of objects }
                if (Resource is TDatasetBusObj) and (not TDatasetBusObj(Resource).CanRead) then begin
                  Logger.Log('GET - User does not have rights to read ' +Resource.ClassName + '.',ltError);
                  JsonResp.I['ResponseNo']:= 403; { "Forbidden" }
                  JsonResp.S['ErrorMessage']:= 'User does not have rights to read ' +Resource.ClassName + '.';
                  exit;
                end
                else begin
                  ListDb(JsonResp.O['JsonOut']);
                  Logger.Log('GET - List for ' + Resource.ClassName + ' ok.',ltDetail);
                  JsonResp.I['ResponseNo']:= 200; { "OK" }
                end;
              end;

            end
            else if (JsonReq.S['Command'] = 'POST') {or (ARequestInfo.CommandType = hcPUT)} then begin
              if not JsonReq.ObjectExists('JsonIn') then begin
                Logger.Log('POST - Input data for ' + ResourceName + ' is empty.',ltError);
                JsonResp.I['ResponseNo']:= 406; { "Not Acceptable" }
                JsonResp.S['ErrorMessage']:= 'Data is empty';
                exit;
              end;
              if Lowercase(JsonReq.O['JsonIn'].S['type']) <> Lowercase(ResourceName) then begin
                Logger.Log('POST - URI Resource does not match request class type.',ltError);
                JsonResp.I['ResponseNo']:= 406; { "Not Acceptable" }
                JsonResp.S['ErrorMessage']:= 'URI Resource does not match request class type';
                exit;
              end;
              if not JsonReq.O['JsonIn'].ObjectExists('fields') then begin
                Logger.Log('POST - Request does not contain object "fields".',ltError);
                JsonResp.I['ResponseNo']:= 406; { "Not Acceptable" }
                JsonResp.S['ErrorMessage']:= 'Request does not contain object "fields"';
                exit;
              end;
              ObjId:= 0;
              if JsonReq.O['JsonIn'].O['fields'].IntegerExists('id') then
                ObjId:= JsonReq.O['JsonIn'].O['fields'].I['id'];
              DbConn.StartTransaction;
              JSONDesrialiser:= TJSONDeserialiser.Create;
              Obj:= nil;
              try
                try
                  JSONDesrialiser.DatabaseConnection:= DbConn;
                  if JsonReq.Exists('Params') and JsonReq.O['Params'].StringExists('RawMode') then begin
                    if SameText(JsonReq.O['Params'].S['RawMode'],'True') then
                      JSONDesrialiser.RawMode:= true;
                  end;
                  if AppEnv.ThreadId <> GetCurrentThreadID then
                    Logger.Log('Threads do not match!', ltError);
                  Obj:= JSONDesrialiser.DeserialiseObject(JsonReq.O['JsonIn']);
                  if not JSONDesrialiser.IsConsistent then begin
                    Logger.Log('POST - Error populating object: ' + JSONDesrialiser.Messages.CommaText,ltDetail);
                    JsonResp.I['ResponseNo']:= 406; { "Not Acceptable" }
                    JsonResp.S['ErrorMessage']:= 'Error: ' + JSONDesrialiser.Messages.CommaText;
                    exit;
                  end;
//                  Logger.Log('Saved object: ' + obj.ClassName, ltDebug);
                  JsonResp.I['ResponseNo']:= 200; { "OK" }
                  JsonResp.O['JsonOut'].S['type']:= JsonReq.O['JsonIn'].S['type'];
                  if Obj is TDatasetBusObj then begin
                    DsBusObj:= TDatasetBusObj(Obj);
//                    Logger.Log('Before Save ' + DsBusObj.ClassName + ' ' + DsBusObj.MsUpdateSiteCode,ltDebug);
                    msTimeStamp:= 0;
                    if JsonReq.O['JsonIn'].O['fields'].Exists('msTimeStamp') then
                      msTimeStamp:= JsonReq.O['JsonIn'].O['fields'].ItemByName['msTimeStamp'].Value.AsDateTime;
                    DsBusObj.SilentMode:= true;
                    msg:= '';
                    if not SaveBusObj(DsBusObj,msg) then begin
                      Logger.Log('POST - Error saving object: ' +  msg,ltError);
                      JsonResp.I['ResponseNo']:= 406; { "Not Acceptable" }
                      JsonResp.S['ErrorMessage']:= MakeErrorMessage(msg);
                      exit;
                    end;
                    if DsBusObj is TMSBusObj then begin
                      if (msTimeStamp <> 0) then begin
//                        if (DsBusObj.MsTimeStamp <> msTimeStamp) then begin
                        { the save above will cause db trigger to update msTimeStamp .. so set back to correct value }
                        TMSBusObj(DsBusObj).FlagAsUpdated(msTimeStamp);
//                        end;
                      end;
                    end;
                    JsonResp.O['JsonOut'].O['fields'].I['ID']:= DsBusObj.ID;
                    Logger.Log('POST - Object saved ok, ID = ' +  IntToStr(DsBusObj.ID),ltDetail);
                  end;
                except
                  on ex: exception do begin
                    Logger.Log('POST - Error: ' +  ex.Message + ' ThreadID = ' + IntToStr(GetCurrentThreadID),ltError);
                    JsonResp.I['ResponseNo']:= 500; { "Internal Server Error" }
                    JsonResp.S['ErrorMessage']:= 'Error: ' + RemoveCRLF(ex.Message);
                    exit;
                  end;
                end;
//                Logger.Log('After Save ' + DsBusObj.ClassName + ' ' + DsBusObj.MsUpdateSiteCode,ltDebug);
                DbConn.Commit;
//                with TMyQuery.Create(nil) do begin
//                  Connection:= DbConn;
//                  SQL.Text:= 'select msTimestamp from ' + TMSBusObj(DsBusObj).TableName + ' where globalref = ' + QuotedStr(TMSBusObj(DsBusObj).GlobalRef);
//                  try
//                    open;
//                    Logger.Log('Saved timestamp: ' + FormatDateTime('yyyy-mm-dd hh:nn:ss', fieldbyname('msTimeStamp').AsDateTime),ltDebug);
//                    if fieldbyname('msTimeStamp').AsDateTime <> msTimestamp then
//                      Logger.Log('error');
//
//                  except
//                  end;
//                  Free;
//                end;
              finally
                if Assigned(Obj) then begin
                  if (Obj is TDatasetBusObj) then
                    TDatasetBusObj(Obj).UnLock;
                end;
                JSONDesrialiser.Free;  { Obj is freeed when JSONDesrialiser is freeed }
                if DbConn.InTransaction then
                  DbConn.Rollback;
              end;
            end
            else begin
              Logger.Log('Command ' + JsonReq.S['Command'] + ' Not Implemented',ltError);
              JsonResp.I['ResponseNo']:= 501; { "Not Implemented" }
              JsonResp.S['ErrorMessage']:= 'Command ' + JsonReq.S['Command'] + ' Not Implemented';
              exit;
            end;
          finally
            AppEnv.UtilsClient.Logger := nil;
            Resource.Free;
            CoUninitialize();
            DbConn.Free;
          end;
        finally
          AppEnv.UtilsClient.Disconnect;
        end;

      finally
        AppEnvPool.ReleaseAppEnv(Logger);
//        Logger.Log('Thread ID release: '+ IntToStr(GetCurrentThreadID), ltInfo);
      end;
    finally
      Logger.Log('Finished Processing HTTP Request (' + FormatDateTime('hh:nn:ss.zzz',now-StartTime)+ ')',ltDetail);
//      Logger.Log('---------------------------------------------',ltDetail);
    end;
  except
    on e: exception do begin
      Logger.Log('Error: ' + e.Message + ' ThreadID = ' + IntToStr(GetCurrentThreadID),ltError);
      JsonResp.I['ResponseNo']:= 500; { "Internal Server Error" }
      JsonResp.S['ErrorMessage']:= 'Error: ' + RemoveCRLF(e.Message);
    end;
  end;
end;


end.
