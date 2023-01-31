unit APIDataSyncObj;

interface

uses
  JsonObject, extctrls, IdHttp, {DataSyncDbObj,} BusObjSchemaLib, WebApiClientObj,
  ApiObjectListObj, Classes, LogMessageTypes, LogThreadBase, LogThreadLib,
  SyncObjs, ConfigDbObj, SynchReportObj, ModuleBaseServerObj;

type
  TSynchDirection = (sdForward, sdReverse);

  TAPIDataSyncThread = class(TThread)
  private
    Config: TJsonObject;
    fNextCheckTime: TDateTime;
    SchemaList: TBOSchemaList;
    SourceLists,
    DestLists: TApiObjectLists;
    ApiSource,
    ApiDest: TWebApiClient;
    Level: integer;
    SrcSysInfo,
    DstSysInfo: TJsonObject;
    SrcUtcOffset,
    DstUTCOffset: TDateTime;
    CurrentSyncListItems: TStringList;
    ConfigDb: TConfigDb;
    fActive: boolean;
    fDataChanged: boolean;
    CurrentSite: TJsonObject;
    LastChangeTimes: TLastChangeList;
    SourceSiteCode: string;
    Report: TSyncReport;
    Module: TModuleBaseServer;
    CheckReferenceObjects: boolean;
    procedure DoWork;
    procedure Log(msg: string; LogType: TLogMessageType);
    procedure IncLevel;
    procedure DecLevel;
    function GetSchema(aClassName: string; var Schema: TBOSchema; var msg: string): boolean;
    function DoSync(Site: TJsonObject; var msg: string): boolean;
    function DoSyncList(aClassName: string; var msg: string): boolean;
    function SyncItem(aClassName: string; aId: integer; var msg: string): boolean;
    function MappRefObj(Src, Dst, RefSchema: TJsonObject; DonePropList: TStringList; var msg: string): boolean;
    function SupObjListSyncDone(aClassName: string; var msg: string): boolean;
    function GetKeyStringPropertyName(aClassName: string; var aKeyStringPropertyName: string; var msg: string): boolean;
    procedure UpdateConfigNextUpdateTime(SiteName: string; UpdateTime: TDateTime);
    function SourceTimeStampNewer(ObjSrc, ObjDst: TJsonObject): boolean;
    function ListSourceTimeStampNewer(ObjSrc, ObjDst: TJsonObject): boolean;
    function GetSourceLastChangeTime(aClassName: string): TDateTime;
    procedure SetSourceLastChangeTime(aClassName: string; const Value: TDateTime);
    function GetActive: boolean;
    property SourceLastChangeTime[aClassName: string]: TDateTime read GetSourceLastChangeTime write SetSourceLastChangeTime;
  protected
    procedure Execute; override;
  public
    constructor Create(aModule: TModuleBaseServer); reintroduce;
    destructor Destroy; override;
    property Active: boolean read GetActive;
  end;

const
  ResultStatus_Ok = 'OK';
  ResultStatus_Sync = 'Sync';
  ResultStatus_Fail = 'Fail';
  ResultStatus_Warn = 'Warning';

  Event_SiteStatus = 'SiteStatus';
  Event_IdleStatus = 'IdleStatus';

  List_Chunk_Size = 500;
  List_Chunk_Size_Small = 100;

implementation

uses
  sysutils, forms, IdSSLOpenSSL, JsonObjectUtils, DateUtils, types, URILib,
  Math, SystemLib, UURIEncode, ModuleUtils;

const
  TypesToSynch: array[0..71] of string =
    (
     'TERPPreference',
     'TCustomFieldList',
     'TCustomFieldConfig',
     'TBusObjCustFieldValueConfig',
     'TRegionalOptions',
     'TDeptClass',
     'TAbility',
     'TServices',
     'TPayRate',
     'TPartsClassPreferences',
     'TAccountType',
     'TTaxCode',
     'TAccount',
     'TERPAccountPref',
     'TSource',
     'TModel',
     'TManufacture',
     'TCountries',
     'TCurrency',
     'TCurrencyRateHistory',
     'TShippingMethod',
     'TPaymentMethod',
     'TERPPaymentMethodPref',
     'TTerms',
     'TClientType',
     'TCompanyType',   // SimpleTypes
     'TFormulaEntry',
     'TFormula',
     'TProductWeb',
     'TSerialJobNumbers',
     'TProductJPGPicture',
     'TEquipment',
     'TEquipmentJPGPicture',
     'TEquipmentJPGImages',
     'TEmployee',
     'TERPEmployeePref',
     'TRoster',
     'TPreference',
     'TEmpNoCommsProducts',
     'TToDo',
     'TTasks',
     'TCustomer',
     'TRepServices',
     'TPhoneSupportType',
     'TPhoneSupportVersion',
     'TPhoneSupportLog',
     'TLeadActionType',
     'TAppointmentStatusType',
     'TOtherContact',
     'TMarketingContact',
     'TLeads',
     'TCustomerEquipment',
     'TQuote',
     'TSalesOrderGroup',
     'TInvoiceGroup',
     'TPosKeypad',
     'TFuncRoom',
     'TPosKeypadCustomise',
     'TPosTill',
     'TPosEop',
     'TAppointment',
     'TCashSale',
     'TRefundSale',
     'TVoucher',
     'TStockAdjustEntry',
     'TStockTransferEntry',
     'TStockMovement',
     'TPOSCashSale',
     'TDelectedProductPicture',
     'TDeletedPartsClassPreferences',
     'TDeletedPreference',
     'TDeletedCFListDropDown');


procedure RemoveIdFields(obj: TJsonObject);
var
  x, y: integer;
begin
  x:= 0;
  while x < obj.Count do begin
    if obj.Items[x].Value.ValueType in [valObject, valArray] then begin
      if obj.Items[x].Value.ValueType = valObject then
        RemoveIdFields(obj.Items[x].Value.AsObject)
      else begin
        for y := 0 to TJSONArray(obj.Items[x].Value).Count -1 do begin
          if TJSONArray(obj.Items[x].Value).Items[y].ValueType = valObject then
            RemoveIdFields(TJSONArray(obj.Items[x].Value).Items[y].AsObject);
        end;
      end;
      Inc(x)
    end
    else if SameText(obj.Items[x].Name, 'ID') then
      obj.Delete(x)
    else
      Inc(x);
  end;
end;

function ArrayObjectByGlobalRef(Arr: TJSONArray; aGlobalRef: string): TJsonObject;
var
  x: integer;
  obj: TJsonObject;
begin
  result:= nil;
  if aGlobalRef = '' then exit;
  for x := 0 to Arr.Count -1 do begin
    obj:= Arr.Items[x].AsObject;
    if obj.O['fields'].Exists('GlobalRef') and SameText(obj.O['fields'].S['GlobalRef'],aGlobalRef) then begin
      result:= obj;
      exit;
    end;
  end;
end;

procedure DeleteGlobalRefsNotInList(GlobalList: TStringList; Arr: TJSONArray);
var
  x: integer;
  GlobalRef: string;
begin
  x:= 0;
  while x < Arr.Count do begin
    GlobalRef:= Arr.Items[x].AsObject.O['fields'].S['GlobalRef'];
    if (GlobalRef = '') or (GlobalList.IndexOf(GlobalRef) < 0) then
      Arr.Delete(x)
    else
      Inc(x);
  end;
end;

{ TAPIDataSyncThread }

constructor TAPIDataSyncThread.Create(aModule: TModuleBaseServer);
begin
  Module:= aModule;
  inherited Create(true);
  CheckReferenceObjects := true;
  SourceSiteCode := '';
  ConfigDb:= TConfigDb.Create('SiteIntegration','localhost');
  LastChangeTimes:= TLastChangeList.Create;
  fNextCheckTime:= now + ((1/24/60/60) * 60);
  FreeOnTerminate:= false;
  Priority:= tpLower;
//  Priority:= tpNormal;
  Config:= TJsonObject.Create;
  SchemaList:= TBOSchemaList.Create;
  SourceLists:= TApiObjectLists.Create;
  DestLists:= TApiObjectLists.Create;
  CurrentSyncListItems:= TStringList.Create;
  CurrentSite:= nil;
  Level:= 0;
  Report := TSyncReport.Create;
  fActive:= true;
  {$WARNINGS OFF}
  Resume;
  {$WARNINGS ON}
end;

procedure TAPIDataSyncThread.DecLevel;
begin
  if Level > 0 then
    Dec(Level);
end;

destructor TAPIDataSyncThread.Destroy;
begin
  SchemaList.Free;
  SourceLists.Free;
  CurrentSyncListItems.Free;
  DestLists.Free;
  Config.Free;
  ConfigDb.Free;
  LastChangeTimes.Free;
  inherited;
end;

function TAPIDataSyncThread.DoSync(Site: TJsonObject; var msg: string): boolean;
var
  x: integer;
  utcStr: string;
  ApiSrc: TWebApiClient;
  ApiDst: TWebApiClient;
  fSrcSysInfo: TJsonObject;
  fDstSysInfo: TJsonObject;
  ObjList: TStringList;

  function GetObjectList(aObjName: string): boolean;
  var
    json: TJsonObject;
    lstIdx: integer;
    s: string;
  begin
    result := true;
    json:= JO;
    try
      if not ApiDst.Get(aObjName + '/ObjectList',json) then begin
        result:= false;
        msg:= 'Error connectiong to destination site ' + ApiDst.ErrorMessage;
        exit;
      end;
      for lstIdx := 0 to json.A['List'].Count -1 do begin
        s := json.A['List'].Items[lstIdx].AsString;
        if ObjList.IndexOf(s) < 0 then
          ObjList.Add(s);
      end;
    finally
      json.Free;
    end;
  end;


begin
  result:= true;
//  MemLogger.Log('Memory used: ' + IntToStr(CurrentMemoryUsage));
  ApiSrc:= TWebApiClient.Create;
  ApiDst:= TWebApiClient.Create;
  fSrcSysInfo:= JO;
  fDstSysInfo:= JO;
  CurrentSite:= Site;
  ObjList := TStringList.Create;
  try
    Log('Checking source connectivity: "' + Site.S['SourceURL'] + '"',ltDetail);
    ApiSrc.UserName:= Site.S['SourceUserName'];
    ApiSrc.Password:= Site.S['SourcePassword'];
    ApiSrc.Database:= Site.S['SourceDatabase'];
    ApiSrc.URL:= Site.S['SourceURL'];
    { test connectivity }
    if not ApiSrc.Get('TErpSysInfo',fSrcSysInfo) then begin
      result:= false;
      msg:= 'Error connectiong to source site ' + ApiSrc.ErrorMessage;
      Report.Status := 'No Connection';
      exit;
    end;

    if not Math.SameValue(fSrcSysInfo.O['Fields'].ItemByName['UTCOffset'].Value.AsFloat,
                          fSrcSysInfo.O['Fields'].ItemByName['MySQLUTCOffset'].Value.AsFloat, 0.003) then begin
      result:= false;
      msg:= 'Source site (' + Site.S['SourceURL'] + ') Time Zone does not match MySQL Time Zone. Please stop and restart MySQL on this server.';
      exit;
    end;
    if not Math.SameValue(fSrcSysInfo.O['Fields'].ItemByName['UTCOffset'].Value.AsFloat,
                      fSrcSysInfo.O['Fields'].ItemByName['DbUTCOffset'].Value.AsFloat, 0.003) then begin
      result:= false;
      msg:= 'Source site (' + Site.S['SourceURL'] + ') Time Zone does not match the database (' + ApiSrc.Database + ') Time Zone.';
      exit;
    end;


    if fSrcSysInfo.O['Fields'].ItemByName['UTCOffset'].Value.AsDateTime < 0 then
      utcStr:= 'GMT - ' + FormatDateTime('hh:nn', fSrcSysInfo.O['Fields'].ItemByName['UTCOffset'].Value.AsDateTime)
    else
      utcStr:= 'GMT + ' + FormatDateTime('hh:nn', fSrcSysInfo.O['Fields'].ItemByName['UTCOffset'].Value.AsDateTime);

    Log(fSrcSysInfo.O['Fields'].S['DatabaseName'] + ' SiteCode ' + fSrcSysInfo.O['Fields'].S['SiteCode']  + ' Version ' + fSrcSysInfo.O['Fields'].S['Version'] + ' ' + utcSTR,ltDetail);

    Log('Checking destination connectivity: "' + Site.S['DestinationURL'] + '"',ltDetail);
    ApiDst.UserName:= Site.S['DestinationUserName'];
    ApiDst.Password:= Site.S['DestinationPassword'];
    ApiDst.Database:= Site.S['DestinationDatabase'];
    ApiDst.URL:= Site.S['DestinationURL'];
    { test connectivity }
    if not ApiDst.Get('TErpSysInfo',fDstSysInfo) then begin
      result:= false;
      msg:= 'Error connectiong to destination site ' + ApiDst.ErrorMessage;
      Report.Status := 'No Connection';
      exit;
    end;

    if not Math.SameValue(fDstSysInfo.O['Fields'].ItemByName['UTCOffset'].Value.AsFloat,
                      fDstSysInfo.O['Fields'].ItemByName['MySQLUTCOffset'].Value.AsFloat, 0.003) then begin
      result:= false;
      msg:= 'Destination site (' + Site.S['DestinationURL'] + ') Time Zone does not match MySQL Time Zone. Please stop and restart MySQL on this server.';
      exit;
    end;
    if not Math.SameValue(fDstSysInfo.O['Fields'].ItemByName['UTCOffset'].Value.AsFloat,
                          fDstSysInfo.O['Fields'].ItemByName['DbUTCOffset'].Value.AsFloat, 0.003) then begin
      result:= false;
      msg:= 'Destination site (' + Site.S['DestinationURL'] + ') Time Zone does not match the database (' + ApiDst.Database + ') Time Zone.';
      exit;
    end;

    if fDstSysInfo.O['Fields'].ItemByName['UTCOffset'].Value.AsDateTime < 0 then
      utcStr:= 'GMT - ' + FormatDateTime('hh:nn', fDstSysInfo.O['Fields'].ItemByName['UTCOffset'].Value.AsDateTime)
    else
      utcStr:= 'GMT + ' + FormatDateTime('hh:nn', fDstSysInfo.O['Fields'].ItemByName['UTCOffset'].Value.AsDateTime);
    Log(fDstSysInfo.O['Fields'].S['DatabaseName'] + ' SiteCode ' + fDstSysInfo.O['Fields'].S['SiteCode'] + ' Version ' + fDstSysInfo.O['Fields'].S['Version'] + ' ' + utcSTR,ltDetail);

    if SameText(fSrcSysInfo.O['Fields'].S['SiteCode'],fDstSysInfo.O['Fields'].S['SiteCode']) then begin
      result:= false;
      msg:= 'Can not synchronise sites with same Site Code';
      exit;
    end;
    if not SameText(fSrcSysInfo.O['Fields'].S['Version'],fDstSysInfo.O['Fields'].S['Version']) then begin
      result:= false;
      msg:= 'Can not synchronise sites with different versions';
      exit;
    end;

    ApiSource:= ApiSrc;
    ApiDest:= ApiDst;

    SrcSysInfo:= fSrcSysInfo;
    DstSysInfo:= fDstSysInfo;
    SourceSiteCode:= SrcSysInfo.O['Fields'].S['SiteCode'];

    SrcUtcOffset:= self.SrcSysInfo.O['fields'].ItemByName['UTCOffset'].Value.AsDateTime;
    DstUtcOffset:= self.DstSysInfo.O['fields'].ItemByName['UTCOffset'].Value.AsDateTime;

    SourceLists.Clear;
    DestLists.Clear;

    CheckReferenceObjects := true;
    if Site.B['SynchAll'] or ((not Site.B['SynchPOS']) and (not Site.B['SynchProduct'])) then begin
      for x:= Low(TypesToSynch) to High(Low(TypesToSynch)) do
        ObjList.Add(TypesToSynch[x]);
    end
    else begin
      if Site.B['SynchPOS'] then begin
//        if not GetObjectList('TPOSCashSale') then exit
//        else begin
//          { move PosCashSale to start of list }
//          ObjList.Delete(ObjList.IndexOf('TPosCashSale'));
//          ObjList.Insert(0,'TPosCashSale');
//        end;
        ObjList.Clear;
        ObjList.Add('TPOSCashSale');
        ObjList.Add('TPOSLayby');
        CheckReferenceObjects := false;
      end;
      if Site.B['SynchProduct'] then begin
        ObjList.Add('TUnitOfMeasure');
        if not GetObjectList('TProductWeb') then exit;
        if not GetObjectList('TStockAdjustEntry') then exit;
        if not GetObjectList('TStockTransferEntry') then exit;
        if not GetObjectList('TStockMovement') then exit;
        ObjList.Add('TDelectedProductPicture');
        ObjList.Add('TDeletedPartsClassPreferences');
      end;
    end;

    Log('Starting forward synchronisation (updating destination (' +ApiDest.URL + ') data with newer source ('+ ApiSource.URL +') data.',ltInfo);
    fDataChanged:= false;
    try
      for x:= 0 to ObjList.Count -1 do begin
        if not Active then exit;
        if not DoSyncList(ObjList[x], msg) then begin
          Log('Error syncronising object: ' + TypesToSynch[x] + ' with error: ' + msg,ltError);
          if result then
            result:= false;
          break;
        end;
      end;
    except
      on e: exception do begin
        result := false;
        msg:= 'Error calling DoSyncList: ' + e.Message;
        Log(msg,ltError);
      end;
    end;
    if fDataChanged then
      Log('Data was changed/updated on Destination system.',ltInfo);


    if Site.B['TwoWaySynch'] then begin
      { now synch back the other way }
      Log('Starting reverse synchronisation (updating source ('+ApiSource.URL+') data with newer destination ('+ApiDest.URL+') data.',ltInfo);

      ApiSource:= ApiDst;
      ApiDest:= ApiSrc;

      SrcSysInfo:= fDstSysInfo;
      DstSysInfo:= fSrcSysInfo;
      SourceSiteCode:= SrcSysInfo.O['Fields'].S['SiteCode'];

      SrcUtcOffset:= self.SrcSysInfo.O['fields'].ItemByName['UTCOffset'].Value.AsDateTime;
      DstUtcOffset:= self.DstSysInfo.O['fields'].ItemByName['UTCOffset'].Value.AsDateTime;

      SourceLists.Clear;
      DestLists.Clear;

      fDataChanged:= false;
      try
        for x:= 0 to ObjList.Count -1 do begin
          if not Active then exit;
          if not DoSyncList(ObjList[x], msg) then begin
            Log('Error syncronising object: ' + TypesToSynch[x] + ' with error: ' + msg,ltError);
             if result then
             result:= false;
            break;
          end;
        end;
      except
        on e: exception do begin
          result := false;
          msg:= 'Error calling DoSyncList: ' + e.Message;
          Log(msg,ltError);
        end;
      end;
      if fDataChanged then
        Log('Data was changed/updated on Source system.',ltInfo);
    end;

  finally
    FreeAndNil(ApiSrc);
    FreeAndNil(ApiDst);
    FreeAndNil(fSrcSysInfo);
    FreeAndNil(fDstSysInfo);
    CurrentSite:= nil;
    ObjList.Free;
  end;
end;

function TAPIDataSyncThread.DoSyncList(aClassName: string;
  var msg: string): boolean;
var
  s: string;
  SrcList, DstList: TApiObjectListBase;
  DstObj: TJsonObject;
  DataChanged: boolean;
  Schema: TBOSchema;
  ChangeCount, TotalCount, ListTotal: integer;
  subMsg: string;
  KeyStringProperty: string;
  ObjRefStr: string;
  ObjNeedsSynching: boolean;
  x, i: integer;
  logStr: string;
  LastChange: TDateTime;
  Json, Lst: TJsonObject;
  WasError: boolean;
  dt, StartTime: TDateTime;

const
  FiveMins = (1/24/60) * 5;

  {  need to get lists in chunks, to limit size of data transfered }
  function GetList(ApiClient: TWebApiClient; Lists: TApiObjectLists; aListClassName: string; var aMsg: string): TApiObjectListBase;
  var
    str: string;
    done: boolean;
    tmp: TJsonObject;
    newObj: TJsonObject;
    tmpIdx: integer;
    ChunkSize, LimitFrom: integer;
  begin
    result:= nil;
    ChunkSize :=  List_Chunk_Size;
    LimitFrom := 0;
    done:= false;
    tmp := nil;
    Log('Getting list ('+aListClassName+') from: ' +  ApiClient.URL,ltDetail);
    try
      repeat
        try
          if not ApiClient.Get(aListClassName +'?LimitCount=' + IntToStr(ChunkSize) + '&LimitFrom=' + IntToStr(LimitFrom) ,str) then begin
            if (ChunkSize > List_Chunk_Size_Small) and (Pos('Content lenth error',ApiClient.ErrorMessage) > 0) then begin
              { reduce chunk size and try again }
              ChunkSize := List_Chunk_Size_Small;
              if not ApiClient.Get(aListClassName +'?LimitCount=' + IntToStr(ChunkSize) + '&LimitFrom=' + IntToStr(LimitFrom) ,str) then begin
                result:= nil;
                aMsg:= 'Error getting source list ' + ApiClient.ErrorMessage;
                exit;
              end;
            end
            else begin
              result:= nil;
              aMsg:= 'Error getting source list ' + ApiClient.ErrorMessage;
              exit;
            end;
          end;

          if LimitFrom = 0 then begin
            { create the list }
            Lists.AddList(aListClassName,str);
            result:= Lists.ListByType[aListClassName];
            if result.Count < ChunkSize then
              done := true;
          end
          else begin
            { need to append to list }
            if not Assigned(tmp) then tmp := TJsonObject.Create
            else tmp.Clear;
            tmp.AsString := str;
//            tmp.SaveToFile('c:\temp\list' + IntToStr(ChunkNo) + '.txt');
            if tmp.A[aListClassName].Count > 0 then begin
              for tmpIdx := 0 to tmp.A[aListClassName].Count -1 do begin
                newObj := TJsonObject.Create;
                newObj.Assign(tmp.A[aListClassName].Items[tmpIdx].AsObject);
                result.Append(newObj);
//                TApiObjectListMem(result).Json.SavetoFile('c:\temp\temp.txt');
              end;
              if tmp.A[aListClassName].Count < ChunkSize then
                done:= true;
            end
            else begin
              done := true;
            end;
          end;
          LimitFrom := LimitFrom + ChunkSize;
        except
          on e: exception do begin
            Log('GetList - Exception: '+ e.Message,ltError);
            result:= nil;
            if str <> '' then begin
              with TStringList.Create do begin
                Text := str;
                SaveToFile(WinTempDir + 'ErrorList.txt');
                free;
              end;
              aMsg:= 'Error reading list ' + e.Message + ' List saved to ' + WinTempDir + 'ErrorList.txt';
            end
            else
              aMsg:= 'Error reading list ' + e.Message;
            exit;
          end;
        end;
      until done;
      Log('Finished Getting list.',ltDetail);
    finally
      tmp.Free;
    end;
  end;

begin
  result:= true;
  if CurrentSyncListItems.IndexOf(aClassName) >= 0  then
    exit;
  CurrentSyncListItems.Add(aClassName);
  IncLevel;
  try
    if (not Active) or Terminated then exit;
    Log('Synchronising object list for: ' + aClassName,ltDetail);

    result:= GetSchema(aClassName, Schema, msg);
    if not result then
      exit;

    { first check that all sub reference objects have been synchronised }
    if CheckReferenceObjects then begin
      for x := 0 to Schema.RefTypesCount -1 do begin
        Log('.. Checking ' + aClassName + ' sub reference object: ' + Schema.RefType[x].S['Type'],ltDetail);
        if not SupObjListSyncDone(Schema.RefType[x].S['Type'],msg) then begin
          result:= false;
          exit;
        end;
      end;
    end;

    try
      { get most recent change time for this object and source }
      LastChange:= SourceLastChangeTime[aClassName];
      if LastChange > 0 then begin
        { .. now see if users have changed anything since this time }
        if not ApiSource.Get(aClassName + '?FieldList=MAX(msTimeStamp) as msTimeStamp',s) then begin
          result:= false;
          msg:= 'Error getting source list ' + ApiSource.ErrorMessage;
          exit;
        end;

        Json:= TJsonObject.Create;
        try
          Json.AsString:= s;
          if (not Json.ArrayExists(aClassName)) or (Json.A[aClassName].Count <> 1) then begin
            Log('Could not read latest Change Time from Source.',ltWarning);
          end
          else begin
            { check for future dated items ..  }
            if (Json.A[aClassName].Items[0].AsObject.DT['msTimeStamp'] - self.SrcUtcOffset) > (NowUTC + FiveMins) then begin
              result := false;
              msg := 'There are items (' +aClassName + ') in the source database that are flagged as having been updated in the future (msTimeStamp field contains a future time).';

              if not ApiDest.Get(aClassName + '?select=[msTimeStamp] >= "' + FormatDateTime(JsonDateTimeFormat,NowUTC+FiveMins+SrcUtcOffset) + '"',s) then begin
  //              result:= false;
  //              msg:= 'Error getting destination list ' + ApiDEst.ErrorMessage;
                exit;
              end;
              Lst := JO;
              try
                Lst.AsString := s;
                for i := 0 to Lst.A[aClassName].Count -1 do begin
                  s:= aClassName + ' Id: ' + IntToStr(Lst.A[aClassName].Items[i].AsObject.I['Id']);
                  s:= s + ' GlobalRef: ' + Lst.A[aClassName].Items[i].AsObject.S['GlobalRef'];
                  if Lst.A[aClassName].Items[i].AsObject.S['KeyValue'] <> '' then
                  s:= s + ' KeyValue: ' + Lst.A[aClassName].Items[i].AsObject.S['KeyValue'];
                  s:= s +', has a future dated TimeStamp: ' + Lst.A[aClassName].Items[i].AsObject.ItemByName['msTimeStamp'].Value.AsString + '.';
                  s:= s +  ' Please open this item in ERP and make any change to it and save it to force an update of the Time Stamp.';
                  Report.AddFail(s);
                  Log(s,ltError);
                end;
              finally
                Lst.Free;
              end;
              SourceLastChangeTime[aClassName]:= 0;
              exit;
            end;

            if Json.A[aClassName].Items[0].AsObject.DT['msTimeStamp'] <= LastChange then begin
              { .. nothing new to update }
              Log('Nothing changed on source for: ' + aClassName,ltDetail);
              exit;
            end;
          end;
        finally
          Json.Free;
        end;
      end;
    except
      on e: exception do begin
        result:= false;
        Msg := 'Exception while getting Last Change Time for ' + aClassName + ': ' + e.Message;
        exit;
      end;
    end;

    try
      SourceLists.Delete(aClassName);
    except
      on e: exception do begin
        result := false;
        msg:= 'DoSyncList - error deleting ' + aClassName + ' from SourceList: ' + e.Message;
        exit;
      end;
    end;

    try
      DestLists.Delete(aClassName);
    except
      on e: exception do begin
        result := false;
        msg:= 'DoSyncList - error deleting ' + aClassName + ' from DestList: ' + e.Message;
        exit;
      end;
    end;

    Log('Getting source list ...',ltDetail);
    SrcList := GetList(ApiSource,SourceLists,aClassName,msg);
    if not Assigned(SrcList) then begin
      result:= false;
      exit;
    end;

    Log('  Done, source list count = ' + IntToStr(SrcList.Count),ltDetail);

    if (not Active) or Terminated then exit;

    Log('Getting destination list ...',ltDetail);
    DstList := GetList(ApiDest,DestLists,aClassName,msg);
    if not Assigned(DstList) then begin
      result:= false;
      exit;
    end;

    Log('  Done, destination list count = ' + IntToStr(DstList.Count),ltDetail);

    DataChanged:= false;

//    with TJsonObject.Create do begin
//      AsString := SrcList.AsString ;
//      SavetoFile('c:\temp\temp.txt');
//      Free;
//    end;
    SrcList.First;
    ChangeCount:= 0;
    TotalCount:= 0;
    ListTotal:= SrcList.Count;

//    if aClassname = 'TProduct' then
//      beep;
    WasError:= false;
    dt:= 0;
    try
      while not SrcList.EOF do begin
        if (not Active) or Terminated then exit;
        Inc(TotalCount);
        if SrcList.Current.DT['msTimeStamp'] < LastChange  then begin
          SrcList.Next;
          continue;
        end;
        if (TotalCount = 1) or (Frac(TotalCount / 50) = 0) then
          Log('Checking "' + aClassName + '" ' + IntToStr(TotalCount) + ' of ' + IntToStr(ListTotal), ltDetail);

        KeyStringProperty:= Schema.Schema.S['KeyStringProperty'];
        DstObj := nil;
        if KeyStringProperty <> '' then begin
          if SrcList.Current.S['KeyValue'] = '' then begin
            Log(aClassName + ' with ID ' + IntToStr(SrcList.Current.I['ID']) + ' has a blank Value for ' +
              KeyStringProperty + ', this record will be skipped.',ltInfo);
  //          Sleep(5);
            Application.ProcessMessages;
            SrcList.Next;
            Continue;
          end;
          DstObj:= DstList.ItemByProp('KeyValue',SrcList.Current.S['KeyValue']);
          ObjRefStr:= KeyStringProperty + ': "' + SrcList.Current.S['KeyValue'] + '"';
        end
        else begin
          DstObj:= DstList.ItemByProp('GlobalRef',SrcList.Current.S['GlobalRef']);
          ObjRefStr:= 'GlobalRef: ' + SrcList.Current.S['GlobalRef'];
        end;
        ObjNeedsSynching:= false;
        if (not Assigned(DstObj)) then begin
          Inc(ChangeCount);
          if ChangeCount > 99 then begin
            Log('100 Items changed, skipping rest of list for now',ltWarning);
            Report.AddFail('Warning: ' + aClassName + ' 100 Items changed, skipping rest of list for now');
            exit;
          end;
          ObjNeedsSynching:= true;
          Log('Object ' + IntToStr(SrcList.Pos + 1) + ' of ' +IntToStr(SrcList.Count)+' "' + aClassName + '" (' + ObjRefStr + ') needs to be added to destination.', ltDetail);
          logStr:= 'Object "' + aClassName + '" (' + ObjRefStr + ') added to destination system.'
        end
        else if ListSourceTimeStampNewer(SrcList.Current, DstObj) then begin
          Inc(ChangeCount);
          if ChangeCount > 99 then begin
            Log('100 Items changed, skipping rest of list for now',ltWarning);
            Report.AddFail('Warning: ' + aClassName + ' 100 Items changed, skipping rest of list for now');
            exit;
          end;
          ObjNeedsSynching:= true;
          Log('Object ' + IntToStr(SrcList.Pos + 1) + ' of ' +IntToStr(SrcList.Count)+' "' + aClassName + '" (' + ObjRefStr + ') needs to be updated on destination system.', ltDetail);
  //        Log(    'Source TimeStamp (UTC): ' + FormatDateTime('yyyy-mm-dd hh:nn:ss',SrcList.Current.ItemByName['msTimeStamp'].Value.AsDateTime - SrcUtcOffset) +
  //          ' Dest TimeStamp (UTC): ' + FormatDateTime('yyyy-mm-dd hh:nn:ss',DstObj.ItemByName['msTimeStamp'].Value.AsDateTime - DstUtcOffset), ltInfo);
  //        Log(    'Source TimeStamp (' + ApiSource.URL + ':' + ApiSource.Database + '): ' +
  //          FormatDateTime('yyyy-mm-dd hh:nn:ss',SrcList.Current.ItemByName['msTimeStamp'].Value.AsDateTime) +
  //          ' Dest TimeStamp (' + ApiDest.URL + ':' + ApiDest.Database + '): ' +
  //          FormatDateTime('yyyy-mm-dd hh:nn:ss',DstObj.ItemByName['msTimeStamp'].Value.AsDateTime), ltDebug);
          logStr:= 'Object "' + aClassName + '" (' + ObjRefStr + ') updated on destination system.'
        end;

        if ObjNeedsSynching then begin
          StartTime := now;
          if not SyncItem(aClassName, SrcList.Current.I['ID'],subMsg) then begin
            WasError:= true;
            Log('Error synchronising "' + aClassName + '" (' + ObjRefStr + '): ' + subMsg, ltError);
            Report.AddFail('Error synchronising "' + aClassName + '" (' + ObjRefStr + '): ' + subMsg);
          end
          else begin
            DataChanged:= true;
            Log(logStr,ltInfo);
            Report.AddOk(logStr,now - StartTime);
          end
        end
        else begin

        end;
        if not WasError then begin
          if SrcList.Current.DT['msTimeStamp'] > dt then
            dt:= SrcList.Current.DT['msTimeStamp'];
        end;

  //      Sleep(5);
        Application.ProcessMessages;
        SrcList.Next;
      end;
    except
      on e: exception do begin
        result := false;
        msg := 'Exception while checking list for ' + aClassName + ': ' + e.Message;
        exit;
      end;
    end;
    if not WasError then
      SourceLastChangeTime[aClassName]:= dt;
    if not Active then exit;
    if DataChanged then begin
      fDataChanged:= true;

//      { reload the dest list }
//      DestLists.Delete(aClassName);
//      if not ApiDest.Get(aClassName,s) then begin
//        result:= false;
//        msg:= 'Error getting destination list ' + ApiDEst.ErrorMessage;
//        exit;
//      end;
//      DestLists.AddList(aClassName,s);
    end;
    Log('Finished synchronising object list for: ' + aClassName,ltDetail);
  finally
    DecLevel;
    CurrentSyncListItems.Delete(CurrentSyncListItems.IndexOf(aClassName));
  end;
end;

procedure TAPIDataSyncThread.DoWork;
var
  SiteIdx: integer;
  Site: TJsonObject;
  msg: string;
  NextSiteCheckTime: TDateTime;
  dt: TDateTime;
const
  OneHour = 1/24;
  OneMin = OneHour /60;

begin
  fNextCheckTime:= 0;
  try

    Config.AsString:= ConfigDb.Value;
    if (not Config.ArrayExists('Sites')) or (Config.A['Sites'].Count = 0) or
      (not Config.B['Active']) then
      exit;  { nothing to do }


    Module.Logger.SetLoggingLevel(TLoggingLevel(Config.I['LoggingLevel']));

    for SiteIdx := 0 to Config.A['Sites'].Count -1 do begin
      Site:= Config.A['Sites'].Items[SiteIdx].AsObject;
      if Site.B['Active'] and (Site.DT['NextSyncTime'] <= now) then begin
        try
          if (Site.O['Interval'].O['DayOfTheWeek'].B[IntToStr(DayOfTheWeek(now))]) then begin

            Report.Init(Site);
            dt:= now;
            Log('Checking "' + Site.S['Name'] + '" ...',ltInfo);
            if DoSync(Site, msg) then
              Log('Finished checking "' + Site.S['Name'] + '" (time taken: ' + FormatDateTime('hh:nn:ss',now-dt)+ ')',ltInfo)
            else begin
              Log('Error processing "' + Site.S['Name'] + '" (time taken: ' + FormatDateTime('hh:nn:ss',now-dt)+ '): ' + msg,ltError);
              Report.AddFail(msg);
            end;
            Report.Finalise

          end;
        finally
          NextSiteCheckTime:= now +
            (Site.O['Interval'].I['Hours'] * OneHour) + (Site.O['Interval'].I['Mins'] * OneMin);
          if SameText(Report.Status,'No Connection') and (NextSiteCheckTime > (now + (5 * OneMin))) then
            { if there are connection problems .. try at least every 5 mins }
            NextSiteCheckTime:= now + (5 * OneMin);
          UpdateConfigNextUpdateTime(Site.S['Name'],NextSiteCheckTime);

          if (fNextCheckTime = 0) or (NextSiteCheckTime < fNextCheckTime) then
            fNextCheckTime:= NextSiteCheckTime;
        end;
      end;
      if Terminated or (not Active) then break;
    end;
  finally
    if fNextCheckTime = 0 then
      fNextCheckTime:= now + ((1/24/60) * 2);   { defailt to 2 mins }
  end;
end;

procedure TAPIDataSyncThread.Execute;
begin
  try
    inherited;
    while not Terminated do begin
      try
        if (Now >= fNextCheckTime) then begin
          if Module.Status = msRunning then
            DoWork
          else
            if not Terminated then
              Terminate;
        end
        else begin
          Sleep(50);
          if Module.Status <> msRunning then
            if not Terminated then
              Terminate;
        end;
      except
      end;
    end;
  finally
    Module.Status := msStopped;
  end;
end;

function TAPIDataSyncThread.GetActive: boolean;
begin
  result := Module.Status = msRunning;
end;

function TAPIDataSyncThread.GetKeyStringPropertyName(aClassName: string;
  var aKeyStringPropertyName: string; var msg: string): boolean;
var
  aSchema: TBOSchema;
begin
  result:= false;
  if GetSchema(aClassName, aSchema, msg) then begin
    aKeyStringPropertyName:= aSchema.Schema.S['KeyStringProperty'];
    if aKeyStringPropertyName <> '' then
      result:= true
    else
      msg:= 'KeyStringProperty not defined for "' + aClassname + '"';
  end;
end;

function TAPIDataSyncThread.GetSourceLastChangeTime(aClassName: string): TDateTime;
begin
  result:= LastChangeTimes.GetLastChangeTime(aClassName,CurrentSite.S['Name'],ApiSource.URL,ApiSource.Database);
  Log('Get Source List Change Time: ' + ApiSource.URL + ' ' + ApiSource.Database + ' ' + CurrentSite.S['Name'] + ' ' + aClassName + ' ' + FormatDateTime('dd/mm/yyyy hh:nn:ss',result),ltDetail);
end;

function TAPIDataSyncThread.GetSchema(aClassName: string;
  var Schema: TBOSchema; var msg: string): boolean;
var
  s: string;
begin
  try
    Schema:= SchemaList.ByTypeName(aClassName);
    if not Assigned(Schema) then begin
      if self.ApiDest.Get(aClassName + '/Schema',s) then begin
        if s <> '' then begin
          Schema:= SchemaList.Add(s);
        end;
      end
      else begin
        result:= false;
        msg := 'GetSchema - unable to get schema info for '+ aClassName + ': ' + self.ApiDest.ErrorMessage;
        exit;
      end;
    end;
    result:= Assigned(Schema);
    if not result then
      msg:= 'Unable to obtain schema information for "' + aClassname + '"' + ' Error: ' + ApiDest.ErrorMessage;
  except
    on e: exception do begin
      result := false;
      msg:= 'GetSchema - (' + aClassName + '):' + e.Message;
    end;
  end;
end;

procedure TAPIDataSyncThread.IncLevel;
begin
  Inc(Level);
end;

procedure TAPIDataSyncThread.Log(msg: string; LogType: TLogMessageType);
var
  prefix: string;
  x: integer;
begin
  prefix:= SourceSiteCode + ' ';
  for x := 0 to Level-1 do
    prefix:= prefix + '   ';

  Module.Logger.Log(prefix + msg, LogType);
end;

function TAPIDataSyncThread.MappRefObj(Src, Dst, RefSchema: TJsonObject;
  DonePropList: TStringList; var msg: string): boolean;
var
//  SrcListRefItem,
//  DstListRefItem: TJsonObject;
  SrcRefItem,
  DstRefItem: TJsonObject;
  RefItemKeyStringProperty: string;
  Link: TJsonObject;
  LinkIdx: integer;
//  SrcList: TApiObjectListBase;
  SrcValue: string;
  Prop, RefProp: string;

//  val: string;
begin
//  RefSchema.Savetofile('c:\temp\temp.txt');
//  Log(RefSchema.AsString,ltDetail);
  result := true;
  { make sure this sub item has been synchronised between the systems first }
  if CheckReferenceObjects then begin
    result:= SupObjListSyncDone(RefSchema.S['type'], msg);
    if not result then exit;
  end;
  { get schema for this reference object }

//  SrcListRefItem:= nil;
//  DstListRefItem:= nil;
  SrcRefItem:= nil;
  DstRefItem:= nil;
  try
    try
      for LinkIdx := 0 to RefSchema.A['Links'].Count -1 do begin
        if (not Active) or Terminated then exit;

        Link:= RefSchema.A['Links'].Items[LinkIdx].AsObject;
        if not Src.O['Fields'].Exists(Link.S['Property']) then begin
          DonePropList.Add(Link.S['Property']);
          continue;
        end;

//        if not Assigned(SrcListRefItem) then begin
//          { find obj in source List }
//          SrcValue:= Src.O['Fields'].ItemByName[Link.S['Property']].Value.AsString;
//          if (SrcValue = '') or (SrcValue = '0') then begin
//            { just map it }
//            Dst.O['Fields'].ItemByName[Link.S['Property']].Value.AsString:= SrcValue;
//            continue;
//          end;
//          SrcList:= SourceLists.ListByType[RefSchema.S['type']];
//          SrcListRefItem:= SrcList.ItemByProp(Link.S['RefProperty'],SrcValue);
//          if not Assigned(SrcListRefItem) then
//            raise Exception.Create('Unable to find source list "'+
//              RefSchema.S['type'] +'" record for ' + Link.S['RefProperty'] + ': "' +
//              Src.O['Fields'].ItemByName[Link.S['Property']].Value.AsString + '"');
//          { now get the matching DestList item .. }
//          if not GetKeyStringPropertyName(RefSchema.S['type'],RefItemKeyStringProperty, msg) then begin
//            result:= false;
//            exit;
//          end;
//          DstListRefItem:= DestLists.ListByType[RefSchema.S['type']].ItemByProp(RefItemKeyStringProperty,SrcListRefItem.S[RefItemKeyStringProperty]);
//          if not Assigned(DstListRefItem) then begin
//            result:= false;
//            msg:= '"' + RefSchema.S['type'] + '" Sub object not found on destination system for "' + SrcListRefItem.S[RefItemKeyStringProperty] + '"';
//            Log(msg, ltWarning);
//            exit;
//          end;
//        end;

        Prop:= Link.S['Property'];
        RefProp:= Link.S['RefProperty'];
        SrcValue:= Src.O['Fields'].ItemByName[Prop].Value.AsString;
        if (SrcValue = '') or (SrcValue = '0') then begin
          { just map it }
          Dst.O['Fields'].ItemByName[Prop].Value.AsString:= SrcValue;
          continue;
        end;
//        GetKeyStringPropertyName(RefSchema.S['type'],RefItemKeyStringProperty, msg);
        if SameText(RefProp,'ID') then begin
          { we need to get data for this lookup object from source system }
          if not Assigned(SrcRefItem) then begin
            { use ID to get source ... }
            if not ApiSource.Get(RefSchema.S['type'], Src.O['fields'].I[Prop], SrcRefItem) then begin
              result:= false;
              msg:= '"' + RefSchema.S['type'] + '" Sub object could not be read from source system for ID: ' + IntToStr(Src.O['fields'].I[Prop]) + ' Error: ' + ApiSource.ErrorMessage;
              Log(msg, ltError);
              exit;
            end;
            { .. and dest (using source global ref }
            if not ApiDest.Get(RefSchema.S['type'], SrcRefItem.O['fields'].S['GlobalRef'], DstRefItem) then begin
              result:= false;
              msg:= '"' + RefSchema.S['type'] + '" Sub object could not be read from destination system for GlobalRef: "' + SrcRefItem.O['fields'].S['GlobalRef'] + '"' + ' Error: ' + ApiDest.ErrorMessage;
              Log(msg, ltError);
              exit;
            end;
          end;
        end;
        if not Assigned(DstRefItem) then begin
          if SameText(RefProp,'GlobalRef') then begin
            { use global ref to find dest sup object }
            if not ApiDest.Get(RefSchema.S['type'], Src.O['fields'].S[Prop], DstRefItem) then begin
              result:= false;
              msg:= '"' + RefSchema.S['type'] + '" Sub object could not be read from destination system for GlobalRef: "' + Src.O['fields'].S[Prop] + '"' + ' Error: ' + ApiDest.ErrorMessage;
              Log(msg, ltError);
              exit;
            end;
          end
          else begin
            { use GetKeyStringPropertyName ref to find dest sup object }
            if not GetKeyStringPropertyName(RefSchema.S['type'],RefItemKeyStringProperty, msg) then begin
              result:= false;
              Log(msg, ltError);
              exit;
            end;
            if not ApiDest.Get(RefSchema.S['type'] + '?KeyValue='+ UURIEncode.URIEncode(Src.O['fields'].S[Prop]), DstRefItem) then begin
              //JsonToFileFormated(Src,'c:\temp\temp.txt');
              result:= false;
              msg:= '"' + RefSchema.S['type'] + '" Sub object could not be read from destination system for '+RefItemKeyStringProperty+': "' + Src.O['fields'].S[Prop] + '"' + ' Error: ' + ApiDest.ErrorMessage;
              Log(msg, ltError);
              exit;
            end;
          end;
        end;

        { now map the data }
        if DonePropList.IndexOf(Prop) < 0 then begin
          if Dst.O['Fields'].Exists(Prop) then begin
            if DstRefItem.O['Fields'].Exists(RefProp) then begin
              Dst.O['Fields'].ItemByName[Prop].Value.AsString:=
                DstRefItem.O['Fields'].ItemByName[RefProp].Value.AsString;
            end
            else begin
              result:= false;
              msg:= 'Error mapping reference object, could not find property ' + RefProp +
                ' in destination list object: ' + DstRefItem.AsString;
              exit;
            end;
          end
          else begin
            result:= false;
            msg:= 'Error mapping reference object, could not find property ' + Prop +
              ' in object ' + Dst.S['type'];
            exit;
          end;
          DonePropList.Add(Prop);
        end;


//        { now map the data }
//        if DonePropList.IndexOf(Link.S['Property']) < 0 then begin
//          if Dst.O['Fields'].Exists(Link.S['Property']) then begin
//            Prop:= Link.S['Property'];
//            RefProp:= Link.S['RefProperty'];
//            if DstListRefItem.Exists(RefProp) then begin
//              Dst.O['Fields'].ItemByName[Prop].Value.AsString:=
//                DstListRefItem.ItemByName[RefProp].Value.AsString;
//            end
//            else begin
//              result:= false;
//              msg:= 'Error mapping reference object, could not find property ' + RefProp +
//                ' in destination list object: ' + DstListRefItem.AsString;
//              exit;
//            end;
//          end
//          else begin
//            result:= false;
//            msg:= 'Error mapping reference object, could not find property ' + Prop +
//              ' in object ' + Dst.S['type'];
//            exit;
//          end;
//          DonePropList.Add(Link.S['Property']);
//        end;
      end;
    finally
      SrcRefItem.Free;
      DstRefItem.Free;
    end;
//    Log('Finished mapping ref objects for: ' + Src.S['type'],ltDebug);
  except
    on e: exception do begin
      raise Exception.Create('Error while mapping sub object fields for ' + src.S['type'] + ' ' + e.ClassName + ' ' + e.Message);
    end;
  end;
end;

procedure TAPIDataSyncThread.SetSourceLastChangeTime(aClassName: string;
  const Value: TDateTime);
begin
  LastChangeTimes.SetLastChangeTime(Value,aClassName,CurrentSite.S['Name'],ApiSource.URL,ApiSource.Database);
  Log('Set Source List Change Time: ' + ApiSource.URL + ' ' + ApiSource.Database + ' ' + CurrentSite.S['Name'] + ' ' + aClassName + ' ' + FormatDateTime('dd/mm/yyyy hh:nn:ss',Value),ltDetail);
end;

function TAPIDataSyncThread.ListSourceTimeStampNewer(ObjSrc,
  ObjDst: TJsonObject): boolean;
var
  ValRel: TValueRelationship;
begin
  ValRel:= CompareDateTime((ObjSrc.ItemByName['msTimeStamp'].Value.AsDateTime - SrcUtcOffset),
    (ObjDst.ItemByName['msTimeStamp'].Value.AsDateTime - DstUtcOffset));
  result:= (ValRel = 1) or
           ((ValRel = 0) and (not SameText(ObjDst.S['msUpdateSiteCode'],ObjSrc.S['msUpdateSiteCode'])));
//  if result then begin
//    Log('List Source: ' + ObjSrc.ItemByName['msTimeStamp'].Value.AsString + ' ' + ObjSrc.S['msUpdateSiteCode'],ltInfo);
//    Log('List Dest: ' + ObjDst.ItemByName['msTimeStamp'].Value.AsString + ' ' + ObjDst.S['msUpdateSiteCode'],ltInfo);
//  end;
end;


function TAPIDataSyncThread.SourceTimeStampNewer(ObjSrc,
  ObjDst: TJsonObject): boolean;
var
  ValRel: TValueRelationship;
begin
  ValRel:= CompareDateTime((ObjSrc.O['fields'].ItemByName['msTimeStamp'].Value.AsDateTime - SrcUtcOffset),
    (ObjDst.O['fields'].ItemByName['msTimeStamp'].Value.AsDateTime - DstUtcOffset));
  result:= (ValRel = 1) or
           ((ValRel = 0) and (not SameText(ObjDst.O['fields'].S['msUpdateSiteCode'],ObjSrc.O['fields'].S['msUpdateSiteCode'])));
//  if result then begin
//    Log('Object Source: ' + ObjSrc.O['fields'].ItemByName['msTimeStamp'].Value.AsString + ' ' + ObjSrc.O['fields'].S['msUpdateSiteCode'],ltDetail);
//    Log('Object Dest: ' + ObjDst.O['fields'].ItemByName['msTimeStamp'].Value.AsString + ' ' + ObjDst.O['fields'].S['msUpdateSiteCode'],ltDetail);
//  end;
end;

function TAPIDataSyncThread.SupObjListSyncDone(aClassName: string; var msg: string): boolean;
begin
  result:= Assigned(DestLists.ListByType[aClassName]);
  if not result then  begin
    { sync this object }
    Log('Sub object list ('+aClassName+') not done, needs synching ..',ltDetail);
    result:= DoSyncList(aClassName, msg);
  end
  else
    Log('Sub object list ('+aClassName+') already done.',ltDetail);
end;

function TAPIDataSyncThread.SyncItem(aClassName: string; aId: integer; var msg: string): boolean;
var
  ObjSrc, ObjDst, PostResult: TJsonObject;
  x: integer;
  Schema: TBOSchema;
  found: boolean;
//  NewGlobRef: string;

  function UpdateSourceGlobalRef(aSrcClass: string; aSrcID: integer; var aNewGlobalRef, aMsg: string): boolean;
  var
    json, jsonRslt: TJsonObject;
  begin
    result:= true;
    aNewGlobalRef:= SrcSysInfo.O['fields'].S['SiteCode'] + IntToStr(aSrcID);
    jsonRslt:= nil;
    json:= TJsonObject.Create;
    try
      json.S['type']:= aSrcClass;
      json.O['fields'].I['ID']:= aSrcID;
      json.O['fields'].S['GlobalRef']:= aNewGlobalRef;
      if not ApiSource.Post(aSrcClass,json,jsonRslt) then begin
        result:= false;
        aMsg:= 'Failed updating source ' + aSrcClass + ' GlobalRef: ' + ApiSource.ErrorMessage;
        exit;
      end;
    finally
      json.Free;
      jsonRslt.Free;
    end;
  end;

  function CheckGlobalRefAndUpdateSiteCode(var aSrcObj: TJsonObject; aMsg: string): boolean;
  var
    json, jsonRslt: TJsonObject;
  begin
    result:= true;
    json:= nil;
    try
      if (aSrcObj.O['fields'].S['GlobalRef'] = '') then begin
        Log('GlobalRef blank for ' + aSrcObj.S['type'] + ' with ID ' +
          IntToStr(aSrcObj.O['fields'].I['ID']) + ', updating source object',ltWarning);
        json:= TJsonObject.Create;
        json.S['type']:= aSrcObj.S['type'];
        json.O['fields'].I['ID']:= aSrcObj.O['fields'].I['ID'];
        json.O['fields'].DT['MsTimeStamp']:= aSrcObj.O['fields'].DT['MsTimeStamp'];
        json.O['fields'].S['GlobalRef']:= SrcSysInfo.O['fields'].S['SiteCode'] + IntToStr(aSrcObj.O['fields'].I['ID']);
      end;
      if (not SameText(aSrcObj.O['fields'].S['msUpdateSiteCode'],SrcSysInfo.O['fields'].S['SiteCode'])) then begin
        if aSrcObj.O['fields'].S['msUpdateSiteCode'] = '' then
          Log('MsUpdateSiteCode blank for ' + aSrcObj.S['type'] + ' with ID ' +
            IntToStr(aSrcObj.O['fields'].I['ID']) + ', updating source object',ltWarning)
          else
          Log('MsUpdateSiteCode does not match site code for ' + aSrcObj.S['type'] + ' with ID ' +
            IntToStr(aSrcObj.O['fields'].I['ID']) + ', updating source object',ltWarning);
        if not Assigned(json) then begin
          json:= TJsonObject.Create;
          json.S['type']:= aSrcObj.S['type'];
          json.O['fields'].I['ID']:= aSrcObj.O['fields'].I['ID'];
          json.O['fields'].DT['MsTimeStamp']:= aSrcObj.O['fields'].DT['MsTimeStamp'];
        end;
        json.O['fields'].S['msUpdateSiteCode']:= SrcSysInfo.O['fields'].S['SiteCode'];
      end;
      if Assigned(json) then begin

        if not ApiSource.Post(json.S['type'] + '?RawMode=true',json,jsonRslt) then begin
          result:= false;
          aMsg:= 'Failed updating source ' + json.S['type'] + ': ' + ApiSource.ErrorMessage;
          Log(aMsg,ltError);
          exit;
        end;
        { now reload our source object }
        if not ApiSource.Get(json.S['type'],json.O['fields'].I['ID'],aSrcObj) then begin
          result:= false;
          aMsg:= 'Failed reading updated source ' + json.S['type'] + ': ' + ApiSource.ErrorMessage;
          Log(aMsg,ltError);
          exit;
        end
        else begin
          { check we now have the values }
          if (aSrcObj.O['fields'].S['GlobalRef'] = '') then begin
            msg:= 'Failed to update source object GlobalRef';
            Log(msg,ltWarning);
            result:= false;
            exit;
          end
          else if (not SameText(aSrcObj.O['fields'].S['msUpdateSiteCode'],SrcSysInfo.O['fields'].S['SiteCode'])) then begin
            msg:= 'Failed to update source object msUpdateSiteCode';
            Log(msg,ltWarning);
            result:= false;
            exit;
          end;
        end;
      end;
    finally
      json.Free;
    end;
  end;


  function MapObj(Src, Dst: TJsonObject; var subMsg: string): boolean;
  var
    i: integer;
    Sch: TBOSchema;
    PairSrc, PairDst, aNewPair: TJSONValuePair;
    subSrc, subDst: TJsonObject;
    arrSrc, arrDst: TJSONArray;
    arrIdx: integer;
    GlobalList, MappedPropList: TStringList;
    GlobalRef: string;
    Ref: TJsonObject;
  begin
    result:= true;
    MappedPropList:= TStringList.Create;
    try
      try
        if GetSchema(Src.S['type'], Sch, subMsg) then begin
          for i := 0 to Src.O['fields'].Count -1 do begin
            PairSrc:= Src.O['fields'].Items[i];
            if SameText(PairSrc.Name,'ID') then
              continue;
            { make sure property exists in destination and is of same type }
            if (not Dst.O['fields'].Exists(PairSrc.Name)) then begin
              { add it ...  }
              aNewPair := nil;
              case PairSrc.ValueType of
                valNone:;
                valString: aNewPair := TJSONValuePair.Create(valString);
                valNumber: aNewPair := TJSONValuePair.Create(valNumber);
                valObject: aNewPair := TJSONValuePair.Create(valObject);
                valArray: aNewPair := TJSONValuePair.Create(valArray);
                valNull: aNewPair := TJSONValuePair.Create(valNull);
                valBoolean:  aNewPair := TJSONValuePair.Create(valBoolean);
              end;
              if Assigned(aNewPair) then begin
                aNewPair.Name := PairSrc.Name;
                Dst.O['fields'].Add(aNewPair);
              end
              else begin
                subMsg:= 'Error mapping from "' +
                  Src.S['type'] + '", could not find property "' + PairSrc.Name +
                  '" in destination object "' + Dst.S['type'] + '"';
                result:= false;
                exit;
              end;
            end;
            PairDst:= Dst.O['fields'].ItemByName[PairSrc.Name];

            if PairSrc.Value.ValueType = valNull then begin
              { source is null to change dest to null }
              PairDst.ValueType:= valNull;
              Continue;  { skip to next }
            end
            else if PairDst.Value.ValueType = valNull then begin
              { dest was null so change to same type as source }
              PairDst.ValueType:= PairSrc.Value.ValueType;

              { if its an object, copy drom source }
              if PairSrc.Value.ValueType = valObject then begin
                { copy data from source }
                PairDst.Value.AsObject.Assign(PairSrc.Value.AsObject);

                { remove ID's from JSON }
                RemoveIdFields(PairDst.Value.AsObject);

              end;

            end
            else if (PairSrc.Value.ValueType <> PairDst.Value.ValueType) then begin
              subMsg:= 'Error mapping from "' +
                Src.S['type'] + '", property "' + PairSrc.Name +
                '" type does not match destination property type for destination object "' + Dst.S['type'] + '"';
              result:= false;
              exit;
            end;
            if PairSrc.Value.ValueType = valObject then begin
              { sub object }
              subSrc:= PairSrc.Value.AsObject;

//              subDst:= Dst.O[PairSrc.Name];
              subDst:= PairDst.Value.AsObject;

              if not MapObj(subSrc, subDst, subMsg) then begin
                result:= false;
                exit;
              end;
            end
            else if PairSrc.Value.ValueType = valArray then begin
              { array }
              arrSrc:= TJSONArray(PairSrc.Value);
              if (arrSrc.Count > 0) and (arrSrc.Items[0].ValueType = valObject) then begin
                { array of objects  eg sub object like lines }
                arrDst:= TJSONArray(PairDst.Value);
                GlobalList:= TStringList.Create;
                try
                  for arrIdx := 0 to arrSrc.Count - 1 do begin
                    if not Active then exit;

                    subSrc:= arrSrc.Items[arrIdx].AsObject;
                    if not CheckGlobalRefAndUpdateSiteCode(subSrc,msg) then
                      exit;
                    GlobalRef:= subSrc.O['fields'].S['GlobalRef'];
//                    if GlobalRef = '' then begin
//                      { try and add glodal ref to source object }
//                      Log('GlobalRef blank for ' + Src.S['type'] + ' with ID ' +
//                        IntToStr(subSrc.O['fields'].I['ID']) + ', updating source object',ltWarning);
//
//                      if not UpdateSourceGlobalRef(subSrc.S['type'],subSrc.O['fields'].I['ID'],GlobalRef,msg) then begin
//                        result:= false;
//                        Log(msg,ltError);
//                        exit;
//                      end;
//
//                      subSrc.O['fields'].S['GlobalRef']:= GlobalRef;
//
//                    end;
                    GlobalList.Add(GlobalRef);
                    subDst:= ArrayObjectByGlobalRef(arrDst, GlobalRef);
                    if not Assigned(subDst) then begin
                      subDst:= JO;
                      subDst.Assign(SubSrc);
                      RemoveIdFields(subDst);
                      arrDst.Add(subDst);
                    end;
                    if not MapObj(subSrc, subDst, subMsg) then begin
                      result:= false;
                      exit;
                    end;
                  end;
                  { delete globalrefs from dest array that are missing from source }
                  DeleteGlobalRefsNotInList(GlobalList,arrDst);
                finally
                  GlobalList.Free;
                end;
              end
              else begin
                { simple type array so just assign to dest }
                TJSONArray(PairDst.Value).Assign(arrSrc);

              end;
            end
            else begin
              { simple field }
              { ToDo check for ref fields }
              if Sch.IsRefProp(PairSrc.Name) then  begin
                { this is a field referencing a lookup referenc object }
                if (PairSrc.Value.AsString = '') or (PairSrc.Value.AsString = '0') then
                  { blank ref so just map it }
                  PairDst.Value.AsString:= PairSrc.Value.AsString
                else begin

                  { get reference data from schema }
                  Ref:= Sch.RefTypeByProperty(PairSrc.Name);

                  { map ref object fields }
                  Log('Mapping ' + Src.S['Type'] + ' sup object property ' + PairSrc.Name + ' ..', ltDetail);
                  if not MappRefObj(Src,Dst,Ref,MappedPropList, subMsg) then begin
                    result:= false;
                    exit;
                  end;

                end;
              end
              else begin
                if not SameText(PairSrc.Name,'ID') then  { should be no ID's at this stage ... but just in case }
                  if PairSrc.ValueType = valNull then begin
                    if PairDst.ValueType <> valNull then begin
                      PairDst.ValueType:= valNull;
                    end;
                  end
                  else if SameText(PairSrc.Name,'msTimeStamp') then begin
                    {  adjust for time zones }
                    PairDst.Value.AsDateTime:= (PairSrc.Value.AsDateTime - SrcUtcOffset) + DstUtcOffset;
//                    Log('Setting TimeStamp to: ' + FormatDateTime('yyyy-mm-dd hh:nn:ss',PairDst.Value.AsDateTime),ltDebug);
                  end
                  else
                    PairDst.Value.AsString:= PairSrc.Value.AsString;
              end;
            end;
          end;
//          Log('TimeStamp: ' + FormatDateTime('yyyy-mm-dd hh:nn:ss',  Dst.O['fields'].DT['msTimeStamp']),ltDebug);
        end
        else
          result:= false;
      finally
        MappedPropList.Free;
      end;
    except
      on e: exception do begin
        result:= false;
        subMsg:= 'Error while mapping "' +
          Src.S['type'] + '", with error:  ' + e.Message;
      end;
    end;
  end;

begin
  IncLevel;
  try
    result:= true;
    Log('Synchronising ' + aClassName, ltDetail);
    if not GetSchema(aClassName, Schema, msg) then begin
      result:= false;
      exit;
    end;
    PostResult:= JO;
    try
      if ApiSource.Get(aClassName,aId,ObjSrc) then begin

        Log('GlobalRef: ' + ObjSrc.O['fields'].S['GlobalRef'], ltDetail);
//        if (aClassName = 'TOtherContact') and (ObjSrc.O['fields'].S['GlobalRef'] = 'DEF54') then
//          Beep;

        { remove reference objects from source }
        for x := 0 to Schema.IgnoreFieldList.Count -1 do
          ObjSrc.O['fields'].Delete(Schema.IgnoreFieldList[x]);

        if (Schema.Schema.S['KeyStringProperty'] <> '') then begin
//          if ObjSrc.O['fields'].S[Schema.Schema.S['KeyStringProperty']] = '' then begin
          if ObjSrc.O['fields'].S['KeyValue'] = '' then begin
            result:= false;
            Log(Schema.Schema.S['KeyStringProperty'] + ' Key Value missing from "' + ObjSrc.S['type'] + '"',ltError);
            exit;
          end;
        end;
//        else if ObjSrc.O['fields'].S['GlobalRef'] = '' then begin
//          Log('GlobalRef blank for ' + aClassName + ' with ID ' +
//            IntToStr(aID) + ', updating source object',ltWarning);
//          { try updating it }
//          if not UpdateSourceGlobalRef(aClassName,aId,NewGlobRef,msg) then begin
//            result:= false;
//            Log(msg,ltError);
//            exit;
//          end;
//          ObjSrc.O['fields'].S['GlobalRef']:= NewGlobRef;
//        end;
        if not CheckGlobalRefAndUpdateSiteCode(ObjSrc,msg) then begin
          result:= false;
          exit;
        end;


        found := false;
        if (Schema.Schema.S['KeyStringProperty'] <> '') then begin
          if ApiDest.Get(aClassName + '?KeyValue=' + UURIEncode.URIEncode(ObjSrc.O['fields'].S['KeyValue']),ObjDst) then begin
            { found it with KeyValue ... }
            found:= true;
          end
          else begin
            { now was it not found (404) ... or a comms error }
            if ApiDest.ResponseCode <> 404 then begin
              result:= false;
              msg:= Apidest.ErrorMessage;
              exit;
            end;
          end;
        end
        else begin
          { use global ref }
          if ApiDest.Get(aClassName,ObjSrc.O['fields'].S['GlobalRef'],ObjDst) then begin
            { found it with GlobalRef ... }
            found:= true;
          end
          else begin
            { now was it not found (404) ... or a comms error }
            if ApiDest.ResponseCode <> 404 then begin
              result:= false;
              msg:= Apidest.ErrorMessage;
              exit;
            end;
          end;
        end;


        if found then begin

          { check time stamps again as users may have changed somthing since we got the lists }
          if not SourceTimeStampNewer(ObjSrc,ObjDst) then begin
            Log('... user updated destination, skipping.', ltDetail);
            exit;
          end;

          { exists in dest system }
          Log('... found, updating from source', ltDetail);

          { remove reference objects }
          for x := 0 to Schema.IgnoreFieldList.Count -1 do
            ObjDst.O['fields'].Delete(Schema.IgnoreFieldList[x]);
        end
        else begin
          Log('... not found, copying from source', ltDetail);
          ObjDst:= TJsonObject.Create;

          { copy data from source }
          ObjDst.Assign(ObjSrc);

          { remove ID's from JSON }
          RemoveIdFields(ObjDst);
        end;

        if ObjSrc.O['fields'].S['GlobalRef'] = '' then begin
          Log('... global ref is blank, adding', ltDetail);
          ObjSrc.O['fields'].S['GlobalRef']:= DstSysInfo.O['Fields'].S['SiteCode'] + IntToStr(ObjSrc.O['fields'].I['ID']);
        end;

//        JsonToFileFormated(ObjSrc,'c:\temp\synch\Src_' + aClassName + '_' + FormatDateTime('yyyy-mm-dd_hh:nn:ss',now) +  '.txt');
//        JsonToFileFormated(ObjDst,'c:\temp\Json_Dst.txt');
        if MapObj(ObjSrc,ObjDst, msg) then begin
          { Post the dest object }
//          JsonToFileFormated(ObjSrc,'c:\temp\sync\Src_' + aClassName + '_' + FormatDateTime('yyyy-mm-dd_hhnnss',now) +  '.txt');
//          JsonToFileFormated(ObjDst,'c:\temp\sync\Dst_' + aClassName + '_' + FormatDateTime('yyyy-mm-dd_hhnnss',now) +  '.txt');
          if not ApiDest.Post(ObjDst.S['type'] + '?RawMode=true',ObjDst,PostResult) then begin
            result:= false;
            msg:= Apidest.ErrorMessage;
            exit;
          end;
        end
        else begin
          result:= false;
//          JsonToFileFormated(ObjDst,'c:\temp\Json_Dst_After_Fail.txt');
        end;
      end
      else begin
        result:= false;
        msg:= ApiSource.ErrorMessage;
      end;
      Log(aClassName + ' Done.', ltDetail);
    finally
      ObjSrc.Free;
      ObjDst.Free;
    end;
  finally
    DecLevel;
  end;
end;

procedure TAPIDataSyncThread.UpdateConfigNextUpdateTime(SiteName: string;
  UpdateTime: TDateTime);
var
  obj, site: TJsonObject;
  x: integer;
begin
  obj:= JO;
  try
    obj.AsString:= ConfigDb.Value;
    for x := 0 to obj.A['Sites'].Count -1 do begin
      site:= obj.A['Sites'].Items[x].AsObject;
      if SameText(site.S['Name'],SiteName) then begin
        site.DT['NextSyncTime']:= UpdateTime;
        ConfigDb.Value:= obj.AsString;
        break;
      end;
    end;
  finally
    obj.Free;
  end;
end;

end.
