unit APIDataSyncObj;

interface

uses
  JsonObject, extctrls, IdHttp, {DataSyncDbObj,} BusObjSchemaLib, WebApiClientObj,
  ApiObjectListObj, Classes, LogMessageTypes, LogThreadLib, SyncObjs, ConfigDbObj;

type
  TSynchDirection = (sdForward, sdReverse);

  TAPIDataSyncThread = class(TThread)
  private
    Config: TJsonObject;
    Lock: TCriticalSection;
    fLogger: TLogger;
    fIdle: boolean;
    fNextCheckTime: TDateTime;
    SchemaList: TBOSchemaList;
    SourceLists,
    DestLists: TApiObjectLists;
    ApiSource,
    ApiDest: TWebApiClient;
    Level: integer;
    SrcSysInfo,
    DstSysInfo: TJsonObject;
    fCurrentSiteName: string;
    SrcUtcOffset,
    DstUTCOffset: TDateTime;
    CurrentSyncListItems: TStringList;
    ConfigDb: TConfigDb;
    fActive: boolean;
    function GetIdle: boolean;
    procedure SetIdle(const Value: boolean);
    procedure DoWork;
    procedure Log(msg: string; LogType: TLogMessageType);
    procedure SendSiteStatus(aStatus, aMessage: string);
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
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
    property Logger: TLogger read fLogger write fLogger;
    property Idle: boolean read GetIdle;
    property Active: boolean read fActive write fActive;
  end;


const
  ResultStatus_Ok = 'OK';
  ResultStatus_Sync = 'Sync';
  ResultStatus_Fail = 'Fail';
  ResultStatus_Warn = 'Warning';

  Event_SiteStatus = 'SiteStatus';
  Event_IdleStatus = 'IdleStatus';

implementation

uses
  sysutils, forms, IdSSLOpenSSL, JsonObjectUtils, DateUtils, types;

const
  TypesToSynch: array[0..1] of string =
    ('TPhoneSupportLog',
     'TMarketingContact');

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

constructor TAPIDataSyncThread.Create(CreateSuspended: Boolean);
begin
  inherited;
  ConfigDb:= TConfigDb.Create('SiteIntergration','localhost');
  fIdle:= true;
  fNextCheckTime:= now + ((1/24/60/60) * 10);
  FreeOnTerminate:= false;
//  Priority:= tpLower;
  Priority:= tpNormal;
  Config:= TJsonObject.Create;
  Lock:= TCriticalSection.Create;
  SchemaList:= TBOSchemaList.Create;
  SourceLists:= TApiObjectLists.Create;
  DestLists:= TApiObjectLists.Create;
  CurrentSyncListItems:= TStringList.Create;
  Level:= 0;
  fActive:= true;
  Resume;
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
  Lock.Free;
  ConfigDb.Free;
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
begin
  result:= true;
  ApiSrc:= TWebApiClient.Create;
  ApiDst:= TWebApiClient.Create;
  fSrcSysInfo:= JO;
  fDstSysInfo:= JO;
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

    SrcUtcOffset:= self.SrcSysInfo.O['fields'].ItemByName['UTCOffset'].Value.AsDateTime;
    DstUtcOffset:= self.DstSysInfo.O['fields'].ItemByName['UTCOffset'].Value.AsDateTime;

    SourceLists.Clear;
    DestLists.Clear;

    Log('Starting forward synchronisation (updating destination data with newer source data).',ltDetail);
//      for x:= 0 to Site.A['SyncList'].Count -1 do begin
    for x:= Low(TypesToSynch) to High(Low(TypesToSynch)) do begin
      if not Active then exit;
//        if not DoSyncList(Site.A['SyncList'].Items[x].AsString, msg) then begin
      if not DoSyncList(TypesToSynch[x], msg) then begin
        if result then
          result:= false;
        break;
      end;
    end;

    if Site.B['TwoWaySynch'] then begin
      { now synch back the other way }
      Log('Starting reverse synchronisation (updating source data with newer destination data).',ltDetail);

      ApiSource:= ApiDst;
      ApiDest:= ApiSrc;

      SrcSysInfo:= fDstSysInfo;
      DstSysInfo:= fSrcSysInfo;

      SrcUtcOffset:= self.DstSysInfo.O['fields'].ItemByName['UTCOffset'].Value.AsDateTime;
      DstUtcOffset:= self.SrcSysInfo.O['fields'].ItemByName['UTCOffset'].Value.AsDateTime;

      SourceLists.Clear;
      DestLists.Clear;

//      for x:= 0 to Site.A['SyncList'].Count -1 do begin
      for x:= Low(TypesToSynch) to High(Low(TypesToSynch)) do begin
        if not Active then exit;
//        if not DoSyncList(Site.A['SyncList'].Items[x].AsString, msg) then begin
        if not DoSyncList(TypesToSynch[x], msg) then begin
          if result then
            result:= false;
          break;
        end;
      end;
    end;

  finally
    FreeAndNil(ApiSrc);
    FreeAndNil(ApiDst);
    FreeAndNil(fSrcSysInfo);
    FreeAndNil(fDstSysInfo);
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
  x: integer;

//  function CompDateTime(const A, B: TDateTime): TValueRelationship;
//  var
//    AYear, AMonth, ADay, AHour, AMin, ASec, AMill: word;
//    BYear, BMonth, BDay, BHour, BMin, BSec, BMill: word;
//  begin
//    DecodeDate(A,AYear,AMonth,ADay);
//    DecodeTime(A,AHour,AMin,ASec,AMill);
//    DecodeDate(B,BYear,BMonth,BDay);
//    DecodeTime(B,BHour,BMin,BSec,BMill);
//    if (AYear = BYear) and (AMonth = BMonth) and (ADay = BDay) and
//       (AHour = BHour) and (AMin = BMin) and (ASec = BSec) then
//      result:= 0
//    else if (AYear > BYear) then
//      result:= 1
//    else if (AYear < BYear) then
//      result:= -1
//    else begin
//      if (AMonth > BMonth) then
//        result:= 1
//      else if (AMonth < BMonth) then
//        result:= -1
//      else begin
//        if (ADay > BDay) then
//          result:= 1
//        else if (ADay < BDay) then
//          result:= -1
//        else begin
//          if (AHour > BHour) then
//            result:= 1
//          else if (AHour < BHour) then
//            result:= -1
//          else begin
//            if (AMin > BMin) then
//              result:= 1
//            else if (AMin < BMin) then
//              result:= -1
//            else begin
//              if (ASec > BSec) then
//                result:= 1
//              else if (ASec < BSec) then
//                result:= -1
//              else begin
//                result:= 0;
//              end;
//            end;
//          end;
//        end;
//      end;
//    end;
//  end;



  function SourceTimeStampNewer(ObjSrc, ObjDst: TJsonObject): boolean;
  begin
    result:= CompareDateTime((ObjSrc.ItemByName['msTimeStamp'].Value.AsDateTime - SrcUtcOffset),
      (ObjDst.ItemByName['msTimeStamp'].Value.AsDateTime - DstUtcOffset)) = 1;
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

    for x := 0 to Schema.RefTypesCount -1 do begin
      Log('.. Checking sub reference object: ' + Schema.RefType[x].S['Type'],ltDetail);
      if not SupObjListSyncDone(Schema.RefType[x].S['Type'],msg) then begin
        result:= false;
        exit;
      end;
    end;

    SourceLists.Delete(aClassName);
    DestLists.Delete(aClassName);

    Log('Getting source list ...',ltDetail);
    if not ApiSource.Get(aClassName,s) then begin
      result:= false;
      msg:= 'Error getting source list ' + ApiSource.ErrorMessage;
      exit;
    end;
    SourceLists.AddList(aClassName,s);
    SrcList:= SourceLists.ListByType[aClassName];
    Log('  Done, source list count = ' + IntToStr(SrcList.Count),ltDetail);


    if (not Active) or Terminated then exit;
    Log('Getting destination list ...',ltDetail);
    if not ApiDest.Get(aClassName,s) then begin
      result:= false;
      msg:= 'Error getting destination list ' + ApiDEst.ErrorMessage;
      exit;
    end;
    DestLists.AddList(aClassName,s);
    DstList:= DestLists.ListByType[aClassName];
    Log('  Done, destination list count = ' + IntToStr(DstList.Count),ltDetail);


    DataChanged:= false;
    SrcList.First;
    ChangeCount:= 0;
    TotalCount:= 0;
    ListTotal:= SrcList.Count;
    while not SrcList.EOF do begin
      Sleep(5);
      if (not Active) or Terminated then exit;
      Inc(TotalCount);
      if (TotalCount = 1) or (Frac(TotalCount / 50) = 0) then
        Log('Checking "' + aClassName + '" ' + IntToStr(TotalCount) + ' of ' + IntToStr(ListTotal), ltDetail);

      KeyStringProperty:= Schema.Schema.S['KeyStringProperty'];
      if KeyStringProperty <> '' then begin
        DstObj:= DstList.ItemByProp(KeyStringProperty,SrcList.Current.S[KeyStringProperty]);
        ObjRefStr:= KeyStringProperty + ': "' + SrcList.Current.S[KeyStringProperty] + '"';
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
          exit;
        end;
        ObjNeedsSynching:= true;
        Log('Object "' + aClassName + '" (' + ObjRefStr + ') needs to be added to destination.', ltDetail);
      end
      else if SourceTimeStampNewer(SrcList.Current, DstObj) then begin
        Inc(ChangeCount);
        if ChangeCount > 99 then begin
          Log('100 Items changed, skipping rest of list for now',ltWarning);
          exit;
        end;
        ObjNeedsSynching:= true;
        Log('Object "' + aClassName + '" (' + ObjRefStr + ') needs to be updated on destination system.', ltDetail);
      end;

      if ObjNeedsSynching then begin
        if not SyncItem(aClassName, SrcList.Current.I['ID'],subMsg) then begin
          //result:= false;
          //exit;
          Log('Error synchronising "' + aClassName + '" (' + ObjRefStr + '): ' + subMsg, ltWarning);
          SrcList.Next;
          Continue;
        end
        else
          DataChanged:= true;
      end
      else begin
//        Sleep(10);
//        Application.ProcessMessages;
//        if not Active then exit;
      end;
      Sleep(5);
      Application.ProcessMessages;
      SrcList.Next;
    end;
    if not Active then exit;
    if DataChanged then begin
      { reload the dest list }
      DestLists.Delete(aClassName);
      if not ApiDest.Get(aClassName,s) then begin
        result:= false;
        msg:= 'Error getting destination list ' + ApiDEst.ErrorMessage;
        exit;
      end;
      DestLists.AddList(aClassName,s);
    end;
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
const
  OneHour = 1/24;
  OneMin = OneHour /60;

begin
//  fNextCheckTime:= now + ((1/24/60) * 15);   { defailt to 15 mins }
  fNextCheckTime:= 0;
  try

    Config.AsString:= ConfigDb.Value;
    if (not Config.ArrayExists('Sites')) or (Config.A['Sites'].Count = 0) then
      exit;  { nothing to do }

    for SiteIdx := 0 to Config.A['Sites'].Count -1 do begin
      Site:= Config.A['Sites'].Items[SiteIdx].AsObject;
      if Site.B['Active'] and (Site.DT['NextSyncTime'] <= now) then begin
        try
          if (Site.O['Interval'].O['DayOfTheWeek'].B[IntToStr(DayOfTheWeek(now))]) then begin

            SendSiteStatus(ResultStatus_Sync,'Checking ...');
            if DoSync(Site, msg) then
              SendSiteStatus(ResultStatus_Ok,'Done: ' + FormatDateTime('dd/mm/yy hh:nn:ss',now))
            else
              SendSiteStatus(ResultStatus_Fail,msg);

          end;
        finally
          NextSiteCheckTime:= now +
            (Site.O['Interval'].I['Hours'] * OneHour) + (Site.O['Interval'].I['Mins'] * OneMin);
          UpdateConfigNextUpdateTime(Site.S['Name'],NextSiteCheckTime);

          if (fNextCheckTime = 0) or (NextSiteCheckTime < fNextCheckTime) then
            fNextCheckTime:= NextSiteCheckTime;
        end;
      end;
      if Terminated or (not Active) then break;
    end;
  finally
    if fNextCheckTime = 0 then
      fNextCheckTime:= now + ((1/24/60) * 15);   { defailt to 15 mins }
  end;
end;

procedure TAPIDataSyncThread.Execute;
begin
  inherited;
  while not Terminated do begin
    try
      if (Now >= fNextCheckTime) and Active then begin
        SetIdle(false);
        try
          try
            DoWork;
          except;
          end;
//          fNextCheckTime:= now + Interval;
        finally
          SetIdle(true);
        end;
      end
      else begin
        Sleep(50);
        Application.ProcessMessages;
      end;
    except
    end;
  end;

end;

function TAPIDataSyncThread.GetIdle: boolean;
begin
  Lock.Acquire;
  try
    result:= fIdle;
  finally
    Lock.Release;
  end;
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

function TAPIDataSyncThread.GetSchema(aClassName: string;
  var Schema: TBOSchema; var msg: string): boolean;
var
  s: string;
begin
  Schema:= SchemaList.ByTypeName(aClassName);
  if not Assigned(Schema) then begin
    if self.ApiDest.Get(aClassName + '/Schema',s) then begin
      if s <> '' then begin
        Schema:= SchemaList.Add(s);
      end;
    end;
  end;
  result:= Assigned(Schema);
  if not result then
    msg:= 'Unable to obtain schema information for "' + aClassname + '"';
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
  if Assigned(fLogger) then begin
    prefix:= '';
    for x := 0 to Level-1 do
      prefix:= prefix + '   ';

    fLogger.Log(prefix + msg, LogType);
  end;
end;

function TAPIDataSyncThread.MappRefObj(Src, Dst, RefSchema: TJsonObject;
  DonePropList: TStringList; var msg: string): boolean;
var
  SrcListRefItem,
  DstListRefItem: TJsonObject;
  RefItemKeyStringProperty: string;
  Link: TJsonObject;
  LinkIdx: integer;
  SrcList: TApiObjectListBase;
  SrcValue: string;
begin
  { make sure this sub item has been synchronised between the systems first }
  result:= SupObjListSyncDone(RefSchema.S['type'], msg);
  if not result then exit;
  { get schema for this reference object }

  SrcListRefItem:= nil;
  DstListRefItem:= nil;
  try
    for LinkIdx := 0 to RefSchema.A['Links'].Count -1 do begin
      if (not Active) or Terminated then exit;

      Link:= RefSchema.A['Links'].Items[LinkIdx].AsObject;
      if not Src.O['Fields'].Exists(Link.S['Property']) then begin
        DonePropList.Add(Link.S['Property']);
        continue;
      end;
      if not Assigned(SrcListRefItem) then begin
        { find obj in source List }
        SrcValue:= Src.O['Fields'].ItemByName[Link.S['Property']].Value.AsString;
        if (SrcValue = '') or (SrcValue = '0') then begin
          { just map it }
          Dst.O['Fields'].ItemByName[Link.S['Property']].Value.AsString:= SrcValue;
          continue;
        end;
        SrcList:= SourceLists.ListByType[RefSchema.S['type']];
        SrcListRefItem:= SrcList.ItemByProp(Link.S['RefProperty'],SrcValue);
//        SrcListRefItem:= SourceLists.ListByType[RefSchema.S['type']].ItemByProp(Link.S['RefProperty'],Src.O['Fields'].ItemByName[Link.S['Property']].Value.AsString);
        if not Assigned(SrcListRefItem) then
          raise Exception.Create('Unable to find source list "'+
            RefSchema.S['type'] +'" record for ' + Link.S['RefProperty'] + ': ' +
            Src.O['Fields'].ItemByName[Link.S['Property']].Value.AsString);
        { now get the matching DestList item .. }
        if not GetKeyStringPropertyName(RefSchema.S['type'],RefItemKeyStringProperty, msg) then begin
          result:= false;
          exit;
        end;
        DstListRefItem:= DestLists.ListByType[RefSchema.S['type']].ItemByProp(RefItemKeyStringProperty,SrcListRefItem.S[RefItemKeyStringProperty]);
        if not Assigned(DstListRefItem) then begin
          result:= false;
          msg:= '"' + RefSchema.S['type'] + '" Sub object not found on destination system for "' + SrcListRefItem.S[RefItemKeyStringProperty] + '"';
          Log(msg, ltWarning);
          exit;
        end;
      end;
      { now map the data }
      if DonePropList.IndexOf(Link.S['Property']) < 0 then begin
        if Dst.O['Fields'].Exists(Link.S['RefProperty']) then
          Dst.O['Fields'].ItemByName[Link.S['Property']].Value.AsString:=
            DstListRefItem.ItemByName[Link.S['RefProperty']].Value.AsString;
        DonePropList.Add(Link.S['Property']);
      end;
    end;
  except
    on e: exception do begin
      raise Exception.Create('Error while mapping sub object fields for ' + src.S['type'] + ' ' + e.ClassName + ' ' + e.Message);
    end;
  end;
end;

procedure TAPIDataSyncThread.SendSiteStatus(aStatus, aMessage: string);
begin
  if Assigned(fLogger) then begin
    with JO do begin
      try
        S['SiteName']:= fCurrentSiteName;
        S['Status']:= aStatus;
        S['Message']:= aMessage;
        fLogger.Events.FireEvent(nil,Event_SiteStatus,AsString);
      finally
        Free;
      end;
    end;
    if aStatus = ResultStatus_Fail then
      Log('[' + fCurrentSiteName + ']  ' +  aStatus + '  ' + aMessage, ltError)
    else if aStatus = ResultStatus_Warn then
      Log('[' + fCurrentSiteName + ']  ' +  aStatus + '  ' + aMessage, ltWarning)
    else
      Log('[' + fCurrentSiteName + ']  ' +  aStatus + '  ' + aMessage, ltDetail);
  end;
end;

procedure TAPIDataSyncThread.SetIdle(const Value: boolean);
begin
  Lock.Acquire;
  try
    fIdle:= value;
  finally
    Lock.Release;
  end;
  if Assigned(fLogger) then begin
    if Value then
      fLogger.Events.FireEvent(nil,Event_IdleStatus,'Working')
    else
      fLogger.Events.FireEvent(nil,Event_IdleStatus,'Waiting');
  end;
end;

function TAPIDataSyncThread.SupObjListSyncDone(aClassName: string; var msg: string): boolean;
begin
  result:= Assigned(DestLists.ListByType[aClassName]);
  if not result then  begin
    { sync this object }
    result:= DoSyncList(aClassName, msg);
  end;
end;

function TAPIDataSyncThread.SyncItem(aClassName: string; aId: integer; var msg: string): boolean;
var
  ObjSrc, ObjDst, PostResult, Obj: TJsonObject;
  x: integer;
  Schema: TBOSchema;

  function MapObj(Src, Dst: TJsonObject; var subMsg: string): boolean;
  var
    i: integer;
    Sch: TBOSchema;
    PairSrc, PairDst: TJSONValuePair;
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
              subMsg:= 'Error mapping from "' +
                Src.S['type'] + '", could not find property "' + PairSrc.Name +
                '" in destination object "' + Dst.S['type'] + '"';
              result:= false;
              exit;
            end;
            if PairSrc.Value.ValueType = valNull then begin
              { source is null to change dest to null }
              Dst.O['fields'].ItemByName[PairSrc.Name].ValueType:= valNull;
              Continue;  { skip to next }
            end
            else if Dst.O['fields'].ItemByName[PairSrc.Name].Value.ValueType = valNull then begin
              { dest was null so change to same type as source }
              Dst.O['fields'].ItemByName[PairSrc.Name].ValueType:= PairSrc.Value.ValueType;
            end
            else if (PairSrc.Value.ValueType <> Dst.O['fields'].ItemByName[PairSrc.Name].Value.ValueType) then begin
              subMsg:= 'Error mapping from "' +
                Src.S['type'] + '", property "' + PairSrc.Name +
                '" type does not match destination property type for destination object "' + Dst.S['type'] + '"';
              result:= false;
              exit;
            end;
            PairDst:= Dst.O['fields'].ItemByName[PairSrc.Name];
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
                    GlobalRef:= subSrc.O['fields'].S['GlobalRef'];
                    if GlobalRef = '' then begin
                      { try and add glodal ref to source object }
                      Log('GlobalRef blank for ' + Src.S['type'] + ' with ID ' +
                        IntToStr(subSrc.O['fields'].I['ID']) + ', updating source object',ltWarning);

                      Obj:= JO;
                      try
                        Obj.S['type']:= subSrc.s['type'];
                        Obj.O['fields'].I['ID']:= subSrc.O['fields'].I['ID'];
                        GlobalRef:= SrcSysInfo.O['fields'].S['SiteCode'] + IntToStr(subSrc.O['fields'].I['ID']);
                        Obj.O['fields'].S['GlobalRef']:= GlobalRef;
                        if not ApiSource.Post(subSrc.s['type'],Obj,PostResult) then begin
                          result:= false;
                          msg:= 'Faild updating source GlobalRef: ' + ApiSource.ErrorMessage;
                          exit;
                        end;
                      finally
                        Obj.Free;
                      end;
//                      subMsg:= 'GlobalRef blank for "' +
//                        Src.S['type'] + '"';
//                      result:= false;
//                      exit;
                    end;
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

                  end
                  else
                    PairDst.Value.AsString:= PairSrc.Value.AsString;
              end;
            end;
          end;
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
          if ObjSrc.O['fields'].S[Schema.Schema.S['KeyStringProperty']] = '' then begin
            result:= false;
//            SendStatus(ResultStatus_Fail,Schema.Schema.S['KeyStringProperty'] + ' value missing from "' + ObjSrc.S['type'] + '"');
            Log(Schema.Schema.S['KeyStringProperty'] + ' value missing from "' + ObjSrc.S['type'] + '"',ltError);
            exit;
          end;
        end
        else if ObjSrc.O['fields'].S['GlobalRef'] = '' then begin
          result:= false;
//          SendStatus(ResultStatus_Fail,'Global Reference value missing from "' + ObjSrc.S['type'] + '"');
          Log('Global Reference value missing from "' + ObjSrc.S['type'] + '"',ltError);
          exit;
        end;

        if (((Schema.Schema.S['KeyStringProperty'] <> '') and ApiDest.Get(aClassName + '/"' +
          ObjSrc.O['fields'].S[Schema.Schema.S['KeyStringProperty']] + '"',ObjDst)) or
           ((ObjSrc.O['fields'].S['GlobalRef'] <> '') and ApiDest.Get(aClassName,ObjSrc.O['fields'].S['GlobalRef'],ObjDst))) then begin
  //      if ApiDest.Get(aClassName,ObjSrc.O['fields'].S['GlobalRef'],ObjDst) then begin
          { exists in dest system }
          Log('... found, updating from source', ltDetail);

          { remove reference objects }
          for x := 0 to Schema.IgnoreFieldList.Count -1 do
            ObjDst.O['fields'].Delete(Schema.IgnoreFieldList[x]);
        end
        else begin
          if ApiDest.NotFound then begin
            Log('... not found, copying from source', ltDetail);
            ObjDst:= TJsonObject.Create;

            { copy data from source }
            ObjDst.Assign(ObjSrc);

            { remove ID's from JSON }
            RemoveIdFields(ObjDst);

          end
          else begin
            result:= false;
            msg:= ApiSource.ErrorMessage;
            exit;
          end;
        end;

        if ObjSrc.O['fields'].S['GlobalRef'] = '' then begin
          Log('... global ref is blank, adding', ltDetail);
          ObjSrc.O['fields'].S['GlobalRef']:= DstSysInfo.O['Fields'].S['SiteCode'] + IntToStr(ObjSrc.O['fields'].I['ID']);
        end;

//        JsonToFileFormated(ObjSrc,'c:\temp\Json_Src.txt');
//        JsonToFileFormated(ObjDst,'c:\temp\Json_Dst_Before.txt');
        if MapObj(ObjSrc,ObjDst, msg) then begin
          { Post the dest object }
//          JsonToFileFormated(ObjDst,'c:\temp\Json_Dst_After_Ok.txt');
          if not ApiDest.Post(ObjDst.S['type'],ObjDst,PostResult) then begin
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
