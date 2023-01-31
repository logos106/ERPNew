unit ErpRestApiObj;

interface

uses
  IdCustomHttpServer, IdContext, JsonObject, myaccess, classes,
  LogThreadLib, LogMessageTypes, RestServerConfigObj;

type

  TErpRestApi = class(TObject)
  private
    Logger: TLogger;
    fConfig: TRestServerConfigValues;
  public
    constructor Create(aLogger: TLogger);
    destructor Destroy; override;
    property Config: TRestServerConfigValues read fConfig write fConfig;
    procedure DoHTTPRequest(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponceInfo: TIdHTTPResponseInfo);
  end;

implementation

uses
  strutils, types, sysutils, AppEnvironment,
  BusObjBase, CommonDbLib, db, JsonToBusObj, ActiveX, AppEnvironmentPool,
  ObjectSerialiser, DBXJSONReflect, ModuleConst;

const
  ERP_WEB_USER = 'WebUser';
//  ERP_API_URL = 'erpapi';
  DefaultServer = 'localhost';

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

{ TErpRestApi }

constructor TErpRestApi.Create(aLogger: TLogger);
begin
  Logger:= aLogger;
  AppEnv.AppDb.Logger:= Logger;
  fConfig:= TRestServerConfigValues.Create;
end;

destructor TErpRestApi.Destroy;
begin
  AppEnv.AppDb.Logger:= nil;
  fConfig.Free;
  inherited;
end;

procedure TErpRestApi.DoHTTPRequest(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponceInfo: TIdHTTPResponseInfo);
var
  URIParts: TStringDynArray;
  ResourceName: string;
  ResourceClassName: string;
  ResourceClass: TPersistentClass;
  Resource: TPersistent;
  DsBusObj: TDatasetBusObj;
  DbConn: TMyConnection;
  ObjID: integer;
  JsonIn, JsonOut: TJsonObject;
  JSONSerialiser: TJSONSerialiser;
  JSONDesrialiser: TJSONDeserialiser;
  sl: TStringList;
  Obj: TObject;
  msg: string;
  MultiLogon: boolean;

  procedure ListDb(json: TJsonObject);
  var
    qry: TMyQuery;
    JsonArray: TJsonArray;
    ArrayItem: TJsonObject;
    x: integer;
  begin
    JsonArray:= Json.A[ResourceName];
    qry:= TMyQuery.Create(nil);
    try
      qry.Connection:= DbConn;

      qry.SQL.Add('select mstimestamp, ' + DsBusObj.IDFieldName);
      if DsBusObj.ClassNameIs('TProductPicture') or DsBusObj.ClassNameIs('TProductJPGPicture') then
        qry.SQL.Add(', PartID as ProductID')
      else if DsBusObj.ClassNameIs('TProductGroup') or DsBusObj.ClassNameIs('TProductJPGGroup') then
        qry.SQL.Add(', GroupName');
      qry.SQL.Add('from ' + DsBusObj.BusObjectTableName);
      qry.Open;
      while not qry.Eof do begin
        ArrayItem:= TJsonObject.Create;
        ArrayItem.S['href']:= 'http//' + ARequestInfo.Host + '/' + ERP_API_URL + '/' + ResourceName + '/' + qry.FieldByName(DsBusObj.IDFieldName).AsString;
        ArrayItem.I['ID']:= qry.FieldByName(DsBusObj.IDFieldName).AsInteger;
        ArrayItem.S['msTimeStamp']:= FormatDateTime(JsonDateTimeFormat, qry.FieldByName('mstimestamp').AsDateTime);
        for x:= 0 to qry.FieldCount -1 do begin
          if (Lowercase(qry.Fields[x].FieldName) <> 'mstimestamp') and
             (Lowercase(qry.Fields[x].FieldName) <> Lowercase(DsBusObj.IDFieldName)) then begin
            case qry.Fields[x].DataType of
              ftString, ftFixedChar, ftWideString, ftFixedWideChar:
                ArrayItem.S[qry.Fields[x].FieldName] := qry.Fields[x].AsString;

              ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeint, ftLongWord,
              ftShortint, ftByte, ftSingle:
                ArrayItem.I[qry.Fields[x].FieldName] := qry.Fields[x].AsInteger;

              ftFloat, ftCurrency, ftExtended:
                ArrayItem.F[qry.Fields[x].FieldName] := qry.Fields[x].AsFloat;

              ftUnknown, ftBoolean, ftDate, ftTime, ftDateTime, ftBytes,
              ftVarBytes, ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor,
              ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftADT, ftArray, ftReference,
              ftDataSet, ftOraBlob, ftOraClob, ftVariant, ftInterface,
              ftIDispatch, ftGuid, ftTimeStamp, ftFMTBcd, ftWideMemo,
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
  end;

begin
  Resource:= nil;
  AResponceInfo.ResponseNo:= 204; { "No Content" }
  AResponceInfo.ContentType:= 'application/json';
  try
    URIParts:= SplitString(Lowercase(ARequestInfo.URI),'/');
    try
      if (High(URIParts) < 2) or (URIParts[1] <> ERP_API_URL)then begin
        AResponceInfo.ResponseNo:= 400; { "Bad Request" }
        AResponceInfo.CustomHeaders.Values['errormessage']:= 'Bad Request';
        exit;
      end;
      ResourceName:= URIParts[2];
      ResourceClassName:= {'T' +} ResourceName;
      ResourceClass:= GetClass(ResourceClassName);
      if not Assigned(ResourceClass) then begin
        AResponceInfo.ResponseNo:= 404; { "Not Found" }
        AResponceInfo.CustomHeaders.Values['errormessage']:= 'Could not find the requested resource "' + ResourceName + '"';
        exit;
      end;

      case AppEnvPool.GetAppEnv(ARequestInfo.RawHeaders.Values['database'], ARequestInfo.AuthUsername, ARequestInfo.AuthPassword) of
        aeprOk:;
        aeprFail:
          begin
            AResponceInfo.ResponseNo:= 503; { "Service Unavaiable" }
            AResponceInfo.CustomHeaders.Values['errormessage']:= 'Faild to obtain a database connection';
            exit;
          end;
        aeprMaxExceeded:
          begin
            AResponceInfo.ResponseNo:= 503; { "Service Unavaiable" }
            AResponceInfo.CustomHeaders.Values['errormessage']:= 'Server maximum number of database connections exceeded';
            exit;
          end;
        aeprInactive:
          begin
            AResponceInfo.ResponseNo:= 503; { "Service Unavaiable" }
            AResponceInfo.CustomHeaders.Values['errormessage']:= 'Server database connection inactive';
            exit;
          end;
      end;
    finally

    end;

    try
      AppEnv.AppDb.Server:= DefaultServer;
      Logger.Log('Useing Database Server: ' + AppEnv.AppDb.Server, ltDetail);

      AppEnv.AppDb.Database:= ARequestInfo.RawHeaders.Values['database'];
      Logger.Log('Useing Database: ' + AppEnv.AppDb.Database, ltDetail);
      if not AppEnv.AppDb.VersionOk then begin
        AResponceInfo.ResponseNo:= 500; { "Internal Server Error" }
        AResponceInfo.CustomHeaders.Values['errormessage']:= 'Error: Server and database versions do not match';
        exit;
      end;

      try
        AppEnv.AppDb.ConnectUser(ARequestInfo.AuthUsername, ARequestInfo.AuthPassword);
      except
        on eusr: exception do begin
          AResponceInfo.ResponseNo:= 403; { "Forbidden" }
          AResponceInfo.CustomHeaders.Values['errormessage']:= 'Forbidden: ' + eusr.Message;
          exit;
        end;
      end;
      if not AppEnv.AppDb.Connection.Connected then  begin
        AResponceInfo.ResponseNo:= 403; { "Forbidden" }
        AResponceInfo.CustomHeaders.Values['errormessage']:= 'Forbidden: Could not connect to ERP';
        exit;
      end;

      MultiLogon:= Lowercase(ARequestInfo.AuthUsername) = Lowercase(Config.WebuserName);
      if not AppEnv.UtilsClient.ConnectUser(msg,DefaultServer,AppEnv.AppDb.Database,ARequestInfo.AuthUsername,'','',MultiLogon) then begin
        AResponceInfo.ResponseNo:= 403; { "Forbidden" }
        AResponceInfo.CustomHeaders.Values['errormessage']:= 'Forbidden: Could not connect to ERP. ' + StringReplace( msg, #13#10,' ',[rfReplaceAll]);
        exit;
      end;
      try
        DbConn:= CommonDbLib.GetNewMyDacConnection(nil);
        CoInitialize(nil);
        try
          if ARequestInfo.CommandType = hcGET then begin
            if ResourceClass.InheritsFrom(TDatasetBusObj) then begin
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
            else begin
              { differnt sort of object }
              AResponceInfo.ResponseNo:= 404; { "Not Found" }
              AResponceInfo.CustomHeaders.Values['errormessage']:= 'Unsupported class of object';
              exit;
            end;
            { get a list or single object instance }
            if (High(URIParts) > 2) and (TryStrToInt(URIParts[3],ObjID)) then begin
              { specific instance }
              if ObjID > 0 then begin

                JSONSerialiser:= TJSONSerialiser.Create;
                sl:= TStringList.Create;
                try
                  try
                    if Assigned(DsBusObj) then DsBusObj.Load(ObjID);
                    JsonOut:= JSONSerialiser.SerialiseObject(Resource);
                    sl.Text:= JsonOut.AsString;
                    FormatJson(sl);
                    //json.SaveToFile('c:\temp\json.txt');
                    //sl.SaveToFile('c:\temp\json.txt');
                    AResponceInfo.ContentText:= sl.text; //DecodeString(Json.AsString);
                  except
                    on exc: exception do begin
                      AResponceInfo.ResponseNo:= 500; { "Internal Server Error" }
                      AResponceInfo.CustomHeaders.Values['errormessage']:= 'Error: ' + exc.Message;
                      exit;
                    end;
                  end;
                finally
                  JSONSerialiser.Free;
                  sl.Free;
                end;

                AResponceInfo.ResponseNo:= 200; { "OK" }
              end
              else begin
                { invalid ID  }

              end;
            end
            else begin
              { list of objects }
              JsonOut:= TJsonObject.Create;
              try
                ListDb(JsonOut);
                AResponceInfo.ContentText:= JsonOut.AsString; //  DecodeString(Json.AsString);
                AResponceInfo.ResponseNo:= 200; { "OK" }
              finally
                JsonOut.Free;
              end;
            end;

          end
          else if (ARequestInfo.CommandType = hcPOST) {or (ARequestInfo.CommandType = hcPUT)} then begin
            JsonIn:= TJsonObject.Create;
            try
              if Assigned(ARequestInfo.PostStream) then
                JsonIn.ReadFromStream(ARequestInfo.PostStream)
              else begin
                AResponceInfo.ResponseNo:= 406; { "Not Acceptable" }
                AResponceInfo.CustomHeaders.Values['errormessage']:= 'Data is empty';
                exit;
              end;
              if Lowercase(JsonIn.S['type']) <> Lowercase(ResourceName) then begin
                AResponceInfo.ResponseNo:= 406; { "Not Acceptable" }
                AResponceInfo.CustomHeaders.Values['errormessage']:= 'URI Resource does not match request class type';
                exit;
              end;
              if not JsonIn.ObjectExists('fields') then begin
                AResponceInfo.ResponseNo:= 406; { "Not Acceptable" }
                AResponceInfo.CustomHeaders.Values['errormessage']:= 'Request does not contain object "fields"';
                exit;
              end;
              ObjId:= 0;
              if JsonIn.O['fields'].IntegerExists('id') then
                ObjId:= JsonIn.O['fields'].I['id'];
              DbConn.StartTransaction;
              JSONDesrialiser:= TJSONDeserialiser.Create;
              JsonOut:= TJsonObject.Create;
              try
                try
                  JSONDesrialiser.DatabaseConnection:= DbConn;
                  Obj:= JSONDesrialiser.DeserialiseObject(JsonIn);
                  if not JSONDesrialiser.IsConsistent then begin
                    AResponceInfo.ResponseNo:= 406; { "Not Acceptable" }
                    AResponceInfo.CustomHeaders.Values['errormessage']:= 'Error: ' + JSONDesrialiser.Messages.CommaText;
                    exit;
                  end;
                  AResponceInfo.ResponseNo:= 200; { "OK" }
                  JsonOut.S['type']:= JsonIn.S['type'];
                  if Obj is TDatasetBusObj then begin
                    DsBusObj:= TDatasetBusObj(Obj);
                    if not DsBusObj.Save then begin
                      AResponceInfo.ResponseNo:= 406; { "Not Acceptable" }
                      AResponceInfo.CustomHeaders.Values['errormessage']:= 'Error: ' + DsBusObj.ResultStatus.Messages;
                      exit;
                    end;
                    JsonOut.O['fields'].I['ID']:= DsBusObj.ID;
                  end;
                  AResponceInfo.ContentText:= JsonOut.AsString;
                except
                  on ex: exception do begin
                    AResponceInfo.ResponseNo:= 500; { "Internal Server Error" }
                    AResponceInfo.CustomHeaders.Values['errormessage']:= 'Error: ' + Trim(ex.Message);
                    exit;
                  end;
                end;
                DbConn.Commit;
              finally
                JSONDesrialiser.Free;
                JsonOut.Free;
                if DbConn.InTransaction then
                  DbConn.Rollback;
              end;
            finally
              JsonIn.Free;
            end;
          end
          else begin
            AResponceInfo.ResponseNo:= 501; { "Not Implemented" }
            AResponceInfo.CustomHeaders.Values['errormessage']:= 'Command ' + ARequestInfo.Command + ' Not Implemented';
            exit;
          end;
        finally
          Resource.Free;
          CoUninitialize();
          DbConn.Free;
        end;
      finally
        AppEnv.UtilsClient.Disconnect;
      end;

    finally
      AppEnvPool.ReleaseAppEnv;
    end;
  except
    on e: exception do begin
      AResponceInfo.ResponseNo:= 500; { "Internal Server Error" }
      AResponceInfo.CustomHeaders.Values['errormessage']:= 'Error: ' + Trim(e.Message);
    end;
  end;
end;

end.
